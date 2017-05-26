Received: from eggs.gnu.org ([2001:4830:134:3::10]:58308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dELki-00048I-P3
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dELkh-0005AN-VF
	for qemu-devel@nongnu.org; Fri, 26 May 2017 16:22:28 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 26 May 2017 22:21:41 +0200
Message-Id: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 00/29] qed: Convert to coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

The qed block driver is one of the last remaining block drivers that use the
AIO callback style interfaces. This series converts it to the coroutine model
that other drivers are using and removes some AIO functions from the block
layer API afterwards.

If this isn't compelling enough, the diffstat should speak for itself.

This series is relatively long, but it consists mostly of mechanical
conversions of one function per patch, so it should be easy to review.

Kevin Wolf (29):
  qed: Use bottom half to resume waiting requests
  qed: Make qed_read_table() synchronous
  qed: Remove callback from qed_read_table()
  qed: Remove callback from qed_read_l2_table()
  qed: Remove callback from qed_find_cluster()
  qed: Make qed_read_backing_file() synchronous
  qed: Make qed_copy_from_backing_file() synchronous
  qed: Remove callback from qed_copy_from_backing_file()
  qed: Make qed_write_header() synchronous
  qed: Remove callback from qed_write_header()
  qed: Make qed_write_table() synchronous
  qed: Remove GenericCB
  qed: Remove callback from qed_write_table()
  qed: Make qed_aio_read_data() synchronous
  qed: Make qed_aio_write_main() synchronous
  qed: Inline qed_commit_l2_update()
  qed: Add return value to qed_aio_write_l1_update()
  qed: Add return value to qed_aio_write_l2_update()
  qed: Add return value to qed_aio_write_main()
  qed: Add return value to qed_aio_write_cow()
  qed: Add return value to qed_aio_write_inplace/alloc()
  qed: Add return value to qed_aio_read/write_data()
  qed: Remove ret argument from qed_aio_next_io()
  qed: Remove recursion in qed_aio_next_io()
  qed: Implement .bdrv_co_readv/writev
  qed: Use CoQueue for serialising allocations
  qed: Simplify request handling
  qed: Use a coroutine for need_check_timer
  block: Remove bdrv_aio_readv/writev_flush()

 block/Makefile.objs   |   2 +-
 block/io.c            | 171 -----------
 block/qed-cluster.c   | 123 ++++----
 block/qed-gencb.c     |  33 ---
 block/qed-table.c     | 261 ++++++-----------
 block/qed.c           | 763 +++++++++++++++++++-------------------------------
 block/qed.h           |  53 +---
 include/block/block.h |   8 -
 8 files changed, 432 insertions(+), 982 deletions(-)
 delete mode 100644 block/qed-gencb.c

-- 
1.8.3.1
