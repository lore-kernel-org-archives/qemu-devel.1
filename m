Received: from eggs.gnu.org ([2001:4830:134:3::10]:44292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wiH-0004Ph-05
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wiG-0007GS-3N
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0wiF-0007GF-TT
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:00:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C32606371F
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:00:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:59:04 +0200
Message-Id: <20170419205923.8808-41-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 40/59] ram: Remove compression_switch and
 inline its logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

We can calculate its value, so we don't create a variable for it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--

After Peter and Dave review, I dropped the variable and just inlined
the condition.

Fix typo

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 14d54fd..fa5a290 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -336,7 +336,6 @@ static QemuCond comp_done_cond;
 /* The empty QEMUFileOps will be used by file in CompressParam */
 static const QEMUFileOps empty_ops = { };
 
-static bool compression_switch;
 static DecompressParam *decomp_param;
 static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
@@ -420,7 +419,6 @@ void migrate_compress_threads_create(void)
     if (!migrate_use_compression()) {
         return;
     }
-    compression_switch = true;
     thread_count = migrate_compress_threads();
     compress_threads = g_new0(QemuThread, thread_count);
     comp_param = g_new0(CompressParam, thread_count);
@@ -1092,7 +1090,6 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
                  * point. In theory, xbzrle can do better than compression.
                  */
                 flush_compressed_data(rs);
-                compression_switch = false;
             }
         }
         /* Didn't find anything this time, but try again on the new block */
@@ -1326,7 +1323,14 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms,
     /* Check the pages is dirty and if it is send it */
     if (migration_bitmap_clear_dirty(rs, dirty_ram_abs)) {
         unsigned long *unsentmap;
-        if (compression_switch && migrate_use_compression()) {
+        /*
+         * If xbzrle is on, stop using the data compression after first
+         * round of migration even if compression is enabled. In theory,
+         * xbzrle can do better than compression.
+         */
+
+        if (migrate_use_compression()
+            && (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
             res = ram_save_compressed_page(rs, ms, pss, last_stage);
         } else {
             res = ram_save_page(rs, ms, pss, last_stage);
-- 
2.9.3
