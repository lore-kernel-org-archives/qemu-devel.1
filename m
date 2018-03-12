Received: from eggs.gnu.org ([2001:4830:134:3::10]:33550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1evKWF-0002is-Vo
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1evKWB-0006Y8-0i
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:17:27 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 12 Mar 2018 13:16:49 +0300
Message-Id: <1520849818-6915-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 0/9] qcow2: cluster space preallocation
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

v8: - patch 1: flags setup moved to a proper place
    - new patch 3 for quorum driver
    - patch 4: expanded the flag description and minor relocations of sanity
               checks
    - patch 5: function renamed
    - patch 6: minor rebase-related changes
    - patch 7: quorum added
    - patch 8: use bdrv_is_allocated interface, which allows a less strict
               zero detection thanks to block_status 'want_zero' flag.
               Other minor changes (encrypted flag check moved).

v7: http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg04470.html

Anton Nefedov (9):
  mirror: inherit supported write/zero flags
  blkverify: set supported write/zero flags
  quorum: set supported write/zero flags
  block: introduce BDRV_REQ_ALLOCATE flag
  block: treat BDRV_REQ_ALLOCATE as serialising
  file-posix: support BDRV_REQ_ALLOCATE
  block: support BDRV_REQ_ALLOCATE in passthrough drivers
  qcow2: skip writing zero buffers to empty COW areas
  iotest 134: test cluster-misaligned encrypted write

 qapi/block-core.json       |  4 ++-
 block/qcow2.h              |  6 ++++
 include/block/block.h      |  8 ++++-
 include/block/block_int.h  |  2 +-
 block/blkdebug.c           |  3 +-
 block/blkverify.c          |  9 ++++++
 block/file-posix.c         | 10 +++++-
 block/io.c                 | 50 +++++++++++++++++++++++------
 block/mirror.c             | 11 +++++++
 block/qcow2-cluster.c      |  2 +-
 block/qcow2.c              | 79 ++++++++++++++++++++++++++++++++++++++++++++--
 block/quorum.c             | 21 ++++++++++++
 block/raw-format.c         |  3 +-
 block/trace-events         |  1 +
 tests/qemu-iotests/060     | 26 +++++++++------
 tests/qemu-iotests/060.out |  5 ++-
 tests/qemu-iotests/134     |  9 ++++++
 tests/qemu-iotests/134.out | 10 ++++++
 18 files changed, 230 insertions(+), 29 deletions(-)

-- 
2.7.4
