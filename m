Received: from eggs.gnu.org ([2001:4830:134:3::10]:36847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsrfr-0005mu-7e
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsrfn-0002LH-Qc
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:37:26 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fsrfn-0002Kt-HL
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 11:37:23 -0400
Received: by mail-pf1-x443.google.com with SMTP id k21-v6so2912535pff.11
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 08:37:23 -0700 (PDT)
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-12-richard.henderson@linaro.org>
	<CAFEAcA-vJu-i2GWy3_WK2BNZj1LhDugb2MnHNMghzc6+O+XeTw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13f902d3-9809-2cf3-ca92-5be6fa54a5cf@linaro.org>
Date: Thu, 23 Aug 2018 08:37:17 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-vJu-i2GWy3_WK2BNZj1LhDugb2MnHNMghzc6+O+XeTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/20] target/arm: Clear unused predicate
 bits for LD1RQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 08/23/2018 08:21 AM, Peter Maydell wrote:
> On 9 August 2018 at 05:21, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> The 16-byte load only uses 16 predicate bits.  But while
>> reusing the other load infrastructure, we find other bits
>> that are set and trigger an assert.  To avoid this and
>> retain the assert, zero-extend the predicate that we pass
>> to the LD1 helper.
>>
>> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-sve.c | 25 +++++++++++++++++++++++--
>>  1 file changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
>> index d27bc8c946..bef6b8242d 100644
>> --- a/target/arm/translate-sve.c
>> +++ b/target/arm/translate-sve.c
>> @@ -4765,12 +4765,33 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
>>      unsigned vsz = vec_full_reg_size(s);
>>      TCGv_ptr t_pg;
>>      TCGv_i32 desc;
>> +    int poff;
>>
>>      /* Load the first quadword using the normal predicated load helpers.  */
>>      desc = tcg_const_i32(simd_desc(16, 16, zt));
>> -    t_pg = tcg_temp_new_ptr();
>>
>> -    tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
>> +    poff = pred_full_reg_offset(s, pg);
>> +    if (vsz > 16) {
>> +        /*
>> +         * Zero-extend the first 16 bits of the predicate into a temporary.
>> +         * This avoids triggering an assert making sure we don't have bits
>> +         * set within a predicate beyond VQ, but we have lowered VQ to 1
>> +         * for this load operation.
>> +         */
>> +        TCGv_i64 tmp = tcg_temp_new_i64();
>> +#ifdef HOST_WORDS_BIGENDIAN
>> +        poff += 6;
>> +#endif
>> +        tcg_gen_ld16u_i64(tmp, cpu_env, poff);
>> +
>> +        poff = offsetof(CPUARMState, vfp.preg_tmp);
>> +        tcg_gen_st_i64(tmp, cpu_env, poff);
>> +        tcg_temp_free_i64(tmp);
>> +    }
>> +
>> +    t_pg = tcg_temp_new_ptr();
>> +    tcg_gen_addi_ptr(t_pg, cpu_env, poff);
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> The bigendian #ifdef in the middle of the code is a little
> ugly, though -- I don't suppose it's possible to avoid it
> (or abstract it away) somehow?

Adding a helper function for this one use didn't seem worthwhile.  But I
certainly can duplicate the form of vec_reg_offset if you prefer.


r~
