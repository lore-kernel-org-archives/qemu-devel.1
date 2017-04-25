Received: from eggs.gnu.org ([2001:4830:134:3::10]:39415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39D0-0006km-AV
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39Cx-000551-MP
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:45:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57242
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d39Cx-00054g-GD
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 18:45:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PMhlMO040068
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 18:45:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebttcfu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 18:45:18 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 18:45:17 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170424220828.1472-3-danielhb@linux.vnet.ibm.com>
References: <20170424220828.1472-1-danielhb@linux.vnet.ibm.com>
	<20170424220828.1472-3-danielhb@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 17:45:11 -0500
Message-Id: <149316031125.25359.7668430465437115135@loki>
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/ppc: migrating the DRC state of
 hotplugged devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Quoting Daniel Henrique Barboza (2017-04-24 17:08:26)
> In pseries, a firmware abstraction called Dynamic Reconfiguration
> Connector (DRC) is used to assign a particular dynamic resource
> to the guest and provide an interface to manage configuration/removal
> of the resource associated with it. In other words, DRC is the
> 'plugged state' of a device.
> =

> Before this patch, DRC wasn't being migrated. This causes
> post-migration problems due to DRC state mismatch between source and
> target. The DRC state of a device X in the source might
> change, while in the target the DRC state of X is still fresh. When
> migrating the guest, X will not have the same hotplugged state as it
> did in the source. This means that we can't hot unplug X in the
> target after migration is completed because its DRC state is not consiste=
nt.
> https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1677552 is one
> bug that is caused by this DRC state mismatch between source and
> target.
> =

> To migrate the DRC state, we defined the VMStateDescription struct for
> spapr_drc to enable the transmission of spapr_drc state in migration.
> Not all the elements in the DRC state are migrated - only those
> that can be modified by guest actions or device add/remove
> operations:
> =

> - 'isolation_state', 'allocation_state' and 'configured' are involved
> in the DR state transition diagram from PAPR+ 2.7, 13.4;
> =

> - 'configured' and 'signalled' are needed in attaching and detaching
> devices;
> =

> - 'indicator_state' provides users with hardware state information.
> =

> These are the DRC elements that are migrated.
> =

> In this patch the DRC state is migrated for PCI, LMB and CPU
> connector types. At this moment there is no support to migrate
> DRC for the PHB (PCI Host Bridge) type.
> =

> The instance_id is used to identify objects in migration. We set
> instance_id of DRC using the unique index so that it is the same
> across migration.
> =

> In hw/ppc/spapr_pci.c, a function called spapr_pci_set_detach_cb
> was created to set the detach_cb of the migrated DRC in the
> spapr_pci_post_load. The reason is that detach_cb is a DRC function
> pointer that can't be migrated but we need it set in the target
> so a ongoing hot-unplug event can properly finish.
> =

> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_drc.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/spapr_pci.c | 22 ++++++++++++++++++
>  2 files changed, 89 insertions(+)
> =

> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index a1cdc87..5c2baad 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -651,6 +651,70 @@ static void spapr_dr_connector_instance_init(Object =
*obj)
>                          NULL, NULL, NULL, NULL);
>  }
> =

