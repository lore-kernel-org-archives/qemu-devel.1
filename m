Received: from eggs.gnu.org ([2001:4830:134:3::10]:40499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDp-0004iV-HX
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDn-0008DZ-Vx
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIDn-0008D1-NC
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:51 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:29 +0100
Message-Id: <20170628190047.26159-12-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 11/29] postcopy: Allow registering of fd handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow other userfaultfd's to be registered into the fault thread
so that handlers for shared memory can get responses.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c    |   3 +
 migration/migration.h    |   2 +
 migration/postcopy-ram.c | 212 +++++++++++++++++++++++++++++++++++------------
 migration/postcopy-ram.h |  21 +++++
 migration/trace-events   |   2 +
 5 files changed, 186 insertions(+), 54 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 89df832625..a88b007a8b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -134,6 +134,8 @@ MigrationIncomingState *migration_incoming_get_current(void)
     if (!once) {
         mis_current.state = MIGRATION_STATUS_NONE;
         memset(&mis_current, 0, sizeof(MigrationIncomingState));
+        mis_current.postcopy_remote_fds = g_array_new(FALSE, TRUE,
+                                                   sizeof(struct PostCopyFD));
         qemu_mutex_init(&mis_current.rp_mutex);
         qemu_event_init(&mis_current.main_thread_load_event, false);
         once = true;
@@ -157,6 +159,7 @@ void migration_incoming_state_destroy(void)
         qemu_fclose(mis->from_src_file);
         mis->from_src_file = NULL;
     }
+    g_array_free(mis->postcopy_remote_fds, TRUE);
 
     qemu_event_destroy(&mis->main_thread_load_event);
 }
