Received: from eggs.gnu.org ([2001:4830:134:3::10]:49192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fW338-0000pa-Oz
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fW337-000678-TE
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:07:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 21 Jun 2018 19:06:55 +0200
Message-Id: <20180621170657.27542-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] file-posix: Make truncate/preallocate
 asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This fixes the problem that blockdev-create on a local file blocks the
main loop despite being a background job. This was caused by file-posix
preallocating the image with blocking syscalls rather than moving this
to the thread pool and yielding the coroutine meanwhile.

Kevin Wolf (2):
  block: Convert .bdrv_truncate callback to coroutine_fn
  file-posix: Make .bdrv_co_truncate asynchronous

 include/block/block.h     |   4 +
 include/block/block_int.h |   4 +-
 include/block/raw-aio.h   |   4 +-
 block.c                   |  49 +++++++-
 block/copy-on-read.c      |   8 +-
 block/crypto.c            |   9 +-
 block/file-posix.c        | 277 ++++++++++++++++++++++++++--------------------
 block/file-win32.c        |   6 +-
 block/gluster.c           |  14 ++-
 block/iscsi.c             |   8 +-
 block/nfs.c               |   7 +-
 block/qcow2.c             |  14 +--
 block/qed.c               |   8 +-
 block/raw-format.c        |   8 +-
 block/rbd.c               |   8 +-
 block/sheepdog.c          |  12 +-
 block/ssh.c               |   6 +-
 17 files changed, 267 insertions(+), 179 deletions(-)

-- 
2.13.6
