Received: from eggs.gnu.org ([2001:4830:134:3::10]:39741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eiqaH-0008El-LW
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eiqaD-0007vx-Nr
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:54:01 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180205105720.14620-1-peter.maydell@linaro.org>
	<20180205105720.14620-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b1112be1-c1bf-ee94-f786-84f248e223c5@amsat.org>
Date: Mon, 5 Feb 2018 20:53:49 -0300
MIME-Version: 1.0
In-Reply-To: <20180205105720.14620-6-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="Y1hOvH8H8T7JIg63Sk7JtEYZy45gzejje"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 5/8] hw/intc/armv7m_nvic:
 Implement cache ID registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y1hOvH8H8T7JIg63Sk7JtEYZy45gzejje
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <b1112be1-c1bf-ee94-f786-84f248e223c5@amsat.org>
Subject: Re: [Qemu-arm] [PATCH 5/8] hw/intc/armv7m_nvic: Implement cache ID
 registers
References: <20180205105720.14620-1-peter.maydell@linaro.org>
 <20180205105720.14620-6-peter.maydell@linaro.org>
In-Reply-To: <20180205105720.14620-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 02/05/2018 07:57 AM, Peter Maydell wrote:
> M profile cores have a similar setup for cache ID registers
> to A profile:
>  * Cache Level ID Register (CLIDR) is a fixed value
>  * Cache Type Register (CTR) is a fixed value
>  * Cache Size ID Registers (CCSIDR) are a bank of registers;
>    which one you see is selected by the Cache Size Selection
>    Register (CSSELR)
>=20
> The only difference is that they're in the NVIC memory mapped
> register space rather than being coprocessor registers.
> Implement the M profile view of them.
>=20
> Since neither Cortex-M3 nor Cortex-M4 implement caches,
> we don't need to update their init functions and can leave
> the ctr/clidr/ccsidr[] fields in their ARMCPU structs at zero.
> Newer cores (like the Cortex-M33) will want to be able to
> set these ID registers to non-zero values, though.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The CSSELR/CCSIDR parts are a bit under-motivated, because
> the Cortex-M33 doesn't implement caches either and so they
> are RAZ/WI for that as well as M3/M4, though I'd written all
> the code before I realized that. This will be helpful if
> we ever need a Cortex-M7 model, though (which does have
> a couple of CSSIDR array entries).

I wonder if it is easier/faster to add a check for the "Instruction not
Data" bit and the level value is not 7 (not permitted) or simple comments=
=2E

> ---
>  target/arm/cpu.h      |  9 +++++++++
>  hw/intc/armv7m_nvic.c | 13 +++++++++++++
>  target/arm/machine.c  | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f21f68ec4a..99c7cb996f 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -453,6 +453,7 @@ typedef struct CPUARMState {
>          uint32_t faultmask[M_REG_NUM_BANKS];
>          uint32_t aircr; /* only holds r/w state if security extn imple=
mented */
>          uint32_t secure; /* Is CPU in Secure state? (not guest visible=
) */
> +        uint32_t csselr[M_REG_NUM_BANKS];
>      } v7m;
> =20
>      /* Information associated with an exception about to be taken:
> @@ -2443,6 +2444,14 @@ static inline int arm_debug_target_el(CPUARMStat=
e *env)
>      }
>  }
> =20
> +static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
> +{
> +    /* If all the CLIDR.Ctypem bits are 0 there are no caches, and
> +     * CSSELR is RAZ/WI.
> +     */
> +    return (cpu->clidr & 0x001fffff) !=3D 0;
> +}

Suggestion to be consistent with other bitfields:

/* V7M Cache Level ID (CLIDR) */
FIELD(V7M_CLIDR, CTYPE, 0, 7 * 3)

So we can use:

    return (cpu->clidr & R_V7M_CLIDR_CTYPE_MASK) !=3D 0;

