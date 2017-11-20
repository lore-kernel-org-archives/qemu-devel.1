Received: from eggs.gnu.org ([2001:4830:134:3::10]:45781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGvX4-0000rB-C0
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 18:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGvX3-0006Ax-G3
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 18:31:18 -0500
Date: Mon, 20 Nov 2017 18:31:06 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171120233106.GJ5399@localhost.localdomain>
References: <cover.1511145863.git.jcody@redhat.com>
	<0c039d00e03331d863ee249810d9778313670803.1511145863.git.jcody@redhat.com>
	<06d8393e-8422-0576-ad68-f14e49eed1a6@redhat.com>
	<20171120223536.GC32161@localhost.localdomain>
	<82e388ce-cbbf-7e59-6433-6e109e426512@redhat.com>
	<20171120230837.GI5399@localhost.localdomain>
	<e1b8b6e2-1e86-9a60-2b3c-53b871c59fd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b8b6e2-1e86-9a60-2b3c-53b871c59fd6@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, kwolf@redhat.com

On Tue, Nov 21, 2017 at 12:13:46AM +0100, Paolo Bonzini wrote:
> On 21/11/2017 00:08, Jeff Cody wrote:
> > @@ -34,6 +36,7 @@ void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QEMUClockType type,
> >      CoSleepCB sleep_cb = {
> >          .co = qemu_coroutine_self(),
> >      };
> > +    if (sleep_cb.co->sleeping == 1 || sleep_cb.co->scheduled == 1) {
> > +       fprintf(stderr, "Cannot sleep a co-routine that is already sleeping "
> > +                       " or scheduled\n");
> > +       abort();
> > +    }
> > +    sleep_cb.co->sleeping = 1;
> >      sleep_cb.ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &sleep_cb);
> >      timer_mod(sleep_cb.ts, qemu_clock_get_ns(type) + ns);
> >      qemu_coroutine_yield();
> 
> I understand that this was just an example and not the actual patch, but
> I'll still point out that this loses the benefit (better error message)
> of keeping the flags separate.
> 
> What do you think about making "scheduled" a const char * and assigning
> __func__ to it (i.e. either "aio_co_schedule" or "co_aio_sleep_ns")?
> 

Ohhh, nice.  I'll spin a v2 with that, and merge patches 3 and 5 together.
And then maybe for 2.12 we can look at making it a fsm, like Stefan
suggested (or somehow make coroutine entry thread safe and idempotent).

Jeff
