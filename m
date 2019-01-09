Received: from eggs.gnu.org ([209.51.188.92]:39278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghEr3-0008NG-2L
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghEr0-000186-Dk
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:29:13 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  9 Jan 2019 16:28:50 +0200
Message-Id: <20190109142850.27727-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] block: Acquire the AioContext in
 guess_disk_lchs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This fixes the following crash:

{ "execute": "blockdev-add",
  "arguments": {"driver": "null-co", "node-name": "hd0"}}
{ "execute": "object-add",
  "arguments": {"qom-type": "iothread", "id": "iothread0"}}
{ "execute": "x-blockdev-set-iothread",
  "arguments": {"node-name": "hd0", "iothread": "iothread0"}}
{ "execute": "device_add",
  "arguments": {"id": "virtio0", "driver": "virtio-blk-pci",
                "drive": "hd0"}}
qemu: qemu_mutex_unlock_impl: Operation not permitted
Aborted

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 hw/block/hd-geometry.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index 79384a2b0a..0d9a7b7e7d 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -55,6 +55,7 @@ struct partition {
 static int guess_disk_lchs(BlockBackend *blk,
                            int *pcylinders, int *pheads, int *psectors)
 {
+    AioContext *ctx = blk_get_aio_context(blk);
     uint8_t buf[BDRV_SECTOR_SIZE];
     int i, heads, sectors, cylinders;
     struct partition *p;
@@ -68,7 +69,10 @@ static int guess_disk_lchs(BlockBackend *blk,
      * but also in async I/O mode. So the I/O throttling function has to
      * be disabled temporarily here, not permanently.
      */
-    if (blk_pread_unthrottled(blk, 0, buf, BDRV_SECTOR_SIZE) < 0) {
+    aio_context_acquire(ctx);
+    i = blk_pread_unthrottled(blk, 0, buf, BDRV_SECTOR_SIZE);
+    aio_context_release(ctx);
+    if (i < 0) {
         return -1;
     }
     /* test msdos magic */
-- 
2.11.0
