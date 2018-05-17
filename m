Received: from eggs.gnu.org ([2001:4830:134:3::10]:46099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJMdq-0004s9-Ut
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJMdm-0008K2-FI
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:24:38 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJMdm-0008JE-9a
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:24:34 -0400
Received: by mail-qk0-x243.google.com with SMTP id d125-v6so4232654qkb.8
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:24:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-37-edgar.iglesias@gmail.com>
	<796ed3f8-6a5d-371f-791d-071f4d6f2cdd@amsat.org>
	<e4a2fa3b-eaa7-be39-71ec-ad3e0420afb2@amsat.org>
	<20180517164239.xyy2gbi5j2uuppix@toto>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3a4a9756-0f55-0902-507d-2df1f659f749@amsat.org>
Date: Thu, 17 May 2018 14:24:28 -0300
MIME-Version: 1.0
In-Reply-To: <20180517164239.xyy2gbi5j2uuppix@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 36/38] target-microblaze: Use
 tcg_gen_movcond in eval_cond_jmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, richard.henderson@linaro.org, qemu-devel@nongnu.org, frederic.konrad@adacore.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 05/17/2018 01:42 PM, Edgar E. Iglesias wrote:
> On Thu, May 17, 2018 at 11:48:35AM -0300, Philippe Mathieu-Daudé wrote:
>> Hi Edgar,
>>
>> On 05/17/2018 11:22 AM, Philippe Mathieu-Daudé wrote:
>>> On 05/16/2018 03:51 PM, Edgar E. Iglesias wrote:
>>>> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>>>>
>>>> Cleanup eval_cond_jmp to use tcg_gen_movcond_i64().
>>>> No functional change.
>>>>
>>>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>>> ---
>>>>  target/microblaze/translate.c | 16 ++++++++++------
>>>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
>>>> index a846797d9c..78c2855ff0 100644
>>>> --- a/target/microblaze/translate.c
>>>> +++ b/target/microblaze/translate.c
>>>> @@ -1171,12 +1171,16 @@ static inline void eval_cc(DisasContext *dc, unsigned int cc,
>>>>  
>>>>  static void eval_cond_jmp(DisasContext *dc, TCGv_i64 pc_true, TCGv_i64 pc_false)
>>>>  {
>>>> -    TCGLabel *l1 = gen_new_label();
>>>> -    /* Conditional jmp.  */
>>>> -    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_false);
>>>> -    tcg_gen_brcondi_i32(TCG_COND_EQ, env_btaken, 0, l1);
>>>> -    tcg_gen_mov_i64(cpu_SR[SR_PC], pc_true);
>>>> -    gen_set_label(l1);
>>>> +    TCGv_i64 tmp_btaken = tcg_temp_new_i64();
>>>> +    TCGv_i64 tmp_zero = tcg_const_i64(0);
>>
>> Why not use cpu_R[0] directly?
>>
>> I wonder, maybe the current model doesn't not have R0 hardwired to 0?
> 
> It does but cpu_R[0] is 32bit so we would still need a temp to extend it...

Oh true, I missed that. Thanks :)

> 
> Cheers,
> Edgar
> 
>>
>>>> +
>>>> +    tcg_gen_extu_i32_i64(tmp_btaken, env_btaken);
>>>
>>> env_btaken is i32, ok.
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>
>>>> +    tcg_gen_movcond_i64(TCG_COND_NE, cpu_SR[SR_PC],
>>>> +                        tmp_btaken, tmp_zero,
>>>> +                        pc_true, pc_false);
>>
>> So we could drop a temp, using:
>>
>>         tcg_gen_movcond_i64(TCG_COND_NE, cpu_SR[SR_PC],
>>                             tmp_btaken, cpu_R[0],
>>                             pc_true, pc_false);
>>
>>>> +
>>>> +    tcg_temp_free_i64(tmp_btaken);
>>>> +    tcg_temp_free_i64(tmp_zero);
>>>>  }
>>>>  
>>>>  static void dec_bcc(DisasContext *dc)
>>>>
> 
