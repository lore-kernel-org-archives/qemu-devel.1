Received: from eggs.gnu.org ([209.51.188.92]:44207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtCpE-00017i-BS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:44:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtCpA-0000Yj-Fb
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:44:46 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 17:44:12 +0300
Message-Id: <20190211144421.106232-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 0/9] qcow2: encryption threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, berrange@redhat.com

Hi all!

The series brings threads to qcow2 encryption/decryption path,
like it is already done for compression.

v4:
add r-b's to most of patches
04: add r-b by Alberto and Paolo.
    Paolo asked to add some information to the commit message.
    I don't have good understanding of moving from
    "AioContext lock usage" to other locks, so I just added
    "Drop dependence on AioContext lock.", not being sure that
    it is correct or make sense. And, in the same time take both
    r-b's. So, hope maintainers will adjust commit message if
    needed.
06: add r-b by Alberto
    drop comment 'No sense in releasing the lock' [Alberto]


v3:
01: drop 'include block_int.h' lines not needed more [Alberto]
02: fix comments style (open/close on separate line), add Alberto's r-b
03: improve commit message, add Alberto's r-b
04: new, follows Paolo's comment


v2: (not very careful change list)
    - multiple cipher inside QCryptoBlock instead of multiple
      blocks inside qcow2, as suggested by Daniel, and it is
      done in separate series
    - use threaded encryption in do_perform_cow_encrypt() too
    - some renaming and refactoring and simplifications


== Performance testing (not updated for v4, as there are no actual changes) ==

Hmm, do we have something like tests/qemu-iotests, but for performance?

[root@kvm up-qcow2-encrypt-threads]# cat test.sh 
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


before the series:
    Test with additional paramter for qemu-img: ''

    real    0m14.318s
    user    0m13.637s
    sys     0m0.881s

    Test with additional paramter for qemu-img: '-W'

    real    0m13.962s
    user    0m13.681s
    sys     0m1.156s


after the series:
    Test with additional paramter for qemu-img: ''

    real    0m14.382s
    user    0m13.735s
    sys     0m0.835s

    Test with additional paramter for qemu-img: '-W'

    real    0m5.696s
    user    0m15.931s
    sys     0m1.144s

Vladimir Sementsov-Ogievskiy (9):
  qcow2.h: add missing include
  qcow2: add separate file for threaded data processing functions
  qcow2-threads: use thread_pool_submit_co
  qcow2-threads: qcow2_co_do_compress: protect queuing by mutex
  qcow2-threads: split out generic path
  qcow2: qcow2_co_preadv: improve locking
  qcow2: qcow2_co_preadv: skip using hd_qiov when possible
  qcow2: bdrv_co_pwritev: move encryption code out of the lock
  qcow2: do encryption in threads

 block/qcow2.h          |  20 ++-
 block/qcow2-bitmap.c   |   1 -
 block/qcow2-cache.c    |   1 -
 block/qcow2-cluster.c  |   8 +-
 block/qcow2-refcount.c |   1 -
 block/qcow2-snapshot.c |   1 -
 block/qcow2-threads.c  | 268 +++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          | 275 ++++++++---------------------------------
 block/Makefile.objs    |   2 +-
 9 files changed, 341 insertions(+), 236 deletions(-)
 create mode 100644 block/qcow2-threads.c

-- 
2.18.0
