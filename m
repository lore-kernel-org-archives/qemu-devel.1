Received: from eggs.gnu.org ([209.51.188.92]:59017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDX6I-00015f-P4
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDX6G-0006Lv-56
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:26:26 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  8 Apr 2019 19:26:15 +0300
Message-Id: <20190408162617.258535-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 for 4.1 0/2] avoid lseek on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Hi!

It's a continuation for
"[PATCH] qcow2: avoid lseek on block_status if possible"
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06598.html

performance results for block-status on tmpfs [tests originally by Kevin,
now they are in 01]:

./tests/perf/block/qcow2/convert-blockstatus /ramdisk/x

after 01:

plain: 81.77
forward: 82.61
prealloc: 0.01

after 02:

plain: 0.12
forward: 0.12
prealloc: 0.01

v2:
 01: new
 02: [mostly by Kevin's comments]
     - rewritten to go through new flag BDRV_BLOCK_RECURSE
     - never retry detection if failed for first time
     - rewrite detection to do less iterations and to be more simple

     iotests 102 behavior changed [and not sure about other two ones
     in comparison with v1, but it seems it doesn't matter]

     also, patch subject changed, as now it's a generic change for
     block layer


Vladimir Sementsov-Ogievskiy (2):
  tests/perf: Test lseek influence on qcow2 block-status
  block: avoid recursive block_status call if possible

 block/qcow2.h                              |  4 ++
 include/block/block.h                      |  8 ++-
 block/io.c                                 |  9 ++-
 block/qcow2-refcount.c                     | 32 ++++++++++
 block/qcow2.c                              | 11 ++++
 tests/perf/block/qcow2/convert-blockstatus | 71 ++++++++++++++++++++++
 tests/qemu-iotests/102                     |  2 +-
 tests/qemu-iotests/102.out                 |  3 +-
 tests/qemu-iotests/141.out                 |  2 +-
 tests/qemu-iotests/144.out                 |  2 +-
 10 files changed, 138 insertions(+), 6 deletions(-)
 create mode 100755 tests/perf/block/qcow2/convert-blockstatus

-- 
2.18.0
