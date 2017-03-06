Received: from eggs.gnu.org ([2001:4830:134:3::10]:52590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cku2r-000085-U7
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cku2o-0001Rf-24
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:55:30 -0500
References: <20170302130422.81380-1-pasic@linux.vnet.ibm.com>
	<20170302154935.7b8ec875.cornelia.huck@de.ibm.com>
	<b12c69aa-67ee-ffbc-cd89-716c24889167@redhat.com>
	<9a67d492-5bda-4b2a-0732-4034176d0d28@linux.vnet.ibm.com>
	<7b6ff676-bf57-d9ab-def7-fe894f821f03@redhat.com>
	<42da742f-a4fa-b592-904e-5e6f07bfe990@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <baababfc-04b0-ad71-3065-381bf8dd1e0d@redhat.com>
Date: Mon, 6 Mar 2017 15:55:19 +0100
MIME-Version: 1.0
In-Reply-To: <42da742f-a4fa-b592-904e-5e6f07bfe990@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-blk: fix race on guest notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 03/03/2017 20:43, Halil Pasic wrote:
> Uh, this is complicated. I'm not out of questions, but I fear taking to
> much of your precious time. I will ask again nevertheless, but please
> just cut the conversation with -EBUSY if it gets to expensive.

It's the opposite!  I need other people to look at it, understand it and
poke holes at my own reasoning.

>         bs_->wakeup =3D true;                                \
>         while ((cond)) {                                   \
>             aio_context_release(ctx_);                     \
>             aio_poll(qemu_get_aio_context(), true);        \
>             aio_context_acquire(ctx_);                     \
>             waited_ =3D true;                                \
>         }                                                  \
>         bs_->wakeup =3D false;                               \
>     }                                                      \
>     waited_; })
>=20
> where it's interesting (me running with 2 iothreads one assigned to my
> block device) we are gonna take  the "else" branch , a will end up
> releasing the ctx belonging to the iothread and then acquire it again,
> and basically wait till the requests are done.
>=20
> Since is virtio_blk_rw_complete acquiring-releasing the same ctx this
> makes a lot of sense. If we would not release the ctx we would end up
> with a deadlock.

Related to this, note that the above release/wait/acquire logic is
itself new to 2.8.  Before, QEMU would run aio_poll(other_aio_context)
directly in the main thread.  This relied on recursive mutexes and
special callbacks to pass the lock between the I/O and main threads.

This worked but it hid some thread-unsafe idioms, so I removed this in
the commits ending at 65c1b5b ("iothread: release AioContext around
aio_poll", 2016-10-28).  BDRV_POLL_WHILE provides an abstraction that
will not change once aio_context_acquire/release disappears in favor of
fine-grained locks.

> But then I do not understand what is the point acquiring
> the mutex in virtio_blk_rw_complete?

When QEMU does I/O in the main thread, it can call
BlockBackend/BlockDriverState functions.  Even though their completion
is processed in the I/O thread (via BDRV_POLL_WHILE), you still need a
lock to handle mutual exclusion between the two.

In the case of virtio_blk_rw_complete the mutex is needed because, for
example, block_acct_done is not thread safe yet.

> Is patch b9e413dd required for the correctness of this patch?
> What is the role of the aio_context_acquire/release introduced by
> b9e413dd in virtio_blk_rw_complete?

Patch b9e413dd should have no semantic change.  The acquire/release that
are added are all balanced by removed acquire/releases elsewhere, for
example in block/linux-aio.c.

Paolo
