Received: from eggs.gnu.org ([2001:4830:134:3::10]:36543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gF3Hs-0004Nv-IG
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 16:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gF3Hp-0002ea-8G
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 16:28:24 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gF3Hp-0002cD-0q
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 16:28:21 -0400
Date: Tue, 23 Oct 2018 16:28:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181023202816.GB20137@flamenco>
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-31-cota@braap.org>
	<2fc311fc-6d03-b1c7-1a9c-583dc5343774@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc311fc-6d03-b1c7-1a9c-583dc5343774@linaro.org>
Subject: Re: [Qemu-devel] [RFC v3 30/56] i386: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Sun, Oct 21, 2018 at 14:27:22 +0100, Richard Henderson wrote:
> On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> > @@ -713,9 +713,9 @@ int hvf_vcpu_exec(CPUState *cpu)
> >          switch (exit_reason) {
> >          case EXIT_REASON_HLT: {
> >              macvm_set_rip(cpu, rip + ins_len);
> > -            if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
> > +            if (!((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD) &&
> >                  (EFLAGS(env) & IF_MASK))
> > -                && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
> > +                && !(cpu_interrupt_request(cpu) & CPU_INTERRUPT_NMI) &&
> >                  !(idtvec_info & VMCS_IDT_VEC_VALID)) {
> >                  cpu_halted_set(cpu, 1);
> >                  ret = EXCP_HLT;
> 
> Likewise wrt multiple calls.
> 
> > @@ -400,7 +401,8 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
> >          };
> >      }
> >  
> > -    if (cpu_state->interrupt_request & CPU_INTERRUPT_NMI) {
> > +    cpu_mutex_lock(cpu_state);
> > +    if (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_NMI) {
> >          if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
> >              cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_NMI);
> >              info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | NMI_VEC;
> > @@ -411,7 +413,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
> >      }
> >  
> >      if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
> > -        (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
> > +        (cpu_interrupt_request(cpu_state) & CPU_INTERRUPT_HARD) &&
> >          (EFLAGS(env) & IF_MASK) && !(info & VMCS_INTR_VALID)) {
> >          int line = cpu_get_pic_interrupt(&x86cpu->env);
> >          cpu_reset_interrupt(cpu_state, CPU_INTERRUPT_HARD);
> 
> Likewise.
> 
> I think you need to be more careful about this in the conversions.  Previously,
> the compiler would CSE these two loads; now you're taking a lock twice.
> 
> Or in the second instance, once, since you explicitly take the lock around a
> big block.  But I think that's papering over the fact that you make 4 calls
> when you should have made one, *and* not hold the lock across all that code.

Yes, I'm aware of this. For a first pass I wanted to make sure no updates
would be lost, e.g.

	int interrupt_request = cpu_interrupt_request(cpu);
	if (interrupt_request & FOO) {
		do_foo(); /* sets cpu->interrupt_request | BAR */
	}
	if (interrupt_request & BAR) { /* wrongly misses BAR update */
		do_bar();
	}

I'll go through the entire patch to amend these.

Thanks,

		E.
