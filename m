Received: from eggs.gnu.org ([2001:4830:134:3::10]:48215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fQw5r-0003KG-MG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fQw5o-0005G2-HQ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:40:51 -0400
Received: from mx2.mpynet.fi ([82.197.21.85]:56034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ari@tuxera.com>) id 1fQw5o-0005FF-55
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:40:48 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Thu, 7 Jun 2018 17:40:18 +0300
Message-ID: <1528382429-13478-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 00/10] New block driver: blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>

This patch series adds a new block driver, blklogwrites, to QEMU. The
driver is given two block devices: a raw device backed by an image or a
host block device, and a log device, typically backed by a file, on
which writes to the raw device are logged.

The logging format used is the same as in the dm-log-writes target of
the Linux kernel device mapper. The log reflects the writes that have
been performed on the guest block device and flushed. To be strict, the
log may contain writes that have not been flushed yet, but they are
technically outside the bounds of the log until the next flush updates
the metadata in the log superblock. We believe these semantics to be
useful even though they may not be completely identical to those of
dm-log-writes.

This functionality can be used for crash consistency and fs consistency
testing in filesystem drivers, including on non-Linux guests and older
guests running Linux versions without support for dm-log-writes. This
is simple and useful. Admittedly this and more advanced things could
perhaps be done by extending the quorum driver, but this approach would
require re-engineering the functionality and involve a more complicated
setup, so we offer this simple solution which we have found useful
internally.

In the first patch of this series, two block permission constants are
moved from block.c to include/block/block.h to make them available
outside of block.c. The next patch uses these constants.

The driver requires all requests to be aligned to the sector size. In
the second patch of this series, which includes the bulk of the
blklogwrites driver, this sector size is assumed to be equal to
BDRV_SECTOR_SIZE for simplicity.

In patches 3-8, a mechanism to pass the block configuration of a block
backend to a block driver is introduced, and this mechanism is
integrated in various hw/block drivers.

In patch 9, blklogwrites is changed to use the block configuration of
the relevant block backend to set its block limits.

Finally, in patch 10, blklogwrites is improved to use the logical
sector size of the block backend for logging. This means that the
sector size in the log metadata will be set to the logical sector size,
and offsets and sizes of writes will be expressed as a multiple of that
instead of BDRV_SECTOR_SIZE.

Aapo Vienamo (1):
  block: Add blklogwrites

Ari Sundholm (9):
  block: Move two block permission constants to the relevant enum
  block: Add a mechanism for passing a block driver a block
    configuration
  hw/scsi/scsi-disk: Always apply block configuration to block driver
  hw/ide/qdev: Always apply block configuration to block driver
  hw/block/virtio-blk: Always apply block configuration to block driver
  hw/block/nvme: Always apply block configuration to block driver
  hw/block/fdc: Always apply block configuration to block driver
  block/blklogwrites: Use block limits from the backend block
    configuration
  block/blklogwrites: Use the block device logical sector size when
    logging writes

 MAINTAINERS               |   6 +
 block.c                   |   6 -
 block/Makefile.objs       |   1 +
 block/blklogwrites.c      | 420 ++++++++++++++++++++++++++++++++++++++++++++++
 block/io.c                |  22 +++
 hw/block/block.c          |  12 +-
 hw/block/fdc.c            |   4 +
 hw/block/nvme.c           |   1 +
 hw/block/virtio-blk.c     |   1 +
 hw/ide/qdev.c             |   2 +
 hw/scsi/scsi-disk.c       |   1 +
 include/block/block.h     |  17 ++
 include/block/block_int.h |   9 +
 include/hw/block/block.h  |   1 +
 qapi/block-core.json      |  29 +++-
 15 files changed, 519 insertions(+), 13 deletions(-)
 create mode 100644 block/blklogwrites.c

-- 
2.7.4
