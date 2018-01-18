Received: from eggs.gnu.org ([2001:4830:134:3::10]:50522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2fu-0005wO-0Y
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2fs-0001Da-Bl
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:42 -0500
Date: Thu, 18 Jan 2018 16:11:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118051129.GP30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<20180115063235.7518-5-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oDT6ON1uLKeoILhE"
Content-Disposition: inline
In-Reply-To: <20180115063235.7518-5-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 4/6] target/ppc/spapr_caps:
 Add new tristate cap safe_bounds_check
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


--oDT6ON1uLKeoILhE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 05:32:33PM +1100, Suraj Jitindar Singh wrote:
> Add new tristate cap cap-sbbc to represent the speculation barrier
> bounds checking capability.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_caps.c    | 39 +++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  5 ++++-
>  3 files changed, 45 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5d62dc9968..02a0cb656b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1792,6 +1792,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_vsx,
>          &vmstate_spapr_cap_dfp,
>          &vmstate_spapr_cap_cfpc,
> +        &vmstate_spapr_cap_sbbc,
>          NULL
>      }
>  };
> @@ -3865,6 +3866,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_DFP] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
>      spapr_caps_add_properties(smc, &error_abort);
>  }
> =20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index bc2b2c3590..518e019cf7 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -191,6 +191,17 @@ static void cap_safe_cache_apply(sPAPRMachineState *=
spapr, uint8_t val,
>      }
>  }
> =20
> +static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_=
t val,
> +                                        Error **errp)
> +{
> +    if (tcg_enabled() && val) {
> +        /* TODO - for now only allow broken for TCG */
> +        error_setg(errp, "Requested safe bounds check capability level n=
ot supported by tcg, try a different value for cap-sbbc");
> +    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_bounds_check(=
))) {
> +        error_setg(errp, "Requested safe bounds check capability level n=
ot supported by kvm, try a different value for cap-sbbc");
> +    }
> +}
> +
>  #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
> =20
>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> @@ -230,6 +241,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "string",
>          .apply =3D cap_safe_cache_apply,
>      },
> +    [SPAPR_CAP_SBBC] =3D {
> +        .name =3D "sbbc",
> +        .description =3D "Speculation Barrier Bounds Checking" VALUE_DES=
C_TRISTATE,
> +        .index =3D SPAPR_CAP_SBBC,
> +        .get =3D spapr_cap_get_tristate,
> +        .set =3D spapr_cap_set_tristate,
> +        .type =3D "string",
> +        .apply =3D cap_safe_bounds_check_apply,
> +    },
>  };
> =20
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> @@ -385,6 +405,25 @@ const VMStateDescription vmstate_spapr_cap_cfpc =3D {
>      },
>  };
> =20
> +static bool spapr_cap_sbbc_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    return spapr->cmd_line_caps[SPAPR_CAP_SBBC] &&
> +           (spapr->eff.caps[SPAPR_CAP_SBBC] !=3D spapr->def.caps[SPAPR_C=
AP_SBBC]);
> +}
> +
> +const VMStateDescription vmstate_spapr_cap_sbbc =3D {
> +    .name =3D "spapr/cap/sbbc",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_cap_sbbc_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(mig.caps[SPAPR_CAP_SBBC], sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  void spapr_caps_reset(sPAPRMachineState *spapr)
>  {
>      sPAPRCapabilities default_caps;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index ff476693d1..c65be62e92 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -62,8 +62,10 @@ typedef enum {
>  #define SPAPR_CAP_DFP                   0x02
>  /* Cache Flush on Privilege Change */
>  #define SPAPR_CAP_CFPC                  0x03
> +/* Speculation Barrier Bounds Checking */
> +#define SPAPR_CAP_SBBC                  0x04
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_CFPC + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_SBBC + 1)
> =20
>  /*
>   * Capability Values
> @@ -782,6 +784,7 @@ extern const VMStateDescription vmstate_spapr_cap_htm;
>  extern const VMStateDescription vmstate_spapr_cap_vsx;
>  extern const VMStateDescription vmstate_spapr_cap_dfp;
>  extern const VMStateDescription vmstate_spapr_cap_cfpc;
> +extern const VMStateDescription vmstate_spapr_cap_sbbc;
> =20
>  static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oDT6ON1uLKeoILhE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpgLIEACgkQbDjKyiDZ
s5IwCA//X0ZhRLZt/GUvBT7mfM2jmnP/l9ChiWJqxwuivsa7DQfkRZFZbg9bMT/x
KCegY/0mBotSxXktst/IezT+jVEo7qnWvKRzURrA4Edy8WrY+GclYrzg6MAZMygw
qp0fMy8YsIe4s70B94fEW0X3xOpADLPCasepCVYbMuRTVP+Bm40KPbkna4NkfpZ6
/PYuOM9u+dKKm7zf5xvgOS9f58NgCVRXiGfx7sx6lnvE06YXkdjLcTn8QVy1dFsv
J0BiyDvmsIeTsjY0guj0XBRoSwLO6dmz0TqyOe4a3cYyVxn+aaFcZZE78jZsEto3
TAlS64i+edY6FriZhKEf1c4DPP3dFIAwQkTAkDT0sW0HOTqgSlr7oNL3C3Su0sqX
YWcZEtbfLSMvEPsIc6mwE//hC/x810ihTYn1oxr4pxQmHGCHnrcJ3/Fwvg0fbLxt
K4ywsF3GVYKwIwHOtC1wLOLnDDLRgRRYX/9ZbKrlgt0J68N8tpuwlLGiOb0p1o1l
VHPJYITTpyCoBib8am/B9s6WGmV75zmMEXBA8kn6D6iOFnqjwVUkOblhj+sTJiXI
i72LGaTTDryo8GSKYSs/oPJ81eix5uZN5agSr0Cc8NHaqdANlvsMpow30H/qBIGe
GD5NSN0HFHNo2ssixKPYTzq0HOx/25kq+LMboqxnHhE7h5t6NCA=
=YINl
-----END PGP SIGNATURE-----

--oDT6ON1uLKeoILhE--
