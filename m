Received: from eggs.gnu.org ([209.51.188.92]:49880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ggXxM-00041J-TY
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ggXxL-0000fL-TE
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:40:52 -0500
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:58028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ggXxL-0000OR-L9
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:40:51 -0500
Received: from player688.ha.ovh.net (unknown [10.109.160.25])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id D0484396FF
	for <qemu-devel@nongnu.org>; Mon,  7 Jan 2019 17:40:42 +0100 (CET)
Date: Mon, 7 Jan 2019 17:40:22 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190107174022.625b3c78@bahia.lan>
In-Reply-To: <20190103015906.GJ10853@umbus.fritz.box>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154535255201.862554.4906401457640454977.stgit@bahia.lan>
	<20190103015906.GJ10853@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/RCbu0ET84B8_dOAnD3Gtqyr";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

--Sig_/RCbu0ET84B8_dOAnD3Gtqyr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Jan 2019 12:59:06 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Dec 21, 2018 at 01:35:52AM +0100, Greg Kurz wrote:
> > The current realize code assumes the PHB is coldplugged, ie, QEMU will
> > terminate if an error is detected, and does not bother to free anything
> > it has already allocated.
> >=20
> > In order to support PHB hotplug, let's first ensure spapr_phb_realize()
> > doesn't leak anything in case of error.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> This looks ok as far as it goes.  However, it looks like there will be
> a lot of fragments duplicated between the rollback paths and
> unrealize() when it's added in the next patch.
>=20
> A common pattern to avoid that is to make unrealize() safe to call on
> a partially realized object, then call that from the realize() failure
> paths.  Is it possible to do that here?  I imagine that would involve
> folding this patch with the next as well.
>=20

Makes sense. I'll give a try.

> > ---
> >  hw/ppc/spapr_pci.c |   40 +++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 35 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index e59adbe706bb..46d7062dd143 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1570,6 +1570,7 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
> >      sPAPRTCETable *tcet;
> >      const unsigned windows_supported =3D
> >          sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> > +    Object *drcs[PCI_SLOT_MAX * 8];
> > =20
> >      if (!spapr) {
> >          error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries =
machine");
> > @@ -1733,7 +1734,10 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
> >          spapr_irq_claim(spapr, irq, true, &local_err);
> >          if (local_err) {
> >              error_propagate_prepend(errp, local_err, "can't allocate L=
SIs: ");
> > -            return;
> > +            while (--i >=3D 0) {
> > +                spapr_irq_free(spapr, sphb->lsi_table[i].irq, 1);
> > +            }
> > +            goto fail_del_msiwindow;
> >          }
> > =20
> >          sphb->lsi_table[i].irq =3D irq;
> > @@ -1741,9 +1745,10 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
> > =20
> >      /* allocate connectors for child PCI devices */
> >      if (sphb->dr_enabled) {
> > -        for (i =3D 0; i < PCI_SLOT_MAX * 8; i++) {
> > -            spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
> > -                                   (sphb->index << 16) | i);
> > +        for (i =3D 0; i < ARRAY_SIZE(drcs); i++) {
> > +            drcs[i] =3D
> > +                OBJECT(spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_=
DRC_PCI,
> > +                                              (sphb->index << 16) | i)=
);
> >          }
> >      }
> > =20
> > @@ -1753,13 +1758,38 @@ static void spapr_phb_realize(DeviceState *dev,=
 Error **errp)
> >          if (!tcet) {
> >              error_setg(errp, "Creating window#%d failed for %s",
> >                         i, sphb->dtbusname);
> > -            return;
> > +            while (--i >=3D 0) {
> > +                tcet =3D spapr_tce_find_by_liobn(sphb->dma_liobn[i]);
> > +                assert(tcet);
> > +                memory_region_del_subregion(&sphb->iommu_root,
> > +                                            spapr_tce_get_iommu(tcet));
> > +                object_unparent(OBJECT(tcet));
> > +            }
> > +            goto fail_free_drcs;
> >          }
> >          memory_region_add_subregion(&sphb->iommu_root, 0,
> >                                      spapr_tce_get_iommu(tcet));
> >      }
> > =20
> >      sphb->msi =3D g_hash_table_new_full(g_int_hash, g_int_equal, g_fre=
e, g_free);
> > +    return;
> > +
> > +fail_free_drcs:
> > +    if (sphb->dr_enabled) {
> > +        for (i =3D 0; i < ARRAY_SIZE(drcs); i++) {
> > +            object_unparent(drcs[i]);
> > +        }
> > +    }
> > +fail_del_msiwindow:
> > +    memory_region_del_subregion(&sphb->iommu_root, &sphb->msiwindow);
> > +    address_space_destroy(&sphb->iommu_as);
> > +    qbus_set_hotplug_handler(BUS(phb->bus), NULL, &error_abort);
> > +    pci_unregister_root_bus(phb->bus);
> > +    memory_region_del_subregion(get_system_memory(), &sphb->iowindow);
> > +    if (sphb->mem64_win_pciaddr !=3D (hwaddr)-1) {
> > +        memory_region_del_subregion(get_system_memory(), &sphb->mem64w=
indow);
> > +    }
> > +    memory_region_del_subregion(get_system_memory(), &sphb->mem32windo=
w);
> >  }
> > =20
> >  static int spapr_phb_children_reset(Object *child, void *opaque)
> >  =20
>=20


--Sig_/RCbu0ET84B8_dOAnD3Gtqyr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlwzgPYACgkQcdTV5YIv
c9a1fA//Yo/G8Av7gRbGnUaZzV9qaN7GWyp0SCqNv7wVkRLRMY/9GxRrD/zzMhti
cmYTqboI53eo1XSubF2Ujn7K2A/nEDj3zLIKCyThh1B296c59plJUuw6L/GE8H15
2Y2VzQYur2/tuumsR1rIN/GulOYPZDhGI1qRx9cK1ctpm0O9qEMkGLlHPKHSrzKZ
E9fB1FaUU6VG5UAcxQY2cMhqfuymVHJqXz+pTejyDJJivp9Wvfg2YVmg6ovawiH6
ERsiQTKLavbRjJHrb2wCuh3GdMfMyJjYUVCfjQXnce41ume621x+quxvbF3TnB62
5Be99sk706mds7Gap+1njW8niyAivlX5yRGHmYvh8oAvEIteDwHmojH6+juszsed
L/iPgZgJZz8pIdU3g0KhjTFP9kAN08ohJg+k5cvUx2mXY+5RJ0wso+RcDskESYh+
NUDl1Uff7NEpdzvh0xjJY4EOqs78mRnOtLMKZccXPTcsoyUNzSXwq18+f6n78uoe
uVpsdtYyavWd0Ge3z7B+XkxTdKal3QO9AAv+8tqUFLH4nmnnDfIOgTyRPfDlWWyn
zIOGPG9+8JuOfgxpY80f8ZwRTHWwOa8WtAHHJhjcDJnOfDD5Knnabr0AaGxATcj3
NjJG0msRqXr6Yx2lSAk3xngleRiqW/8qnZxQKBMz0LyMwCkJubY=
=GH7R
-----END PGP SIGNATURE-----

--Sig_/RCbu0ET84B8_dOAnD3Gtqyr--
