Received: from eggs.gnu.org ([2001:4830:134:3::10]:43294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fbTks-0005Ug-CQ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fbTko-0002rK-2p
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:38:46 -0400
Received: from foss.arm.com ([217.140.101.70]:47352)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suzuki.poulose@arm.com>) id 1fbTkn-0002q1-QH
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:38:42 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-16-git-send-email-suzuki.poulose@arm.com>
	<20180704155104.GN4828@arm.com>
	<12d1832a-1a13-7dd4-662b-addf58400789@arm.com>
	<fe9f5aa5-b283-07e0-5f0e-e97d96b780e7@arm.com>
	<9f1af26e-2913-2b0b-1352-63160096f78f@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f3463d0a-c6a3-c34d-acb3-13c99fc61c5a@arm.com>
Date: Fri, 6 Jul 2018 17:39:00 +0100
MIME-Version: 1.0
In-Reply-To: <9f1af26e-2913-2b0b-1352-63160096f78f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/20] kvm: arm/arm64: Allow tuning the
 physical address size for VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org, Peter Maydel <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

On 07/06/2018 04:09 PM, Marc Zyngier wrote:
> On 06/07/18 14:49, Suzuki K Poulose wrote:
>> On 04/07/18 23:03, Suzuki K Poulose wrote:
>>> On 07/04/2018 04:51 PM, Will Deacon wrote:
>>>> Hi Suzuki,
>>>>
>>>> On Fri, Jun 29, 2018 at 12:15:35PM +0100, Suzuki K Poulose wrote:
>>>>> Allow specifying the physical address size for a new VM via
>>>>> the kvm_type argument for KVM_CREATE_VM ioctl. This allows
>>>>> us to finalise the stage2 page table format as early as possible
>>>>> and hence perform the right checks on the memory slots without
>>>>> complication. The size is encoded as Log2(PA_Size) in the bits[7:0]
>>>>> of the type field and can encode more information in the future if
>>>>> required. The IPA size is still capped at 40bits.
>>>>>
>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>>> Cc: Christoffer Dall <cdall@kernel.org>
>>>>> Cc: Peter Maydel <peter.maydell@linaro.org>
>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>> ---
>>>>>  =C2=A0 arch/arm/include/asm/kvm_mmu.h=C2=A0=C2=A0 |=C2=A0 2 ++
>>>>>  =C2=A0 arch/arm64/include/asm/kvm_arm.h | 10 +++-------
>>>>>  =C2=A0 arch/arm64/include/asm/kvm_mmu.h |=C2=A0 2 ++
>>>>>  =C2=A0 include/uapi/linux/kvm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 10 ++++++++++
>>>>>  =C2=A0 virt/kvm/arm/arm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++++++++++++++++++++++--
>>>>>  =C2=A0 5 files changed, 39 insertions(+), 9 deletions(-)
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>>> index 4df9bb6..fa4cab0 100644
>>>>> --- a/include/uapi/linux/kvm.h
>>>>> +++ b/include/uapi/linux/kvm.h
>>>>> @@ -751,6 +751,16 @@ struct kvm_ppc_resize_hpt {
>>>>>  =C2=A0 #define KVM_S390_SIE_PAGE_OFFSET 1
>>>>>  =C2=A0 /*
>>>>> + * On arm/arm64, machine type can be used to request the physical
>>>>> + * address size for the VM. Bits [7-0] have been reserved for the
>>>>> + * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
>>>>> + * value 0 implies the default IPA size, which is 40bits.
>>>>> + */
>>>>> +#define KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK=C2=A0=C2=A0=C2=A0 0xff
>>>>> +#define KVM_VM_TYPE_ARM_PHYS_SHIFT(x)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
>>>>> +=C2=A0=C2=A0=C2=A0 ((x) & KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK)
>>>>
>>>> This seems like you're allocating quite a lot of bits in a non-exten=
sible
>>>> interface to a fairly esoteric parameter. Would it be better to add =
another
>>>> ioctl, or condense the number of sizes you support instead?
>>>
>>> As I explained in the other thread, we need the size as soon as the V=
M
>>> is created. The major challenge is keeping the backward compatibility=
 by
>>> mapping 0 to 40bits. I will give it a thought.
>>
>> Here is one option. We could re-use the {V}TCR_ELx.{I}PS field format,=
 which
>> occupies 3 bits and has the following definitions. (ID_AA64MMFR0_EL1:P=
ARange
>> also has the field definitions, except that the field is 4bits wide, b=
ut
>> only 3bits are used)
>>
>> 000 32 bits, 4GB.
>> 001 36 bits, 64GB.
>> 010 40 bits, 1TB.
>> 011 42 bits, 4TB.
>> 100 44 bits, 16TB.
>> 101 48 bits, 256TB.
>> 110 52 bits, 4PB
>>
>> But we need to map 0 =3D> 40bits IPA to make our ABI backward compatib=
le. So
>> we could use the additional one bit to indicate that IPA size is reque=
sted
>> in the 3 bits.
>>
>> i.e,
>>
>> machine_type:
>>
>> Bit [2:0]	- Requested IPA size. Values follow VTCR_EL2.PS format.
>>
>> Bit [3]		- 1 =3D> IPA Size bits (Bits[2:0]) requested.
>> 		0 =3D> Not requested
>>
>> The only minor down side is restricting to the predefined values above=
,
>> which is not a real issue for a VM.
>>
>> Thoughts ?
>=20
> I'd be very wary of using that 4th bit to do something that is not in
> the architecture. We have only a single value left to be used (0b111),
> and then your scheme clashes with the architecture definition.

I agree. However, if we ever go beyond the 3bits in PARange, we have an
issue with {V}TCR counter part. But lets not take that chance.

>=20
> I'd rather encode things in a way that is independent from the
> architecture, and be done with it. You can map 0 to 40bits, and we have
> the ability to express all values the architecture has (just in a
> different order).

The other option I can think of is encoding a signed number which is the=20
difference of the IPA from 40. But that would need 5 bits if we were to
encode it as it is. And if we want to squeeze it in 4bit, we could store=20
half the difference (limiting the IPA limit to even numbers).

i.e IPA =3D 40 + 2 * sign_extend(bits[3:0);


Suzuki
