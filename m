Received: from eggs.gnu.org ([209.51.188.92]:59957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvw-0003IL-Te
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvu-0005GM-N4
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:04 -0500
Date: Wed, 13 Feb 2019 14:56:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213035653.GE1884@umbus.fritz.box>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999587292.690774.16487295114126456879.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0uCeA/GhJk5vQd80"
Content-Disposition: inline
In-Reply-To: <154999587292.690774.16487295114126456879.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v4 06/15] spapr_pci: add PHB unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--0uCeA/GhJk5vQd80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 07:24:33PM +0100, Greg Kurz wrote:
> To support PHB hotplug we need to clean up lingering references,
> memory, child properties, etc. prior to the PHB object being
> finalized. Generally this will be called as a result of calling
> object_unparent() on the PHB object, which in turn would normally
> be called as the result of an unplug() operation.
>=20
> When the PHB is finalized, child objects will be unparented in
> turn, and finalized if the PHB was the only reference holder. so
> we don't bother to explicitly unparent child objects of the PHB
> (spapr_iommu, spapr_drc, etc).
>=20
> The formula that gives the number of DMA windows is moved to an
> inline function in the hw/pci-host/spapr.h header because it
> will have other users.
>=20
> The unrealize function is able to cope with partially realized PHBs.
> It is hence used to implement proper rollback on the realize error
> path.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v4: - reverted to v2
> v3: - don't free LSIs at unrealize
> v2: - implement rollback with unrealize function
> ---
>  hw/ppc/spapr_pci.c          |   75 +++++++++++++++++++++++++++++++++++++=
++++--
>  include/hw/pci-host/spapr.h |    5 +++
>  2 files changed, 76 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index d68595531d5a..e3781dd110b2 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1565,6 +1565,64 @@ static void spapr_pci_unplug_request(HotplugHandle=
r *plug_handler,
>      }
>  }
> =20
> +static void spapr_phb_finalizefn(Object *obj)
> +{
> +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(obj);
> +
> +    g_free(sphb->dtbusname);
> +    sphb->dtbusname =3D NULL;
> +}
> +
> +static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(phb);
> +    sPAPRTCETable *tcet;
> +    int i;
> +    const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
> +
> +    if (sphb->msi) {
> +        g_hash_table_unref(sphb->msi);
> +        sphb->msi =3D NULL;
> +    }
> +
> +    /*
> +     * Remove IO/MMIO subregions and aliases, rest should get cleaned
> +     * via PHB's unrealize->object_finalize
> +     */
> +    for (i =3D windows_supported - 1; i >=3D 0; i--) {
> +        tcet =3D spapr_tce_find_by_liobn(sphb->dma_liobn[i]);
> +        if (tcet) {
> +            memory_region_del_subregion(&sphb->iommu_root,
> +                                        spapr_tce_get_iommu(tcet));
> +        }
> +    }
> +
> +    for (i =3D PCI_NUM_PINS - 1; i >=3D 0; i--) {
> +        if (sphb->lsi_table[i].irq) {
> +            spapr_irq_free(spapr, sphb->lsi_table[i].irq, 1);
> +            sphb->lsi_table[i].irq =3D 0;
> +        }
> +    }
> +
> +    QLIST_REMOVE(sphb, list);
> +
> +    memory_region_del_subregion(&sphb->iommu_root, &sphb->msiwindow);
> +
> +    address_space_destroy(&sphb->iommu_as);
> +
> +    qbus_set_hotplug_handler(BUS(phb->bus), NULL, &error_abort);
> +    pci_unregister_root_bus(phb->bus);
> +
> +    memory_region_del_subregion(get_system_memory(), &sphb->iowindow);
> +    if (sphb->mem64_win_pciaddr !=3D (hwaddr)-1) {
> +        memory_region_del_subregion(get_system_memory(), &sphb->mem64win=
dow);
> +    }
> +    memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
> +}
> +
>  static void spapr_phb_realize(DeviceState *dev, Error **errp)
>  {
>      /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
> @@ -1582,8 +1640,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      PCIBus *bus;
>      uint64_t msi_window_size =3D 4096;
>      sPAPRTCETable *tcet;
> -    const unsigned windows_supported =3D
> -        sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> +    const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
> =20
>      if (!spapr) {
>          error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries ma=
chine");
> @@ -1740,6 +1797,10 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>              if (local_err) {
>                  error_propagate_prepend(errp, local_err,
>                                          "can't allocate LSIs: ");
> +                /*
> +                 * Older machines will never support PHB hotplug, ie, th=
is is an
> +                 * init only path and QEMU will terminate. No need to ro=
llback.
> +                 */
>                  return;
>              }
> =20
> @@ -1749,7 +1810,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>          spapr_irq_claim(spapr, irq, &local_err);
>          if (local_err) {
>              error_propagate_prepend(errp, local_err, "can't allocate LSI=
s: ");
> -            return;
> +            goto unrealize;
>          }
> =20
>          sphb->lsi_table[i].irq =3D irq;
> @@ -1769,13 +1830,17 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
>          if (!tcet) {
>              error_setg(errp, "Creating window#%d failed for %s",
>                         i, sphb->dtbusname);
> -            return;
> +            goto unrealize;
>          }
>          memory_region_add_subregion(&sphb->iommu_root, 0,
>                                      spapr_tce_get_iommu(tcet));
>      }
> =20
>      sphb->msi =3D g_hash_table_new_full(g_int_hash, g_int_equal, g_free,=
 g_free);
> +    return;
> +
> +unrealize:
> +    spapr_phb_unrealize(dev, NULL);
>  }
> =20
>  static int spapr_phb_children_reset(Object *child, void *opaque)
> @@ -1974,6 +2039,7 @@ static void spapr_phb_class_init(ObjectClass *klass=
, void *data)
> =20
>      hc->root_bus_path =3D spapr_phb_root_bus_path;
>      dc->realize =3D spapr_phb_realize;
> +    dc->unrealize =3D spapr_phb_unrealize;
>      dc->props =3D spapr_phb_properties;
>      dc->reset =3D spapr_phb_reset;
>      dc->vmsd =3D &vmstate_spapr_pci;
> @@ -1989,6 +2055,7 @@ static const TypeInfo spapr_phb_info =3D {
>      .name          =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
>      .parent        =3D TYPE_PCI_HOST_BRIDGE,
>      .instance_size =3D sizeof(sPAPRPHBState),
> +    .instance_finalize =3D spapr_phb_finalizefn,
>      .class_init    =3D spapr_phb_class_init,
>      .interfaces    =3D (InterfaceInfo[]) {
>          { TYPE_HOTPLUG_HANDLER },
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 51d81c4b7ce8..7cfce54a9449 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -163,4 +163,9 @@ static inline void spapr_phb_vfio_reset(DeviceState *=
qdev)
> =20
>  void spapr_phb_dma_reset(sPAPRPHBState *sphb);
> =20
> +static inline unsigned spapr_phb_windows_supported(sPAPRPHBState *sphb)
> +{
> +    return sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> +}
> +
>  #endif /* PCI_HOST_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0uCeA/GhJk5vQd80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjlYQACgkQbDjKyiDZ
s5J4GhAAjgQSDi2I0tAjnwBph4X5jpBcwdy+264xX8lDkSGKUFUnpNx+0VHlEfho
v1Ad1rN9oucxwhIzHGGaq3iLB+mbZyCzaw1y44yMytQTHZi5oK8ZccspSSxKnQ7U
l+f2NCxsdgZM2UaDdz/m/8PvNYGSiJ5tIvY+SGIGJb6lTe4mp1UJiU7KIDSxq1iv
ETZ90CgD6+eaV2hktJ2IvAwqHqks6tIanAeluk+IdYMiQpTJ0vhDTfm6jtABx8X8
rY+4lFN98k/zT0YDxwmBBYFsNLqbnjha7X7sSHoAef1jCWZx8R9x0rFgZf5QRigI
6Vahm4RcWkyG9JF5fx7ZBRhpuwNF2W+m1Z810cNJ/QkI5LKGxEqJPWHvo/UT4i/t
VveTuvxgGzuMsb48RfEqVmy1MUHDekQTPRfPjMSKizFrN6NXkIRXvg6G4wRvNjIn
Fg4ViWY8n+Nj+M1b1sImwoG6nCWgIk9ke3Qa7kGOedcf+eSL0Rm9NX8buXQyhRY0
7S/MDbbWG7O8C4Kv7Uc3RSkWEyEWsEyEqfNpcqdIDkkcksg93rMKAE9PH9A1Iheh
P5dnp88husFkfydwX/Ha+xZVY8YaYw3Y9/WduBlmetDBing6JBChCinx40BHsfMk
gxj2WkUnjlKA5LmPuDnKIaL3LucAGEC38GDaa4IDT1/yO9Ey+Vs=
=T5li
-----END PGP SIGNATURE-----

--0uCeA/GhJk5vQd80--
