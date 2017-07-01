Received: from eggs.gnu.org ([2001:4830:134:3::10]:57800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRDbk-0004Cf-G9
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 04:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRDbh-00027l-BJ
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 04:18:24 -0400
Date: Sat, 1 Jul 2017 17:53:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170701075310.GL13989@umbus.fritz.box>
References: <20170628140919.27167-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t5C3/nrmPumNj5sH"
Content-Disposition: inline
In-Reply-To: <20170628140919.27167-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix migration to pseries machine <
 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--t5C3/nrmPumNj5sH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 04:09:19PM +0200, Laurent Vivier wrote:
1;4602;0c> since commit 5c4537bd ("spapr: Fix 2.7<->2.8 migration of PCI ho=
st bridge"),
> some migration fields are forged from the new ones in spapr_pci_pre_save(=
).
>=20
> It works well, except when the number of MSI devices is 0,
> because in this case the function exits immediately.
>=20
> This fix moves the migration code before the exit code.
>=20
> The problem can be reproduced with these commands:
>=20
> source qemu-2.9:
>=20
>     qemu-system-ppc64 -monitor stdio -M pseries-2.6 -nodefaults -S
>=20
> destination qemu-2.6:
>=20
>     qemu-system-ppc64 -monitor stdio -M pseries-2.6 -nodefaults \
>                       -incoming tcp:0:4444
>=20
> on the source:
>=20
>     migrate tcp:localhost:4444
>=20
> Destination fails with the following error:
>=20
>     qemu-system-ppc64: error while loading state for
>                        instance 0x0 of device 'spapr_pci'
>     qemu-system-ppc64: load of migration failed: Invalid argument
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/spapr_pci.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 0b447f2..bd30b4f 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1873,20 +1873,6 @@ static void spapr_pci_pre_save(void *opaque)
>      gpointer key, value;
>      int i;
> =20
> -    g_free(sphb->msi_devs);
> -    sphb->msi_devs =3D NULL;
> -    sphb->msi_devs_num =3D g_hash_table_size(sphb->msi);
> -    if (!sphb->msi_devs_num) {
> -        return;
> -    }
> -    sphb->msi_devs =3D g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_ms=
i_mig));
> -
> -    g_hash_table_iter_init(&iter, sphb->msi);
> -    for (i =3D 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
> -        sphb->msi_devs[i].key =3D *(uint32_t *) key;
> -        sphb->msi_devs[i].value =3D *(spapr_pci_msi *) value;
> -    }
> -
>      if (sphb->pre_2_8_migration) {
>          sphb->mig_liobn =3D sphb->dma_liobn[0];
>          sphb->mig_mem_win_addr =3D sphb->mem_win_addr;
> @@ -1900,6 +1886,20 @@ static void spapr_pci_pre_save(void *opaque)
>              sphb->mig_mem_win_size +=3D sphb->mem64_win_size;
>          }
>      }
> +
> +    g_free(sphb->msi_devs);
> +    sphb->msi_devs =3D NULL;
> +    sphb->msi_devs_num =3D g_hash_table_size(sphb->msi);
> +    if (!sphb->msi_devs_num) {
> +        return;
> +    }
> +    sphb->msi_devs =3D g_malloc(sphb->msi_devs_num * sizeof(spapr_pci_ms=
i_mig));
> +
> +    g_hash_table_iter_init(&iter, sphb->msi);
> +    for (i =3D 0; g_hash_table_iter_next(&iter, &key, &value); ++i) {
> +        sphb->msi_devs[i].key =3D *(uint32_t *) key;
> +        sphb->msi_devs[i].value =3D *(spapr_pci_msi *) value;
> +    }
>  }
> =20
>  static int spapr_pci_post_load(void *opaque, int version_id)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--t5C3/nrmPumNj5sH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZV1TmAAoJEGw4ysog2bOShnUQAOGWs/tJYrF6btU7cynT5Q65
2JgnzsXEXMA1gmiHDwNQen4l9tdiavLPFodpTHocF+L6GHvFAE+OAi9BASIxZsdG
xm+FwflVPe//8R3qkjE9NiC0MOyxzuXJHb++KLZhbrN15ZML07Y407Qh3lssSz4s
eryfoh2XSsGG0Ja91YG4E3PT0FbKlpFfRALUB26dzW3cOcXVFfbNbCwj579IeX7I
wfMojKEaGrZH2OoNdYS/8EOr4m3N9PA4/T8kmrNyRfb8FnJY19eP+ut/XJdj8Daa
vULmUYJuI/iIELbKWNqumbhChaNuKQdq/w1lVqYSAqFlFP+1jYCMt25mWyvCmfPK
FoAETojG/Ul/wy0JqAaaEF/j3d981bwpHF6k2bwnO1W6B5bK398ll/NjYcADYXsf
YeJYJMkKlfUx6lx2dOQXSua+fl5ljz+dO4dD5YUQ8GAf1ME14S1warTpAHShAm8G
upvLnizqQxI/GU1z+JeO1vRGNsgblMM4YVMkukqqPThrIjqjxeOLeQfoT3RxDO75
VZdvqBOLxfQ7qBoJ4XD4Qkt7a2Tl4iwZYTY8VblXN4W9QnFMlgvXwK3kLIXXmQbi
YzxKypfF/PvV1cEGHiKJHJ8vMkSOr8rrfWoU0bIJsobKjD92LqJzjciAHdVV/Su8
D0+vGfrH8Fyq4ZAeXjr7
=WZyL
-----END PGP SIGNATURE-----

--t5C3/nrmPumNj5sH--
