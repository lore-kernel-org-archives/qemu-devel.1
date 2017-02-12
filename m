Received: from eggs.gnu.org ([2001:4830:134:3::10]:47177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj7v-000709-0P
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj7t-0007Iq-Ll
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:38:55 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:38:33 +0100
Message-Id: <20170212013844.6560-1-mreitz@redhat.com>
In-Reply-To: <20170212013440.5919-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 10/21] block/qapi: reduce the coupling between
 the bdrv_query_stats and bdrv_query_bds_stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

The bdrv_query_stats and bdrv_query_bds_stats functions need to call
each other, that increases the coupling. it also makes the program
complicated and makes some unnecessary tests.

Remove the call from bdrv_query_bds_stats to bdrv_query_stats, just
take some recursion to make it clearly.

Avoid testing whether the blk is NULL during querying the bds stats.
It is unnecessary.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-id: 1484467275-27919-2-git-send-email-douly.fnst@cn.fujitsu.com
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qapi.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 63297353f7..48105ed277 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -357,10 +357,6 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
     qapi_free_BlockInfo(info);
 }
 
-static BlockStats *bdrv_query_stats(BlockBackend *blk,
-                                    const BlockDriverState *bs,
-                                    bool query_backing);
-
 static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
 {
     BlockAcctStats *stats = blk_get_stats(blk);
@@ -428,9 +424,18 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
     }
 }
 
-static void bdrv_query_bds_stats(BlockStats *s, const BlockDriverState *bs,
+static BlockStats *bdrv_query_bds_stats(const BlockDriverState *bs,
                                  bool query_backing)
 {
+    BlockStats *s = NULL;
+
+    s = g_malloc0(sizeof(*s));
+    s->stats = g_malloc0(sizeof(*s->stats));
+
+    if (!bs) {
+        return s;
+    }
+
     if (bdrv_get_node_name(bs)[0]) {
         s->has_node_name = true;
         s->node_name = g_strdup(bdrv_get_node_name(bs));
@@ -440,14 +445,15 @@ static void bdrv_query_bds_stats(BlockStats *s, const BlockDriverState *bs,
 
     if (bs->file) {
         s->has_parent = true;
-        s->parent = bdrv_query_stats(NULL, bs->file->bs, query_backing);
+        s->parent = bdrv_query_bds_stats(bs->file->bs, query_backing);
     }
 
     if (query_backing && bs->backing) {
         s->has_backing = true;
-        s->backing = bdrv_query_stats(NULL, bs->backing->bs, query_backing);
+        s->backing = bdrv_query_bds_stats(bs->backing->bs, query_backing);
     }
 
+    return s;
 }
 
 static BlockStats *bdrv_query_stats(BlockBackend *blk,
@@ -456,17 +462,13 @@ static BlockStats *bdrv_query_stats(BlockBackend *blk,
 {
     BlockStats *s;
 
-    s = g_malloc0(sizeof(*s));
-    s->stats = g_malloc0(sizeof(*s->stats));
+    s = bdrv_query_bds_stats(bs, query_backing);
 
     if (blk) {
         s->has_device = true;
         s->device = g_strdup(blk_name(blk));
         bdrv_query_blk_stats(s->stats, blk);
     }
-    if (bs) {
-        bdrv_query_bds_stats(s, bs, query_backing);
-    }
 
     return s;
 }
-- 
2.11.0
