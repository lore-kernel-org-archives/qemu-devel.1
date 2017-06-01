Received: from eggs.gnu.org ([2001:4830:134:3::10]:51516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoW-00007y-Bc
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGRoT-0004dh-67
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:04 -0400
Received: from mail-eopbgr40133.outbound.protection.outlook.com
	([40.107.4.133]:34349
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dGRoS-0004d9-FU
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:15:01 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 1 Jun 2017 18:14:18 +0300
Message-ID: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 00/15] qcow2: space preallocation and COW
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Changes in v2:
  - introduce new BDRV flag for write_zeroes()
      instead of using driver callback directly.
    Skipped introducing new functions like bdrv_co_pallocate() for now:
      1. it seems ok to keep calling this write_zeroes() as zeroes
      are expected;
      2. most of the code can be reused now anyway, so changes to
      write_zeroes() path are not significant
      3. write_zeroes() alignment and max-request limits can also be reused

    As a possible alternative we can have bdrv_co_pallocate() which can
    switch to pwrite_zeroes(,flags|=BDRV_REQ_ALLOCATE) early.

========

This pull request is to address a few performance problems of qcow2 format:

  1. non cluster-aligned write requests (to unallocated clusters) explicitly
    pad data with zeroes if there is no backing data. This can be avoided
    and the whole clusters are preallocated and zeroed in a single
    efficient write_zeroes() operation, also providing better host file
    continuity

  2. moreover, efficient write_zeroes() operation can be used to preallocate
    space megabytes ahead which gives noticeable improvement on some storage
    types (e.g. distributed storages where space allocation operation is
    expensive)

  3. preallocating/zeroing the clusters in advance makes possible to enable
    simultaneous writes to the same unallocated cluster, which is beneficial
    for parallel sequential write operations which are not cluster-aligned

Performance test results are added to commit messages (see patch 3, 12)

Anton Nefedov (11):
  block: introduce BDRV_REQ_ALLOCATE flag
  file-posix: support BDRV_REQ_ALLOCATE
  blkdebug: support BDRV_REQ_ALLOCATE
  qcow2: do not COW the empty areas
  qcow2: set inactive flag
  qcow2: handle_prealloc(): find out if area zeroed by earlier
    preallocation
  qcow2: fix misleading comment about L2 linking
  qcow2-cluster: slightly refactor handle_dependencies()
  qcow2-cluster: make handle_dependencies() logic easier to follow
  qcow2: allow concurrent unaligned writes to the same clusters
  iotest 046: test simultaneous cluster write error case

Denis V. Lunev (3):
  qcow2: alloc space for COW in one chunk
  qcow2: preallocation at image expand
  qcow2: truncate preallocated space

Pavel Butsykin (1):
  qcow2: check space leak at the end of the image

 block/blkdebug.c                   |   3 +-
 block/file-posix.c                 |   9 +-
 block/io.c                         |  19 ++-
 block/qcow2-cache.c                |   3 +
 block/qcow2-cluster.c              | 218 +++++++++++++++++++++++------
 block/qcow2-refcount.c             |  21 +++
 block/qcow2.c                      | 273 ++++++++++++++++++++++++++++++++++++-
 block/qcow2.h                      |  26 ++++
 block/trace-events                 |   1 +
 include/block/block.h              |   6 +-
 tests/qemu-iotests/026.out         | 104 ++++++++++----
 tests/qemu-iotests/026.out.nocache | 104 ++++++++++----
 tests/qemu-iotests/029.out         |   5 +-
 tests/qemu-iotests/046             |  38 +++++-
 tests/qemu-iotests/046.out         |  23 ++++
 tests/qemu-iotests/060             |   2 +-
 tests/qemu-iotests/060.out         |  13 +-
 tests/qemu-iotests/061.out         |   5 +-
 tests/qemu-iotests/066             |   2 +-
 tests/qemu-iotests/066.out         |   9 +-
 tests/qemu-iotests/098.out         |   7 +-
 tests/qemu-iotests/108.out         |   5 +-
 tests/qemu-iotests/112.out         |   5 +-
 23 files changed, 789 insertions(+), 112 deletions(-)

-- 
2.7.4
