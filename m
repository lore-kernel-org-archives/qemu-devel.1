Received: from eggs.gnu.org ([2001:4830:134:3::10]:44426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTt3w-0004Vi-Kl
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTt3t-00020g-F4
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:26:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTt3t-00020Y-6i
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:26:13 -0500
Date: Wed, 18 Jan 2017 17:26:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170118172608.0db201ce@nial.brq.redhat.com>
In-Reply-To: <73c6dc4e-805e-a9a1-712d-7373a3409b66@redhat.com>
References: <20170112182446.9600-1-lersek@redhat.com>
	<20170112182446.9600-3-lersek@redhat.com>
	<20170113140914.62af8755@nial.brq.redhat.com>
	<32d3f5cf-9428-29db-45bb-d3a35c6cbd04@redhat.com>
	<20170117122131.466d4147@nial.brq.redhat.com>
	<bbd7f2a5-cdec-aaf3-acfb-c99ce9054a3c@redhat.com>
	<20170117142059.3a7689de@nial.brq.redhat.com>
	<17a61164-0cb8-98fd-b340-8cb3a27edb0e@redhat.com>
	<20170117152056.4e37468e@nial.brq.redhat.com>
	<ce81a37b-231c-6a7d-feae-bbf5b6cd45a1@redhat.com>
	<20170118110353.3f2ac8a3@nial.brq.redhat.com>
	<98895612-58dd-f0cb-e761-515f9e29c373@redhat.com>
	<e94a097e-274b-b26a-ec89-70929c422c69@redhat.com>
	<20170118133844.75422b55@nial.brq.redhat.com>
	<73c6dc4e-805e-a9a1-712d-7373a3409b66@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 wave 2 2/3] hw/isa/lpc_ich9: add
 broadcast SMI feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Michael Kinney <michael.d.kinney@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 18 Jan 2017 16:42:27 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 01/18/17 13:38, Igor Mammedov wrote:
> > On Wed, 18 Jan 2017 11:23:48 +0100
> > Laszlo Ersek <lersek@redhat.com> wrote:
> >   
> >> On 01/18/17 11:19, Laszlo Ersek wrote:  
> >>> On 01/18/17 11:03, Igor Mammedov wrote:    
> >>>> On Tue, 17 Jan 2017 19:53:21 +0100
> >>>> Laszlo Ersek <lersek@redhat.com> wrote:
> >>>>    
> >>
> >> [snip]
> >>  
> >>>>> This is the code I wrote (extracting a new ich9_apm_broadcast_smi()
> >>>>> function from ich9_apm_ctrl_changed(), due to size reasons):
> >>>>>    
> >>>>>> static void ich9_apm_broadcast_smi(void)
> >>>>>> {
> >>>>>>     CPUState *cs;
> >>>>>>
> >>>>>>     cpu_synchronize_all_states(); /* <--------- mark this */    
> >>>> it probably should be executed after pause_all_vcpus(),
> >>>> maybe it will help.
> >>>>    
> >>>>>>     CPU_FOREACH(cs) {
> >>>>>>         X86CPU *cpu = X86_CPU(cs);
> >>>>>>         CPUX86State *env = &cpu->env;
> >>>>>>
> >>>>>>         if (env->smbase == 0x30000 && env->eip == 0xfff0) {
> >>>>>>             CPUClass *k = CPU_GET_CLASS(cs);
> >>>>>>             uint64_t cpu_arch_id = k->get_arch_id(cs);
> >>>>>>
> >>>>>>             trace_ich9_apm_broadcast_smi_skip(cpu_arch_id);
> >>>>>>             continue;
> >>>>>>         }
> >>>>>>
> >>>>>>         cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> >>>>>>     }
> >>>>>> }      
> >>>>>    
> >>>> [...]    
> >>>>> (b) If I add the cpu_synchronize_all_states() call before the loop, then
> >>>>> the incorrect filter matches go away; QEMU sees the KVM VCPU states
> >>>>> correctly, and the SMI is broad-cast.
> >>>>>
> >>>>> However, in this case, the boot slows to a *crawl*. It's unbearable. All
> >>>>> VCPUs are pegged at 100%, and you can easily follow the OVMF debug log
> >>>>> with the naked eye, almost line by line.
> >>>>> I didn't expect that cpu_synchronize_all_states() would be so costly,
> >>>>> but it makes the idea of checking VCPU state in the APM_CNT handler a
> >>>>> non-starter.    
> >>>> I wonder were bottleneck is to slow down guest so much.
> >>>> What is actual cost of calling cpu_synchronize_all_states()?
> >>>>
> >>>> Maybe calling pause_all_vcpus() before cpu_synchronize_all_states()
> >>>> would help.    
> >>>
> >>> If I prepend just a pause_all_vcpus() function call, at the top, then
> >>> the VM freezes (quite understandably) when the first SMI is raised via
> >>> APM_CNT.
> >>>
> >>> If I, instead, bracket the function body with pause_all_vcpus() and
> >>> resume_all_vcpus(), like this:
> >>>
> >>> static void ich9_apm_broadcast_smi(void)
> >>> {
> >>>     CPUState *cs;
> >>>
> >>>     pause_all_vcpus();
> >>>     cpu_synchronize_all_states();
> >>>     CPU_FOREACH(cs) {
> >>>         X86CPU *cpu = X86_CPU(cs);
> >>>         CPUX86State *env = &cpu->env;
> >>>
> >>>         if (env->smbase == 0x30000 && env->eip == 0xfff0) {
> >>>             CPUClass *k = CPU_GET_CLASS(cs);
> >>>             uint64_t cpu_arch_id = k->get_arch_id(cs);
> >>>
> >>>             trace_ich9_apm_broadcast_smi_skip(cpu_arch_id);
> >>>             continue;
> >>>         }
> >>>
> >>>         cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> >>>     }
> >>>     resume_all_vcpus();
> >>> }
> >>>
> >>> then I see the following symptoms:
> >>> - rather than 4 VCPUs being pegged at 100%, only one VCPU is pegged at
> >>>   100%
> >>> - the boot process, as observed from the OVMF log, is just as slow
> >>>   (= crawling) as without the VCPU pausing/resuming (i.e., like with
> >>>   cpu_synchronize_all_states() only); so ultimately the
> >>>   pausing/resuming doesn't help.    
> >>
> >> I also tried this variant (bracketing only the sync call with pause/resume):
> >>
> >> static void ich9_apm_broadcast_smi(void)
> >> {
> >>     CPUState *cs;
> >>
> >>     pause_all_vcpus();
> >>     cpu_synchronize_all_states();
> >>     resume_all_vcpus();
> >>     CPU_FOREACH(cs) {
> >>         X86CPU *cpu = X86_CPU(cs);
> >>         CPUX86State *env = &cpu->env;
> >>
> >>         if (env->smbase == 0x30000 && env->eip == 0xfff0) {
> >>             CPUClass *k = CPU_GET_CLASS(cs);
> >>             uint64_t cpu_arch_id = k->get_arch_id(cs);
> >>
> >>             trace_ich9_apm_broadcast_smi_skip(cpu_arch_id);
> >>             continue;
> >>         }
> >>
> >>         cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> >>     }
> >> }
> >>
> >> This behaves identically to the version where pause/resume bracket the
> >> entire function body (i.e., 1 VCPU pegged, super-slow boot progress).  
> > wrapping entire function into pause_all_vcpus()/resume_all_vcpus()
> > looks better as then cpu_interrupt() would not need to send IPIs to CPUs
> > since pause_all_vcpus() would have done it.
> 
> I don't understand, why would a pause operation send IPIs?
pause_all forces exit on all CPUs and cpu_interrupt() does the same to
a CPU so if all CPUs were kicked out of running state then cpu_interrupt()
would skip kick out step.

