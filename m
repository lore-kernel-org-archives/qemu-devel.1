Received: from eggs.gnu.org ([2001:4830:134:3::10]:59208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emjDZ-0002fm-12
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1emjDY-0001NI-AJ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:50:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1emjDY-0001Mq-2B
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:50:36 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 16 Feb 2018 16:50:10 +0000
Message-Id: <20180216165015.30715-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/5] block: fix blk_aio_*() segfault when
 blk->root == NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, mark.kanda@oracle.com, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v3:
 * Add Patch 1 to rename aio_context_in_iothread() to
   in_aio_context_home_thread() [Eric]
v2:
 * Introduce AIO_WAIT_WHILE() since aio_poll(ctx, true) is not allowed [Paolo]

Using bdrv_inc_in_flight(blk_bs(blk)) doesn't work since BlockBackend->root may
be NULL.

This patch series solves the issue by adding an BlockBackend->in_flight counter
so requests can be tracked even when there is no BlockDriverState.

This should fix the IDE and virtio-blk segfaults that have been encountered
when there is no BlockDriverState.

The patch is based on work by Kevin Wolf.

Kevin Wolf (1):
  block: test blk_aio_flush() with blk->root == NULL

Stefan Hajnoczi (4):
  aio: rename aio_context_in_iothread() to in_aio_context_home_thread()
  block: extract AIO_WAIT_WHILE() from BlockDriverState
  block: add BlockBackend->in_flight counter
  Revert "IDE: Do not flush empty CDROM drives"

 tests/Makefile.include     |   2 +
 util/Makefile.objs         |   2 +-
 include/block/aio-wait.h   | 116 +++++++++++++++++++++++++++++++++++++++++++++
 include/block/aio.h        |   7 ++-
 include/block/block.h      |  40 +++-------------
 include/block/block_int.h  |   7 ++-
 block.c                    |   7 ++-
 block/block-backend.c      |  60 ++++++++++++++++++++---
 block/io.c                 |  10 +---
 hw/ide/core.c              |  10 +---
 tests/test-block-backend.c |  82 ++++++++++++++++++++++++++++++++
 util/aio-wait.c            |  40 ++++++++++++++++
 12 files changed, 318 insertions(+), 65 deletions(-)
 create mode 100644 include/block/aio-wait.h
 create mode 100644 tests/test-block-backend.c
 create mode 100644 util/aio-wait.c

-- 
2.14.3
