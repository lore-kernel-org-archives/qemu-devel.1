Received: from eggs.gnu.org ([2001:4830:134:3::10]:38566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1danfH-0008Ci-Q2
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 14:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1danfC-0004sZ-La
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 14:37:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55237
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1danfC-0004s4-FC
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 14:37:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6RIY84J123405
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 14:37:32 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2byjwe7a2q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 14:37:32 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 27 Jul 2017 12:37:31 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170727190955.2792d785@bahia.lan>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150105840463.12000.9666180368681199673.stgit@bahia>
	<ac479056-e370-7083-bd9e-60d873baf2b4@ozlabs.ru>
	<20170727190955.2792d785@bahia.lan>
Date: Thu, 27 Jul 2017 13:37:24 -0500
Message-Id: <150118064456.26979.6912423000066856676@loki>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 26/26] spapr: add hotplug hooks
 for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

Quoting Greg Kurz (2017-07-27 12:09:55)
> On Thu, 27 Jul 2017 14:41:31 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> =

> > On 26/07/17 18:40, Greg Kurz wrote:
> > > Hotplugging PHBs is a machine-level operation, but PHBs reside on the
> > > main system bus, so we register spapr machine as the handler for the
> > > main system bus.
> > > =

> > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > > - rebased against ppc-for-2.10
> > > - converted to unplug_request
> > > - handle drc_id at pre-plug
> > > - reset hotplugged PHB at plug
> > > - compatibility with older machine types
> > > ---
> > >  hw/ppc/spapr.c              |  114 +++++++++++++++++++++++++++++++++=
++++++++++
> > >  hw/ppc/spapr_drc.c          |    1 =

> > >  hw/ppc/spapr_pci.c          |    2 -
> > >  include/hw/pci-host/spapr.h |    2 +
> > >  include/hw/ppc/spapr.h      |    1 =

> > >  5 files changed, 118 insertions(+), 2 deletions(-)
> > > =

> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 90485054c2e7..589f76ef9fb8 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2540,6 +2540,10 @@ static void ppc_spapr_init(MachineState *machi=
ne)
> > >      register_savevm_live(NULL, "spapr/htab", -1, 1,
> > >                           &savevm_htab_handlers, spapr);
> > >  =

> > > +    if (spapr->dr_phb_enabled) {
> > > +        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machin=
e), NULL);
> > > +    }
> > > +
> > >      qemu_register_boot_set(spapr_boot_set, spapr);
> > >  =

> > >      if (kvm_enabled()) {
> > > @@ -3238,6 +3242,103 @@ out:
> > >      error_propagate(errp, local_err);
> > >  }
> > >  =