> Do you mean the resume? Even in that case, why would the resume send
> precisely SMIs (substituting for the specific CPU_INTERRUPT_SMI calls)
> and not some other kind of interrupt?
> 
> > So the left question is what this 1 CPU does to make things so slow.
> > Does it send a lot of SMIs or something else?  
> 
> The firmware uses many SMIs / Trigger() calls, for example for the
> implementation of UEFI variable services, and SMM lockbox operations.
> However, it does not use *masses* of them. Following the OVMF log, I see
> that *individual* APM_CNT writes take very long (on the order of a
> second, even), which implies that a single cpu_synchronize_all_states()
> function call takes very long.
> 
> I briefly checked what cpu_synchronize_all_states() does, digging down
> its call stack. I don't see anything in it that we should or could
> modify for the sake of this work.
> 
> 
> I think the current line of investigation is way out of scope for this
> work, and that we've lost focus. In the original "PATCH v6 wave 2 2/3",
> cpu_interrupt() just works as intended.
It's not that I'm outright against of v6 as is,
it just seems that something fundamentally broken on
cpu_synchronize_all_states() call chain and instead of fixing issue
the same SMBASE race case would be just ignored since CPU hotplug is
broken with OVMF anyways.

So I'm fine with applying v6 as is
and as follow up fix to cpu_synchronize_all_states() with
follow up filtering out of the same SMBASE in reset state CPUs
if possible in 2.9 merge window.

> Why are we branching out this far from that? Just to avoid the CPU
> unpark feature that Paolo suggested (which would also be negotiated)?
> 
> What is so wrong with the planned CPU unpark stuff that justifies
> blocking this patch?
> 
> Honestly I don't understand why we can't approach these features
> *incrementally*. Let's do the negotiable SMI broadcast now, then do VCPU
> hotplug later. I think the current negotiation pattern is flexible and
> future-proofed enough for that. It was you who suggested, for
> simplifying the last patch in the series, that we completely ignore VCPU
> hotplug for now (and I whole-heartedly agreed).
> 
> Let me put it like this: what is in this patch, in your opinion, that
> *irrevocably* breaks the upcoming VCPU hotplug feature, or else limits
> our options in implementing it? In my opinion, we can later implement
> *anything at all*, dependent on new feature bits. We can even decide to
> reject guest feature requests that specify *only* bit#0; which
> practically means disabling guests (using SMIs) that don't conform to
> our VCPU hotlpug implementation.
Why do negotiation if hotplug could be done without it, on hw(QEMU)
side hotplug seems to be implemented sufficiently (but we still missing
SMRR support). The only thing to make hotplug work with OVMF might be
issuing SMI either directly from QEMU or from AML (write into APM_CNT)
after CPU is hotplugged.

> 
> Laszlo
