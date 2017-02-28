Received: from eggs.gnu.org ([2001:4830:134:3::10]:42998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cihIh-0003lT-KW
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cihIg-0003vn-8N
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:54:43 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 13:53:45 +0100
Message-Id: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/44] New op blocker system, part 1
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
 qemu-img.c                       |  12 +-
 qemu-io-cmds.c                   |  28 ++
 tests/qemu-iotests/051.pc.out    |   6 +-
 tests/qemu-iotests/055           |  11 +-
 tests/qemu-iotests/085.out       |   2 +-
 tests/qemu-iotests/141           |   2 +-
 tests/qemu-iotests/141.out       |   4 +-
 tests/qemu-iotests/172.out       |  53 ++++
 tests/test-blockjob-txn.c        |   6 +-
 tests/test-blockjob.c            |  10 +-
 tests/test-throttle.c            |   7 +-
 67 files changed, 1786 insertions(+), 287 deletions(-)

-- 
1.8.3.1
