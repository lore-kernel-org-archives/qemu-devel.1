Received: from eggs.gnu.org ([209.51.188.92]:50073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hC7rH-0002bo-Bk
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 15:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hC7rE-00024S-Re
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 15:17:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hC7rE-00020H-DE
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 15:17:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so5177592wre.7
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 12:17:02 -0700 (PDT)
References: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554383690-28338-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<e0e8ff46-2fa8-e0ce-8699-2cec076695d1@redhat.com>
	<BN6PR2201MB12518B6A27D666DE96C5E30BC6500@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0d428692-d478-9c03-8416-ced9700f995c@redhat.com>
Date: Thu, 4 Apr 2019 21:17:00 +0200
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB12518B6A27D666DE96C5E30BC6500@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 2/4] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>

Hi Aleksandar,

On 4/4/19 8:19 PM, Aleksandar Markovic wrote:
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Subject: Re: [PATCH v6 2/4] target/mips: Optimize ILVEV.<B|H|W|D> MSA instructions
>>
>> Hi Mateja,
>>
>> On 4/4/19 3:14 PM, Mateja Marjanovic wrote:
>>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>>
>>> Optimize set of MSA instructions ILVEV.<B|H|W|D>, using
>>> directly tcg registers and performing logic on them
>>> instead of using helpers.
>>>
>>> In the following table, the first column is the performance
>>> before this patch. The second represents the performance,
>>> after converting from helpers to tcg, but without using
>>> tcg_gen_deposit function. The third one is the solution
>>> which is implemented in this patch.
>>>
>>> Performance measurement is done by executing the
>>> instructions a large number of times on a computer
>>> with Intel Core i7-3770 CPU @ 3.40GHz×8.
>>>
>>> ============================================================
>>> || instr    ||   before    || no-deposit ||  with-deposit ||
>>> ============================================================
>>> || ilvev.b  ||  126.92 ms  ||  24.52 ms  ||   24.43 ms    ||
>>> || ilvev.h  ||   93.67 ms  ||  23.92 ms  ||   23.86 ms    ||
>>
>> I'm quite surprised there is not a single change here since your v5, are
>> you sure you used the correct result? I was expecting a slighly improvement.
>>
> 
> Hello, Philippe.
> 
> First of all, thank you so much for taking your time to provide
> Matejan with the source code below.
> 
> Speaking about your idea, Mateja told me he DID implemented it,
> and did measurements, and that the improvement is noticeable,
> but really small. I don't know why he did not include that change
> - perhaps he didn't have enough time to integrate it.
> 
> I know he is on a long weekend now, so we will have to wait for
> the next week for Mateja to explain this to us. Mateja, could you
> perhaps add a column "with-deposit-and-mask-as-tcg-constant"?

Ah OK, no worries since this series will enter in the 4.1 dev cycle and
there is still 2/3 weeks to go.
I am simply curious to see the difference using the register approach :)
I recently noticed I can run those tests myself (I previously mixed
threads and thought Mateja was running this on a FPGA).

I try to have a quick look at your work, and I'm pleased to see how
Mateja improves the quality/accuracy of each series.

Regards,

Phil.

