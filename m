Received: from eggs.gnu.org ([2001:4830:134:3::10]:55099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cR4oo-0001Wn-EZ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 17:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cR4oj-0008O8-HN
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 17:23:02 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cR4oj-0008Nm-9V
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 17:22:57 -0500
Received: by mail-wm0-x243.google.com with SMTP id l2so33078424wml.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 14:22:57 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170104132625.28059-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <93ac5112-861d-6df4-08e8-6cacac0e2792@redhat.com>
Date: Tue, 10 Jan 2017 23:22:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170104132625.28059-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/10] aio_context_acquire/release
 pushdown, part 1
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



On 04/01/2017 14:26, Paolo Bonzini wrote:
> This is the first step of pushing down the AioContext lock.  Bottom halves
> are already protected by their own lock, use it also for walking_bh
> and for the handlers list (including walking_handlers).  The (lock,
> walking_foo) pair is wrapped into the QemuLockCnt primitive.
> 
> Paolo

Ping?  (I'm ready to post part 2 now that Kevin is back from vacation
and all prerequisites are in origin/master).

Paolo

> v2->v3:
>         fix missing unlock
> 
> v1->v2:
>         rebased on top of polling patches
>         moved documentation to include/
>         new patch "aio-posix: split aio_dispatch_handlers out of aio_dispatch"
>         replaced atomic_read with atomic_mb_read in qemu_lockcnt_inc
>         replaced futex* function and macro names with qemu_futex*
>         removed atomic access to node->pfd.revents (because there is no
>           concurrent aio_poll anymore after the BDRV_POLL_WHILE series)
>         left "aio: push aio_context_acquire/release down to dispatching"
>           to a later series
> 
> Paolo Bonzini (10):
>   aio: rename bh_lock to list_lock
>   qemu-thread: introduce QemuLockCnt
>   aio: make ctx->list_lock a QemuLockCnt, subsuming ctx->walking_bh
>   qemu-thread: optimize QemuLockCnt with futexes on Linux
>   aio-posix: split aio_dispatch_handlers out of aio_dispatch
>   aio: tweak walking in dispatch phase
>   aio-posix: remove walking_handlers, protecting AioHandler list with
>     list_lock
>   aio-win32: remove walking_handlers, protecting AioHandler list with
>     list_lock
>   aio: document locking
>   async: optimize aio_bh_poll
> 
>  aio-posix.c                 | 116 +++++++------
>  aio-win32.c                 |  83 ++++++----
>  async.c                     |  45 ++---
>  docs/lockcnt.txt            | 277 +++++++++++++++++++++++++++++++
>  docs/multiple-iothreads.txt |  13 +-
>  include/block/aio.h         |  38 ++---
>  include/qemu/futex.h        |  36 ++++
>  include/qemu/thread.h       | 111 +++++++++++++
>  util/Makefile.objs          |   1 +
>  util/lockcnt.c              | 395 ++++++++++++++++++++++++++++++++++++++++++++
>  util/qemu-thread-posix.c    |  35 +---
>  util/qemu-thread-win32.c    |   2 +-
>  util/trace-events           |  10 ++
>  13 files changed, 1003 insertions(+), 159 deletions(-)
>  create mode 100644 docs/lockcnt.txt
>  create mode 100644 include/qemu/futex.h
>  create mode 100644 util/lockcnt.c
> 
