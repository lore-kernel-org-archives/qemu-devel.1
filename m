Received: from eggs.gnu.org ([2001:4830:134:3::10]:54808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cFOMv-0002SX-0G
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cFOMq-0005GU-RP
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:49:57 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cFOMq-0005GJ-Mk
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 11:49:52 -0500
Received: by mail-qt0-f195.google.com with SMTP id m48so2688430qta.2
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 08:49:52 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-63-git-send-email-rth@twiddle.net>
	<87r35hxf04.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e1c33280-7442-d03a-446f-8150d4b86353@twiddle.net>
Date: Fri, 9 Dec 2016 08:48:49 -0800
MIME-Version: 1.0
In-Reply-To: <87r35hxf04.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 62/64] tcg: Use ctpop to generate ctz if
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 12/09/2016 08:07 AM, Alex Bennée wrote:
> 
> Richard Henderson <rth@twiddle.net> writes:
> 
>> Particularly when andc is also available, this is two insns
>> shorter than using clz to compute ctz.
>>
>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>> ---
>>  tcg/tcg-op.c | 107 ++++++++++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 65 insertions(+), 42 deletions(-)
>>
>> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
>> index 6f4b1b6..d1debde 100644
>> --- a/tcg/tcg-op.c
>> +++ b/tcg/tcg-op.c
>> @@ -497,43 +497,46 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
> <snip>
>>      } else {
>> -        gen_helper_ctz_i32(ret, arg1, arg2);
>> +        TCGv_i32 z, t;
>> +        if (TCG_TARGET_HAS_ctpop_i32 && TCG_TARGET_HAS_andc_i32) {
>> +            t = tcg_temp_new_i32();
>> +            tcg_gen_subi_i32(t, arg1, 1);
>> +            tcg_gen_andc_i32(t, t, arg1);
>> +            tcg_gen_ctpop_i32(t, t);
>> +        do_movc:
> 
> Hmmm and...
> 
> <snip>
>>  void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
>> @@ -1842,18 +1845,29 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
>>  {
>>      if (TCG_TARGET_HAS_ctz_i64) {
>>          tcg_gen_op3_i64(INDEX_op_ctz_i64, ret, arg1, arg2);
> <snip>
>>      } else {
>> -        gen_helper_ctz_i64(ret, arg1, arg2);
>> +        TCGv_i64 z, t;
>> +        if (TCG_TARGET_HAS_ctpop_i64 && TCG_TARGET_HAS_andc_i64) {
>> +            t = tcg_temp_new_i64();
>> +            tcg_gen_subi_i64(t, arg1, 1);
>> +            tcg_gen_andc_i64(t, t, arg1);
>> +            tcg_gen_ctpop_i64(t, t);
>> +        do_movc:
> 
> Hmmm.
> 
> So I'm not a goto hater as it makes sense for a bunch of things. But
> this seems just a little too liberal usage to my eyes. What's wrong with
> a little extra nesting (seeing the compiler sorts it all out in the
> end):
> 
>         if ((TCG_TARGET_HAS_ctpop_i32 && TCG_TARGET_HAS_andc_i32)
>             || TCG_TARGET_HAS_clz_i32 || TCG_TARGET_HAS_clz_i64) {
> 
>             TCGv_i32 z, t;
> 
>             if (TCG_TARGET_HAS_ctpop_i32 && TCG_TARGET_HAS_andc_i32) {
>                 t = tcg_temp_new_i32();
>                 tcg_gen_subi_i32(t, arg1, 1);
>                 tcg_gen_andc_i32(t, t, arg1);
>                 tcg_gen_ctpop_i32(t, t);
>             } else if (TCG_TARGET_HAS_clz_i32 || TCG_TARGET_HAS_clz_i64) {
>                 /* Since all non-x86 hosts have clz(0) == 32, don't fight it.  */
>                 t = tcg_temp_new_i32();
>                 tcg_gen_neg_i32(t, arg1);
>                 tcg_gen_and_i32(t, t, arg1);
>                 tcg_gen_clzi_i32(t, t, 32);
>                 tcg_gen_xori_i32(t, t, 31);
>             }
>             /* final movc */
>             z = tcg_const_i32(0);
>             tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
>             tcg_temp_free_i32(t);
>             tcg_temp_free_i32(z);
>         } else {
>             gen_helper_ctz_i32(ret, arg1, arg2);
>         }

That does look better.  Thanks,


r~
