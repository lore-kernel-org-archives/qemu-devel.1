Received: from eggs.gnu.org ([2001:4830:134:3::10]:54002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fcVIg-0006Ir-N2
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fcVId-0000Wt-Bt
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:29:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37660
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fcVId-0000TK-2X
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 08:29:51 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-16-git-send-email-suzuki.poulose@arm.com>
	<20180704155104.GN4828@arm.com>
	<12d1832a-1a13-7dd4-662b-addf58400789@arm.com>
	<fe9f5aa5-b283-07e0-5f0e-e97d96b780e7@arm.com>
	<9f1af26e-2913-2b0b-1352-63160096f78f@arm.com>
	<f3463d0a-c6a3-c34d-acb3-13c99fc61c5a@arm.com>
	<20180709112326.GD9486@e103592.cambridge.arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <17f8d585-3489-ab6f-6ee1-4d8d337dcf9c@arm.com>
Date: Mon, 9 Jul 2018 13:29:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180709112326.GD9486@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
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
To: Dave Martin <Dave.Martin@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, cdall@kernel.org, kvm@vger.kernel.org, catalin.marinas@arm.com, punit.agrawal@arm.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org

On 09/07/18 12:23, Dave Martin wrote:
> On Fri, Jul 06, 2018 at 05:39:00PM +0100, Suzuki K Poulose wrote:
>> On 07/06/2018 04:09 PM, Marc Zyngier wrote:
>>> On 06/07/18 14:49, Suzuki K Poulose wrote:
>>>> On 04/07/18 23:03, Suzuki K Poulose wrote:
>>>>> On 07/04/2018 04:51 PM, Will Deacon wrote:
>>>>>> Hi Suzuki,
>>>>>>
>>>>>> On Fri, Jun 29, 2018 at 12:15:35PM +0100, Suzuki K Poulose wrote:
>>>>>>> Allow specifying the physical address size for a new VM via
>>>>>>> the kvm_type argument for KVM_CREATE_VM ioctl. This allows
>>>>>>> us to finalise the stage2 page table format as early as possible
>>>>>>> and hence perform the right checks on the memory slots without
>>>>>>> complication. The size is encoded as Log2(PA_Size) in the bits[7:=
0]
>>>>>>> of the type field and can encode more information in the future i=
f
>>>>>>> required. The IPA size is still capped at 40bits.
>>>>>>>
>>>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>>>>> Cc: Christoffer Dall <cdall@kernel.org>
>>>>>>> Cc: Peter Maydel <peter.maydell@linaro.org>
>>>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>>>> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>>>>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>>> ---
>>>>>>> =C2=A0 arch/arm/include/asm/kvm_mmu.h=C2=A0=C2=A0 |=C2=A0 2 ++
>>>>>>> =C2=A0 arch/arm64/include/asm/kvm_arm.h | 10 +++-------
>>>>>>> =C2=A0 arch/arm64/include/asm/kvm_mmu.h |=C2=A0 2 ++
>>>>>>> =C2=A0 include/uapi/linux/kvm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 10 ++++++++++
>>>>>>> =C2=A0 virt/kvm/arm/arm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++++++++++++++++++++++--
>>>>>>> =C2=A0 5 files changed, 39 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>>>>> index 4df9bb6..fa4cab0 100644
>>>>>>> --- a/include/uapi/linux/kvm.h
>>>>>>> +++ b/include/uapi/linux/kvm.h
>>>>>>> @@ -751,6 +751,16 @@ struct kvm_ppc_resize_hpt {
>>>>>>> =C2=A0 #define KVM_S390_SIE_PAGE_OFFSET 1
>>>>>>> =C2=A0 /*
>>>>>>> + * On arm/arm64, machine type can be used to request the physica=
l
>>>>>>> + * address size for the VM. Bits [7-0] have been reserved for th=
e
>>>>>>> + * PA size shift (i.e, log2(PA_Size)). For backward compatibilit=
y,
>>>>>>> + * value 0 implies the default IPA size, which is 40bits.
>>>>>>> + */
>>>>>>> +#define KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK=C2=A0=C2=A0=C2=A0 0xff
>>>>>>> +#define KVM_VM_TYPE_ARM_PHYS_SHIFT(x)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
>>>>>>> +=C2=A0=C2=A0=C2=A0 ((x) & KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK)
>>>>>>
>>>>>> This seems like you're allocating quite a lot of bits in a non-ext=
ensible
>>>>>> interface to a fairly esoteric parameter. Would it be better to ad=
d another
>>>>>> ioctl, or condense the number of sizes you support instead?
>>>>>
>>>>> As I explained in the other thread, we need the size as soon as the=
 VM
>>>>> is created. The major challenge is keeping the backward compatibili=
ty by
>>>>> mapping 0 to 40bits. I will give it a thought.
>>>>
>>>> Here is one option. We could re-use the {V}TCR_ELx.{I}PS field forma=
t, which
>>>> occupies 3 bits and has the following definitions. (ID_AA64MMFR0_EL1=
:PARange
>>>> also has the field definitions, except that the field is 4bits wide,=
 but
>>>> only 3bits are used)
>>>>
>>>> 000 32 bits, 4GB.
>>>> 001 36 bits, 64GB.
>>>> 010 40 bits, 1TB.
>>>> 011 42 bits, 4TB.
>>>> 100 44 bits, 16TB.
>>>> 101 48 bits, 256TB.
>>>> 110 52 bits, 4PB
>>>>
>>>> But we need to map 0 =3D> 40bits IPA to make our ABI backward compat=
ible. So
>>>> we could use the additional one bit to indicate that IPA size is req=
uested
>>>> in the 3 bits.
>>>>
>>>> i.e,
>>>>
>>>> machine_type:
>>>>
>>>> Bit [2:0]	- Requested IPA size. Values follow VTCR_EL2.PS format.
>>>>
>>>> Bit [3]		- 1 =3D> IPA Size bits (Bits[2:0]) requested.
>>>> 		0 =3D> Not requested
>>>>
>>>> The only minor down side is restricting to the predefined values abo=
ve,
>>>> which is not a real issue for a VM.
>>>>
>>>> Thoughts ?
>>>
>>> I'd be very wary of using that 4th bit to do something that is not in
>>> the architecture. We have only a single value left to be used (0b111)=
,
>>> and then your scheme clashes with the architecture definition.
>>
>> I agree. However, if we ever go beyond the 3bits in PARange, we have a=
n
>> issue with {V}TCR counter part. But lets not take that chance.
>>
>>>
>>> I'd rather encode things in a way that is independent from the
>>> architecture, and be done with it. You can map 0 to 40bits, and we ha=
ve
>>> the ability to express all values the architecture has (just in a
>>> different order).
>>
>> The other option I can think of is encoding a signed number which is t=
he
>> difference of the IPA from 40. But that would need 5 bits if we were t=
o
>> encode it as it is. And if we want to squeeze it in 4bit, we could sto=
re
>> half the difference (limiting the IPA limit to even numbers).
>>
>> i.e IPA =3D 40 + 2 * sign_extend(bits[3:0);
>=20
> I came across similar issues when trying to work out how to enable
> SVE for KVM.  In the end I reduced this to a per-vcpu feature, but
> it means that there is no global opt-in for the SVE-specific KVM
> API extensions:
>=20
> That's a bit gross, because SVE may require a change to the way
> vcpus are initialised.  The set of supported SVE vector lengths needs
> to be set somehow before the vcpu is set running, but it's tricky do
> do that without a new ioctl -- which would mean that if SVE is enabled
> for a vcpu then the vcpu is not considered runnable until the new
> magic ioctl is called.
>=20
> Opting into that semantic change globally at VM creation time might
> be preferable.  On the SVE side, this is still very much subject to
> review/change.
>=20
>=20
> Here:
>=20
> The KVM_CREATE_VM init argument seems undefined by the KVM core code an=
d
> is available for arches to abuse in creative ways.  x86 and arm have
> nothing here and reject non-zero values with -EINVAL; s390 treats it as
> a bitmask, and defines a sincle feature-like bit here; powerpc treats i=
t
> as an enumeration of VM types.
>=20
> If we want to be extensible, we could
>=20
>  a) Pass a pointer in type, and come up with some extensible VM paramet=
er
>     struct for it to point to (which then wouldn't need a cryptic
>     compressed encoding), or
>=20
>  b) Introduce a new "KVM_CREATE_VM2" variant that either takes such
>     an argument, or mandates a parameter negotiation phase involving
>     additional ioctls before marking the VM as ready for vcpu and
>     device creation.
>=20
> (a) feels like an easy backwards-compatible approach, but cannot be
> readily adopted by other arches (maybe not an issue).
>=20
> (b) might be considered overengineered, so it would need a bit of
> thought.
>=20
> Wedging arguments into a few bits in the type argument feels awkward,
> and may be regretted later if we run out of bits, or something can't be
> represented in the chosen encoding.

I think that's a pretty convincing argument for a "better" CREATE_VM,
one that would have a clearly defined, structured (and potentially
extensible) argument.

I've quickly hacked the following:

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b6270a3b38e9..3e76214034c2 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -735,6 +735,20 @@ struct kvm_ppc_resize_hpt {
 	__u32 pad;
 };

+struct kvm_create_vm2 {
+	__u64	version;	/* Or maybe not */
+	union {
+		struct {
+#define KVM_ARM_SVE_CAPABLE	(1 << 0)
+#define KVM_ARM_SELECT_IPA	{1 << 1)
+			__u64	capabilities;
+			__u16	sve_vlen;
+			__u8	ipa_size;
+		} arm64;
+		__u64	dummy[15];
+	};
+};
+
 #define KVMIO 0xAE

 /* machine type bits, to be used as argument to KVM_CREATE_VM */

Other architectures could fill in their own bits if they need to.

Thoughts?

	M.
--=20
Jazz is not dead. It just smells funny...
