Received: from eggs.gnu.org ([2001:4830:134:3::10]:60539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dKklx-0000mC-1R
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dKklv-0006zl-WE
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 08:18:13 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Tue, 13 Jun 2017 15:16:35 +0300
Message-Id: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/4] Add shrink image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, pbutsykin@virtuozzo.com, den@openvz.org

This patch add shrinking of the image file for qcow2. As a result, this allows
us to reduce the virtual image size and free up space on the disk without
copying the image. Image can be fragmented and shrink is done by punching holes
in the image file.

# ./qemu-img create -f qcow2 -o size=4G image.qcow2
Formatting 'image.qcow2', fmt=qcow2 size=4294967296 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16

# ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
wrote 1073741824/1073741824 bytes at offset 0
1 GiB, 1 ops; 0:00:02.59 (395.180 MiB/sec and 0.3859 ops/sec)

# ./qemu-img resize image.qcow2 512M
Warning: shrinking of the image can lead to data loss. Before performing shrink operation you must make sure that the shrink part of image doesn't contain important data.
If you don't want to see this message use --shrink option.
Image resized.

# ./qemu-img resize --shrink image.qcow2 128M
Image resized.

# ./qemu-img info image.qcow2
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

# du -h ./image.qcow2 
129M    ./image.qcow2

Changes from v1:
- add --shrink flag for qemu-img resize
- add qcow2_cache_discard
- simplify qcow2_shrink_l1_table() to reduce the likelihood of image corruption
- add new qemu-iotests for shrinking images

Pavel Butsykin (4):
  qemu-img: add --shrink flag for resize
  qcow2: add qcow2_cache_discard
  qcow2: add shrink image support
  qemu-iotests: add shrinking image test

 block/qcow2-cache.c        |  21 +++++++++
 block/qcow2-cluster.c      |  42 +++++++++++++++++
 block/qcow2-refcount.c     |  70 ++++++++++++++++++++++++++++
 block/qcow2.c              |  40 ++++++++++++----
 block/qcow2.h              |   3 ++
 qapi/block-core.json       |   3 +-
 qemu-img-cmds.hx           |   4 +-
 qemu-img.c                 |  15 ++++++
 qemu-img.texi              |   5 +-
 tests/qemu-iotests/102     |   4 +-
 tests/qemu-iotests/163     | 113 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/163.out |   5 ++
 tests/qemu-iotests/group   |   1 +
 13 files changed, 310 insertions(+), 16 deletions(-)
 create mode 100644 tests/qemu-iotests/163
 create mode 100644 tests/qemu-iotests/163.out

-- 
2.13.0
