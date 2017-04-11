Received: from eggs.gnu.org ([2001:4830:134:3::10]:46402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR5-0005Gx-Ow
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxkR4-0005pi-CV
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:17:35 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Apr 2017 20:17:05 -0500
Message-Id: <20170411011718.9152-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 v9 00/13] add blkdebug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v9

Prerequisite: Max's block-next tree:
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg01298.html

v6 was:
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg01562.html
v7 and v8 were the first half of v6, and already applied to 2.9,
at commit f82c5b17.

Since then:
- Rebase to master
- Add more qcow2 patches to make write zeroes at unaligned tail cluster
more like discard of the same cluster, including more tests

001/13:[down] 'qcow2: Unallocate unmapped zero clusters if no backing file'
002/13:[down] 'iotests: Add test 179 to cover write zeroes with unmap'
003/13:[down] 'qemu-io: Switch 'alloc' command to byte-based length'
004/13:[down] 'qemu-io: Switch 'map' output to byte-based reporting'
005/13:[down] 'qcow2: Optimize write zero of unaligned tail cluster'
006/13:[0018] [FC] 'qcow2: Assert that cluster operations are aligned'
007/13:[0003] [FC] 'qcow2: Discard/zero clusters by byte count'
008/13:[----] [--] 'blkdebug: Sanity check block layer guarantees'
009/13:[----] [--] 'blkdebug: Refactor error injection'
010/13:[----] [--] 'blkdebug: Add pass-through write_zero and discard support'
011/13:[----] [--] 'blkdebug: Simplify override logic'
012/13:[0036] [FC] 'blkdebug: Add ability to override unmap geometries'
013/13:[----] [-C] 'tests: Add coverage for recent block geometry fixes'

Eric Blake (13):
  qcow2: Unallocate unmapped zero clusters if no backing file
  iotests: Add test 179 to cover write zeroes with unmap
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

 qapi/block-core.json              |  33 ++++-
 block/qcow2.h                     |   9 +-
 block/blkdebug.c                  | 264 +++++++++++++++++++++++++++++++-------
 block/qcow2-cluster.c             |  62 +++++----
 block/qcow2-snapshot.c            |   7 +-
 block/qcow2.c                     |  28 ++--
 qemu-io-cmds.c                    |  35 ++---
 tests/qemu-iotests/019.out        |   8 +-
 tests/qemu-iotests/102.out        |   4 +-
 tests/qemu-iotests/146.out        |  30 ++---
 tests/qemu-iotests/154            | 111 +++++++++++++++-
 tests/qemu-iotests/154.out        |  82 ++++++++++++
 tests/qemu-iotests/177            | 114 ++++++++++++++++
 tests/qemu-iotests/177.out        |  49 +++++++
 tests/qemu-iotests/179            |  78 +++++++++++
 tests/qemu-iotests/179.out        |  22 ++++
 tests/qemu-iotests/common.pattern |   2 +-
 tests/qemu-iotests/group          |   2 +
 18 files changed, 809 insertions(+), 131 deletions(-)
 create mode 100755 tests/qemu-iotests/177
 create mode 100644 tests/qemu-iotests/177.out
 create mode 100755 tests/qemu-iotests/179
 create mode 100644 tests/qemu-iotests/179.out

-- 
2.9.3
