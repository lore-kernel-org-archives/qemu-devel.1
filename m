Received: from eggs.gnu.org ([2001:4830:134:3::10]:50562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2fw-0005wz-Cx
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2fs-0001Do-Cb
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:44 -0500
Date: Thu, 18 Jan 2018 16:11:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118051150.GQ30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<20180115063235.7518-6-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5ltdm4mkXNgScZ66"
Content-Disposition: inline
In-Reply-To: <20180115063235.7518-6-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 5/6] target/ppc/spapr_caps:
 Add new tristate cap safe_indirect_branch
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


--5ltdm4mkXNgScZ66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 05:32:34PM +1100, Suraj Jitindar Singh wrote:
> Add new tristate cap cap-ibs to represent the indirect branch
> serialisation capability.
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
> index 02a0cb656b..269c1c7857 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1793,6 +1793,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_dfp,
>          &vmstate_spapr_cap_cfpc,
>          &vmstate_spapr_cap_sbbc,
> +        &vmstate_spapr_cap_ibs,
>          NULL
>      }
>  };
> @@ -3867,6 +3868,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_DFP] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> +    smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      spapr_caps_add_properties(smc, &error_abort);
>  }
> =20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 518e019cf7..0b36333a85 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -202,6 +202,17 @@ static void cap_safe_bounds_check_apply(sPAPRMachine=
State *spapr, uint8_t val,
>      }
>  }
> =20
> +static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
> +                                           uint8_t val, Error **errp)
> +{
> +    if (tcg_enabled() && val) {
> +        /* TODO - for now only allow broken for TCG */
> +        error_setg(errp, "Requested safe indirect branch capability leve=
l not supported by tcg, try a different value for cap-ibs");
> +    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_indirect_bran=
ch())) {
> +        error_setg(errp, "Requested safe indirect branch capability leve=
l not supported by kvm, try a different value for cap-ibs");
> +    }
> +}
> +
>  #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
> =20
>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> @@ -250,6 +261,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "string",
>          .apply =3D cap_safe_bounds_check_apply,
>      },
> +    [SPAPR_CAP_IBS] =3D {
> +        .name =3D "ibs",
> +        .description =3D "Indirect Branch Serialisation" VALUE_DESC_TRIS=
TATE,
> +        .index =3D SPAPR_CAP_IBS,
> +        .get =3D spapr_cap_get_tristate,
> +        .set =3D spapr_cap_set_tristate,
> +        .type =3D "string",
> +        .apply =3D cap_safe_indirect_branch_apply,
> +    },
>  };
> =20
>  static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
> @@ -424,6 +444,25 @@ const VMStateDescription vmstate_spapr_cap_sbbc =3D {
>      },
>  };
> =20
> +static bool spapr_cap_ibs_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    return spapr->cmd_line_caps[SPAPR_CAP_IBS] &&
> +           (spapr->eff.caps[SPAPR_CAP_IBS] !=3D spapr->def.caps[SPAPR_CA=
P_IBS]);
> +}
> +
> +const VMStateDescription vmstate_spapr_cap_ibs =3D {
> +    .name =3D "spapr/cap/ibs",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_cap_ibs_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(mig.caps[SPAPR_CAP_IBS], sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  void spapr_caps_reset(sPAPRMachineState *spapr)
>  {
>      sPAPRCapabilities default_caps;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index c65be62e92..549d7a4134 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -64,8 +64,10 @@ typedef enum {
>  #define SPAPR_CAP_CFPC                  0x03
>  /* Speculation Barrier Bounds Checking */
>  #define SPAPR_CAP_SBBC                  0x04
> +/* Indirect Branch Serialisation */
> +#define SPAPR_CAP_IBS                   0x05
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_SBBC + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_IBS + 1)
> =20
>  /*
>   * Capability Values
> @@ -785,6 +787,7 @@ extern const VMStateDescription vmstate_spapr_cap_vsx;
>  extern const VMStateDescription vmstate_spapr_cap_dfp;
>  extern const VMStateDescription vmstate_spapr_cap_cfpc;
>  extern const VMStateDescription vmstate_spapr_cap_sbbc;
> +extern const VMStateDescription vmstate_spapr_cap_ibs;
> =20
>  static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5ltdm4mkXNgScZ66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpgLJYACgkQbDjKyiDZ
s5JmRBAAri95hy6jMTINRHnwhLdLtLDufgm9LE5FA9IzoHBSod4ZAhkXdgoMT34m
zuFcYB9meTJmrONuSrrZ/mQbhTF9OZqgDjPJr3Ps7DtP8RDOSCLKOPoBTb1oHklX
1yAof2Aey6lAXJ9f6OEC7+dN24v4HWkVZ0I4iD0XIszqxQ/5N8BEzIS738+1AoEX
FpuNS5cV33+U+oQ09v0VtpdteGP22rN0JmzJxiqIcwwTU2a6klNCVL17X6QwEZx3
Bdtx0/0sNTjC/YZ58strgoBujQIQwfkCwqcRDoPDkDQaCHAsGD3qyx4R2A2oIM5H
zndDxtnyLzU9+ncEzcfCB3S52J/PPYsqtDxrLW1Y7HXaTY9aCkTFzj3pr91fO3E9
cYS6GaRm9EWUXQxVvi8pEnPL+ga4iDCq50Ve5AZ6xlOXCW1x4nms80g853s0qM8m
X55b6ahDYIawm1JfwJrHbE0YwqzYi4nDfLN+IFwqV7zkngYI3ZvamrsQ3Q6vbhwS
TIvPv5KgTq75PtxXxc52vZcYi8hAD1w75Glv1LvETpYQoGl8yOdiEAtN5HvvlSDL
F/B35Ih/bagaXowLwHqTL+1XXEaGpbL53065faS9BS5kc2c+wpup1iblAaJEMG2N
RON8X/2DDaDbR1KHPvdDFqBaDj/cTj0V5qLOKoGeFoMCzUTiQxo=
=INmH
-----END PGP SIGNATURE-----

--5ltdm4mkXNgScZ66--
