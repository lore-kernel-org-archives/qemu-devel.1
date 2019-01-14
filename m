Received: from eggs.gnu.org ([209.51.188.92]:54159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3Ap-0001de-DM
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3Ao-0008VW-De
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:25:07 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 14 Jan 2019 16:23:58 +0200
Message-Id: <cover.1547475602.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 0/6] Acquire the AioContext during _realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>

This series acquires the AioContext in the _realize() functions of
several devices before making use of their block backends. This fixes
at least a couple of crashes (in virtio-blk and scsi). The other
devices don't currently support iothreads so there's no crashes.

Berto

v2:
- Patch 1: include a test case [Kevin]
- Patch 2: include a test case and extend the locking to protect more
  function calls [Kevin]

v1: https://lists.gnu.org/archive/html/qemu-block/2019-01/msg00259.html
- Initial version

Output of backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/6:[0095] [FC] 'block: Acquire the AioContext in virtio_blk_device_realize()'
002/6:[0094] [FC] 'block: Acquire the AioContext in scsi_*_realize()'
003/6:[----] [--] 'block: Acquire the AioContext in floppy_drive_realize()'
004/6:[----] [--] 'block: Acquire the AioContext in nvme_realize()'
005/6:[----] [--] 'block: Acquire the AioContext in ide_dev_initfn()'
006/6:[----] [--] 'block: Acquire the AioContext in usb_msd_storage_realize()'

Alberto Garcia (6):
  block: Acquire the AioContext in virtio_blk_device_realize()
  block: Acquire the AioContext in scsi_*_realize()
  block: Acquire the AioContext in floppy_drive_realize()
  block: Acquire the AioContext in nvme_realize()
  block: Acquire the AioContext in ide_dev_initfn()
  block: Acquire the AioContext in usb_msd_storage_realize()

 hw/block/fdc.c             |  15 ++++--
 hw/block/nvme.c            |  13 +++--
 hw/block/virtio-blk.c      |  22 ++++++---
 hw/ide/qdev.c              |  17 +++++--
 hw/scsi/scsi-disk.c        |  23 +++++++--
 hw/usb/dev-storage.c       |   5 ++
 tests/qemu-iotests/236     | 121 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/236.out |  46 +++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 9 files changed, 241 insertions(+), 22 deletions(-)
 create mode 100755 tests/qemu-iotests/236
 create mode 100644 tests/qemu-iotests/236.out

-- 
2.11.0
