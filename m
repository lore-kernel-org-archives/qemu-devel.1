Received: from eggs.gnu.org ([208.118.235.92]:38305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZh-0002ZP-M6
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZf-00056a-D6
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:33 -0500
Date: Thu, 3 Jan 2019 12:59:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103015906.GJ10853@umbus.fritz.box>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154535255201.862554.4906401457640454977.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+Hr//EUsa8//ouuB"
Content-Disposition: inline
In-Reply-To: <154535255201.862554.4906401457640454977.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 04/15] spapr_pci: add proper rollback on
 PHB realize error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>


--+Hr//EUsa8//ouuB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 01:35:52AM +0100, Greg Kurz wrote:
> The current realize code assumes the PHB is coldplugged, ie, QEMU will
> terminate if an error is detected, and does not bother to free anything
> it has already allocated.
>=20
> In order to support PHB hotplug, let's first ensure spapr_phb_realize()
> doesn't leak anything in case of error.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

This looks ok as far as it goes.  However, it looks like there will be
a lot of fragments duplicated between the rollback paths and
unrealize() when it's added in the next patch.

A common pattern to avoid that is to make unrealize() safe to call on
a partially realized object, then call that from the realize() failure
paths.  Is it possible to do that here?  I imagine that would involve
folding this patch with the next as well.

> ---
>  hw/ppc/spapr_pci.c |   40 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index e59adbe706bb..46d7062dd143 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1570,6 +1570,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      sPAPRTCETable *tcet;
>      const unsigned windows_supported =3D
>          sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> +    Object *drcs[PCI_SLOT_MAX * 8];
> =20
>      if (!spapr) {
>          error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries ma=
chine");
> @@ -1733,7 +1734,10 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>          spapr_irq_claim(spapr, irq, true, &local_err);
>          if (local_err) {
>              error_propagate_prepend(errp, local_err, "can't allocate LSI=
s: ");
> -            return;
> +            while (--i >=3D 0) {
> +                spapr_irq_free(spapr, sphb->lsi_table[i].irq, 1);
> +            }
> +            goto fail_del_msiwindow;
>          }
> =20
>          sphb->lsi_table[i].irq =3D irq;
> @@ -1741,9 +1745,10 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
> =20
>      /* allocate connectors for child PCI devices */
>      if (sphb->dr_enabled) {
> -        for (i =3D 0; i < PCI_SLOT_MAX * 8; i++) {
> -            spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
> -                                   (sphb->index << 16) | i);
> +        for (i =3D 0; i < ARRAY_SIZE(drcs); i++) {
> +            drcs[i] =3D
> +                OBJECT(spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DR=
C_PCI,
> +                                              (sphb->index << 16) | i));
>          }
>      }
> =20
> @@ -1753,13 +1758,38 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
>          if (!tcet) {
>              error_setg(errp, "Creating window#%d failed for %s",
>                         i, sphb->dtbusname);
> -            return;
> +            while (--i >=3D 0) {
> +                tcet =3D spapr_tce_find_by_liobn(sphb->dma_liobn[i]);
> +                assert(tcet);
> +                memory_region_del_subregion(&sphb->iommu_root,
> +                                            spapr_tce_get_iommu(tcet));
> +                object_unparent(OBJECT(tcet));
> +            }
> +            goto fail_free_drcs;
>          }
>          memory_region_add_subregion(&sphb->iommu_root, 0,
>                                      spapr_tce_get_iommu(tcet));
>      }
> =20
>      sphb->msi =3D g_hash_table_new_full(g_int_hash, g_int_equal, g_free,=
 g_free);
> +    return;
> +
> +fail_free_drcs:
> +    if (sphb->dr_enabled) {
> +        for (i =3D 0; i < ARRAY_SIZE(drcs); i++) {
> +            object_unparent(drcs[i]);
> +        }
> +    }
> +fail_del_msiwindow:
> +    memory_region_del_subregion(&sphb->iommu_root, &sphb->msiwindow);
> +    address_space_destroy(&sphb->iommu_as);
> +    qbus_set_hotplug_handler(BUS(phb->bus), NULL, &error_abort);
> +    pci_unregister_root_bus(phb->bus);
> +    memory_region_del_subregion(get_system_memory(), &sphb->iowindow);
> +    if (sphb->mem64_win_pciaddr !=3D (hwaddr)-1) {
> +        memory_region_del_subregion(get_system_memory(), &sphb->mem64win=
dow);
> +    }
> +    memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
>  }
> =20
>  static int spapr_phb_children_reset(Object *child, void *opaque)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+Hr//EUsa8//ouuB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwtbGoACgkQbDjKyiDZ
s5LSKRAA326w3TamQpP04PfUVZcNiMJiDT8cbeyn/gNrGiAX7UWtTFgU1dIv1jE+
g8JTp77hYjLoiE0owDMa5tdgBAoouV9xPvtUTYdgXdL90fNfxVrvNi6HP9xJANVC
MPKnnKQBLnbRjvRJbKHys0bi9OciBoNW/fbY4MYP4X2UNsS6DuEX+bJALjYYFzbj
YTl15WrL6vwzZTKFEWTscKbBYNxXO9vxm9dMpTgYyUausekCDe/5yIIfBhsCvGn1
RYx9hMfj/2VcLUFQ/GetLgZtq8Iz88vhrOGtmM6eKbrPmgAv3Yq4HLnVm/rSfqaw
C1Q/9EFY2tk9rEHT8Iid+tM8yziPtV9BV8W9uKzRwit0dGFiLWRcVQ6B9scL01Eo
Bj9HSfPk7D8LQIU3h1IxO8cz0PmV0LQMbVp0oqL20kx3Hx5HHMEhaoWLNn3Tj8Hc
s9gJqPEPLULQ4gqSRnNpZb5fDLmYP/shsTA//2iAcPR/lvyWOybczrGmTMF2sVRs
mvM0e6S8i855yDLORru1pk/hEkb0nncoFtPhW+YHIN2bUQnJ8dL21+javYzrYQzO
hxBuj/xEWzExvSuKZBogYLQ+YGozBl1C8+cToLE9J5Ry7qRj53iZTmHHufFxmU7N
TK97xU7UQWul/IR9/DY1Srzfnz7NtM3un7fwDCEznFj0ZRTGot4=
=MV3Q
-----END PGP SIGNATURE-----

--+Hr//EUsa8//ouuB--