> +
>  static inline bool aa64_generate_debug_exceptions(CPUARMState *env)
>  {
>      if (arm_is_secure(env)) {
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index eb49fd77c7..cc83c9e553 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1025,6 +1025,14 @@ static uint32_t nvic_readl(NVICState *s, uint32_=
t offset, MemTxAttrs attrs)
>          return cpu->id_isar4;
>      case 0xd74: /* ISAR5.  */
>          return cpu->id_isar5;
> +    case 0xd78: /* CLIDR */
> +        return cpu->clidr;
> +    case 0xd7c: /* CTR */
> +        return cpu->ctr;
> +    case 0xd80: /* CSSIDR */
> +        return cpu->ccsidr[cpu->env.v7m.csselr[attrs.secure] & 0xf];

/* V7M Cache Size Selection (CSSELR) */
FIELD(V7M_CSSELR, LEVEL, 1, 3)

> +    case 0xd84: /* CSSELR */
> +        return cpu->env.v7m.csselr[attrs.secure];
>      /* TODO: Implement debug registers.  */
>      case 0xd90: /* MPU_TYPE */
>          /* Unified MPU; if the MPU is not present this value is zero *=
/
> @@ -1385,6 +1393,11 @@ static void nvic_writel(NVICState *s, uint32_t o=
ffset, uint32_t value,
>          qemu_log_mask(LOG_UNIMP,
>                        "NVIC: Aux fault status registers unimplemented\=
n");
>          break;
> +    case 0xd84: /* CSSELR */
> +        if (!arm_v7m_csselr_razwi(cpu)) {
> +            cpu->env.v7m.csselr[attrs.secure] =3D value & 0xf;
> +        }
> +        break;
>      case 0xd90: /* MPU_TYPE */
>          return; /* RO */
>      case 0xd94: /* MPU_CTRL */
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index a85c2430d3..968ec30b4a 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -108,6 +108,41 @@ static const VMStateDescription vmstate_m_faultmas=
k_primask =3D {
>      }
>  };
> =20
> +/* CSSELR is in a subsection because we didn't implement it previously=
=2E
> + * Migration from an old implementation will leave it at zero, which
> + * is OK since the only CPUs in the old implementation make the
> + * register RAZ/WI.
> + * Since there was no version of QEMU which implemented the CSSELR for=

> + * just non-secure, we transfer both banks here rather than putting
> + * the secure banked version in the m-security subsection.
> + */
> +static bool csselr_vmstate_validate(void *opaque, int version_id)
> +{
> +    ARMCPU *cpu =3D opaque;
> +
> +    return cpu->env.v7m.csselr[M_REG_NS] < sizeof(cpu->ccsidr)
> +        && cpu->env.v7m.csselr[M_REG_S] < sizeof(cpu->ccsidr);
> +}
> +
> +static bool m_csselr_needed(void *opaque)
> +{
> +    ARMCPU *cpu =3D opaque;
> +
> +    return !arm_v7m_csselr_razwi(cpu);
> +}
> +
> +static const VMStateDescription vmstate_m_csselr =3D {
> +    .name =3D "cpu/m/csselr",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D m_csselr_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(env.v7m.csselr, ARMCPU, M_REG_NUM_BANKS),=

> +        VMSTATE_VALIDATE("CSSELR is valid", csselr_vmstate_validate),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_m =3D {
>      .name =3D "cpu/m",
>      .version_id =3D 4,
> @@ -129,6 +164,7 @@ static const VMStateDescription vmstate_m =3D {
>      },
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_m_faultmask_primask,
> +        &vmstate_m_csselr,
>          NULL
>      }
>  };
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


--Y1hOvH8H8T7JIg63Sk7JtEYZy45gzejje
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp47o4ACgkQ4+MsLN6t
wN7gVA/+LgXWcBtHxzuOoRtl05kGPWkYiGLisZYm1OFDIkN0UPXG5QwpZIKhs6y9
+ri83UMexq/baWy0US+t5NySGjfTKmhGC5mh2VcitrRFCDv6yobwfqaconHVyEnb
40Mfq7dz9G+8+L4ZBeGOU/Q6MEW14M3/ojmY9ydXqDocRZnWJroKvqhSOCEJ1uWS
GRDLkioLKE+c0+r9M8gJsLWQTw8tXhIB1W5P0PQZ7azVymaH41B2s9oSZ0E4dpfP
jS+tSbtZMyF5xxRBjJUN/hetLnJqznoaWENvXx1mkS40MJ2LeUe9OY9fOE+NKQHY
hOXGSrDL9wZTAPjNkVLYJ1Lvz2YqNC72PNsjP99d90TFhEwXf46Gk3rwpMyHHeZh
75pLW1TWkzDmrkJD/LS3Jxepk2xhPviIjujuTRvcHnu/6rzyDeNTcXCpefFJGXe/
LdXWwjccgCXD0EK62h8DX/1Xr2LLkb4nQ8VScPu4pbBXrjE8O+JG0otiWa8OLQe4
kRrIZb7YVNFbOjlEgiQ8umQCCuq/BpU33YUQC+0ZabXKOi+ZmuhJxmoGrYrWxLP/
eSsmfSiBK3JAgbdcs9MomuXIKDAgE1M6lXrhT9Vk7nke9hE8H8kzXkKhqtD2n3t2
nOAvMfNPjRT9P/LTydJhsPRUbWzvgyMjk94wJOfi2tJP46tDImw=
=M7Vp
-----END PGP SIGNATURE-----

--Y1hOvH8H8T7JIg63Sk7JtEYZy45gzejje--
