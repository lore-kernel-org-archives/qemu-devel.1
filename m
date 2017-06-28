Received: from eggs.gnu.org ([2001:4830:134:3::10]:40705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEJ-000555-0S
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIEG-0008NC-IZ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIEG-0008N2-9V
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:20 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:35 +0100
Message-Id: <20170628190047.26159-18-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 17/29] vhost+postcopy: Send requests to source
 for shared pages
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

Send requests back to the source for shared page requests.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.h    |  2 ++
 migration/postcopy-ram.c | 31 ++++++++++++++++++++++++++++---
 migration/postcopy-ram.h |  3 +++
 migration/trace-events   |  2 ++
 4 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 1210b217a1..5fa0bb7b53 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -49,6 +49,8 @@ struct MigrationIncomingState {
     int       userfault_quit_fd;
     QEMUFile *to_src_file;
     QemuMutex rp_mutex;    /* We send replies from multiple threads */
+    /* RAMBlock of last request sent to source */
+    RAMBlock *last_rb;
     void     *postcopy_tmp_page;
     void     *postcopy_tmp_zero_page;
     /* PostCopyFD's for external userfaultfds & handlers of shared memory */
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index d43a73c108..cbf10236f0 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -460,6 +460,31 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
 }
 
 /*
+ * Callback from shared fault handlers to ask for a page,
+ * the page must be specified by a RAMBlock and an offset in that rb
+ */
+int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
+                                 uint64_t client_addr, uint64_t rb_offset)
+{
+    size_t pagesize = qemu_ram_pagesize(rb);
+    uint64_t aligned_rbo = rb_offset & ~(pagesize - 1);
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    trace_postcopy_request_shared_page(pcfd->idstr, qemu_ram_get_idstr(rb),
+                                       rb_offset);
+    /* TODO: Check bitmap to see if we already have the page */
+    if (rb != mis->last_rb) {
+        mis->last_rb = rb;
+        migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
+                                  aligned_rbo, pagesize);
+    } else {
+        /* Save some space */
+        migrate_send_rp_req_pages(mis, NULL, aligned_rbo, pagesize);
+    }
+    return 0;
+}
+
+/*
  * Handle faults detected by the USERFAULT markings
  */
 static void *postcopy_ram_fault_thread(void *opaque)
@@ -469,9 +494,9 @@ static void *postcopy_ram_fault_thread(void *opaque)
     int ret;
     size_t index;
     RAMBlock *rb = NULL;
-    RAMBlock *last_rb = NULL; /* last RAMBlock we sent part of */
 
     trace_postcopy_ram_fault_thread_entry();
+    mis->last_rb = NULL; /* last RAMBlock we sent part of */
     qemu_sem_post(&mis->fault_thread_sem);
 
     struct pollfd *pfd;
@@ -560,8 +585,8 @@ static void *postcopy_ram_fault_thread(void *opaque)
              * Send the request to the source - we want to request one
              * of our host page sizes (which is >= TPS)
              */
-            if (rb != last_rb) {
-                last_rb = rb;
+            if (rb != mis->last_rb) {
+                mis->last_rb = rb;
                 migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
                                          rb_offset, qemu_ram_pagesize(rb));
             } else {
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 873c147b68..69e88b0174 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -162,5 +162,8 @@ struct PostCopyFD {
  */
 void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
 void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
+/* Callback from shared fault handlers to ask for a page */
+int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
+                                 uint64_t client_addr, uint64_t offset);
 
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index 522cfa170d..7ac8f9cf41 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -197,6 +197,8 @@ postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
+postcopy_request_shared_page(const char *sharer, const char *rb, uint64_t rb_offset) "for %s in %s offset %"PRIx64
+
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
-- 
2.13.0
