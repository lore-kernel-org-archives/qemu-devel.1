Received: from eggs.gnu.org ([2001:4830:134:3::10]:38500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg93q-0006D3-E8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg93o-0005Nl-5N
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:56:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cg93n-0005NP-Te
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:56:48 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Feb 2017 11:56:20 +0000
Message-Id: <20170221115644.28264-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 00/24] Block patches
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

The following changes since commit 56f9e46b841c7be478ca038d8d4085d776ab4b0d:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-02-20' into staging (2017-02-20 17:42:47 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to a7b91d35bab97a2d3e779d0c64c9b837b52a6cf7:

  coroutine-lock: make CoRwlock thread-safe and fair (2017-02-21 11:39:40 +0000)

----------------------------------------------------------------
Pull request

v2:
 * Rebased to resolve scsi conflicts

----------------------------------------------------------------

Paolo Bonzini (24):
  block: move AioContext, QEMUTimer, main-loop to libqemuutil
  aio: introduce aio_co_schedule and aio_co_wake
  block-backend: allow blk_prw from coroutine context
  test-thread-pool: use generic AioContext infrastructure
  io: add methods to set I/O handlers on AioContext
  io: make qio_channel_yield aware of AioContexts
  nbd: convert to use qio_channel_yield
  coroutine-lock: reschedule coroutine on the AioContext it was running
    on
  blkdebug: reschedule coroutine on the AioContext it is running on
  qed: introduce qed_aio_start_io and qed_aio_next_io_cb
  aio: push aio_context_acquire/release down to dispatching
  block: explicitly acquire aiocontext in timers that need it
  block: explicitly acquire aiocontext in callbacks that need it
  block: explicitly acquire aiocontext in bottom halves that need it
  block: explicitly acquire aiocontext in aio callbacks that need it
  aio-posix: partially inline aio_dispatch into aio_poll
  async: remove unnecessary inc/dec pairs
  block: document fields protected by AioContext lock
  coroutine-lock: make CoMutex thread-safe
  coroutine-lock: add limited spinning to CoMutex
  test-aio-multithread: add performance comparison with thread-based
    mutexes
  coroutine-lock: place CoMutex before CoQueue in header
  coroutine-lock: add mutex argument to CoQueue APIs
  coroutine-lock: make CoRwlock thread-safe and fair

 Makefile.objs                       |   4 -
 stubs/Makefile.objs                 |   1 +
 tests/Makefile.include              |  19 +-
 util/Makefile.objs                  |   6 +-
 block/nbd-client.h                  |   2 +-
 block/qed.h                         |   3 +
 include/block/aio.h                 |  38 ++-
 include/block/block_int.h           |  64 +++--
 include/io/channel.h                |  72 +++++-
 include/qemu/coroutine.h            |  84 ++++---
 include/qemu/coroutine_int.h        |  11 +-
 include/sysemu/block-backend.h      |  14 +-
 tests/iothread.h                    |  25 ++
 block/backup.c                      |   2 +-
 block/blkdebug.c                    |   9 +-
 block/blkreplay.c                   |   2 +-
 block/block-backend.c               |  13 +-
 block/curl.c                        |  44 +++-
 block/gluster.c                     |   9 +-
 block/io.c                          |  42 +---
 block/iscsi.c                       |  15 +-
 block/linux-aio.c                   |  10 +-
 block/mirror.c                      |  12 +-
 block/nbd-client.c                  | 119 +++++----
 block/nfs.c                         |   9 +-
 block/qcow2-cluster.c               |   4 +-
 block/qed-cluster.c                 |   2 +
 block/qed-table.c                   |  12 +-
 block/qed.c                         |  58 +++--
 block/sheepdog.c                    |  31 +--
 block/ssh.c                         |  29 +--
 block/throttle-groups.c             |   4 +-
 block/win32-aio.c                   |   9 +-
 dma-helpers.c                       |   2 +
 hw/9pfs/9p.c                        |   2 +-
 hw/block/virtio-blk.c               |  19 +-
 hw/scsi/scsi-bus.c                  |   2 +
 hw/scsi/scsi-disk.c                 |  15 ++
 hw/scsi/scsi-generic.c              |  20 +-
 hw/scsi/virtio-scsi.c               |   7 +
 io/channel-command.c                |  13 +
 io/channel-file.c                   |  11 +
 io/channel-socket.c                 |  16 +-
 io/channel-tls.c                    |  12 +
 io/channel-watch.c                  |   6 +
 io/channel.c                        |  97 ++++++--
 nbd/client.c                        |   2 +-
 nbd/common.c                        |   9 +-
 nbd/server.c                        |  94 +++-----
 stubs/linux-aio.c                   |  32 +++
 stubs/set-fd-handler.c              |  11 -
 tests/iothread.c                    |  91 +++++++
 tests/test-aio-multithread.c        | 463 ++++++++++++++++++++++++++++++++++++
 tests/test-thread-pool.c            |  12 +-
 aio-posix.c => util/aio-posix.c     |  62 ++---
 aio-win32.c => util/aio-win32.c     |  30 +--
 util/aiocb.c                        |  55 +++++
 async.c => util/async.c             |  84 ++++++-
 iohandler.c => util/iohandler.c     |   0
 main-loop.c => util/main-loop.c     |   0
 util/qemu-coroutine-lock.c          | 254 ++++++++++++++++++--
 util/qemu-coroutine-sleep.c         |   2 +-
 util/qemu-coroutine.c               |   8 +
 qemu-timer.c => util/qemu-timer.c   |   0
 thread-pool.c => util/thread-pool.c |   8 +-
 trace-events                        |  11 -
 util/trace-events                   |  17 +-
 67 files changed, 1712 insertions(+), 533 deletions(-)
 create mode 100644 tests/iothread.h
 create mode 100644 stubs/linux-aio.c
 create mode 100644 tests/iothread.c
 create mode 100644 tests/test-aio-multithread.c
 rename aio-posix.c => util/aio-posix.c (94%)
 rename aio-win32.c => util/aio-win32.c (95%)
 create mode 100644 util/aiocb.c
 rename async.c => util/async.c (82%)
 rename iohandler.c => util/iohandler.c (100%)
 rename main-loop.c => util/main-loop.c (100%)
 rename qemu-timer.c => util/qemu-timer.c (100%)
 rename thread-pool.c => util/thread-pool.c (97%)

-- 
2.9.3
