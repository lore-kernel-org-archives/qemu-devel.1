Received: from eggs.gnu.org ([2001:4830:134:3::10]:54029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzAA-0008SZ-FS
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA3-00077X-56
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:40:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37570 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elzA2-000776-V4
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:55 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Feb 2018 15:39:36 +0000
Message-Id: <20180214153938.5410-9-dgilbert@redhat.com>
In-Reply-To: <20180214153938.5410-1-dgilbert@redhat.com>
References: <20180214153938.5410-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] migration: provide
 postcopy_fault_thread_notify()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com

From: Peter Xu <peterx@redhat.com>

A general helper to notify the fault thread.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180208103132.28452-4-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 35 ++++++++++++++++++++---------------
 migration/postcopy-ram.h |  2 ++
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9ad4f20f82..032abfbf1a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -377,25 +377,15 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
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
@@ -824,6 +814,21 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
 
 /* ------------------------------------------------------------------------- */
 
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
 /**
  * postcopy_discard_send_init: Called at the start of each RAMBlock before
  *   asking to discard individual ranges.
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
2.14.3
