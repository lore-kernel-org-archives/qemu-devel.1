Received: from eggs.gnu.org ([208.118.235.92]:38380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZn-0002h7-1x
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZg-00059G-Fm
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:37 -0500
Date: Thu, 3 Jan 2019 13:17:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103021702.GN10853@umbus.fritz.box>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154537417263.891798.7533381599337392867.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hNG1vEeyG8BCaHbQ"
Content-Disposition: inline
In-Reply-To: <154537417263.891798.7533381599337392867.stgit@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>


--hNG1vEeyG8BCaHbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 07:36:12AM +0100, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> Hotplugging PHBs is a machine-level operation, but PHBs reside on the
> main system bus, so we register spapr machine as the handler for the
> main system bus.
>=20
> We re-get the phandle of the interrupt controller systematically for
> simplicity.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c         |  147 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/spapr_drc.c     |    1=20
>  hw/ppc/spapr_pci.c     |   16 -----
>  include/hw/ppc/spapr.h |    1=20
>  4 files changed, 149 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5c405a5fafca..065c9f19700e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2923,6 +2923,10 @@ static void spapr_machine_init(MachineState *machi=
ne)
>      register_savevm_live(NULL, "spapr/htab", -1, 1,
>                           &savevm_htab_handlers, spapr);
> =20
> +    if (smc->dr_phb_enabled) {
> +        qbus_set_hotplug_handler(sysbus_get_default(), OBJECT(machine), =
NULL);
> +    }
> +
>      qemu_register_boot_set(spapr_boot_set, spapr);
> =20
>      if (kvm_enabled()) {
> @@ -3716,6 +3720,135 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
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
> +    void *fdt =3D NULL;
> +    int fdt_start_offset;
> +    int fdt_size;
> +    Error *local_err =3D NULL;
> +    sPAPRDRConnector *drc;
> +    int ret;
> +    bool hotplugged =3D spapr_drc_hotplugged(dev);
> +    int offset, phandle =3D 0;
> +    gchar *nodename =3D NULL;
> +
> +    if (!smc->dr_phb_enabled) {
> +        return;
> +    }
> +
> +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
> +    /* hotplug hooks should check it's enabled before getting this far */
> +    assert(drc);
> +
> +    if (hotplugged) {
> +        if (spapr->fdt_blob) {
> +            /*
> +             * SLOF might have pushed an updated FDT with new phandle va=
lues.
> +             * Re-get the one of our interrupt controller.
> +             */
> +            nodename =3D spapr->irq->get_nodename(spapr);
> +
> +            offset =3D fdt_subnode_offset(spapr->fdt_blob, 0, nodename);
> +            if (offset < 0) {
> +                error_setg(errp, "Can't find node \"%s\": %s",
> +                           nodename, fdt_strerror(offset));
> +                goto out;
> +            }
> +
> +            phandle =3D fdt_get_phandle(spapr->fdt_blob, offset);
> +            if (phandle < 0) {
> +                error_setg(errp, "Can't get phandle of node \"%s\": %s",
> +                           nodename, fdt_strerror(offset));
> +                goto out;
> +            }
> +        }
> +        DEVICE_GET_CLASS(dev)->reset(dev);
> +    }
> +
> +    /* For cold-plugged at initial boot and fallback for hotplug */
> +    if (!phandle) {
> +        phandle =3D PHANDLE_XICP;
> +    }
> +
> +    fdt =3D create_device_tree(&fdt_size);
> +    ret =3D spapr_populate_pci_dt(sphb, phandle, fdt, spapr->irq->nr_msi=
s,
> +                                &fdt_start_offset);
> +    if (ret < 0) {
> +        error_setg(&local_err, "unable to create FDT for %sPHB",
> +                   dev->hotplugged ? "hotplugged " : "");
> +        goto out;
> +    }
> +
> +    if (hotplugged) {
> +        /* generally SLOF creates these, for hotplug it's up to QEMU */
> +        _FDT(fdt_setprop_string(fdt, fdt_start_offset, "name", "pci"));
> +    }
> +
> +    spapr_drc_attach(drc, DEVICE(dev), fdt, fdt_start_offset, &local_err=
);
> +
> +out:
> +    g_free(nodename);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        g_free(fdt);
> +        return;
> +    }
> +
> +    if (hotplugged) {
> +        spapr_hotplug_req_add_by_index(drc);
> +    } else if (drc) {
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
> @@ -3723,6 +3856,8 @@ static void spapr_machine_device_plug(HotplugHandle=
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
> @@ -3741,6 +3876,7 @@ static void spapr_machine_device_unplug_request(Hot=
plugHandler *hotplug_dev,
>  {
>      sPAPRMachineState *sms =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
>      MachineClass *mc =3D MACHINE_GET_CLASS(sms);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> =20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> @@ -3760,6 +3896,12 @@ static void spapr_machine_device_unplug_request(Ho=
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
> @@ -3770,6 +3912,8 @@ static void spapr_machine_device_pre_plug(HotplugHa=
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
> @@ -3777,7 +3921,8 @@ static HotplugHandler *spapr_get_hotplug_handler(Ma=
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
> index 189ee681062a..7a2676716364 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -703,6 +703,7 @@ static void spapr_drc_phb_class_init(ObjectClass *k, =
void *data)
>      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
>      drck->typename =3D "PHB";
>      drck->drc_name_prefix =3D "PHB ";
> +    drck->release =3D spapr_phb_release;
>  }
> =20
>  static const TypeInfo spapr_dr_connector_info =3D {
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 688cca83ef2f..5bc912aa0028 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1627,21 +1627,7 @@ static void spapr_phb_realize(DeviceState *dev, Er=
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

Could this cause an unexpected assert if you're using an older machine
type that doesn't install the hotplug handler, then don't supply an
index on the command line?

>      if (sphb->mem64_win_size !=3D 0) {
>          if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index e96deefa30de..eff479b0a019 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -764,6 +764,7 @@ int spapr_max_server_number(sPAPRMachineState *spapr);
>  /* CPU and LMB DRC release callbacks. */
>  void spapr_core_release(DeviceState *dev);
>  void spapr_lmb_release(DeviceState *dev);
> +void spapr_phb_release(DeviceState *dev);
> =20
>  void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
>  int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hNG1vEeyG8BCaHbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwtcJ4ACgkQbDjKyiDZ
s5JgxRAAj2GxR6uLJmY5IlMfjww6eDceKm6hOr/Vnop29XMGwrfhLqhhgzlB5491
0qt7z83ehkW1JZHhM0Vw6DBOpAFTHzvo7lHi3gkRyqvD8cY6cNtLKD64jM96GFRn
OmsvW+5fs7SkDlSJqdvPM0z2d0hCXFZSN436+3v8EHY9erhKKmbSagkxXfPcgKOR
S0hUac9LHYbXjpWTQPYDRISn9XE7MFVuBeL7YuRmIroz/Qph5U0t5hpEbjjxlvH3
bv3JRd6xVzzmEU7WjiEpSLQF9xXFk/07RBzs8CzpgyiP9tq/Lx++7wKAIpn1H9Ur
8xhTiCQ8VBFmdKbhsslgB0IUB+q2bGF+SfwuRkH/BdILBndcbWaIN7s2rTwakVhF
3c4b5cZ8KGZtfyDnf6pZwBLWBA5+RtRTgh7GtlIWzVXfySnPsPL0gDNeT2Etf6hM
/Ah4e78l0qk0+Qe+HjOMxbp8K90PRJyMhy2+HX1dYcX6Zg4XFUEB3JFPb5J+J2c9
XlaKCdKCQtckfqpcL5xJklgwwM2Qb5iL5oeae+p0tg1qGP2f6KXTl6Ho2LG0knVl
DmIyHiIUjEwUFfktaUmZYC3BPsu+fXCsApWZCE8fQlfwGDNt68bIYpiqVPlabn3L
v/7aHNSjE327n20IthUBGFlUuYvmYPh34qwGPBKgPROdWeT4ACY=
=jE4h
-----END PGP SIGNATURE-----

--hNG1vEeyG8BCaHbQ--
