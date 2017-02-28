Received: from eggs.gnu.org ([2001:4830:134:3::10]:44552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioW3-0005U7-Va
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioW2-0007VX-Nz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:36:59 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:35:59 +0100
Message-Id: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/46] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit 9514f2648ca05b38e852b490a12b8cd98d5808c1:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-02-28 17:39:49 +0000)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to b2c2832c6140cfe3ddc0de2d77eeb0b77dea8fd3:

  block: Add Error parameter to bdrv_append() (2017-02-28 20:47:51 +0100)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Kevin Wolf (44):
      block: Add op blocker permission constants
      block: Add Error argument to bdrv_attach_child()
      block: Let callers request permissions when attaching a child node
      block: Involve block drivers in permission granting
      block: Default .bdrv_child_perm() for filter drivers
      block: Request child permissions in filter drivers
      block: Default .bdrv_child_perm() for format drivers
      block: Request child permissions in format drivers
      vvfat: Implement .bdrv_child_perm()
      block: Require .bdrv_child_perm() with child nodes
      block: Request real permissions in bdrv_attach_child()
      block: Add permissions to BlockBackend
      block: Add permissions to blk_new()
      block: Add error parameter to blk_insert_bs()
      block: Add BDRV_O_RESIZE for blk_new_open()
      block: Request real permissions in blk_new_open()
      block: Allow error return in BlockDevOps.change_media_cb()
      hw/block: Request permissions
      hw/block: Introduce share-rw qdev property
      blockjob: Add permissions to block_job_create()
      block: Add BdrvChildRole.get_parent_desc()
      block: Include details on permission errors in message
      block: Add BdrvChildRole.stay_at_node
      blockjob: Add permissions to block_job_add_bdrv()
      commit: Use real permissions in commit block job
      commit: Use real permissions for HMP 'commit'
      backup: Use real permissions in backup block job
      block: Fix pending requests check in bdrv_append()
      block: BdrvChildRole.attach/detach() callbacks
      block: Allow backing file links in change_parent_backing_link()
      blockjob: Factor out block_job_remove_all_bdrv()
      mirror: Use real permissions in mirror/active commit block job
      stream: Use real permissions in streaming block job
      mirror: Add filter-node-name to blockdev-mirror
      commit: Add filter-node-name to block-commit
      hmp: Request permissions in qemu-io
      migration/block: Use real permissions
      nbd/server: Use real permissions for NBD exports
      tests: Remove FIXME comments
      block: Pass BdrvChild to bdrv_aligned_preadv/pwritev and copy-on-read
      block: Assertions for write permissions
      block: Assertions for resize permission
      block: Add Error parameter to bdrv_set_backing_hd()
      block: Add Error parameter to bdrv_append()

Markus Armbruster (1):
      option: Tweak invalid size error message and unbreak iotest 049

Peter Lieven (1):
      qemu-img: make convert async

 block.c                          | 583 ++++++++++++++++++++++++++++++++++-----
 block/backup.c                   |  22 +-
 block/blkdebug.c                 |   2 +
 block/blkreplay.c                |   1 +
 block/blkverify.c                |   1 +
 block/block-backend.c            | 116 +++++++-
 block/bochs.c                    |   1 +
 block/cloop.c                    |   1 +
 block/commit.c                   | 176 ++++++++++--
 block/crypto.c                   |   1 +
 block/dmg.c                      |   1 +
 block/io.c                       |  41 +--
 block/mirror.c                   | 237 ++++++++++++++--
 block/parallels.c                |   4 +-
 block/qcow.c                     |   4 +-
 block/qcow2.c                    |  19 +-
 block/qed.c                      |   4 +-
 block/quorum.c                   |  11 +-
 block/raw-format.c               |   1 +
 block/replication.c              |   3 +-
 block/sheepdog.c                 |   2 +-
 block/stream.c                   |  47 +++-
 block/vdi.c                      |   4 +-
 block/vhdx.c                     |   4 +-
 block/vmdk.c                     |   7 +-
 block/vpc.c                      |   4 +-
 block/vvfat.c                    |  24 +-
 blockdev.c                       |  74 ++++-
 blockjob.c                       |  62 ++++-
 hmp.c                            |  33 ++-
 hw/block/block.c                 |  24 +-
 hw/block/fdc.c                   |  28 +-
 hw/block/m25p80.c                |   8 +
 hw/block/nand.c                  |   7 +
 hw/block/nvme.c                  |   8 +-
 hw/block/onenand.c               |   7 +
 hw/block/pflash_cfi01.c          |  18 +-
 hw/block/pflash_cfi02.c          |  19 +-
 hw/block/virtio-blk.c            |   8 +-
 hw/core/qdev-properties-system.c |   9 +-
 hw/ide/core.c                    |   2 +-
 hw/ide/qdev.c                    |   9 +-
 hw/nvram/spapr_nvram.c           |   8 +
 hw/scsi/scsi-disk.c              |  12 +-
 hw/sd/sd.c                       |   8 +-
 hw/usb/dev-storage.c             |   6 +-
 include/block/block.h            |  46 ++-
 include/block/block_int.h        | 126 ++++++++-
 include/block/blockjob.h         |  14 +-
 include/block/blockjob_int.h     |   4 +-
 include/hw/block/block.h         |   8 +-
 include/qemu-io.h                |   1 +
 include/sysemu/block-backend.h   |   9 +-
 migration/block.c                |  21 +-
 nbd/server.c                     |  16 +-
 qapi/block-core.json             |  16 +-
 qemu-img-cmds.hx                 |   4 +-
 qemu-img.c                       | 334 +++++++++++++++-------
 qemu-img.texi                    |  16 +-
 qemu-io-cmds.c                   |  28 ++
 tests/qemu-iotests/049.out       |  14 +-
 tests/qemu-iotests/051.pc.out    |   6 +-
 tests/qemu-iotests/055           |  11 +-
 tests/qemu-iotests/085.out       |   2 +-
 tests/qemu-iotests/141           |   2 +-
 tests/qemu-iotests/141.out       |   4 +-
 tests/qemu-iotests/172.out       |  53 ++++
 tests/test-blockjob-txn.c        |   6 +-
 tests/test-blockjob.c            |  10 +-
 tests/test-throttle.c            |   7 +-
 util/qemu-option.c               |   2 +-
 71 files changed, 2039 insertions(+), 392 deletions(-)
