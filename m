Received: from eggs.gnu.org ([2001:4830:134:3::10]:33663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edcu5-0004Ea-NZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edcu4-0001i8-OG
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:16:53 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:40568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edcu4-0001gd-Jl
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:16:52 -0500
Received: by mail-ot0-x242.google.com with SMTP id x4so7571928otg.7
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 06:16:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180119045438.28582-12-richard.henderson@linaro.org>
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 14:16:31 +0000
Message-ID: <CAFEAcA_ACU1KRgth8B+hNr2BeDYzRQEz4KeA2cOytPsn_xfKjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 11/16] target/arm: Add SVE to migration
 state
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

On 19 January 2018 at 04:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Save the high parts of the Zregs and all of the Pregs.
> The ZCR_ELx registers are migrated via the CP mechanism.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/machine.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index cb0e1c92bb..2c8b43062f 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -122,6 +122,56 @@ static const VMStateDescription vmstate_iwmmxt = {
>      }
>  };
>
> +#ifdef TARGET_AARCH64
> +/* The expression ARM_MAX_VQ - 2 is 0 for pure AArch32 build,
> + * and ARMPredicateReg is actively empty.  This triggers errors
> + * in the expansion of the VMSTATE macros.
> + */
> +
> +static bool sve_needed(void *opaque)
> +{
> +    ARMCPU *cpu = opaque;
> +    CPUARMState *env = &cpu->env;
> +
> +    return arm_feature(env, ARM_FEATURE_SVE);
> +}
> +
> +/* The first two words of each Zreg is stored in VFP state.  */
> +static const VMStateDescription vmstate_zreg_hi_reg = {
> +    .name = "cpu/sve/zreg_hi",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64_SUB_ARRAY(d, ARMVectorReg, 2, ARM_MAX_VQ - 2),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_preg_reg = {
> +    .name = "cpu/sve/preg",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(p, ARMPredicateReg, 2 * ARM_MAX_VQ / 8),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_sve = {
> +    .name = "cpu/sve",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = sve_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT_ARRAY(env.vfp.zregs, ARMCPU, 32, 0,
> +                             vmstate_zreg_hi_reg, ARMVectorReg),
> +        VMSTATE_STRUCT_ARRAY(env.vfp.pregs, ARMCPU, 17, 0,
> +                             vmstate_preg_reg, ARMPredicateReg),

Is it the QEMU_ALIGNED attribute that means we need to do the pregs
via a STRUCT_ARRAY rather than being able to use a UINT64_2DARRAY ?

> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +#endif /* AARCH64 */

thanks
-- PMM
