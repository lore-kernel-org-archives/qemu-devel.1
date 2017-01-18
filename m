Received: from eggs.gnu.org ([2001:4830:134:3::10]:41200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTpVt-0007dJ-Sq
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cTpVq-0002c3-ND
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:38:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cTpVq-0002b4-E2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:38:50 -0500
Date: Wed, 18 Jan 2017 13:38:44 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170118133844.75422b55@nial.brq.redhat.com>
In-Reply-To: <e94a097e-274b-b26a-ec89-70929c422c69@redhat.com>
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

On Wed, 18 Jan 2017 11:23:48 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 01/18/17 11:19, Laszlo Ersek wrote:
> > On 01/18/17 11:03, Igor Mammedov wrote:  
> >> On Tue, 17 Jan 2017 19:53:21 +0100
> >> Laszlo Ersek <lersek@redhat.com> wrote:
> >>  
> 
> [snip]
> 
> >>> This is the code I wrote (extracting a new ich9_apm_broadcast_smi()
> >>> function from ich9_apm_ctrl_changed(), due to size reasons):
> >>>  
> >>>> static void ich9_apm_broadcast_smi(void)
> >>>> {
> >>>>     CPUState *cs;
> >>>>
> >>>>     cpu_synchronize_all_states(); /* <--------- mark this */  
> >> it probably should be executed after pause_all_vcpus(),
> >> maybe it will help.
> >>  
> >>>>     CPU_FOREACH(cs) {
> >>>>         X86CPU *cpu = X86_CPU(cs);
> >>>>         CPUX86State *env = &cpu->env;
> >>>>
> >>>>         if (env->smbase == 0x30000 && env->eip == 0xfff0) {
> >>>>             CPUClass *k = CPU_GET_CLASS(cs);
> >>>>             uint64_t cpu_arch_id = k->get_arch_id(cs);
> >>>>
> >>>>             trace_ich9_apm_broadcast_smi_skip(cpu_arch_id);
> >>>>             continue;
> >>>>         }
> >>>>
> >>>>         cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> >>>>     }
> >>>> }    
> >>>  
> >> [...]  
> >>> (b) If I add the cpu_synchronize_all_states() call before the loop, then
> >>> the incorrect filter matches go away; QEMU sees the KVM VCPU states
> >>> correctly, and the SMI is broad-cast.
> >>>
> >>> However, in this case, the boot slows to a *crawl*. It's unbearable. All
> >>> VCPUs are pegged at 100%, and you can easily follow the OVMF debug log
> >>> with the naked eye, almost line by line.
> >>> I didn't expect that cpu_synchronize_all_states() would be so costly,
> >>> but it makes the idea of checking VCPU state in the APM_CNT handler a
> >>> non-starter.  
> >> I wonder were bottleneck is to slow down guest so much.
> >> What is actual cost of calling cpu_synchronize_all_states()?
> >>
> >> Maybe calling pause_all_vcpus() before cpu_synchronize_all_states()
> >> would help.  
> > 
> > If I prepend just a pause_all_vcpus() function call, at the top, then
> > the VM freezes (quite understandably) when the first SMI is raised via
> > APM_CNT.
> > 
> > If I, instead, bracket the function body with pause_all_vcpus() and
> > resume_all_vcpus(), like this:
> > 
> > static void ich9_apm_broadcast_smi(void)
> > {
> >     CPUState *cs;
> > 
> >     pause_all_vcpus();
> >     cpu_synchronize_all_states();
> >     CPU_FOREACH(cs) {
> >         X86CPU *cpu = X86_CPU(cs);
> >         CPUX86State *env = &cpu->env;
> > 
> >         if (env->smbase == 0x30000 && env->eip == 0xfff0) {
> >             CPUClass *k = CPU_GET_CLASS(cs);
> >             uint64_t cpu_arch_id = k->get_arch_id(cs);
> > 
> >             trace_ich9_apm_broadcast_smi_skip(cpu_arch_id);
> >             continue;
> >         }
> > 
> >         cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> >     }
> >     resume_all_vcpus();
> > }
> > 
> > then I see the following symptoms:
> > - rather than 4 VCPUs being pegged at 100%, only one VCPU is pegged at
> >   100%
> > - the boot process, as observed from the OVMF log, is just as slow
> >   (= crawling) as without the VCPU pausing/resuming (i.e., like with
> >   cpu_synchronize_all_states() only); so ultimately the
> >   pausing/resuming doesn't help.  
> 
> I also tried this variant (bracketing only the sync call with pause/resume):
> 
> static void ich9_apm_broadcast_smi(void)
> {
>     CPUState *cs;
> 
>     pause_all_vcpus();
>     cpu_synchronize_all_states();
>     resume_all_vcpus();
>     CPU_FOREACH(cs) {
>         X86CPU *cpu = X86_CPU(cs);
>         CPUX86State *env = &cpu->env;
> 
>         if (env->smbase == 0x30000 && env->eip == 0xfff0) {
>             CPUClass *k = CPU_GET_CLASS(cs);
>             uint64_t cpu_arch_id = k->get_arch_id(cs);
> 
>             trace_ich9_apm_broadcast_smi_skip(cpu_arch_id);
>             continue;
>         }
> 
>         cpu_interrupt(cs, CPU_INTERRUPT_SMI);
>     }
> }
> 
> This behaves identically to the version where pause/resume bracket the
> entire function body (i.e., 1 VCPU pegged, super-slow boot progress).
wrapping entire function into pause_all_vcpus()/resume_all_vcpus()
looks better as then cpu_interrupt() would not need to send IPIs to CPUs
since pause_all_vcpus() would have done it.

So the left question is what this 1 CPU does to make things so slow.
Does it send a lot of SMIs or something else?
