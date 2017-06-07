Received: from eggs.gnu.org ([2001:4830:134:3::10]:37950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIRWG-0003Zj-RL
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIRWF-0002SM-FM
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:20:28 -0400
Date: Wed, 7 Jun 2017 11:33:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170607013307.GI13397@umbus.fritz.box>
References: <20170606130534.11019-1-david@gibson.dropbear.id.au>
	<20170606130534.11019-2-david@gibson.dropbear.id.au>
	<149678504780.2548.15705693006952673484@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dZMKKfncsnDOeEps"
Content-Disposition: inline
In-Reply-To: <149678504780.2548.15705693006952673484@loki>
Subject: Re: [Qemu-devel] [RFC 1/3] spapr: Fold spapr_phb_add_pci_device()
 into its only caller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--dZMKKfncsnDOeEps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2017 at 04:37:27PM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-06-06 08:05:32)
> > This function is fairly short, and so is its only caller.  There's no
> > particular logical distinction between them, so fold them together.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_pci.c | 53 ++++++++++++++++++++++------------------------=
-------
> >  1 file changed, 22 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 46e736d..a216f61 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1344,30 +1344,6 @@ static int spapr_create_pci_child_dt(sPAPRPHBSta=
te *phb, PCIDevice *dev,
> >      return offset;
> >  }
> >=20
> > -static void spapr_phb_add_pci_device(sPAPRDRConnector *drc,
> > -                                     sPAPRPHBState *phb,
> > -                                     PCIDevice *pdev,
> > -                                     Error **errp)
> > -{
> > -    DeviceState *dev =3D DEVICE(pdev);
> > -    void *fdt =3D NULL;
> > -    int fdt_start_offset =3D 0, fdt_size;
> > -
> > -    fdt =3D create_device_tree(&fdt_size);
> > -    fdt_start_offset =3D spapr_create_pci_child_dt(phb, pdev, fdt, 0);
> > -    if (!fdt_start_offset) {
> > -        error_setg(errp, "Failed to create pci child device tree node"=
);
> > -        goto out;
> > -    }
> > -
> > -    spapr_drc_attach(drc, DEVICE(pdev),
> > -                     fdt, fdt_start_offset, !dev->hotplugged, errp);
> > -out:
> > -    if (*errp) {
> > -        g_free(fdt);
> > -    }
> > -}
> > -
> >  /* Callback to be called during DRC release. */
> >  void spapr_phb_remove_pci_device_cb(DeviceState *dev)
> >  {
> > @@ -1429,6 +1405,8 @@ static void spapr_phb_hot_plug_child(HotplugHandl=
er *plug_handler,
> >      Error *local_err =3D NULL;
> >      PCIBus *bus =3D PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
> >      uint32_t slotnr =3D PCI_SLOT(pdev->devfn);
> > +    void *fdt =3D NULL;
> > +    int fdt_start_offset, fdt_size;
> >=20
> >      /* if DR is disabled we don't need to do anything in the case of
> >       * hotplug or coldplug callbacks
> > @@ -1438,10 +1416,10 @@ static void spapr_phb_hot_plug_child(HotplugHan=
dler *plug_handler,
> >           * we need to let them know it's not enabled
> >           */
> >          if (plugged_dev->hotplugged) {
> > -            error_setg(errp, QERR_BUS_NO_HOTPLUG,
> > +            error_setg(&local_err, QERR_BUS_NO_HOTPLUG,
> >                         object_get_typename(OBJECT(phb)));
> >          }
> > -        return;
> > +        goto out;
> >      }
> >=20
> >      g_assert(drc);
> > @@ -1452,16 +1430,23 @@ static void spapr_phb_hot_plug_child(HotplugHan=
dler *plug_handler,
> >       */
> >      if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] =
&&
> >          PCI_FUNC(pdev->devfn) !=3D 0) {
> > -        error_setg(errp, "PCI: slot %d function 0 already ocuppied by =
%s,"
> > +        error_setg(&local_err, "PCI: slot %d function 0 already ocuppi=
ed by %s,"
> >                     " additional functions can no longer be exposed to =
guest.",
> >                     slotnr, bus->devices[PCI_DEVFN(slotnr, 0)]->name);
> > -        return;
> > +        goto out;
> >      }
> >=20
> > -    spapr_phb_add_pci_device(drc, phb, pdev, &local_err);
>=20
> Since we never used local_err outside propagating it and immediately
> bailing, and since we bail on errp in all prior callers, maybe we
> should just drop local_err completely in favor errp.

That doesn't quite work.  The reason for the local_err pattern is so
that we can tell locally if the error was triggered (errp might be
NULL, so checking *errp isn't safe).

>=20
> > +    fdt =3D create_device_tree(&fdt_size);
> > +    fdt_start_offset =3D spapr_create_pci_child_dt(phb, pdev, fdt, 0);
> > +    if (!fdt_start_offset) {
> > +        error_setg(&local_err, "Failed to create pci child device tree=
 node");
> > +        goto out;
> > +    }
> > +
> > +    spapr_drc_attach(drc, DEVICE(pdev), fdt, fdt_start_offset,
> > +                     !plugged_dev->hotplugged, &local_err);
> >      if (local_err) {
> > -        error_propagate(errp, local_err);
> > -        return;
> > +        goto out;
> >      }
> >=20
> >      /* If this is function 0, signal hotplug for all the device functi=
ons.
> > @@ -1485,6 +1470,12 @@ static void spapr_phb_hot_plug_child(HotplugHand=
ler *plug_handler,
> >              }
> >          }
> >      }
> > +
> > +out:
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        g_free(fdt);
> > +    }
> >  }
> >=20
> >  static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dZMKKfncsnDOeEps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZN1fTAAoJEGw4ysog2bOSs2YP+wU5SX92vnbh+NgTNGkZvmSm
ow+oBBeqTb3hGYim3brm4BEiyS1SRgBrQmhesyN/0r+3xQb8NrYuZUN0tv4taGCo
l+qUw82JwbAsRmafUl5KuyeMK2bvclSSoDEgz75SnPANrdhjZ/h5AcAP6uATzY1O
J8A6dFAcPzBm8sairue50HoxEP60jxkkInsJRTJadKwlww8SnmZcB97SMAgXBsRt
l+f915AxT1MBcPbpDxF0GJXyFa5oWH6EAhBmY5cHnypOHBVEV/oVlGRaMTuNDN+i
4Bvx4QLuY5nikIis5eTLraSOdYSsQ+4BpO0/fK6DkQtxf3+MVi84Yqal2Ezb4nNN
PBx+WdI6qz0F+dltyW64vDTZd7EcNs48e8QaO5ty33MIK1n10hoIH2Rnk4IYmDq8
w61sE8RGHsCgc6WlQ4l5pzZF2JebRWmucfNtTm13YX65yleu30s10oyJ+cJKVzSv
WWnVrLsjP7lfBNJFOzbWOrd9mABAfPcf7RMqITh8RK/F6E9DdY+yUoNIQxw0HDq9
YWMtUyv5SIm4rZw+CRwxD+2W5B36SxY50A+MshdWYnlx38xTKKfOPBXlcBWRPetO
U4uXJ0WYQI9yQDfWpTDax7+TVtY7Qd+FfMkoOJ/k3od1O6rQhn7Ktz2K4P12zPJg
+1vd7jM5db8+gpuk3l0a
=KG6Q
-----END PGP SIGNATURE-----

--dZMKKfncsnDOeEps--
