Received: from eggs.gnu.org ([2001:4830:134:3::10]:41289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLclS-0003rj-QR
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLclR-0001aM-Qv
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:57:18 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:34764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLclR-0001ZU-Cv
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:57:17 -0400
Received: by mail-it0-x241.google.com with SMTP id 201so3090218itu.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 14:57:15 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <5fd00837-211a-011c-be1c-d5e2e7417d9d@twiddle.net>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-3-rth@twiddle.net> <87vanxmyac.fsf@linaro.org>
	<5fd00837-211a-011c-be1c-d5e2e7417d9d@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Jun 2017 18:57:14 -0300
Message-ID: <CAAdtpL61qwKDcpMU6eOZu10GYZBOgN97dRuEA3QbR6aY4aTSfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/alpha: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Peter cleaned that and improved the doc on ARM:
https://patchwork.kernel.org/patch/9690993/
(commit b636649f5a2e108413dd171edaf320f781f57942)

$ git grep -- singlestep_enabled target|wc -l
113
still confusing...

On Thu, Jun 15, 2017 at 5:55 PM, Richard Henderson <rth@twiddle.net> wrote:
> On 06/15/2017 01:48 AM, Alex Benn=C3=A9e wrote:
>>
>>
>> Richard Henderson <rth@twiddle.net> writes:
>>
>>> Signed-off-by: Richard Henderson <rth@twiddle.net>
>>> ---
>>>   target/alpha/translate.c | 27 ++++++++++++++++++++++-----
>>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
>>> index 7c45ae3..a48e451 100644
>>> --- a/target/alpha/translate.c
>>> +++ b/target/alpha/translate.c
>>> @@ -84,6 +84,7 @@ typedef enum {
>>>          the PC (for whatever reason), so there's no need to do it agai=
n
>>> on
>>>          exiting the TB.  */
>>>       EXIT_PC_UPDATED,
>>> +    EXIT_PC_UPDATED_NOCHAIN,
>>>
>>>       /* We are exiting the TB, but have neither emitted a goto_tb, nor
>>>          updated the PC for the next instruction to be executed.  */
>>> @@ -458,11 +459,17 @@ static bool in_superpage(DisasContext *ctx, int64=
_t
>>> addr)
>>>   #endif
>>>   }
>>>
>>> +static bool use_exit_tb(DisasContext *ctx)
>>> +{
>>> +    return ((ctx->tb->cflags & CF_LAST_IO)
>>> +            || ctx->singlestep_enabled
>>> +            || singlestep);
>>> +}
>>
>>
>> minor nit: why start testing this global? At the least we should
>> probably seed ctx->singlestep_enabled when we set up for translation.
>>
>>> +
>>>   static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
>>>   {
>>>       /* Suppress goto_tb in the case of single-steping and IO.  */
>>> -    if ((ctx->tb->cflags & CF_LAST_IO)
>>> -        || ctx->singlestep_enabled || singlestep) {
>
>
> I didn't start testing this global.  It's already there.
>
> Further, despite the name similarity these are very different conditions.
>
> For ctx->singlestep_enabled we emit a debug exception at the end of every
> instruction.
>
> For singlestep, we must execute only one insn in the TB and further we mu=
st
> return to the main loop after the TB.  Both are required for -singlestep =
-d
> cpu to log all that's being requested.
>
> One cannot combine the two conditions.
>
>
> r~
>
