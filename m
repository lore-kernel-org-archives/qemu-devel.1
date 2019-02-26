Received: from eggs.gnu.org ([209.51.188.92]:35829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1gyeBR-0002Gg-JW
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1gyeBQ-0000lW-G1
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:58:13 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Tue, 26 Feb 2019 17:59:30 +0300
Message-Id: <20190226145930.5000-1-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] block: propagate discard aligment from
 format drivers to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>

Nowaday SCSI drivers in guests are able to alight UNMAP requests before
sending to the device. Right now QEMU provides an ability to set
this via "discard_granularity" property of the block device which could
be used by management layer.

Though, in particular, from the point of QEMU, there is
pdiscard_granularity on the format driver level, f.e. on QCOW2 or iSCSI.
It would be beneficial to pass this value as a default for this
property.

Technically this should reduce the amount of useless UNMAP requests
from the guest to the host.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Fam Zheng <fam@euphon.net>
---
 block/block-backend.c          | 13 +++++++++++++
 hw/scsi/scsi-disk.c            |  4 ++--
 include/sysemu/block-backend.h |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index f6ea824308..17a709a551 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -21,11 +21,13 @@
 #include "qapi/qapi-events-block.h"
 #include "qemu/id.h"
 #include "qemu/option.h"
+#include "qemu/units.h"
 #include "trace.h"
 #include "migration/misc.h"
 
 /* Number of coroutines to reserve per attached device model */
 #define COROUTINE_POOL_RESERVATION 64
+#define DEFAULT_DISCARD_GRANULARITY (4 * KiB)
 
 #define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
 
@@ -2042,6 +2044,17 @@ int blk_probe_geometry(BlockBackend *blk, HDGeometry *geo)
     return bdrv_probe_geometry(blk_bs(blk), geo);
 }
 
+int blk_discard_granularity(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+
+    if (bs == NULL) {
+        return DEFAULT_DISCARD_GRANULARITY;
+    }
+
+    return bs->bl.pdiscard_alignment;
+}
+
 /*
  * Updates the BlockBackendRootState object with data from the currently
  * attached BlockDriverState.
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index d4e83aef0e..f0ff099114 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -43,7 +43,6 @@
 #define SCSI_MAX_INQUIRY_LEN        256
 #define SCSI_MAX_MODE_LEN           256
 
-#define DEFAULT_DISCARD_GRANULARITY (4 * KiB)
 #define DEFAULT_MAX_UNMAP_SIZE      (1 * GiB)
 #define DEFAULT_MAX_IO_SIZE         INT_MAX     /* 2 GB - 1 block */
 
@@ -2338,7 +2337,8 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
 
     if (s->qdev.conf.discard_granularity == -1) {
         s->qdev.conf.discard_granularity =
-            MAX(s->qdev.conf.logical_block_size, DEFAULT_DISCARD_GRANULARITY);
+            MAX(s->qdev.conf.logical_block_size,
+                blk_discard_granularity(s->qdev.conf.blk));
     }
 
     if (!s->version) {
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 832a4bf168..18428e685d 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -218,6 +218,7 @@ int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
 int blk_load_vmstate(BlockBackend *blk, uint8_t *buf, int64_t pos, int size);
 int blk_probe_blocksizes(BlockBackend *blk, BlockSizes *bsz);
 int blk_probe_geometry(BlockBackend *blk, HDGeometry *geo);
+int blk_discard_granularity(BlockBackend *blk);
 BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
                                   BlockCompletionFunc *cb,
                                   void *opaque, int ret);
-- 
2.17.1