> Yours,
> Aleksandar
> 
> 
>>> || ilvev.w  ||  117.86 ms  ||  23.83 ms  ||   22.17 ms    ||
>>> || ilvev.d  ||   45.49 ms  ||  19.74 ms  ||   19.71 ms    ||
>>> ============================================================
>>>
>>> No-deposit column and with-deposit column have the
>>> same statistical values in every row, except ILVEV.W,
>>> which is the only function which uses the deposit
>>> function.
>>>
>>> No-deposit version of the ILVEV.W implementation:
>>>
>>> static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
>>>                                uint32_t ws, uint32_t wt)
>>> {
>>>     TCGv_i64 t1 = tcg_temp_new_i64();
>>>     TCGv_i64 t2 = tcg_temp_new_i64();
>>>     uint64_t mask = 0x00000000ffffffffULL;
>>>
>>>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>>>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
>>>     tcg_gen_shli_i64(t2, t2, 32);
>>>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
>>>
>>>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>>>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>>>     tcg_gen_shli_i64(t2, t2, 32);
>>>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
>>>
>>>     tcg_temp_free_i64(t1);
>>>     tcg_temp_free_i64(t2);
>>> }
>>>
>>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>>> ---
>>>  target/mips/helper.h     |   1 -
>>>  target/mips/msa_helper.c |   9 -----
>>>  target/mips/translate.c  | 101 ++++++++++++++++++++++++++++++++++++++++++++++-
>>>  3 files changed, 100 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/target/mips/helper.h b/target/mips/helper.h
>>> index 02e16c7..82f6a40 100644
>>> --- a/target/mips/helper.h
>>> +++ b/target/mips/helper.h
>>> @@ -864,7 +864,6 @@ DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, i32)
>>>  DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
>>>  DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
>>>  DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
>>> -DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
>>>  DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
>>>  DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
>>>  DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
>>> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
>>> index a7ea6aa..d5c3842 100644
>>> --- a/target/mips/msa_helper.c
>>> +++ b/target/mips/msa_helper.c
>>> @@ -1197,15 +1197,6 @@ MSA_FN_DF(ilvl_df)
>>>      } while (0)
>>>  MSA_FN_DF(ilvr_df)
>>>  #undef MSA_DO
>>> -
>>> -#define MSA_DO(DF)                      \
>>> -    do {                                \
>>> -        pwx->DF[2*i]   = pwt->DF[2*i];  \
>>> -        pwx->DF[2*i+1] = pws->DF[2*i];  \
>>> -    } while (0)
>>> -MSA_FN_DF(ilvev_df)
>>> -#undef MSA_DO
>>> -
>>>  #undef MSA_LOOP_COND
>>>
>>>  #define MSA_LOOP_COND(DF) \
>>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>>> index df685e4..3057669 100644
>>> --- a/target/mips/translate.c
>>> +++ b/target/mips/translate.c
>>> @@ -28973,6 +28973,90 @@ static inline void gen_ilvod_d(CPUMIPSState *env, uint32_t wd,
>>>      tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
>>>  }
>>>
>>> +/*
>>> + * [MSA] ILVEV.B wd, ws, wt
>>> + *
>>> + *   Vector Interleave Even (byte data elements)
>>> + *
>>> + */
>>> +static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
>>> +                               uint32_t ws, uint32_t wt)
>>> +{
>>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>>> +    TCGv_i64 mask = tcg_const_i64(0x00ff00ff00ff00ffULL);
>>> +
>>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
>>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
>>> +    tcg_gen_shli_i64(t2, t2, 8);
>>> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
>>> +
>>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>>> +    tcg_gen_shli_i64(t2, t2, 8);
>>> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
>>> +
>>> +    tcg_temp_free_i64(mask);
>>> +    tcg_temp_free_i64(t1);
>>> +    tcg_temp_free_i64(t2);
>>> +}
>>> +
>>> +/*
>>> + * [MSA] ILVEV.H wd, ws, wt
>>> + *
>>> + *   Vector Interleave Even (halfword data elements)
>>> + *
>>> + */
>>> +static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
>>> +                               uint32_t ws, uint32_t wt)
>>> +{
>>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>>> +    TCGv_i64 mask = tcg_const_i64(0x0000ffff0000ffffULL);
>>> +
>>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
>>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
>>> +    tcg_gen_shli_i64(t2, t2, 16);
>>> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
>>> +
>>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>>> +    tcg_gen_shli_i64(t2, t2, 16);
>>> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
>>> +
>>> +    tcg_temp_free_i64(mask);
>>> +    tcg_temp_free_i64(t1);
>>> +    tcg_temp_free_i64(t2);
>>> +}
>>
>> Apparently you missed my comment about refactoring using mask/shift as
>> arguments:
>>
>> static inline void gen_ilvev_hb(CPUMIPSState *env, uint32_t wd,
>>                                 uint32_t ws, uint32_t wt,
>>                                 int64_t mask, int64_t shift)
>> {
>>     TCGv_i64 t1 = tcg_temp_new_i64();
>>     TCGv_i64 t2 = tcg_temp_new_i64();
>>     TCGv_i64 tm = tcg_const_i64(mask);
>>
>>     tcg_gen_and_i64(t1, msa_wr_d[wt * 2], tm);
>>     tcg_gen_and_i64(t2, msa_wr_d[ws * 2], tm);
>>     tcg_gen_shli_i64(t2, t2, shift);
>>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
>>
>>     tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], tm);
>>     tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], tm);
>>     tcg_gen_shli_i64(t2, t2, shift);
>>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
>>
>>     tcg_temp_free_i64(tm);
>>     tcg_temp_free_i64(t1);
>>     tcg_temp_free_i64(t2);
>> }
>>
>> static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
>>                                uint32_t ws, uint32_t wt)
>> {
>>     gen_ilvev_hb(env, wd, ws, wt, 0x00ff00ff00ff00ffLL, 8);
>> }
>>
>> static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
>>                                uint32_t ws, uint32_t wt)
>> {
>>     gen_ilvev_hb(env, wd, ws, wt, 0x0000ffff0000ffffLL, 16);
>> }
>>
>>
>>> +
>>> +/*
>>> + * [MSA] ILVEV.W wd, ws, wt
>>> + *
>>> + *   Vector Interleave Even (word data elements)
>>> + *
>>> + */
>>> +static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
>>> +                               uint32_t ws, uint32_t wt)
>>> +{
>>> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2],
>>> +                        msa_wr_d[ws * 2], 32, 32);
>>> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[wt * 2 + 1],
>>> +                        msa_wr_d[ws * 2 + 1], 32, 32);
>>> +}
>>> +
>>> +/*
>>> + * [MSA] ILVEV.D wd, ws, wt
>>> + *
>>> + *   Vector Interleave Even (Doubleword data elements)
>>> + *
>>> + */
>>> +static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
>>> +                               uint32_t ws, uint32_t wt)
>>> +{
>>> +    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
>>> +    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
>>> +}
>>> +
>>>  static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
>>>  {
>>>  #define MASK_MSA_3R(op)    (MASK_MSA_MINOR(op) | (op & (0x7 << 23)))
>>> @@ -29129,7 +29213,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
>>>          gen_helper_msa_mod_s_df(cpu_env, tdf, twd, tws, twt);
>>>          break;
>>>      case OPC_ILVEV_df:
>>> -        gen_helper_msa_ilvev_df(cpu_env, tdf, twd, tws, twt);
>>> +        switch (df) {
>>> +        case DF_BYTE:
>>> +            gen_ilvev_b(env, wd, ws, wt);
>>> +            break;
>>> +        case DF_HALF:
>>> +            gen_ilvev_h(env, wd, ws, wt);
>>> +            break;
>>> +        case DF_WORD:
>>> +            gen_ilvev_w(env, wd, ws, wt);
>>> +            break;
>>> +        case DF_DOUBLE:
>>> +            gen_ilvev_d(env, wd, ws, wt);
>>> +            break;
>>> +        default:
>>> +            assert(0);
>>> +        }
>>>          break;
>>>      case OPC_BINSR_df:
>>>          gen_helper_msa_binsr_df(cpu_env, tdf, twd, tws, twt);
>>>
>>
> ________________________________________
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> Sent: Thursday, April 4, 2019 3:42 PM
> To: Mateja Marjanovic; qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; richard.henderson@linaro.org; Aleksandar Markovic; Aleksandar Rikalo
> Subject: Re: [PATCH v6 2/4] target/mips: Optimize ILVEV.<B|H|W|D> MSA instructions
> 
> Hi Mateja,
> 
> On 4/4/19 3:14 PM, Mateja Marjanovic wrote:
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>>
>> Optimize set of MSA instructions ILVEV.<B|H|W|D>, using
>> directly tcg registers and performing logic on them
>> instead of using helpers.
>>
>> In the following table, the first column is the performance
>> before this patch. The second represents the performance,
>> after converting from helpers to tcg, but without using
>> tcg_gen_deposit function. The third one is the solution
>> which is implemented in this patch.
>>
>> Performance measurement is done by executing the
>> instructions a large number of times on a computer
>> with Intel Core i7-3770 CPU @ 3.40GHz×8.
>>
>> ============================================================
>> || instr    ||   before    || no-deposit ||  with-deposit ||
>> ============================================================
>> || ilvev.b  ||  126.92 ms  ||  24.52 ms  ||   24.43 ms    ||
>> || ilvev.h  ||   93.67 ms  ||  23.92 ms  ||   23.86 ms    ||
> 
> I'm quite surprised there is not a single change here since your v5, are
> you sure you used the correct result? I was expecting a slighly improvement.
> 
>> || ilvev.w  ||  117.86 ms  ||  23.83 ms  ||   22.17 ms    ||
>> || ilvev.d  ||   45.49 ms  ||  19.74 ms  ||   19.71 ms    ||
>> ============================================================
>>
>> No-deposit column and with-deposit column have the
>> same statistical values in every row, except ILVEV.W,
>> which is the only function which uses the deposit
>> function.
>>
>> No-deposit version of the ILVEV.W implementation:
>>
>> static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
>>                                uint32_t ws, uint32_t wt)
>> {
>>     TCGv_i64 t1 = tcg_temp_new_i64();
>>     TCGv_i64 t2 = tcg_temp_new_i64();
>>     uint64_t mask = 0x00000000ffffffffULL;
>>
>>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
>>     tcg_gen_shli_i64(t2, t2, 32);
>>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
>>
>>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>>     tcg_gen_shli_i64(t2, t2, 32);
>>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
>>
>>     tcg_temp_free_i64(t1);
>>     tcg_temp_free_i64(t2);
>> }
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> ---
>>  target/mips/helper.h     |   1 -
>>  target/mips/msa_helper.c |   9 -----
>>  target/mips/translate.c  | 101 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  3 files changed, 100 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/mips/helper.h b/target/mips/helper.h
>> index 02e16c7..82f6a40 100644
>> --- a/target/mips/helper.h
>> +++ b/target/mips/helper.h
>> @@ -864,7 +864,6 @@ DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, i32)
>>  DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
>>  DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
>>  DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
>> -DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
>>  DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
>>  DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
>>  DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
>> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
>> index a7ea6aa..d5c3842 100644
>> --- a/target/mips/msa_helper.c
>> +++ b/target/mips/msa_helper.c
>> @@ -1197,15 +1197,6 @@ MSA_FN_DF(ilvl_df)
>>      } while (0)
>>  MSA_FN_DF(ilvr_df)
>>  #undef MSA_DO
>> -
>> -#define MSA_DO(DF)                      \
>> -    do {                                \
>> -        pwx->DF[2*i]   = pwt->DF[2*i];  \
>> -        pwx->DF[2*i+1] = pws->DF[2*i];  \
>> -    } while (0)
>> -MSA_FN_DF(ilvev_df)
>> -#undef MSA_DO
>> -
>>  #undef MSA_LOOP_COND
>>
>>  #define MSA_LOOP_COND(DF) \
>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>> index df685e4..3057669 100644
>> --- a/target/mips/translate.c
>> +++ b/target/mips/translate.c
>> @@ -28973,6 +28973,90 @@ static inline void gen_ilvod_d(CPUMIPSState *env, uint32_t wd,
>>      tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
>>  }
>>
>> +/*
>> + * [MSA] ILVEV.B wd, ws, wt
>> + *
>> + *   Vector Interleave Even (byte data elements)
>> + *
>> + */
>> +static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
>> +                               uint32_t ws, uint32_t wt)
>> +{
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    TCGv_i64 mask = tcg_const_i64(0x00ff00ff00ff00ffULL);
>> +
>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
>> +    tcg_gen_shli_i64(t2, t2, 8);
>> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
>> +
>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>> +    tcg_gen_shli_i64(t2, t2, 8);
>> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
>> +
>> +    tcg_temp_free_i64(mask);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>> +}
>> +
>> +/*
>> + * [MSA] ILVEV.H wd, ws, wt
>> + *
>> + *   Vector Interleave Even (halfword data elements)
>> + *
>> + */
>> +static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
>> +                               uint32_t ws, uint32_t wt)
>> +{
>> +    TCGv_i64 t1 = tcg_temp_new_i64();
>> +    TCGv_i64 t2 = tcg_temp_new_i64();
>> +    TCGv_i64 mask = tcg_const_i64(0x0000ffff0000ffffULL);
>> +
>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
>> +    tcg_gen_shli_i64(t2, t2, 16);
>> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
>> +
>> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>> +    tcg_gen_shli_i64(t2, t2, 16);
>> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
>> +
>> +    tcg_temp_free_i64(mask);
>> +    tcg_temp_free_i64(t1);
>> +    tcg_temp_free_i64(t2);
>> +}
> 
> Apparently you missed my comment about refactoring using mask/shift as
> arguments:
> 
> static inline void gen_ilvev_hb(CPUMIPSState *env, uint32_t wd,
>                                 uint32_t ws, uint32_t wt,
>                                 int64_t mask, int64_t shift)
> {
>     TCGv_i64 t1 = tcg_temp_new_i64();
>     TCGv_i64 t2 = tcg_temp_new_i64();
>     TCGv_i64 tm = tcg_const_i64(mask);
> 
>     tcg_gen_and_i64(t1, msa_wr_d[wt * 2], tm);
>     tcg_gen_and_i64(t2, msa_wr_d[ws * 2], tm);
>     tcg_gen_shli_i64(t2, t2, shift);
>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> 
>     tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], tm);
>     tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], tm);
>     tcg_gen_shli_i64(t2, t2, shift);
>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> 
>     tcg_temp_free_i64(tm);
>     tcg_temp_free_i64(t1);
>     tcg_temp_free_i64(t2);
> }
> 
> static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
>                                uint32_t ws, uint32_t wt)
> {
>     gen_ilvev_hb(env, wd, ws, wt, 0x00ff00ff00ff00ffLL, 8);
> }
> 
> static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
>                                uint32_t ws, uint32_t wt)
> {
>     gen_ilvev_hb(env, wd, ws, wt, 0x0000ffff0000ffffLL, 16);
> }
> 
> 
>> +
>> +/*
>> + * [MSA] ILVEV.W wd, ws, wt
>> + *
>> + *   Vector Interleave Even (word data elements)
>> + *
>> + */
>> +static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
>> +                               uint32_t ws, uint32_t wt)
>> +{
>> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2],
>> +                        msa_wr_d[ws * 2], 32, 32);
>> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[wt * 2 + 1],
>> +                        msa_wr_d[ws * 2 + 1], 32, 32);
>> +}
>> +
>> +/*
>> + * [MSA] ILVEV.D wd, ws, wt
>> + *
>> + *   Vector Interleave Even (Doubleword data elements)
>> + *
>> + */
>> +static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
>> +                               uint32_t ws, uint32_t wt)
>> +{
>> +    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
>> +    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
>> +}
>> +
>>  static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
>>  {
>>  #define MASK_MSA_3R(op)    (MASK_MSA_MINOR(op) | (op & (0x7 << 23)))
>> @@ -29129,7 +29213,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
>>          gen_helper_msa_mod_s_df(cpu_env, tdf, twd, tws, twt);
>>          break;
>>      case OPC_ILVEV_df:
>> -        gen_helper_msa_ilvev_df(cpu_env, tdf, twd, tws, twt);
>> +        switch (df) {
>> +        case DF_BYTE:
>> +            gen_ilvev_b(env, wd, ws, wt);
>> +            break;
>> +        case DF_HALF:
>> +            gen_ilvev_h(env, wd, ws, wt);
>> +            break;
>> +        case DF_WORD:
>> +            gen_ilvev_w(env, wd, ws, wt);
>> +            break;
>> +        case DF_DOUBLE:
>> +            gen_ilvev_d(env, wd, ws, wt);
>> +            break;
>> +        default:
>> +            assert(0);
>> +        }
>>          break;
>>      case OPC_BINSR_df:
>>          gen_helper_msa_binsr_df(cpu_env, tdf, twd, tws, twt);
>>
