Received: from eggs.gnu.org ([209.51.188.92]:49884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtuWj-0004PN-QQ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtuWh-0003dg-Mh
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:24:37 -0500
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:59418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtuWh-0003ZD-CK
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:24:35 -0500
Received: from player716.ha.ovh.net (unknown [10.109.146.175])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id E79A8F28B9
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 14:24:30 +0100 (CET)
Date: Wed, 13 Feb 2019 14:24:12 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190213142412.00ba8ffe@bahia.lan>
In-Reply-To: <20190213041307.GH1884@umbus.fritz.box>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999592549.690774.13071669609040970763.stgit@bahia.lan>
	<20190213041307.GH1884@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/_XlV2Xw=LGidnLCh3Mdm2rp";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 14/15] spapr: add hotplug hooks for PHB
 hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

--Sig_/_XlV2Xw=LGidnLCh3Mdm2rp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Feb 2019 15:13:08 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Feb 12, 2019 at 07:25:25PM +0100, Greg Kurz wrote:
> > Hotplugging PHBs is a machine-level operation, but PHBs reside on the
> > main system bus, so we register spapr machine as the handler for the
> > main system bus.
> >=20
> > Provide the usual pre-plug, plug and unplug-request handlers.
> >=20
> > Move the checking of the PHB index to the pre-plug handler. It is okay
> > to do that and assert in the realize function because the pre-plug
> > handler is always called, even for the oldest machine types we support.
> >=20
> > Unlike with other device types, there are some cases where we cannot
> > provide the FDT fragment of the PHB from the plug handler, eg, before
> > KVMPPC_H_UPDATE_DT was called. Do this from a DRC callback that is
> > called just before the first FDT fragment is exposed to the guest.
> >=20
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > (Fixed interrupt controller phandle in "interrupt-map" and
> >  TCE table size in "ibm,dma-window" FDT fragment, Greg Kurz)
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v4: - populate FDT fragment in a DRC callback
> > v3: - reworked phandle handling some more
> > v2: - reworked phandle handling
> >     - sync LSIs to KVM
> > ---
> > ---
> >  hw/ppc/spapr.c         |  121 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  hw/ppc/spapr_drc.c     |    2 +
> >  hw/ppc/spapr_pci.c     |   16 ------
> >  include/hw/ppc/spapr.h |    5 ++
> >  4 files changed, 127 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 021758825b7e..06ce0babcb54 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2930,6 +2930,11 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >      register_savevm_live(NULL, "spapr/htab", -1, 1,
> >                           &savevm_htab_handlers, spapr);
> > =20
> > +    if (smc->dr_phb_enabled) {
> > +        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine),
> > +                                 &error_fatal);
> > +    } =20
>=20
> I think you could do this unconditionally and just check
> dr_phb_enabled at pre_plug.  That makes it more consistent with the
> other hotplug types, and I suspect will give us better error messages.
>=20

Ok.

