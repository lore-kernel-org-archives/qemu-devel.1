Received: from eggs.gnu.org ([2001:4830:134:3::10]:55920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHhB-0002at-5v
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIHh9-0007kC-EI
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:27:53 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  1 Nov 2018 21:27:31 +0300
Message-Id: <20181101182738.70462-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 0/7] qcow2 decompress in threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Hi all!

The series brings threads to qcow2 decompression path, like it is
already done for compression.

Performance gain is illustrated by the following test:

[]# cat gen.sh
#!/bin/bash

echo 'create pattern-file /ssd/t_pat'

./qemu-img create -f raw /ssd/t_pat 10g
for i in {0..9}; do
    ./qemu-io -f raw -c "write -P 0xab ${i}g 1g" /ssd/t_pat
done

echo 'convert it to compressed /ssd/t_pat.compressed.qcow2'

./qemu-img convert -W -f raw -O qcow2 -c /ssd/t_pat /ssd/t_pat.compressed.qcow2
rm -f /ssd/t_pat

test:
[]# time ./qemu-img convert -f qcow2 --target-image-opts -n /ssd/t_pat.compressed.qcow2  'driver=null-co,size=10G'



result before the series:

real    0m16.585s
user    0m14.899s
sys     0m2.219s



result after the series:

real    0m6.528s
user    0m19.343s
sys     0m3.081s


Note: my cpu is 4-cores 8-threads i7-4790

Vladimir Sementsov-Ogievskiy (7):
  qcow2: use Z_OK instead of 0 for deflateInit2 return code check
  qcow2: make more generic interface for qcow2_compress
  qcow2: move decompression from qcow2-cluster.c to qcow2.c
  qcow2: refactor decompress_buffer
  qcow2: use byte-based read in qcow2_decompress_cluster
  qcow2: aio support for compressed cluster read
  qcow2: do decompression in threads

 block/qcow2.h         |   4 -
 block/qcow2-cluster.c |  70 -----------------
 block/qcow2.c         | 169 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 143 insertions(+), 100 deletions(-)

-- 
2.18.0
