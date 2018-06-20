Received: from eggs.gnu.org ([2001:4830:134:3::10]:49274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVePe-000109-HL
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVePd-0004zj-On
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:48:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Jun 2018 17:48:34 +0300
Message-Id: <20180620144837.19341-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qcow2 compress threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, stefanha@gmail.com, pl@kamp.de, den@openvz.org, vsementsov@virtuozzo.com

Hi all!

Here are compress threads for qcow2, to increase performance of
compressed writes.

v2 changes:

02: fix typo in commit msg
    keep "qemu/osdep.h" to be the first included header,
    fix comment style

===========

I've created the following test:

[]# cat ../gen.sh 
#!/bin/bash

echo 'create pattern-file t_pat'

./qemu-img create -f raw t_pat 1000m
./qemu-io -c 'write -P 0xab 0 1000m' t_pat

echo 'create randod t_rand'

dd if=/dev/urandom of=t_rand bs=1M count=1000

[]# cat ../test.sh 
#!/bin/bash

rm -f t_out

echo 'test pattern-file compression'

time ./qemu-img convert -W -f raw -O qcow2 -c t_pat t_out

rm -f t_out

echo 'test random-file compression'

time ./qemu-img convert -W -f raw -O qcow2 -c t_rand t_out

rm -f t_out


and results before the series (and without -W flag):

test pattern-file compression

real    0m16.658s
user    0m16.450s
sys     0m0.628s
test random-file compression

real    0m24.194s
user    0m24.361s
sys     0m0.395s

results with -W flag, after first patch:

test pattern-file compression

real    0m16.242s
user    0m16.895s
sys     0m0.080s
test random-file compression

real    0m23.450s
user    0m23.767s
sys     0m1.085s

results with -W flag, after third patch:

test pattern-file compression

real    0m5.747s
user    0m22.637s
sys     0m0.393s
test random-file compression

real    0m8.402s
user    0m33.315s
sys     0m0.926s

So, we see significant performance gain. But this of course don't work
without -W flag.

results without -W flag, after third patch:

test pattern-file compression

real    0m16.908s
user    0m16.775s
sys     0m0.589s
test random-file compression

real    0m24.913s
user    0m24.586s
sys     0m0.898s

Note: my cpu is 4-cores 8-threads i7-4790

Vladimir Sementsov-Ogievskiy (3):
  qemu-img: allow compressed not-in-order writes
  qcow2: refactor data compression
  qcow2: add compress threads

 block/qcow2.h |   3 ++
 block/qcow2.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++------------
 qemu-img.c    |   5 ---
 3 files changed, 112 insertions(+), 32 deletions(-)

-- 
2.11.1
