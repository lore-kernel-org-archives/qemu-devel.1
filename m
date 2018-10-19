Received: from eggs.gnu.org ([2001:4830:134:3::10]:46215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gDZMC-0006Yu-1t
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gDZM8-0006WP-Rw
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:18:43 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gDZM5-00066I-En
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:18:39 -0400
Received: by mail-pf1-x443.google.com with SMTP id l81-v6so16837099pfg.3
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 11:18:22 -0700 (PDT)
Date: Fri, 19 Oct 2018 11:18:20 -0700 (PDT)
In-Reply-To: <da430247-4273-6df4-3629-99140c0995bc@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-48b7d6e5-1376-4ffc-8adc-81eddc8e6aa2@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/28] target/riscv: Convert RVXI
 arithmetic insns to decodetree
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

On Fri, 19 Oct 2018 04:00:33 PDT (-0700), kbastian@mail.uni-paderborn.de wrote:
> Hi Richard,
>
> On 10/12/18 8:46 PM, Richard Henderson wrote:
>> On 10/12/18 10:30 AM, Bastian Koppelmann wrote:
>>> +static bool trans_andi(DisasContext *ctx, arg_andi *a, uint32_t insn)
>>> +{
>>> +    gen_arith_imm(ctx, OPC_RISC_ANDI, a->rd, a->rs1, a->imm);
>>> +    return true;
>>> +}
>>> +static bool trans_slli(DisasContext *ctx, arg_slli *a, uint32_t insn)
>>> +{
>>> +    if (a->rd != 0) {
>>> +        TCGv t = tcg_temp_new();
>>> +        gen_get_gpr(t, a->rs1);
>>> +
>>> +        if (a->shamt >= TARGET_LONG_BITS) {
>>> +            gen_exception_illegal(ctx);
>>> +            return true;
>>> +        }
>>> +        tcg_gen_shli_tl(t, t, a->shamt);
>>> +
>>> +        gen_set_gpr(a->rd, t);
>>> +        tcg_temp_free(t);
>>> +    } /* NOP otherwise */
>>> +    return true;
>>> +}
>> Spacing.  Any reason why trans_slli (and the other shifts) aren't using
>> gen_arith_imm as well?
>
>
> Their opcode is not uniquely defined in instmap.h, just a generic
> OPC_RISC_SHIFT_RIGHT_IW. I guess I can give the opcode as a magic value
> for now.

Shifts are the only arithmetic operations that aren't uniquely defined by func3 
(the opcode), but instead have another bit packed in where the immediate 
usually lives to differentiate between arithmetic and logical shifts.  This 
pretty much always ends up as a bit of a special case in software decoders.
