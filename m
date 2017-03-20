Received: from eggs.gnu.org ([2001:4830:134:3::10]:43337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1cpyCy-00024F-VD
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1cpyCv-0006pl-2E
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:22:53 -0400
Received: from [45.249.212.188] (port=2963 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1cpyCu-0006hR-9v
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:22:48 -0400
From: "Herongguang (Stephen)" <herongguang.he@huawei.com>
Message-ID: <58CFE56E.9090303@huawei.com>
Date: Mon, 20 Mar 2017 22:21:34 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [BUG/RFC] INIT IPI lost when VM starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com, afaerber@suse.de, jan.kiszka@siemens.com, qemu-devel@nongnu.org, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, wangxinxin.wang@huawei.com, "weidong.huang@huawei.com >> Huangweidong (C)" <weidong.huang@huawei.com>

Hi,
We encountered a problem that when a domain starts, seabios failed to online a vCPU.

After investigation, we found that the reason is in kvm-kmod, KVM_APIC_INIT bit in
vcpu->arch.apic->pending_events was overwritten by qemu, and thus an INIT IPI sent
to AP was lost. Qemu does this since libvirtd sends a ‘query-cpus’ qmp command to qemu
on VM start.

In qemu, qmp_query_cpus-> cpu_synchronize_state-> kvm_cpu_synchronize_state->
do_kvm_cpu_synchronize_state, qemu gets registers/vcpu_events from kvm-kmod and
sets cpu->kvm_vcpu_dirty to true, and vcpu thread in qemu will call
kvm_arch_put_registers if cpu->kvm_vcpu_dirty is true, thus pending_events is
overwritten by qemu.

I think there is no need for qemu to set cpu->kvm_vcpu_dirty to true after ‘query-cpus’,
and  kvm-kmod should not clear KVM_APIC_INIT unconditionally. And I am not sure whether
it is OK for qemu to set cpu->kvm_vcpu_dirty in do_kvm_cpu_synchronize_state in each caller.

What’s your opinion?
