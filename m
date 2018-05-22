Received: from eggs.gnu.org ([2001:4830:134:3::10]:45267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLA0u-0001JG-GJ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLA0t-000293-Hn
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:19:52 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:36346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLA0t-00028h-CK
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:19:51 -0400
Received: by mail-ot0-x22d.google.com with SMTP id m11-v6so21662953otf.3
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 09:19:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7af06713-7e42-6489-5945-85545bc02f26@twiddle.net>
References: <CAFEAcA-aD98+wh=XfMkY1iUwHjDJZ6dH7Juv0_o_VbgkcV0etw@mail.gmail.com>
	<214c47f3-1583-6480-4837-8b8ced37f038@twiddle.net>
	<CAFEAcA9QN_EFbfwqps+5Bu7CKX4J7GLGjBMURmk-1Jk22iixKA@mail.gmail.com>
	<7af06713-7e42-6489-5945-85545bc02f26@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 17:19:30 +0100
Message-ID: <CAFEAcA90PcQH1Y-md7=dPTziP06ozripM7yPjqKJDgbk93gSzQ@mail.gmail.com>
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

On 22 May 2018 at 17:11, Richard Henderson <rth@twiddle.net> wrote:
> On 05/22/2018 07:56 AM, Peter Maydell wrote:
> The *helpers* are supposed to be returning uint32_t.  That should be enforced
> by the prototype generated from "f16" being aliased to "i32".
>
> The softfloat routines are supposed to be returning float16, aka uint16_t.
>
> So:
>
> float16 f();
> uint32_t h() { return f(); }
>
> will generate a zero-extend, in C, before returning to TCG generated code.

But what we actually have is
target/arm/helper.c:float16 HELPER(recpe_f16)(float16 input, void *fpstp)
target/arm/helper.c:float16 HELPER(vfp_sltoh)(uint32_t x, uint32_t
shift, void *fpst)

(and others that you can find by grepping for "float16 HELPER") --
the helpers don't return a uint32_t, they return float16.
In fact if you try to make them return uint32_t then you get
a compile error, because the DEF_HELPER_* macros prototype them
as returning float16 when you say the return type is 'f16'.

thanks
-- PMM
