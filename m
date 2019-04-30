Received: from eggs.gnu.org ([209.51.188.92]:48743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuq-00081c-Hi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUun-00024S-VC
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:17 +0200
Message-Id: <20190430154244.30083-1-kwolf@redhat.com>
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit 22d96eac64877c4d96f9928babb6f2fcc68faa=
cf:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2019-04-29 19:11:15 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 54277a2aab876aba7b55c7e88e2b372691849741:

  block/qed: add missed coroutine_fn markers (2019-04-30 15:29:00 +0200)

----------------------------------------------------------------
Block layer patches:

- iotests: Fix output of qemu-io related tests
- Don't ignore bdrv_set_aio_context() for nodes with bs->drv =3D NUL
- vmdk: Set vmdk parent backing_format to vmdk
- qcow2: Preallocation fixes (especially for external data files)
- Add linear-buffer-based APIs (as wrappers around qiov-based ones)
- Various code cleanups and small corner case fixes

----------------------------------------------------------------
Alberto Garcia (3):
      qcow2: Fix error handling in the compression code
      commit: Make base read-only if there is an early failure
      iotests: Check that images are in read-only mode after block-commit

Eric Blake (2):
      cutils: Fix size_to_str() on 32-bit platforms
      qemu-img: Saner printing of large file sizes

Kevin Wolf (5):
      block: Fix AioContext switch for bs->drv =3D=3D NULL
      qcow2: Avoid COW during metadata preallocation
      qcow2: Add errp to preallocate_co()
      qcow2: Fix full preallocation with external data file
      qcow2: Fix qcow2_make_empty() with external data file

Max Reitz (2):
      iotests: Perform the correct test in 082
      qemu-img: Make create hint at protocol options

Sam Eiderman (1):
      vmdk: Set vmdk parent backing_format to vmdk

Stefano Garzarella (2):
      block/vhdx: Remove redundant IEC binary prefixes definition
      block/vhdx: Use IEC binary prefixes for size constants

Thomas Huth (1):
      tests/qemu-iotests: Fix output of qemu-io related tests

Vladimir Sementsov-Ogievskiy (10):
      block: introduce byte-based io helpers
      block/qcow2: use buffer-based io
      block/qcow: use buffer-based io
      block/qed: use buffer-based io
      block/parallels: use buffer-based io
      block/backup: use buffer-based io
      block/commit: use buffer-based io
      block/stream: use buffer-based io
      qemu-img: use buffer-based io
      block/qed: add missed coroutine_fn markers

Zhengui li (1):
      vpc: unlock Coroutine lock to make IO submit Concurrently

 block/qed.h                    |  28 ++++---
 block/vhdx.h                   |  16 ++--
 include/block/block_int.h      |  16 ++++
 include/sysemu/block-backend.h |  19 +++++
 block.c                        |  12 +--
 block/backup.c                 |  14 ++--
 block/commit.c                 |   8 +-
 block/parallels.c              |  14 ++--
 block/qapi.c                   |  49 +++---------
 block/qcow.c                   |  19 ++---
 block/qcow2.c                  |  80 ++++++++++----------
 block/qed-check.c              |   4 +-
 block/qed-table.c              |  45 ++++++-----
 block/qed.c                    |  11 ++-
 block/stream.c                 |   4 +-
 block/vhdx-log.c               |   2 +-
 block/vhdx.c                   |   7 +-
 block/vmdk.c                   |   2 +
 block/vpc.c                    |   4 +
 qemu-img.c                     |  26 ++++---
 util/cutils.c                  |   2 +-
 tests/qemu-iotests/026.out     | 168 ++++++++++++++++++++---------------=
------
 tests/qemu-iotests/043.out     |   6 +-
 tests/qemu-iotests/053.out     |   2 +-
 tests/qemu-iotests/059.out     |  10 +--
 tests/qemu-iotests/060.out     |  16 ++--
 tests/qemu-iotests/061.out     |  12 +--
 tests/qemu-iotests/069.out     |   2 +-
 tests/qemu-iotests/070.out     |   4 +-
 tests/qemu-iotests/075.out     |  14 ++--
 tests/qemu-iotests/076.out     |   6 +-
 tests/qemu-iotests/078.out     |  12 +--
 tests/qemu-iotests/080.out     |  40 +++++-----
 tests/qemu-iotests/081.out     |   2 +-
 tests/qemu-iotests/082         |   5 +-
 tests/qemu-iotests/082.out     |  51 ++++++++-----
 tests/qemu-iotests/084.out     |   8 +-
 tests/qemu-iotests/088.out     |  12 +--
 tests/qemu-iotests/089.out     |   2 +-
 tests/qemu-iotests/095.out     |   4 +-
 tests/qemu-iotests/103.out     |  14 ++--
 tests/qemu-iotests/104.out     |   6 +-
 tests/qemu-iotests/110.out     |   6 +-
 tests/qemu-iotests/114.out     |   4 +-
 tests/qemu-iotests/116.out     |  14 ++--
 tests/qemu-iotests/126.out     |   4 +-
 tests/qemu-iotests/130.out     |  10 +--
 tests/qemu-iotests/131.out     |   2 +-
 tests/qemu-iotests/133.out     |  30 ++++----
 tests/qemu-iotests/137.out     |  28 +++----
 tests/qemu-iotests/140.out     |   2 +-
 tests/qemu-iotests/143.out     |   2 +-
 tests/qemu-iotests/153.out     |  32 ++++----
 tests/qemu-iotests/187.out     |   6 +-
 tests/qemu-iotests/188.out     |   2 +-
 tests/qemu-iotests/191.out     |   8 +-
 tests/qemu-iotests/195.out     |   4 +-
 tests/qemu-iotests/197.out     |   2 +-
 tests/qemu-iotests/198.out     |   4 +-
 tests/qemu-iotests/205         |   2 +-
 tests/qemu-iotests/206.out     |  10 +--
 tests/qemu-iotests/207.out     |  12 +--
 tests/qemu-iotests/210.out     |   8 +-
 tests/qemu-iotests/211.out     |  10 +--
 tests/qemu-iotests/212.out     |  10 +--
 tests/qemu-iotests/213.out     |  10 +--
 tests/qemu-iotests/215.out     |   2 +-
 tests/qemu-iotests/226.out     |  16 ++--
 tests/qemu-iotests/233.out     |   4 +-
 tests/qemu-iotests/237.out     |  22 +++---
 tests/qemu-iotests/242.out     |  10 +--
 tests/qemu-iotests/244.out     |  10 +--
 tests/qemu-iotests/249         | 115 ++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out     |  35 +++++++++
 tests/qemu-iotests/group       |   1 +
 75 files changed, 696 insertions(+), 519 deletions(-)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out
