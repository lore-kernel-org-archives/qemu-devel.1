Received: from eggs.gnu.org ([209.51.188.92]:59932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvw-0003HX-Cp
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvt-0005D2-9K
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:04 -0500
Date: Wed, 13 Feb 2019 15:13:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213041307.GH1884@umbus.fritz.box>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999592549.690774.13071669609040970763.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u9wPhCK/rM6+CG+h"
Content-Disposition: inline
In-Reply-To: <154999592549.690774.13071669609040970763.stgit@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--u9wPhCK/rM6+CG+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 07:25:25PM +0100, Greg Kurz wrote:
> Hotplugging PHBs is a machine-level operation, but PHBs reside on the
> main system bus, so we register spapr machine as the handler for the
> main system bus.
>=20
> Provide the usual pre-plug, plug and unplug-request handlers.
>=20
> Move the checking of the PHB index to the pre-plug handler. It is okay
> to do that and assert in the realize function because the pre-plug
> handler is always called, even for the oldest machine types we support.
>=20
> Unlike with other device types, there are some cases where we cannot
> provide the FDT fragment of the PHB from the plug handler, eg, before
> KVMPPC_H_UPDATE_DT was called. Do this from a DRC callback that is
> called just before the first FDT fragment is exposed to the guest.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> (Fixed interrupt controller phandle in "interrupt-map" and
>  TCE table size in "ibm,dma-window" FDT fragment, Greg Kurz)
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v4: - populate FDT fragment in a DRC callback
> v3: - reworked phandle handling some more
> v2: - reworked phandle handling
>     - sync LSIs to KVM
> ---
> ---
>  hw/ppc/spapr.c         |  121 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/spapr_drc.c     |    2 +
>  hw/ppc/spapr_pci.c     |   16 ------
>  include/hw/ppc/spapr.h |    5 ++
>  4 files changed, 127 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 021758825b7e..06ce0babcb54 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2930,6 +2930,11 @@ static void spapr_machine_init(MachineState *machi=
ne)
>      register_savevm_live(NULL, "spapr/htab", -1, 1,
>                           &savevm_htab_handlers, spapr);
> =20
> +    if (smc->dr_phb_enabled) {
> +        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine),
> +                                 &error_fatal);
> +    }

I think you could do this unconditionally and just check
dr_phb_enabled at pre_plug.  That makes it more consistent with the
other hotplug types, and I suspect will give us better error messages.

