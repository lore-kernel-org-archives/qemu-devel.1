Received: from eggs.gnu.org ([2001:4830:134:3::10]:41666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gIFNj-0004Fd-Ak
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gIFNf-0002FZ-5z
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:59:39 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gIFNc-0002Dw-1m
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:59:32 -0400
Received: by mail-pf1-x443.google.com with SMTP id v5-v6so4638992pfm.12
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 08:59:27 -0700 (PDT)
Date: Thu, 01 Nov 2018 08:59:25 -0700 (PDT)
In-Reply-To: <8818c4f3-7ff5-44c6-abbe-67489519ccde@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-3a3dd1f0-dbed-4b43-b21f-88ecea6f5fb1@palmer-si-x1c4>
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
To: richard.henderson@linaro.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>, peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On Wed, 31 Oct 2018 15:38:08 PDT (-0700), richard.henderson@linaro.org wrote:
> On 10/31/18 1:20 PM, Bastian Koppelmann wrote:
>>  static bool trans_slt(DisasContext *ctx, arg_slt *a)
>>  {
>> -    gen_arith(ctx, OPC_RISC_SLT, a->rd, a->rs1, a->rs2);
>> +    TCGv source1 = tcg_temp_new();
>> +    TCGv source2 = tcg_temp_new();
>> +
>> +    gen_get_gpr(source1, a->rs1);
>> +    gen_get_gpr(source2, a->rs2);
>> +
>> +    tcg_gen_setcond_tl(TCG_COND_LT, source1, source1, source2);
>
> I do wonder about extracting this one line to gen_slt so that you can re-use
> gen_arith and gen_arithi.
>
>> +    tcg_gen_setcond_tl(TCG_COND_LTU, source1, source1, source2);
>
> Similarly.
>
>>  static bool trans_sllw(DisasContext *ctx, arg_sllw *a)
>>  {
>> -    gen_arith(ctx, OPC_RISC_SLLW, a->rd, a->rs1, a->rs2);
>> +    TCGv source1 = tcg_temp_new();
>> +    TCGv source2 = tcg_temp_new();
>> +
>> +    gen_get_gpr(source1, a->rs1);
>> +    gen_get_gpr(source2, a->rs2);
>> +
>> +    tcg_gen_andi_tl(source2, source2, 0x1F);
>> +    tcg_gen_shl_tl(source1, source1, source2);
>> +
>> +    gen_set_gpr(a->rd, source1);
>
> Missing the ext32s after the shift.
>
>>  static bool trans_srlw(DisasContext *ctx, arg_srlw *a)
>>  {
>> -    gen_arith(ctx, OPC_RISC_SRLW, a->rd, a->rs1, a->rs2);
>> +    TCGv source1 = tcg_temp_new();
>> +    TCGv source2 = tcg_temp_new();
>> +
>> +    gen_get_gpr(source1, a->rs1);
>> +    gen_get_gpr(source2, a->rs2);
>> +
>> +    /* clear upper 32 */
>> +    tcg_gen_ext32u_tl(source1, source1);
>> +    tcg_gen_andi_tl(source2, source2, 0x1F);
>> +    tcg_gen_shr_tl(source1, source1, source2);
>
> Likewise.  (Consider source2 == 0.)
>
>> -    case OPC_RISC_SRL:
>> -        tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
>> -        tcg_gen_shr_tl(source1, source1, source2);
>> -        break;
> ...
>> -    case OPC_RISC_SRA:
>> -        tcg_gen_andi_tl(source2, source2, TARGET_LONG_BITS - 1);
>> -        tcg_gen_sar_tl(source1, source1, source2);
>> -        break;
>
> I see that the bugs are in the original though, so fixing them in a separate
> patch is certainly ok.

Since we're in the soft freeze now, I think it would be great to get the bug 
fixes broken out as separate patches at the start of this series that we can 
pick up for this release.  It would be great if the decodetree conversion was a 
non-functional change, as that will make it easier to review.

Sorry for adding a bunch of work for you, Bastian :)
