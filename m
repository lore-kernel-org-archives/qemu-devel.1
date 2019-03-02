Received: from eggs.gnu.org ([209.51.188.92]:44238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0Dpy-00031l-FA
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 18:14:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0Dpx-0003vl-Gn
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 18:14:34 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0Dpw-0003v3-RC
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 18:14:33 -0500
Date: Sat, 2 Mar 2019 18:14:31 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190302231431.GB16678@flamenco>
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-41-cota@braap.org>
	<87d0o2msz4.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0o2msz4.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] [PATCH v6 40/73] i386/kvm: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On Fri, Feb 08, 2019 at 11:15:27 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  target/i386/kvm.c | 54 +++++++++++++++++++++++++++--------------------
> >  1 file changed, 31 insertions(+), 23 deletions(-)
> >
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index ca2629f0fe..3f3c670897 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> <snip>
> > @@ -3183,14 +3186,14 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
> >  {
> >      X86CPU *x86_cpu = X86_CPU(cpu);
> >      CPUX86State *env = &x86_cpu->env;
> > +    uint32_t interrupt_request;
> >      int ret;
> >
> > +    interrupt_request = cpu_interrupt_request(cpu);
> >      /* Inject NMI */
> > -    if (cpu->interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
> > -        if (cpu->interrupt_request & CPU_INTERRUPT_NMI) {
> > -            qemu_mutex_lock_iothread();
> > +    if (interrupt_request & (CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
> > +        if (interrupt_request & CPU_INTERRUPT_NMI) {
> >              cpu_reset_interrupt(cpu, CPU_INTERRUPT_NMI);
> > -            qemu_mutex_unlock_iothread();
> >              DPRINTF("injected NMI\n");
> >              ret = kvm_vcpu_ioctl(cpu, KVM_NMI);
> >              if (ret < 0) {
> > @@ -3198,10 +3201,8 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
> >                          strerror(-ret));
> >              }
> >          }
> > -        if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
> > -            qemu_mutex_lock_iothread();
> > +        if (interrupt_request & CPU_INTERRUPT_SMI) {
> >              cpu_reset_interrupt(cpu, CPU_INTERRUPT_SMI);
> > -            qemu_mutex_unlock_iothread();
> >              DPRINTF("injected SMI\n");
> >              ret = kvm_vcpu_ioctl(cpu, KVM_SMI);
> >              if (ret < 0) {
> > @@ -3215,16 +3216,18 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
> >          qemu_mutex_lock_iothread();
> >      }
> >
> > +    interrupt_request = cpu_interrupt_request(cpu);
> > +
> 
> This seems a bit smelly as we have already read interrupt_request once
> before. So this says that something may have triggered an IRQ while we
> were dealing with the above. It requires a comment at least.

There are a few cpu_reset_interrupt() calls above, so I thought a comment
wasn't necessary. I've added the following comment:

+    /*
+     * We might have cleared some bits in cpu->interrupt_request since reading
+     * it; read it again.
+     */
     interrupt_request = cpu_interrupt_request(cpu);

> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks,

		E.