>      qemu_register_boot_set(spapr_boot_set, spapr);
> =20
>      if (kvm_enabled()) {
> @@ -3733,6 +3738,108 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
> +int spapr_dt_phb(DeviceState *dev, sPAPRMachineState *spapr, void *fdt,
> +                 int *fdt_start_offset, Error **errp)
> +{
> +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> +    uint32_t intc_phandle;
> +
> +    if (spapr_irq_get_phandle(spapr, spapr->fdt_blob, &intc_phandle, err=
p)) {
> +        return -1;
> +    }
> +
> +    if (spapr_populate_pci_dt(sphb, intc_phandle, fdt, spapr->irq->nr_ms=
is,
> +                              fdt_start_offset)) {
> +        error_setg(errp, "unable to create FDT node for PHB %d", sphb->i=
ndex);
> +        return -1;
> +    }
> +
> +    /* generally SLOF creates these, for hotplug it's up to QEMU */
> +    _FDT(fdt_setprop_string(fdt, *fdt_start_offset, "name", "pci"));
> +
> +    return 0;
> +}
> +
> +static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState =
*dev,
> +                               Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
> +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +    const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
> +
> +    if (sphb->index =3D=3D (uint32_t)-1) {
> +        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
> +        return;
> +    }
> +
> +    /*
> +     * This will check that sphb->index doesn't exceed the maximum numbe=
r of
> +     * PHBs for the current machine type.
> +     */
> +    smc->phb_placement(spapr, sphb->index,
> +                       &sphb->buid, &sphb->io_win_addr,
> +                       &sphb->mem_win_addr, &sphb->mem64_win_addr,
> +                       windows_supported, sphb->dma_liobn, errp);
> +}
> +
> +static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                           Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> +    sPAPRDRConnector *drc;
> +    bool hotplugged =3D spapr_drc_hotplugged(dev);
> +    Error *local_err =3D NULL;
> +
> +    if (!smc->dr_phb_enabled) {
> +        return;
> +    }
> +
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
> +    /* hotplug hooks should check it's enabled before getting this far */
> +    assert(drc);
> +
> +    /*
> +     * The FDT fragment will be added during the first invocation of RTAS
> +     * ibm,client-architecture-support  for this device, when we're sure
> +     * that the IOMMU is configured and that QEMU knows the phandle of t=
he
> +     * interrupt controller.
> +     */
> +    spapr_drc_attach(drc, DEVICE(dev), NULL, 0, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (hotplugged) {
> +        spapr_hotplug_req_add_by_index(drc);
> +    } else {
> +        spapr_drc_reset(drc);
> +    }
> +}
> +
> +void spapr_phb_release(DeviceState *dev)
> +{
> +    object_unparent(OBJECT(dev));
> +}
> +
> +static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp)
> +{
> +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
> +    sPAPRDRConnector *drc;
> +
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
> +    assert(drc);
> +
> +    if (!spapr_drc_unplug_requested(drc)) {
> +        spapr_drc_detach(drc);
> +        spapr_hotplug_req_remove_by_index(drc);
> +    }
> +}
> +
>  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>                                        DeviceState *dev, Error **errp)
>  {
> @@ -3740,6 +3847,8 @@ static void spapr_machine_device_plug(HotplugHandle=
r *hotplug_dev,
>          spapr_memory_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>          spapr_core_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRID=
GE)) {
> +        spapr_phb_plug(hotplug_dev, dev, errp);
>      }
>  }
> =20
> @@ -3758,6 +3867,7 @@ static void spapr_machine_device_unplug_request(Hot=
plugHandler *hotplug_dev,
>  {
>      sPAPRMachineState *sms =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
>      MachineClass *mc =3D MACHINE_GET_CLASS(sms);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> =20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> @@ -3777,6 +3887,12 @@ static void spapr_machine_device_unplug_request(Ho=
tplugHandler *hotplug_dev,
>              return;
>          }
>          spapr_core_unplug_request(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRID=
GE)) {
> +        if (!smc->dr_phb_enabled) {
> +            error_setg(errp, "PHB hot unplug not supported on this machi=
ne");
> +            return;
> +        }
> +        spapr_phb_unplug_request(hotplug_dev, dev, errp);
>      }
>  }
> =20
> @@ -3787,6 +3903,8 @@ static void spapr_machine_device_pre_plug(HotplugHa=
ndler *hotplug_dev,
>          spapr_memory_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>          spapr_core_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRID=
GE)) {
> +        spapr_phb_pre_plug(hotplug_dev, dev, errp);
>      }
>  }
> =20
> @@ -3794,7 +3912,8 @@ static HotplugHandler *spapr_get_hotplug_handler(Ma=
chineState *machine,
>                                                   DeviceState *dev)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> -        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_PCI_HOST_BRIDGE)) {
>          return HOTPLUG_HANDLER(machine);
>      }
>      return NULL;
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index c5a281915665..22563a381a37 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -709,6 +709,8 @@ static void spapr_drc_phb_class_init(ObjectClass *k, =
void *data)
>      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
>      drck->typename =3D "PHB";
>      drck->drc_name_prefix =3D "PHB ";
> +    drck->release =3D spapr_phb_release;
> +    drck->populate_dt =3D spapr_dt_phb;
>  }
> =20
>  static const TypeInfo spapr_dr_connector_info =3D {
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 7df7f6502f93..d0caca627455 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1647,21 +1647,7 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>          return;
>      }
> =20
> -    if (sphb->index !=3D (uint32_t)-1) {
> -        Error *local_err =3D NULL;
> -
> -        smc->phb_placement(spapr, sphb->index,
> -                           &sphb->buid, &sphb->io_win_addr,
> -                           &sphb->mem_win_addr, &sphb->mem64_win_addr,
> -                           windows_supported, sphb->dma_liobn, &local_er=
r);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -    } else {
> -        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
> -        return;
> -    }
> +    assert(sphb->index !=3D (uint32_t)-1); /* checked in spapr_phb_pre_p=
lug() */
> =20
>      if (sphb->mem64_win_size !=3D 0) {
>          if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a3074e7fea37..69d9c2196ca2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -764,9 +764,12 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr, =
int shift,
>  void spapr_clear_pending_events(sPAPRMachineState *spapr);
>  int spapr_max_server_number(sPAPRMachineState *spapr);
> =20
> -/* CPU and LMB DRC release callbacks. */
> +/* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);
>  void spapr_lmb_release(DeviceState *dev);
> +void spapr_phb_release(DeviceState *dev);
> +int spapr_dt_phb(DeviceState *dev, sPAPRMachineState *spapr, void *fdt,
> +                 int *fdt_start_offset, Error **errp);
> =20
>  void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
>  int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u9wPhCK/rM6+CG+h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjmVMACgkQbDjKyiDZ
s5J3JA//Yqfgd2DVrCQoz8/DW9GpAf1P6/iKXQkUcRLtUcfMuMaGAwjedDzNBdTm
OyYzCFXeWvA4o98qp6nd8ntXZPZJAlXCN/GH5izM8zKbU6kbwkQeoqMKIe+Is+rZ
IhXhU0hsJxS6PnrCy4jLDkjAuE6PtVLuwb5vG8B1vm7jWcjS0dqCXKWHCTKVcuYj
W7tKTrKwiG1f2VeiPRnIE0qihGaxQAZHMZfcRzhaivG50hSLDRrTANDhrP55C3dd
rxN5/Sj0z5VKeuouzZSoH0mNHk3dyCJNz7Iijuf4IgRT9ZCBgvtmkk51ZwwJNxat
3t4ZznW1OumehJBeGnHKN4yhZjZrOuKPtxhREPxICoAebByqJRL+gInxq/wPkH1G
Xwf43+SSnwj9/6aj6604NloIINOPLPf2oKFjx+0TnquiELel92tFoPYyqFR+fq3q
vV0OAawE224NcOe9E8QIjERsQspv2vWdmPxiiIb7eAds+PukEZEbJH1P0lnBPO7Q
6FxM5PaJiLM4vsgDppmsUueZPT1MPAwxuNfO64UkQnE7msKw3sIJ84kHrUkZpGN/
hNrMjVbV4y5S+S1toE0lvHwcS3mjfRyu6R540juTR1eUL80bLFLi5eWtRKzkw3s6
ZEadQXtM9SdU8Y1+ugCeDCC/JfJfkT/ObtXjFLmz0CYM7SOm4d0=
=NTl3
-----END PGP SIGNATURE-----

--u9wPhCK/rM6+CG+h--
