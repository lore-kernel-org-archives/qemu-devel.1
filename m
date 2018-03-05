Received: from eggs.gnu.org ([2001:4830:134:3::10]:55078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1esuGo-00021x-A8
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:51:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1esuGn-0006rl-4R
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:51:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Mar 2018 18:51:07 +0100
Message-Id: <20180305175107.20210-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/38] Block layer patches
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

The following changes since commit 86f4c7e05b1c44dbe1b329a51f311f10aef6ff=
34:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80302' into staging (2018-03-02 14:37:10 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to bfe1a14c180ec44c033be12b9151252ffda69292:

  block: Fix NULL dereference on empty drive error (2018-03-05 18:45:32 +=
0100)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Alberto Garcia (3):
      specs/qcow2: Fix documentation of the compressed cluster descriptor
      docs: document how to use the l2-cache-entry-size parameter
      qcow2: Replace align_offset() with ROUND_UP()

Anton Nefedov (2):
      block: fix write with zero flag set and iovector provided
      iotest 033: add misaligned write-zeroes test via truncate

Eric Blake (21):
      block: Add .bdrv_co_block_status() callback
      nvme: Drop pointless .bdrv_co_get_block_status()
      block: Switch passthrough drivers to .bdrv_co_block_status()
      file-posix: Switch to .bdrv_co_block_status()
      gluster: Switch to .bdrv_co_block_status()
      iscsi: Switch cluster_sectors to byte-based
      iscsi: Switch iscsi_allocmap_update() to byte-based
      iscsi: Switch to .bdrv_co_block_status()
      null: Switch to .bdrv_co_block_status()
      parallels: Switch to .bdrv_co_block_status()
      qcow: Switch to .bdrv_co_block_status()
      qcow2: Switch to .bdrv_co_block_status()
      qed: Switch to .bdrv_co_block_status()
      raw: Switch to .bdrv_co_block_status()
      sheepdog: Switch to .bdrv_co_block_status()
      vdi: Avoid bitrot of debugging code
      vdi: Switch to .bdrv_co_block_status()
      vmdk: Switch to .bdrv_co_block_status()
      vpc: Switch to .bdrv_co_block_status()
      vvfat: Switch to .bdrv_co_block_status()
      block: Drop unused .bdrv_co_get_block_status()

Kevin Wolf (3):
      block: test blk_aio_flush() with blk->root =3D=3D NULL
      Merge remote-tracking branch 'mreitz/tags/pull-block-2018-03-02' in=
to queue-block
      block: Fix NULL dereference on empty drive error

Max Reitz (4):
      qemu-img: Make resize error message more general
      block/ssh: Pull ssh_grow_file() from ssh_create()
      block/ssh: Make ssh_grow_file() blocking
      block/ssh: Add basic .bdrv_truncate()

Stefan Hajnoczi (6):
      aio: rename aio_context_in_iothread() to in_aio_context_home_thread=
()
      block: extract AIO_WAIT_WHILE() from BlockDriverState
      block: add BlockBackend->in_flight counter
      Revert "IDE: Do not flush empty CDROM drives"
      block: rename .bdrv_create() to .bdrv_co_create_opts()
      qcow2: make qcow2_co_create2() a coroutine_fn

 qapi/block-core.json       |   6 +-
 docs/interop/qcow2.txt     |  16 ++++-
 docs/qcow2-cache.txt       |  46 ++++++++++++-
 block/qcow2.h              |   6 --
 include/block/aio-wait.h   | 116 ++++++++++++++++++++++++++++++++
 include/block/aio.h        |   7 +-
 include/block/block.h      |  54 ++++-----------
 include/block/block_int.h  |  61 ++++++++++-------
 block.c                    |  11 ++-
 block/blkdebug.c           |  20 +++---
 block/block-backend.c      |  65 +++++++++++++++---
 block/commit.c             |   2 +-
 block/crypto.c             |   8 +--
 block/file-posix.c         |  79 +++++++++++-----------
 block/file-win32.c         |   5 +-
 block/gluster.c            |  83 ++++++++++++-----------
 block/io.c                 |  98 +++++++++++----------------
 block/iscsi.c              | 164 ++++++++++++++++++++++++---------------=
------
 block/mirror.c             |   2 +-
 block/nfs.c                |   5 +-
 block/null.c               |  23 ++++---
 block/nvme.c               |  14 ----
 block/parallels.c          |  28 +++++---
 block/qcow.c               |  32 +++++----
 block/qcow2-bitmap.c       |   4 +-
 block/qcow2-cluster.c      |   4 +-
 block/qcow2-refcount.c     |   4 +-
 block/qcow2-snapshot.c     |  10 +--
 block/qcow2.c              |  60 +++++++++--------
 block/qed.c                |  82 ++++++++---------------
 block/raw-format.c         |  21 +++---
 block/rbd.c                |   6 +-
 block/sheepdog.c           |  36 +++++-----
 block/ssh.c                |  66 +++++++++++++++---
 block/throttle.c           |   2 +-
 block/vdi.c                |  50 +++++++-------
 block/vhdx.c               |   5 +-
 block/vmdk.c               |  43 +++++-------
 block/vpc.c                |  50 +++++++-------
 block/vvfat.c              |  16 ++---
 hw/ide/core.c              |  10 +--
 qemu-img.c                 |   2 +-
 tests/test-block-backend.c |  82 +++++++++++++++++++++++
 util/aio-wait.c            |  40 +++++++++++
 tests/Makefile.include     |   2 +
 tests/qemu-iotests/033     |  29 ++++++++
 tests/qemu-iotests/033.out |  13 ++++
 util/Makefile.objs         |   2 +-
 48 files changed, 980 insertions(+), 610 deletions(-)
 create mode 100644 include/block/aio-wait.h
 create mode 100644 tests/test-block-backend.c
 create mode 100644 util/aio-wait.c
