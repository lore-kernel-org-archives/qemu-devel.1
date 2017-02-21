Received: from eggs.gnu.org ([2001:4830:134:3::10]:42554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuJ-00085C-P5
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuI-0007lI-E6
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:11 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:57:56 +0100
Message-Id: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 00/54] New op blocker system, part 1
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

This series is the first part of implementing the new op blocker system
whose design was agreed on quite a while ago, but proved a bit tricky to
implement in places. There is more work to do to fully replace the old op
blocker system, but realistically we don't have that much time until the 2.9
freeze. So let's merge this series to complement the traditional op blockers
and plan with a second part for the 2.10 timeframe.

The basic idea is that every user of a block node (including things outside the
block layer that go through a BlockBackend, and also other block nodes that
hold references to it) has to declare which low-level operations/permissions it
needs and which operation it allows other users to perform on the same node.
Depending on these declarations, conflicts are avoided by returning an error
for attempts to attach a conflicting user to the same node.

After this series, all users request permissions, and hopefully all of the
permissions they need. For writes and resize, getting the permission first is
actually enforced with assertions. Asserting it for consistent reads is in
theory doable, but would mean introducing a request flag that tell us that
inconsistent reads are okay - and that in all block drivers to recursively
propagate this flag through the backing chain. It might not be worth it.

As stated above, the series doesn't remove the old op blockers yet, though in
theory the new op blockers should block everything that needs to be blocked.
In practice, the read/write/resize blockers should be okay, but
BLK_PERM_GRAPH_MOD isn't to be taken too seriously at the moment. It isn't
really applied consistently and doesn't do much useful yet. Making proper use
of it is left for the part 2 series.

Kevin Wolf (54):
  blockdev: Use BlockBackend to resize in qmp_block_resize()
  qcow2: Use BB for resizing in qcow2_amend_options()
  mirror: Resize active commit base in mirror_run()
  block: Pass BdrvChild to bdrv_truncate()
  block: Attach bs->file only during .bdrv_open()
  block: Factor out bdrv_open_child_bs()
  block: Use BlockBackend for image probing
  block: Factor out bdrv_open_driver()
  block: Add bdrv_new_open_driver()
  vvfat: Use opened node as backing file
  tests: Use opened block node for block job tests
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
  mirror: Use real permissions in mirror/active commit block job
  stream: Use real permissions in streaming block job
  mirror: Add filter-node-name to blockdev-mirror
  commit: Add filter-node-name to block-commit
  hmp: Request permissions in qemu-io
  migration/block: Use real permissions
  nbd/server: Use real permissions for NBD exports
  tests: Remove FIXME comments
  block: Pass BdrvChild to bdrv_aligned_preadv/pwritev
  block: Assertions for write permissions
  block: Assertions for resize permission
  block: Add Error parameter to bdrv_set_backing_hd()
  block: Add Error parameter to bdrv_append()

 block.c                          | 803 +++++++++++++++++++++++++++++++--------
 block/backup.c                   |  22 +-
 block/blkdebug.c                 |   4 +-
 block/blkreplay.c                |   1 +
 block/blkverify.c                |   1 +
 block/block-backend.c            | 118 +++++-
 block/bochs.c                    |   7 +
 block/cloop.c                    |   7 +
 block/commit.c                   | 168 +++++++-
 block/crypto.c                   |   9 +-
 block/dmg.c                      |   7 +
 block/io.c                       |  40 +-
 block/mirror.c                   | 243 +++++++++---
 block/parallels.c                |  18 +-
 block/qcow.c                     |  14 +-
 block/qcow2-refcount.c           |   2 +-
 block/qcow2.c                    |  38 +-
 block/qed.c                      |  22 +-
 block/quorum.c                   |  11 +-
 block/raw-format.c               |   9 +-
 block/replication.c              |   9 +-
 block/stream.c                   |  45 ++-
 block/vdi.c                      |  10 +-
 block/vhdx-log.c                 |   2 +-
 block/vhdx.c                     |  12 +-
 block/vmdk.c                     |  13 +-
 block/vpc.c                      |  10 +-
 block/vvfat.c                    |  34 +-
 blockdev.c                       |  74 +++-
 blockjob.c                       |  48 ++-
 hmp.c                            |  33 +-
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
 hw/ide/qdev.c                    |   8 +-
 hw/nvram/spapr_nvram.c           |   8 +
 hw/scsi/scsi-disk.c              |  12 +-
 hw/sd/sd.c                       |   8 +-
 hw/usb/dev-storage.c             |   6 +-
 include/block/block.h            |  49 ++-
 include/block/block_int.h        | 126 +++++-
 include/block/blockjob.h         |   5 +-
 include/block/blockjob_int.h     |   4 +-
 include/hw/block/block.h         |   7 +-
 include/qemu-io.h                |   1 +
 include/sysemu/block-backend.h   |   9 +-
 migration/block.c                |  20 +-
 nbd/server.c                     |  16 +-
 qapi/block-core.json             |  16 +-
 qemu-img.c                       |  12 +-
 qemu-io-cmds.c                   |  28 ++
 tests/qemu-iotests/051.out       |   4 +-
 tests/qemu-iotests/051.pc.out    |  10 +-
 tests/qemu-iotests/055           |  11 +-
 tests/qemu-iotests/085.out       |   2 +-
 tests/qemu-iotests/141           |   2 +-
 tests/qemu-iotests/141.out       |   4 +-
 tests/qemu-iotests/172.out       |  53 +++
 tests/test-blockjob-txn.c        |  12 +-
 tests/test-blockjob.c            |  16 +-
 tests/test-throttle.c            |   7 +-
 69 files changed, 2013 insertions(+), 415 deletions(-)

-- 
1.8.3.1