diff --git a/migration/migration.h b/migration/migration.h
index d109635d08..1210b217a1 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -51,6 +51,8 @@ struct MigrationIncomingState {
     QemuMutex rp_mutex;    /* We send replies from multiple threads */
     void     *postcopy_tmp_page;
     void     *postcopy_tmp_zero_page;
+    /* PostCopyFD's for external userfaultfds & handlers of shared memory */
+    GArray   *postcopy_remote_fds;
 
     QEMUBH *bh;
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 64f5a8b003..d43a73c108 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -467,29 +467,43 @@ static void *postcopy_ram_fault_thread(void *opaque)
     MigrationIncomingState *mis = opaque;
     struct uffd_msg msg;
     int ret;
+    size_t index;
     RAMBlock *rb = NULL;
     RAMBlock *last_rb = NULL; /* last RAMBlock we sent part of */
 
     trace_postcopy_ram_fault_thread_entry();
     qemu_sem_post(&mis->fault_thread_sem);
 
+    struct pollfd *pfd;
+    size_t pfd_len = 2 + mis->postcopy_remote_fds->len;
+
+    pfd = g_new0(struct pollfd, pfd_len);
+
+    pfd[0].fd = mis->userfault_fd;
+    pfd[0].events = POLLIN;
+    pfd[1].fd = mis->userfault_quit_fd;
+    pfd[1].events = POLLIN; /* Waiting for eventfd to go positive */
+    trace_postcopy_ram_fault_thread_fds_core(pfd[0].fd, pfd[1].fd);
+    for (index = 0; index < mis->postcopy_remote_fds->len; index++) {
+        struct PostCopyFD *pcfd = &g_array_index(mis->postcopy_remote_fds,
+                                                 struct PostCopyFD, index);
+        pfd[2 + index].fd = pcfd->fd;
+        pfd[2 + index].events = POLLIN;
+        trace_postcopy_ram_fault_thread_fds_extra(2 + index, pcfd->idstr,
+                                                  pcfd->fd);
+    }
+
     while (true) {
         ram_addr_t rb_offset;
-        struct pollfd pfd[2];
+        int poll_result;
 
         /*
          * We're mainly waiting for the kernel to give us a faulting HVA,
          * however we can be told to quit via userfault_quit_fd which is
          * an eventfd
          */
-        pfd[0].fd = mis->userfault_fd;
-        pfd[0].events = POLLIN;
-        pfd[0].revents = 0;
-        pfd[1].fd = mis->userfault_quit_fd;
-        pfd[1].events = POLLIN; /* Waiting for eventfd to go positive */
-        pfd[1].revents = 0;
-
-        if (poll(pfd, 2, -1 /* Wait forever */) == -1) {
+        poll_result = poll(pfd, pfd_len, -1 /* Wait forever */);
+        if (poll_result == -1) {
             error_report("%s: userfault poll: %s", __func__, strerror(errno));
             break;
         }
@@ -499,57 +513,118 @@ static void *postcopy_ram_fault_thread(void *opaque)
             break;
         }
 
-        ret = read(mis->userfault_fd, &msg, sizeof(msg));
-        if (ret != sizeof(msg)) {
-            if (errno == EAGAIN) {
-                /*
-                 * if a wake up happens on the other thread just after
-                 * the poll, there is nothing to read.
-                 */
-                continue;
+        if (pfd[0].revents) {
+            poll_result--;
+            ret = read(mis->userfault_fd, &msg, sizeof(msg));
+            if (ret != sizeof(msg)) {
+                if (errno == EAGAIN) {
+                    /*
+                     * if a wake up happens on the other thread just after
+                     * the poll, there is nothing to read.
+                     */
+                    continue;
+                }
+                if (ret < 0) {
+                    error_report("%s: Failed to read full userfault "
+                                 "message: %s",
+                                 __func__, strerror(errno));
+                    break;
+                } else {
+                    error_report("%s: Read %d bytes from userfaultfd "
+                                 "expected %zd",
+                                 __func__, ret, sizeof(msg));
+                    break; /* Lost alignment, don't know what we'd read next */
+                }
+            }
+            if (msg.event != UFFD_EVENT_PAGEFAULT) {
+                error_report("%s: Read unexpected event %ud from userfaultfd",
+                             __func__, msg.event);
+                continue; /* It's not a page fault, shouldn't happen */
             }
-            if (ret < 0) {
-                error_report("%s: Failed to read full userfault message: %s",
-                             __func__, strerror(errno));
+
+            rb = qemu_ram_block_from_host(
+                     (void *)(uintptr_t)msg.arg.pagefault.address,
+                     true, &rb_offset);
+            if (!rb) {
+                error_report("postcopy_ram_fault_thread: Fault outside guest: %"
+                             PRIx64, (uint64_t)msg.arg.pagefault.address);
                 break;
-            } else {
-                error_report("%s: Read %d bytes from userfaultfd expected %zd",
-                             __func__, ret, sizeof(msg));
-                break; /* Lost alignment, don't know what we'd read next */
             }
-        }
-        if (msg.event != UFFD_EVENT_PAGEFAULT) {
-            error_report("%s: Read unexpected event %ud from userfaultfd",
-                         __func__, msg.event);
-            continue; /* It's not a page fault, shouldn't happen */
-        }
 
-        rb = qemu_ram_block_from_host(
-                 (void *)(uintptr_t)msg.arg.pagefault.address,
-                 true, &rb_offset);
-        if (!rb) {
-            error_report("postcopy_ram_fault_thread: Fault outside guest: %"
-                         PRIx64, (uint64_t)msg.arg.pagefault.address);
-            break;
-        }
+            rb_offset &= ~(qemu_ram_pagesize(rb) - 1);
+            trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
+                                                    qemu_ram_get_idstr(rb),
+                                                    rb_offset);
 
-        rb_offset &= ~(qemu_ram_pagesize(rb) - 1);
-        trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
-                                                qemu_ram_get_idstr(rb),
-                                                rb_offset);
+            /*
+             * Send the request to the source - we want to request one
+             * of our host page sizes (which is >= TPS)
+             */
+            if (rb != last_rb) {
+                last_rb = rb;
+                migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
+                                         rb_offset, qemu_ram_pagesize(rb));
+            } else {
+                /* Save some space */
+                migrate_send_rp_req_pages(mis, NULL,
+                                         rb_offset, qemu_ram_pagesize(rb));
+            }
+        }
 
-        /*
-         * Send the request to the source - we want to request one
-         * of our host page sizes (which is >= TPS)
-         */
-        if (rb != last_rb) {
-            last_rb = rb;
-            migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
-                                     rb_offset, qemu_ram_pagesize(rb));
-        } else {
-            /* Save some space */
-            migrate_send_rp_req_pages(mis, NULL,
-                                     rb_offset, qemu_ram_pagesize(rb));
+        /* Now handle any requests from external processes on shared memory */
+        /* TODO: May need to handle devices deregistering during postcopy */
+        for (index = 2; index < pfd_len && poll_result; index++) {
+            if (pfd[index].revents) {
+                struct PostCopyFD *pcfd =
+                    &g_array_index(mis->postcopy_remote_fds,
+                                   struct PostCopyFD, index - 2);
+
+                poll_result--;
+                if (pfd[index].revents & POLLERR) {
+                    error_report("%s: POLLERR on poll %zd fd=%d",
+                                 __func__, index, pcfd->fd);
+                    pfd[index].events = 0;
+                    continue;
+                }
+
+                ret = read(pcfd->fd, &msg, sizeof(msg));
+                if (ret != sizeof(msg)) {
+                    if (errno == EAGAIN) {
+                        /*
+                         * if a wake up happens on the other thread just after
+                         * the poll, there is nothing to read.
+                         */
+                        continue;
+                    }
+                    if (ret < 0) {
+                        error_report("%s: Failed to read full userfault "
+                                     "message: %s (shared) revents=%d",
+                                     __func__, strerror(errno),
+                                     pfd[index].revents);
+                        /*TODO: Could just disable this sharer */
+                        break;
+                    } else {
+                        error_report("%s: Read %d bytes from userfaultfd "
+                                     "expected %zd (shared)",
+                                     __func__, ret, sizeof(msg));
+                        /*TODO: Could just disable this sharer */
+                        break; /*Lost alignment,don't know what we'd read next*/
+                    }
+                }
+                if (msg.event != UFFD_EVENT_PAGEFAULT) {
+                    error_report("%s: Read unexpected event %ud "
+                                 "from userfaultfd (shared)",
+                                 __func__, msg.event);
+                    continue; /* It's not a page fault, shouldn't happen */
+                }
+                /* Call the device handler registered with us */
+                ret = pcfd->handler(pcfd, &msg);
+                if (ret) {
+                    error_report("%s: Failed to resolve shared fault on %zd/%s",
+                                 __func__, index, pcfd->idstr);
+                    /* TODO: Fail? Disable this sharer? */
+                }
+            }
         }
     }
     trace_postcopy_ram_fault_thread_exit();
