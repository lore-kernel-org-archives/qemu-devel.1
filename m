Received: from eggs.gnu.org ([2001:4830:134:3::10]:37633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dG4r3-000153-NN
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dG4r2-0004uB-QO
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:44:09 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Wed, 31 May 2017 17:43:29 +0300
Message-ID: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] Add reduce image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, pbutsykin@virtuozzo.com

This patch adds the reduction of the image file for qcow2. As a result, this
allows us to reduce the virtual image size and free up space on the disk without
copying the image. Image can be fragmented and reduction is done by punching
holes in the image file.

# ./qemu-img create -f qcow2 -o size=4G image.qcow2
Formatting 'image.qcow2', fmt=qcow2 size=4294967296 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16

# ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
wrote 1073741824/1073741824 bytes at offset 0
1 GiB, 1 ops; 0:00:02.59 (395.180 MiB/sec and 0.3859 ops/sec)

# ./qemu-img resize image.qcow2 128M
Image resized.

# qemu-img info image.qcow2 
image: image.qcow2
file format: qcow2
virtual size: 128M (134217728 bytes)
disk size: 128M
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

# du -h image.qcow2 
129M    image.qcow2

Pavel Butsykin (2):
  qcow2: add reduce image support
  qemu-iotests: add reducing image test in 025

 block/qcow2-cache.c        |  8 +++++
 block/qcow2-cluster.c      | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2-refcount.c     | 65 ++++++++++++++++++++++++++++++++++++
 block/qcow2.c              | 40 ++++++++++++++++------
 block/qcow2.h              |  4 +++
 qapi/block-core.json       |  4 ++-
 tests/qemu-iotests/025     | 19 +++++++++--
 tests/qemu-iotests/025.out | 12 ++++++-
 8 files changed, 221 insertions(+), 14 deletions(-)

-- 
2.11.0
