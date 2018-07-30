Received: from eggs.gnu.org ([2001:4830:134:3::10]:43834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oE-0002zr-Qu
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fk9oD-00087Q-Nl
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:10:06 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 30 Jul 2018 17:09:45 +0200
Message-Id: <20180730150958.14607-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 00/13] Block layer patches
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

The following changes since commit 6d9dd5fb9d0e9f4a174f53a0e20a39fbe809c71e:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qobject-2018-07-27-v2' into staging (2018-07-30 09:55:47 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 1239ac241fe170bb9fcf0be74bfff04f6f1c2560:

  qemu-iotests: Test query-blockstats with -drive and -blockdev (2018-07-30 15:35:37 +0200)

----------------------------------------------------------------
Block layer patches:

- qemu-img convert -C is now required to enable copy offloading
- file-posix: Fix write_zeroes with unmap on block devices (would fall
  back to explicit writes on recent kernels)
- Fix query-blockstats interface for use with -blockdev
- Minor fixes and documentation updates

----------------------------------------------------------------
Fam Zheng (6):
      file-posix: Handle EINTR in preallocation=full write
      docs: Describe using images in writing iotests
      iotests: Don't lock /dev/null in 226
      Revert "qemu-img: Document copy offloading implications with -S and -c"
      qemu-img: Add -C option for convert with copy offloading
      iotests: Add test for 'qemu-img convert -C' compatibility

KONRAD Frederic (1):
      qcow: fix a reference leak

Kevin Wolf (5):
      block: Fix documentation for BDRV_REQ_MAY_UNMAP
      file-posix: Fix write_zeroes with unmap on block devices
      block/qapi: Add 'qdev' field to query-blockstats result
      block/qapi: Include anonymous BBs in query-blockstats
      qemu-iotests: Test query-blockstats with -drive and -blockdev

Leonid Bloch (1):
      qcow2: A grammar fix in conflicting cache sizing error message

 qapi/block-core.json       |  14 +++-
 include/block/block.h      |  11 +--
 block/file-posix.c         |  62 ++++++++++----
 block/qapi.c               |  16 +++-
 block/qcow.c               |   1 +
 block/qcow2.c              |   2 +-
 qemu-img.c                 |  21 ++++-
 docs/devel/testing.rst     |  11 +++
 qemu-img-cmds.hx           |   2 +-
 qemu-img.texi              |  14 ++--
 tests/qemu-iotests/082     |   8 ++
 tests/qemu-iotests/082.out |  11 +++
 tests/qemu-iotests/103.out |   4 +-
 tests/qemu-iotests/137.out |   2 +-
 tests/qemu-iotests/226     |   4 +-
 tests/qemu-iotests/227     | 101 ++++++++++++++++++++++
 tests/qemu-iotests/227.out | 205 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 18 files changed, 449 insertions(+), 41 deletions(-)
 create mode 100755 tests/qemu-iotests/227
 create mode 100644 tests/qemu-iotests/227.out
