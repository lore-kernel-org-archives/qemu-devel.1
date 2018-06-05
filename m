Received: from eggs.gnu.org ([2001:4830:134:3::10]:37202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQEmN-0000s6-Bt
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQEmL-0004y9-1k
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:25:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fQEmK-0004xv-TQ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:25:48 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Jun 2018 17:25:45 +0100
Message-Id: <20180605162545.80778-3-dgilbert@redhat.com>
In-Reply-To: <20180605162545.80778-1-dgilbert@redhat.com>
References: <20180605162545.80778-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] migration: Poison ramblock loops in
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, clg@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The migration code should be using the
  RAMBLOCK_FOREACH_MIGRATABLE and qemu_ram_foreach_block_migratable
not the all-block versions;  poison them so that we can't accidentally
use them.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/exec/ramlist.h | 4 +++-
 migration/migration.h  | 3 +++
 migration/ram.c        | 4 +++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
index 2e2ac6cb99..bc4faa1b00 100644
--- a/include/exec/ramlist.h
+++ b/include/exec/ramlist.h
@@ -56,8 +56,10 @@ typedef struct RAMList {
 extern RAMList ram_list;
 
 /* Should be holding either ram_list.mutex, or the RCU lock. */
-#define  RAMBLOCK_FOREACH(block)  \
+#define  INTERNAL_RAMBLOCK_FOREACH(block)  \
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next)
+/* Never use the INTERNAL_ version except for defining other macros */
+#define RAMBLOCK_FOREACH(block) INTERNAL_RAMBLOCK_FOREACH(block)
 
 void qemu_mutex_lock_ramlist(void);
 void qemu_mutex_unlock_ramlist(void);
diff --git a/migration/migration.h b/migration/migration.h
index 5af57d616c..31d3ed12dc 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -284,4 +284,7 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 void dirty_bitmap_mig_before_vm_start(void);
 void init_dirty_bitmap_incoming_migration(void);
 
+#define qemu_ram_foreach_block \
+  #warning "Use qemu_ram_foreach_block_migratable in migration code"
+
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index a7807cea84..e0d19305ee 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -159,9 +159,11 @@ out:
 
 /* Should be holding either ram_list.mutex, or the RCU lock. */
 #define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
-    RAMBLOCK_FOREACH(block)                            \
+    INTERNAL_RAMBLOCK_FOREACH(block)                   \
         if (!qemu_ram_is_migratable(block)) {} else
 
+#undef RAMBLOCK_FOREACH
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
-- 
2.17.0
