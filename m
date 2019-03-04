Received: from eggs.gnu.org ([209.51.188.92]:34281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0cHd-0001uN-QQ
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 20:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0cHb-0007Y1-Sj
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 20:20:45 -0500
Date: Mon, 4 Mar 2019 11:47:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304004754.GE7792@umbus.fritz.box>
References: <20190301024317.22137-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Content-Disposition: inline
In-Reply-To: <20190301024317.22137-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH v3 1/4] target/ppc/spapr: Add
 SPAPR_CAP_LARGE_DECREMENTER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 01:43:14PM +1100, Suraj Jitindar Singh wrote:
> Add spapr_cap SPAPR_CAP_LARGE_DECREMENTER to be used to control the
> availability of the large decrementer for a guest.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Series applied to ppc-for-4.0, thanks.

> ---
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_caps.c    | 17 +++++++++++++++++
>  include/hw/ppc/spapr.h |  5 ++++-
>  3 files changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6f9208476a..d068982a5e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2077,6 +2077,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_irq_map,
>          &vmstate_spapr_cap_nested_kvm_hv,
>          &vmstate_spapr_dtb,
> +        &vmstate_spapr_cap_large_decr,
>          NULL
>      }
>  };
> @@ -4309,6 +4310,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB */
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_OF=
F;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_xics;
>      smc->dr_phb_enabled =3D true;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 64f98ae68d..3f90f5823e 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -390,6 +390,13 @@ static void cap_nested_kvm_hv_apply(sPAPRMachineStat=
e *spapr,
>      }
>  }
> =20
> +static void cap_large_decr_apply(sPAPRMachineState *spapr,
> +                                 uint8_t val, Error **errp)
> +{
> +    if (val)
> +        error_setg(errp, "No large decrementer support, try cap-large-de=
cr=3Doff");
> +}
> +
>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -468,6 +475,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .apply =3D cap_nested_kvm_hv_apply,
>      },
> +    [SPAPR_CAP_LARGE_DECREMENTER] =3D {
> +        .name =3D "large-decr",
> +        .description =3D "Allow Large Decrementer",
> +        .index =3D SPAPR_CAP_LARGE_DECREMENTER,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_large_decr_apply,
> +    },
>  };
> =20
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> @@ -596,6 +612,7 @@ SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
>  SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
> +SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
> =20
>  void spapr_caps_init(sPAPRMachineState *spapr)
>  {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 86b0488d29..3cd47fb6e8 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -74,8 +74,10 @@ typedef enum {
>  #define SPAPR_CAP_HPT_MAXPAGESIZE       0x06
>  /* Nested KVM-HV */
>  #define SPAPR_CAP_NESTED_KVM_HV         0x07
> +/* Large Decrementer */
> +#define SPAPR_CAP_LARGE_DECREMENTER     0x08
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_KVM_HV + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_LARGE_DECREMENTER + 1)
> =20
>  /*
>   * Capability Values
> @@ -843,6 +845,7 @@ extern const VMStateDescription vmstate_spapr_cap_cfp=
c;
>  extern const VMStateDescription vmstate_spapr_cap_sbbc;
>  extern const VMStateDescription vmstate_spapr_cap_ibs;
>  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
> +extern const VMStateDescription vmstate_spapr_cap_large_decr;
> =20
>  static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8dbgACgkQbDjKyiDZ
s5LYSQ//S3pb9c2PZYoHyDhAMsOhnmLHw9j9+CK9tXo1XA9NnwahjEKnD5JhaFE5
Oc9q/Jb8X8aCMMvojHkyM1seihkvKZ9Cq2PDiX0d664aQI2jq/exWQkpfuQZDu1n
VUtST1D8J2EfmMzxmnflBvLS/fL2B4QL8TWp1c36pnfdYmZG4oZS2852RJwxl134
8uScXm4OBjDi2prWdYvvO3ZqjbHIVyEYEnDw9IPkSbntHWtgI2XvYwZKhpJL0Tpq
JaVlBGg5zrgow0MrL1XfCU5HBEl1hX1mOnG2EGraZmg8sYINmCBEAfoA0Bf4Kp3/
0uEVK3mjkXe/9/UaZ8KGmx82WnjNrMQ5kk6EQn/68PJzLGsJH3C2K0W5KZunWESC
5JjRa4t3OPxBr6j3OwFZyFFK1baK+NmBdEsSrqnI1jyS3+2mpE0c8uJfKVAs/wkV
vAsRz5lZIh/0HqXX/rxGDm4xR4AmGlEoLk8zSm5NhwwOgYwJEaZzWcn7vxD1jyxZ
WU9KJhQvoW8ubCbdCpQLbzF1wyKrjRmsepUoTgxfl9RuJMICtDkj1qAXKynJ9W1m
2xY1bn/KoS9lF++EiAZ7FTSCovkIrSKJaOhWNpzueEPnDS6oVtRarXwhyz9ur+rz
UnCWigLCpRN57P+n0vdnjIKLHzE3BNC2IILund+pKeUHY0oCLOM=
=1UEb
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--
