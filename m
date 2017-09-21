Received: from eggs.gnu.org ([2001:4830:134:3::10]:44905)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dv0es-00059E-7X
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dv0ep-0001DI-3V
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:32:46 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:39962 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dv0eo-0001BW-Qu
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:32:43 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 21 Sep 2017 14:32:32 +0200
Message-Id: <1505997152-16980-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH] migration: disable auto-converge during bulk
 block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

auto-converge and block migration currently do not play well together.
During block migration the auto-converge logic detects that ram
migration makes no progress and thus throttles down the vm until
it nearly stalls completely. Avoid this by disabling the throttling
logic during the bulk phase of the block migration.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
---
 migration/block.c | 5 +++++
 migration/block.h | 7 +++++++
 migration/ram.c   | 3 ++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/block.c b/migration/block.c
index 9171f60..606ad4d 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -161,6 +161,11 @@ int blk_mig_active(void)
     return !QSIMPLEQ_EMPTY(&block_mig_state.bmds_list);
 }
 
+int blk_mig_bulk_active(void)
+{
+    return blk_mig_active() && !block_mig_state.bulk_completed;
+}
+
 uint64_t blk_mig_bytes_transferred(void)
 {
     BlkMigDevState *bmds;
diff --git a/migration/block.h b/migration/block.h
index 22ebe94..3178609 100644
--- a/migration/block.h
+++ b/migration/block.h
@@ -16,6 +16,7 @@
 
 #ifdef CONFIG_LIVE_BLOCK_MIGRATION
 int blk_mig_active(void);
+int blk_mig_bulk_active(void);
 uint64_t blk_mig_bytes_transferred(void);
 uint64_t blk_mig_bytes_remaining(void);
 uint64_t blk_mig_bytes_total(void);
@@ -25,6 +26,12 @@ static inline int blk_mig_active(void)
 {
     return false;
 }
+
+static inline int blk_mig_bulk_active(void)
+{
+    return false;
+}
+
 static inline uint64_t blk_mig_bytes_transferred(void)
 {
     return 0;
diff --git a/migration/ram.c b/migration/ram.c
index e18b3e2..720470e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -46,6 +46,7 @@
 #include "exec/ram_addr.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
+#include "migration/block.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -623,7 +624,7 @@ static void migration_bitmap_sync(RAMState *rs)
             / (end_time - rs->time_last_bitmap_sync);
         bytes_xfer_now = ram_counters.transferred;
 
-        if (migrate_auto_converge()) {
+        if (migrate_auto_converge() && !blk_mig_bulk_active()) {
             /* The following detection logic can be refined later. For now:
                Check to see if the dirtied bytes is 50% more than the approx.
                amount of bytes that just got transferred since the last time we
-- 
1.9.1
