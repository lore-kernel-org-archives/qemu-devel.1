Received: from eggs.gnu.org ([2001:4830:134:3::10]:33565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YVy-0007S0-6b
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3YVw-00043B-QO
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:46:38 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Apr 2017 20:46:09 -0500
Message-Id: <20170427014626.11553-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 00/17] add blkdebug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v10

Prerequisites: Max's block-next tree:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01298.html
Fam's fix for test 109:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03195.html

v9 was:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01723.html

Since then:
- Rebase to master
- Add even more qcow2 patches to make tracking of preallocated
zero clusters correct
- replace v9 1/13 with 4/17 that is not as invasive (no change to
v2 format, and no questionable use of unallocated clusters)
- rewrite v9 2/13 (iotests 179) with 5/17, as something more robust

001/17:[down] 'block: Update comments on BDRV_BLOCK_* meanings'
002/17:[down] 'qcow2: Correctly report status of preallocated zero cluste=
rs'
003/17:[down] 'qcow2: Reuse preallocated zero clusters'
004/17:[down] 'qcow2: Optimize zero_single_l2() to minimize L2 churn'
005/17:[0187] [FC] 'iotests: Add test 179 to cover write zeroes with unma=
p'
006/17:[down] 'qemu-io: Don't open-code QEMU_IS_ALIGNED'
007/17:[0010] [FC] 'qemu-io: Switch 'alloc' command to byte-based length'
008/17:[0022] [FC] 'qemu-io: Switch 'map' output to byte-based reporting'
009/17:[0006] [FC] 'qcow2: Optimize write zero of unaligned tail cluster'
010/17:[----] [-C] 'qcow2: Assert that cluster operations are aligned'
011/17:[0005] [FC] 'qcow2: Discard/zero clusters by byte count'
012/17:[----] [--] 'blkdebug: Sanity check block layer guarantees'
013/17:[----] [--] 'blkdebug: Refactor error injection'
014/17:[----] [--] 'blkdebug: Add pass-through write_zero and discard sup=
port'
015/17:[----] [--] 'blkdebug: Simplify override logic'
016/17:[----] [--] 'blkdebug: Add ability to override unmap geometries'
017/17:[----] [-C] 'tests: Add coverage for recent block geometry fixes'

Eric Blake (16):
  block: Update comments on BDRV_BLOCK_* meanings
  qcow2: Correctly report status of preallocated zero clusters
  qcow2: Optimize zero_single_l2() to minimize L2 churn
  iotests: Add test 179 to cover write zeroes with unmap
  qemu-io: Don't open-code QEMU_IS_ALIGNED
  qemu-io: Switch 'alloc' command to byte-based length
  qemu-io: Switch 'map' output to byte-based reporting
  qcow2: Optimize write zero of unaligned tail cluster
  qcow2: Assert that cluster operations are aligned
  qcow2: Discard/zero clusters by byte count
  blkdebug: Sanity check block layer guarantees
  blkdebug: Refactor error injection
  blkdebug: Add pass-through write_zero and discard support
  blkdebug: Simplify override logic
  blkdebug: Add ability to override unmap geometries
  tests: Add coverage for recent block geometry fixes

Max Reitz (1):
  qcow2: Reuse preallocated zero clusters

 qapi/block-core.json              |  33 ++++-
 block/qcow2.h                     |  12 +-
 include/block/block.h             |  13 +-
 block/blkdebug.c                  | 264 +++++++++++++++++++++++++++++++-=
------
 block/qcow2-cluster.c             | 177 +++++++++++++++++--------
 block/qcow2-snapshot.c            |   7 +-
 block/qcow2.c                     |  28 ++--
 qemu-io-cmds.c                    |  45 ++++---
 tests/qemu-iotests/019.out        |   8 +-
 tests/qemu-iotests/102.out        |   4 +-
 tests/qemu-iotests/146.out        |  30 ++---
 tests/qemu-iotests/154            | 112 +++++++++++++++-
 tests/qemu-iotests/154.out        |  83 ++++++++++++
 tests/qemu-iotests/177            | 114 ++++++++++++++++
 tests/qemu-iotests/177.out        |  49 +++++++
 tests/qemu-iotests/179            | 123 ++++++++++++++++++
 tests/qemu-iotests/179.out        |  90 +++++++++++++
 tests/qemu-iotests/common.pattern |   2 +-
 tests/qemu-iotests/group          |   2 +
 19 files changed, 1024 insertions(+), 172 deletions(-)
 create mode 100755 tests/qemu-iotests/177
 create mode 100644 tests/qemu-iotests/177.out
 create mode 100755 tests/qemu-iotests/179
 create mode 100644 tests/qemu-iotests/179.out

--=20
2.9.3
