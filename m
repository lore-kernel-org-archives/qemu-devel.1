Received: from eggs.gnu.org ([2001:4830:134:3::10]:41350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dQZDZ-0001zc-Id
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dQZDW-0006wn-Pq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:10:45 -0400
Received: from mail-he1eur01on0130.outbound.protection.outlook.com
	([104.47.0.130]:13920
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dQZDV-0006uI-W8
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:10:42 -0400
Date: Thu, 29 Jun 2017 16:10:20 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170629131019.GC2973@rkaganb.sw.ru>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
	<20170621162424.10462-8-rkagan@virtuozzo.com>
	<20170628164743.0df730a0@nial.brq.redhat.com>
	<20170629095326.GA2973@rkaganb.sw.ru>
	<20170629135329.0c2dcd70@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629135329.0c2dcd70@nial.brq.redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Thu, Jun 29, 2017 at 01:53:29PM +0200, Igor Mammedov wrote:
> On Thu, 29 Jun 2017 12:53:27 +0300
> Roman Kagan <rkagan@virtuozzo.com> wrote:
> 
> > On Wed, Jun 28, 2017 at 04:47:43PM +0200, Igor Mammedov wrote:
> > > On Wed, 21 Jun 2017 19:24:08 +0300
> > > Roman Kagan <rkagan@virtuozzo.com> wrote:
> > >   
> > > > Hyper-V identifies vCPUs by Virtual Processor (VP) index which can be
> > > > queried by the guest via HV_X64_MSR_VP_INDEX msr.  It is defined by the
> > > > spec as a sequential number which can't exceed the maximum number of
> > > > vCPUs per VM.
> > > > 
> > > > It has to be owned by QEMU in order to preserve it across migration.
> > > > 
> > > > However, the initial implementation in KVM didn't allow to set this
> > > > msr, and KVM used its own notion of VP index.  Fortunately, the way
> > > > vCPUs are created in QEMU/KVM makes it likely that the KVM value is
> > > > equal to QEMU cpu_index.
> > > > 
> > > > So choose cpu_index as the value for vp_index, and push that to KVM on
> > > > kernels that support setting the msr.  On older ones that don't, query
> > > > the kernel value and assert that it's in sync with QEMU.
> > > > 
> > > > Besides, since handling errors from vCPU init at hotplug time is
> > > > impossible, disable vCPU hotplug.  
> > > proper place to check if cpu might be created is at 
> > > pc_cpu_pre_plug() where you can gracefully abort cpu creation process.   
> > 
> > Thanks for the suggestion, I'll rework it this way.
> > 
> > > Also it's possible to create cold-plugged CPUs in out of order
> > > sequence using
> > >  -device cpu-foo on CLI
> > > will be hyperv kvm/guest side ok with it?  
> > 
> > On kernels that support setting HV_X64_MSR_VP_INDEX QEMU will
> > synchronize all sides.  On kernels that don't, if out-of-order creation
> > results in vp_index mismatch between the kernel and QEMU, vcpu creation
> > will fail.
> 
> And additional question,
> what would happen if VM is started on host supporting VP index setting
> and then migrated to a host without it?

The destination QEMU will attempt to initialize vCPUs, and if that
fails (e.g. due to vp_index mismatch), the migration will be aborted and
the source VM will continue running.

If the destination QEMU is old, too, there's a chance that vp_index will
change.  Then we just keep the fingers crossed that the guest doesn't
notice (this is the behavior we have now).

> > > > +X86CPU *hyperv_find_vcpu(uint32_t vp_index)
> > > > +{
> > > > +    return X86_CPU(qemu_get_cpu(vp_index));
> > > > +}  
> > > this helper isn't used in this patch, add it in the patch that would actually use it  
> > 
> > I thought I would put the only two functions that encapsulate the
> > knowledge of how vp_index is realted to cpu_index, in a single patch.
> > 
> > I'm now thinking of open-coding the iteration over cpus here and
> > directly look for cpu whose hyperv_vp_index() matches.  Then that
> > knowledge will become encapsulated in a single place, and indeed, this
> > helper can go into another patch where it's used.
> > 
> > > also if  qemu_get_cpu() were called from each CPU init,
> > > it would incur O(N^2) complexity, could you do without it?  
> > 
> > It isn't called on hot paths (ATM it's called only when SINT routes are
> > created, which is at most one per cpu).  I don't see a problem here.
> For what/where do you need this lookup?

The guest configures devices to signal their events with synthetic
interrupts on specific cpus, identified by vp_index.  When we receive
such a request we look up the cpu and set up a SINT route to be able to
deliver interrupts to its synic.

Or did I misunderstand the question perhaps?

> > > maybe split all renaming into separate patch ...  
> > 
> > Part of the renaming will disappear eventually in the followup patches,
> > so I'm sure it's a good idea...  Opinions?
> I'd still spit. not to distract reviewers from
> what this patch is actually tries to accomplish at least

OK, makes sense.

> > > > +        ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, &msr_data);
> > > > +        if (ret < 0) {  
> > > when this can fail?  
> > 
> > Dunno, but not checking for errors doesn't look good.
> Point of asking is to confirm that call shouldn't fail normally and
> if it fails it's we can't recover and should die.
> 
> Looking at condition above !is_hv_vpindex_settable it looks like
> call wouldn't fail. (i.e. it makes sure that qemu is running on
> supported kernel)

No, I do KVM_GET_MSRS here, which is supported since this msr was
introduced.

But actually you've spot a bug which I meant to fix but forgot: the code
in hyperv_handle_properties should fail if a particular hyperv feature
is requested but the corresponding msr isn't found among reported via
KVM_GET_MSR_INDEX_LIST.  ATM this is only done for some features but not
all.

I'll try to fix that; once done, cpu->hyperv_vpindex here will make sure
this msr is gettable.

Thanks,
Roman.
