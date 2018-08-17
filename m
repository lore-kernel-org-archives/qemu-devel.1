Received: from eggs.gnu.org ([2001:4830:134:3::10]:45834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhW7-0000f9-Db
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhW6-0004a1-Ij
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:22:27 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:43886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqhW6-0004ZO-9y
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:22:26 -0400
Received: by mail-oi0-x244.google.com with SMTP id b15-v6so14894881oib.10
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 09:22:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-10-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 17:22:05 +0100
Message-ID: <CAFEAcA__p5-xuYvqAh=97Uz81rxAiQNAnrKFFCsPAk-P4i_FHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/20] target/arm: Handle SVE vector length
 changes in system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> SVE vector length can change when changing EL, or when writing
> to one of the ZCR_ELn registers.
>
> For correctness, our implementation requires that predicate bits
> that are inaccessible are never set.  Which means noticing length
> changes and zeroing the appropriate register bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


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
> +     * ??? How should sve_exception_el interact with AArch32 state?
> +     * That isn't included in the CheckSVEEnabled pseudocode, so is the
> +     * host kernel required to explicitly disable SVE for an EL using aa32?
> +     */

I'm not clear what you're asking here. If the EL is AArch32
then why does it make a difference if SVE is enabled or disabled?
You can't get at it...

> +    old_len = (sve_exception_el(env, old_el)
> +               ? 0 : sve_zcr_len_for_el(env, old_el));
> +    new_len = (sve_exception_el(env, new_el)
> +               ? 0 : sve_zcr_len_for_el(env, new_el));
> +
> +    /* When changing vector length, clear inaccessible state.  */
> +    if (new_len < old_len) {
> +        aarch64_sve_narrow_vq(env, new_len + 1);
> +    }
> +}
> +#endif

thanks
-- PMM
