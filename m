Received: from eggs.gnu.org ([2001:4830:134:3::10]:52263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecEJg-0004MV-8t
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecEJb-0004ET-G1
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 12:49:32 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 18 Jan 2018 20:48:58 +0300
Message-Id: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 0/9] qcow2: cluster space preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

(used to be 'qcow2: preallocation and COW improvements')

v7: patch 8/9:
    - is_zero_cow() function reworked
    - blkdbg event added
    - write-zeroes errors handled
    - iotest 60 fixed properly

v6: http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg03463.html

Anton Nefedov (9):
  mirror: inherit supported write/zero flags
  blkverify: set supported write/zero flags
  block: introduce BDRV_REQ_ALLOCATE flag
  block: treat BDRV_REQ_ALLOCATE as serialising
  file-posix: support BDRV_REQ_ALLOCATE
  block: support BDRV_REQ_ALLOCATE in passthrough drivers
  qcow2: move is_zero() up
  qcow2: skip writing zero buffers to empty COW areas
  iotest 134: test cluster-misaligned encrypted write

 qapi/block-core.json       |   4 +-
 block/qcow2.h              |   6 +++
 include/block/block.h      |   6 ++-
 include/block/block_int.h  |   2 +-
 block/blkdebug.c           |   3 +-
 block/blkverify.c          |   9 ++++
 block/file-posix.c         |   8 ++++
 block/io.c                 |  47 ++++++++++++++++-----
 block/mirror.c             |   5 +++
 block/qcow2-cluster.c      |   2 +-
 block/qcow2.c              | 101 ++++++++++++++++++++++++++++++++++++---------
 block/raw-format.c         |   3 +-
 block/trace-events         |   1 +
 tests/qemu-iotests/060     |  26 +++++++-----
 tests/qemu-iotests/060.out |   5 ++-
 tests/qemu-iotests/066     |   2 +-
 tests/qemu-iotests/066.out |   4 +-
 tests/qemu-iotests/134     |   9 ++++
 tests/qemu-iotests/134.out |  10 +++++
 19 files changed, 202 insertions(+), 51 deletions(-)

-- 
2.7.4
