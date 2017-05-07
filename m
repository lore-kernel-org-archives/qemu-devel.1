Received: from eggs.gnu.org ([2001:4830:134:3::10]:45727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d79iA-0002ba-CX
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d79i9-0007iU-AA
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:06:06 -0400
From: Eric Blake <eblake@redhat.com>
Date: Sat,  6 May 2017 19:05:40 -0500
Message-Id: <20170507000552.20847-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v13 00/12] qcow2 zero-cluster tweaks [was add
 blkdebug tests]
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

I've collected several improvements for qcow2 zero-cluster handling.

Available as a tag at:
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v13

Marked as v13 for "hysterical raisins", since it it the half of
v10 [1] that was not resubmitted as v11 [2].

Depends on Max's block tree:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00641.html
and on Max's qcow2 cleanups:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00689.html

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05227.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05896.html
[3] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00722.html

Changes since last posting (v12 [3]):
- 2 more new patches: split indentation from other changes (patch 1),
and add a typedef (patch 5)
- address Max's findings

001/12:[down] 'qcow2: Nicer variable names in qcow2_update_snapshot_refcount()'
002/12:[0040] [FC] 'qcow2: Use consistent switch indentation'
003/12:[----] [--] 'block: Update comments on BDRV_BLOCK_* meanings'
004/12:[----] [--] 'qcow2: Correctly report status of preallocated zero clusters'
005/12:[down] 'qcow2: Name typedef for cluster type'
006/12:[0032] [FC] 'qcow2: Make distinction between zero cluster types obvious'
007/12:[0002] [FC] 'qcow2: Optimize zero_single_l2() to minimize L2 churn'
008/12:[0002] [FC] 'iotests: Improve _filter_qemu_img_map'
009/12:[0010] [FC] 'iotests: Add test 179 to cover write zeroes with unmap'
010/12:[0003] [FC] 'qcow2: Optimize write zero of unaligned tail cluster'
011/12:[----] [--] 'qcow2: Assert that cluster operations are aligned'
012/12:[----] [--] 'qcow2: Discard/zero clusters by byte count'

Eric Blake (12):
  qcow2: Nicer variable names in qcow2_update_snapshot_refcount()
  qcow2: Use consistent switch indentation
  block: Update comments on BDRV_BLOCK_* meanings
  qcow2: Correctly report status of preallocated zero clusters
  qcow2: Name typedef for cluster type
  qcow2: Make distinction between zero cluster types obvious
  qcow2: Optimize zero_single_l2() to minimize L2 churn
  iotests: Improve _filter_qemu_img_map
  iotests: Add test 179 to cover write zeroes with unmap
  qcow2: Optimize write zero of unaligned tail cluster
  qcow2: Assert that cluster operations are aligned
  qcow2: Discard/zero clusters by byte count

 block/qcow2.h                    |  23 +++--
 include/block/block.h            |  35 ++++----
 include/block/block_int.h        |   7 ++
 block/qcow2-cluster.c            | 181 ++++++++++++++++++++++-----------------
 block/qcow2-refcount.c           | 144 +++++++++++++++----------------
 block/qcow2-snapshot.c           |   7 +-
 block/qcow2.c                    |  38 ++++----
 tests/qemu-iotests/common.filter |   4 +-
 tests/qemu-iotests/060.out       |   6 +-
 tests/qemu-iotests/122.out       |  16 ++--
 tests/qemu-iotests/154           | 160 +++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/154.out       | 158 ++++++++++++++++++++++++++++++----
 tests/qemu-iotests/179           | 130 ++++++++++++++++++++++++++++
 tests/qemu-iotests/179.out       | 156 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group         |   1 +
 15 files changed, 840 insertions(+), 226 deletions(-)
 create mode 100755 tests/qemu-iotests/179
 create mode 100644 tests/qemu-iotests/179.out

-- 
2.9.3
