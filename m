Received: from eggs.gnu.org ([2001:4830:134:3::10]:50516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2ft-0005wL-Fh
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2fs-0001Ds-D4
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:41 -0500
Date: Thu, 18 Jan 2018 16:10:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118051011.GO30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<20180115063235.7518-4-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="80d3ujMCT5hHQAFF"
Content-Disposition: inline
In-Reply-To: <20180115063235.7518-4-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 3/6] target/ppc/spapr_caps:
 Add new tristate cap safe_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org


--80d3ujMCT5hHQAFF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 05:32:32PM +1100, Suraj Jitindar Singh wrote:
> Add new tristate cap cap-cfpc to represent the cache flush on privilege
> change capability.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_caps.c    | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  5 ++++-
>  3 files changed, 46 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3e528fe91e..5d62dc9968 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1791,6 +1791,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_htm,
>          &vmstate_spapr_cap_vsx,
>          &vmstate_spapr_cap_dfp,
> +        &vmstate_spapr_cap_cfpc,
>          NULL
>      }
>  };
> @@ -3863,6 +3864,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_DFP] =3D SPAPR_CAP_ON;
> +    smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
>      spapr_caps_add_properties(smc, &error_abort);
>  }
> =20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 436250d77b..bc2b2c3590 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -180,6 +180,18 @@ static void cap_dfp_apply(sPAPRMachineState *spapr, =
uint8_t val, Error **errp)
>      }
>  }
> =20
> +static void cap_safe_cache_apply(sPAPRMachineState *spapr, uint8_t val,
> +                                 Error **errp)
> +{
> +    if (tcg_enabled() && val) {
> +        /* TODO - for now only allow broken for TCG */
> +        error_setg(errp, "Requested safe cache capability level not supp=
orted by tcg, try a different value for cap-cfpc");
> +    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_cache())) {
> +        error_setg(errp, "Requested safe cache capability level not supp=
orted by kvm, try a different value for cap-cfpc");
> +    }
> +}
> +
> +#define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
> =20
>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
> @@ -209,6 +221,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .apply =3D cap_dfp_apply,
>      },
> +    [SPAPR_CAP_CFPC] =3D {
> +        .name =3D "cfpc",
> +        .description =3D "Cache Flush on Privilege Change" VALUE_DESC_TR=
ISTATE,
> +        .index =3D SPAPR_CAP_CFPC,
> +        .get =3D spapr_cap_get_tristate,
> +        .set =3D spapr_cap_set_tristate,
> +        .type =3D "string",
> +        .apply =3D cap_safe_cache_apply,
> +    },
>  };
> =20
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> @@ -345,6 +366,25 @@ const VMStateDescription vmstate_spapr_cap_dfp =3D {
>      },
>  };
> =20
> +static bool spapr_cap_cfpc_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    return spapr->cmd_line_caps[SPAPR_CAP_CFPC] &&
> +           (spapr->eff.caps[SPAPR_CAP_CFPC] !=3D spapr->def.caps[SPAPR_C=
AP_CFPC]);
> +}
> +
> +const VMStateDescription vmstate_spapr_cap_cfpc =3D {
> +    .name =3D "spapr/cap/cfpc",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_cap_cfpc_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(mig.caps[SPAPR_CAP_CFPC], sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};

Hrm, some macros to build these would probably be a good idea..

>  void spapr_caps_reset(sPAPRMachineState *spapr)
>  {
>      sPAPRCapabilities default_caps;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 61bb3632c4..ff476693d1 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -60,8 +60,10 @@ typedef enum {
>  #define SPAPR_CAP_VSX                   0x01
>  /* Decimal Floating Point */
>  #define SPAPR_CAP_DFP                   0x02
> +/* Cache Flush on Privilege Change */
> +#define SPAPR_CAP_CFPC                  0x03
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_DFP + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_CFPC + 1)
> =20
>  /*
>   * Capability Values
> @@ -779,6 +781,7 @@ int spapr_caps_pre_save(void *opaque);
>  extern const VMStateDescription vmstate_spapr_cap_htm;
>  extern const VMStateDescription vmstate_spapr_cap_vsx;
>  extern const VMStateDescription vmstate_spapr_cap_dfp;
> +extern const VMStateDescription vmstate_spapr_cap_cfpc;
> =20
>  static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--80d3ujMCT5hHQAFF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpgLDMACgkQbDjKyiDZ
s5JbYQ/4oJkFo7Sx6eApO7q+MB///PTJzJK6o0228MQFfp8N+dL02YL12vRb45JW
w2KR3ZfpUFKEQT3aPiV9TgtKzEgb6HUyNz/zItBpbjLNfBHP4vOCDQtaKYo934Wz
df6EllhlS7xuBvAfKXOd0UrGgLzPWivEt8BEd7kXRSO2svD94Pi01gskGTwK4JKA
UGqDgM//f38QeYb8k957uQp1gbI/chH1X+mftLBJaAzphSfHf/dbCvg43h0sWn6c
BVv40cj7rUu7tRRc2xWTGd4CZenbhU55jDJ6fth1ndWLkJGiSGpnQzN+ugZoDQc8
mLKFc+VS1trk1qiIyZFQ3ZTtur/BPeGFfSTnxQe+xOmfXFp2zhVA9jWk5bwzG3lJ
iKJ2EpaDUndW9m0wH4g5nrnfB4N1u9FTRu1+kHFD1aTLvaVhf8QSGFHEjkqs2lCW
/qZjRuEq8/rTcIQ5E3+ZH3M9QC2z6g0COniZ8AkWtlO7SYhQiwevU1p8h+ZcMS5S
uyqiwG+w6Cx7gQZUzlu7GgO0X+m7hxKCkevGUjhittNee1TeZjoTaclstkcaict+
8RI60FhknOAECNnZaIDi+TCTyfJ0hgoPNnIynjvi+/pHH4UZJWxl3nranrJvAzb0
znuHMktn6lvQejzmNjiNSbtlrEK8Gj8wkDeSGg13YaspHUKqqg==
=JnP0
-----END PGP SIGNATURE-----

--80d3ujMCT5hHQAFF--
