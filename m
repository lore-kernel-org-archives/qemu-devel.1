Received: from eggs.gnu.org ([2001:4830:134:3::10]:48858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dTUHi-000131-57
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dTUHg-0007WY-Us
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:31:06 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri,  7 Jul 2017 17:30:24 +0300
Message-Id: <20170707143028.692-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/4] Add shrink image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org, pbutsykin@virtuozzo.com

This patch add shrinking of the image file for qcow2. As a result, this allows
us to reduce the virtual image size and free up space on the disk without
copying the image. Image can be fragmented and shrink is done by punching holes
in the image file.

# ./qemu-img create -f qcow2 image.qcow2 4G
Formatting 'image.qcow2', fmt=qcow2 size=4294967296 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16

# ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
wrote 1073741824/1073741824 bytes at offset 0
1 GiB, 1 ops; 0:00:04.59 (222.886 MiB/sec and 0.2177 ops/sec)

# ./qemu-img resize image.qcow2 512M
qemu-img: Warning: Shrinking an image will delete all data beyondthe shrunken image's end. Before performing such anoperation, make sure there is no important data there.
qemu-img: Use the --shrink option to perform a shrink operation.

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

# du -h image.qcow2 
129M    image.qcow2

Changes from v1:
- add --shrink flag for qemu-img resize
- add qcow2_cache_discard
- simplify qcow2_shrink_l1_table() to reduce the likelihood of image corruption
- add new qemu-iotests for shrinking images

Changes from v2:
- replace qprintf() on error_report() (1)
- rewrite warning messages (1)
- enforce --shrink flag for all formats except raw (1)
- split qcow2_cache_discard() (2)
- minor fixes according to comments (3)
- rewrite the last part of qcow2_shrink_reftable() to avoid
  qcow2_free_clusters() calls inside (3)
- improve test for shrinking image (4)

Pavel Butsykin (4):
  qemu-img: add --shrink flag for resize
  qcow2: add qcow2_cache_discard
  qcow2: add shrink image support
  qemu-iotests: add shrinking image test

 block/qcow2-cache.c        |  26 +++++++
 block/qcow2-cluster.c      |  40 +++++++++++
 block/qcow2-refcount.c     | 117 +++++++++++++++++++++++++++++++
 block/qcow2.c              |  42 ++++++++---
 block/qcow2.h              |  17 +++++
 qapi/block-core.json       |   3 +-
 qemu-img-cmds.hx           |   4 +-
 qemu-img.c                 |  23 ++++++
 qemu-img.texi              |   7 +-
 tests/qemu-iotests/102     |   4 +-
 tests/qemu-iotests/163     | 170 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/163.out |   5 ++
 tests/qemu-iotests/group   |   1 +
 13 files changed, 443 insertions(+), 16 deletions(-)
 create mode 100644 tests/qemu-iotests/163
 create mode 100644 tests/qemu-iotests/163.out

-- 
2.13.0
