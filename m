Received: from eggs.gnu.org ([2001:4830:134:3::10]:58535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1df3XW-0003EB-AO
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1df3XT-0006JO-5m
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:23:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  8 Aug 2017 13:22:51 +0100
Message-Id: <20170808122251.29815-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-blk: handle blk_getlength() errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

If blk_getlength() fails in virtio_blk_update_config() consider the disk
image length to be 0 bytes.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b750bd8b53..a16ac75090 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -730,6 +730,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
     BlockConf *conf = &s->conf.conf;
     struct virtio_blk_config blkcfg;
     uint64_t capacity;
+    int64_t length;
     int blk_size = conf->logical_block_size;
 
     blk_get_geometry(s->blk, &capacity);
@@ -752,7 +753,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
      * divided by 512 - instead it is the amount of blk_size blocks
      * per track (cylinder).
      */
-    if (blk_getlength(s->blk) /  conf->heads / conf->secs % blk_size) {
+    length = blk_getlength(s->blk);
+    if (length > 0 && length / conf->heads / conf->secs % blk_size) {
         blkcfg.geometry.sectors = conf->secs & ~s->sector_mask;
     } else {
         blkcfg.geometry.sectors = conf->secs;
-- 
2.13.3
