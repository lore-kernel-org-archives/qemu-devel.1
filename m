Received: from eggs.gnu.org ([2001:4830:134:3::10]:49927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1cqAaZ-000516-CS
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1cqAaV-000294-Ru
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:36:03 -0400
Received: from [45.249.212.189] (port=2863 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <herongguang.he@huawei.com>) id 1cqAaU-000210-Gy
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:35:59 -0400
References: <58CFE56E.9090303@huawei.com>
From: "Herongguang (Stephen)" <herongguang.he@huawei.com>
Message-ID: <58D09F48.9010809@huawei.com>
Date: Tue, 21 Mar 2017 11:34:32 +0800
MIME-Version: 1.0
In-Reply-To: <58CFE56E.9090303@huawei.com>
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

Let me clarify it more clearly. Time sequence is that qemu handles ‘query-cpus’ qmp command, vcpu 1 (and vcpu 0) got registers from kvm-kmod (qmp_query_cpus-> cpu_synchronize_state-> kvm_cpu_synchronize_state->
 > do_kvm_cpu_synchronize_state-> kvm_arch_get_registers), then vcpu 0 (BSP) sends INIT-SIPI to vcpu 1(AP). In kvm-kmod, vcpu 1’s pending_events’s KVM_APIC_INIT bit set.
Then vcpu 1 continue running, vcpu1 thread in qemu calls kvm_arch_put_registers-> kvm_put_vcpu_events, so KVM_APIC_INIT bit in vcpu 1’s pending_events got cleared, i.e., lost.

In kvm-kmod, except for pending_events, sipi_vector may also be overwritten., so I am not sure if there are other fields/registers in danger, i.e., those may be modified asynchronously with vcpu thread itself.

BTW, using a sleep like following can reliably reproduce this problem, if VM equipped with more than 2 vcpus and starting VM using libvirtd.

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 55865db..5099290 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2534,6 +2534,11 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
              KVM_VCPUEVENT_VALID_NMI_PENDING | KVM_VCPUEVENT_VALID_SIPI_VECTOR;
      }

+    if (CPU(cpu)->cpu_index == 1) {
+        fprintf(stderr, "vcpu 1 sleep!!!!\n");
+        sleep(10);
+    }
+
      return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
  }


On 2017/3/20 22:21, Herongguang (Stephen) wrote:
> Hi,
> We encountered a problem that when a domain starts, seabios failed to online a vCPU.
>
> After investigation, we found that the reason is in kvm-kmod, KVM_APIC_INIT bit in
> vcpu->arch.apic->pending_events was overwritten by qemu, and thus an INIT IPI sent
> to AP was lost. Qemu does this since libvirtd sends a ‘query-cpus’ qmp command to qemu
> on VM start.
>
> In qemu, qmp_query_cpus-> cpu_synchronize_state-> kvm_cpu_synchronize_state->
> do_kvm_cpu_synchronize_state, qemu gets registers/vcpu_events from kvm-kmod and
> sets cpu->kvm_vcpu_dirty to true, and vcpu thread in qemu will call
> kvm_arch_put_registers if cpu->kvm_vcpu_dirty is true, thus pending_events is
> overwritten by qemu.
>
> I think there is no need for qemu to set cpu->kvm_vcpu_dirty to true after ‘query-cpus’,
> and  kvm-kmod should not clear KVM_APIC_INIT unconditionally. And I am not sure whether
> it is OK for qemu to set cpu->kvm_vcpu_dirty in do_kvm_cpu_synchronize_state in each caller.
>
> What’s your opinion?
>
