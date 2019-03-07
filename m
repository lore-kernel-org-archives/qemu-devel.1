Received: from eggs.gnu.org ([209.51.188.92]:57867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1jua-00081U-CI
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1juZ-0006yX-3s
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:41:36 -0500
Date: Thu, 7 Mar 2019 14:29:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307032924.GC7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-11-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-11-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 10/27] ppc/xive: Make XIVE generate the
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


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:15AM +0100, C=E9dric Le Goater wrote:
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
> ---
>  include/hw/ppc/xive.h |  3 ++-
>  hw/intc/xive.c        | 22 +++++++++++++++++++---
>  2 files changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index c4f27742ca09..6b89dc7679f9 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -313,7 +313,8 @@ typedef struct XiveTCTX {
>      DeviceState parent_obj;
> =20
>      CPUState    *cs;
> -    qemu_irq    output;
> +    qemu_irq    hv_output;
> +    qemu_irq    os_output;
> =20
>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
>  } XiveTCTX;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index a0b87001da25..237e7b256dc0 100644
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

IIUC hitting this case would indicate a code error, not a guest error,
in which case g_assert_not_reached() would be more appropriate that
returning 0.

Return "0" is kind of weird.  qemu_irq is actually a pointer so this
is really returning NULL.  But I don't think most things that handle
qemu_irq expect them to be NULL, so it's likely that this will just
crash further on.

Apart from that, LGTM.

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
> @@ -546,7 +561,8 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
>      env =3D &cpu->env;
>      switch (PPC_INPUT(env)) {
>      case PPC_FLAGS_INPUT_POWER9:
> -        tctx->output =3D env->irq_inputs[POWER9_INPUT_INT];
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

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAkBIACgkQbDjKyiDZ
s5LJJw//S2xpLtA6GYK+prekevZLcErOMzpupedSBqxo9fZjB3SVSV8N4+f69vXt
qyaWSA53JP2BWgsbJ2W+EMGi7OMg6mXCpzrjbRRHwKGvojxEdJyF2ms8zirqblkv
DnF5Jqekq5/fQKkh5xdgYhxYzf15zE7/FMD66yN5EDDCwo/81fVpsoQvzpWW1d4q
19FkheWapIeiJHSW9TbIQLy2uF7TMAFc465VLSGBxzwn2dsD3QARYjDW2vGDXQcJ
cEFuI6kEA4W1XE+X8Ssxv595ooBOQ48uH95NZZORSosHrAO/pZkGgXAE9ZUOc3i+
u8JCjzmmjHgcwX1dGMOX2xoS8cNtF55MuP5TirIUhqXp7TKY4Am+do3GaDEiY9mZ
ufUGKDOxnOrCABdgwjaoL+tjNf5Z3BmSDNSZAN3wA9S/sj1SFsWG2ObJdi2OIdXa
RlOZwqP032z9mrhiVVbPIGvqgHzNuxg1OtGwnSXGUInNjnBstKK8TcaGdjxbyUc0
ao8YHIoN+vAG0Z62arkroD/I38dXr44bhJXqihxhDDQcTJ7oYWBNMY06sChqoJZM
UWNdP0quXWRC+yMsYA/FM/UtEaFnm7b9UKvIFlMSuOMrw7nNqO6e2l72lG7x1TIC
tqTbFpzjxxQRbONBBilQMl6Za2Zx+3ikHpA0y8TWtQJNYnGL1lg=
=AzMy
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
