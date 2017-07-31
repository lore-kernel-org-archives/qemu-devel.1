Received: from eggs.gnu.org ([2001:4830:134:3::10]:39351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcDSj-0004no-Ar
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dcDSf-0005NX-T2
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:22:33 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 31 Jul 2017 19:21:52 +0300
Message-Id: <1501518125-29851-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 00/13] qcow2: space preallocation and COW
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
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Here goes a revisited series on qcow2 preallocation. It's probably a bit better
integrated this time and the amount of code is reduced significantly.

Changes in v3:

  - requests intersection detection from the previous versions is removed
    from qcow2 driver. Instead, tracked request infrastructure from the common
    block layer is used.

  - that made possible to omit preallocation for metadata writes.
    Those are rare and won't affect performance.

  - 'Simultaneous writes' feature (patches v2 12-15) dropped by now;
     Might worth a separate series.

  - various remarks to the previous version fixed

  - some iotests added

========

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

  /* omitted in v3: */
  3. preallocating/zeroing the clusters in advance makes possible to enable
    simultaneous writes to the same unallocated cluster, which is beneficial
    for parallel sequential write operations which are not cluster-aligned

Performance test results are added to commit messages (see patch 3, 12)

Anton Nefedov (10):
  block: introduce BDRV_REQ_ALLOCATE flag
  block: treat BDRV_REQ_ALLOCATE as serialising
  file-posix: support BDRV_REQ_ALLOCATE
  block: support BDRV_REQ_ALLOCATE in passthrough drivers
  qcow2: set inactive flag
  qcow2: move is_zero_sectors() up
  qcow2: skip writing zero buffers to empty COW areas
  qcow2: allocate image space by-cluster
  iotest 190: test BDRV_REQ_ALLOCATE
  iotest 134: test cluster-misaligned encrypted write

Denis V. Lunev (2):
  qcow2: preallocation at image expand
  qcow2: truncate preallocated space

Pavel Butsykin (1):
  qcow2: check space leak at the end of the image

 include/block/block.h              |   6 +-
 include/block/block_int.h          |   2 +-
 block/qcow2.h                      |  18 ++++
 block/blkdebug.c                   |   3 +-
 block/file-posix.c                 |   9 +-
 block/io.c                         |  47 +++++++--
 block/qcow2-cluster.c              |  14 ++-
 block/qcow2-refcount.c             |   7 ++
 block/qcow2.c                      | 201 +++++++++++++++++++++++++++++++++----
 block/raw-format.c                 |   3 +-
 block/trace-events                 |   2 +
 qemu-options.hx                    |   4 +
 tests/qemu-iotests/026.out         | 104 ++++++++++++++-----
 tests/qemu-iotests/026.out.nocache | 104 ++++++++++++++-----
 tests/qemu-iotests/029.out         |   5 +-
 tests/qemu-iotests/060             |   2 +-
 tests/qemu-iotests/060.out         |  13 ++-
 tests/qemu-iotests/061.out         |   5 +-
 tests/qemu-iotests/066             |   2 +-
 tests/qemu-iotests/066.out         |   9 +-
 tests/qemu-iotests/098.out         |   7 +-
 tests/qemu-iotests/108.out         |   5 +-
 tests/qemu-iotests/112.out         |   5 +-
 tests/qemu-iotests/134             |   9 ++
 tests/qemu-iotests/134.out         |  10 ++
 tests/qemu-iotests/190             | 146 +++++++++++++++++++++++++++
 tests/qemu-iotests/190.out         |  50 +++++++++
 tests/qemu-iotests/group           |   1 +
 28 files changed, 693 insertions(+), 100 deletions(-)
 create mode 100755 tests/qemu-iotests/190
 create mode 100644 tests/qemu-iotests/190.out

-- 
2.7.4
