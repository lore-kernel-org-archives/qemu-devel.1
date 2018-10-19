Received: from eggs.gnu.org ([2001:4830:134:3::10]:52274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gDZpc-0001er-DU
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gDZpZ-0002Fm-8V
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:49:08 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gDZpY-0002Ec-R0
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:49:05 -0400
Received: by mail-pg1-x542.google.com with SMTP id 32-v6so4954590pgu.2
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 11:49:04 -0700 (PDT)
Date: Fri, 19 Oct 2018 11:49:02 -0700 (PDT)
In-Reply-To: <86d7b325-80e1-1783-fb9b-b2071f1795cc@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-26816380-2076-492e-8d62-d522d7980f8d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 16/28] target/riscv: Convert quadrant 1 of
 RVXC insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kbastian@mail.uni-paderborn.de
Cc: richard.henderson@linaro.org, Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org

On Fri, 19 Oct 2018 08:28:38 PDT (-0700), kbastian@mail.uni-paderborn.de wrote:
> On 10/13/18 8:53 PM, Richard Henderson wrote:
>> On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
>>> +static bool trans_c_addi(DisasContext *ctx, arg_c_addi *a, uint16_t insn)
>>> +{
>>> +    if (a->imm == 0) {
>>> +        return true;
>>> +    }
>> return false, I think.
>
>
> Those are HINTS, which means the instruction in valid, but does not
> affect state, so true is correct. If I do return false, then Linux does
> not boot anymore :)

Technically, "c.addi x0, 0" is an illegal instruction.  It just so happens, 
however, that the encoding that would arise from "c.addi x0, 0" is instead the 
legal "c.nop" instruction, which happens to have exactly the same effect as a 
"c.addi x0, 0".  No idea why the spec is written this way.

So I guess you're both correct: "trans_c_addi" should treat this as invalid, as 
it's not an addi.  The processor's behavior will still be correct with this 
implementation, though, so I don't see this as a distinction worth worrying 
about.

>>> +    arg_jal arg = { .rd = 1, .imm = a->imm };
>>> +    return trans_jal(ctx, &arg, insn);
>>> +#else
>>> +    /* C.ADDIW */
>>> +    arg_addiw arg = { .rd = a->rd, .rs1 = a->rd, .imm = a->imm };
>>> +    return trans_addiw(ctx, &arg, insn);
>>> +#endif
>>> +}
>>> +
>>> +static bool trans_c_li(DisasContext *ctx, arg_c_li *a, uint16_t insn)
>>> +{
>>> +    if (a->rd == 0) {
>>> +        return true;
>>> +    }
>> return false.
>
>
> Likewise.

In this case I believe "li x0, *" should be invalid.  According to v2.2

    C.LI loads the sign-extended 6-bit immediate, imm, into register rd. C.LI 
    is only valid when rd6 = x0.
    C.LI expands into addi rd, x0, imm[5:0].

>>> +static bool trans_c_addi16sp_lui(DisasContext *ctx, arg_c_addi16sp_lui *a,
>>> +        uint16_t insn)
>>> +{
>>> +    if (a->rd == 2) {
>>> +        /* C.ADDI16SP */
>>> +        arg_addi arg = { .rd = 2, .rs1 = 2, .imm = a->imm_addi16sp };
>>> +        return trans_addi(ctx, &arg, insn);
>>> +    } else if (a->imm_lui != 0) {
>>> +        if (a->rd == 0) {
>>> +            return true;
>>> +        }
>> I think it should be
>>
>>    } else if (a->imm_lui != 0 && a->rd != 0) {
>
> Likewise.

Yes, c.lui is invalid with a non-zero immediate.  Again, according to v2.2

    C.LUI loads the non-zero 6-bit immediate field into bits 17–12 of the 
    destination register, clears the bottom 12 bits, and sign-extends bit 17 
    into all higher bits of the destination. C.LUI is only valid when rd6 = 
    {x0, x2}, and when the immediate is not equal to zero.  C.LUI expands into 
    lui rd, nzuimm[17:12].
