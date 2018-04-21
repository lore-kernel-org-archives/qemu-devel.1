Received: from eggs.gnu.org ([2001:4830:134:3::10]:58292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9saG-0002i6-TT
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 09:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9saF-0000Fp-Fm
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 09:29:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 21 Apr 2018 15:29:20 +0200
Message-Id: <20180421132929.21610-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/9] block: Add COR filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This series adds a copy-on-read block filter driver which works by
simply setting the BDRV_REQ_COPY_ON_READ flag on write requests (and
otherwise just passing everything through).

Cover letter of v1:
http://lists.nongnu.org/archive/html/qemu-block/2018-04/msg00285.html


v2:
- Renamed the driver "copy-on-read" (from just "cor") [Stefan]
- Commit message typo fix in patch 2 [Stefan, Berto]


git-backport-diff against v2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/9:[0020] [FC] 'block: Add COR filter driver'
002/9:[----] [--] 'block: BLK_PERM_WRITE includes ..._UNCHANGED'
003/9:[----] [--] 'block: Add BDRV_REQ_WRITE_UNCHANGED flag'
004/9:[----] [--] 'block: Set BDRV_REQ_WRITE_UNCHANGED for COR writes'
005/9:[----] [--] 'block/quorum: Support BDRV_REQ_WRITE_UNCHANGED'
006/9:[----] [--] 'block: Support BDRV_REQ_WRITE_UNCHANGED in filters'
007/9:[----] [--] 'iotests: Clean up wrap image in 197'
008/9:[0010] [FC] 'iotests: Copy 197 for COR filter driver'
009/9:[0004] [FC] 'iotests: Add test for COR across nodes'


Max Reitz (9):
  block: Add COR filter driver
  block: BLK_PERM_WRITE includes ..._UNCHANGED
  block: Add BDRV_REQ_WRITE_UNCHANGED flag
  block: Set BDRV_REQ_WRITE_UNCHANGED for COR writes
  block/quorum: Support BDRV_REQ_WRITE_UNCHANGED
  block: Support BDRV_REQ_WRITE_UNCHANGED in filters
  iotests: Clean up wrap image in 197
  iotests: Copy 197 for COR filter driver
  iotests: Add test for COR across nodes

 block/Makefile.objs        |   2 +-
 qapi/block-core.json       |   5 +-
 include/block/block.h      |   9 ++-
 block/blkdebug.c           |   9 +--
 block/blkreplay.c          |   3 +
 block/blkverify.c          |   3 +
 block/copy-on-read.c       | 173 +++++++++++++++++++++++++++++++++++++++++++++
 block/io.c                 |  12 +++-
 block/mirror.c             |   2 +
 block/quorum.c             |  19 +++--
 block/raw-format.c         |   9 +--
 block/throttle.c           |   6 +-
 tests/qemu-iotests/197     |   1 +
 tests/qemu-iotests/215     | 120 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/215.out |  26 +++++++
 tests/qemu-iotests/216     | 117 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/216.out |  28 ++++++++
 tests/qemu-iotests/group   |   2 +
 18 files changed, 524 insertions(+), 22 deletions(-)
 create mode 100644 block/copy-on-read.c
 create mode 100755 tests/qemu-iotests/215
 create mode 100644 tests/qemu-iotests/215.out
 create mode 100755 tests/qemu-iotests/216
 create mode 100644 tests/qemu-iotests/216.out

-- 
2.14.3
