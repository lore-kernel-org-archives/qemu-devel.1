Received: from eggs.gnu.org ([209.51.188.92]:51438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1998-0003Et-7h
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1994-0000lD-EG
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:26:10 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1992-0000V1-Cf
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:26:05 -0500
Received: by mail-pf1-x441.google.com with SMTP id n125so5580837pfn.5
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 04:26:03 -0800 (PST)
References: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1551712405-2530-7-git-send-email-mateja.marjanovic@rt-rk.com>
	<BN6PR2201MB1251A6A94C986D2E391EF774C6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef7a569e-cca2-ef48-9fe8-5f71315441c4@linaro.org>
Date: Tue, 5 Mar 2019 04:25:58 -0800
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251A6A94C986D2E391EF774C6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/13] target/mips: Add emulation of MMI
 instruction PEXEH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

On 3/4/19 10:27 AM, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH v3 06/13] target/mips: Add emulation of MMI instruction PEXEH
>>
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> Add emulation of MMI instruction PEXEH. The emulation is implemented
>> using TCG front end operations directly to achieve better performance.
>>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> ---
>>  target/mips/translate.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 74 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>> index 64eb10c..01efcde 100644
>> --- a/target/mips/translate.c
>> +++ b/target/mips/translate.c
>> @@ -24650,6 +24650,77 @@ static void gen_mmi_pexcw(DisasContext *ctx)
>>      }
>>  }
>>
>> +/*
>> + *  PEXEH rd, rt
>> + *
>> + *  Parallel Exchange Even Halfword
> 
> Indentation...
> 
>> + *
>> + *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
>> + *  +-----------+---------+---------+---------+---------+-----------+
>> + *  |    MMI    |0 0 0 0 0|   rt    |   rd    |  PEXEH  |    MMI2   |
>> + *  +-----------+---------+---------+---------+---------+-----------+
>> + */
>> +
>> +static void gen_mmi_pexeh(DisasContext *ctx)
>> +{
>> +    uint32_t pd, rt, rd;
>> +    uint32_t opcode;
>> +
>> +    opcode = ctx->opcode;
>> +
>> +    pd = extract32(opcode, 21, 5);
>> +    rt = extract32(opcode, 16, 5);
>> +    rd = extract32(opcode, 11, 5);
>> +
>> +    if (unlikely(pd != 0)) {
>> +        generate_exception_end(ctx, EXCP_RI);
>> +    } else if (rd == 0) {
>> +        /* nop */
>> +    } else if (rt == 0) {
>> +        tcg_gen_movi_i64(cpu_gpr[rd], 0);
>> +        tcg_gen_movi_i64(cpu_mmr[rd], 0);
>> +    } else {
>> +        TCGv_i64 t0 = tcg_temp_new();
>> +        TCGv_i64 t1 = tcg_temp_new();
>> +        uint64_t mask0 = (1ULL << 16) - 1;
>> +        uint64_t mask1 = mask0 << 16;
>> +        uint64_t mask2 = mask1 << 16;
>> +        uint64_t mask3 = mask2 << 16;
> 
> What about:
> 
>        uint64_t mask2 = mask0 << 32;
>        uint64_t mask3 = mask0 << 48;
> 
>> +
>> +        tcg_gen_movi_i64(t1, 0);
>> +
> 
> The last blank line should be deleted IMO.
> 
>> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask0);
>> +        tcg_gen_shli_i64(t0, t0, 32);
>> +        tcg_gen_or_i64(t1, t0, t1);
>> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask1);
>> +        tcg_gen_or_i64(t1, t0, t1);
>> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask2);
>> +        tcg_gen_shri_i64(t0, t0, 32);
>> +        tcg_gen_or_i64(t1, t0, t1);
>> +        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask3);
>> +        tcg_gen_or_i64(t1, t0, t1);
>> +
>> +        tcg_gen_mov_i64(cpu_gpr[rd], t1);
>> +        tcg_gen_movi_i64(t1, 0);
>> +
>> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask0);
> 
> Better (more logical nad consistent with other patches) spacing is like
> this:
> 
>         tcg_gen_mov_i64(cpu_gpr[rd], t1);
> 
>         tcg_gen_movi_i64(t1, 0);
>         tcg_gen_andi_i64(t0, cpu_mmr[rt], mask0);
> 
>> +        tcg_gen_shli_i64(t0, t0, 32);
>> +        tcg_gen_or_i64(t1, t0, t1);
>> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask1);
>> +        tcg_gen_or_i64(t1, t0, t1);
>> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask2);
>> +        tcg_gen_shri_i64(t0, t0, 32);
>> +        tcg_gen_or_i64(t1, t0, t1);
>> +        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask3);
>> +        tcg_gen_or_i64(t1, t0, t1);
>> +
>> +        tcg_gen_mov_i64(cpu_mmr[rd], t1);
>> +
>> +        tcg_temp_free(t0);
>> +        tcg_temp_free(t1);
>> +    }
> 
> I think that if rt == rd this whole block can be rewritten in a more optimal
> and clearer way:
> 
>         tcg_gen_andi_i64(t0, cpu_gpr[rt], mask0);
>         tcg_gen_shli_i64(t0, t0, 32);
>         tcg_gen_andi_i64(t1, cpu_gpr[rt], mask2);
>         tcg_gen_shri_i64(t1, t1, 32);
> 
>         tcg_gen_andi_i64(cpu_gpr[rd], mask3 || mask1);
>         tcg_gen_or_i64(cpu_gpr[rd], t0);
>         tcg_gen_or_i64(cpu_gpr[rd], t1);
> 
> and the same for "mmr" half.

You don't need rt == rd in order to write it that way:

  tcg_gen_andi_i64(cpu_gpr[rd], cpu_gpr[rt], mask3 | mask1);

And yes, that's much better.


r~
