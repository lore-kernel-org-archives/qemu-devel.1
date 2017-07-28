Received: from eggs.gnu.org ([2001:4830:134:3::10]:46834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0Iu-0000n3-05
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1db0It-00018H-2p
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1db0Is-00017e-Nw
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:07:23 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 28 Jul 2017 16:06:18 +0800
Message-Id: <1501229198-30588-10-git-send-email-peterx@redhat.com>
In-Reply-To: <1501229198-30588-1-git-send-email-peterx@redhat.com>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 09/29] migration: provide
 postcopy_fault_thread_notify()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

A general helper to notify the fault thread.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 35 ++++++++++++++++++++---------------
 migration/postcopy-ram.h |  2 ++
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 4278fe7..9ce391d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -287,6 +287,21 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis, size_t ram_pages)
     return 0;
 }
 
+void postcopy_fault_thread_notify(MigrationIncomingState *mis)
+{
+    uint64_t tmp64 = 1;
+
+    /*
+     * Tell the fault_thread to exit, it's an eventfd that should
+     * currently be at 0, we're going to increment it to 1
+     */
+    if (write(mis->userfault_event_fd, &tmp64, 8) != 8) {
+        /* Not much we can do here, but may as well report it */
+        error_report("%s: incrementing userfault_quit_fd: %s", __func__,
+                     strerror(errno));
+    }
+}
+
 /*
  * At the end of a migration where postcopy_ram_incoming_init was called.
  */
@@ -295,25 +310,15 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     trace_postcopy_ram_incoming_cleanup_entry();
 
     if (mis->have_fault_thread) {
-        uint64_t tmp64;
-
         if (qemu_ram_foreach_block(cleanup_range, mis)) {
             return -1;
         }
-        /*
-         * Tell the fault_thread to exit, it's an eventfd that should
-         * currently be at 0, we're going to increment it to 1
-         */
-        tmp64 = 1;
+        /* Let the fault thread quit */
         atomic_set(&mis->fault_thread_quit, 1);
-        if (write(mis->userfault_event_fd, &tmp64, 8) == 8) {
-            trace_postcopy_ram_incoming_cleanup_join();
-            qemu_thread_join(&mis->fault_thread);
-        } else {
-            /* Not much we can do here, but may as well report it */
-            error_report("%s: incrementing userfault_quit_fd: %s", __func__,
-                         strerror(errno));
-        }
+        postcopy_fault_thread_notify(mis);
+        trace_postcopy_ram_incoming_cleanup_join();
+        qemu_thread_join(&mis->fault_thread);
+
         trace_postcopy_ram_incoming_cleanup_closeuf();
         close(mis->userfault_fd);
         close(mis->userfault_event_fd);
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 78a3591..4a7644d 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -114,4 +114,6 @@ PostcopyState postcopy_state_get(void);
 /* Set the state and return the old state */
 PostcopyState postcopy_state_set(PostcopyState new_state);
 
+void postcopy_fault_thread_notify(MigrationIncomingState *mis);
+
 #endif
-- 
2.7.4
