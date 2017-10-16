Received: from eggs.gnu.org ([2001:4830:134:3::10]:42256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zGP-0000Ns-4x
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3zGO-00019F-5I
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:52:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e3zGN-00018e-SP
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 02:52:36 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 16 Oct 2017 14:51:47 +0800
Message-Id: <20171016065216.18162-4-peterx@redhat.com>
In-Reply-To: <20171016065216.18162-1-peterx@redhat.com>
References: <20171016065216.18162-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/32] migration: provide
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

A general helper to notify the fault thread.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 35 ++++++++++++++++++++---------------
 migration/postcopy-ram.h |  2 ++
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 07dd29c9d7..e770077a81 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -369,6 +369,21 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis, size_t ram_pages)
     return 0;
 }
 
+void postcopy_fault_thread_notify(MigrationIncomingState *mis)
+{
+    uint64_t tmp64 = 1;
+
+    /*
+     * Wakeup the fault_thread.  It's an eventfd that should currently
+     * be at 0, we're going to increment it to 1
+     */
+    if (write(mis->userfault_event_fd, &tmp64, 8) != 8) {
+        /* Not much we can do here, but may as well report it */
+        error_report("%s: incrementing failed: %s", __func__,
+                     strerror(errno));
+    }
+}
+
 /*
  * At the end of a migration where postcopy_ram_incoming_init was called.
  */
@@ -377,25 +392,15 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
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
-            error_report("%s: incrementing userfault_event_fd: %s", __func__,
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
index 77ea0fd264..14f6cadcbd 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -114,4 +114,6 @@ PostcopyState postcopy_state_get(void);
 /* Set the state and return the old state */
 PostcopyState postcopy_state_set(PostcopyState new_state);
 
+void postcopy_fault_thread_notify(MigrationIncomingState *mis);
+
 #endif
-- 
2.13.5
