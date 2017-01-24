Received: from eggs.gnu.org ([2001:4830:134:3::10]:53937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW71y-0000MM-9c
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:45:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW71x-00054V-EJ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:45:26 -0500
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:33690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW71x-000544-8x
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:45:25 -0500
Received: by mail-ua0-x22c.google.com with SMTP id i68so142111177uad.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 11:45:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <649a4b6e-2c7f-cf2c-5fb2-9213aaffd34a@twiddle.net>
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
	<1485285380-10565-6-git-send-email-peter.maydell@linaro.org>
	<649a4b6e-2c7f-cf2c-5fb2-9213aaffd34a@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 19:45:03 +0000
Message-ID: <CAFEAcA8hZKk429b_sdtQb5bT7ymjBAqbcokpOL-oc2Vi8zUbyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 05/10] armv7m: honour CCR.STACKALIGN on
 exception entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Liviu Ionescu <ilg@livius.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 24 January 2017 at 19:33, Richard Henderson <rth@twiddle.net> wrote:
> On 01/24/2017 11:16 AM, Peter Maydell wrote:
>> The CCR.STACKALIGN bit controls whether the CPU is supposed to force
>> 8-alignment of the stack pointer on entry to the exception handler.
>
> 8...
>
>> +    /* Align stack pointer if the guest wants that */
>> +    if ((env->regs[13] & 4) && (env->v7m.ccr & R_V7M_CCR_STKALIGN_MASK)) {
>
> 4...
>
>>          env->regs[13] -= 4;
>
> Not alignment.  "&= -4"?

We know SP is always at least a multiple of 4. If it's already
a multiple of 8 then (sp & 4) will be false and we leave sp alone.
Otherwise it's a multiple of 4 but not 8, and subtracting 4
makes it 8 aligned (and we set the saved-XPSR bit to indicate
that we need to undo that on exception exit).

You could maybe rephrase the code to look a bit closer to the
v7M ARM ARM pseudocode, but the way it's written now isn't wrong,
so since this patch is only trying to say "do this if STKALIGN
is set rather than all the time" just adjusting the if conditional
seemed the best thing to me.

(The pseudocode checks for "do we need to align" with
"SP<2> AND forcealign", and does the alignment by
ANDing with a mask constructed with "NOT(ZeroExtend(forcealign:'00',32))".
So we do the check the same way it does, but use a subtract
rather than an AND-NOT. (Since we know that bit 2 must be set
then subtracting 4 and masking that bit to 0 are the same thing.)

thanks
-- PMM
