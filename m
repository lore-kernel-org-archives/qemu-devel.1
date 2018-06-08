Received: from eggs.gnu.org ([2001:4830:134:3::10]:46430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fRGZP-0000hr-5D
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fRGZO-0005x9-DH
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:32:43 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Fri, 8 Jun 2018 15:32:24 +0300
Message-ID: <1528461148-17925-7-git-send-email-ari@tuxera.com>
In-Reply-To: <1528461148-17925-1-git-send-email-ari@tuxera.com>
References: <1528461148-17925-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 06/10] hw/block/virtio-blk: Always apply
 block configuration to block driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:virtio-blk" <qemu-block@nongnu.org>

This allows the block driver to use the block configuration of the new
VirtIO block device. One use for this information is to set request
limits using this information.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 hw/block/virtio-blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 50b5c86..51e7b86 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -975,6 +975,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     s->change = qemu_add_vm_change_state_handler(virtio_blk_dma_restart_cb, s);
     blk_set_dev_ops(s->blk, &virtio_block_ops, s);
     blk_set_guest_block_size(s->blk, s->conf.conf.logical_block_size);
+    blkconf_apply_to_blkdrv(&s->conf.conf);
 
     blk_iostatus_enable(s->blk);
 }
-- 
2.7.4
