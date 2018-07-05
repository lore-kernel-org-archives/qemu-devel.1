Received: from eggs.gnu.org ([2001:4830:134:3::10]:58094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Suzuki.Poulose@arm.com>) id 1fb50F-00083v-KH
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Suzuki.Poulose@arm.com>) id 1fb50A-0006Az-Jw
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:12:59 -0400
Received: from foss.arm.com ([217.140.101.70]:57942)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Suzuki.Poulose@arm.com>) id 1fb50A-00064L-As
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:12:54 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-23-git-send-email-suzuki.poulose@arm.com>
	<20180704140943.GF4828@arm.com>
	<8c9bb3cd-f673-17f3-656f-66b7e14fc73c@arm.com>
	<20180704155231.GP4828@arm.com>
	<ca05f552-d0d7-b5b8-954b-7254e8c1e529@arm.com>
	<d0c005f8-eae4-3784-1ebc-d279df4ee608@arm.com>
	<bd5186ce-66ab-e2fa-3531-46a4a87b84d8@redhat.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <5790744f-a8bd-3a44-8e8d-bc3e05b74ce5@arm.com>
Date: Thu, 5 Jul 2018 15:12:48 +0100
MIME-Version: 1.0
In-Reply-To: <bd5186ce-66ab-e2fa-3531-46a4a87b84d8@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [kvmtool test PATCH 22/24] kvmtool: arm64: Add
 support for guest physical address size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Julien Grall <julien.grall@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, cdall@kernel.org, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org

On 05/07/18 14:46, Auger Eric wrote:
> Hi Marc,
> 
> On 07/05/2018 03:20 PM, Marc Zyngier wrote:
>> On 05/07/18 13:47, Julien Grall wrote:
>>> Hi Will,
>>>
>>> On 04/07/18 16:52, Will Deacon wrote:
>>>> On Wed, Jul 04, 2018 at 04:00:11PM +0100, Julien Grall wrote:
>>>>> On 04/07/18 15:09, Will Deacon wrote:
>>>>>> On Fri, Jun 29, 2018 at 12:15:42PM +0100, Suzuki K Poulose wrote:
>>>>>>> Add an option to specify the physical address size used by this
>>>>>>> VM.
>>>>>>>
>>>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>>> ---
>>>>>>>    arm/aarch64/include/kvm/kvm-config-arch.h | 5 ++++-
>>>>>>>    arm/include/arm-common/kvm-config-arch.h  | 1 +
>>>>>>>    2 files changed, 5 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
>>>>>>> index 04be43d..dabd22c 100644
>>>>>>> --- a/arm/aarch64/include/kvm/kvm-config-arch.h
>>>>>>> +++ b/arm/aarch64/include/kvm/kvm-config-arch.h
>>>>>>> @@ -8,7 +8,10 @@
>>>>>>>    			"Create PMUv3 device"),				\
>>>>>>>    	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
>>>>>>>    			"Specify random seed for Kernel Address Space "	\
>>>>>>> -			"Layout Randomization (KASLR)"),
>>>>>>> +			"Layout Randomization (KASLR)"),		\
>>>>>>> +	OPT_INTEGER('\0', "phys-shift", &(cfg)->phys_shift,		\
>>>>>>> +			"Specify maximum physical address size (not "	\
>>>>>>> +			"the amount of memory)"),
>>>>>>
>>>>>> Given that this is a shift value, I think the help message could be more
>>>>>> informative. Something like:
>>>>>>
>>>>>> 	"Specify maximum number of bits in a guest physical address"
>>>>>>
>>>>>> I think I'd actually leave out any mention of memory, because this does
>>>>>> actually have an effect on the amount of addressable memory in a way that I
>>>>>> don't think we want to describe in half of a usage message line :)
>>>>> Is there any particular reasons to expose this option to the user?
>>>>>
>>>>> I have recently sent a series to allow the user to specify the position
>>>>> of the RAM [1]. With that series in mind, I think the user would not really
>>>>> need to specify the maximum physical shift. Instead we could automatically
>>>>> find it.
>>>>
>>>> Marc makes a good point that it doesn't help for MMIO regions, so I'm trying
>>>> to understand whether we can do something differently there and avoid
>>>> sacrificing the type parameter.
>>>
>>> I am not sure to understand this. kvmtools knows the memory layout
>>> (including MMIOs) of the guest, so couldn't it guess the maximum
>>> physical shift for that?
>>
>> That's exactly what Will was trying to avoid, by having KVM to compute
>> the size of the IPA space based on the registered memslots. We've now
>> established that it doesn't work, so what we need to define is:
>>
>> - whether we need another ioctl(), or do we carry on piggy-backing on
>> the CPU type,
> kvm type I guess

machine type is more appropriate, going by the existing users.

>> - assuming the latter, whether we can reduce the number of bits used in
>> the ioctl parameter by subtly encoding the IPA size.
> Getting benefit from your Freudian slip, how should guest CPU PARange
> and maximum number of bits in a guest physical address relate?
> 
> My understanding is they are not correlated at the moment and our guest
> PARange is fixed at the moment. But shouldn't they?
> 
> On Intel there is
>     qemu-system-x86_64 -M pc,accel=kvm -cpu SandyBridge,phys-bits=36
> or
>     qemu-system-x86_64 -M pc,accel=kvm -cpu SandyBridge,host-phys-bits=true
> 
> where phys-bits, as far as I understand has a a similar semantics as the
> PARange.


AFAIT, PARange tells you the maximum (I)Physcial Address that can be handled
by the CPU. But your IPA limit tells you where the guest RAM is placed.
So they need not be the same. e.g, on Juno, A57's have a PARange of 42 if I am
not wrong (but definitely > 40), while A53's have it at 40 and the system RAM
is at 40bits.

So, if we were to only use the A57s on Juno, we could run a KVM instance with 42
bits IPA or anything lower. So, PARange can be inferred as the maximum limit
of the CPU's capability while the IPA is where the RAM is placed for a given
system.
One could keep them in sync for a VM by emulating, but then nobody
uses the PARange, except the KVM. The other problem with capping PARange in the VM
to IPA is restricting the IPA size of a nested VM. So, I don't think this is
really beneficial.

Cheers
Suzuki


> 
> Thanks
> 
> Eric
>>
>> Thanks,
>>
>> 	M.
>>
