Received: from eggs.gnu.org ([2001:4830:134:3::10]:42055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWl85-0001u7-CJ
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWl81-0004Gu-TM
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:43:29 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 11 Dec 2018 19:43:09 +0300
Message-Id: <20181211164317.32893-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/8] qcow2: encryption threads
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

v2: - multiple cipher inside QCryptoBlock instead of multiple
      blocks inside qcow2, as suggested by Daniel, and it is
      done in separate series
    - use threaded encryption in do_perform_cow_encrypt() too
    - some renaming and refactoring and simplifications
(Sorry for not being very careful about change list, but v1 isn't
 actually reviewed, as approach with multiple blocks was early
 rejected by Denial)

The series now based on two queued for 4.0 series, which, in
turn, may be applied in any order: "crypto threads" (Daniel's
tree), and  "qcow2 decompress in threads", which is now in
Kevin's block-next.

Based-on: <20181207161351.4380-1-vsementsov@virtuozzo.com>
([PATCH v3 0/5] crypto threads)
Based-on: git://repo.or.cz/qemu/kevin.git block-next
(decompress in threads inside)

Final performance gain is illustrated by the following test:
 (note, that in v2 I've dropped iter-time=10, pointed by Daniel)

]# cat test.sh 
#!/bin/bash

size=1G
src=/ssd/src.raw
dst=/ssd/dst.enc.qcow2

# create source for tests
./qemu-img create -f raw "$src" $size > /dev/null
./qemu-io -f raw -c "write -P 0xa 0 $size" "$src" > /dev/null

for w in "" "-W"; do
    echo -e "Test with additional paramter for qemu-img: '$w'"

    # create target
    ./qemu-img create -f qcow2 --object secret,id=sec0,data=test -o encrypt.format=luks,encrypt.key-secret=sec0 "$dst" $size > /dev/null

    time ./qemu-img convert $w -f raw --object secret,id=sec0,data=test --target-image-opts -n "$src" "driver=qcow2,file.filename=$dst,encrypt.key-secret=sec0"
    echo
done


before crypto threads series:
Test with additional paramter for qemu-img: ''

real    0m14.224s
user    0m13.559s
sys     0m0.860s

Test with additional paramter for qemu-img: '-W'

real    0m14.002s
user    0m13.562s
sys     0m1.187s


after crypto threads series:
Test with additional paramter for qemu-img: ''

real    0m14.307s
user    0m13.646s
sys     0m0.859s

Test with additional paramter for qemu-img: '-W'

real    0m14.452s
user    0m13.699s
sys     0m1.112s


and after these series:
Test with additional paramter for qemu-img: ''

real    0m14.367s
user    0m13.722s
sys     0m0.829s

Test with additional paramter for qemu-img: '-W'

real    0m5.641s
user    0m15.692s
sys     0m1.207s

Vladimir Sementsov-Ogievskiy (8):
  qcow2.h: add missing include
  qcow2: add separate file for threaded data processing functions
  qcow2-threads: use thread_pool_submit_co
  qcow2-threads: split out generic path
  qcow2: qcow2_co_preadv: improve locking
  qcow2: qcow2_co_preadv: skip using hd_qiov when possible
  qcow2: bdrv_co_pwritev: move encryption code out of the lock
  qcow2: do encryption in threads

 block/qcow2.h         |  20 ++-
 block/qcow2-cluster.c |   7 +-
 block/qcow2-threads.c | 260 +++++++++++++++++++++++++++++++++++++++
 block/qcow2.c         | 276 ++++++++----------------------------------
 block/Makefile.objs   |   2 +-
 5 files changed, 335 insertions(+), 230 deletions(-)
 create mode 100644 block/qcow2-threads.c

-- 
2.18.0
