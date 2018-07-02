Received: from eggs.gnu.org ([2001:4830:134:3::10]:33084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Suzuki.Poulose@arm.com>) id 1fZw1k-00081o-KV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Suzuki.Poulose@arm.com>) id 1fZw1f-0006ou-JV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:25:48 -0400
Received: from foss.arm.com ([217.140.101.70]:36098)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Suzuki.Poulose@arm.com>) id 1fZw1f-0006nf-9e
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:25:43 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-8-git-send-email-suzuki.poulose@arm.com>
	<6a51d7dd-7bbe-5ea5-4498-26b5e290d9a6@arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <176bec38-724b-0206-31dc-a4a7bffdf2d0@arm.com>
Date: Mon, 2 Jul 2018 11:25:36 +0100
MIME-Version: 1.0
In-Reply-To: <6a51d7dd-7bbe-5ea5-4498-26b5e290d9a6@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/20] kvm: arm/arm64: Prepare for VM
 specific stage2 translations
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

On 02/07/18 11:12, Marc Zyngier wrote:
> On 29/06/18 12:15, Suzuki K Poulose wrote:
>> Right now the stage2 page table for a VM is hard coded, assuming
>> an IPA of 40bits. As we are about to add support for per VM IPA,
>> prepare the stage2 page table helpers to accept the kvm instance
>> to make the right decision for the VM. No functional changes.
>> Adds stage2_pgd_size(kvm) to replace S2_PGD_SIZE. Also, moves
>> some of the definitions dependent on kvm instance to asm/kvm_mmu.h
>> for arm32. In that process drop the _AC() specifier constants
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since V2:
>>   - Update commit description abuot the movement to asm/kvm_mmu.h
>>     for arm32
>>   - Drop _AC() specifiers
>> ---
>>   arch/arm/include/asm/kvm_arm.h                |   3 +-
>>   arch/arm/include/asm/kvm_mmu.h                |  15 +++-
>>   arch/arm/include/asm/stage2_pgtable.h         |  42 ++++-----
>>   arch/arm64/include/asm/kvm_mmu.h              |   7 +-
>>   arch/arm64/include/asm/stage2_pgtable-nopmd.h |  18 ++--
>>   arch/arm64/include/asm/stage2_pgtable-nopud.h |  16 ++--
>>   arch/arm64/include/asm/stage2_pgtable.h       |  49 ++++++-----
>>   virt/kvm/arm/arm.c                            |   2 +-
>>   virt/kvm/arm/mmu.c                            | 119 +++++++++++++-------------
>>   virt/kvm/arm/vgic/vgic-kvm-device.c           |   2 +-
>>   10 files changed, 148 insertions(+), 125 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
>> index 3ab8b37..c3f1f9b 100644
>> --- a/arch/arm/include/asm/kvm_arm.h
>> +++ b/arch/arm/include/asm/kvm_arm.h
>> @@ -133,8 +133,7 @@
>>    * space.
>>    */
>>   #define KVM_PHYS_SHIFT	(40)
>> -#define KVM_PHYS_SIZE	(_AC(1, ULL) << KVM_PHYS_SHIFT)
>> -#define KVM_PHYS_MASK	(KVM_PHYS_SIZE - _AC(1, ULL))
>> +
>>   #define PTRS_PER_S2_PGD	(_AC(1, ULL) << (KVM_PHYS_SHIFT - 30))
>>   
>>   /* Virtualization Translation Control Register (VTCR) bits */
>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> index 8553d68..f36eb20 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -36,15 +36,19 @@
>>   	})
>>   
>>   /*
>> - * KVM_MMU_CACHE_MIN_PAGES is the number of stage2 page table translation levels.
>> + * kvm_mmu_cache_min_pages() is the number of stage2 page
>> + * table translation levels, excluding the top level, for
>> + * the given VM. Since we have a 3 level page-table, this
>> + * is fixed.
> 
> I find this comment quite confusing: number of levels, but excluding the
> top one? The original one was just as bad, to be honest.
> 
> Can't we just say: "kvm_mmu_cache_min_page() is the number of pages
> required to install a stage-2 translation"?

Yes, that is much better.  Will change it.

>> diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
>> index 8b68099..057a405 100644
>> --- a/arch/arm64/include/asm/stage2_pgtable.h
>> +++ b/arch/arm64/include/asm/stage2_pgtable.h
>> @@ -65,10 +65,10 @@
>>   #define PTRS_PER_S2_PGD			(1 << (KVM_PHYS_SHIFT - S2_PGDIR_SHIFT))
>>   
>>   /*
>> - * KVM_MMU_CACHE_MIN_PAGES is the number of stage2 page table translation
>> + * kvm_mmmu_cache_min_pages is the number of stage2 page table translation
>>    * levels in addition to the PGD.
>>    */
>> -#define KVM_MMU_CACHE_MIN_PAGES		(STAGE2_PGTABLE_LEVELS - 1)
>> +#define kvm_mmu_cache_min_pages(kvm)	(STAGE2_PGTABLE_LEVELS - 1)
> 
> Same comment as for the 32bit case.
> 
>>   

>>
> 
> Otherwise:
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks
Suzuki
