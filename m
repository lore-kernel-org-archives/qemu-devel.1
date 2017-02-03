Received: from eggs.gnu.org ([2001:4830:134:3::10]:36693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5n-0007nW-Aw
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5k-000836-1E
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:7444 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5j-00080W-Mb
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:52 +0300
Message-Id: <20170203154757.36140-14-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 13/18] nbd: add nbd_dirty_bitmap_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

Realize bdrv_dirty_bitmap_load interface.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 63bc3f04d0..b2b6fd1cf9 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -557,6 +557,35 @@ static void nbd_refresh_filename(BlockDriverState *bs, QDict *options)
     bs->full_open_options = opts;
 }
 
+static BdrvDirtyBitmap *nbd_dirty_bitmap_load(BlockDriverState *bs,
+                                              const char *name, Error **errp)
+{
+    int64_t offset = 0, end;
+    uint32_t ma = -1;
+    BdrvDirtyBitmap *bitmap =
+        bdrv_create_dirty_bitmap(bs, bdrv_get_default_bitmap_granularity(bs),
+                                 name, errp);
+    if (bitmap == NULL) {
+        return NULL;
+    }
+
+    end = bdrv_dirty_bitmap_size(bitmap) << BDRV_SECTOR_BITS;
+
+    while (offset < end) {
+        offset = nbd_client_co_load_bitmap_part(bs, offset,
+                                                MIN(end - offset, ma), bitmap);
+        if (offset < 0) {
+            goto fail;
+        }
+    }
+
+    return bitmap;
+
+fail:
+    bdrv_release_dirty_bitmap(bs, bitmap);
+    return NULL;
+}
+
 static BlockDriver bdrv_nbd = {
     .format_name                = "nbd",
     .protocol_name              = "nbd",
@@ -574,6 +603,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirty_bitmap_load     = nbd_dirty_bitmap_load,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -593,6 +623,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirty_bitmap_load     = nbd_dirty_bitmap_load,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -612,6 +643,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_detach_aio_context    = nbd_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
+    .bdrv_dirty_bitmap_load     = nbd_dirty_bitmap_load,
 };
 
 static void bdrv_nbd_init(void)
-- 
2.11.0
