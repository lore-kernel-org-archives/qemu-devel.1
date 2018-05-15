Received: from eggs.gnu.org ([2001:4830:134:3::10]:58240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYk-00038J-AG
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjYj-0001r5-6Y
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fIjYj-0001qs-0h
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:40:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F01B40201A0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 23:40:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 16 May 2018 01:39:55 +0200
Message-Id: <20180515234017.2277-19-quintela@redhat.com>
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 18/40] migration: allow fault thread to pause
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

Allows the fault thread to stop handling page faults temporarily. When
network failure happened (and if we expect a recovery afterwards), we
should not allow the fault thread to continue sending things to source,
instead, it should halt for a while until the connection is rebuilt.

When the dest main thread noticed the failure, it kicks the fault thread
to switch to pause state.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-7-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c    |  1 +
 migration/migration.h    |  1 +
 migration/postcopy-ram.c | 54 +++++++++++++++++++++++++++++++++++++---
 migration/savevm.c       |  3 +++
 migration/trace-events   |  2 ++
 5 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f9c58d2511..3d3b0a5b4a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -160,6 +160,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
         qemu_mutex_init(&mis_current.rp_mutex);
         qemu_event_init(&mis_current.main_thread_load_event, false);
         qemu_sem_init(&mis_current.postcopy_pause_sem_dst, 0);
+        qemu_sem_init(&mis_current.postcopy_pause_sem_fault, 0);
 
         init_dirty_bitmap_incoming_migration();
 
diff --git a/migration/migration.h b/migration/migration.h
index 32fd50e9be..4ea5949104 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -76,6 +76,7 @@ struct MigrationIncomingState {
 
     /* notify PAUSED postcopy incoming migrations to try to continue */
     QemuSemaphore postcopy_pause_sem_dst;
+    QemuSemaphore postcopy_pause_sem_fault;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 8ceeaa2a93..658b750a8e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -830,6 +830,17 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
                                       affected_cpu);
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
@@ -880,6 +891,22 @@ static void *postcopy_ram_fault_thread(void *opaque)
             break;
         }
 
+        if (!mis->to_src_file) {
+            /*
+             * Possibly someone tells us that the return path is
+             * broken already using the event. We should hold until
+             * the channel is rebuilt.
+             */
+            if (postcopy_pause_fault_thread(mis)) {
+                mis->last_rb = NULL;
+                /* Continue to read the userfaultfd */
+            } else {
+                error_report("%s: paused but don't allow to continue",
+                             __func__);
+                break;
+            }
+        }
+
         if (pfd[1].revents) {
             uint64_t tmp64 = 0;
 
@@ -942,18 +969,37 @@ static void *postcopy_ram_fault_thread(void *opaque)
                     (uintptr_t)(msg.arg.pagefault.address),
                                 msg.arg.pagefault.feat.ptid, rb);
 
+retry:
             /*
              * Send the request to the source - we want to request one
              * of our host page sizes (which is >= TPS)
              */
             if (rb != mis->last_rb) {
                 mis->last_rb = rb;
-                migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
-                                         rb_offset, qemu_ram_pagesize(rb));
+                ret = migrate_send_rp_req_pages(mis,
+                                                qemu_ram_get_idstr(rb),
+                                                rb_offset,
+                                                qemu_ram_pagesize(rb));
             } else {
                 /* Save some space */
-                migrate_send_rp_req_pages(mis, NULL,
-                                         rb_offset, qemu_ram_pagesize(rb));
+                ret = migrate_send_rp_req_pages(mis,
+                                                NULL,
+                                                rb_offset,
+                                                qemu_ram_pagesize(rb));
+            }
+
+            if (ret) {
+                /* May be network failure, try to wait for recovery */
+                if (ret == -EIO && postcopy_pause_fault_thread(mis)) {
+                    /* We got reconnected somehow, try to continue */
+                    mis->last_rb = NULL;
+                    goto retry;
+                } else {
+                    /* This is a unavoidable fault */
+                    error_report("%s: migrate_send_rp_req_pages() get %d",
+                                 __func__, ret);
+                    break;
+                }
             }
         }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 8ad99b1eaa..6ee69d8283 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2083,6 +2083,9 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     mis->to_src_file = NULL;
     qemu_mutex_unlock(&mis->rp_mutex);
 
+    /* Notify the fault thread for the invalidated file handle */
+    postcopy_fault_thread_notify(mis);
+
     error_report("Detected IO failure for postcopy. "
                  "Migration paused.");
 
diff --git a/migration/trace-events b/migration/trace-events
index cd971bf9fe..7f836499d1 100644
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
2.17.0
