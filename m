Received: from eggs.gnu.org ([2001:4830:134:3::10]:40389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXl9p-0004OD-Fz
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXl9o-0006Vf-Hl
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:57:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 14 Dec 2018 11:57:07 +0100
Message-Id: <20181214105707.10707-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/42] Block layer patches
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

The following changes since commit d8d5fefd8657d4f7b380b3a1533340434b5b9d=
ef:

  Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-r=
equest' into staging (2018-12-13 18:45:18 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 537c3d4f64297911a5b70a151926cd7851bbf752:

  block/mirror: add missing coroutine_fn annotations (2018-12-14 11:55:02=
 +0100)

----------------------------------------------------------------
Block layer patches:

- qcow2: Decompression worker threads
- dmg: lzfse compression support
- file-posix: Simplify delegation to worker thread
- Don't pass flags to bdrv_reopen_queue()
- iotests: make 235 work on s390 (and others)

----------------------------------------------------------------
Alberto Garcia (15):
      block: Add bdrv_reopen_set_read_only()
      block: Use bdrv_reopen_set_read_only() in bdrv_backing_update_filen=
ame()
      block: Use bdrv_reopen_set_read_only() in commit_start/complete()
      block: Use bdrv_reopen_set_read_only() in bdrv_commit()
      block: Use bdrv_reopen_set_read_only() in stream_start/complete()
      block: Use bdrv_reopen_set_read_only() in qmp_change_backing_file()
      block: Use bdrv_reopen_set_read_only() in external_snapshot_commit(=
)
      block: Use bdrv_reopen_set_read_only() in the mirror driver
      block: Drop bdrv_reopen()
      qemu-io: Put flag changes in the options QDict in reopen_f()
      block: Clean up reopen_backing_file() in block/replication.c
      block: Remove flags parameter from bdrv_reopen_queue()
      block: Stop passing flags to bdrv_reopen_queue_child()
      block: Remove assertions from update_flags_from_options()
      block: Assert that flags are up-to-date in bdrv_reopen_prepare()

Christian Borntraeger (1):
      iotests: make 235 work on s390 (and others)

Julio Faracco (4):
      block: adding lzfse decompressing support as a module.
      configure: adding support to lzfse library.
      dmg: including dmg-lzfse module inside dmg block driver.
      dmg: exchanging hardcoded dmg UDIF block types to enum.

Kevin Wolf (12):
      file-posix: Reorganise RawPosixAIOData
      file-posix: Factor out raw_thread_pool_submit()
      file-posix: Avoid aio_worker() for QEMU_AIO_TRUNCATE
      file-posix: Avoid aio_worker() for QEMU_AIO_COPY_RANGE
      file-posix: Avoid aio_worker() for QEMU_AIO_WRITE_ZEROES
      file-posix: Avoid aio_worker() for QEMU_AIO_DISCARD
      file-posix: Avoid aio_worker() for QEMU_AIO_FLUSH
      file-posix: Move read/write operation logic out of aio_worker()
      file-posix: Avoid aio_worker() for QEMU_AIO_READ/WRITE
      file-posix: Remove paio_submit_co()
      file-posix: Switch to .bdrv_co_ioctl
      file-posix: Avoid aio_worker() for QEMU_AIO_IOCTL

Stefan Hajnoczi (1):
      block/mirror: add missing coroutine_fn annotations

Vladimir Sementsov-Ogievskiy (9):
      block/replication: drop extra synchronization
      block/backup: drop unused synchronization interface
      qcow2: use Z_OK instead of 0 for deflateInit2 return code check
      qcow2: make more generic interface for qcow2_compress
      qcow2: move decompression from qcow2-cluster.c to qcow2.c
      qcow2: refactor decompress_buffer
      qcow2: use byte-based read in qcow2_decompress_cluster
      qcow2: aio support for compressed cluster read
      qcow2: do decompression in threads

 configure                    |  31 ++++
 block/dmg.h                  |   3 +
 block/qcow2.h                |   4 -
 include/block/block.h        |   6 +-
 include/block/block_backup.h |  13 --
 include/scsi/pr-manager.h    |   8 +-
 block.c                      |  89 +++++-----
 block/backup.c               |  38 +----
 block/commit.c               |  23 +--
 block/dmg-lzfse.c            |  49 ++++++
 block/dmg.c                  |  65 ++++++--
 block/file-posix.c           | 382 ++++++++++++++++++++++---------------=
------
 block/mirror.c               |  38 +++--
 block/qcow2-cluster.c        |  70 --------
 block/qcow2.c                | 170 ++++++++++++++++---
 block/replication.c          |  67 +++-----
 block/stream.c               |  20 +--
 blockdev.c                   |  11 +-
 qemu-io-cmds.c               |  29 +++-
 scsi/pr-manager.c            |  21 +--
 block/Makefile.objs          |   2 +
 scsi/trace-events            |   2 +-
 tests/qemu-iotests/133       |  18 ++
 tests/qemu-iotests/133.out   |  15 ++
 tests/qemu-iotests/235       |   4 +-
 25 files changed, 671 insertions(+), 507 deletions(-)
 create mode 100644 block/dmg-lzfse.c
