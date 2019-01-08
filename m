Received: from eggs.gnu.org ([209.51.188.92]:39722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ggoT4-00010X-MO
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ggoT3-0002mY-8i
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:18:42 -0500
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:55156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ggoT2-0002iL-Vh
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:18:41 -0500
Received: from player750.ha.ovh.net (unknown [10.109.160.244])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 60F6A1C7A81
	for <qemu-devel@nongnu.org>; Tue,  8 Jan 2019 11:18:38 +0100 (CET)
Date: Tue, 8 Jan 2019 11:18:12 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190108111812.446b87a9@bahia.lan>
In-Reply-To: <20190103021702.GN10853@umbus.fritz.box>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154537417263.891798.7533381599337392867.stgit@bahia.lan>
	<20190103021702.GN10853@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/R9y/XgfXkofmW833fY0YOnf";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 15/15] spapr: add hotplug hooks for PHB
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

--Sig_/R9y/XgfXkofmW833fY0YOnf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Jan 2019 13:17:03 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Dec 21, 2018 at 07:36:12AM +0100, Greg Kurz wrote:
> > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> >=20
> > Hotplugging PHBs is a machine-level operation, but PHBs reside on the
> > main system bus, so we register spapr machine as the handler for the
> > main system bus.
> >=20
> > We re-get the phandle of the interrupt controller systematically for
> > simplicity.
> >=20
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c         |  147 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  hw/ppc/spapr_drc.c     |    1=20
> >  hw/ppc/spapr_pci.c     |   16 -----
> >  include/hw/ppc/spapr.h |    1=20
> >  4 files changed, 149 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 5c405a5fafca..065c9f19700e 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2923,6 +2923,10 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >      register_savevm_live(NULL, "spapr/htab", -1, 1,
> >                           &savevm_htab_handlers, spapr);
> > =20
> > +    if (smc->dr_phb_enabled) {
> > +        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine)=
, NULL);
> > +    }
> > +
> >      qemu_register_boot_set(spapr_boot_set, spapr);
> > =20
> >      if (kvm_enabled()) {
> > @@ -3716,6 +3720,135 @@ out:
> >      error_propagate(errp, local_err);
> >  }
> > =20
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
> > +    void *fdt =3D NULL;
> > +    int fdt_start_offset;
> > +    int fdt_size;
> > +    Error *local_err =3D NULL;
> > +    sPAPRDRConnector *drc;
> > +    int ret;
> > +    bool hotplugged =3D spapr_drc_hotplugged(dev);
> > +    int offset, phandle =3D 0;
> > +    gchar *nodename =3D NULL;
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
> > +    if (hotplugged) {
> > +        if (spapr->fdt_blob) {
> > +            /*
> > +             * SLOF might have pushed an updated FDT with new phandle =
values.
> > +             * Re-get the one of our interrupt controller.
> > +             */
> > +            nodename =3D spapr->irq->get_nodename(spapr);
> > +
> > +            offset =3D fdt_subnode_offset(spapr->fdt_blob, 0, nodename=
);
> > +            if (offset < 0) {
> > +                error_setg(errp, "Can't find node \"%s\": %s",
> > +                           nodename, fdt_strerror(offset));
> > +                goto out;
> > +            }
> > +
> > +            phandle =3D fdt_get_phandle(spapr->fdt_blob, offset);
> > +            if (phandle < 0) {
> > +                error_setg(errp, "Can't get phandle of node \"%s\": %s=
",
> > +                           nodename, fdt_strerror(offset));
> > +                goto out;
> > +            }
> > +        }
> > +        DEVICE_GET_CLASS(dev)->reset(dev);
> > +    }
> > +
> > +    /* For cold-plugged at initial boot and fallback for hotplug */
> > +    if (!phandle) {
> > +        phandle =3D PHANDLE_XICP;
> > +    }
> > +
> > +    fdt =3D create_device_tree(&fdt_size);
> > +    ret =3D spapr_populate_pci_dt(sphb, phandle, fdt, spapr->irq->nr_m=
sis,
> > +                                &fdt_start_offset);
> > +    if (ret < 0) {
> > +        error_setg(&local_err, "unable to create FDT for %sPHB",
> > +                   dev->hotplugged ? "hotplugged " : "");
> > +        goto out;
> > +    }
> > +
> > +    if (hotplugged) {
> > +        /* generally SLOF creates these, for hotplug it's up to QEMU */
> > +        _FDT(fdt_setprop_string(fdt, fdt_start_offset, "name", "pci"));
> > +    }
> > +
> > +    spapr_drc_attach(drc, DEVICE(dev), fdt, fdt_start_offset, &local_e=
rr);
> > +
> > +out:
> > +    g_free(nodename);
> > +
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        g_free(fdt);
> > +        return;
> > +    }
> > +
> > +    if (hotplugged) {
> > +        spapr_hotplug_req_add_by_index(drc);
> > +    } else if (drc) {
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
> > @@ -3723,6 +3856,8 @@ static void spapr_machine_device_plug(HotplugHand=
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
> > @@ -3741,6 +3876,7 @@ static void spapr_machine_device_unplug_request(H=
otplugHandler *hotplug_dev,
> >  {
> >      sPAPRMachineState *sms =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
> >      MachineClass *mc =3D MACHINE_GET_CLASS(sms);
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > =20
> >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >          if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> > @@ -3760,6 +3896,12 @@ static void spapr_machine_device_unplug_request(=
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
> > @@ -3770,6 +3912,8 @@ static void spapr_machine_device_pre_plug(Hotplug=
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
> > @@ -3777,7 +3921,8 @@ static HotplugHandler *spapr_get_hotplug_handler(=
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
> > index 189ee681062a..7a2676716364 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -703,6 +703,7 @@ static void spapr_drc_phb_class_init(ObjectClass *k=
, void *data)
> >      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
> >      drck->typename =3D "PHB";
> >      drck->drc_name_prefix =3D "PHB ";
> > +    drck->release =3D spapr_phb_release;
> >  }
> > =20
> >  static const TypeInfo spapr_dr_connector_info =3D {
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 688cca83ef2f..5bc912aa0028 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -1627,21 +1627,7 @@ static void spapr_phb_realize(DeviceState *dev, =
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
_plug() */ =20
>=20
> Could this cause an unexpected assert if you're using an older machine
> type that doesn't install the hotplug handler, then don't supply an
> index on the command line?
>=20

AFAICS all machine types do install the hotplug handler.

static void spapr_machine_class_init(ObjectClass *oc, void *data)
{
...
    HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
...
    hc->pre_plug =3D spapr_machine_device_pre_plug;
    hc->plug =3D spapr_machine_device_plug;

and so we get:

$ ppc64-softmmu/qemu-system-ppc64 -machine pseries-2.1 -device spapr-pci-ho=
st-bridge
qemu-system-ppc64: -device spapr-pci-host-bridge: "index" for PAPR PHB is m=
andatory

which is expected since we deliberately broke backward compatibility when we
made "index" mandatory (see commit 30b3bc5aa9f4 for details).

> >      if (sphb->mem64_win_size !=3D 0) {
> >          if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index e96deefa30de..eff479b0a019 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -764,6 +764,7 @@ int spapr_max_server_number(sPAPRMachineState *spap=
r);
> >  /* CPU and LMB DRC release callbacks. */
> >  void spapr_core_release(DeviceState *dev);
> >  void spapr_lmb_release(DeviceState *dev);
> > +void spapr_phb_release(DeviceState *dev);
> > =20
> >  void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
> >  int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
> >  =20
>=20


--Sig_/R9y/XgfXkofmW833fY0YOnf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlw0eOQACgkQcdTV5YIv
c9bEJg/+JITvcEjmMhDxD0BJ7LTccGUED18dfbxdIShgUqFsosau4N7UbEW0ZJVe
U4GOPxu1NgVZZrLn8/wy2/o0KG8+T243lHBG2vFl8N0vQFn87sEtsDJndYRdBQxw
+ASq/1kmgRjrVGfHBSCSn6bTH68YijL66s56iT0Q3d/uBV6rQCuTdbAvrauvMdmq
JUifuDo/uBaz/Wl/1/VI7/5LKC2YVvMknQh041vMb2LDSQkdSqyMNEW5C7CtIhsh
1T92uEuAqx9hdwNbE/MCOz0mLXvSeqZXpr6FdQu3dqGy5nXAvHSKJt+oR/d4wy+D
P33HfeLqYM2cY2lQV1lIX24R0gbSeXQ5xoR10el1Yykchr5fAdqFNCgzmAv50Vwd
dsck0XEwucsF943+1i7azpXehQBnrvQDe3v+IdYUcb3cjctiMsmrKsGJgztKzLFq
6nlXVNULdmnHBqgdDnJ3hQAVCCiKc6wvvngSzMdDegCrHhdUY5lLyXF22xw4aAgM
DFUEbDUfa83Mxs7tLNguAgCgoVesXj7vzZ+8h9C1U4GP542U5daIB3U4ro3LMrm/
9i/zRttCTh8xM4TA9mJfV5yjgCuaKOkrSaz2Cx1YzzKYqia6eLxT5gZw2IGS/hvt
H3UwXwrjhR9VC1l/mox+kbmRx64kZLmE46Ndy4MCunCnTaBKYKI=
=YbPE
-----END PGP SIGNATURE-----

--Sig_/R9y/XgfXkofmW833fY0YOnf--
