Received: from eggs.gnu.org ([2001:4830:134:3::10]:58822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLU-0002hI-QS
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLO-0005k9-Ny
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:22 +0100
Message-Id: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 00/41] New op blocker system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This series is a first rough attempt at implementing the new op blocker system
whose design was agreed on quite a while ago, but proved a bit tricky to
implement in places. There is still work left to do, but if we want to get this
(or the greatest part of it) into 2.9, it's probably time to start review and
discussion.

The basic idea is that every user of a block node (including things outside the
block layer that go through a BlockBackend, and also other block nodes that
hold references to it) has to declare which low-level operations/permissions it
needs and which operation it allows other users to perform on the same node.
Depending on these declarations, conflicts are avoided by returning an error
for attempts to attach a conflicting user to the same node.

After this series, all users request permissions, and hopefully all of the
permissions they need. For a subset of them, getting the permission first is
actually enforced with assertions. We can probably add more assertions to this.

The series doesn't remove the old op blockers yet, though in theory the new op
blockers should block everything they used to block. (In practice it's not
completely true yet, some monitor commands don't get the right permissions yet,
in particular related to resize/graph modification.)

Kevin Wolf (41):
  block: Attach bs->file only during .bdrv_open()
  block: Add op blocker permission constants
  block: Add Error argument to bdrv_attach_child()
  block: Let callers request permissions when attaching a child node
  tests: Use opened block node for block job tests
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
  block: Request real permissions in blk_new_open()
  block: Allow error return in BlockDevOps.change_media_cb()
  hw/block: Request permissions
  hw/block: Introduce share-rw qdev property
  blockjob: Add permissions to block_job_create()
  block: Add BdrvChildRole.get_link_name()
  block: Include details on permission errors in message
  block: Add BdrvChildRole.stay_at_node
  blockjob: Add permissions to block_job_add_bdrv()
  block: Factor out bdrv_open_driver()
  block: Add bdrv_new_open_driver()
  commit: Use real permissions in commit block job
  commit: Use real permissions for HMP 'commit'
  backup: Use real permissions in backup block job
  block: Fix pending requests check in bdrv_append()
  block: BdrvChildRole.attach/detach() callbacks
  block: Allow backing file links in change_parent_backing_link()
  mirror: Use real permissions in mirror/active commit block job
  stream: Use real permissions in streaming block job
  hmp: Request permissions in qemu-io
  migration/block: Use real permissions
  nbd/server: Use real permissions for NBD exports
  tests: Remove FIXME comments
  block: Pass BdrvChild to bdrv_aligned_preadv/pwritev
  block: Assertions for write permissions

 block.c                          | 615 ++++++++++++++++++++++++++++++++-------
 block/backup.c                   |  21 +-
 block/blkdebug.c                 |   2 +
 block/blkreplay.c                |   1 +
 block/blkverify.c                |   1 +
 block/block-backend.c            |  95 +++++-
 block/bochs.c                    |   7 +
 block/cloop.c                    |   7 +
 block/commit.c                   | 164 +++++++++--
 block/crypto.c                   |   7 +
 block/dmg.c                      |   7 +
 block/io.c                       |  40 ++-
 block/mirror.c                   | 160 ++++++++--
 block/parallels.c                |   7 +
 block/qcow.c                     |   7 +
 block/qcow2.c                    |  19 +-
 block/qed.c                      |  19 +-
 block/quorum.c                   |  10 +-
 block/raw-format.c               |   7 +
 block/replication.c              |   7 +
 block/stream.c                   |  36 ++-
 block/vdi.c                      |   7 +
 block/vhdx.c                     |   7 +
 block/vmdk.c                     |   7 +
 block/vpc.c                      |   7 +
 block/vvfat.c                    |  13 +
 blockdev.c                       |  27 +-
 blockjob.c                       |  39 ++-
 hmp.c                            |  33 ++-
 hw/block/block.c                 |  21 +-
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
 hw/ide/qdev.c                    |   8 +-
 hw/nvram/spapr_nvram.c           |   8 +
 hw/scsi/scsi-disk.c              |  11 +-
 hw/sd/sd.c                       |   8 +-
 hw/usb/dev-storage.c             |   6 +-
 include/block/block.h            |   5 +-
 include/block/block_int.h        | 124 +++++++-
 include/block/blockjob.h         |   4 +-
 include/block/blockjob_int.h     |   4 +-
 include/hw/block/block.h         |   7 +-
 include/qemu-io.h                |   1 +
 include/sysemu/block-backend.h   |   9 +-
 migration/block.c                |  20 +-
 nbd/server.c                     |  16 +-
 qemu-img.c                       |   6 +-
 qemu-io-cmds.c                   |  28 ++
 tests/qemu-iotests/051.out       |   4 +-
 tests/qemu-iotests/051.pc.out    |  10 +-
 tests/qemu-iotests/055           |  11 +-
 tests/qemu-iotests/141           |   2 +-
 tests/qemu-iotests/141.out       |   4 +-
 tests/qemu-iotests/172.out       |  53 ++++
 tests/test-blockjob-txn.c        |  12 +-
 tests/test-blockjob.c            |  16 +-
 tests/test-throttle.c            |   7 +-
 65 files changed, 1616 insertions(+), 282 deletions(-)

-- 
1.8.3.1
