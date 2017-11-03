Received: from eggs.gnu.org ([2001:4830:134:3::10]:46068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAcon-0002Kr-2I
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eAcoi-0007v0-1X
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:19:32 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Fri,  3 Nov 2017 16:18:49 +0200
Message-Id: <cover.1509718618.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 0/7] Misc qcow2 corruption checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

This series contains a few checks that prevent QEMU from crashing
under some scenarios with corrupted qcow2 images.

The first patch solves the crash reported here:

  https://bugs.launchpad.net/qemu/+bug/1728615

And the others solve similar crashes that I detected in the process of
fixing this one.

Regards,

Berto

v2:
- Use goto fail in the l2_allocate() check [Max]
- Add check and test case for allocation of compressed clusters [Max]
- Add test case for header.refcount_table_offset == 0
- Add overlap checks to qcow2_crypto_hdr_init_func() [Max]

v1: https://lists.gnu.org/archive/html/qemu-block/2017-11/msg00010.html
- Initial version

Output of backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/7:[----] [--] 'qcow2: Prevent allocating refcount blocks at offset 0'
002/7:[0003] [FC] 'qcow2: Prevent allocating L2 tables at offset 0'
003/7:[down] 'qcow2: Prevent allocating compressed clusters at offset 0'
004/7:[----] [-C] 'qcow2: Don't open images with header.refcount_table_clusters == 0'
005/7:[down] 'qcow2: Add iotest for an image with header.refcount_table_offset == 0'
006/7:[----] [--] 'qcow2: Add iotest for an empty refcount table'
007/7:[down] 'qcow2: Assert that the crypto header does not overlap other metadata'

Alberto Garcia (7):
  qcow2: Prevent allocating refcount blocks at offset 0
  qcow2: Prevent allocating L2 tables at offset 0
  qcow2: Prevent allocating compressed clusters at offset 0
  qcow2: Don't open images with header.refcount_table_clusters == 0
  qcow2: Add iotest for an image with header.refcount_table_offset == 0
  qcow2: Add iotest for an empty refcount table
  qcow2: Assert that the crypto header does not overlap other metadata

 block/qcow2-cluster.c      |  8 ++++++++
 block/qcow2-refcount.c     | 15 +++++++++++++-
 block/qcow2.c              |  7 +++++++
 tests/qemu-iotests/060     | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/060.out | 39 ++++++++++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+), 1 deletion(-)

-- 
2.11.0
