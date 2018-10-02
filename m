Received: from eggs.gnu.org ([2001:4830:134:3::10]:34759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HnG-0006tz-Sx
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HnG-0006R7-3X
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:20:42 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7HnF-0006Qj-M7
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:20:41 -0400
Received: by mail-ot1-x344.google.com with SMTP id u22so1311667ota.12
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:20:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180926192323.12659-5-richard.henderson@linaro.org>
References: <20180926192323.12659-1-richard.henderson@linaro.org>
	<20180926192323.12659-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 11:20:20 +0100
Message-ID: <CAFEAcA_pT6xZ9g8PXDX8yhkN6DFESkeqTwHJbFmH8hTX3wYb0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 04/15] target/arm: Handle SVE vector
 length changes in system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 September 2018 at 20:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> SVE vector length can change when changing EL, or when writing
> to one of the ZCR_ELn registers.
>
> For correctness, our implementation requires that predicate bits
> that are inaccessible are never set.  Which means noticing length
> changes and zeroing the appropriate register bits.
>
> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +
> +/*
> + * Notice a change in SVE vector size when changing EL.
> + */
> +void aarch64_sve_change_el(CPUARMState *env, int old_el, int new_el)
> +{
> +    int old_len, new_len;
> +
> +    /* Nothing to do if no SVE.  */
> +    if (!arm_feature(env, ARM_FEATURE_SVE)) {
> +        return;
> +    }
> +
> +    /* Nothing to do if FP is disabled in either EL.  */
> +    if (fp_exception_el(env, old_el) || fp_exception_el(env, new_el)) {
> +        return;
> +    }
> +
> +    /*
> +     * When FP is enabled, but SVE is disabled, the effective len is 0.
> +     * ??? Do we need a conditional for old_el/new_el in aa32 state?
> +     * That isn't included in the CheckSVEEnabled pseudocode, so is the
> +     * host kernel required to explicitly disable SVE for an EL using aa32?
> +     */

Possibly relevant here is DDI0584A.d section 3.2 (that's the
SVE Arm ARM supplement), which says "If SVE instructions are
disabled or trapped at ELx, or not available because that Exception
level is in AArch32 state, then for all purposes other than a direct
read, the ZCR_ELx.LEN field has an Effective value of 0".

My assumption is that the CheckSVEEnabled pseudacode doesn't look
for the exception level being AArch32 because it's not possible
to reach that function in AArch32 mode.

thanks
-- PMM
