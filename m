Received: from eggs.gnu.org ([2001:4830:134:3::10]:47603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkLs0-0004Ya-7M
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkLrz-0001Qp-9C
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:58:16 -0400
Date: Wed, 23 Aug 2017 12:39:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823023945.GM5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ac6a19d43a6d36ae6f7cab99a1ac25d2515339ad.1503249785.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7vLGWvOrvbSM0Ba8"
Content-Disposition: inline
In-Reply-To: <ac6a19d43a6d36ae6f7cab99a1ac25d2515339ad.1503249785.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 13/15] ppc4xx: Add more PLB registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--7vLGWvOrvbSM0Ba8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> These registers are present in 440 SoCs (and maybe in others too) and
> U-Boot accesses them when printing register info. We don't emulate
> these but add them to avoid crashing when they are read or written.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

I'm ok with stub implementation, but I'm a bit uncomfortable with
registering these DCRs unconditionally rather than just on the chips
that actually implement them.

> ---
>  hw/ppc/ppc405_uc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index e621d0a..8e58065 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -105,9 +105,12 @@ ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, pp=
c4xx_bd_info_t *bd,
>  /***********************************************************************=
******/
>  /* Peripheral local bus arbitrer */
>  enum {
> -    PLB0_BESR =3D 0x084,
> -    PLB0_BEAR =3D 0x086,
> -    PLB0_ACR  =3D 0x087,
> +    PLB3A0_ACR =3D 0x077,
> +    PLB4A0_ACR =3D 0x081,
> +    PLB0_BESR  =3D 0x084,
> +    PLB0_BEAR  =3D 0x086,
> +    PLB0_ACR   =3D 0x087,
> +    PLB4A1_ACR =3D 0x089,
>  };
> =20
>  typedef struct ppc4xx_plb_t ppc4xx_plb_t;
> @@ -179,9 +182,12 @@ void ppc4xx_plb_init(CPUPPCState *env)
>      ppc4xx_plb_t *plb;
> =20
>      plb =3D g_malloc0(sizeof(ppc4xx_plb_t));
> +    ppc_dcr_register(env, PLB3A0_ACR, plb, &dcr_read_plb, &dcr_write_plb=
);
> +    ppc_dcr_register(env, PLB4A0_ACR, plb, &dcr_read_plb, &dcr_write_plb=
);
>      ppc_dcr_register(env, PLB0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
>      ppc_dcr_register(env, PLB0_BEAR, plb, &dcr_read_plb, &dcr_write_plb);
>      ppc_dcr_register(env, PLB0_BESR, plb, &dcr_read_plb, &dcr_write_plb);
> +    ppc_dcr_register(env, PLB4A1_ACR, plb, &dcr_read_plb, &dcr_write_plb=
);
>      qemu_register_reset(ppc4xx_plb_reset, plb);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7vLGWvOrvbSM0Ba8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmc6vAACgkQbDjKyiDZ
s5IxVBAAvFdqjWdK8bSwFIDj2Fv/bqVdztc8AhkDekgb3iLOaaVVtSsqr08gnUJR
3+XAC9Z0r53AZxI+VpGDF/MDzIJRWnWKtFiBJDZd0eX1hY/On3b22rFh6e9QArut
4FpjJDZ0AbEGqZhK/H6OfooO9K4DkhbbPPh+ShARXmsjBiXFM5PlOFMwDoqL8Vpa
/4synADknEFhaFmQm2Q7aWhsgh06/aPxePRTLo9FLUU7tu12UDMcTyKdEZ5mI5eO
QC6VQQFynWxk2FaG1RFfn+pRqNIL04fkawDn7LzzfnnNSEGCg/aodSYzmyTIjn2g
NDQKcugr4zOPc9Cxl18kTjtWhcwhOzvQTG2V9Fry26/r48A06oOxPY8fTNnKSzk8
aRDLJbcd1jSD5P4OtyBa1PlhMUVgaDR9mmI7AUWF2HpTWVHVHgZQcH+LsfkPnDbN
wDDruPGQSDKpsUOSSwX1brjKBiYRjSMCn3Q8Pz/fpf8Tx1hmcw/ATQwUWGYitq5C
QEWZrbsBY65CveGPQ3h4YMGRW8oDRMIjXu7N0eQnG0YTKvqVj1PKLknEqdLfd1Ji
YbKlBL8sxrBO41tuj4JmxSI2LxP2xNTy4P7QiAsb2FkLifeo0ldb6j2pLb3BBDlg
gINxvOf4ZsG36dNUCXDyontnvaFLaVTm2/KNz4nX02giJk5UR44=
=SQ4Q
-----END PGP SIGNATURE-----

--7vLGWvOrvbSM0Ba8--
