Received: from eggs.gnu.org ([2001:4830:134:3::10]:41883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dQY10-0005NQ-54
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dQY0v-0005Sr-9K
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:53:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dQY0v-0005ST-0C
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:53:37 -0400
Date: Thu, 29 Jun 2017 13:53:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170629135329.0c2dcd70@nial.brq.redhat.com>
In-Reply-To: <20170629095326.GA2973@rkaganb.sw.ru>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
	<20170621162424.10462-8-rkagan@virtuozzo.com>
	<20170628164743.0df730a0@nial.brq.redhat.com>
	<20170629095326.GA2973@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/23] hyperv: ensure VP index equal to
 QEMU cpu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Thu, 29 Jun 2017 12:53:27 +0300
Roman Kagan <rkagan@virtuozzo.com> wrote:

> On Wed, Jun 28, 2017 at 04:47:43PM +0200, Igor Mammedov wrote:
> > On Wed, 21 Jun 2017 19:24:08 +0300
> > Roman Kagan <rkagan@virtuozzo.com> wrote:
> >   
> > > Hyper-V identifies vCPUs by Virtual Processor (VP) index which can be
> > > queried by the guest via HV_X64_MSR_VP_INDEX msr.  It is defined by the
> > > spec as a sequential number which can't exceed the maximum number of
> > > vCPUs per VM.
> > > 
> > > It has to be owned by QEMU in order to preserve it across migration.
> > > 
> > > However, the initial implementation in KVM didn't allow to set this
> > > msr, and KVM used its own notion of VP index.  Fortunately, the way
> > > vCPUs are created in QEMU/KVM makes it likely that the KVM value is
> > > equal to QEMU cpu_index.
> > > 
> > > So choose cpu_index as the value for vp_index, and push that to KVM on
> > > kernels that support setting the msr.  On older ones that don't, query
> > > the kernel value and assert that it's in sync with QEMU.
> > > 
> > > Besides, since handling errors from vCPU init at hotplug time is
> > > impossible, disable vCPU hotplug.  
> > proper place to check if cpu might be created is at 
> > pc_cpu_pre_plug() where you can gracefully abort cpu creation process.   
> 
> Thanks for the suggestion, I'll rework it this way.
> 
> > Also it's possible to create cold-plugged CPUs in out of order
> > sequence using
> >  -device cpu-foo on CLI
> > will be hyperv kvm/guest side ok with it?  
> 
> On kernels that support setting HV_X64_MSR_VP_INDEX QEMU will
> synchronize all sides.  On kernels that don't, if out-of-order creation
> results in vp_index mismatch between the kernel and QEMU, vcpu creation
> will fail.

And additional question,
what would happen if VM is started on host supporting VP index setting
and then migrated to a host without it?

> 
> > > This patch also introduces accessor functions to wrap the mapping
> > > between a vCPU and its vp_index.  Besides, a few variables are renamed
> > > to avoid confusion of vp_index with vcpu_id (== apic_id).
> > > 
> > > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> > > ---
> > > v1 -> v2:
> > >  - were patches 5, 6 in v1
> > >  - move vp_index initialization to hyperv_init_vcpu
> > >  - check capability before trying to set the msr
> > >  - set the msr on the usual kvm_put_msrs path
> > >  - disable cpu hotplug if msr is not settable
> > > 
> > >  target/i386/hyperv.h |  5 ++++-
> > >  target/i386/hyperv.c | 16 +++++++++++++---
> > >  target/i386/kvm.c    | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 68 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
> > > index 0c3b562..82f4757 100644
> > > --- a/target/i386/hyperv.h
> > > +++ b/target/i386/hyperv.h
> > > @@ -32,11 +32,14 @@ struct HvSintRoute {
> > >  
> > >  int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
> > >  
> > > -HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
> > > +HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
> > >                                        HvSintAckClb sint_ack_clb);
> > >  
> > >  void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
> > >  
> > >  int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
> > >  
> > > +uint32_t hyperv_vp_index(X86CPU *cpu);
> > > +X86CPU *hyperv_find_vcpu(uint32_t vp_index);
> > > +
> > >  #endif
> > > diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
> > > index 227185c..4f57447 100644
> > > --- a/target/i386/hyperv.c
> > > +++ b/target/i386/hyperv.c
> > > @@ -16,6 +16,16 @@
> > >  #include "hyperv.h"
> > >  #include "hyperv_proto.h"
> > >  
> > > +uint32_t hyperv_vp_index(X86CPU *cpu)
> > > +{
> > > +    return CPU(cpu)->cpu_index;
> > > +}  
> > 
> >   
> > > +X86CPU *hyperv_find_vcpu(uint32_t vp_index)
> > > +{
> > > +    return X86_CPU(qemu_get_cpu(vp_index));
> > > +}  
> > this helper isn't used in this patch, add it in the patch that would actually use it  
> 
> I thought I would put the only two functions that encapsulate the
> knowledge of how vp_index is realted to cpu_index, in a single patch.
> 
> I'm now thinking of open-coding the iteration over cpus here and
> directly look for cpu whose hyperv_vp_index() matches.  Then that
> knowledge will become encapsulated in a single place, and indeed, this
> helper can go into another patch where it's used.
> 
> > also if  qemu_get_cpu() were called from each CPU init,
> > it would incur O(N^2) complexity, could you do without it?  
> 
> It isn't called on hot paths (ATM it's called only when SINT routes are
> created, which is at most one per cpu).  I don't see a problem here.
For what/where do you need this lookup?

