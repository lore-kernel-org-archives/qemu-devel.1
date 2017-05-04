Received: from eggs.gnu.org ([2001:4830:134:3::10]:52477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d677h-0002u5-5K
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d677f-0001Ft-TQ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 23:08:09 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  3 May 2017 22:07:45 -0500
Message-Id: <20170504030755.1001-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v12 00/10] qcow2 zero-cluster tweaks [was add
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
git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-v12

Marked as v12 for "hysterical raisins", since it it the half of
v10 [1] that was not resubmitted as v11 [2].

Depends on Max's block tree:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00641.html
and on Max's qcow2 cleanups:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00689.html

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05227.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05896.html

Changes since last posting:
- lots of tweaks to resolve Max's review findings, including
rewriting my additions to test 154
- a new patch splitting QCOW2_CLUSTER_ZERO that fell out from
my review of Max's work
- defer any optimizations of a backing file with different length
until later (I will still post an RFC patch to explore what
optimizations a BDRV_BLOCK_EOF would allow, but didn't want to
hold up this series any further)

001/10:[down] 'qcow2: Use consistent switch indentation'
002/10:[0043] [FC] 'block: Update comments on BDRV_BLOCK_* meanings'
003/10:[0023] [FC] 'qcow2: Correctly report status of preallocated zero clusters'
004/10:[down] 'qcow2: Make distinction between zero cluster types obvious'
005/10:[0008] [FC] 'qcow2: Optimize zero_single_l2() to minimize L2 churn'
006/10:[down] 'iotests: Improve _filter_qemu_img_map'
007/10:[0107] [FC] 'iotests: Add test 179 to cover write zeroes with unmap'
008/10:[0260] [FC] 'qcow2: Optimize write zero of unaligned tail cluster'
009/10:[----] [--] 'qcow2: Assert that cluster operations are aligned'
010/10:[0005] [FC] 'qcow2: Discard/zero clusters by byte count'

Eric Blake (10):
  qcow2: Use consistent switch indentation
  block: Update comments on BDRV_BLOCK_* meanings
  qcow2: Correctly report status of preallocated zero clusters
  qcow2: Make distinction between zero cluster types obvious
  qcow2: Optimize zero_single_l2() to minimize L2 churn
  iotests: Improve _filter_qemu_img_map
  iotests: Add test 179 to cover write zeroes with unmap
  qcow2: Optimize write zero of unaligned tail cluster
  qcow2: Assert that cluster operations are aligned
  qcow2: Discard/zero clusters by byte count

 block/qcow2.h                    |  17 +++--
 include/block/block.h            |  35 +++++----
 include/block/block_int.h        |   7 ++
 block/qcow2-cluster.c            | 156 ++++++++++++++++++++++----------------
 block/qcow2-refcount.c           | 124 +++++++++++++++---------------
 block/qcow2-snapshot.c           |   7 +-
 block/qcow2.c                    |  38 ++++++----
 tests/qemu-iotests/common.filter |   4 +-
 tests/qemu-iotests/122.out       |  16 ++--
 tests/qemu-iotests/154           | 160 ++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/154.out       | 159 ++++++++++++++++++++++++++++++++++----
 tests/qemu-iotests/179           | 132 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/179.out       | 160 +++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group         |   1 +
 14 files changed, 818 insertions(+), 198 deletions(-)
 create mode 100755 tests/qemu-iotests/179
 create mode 100644 tests/qemu-iotests/179.out

-- 
2.9.3
