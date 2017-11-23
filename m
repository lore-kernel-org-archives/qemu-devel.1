Received: from eggs.gnu.org ([2001:4830:134:3::10]:38244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1eHtcv-0006CF-C4
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1eHtcs-0001Th-1d
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:41:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1eHtcr-0001SZ-Pc
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:41:17 -0500
Date: Thu, 23 Nov 2017 16:41:12 +0100
From: "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Message-ID: <20171123154111.GC21279@flask>
References: <58CFE56E.9090303@huawei.com>
	<135b6663-b65c-b5ba-d3a8-b2a2127a07fa@redhat.com>
	<58E59E29.7070305@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA4964D4@DGGEMA505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA4964D4@DGGEMA505-MBS.china.huawei.com>
Subject: Re: [Qemu-devel] [BUG/RFC] INIT IPI lost when VM starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "afaerber@suse.de" <afaerber@suse.de>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, linzhecheng <linzhecheng@huawei.com>

2017-11-20 06:57+0000, Gonglei (Arei):
> Hi Paolo,
> 
> What's your opinion about this patch? We found it just before finishing patches 
> for the past two days.

I think your case was fixed by f4ef19108608 ("KVM: X86: Fix loss of
pending INIT due to race"), but that patch didn't fix it perfectly, so
maybe you're hitting a similar case that happens in SMM ...

> > -----Original Message-----
> > From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On
> > Behalf Of Herongguang (Stephen)
> > On 2017/4/6 0:16, Paolo Bonzini wrote:
> > > Hi Rongguang,
> > >
> > > sorry for the late response.
> > >
> > > Where exactly is KVM_APIC_INIT dropped?  kvm_get_mp_state does clear
> > the
> > > bit, but the result of the INIT is stored in mp_state.
> > 
> > It's dropped in KVM_SET_VCPU_EVENTS, see below.
> > 
> > >
> > > kvm_get_vcpu_events is called after kvm_get_mp_state; it retrieves
> > > KVM_APIC_INIT in events.smi.latched_init and kvm_set_vcpu_events passes
> > > it back.  Maybe it should ignore events.smi.latched_init if not in SMM,
> > > but I would like to understand the exact sequence of events.
> > 
> > time0:
> > vcpu1:
> > qmp_query_cpus-> cpu_synchronize_state-> kvm_cpu_synchronize_state->
> >  > do_kvm_cpu_synchronize_state(and set vcpu1's cpu->kvm_vcpu_dirty to
> > true)-> kvm_arch_get_registers(KVM_APIC_INIT bit in
> > vcpu->arch.apic->pending_events was not set)
> > 
> > time1:
> > vcpu0:
> > send INIT-SIPI to all AP->(in vcpu 0's
> > context)__apic_accept_irq(KVM_APIC_INIT bit in vcpu1's
> > arch.apic->pending_events is set)
> > 
> > time2:
> > vcpu1:
> > kvm_cpu_exec->(if cpu->kvm_vcpu_dirty is
> > true)kvm_arch_put_registers->kvm_put_vcpu_events(overwritten
> > KVM_APIC_INIT bit in vcpu->arch.apic->pending_events!)
> > 
> > So it's a race between vcpu1 get/put registers with kvm/other vcpus changing
> > vcpu1's status/structure fields in the mean time, I am in worry of if there are
> > other fields may be overwritten,
> > sipi_vector is one.

Fields that can be asynchronously written by other VCPUs (like SIPI,
NMI) must not be SET if other VCPUs were not paused since the last GET.
(Looking at the interface, we can currently lose pending SMI.)

INIT is one of the restricted fields, but the API unconditionally
couples SMM with latched INIT, which means that we can lose an INIT if
the VCPU is in SMM mode -- do you see SMM in kvm_vcpu_events?

Thanks.