> > > +static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceSt=
ate *dev,
> > > +                               Error **errp)
> > > +{
> > > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > > +
> > > +    if (sphb->drc_id =3D=3D (uint32_t)-1) {
> > > +        sphb->drc_id =3D sphb->index;
> > > +    }
> > > +
> > > +    if (sphb->drc_id >=3D SPAPR_DRC_MAX_PHB) {
> > > +        error_setg(errp, "PHB id %d out of range", sphb->drc_id);
> > > +    }  =

> > =

> > =

> > sphb->index in considered 16bits in the existing code (even though it is
> > defined as 32bit) and SPAPR_DRC_MAX_PHB is just 256. I'd suggest using =
the
> > same limit for both, either 256 or 65536 is fine for me.
> > =

> > It is actually a bit weird - it is possible to completely configure few
> > PHBs in the command line so they will have index=3D=3D-1 but PCI hotplu=
g code -
> > spapr_phb_get_pci_func_drc() and spapr_phb_realize() - does not check f=
or
> > this and just does (sphb->index << 16).
> =

> You're right and this looks like a bug... I'll try to come up with a fix.

Yup, that's a bug, and we can trigger it currently by adding 2
additional PHBs that don't have an index specified. QOM catches
and reports them as "attempt to add duplicate property", but it's
just reported by spapr_dr_connector_new() and doesn't seem to be
treated as fatal (and probably should be).

Might also see this more in practice now with the multi-phb support
in libvirt, though I'd imagine those would tend to rely on phb->index
being set.

Now that phb->drc_id is available though we can just use that instead.
I agree it should be limited to 16-bit or smaller to avoid any
possibility of overlap.

> =

> > May be just ditch drc_id, enforce index not to be -1 and use it as drc_=
id?
> > =

> =

> This was how Mike did it in the original patchset but David suggested
> to introduce drc_id (to preserve existing setups I guess):
> =

> http://patchwork.ozlabs.org/patch/466262/

Althrough IIRC what David proposed was to handle it like the other
properties which are filled in automatically when 'index' is specified,
i.e. 'drc_id' would be set automatically by 'index' if index is
specified, or we can set it explicitly if 'index' not specified, but
if we try to set both 'index' and 'drc_id' we trigger the "Either "index"
or other parameters must be specified for PAPR PHB, not both" error.

And it looks like 'index' is limited to 30, so it fits within our
16-bit limit for drc_id.

> =

> > =

> > =

> > > +}
> > > +
> > > +static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState =
*dev,
> > > +                           Error **errp)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
> > > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > > +    void *fdt =3D NULL;
> > > +    int fdt_start_offset;
> > > +    int fdt_size;
> > > +    Error *local_err =3D NULL;
> > > +    sPAPRDRConnector *drc;
> > > +    uint32_t phandle;
> > > +    int ret;
> > > +    bool hotplugged =3D spapr_drc_hotplugged(dev);
> > > +
> > > +    if (!spapr->dr_phb_enabled) {
> > > +        return;
> > > +    }
> > > +
> > > +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->drc_id);
> > > +    /* hotplug hooks should check it's enabled before getting this f=
ar */
> > > +    g_assert(drc);
> > > +
> > > +    if (hotplugged) {
> > > +        if (spapr->xics_phandle =3D=3D UINT32_MAX) {
> > > +            error_setg(&local_err,
> > > +                       "SLOF didn't update the XICS phandle. PHB hot=
plug cancelled");
> > > +            goto out;
> > > +        }
> > > +        phandle =3D spapr->xics_phandle;
> > > +
> > > +        spapr_phb_reset(dev);  =

> > =

> > =

> > It could be DEVICE_GET_CLASS(dev)->reset(dev) without exporting
> > spapr_phb_reset. Not sure how this fits into the current QEMU coding st=
yle
> > though.
> > =

> > =

> > =

> > > +    } else {
> > > +        phandle =3D PHANDLE_XICP;
> > > +    }
> > > +
> > > +    fdt =3D create_device_tree(&fdt_size);
> > > +    ret =3D spapr_populate_pci_dt(sphb, phandle, fdt, &fdt_start_off=
set);
> > > +    if (ret < 0) {
> > > +        error_setg(&local_err, "unable to create FDT for %sPHB",
> > > +                   dev->hotplugged ? "hotplugged " : "");
> > > +        goto out;
> > > +    }
> > > +
> > > +    if (hotplugged) {
> > > +        /* generally SLOF creates these, for hotplug it's up to QEMU=
 */
> > > +        _FDT(fdt_setprop_string(fdt, fdt_start_offset, "name", "pci"=
));
> > > +    }
> > > +
> > > +    spapr_drc_attach(drc, DEVICE(dev), fdt, fdt_start_offset, &local=
_err);
> > > +out:
> > > +    if (local_err) {
> > > +        error_propagate(errp, local_err);
> > > +        g_free(fdt);
> > > +        return;
> > > +    }
> > > +
> > > +    if (hotplugged) {
> > > +        spapr_hotplug_req_add_by_index(drc);
> > > +    } else if (drc) {
> > > +        spapr_drc_reset(drc);
> > > +    }
> > > +}
> > > +
> > > +void spapr_phb_release(DeviceState *dev)
> > > +{
> > > +    object_unparent(OBJECT(dev));
> > > +}
> > > +
> > > +static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
> > > +                                     DeviceState *dev, Error **errp)
> > > +{
> > > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > > +    sPAPRDRConnector *drc;
> > > +
> > > +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->drc_id);
> > > +    g_assert(drc);
> > > +
> > > +    if (!spapr_drc_unplug_requested(drc)) {
> > > +        spapr_drc_detach(drc);
> > > +        spapr_hotplug_req_remove_by_index(drc);
> > > +    }
> > > +}
> > > +
> > >  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
> > >                                        DeviceState *dev, Error **errp)
> > >  {
> > > @@ -3284,6 +3385,8 @@ static void spapr_machine_device_plug(HotplugHa=
ndler *hotplug_dev,
> > >          spapr_memory_plug(hotplug_dev, dev, node, errp);
> > >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)=
) {
> > >          spapr_core_plug(hotplug_dev, dev, errp);
> > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_=
BRIDGE)) {
> > > +        spapr_phb_plug(hotplug_dev, dev, errp);
> > >      }
> > >  }
> > >  =

