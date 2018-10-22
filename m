Received: from eggs.gnu.org ([2001:4830:134:3::10]:52254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gEjwT-0008LD-Iq
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gEjmZ-000290-Ha
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:38:52 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gEjmU-0001oJ-OC
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 19:38:45 -0400
Date: Mon, 22 Oct 2018 19:38:32 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181022233832.GA31407@flamenco>
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-38-cota@braap.org>
	<fe2729b7-60b1-bac6-2a3f-b9cec01f3c82@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe2729b7-60b1-bac6-2a3f-b9cec01f3c82@linaro.org>
Subject: Re: [Qemu-devel] [RFC v3 37/56] mips: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, James Hogan <jhogan@kernel.org>

On Sun, Oct 21, 2018 at 14:30:20 +0100, Richard Henderson wrote:
> On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> > @@ -60,7 +60,7 @@ static bool mips_cpu_has_work(CPUState *cs)
> >      /* Prior to MIPS Release 6 it is implementation dependent if non-enabled
> >         interrupts wake-up the CPU, however most of the implementations only
> >         check for interrupts that can be taken. */
> > -    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
> > +    if ((cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
> >          cpu_mips_hw_interrupts_pending(env)) {
> >          if (cpu_mips_hw_interrupts_enabled(env) ||
> >              (env->insn_flags & ISA_MIPS32R6)) {
> > @@ -72,7 +72,7 @@ static bool mips_cpu_has_work(CPUState *cs)
> >      if (env->CP0_Config3 & (1 << CP0C3_MT)) {
> >          /* The QEMU model will issue an _WAKE request whenever the CPUs
> >             should be woken up.  */
> > -        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
> > +        if (cpu_interrupt_request(cs) & CPU_INTERRUPT_WAKE) {
> >              has_work = true;
> >          }
> >  
> > @@ -82,7 +82,7 @@ static bool mips_cpu_has_work(CPUState *cs)
> >      }
> >      /* MIPS Release 6 has the ability to halt the CPU.  */
> >      if (env->CP0_Config5 & (1 << CP0C5_VP)) {
> > -        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
> > +        if (cpu_interrupt_request(cs) & CPU_INTERRUPT_WAKE) {
> >              has_work = true;
> >          }
> >          if (!mips_vp_active(env)) {
> 
> Multiple calls.

Fixed, even though cpu_has_work ends up being called with
the lock held later in the series.

Thanks,

		E.
