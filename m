Received: from eggs.gnu.org ([2001:4830:134:3::10]:54647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1enqff-0007t3-A0
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1enqfZ-00047E-U3
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:00:15 -0500
Date: Mon, 19 Feb 2018 19:59:51 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <1182018243.3954787.1519066791081.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <95b23032-6a23-914f-2c79-3da8bbc79c22@redhat.com>
References: <CAJSP0QV=rntD8h4kLdDaydDHxf9ustrK0jnUfU-aQFJp2wPAWg@mail.gmail.com>
	<95b23032-6a23-914f-2c79-3da8bbc79c22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: pbonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

>>Heh.  I have stopped pushing my patches (and scratched a few itches with
>>patchew instead) because I'm still a bit burned out from recent KVM
>>stuff, but this may be the injection of enthusiasm that I needed. :)


Thanks Paolo for your great work on multiqueue, that's a lot of work since =
the last years !=20

I cross my fingers for 2018, and wait for ceph rbd block driver multiqueue =
implementation :)

Regards,

Alexandre

----- Mail original -----
De: "pbonzini" <pbonzini@redhat.com>
=C3=80: "Stefan Hajnoczi" <stefanha@gmail.com>, "qemu-devel" <qemu-devel@no=
ngnu.org>, "qemu-block" <qemu-block@nongnu.org>
Cc: "Kevin Wolf" <kwolf@redhat.com>, "Fam Zheng" <famz@redhat.com>
Envoy=C3=A9: Lundi 19 F=C3=A9vrier 2018 19:03:19
Objet: Re: [Qemu-devel] Multiqueue block layer

On 18/02/2018 19:20, Stefan Hajnoczi wrote:=20
> Paolo's patches have been getting us closer to multiqueue block layer=20
> support but there is a final set of changes required that has become=20
> clearer to me just recently. I'm curious if this matches Paolo's=20
> vision and whether anyone else has comments.=20
>=20
> We need to push the AioContext lock down into BlockDriverState so that=20
> thread-safety is not tied to a single AioContext but to the=20
> BlockDriverState itself. We also need to audit block layer code to=20
> identify places that assume everything is run from a single=20
> AioContext.=20

This is mostly done already. Within BlockDriverState=20
dirty_bitmap_mutex, reqs_lock and the BQL is good enough in many cases.=20
Drivers already have their mutex.=20

> After this is done the final piece is to eliminate=20
> bdrv_set_aio_context(). BlockDriverStates should not be associated=20
> with an AioContext. Instead they should use whichever AioContext they=20
> are invoked under. The current thread's AioContext can be fetched=20
> using qemu_get_current_aio_context(). This is either the main loop=20
> AioContext or an IOThread AioContext.=20
>=20
> The .bdrv_attach/detach_aio_context() callbacks will no longer be=20
> necessary in a world where block driver code is thread-safe and any=20
> AioContext can be used.=20

This is not entirely possible. In particular, network drivers still=20
have a "home context" which is where the file descriptor callbacks are=20
attached to. They could still dispatch I/O from any thread in a=20
multiqueue setup. This is the remaining intermediate step between "no=20
AioContext lock" and "multiqueue".=20

> bdrv_drain_all() and friends do not require extensive modifications=20
> because the bdrv_wakeup() mechanism already works properly when there=20
> are multiple IOThreads involved.=20

Yes, this is already done indeed.=20

> Block jobs no longer need to be in the same AioContext as the=20
> BlockDriverState. For simplicity we may choose to always run them in=20
> the main loop AioContext by default. This may have a performance=20
> impact on tight loops like bdrv_is_allocated() and the initial=20
> mirroring phase, but maybe not.=20
>=20
> The upshot of all this is that bdrv_set_aio_context() goes away while=20
> all block driver code needs to be more aware of thread-safety. It can=20
> no longer assume that everything is called from one AioContext.=20

Correct.=20

> We should optimize file-posix.c and qcow2.c for maximum parallelism=20
> using fine-grained locks and other techniques. The remaining block=20
> drivers can use one CoMutex per BlockDriverState.=20

Even better: there is one thread pool and linux-aio context per I/O=20
thread, file-posix.c should just submit I/O to the current thread with=20
no locking whatsoever. There is still reqs_lock, but that can be=20
optimized easily (see=20
http://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03323.html; now=20
that we have QemuLockable, reqs_lock could also just become a QemuSpin).=20

qcow2.c could be adjusted to use rwlocks.=20

> I'm excited that we're relatively close to multiqueue now. I don't=20
> want to jinx it by saying 2018 is the year of the multiqueue block=20
> layer, but I'll say it anyway :).=20

Heh. I have stopped pushing my patches (and scratched a few itches with=20
patchew instead) because I'm still a bit burned out from recent KVM=20
stuff, but this may be the injection of enthusiasm that I needed. :)=20

Actually, I'd be content with removing the AioContext lock in the first=20
half of 2018. 1/3rd of that is gone already---doh! But we're actually=20
pretty close, thanks to you and all the others who have helped reviewing=20
the past 100 or so patches!=20

Paolo=20
