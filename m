Received: from eggs.gnu.org ([2001:4830:134:3::10]:46115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQ0Sh-0006wo-6q
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQ0Sd-00059L-5V
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:04:03 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:60866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQ0Sc-00055I-Qq
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 20:03:59 -0400
References: <20170627191221.31650-1-laurent@vivier.eu>
	<20170627191221.31650-2-laurent@vivier.eu>
	<0d870134-fd3e-67ca-9112-94672cf7e742@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e7296c14-1b4b-9508-aaaf-c1bc3ad49409@vivier.eu>
Date: Wed, 28 Jun 2017 02:03:33 +0200
MIME-Version: 1.0
In-Reply-To: <0d870134-fd3e-67ca-9112-94672cf7e742@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/7] target/m68k: add fscc.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Le 27/06/2017 à 22:00, Richard Henderson a écrit :
> On 06/27/2017 12:12 PM, Laurent Vivier wrote:
>>       case 3:  /* Ordered Greater than or Equal Z || !(A || N) */
>>       case 19: /* Greater than or Equal Z || !(A || N) */
>> +        g_assert(FPSR_CC_A == (FPSR_CC_N >> 3));
>> +        c->v1 = tcg_temp_new();
>> +        c->g1 = 0;
>> +        tcg_gen_shli_i32(c->v1, fpsr, 3);
>> +        tcg_gen_or_i32(c->v1, c->v1, fpsr);
>> +        tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
>> +        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_N | FPSR_CC_Z);
>> +        c->tcond = TCG_COND_NE;
> 
> Still with the unmasked shift.
> 
>     tcg_gen_not_i32(c->v1, fpsr);
>     tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_A | FPSR_CC_N);
>     tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_Z);
>     tcg_gen_or_i32(c->v1, c->v1, fpsr);
> 
> 
>>       case 5:  /* Ordered Less than or Equal Z || (N && !A) */
>>       case 21: /* Less than or Equal Z || (N && !A) */
>> +        g_assert(FPSR_CC_A == (FPSR_CC_N >> 3));
>> +        c->v1 = tcg_temp_new();
>> +        c->g1 = 0;
>> +        tcg_gen_xori_i32(c->v1, fpsr, FPSR_CC_A);
>> +        tcg_gen_shli_i32(c->v1, c->v1, 3);
>> +        tcg_gen_ori_i32(c->v1, c->v1, FPSR_CC_Z);
>> +        tcg_gen_and_i32(c->v1, c->v1, fpsr);
>> +        c->tcond = TCG_COND_NE;
> 
> Likewise.
> 
>     tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
>     tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_A));
>     tcg_gen_andc_i32(c->v1, fpsr, c->v1);
>     tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_Z | FPSR_CC_N);
> 
> 
>>       case 10: /* Unordered or Greater Than A || !(N || Z)) */
>>       case 26: /* Not Less or Equal A || !(N || Z)) */
>> +        g_assert(FPSR_CC_Z == (FPSR_CC_N >> 1));
>> +        c->v1 = tcg_temp_new();
>> +        c->g1 = 0;
>> +        tcg_gen_shli_i32(c->v1, fpsr, 1);
>> +        tcg_gen_or_i32(c->v1, c->v1, fpsr);
>> +        tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
>> +        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_N | FPSR_CC_A);
>> +        c->tcond = TCG_COND_NE;
> 
> Likewise.
> 
>     tcg_gen_not_i32(c->v1, fpsr);
>     tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_Z | FPSR_CC_N);
>     tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_A);
>     tcg_gen_or_i32(c->v1, c->v1, fpsr);
> 
> 
>>       case 12: /* Unordered or Less Than A || (N && !Z) */
>>       case 28: /* Not Greater than or Equal A || (N && !Z) */
>> +        c->v1 = tcg_temp_new();
>> +        c->g1 = 0;
>> +        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
>> +        tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) -
>> ctz32(FPSR_CC_Z));
>> +        tcg_gen_andc_i32(c->v1, fpsr, c->v1);
>> +        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_A | FPSR_CC_N);
>> +        c->tcond = TCG_COND_NE;
> 
> I hadn't meant that this was the only one to fix.
> 

Thank you Richard, but all these changes break something somewhere, I'm
searching why.

Thanks,
Laurent
