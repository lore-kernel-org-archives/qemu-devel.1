Received: from eggs.gnu.org ([209.51.188.92]:60225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h2KxV-0007mX-Qr
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h2KxV-0003x2-0j
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:15:05 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h2KxU-0003wT-Na
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 14:15:04 -0500
Received: by mail-pf1-x444.google.com with SMTP id h1so14822009pfo.7
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 11:15:04 -0800 (PST)
References: <20190308185932.4954-1-richard.henderson@linaro.org>
	<CAFEAcA_ri8+bspkOhfmWu2fyPxomECZ2WPButBG6qOscBOWLZA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fa71b1a6-9211-7e6b-be0b-8f8d69872214@linaro.org>
Date: Fri, 8 Mar 2019 11:15:00 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ri8+bspkOhfmWu2fyPxomECZ2WPButBG6qOscBOWLZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/hppa: Check for page crossings in
 use_goto_tb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sven Schnelle <svens@stackframe.org>

On 3/8/19 11:04 AM, Peter Maydell wrote:
> On Fri, 8 Mar 2019 at 19:00, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We got away with eliding this check when target/hppa was user-only,
>> but missed adding this check when adding system support.
>>
>> Fixes an early crash in the HP-UX 11 installer.
>>
>> Reported-by: Sven Schnelle <svens@stackframe.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/hppa/translate.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
>> index dc5636fe94..6c815e05c2 100644
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -816,12 +816,10 @@ static bool gen_illegal(DisasContext *ctx)
>>
>>  static bool use_goto_tb(DisasContext *ctx, target_ureg dest)
>>  {
>> -    /* Suppress goto_tb in the case of single-steping and IO.  */
>> -    if ((tb_cflags(ctx->base.tb) & CF_LAST_IO)
>> -        || ctx->base.singlestep_enabled) {
>> -        return false;
>> -    }
>> -    return true;
>> +    /* Suppress goto_tb for page crossing, IO, or single-steping.  */
> 
> "stepping"

Oops.

>> +    return !(((ctx->base.pc_first ^ dest) & TARGET_PAGE_MASK)
>> +             || (tb_cflags(ctx->base.tb) & CF_LAST_IO)
>> +             || ctx->base.singlestep_enabled);
>>  }
> 
> I note that (a) this isn't the way every other port phrases
> the "same page" check -- they generally use something like
>  (ctx->base.tb->pc & TARGET_PAGE_MASK) == (dest & TARGET_PAGE_MASK)

This should be the same result.

ctx->base.pc_first was initialized from tb->pc.  I find the xor expression more
compact and usually fits on a line, where repeating TARGET_PAGE_MASK doesn't.

> and (b) the other ports generally keep that check inside an
> ifndef CONFIG_USER_ONLY.

I've wondered about that.  It certainly works for normal executables, but I
wonder if there are jit-like cases that fail when eliding that check.

Here, I think I was just a bit lazy.

Thoughts?


r~
