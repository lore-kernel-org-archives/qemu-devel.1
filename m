Received: from eggs.gnu.org ([2001:4830:134:3::10]:44493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3zsE-0007ip-Qz
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f3zs9-0001fG-27
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:03:58 -0400
Date: Thu, 5 Apr 2018 10:03:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180405100346.7789e8e1.cohuck@redhat.com>
In-Reply-To: <11ca3563-dd2c-f8b0-8336-323177477a00@de.ibm.com>
References: <20180326092036.12780-1-david@redhat.com>
	<11ca3563-dd2c-f8b0-8336-323177477a00@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] s390x/kvm: call
 cpu_synchronize_state() on every kvm_arch_handle_exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On Thu, 5 Apr 2018 09:53:45 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 03/26/2018 11:20 AM, David Hildenbrand wrote:

> FWIW, I think your patch even fixes a bug:
> 
> --- snip ----
> static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
> {
>     int r = 0;
>     uint16_t func_code;
> 
>     /*
>      * For any diagnose call we support, bits 48-63 of the resulting
>      * address specify the function code; the remainder is ignored.
>      */
>     func_code = decode_basedisp_rs(&cpu->env, ipb, NULL) & DIAG_KVM_CODE_MASK;
> 
> ---->  
> 	static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
> 	                                       uint8_t *ar)
> 	{
> 	    hwaddr addr = 0;
> 	    uint8_t reg;
> 	    
> 	    reg = ipb >> 28;
> 	    if (reg > 0) {
> 	        addr = env->regs[reg];
> 
> ----> we do the sync_regs after this in the diag handler!  
> So currently we only handle the case with base reg == 0 correctly.
> So
> diag x,y,0x500(0) 
> works
> 
> 
> but things like
> lghi 1,0x500
> diag x,y,0(1)
> 
> not unless I miss something.

I think you are right.

> 
> 
> [...]
> > @@ -1778,6 +1760,8 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> > 
> >      qemu_mutex_lock_iothread();
> > 
> > +    cpu_synchronize_state(CPU(cpu));
> > +
> >      switch (run->exit_reason) {
> >          case KVM_EXIT_S390_SIEIC:
> >              ret = handle_intercept(cpu);
> >   
> 
> Does it make sense to do this hunk NOW for 2.12 (cc stable)
> and queue your full patch for 2.13?
> 

I'd prefer a cpu_synchronize_state() at the start of handle_diag() and
a respin of this patch for 2.13, but that should be fine as well.

I'll queue a proper patch for 2.12-rc.
