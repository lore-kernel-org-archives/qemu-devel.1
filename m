Received: from eggs.gnu.org ([2001:4830:134:3::10]:57947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL8SX-0000mn-IT
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL8SU-0006UY-5M
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:35:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dL8ST-0006Tj-TH
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:35:42 -0400
Date: Wed, 14 Jun 2017 10:35:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170614133536.GG5016@thinpad.lan.raisama.net>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-6-rkagan@virtuozzo.com>
	<20170613185752.GZ5016@thinpad.lan.raisama.net>
	<20170614112506.GI2004@rkaganb.sw.ru>
	<20170614130015.GC5016@thinpad.lan.raisama.net>
	<20170614152450.199121ee@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614152450.199121ee@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/23] hyperv: ensure VP index equal to
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed, Jun 14, 2017 at 03:24:50PM +0200, Igor Mammedov wrote:
> On Wed, 14 Jun 2017 10:00:15 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, Jun 14, 2017 at 02:25:07PM +0300, Roman Kagan wrote:
> > > On Tue, Jun 13, 2017 at 03:57:52PM -0300, Eduardo Habkost wrote:  
> > > > On Tue, Jun 06, 2017 at 09:19:30PM +0300, Roman Kagan wrote:  
> > > > > Hyper-V identifies vcpus by the virtual processor (VP) index which is
> > > > > normally queried by the guest via HV_X64_MSR_VP_INDEX msr.
> > > > > 
> > > > > It has to be owned by QEMU in order to preserve it across migration.
> > > > > 
> > > > > However, the current implementation in KVM doesn't allow to set this
> > > > > msr, and KVM uses its own notion of VP index.  Fortunately, the way
> > > > > vcpus are created in QEMU/KVM basically guarantees that the KVM value is
> > > > > equal to QEMU cpu_index.  
> > > > 
> > > > This might not be true in the future.  cpu_index is not a good
> > > > identifier for CPUs, and we would like to remove it in the
> > > > future.
> > > > 
> > > > But it looks like we have no choice, see extra comments below:  
> > >   
> > > > > +static void hyperv_set_vp_index(CPUState *cs)
> > > > > +{
> > > > > +    struct {
> > > > > +        struct kvm_msrs info;
> > > > > +        struct kvm_msr_entry entries[1];
> > > > > +    } msr_data;
> > > > > +    int ret;
> > > > > +
> > > > > +    msr_data.info.nmsrs = 1;
> > > > > +    msr_data.entries[0].index = HV_X64_MSR_VP_INDEX;
> > > > > +
> > > > > +    /*
> > > > > +     * Some kernels don't support setting HV_X64_MSR_VP_INDEX.  However,
> > > > > +     * they use VP_INDEX equal to cpu_index due to the way vcpus are created.
> > > > > +     * So ignore the errors from SET_MSRS, but verify that GET_MSRS returns the
> > > > > +     * expected value.
> > > > > +     */  
> > > > 
> > > > Oh.  This sounds like a problem.  As reference for others, this
> > > > is the KVM code in kvm_hv_get_msr():
> > > > 
> > > > 	case HV_X64_MSR_VP_INDEX: {
> > > > 		int r;
> > > > 		struct kvm_vcpu *v;
> > > > 
> > > > 		kvm_for_each_vcpu(r, v, vcpu->kvm) {
> > > > 			if (v == vcpu) {
> > > > 				data = r;
> > > > 				break;
> > > > 			}
> > > > 		}
> > > > 		break;
> > > > 	}
> > > > 
> > > > The problem with that is that it will break as soon as we create
> > > > VCPUs in a different order.  Unsolvable on hosts that don't allow
> > > > HV_X64_MSR_VP_INDEX to be set, however.  
> > > 
> > > Right, thanks for putting together a detailed explanation.
> > > 
> > > This was a thinko back then, not to have HV_X64_MSR_VP_INDEX maintained
> > > by QEMU.  I'm going to post a patch to KVM fixing that.
> > > 
> > > Meanwhile QEMU needs a way to maintain its notion of vp_index that is
> > >   1) in sync with kernel's notion
> > >   2) also with kernels that don't support setting the msr
> > >   3) persistent across migrations
> > > 
> > > cpu_index looked like a perfect candidate.  
> > 
> > I would like to be able to stop using cpu_index as a persistent
> > VCPU identifier in the future.  I would also like to be able to
> > create VCPUs in any order without breaking guest ABI.  But it
> > seems to be impossible to do that without breaking vp_index on
> > older kernels.
> > 
> > So cpu_index looks like the only candidate we have.
> > 
> > >   
> > > > > +    msr_data.entries[0].data = cs->cpu_index;
> > > > > +    kvm_vcpu_ioctl(cs, KVM_SET_MSRS, &msr_data);
> > > > > +    ret = kvm_vcpu_ioctl(cs, KVM_GET_MSRS, &msr_data);
> > > > > +    assert(ret == 1);
> > > > > +    assert(msr_data.entries[0].data == cs->cpu_index);  
> > > > 
> > > > If KVM already initializes the MSR to cpu_index and we will abort
> > > > if it was not set to anything except cpu_index here, why exactly
> > > > do we need the KVM_SET_MSRS call?  
> > > 
> > > The kernel made no obligations to keep initializing its vp_index
> > > identically to QEMU's cpu_index.  So we'd better check and abort if that
> > > got out of sync.  Once KVM gains the ability to learn vp_index from QEMU
> > > we'll no longer depend on that as we'll do explicit synchronization.  
> > 
> > I think the kernel now has an obligation to keep initializing
> > HV_X64_MSR_VP_INDEX in a compatible way, or it will break older
> > QEMU versions that don't set the MSR.
> > 
> > But if you don't think we can rely on that, then the KVM_SET_MSRS
> > call won't hurt.
> 
> if we can tell apart old index based vp_index kernel and new that supports
> MSR setting (add cap check perhaps) then we should be able to
>  - leave out old vp_index broken as it is now (for old kernels/old QEMU and/ new QEMU old machine types)
>      i.e. do not set vp_index MSR in QEMU
>  - in case of (new QEMU new machine type/new kernel) use APIC ID which would work
>    with out of order CPU creation

I agree with the proposal, but I don't see the need for a
capability check:

Old machine-types can simply not call KVM_SET_MSRS, as you
suggested.

New machine-types can just call KVM_SET_MSRS unconditionally, and
warn the user in case the it fails and the APIC ID really doesn't
match the index in KVM (which in practice will happen only if the
user is also configuring a CPU topology explicitly).

-- 
Eduardo
