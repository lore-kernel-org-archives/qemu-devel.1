Received: from eggs.gnu.org ([2001:4830:134:3::10]:42561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ez4BO-0006w5-6G
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ez4BJ-0001wF-R7
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:39:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ez4BJ-0001tp-Ke
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:39:17 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20180320173500.32065-1-vkuznets@redhat.com>
	<20180320173500.32065-2-vkuznets@redhat.com>
	<20180322170920.GA23446@amt.cnet>
Date: Thu, 22 Mar 2018 18:39:09 +0100
In-Reply-To: <20180322170920.GA23446@amt.cnet> (Marcelo Tosatti's message of
	"Thu, 22 Mar 2018 14:09:21 -0300")
Message-ID: <87efkc57sy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/2] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Roman Kagan <rkagan@virtuozzo.com>

Marcelo Tosatti <mtosatti@redhat.com> writes:

> On Tue, Mar 20, 2018 at 06:34:59PM +0100, Vitaly Kuznetsov wrote:
>> KVM recently gained support for Hyper-V Reenlightenment MSRs which are
>> required to make KVM-on-Hyper-V enable TSC page clocksource to its guests
>> when INVTSC is not passed to it (and it is not passed by default in Qemu
>> as it effectively blocks migration).
>
> Hi Vitaly,
>
> From Microsoft's documentation:
>
> "An L1 hypervisor can request to be notified when its partition is
> migrated. This capability is enumerated in CPUID as
> AccessReenlightenmentControls privilege (see 2.4.10)."
>
> The L0 hypervisor exposes a synthetic MSR
> (HV_X64_MSR_REENLIGHTENMENT_CONTROL) that may be used by the L1
> hypervisor to configure an interrupt vector and target processor. The L0
> hypervisor will inject an interrupt with the specified vector after each
> migration.
>
> What prevents a guest from setting the enable bit, and expect
> to receive an interrupt, if the reenlightenment MSRs are exposed ?
>

This is actually desired: Hyper-V on KVM will set this bit and expect to
receive an interrupt. Currently, we don't send it because we don't
migrate nested workloads but eventually, when we learn how to do this in
KVM, sending an interrupt and doint TSC access emulation will be required.

Normal Windows on KVM won't use the feature as it doesn't need it: upon
migration we update TSC page in KVM and readings from it stay correct.

-- 
  Vitaly
