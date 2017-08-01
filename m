Received: from eggs.gnu.org ([2001:4830:134:3::10]:33758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcYeS-00039t-Kf
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcYeO-0006FE-Ba
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:00:04 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:46570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dcYeO-0006EF-0g
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:00:00 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 558F966DF0
	for <qemu-devel@nongnu.org>; Tue,  1 Aug 2017 16:59:58 +0200 (CEST)
Date: Tue, 1 Aug 2017 16:59:45 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170801165945.48addc90@bahia.lan>
In-Reply-To: <150118064456.26979.6912423000066856676@loki>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150105840463.12000.9666180368681199673.stgit@bahia>
	<ac479056-e370-7083-bd9e-60d873baf2b4@ozlabs.ru>
	<20170727190955.2792d785@bahia.lan>
	<150118064456.26979.6912423000066856676@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/QPSJ7B_oKuWlT061YaKQCNJ";
	protocol="application/pgp-signature"
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, "Michael S.
	Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/QPSJ7B_oKuWlT061YaKQCNJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Jul 2017 13:37:24 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Greg Kurz (2017-07-27 12:09:55)
> > On Thu, 27 Jul 2017 14:41:31 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >  =20
> > > On 26/07/17 18:40, Greg Kurz wrote: =20
> > > > Hotplugging PHBs is a machine-level operation, but PHBs reside on t=
he
> > > > main system bus, so we register spapr machine as the handler for the
> > > > main system bus.
> > > >=20
> > > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > > - rebased against ppc-for-2.10
> > > > - converted to unplug_request
> > > > - handle drc_id at pre-plug
> > > > - reset hotplugged PHB at plug
> > > > - compatibility with older machine types
> > > > ---
> > > >  hw/ppc/spapr.c              |  114 +++++++++++++++++++++++++++++++=
++++++++++++
> > > >  hw/ppc/spapr_drc.c          |    1=20
> > > >  hw/ppc/spapr_pci.c          |    2 -
> > > >  include/hw/pci-host/spapr.h |    2 +
> > > >  include/hw/ppc/spapr.h      |    1=20
> > > >  5 files changed, 118 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 90485054c2e7..589f76ef9fb8 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -2540,6 +2540,10 @@ static void ppc_spapr_init(MachineState *mac=
hine)
> > > >      register_savevm_live(NULL, "spapr/htab", -1, 1,
> > > >                           &savevm_htab_handlers, spapr);
> > > > =20
> > > > +    if (spapr->dr_phb_enabled) {
> > > > +        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(mach=
ine), NULL);
> > > > +    }
> > > > +
> > > >      qemu_register_boot_set(spapr_boot_set, spapr);
> > > > =20
> > > >      if (kvm_enabled()) {
> > > > @@ -3238,6 +3242,103 @@ out:
> > > >      error_propagate(errp, local_err);
> > > >  }
> > > > =20
> > > > +static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, Device=
State *dev,
> > > > +                               Error **errp)
> > > > +{
> > > > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > > > +
> > > > +    if (sphb->drc_id =3D=3D (uint32_t)-1) {
> > > > +        sphb->drc_id =3D sphb->index;
> > > > +    }
> > > > +
> > > > +    if (sphb->drc_id >=3D SPAPR_DRC_MAX_PHB) {
> > > > +        error_setg(errp, "PHB id %d out of range", sphb->drc_id);
> > > > +    }   =20
> > >=20
> > >=20
> > > sphb->index in considered 16bits in the existing code (even though it=
 is
> > > defined as 32bit) and SPAPR_DRC_MAX_PHB is just 256. I'd suggest usin=
g the
> > > same limit for both, either 256 or 65536 is fine for me.
> > >=20
> > > It is actually a bit weird - it is possible to completely configure f=
ew
> > > PHBs in the command line so they will have index=3D=3D-1 but PCI hotp=
lug code -
> > > spapr_phb_get_pci_func_drc() and spapr_phb_realize() - does not check=
 for
> > > this and just does (sphb->index << 16). =20
> >=20
> > You're right and this looks like a bug... I'll try to come up with a fi=
x. =20
>=20
> Yup, that's a bug, and we can trigger it currently by adding 2
> additional PHBs that don't have an index specified. QOM catches
> and reports them as "attempt to add duplicate property", but it's
> just reported by spapr_dr_connector_new() and doesn't seem to be
> treated as fatal (and probably should be).
>=20

Yeah, spapr_dr_connector_new() doesn't care for errors at all and
happily returns a pointer to an unrealized DRC. This causes weird
behavior. For example, when using mandatory props instead of index:

-device spapr-pci-host-bridge,id=3Dpci1,\
                              buid=3D0x800000020000001,\
                              liobn=3D0x80000100,\
                              liobn64=3D0x80000101,\
                              mem_win_addr=3D0x200100000000,\
                              mem64_win_addr=3D0x220000000000,\
                              io_win_addr=3D0x200000010000 \
-device spapr-pci-host-bridge,id=3Dpci2,\
                              buid=3D0x800000020000002,\
                              liobn=3D0x80000200,\
                              liobn64=3D0x80000201,\
                              mem_win_addr=3D0x200180000000,\
                              mem64_win_addr=3D0x230000000000,\
                              io_win_addr=3D0x200000020000 \
-device virtio-net,id=3Dhp1,bus=3Dpci1.0 \
-device virtio-net,id=3Dhp2,bus=3Dpci2.0=20

QEMU complains and exits:

qemu-system-ppc64: -device virtio-net,id=3Dhp2,bus=3Dpci2.0: an attached de=
vice
 is still awaiting release

> Might also see this more in practice now with the multi-phb support
> in libvirt, though I'd imagine those would tend to rely on phb->index
> being set.
>=20

I had confirmation from Shiva that libvirt passes the following to QEMU:

spapr-pci-host-bridge,index=3DX,id=3Dpci.X<,numa_node=3DZ>

> Now that phb->drc_id is available though we can just use that instead.
> I agree it should be limited to 16-bit or smaller to avoid any
> possibility of overlap.
>=20

Well, David changed his mind and now suggests we rather make index mandatory
instead of adding drc_id (even if it breaks existing setups that don't rely
on index).

> >  =20
> > > May be just ditch drc_id, enforce index not to be -1 and use it as dr=
c_id?
> > >  =20
> >=20
> > This was how Mike did it in the original patchset but David suggested
> > to introduce drc_id (to preserve existing setups I guess):
> >=20
> > http://patchwork.ozlabs.org/patch/466262/ =20
>=20
> Althrough IIRC what David proposed was to handle it like the other
> properties which are filled in automatically when 'index' is specified,
> i.e. 'drc_id' would be set automatically by 'index' if index is
> specified, or we can set it explicitly if 'index' not specified, but
> if we try to set both 'index' and 'drc_id' we trigger the "Either "index"
> or other parameters must be specified for PAPR PHB, not both" error.
>=20
> And it looks like 'index' is limited to 30, so it fits within our
> 16-bit limit for drc_id.
>=20
> >  =20
> > >=20
> > >  =20
> > > > +}
> > > > +
> > > > +static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceStat=
e *dev,
> > > > +                           Error **errp)
> > > > +{
> > > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev)=
);
> > > > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > > > +    void *fdt =3D NULL;
> > > > +    int fdt_start_offset;
> > > > +    int fdt_size;
> > > > +    Error *local_err =3D NULL;
> > > > +    sPAPRDRConnector *drc;
> > > > +    uint32_t phandle;
> > > > +    int ret;
> > > > +    bool hotplugged =3D spapr_drc_hotplugged(dev);
> > > > +
> > > > +    if (!spapr->dr_phb_enabled) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->drc_id);
> > > > +    /* hotplug hooks should check it's enabled before getting this=
 far */
