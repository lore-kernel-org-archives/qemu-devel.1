Received: from eggs.gnu.org ([2001:4830:134:3::10]:34887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEjm-00088n-7G
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEje-0002Cf-Kl
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:25 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Nov 2018 19:55:00 +0300
Message-Id: <20181123165511.416480-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 00/11] qcow2: encryption threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berrange@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all!

The series brings threads to qcow2 encryption/decryption path,
like it is already done for compression.

Based-on: Kevin's block-next branch [d3db1496c5]

Performance gain is illustrated by the following test:

]# cat test.sh 
#!/bin/bash

size=1G
src=/ssd/src.raw
dst=/ssd/dst.enc.qcow2

echo create source for tests
./qemu-img create -f raw "$src" $size
./qemu-io -f raw -c "write -P 0xa 0 $size" "$src"

for w in "" "-W"; do
    echo -e "\n\nTest with additional paramter for qemu-img: '$w'\n"

    echo create target...
    ./qemu-img create -f qcow2 --object secret,id=sec0,data=test -o encrypt.format=luks,encrypt.key-secret=sec0,encrypt.iter-time=10 "$dst" $size
    echo

    echo test...
    time ./qemu-img convert $w -f raw --object secret,id=sec0,data=test --target-image-opts -n "$src" "driver=qcow2,file.filename=$dst,encrypt.key-secret=sec0"
done



before patches:

]# ./test.sh 
create source for tests
Formatting '/ssd/src.raw', fmt=raw size=1073741824
wrote 1073741824/1073741824 bytes at offset 0
1 GiB, 1 ops; 0:00:03.02 (338.734 MiB/sec and 0.3308 ops/sec)


Test with additional paramter for qemu-img: ''

create target...
Formatting '/ssd/dst.enc.qcow2', fmt=qcow2 size=1073741824 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 cluster_size=65536 lazy_refcounts=off refcount_bits=16

test...

real    0m12.014s
user    0m11.299s
sys     0m0.928s


Test with additional paramter for qemu-img: '-W'

create target...
Formatting '/ssd/dst.enc.qcow2', fmt=qcow2 size=1073741824 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 cluster_size=65536 lazy_refcounts=off refcount_bits=16

test...

real    0m11.639s
user    0m11.324s
sys     0m1.149s



after patches:

]# ./test.sh 
create source for tests
Formatting '/ssd/src.raw', fmt=raw size=1073741824
wrote 1073741824/1073741824 bytes at offset 0
1 GiB, 1 ops; 0:00:02.63 (388.900 MiB/sec and 0.3798 ops/sec)


Test with additional paramter for qemu-img: ''

create target...
Formatting '/ssd/dst.enc.qcow2', fmt=qcow2 size=1073741824 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 cluster_size=65536 lazy_refcounts=off refcount_bits=16

test...

real    0m12.113s
user    0m11.433s
sys     0m0.878s


Test with additional paramter for qemu-img: '-W'

create target...
Formatting '/ssd/dst.enc.qcow2', fmt=qcow2 size=1073741824 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10 cluster_size=65536 lazy_refcounts=off refcount_bits=16

test...

real    0m3.436s
user    0m13.429s
sys     0m1.183s


Vladimir Sementsov-Ogievskiy (11):
  qcow2.h: add missing include
  qcow2: add separate file for threaded data processing functions
  qcow2-threads: use thread_pool_submit_co
  qcow2: split out data processing threads state from BDRVQcow2State
  qcow2-threads: split out generic path
  qcow2-threads: add per-thread data
  qcow2-threads: add encryption
  qcow2: bdrv_co_preadv: improve locking
  qcow2: qcow2_co_preadv: skip using hd_qiov when possible
  qcow2: bdrv_co_pwritev: move encryption code out of the lock
  qcow2: do encryption in threads

 block/qcow2.h         |  34 ++++-
 block/qcow2-threads.c | 281 ++++++++++++++++++++++++++++++++++++
 block/qcow2.c         | 328 +++++++++++++-----------------------------
 block/Makefile.objs   |   2 +-
 4 files changed, 412 insertions(+), 233 deletions(-)
 create mode 100644 block/qcow2-threads.c

-- 
2.18.0
