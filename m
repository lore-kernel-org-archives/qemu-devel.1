Received: from eggs.gnu.org ([2001:4830:134:3::10]:38459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxcBO-0000jM-C9
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxcBN-0007mX-GH
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:28:50 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxcBN-0007m9-AH
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:28:49 -0400
Received: by mail-wm0-x22a.google.com with SMTP id w64so43550436wma.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 09:28:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491820793-5348-7-git-send-email-peter.maydell@linaro.org>
References: <1491820793-5348-1-git-send-email-peter.maydell@linaro.org>
	<1491820793-5348-7-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 17:28:27 +0100
Message-ID: <CAFEAcA9A60tdpYTPbm36+i2uo6E__5EjtRWu_Esnx5uASDsZ6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 6/7] arm: Implement M profile
 exception return properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 10 April 2017 at 11:39, Peter Maydell <peter.maydell@linaro.org> wrote:
> On M profile, return from exceptions happen when privileged code
> executes one of the following function call return instructions:
>  * POP or LDM which loads the PC
>  * LDR to PC
>  * BX register
> and the new PC value is 0xFFxxxxxx.

So this isn't quite right -- the special behaviour happens only
when in Handler mode. (Handler is always privileged, but not
all privileged code is in Handler mode)...

> +static inline void gen_bx_excret(DisasContext *s, TCGv_i32 var)
> +{
> +    /* Generate the same code here as for a simple bx, but flag via
> +     * s->is_jmp that we need to do the rest of the work later.
> +     */
> +    gen_bx(s, var);
> +    if (!IS_USER(s) && arm_dc_feature(s, ARM_FEATURE_M)) {

...so we need to track "are we in Handler mode" (ie
env->v7m.exception != 0) in the TB flags and test that here
rather than testing IS_USER.

(Otherwise if you have code which executes the same 'bx' instruction
both as a legitimate exception return and as a fake exception
return while in privileged thread mode then we assert() in
do_v7m_exception_exit. I have a test case that does this but no
real code would ever do it.)

thanks
-- PMM
