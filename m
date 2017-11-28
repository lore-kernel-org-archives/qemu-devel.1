Received: from eggs.gnu.org ([2001:4830:134:3::10]:56614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJjo2-0005Ni-D0
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJjny-0004KK-Vs
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:36:26 -0500
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-2-kwolf@redhat.com>
	<00b2dbda-e7a1-2fc4-b7ca-e60c0ef08a95@redhat.com>
	<20171128163725.GG3703@localhost.localdomain>
	<cf7eed9c-5047-fce8-f649-f8fb3310546b@redhat.com>
	<20171128171931.GJ3703@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1564f667-079f-e480-9bff-2c10033ba0f4@redhat.com>
Date: Tue, 28 Nov 2017 18:35:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171128171931.GJ3703@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/4] Revert "coroutine: abort if
 we try to schedule or enter a pending coroutine"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On 28/11/2017 18:19, Kevin Wolf wrote:
> Am 28.11.2017 um 18:01 hat Paolo Bonzini geschrieben:
>> Basically, once you do aio_co_schedule or aio_co_wake the coroutine is
>> not any more yours.  It's owned by the context that will run it and yo=
u
>> should not do anything with it.
>=20
> Well, but that poses the question how you can implement any coroutine
> that can be reentered from more than one place. Not being able to do
> that would be a severe restriction.
>
> For example, take quorum, which handles requests by spawning a coroutin=
e
> for every child and then yielding until acb->count =3D=3D s->num_childr=
en.
> This means that the main request coroutine can be reentered from the
> child request coroutines in any order and timing.
>=20
> What saves us currently is that they are all in the same AioContext, so
> we won't actually end up in aio_co_schedule(), but I'm sure that sooner
> or later we'll find cases where we're waiting for several workers that
> are spread across different I/O threads.

That can work as long as you add synchronization among those "more than
one place" (quorum doesn't need it because as you say there's only one
AioContext involved).  Take the previous example of

	f();
	g();
	qemu_coroutine_yield();

If f() and g() do

	lock a mutex
	x--;
	wake =3D (x =3D=3D 0)
	unlock a mutex
	if (wake)
		aio_co_wake(co)

then that's fine, because aio_co_wake is only entered in one place.

> I don't think "don't do that" is a good answer to this.
>=20
> And yes, reentering co_aio_sleep_ns() early is a real requirement, too.
> The test case that used speed=3D1 and would have waited a few hours bef=
ore
> actually cancelling the job is an extreme example, but even just
> delaying cancellation for a second is bad if this is a second of
> migration downtime.

Ok, that can be fixed along the lines of what Jeff has just written.
I'll take a look.

Thanks,

Paolo
