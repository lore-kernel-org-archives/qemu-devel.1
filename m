Received: from eggs.gnu.org ([2001:4830:134:3::10]:42921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXotm-0001si-64
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fXoti-00033P-2A
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:24:49 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 26 Jun 2018 16:24:28 +0200
Message-Id: <20180626142434.22090-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] file-posix: Make truncate/preallocate
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
Cc: kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

This fixes the problem that blockdev-create on a local file blocks the
main loop despite being a background job. This was caused by file-posix
preallocating the image with blocking syscalls rather than moving this
to the thread pool and yielding the coroutine meanwhile.

v2:
- Add locking to qcow2_co_discard()
- Extra qcow2 fix and cleanup related to the locking code
- Use tracked requests infrastructure for serialising I/O requests
  against truncate in newly allocated areas

Kevin Wolf (6):
  qcow2: Fix qcow2_truncate() error return value
  block: Convert .bdrv_truncate callback to coroutine_fn
  qcow2: Remove coroutine trampoline for preallocate_co()
  block: Move bdrv_truncate() implementation to io.c
  block: Use tracked request for truncate
  file-posix: Make .bdrv_co_truncate asynchronous

 include/block/block.h     |   4 +
 include/block/block_int.h |   7 +-
 include/block/raw-aio.h   |   4 +-
 block.c                   |  64 +----------
 block/copy-on-read.c      |   8 +-
 block/crypto.c            |   9 +-
 block/file-posix.c        | 277 ++++++++++++++++++++++++++--------------------
 block/file-win32.c        |   6 +-
 block/gluster.c           |  14 ++-
 block/io.c                | 134 ++++++++++++++++++++++
 block/iscsi.c             |   8 +-
 block/nfs.c               |   7 +-
 block/qcow2.c             | 124 +++++++++------------
 block/qed.c               |   8 +-
 block/raw-format.c        |   8 +-
 block/rbd.c               |   8 +-
 block/sheepdog.c          |  12 +-
 block/ssh.c               |   6 +-
 18 files changed, 405 insertions(+), 303 deletions(-)

-- 
2.13.6