@@ -879,3 +954,32 @@ PostcopyState postcopy_state_set(PostcopyState new_state)
 {
     return atomic_xchg(&incoming_postcopy_state, new_state);
 }
+
+/* Register a handler for external shared memory postcopy
+ * called on the destination.
+ */
+void postcopy_register_shared_ufd(struct PostCopyFD *pcfd)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    mis->postcopy_remote_fds = g_array_append_val(mis->postcopy_remote_fds,
+                                                  *pcfd);
+}
+
+/* Unregister a handler for external shared memory postcopy
+ */
+void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd)
+{
+    guint i;
+    MigrationIncomingState *mis = migration_incoming_get_current();
+    GArray *pcrfds = mis->postcopy_remote_fds;
+
+    for (i = 0; i < pcrfds->len; i++) {
+        struct PostCopyFD *cur = &g_array_index(pcrfds, struct PostCopyFD, i);
+        if (cur->fd == pcfd->fd) {
+            mis->postcopy_remote_fds = g_array_remove_index(pcrfds, i);
+            return;
+        }
+    }
+}
+
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 70d4b09659..ba8a8ffec5 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -141,4 +141,25 @@ void postcopy_remove_notifier(NotifierWithReturn *n);
 /* Call the notifier list set by postcopy_add_start_notifier */
 int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp);
 
+struct PostCopyFD;
+
+/* ufd is a pointer to the struct uffd_msg *TODO: more Portable! */
+typedef int (*pcfdhandler)(struct PostCopyFD *pcfd, void *ufd);
+
+struct PostCopyFD {
+    int fd;
+    /* Data to pass to handler */
+    void *data;
+    /* Handler to be called whenever we get a poll event */
+    pcfdhandler handler;
+    /* A string to use in error messages */
+    char *idstr;
+};
+
+/* Register a userfaultfd owned by an external process for
+ * shared memory.
+ */
+void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
+void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
+
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index cb2c4b5b40..522cfa170d 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -189,6 +189,8 @@ postcopy_place_page_zero(void *host_addr) "host=%p"
 postcopy_ram_enable_notify(void) ""
 postcopy_ram_fault_thread_entry(void) ""
 postcopy_ram_fault_thread_exit(void) ""
+postcopy_ram_fault_thread_fds_core(int baseufd, int quitfd) "ufd: %d quitfd: %d"
+postcopy_ram_fault_thread_fds_extra(size_t index, const char *name, int fd) "%zd/%s: %d"
 postcopy_ram_fault_thread_quit(void) ""
 postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
 postcopy_ram_incoming_cleanup_closeuf(void) ""
-- 
2.13.0
