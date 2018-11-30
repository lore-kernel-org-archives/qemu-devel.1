Received: from eggs.gnu.org ([2001:4830:134:3::10]:39881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSgsM-0003Ir-VB
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSgsL-0003l6-OM
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:22:26 -0500
References: <20181128201317.146504-1-vsementsov@virtuozzo.com>
	<20181129104255.GC4797@linux.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bee3fa2f-67dc-0948-5ffc-97949e96a0cc@redhat.com>
Date: Fri, 30 Nov 2018 12:22:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181129104255.GC4797@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AioContext locking vs. coroutines (was: [PATCH]
 mirror dead-lock)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, dplotnikov@virtuozzo.com, jcody@redhat.com

On 29/11/18 11:42, Kevin Wolf wrote:
> I guess in this specific instance we can just remove the locking from
> mirror_read/write_complete becasue it's only locking an AioContext whos=
e
> lock we already hold anyway because we're in a Coroutine owned by the
> AioContext, so yielding will release the lock and avoid the deadlock.
>=20
> But more generally, does this mean that it is never correct to have an
> explicit aio_context_acquire/release() pair in coroutine context, at
> least for all practical cases where you call things that could yield?

Yes.  In fact, I remember asking Max to drop aio_context_acquire/release
from mirror.c when he converted it to coroutines, but that must have
fallen through the cracks.

> And if you're inside a coroutine and want to access something in a
> different AioContext, you need to drop out of the coroutine first?
> If so, should aio_context_acquire() then assert that it's not called
> from coroutine context?

I'm not sure about that; there could be legitimate case in which the
main thread acquires another context's lock.

> Paolo, will this restriction of coroutines be solved for good when you
> get your patches merged that remove the AioContext lock?

Yes.

Paolo
