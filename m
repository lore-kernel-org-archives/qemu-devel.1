Received: from eggs.gnu.org ([2001:4830:134:3::10]:41844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAVy-0008Q6-3M
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fRAVx-0008Dw-A4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:04:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Jun 2018 14:04:11 +0800
Message-Id: <20180608060417.10170-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] mirror: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is the third part of copy offloading work. The first patches are fixes and
improvements in preparation for enabling mirror job. The last patch does a
similar change to the backup patch: it inserts a blk_aio_copy_range call before
the usual bounce buffer code in mirror_iteration.

Fam Zheng (6):
  file-posix: Fix EINTR handling
  block: Check if block drivers can do copy offloading
  block-backend: Refactor AIO emulation
  block-backend: Add blk_aio_copy_range
  block: Add backing passthrough implementations for copy_range
  mirror: Use copy offloading

 block.c                        |  12 ++
 block/block-backend.c          | 247 +++++++++++++++++++++++----------
 block/file-posix.c             |  29 ++--
 block/io.c                     |  27 ++++
 block/iscsi.c                  |   8 ++
 block/mirror.c                 |  71 +++++++++-
 block/qcow2.c                  |  11 ++
 block/raw-format.c             |   6 +
 block/trace-events             |   1 +
 include/block/block_int.h      |  26 ++++
 include/sysemu/block-backend.h |   4 +
 11 files changed, 354 insertions(+), 88 deletions(-)

-- 
2.17.0
