Received: from eggs.gnu.org ([2001:4830:134:3::10]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQE5Q-00079Q-65
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQE5L-0006DX-9a
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:36:56 -0400
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:52151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQE5L-0006Cs-2c
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:36:51 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id ECB8610D82B
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 16:36:48 +0200 (CEST)
Date: Wed, 28 Jun 2017 16:36:41 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170628163641.67809200@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170628140919.27167-1-lvivier@redhat.com>
References: <20170628140919.27167-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Lml9i4ec5SkAv6DzMAe.aI/";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: fix migration to pseries
 machine < 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/Lml9i4ec5SkAv6DzMAe.aI/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Jun 2017 16:09:19 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> since commit 5c4537bd ("spapr: Fix 2.7<->2.8 migration of PCI host bridge=
"),
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
> ---

Maybe Cc: qemu-stable ?

Reviewed-by: Greg Kurz <groug@kaod.org>

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


--Sig_/Lml9i4ec5SkAv6DzMAe.aI/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllTvvkACgkQAvw66wEB28JcugCdE0MHsHKQqIYVNIC01z9yfnde
3XoAn2finHbCD/D7UnzyjL7N6AnRPWV+
=Awxn
-----END PGP SIGNATURE-----

--Sig_/Lml9i4ec5SkAv6DzMAe.aI/--
