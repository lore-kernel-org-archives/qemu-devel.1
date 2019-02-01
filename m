Received: from eggs.gnu.org ([209.51.188.92]:38694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbnQ-00078i-RK
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbnI-00089r-T1
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:00 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:34:51 +0100
Message-Id: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/27] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit cfe6c547690b06fbce54a6d0f7b05dd7f18e36=
ea:

  Merge remote-tracking branch 'remotes/xanclic/tags/pull-block-2019-01-3=
1' into staging (2019-01-31 19:26:09 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 7471a649fc3a391dd497297013fb2525ca9821ba:

  scsi-disk: Add device_id property (2019-02-01 13:48:11 +0100)

----------------------------------------------------------------
Block layer patches:

- vmdk: Support for blockdev-create
- block: Apply auto-read-only for ro-whitelist drivers
- virtio-scsi: Fixes related to attaching/detaching iothreads
- scsi-disk: Fixed erroneously detected multipath setup with multiple
  disks created with node-names. Added device_id property.
- block: Fix hangs in synchronous APIs with iothreads
- block: Fix invalidate_cache error path for parent activation
- block-backend, mirror, qcow2, vpc, vdi, qemu-iotests:
  Minor fixes and code improvements

----------------------------------------------------------------
Alberto Garcia (7):
      mirror: Release the dirty bitmap if mirror_start_job() fails
      mirror: Block the source BlockDriverState in mirror_start_job()
      qcow2: Assert that refcount block offsets fit in the refcount table
      virtio-scsi: Move BlockBackend back to the main AioContext on unplu=
g
      scsi-disk: Acquire the AioContext in scsi_*_realize()
      virtio-scsi: Forbid devices with different iothreads sharing a bloc=
kdev
      qtest.py: Wait for the result of qtest commands

Fam Zheng (3):
      vmdk: Refactor vmdk_create_extent
      vmdk: Implement .bdrv_co_create callback
      iotests: Filter cid numbers in VMDK extent info

John Snow (1):
      iotests/236: fix transaction kwarg order

Kevin Wolf (7):
      block: Fix hangs in synchronous APIs with iothreads
      iotests: Add VMDK tests for blockdev-create
      vmdk: Reject excess extents in blockdev-create
      block: Apply auto-read-only for ro-whitelist drivers
      block: Fix invalidate_cache error path for parent activation
      scsi-disk: Don't use empty string as device id
      scsi-disk: Add device_id property

Markus Armbruster (2):
      block: Replace qdict_put() by qdict_put_obj() where appropriate
      block: Eliminate the S_1KiB, S_2KiB, ... macros

Max Reitz (2):
      iotests: Make 234 stable
      iotests: Filter second BLOCK_JOB_ERROR from 229

Peter Maydell (3):
      block/vpc: Don't take address of fields in packed structs
      block/vdi: Don't take address of fields in packed structs
      uuid: Make qemu_uuid_bswap() take and return a QemuUUID

Thomas Huth (1):
      block: Remove blk_attach_dev_legacy() / legacy_dev code

yuchenlin (1):
      qemu-iotests: add test case for dmg

 qapi/block-core.json                               |  71 +++
 qapi/qapi-schema.json                              |  16 +-
 block/qcow2.h                                      |  10 +-
 include/qemu/units.h                               |  73 ---
 include/qemu/uuid.h                                |   2 +-
 include/sysemu/block-backend.h                     |   5 +-
 block.c                                            |  27 +-
 block/blklogwrites.c                               |   5 +-
 block/block-backend.c                              |  59 +--
 block/io.c                                         |   8 +-
 block/mirror.c                                     |  11 +
 block/nbd-client.c                                 |   1 +
 block/nvme.c                                       |   1 +
 block/qcow2-refcount.c                             |   3 +
 block/qcow2.c                                      |   1 +
 block/qed.c                                        |   1 +
 block/vdi.c                                        |  57 ++-
 block/vmdk.c                                       | 532 +++++++++++++++=
------
 block/vpc.c                                        |   4 +-
 hw/acpi/vmgenid.c                                  |   6 +-
 hw/scsi/scsi-disk.c                                |  59 ++-
 hw/scsi/virtio-scsi.c                              |  13 +
 tests/test-block-iothread.c                        | 372 ++++++++++++++
 tests/vmgenid-test.c                               |   2 +-
 util/uuid.c                                        |  10 +-
 scripts/qtest.py                                   |   6 +
 tests/Makefile.include                             |   2 +
 tests/qemu-iotests/141.out                         |   4 +-
 tests/qemu-iotests/229                             |   6 +-
 tests/qemu-iotests/229.out                         |   1 -
 tests/qemu-iotests/234                             |  56 ++-
 tests/qemu-iotests/234.out                         |  10 +-
 tests/qemu-iotests/236.out                         |  56 +--
 tests/qemu-iotests/237                             | 237 +++++++++
 tests/qemu-iotests/237.out                         | 348 ++++++++++++++
 tests/qemu-iotests/239                             |  53 ++
 tests/qemu-iotests/239.out                         |   4 +
 tests/qemu-iotests/240                             | 129 +++++
 tests/qemu-iotests/240.out                         |  54 +++
 tests/qemu-iotests/check                           |   7 +
 tests/qemu-iotests/common.filter                   |   1 +
 tests/qemu-iotests/group                           |   3 +
 tests/qemu-iotests/iotests.py                      |  22 +-
 .../qemu-iotests/sample_images/simple-dmg.dmg.bz2  | Bin 0 -> 3479 bytes
 44 files changed, 1931 insertions(+), 417 deletions(-)
 create mode 100644 tests/test-block-iothread.c
 create mode 100755 tests/qemu-iotests/237
 create mode 100644 tests/qemu-iotests/237.out
 create mode 100755 tests/qemu-iotests/239
 create mode 100644 tests/qemu-iotests/239.out
 create mode 100755 tests/qemu-iotests/240
 create mode 100644 tests/qemu-iotests/240.out
 create mode 100644 tests/qemu-iotests/sample_images/simple-dmg.dmg.bz2
