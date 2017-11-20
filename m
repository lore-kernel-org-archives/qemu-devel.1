Received: from eggs.gnu.org ([2001:4830:134:3::10]:33439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eGuqd-0007Rr-RE
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eGuqd-0004VN-0L
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:47:27 -0500
References: <cover.1511145863.git.jcody@redhat.com>
	<0c039d00e03331d863ee249810d9778313670803.1511145863.git.jcody@redhat.com>
	<06d8393e-8422-0576-ad68-f14e49eed1a6@redhat.com>
	<20171120223536.GC32161@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <82e388ce-cbbf-7e59-6433-6e109e426512@redhat.com>
Date: Mon, 20 Nov 2017 23:47:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171120223536.GC32161@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] coroutines: abort if we try to enter a
 still-sleeping coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, kwolf@redhat.com

On 20/11/2017 23:35, Jeff Cody wrote:
>> Is this a different "state" (in Stefan's parlance) than scheduled?  In
>> practice both means that someone may call qemu_(aio_)coroutine_enter
>> concurrently, so you'd better not do it yourself.
>>
> It is slightly different; it is from sleeping with a timer via
> co_aio_sleep_ns and waking via co_sleep_cb.  Whereas the 'co->scheduled=
' is
> specifically from being scheduled for a specific AioContext, via
> aio_co_schedule().

Right; however, that would only make a difference if we allowed
canceling a co_aio_sleep_ns.  Since we don't want that, they have the
same transitions.

> In practice, 'co->schedule' and 'co->sleeping' certainly rhyme, at the =
very
> least.
>=20
> But having them separate will put the abort closer to where the problem=
 lies,
> so it should make debugging a bit easier if we hit it.

What do you mean by closer?  It would print a slightly more informative
message, but the message is in qemu_aio_coroutine_for both cases.

In fact, unifying co->scheduled and co->sleeping means that you can
easily abort when co_aio_sleep_ns is called on a scheduled coroutine, lik=
e

    /* This is valid. */
    aio_co_schedule(qemu_get_current_aio_context(),
                    qemu_coroutine_self());

    /* But only if there was a qemu_coroutine_yield here.  */
    co_aio_sleep_ns(qemu_get_current_aio_context(), 1000);

Thanks,

Paolo
