Received: from eggs.gnu.org ([2001:4830:134:3::10]:47574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXJ1T-0004N9-Rw
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXJ1Q-0006nW-N3
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:18:07 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXJ1Q-0006n5-J9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:18:04 -0400
Received: by mail-qk0-x242.google.com with SMTP id d136so1027861qkg.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 20:18:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170512233843.27713-1-f4bug@amsat.org>
	<20170512233843.27713-7-f4bug@amsat.org>
	<16f76ae2-4cc2-ac89-065c-5158539ca2e6@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2d11390a-2adc-e40a-6b5c-7c6ee4e7401d@amsat.org>
Date: Tue, 18 Jul 2017 00:18:00 -0300
MIME-Version: 1.0
In-Reply-To: <16f76ae2-4cc2-ac89-065c-5158539ca2e6@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 6/6] target/sparc: optimize various
 functions using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 05/12/2017 09:08 PM, Richard Henderson wrote:
> On 05/12/2017 04:38 PM, Philippe Mathieu-Daudé wrote:
[...]
>>   static inline void gen_op_add_cc(TCGv dst, TCGv src1, TCGv src2)
>> @@ -638,8 +634,7 @@ static inline void gen_op_mulscc(TCGv dst, TCGv 
>> src1, TCGv src2)
>>       // env->y = (b2 << 31) | (env->y >> 1);
>>       tcg_gen_andi_tl(r_temp, cpu_cc_src, 0x1);
>>       tcg_gen_shli_tl(r_temp, r_temp, 31);
>> -    tcg_gen_shri_tl(t0, cpu_y, 1);
>> -    tcg_gen_andi_tl(t0, t0, 0x7fffffff);
>> +    tcg_gen_extract_tl(t0, cpu_y, 1, 31);
>>       tcg_gen_or_tl(t0, t0, r_temp);
>>       tcg_gen_andi_tl(cpu_y, t0, 0xffffffff);

So this 0xffffffff mask is incorrect and should be 0x7fffffff?

> 
> But this should use
> 
>    tcg_gen_extract_tl(cpu_y, cpu_y, 1, 31);
>    tcg_gen_deposit_tl(cpu_y, cpu_y, cpu_cc_src, 31, 1);
> 
> 
> r~
