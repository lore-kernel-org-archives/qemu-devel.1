Received: from eggs.gnu.org ([2001:4830:134:3::10]:59518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmbX-0006Re-Pc
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cvmbU-0007aE-NX
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:12:15 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:27104 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cvmbU-0007VA-Ce
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:12:12 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Wed,  5 Apr 2017 18:12:05 +0300
Message-Id: <1491405126-30591-2-git-send-email-den@openvz.org>
In-Reply-To: <1491405126-30591-1-git-send-email-den@openvz.org>
References: <1491405126-30591-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/2] parallels: create parallels_inactivate()
 callback of block driver state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>

We should avoid to image file at migration end when BDRV_O_INACTIVE
is set on the block driver state. All modifications should be done
in advance, i.e. in bdrv_inactivate.

The patch also adds final bdrv_flush() to be sure that changes have
reached disk finally before other side will access the image.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 90acf79..9dea09e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -728,18 +728,35 @@ fail_options:
     goto fail;
 }
 
-
-static void parallels_close(BlockDriverState *bs)
+static int parallels_inactivate(BlockDriverState *bs)
 {
+    int err;
     BDRVParallelsState *s = bs->opaque;
 
-    if (bs->open_flags & BDRV_O_RDWR) {
-        s->header->inuse = 0;
-        parallels_update_header(bs);
+    if (!(bs->open_flags & BDRV_O_RDWR)) {
+        return 0;
+    }
+
+    s->header->inuse = 0;
+    err = parallels_update_header(bs);
+    if (err < 0) {
+        return err;
+    }
+
+    err = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS);
+    if (err < 0) {
+        return err;
     }
 
-    if (bs->open_flags & BDRV_O_RDWR) {
-        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS);
+    return bdrv_flush(bs->file->bs);
+}
+
+static void parallels_close(BlockDriverState *bs)
+{
+    BDRVParallelsState *s = bs->opaque;
+
+    if (!(bs->open_flags & BDRV_O_INACTIVE)) {
+        parallels_inactivate(bs);
     }
 
     g_free(s->bat_dirty_bmap);
@@ -777,6 +794,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_flush_to_os      = parallels_co_flush_to_os,
     .bdrv_co_readv  = parallels_co_readv,
     .bdrv_co_writev = parallels_co_writev,
+    .bdrv_inactivate = parallels_inactivate,
 
     .bdrv_create    = parallels_create,
     .bdrv_check     = parallels_check,
-- 
2.7.4
