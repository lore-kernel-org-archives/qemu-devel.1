Received: from eggs.gnu.org ([2001:4830:134:3::10]:42953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60u-0007U3-Lm
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fn60r-000232-SX
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:43:20 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  7 Aug 2018 20:43:04 +0300
Message-Id: <20180807174311.32454-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/7] qcow2: async handling of fragmented io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all!

Here is an asynchronous scheme for handling fragmented qcow2
reads and writes. Both qcow2 read and write functions loops through
sequential portions of data. The series aim it to parallelize these
loops iterations.

It improves performance for fragmented qcow2 images, I've tested it
as follows:

I have four 4G qcow2 images (with default 64k block size) on my ssd disk:
t-seq.qcow2 - sequentially written qcow2 image
t-reverse.qcow2 - filled by writing 64k portions from end to the start
t-rand.qcow2 - filled by writing 64k portions (aligned) in random order
t-part-rand.qcow2 - filled by shuffling order of 64k writes in 1m clusters
(see source code of image generation in the end for details)

and the test (sequential io by 1mb chunks):

test write:
    for t in /ssd/t-*; \
        do sync; echo 1 > /proc/sys/vm/drop_caches; echo ===  $t  ===; \
        ./qemu-img bench -c 4096 -d 1 -f qcow2 -n -s 1m -t none -w $t; \
    done

test read (same, just drop -w parameter):
    for t in /ssd/t-*; \
        do sync; echo 1 > /proc/sys/vm/drop_caches; echo ===  $t  ===; \
        ./qemu-img bench -c 4096 -d 1 -f qcow2 -n -s 1m -t none $t; \
    done

short info about parameters:
  -w - do writes (otherwise do reads)
  -c - count of blocks
  -s - block size
  -t none - disable cache
  -n - native aio
  -d 1 - don't use parallel requests provided by qemu-img bench itself

results:
    +-----------+-----------+----------+-----------+----------+
    |   file    | wr before | wr after | rd before | rd after |
    +-----------+-----------+----------+-----------+----------+
    | seq       |     8.605 |    8.636 |     9.043 |    9.010 |
    | reverse   |     9.934 |    8.654 |    17.162 |    8.662 |
    | rand      |     9.983 |    8.687 |    19.775 |    9.010 |
    | part-rand |     9.871 |    8.650 |    14.241 |    8.669 |
    +-----------+-----------+----------+-----------+----------+

Performance gain is obvious, especially for read.

how images are generated:

 === gen-writes file ===
    #!/usr/bin/env python
    import random
    import sys

    size = 4 * 1024 * 1024 * 1024
    block = 64 * 1024
    block2 = 1024 * 1024

    arg = sys.argv[1]

    if arg in ('rand', 'reverse', 'seq'):
        writes = list(range(0, size, block))

    if arg == 'rand':
        random.shuffle(writes)
    elif arg == 'reverse':
        writes.reverse()
    elif arg == 'part-rand':
        writes = []
        for off in range(0, size, block2):
            wr = list(range(off, off + block2, block))
            random.shuffle(wr)
            writes.extend(wr)
    elif arg != 'seq':
        sys.exit(1)

    for w in writes:
        print 'write -P 0xff {} {}'.format(w, block)

    print 'q'


 === gen-test-images.sh file ===
    #!/bin/bash

    IMG_PATH=/ssd

    for name in seq reverse rand part-rand; do
        IMG=$IMG_PATH/t-$name.qcow2
        echo createing $IMG ...
        rm -f $IMG
        qemu-img create -f qcow2 $IMG 4G
        gen-writes $name | qemu-io $IMG
    done

Denis V. Lunev (1):
  qcow2: move qemu_co_mutex_lock below decryption procedure

Vladimir Sementsov-Ogievskiy (6):
  qcow2: bdrv_co_pwritev: move encryption code out of lock
  qcow2: split out reading normal clusters from qcow2_co_preadv
  qcow2: async scheme for qcow2_co_preadv
  qcow2: refactor qcow2_co_pwritev: split out qcow2_co_do_pwritev
  qcow2: refactor qcow2_co_pwritev locals scope
  qcow2: async scheme for qcow2_co_pwritev

 block/qcow2.c                      | 506 +++++++++++++++++++++++++++++--------
 tests/qemu-iotests/026.out         |  18 +-
 tests/qemu-iotests/026.out.nocache |  20 +-
 3 files changed, 415 insertions(+), 129 deletions(-)

-- 
2.11.1
