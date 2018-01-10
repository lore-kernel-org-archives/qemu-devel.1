Received: from eggs.gnu.org ([2001:4830:134:3::10]:38100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZARM-0001yI-9X
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZARH-0002rY-Cr
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:04:48 -0500
Received: from mail.ispras.ru ([83.149.199.45]:46612)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZARH-0002pj-4s
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 02:04:43 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20171116115926.16627-1-pbonzini@redhat.com>
	<20171116115926.16627-8-pbonzini@redhat.com>
	<CAFEAcA-06-VmH7Pvymo-o-HmiQ-uQ67Hs0KhWZfxswBxsfD2-g@mail.gmail.com>
	<bf4bedd9-0ef8-cff3-6153-531fba597237@redhat.com>
	<CAFEAcA9Rnd3gtrHb389e6fOEAae4aLhJnQWU-vKyzTM4o-riOQ@mail.gmail.com>
	<001b01d361e9$d46ace40$7d406ac0$@ru>
	<CAFEAcA8NGnmG_8SipvPN5_dPhokH2zZAXykN2KiW10XhB-9xXQ@mail.gmail.com>
	<CAFEAcA9PUOyK_vEnMKJkZV5s7o4zHDRedUY7z0ZH0i5ULEGzwg@mail.gmail.com>
	<004401d3894c$b3fc90f0$1bf5b2d0$@ru>
	<CAFEAcA8GiMDyFU4j3OvZ7F=fXk93B4447RQnpp+9cHWUGMp7Ag@mail.gmail.com>
In-Reply-To: <CAFEAcA8GiMDyFU4j3OvZ7F=fXk93B4447RQnpp+9cHWUGMp7Ag@mail.gmail.com>
Date: Wed, 10 Jan 2018 10:04:41 +0300
Message-ID: <001401d389e1$495ffa30$dc1fee90$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PULL 07/11] cpu-exec: don't overwrite
 exception_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Peter Maydell' <peter.maydell@linaro.org>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, 'QEMU Developers' <qemu-devel@nongnu.org>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> On 9 January 2018 at 13:21, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> > I tried to get some logs with the following code.
> > It prints that there was an exception 5 and it was overwritten by the standard code.
> > Fixed code prevents this overwrite.
> >
> > I guess that one of the following is true:
> >  - unfixed version misses some exceptions
> >  - fixed version processes some exceptions twice (e.g., when there is no clear exception)
> >
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 280200f..fa810f7 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -605,6 +605,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >      /* Finally, check if we need to exit to the main loop.  */
> >      if (unlikely(atomic_read(&cpu->exit_request)
> >          || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0)))
> > +        if (cpu->exception_index != -1 && cpu->exception_index != EXCP_INTERRUP
> > +            qemu_log("overwriting excp_index %x\n", cpu->exception_index);
> >          atomic_set(&cpu->exit_request, 0);
> >          cpu->exception_index = EXCP_INTERRUPT;
> >          return true;
> 
> This looks like it's just working around whatever is going on
> (why should EXCP_INTERRUPT be special?). What we need to do is
> find out what's actually happening here...

The failure cause is in incorrect interrupt processing.
When ARM processes hardware interrupt in arm_cpu_exec_interrupt(),
it executes cs->exception_index = excp_idx;

This assumes, that the exception will be processed later.
But it is processed immediately by calling cc->do_interrupt(cs);
instead of leaving this job to cpu_exec.

I guess these calls should be removed to match the cpu_exec execution pattern.

Pavel Dovgalyuk
