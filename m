Received: from eggs.gnu.org ([2001:4830:134:3::10]:55944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfrbN-0008FZ-4O
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfrbJ-0004ht-U6
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:50:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dfrbJ-0004gt-No
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:50:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 10 Aug 2017 18:48:24 +0100
Message-Id: <20170810174824.9580-4-stefanha@redhat.com>
In-Reply-To: <20170810174824.9580-1-stefanha@redhat.com>
References: <20170810174824.9580-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 3/3] virtio-blk: handle blk_getlength()
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

If blk_getlength() fails in virtio_blk_update_config() consider the disk
image length to be 0 bytes.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170808122251.29815-1-stefanha@redhat.com
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
2.13.4
