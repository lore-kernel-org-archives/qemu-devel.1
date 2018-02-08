Received: from eggs.gnu.org ([2001:4830:134:3::10]:49376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ejpqF-0007oS-Uo
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ejpqA-0003eg-7W
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:18:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ejpqA-0003Z6-2f
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:18:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  8 Feb 2018 17:18:04 +0000
Message-Id: <20180208171807.24267-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] block: fix blk_aio_*() segfault when
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, mark.kanda@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>

Using bdrv_inc_in_flight(blk_bs(blk)) doesn't work since BlockBackend->root may
be NULL.

This patch series solves the issue by adding an BlockBackend->in_flight counter
so requests can be tracked even when there is no BlockDriverState.

This should fix the IDE and virtio-blk segfaults that have been encountered
when there is no BlockDriverState.

The patch is based on work by Kevin Wolf.

Kevin Wolf (1):
  block: test blk_aio_flush() with blk->root == NULL

Stefan Hajnoczi (2):
  block: add BlockBackend->in_flight counter
  Revert "IDE: Do not flush empty CDROM drives"

 tests/Makefile.include     |  2 ++
 block.c                    |  2 +-
 block/block-backend.c      | 59 +++++++++++++++++++++++++++++----
 hw/ide/core.c              | 10 +-----
 tests/test-block-backend.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 17 deletions(-)
 create mode 100644 tests/test-block-backend.c

-- 
2.14.3
