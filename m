Received: from eggs.gnu.org ([2001:4830:134:3::10]:33188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPUoc-0000Vm-AM
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPUoZ-00046l-Kn
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:53:22 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gPUoZ-00045V-71
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:53:19 -0500
Received: by mail-pl1-x641.google.com with SMTP id v1-v6so6101108plo.2
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 07:53:19 -0800 (PST)
Date: Wed, 21 Nov 2018 07:53:17 -0800 (PST)
In-Reply-To: <CAKmqyKMh3T7w-NsP-i2HaRUHvR-0BhqeyTgd2mD0hnH9k8gZiQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-995d2bae-d043-45c1-872d-7639baafd856@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v1 11/23] riscv: tcg-target: Add the
 relocation functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: richard.henderson@linaro.org, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org

On Tue, 20 Nov 2018 17:15:11 PST (-0800), alistair23@gmail.com wrote:
> On Fri, Nov 16, 2018 at 12:33 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/15/18 11:35 PM, Alistair Francis wrote:
>> > +static void reloc_sbimm12(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
>> > +{
>> > +    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
>> > +    tcg_debug_assert(offset == sextract32(offset, 1, 12) << 1);
>> > +
>> > +    code_ptr[0] |= encode_sbimm12(offset);
>> > +}
>>
>> FYI, I have an in-flight patch for 4.0 that will make patch_reloc return a bool
>> for relocation success, which will move these asserts.
>>
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02237.html
>
> Thanks, I'll keep an eye on this.
>
>>
>>
>> > +static void reloc_call(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
>> > +{
>> > +    intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
>> > +    tcg_debug_assert(offset == (int32_t)offset);
>> > +
>> > +    int32_t hi20 = ((offset + 0x800) >> 12) << 12;
>> > +    int32_t lo12 = offset - hi20;
>> > +
>> > +    code_ptr[0] |= encode_uimm20(hi20);
>> > +    code_ptr[1] |= encode_imm12(lo12);
>> > +}
>> > +
>>
>> This is ok for patching during generation, but it is not ok for
>> tb_target_set_jmp_target from patch 9.
>>
>> Will the riscv-32 compiler use a FSTD insn to implement atomic_set for 64-bit?
>>  If not, you may be just better off using the indirect method.
>
> I'm not sure. Is the indirect method just using atomic set, because
> that is what I have now?

Per the memory model chapter (which is being ratified now), FSD is not atomic on rv32i:

    An FLD or FSD instruction for which XLEN<64 may also be decomposed into a 
    set of component memory operations of any granularity.

So they should not be used on RV32I hosts to provide atomicity, even if they 
may be atomic on some microarchitectures.
