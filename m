Received: from eggs.gnu.org ([2001:4830:134:3::10]:54792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFxQ-00015j-9N
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFxP-0003tN-FA
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:31:20 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 21:31:06 +0100
Message-Id: <20171110203111.7666-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 0/5] qcow2: Fixes for corrupted images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

This series contains fixes for another batch of qcow2-related crashes
reported on Launchpad by Nageswara (the first batch was
http://lists.nongnu.org/archive/html/qemu-block/2017-11/msg00082.html by
Berto).

Patch 4 fixes an out-of-bounds array access in memory which is not
really a security issue for multiple reasons (really, at most you can
read eight bytes from somewhere with an extremely high chance of
crashing qemu and requiring the user to invoke a block_resize shrinking
the qcow2 image (and also reset some bit in the image from 1 to 0, but
only if the overlap checks don't catch you)), but most importantly that
code hasn't been in 2.10, so we're fine.


Max Reitz (5):
  qcow2: check_errors are fatal
  qcow2: Unaligned zero cluster in handle_alloc()
  block: Guard against NULL bs->drv
  qcow2: Add bounds check to get_refblock_offset()
  qcow2: Refuse to get unaligned offsets from cache

 block/qcow2.h              |   6 ---
 block.c                    |  19 ++++++-
 block/io.c                 |  36 +++++++++++++
 block/qapi.c               |   8 ++-
 block/qcow2-cache.c        |  21 ++++++++
 block/qcow2-cluster.c      |  13 ++++-
 block/qcow2-refcount.c     |  26 +++++++++-
 block/qcow2.c              |   5 +-
 block/replication.c        |  15 ++++++
 block/vvfat.c              |   2 +-
 tests/qemu-iotests/060     | 125 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/060.out | 115 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 379 insertions(+), 12 deletions(-)

-- 
2.13.6
