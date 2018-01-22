Received: from eggs.gnu.org ([2001:4830:134:3::10]:53743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edcLI-0000IN-HW
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1edcLF-0005Qz-CJ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:40:56 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:45747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1edcLF-0005Qa-62
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:40:53 -0500
Received: by mail-wr0-x244.google.com with SMTP id 16so8693601wry.12
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 05:40:53 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
	<20180119045438.28582-12-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-12-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 13:40:50 +0000
Message-ID: <87shayj9jx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Save the high parts of the Zregs and all of the Pregs.
> The ZCR_ELx registers are migrated via the CP mechanism.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/machine.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index cb0e1c92bb..2c8b43062f 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -122,6 +122,56 @@ static const VMStateDescription vmstate_iwmmxt =3D {
>      }
>  };
>
> +#ifdef TARGET_AARCH64
> +/* The expression ARM_MAX_VQ - 2 is 0 for pure AArch32 build,
> + * and ARMPredicateReg is actively empty.  This triggers errors
> + * in the expansion of the VMSTATE macros.
> + */

This makes me think that #ifdef-ing out the pregs might be better for
the 32 bit target build.

> +
> +static bool sve_needed(void *opaque)
> +{
> +    ARMCPU *cpu =3D opaque;
> +    CPUARMState *env =3D &cpu->env;
> +
> +    return arm_feature(env, ARM_FEATURE_SVE);
> +}
> +
> +/* The first two words of each Zreg is stored in VFP state.  */
> +static const VMStateDescription vmstate_zreg_hi_reg =3D {
> +    .name =3D "cpu/sve/zreg_hi",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64_SUB_ARRAY(d, ARMVectorReg, 2, ARM_MAX_VQ - 2),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_preg_reg =3D {
> +    .name =3D "cpu/sve/preg",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64_ARRAY(p, ARMPredicateReg, 2 * ARM_MAX_VQ / 8),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_sve =3D {
> +    .name =3D "cpu/sve",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D sve_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_STRUCT_ARRAY(env.vfp.zregs, ARMCPU, 32, 0,
> +                             vmstate_zreg_hi_reg, ARMVectorReg),
> +        VMSTATE_STRUCT_ARRAY(env.vfp.pregs, ARMCPU, 17, 0,
> +                             vmstate_preg_reg, ARMPredicateReg),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +#endif /* AARCH64 */
> +
>  static bool m_needed(void *opaque)
>  {
>      ARMCPU *cpu =3D opaque;
> @@ -586,6 +636,9 @@ const VMStateDescription vmstate_arm_cpu =3D {
>          &vmstate_pmsav7,
>          &vmstate_pmsav8,
>          &vmstate_m_security,
> +#ifdef TARGET_AARCH64
> +        &vmstate_sve,
> +#endif
>          NULL
>      }
>  };


--
Alex Benn=C3=A9e
