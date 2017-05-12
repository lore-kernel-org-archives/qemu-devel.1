Received: from eggs.gnu.org ([2001:4830:134:3::10]:57963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8zlH-0007ex-B7
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8zlG-0006qi-B2
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:52:55 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8zlG-0006q1-7B
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:52:54 -0400
Received: by mail-qk0-x241.google.com with SMTP id y128so6091671qka.3
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 18:52:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-6-f4bug@amsat.org>
	<06376c63-cf60-5496-60a3-d6b1a129f397@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c2737e4-0f46-684e-a410-ba9d59023c09@amsat.org>
Date: Thu, 11 May 2017 22:52:49 -0300
MIME-Version: 1.0
In-Reply-To: <06376c63-cf60-5496-60a3-d6b1a129f397@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/8] target/m68k: optimize bcd_flags()
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

This patch is correct:

$ docker run -it -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle --sp-file 
scripts/coccinelle/tcg_gen_extract.cocci --macro-file 
scripts/cocci-macro-file.h --dir target/m68k
init_defs_builtins: /usr/lib64/coccinelle/standard.h
init_defs: scripts/cocci-macro-file.h
HANDLING: target/m68k/helper.c
HANDLING: target/m68k/gdbstub.c
HANDLING: target/m68k/translate.c
candidate at target/m68k/translate.c:1466
   op_size: i32/i32 (same)
   low_bits: 1 (value: 0x1)
   len: 0x1
   len_bits == low_bits
   candidate IS optimizable

On 05/11/2017 05:41 AM, Laurent Vivier wrote:
> Le 10/05/2017 à 22:05, Philippe Mathieu-Daudé a écrit :
>> Applied using Coccinelle script.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  target/m68k/translate.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>> index 9f60fbc0db..babb9e2c5b 100644
>> --- a/target/m68k/translate.c
>> +++ b/target/m68k/translate.c
>> @@ -1463,8 +1463,7 @@ static void bcd_flags(TCGv val)
>>      tcg_gen_andi_i32(QREG_CC_C, val, 0x0ff);
>>      tcg_gen_or_i32(QREG_CC_Z, QREG_CC_Z, QREG_CC_C);
>>
>> -    tcg_gen_shri_i32(QREG_CC_C, val, 8);
>> -    tcg_gen_andi_i32(QREG_CC_C, QREG_CC_C, 1);
>> +    tcg_gen_extract_i32(QREG_CC_C, val, 8, 1);
>>
>>      tcg_gen_mov_i32(QREG_CC_X, QREG_CC_C);
>>  }
>>
>
> Acked-by: Laurent Vivier <laurent@vivier.eu>

Thanks!
