Received: from eggs.gnu.org ([2001:4830:134:3::10]:34551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFieV-0002Wb-Ud
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFieS-0002vK-Rx
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:01:44 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFieS-0002vG-MN
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:01:40 -0400
Received: by mail-oi0-x241.google.com with SMTP id w138so16209435oiw.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:01:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <a98c67f8-3c5c-b68d-beea-f1972bb3dc0d@twiddle.net>
	<20170513002906.31201-1-f4bug@amsat.org>
	<b8f1e25e-cde0-9d37-e4f1-f64b78447c58@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <766ac5d7-c6f0-7458-6c2f-8e115db18fe5@amsat.org>
Date: Tue, 30 May 2017 12:01:37 -0300
MIME-Version: 1.0
In-Reply-To: <b8f1e25e-cde0-9d37-e4f1-f64b78447c58@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: optimize gen_extr_i64_i32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 05/12/2017 11:13 PM, Richard Henderson wrote:
> On 05/12/2017 05:29 PM, Philippe Mathieu-Daudé wrote:
>> Inspired by Richard Henderson comment:
>>
>>
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg02277.html
>>
>> Patch applied mechanically with this coccinelle semantic patch:
>>
>>      @@
>>      expression lo, hi,arg;
>>      @@
>>      -tcg_gen_extrl_i64_i32(lo, arg);
>>      -tcg_gen_extrh_i64_i32(hi, arg);
>>      +tcg_gen_extr_i64_i32(lo, hi, arg);
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   tcg/tcg-op.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
>> index 6b1f41500c..f3d556c21a 100644
>> --- a/tcg/tcg-op.c
>> +++ b/tcg/tcg-op.c
>> @@ -2562,8 +2562,7 @@ void tcg_gen_extr_i64_i32(TCGv_i32 lo, TCGv_i32
>> hi, TCGv_i64 arg)
>>           tcg_gen_mov_i32(lo, TCGV_LOW(arg));
>>           tcg_gen_mov_i32(hi, TCGV_HIGH(arg));
>>       } else {
>> -        tcg_gen_extrl_i64_i32(lo, arg);
>> -        tcg_gen_extrh_i64_i32(hi, arg);
>> +        tcg_gen_extr_i64_i32(lo, hi, arg);
>
> You've just created an instance of infinite self-recursion.

Now I understand why Eric writes "applied mechanically" then "verified 
manually" in his commits, it avoid to ask for non-sens review...
