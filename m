Received: from eggs.gnu.org ([209.51.188.92]:55783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHU8A-000450-NN
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 10:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHTvg-00075R-Cv
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:51:49 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 19 Apr 2019 16:51:39 +0300
Message-Id: <20190419135142.91810-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Fix overflow bug in qcow2 discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, eblake@redhat.com

v2: [mostly by Eric's review]
01: new
02: point to bug introducing commit in cover letter [Eric]
     [but I failed to compile it, to check]
    drop s/INT_MAX/BDRV_REQUEST_MAX_BYTES/ chunk
03: - improve wording
    - cheating with preallocation=metadata and discards
      to make test quick and not eating disk space
    - use new trace-point
    - move it to be 250 iotest
    - filter out extra qemu-img info output

Vladimir Sementsov-Ogievskiy (3):
  block/qcow2-refcount: add trace-point to qcow2_process_discards
  block/io: bdrv_pdiscard: support int64_t bytes parameter
  iotests: test big qcow2 shrink

 include/block/block.h      |  4 +--
 block/io.c                 | 16 ++++-----
 block/qcow2-refcount.c     |  7 +++-
 block/trace-events         |  3 ++
 tests/qemu-iotests/250     | 72 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/250.out | 21 +++++++++++
 tests/qemu-iotests/group   |  1 +
 7 files changed, 113 insertions(+), 11 deletions(-)
 create mode 100755 tests/qemu-iotests/250
 create mode 100644 tests/qemu-iotests/250.out

-- 
2.18.0
