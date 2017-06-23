Received: from eggs.gnu.org ([2001:4830:134:3::10]:59088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLX-0000JO-Kd
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLW-0007Qv-Gi
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:20:58 +0200
Message-Id: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/61] Block layer patches
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

The following changes since commit 4c8c1cc544dbd5e2564868e61c5037258e393832:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.10-pull-request' into staging (2017-06-22 19:01:58 +0100)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 1512008812410ca4054506a7c44343088abdd977:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2017-06-23' into queue-block (2017-06-23 14:09:12 +0200)

----------------------------------------------------------------

Block layer patches

----------------------------------------------------------------
Alberto Garcia (9):
      throttle: Update throttle-groups.c documentation
      qcow2: Remove unused Error variable in do_perform_cow()
      qcow2: Use unsigned int for both members of Qcow2COWRegion
      qcow2: Make perform_cow() call do_perform_cow() twice
      qcow2: Split do_perform_cow() into _read(), _encrypt() and _write()
      qcow2: Allow reading both COW regions with only one request
      qcow2: Pass a QEMUIOVector to do_perform_cow_{read,write}()
      qcow2: Merge the writing of the COW regions with the guest data
      qcow2: Use offset_into_cluster() and offset_to_l2_index()

Kevin Wolf (37):
      commit: Fix completion with extra reference
      qemu-iotests: Allow starting new qemu after cleanup
      qemu-iotests: Test exiting qemu with running job
      doc: Document generic -blockdev options
      doc: Document driver-specific -blockdev options
      qed: Use bottom half to resume waiting requests
      qed: Make qed_read_table() synchronous
      qed: Remove callback from qed_read_table()
      qed: Remove callback from qed_read_l2_table()
      qed: Remove callback from qed_find_cluster()
      qed: Make qed_read_backing_file() synchronous
      qed: Make qed_copy_from_backing_file() synchronous
      qed: Remove callback from qed_copy_from_backing_file()
      qed: Make qed_write_header() synchronous
      qed: Remove callback from qed_write_header()
      qed: Make qed_write_table() synchronous
      qed: Remove GenericCB
      qed: Remove callback from qed_write_table()
      qed: Make qed_aio_read_data() synchronous
      qed: Make qed_aio_write_main() synchronous
      qed: Inline qed_commit_l2_update()
      qed: Add return value to qed_aio_write_l1_update()
      qed: Add return value to qed_aio_write_l2_update()
      qed: Add return value to qed_aio_write_main()
      qed: Add return value to qed_aio_write_cow()
      qed: Add return value to qed_aio_write_inplace/alloc()
      qed: Add return value to qed_aio_read/write_data()
      qed: Remove ret argument from qed_aio_next_io()
      qed: Remove recursion in qed_aio_next_io()
      qed: Implement .bdrv_co_readv/writev
      qed: Use CoQueue for serialising allocations
      qed: Simplify request handling
      qed: Use a coroutine for need_check_timer
      qed: Add coroutine_fn to I/O path functions
      qed: Use bdrv_co_* for coroutine_fns
      block: Remove bdrv_aio_readv/writev/flush()
      Merge remote-tracking branch 'mreitz/tags/pull-block-2017-06-23' into queue-block

Manos Pitsidianakis (1):
      block: change variable names in BlockDriverState

Max Reitz (3):
      blkdebug: Catch bs->exact_filename overflow
      blkverify: Catch bs->exact_filename overflow
      block: Do not strcmp() with NULL uri->scheme

Stefan Hajnoczi (10):
      block: count bdrv_co_rw_vmstate() requests
      block: use BDRV_POLL_WHILE() in bdrv_rw_vmstate()
      migration: avoid recursive AioContext locking in save_vmstate()
      migration: use bdrv_drain_all_begin/end() instead bdrv_drain_all()
      virtio-pci: use ioeventfd even when KVM is disabled
      migration: hold AioContext lock for loadvm qemu_fclose()
      qemu-iotests: 068: extract _qemu() function
      qemu-iotests: 068: use -drive/-device instead of -hda
      qemu-iotests: 068: test iothread mode
      qemu-img: don't shadow opts variable in img_dd()

Stephen Bates (1):
      nvme: Add support for Read Data and Write Data in CMBs.

sochin.jiang (1):
      fix: avoid an infinite loop or a dangling pointer problem in img_commit

 block/Makefile.objs            |   2 +-
 block/blkdebug.c               |  46 +--
 block/blkreplay.c              |   8 +-
 block/blkverify.c              |  12 +-
 block/block-backend.c          |  22 +-
 block/commit.c                 |   7 +
 block/file-posix.c             |  34 +-
 block/io.c                     | 240 ++-----------
 block/iscsi.c                  |  20 +-
 block/mirror.c                 |   8 +-
 block/nbd-client.c             |   8 +-
 block/nbd-client.h             |   4 +-
 block/nbd.c                    |   6 +-
 block/nfs.c                    |   2 +-
 block/qcow2-cluster.c          | 201 ++++++++---
 block/qcow2.c                  |  94 +++--
 block/qcow2.h                  |  11 +-
 block/qed-cluster.c            | 124 +++----
 block/qed-gencb.c              |  33 --
 block/qed-table.c              | 261 +++++---------
 block/qed.c                    | 779 ++++++++++++++++-------------------------
 block/qed.h                    |  54 +--
 block/raw-format.c             |   8 +-
 block/rbd.c                    |   4 +-
 block/sheepdog.c               |  12 +-
 block/ssh.c                    |   2 +-
 block/throttle-groups.c        |   2 +-
 block/trace-events             |   3 -
 blockjob.c                     |   4 +-
 hw/block/nvme.c                |  83 +++--
 hw/block/nvme.h                |   1 +
 hw/virtio/virtio-pci.c         |   2 +-
 include/block/block.h          |  16 +-
 include/block/block_int.h      |   6 +-
 include/block/blockjob.h       |  18 +
 include/sysemu/block-backend.h |  20 +-
 migration/savevm.c             |  32 +-
 qemu-img.c                     |  29 +-
 qemu-io-cmds.c                 |  46 +--
 qemu-options.hx                | 221 ++++++++++--
 tests/qemu-iotests/068         |  37 +-
 tests/qemu-iotests/068.out     |  11 +-
 tests/qemu-iotests/185         | 206 +++++++++++
 tests/qemu-iotests/185.out     |  59 ++++
 tests/qemu-iotests/common.qemu |   3 +
 tests/qemu-iotests/group       |   1 +
 46 files changed, 1477 insertions(+), 1325 deletions(-)
 delete mode 100644 block/qed-gencb.c
 create mode 100755 tests/qemu-iotests/185
 create mode 100644 tests/qemu-iotests/185.out
