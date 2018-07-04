Received: from eggs.gnu.org ([2001:4830:134:3::10]:43041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fad5j-0005Qb-HG
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fad5e-00046r-JH
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:24:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fad5e-00046j-Dc
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 04:24:42 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-11-git-send-email-suzuki.poulose@arm.com>
	<e0c8dc62-42e8-ee24-5519-e19b2739160b@redhat.com>
	<a6fa912a-b2ff-ac1e-0120-b2f7eabb6f7f@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3192c7dc-4127-ec97-6ba3-262fa3ff6243@redhat.com>
Date: Wed, 4 Jul 2018 10:24:38 +0200
MIME-Version: 1.0
In-Reply-To: <a6fa912a-b2ff-ac1e-0120-b2f7eabb6f7f@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/20] kvm: arm64: Dynamic configuration
 of VTTBR mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com, kvmarm@lists.cs.columbia.edu

Hi Suzuki,

On 07/03/2018 01:54 PM, Suzuki K Poulose wrote:
> Hi Eric,
> 
> On 02/07/18 15:41, Auger Eric wrote:
>> Hi Suzuki,
>>
>> On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
>>> On arm64 VTTBR_EL2:BADDR holds the base address for the stage2
>>> translation table. The Arm ARM mandates that the bits BADDR[x-1:0]
>>> should be 0, where 'x' is defined for a given IPA Size and the
>>> number of levels for a translation granule size. It is defined
>>> using some magical constants. This patch is a reverse engineered
>>> implementation to calculate the 'x' at runtime for a given ipa and
>>> number of page table levels. See patch for more details.
>>>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Christoffer Dall <cdall@kernel.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>> Changes since V2:
>>>   - Part 1 of spilt from VTCR & VTTBR dynamic configuration
>>> ---
>>>   arch/arm64/include/asm/kvm_arm.h | 60
>>> +++++++++++++++++++++++++++++++++++++---
>>>   arch/arm64/include/asm/kvm_mmu.h | 25 ++++++++++++++++-
>>>   2 files changed, 80 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_arm.h
>>> b/arch/arm64/include/asm/kvm_arm.h
>>> index 3dffd38..c557f45 100644
>>> --- a/arch/arm64/include/asm/kvm_arm.h
>>> +++ b/arch/arm64/include/asm/kvm_arm.h
>>> @@ -140,8 +140,6 @@
>>>    * Note that when using 4K pages, we concatenate two first level
>>> page tables
>>>    * together. With 16K pages, we concatenate 16 first level page
>>> tables.
>>>    *
>>> - * The magic numbers used for VTTBR_X in this patch can be found in
>>> Tables
>>> - * D4-23 and D4-25 in ARM DDI 0487A.b.
>> Isn't it a pretty old reference? Could you refer to C.a?
> 
> Sure, I will update the references everywhere.
> 
>>> + *
>>> + * The algorithm defines the expectations on the BaseAddress (for
>>> the page
>>> + * table) bits resolved at each level based on the page size, entry
>>> level
>>> + * and T0SZ. The variable "x" in the algorithm also affects the
>>> VTTBR:BADDR
>>> + * for stage2 page table.
>>> + *
>>> + * The value of "x" is calculated as :
>>> + *    x = Magic_N - T0SZ
>>> + *
>>> + * where Magic_N is an integer depending on the page size and the entry
>>> + * level of the page table as below:
>>> + *
>>> + *    --------------------------------------------
>>> + *    | Entry level        |  4K    16K   64K |
>>> + *    --------------------------------------------
>>> + *    | Level: 0 (4 levels)    | 28   |  -  |  -  |
>>> + *    --------------------------------------------
>>> + *    | Level: 1 (3 levels)    | 37   | 31  | 25  |
>>> + *    --------------------------------------------
>>> + *    | Level: 2 (2 levels)    | 46   | 42  | 38  |
>>> + *    --------------------------------------------
>>> + *    | Level: 3 (1 level)    | -    | 53  | 51  |
>>> + *    --------------------------------------------
>> I understand entry level = Lookup level in the table.
> 
> Entry level => The level at which we start the page table walk for
> a given address (This is in line with the ARM ARM). So,
> 
> Entry_level = (4 - Number_of_Page_table_levels)
> 
>> But you may want to compute x for BaseAddress matching lookup level 2
>> with number of levels = 4.
> 
> No, the BaseAddress is only calcualted for the "Entry_level". So the
> above case doesn't exist at all.
> 
>> So shouldn't you s/Number of levels/4 - entry_level?
> 
> Ok, I now understood what you are referring to [0]
>> for BADDR we want the BaseAddr of the initial lookup level so
>> effectively the entry level we are interested in is 4 - number of levels
>> and we don't care or d) condition. At least this is my understanding ;-)
>> If correct you may slightly reword the explanation?
> 
> 
>>> + *
>>> + * We have a magic formula for the Magic_N below.
>>> + *
>>> + *  Magic_N(PAGE_SIZE, Entry_Level) = 64 - ((PAGE_SHIFT - 3) *
>>> Number of levels)
> 
> [0] ^^^
> 
> 
> 
>>> + *
>>> + * where number of levels = (4 - Entry_Level).
> 
> ^^^ Doesn't this help make it clear ? Using the expansion makes it a bit
> more
> unreadable below.

I just wanted to mention the tables you refer (D4-23 and D4-25) give
Magic_N for a larger scope as they deal with any lookup level while we
only care about the entry level for BADDR. So I was a little bit
confused when reading the explanation but that's not a big deal.

> 
>>>   +/*
>>> + * Get the magic number 'x' for VTTBR:BADDR of this KVM instance.
>>> + * With v8.2 LVA extensions, 'x' should be a minimum of 6 with
>>> + * 52bit IPS.
>> Link to the spec?
> 
> Sure, will add it.
> 
> Thanks for the patience to review :-)
you're welcome ;-)

Eric
> 
> Cheers
> Suzuki
