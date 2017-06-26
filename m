Received: from eggs.gnu.org ([2001:4830:134:3::10]:34178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPP2S-0000jN-5u
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dPP2M-0001KQ-7B
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:06:28 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:63235)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dPP2L-0001K2-SJ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:06:22 -0400
References: <20170625192125.9992-1-laurent@vivier.eu>
	<20170625192125.9992-4-laurent@vivier.eu>
	<d792cbf9-454a-1237-6c1a-02336a020d25@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2110ab22-2402-f84a-9bae-6fd68b570b77@vivier.eu>
Date: Mon, 26 Jun 2017 10:05:57 +0200
MIME-Version: 1.0
In-Reply-To: <d792cbf9-454a-1237-6c1a-02336a020d25@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/7] target/m68k: add fsglmul and fsgldiv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Le 25/06/2017 à 21:44, Philippe Mathieu-Daudé a écrit :
> Hi Laurent,
> 
> On 06/25/2017 04:21 PM, Laurent Vivier wrote:
>> fsglmul and fsgldiv truncate data to single precision before computing
>> results.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   target/m68k/fpu_helper.c | 22 ++++++++++++++++++++++
>>   target/m68k/helper.h     |  2 ++
>>   target/m68k/translate.c  |  6 ++++++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
>> index 912c0b7..0d83925 100644
>> --- a/target/m68k/fpu_helper.c
>> +++ b/target/m68k/fpu_helper.c
>> @@ -183,11 +183,33 @@ void HELPER(fmul)(CPUM68KState *env, FPReg *res,
>> FPReg *val0, FPReg *val1)
>>       res->d = floatx80_mul(val0->d, val1->d, &env->fp_status);
>>   }
>>   +void HELPER(fsglmul)(CPUM68KState *env, FPReg *res, FPReg *val0,
>> FPReg *val1)
>> +{
>> +    float32 a, b, c;
>> +
>> +    a = floatx80_to_float32(val0->d, &env->fp_status);
>> +    b = floatx80_to_float32(val1->d, &env->fp_status);
>> +    c = float32_mul(a, b, &env->fp_status);
> 
> Why not use floatx80_mul() directly?
> 
>> +
>> +    res->d = float32_to_floatx80(c, &env->fp_status);
>> +}
>> +
>>   void HELPER(fdiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg
>> *val1)
>>   {
>>       res->d = floatx80_div(val1->d, val0->d, &env->fp_status);
>>   }
>>   +void HELPER(fsgldiv)(CPUM68KState *env, FPReg *res, FPReg *val0,
>> FPReg *val1)
>> +{
>> +    float32 a, b, c;
>> +
>> +    a = floatx80_to_float32(val1->d, &env->fp_status);
>> +    b = floatx80_to_float32(val0->d, &env->fp_status);
>> +    c = float32_div(a, b, &env->fp_status);
> 
> floatx80_div()?
> 

Just to follow the spec of the instruction:

"if either operand requires more than 24 bits of mantissa to be
accurately represented, the extraneous mantissa bits are truncated prior
to the multiplication;"

Do you think I should keep them in floatx80 and use the floatx80_round()
(I introduce latter in the series) to reduce the precision prior the
floatx80_mul()?

Thanks,
Laurent
