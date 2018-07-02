Received: from eggs.gnu.org ([2001:4830:134:3::10]:46283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Suzuki.Poulose@arm.com>) id 1fZzHv-0000Ph-Rm
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Suzuki.Poulose@arm.com>) id 1fZzHs-0005u1-QN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:54:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40344
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Suzuki.Poulose@arm.com>) id 1fZzHs-0005tn-JH
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:54:40 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-20-git-send-email-suzuki.poulose@arm.com>
	<8dcb10d8-d0ff-feb9-4ca8-38d7eeb5e6ce@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <72472fe5-69a2-9272-c0ef-d0b981ee0446@arm.com>
Date: Mon, 2 Jul 2018 14:54:36 +0100
MIME-Version: 1.0
In-Reply-To: <8dcb10d8-d0ff-feb9-4ca8-38d7eeb5e6ce@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 19/20] kvm: arm64: Allow IPA size
 supported by the system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org

On 02/07/18 14:50, Marc Zyngier wrote:
> On 29/06/18 12:15, Suzuki K Poulose wrote:
>> So far we have restricted the IPA size of the VM to the default
>> value (40bits). Now that we can manage the IPA size per VM and
>> support dynamic stage2 page tables, allow VMs to have larger IPA.
>> This is done by setting the IPA limit to the one supported by
>> the hardware and kernel. This patch also moves the check for
>> the default IPA size support to kvm_get_ipa_limit().
>>
>> Since the stage2 page table code is dependent on the stage1
>> page table, we always ensure that :
>>
>>    Number of Levels at Stage1 >= Number of Levels at Stage2
>>
>> So we limit the IPA to make sure that the above condition
>> is satisfied. This will affect the following combinations
>> of VA_BITS and IPA for different page sizes.
>>
>>    39bit VA, 4K  - IPA > 43 (Upto 48)
>>    36bit VA, 16K - IPA > 40 (Upto 48)
>>    42bit VA, 64K - IPA > 46 (Upto 52)
> 
> I'm not sure I get it. Are these the IPA sizes that we forbid based on
> the host VA size and page size configuration?

Yes, thats right.

> If so, can you rewrite
> this as:
> 
>     host configuration | unsupported IPA range
>     39bit VA, 4k       | [44, 48]
>     36bit VA, 16K      | [41, 48]
>     42bit VA, 64k      | [47, 52]
> 
> and say that all the other combinations are supported?

Sure, that looks much better. Thanks

Suzuki
