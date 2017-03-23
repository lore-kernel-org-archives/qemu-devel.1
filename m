Received: from eggs.gnu.org ([2001:4830:134:3::10]:45884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9d7-0008Jn-Rd
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cr9d4-0000bD-PF
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cr9d4-0000b0-Jw
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:46:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 767227AEA4
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:46:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 23 Mar 2017 21:45:30 +0100
Message-Id: <20170323204544.12015-38-quintela@redhat.com>
In-Reply-To: <20170323204544.12015-1-quintela@redhat.com>
References: <20170323204544.12015-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 37/51] ram: Move compression_switch to RAMState
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

Rename it to preffer_xbzrle that is a more descriptive name.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6a39704..591cf89 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -217,6 +217,9 @@ struct RAMState {
     uint64_t dirty_pages_rate;
     /* Count of requests incoming from destination */
     uint64_t postcopy_requests;
+    /* Should we move to xbzrle after the 1st round
+       of compression */
+    bool preffer_xbzrle;
     /* protects modification of the bitmap */
     QemuMutex bitmap_mutex;
     /* Ram Bitmap protected by RCU */
@@ -335,7 +338,6 @@ static QemuCond comp_done_cond;
 /* The empty QEMUFileOps will be used by file in CompressParam */
 static const QEMUFileOps empty_ops = { };
 
-static bool compression_switch;
 static DecompressParam *decomp_param;
 static QemuThread *decompress_threads;
 static QemuMutex decomp_done_lock;
@@ -419,7 +421,6 @@ void migrate_compress_threads_create(void)
     if (!migrate_use_compression()) {
         return;
     }
-    compression_switch = true;
     thread_count = migrate_compress_threads();
     compress_threads = g_new0(QemuThread, thread_count);
     comp_param = g_new0(CompressParam, thread_count);
@@ -1091,7 +1092,7 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
                  * point. In theory, xbzrle can do better than compression.
                  */
                 flush_compressed_data(rs);
-                compression_switch = false;
+                rs->preffer_xbzrle = true;
             }
         }
         /* Didn't find anything this time, but try again on the new block */
@@ -1323,7 +1324,7 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms,
     /* Check the pages is dirty and if it is send it */
     if (migration_bitmap_clear_dirty(rs, dirty_ram_abs)) {
         unsigned long *unsentmap;
-        if (compression_switch && migrate_use_compression()) {
+        if (!rs->preffer_xbzrle && migrate_use_compression()) {
             res = ram_save_compressed_page(rs, ms, pss, last_stage);
         } else {
             res = ram_save_page(rs, ms, pss, last_stage);
-- 
2.9.3
