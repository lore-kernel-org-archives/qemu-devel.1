Received: from eggs.gnu.org ([2001:4830:134:3::10]:55968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvI-0004aB-TF
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fVGvI-0005dj-51
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:43:52 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Tue, 19 Jun 2018 16:43:37 +0300
Message-ID: <1529415820-7750-6-git-send-email-ari@tuxera.com>
In-Reply-To: <1529415820-7750-1-git-send-email-ari@tuxera.com>
References: <1529415820-7750-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 5/8] hw/block/virtio-blk: Always apply block
 configuration to block driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max
	Reitz <mreitz@redhat.com>, "open list:virtio-blk" <qemu-block@nongnu.org>

This allows the block driver to use the block configuration of the new
VirtIO block device. One use for this information is to set request
limits using this information.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 hw/block/virtio-blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 225fe44..d5fb43b 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -974,6 +974,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     s->change = qemu_add_vm_change_state_handler(virtio_blk_dma_restart_cb, s);
     blk_set_dev_ops(s->blk, &virtio_block_ops, s);
     blk_set_guest_block_size(s->blk, s->conf.conf.logical_block_size);
+    blkconf_apply_to_blkdrv(&s->conf.conf);
 
     blk_iostatus_enable(s->blk);
 }
-- 
2.7.4
