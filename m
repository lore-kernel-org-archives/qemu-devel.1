Received: from eggs.gnu.org ([2001:4830:134:3::10]:44493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwOY-00017Q-Qk
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 15:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwOV-0004HY-PB
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 15:48:18 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cXwOV-0004HS-Ip
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 15:48:15 -0500
Received: by mail-qk0-x242.google.com with SMTP id u25so16148508qki.2
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 12:48:15 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b9d9743-c482-1c99-b284-17c42b1383e1@redhat.com>
Date: Sun, 29 Jan 2017 21:48:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170120164322.21851-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/17] aio_context_acquire/release pushdown, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com



On 20/01/2017 17:43, Paolo Bonzini wrote:
> This series pushes down aio_context_acquire/release to the point
> where we can actually reason on using different fine-grained mutexes.
> 
> The main infrastructure is introduced in patch 1.  The new API aio_co_wake
> starts a coroutine with aio_context_acquire/release protection, which
> requires tracking each coroutine's "home" AioContext.  aio_co_schedule
> instead takes care of moving a sleeping coroutine to a different
> AioContext, also ensuring that it runs under aio_context_acquire/release.
> This is useful to implement bdrv_set_aio_context, as a simpler alternative
> to bottom halves.  Even though one-shot BHs are already simpler than
> what we had before, after this patch aio_co_wake and aio_co_schedule
> save you from having to do aio_context_acquire/release explicitly.
> 
> After patch 2 to 4, which are just small preparatory changes, patches
> 5 to 8 provide an example of how to use the new API.  In particular patch
> 5 to 7 implement a new organization of coroutines in the NBD client,
> which allows not blocking on partial reply header reads.
> 
> Patch 9 introduces helpers for AioContext locking in QED, which is
> the most complex AIO-based driver left.  Then the actual meat of the
> series runs from patch 10 to patch 14, followed by small optimizations
> in patches 15 and 16.
> 
> The patches do some back and forth in adding/removing
> aio_context_acquire/release calls in block/*.c but ultimately a small
> number of aio_context_acquire/release pairs are added after the pushdown.
> These are mostly in drivers that use external libraries (and actually
> they could already be replaced by QemuMutex) and in device models
> that support multithreaded operation (aka iothread aka dataplane).
> 
> Notably, coroutines need not care about aio_context_acquire/release.
> The device models ensure that the first creation of the coroutine has
> the AioContext, while aio_co_wake/aio_co_schedule do the same after
> they yield.  Therefore, most of the files only need to use those two
> functions instead of, respectively, qemu_coroutine_enter and
> aio_bh_schedule_oneshot.
> 
> However, this is only an intermediate step which is needed because the
> block layer and qemu-coroutine locks are thread-unsafe.  So the next
> part will add separate locking, independent of AioContext, to block.c and
> mostly block/io.c---this includes making CoMutex thread-safe.  Patch 17
> therefore already documents the current locking policies block.h to
> prepare for the next series.
> 
> Paolo
> 
> v1->v2:
>         new patch (4) removing block-obj-y -> io-obj-y dependency
>         removed QIOChannelRestart from
>                 "io: add methods to set I/O handlers on AioContext"
>         improved qio_channel_set_aio_context docs, renamed to
>                 qio_channel_attach_aio_context
>         fixed pasto in "io: make qio_channel_yield aware of AioContexts"
>         document restrictions in bdrv_aio_cancel due to qemu_aio_ref
>         converted NBD server to qio_channel_yield too
>         allow NULL s->read_reply_co
>         
> *** BLURB HERE ***
> 
> Paolo Bonzini (17):
>   aio: introduce aio_co_schedule and aio_co_wake
>   block-backend: allow blk_prw from coroutine context
>   test-thread-pool: use generic AioContext infrastructure
>   block: move AioContext and QEMUTimer to libqemuutil
>   io: add methods to set I/O handlers on AioContext
>   io: make qio_channel_yield aware of AioContexts
>   nbd: convert to use qio_channel_yield
>   coroutine-lock: reschedule coroutine on the AioContext it was running
>     on
>   qed: introduce qed_aio_start_io and qed_aio_next_io_cb
>   aio: push aio_context_acquire/release down to dispatching
>   block: explicitly acquire aiocontext in timers that need it
>   block: explicitly acquire aiocontext in callbacks that need it
>   block: explicitly acquire aiocontext in bottom halves that need it
>   block: explicitly acquire aiocontext in aio callbacks that need it
>   aio-posix: partially inline aio_dispatch into aio_poll
>   async: remove unnecessary inc/dec pairs
>   block: document fields protected by AioContext lock
> 
>  Makefile.objs                       |   5 +-
>  block/blkdebug.c                    |   9 +-
>  block/blkreplay.c                   |   2 +-
>  block/block-backend.c               |  13 ++-
>  block/curl.c                        |  44 ++++++--
>  block/gluster.c                     |   9 +-
>  block/io.c                          |  38 ++-----
>  block/iscsi.c                       |  15 ++-
>  block/linux-aio.c                   |  10 +-
>  block/mirror.c                      |  12 +-
>  block/nbd-client.c                  | 108 ++++++++----------
>  block/nbd-client.h                  |   2 +-
>  block/nfs.c                         |   9 +-
>  block/qed-cluster.c                 |   2 +
>  block/qed-table.c                   |  12 +-
>  block/qed.c                         |  58 +++++++---
>  block/qed.h                         |   3 +
>  block/sheepdog.c                    |  29 ++---
>  block/ssh.c                         |  29 ++---
>  block/throttle-groups.c             |   2 +
>  block/win32-aio.c                   |   9 +-
>  dma-helpers.c                       |   2 +
>  hw/block/virtio-blk.c               |  19 +++-
>  hw/scsi/scsi-bus.c                  |   2 +
>  hw/scsi/scsi-disk.c                 |  15 +++
>  hw/scsi/scsi-generic.c              |  20 +++-
>  hw/scsi/virtio-scsi.c               |   6 +
>  include/block/aio.h                 |  38 ++++++-
>  include/block/block_int.h           |  64 ++++++-----
>  include/io/channel.h                |  72 +++++++++++-
>  include/qemu/coroutine_int.h        |  10 +-
>  include/sysemu/block-backend.h      |  14 ++-
>  io/channel-command.c                |  13 +++
>  io/channel-file.c                   |  11 ++
>  io/channel-socket.c                 |  16 ++-
>  io/channel-tls.c                    |  12 ++
>  io/channel-watch.c                  |   6 +
>  io/channel.c                        |  97 ++++++++++++----
>  nbd/client.c                        |   2 +-
>  nbd/common.c                        |   9 +-
>  nbd/server.c                        |  94 +++++-----------
>  stubs/Makefile.objs                 |   2 +
>  stubs/linux-aio.c                   |  32 ++++++
>  stubs/main-loop.c                   |   8 ++
>  stubs/set-fd-handler.c              |  11 --
>  tests/Makefile.include              |  18 +--
>  tests/iothread.c                    |  91 +++++++++++++++
>  tests/iothread.h                    |  25 +++++
>  tests/test-aio-multithread.c        | 213 ++++++++++++++++++++++++++++++++++++
>  tests/test-thread-pool.c            |  12 +-
>  tests/test-vmstate.c                |  11 --
>  trace-events                        |   4 +
>  util/Makefile.objs                  |   5 +-
>  aio-posix.c => util/aio-posix.c     |  60 +++-------
>  aio-win32.c => util/aio-win32.c     |  30 ++---
>  util/aiocb.c                        |  55 ++++++++++
>  async.c => util/async.c             |  84 ++++++++++++--
>  util/qemu-coroutine-lock.c          |   5 +-
>  util/qemu-coroutine-sleep.c         |   2 +-
>  util/qemu-coroutine.c               |   8 ++
>  qemu-timer.c => util/qemu-timer.c   |   0
>  thread-pool.c => util/thread-pool.c |   6 +-
>  util/trace-events                   |   1 -
>  63 files changed, 1155 insertions(+), 465 deletions(-)
>  create mode 100644 stubs/linux-aio.c
>  create mode 100644 stubs/main-loop.c
>  create mode 100644 tests/iothread.c
>  create mode 100644 tests/iothread.h
>  create mode 100644 tests/test-aio-multithread.c
>  rename aio-posix.c => util/aio-posix.c (94%)
>  rename aio-win32.c => util/aio-win32.c (95%)
>  create mode 100644 util/aiocb.c
>  rename async.c => util/async.c (82%)
>  rename qemu-timer.c => util/qemu-timer.c (100%)
>  rename thread-pool.c => util/thread-pool.c (98%)
> 

Ping?

Paolo
