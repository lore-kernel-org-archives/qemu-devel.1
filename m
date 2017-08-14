Received: from eggs.gnu.org ([2001:4830:134:3::10]:56229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh8fh-0000dS-BC
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh8fd-0005bv-7t
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:16:17 -0400
Date: Mon, 14 Aug 2017 14:44:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170814044454.GG3452@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<675e091387248b49c97ff99ef07eb23ed316aefb.1502643878.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
In-Reply-To: <675e091387248b49c97ff99ef07eb23ed316aefb.1502643878.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 11/12] ppc4xx: Export ECB and PLB
 emulation
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


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> These devices are found in some other ppc4xx cores too.

Elsewhere in the series you moved things that were used elsewhere out
of 405_uc, why not do that here as well?

> Also add some more PLB registers for 460EX.

Separate patch for that please, it's logically unrelated.  Plus the
commit message should say what these registers are, where they appear,
why do we need them?

>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/ppc405.h    |  3 +++
>  hw/ppc/ppc405_uc.c | 16 +++++++++++-----
>  2 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
> index a9ffc87..7ed25cf 100644
> --- a/hw/ppc/ppc405.h
> +++ b/hw/ppc/ppc405.h
> @@ -59,6 +59,9 @@ struct ppc4xx_bd_info_t {
>  ram_addr_t ppc405_set_bootinfo (CPUPPCState *env, ppc4xx_bd_info_t *bd,
>                                  uint32_t flags);
> =20
> +void ppc4xx_plb_init(CPUPPCState *env);
> +void ppc405_ebc_init(CPUPPCState *env);
> +
>  CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
>                          MemoryRegion ram_memories[4],
>                          hwaddr ram_bases[4],
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 8f44cb4..8e58065 100644
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
> @@ -174,14 +177,17 @@ static void ppc4xx_plb_reset (void *opaque)
>      plb->besr =3D 0x00000000;
>  }
> =20
> -static void ppc4xx_plb_init(CPUPPCState *env)
> +void ppc4xx_plb_init(CPUPPCState *env)
>  {
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
> @@ -585,7 +591,7 @@ static void ebc_reset (void *opaque)
>      ebc->cfg =3D 0x80400000;
>  }
> =20
> -static void ppc405_ebc_init(CPUPPCState *env)
> +void ppc405_ebc_init(CPUPPCState *env)
>  {
>      ppc4xx_ebc_t *ebc;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmRKsYACgkQbDjKyiDZ
s5L0bBAA5Gk6I9NtAn6MKDMhJyJ8pXPepApeDjXmzZjnRCcZqXZUl08EPcriw6Sa
u4jmTPmU1YoFzbKQnoFtn1JPm9sXwu6UyigPtqDSiWXyah9Ut4Yr+aL05Jb3DcCP
4BsyvFjS6KnRamqAGN49ib8IqdMcrEY+itqr1qohUSmBTFsoKo6AnuXns96TqUhx
ggj9eA6FFlvWUrgA/omWaL5LbOa+wq3ZYHIwIv3eSdh6vLxhgKc7/JFfQjTm3axe
ZmCOgIzBk38udvSQAuM2U/3asc/btA4Fbr936WuiGGTNkVTZxGVNR1FuOj8wRj5T
+JRLC2yF48bITWmw2r77Kx2xSV24rGmILQRDV7kvJ5ShlP0OtTNyAqqQ6RNc9YuA
rMi+SFEh/kOcmU45myKicyNsVQ/qIxzL0MJ/UVHNv6e0wQky6BQVMIZpGN5jnPq2
ObEhiXdRFu3R9IER1Evj0oMonp6CvgY8g1RuWOmYsi79dNlWbTRemzHr0u5DoEIM
QjUGmvlDkV0hs4S81HcDWTM9E6en56XFGH1WlFvs8wmljqvj/4O87NZLVOV3dhe7
PP3AaiyIvbD1o5aUo3dlUDzOP+goeMeYHfnewD4K3l+sZZFatlVNP9o15XK0bE4F
o3iN8jROYRVhlFem6digZM+H/zfpIlCz+u8x5QjWrkHbHAHLk8A=
=iocu
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
