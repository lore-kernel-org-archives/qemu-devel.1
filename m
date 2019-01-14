Received: from eggs.gnu.org ([209.51.188.92]:59061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3Rk-0007S1-Uj
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gj3Rk-0002gN-4V
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:42:36 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190114133257.30299-2-stefanha@redhat.com>
References: <20190114133257.30299-1-stefanha@redhat.com>
	<20190114133257.30299-2-stefanha@redhat.com>
Date: Mon, 14 Jan 2019 15:42:29 +0100
Message-ID: <w51tvib47xm.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] throttle-groups: fix restart
 coroutine iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon 14 Jan 2019 02:32:56 PM CET, Stefan Hajnoczi wrote:
> The following QMP command leads to a crash when iothreads are used:
>
>   { 'execute': 'device_del', 'arguments': {'id': 'data'} }
>
> The backtrace involves the queue restart coroutine where
> tgm->throttle_state is a NULL pointer because
> throttle_group_unregister_tgm() has already been called:
>
>   (gdb) bt full
>   #0  0x00005585a7a3b378 in qemu_mutex_lock_impl (mutex=0xffffffffffffffd0, file=0x5585a7bb3d54 "block/throttle-groups.c", line=412) at util/qemu-thread-posix.c:64
>         err = <optimized out>
>         __PRETTY_FUNCTION__ = "qemu_mutex_lock_impl"
>         __func__ = "qemu_mutex_lock_impl"
>   #1  0x00005585a79be074 in throttle_group_restart_queue_entry (opaque=0x5585a9de4eb0) at block/throttle-groups.c:412
>         _f = <optimized out>
>         data = 0x5585a9de4eb0
>         tgm = 0x5585a9079440
>         ts = 0x0
>         tg = 0xffffffffffffff98
>         is_write = false
>         empty_queue = 255
>
> This coroutine should not execute in the iothread after the throttle
> group member has been unregistered!
>
> The root cause is that the device_del code path schedules the restart
> coroutine in the iothread while holding the AioContext lock.  Therefore
> the iothread cannot execute the coroutine until after device_del
> releases the lock - by this time it's too late.
>
> This patch adds a reference count to ThrottleGroupMember so we can
> synchronously wait for restart coroutines to complete.  Once they are
> done it is safe to unregister the ThrottleGroupMember.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
