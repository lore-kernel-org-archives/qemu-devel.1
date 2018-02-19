Received: from eggs.gnu.org ([2001:4830:134:3::10]:40396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1enpn2-0001rl-DG
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1enpn1-00045Y-Cv
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:03:48 -0500
References: <CAJSP0QV=rntD8h4kLdDaydDHxf9ustrK0jnUfU-aQFJp2wPAWg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95b23032-6a23-914f-2c79-3da8bbc79c22@redhat.com>
Date: Mon, 19 Feb 2018 19:03:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QV=rntD8h4kLdDaydDHxf9ustrK0jnUfU-aQFJp2wPAWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Multiqueue block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

On 18/02/2018 19:20, Stefan Hajnoczi wrote:
> Paolo's patches have been getting us closer to multiqueue block layer
> support but there is a final set of changes required that has become
> clearer to me just recently.  I'm curious if this matches Paolo's
> vision and whether anyone else has comments.
>=20
> We need to push the AioContext lock down into BlockDriverState so that
> thread-safety is not tied to a single AioContext but to the
> BlockDriverState itself.  We also need to audit block layer code to
> identify places that assume everything is run from a single
> AioContext.

This is mostly done already.  Within BlockDriverState
dirty_bitmap_mutex, reqs_lock and the BQL is good enough in many cases.
Drivers already have their mutex.

> After this is done the final piece is to eliminate
> bdrv_set_aio_context().  BlockDriverStates should not be associated
> with an AioContext.  Instead they should use whichever AioContext they
> are invoked under.  The current thread's AioContext can be fetched
> using qemu_get_current_aio_context().  This is either the main loop
> AioContext or an IOThread AioContext.
>
> The .bdrv_attach/detach_aio_context() callbacks will no longer be
> necessary in a world where block driver code is thread-safe and any
> AioContext can be used.

This is not entirely possible.  In particular, network drivers still
have a "home context" which is where the file descriptor callbacks are
attached to.  They could still dispatch I/O from any thread in a
multiqueue setup.  This is the remaining intermediate step between "no
AioContext lock" and "multiqueue".

> bdrv_drain_all() and friends do not require extensive modifications
> because the bdrv_wakeup() mechanism already works properly when there
> are multiple IOThreads involved.

Yes, this is already done indeed.

> Block jobs no longer need to be in the same AioContext as the
> BlockDriverState.  For simplicity we may choose to always run them in
> the main loop AioContext by default.  This may have a performance
> impact on tight loops like bdrv_is_allocated() and the initial
> mirroring phase, but maybe not.
>=20
> The upshot of all this is that bdrv_set_aio_context() goes away while
> all block driver code needs to be more aware of thread-safety.  It can
> no longer assume that everything is called from one AioContext.

Correct.

> We should optimize file-posix.c and qcow2.c for maximum parallelism
> using fine-grained locks and other techniques.  The remaining block
> drivers can use one CoMutex per BlockDriverState.

Even better: there is one thread pool and linux-aio context per I/O
thread, file-posix.c should just submit I/O to the current thread with
no locking whatsoever.  There is still reqs_lock, but that can be
optimized easily (see
http://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03323.html; now
that we have QemuLockable, reqs_lock could also just become a QemuSpin).

qcow2.c could be adjusted to use rwlocks.

> I'm excited that we're relatively close to multiqueue now.  I don't
> want to jinx it by saying 2018 is the year of the multiqueue block
> layer, but I'll say it anyway :).

Heh.  I have stopped pushing my patches (and scratched a few itches with
patchew instead) because I'm still a bit burned out from recent KVM
stuff, but this may be the injection of enthusiasm that I needed. :)

Actually, I'd be content with removing the AioContext lock in the first
half of 2018.  1/3rd of that is gone already---doh!  But we're actually
pretty close, thanks to you and all the others who have helped reviewing
the past 100 or so patches!

Paolo
