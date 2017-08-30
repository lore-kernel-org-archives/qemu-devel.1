Received: from eggs.gnu.org ([2001:4830:134:3::10]:34023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyQu-00070f-Ub
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyQr-0003EV-Ut
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:33:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmyQr-0003E5-L8
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:33:05 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Aug 2017 16:32:03 +0800
Message-Id: <1504081950-2528-7-git-send-email-peterx@redhat.com>
In-Reply-To: <1504081950-2528-1-git-send-email-peterx@redhat.com>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 06/33] migration: reuse mis->userfault_quit_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

It was only used for quitting the page fault thread before. Let it be
something more useful - now we can use it to notify a "wake" for the
page fault thread (for any reason), and it only means "quit" if the
fault_thread_quit is set.

Since we changed what it does, renaming it to userfault_event_fd.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h    |  6 ++++--
 migration/postcopy-ram.c | 26 +++++++++++++++++---------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 148c9fa..70e3094 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -35,6 +35,8 @@ struct MigrationIncomingState {
     bool           have_fault_thread;
     QemuThread     fault_thread;
     QemuSemaphore  fault_thread_sem;
+    /* Set this when we want the fault thread to quit */
+    bool           fault_thread_quit;
 
     bool           have_listen_thread;
     QemuThread     listen_thread;
@@ -42,8 +44,8 @@ struct MigrationIncomingState {
 
     /* For the kernel to send us notifications */
     int       userfault_fd;
-    /* To tell the fault_thread to quit */
-    int       userfault_quit_fd;
+    /* To notify the fault_thread to wake, e.g., when need to quit */
+    int       userfault_event_fd;
     QEMUFile *to_src_file;
     QemuMutex rp_mutex;    /* We send replies from multiple threads */
     void     *postcopy_tmp_page;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 7a414eb..0138a49 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -305,17 +305,18 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
          * currently be at 0, we're going to increment it to 1
          */
         tmp64 = 1;
-        if (write(mis->userfault_quit_fd, &tmp64, 8) == 8) {
+        atomic_set(&mis->fault_thread_quit, 1);
+        if (write(mis->userfault_event_fd, &tmp64, 8) == 8) {
             trace_postcopy_ram_incoming_cleanup_join();
             qemu_thread_join(&mis->fault_thread);
         } else {
             /* Not much we can do here, but may as well report it */
-            error_report("%s: incrementing userfault_quit_fd: %s", __func__,
+            error_report("%s: incrementing userfault_event_fd: %s", __func__,
                          strerror(errno));
         }
         trace_postcopy_ram_incoming_cleanup_closeuf();
         close(mis->userfault_fd);
-        close(mis->userfault_quit_fd);
+        close(mis->userfault_event_fd);
         mis->have_fault_thread = false;
     }
 
@@ -438,7 +439,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
         pfd[0].fd = mis->userfault_fd;
         pfd[0].events = POLLIN;
         pfd[0].revents = 0;
-        pfd[1].fd = mis->userfault_quit_fd;
+        pfd[1].fd = mis->userfault_event_fd;
         pfd[1].events = POLLIN; /* Waiting for eventfd to go positive */
         pfd[1].revents = 0;
 
@@ -448,8 +449,15 @@ static void *postcopy_ram_fault_thread(void *opaque)
         }
 
         if (pfd[1].revents) {
-            trace_postcopy_ram_fault_thread_quit();
-            break;
+            uint64_t tmp64 = 0;
+
+            /* Consume the signal */
+            read(mis->userfault_event_fd, &tmp64, 8);
+
+            if (atomic_read(&mis->fault_thread_quit)) {
+                trace_postcopy_ram_fault_thread_quit();
+                break;
+            }
         }
 
         ret = read(mis->userfault_fd, &msg, sizeof(msg));
@@ -528,9 +536,9 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
     }
 
     /* Now an eventfd we use to tell the fault-thread to quit */
-    mis->userfault_quit_fd = eventfd(0, EFD_CLOEXEC);
-    if (mis->userfault_quit_fd == -1) {
-        error_report("%s: Opening userfault_quit_fd: %s", __func__,
+    mis->userfault_event_fd = eventfd(0, EFD_CLOEXEC);
+    if (mis->userfault_event_fd == -1) {
+        error_report("%s: Opening userfault_event_fd: %s", __func__,
                      strerror(errno));
         close(mis->userfault_fd);
         return -1;
-- 
2.7.4
