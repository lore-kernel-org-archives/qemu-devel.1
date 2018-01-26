Received: from eggs.gnu.org ([2001:4830:134:3::10]:33745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ef7w7-0003Zx-FE
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ef7w4-0001iZ-80
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:37:11 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ef7w3-0001hu-W7
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:37:08 -0500
Received: by mail-wm0-x243.google.com with SMTP id r71so2799459wmd.1
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 09:37:07 -0800 (PST)
References: <20180123035349.24538-1-richard.henderson@linaro.org>
	<20180123035349.24538-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180123035349.24538-4-richard.henderson@linaro.org>
Date: Fri, 26 Jan 2018 15:05:24 +0000
Message-ID: <871sic7j9n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/5] target/arm: Add SVE to migration
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

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

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