> +static bool spapr_drc_needed(void *opaque)
> +{
> +    sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
> +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +    bool rc =3D false;
> +    sPAPRDREntitySense value;
> +    drck->entity_sense(drc, &value);
> +    /* If no dev is plugged in there is no need to migrate the DRC state=
 */
> +    if (value !=3D SPAPR_DR_ENTITY_SENSE_PRESENT) {
> +        return false;
> +    }
> +
> +    /*
> +     * If there is dev plugged in, we need to migrate the DRC state when
> +     * it is different from cold-plugged state
> +     */
> +    switch (drc->type) {
> +
> +    case SPAPR_DR_CONNECTOR_TYPE_PCI:
> +        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_U=
NISOLATED) &&
> +               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_U=
SABLE) &&
> +               drc->configured && drc->signalled && !drc->awaiting_relea=
se);
> +        break;
> +
> +    case SPAPR_DR_CONNECTOR_TYPE_LMB:
> +        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_I=
SOLATED) &&
> +               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_U=
NUSABLE) &&
> +               drc->configured && drc->signalled && !drc->awaiting_relea=
se);
> +        break;
> +
> +    case SPAPR_DR_CONNECTOR_TYPE_CPU:
> +        rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_I=
SOLATED) &&
> +               (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_U=
NUSABLE) &&
> +                drc->configured && drc->signalled && !drc->awaiting_rele=
ase);
> +        break;
> +
> +    default:
> +        ;
> +    }
> +    return rc;
> +}
> +
> +/* return the unique drc index as instance_id for qom interfaces*/
> +static int get_instance_id(DeviceState *dev)
> +{
> +    return (int)get_index(SPAPR_DR_CONNECTOR(OBJECT(dev)));
> +}
> +
> +static const VMStateDescription vmstate_spapr_drc =3D {
> +    .name =3D "spapr_drc",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_drc_needed,
> +    .fields  =3D (VMStateField []) {
> +        VMSTATE_UINT32(isolation_state, sPAPRDRConnector),
> +        VMSTATE_UINT32(allocation_state, sPAPRDRConnector),
> +        VMSTATE_UINT32(indicator_state, sPAPRDRConnector),
> +        VMSTATE_BOOL(configured, sPAPRDRConnector),
> +        VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
> +        VMSTATE_BOOL(signalled, sPAPRDRConnector),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
>  {
>      DeviceClass *dk =3D DEVICE_CLASS(k);
> @@ -659,6 +723,8 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
>      dk->reset =3D reset;
>      dk->realize =3D realize;
>      dk->unrealize =3D unrealize;
> +    dk->vmsd =3D &vmstate_spapr_drc;
> +    dk->dev_get_instance_id =3D get_instance_id;
>      drck->set_isolation_state =3D set_isolation_state;
>      drck->set_indicator_state =3D set_indicator_state;
>      drck->set_allocation_state =3D set_allocation_state;
> @@ -672,6 +738,7 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
>      drck->detach =3D detach;
>      drck->release_pending =3D release_pending;
>      drck->set_signalled =3D set_signalled;
> +
>      /*
>       * Reason: it crashes FIXME find and document the real reason
>       */
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 98c52e4..639dad2 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1922,12 +1922,34 @@ static void spapr_pci_pre_save(void *opaque)
>      }
>  }
> =

> +/*
> + * detach_cb in the DRC state is a function pointer that cannot be
> + * migrated. We set it right after migration so that a migrated
> + * hot-unplug event could finish its work.
> + */
> +static void spapr_pci_set_detach_cb(PCIBus *bus, PCIDevice *pdev,
> +                                 void *opaque)
> +{
> +    sPAPRPHBState *sphb =3D opaque;
> +    sPAPRDRConnector *drc =3D spapr_phb_get_pci_drc(sphb, pdev);
> +    drc->detach_cb =3D spapr_phb_remove_pci_device_cb;
> +}

This is doesn't quite work, because drc->detach_cb takes an opaque
argument that is not being restored in here (and is not really
possible to restore).

However, the only DRC user who currently relies on the opaque is
memory unplug, which passes an sPAPRDIMMState via spapr_del_lmbs:

  drck->detach(drc, dev, spapr_lmb_release, ds, errp);

It's actually possible to do away with this, you just need to add
the sPAPRDIMMStates to a QTAILQ that's attached to sPAPRPHBState,
and then migrate it when it is non-empty, similar to how ccs_list
is migrated in the following patch. Then you would modify
spapr_lmb_release to search that queue for the matching
sPAPRDIMMState instead of relying on the opaque argument. You
can get to the sPAPRPHBState via qdev_get_machine(),
spapr_phb_realize() has an example.

spapr_phb_remove_pci_device_cb also currently takes an opaque to
an sPAPRPHBState*, but it doesn't actually do anything with it,
so you can drop it from there. and spapr_core_release never used
an opaque.

> +
>  static int spapr_pci_post_load(void *opaque, int version_id)
>  {
>      sPAPRPHBState *sphb =3D opaque;
>      gpointer key, value;
>      int i;
> =

> +    PCIBus *bus =3D PCI_HOST_BRIDGE(sphb)->bus;
> +    unsigned int bus_no =3D 0;
> +
> +    /* Set detach_cb for the drc unconditionally after migration */
> +    if (bus) {
> +        pci_for_each_device(bus, pci_bus_num(bus), spapr_pci_set_detach_=
cb,
> +                            &bus_no);
> +    }

In a previous thread it was suggested that rather than restoring these
after migration, we should modify spapr_dr_connector_new() to take the
attach/detach callbacks as parameters so that they are set statically
at init time. Then we can drop all the post-load hooks (memory/cpu
would need similar post-load restorations as well, otherwise).

> +
>      for (i =3D 0; i < sphb->msi_devs_num; ++i) {
>          key =3D g_memdup(&sphb->msi_devs[i].key,
>                         sizeof(sphb->msi_devs[i].key));
> -- =

> 2.9.3
> =

>=20
