Received: from eggs.gnu.org ([2001:4830:134:3::10]:40409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDwoq-00084Q-7s
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDwon-0006O9-0I
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:49:36 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDwom-0006Nl-Q1
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:49:32 -0400
Received: by mail-pg0-x244.google.com with SMTP id p9-v6so8367602pgc.9
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 11:49:32 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-10-richard.henderson@linaro.org>
	<87lgd3aafy.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <58bc1b1f-f965-6bdb-fcc3-7ae8d8965174@linaro.org>
Date: Wed, 2 May 2018 11:49:28 -0700
MIME-Version: 1.0
In-Reply-To: <87lgd3aafy.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 9/9] target/arm: Implement FP
 data-processing (3 source) for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 05/01/2018 04:21 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> We missed all of the scalar fp16 fma operations.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-a64.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
>> index 11b90b7eb0..0cb1fc4d67 100644
>> --- a/target/arm/translate-a64.c
>> +++ b/target/arm/translate-a64.c
>> @@ -5154,6 +5154,44 @@ static void handle_fp_3src_double(DisasContext *s, bool o0, bool o1,
>>      tcg_temp_free_i64(tcg_res);
>>  }
>>
>> +/* Floating-point data-processing (3 source) - half precision */
>> +static void handle_fp_3src_half(DisasContext *s, bool o0, bool o1,
>> +                                int rd, int rn, int rm, int ra)
>> +{
>> +    TCGv_i32 tcg_op1, tcg_op2, tcg_op3;
>> +    TCGv_i32 tcg_res = tcg_temp_new_i32();
>> +    TCGv_ptr fpst = get_fpstatus_ptr(true);
>> +
>> +    tcg_op1 = read_fp_hreg(s, rn);
>> +    tcg_op2 = read_fp_hreg(s, rm);
>> +    tcg_op3 = read_fp_hreg(s, ra);
>> +
>> +    /* These are fused multiply-add, and must be done as one
>> +     * floating point operation with no rounding between the
>> +     * multiplication and addition steps.
> 
> I got confused first time reading this as we cover F[N]M[ADD|SUB].
> Perhaps that is better enumerated at the top of the function?

*shrug* It's an exact copy of the beginnings of the single and double
functions.  Is it really that confusing?


r~
