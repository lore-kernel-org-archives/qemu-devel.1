Received: from eggs.gnu.org ([2001:4830:134:3::10]:50577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKC9U-00032k-1e
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 19:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKC9R-0007N6-Ki
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 19:56:59 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gKC9M-0006tY-0U
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 19:56:53 -0500
Received: by mail-pl1-x641.google.com with SMTP id p4-v6so4652689plo.5
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 16:56:51 -0800 (PST)
Date: Tue, 06 Nov 2018 16:56:49 -0800 (PST)
In-Reply-To: <8cede3dd-e348-639e-b528-3aa87abf1aae@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-29c2d3d1-ff38-423d-a20e-70870b1f2639@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: richard.henderson@linaro.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair Francis <Alistair.Francis@wdc.com>, Michael Clark <mjc@sifive.com>

On Mon, 05 Nov 2018 09:00:10 PST (-0800), Bastian Koppelmann wrote:
>
> On 11/1/18 4:59 PM, Palmer Dabbelt wrote:
>> On Wed, 31 Oct 2018 15:38:08 PDT (-0700), richard.henderson@linaro.org
>> wrote:
>>> On 10/31/18 1:20 PM, Bastian Koppelmann wrote:
>>>>  static bool trans_slt(DisasContext *ctx, arg_slt *a)
>>>>  {
>>>> -    gen_arith(ctx, OPC_RISC_SLT, a->rd, a->rs1, a->rs2);
>>>> +    TCGv source1 = tcg_temp_new();
>>>> +    TCGv source2 = tcg_temp_new();
>>>> +
>>>> +    gen_get_gpr(source1, a->rs1);
>>>> +    gen_get_gpr(source2, a->rs2);
>>>> +
>>>> +    tcg_gen_setcond_tl(TCG_COND_LT, source1, source1, source2);
>>>
>>> I do wonder about extracting this one line to gen_slt so that you can
>>> re-use
>>> gen_arith and gen_arithi.
>>>
>>>> +    tcg_gen_setcond_tl(TCG_COND_LTU, source1, source1, source2);
>>>
>>> Similarly.
>>>
>>>>  static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
>>>>  {
>>>> -    gen_arith(ctx, OPC_RISC_SLLW, a->rd, a->rs1, a->rs2);
>>>> +    TCGv source1 = tcg_temp_new();
>>>> +    TCGv source2 = tcg_temp_new();
>>>> +
>>>> +    gen_get_gpr(source1, a->rs1);
>>>> +    gen_get_gpr(source2, a->rs2);
>>>> +
>>>> +    tcg_gen_andi_tl(source2, source2, 0x1F);
>>>> +    tcg_gen_shl_tl(source1, source1, source2);
>>>> +
>>>> +    gen_set_gpr(a->rd, source1);
>>>
>>> Missing the ext32s after the shift.
>>>
>>>>  static bool trans_srlw(DisasContext *ctx, arg_srlw *a)
>>>>  {
>>>> -    gen_arith(ctx, OPC_RISC_SRLW, a->rd, a->rs1, a->rs2);
>>>> +    TCGv source1 = tcg_temp_new();
>>>> +    TCGv source2 = tcg_temp_new();
>>>> +
>>>> +    gen_get_gpr(source1, a->rs1);
>>>> +    gen_get_gpr(source2, a->rs2);
>>>> +
>>>> +    /* clear upper 32 */
>>>> +    tcg_gen_ext32u_tl(source1, source1);
>>>> +    tcg_gen_andi_tl(source2, source2, 0x1F);
>>>> +    tcg_gen_shr_tl(source1, source1, source2);
>>>
>>> Likewise.  (Consider source2 == 0.)
>>>
>>>> -    case OPC_RISC_SRL:
>>>> -        tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
>>>> -        tcg_gen_shr_tl(source1, source1, source2);
>>>> -        break;
>>> ...
>>>> -    case OPC_RISC_SRA:
>>>> -        tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
>>>> -        tcg_gen_sar_tl(source1, source1, source2);
>>>> -        break;
>>>
>>> I see that the bugs are in the original though, so fixing them in a
>>> separate
>>> patch is certainly ok.
>>
>> Since we're in the soft freeze now, I think it would be great to get
>> the bug fixes broken out as separate patches at the start of this
>> series that we can pick up for this release.  It would be great if the
>> decodetree conversion was a non-functional change, as that will make
>> it easier to review.
>
>
> Sounds good. Unfortunately, I don't have much time right now. I try at
> least to extract the bugfixes, such that they make it for this release.

Thanks.  You're welcome to just enumerate the bug fixes so I can dig them out 
if that's easier.