> > > > +    g_assert(drc);
> > > > +
> > > > +    if (hotplugged) {
> > > > +        if (spapr->xics_phandle =3D=3D UINT32_MAX) {
> > > > +            error_setg(&local_err,
> > > > +                       "SLOF didn't update the XICS phandle. PHB h=
otplug cancelled");
> > > > +            goto out;
> > > > +        }
> > > > +        phandle =3D spapr->xics_phandle;
> > > > +
> > > > +        spapr_phb_reset(dev);   =20
> > >=20
> > >=20
> > > It could be DEVICE_GET_CLASS(dev)->reset(dev) without exporting
> > > spapr_phb_reset. Not sure how this fits into the current QEMU coding =
style
> > > though.
> > >=20
> > >=20
> > >  =20
> > > > +    } else {
> > > > +        phandle =3D PHANDLE_XICP;
> > > > +    }
> > > > +
> > > > +    fdt =3D create_device_tree(&fdt_size);
> > > > +    ret =3D spapr_populate_pci_dt(sphb, phandle, fdt, &fdt_start_o=
ffset);
> > > > +    if (ret < 0) {
> > > > +        error_setg(&local_err, "unable to create FDT for %sPHB",
> > > > +                   dev->hotplugged ? "hotplugged " : "");
> > > > +        goto out;
> > > > +    }
> > > > +
> > > > +    if (hotplugged) {
> > > > +        /* generally SLOF creates these, for hotplug it's up to QE=
MU */
> > > > +        _FDT(fdt_setprop_string(fdt, fdt_start_offset, "name", "pc=
i"));
> > > > +    }
> > > > +
> > > > +    spapr_drc_attach(drc, DEVICE(dev), fdt, fdt_start_offset, &loc=
al_err);
> > > > +out:
> > > > +    if (local_err) {
> > > > +        error_propagate(errp, local_err);
> > > > +        g_free(fdt);
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (hotplugged) {
> > > > +        spapr_hotplug_req_add_by_index(drc);
> > > > +    } else if (drc) {
> > > > +        spapr_drc_reset(drc);
> > > > +    }
> > > > +}
> > > > +
> > > > +void spapr_phb_release(DeviceState *dev)
> > > > +{
> > > > +    object_unparent(OBJECT(dev));
> > > > +}
> > > > +
> > > > +static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
> > > > +                                     DeviceState *dev, Error **err=
p)
> > > > +{
> > > > +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> > > > +    sPAPRDRConnector *drc;
> > > > +
> > > > +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->drc_id);
> > > > +    g_assert(drc);
> > > > +
> > > > +    if (!spapr_drc_unplug_requested(drc)) {
> > > > +        spapr_drc_detach(drc);
> > > > +        spapr_hotplug_req_remove_by_index(drc);
> > > > +    }
> > > > +}
> > > > +
> > > >  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
> > > >                                        DeviceState *dev, Error **er=
rp)
> > > >  {
> > > > @@ -3284,6 +3385,8 @@ static void spapr_machine_device_plug(Hotplug=
Handler *hotplug_dev,
> > > >          spapr_memory_plug(hotplug_dev, dev, node, errp);
> > > >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_COR=
E)) {
> > > >          spapr_core_plug(hotplug_dev, dev, errp);
> > > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOS=
T_BRIDGE)) {
> > > > +        spapr_phb_plug(hotplug_dev, dev, errp);
> > > >      }
> > > >  }
> > > > =20
> > > > @@ -3311,6 +3414,12 @@ static void spapr_machine_device_unplug_requ=
est(HotplugHandler *hotplug_dev,
> > > >              return;
> > > >          }
> > > >          spapr_core_unplug_request(hotplug_dev, dev, errp);
> > > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOS=
T_BRIDGE)) {
> > > > +        if (sms->dr_phb_enabled) {
> > > > +            spapr_phb_unplug_request(hotplug_dev, dev, errp);
> > > > +        } else {
> > > > +            error_setg(errp, "PHB hot unplug not supported on this=
 machine");
> > > > +        }
> > > >      }
> > > >  }
> > > > =20
> > > > @@ -3321,6 +3430,8 @@ static void spapr_machine_device_pre_plug(Hot=
plugHandler *hotplug_dev,
> > > >          spapr_memory_pre_plug(hotplug_dev, dev, errp);
> > > >      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_COR=
E)) {
> > > >          spapr_core_pre_plug(hotplug_dev, dev, errp);
> > > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOS=
T_BRIDGE)) {
> > > > +        spapr_phb_pre_plug(hotplug_dev, dev, errp);
> > > >      }
> > > >  }
> > > > =20
> > > > @@ -3328,7 +3439,8 @@ static HotplugHandler *spapr_get_hotplug_hand=
ler(MachineState *machine,
> > > >                                                   DeviceState *dev)
> > > >  {
> > > >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> > > > -        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> > > > +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE) ||
> > > > +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDG=
E)) {
> > > >          return HOTPLUG_HANDLER(machine);
> > > >      }
> > > >      return NULL;
> > > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > > index 2e1049ce61c7..845fcf70b932 100644
> > > > --- a/hw/ppc/spapr_drc.c
> > > > +++ b/hw/ppc/spapr_drc.c
> > > > @@ -704,6 +704,7 @@ static void spapr_drc_phb_class_init(ObjectClas=
s *k, void *data)
> > > >      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
> > > >      drck->typename =3D "PHB";
> > > >      drck->drc_name_prefix =3D "PHB ";
> > > > +    drck->release =3D spapr_phb_release;
> > > >  }
> > > > =20
> > > >  static const TypeInfo spapr_dr_connector_info =3D {
> > > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > > index 157867af8178..c12f71ae3e2d 100644
> > > > --- a/hw/ppc/spapr_pci.c
> > > > +++ b/hw/ppc/spapr_pci.c
> > > > @@ -1833,7 +1833,7 @@ void spapr_phb_dma_reset(sPAPRPHBState *sphb)
> > > >                             sphb->dma_win_size >> SPAPR_TCE_PAGE_SH=
IFT);
> > > >  }
> > > > =20
> > > > -static void spapr_phb_reset(DeviceState *qdev)
> > > > +void spapr_phb_reset(DeviceState *qdev)
> > > >  {
> > > >      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(qdev);
> > > > =20
> > > > diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spap=
r.h
> > > > index 7837fb0b1110..15799cee4280 100644
> > > > --- a/include/hw/pci-host/spapr.h
> > > > +++ b/include/hw/pci-host/spapr.h
> > > > @@ -120,6 +120,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
> > > > =20
> > > >  void spapr_pci_rtas_init(void);
> > > > =20
> > > > +void spapr_phb_reset(DeviceState *qdev);
> > > > +
> > > >  sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState *spapr, uint64=
_t buid);
> > > >  PCIDevice *spapr_pci_find_dev(sPAPRMachineState *spapr, uint64_t b=
uid,
> > > >                                uint32_t config_addr);
> > > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > > index f09c54d5bb94..a2f6782bdbbf 100644
> > > > --- a/include/hw/ppc/spapr.h
> > > > +++ b/include/hw/ppc/spapr.h
> > > > @@ -673,6 +673,7 @@ void spapr_reallocate_hpt(sPAPRMachineState *sp=
apr, int shift,
> > > >  /* CPU and LMB DRC release callbacks. */
> > > >  void spapr_core_release(DeviceState *dev);
> > > >  void spapr_lmb_release(DeviceState *dev);
> > > > +void spapr_phb_release(DeviceState *dev);
> > > > =20
> > > >  void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *n=
s);
> > > >  int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_off=
set);
> > > >=20
> > > >    =20
> > >=20
> > >  =20
> >  =20
>=20


--Sig_/QPSJ7B_oKuWlT061YaKQCNJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmAl2EACgkQAvw66wEB28La+ACgpurXuETQQkv+MhcM+WxQAPdL
YWwAn3jmD8gJeymgfvicwgOKXLmUCSkW
=xYlL
-----END PGP SIGNATURE-----

--Sig_/QPSJ7B_oKuWlT061YaKQCNJ--
