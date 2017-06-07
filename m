Received: from eggs.gnu.org ([2001:4830:134:3::10]:36273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIjvX-0007lO-Cl
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIjvS-00036h-Iq
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:59:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dIjvS-00036T-8y
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:59:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v57MxRTW022661
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 18:59:40 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2axpxt8ra9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 18:59:40 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 7 Jun 2017 18:59:39 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170607013307.GI13397@umbus.fritz.box>
References: <20170606130534.11019-1-david@gibson.dropbear.id.au>
	<20170606130534.11019-2-david@gibson.dropbear.id.au>
	<149678504780.2548.15705693006952673484@loki>
	<20170607013307.GI13397@umbus.fritz.box>
Date: Wed, 07 Jun 2017 17:59:29 -0500
Message-Id: <149687636946.5725.5647554492859089506@loki>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Quoting David Gibson (2017-06-06 20:33:07)
> On Tue, Jun 06, 2017 at 04:37:27PM -0500, Michael Roth wrote:
> > Quoting David Gibson (2017-06-06 08:05:32)
> > > This function is fairly short, and so is its only caller.  There's no
> > > particular logical distinction between them, so fold them together.
> > > =

> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr_pci.c | 53 ++++++++++++++++++++++----------------------=
---------
> > >  1 file changed, 22 insertions(+), 31 deletions(-)
> > > =

> > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > index 46e736d..a216f61 100644
> > > --- a/hw/ppc/spapr_pci.c
> > > +++ b/hw/ppc/spapr_pci.c
> > > @@ -1344,30 +1344,6 @@ static int spapr_create_pci_child_dt(sPAPRPHBS=
tate *phb, PCIDevice *dev,
> > >      return offset;
> > >  }
> > > =

> > > -static void spapr_phb_add_pci_device(sPAPRDRConnector *drc,
> > > -                                     sPAPRPHBState *phb,
> > > -                                     PCIDevice *pdev,
> > > -                                     Error **errp)
> > > -{
> > > -    DeviceState *dev =3D DEVICE(pdev);
> > > -    void *fdt =3D NULL;
> > > -    int fdt_start_offset =3D 0, fdt_size;
> > > -
> > > -    fdt =3D create_device_tree(&fdt_size);
> > > -    fdt_start_offset =3D spapr_create_pci_child_dt(phb, pdev, fdt, 0=
);
> > > -    if (!fdt_start_offset) {
> > > -        error_setg(errp, "Failed to create pci child device tree nod=
e");
> > > -        goto out;
> > > -    }
> > > -
> > > -    spapr_drc_attach(drc, DEVICE(pdev),
> > > -                     fdt, fdt_start_offset, !dev->hotplugged, errp);
> > > -out:
> > > -    if (*errp) {
> > > -        g_free(fdt);
> > > -    }
> > > -}
> > > -
> > >  /* Callback to be called during DRC release. */
> > >  void spapr_phb_remove_pci_device_cb(DeviceState *dev)
> > >  {
> > > @@ -1429,6 +1405,8 @@ static void spapr_phb_hot_plug_child(HotplugHan=
dler *plug_handler,
> > >      Error *local_err =3D NULL;
> > >      PCIBus *bus =3D PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
> > >      uint32_t slotnr =3D PCI_SLOT(pdev->devfn);
> > > +    void *fdt =3D NULL;
> > > +    int fdt_start_offset, fdt_size;
> > > =

> > >      /* if DR is disabled we don't need to do anything in the case of
> > >       * hotplug or coldplug callbacks
> > > @@ -1438,10 +1416,10 @@ static void spapr_phb_hot_plug_child(HotplugH=
andler *plug_handler,
> > >           * we need to let them know it's not enabled
> > >           */
> > >          if (plugged_dev->hotplugged) {
> > > -            error_setg(errp, QERR_BUS_NO_HOTPLUG,
> > > +            error_setg(&local_err, QERR_BUS_NO_HOTPLUG,
> > >                         object_get_typename(OBJECT(phb)));
> > >          }
> > > -        return;
> > > +        goto out;
> > >      }
> > > =

> > >      g_assert(drc);
> > > @@ -1452,16 +1430,23 @@ static void spapr_phb_hot_plug_child(HotplugH=
andler *plug_handler,
> > >       */
> > >      if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)=
] &&
> > >          PCI_FUNC(pdev->devfn) !=3D 0) {
> > > -        error_setg(errp, "PCI: slot %d function 0 already ocuppied b=
y %s,"
> > > +        error_setg(&local_err, "PCI: slot %d function 0 already ocup=
pied by %s,"
> > >                     " additional functions can no longer be exposed t=
o guest.",
> > >                     slotnr, bus->devices[PCI_DEVFN(slotnr, 0)]->name);
> > > -        return;
> > > +        goto out;
> > >      }
> > > =

> > > -    spapr_phb_add_pci_device(drc, phb, pdev, &local_err);
> > =

> > Since we never used local_err outside propagating it and immediately
> > bailing, and since we bail on errp in all prior callers, maybe we
> > should just drop local_err completely in favor errp.
> =

> That doesn't quite work.  The reason for the local_err pattern is so
> that we can tell locally if the error was triggered (errp might be
> NULL, so checking *errp isn't safe).

Ah, of course, not sure how I keep forgetting that detail.

> =

> > =

> > > +    fdt =3D create_device_tree(&fdt_size);
> > > +    fdt_start_offset =3D spapr_create_pci_child_dt(phb, pdev, fdt, 0=
);
> > > +    if (!fdt_start_offset) {
> > > +        error_setg(&local_err, "Failed to create pci child device tr=
ee node");
> > > +        goto out;
> > > +    }
> > > +
> > > +    spapr_drc_attach(drc, DEVICE(pdev), fdt, fdt_start_offset,
> > > +                     !plugged_dev->hotplugged, &local_err);
> > >      if (local_err) {
> > > -        error_propagate(errp, local_err);
> > > -        return;
> > > +        goto out;
> > >      }
> > > =

> > >      /* If this is function 0, signal hotplug for all the device func=
tions.
> > > @@ -1485,6 +1470,12 @@ static void spapr_phb_hot_plug_child(HotplugHa=
ndler *plug_handler,
> > >              }
> > >          }
> > >      }
> > > +
> > > +out:
> > > +    if (local_err) {
> > > +        error_propagate(errp, local_err);
> > > +        g_free(fdt);
> > > +    }
> > >  }
> > > =

> > >  static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
> > =

> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
