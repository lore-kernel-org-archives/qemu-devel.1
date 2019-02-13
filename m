Received: from eggs.gnu.org ([209.51.188.92]:45583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtn6T-0008KE-Ov
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtmwh-00063j-KY
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:18:56 -0500
Date: Wed, 13 Feb 2019 16:17:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213051738.GT1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-19-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QgvTbcZPsSS/HkXe"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-19-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 18/19] ppc/xive: Make XIVE generate the
 proper interrupt types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--QgvTbcZPsSS/HkXe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:24AM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> It should be generic Hypervisor Virtualization interrupts for HV
> directed rings and traditional External Interrupts for the OS directed
> ring.
>=20
> Don't generate anything for the user ring as it isn't actually
> supported.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/xive.h |  3 ++-
>  hw/intc/xive.c        | 22 +++++++++++++++++++---
>  2 files changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 2bad8526221b..82e9aef677c5 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -316,7 +316,8 @@ typedef struct XiveTCTX {
>      DeviceState parent_obj;
> =20
>      CPUState    *cs;
> -    qemu_irq    output;
> +    qemu_irq    hv_output;
> +    qemu_irq    os_output;
> =20
>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
>      uint32_t    hw_cam;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 119bb02d345d..14b854181ab7 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -61,13 +61,28 @@ static uint8_t exception_mask(uint8_t ring)
>      }
>  }
> =20
> +static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
> +{
> +        switch (ring) {
> +        case TM_QW0_USER:
> +                return 0; /* Not supported */
> +        case TM_QW1_OS:
> +                return tctx->os_output;
> +        case TM_QW2_HV_POOL:
> +        case TM_QW3_HV_PHYS:
> +                return tctx->hv_output;
> +        default:
> +                return 0;
> +        }
> +}
> +
>  static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>  {
>      uint8_t *regs =3D &tctx->regs[ring];
>      uint8_t nsr =3D regs[TM_NSR];
>      uint8_t mask =3D exception_mask(ring);
> =20
> -    qemu_irq_lower(tctx->output);
> +    qemu_irq_lower(xive_tctx_output(tctx, ring));
> =20
>      if (regs[TM_NSR] & mask) {
>          uint8_t cppr =3D regs[TM_PIPR];
> @@ -100,7 +115,7 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t =
ring)
>          default:
>              g_assert_not_reached();
>          }
> -        qemu_irq_raise(tctx->output);
> +        qemu_irq_raise(xive_tctx_output(tctx, ring));
>      }
>  }
> =20
> @@ -554,7 +569,8 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
>      env =3D &cpu->env;
>      switch (PPC_INPUT(env)) {
>      case PPC_FLAGS_INPUT_POWER9:
> -        tctx->output =3D env->irq_inputs[POWER7_INPUT_INT];
> +        tctx->hv_output =3D env->irq_inputs[POWER9_INPUT_HINT];
> +        tctx->os_output =3D env->irq_inputs[POWER9_INPUT_INT];
>          break;
> =20
>      default:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QgvTbcZPsSS/HkXe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjqHEACgkQbDjKyiDZ
s5IeSBAAuSRTAxDuqYYrj1J0Iut5cqm9VkiaD0A6dJBGhUKbNgkuWlyeGTeL7c/L
kwNHCjHdEWkgyHPuVe8hIhrYzNsp1lLLHss55+67OPR3Cwztq/Ts1HVt0hqXWgIY
WzC1cmPWKibTzsnihr06s5VHUcHCGlE9psjJkGk6TGmHo8SV1aRAkTQ26y5RYn3y
6oNB6q/TxNKqfst7+Phr/B7sFZqhpnNh/4hvPL0idfwWm7l63kAck6m7fxp/qJti
kfDZbG7ochPSoW0hWemOCTFvResoqV82ZB1wWdVS2KUKXho3F1GSJlt7R9hf6Q+c
uSTW3V27upP59P6xMCHA8WVGd+6Cdg4/ZpnuGNiwhMTT6C6UlypVeQ8ywC0orHME
tqLrsaQfb+T9u/mvIf53EJSoI/nzGWa45RdF5DircuQD597GIHVVQe6Z1ALaZhU4
XK5JmbVN/GleRs6FdCCf0aMqpcdZrAcZ+cPfqlBcf1gs2sJ3CPkBJoVpduFI7hqU
WUB9CHLm/Q+QTgLNEmORoYEzJvIcA2Gyx7SxXby/iHJUMkvtLLIYmEHF7aY3n50z
SzeXrt3JtinnTw+iSpJFtYEqmJ6G8T0ZF29pkKNYraTGAze+i/JiDDnFOZwLvTBy
Chycc3bo4pOI4Sb+I0iB8XH8RwXIyEcvY2SsSAOCwZ00UMtQ6pw=
=cl47
-----END PGP SIGNATURE-----

--QgvTbcZPsSS/HkXe--
