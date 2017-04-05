Received: from eggs.gnu.org ([2001:4830:134:3::10]:54823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvnbR-0004KT-Td
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvnbO-0004mV-M0
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:16:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvnbO-0004mF-G5
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:16:10 -0400
References: <58CFE56E.9090303@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <135b6663-b65c-b5ba-d3a8-b2a2127a07fa@redhat.com>
Date: Wed, 5 Apr 2017 18:16:05 +0200
MIME-Version: 1.0
In-Reply-To: <58CFE56E.9090303@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [BUG/RFC] INIT IPI lost when VM starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Herongguang (Stephen)" <herongguang.he@huawei.com>, rkrcmar@redhat.com, afaerber@suse.de, jan.kiszka@siemens.com, qemu-devel@nongnu.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, wangxinxin.wang@huawei.com, "weidong.huang@huawei.com >> Huangweidong (C)" <weidong.huang@huawei.com>



On 20/03/2017 15:21, Herongguang (Stephen) wrote:
>=20
> We encountered a problem that when a domain starts, seabios failed to
> online a vCPU.
>=20
> After investigation, we found that the reason is in kvm-kmod,
> KVM_APIC_INIT bit in
> vcpu->arch.apic->pending_events was overwritten by qemu, and thus an
> INIT IPI sent
> to AP was lost. Qemu does this since libvirtd sends a =E2=80=98query-cp=
us=E2=80=99 qmp
> command to qemu
> on VM start.
>=20
> In qemu, qmp_query_cpus-> cpu_synchronize_state->
> kvm_cpu_synchronize_state->
> do_kvm_cpu_synchronize_state, qemu gets registers/vcpu_events from
> kvm-kmod and
> sets cpu->kvm_vcpu_dirty to true, and vcpu thread in qemu will call
> kvm_arch_put_registers if cpu->kvm_vcpu_dirty is true, thus
> pending_events is
> overwritten by qemu.
>=20
> I think there is no need for qemu to set cpu->kvm_vcpu_dirty to true
> after =E2=80=98query-cpus=E2=80=99,
> and  kvm-kmod should not clear KVM_APIC_INIT unconditionally. And I am
> not sure whether
> it is OK for qemu to set cpu->kvm_vcpu_dirty in
> do_kvm_cpu_synchronize_state in each caller.
>=20
> What=E2=80=99s your opinion?

Hi Rongguang,

sorry for the late response.

Where exactly is KVM_APIC_INIT dropped?  kvm_get_mp_state does clear the
bit, but the result of the INIT is stored in mp_state.

kvm_get_vcpu_events is called after kvm_get_mp_state; it retrieves
KVM_APIC_INIT in events.smi.latched_init and kvm_set_vcpu_events passes
it back.  Maybe it should ignore events.smi.latched_init if not in SMM,
but I would like to understand the exact sequence of events.

Thanks,

paolo
