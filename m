Received: from eggs.gnu.org ([2001:4830:134:3::10]:39004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5f75-0001NU-60
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5f74-00067O-9s
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:18:11 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5f74-00067B-4R
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 18:18:10 -0400
Received: by mail-ot0-x241.google.com with SMTP id m7-v6so10507586otd.1
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 15:18:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3147e65b-b6ff-a49e-fc40-21396dcbea0c@twiddle.net>
References: <20180409140714.26841-1-peter.maydell@linaro.org>
	<3147e65b-b6ff-a49e-fc40-21396dcbea0c@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 23:17:49 +0100
Message-ID: <CAFEAcA9UdXdWh1HwF9=Hjazv2Sa0P3zyHAejTQtdw+CTHpChXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12] linux-user/signal.c: Ensure
 AArch64 signal frame isn't too small
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henwood <richard.henwood@arm.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 9 April 2018 at 23:05, Richard Henderson <rth@twiddle.net> wrote:
> On 04/10/2018 12:07 AM, Peter Maydell wrote:
>> In particular the dash shell
>> would segfault if the frame wasn't as big enough.
>
> Ah, that was the critical difference in my failure to replicate -- the fedora
> sysroot doesn't have dash.  As you say, the patch matches the kernel so,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> That said, what the hell is dash doing that relies on this?

Yeah, I want to look more closely at what's going on here
tomorrow -- this is definitely a bug fix but I'm wondering
if it only masks a different underlying issue.

The spurious SEGV is the result of the call to
lock_user_struct() in target_setup_frame() failing
if we use too small a frame size, resulting in our
calling force_sigsegv().

thanks
-- PMM
