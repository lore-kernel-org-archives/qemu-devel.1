Received: from eggs.gnu.org ([2001:4830:134:3::10]:39604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqX-0000zB-7t
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqT-0002Kl-QR
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dxCqT-0002JG-II
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:49 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 27 Sep 2017 14:57:36 +0100
Message-Id: <20170927135742.19724-2-dgilbert@redhat.com>
In-Reply-To: <20170927135742.19724-1-dgilbert@redhat.com>
References: <20170927135742.19724-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] migration: disable auto-converge during
 bulk block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pl@kamp.de, quintela@redhat.com

From: Peter Lieven <pl@kamp.de>

auto-converge and block migration currently do not play well together.
During block migration the auto-converge logic detects that ram
migration makes no progress and thus throttles down the vm until
it nearly stalls completely. Avoid this by disabling the throttling
logic during the bulk phase of the block migration.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1506421996-12513-1-git-send-email-pl@kamp.de>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/block.c | 5 +++++
 migration/block.h | 7 +++++++
 migration/ram.c   | 6 +++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/migration/block.c b/migration/block.c
index 9171f60028..606ad4db92 100644
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
index 22ebe94259..3178609dbd 100644
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
index 88ca69e7b2..b83f8977c5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -46,6 +46,7 @@
 #include "exec/ram_addr.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
+#include "migration/block.h"
 
 /***********************************************************/
 /* ram save/restore */
@@ -825,7 +826,10 @@ static void migration_bitmap_sync(RAMState *rs)
             / (end_time - rs->time_last_bitmap_sync);
         bytes_xfer_now = ram_counters.transferred;
 
-        if (migrate_auto_converge()) {
+        /* During block migration the auto-converge logic incorrectly detects
+         * that ram migration makes no progress. Avoid this by disabling the
+         * throttling logic during the bulk phase of block migration. */
+        if (migrate_auto_converge() && !blk_mig_bulk_active()) {
             /* The following detection logic can be refined later. For now:
                Check to see if the dirtied bytes is 50% more than the approx.
                amount of bytes that just got transferred since the last time we
-- 
2.13.5
