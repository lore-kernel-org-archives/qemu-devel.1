Received: from eggs.gnu.org ([2001:4830:134:3::10]:59448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQJDe-0004aj-6M
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQJDa-0001vY-6h
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:05:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQJDZ-0001v6-SY
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 16:05:42 -0400
References: <20170627191221.31650-1-laurent@vivier.eu>
	<20170627191221.31650-2-laurent@vivier.eu>
	<0d870134-fd3e-67ca-9112-94672cf7e742@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9f5d4ac9-8efa-c496-94a0-72e3f4813338@vivier.eu>
Date: Wed, 28 Jun 2017 22:05:19 +0200
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>

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

We want to compute !(A || N), but I think this is (!A || !N)

>     tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_Z);
>     tcg_gen_or_i32(c->v1, c->v1, fpsr);

So we have Z || !A || !N

Do you think we can do better than:

     tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
     tcg_gen_shli_i32(c->v1, c->v1,
                      ctz32(FPSR_CC_N) - ctz32(FPSR_CC_A));
     tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_Z | FPSR_CC_N);
     tcg_gen_or_i32(c->v1, c->v1, fpsr);
     tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);

Thanks,
Laurent