> 
> > > @@ -105,7 +115,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
> > >      }
> > >      sint_route->gsi = gsi;
> > >      sint_route->sint_ack_clb = sint_ack_clb;
> > > -    sint_route->vcpu_id = vcpu_id;
> > > +    sint_route->vcpu_id = vp_index;  
> >                    ^^^ - shouldn't it also be re-named?  
> 
> Right, but vcpu_id on sint_route is replaced with X86CPU pointer in a
> followup patch, so I wasn't sure if it was worth while to add more
> churn...
> 
> > 
> > maybe split all renaming into separate patch ...  
> 
> Part of the renaming will disappear eventually in the followup patches,
> so I'm sure it's a good idea...  Opinions?
I'd still spit. not to distract reviewers from
what this patch is actually tries to accomplish at least

> 
> > > +static int hyperv_init_vcpu(X86CPU *cpu)
> > > +{
> > > +    if (cpu->hyperv_vpindex && !is_hv_vpindex_settable) {
> > > +        /*
> > > +         * the kernel doesn't support setting vp_index; assert that its value
> > > +         * is in sync
> > > +         */
> > > +        int ret;
> > > +        struct {
> > > +            struct kvm_msrs info;
> > > +            struct kvm_msr_entry entries[1];
> > > +        } msr_data = {
> > > +            .info.nmsrs = 1,
> > > +            .entries[0].index = HV_X64_MSR_VP_INDEX,
> > > +        };
> > > +
> > > +        /*
> > > +         * handling errors from vcpu init at hotplug time is impossible, so
> > > +         * disallow cpu hotplug
> > > +         */
> > > +        MACHINE_GET_CLASS(current_machine)->hot_add_cpu = NULL;  
> > one shouldn't alter machine this way nor
> > it would disable cpu hotplug, it would disable only cpu-add interface
> > but device_add() would still work.  
> 
> Understood, will rework as you suggest above.
> 
> > > +        ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, &msr_data);
> > > +        if (ret < 0) {  
> > when this can fail?  
> 
> Dunno, but not checking for errors doesn't look good.
Point of asking is to confirm that call shouldn't fail normally and
if it fails it's we can't recover and should die.

Looking at condition above !is_hv_vpindex_settable it looks like
call wouldn't fail. (i.e. it makes sure that qemu is running on
supported kernel)

> 
> > > +            return ret;
> > > +        }
> > > +        assert(ret == 1);
> > > +
> > > +        if (msr_data.entries[0].data != hyperv_vp_index(cpu)) {
> > > +            fprintf(stderr, "kernel's vp_index != QEMU's vp_index\n");  
> > error_report()  
> 
> OK (target/i386/kvm.c is already a mix of all possible styles of error
> reporting, I must've followed a wrong one).
> 
> Thanks,
> Roman.
