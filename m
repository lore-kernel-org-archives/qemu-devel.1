Received: from eggs.gnu.org ([2001:4830:134:3::10]:34483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gJiP4-0004Rf-Rz
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gJiEs-0000qZ-Mn
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 12:00:40 -0500
References: <mhng-3a3dd1f0-dbed-4b43-b21f-88ecea6f5fb1@palmer-si-x1c4>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <8cede3dd-e348-639e-b528-3aa87abf1aae@mail.uni-paderborn.de>
Date: Mon, 5 Nov 2018 18:00:10 +0100
MIME-Version: 1.0
In-Reply-To: <mhng-3a3dd1f0-dbed-4b43-b21f-88ecea6f5fb1@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [PATCH v3 26/35] target/riscv: Remove shift and
 slt insn manual decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, richard.henderson@linaro.org
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>


On 11/1/18 4:59 PM, Palmer Dabbelt wrote:
> On Wed, 31 Oct 2018 15:38:08 PDT (-0700), richard.henderson@linaro.org 
> wrote:
>> On 10/31/18 1:20 PM, Bastian Koppelmann wrote:
>>>  static bool trans_slt(DisasContext *ctx, arg_slt *a)
>>>  {
>>> -    gen_arith(ctx, OPC_RISC_SLT, a->rd, a->rs1, a->rs2);
>>> +    TCGv source1 = tcg_temp_new();
>>> +    TCGv source2 = tcg_temp_new();
>>> +
>>> +    gen_get_gpr(source1, a->rs1);
>>> +    gen_get_gpr(source2, a->rs2);
>>> +
>>> +    tcg_gen_setcond_tl(TCG_COND_LT, source1, source1, source2);
>>
>> I do wonder about extracting this one line to gen_slt so that you can 
>> re-use
>> gen_arith and gen_arithi.
>>
>>> +    tcg_gen_setcond_tl(TCG_COND_LTU, source1, source1, source2);
>>
>> Similarly.
>>
>>>  static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
>>>  {
>>> -    gen_arith(ctx, OPC_RISC_SLLW, a->rd, a->rs1, a->rs2);
>>> +    TCGv source1 = tcg_temp_new();
>>> +    TCGv source2 = tcg_temp_new();
>>> +
>>> +    gen_get_gpr(source1, a->rs1);
>>> +    gen_get_gpr(source2, a->rs2);
>>> +
>>> +    tcg_gen_andi_tl(source2, source2, 0x1F);
>>> +    tcg_gen_shl_tl(source1, source1, source2);
>>> +
>>> +    gen_set_gpr(a->rd, source1);
>>
>> Missing the ext32s after the shift.
>>
>>>  static bool trans_srlw(DisasContext *ctx, arg_srlw *a)
>>>  {
>>> -    gen_arith(ctx, OPC_RISC_SRLW, a->rd, a->rs1, a->rs2);
>>> +    TCGv source1 = tcg_temp_new();
>>> +    TCGv source2 = tcg_temp_new();
>>> +
>>> +    gen_get_gpr(source1, a->rs1);
>>> +    gen_get_gpr(source2, a->rs2);
>>> +
>>> +    /* clear upper 32 */
>>> +    tcg_gen_ext32u_tl(source1, source1);
>>> +    tcg_gen_andi_tl(source2, source2, 0x1F);
>>> +    tcg_gen_shr_tl(source1, source1, source2);
>>
>> Likewise.  (Consider source2 == 0.)
>>
>>> -    case OPC_RISC_SRL:
>>> -        tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
>>> -        tcg_gen_shr_tl(source1, source1, source2);
>>> -        break;
>> ...
>>> -    case OPC_RISC_SRA:
>>> -        tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
>>> -        tcg_gen_sar_tl(source1, source1, source2);
>>> -        break;
>>
>> I see that the bugs are in the original though, so fixing them in a 
>> separate
>> patch is certainly ok.
>
> Since we're in the soft freeze now, I think it would be great to get 
> the bug fixes broken out as separate patches at the start of this 
> series that we can pick up for this release.  It would be great if the 
> decodetree conversion was a non-functional change, as that will make 
> it easier to review.


Sounds good. Unfortunately, I don't have much time right now. I try at 
least to extract the bugfixes, such that they make it for this release.


Cheers,

Bastian