> > > @@ -3311,6 +3414,12 @@ static void spapr_machine_device_unplug_reques=
t(HotplugHandler *hotplug_dev,
> > >              return;
> > >          }
> > >          spapr_core_unplug_request(hotplug_dev, dev, errp);
> > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_=
BRIDGE)) {
> > > +        if (sms->dr_phb_enabled) {
> > > +            spapr_phb_unplug_request(hotplug_dev, dev, errp);
> > > +        } else {
> > > +            error_setg(errp, "PHB hot unplug not supported on this m=
achine");
> > > +        }
> > >      }
> > >  }
> > >  =

> > > @@ -3321,6 +3430,8 @@ static void spapr_machine_device_pre_plug(Hotpl=
ugHandler *hotplug_dev,
> > >          spapr_memory_pre_plug(hotplug_dev, dev, errp);
> > >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)=
) {
> > >          spapr_core_pre_plug(hotplug_dev, dev, errp);
> > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_=
BRIDGE)) {
> > > +        spapr_phb_pre_plug(hotplug_dev, dev, errp);
> > >      }
> > >  }
> > >  =

> > > @@ -3328,7 +3439,8 @@ static HotplugHandler *spapr_get_hotplug_handle=
r(MachineState *machine,
> > >                                                   DeviceState *dev)
> > >  {
> > >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> > > -        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> > > +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE) ||
> > > +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)=
) {
> > >          return HOTPLUG_HANDLER(machine);
> > >      }
> > >      return NULL;
> > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > index 2e1049ce61c7..845fcf70b932 100644
> > > --- a/hw/ppc/spapr_drc.c
> > > +++ b/hw/ppc/spapr_drc.c
> > > @@ -704,6 +704,7 @@ static void spapr_drc_phb_class_init(ObjectClass =
*k, void *data)
> > >      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
> > >      drck->typename =3D "PHB";
> > >      drck->drc_name_prefix =3D "PHB ";
> > > +    drck->release =3D spapr_phb_release;
> > >  }
> > >  =

> > >  static const TypeInfo spapr_dr_connector_info =3D {
> > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > index 157867af8178..c12f71ae3e2d 100644
> > > --- a/hw/ppc/spapr_pci.c
> > > +++ b/hw/ppc/spapr_pci.c
> > > @@ -1833,7 +1833,7 @@ void spapr_phb_dma_reset(sPAPRPHBState *sphb)
> > >                             sphb->dma_win_size >> SPAPR_TCE_PAGE_SHIF=
T);
> > >  }
> > >  =

> > > -static void spapr_phb_reset(DeviceState *qdev)
> > > +void spapr_phb_reset(DeviceState *qdev)
> > >  {
> > >      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(qdev);
> > >  =

> > > diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> > > index 7837fb0b1110..15799cee4280 100644
> > > --- a/include/hw/pci-host/spapr.h
> > > +++ b/include/hw/pci-host/spapr.h
> > > @@ -120,6 +120,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
> > >  =

> > >  void spapr_pci_rtas_init(void);
> > >  =

> > > +void spapr_phb_reset(DeviceState *qdev);
> > > +
> > >  sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState *spapr, uint64_t=
 buid);
> > >  PCIDevice *spapr_pci_find_dev(sPAPRMachineState *spapr, uint64_t bui=
d,
> > >                                uint32_t config_addr);
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index f09c54d5bb94..a2f6782bdbbf 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -673,6 +673,7 @@ void spapr_reallocate_hpt(sPAPRMachineState *spap=
r, int shift,
> > >  /* CPU and LMB DRC release callbacks. */
> > >  void spapr_core_release(DeviceState *dev);
> > >  void spapr_lmb_release(DeviceState *dev);
> > > +void spapr_phb_release(DeviceState *dev);
> > >  =

> > >  void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
> > >  int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offse=
t);
> > > =

> > >   =

> > =

> > =

>=20
