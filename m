Received: from eggs.gnu.org ([2001:4830:134:3::10]:60943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJjGk-0008Uz-8V
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJjGg-0008B6-D5
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:02:02 -0500
References: <20171128154350.21504-1-kwolf@redhat.com>
	<20171128154350.21504-2-kwolf@redhat.com>
	<00b2dbda-e7a1-2fc4-b7ca-e60c0ef08a95@redhat.com>
	<20171128163725.GG3703@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf7eed9c-5047-fce8-f649-f8fb3310546b@redhat.com>
Date: Tue, 28 Nov 2017 18:01:32 +0100
MIME-Version: 1.0
In-Reply-To: <20171128163725.GG3703@localhost.localdomain>
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

On 28/11/2017 17:37, Kevin Wolf wrote:
>>
>> It can also conflict badly with another aio_co_schedule().  Your patch
>> here removes the assertion in this case, and patch 3 makes it easier t=
o
>> get into the situation where two aio_co_schedule()s conflict with each
>> other.
> I don't see how they conflict. If the second aio_co_schedule() comes
> before the coroutine is actually entered, they are effectively simply
> merged into a single one. Which is exactly what was intended.

Suppose you have

	ctx->scheduled_coroutines
	  |
	  '---> co
                |
                '---> NULL

Then aio_co_schedule(ctx, co) does QSLIST_INSERT_HEAD_ATOMIC, which is

	/* On entry, ctx->scheduled_coroutines =3D=3D co.  */
	co->next =3D ctx->scheduled_coroutines
	change ctx->scheduled_coroutines from co->next to co

This results in a loop:
=09
	ctx->scheduled_coroutines
	  |
	  '---> co <-.
                |    |
                '----'

This is an obvious hang due to list corruption.  In other more
complicated cases it can skip a wakeup, which is a more subtle kind of
hang.  You can also get memory corruption if the coroutine terminates
(and is freed) before aio_co_schedule executes.

Basically, once you do aio_co_schedule or aio_co_wake the coroutine is
not any more yours.  It's owned by the context that will run it and you
should not do anything with it.

The same is true for co_aio_sleep_ns.  Just because in practice it works
(and it seemed like a clever idea at the time) it doesn't mean it *is* a
good idea...

Paolo
