Received: from eggs.gnu.org ([2001:4830:134:3::10]:56992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJYi-0003zB-GN
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRJYc-0006Ml-KO
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:11:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRJYc-0006MT-BH
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:11:50 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 19 Dec 2017 15:11:21 +0000
Message-Id: <20171219151144.11120-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/23] Block patches
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

The following changes since commit eaefea537b476cb853e2edbdc68e969ec777e4=
bb:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' i=
nto staging (2017-12-18 14:17:42 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 7a9dda0d7f9831c2432620dcfefdadbb7ae888dc:

  qemu-iotests: add 203 savevm with IOThreads test (2017-12-19 10:25:09 +=
0000)

----------------------------------------------------------------
Pull request

v2:
 * Fixed incorrect virtio_blk_data_plane_create() local_err refactoring i=
n
   "hw/block: Use errp directly rather than local_err" that broke virtio-=
blk
   over virtio-mmio [Peter]

----------------------------------------------------------------

Mao Zhongyi (4):
  hw/block/nvme: Convert to realize
  hw/block: Fix the return type
  hw/block: Use errp directly rather than local_err
  dev-storage: Fix the unusual function name

Mark Kanda (2):
  virtio-blk: make queue size configurable
  virtio-blk: reject configs with logical block size > physical block
    size

Paolo Bonzini (1):
  block: avoid recursive AioContext acquire in bdrv_inactivate_all()

Stefan Hajnoczi (16):
  coroutine: simplify co_aio_sleep_ns() prototype
  qdev: drop unused #include "sysemu/iothread.h"
  blockdev: hold AioContext for bdrv_unref() in
    external_snapshot_clean()
  block: don't keep AioContext acquired after
    external_snapshot_prepare()
  block: don't keep AioContext acquired after drive_backup_prepare()
  block: don't keep AioContext acquired after blockdev_backup_prepare()
  block: don't keep AioContext acquired after
    internal_snapshot_prepare()
  block: drop unused BlockDirtyBitmapState->aio_context field
  iothread: add iothread_by_id() API
  blockdev: add x-blockdev-set-iothread testing command
  qemu-iotests: add 202 external snapshots IOThread test
  docs: mark nested AioContext locking as a legacy API
  blockdev: add x-blockdev-set-iothread force boolean
  iotests: add VM.add_object()
  iothread: fix iothread_stop() race condition
  qemu-iotests: add 203 savevm with IOThreads test

 docs/devel/multiple-iothreads.txt |   7 +-
 qapi/block-core.json              |  40 ++++++
 hw/block/dataplane/virtio-blk.h   |   2 +-
 include/hw/block/block.h          |   4 +-
 include/hw/virtio/virtio-blk.h    |   1 +
 include/qemu/coroutine.h          |   6 +-
 include/sysemu/iothread.h         |   4 +-
 block.c                           |  14 ++-
 block/null.c                      |   3 +-
 block/sheepdog.c                  |   3 +-
 blockdev.c                        | 259 +++++++++++++++++++++++++++-----=
------
 hw/block/block.c                  |  15 ++-
 hw/block/dataplane/virtio-blk.c   |  12 +-
 hw/block/fdc.c                    |  17 +--
 hw/block/nvme.c                   |  23 ++--
 hw/block/virtio-blk.c             |  30 +++--
 hw/core/qdev-properties-system.c  |   1 -
 hw/ide/qdev.c                     |  12 +-
 hw/scsi/scsi-disk.c               |  13 +-
 hw/usb/dev-storage.c              |  29 ++---
 iothread.c                        |  27 +++-
 util/qemu-coroutine-sleep.c       |   4 +-
 tests/qemu-iotests/202            |  95 ++++++++++++++
 tests/qemu-iotests/202.out        |  11 ++
 tests/qemu-iotests/203            |  59 +++++++++
 tests/qemu-iotests/203.out        |   6 +
 tests/qemu-iotests/group          |   2 +
 tests/qemu-iotests/iotests.py     |   5 +
 28 files changed, 531 insertions(+), 173 deletions(-)
 create mode 100755 tests/qemu-iotests/202
 create mode 100644 tests/qemu-iotests/202.out
 create mode 100755 tests/qemu-iotests/203
 create mode 100644 tests/qemu-iotests/203.out

--=20
2.14.3
