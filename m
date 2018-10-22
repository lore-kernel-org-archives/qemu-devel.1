Received: from eggs.gnu.org ([2001:4830:134:3::10]:52740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gEjyB-0001R6-GJ
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gEjy6-0001Nv-Gq
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:50:47 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gEjy6-0001Ne-9Z
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:50:42 -0400
Date: Mon, 22 Oct 2018 19:50:40 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181022235040.GB31407@flamenco>
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-47-cota@braap.org>
	<8af6bae7-ac35-f419-0a83-8a54cfb5eb0d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8af6bae7-ac35-f419-0a83-8a54cfb5eb0d@linaro.org>
Subject: Re: [Qemu-devel] [RFC v3 46/56] accel/tcg: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Sun, Oct 21, 2018 at 14:34:25 +0100, Richard Henderson wrote:
> On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> > @@ -540,16 +540,16 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >       */
> >      atomic_mb_set(&cpu->icount_decr.u16.high, 0);
> >  
> > -    if (unlikely(atomic_read(&cpu->interrupt_request))) {
> > +    if (unlikely(cpu_interrupt_request(cpu))) {
> >          int interrupt_request;
> >          qemu_mutex_lock_iothread();
> > -        interrupt_request = cpu->interrupt_request;
> > +        interrupt_request = cpu_interrupt_request(cpu);
> >          if (unlikely(cpu->singlestep_enabled & SSTEP_NOIRQ)) {
> >              /* Mask out external interrupts for this step. */
> >              interrupt_request &= ~CPU_INTERRUPT_SSTEP_MASK;
> >          }
> >          if (interrupt_request & CPU_INTERRUPT_DEBUG) {
> > -            cpu->interrupt_request &= ~CPU_INTERRUPT_DEBUG;
> > +            cpu_reset_interrupt(cpu, CPU_INTERRUPT_DEBUG);
> >              cpu->exception_index = EXCP_DEBUG;
> >              qemu_mutex_unlock_iothread();
> >              return true;
> 
> Multiple calls.

I'd rather keep it as is.

The first read takes the lock, and that has to stay unless
we want to use atomic_set on interrupt_request everywhere.

The second read happens after the BQL has been acquired;
note that to avoid deadlock we never acquire the BQL after
a CPU lock; the second (locked) read thus has to stay.

Subsequent accesses are all via cpu_reset_interrupt.
If we wanted to avoid reacquiring the lock, we'd have
to explicitly acquire the lock before the 2nd read,
and add unlocks everywhere (like the many qemu_mutex_unlock_iothread
calls), which would be ugly. But we'd also have to be careful
not to longjmp with the CPU mutex held, so we'd have to
unlock/lock around cc->cpu_exec_interrupt.

Given that the CPU lock is uncontended (so it's cheap to
acquire) and that the cases where we call cpu_reset_interrupt
are not that frequent (CPU_INTERRUPT_{DEBUG,HALT,EXITTB}),
I'd rather just keep the patch as is.

Thanks,

		Emilio
