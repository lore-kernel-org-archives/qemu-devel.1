Received: from eggs.gnu.org ([209.51.188.92]:44210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGhVX-00038L-Nl
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 06:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGhVW-0003ty-Ps
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 06:09:35 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 17 Apr 2019 13:09:27 +0300
Message-Id: <20190417100929.39943-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH for-4.0? 0/2] Fix overflow bug in qcow2 discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com

Hi all. We faced an interesting bug, which may be simply reproduced:

prepare image:
./qemu-img create -f qcow2 -o cluster_size=1M /ssd/test 2300M
./qemu-io -c 'write 100M 2000M' -c 'write 2100M 200M' -c 'write 0 100M' /ssd/test

shrink:
./qemu-img resize --shrink /ssd/test 50M

bug:
./qemu-img info /ssd/test
image: /ssd/test
file format: qcow2
virtual size: 50M (52428800 bytes)
disk size: 2.2G
cluster_size: 1048576
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

Virtual size is shrunk, but file - not. It is due to the fact,
that merged qcow2 discard may exceed 2G, and then converting from
uint64_t to int in qcow2_process_discards when we call bdrv_pdiscard
make wrong thing.

So, here are proposal of fix and new iotest for it.

Vladimir Sementsov-Ogievskiy (2):
  block/io: bdrv_pdiscard: support int64_t bytes parameter
  iotests: test big qcow2 shrink

 include/block/block.h      |  4 +--
 block/io.c                 | 19 ++++++-----
 tests/qemu-iotests/249     | 69 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/249.out | 30 +++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 5 files changed, 112 insertions(+), 11 deletions(-)
 create mode 100755 tests/qemu-iotests/249
 create mode 100644 tests/qemu-iotests/249.out

-- 
2.18.0
