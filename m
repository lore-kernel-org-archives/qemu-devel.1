Received: from eggs.gnu.org ([2001:4830:134:3::10]:40910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dINb3-00029x-Fa
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dINb0-0000px-Ab
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:09:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35326
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dINb0-0000pg-4E
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:09:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56N8i5p179975
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 19:09:05 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2awy7m8ptd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 19:09:04 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Jun 2017 17:09:04 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170606130534.11019-2-david@gibson.dropbear.id.au>
References: <20170606130534.11019-1-david@gibson.dropbear.id.au>
	<20170606130534.11019-2-david@gibson.dropbear.id.au>
Date: Tue, 06 Jun 2017 16:37:27 -0500
Message-Id: <149678504780.2548.15705693006952673484@loki>
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

Quoting David Gibson (2017-06-06 08:05:32)
> This function is fairly short, and so is its only caller.  There's no
> particular logical distinction between them, so fold them together.
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_pci.c | 53 ++++++++++++++++++++++--------------------------=
-----
>  1 file changed, 22 insertions(+), 31 deletions(-)
> =

> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 46e736d..a216f61 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1344,30 +1344,6 @@ static int spapr_create_pci_child_dt(sPAPRPHBState=
 *phb, PCIDevice *dev,
>      return offset;
>  }
> =

> -static void spapr_phb_add_pci_device(sPAPRDRConnector *drc,
> -                                     sPAPRPHBState *phb,
> -                                     PCIDevice *pdev,
> -                                     Error **errp)
> -{
> -    DeviceState *dev =3D DEVICE(pdev);
> -    void *fdt =3D NULL;
> -    int fdt_start_offset =3D 0, fdt_size;
> -
> -    fdt =3D create_device_tree(&fdt_size);
> -    fdt_start_offset =3D spapr_create_pci_child_dt(phb, pdev, fdt, 0);
> -    if (!fdt_start_offset) {
> -        error_setg(errp, "Failed to create pci child device tree node");
> -        goto out;
> -    }
> -
> -    spapr_drc_attach(drc, DEVICE(pdev),
> -                     fdt, fdt_start_offset, !dev->hotplugged, errp);
> -out:
> -    if (*errp) {
> -        g_free(fdt);
> -    }
> -}
> -
>  /* Callback to be called during DRC release. */
>  void spapr_phb_remove_pci_device_cb(DeviceState *dev)
>  {
> @@ -1429,6 +1405,8 @@ static void spapr_phb_hot_plug_child(HotplugHandler=
 *plug_handler,
>      Error *local_err =3D NULL;
>      PCIBus *bus =3D PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
>      uint32_t slotnr =3D PCI_SLOT(pdev->devfn);
> +    void *fdt =3D NULL;
> +    int fdt_start_offset, fdt_size;
> =

>      /* if DR is disabled we don't need to do anything in the case of
>       * hotplug or coldplug callbacks
> @@ -1438,10 +1416,10 @@ static void spapr_phb_hot_plug_child(HotplugHandl=
er *plug_handler,
>           * we need to let them know it's not enabled
>           */
>          if (plugged_dev->hotplugged) {
> -            error_setg(errp, QERR_BUS_NO_HOTPLUG,
> +            error_setg(&local_err, QERR_BUS_NO_HOTPLUG,
>                         object_get_typename(OBJECT(phb)));
>          }
> -        return;
> +        goto out;
>      }
> =

>      g_assert(drc);
> @@ -1452,16 +1430,23 @@ static void spapr_phb_hot_plug_child(HotplugHandl=
er *plug_handler,
>       */
>      if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
>          PCI_FUNC(pdev->devfn) !=3D 0) {
> -        error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s=
,"
> +        error_setg(&local_err, "PCI: slot %d function 0 already ocuppied=
 by %s,"
>                     " additional functions can no longer be exposed to gu=
est.",
>                     slotnr, bus->devices[PCI_DEVFN(slotnr, 0)]->name);
> -        return;
> +        goto out;
>      }
> =

> -    spapr_phb_add_pci_device(drc, phb, pdev, &local_err);

Since we never used local_err outside propagating it and immediately
bailing, and since we bail on errp in all prior callers, maybe we
should just drop local_err completely in favor errp.

> +    fdt =3D create_device_tree(&fdt_size);
> +    fdt_start_offset =3D spapr_create_pci_child_dt(phb, pdev, fdt, 0);
> +    if (!fdt_start_offset) {
> +        error_setg(&local_err, "Failed to create pci child device tree n=
ode");
> +        goto out;
> +    }
> +
> +    spapr_drc_attach(drc, DEVICE(pdev), fdt, fdt_start_offset,
> +                     !plugged_dev->hotplugged, &local_err);
>      if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> +        goto out;
>      }
> =

>      /* If this is function 0, signal hotplug for all the device function=
s.
> @@ -1485,6 +1470,12 @@ static void spapr_phb_hot_plug_child(HotplugHandle=
r *plug_handler,
>              }
>          }
>      }
> +
> +out:
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        g_free(fdt);
> +    }
>  }
> =

>  static void spapr_phb_hot_unplug_child(HotplugHandler *plug_handler,
> -- =

> 2.9.4
>=20
