Received: from eggs.gnu.org ([2001:4830:134:3::10]:35794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJRH-0008CF-94
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJRG-0006WJ-5E
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJRF-0006Vm-So
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:02:14 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:01:07 +0800
Message-Id: <20171108060130.3772-10-peterx@redhat.com>
In-Reply-To: <20171108060130.3772-1-peterx@redhat.com>
References: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 09/32] migration: allow fault thread to pause
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Allows the fault thread to stop handling page faults temporarily. When
network failure happened (and if we expect a recovery afterwards), we
should not allow the fault thread to continue sending things to source,
instead, it should halt for a while until the connection is rebuilt.

When the dest main thread noticed the failure, it kicks the fault thread
to switch to pause state.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c    |  1 +
 migration/migration.h    |  1 +
 migration/postcopy-ram.c | 50 ++++++++++++++++++++++++++++++++++++++++++++----
 migration/savevm.c       |  3 +++
 migration/trace-events   |  2 ++
 5 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index db896233f6..54fba8668d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -151,6 +151,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
         qemu_mutex_init(&mis_current.rp_mutex);
         qemu_event_init(&mis_current.main_thread_load_event, false);
         qemu_sem_init(&mis_current.postcopy_pause_sem_dst, 0);
+        qemu_sem_init(&mis_current.postcopy_pause_sem_fault, 0);
         once = true;
     }
     return &mis_current;
diff --git a/migration/migration.h b/migration/migration.h
index b63cdfbfdb..2751b2dffc 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -64,6 +64,7 @@ struct MigrationIncomingState {
 
     /* notify PAUSED postcopy incoming migrations to try to continue */
     QemuSemaphore postcopy_pause_sem_dst;
+    QemuSemaphore postcopy_pause_sem_fault;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 032abfbf1a..31c290c884 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -485,6 +485,17 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
     return 0;
 }
 
+static bool postcopy_pause_fault_thread(MigrationIncomingState *mis)
+{
+    trace_postcopy_pause_fault_thread();
+
+    qemu_sem_wait(&mis->postcopy_pause_sem_fault);
+
+    trace_postcopy_pause_fault_thread_continued();
+
+    return true;
+}
+
 /*
  * Handle faults detected by the USERFAULT markings
  */
@@ -535,6 +546,22 @@ static void *postcopy_ram_fault_thread(void *opaque)
             }
         }
 
+        if (!mis->to_src_file) {
+            /*
+             * Possibly someone tells us that the return path is
+             * broken already using the event. We should hold until
+             * the channel is rebuilt.
+             */
+            if (postcopy_pause_fault_thread(mis)) {
+                last_rb = NULL;
+                /* Continue to read the userfaultfd */
+            } else {
+                error_report("%s: paused but don't allow to continue",
+                             __func__);
+                break;
+            }
+        }
+
         ret = read(mis->userfault_fd, &msg, sizeof(msg));
         if (ret != sizeof(msg)) {
             if (errno == EAGAIN) {
@@ -574,18 +601,33 @@ static void *postcopy_ram_fault_thread(void *opaque)
                                                 qemu_ram_get_idstr(rb),
                                                 rb_offset);
 
+retry:
         /*
          * Send the request to the source - we want to request one
          * of our host page sizes (which is >= TPS)
          */
         if (rb != last_rb) {
             last_rb = rb;
-            migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
-                                     rb_offset, qemu_ram_pagesize(rb));
+            ret = migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
+                                            rb_offset, qemu_ram_pagesize(rb));
         } else {
             /* Save some space */
-            migrate_send_rp_req_pages(mis, NULL,
-                                     rb_offset, qemu_ram_pagesize(rb));
+            ret = migrate_send_rp_req_pages(mis, NULL,
+                                            rb_offset, qemu_ram_pagesize(rb));
+        }
+
+        if (ret) {
+            /* May be network failure, try to wait for recovery */
+            if (ret == -EIO && postcopy_pause_fault_thread(mis)) {
+                /* We got reconnected somehow, try to continue */
+                last_rb = NULL;
+                goto retry;
+            } else {
+                /* This is a unavoidable fault */
+                error_report("%s: migrate_send_rp_req_pages() get %d",
+                             __func__, ret);
+                break;
+            }
         }
     }
     trace_postcopy_ram_fault_thread_exit();
diff --git a/migration/savevm.c b/migration/savevm.c
index 93e308ebf0..86ada6d0e7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2039,6 +2039,9 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     mis->to_src_file = NULL;
     qemu_mutex_unlock(&mis->rp_mutex);
 
+    /* Notify the fault thread for the invalidated file handle */
+    postcopy_fault_thread_notify(mis);
+
     error_report("Detected IO failure for postcopy. "
                  "Migration paused.");
 
diff --git a/migration/trace-events b/migration/trace-events
index a4031cfe00..32f02cbdcc 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -101,6 +101,8 @@ open_return_path_on_source_continue(void) ""
 postcopy_start(void) ""
 postcopy_pause_return_path(void) ""
 postcopy_pause_return_path_continued(void) ""
+postcopy_pause_fault_thread(void) ""
+postcopy_pause_fault_thread_continued(void) ""
 postcopy_pause_continued(void) ""
 postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
-- 
2.13.6
