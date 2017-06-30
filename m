Received: from eggs.gnu.org ([2001:4830:134:3::10]:53004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQwLi-0004g6-AV
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQwLh-0002U2-JM
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:52:42 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:35216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dQwLh-0002S6-F8
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:52:41 -0400
Received: by mail-io0-x243.google.com with SMTP id 84so3485702iop.2
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 06:52:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa409172-2651-d685-6de0-b1559745cba9@twiddle.net>
References: <20170630004059.25619-1-bobby.prani@gmail.com>
	<20170630004059.25619-3-bobby.prani@gmail.com>
	<fa409172-2651-d685-6de0-b1559745cba9@twiddle.net>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 30 Jun 2017 09:52:08 -0400
Message-ID: <CAJhHMCCe_FxsDUemUs-iSBsLfke2yYvip7oN2ve5nwYcEykE7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] tcg/aarch64: Use ADRP+ADD to
 compute target address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On Fri, Jun 30, 2017 at 12:47 AM, Richard Henderson <rth@twiddle.net> wrote:
> On 06/29/2017 05:40 PM, Pranith Kumar wrote:
>>
>>   void aarch64_tb_set_jmp_target(uintptr_t jmp_addr, uintptr_t addr)
>>   {
>>       tcg_insn_unit *code_ptr = (tcg_insn_unit *)jmp_addr;
>> -    tcg_insn_unit *target = (tcg_insn_unit *)addr;
>> +    tcg_insn_unit i1, i2;
>> +    uint64_t pair;
>>   +    ptrdiff_t offset = addr - jmp_addr;
>> +
>> +    if (offset == sextract64(offset, 0, 26)) {
>> +        i1 = NOP;
>> +        i2 = I3206_B | ((offset >> 2) & 0x3ffffff);
>
>
> Branch first, since that's the offset you calculated.
> Also, the nop need not be executed.

This is exactly how I form the instruction pair below (B+NOP, not
NOP+B). But I get your point. It is confusing to use i1 for the second
instruction. I'll change it.

>
>> +    } else {
>> +        offset = (addr >> 12) - (jmp_addr >> 12);
>> +
>> +        /* patch ADRP */
>> +        i2 = deposit32(*code_ptr++, 29, 2, offset & 0x3);
>> +        i2 = deposit32(i2, 5, 19, offset >> 2);
>> +        /* patch ADDI */
>> +        i1 = deposit32(*code_ptr, 10, 12, addr & 0xfff);
>
>
> You can't just patch these insns, because they aren't necessarily ADRP+ADD.
> Indeed, they will very likely be B and NOP.  The first address we patch in
> is tb_jmp_reset_offset, which is the following opcode, which is definitely
> in range of the branch above.

Whoops, I totally missed that we patch these out the first time out. I
will explicitly generate the ADRP+ADD pair from here.

Thanks,
-- 
Pranith
