Received: from eggs.gnu.org ([2001:4830:134:3::10]:48680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLACz-00066B-JZ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLACy-0007Vo-Ph
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:32:21 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:34181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLACy-0007VT-LG
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:32:20 -0400
Received: by mail-ot0-x235.google.com with SMTP id i5-v6so21725238otf.1
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 09:32:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a801fc3e-2dc1-06de-1ec1-0b911ea29450@twiddle.net>
References: <CAFEAcA-aD98+wh=XfMkY1iUwHjDJZ6dH7Juv0_o_VbgkcV0etw@mail.gmail.com>
	<214c47f3-1583-6480-4837-8b8ced37f038@twiddle.net>
	<CAFEAcA9QN_EFbfwqps+5Bu7CKX4J7GLGjBMURmk-1Jk22iixKA@mail.gmail.com>
	<7af06713-7e42-6489-5945-85545bc02f26@twiddle.net>
	<CAFEAcA90PcQH1Y-md7=dPTziP06ozripM7yPjqKJDgbk93gSzQ@mail.gmail.com>
	<a801fc3e-2dc1-06de-1ec1-0b911ea29450@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 17:31:59 +0100
Message-ID: <CAFEAcA_u8f_S9ij2Yt4gYitjXrJfpn=DQbyDm-fp4QsDN+JWcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] TCG helpers that return f16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 22 May 2018 at 17:27, Richard Henderson <rth@twiddle.net> wrote:
> On 05/22/2018 09:19 AM, Peter Maydell wrote:
>> But what we actually have is
>> target/arm/helper.c:float16 HELPER(recpe_f16)(float16 input, void *fpstp)
>> target/arm/helper.c:float16 HELPER(vfp_sltoh)(uint32_t x, uint32_t
>> shift, void *fpst)
>>
>> (and others that you can find by grepping for "float16 HELPER") --
>> the helpers don't return a uint32_t, they return float16.
>> In fact if you try to make them return uint32_t then you get
>> a compile error, because the DEF_HELPER_* macros prototype them
>> as returning float16 when you say the return type is 'f16'.
>
> Grr.  That is definitely not what I thought we were wiring up.
>
> So, do you think it is sufficiently less confusing for developers within
> target/* to have "f16" expand to "float16" as opposed to uint32_t?

I don't think it's a big deal for f16 return to require a uint32_t
return type -- if we get the DEF_HELPER macros to do the
right thing then it'll be a compile error if you get it wrong.
At any rate we should do that first as our bug fix before we
think about anything more clever.

Do we also want f16 inputs to mean uint32_t arguments?

thanks
-- PMM
