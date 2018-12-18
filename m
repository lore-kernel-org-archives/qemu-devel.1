Received: from eggs.gnu.org ([2001:4830:134:3::10]:47258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAFy-0006IU-Qd
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gZAFu-0003RU-Br
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 02:57:34 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 18 Dec 2018 07:57:25 +0000
Message-ID: <20181218075707.12006-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v11 00/10] qcow2: cluster space preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

new in v11:
    - patch 4, 9: fixed commentary format
    - patch 4: removed one hunk with a dead check
    - patch 5: added commentary to BDRV_REQ_ALLOCATE definition
    - new auxiliary patch 6 for the following patch-7 change:
    - patch 7: reset BDRV_REQ_ALLOCATE from supported flag if CONFIG_FALLOC=
ATE
               is false
    - patch 9: add commentary about missing qcow2_pre_write_overlap_check()=
.
               Omit redundant changes in the test 060.

v10: http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg00121.html
    - patches 1-3,6,7: rebase after REQ_WRITE_UNCHANGED
    - patch 3: drop supported_zero_flags. My bad, no write_zeroes in quorum=
.
    - patch 4: almost trivial rebase. RB-tags not stripped.
               Choose another constant for BDRV_REQ_ALLOCATE
    - patch 5: rebase. Instead of marking REQ_ALLOCATE serialising, accompa=
ny
               it with REQ_SERIALISING.
    - patch 7: add symmetric copy-on-read change
    - patch 8: trivial rebase. RB-tags not stripped.

----

This pull request is to start to improve a few performance points of
qcow2 format:

  1. non cluster-aligned write requests (to unallocated clusters) explicitl=
y
     pad data with zeroes if there is no backing data.
     Resulting increase in ops number and potential cluster fragmentation
     (on the host file) is already solved by:
       ee22a9d qcow2: Merge the writing of the COW regions with the guest d=
ata
     However, in case of zero COW regions, that can be avoided at all
     but the whole clusters are preallocated and zeroed in a single
     efficient write_zeroes() operation

  2. moreover, efficient write_zeroes() operation can be used to preallocat=
e
     space megabytes (*configurable number) ahead which gives noticeable
     improvement on some storage types (e.g. distributed storage)
     where the space allocation operation might be expensive)
     (Not included in this patchset since v6).

  3. this will also allow to enable simultaneous writes to the same unalloc=
ated
     cluster after the space has been allocated & zeroed but before
     the first data is written and the cluster is linked to L2.
     (Not included in this patchset).

Efficient write_zeroes usually implies that the blocks are not actually
written to but only reserved and marked as zeroed by the storage.
In this patchset, file-posix driver is marked as supporting this operation
if it supports (/configured to support) fallocate() operation.

Existing bdrv_write_zeroes() falls back to writing zero buffers if
write_zeroes is not supported by the driver.
A new flag (BDRV_REQ_ALLOCATE) is introduced to avoid that but return ENOTS=
UP.
Such allocate requests are also implemented to possibly overlap with the
other requests. No wait is performed but an error returned in such case as =
well.
So the operation should be considered advisory and a fallback scenario stil=
l
handled by the caller (in this case, qcow2 driver).

simple perf test:

  qemu-img create -f qcow2 test.img 4G && \
  qemu-img bench -c $((1024*1024)) -f qcow2 -n -s 4k -t none -w test.img

test results (seconds):

    +-----------+-------+------+-------+------+------+
    |   file    |    before    |     after    | gain |
    +-----------+-------+------+-------+------+------+
    |    ssd    |      61.153  |      36.313  |  41% |
    |    hdd    |     112.676  |     122.056  |  -8% |
    +-----------+--------------+--------------+------+

Anton Nefedov (10):
  mirror: inherit supported write/zero flags
  blkverify: set supported write/zero flags
  quorum: set supported write flags
  block: introduce BDRV_REQ_ALLOCATE flag
  block: treat BDRV_REQ_ALLOCATE as serialising
  file-posix: reset fallocate-related flags without CONFIG_FALLOCATE*
  file-posix: support BDRV_REQ_ALLOCATE
  block: support BDRV_REQ_ALLOCATE in passthrough drivers
  qcow2: skip writing zero buffers to empty COW areas
  iotest 134: test cluster-misaligned encrypted write

 qapi/block-core.json       |  4 +-
 block/qcow2.h              |  6 +++
 include/block/block.h      | 13 +++++-
 include/block/block_int.h  |  3 +-
 block/blkdebug.c           |  2 +-
 block/blkverify.c          | 10 ++++-
 block/copy-on-read.c       |  4 +-
 block/file-posix.c         | 16 +++++--
 block/io.c                 | 45 +++++++++++++++----
 block/mirror.c             |  8 +++-
 block/qcow2-cluster.c      |  2 +-
 block/qcow2.c              | 89 +++++++++++++++++++++++++++++++++++++-
 block/quorum.c             | 19 +++++++-
 block/raw-format.c         |  2 +-
 block/trace-events         |  1 +
 tests/qemu-iotests/060     |  7 ++-
 tests/qemu-iotests/060.out |  5 ++-
 tests/qemu-iotests/134     |  9 ++++
 tests/qemu-iotests/134.out | 10 +++++
 19 files changed, 227 insertions(+), 28 deletions(-)

--=20
2.17.1
