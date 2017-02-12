Received: from eggs.gnu.org ([2001:4830:134:3::10]:46581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj3z-0003Ka-JD
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj3y-0006fi-H4
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:34:51 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:34:19 +0100
Message-Id: <20170212013440.5919-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/21] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 98b2faeaee96ab084d0b1669918688d8895c15=
5f:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' int=
o staging (2017-02-10 18:07:02 +0000)

are available in the git repository at:

  git://github.com/XanClic/qemu.git tags/pull-block-2017-02-12

for you to fetch changes up to 10d6eda1926804a09aa0710ca62933087813de0b:

  qemu-img: Avoid setting ret to unused value in img_convert() (2017-02-1=
2 00:56:32 +0100)

----------------------------------------------------------------
Block patches

----------------------------------------------------------------
Alberto Garcia (2):
      qcow2: Optimize the refcount-block overlap check
      qemu-io: don't allow I/O operations larger than BDRV_REQUEST_MAX_BY=
TES

Daniel P. Berrange (1):
      iotests: record separate timings per format,protocol pair

Dou Liyang (2):
      block/qapi: reduce the coupling between the bdrv_query_stats and bd=
rv_query_bds_stats
      block/qapi: reduce the execution time of qmp_query_blockstats

Fam Zheng (2):
      qapi: Tweak error message of bdrv_query_image_info
      iotests: Fix reference output for 059

Jeff Cody (3):
      block: check full backing filename when searching protocol filename=
s
      qemu-iotests: Don't create fifos / pidfiles with protocol paths
      qemu-iotest: test to lookup protocol-based image with relative back=
ing

Max Reitz (1):
      qemu-img: Improve commit invalid base message

Nir Soffer (3):
      qemu-io: Return non-zero exit code on failure
      qemu-iotests: Add _unsupported_fmt helper
      qemu-io: Add failure regression tests

Peter Lieven (2):
      block/nfs: fix NULL pointer dereference in URI parsing
      block/nfs: fix naming of runtime opts

Peter Maydell (2):
      qemu-img: Use qemu_strtoul() rather than raw strtoul()
      qemu-img: Avoid setting ret to unused value in img_convert()

QingFeng Hao (2):
      iotests: Fix a problem in common.filter
      block/vmdk: Fix the endian problem of buf_len and lba

Vladimir Sementsov-Ogievskiy (1):
      block: bdrv_invalidate_cache: invalidate children first

 tests/qemu-iotests/Makefile      |  2 +-
 block/qcow2.h                    |  1 +
 block.c                          | 24 +++++++---
 block/nfs.c                      | 49 ++++++++++----------
 block/qapi.c                     | 99 +++++++++++++++++-----------------=
------
 block/qcow2-refcount.c           | 24 +++++++++-
 block/qcow2.c                    |  1 +
 block/vmdk.c                     |  4 +-
 qemu-img.c                       | 44 +++++++++---------
 qemu-io-cmds.c                   | 20 +++++---
 qemu-io.c                        |  8 +++-
 tests/qemu-iotests/.gitignore    |  2 +-
 tests/qemu-iotests/059.out       |  5 +-
 tests/qemu-iotests/070.out       |  1 -
 tests/qemu-iotests/075.out       |  7 ---
 tests/qemu-iotests/076.out       |  3 --
 tests/qemu-iotests/078.out       |  6 ---
 tests/qemu-iotests/080.out       | 18 --------
 tests/qemu-iotests/083.out       | 17 -------
 tests/qemu-iotests/088.out       |  6 ---
 tests/qemu-iotests/092.out       | 12 -----
 tests/qemu-iotests/116.out       |  7 ---
 tests/qemu-iotests/131.out       |  1 -
 tests/qemu-iotests/140.out       |  1 -
 tests/qemu-iotests/173           | 97 ++++++++++++++++++++++++++++++++++=
+++++
 tests/qemu-iotests/173.out       | 12 +++++
 tests/qemu-iotests/174           | 59 ++++++++++++++++++++++++
 tests/qemu-iotests/174.out       |  7 +++
 tests/qemu-iotests/check         | 12 +++--
 tests/qemu-iotests/common.config |  6 ++-
 tests/qemu-iotests/common.filter |  2 +-
 tests/qemu-iotests/common.qemu   | 10 ++--
 tests/qemu-iotests/common.rc     | 17 +++++--
 tests/qemu-iotests/group         |  2 +
 34 files changed, 366 insertions(+), 220 deletions(-)
 create mode 100755 tests/qemu-iotests/173
 create mode 100644 tests/qemu-iotests/173.out
 create mode 100755 tests/qemu-iotests/174
 create mode 100644 tests/qemu-iotests/174.out
