Received: from eggs.gnu.org ([2001:4830:134:3::10]:38577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4K-0006Wz-0q
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4F-0001Hh-Qm
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:52 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:39:56 +0200
Message-Id: <20180515154033.19899-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/37] Block layer patches
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

The following changes since commit ad1b4ec39caa5b3f17cbd8160283a03a3dcfe2=
ae:

  Merge remote-tracking branch 'remotes/kraxel/tags/input-20180515-pull-r=
equest' into staging (2018-05-15 12:50:06 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 1fce860ea5eba1ca00a67911fc0b8a5d80009514:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2018-05-15' into q=
ueue-block (2018-05-15 16:19:53 +0200)

----------------------------------------------------------------
Block layer patches:

- Switch AIO/callback based block drivers to a byte-based interface
- Block jobs: Expose error string via query-block-jobs
- Block job cleanups and fixes
- hmp: Allow using a qdev id in block_set_io_throttle
- Copy-on-read block driver
- The qcow2 default refcount cache size has been decreased
- Various bug fixes
----------------------------------------------------------------
Alberto Garcia (5):
      hmp: Allow using a qdev id in block_set_io_throttle
      Fix error message about compressed clusters with OFLAG_COPIED
      specs/qcow2: Clarify that compressed clusters have the COPIED bit r=
eset
      qcow2: Give the refcount cache the minimum possible size by default
      docs: Document the new default sizes of the qcow2 caches

Daniel Henrique Barboza (1):
      block-backend: simplify blk_get_aio_context

Eric Blake (7):
      block: Support byte-based aio callbacks
      file-win32: Switch to byte-based callbacks
      null: Switch to byte-based read/write
      rbd: Switch to byte-based callbacks
      vxhs: Switch to byte-based callbacks
      block: Drop last of the sector-based aio callbacks
      block: Merge .bdrv_co_writev{,_flags} in drivers

John Snow (1):
      blockjob: expose error string via query

Kevin Wolf (7):
      blockjob: Fix assertion in block_job_finalize()
      blockjob: Wrappers for progress counter access
      blockjob: Move RateLimit to BlockJob
      blockjob: Implement block_job_set_speed() centrally
      blockjob: Introduce block_job_ratelimit_get_delay()
      blockjob: Add block_job_driver()
      Merge remote-tracking branch 'mreitz/tags/pull-block-2018-05-15' in=
to queue-block

Max Reitz (17):
      iotests: Split 214 off of 122
      iotests: Add failure matching to common.qemu
      iotests: Skip 181 and 201 without userfaultfd
      block: Add COR filter driver
      block: BLK_PERM_WRITE includes ..._UNCHANGED
      block: Add BDRV_REQ_WRITE_UNCHANGED flag
      block: Set BDRV_REQ_WRITE_UNCHANGED for COR writes
      block/quorum: Support BDRV_REQ_WRITE_UNCHANGED
      block: Support BDRV_REQ_WRITE_UNCHANGED in filters
      iotests: Clean up wrap image in 197
      iotests: Copy 197 for COR filter driver
      iotests: Add test for COR across nodes
      qemu-img: Check post-truncation size
      block: Document BDRV_REQ_WRITE_UNCHANGED support
      qemu-io: Use purely string blockdev options
      qemu-img: Use only string options in img_open_opts
      iotests: Add test for -U/force-share conflicts

 qapi/block-core.json           |  11 ++-
 docs/interop/qcow2.txt         |   8 +-
 docs/qcow2-cache.txt           |  33 ++++----
 block/qcow2.h                  |   4 -
 include/block/block.h          |   9 ++-
 include/block/block_int.h      |  28 +++++--
 include/block/blockjob.h       |  32 ++++++++
 include/block/blockjob_int.h   |  11 ++-
 include/block/raw-aio.h        |   2 +-
 block/backup.c                 |  62 ++++++---------
 block/blkdebug.c               |   9 ++-
 block/blkreplay.c              |   3 +
 block/blkverify.c              |   3 +
 block/block-backend.c          |   8 +-
 block/commit.c                 |  35 +++------
 block/copy-on-read.c           | 173 +++++++++++++++++++++++++++++++++++=
++++++
 block/file-win32.c             |  47 ++++++-----
 block/gluster.c                |   4 +-
 block/io.c                     |  75 ++++++++++--------
 block/iscsi.c                  |   8 +-
 block/mirror.c                 |  44 ++++-------
 block/null.c                   |  45 +++++------
 block/parallels.c              |   4 +-
 block/qcow.c                   |   6 +-
 block/qcow2-refcount.c         |   4 +-
 block/qcow2.c                  |  31 +++++---
 block/qed.c                    |   3 +-
 block/quorum.c                 |  19 +++--
 block/raw-format.c             |   9 ++-
 block/rbd.c                    |  40 +++++-----
 block/replication.c            |   4 +-
 block/sheepdog.c               |   4 +-
 block/ssh.c                    |   4 +-
 block/stream.c                 |  33 +++-----
 block/throttle.c               |   6 +-
 block/vhdx.c                   |   4 +-
 block/vxhs.c                   |  43 +++++-----
 block/win32-aio.c              |   5 +-
 blockjob.c                     |  40 +++++++---
 hmp.c                          |  14 +++-
 qemu-img.c                     |  43 ++++++++--
 qemu-io.c                      |   4 +-
 block/Makefile.objs            |   2 +-
 hmp-commands.hx                |   3 +-
 tests/qemu-iotests/122         |  47 -----------
 tests/qemu-iotests/122.out     |  33 --------
 tests/qemu-iotests/137.out     |   2 +-
 tests/qemu-iotests/153         |  17 ++++
 tests/qemu-iotests/153.out     |  16 ++++
 tests/qemu-iotests/181         |  13 ++++
 tests/qemu-iotests/197         |   1 +
 tests/qemu-iotests/201         |  13 ++++
 tests/qemu-iotests/214         |  97 +++++++++++++++++++++++
 tests/qemu-iotests/214.out     |  35 +++++++++
 tests/qemu-iotests/215         | 120 ++++++++++++++++++++++++++++
 tests/qemu-iotests/215.out     |  26 +++++++
 tests/qemu-iotests/216         | 115 +++++++++++++++++++++++++++
 tests/qemu-iotests/216.out     |  28 +++++++
 tests/qemu-iotests/common.qemu |  58 ++++++++++++--
 tests/qemu-iotests/group       |   3 +
 60 files changed, 1174 insertions(+), 429 deletions(-)
 create mode 100644 block/copy-on-read.c
 create mode 100755 tests/qemu-iotests/214
 create mode 100644 tests/qemu-iotests/214.out
 create mode 100755 tests/qemu-iotests/215
 create mode 100644 tests/qemu-iotests/215.out
 create mode 100755 tests/qemu-iotests/216
 create mode 100644 tests/qemu-iotests/216.out