> >      qemu_register_boot_set(spapr_boot_set, spapr);
> > =20
> >      if (kvm_enabled()) {
> > @@ -3733,6 +3738,108 @@ out:
> >      error_propagate(errp, local_err);
> >  }
> > =20
> > +int spapr_dt_phb(DeviceState *dev, sPAPRMachineState *spapr, void *fdt,
> > +                 int *fdt_start_offset, Error **errp)
> > +{
> > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > +    uint32_t intc_phandle;
> > +
> > +    if (spapr_irq_get_phandle(spapr, spapr->fdt_blob, &intc_phandle, e=
rrp)) {
> > +        return -1;
> > +    }
> > +
> > +    if (spapr_populate_pci_dt(sphb, intc_phandle, fdt, spapr->irq->nr_=
msis,
> > +                              fdt_start_offset)) {
> > +        error_setg(errp, "unable to create FDT node for PHB %d", sphb-=
>index);
> > +        return -1;
> > +    }
> > +
> > +    /* generally SLOF creates these, for hotplug it's up to QEMU */
> > +    _FDT(fdt_setprop_string(fdt, *fdt_start_offset, "name", "pci"));
> > +
> > +    return 0;
> > +}
> > +
> > +static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceStat=
e *dev,
> > +                               Error **errp)
> > +{
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
> > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > +    const unsigned windows_supported =3D spapr_phb_windows_supported(s=
phb);
> > +
> > +    if (sphb->index =3D=3D (uint32_t)-1) {
> > +        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * This will check that sphb->index doesn't exceed the maximum num=
ber of
> > +     * PHBs for the current machine type.
> > +     */
> > +    smc->phb_placement(spapr, sphb->index,
> > +                       &sphb->buid, &sphb->io_win_addr,
> > +                       &sphb->mem_win_addr, &sphb->mem64_win_addr,
> > +                       windows_supported, sphb->dma_liobn, errp);
> > +}
> > +
> > +static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *d=
ev,
> > +                           Error **errp)
> > +{
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > +    sPAPRDRConnector *drc;
> > +    bool hotplugged =3D spapr_drc_hotplugged(dev);
> > +    Error *local_err =3D NULL;
> > +
> > +    if (!smc->dr_phb_enabled) {
> > +        return;
> > +    }
> > +
> > +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
> > +    /* hotplug hooks should check it's enabled before getting this far=
 */
> > +    assert(drc);
> > +
> > +    /*
> > +     * The FDT fragment will be added during the first invocation of R=
TAS
> > +     * ibm,client-architecture-support  for this device, when we're su=
re
> > +     * that the IOMMU is configured and that QEMU knows the phandle of=
 the
> > +     * interrupt controller.
> > +     */
> > +    spapr_drc_attach(drc, DEVICE(dev), NULL, 0, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    if (hotplugged) {
> > +        spapr_hotplug_req_add_by_index(drc);
> > +    } else {
> > +        spapr_drc_reset(drc);
> > +    }
> > +}
> > +
> > +void spapr_phb_release(DeviceState *dev)
> > +{
> > +    object_unparent(OBJECT(dev));
> > +}
> > +
> > +static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
> > +                                     DeviceState *dev, Error **errp)
> > +{
> > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > +    sPAPRDRConnector *drc;
> > +
> > +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
> > +    assert(drc);
> > +
> > +    if (!spapr_drc_unplug_requested(drc)) {
> > +        spapr_drc_detach(drc);
> > +        spapr_hotplug_req_remove_by_index(drc);
> > +    }
> > +}
> > +
> >  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
> >                                        DeviceState *dev, Error **errp)
> >  {
> > @@ -3740,6 +3847,8 @@ static void spapr_machine_device_plug(HotplugHand=
ler *hotplug_dev,
> >          spapr_memory_plug(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> >          spapr_core_plug(hotplug_dev, dev, errp);
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BR=
IDGE)) {
> > +        spapr_phb_plug(hotplug_dev, dev, errp);
> >      }
> >  }
> > =20
> > @@ -3758,6 +3867,7 @@ static void spapr_machine_device_unplug_request(H=
otplugHandler *hotplug_dev,
> >  {
> >      sPAPRMachineState *sms =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
> >      MachineClass *mc =3D MACHINE_GET_CLASS(sms);
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > =20
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >          if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> > @@ -3777,6 +3887,12 @@ static void spapr_machine_device_unplug_request(=
HotplugHandler *hotplug_dev,
> >              return;
> >          }
> >          spapr_core_unplug_request(hotplug_dev, dev, errp);
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BR=
IDGE)) {
> > +        if (!smc->dr_phb_enabled) {
> > +            error_setg(errp, "PHB hot unplug not supported on this mac=
hine");
> > +            return;
> > +        }
> > +        spapr_phb_unplug_request(hotplug_dev, dev, errp);
> >      }
> >  }
> > =20
> > @@ -3787,6 +3903,8 @@ static void spapr_machine_device_pre_plug(Hotplug=
Handler *hotplug_dev,
> >          spapr_memory_pre_plug(hotplug_dev, dev, errp);
> >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> >          spapr_core_pre_plug(hotplug_dev, dev, errp);
> > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BR=
IDGE)) {
> > +        spapr_phb_pre_plug(hotplug_dev, dev, errp);
> >      }
> >  }
> > =20
> > @@ -3794,7 +3912,8 @@ static HotplugHandler *spapr_get_hotplug_handler(=
MachineState *machine,
> >                                                   DeviceState *dev)
> >  {
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> > -        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> > +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE) ||
> > +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
> >          return HOTPLUG_HANDLER(machine);
> >      }
> >      return NULL;
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index c5a281915665..22563a381a37 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -709,6 +709,8 @@ static void spapr_drc_phb_class_init(ObjectClass *k=
, void *data)
> >      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
> >      drck->typename =3D "PHB";
> >      drck->drc_name_prefix =3D "PHB ";
> > +    drck->release =3D spapr_phb_release;
> > +    drck->populate_dt =3D spapr_dt_phb;
> >  }
> > =20
> >  static const TypeInfo spapr_dr_connector_info =3D {
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 7df7f6502f93..d0caca627455 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1647,21 +1647,7 @@ static void spapr_phb_realize(DeviceState *dev, =
Error **errp)
> >          return;
> >      }
> > =20
> > -    if (sphb->index !=3D (uint32_t)-1) {
> > -        Error *local_err =3D NULL;
> > -
> > -        smc->phb_placement(spapr, sphb->index,
> > -                           &sphb->buid, &sphb->io_win_addr,
> > -                           &sphb->mem_win_addr, &sphb->mem64_win_addr,
> > -                           windows_supported, sphb->dma_liobn, &local_=
err);
> > -        if (local_err) {
> > -            error_propagate(errp, local_err);
> > -            return;
> > -        }
> > -    } else {
> > -        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
> > -        return;
> > -    }
> > +    assert(sphb->index !=3D (uint32_t)-1); /* checked in spapr_phb_pre=
_plug() */
> > =20
> >      if (sphb->mem64_win_size !=3D 0) {
> >          if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index a3074e7fea37..69d9c2196ca2 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -764,9 +764,12 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr=
, int shift,
> >  void spapr_clear_pending_events(sPAPRMachineState *spapr);
> >  int spapr_max_server_number(sPAPRMachineState *spapr);
> > =20
> > -/* CPU and LMB DRC release callbacks. */
> > +/* DRC callbacks. */
> >  void spapr_core_release(DeviceState *dev);
> >  void spapr_lmb_release(DeviceState *dev);
> > +void spapr_phb_release(DeviceState *dev);
> > +int spapr_dt_phb(DeviceState *dev, sPAPRMachineState *spapr, void *fdt,
> > +                 int *fdt_start_offset, Error **errp);
> > =20
> >  void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
> >  int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
> >  =20
>=20


--Sig_/_XlV2Xw=LGidnLCh3Mdm2rp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlxkGnwACgkQcdTV5YIv
c9Zt1hAAtJK5KCZ7YWKFo65TPRcuy1gWMh6+9D5rUkrPi9UW93s3TApBoqqcR3Fv
+g62VX2InjgRc2AtpgZhr5Rwsl/PAMu5UhUvkjTdQom36id6c4RHwliF+uTG6kIw
gQt2NOFXxIc9qyMvYYJQey50gIrxCzBHbsGa/xG5qcfOgElyq483niPIRnx7iRvc
uMVg5T9trIsrT93g7ekvo2SdGJpJxnZdH9yO4yIkeVoa9nQhBRsdx4bB+la21YEx
P0WARPzzNAtvT4gvmUp16ZwQwD6Yk4CvNOieBvUyU6ctD7xvWr9s0OLDQd8jiRmh
HDhaG1B5OVv8WV2dEvEWmhrWi++3pJWbhtwfogLjdKnsiVLFmHZDNKcz3R4NqHVL
DiOA/Y83Tm+ytVFW3qy/YjeWRIccWwgi0oB6Uqih7Lw/85jiQmJmdU+8RK7tlHk4
vmTfxRWsRO/+VLwkOlZF9kWngp+8paz5e6oK9FcJciEwwZyqBbQDTnqJ2d7YgYHq
e222B1hN++uEBzRgByIj+1lNqRsehqlqrGFKhM3RyJYQlTsmU4Qw67QyXZpVK7GB
jxiFsNBPE9qcfyktzX7G+ZiyGSAYi69GrBZhKpcUlKRkvaTIo5v7aBHimZgxGu7S
I3UkWVJwOvDLYOBIDAX8agxIypxjxnFGNiGZBJmc6qMOPnTJSEI=
=BKBQ
-----END PGP SIGNATURE-----

--Sig_/_XlV2Xw=LGidnLCh3Mdm2rp--
