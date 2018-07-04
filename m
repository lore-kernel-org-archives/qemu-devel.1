Received: from eggs.gnu.org ([2001:4830:134:3::10]:33820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fakAG-0002rL-5m
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fakAD-0003V4-3S
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:57:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47342
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fakAC-0003Uc-S9
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:57:53 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-25-git-send-email-suzuki.poulose@arm.com>
	<20180704142241.GG4828@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <66e93016-91bd-5fbb-2479-9f1d87795e5e@arm.com>
Date: Wed, 4 Jul 2018 16:58:12 +0100
MIME-Version: 1.0
In-Reply-To: <20180704142241.GG4828@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [kvmtool test PATCH 24/24] kvmtool: arm: Add
 support for creating VM with PA size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org

Hi Will,

On 07/04/2018 03:22 PM, Will Deacon wrote:
> On Fri, Jun 29, 2018 at 12:15:44PM +0100, Suzuki K Poulose wrote:
>> diff --git a/arm/kvm.c b/arm/kvm.c
>> index 5701d41..b1969be 100644
>> --- a/arm/kvm.c
>> +++ b/arm/kvm.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/kvm.h>
>>   #include <linux/sizes.h>
>>   
>> +unsigned long kvm_arm_type;
>> +
>>   struct kvm_ext kvm_req_ext[] = {
>>   	{ DEFINE_KVM_EXT(KVM_CAP_IRQCHIP) },
>>   	{ DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
>> @@ -18,6 +20,26 @@ struct kvm_ext kvm_req_ext[] = {
>>   	{ 0, 0 },
>>   };
>>   
>> +#ifndef KVM_ARM_GET_MAX_VM_PHYS_SHIFT
>> +#define KVM_ARM_GET_MAX_VM_PHYS_SHIFT		_IO(KVMIO, 0x0b)
>> +#endif
>> +
>> +void kvm__arch_init_hyp(struct kvm *kvm)
>> +{
>> +	int max_ipa;
>> +
>> +	max_ipa = ioctl(kvm->sys_fd, KVM_ARM_GET_MAX_VM_PHYS_SHIFT);
>> +	if (max_ipa < 0)
>> +		max_ipa = 40;
>> +	if (!kvm->cfg.arch.phys_shift)
>> +		kvm->cfg.arch.phys_shift = 40;
>> +	if (kvm->cfg.arch.phys_shift > max_ipa)
>> +		die("Requested PA size (%u) is not supported by the host (%ubits)\n",
>> +		    kvm->cfg.arch.phys_shift, max_ipa);
>> +	if (kvm->cfg.arch.phys_shift != 40)
>> +		kvm_arm_type = kvm->cfg.arch.phys_shift;
>> +}
> 
> Seems a bit weird that the "machine type identifier" to KVM_CREATE_VM is
> dedicated entirely to holding the physical address shift verbatim. Is this
> really the ABI?

The bits[7:0] of the machine type has been reserved for the IPA shift.
This version is missing the updates to the ABI documentation, I have it
for the next version.

> 
> Also, couldn't KVM figure it out automatically if you add memslots at high
> addresses, making this a niche tunable outside of testing?

The stage2 pgd size is really dependent on the max IPA. Also, unlike the 
stage1 (where the maximum size will be 1 page), the size can go upto 16
pages (and different number of levels due to concatenation), so we need
to finalize this at least before the first memory gets mapped (RAM or 
Device). That implies, we cannot wait until all the memory slots are
created.

The first version of the series added a separate ioctl for specifying
the limit, which had its own complexities. So, this ABI was suggested
to keep things simpler.


Suzuki
