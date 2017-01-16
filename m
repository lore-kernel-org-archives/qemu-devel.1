Received: from eggs.gnu.org ([2001:4830:134:3::10]:41145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VF-0007z3-1i
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cT7VB-0003iK-Qt
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cT7VB-0003iA-L9
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:39:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jan 2017 13:39:00 +0000
Message-Id: <20170116133911.21684-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 00/11] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 2ccede18bd24fce5db83fef3674563a1f256717b:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2017-01-16 12:41:35 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 7d506c90afa47facdb993bc19c15863eef584f1d:

  async: optimize aio_bh_poll (2017-01-16 13:25:18 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Paolo Bonzini (11):
  block: get rid of bdrv_io_unplugged_begin/end
  aio: rename bh_lock to list_lock
  qemu-thread: introduce QemuLockCnt
  aio: make ctx->list_lock a QemuLockCnt, subsuming ctx->walking_bh
  qemu-thread: optimize QemuLockCnt with futexes on Linux
  aio-posix: split aio_dispatch_handlers out of aio_dispatch
  aio: tweak walking in dispatch phase
  aio-posix: remove walking_handlers, protecting AioHandler list with
    list_lock
  aio-win32: remove walking_handlers, protecting AioHandler list with
    list_lock
  aio: document locking
  async: optimize aio_bh_poll

 docs/lockcnt.txt            | 277 +++++++++++++++++++++++++++++++
 docs/multiple-iothreads.txt |  13 +-
 util/Makefile.objs          |   1 +
 include/block/aio.h         |  38 ++---
 include/block/block.h       |   2 -
 include/block/block_int.h   |   3 +-
 include/qemu/futex.h        |  36 ++++
 include/qemu/thread.h       | 112 +++++++++++++
 aio-posix.c                 | 118 +++++++------
 aio-win32.c                 |  83 +++++----
 async.c                     |  45 ++---
 block/io.c                  |  41 +----
 util/lockcnt.c              | 397 ++++++++++++++++++++++++++++++++++++++++++++
 util/qemu-thread-posix.c    |  35 +---
 util/qemu-thread-win32.c    |   2 +-
 util/trace-events           |  10 ++
 16 files changed, 1010 insertions(+), 203 deletions(-)
 create mode 100644 docs/lockcnt.txt
 create mode 100644 include/qemu/futex.h
 create mode 100644 util/lockcnt.c

-- 
2.9.3
