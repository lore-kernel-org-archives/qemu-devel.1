Received: from eggs.gnu.org ([2001:4830:134:3::10]:44796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1cvwXN-00051d-Hu
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 21:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1cvwXK-0000B3-B8
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 21:48:37 -0400
Received: from [45.249.212.187] (port=3024 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1cvwXJ-00006r-Mr
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 21:48:34 -0400
References: <58CFE56E.9090303@huawei.com>
	<135b6663-b65c-b5ba-d3a8-b2a2127a07fa@redhat.com>
From: "Herongguang (Stephen)" <herongguang.he@huawei.com>
Message-ID: <58E59E29.7070305@huawei.com>
Date: Thu, 6 Apr 2017 09:47:21 +0800
MIME-Version: 1.0
In-Reply-To: <135b6663-b65c-b5ba-d3a8-b2a2127a07fa@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [BUG/RFC] INIT IPI lost when VM starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com, afaerber@suse.de, jan.kiszka@siemens.com, qemu-devel@nongnu.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, wangxinxin.wang@huawei.com, "weidong.huang@huawei.com >> Huangweidong (C)" <weidong.huang@huawei.com>



On 2017/4/6 0:16, Paolo Bonzini wrote:
>
> On 20/03/2017 15:21, Herongguang (Stephen) wrote:
>> We encountered a problem that when a domain starts, seabios failed to
>> online a vCPU.
>>
>> After investigation, we found that the reason is in kvm-kmod,
>> KVM_APIC_INIT bit in
>> vcpu->arch.apic->pending_events was overwritten by qemu, and thus an
>> INIT IPI sent
>> to AP was lost. Qemu does this since libvirtd sends a ‘query-cpus’ qmp
>> command to qemu
>> on VM start.
>>
>> In qemu, qmp_query_cpus-> cpu_synchronize_state->
>> kvm_cpu_synchronize_state->
>> do_kvm_cpu_synchronize_state, qemu gets registers/vcpu_events from
>> kvm-kmod and
>> sets cpu->kvm_vcpu_dirty to true, and vcpu thread in qemu will call
>> kvm_arch_put_registers if cpu->kvm_vcpu_dirty is true, thus
>> pending_events is
>> overwritten by qemu.
>>
>> I think there is no need for qemu to set cpu->kvm_vcpu_dirty to true
>> after ‘query-cpus’,
>> and  kvm-kmod should not clear KVM_APIC_INIT unconditionally. And I am
>> not sure whether
>> it is OK for qemu to set cpu->kvm_vcpu_dirty in
>> do_kvm_cpu_synchronize_state in each caller.
>>
>> What’s your opinion?
> Hi Rongguang,
>
> sorry for the late response.
>
> Where exactly is KVM_APIC_INIT dropped?  kvm_get_mp_state does clear the
> bit, but the result of the INIT is stored in mp_state.

It's dropped in KVM_SET_VCPU_EVENTS, see below.

>
> kvm_get_vcpu_events is called after kvm_get_mp_state; it retrieves
> KVM_APIC_INIT in events.smi.latched_init and kvm_set_vcpu_events passes
> it back.  Maybe it should ignore events.smi.latched_init if not in SMM,
> but I would like to understand the exact sequence of events.

time0:
vcpu1:
qmp_query_cpus-> cpu_synchronize_state-> kvm_cpu_synchronize_state->
 > do_kvm_cpu_synchronize_state(and set vcpu1's cpu->kvm_vcpu_dirty to true)-> kvm_arch_get_registers(KVM_APIC_INIT bit in vcpu->arch.apic->pending_events was not set)

time1:
vcpu0:
send INIT-SIPI to all AP->(in vcpu 0's context)__apic_accept_irq(KVM_APIC_INIT bit in vcpu1's arch.apic->pending_events is set)

time2:
vcpu1:
kvm_cpu_exec->(if cpu->kvm_vcpu_dirty is true)kvm_arch_put_registers->kvm_put_vcpu_events(overwritten KVM_APIC_INIT bit in vcpu->arch.apic->pending_events!)

So it's a race between vcpu1 get/put registers with kvm/other vcpus changing vcpu1's status/structure fields in the mean time, I am in worry of if there are other fields may be overwritten,
sipi_vector is one.

also see: https://www.mail-archive.com/qemu-devel@nongnu.org/msg438675.html

> Thanks,
>
> paolo
>
> .
>
