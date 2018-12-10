Received: from eggs.gnu.org ([2001:4830:134:3::10]:52112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWMSC-0007e3-GY
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWMSB-0006nD-7X
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:22:36 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWMSA-0006mI-Ee
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:22:35 -0500
Received: by mail-ot1-x343.google.com with SMTP id e12so10518728otl.5
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 06:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20181206175541.29508-1-richard.henderson@linaro.org>
	<20181206175541.29508-2-richard.henderson@linaro.org>
In-Reply-To: <20181206175541.29508-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 14:22:21 +0000
Message-ID: <CAFEAcA9HSrGX2PR8DieF6Fa8x2fHk1xnnismNvcMpaSQ4U9dMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] target/arm: Introduce
 arm_hcr_el2_eff
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

On Thu, 6 Dec 2018 at 17:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Replace arm_hcr_el2_{fmo,imo,amo} with a more general routine
> that also takes SCR_EL3.NS (aka arm_is_secure_below_el3) into
> account, as documented for the plethora of bits in HCR_EL2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ----
> v3: Fix set of bits affected by just TGE.
>     Reorder the bits to ascending order.
>     Zap VF,VI,VSE when !TGE and ![FIA]MO.

> +/*
> + * Return the effective value of HCR_EL2.
> + * Bits that are not included here:
> + * RW       (read from SCR_EL3.RW as needed)
> + */
> +uint64_t arm_hcr_el2_eff(CPUARMState *env)
> +{
> +    uint64_t ret = env->cp15.hcr_el2;
> +
> +    if (arm_is_secure_below_el3(env)) {
> +        /*
> +         * "This register has no effect if EL2 is not enabled in the
> +         * current Security state".  This is ARMv8.4-SecEL2 speak for
> +         * !(SCR_EL3.NS==1 || SCR_EL3.EEL2==1).
> +         *
> +         * Prior to that, the language was "In an implementation that
> +         * includes EL3, when the value of SCR_EL3.NS is 0 the PE behaves
> +         * as if this field is 0 for all purposes other than a direct
> +         * read or write access of HCR_EL2".  With lots of enumeration
> +         * on a per-field basis.  In current QEMU, this is condition
> +         * is arm_is_secure_below_el3.
> +         *
> +         * Since the v8.4 language applies to the entire register, and
> +         * appears to be backward compatible, use that.
> +         */
> +        ret = 0;
> +    } else if (ret & HCR_TGE) {
> +        /* These bits are up-to-date as of ARMv8.4.  */
> +        if (ret & HCR_E2H) {
> +            ret &= ~(HCR_VM | HCR_FMO | HCR_IMO | HCR_AMO |
> +                     HCR_BSU_MASK | HCR_DC | HCR_TWI | HCR_TWE |
> +                     HCR_TID0 | HCR_TID2 | HCR_TPCP | HCR_TPU |
> +                     HCR_TDZ | HCR_CD | HCR_ID | HCR_MIOCNCE);
> +        } else {
> +            ret |= HCR_FMO | HCR_IMO | HCR_AMO;
> +        }
> +        ret &= ~(HCR_SWIO | HCR_PTW | HCR_VF | HCR_VI | HCR_VSE |
> +                 HCR_FB | HCR_TID1 | HCR_TID3 | HCR_TSC | HCR_TACR |
> +                 HCR_TSW | HCR_TTLB | HCR_TVM | HCR_HCD | HCR_TRVM |
> +                 HCR_TLOR);
> +    } else {
> +        if (!(ret & HCR_FMO)) {
> +            ret &= ~HCR_VF;
> +        }
> +        if (!(ret & HCR_IMO)) {
> +            ret &= ~HCR_VI;
> +        }
> +        if (!(ret & HCR_AMO)) {
> +            ret &= ~HCR_VSE;
> +        }

This section that clears VI/VF/VSE is new, and I'm not sure it's right.
The spec says that the virtual IRQ interrupt is enabled only if {TGE,IMO}
is {0,1}, but the meaning of the bit is "pending", and an interrupt
can be pending without being enabled. Ditto VF, VSE.

(As there are only two places that look at the VI/VF/VSE bits and
they both look directly at cp15.hcr_el2 this doesn't change behaviour.)

> +    }
> +
> +    return ret;
> +}
> +

thanks
-- PMM
