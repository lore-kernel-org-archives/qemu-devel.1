Received: from eggs.gnu.org ([2001:4830:134:3::10]:55856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUi8J-0008IT-Tt
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUi8F-0004VU-N9
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:34:59 -0400
Date: Mon, 18 Jun 2018 10:34:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618003445.GB25461@umbus.fritz.box>
References: <20180617155309.1653-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20180617155309.1653-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] fpu_helper.c: fix helper_fpscr_clrbit()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, aurelien@aurel32.net, agraf@suse.de, qemu-ppc@nongnu.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 17, 2018 at 11:53:09AM -0400, John Arbuckle wrote:
> Fix the helper_fpscr_clrbit() function so it correctly
> sets the FEX and VX bits.

This needs a lot more information in the commit message:

  * What exactly was wrong with the previous setting of the FEX and VX
    bits?

  * Where can we find documentation which describes how they should be
    set correctly?
 =20
This is information we need to properly review the patch.

>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  target/ppc/fpu_helper.c | 57 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 57 insertions(+)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index d31a933cbb..7e697a11d0 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -325,6 +325,63 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t =
bit)
>          case FPSCR_RN:
>              fpscr_set_rounding_mode(env);
>              break;
> +        case FPSCR_VXSNAN:
> +        case FPSCR_VXISI:
> +        case FPSCR_VXIDI:
> +        case FPSCR_VXZDZ:
> +        case FPSCR_VXIMZ:
> +        case FPSCR_VXVC:
> +        case FPSCR_VXSOFT:
> +        case FPSCR_VXSQRT:
> +        case FPSCR_VXCVI:
> +        {
> +            int vxsnan, vxisi, vxidi, vxzdz, vximz, vxvc, vxsoft, vxsqrt=
, vxcvi;
> +            vxsnan =3D (env->fpscr >> (31 - FPSCR_VXSNAN)) & 1;
> +            vxisi =3D (env->fpscr >> (31 - FPSCR_VXISI)) & 1;
> +            vxidi =3D (env->fpscr >> (31 - FPSCR_VXIDI)) & 1;
> +            vxzdz =3D (env->fpscr >> (31 - FPSCR_VXZDZ)) & 1;
> +            vximz =3D (env->fpscr >> (31 - FPSCR_VXIMZ)) & 1;
> +            vxvc =3D (env->fpscr >> (31 - FPSCR_VXVC)) & 1;
> +            vxsoft =3D (env->fpscr >> (31 - FPSCR_VXSOFT)) & 1;
> +            vxsqrt =3D (env->fpscr >> (31 - FPSCR_VXSQRT)) & 1;
> +            vxcvi =3D (env->fpscr >> (31 - FPSCR_VXCVI)) & 1;
> +            if (~(vxsnan & vxisi & vxidi & vxzdz & vximz & vxvc & vxsoft=
 &
> +                  vxsqrt & vxcvi)) {
> +                /* Set VX bit to zero */
> +                env->fpscr =3D env->fpscr & ~(1 << FPSCR_VX);
> +            }
> +        }
> +            break;
> +        case FPSCR_VX:
> +        case FPSCR_OX:
> +        case FPSCR_UX:
> +        case FPSCR_ZX:
> +        case FPSCR_XX:
> +        case FPSCR_VE:
> +        case FPSCR_OE:
> +        case FPSCR_UE:
> +        case FPSCR_ZE:
> +        case FPSCR_XE:
> +        {
> +            int vx, ox, ux, zx, xx, ve, oe, ue, ze, xe;
> +            vx =3D (env->fpscr >> (31 - FPSCR_VX)) & 1;
> +            ox =3D (env->fpscr >> (31 - FPSCR_OX)) & 1;
> +            ux =3D (env->fpscr >> (31 - FPSCR_UX)) & 1;
> +            zx =3D (env->fpscr >> (31 - FPSCR_ZX)) & 1;
> +            xx =3D (env->fpscr >> (31 - FPSCR_XX)) & 1;
> +            ve =3D (env->fpscr >> (31 - FPSCR_VE)) & 1;
> +            oe =3D (env->fpscr >> (31 - FPSCR_OE)) & 1;
> +            ue =3D (env->fpscr >> (31 - FPSCR_UE)) & 1;
> +            ze =3D (env->fpscr >> (31 - FPSCR_ZE)) & 1;
> +            xe =3D (env->fpscr >> (31 - FPSCR_XE)) & 1;
> +            bool fex;
> +            fex =3D (vx & ve) | (ox & oe) | (ux & ue) | (zx & ze) | (xx =
& xe);
> +            unsigned int mask;
> +            mask =3D (1 << FPSCR_FEX);
> +            /* Set the FEX bit */
> +            env->fpscr =3D (env->fpscr & ~mask) | (-fex & mask);
> +        }
> +            break;
>          default:
>              break;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsm/iMACgkQbDjKyiDZ
s5KWmxAAlhZgDsNKXPQU2j0ewlncL5+gt89mRNrS1WefxDMHHAg8w0DYzlGTHarq
5k47CkKMeeWezrS0/kKNrr8kjdAiucTRLw8KIWHhzaOB/UA6uppV/VqmoO/nJv/o
wyaaNXYiSX3f2LAnlPiwAizevjqg1ehJzOUJOPKvK5wx4dVcyGNgPZiiLYvydtEX
c4p3Vpds0nuOrDyQQLU6h400oytiiOgsa4PW/XgrhCHXh5qJOo8o97wSOiVa+Plj
siMMavEaWqtQor+2+29ev1LFAU9FWqoNChkY67nfsM+MkImHkgecz+/3QMWm0IuX
n+eX1Nl1ztrxPcD/7wAuIjbjGH5keppJSJMqXvAiSLVJ/K819umYy14dbAyCOLhH
DT5sul+Hn63+eLXp4eToPLVOayNGZhruF6C8UOLtELzJs4va8EAfsTEXYzpGLBkd
eyN/f33NnyVfqk2VKgU+YzCeJNVf6nEZY2M/63goJdE7uRxXDVMhH8HNcz5Mbmwl
9JVeAWCphX2LvzuiprrW1FlqAx3aspK/WEP6bKPTAPnX30lG8kmBjWLyrEf+FoB+
sEqTiRZfPTUH28PQxXmd1LEm4SM7lzPdicDHDJuyF2UxtSXmksDTZ+nWoapE7e/K
aR6B8EoTB2UwcdlzBOlDQFB6hXMBpPKvDqQh/Og6h6bBdCBR5OM=
=wlhT
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
