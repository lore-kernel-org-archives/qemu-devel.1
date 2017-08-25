Received: from eggs.gnu.org ([2001:4830:134:3::10]:51338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl8tu-0006Gj-14
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dl8tr-0004Uh-BI
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 03:19:30 -0400
Date: Fri, 25 Aug 2017 17:19:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825071917.GG2772@umbus.fritz.box>
References: <20170823205731.3325-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline
In-Reply-To: <20170823205731.3325-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: CAS reset on early device hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 05:57:31PM -0300, Daniel Henrique Barboza wrote:
> This patch is a follow up on the discussions made in patch
> "hw/ppc: disable hotplug before CAS is completed" that can be
> found at [1].
>=20
> At this moment, we do not support CPU/memory hotplug in early
> boot stages, before CAS. When a hotplug occurs, the event is logged
> in an internal rtas event log queue and an IRQ pulse is fired. In
> regular conditions, the guest handles the interrupt by executing
> check_exception, fetching the generated hotplug event and enabling
> the device for use.
>=20
> In early boot, this IRQ isn't caught (SLOF does not handle hotplug
> events), leaving the event in the rtas event log queue. If the guest
> executes check_exception due to another hotplug event, the re-assertion
> of the IRQ ends up de-queuing the first hotplug event as well. In short,
> a device hotplugged before CAS is considered coldplugged by SLOF.
> This leads to device misbehavior and, in some cases, guest kernel
> Ooops when trying to unplug the device.
>=20
> A proper fix would be to turn every device hotplugged before CAS
> as a colplugged device. This is not trivial to do with the current
> code base though - the FDT is written in the guest memory at
> ppc_spapr_reset and can't be retrieved without adding extra state
> (fdt_size for example) that will need to managed and migrated. Adding
> the hotplugged DT in the middle of CAS negotiation via the updated DT
> tree works with CPU devs, but panics the guest kernel at boot. Additional
> analysis would be necessary for LMBs and PCI devices. There are]
> questions to be made in QEMU/SLOF/kernel level about how we can make
> this change in a sustainable way.
>=20
> Until we go all the way with the proper fix, this patch works around
> the situation by issuing a CAS reset if a hotplugged device is detected
> during CAS negotiations:
>=20
> - 'spapr_cas_completed' is a helper function that is used in the 'plug'
> functions of CPU, LMB and PCI devices to inform if we are past CAS. If a
> device is hotplugged after CAS, no changes are made. Otherwise, we
> do not fire any hotplug event (it will be lost anyway) and no DRC changes
> are made, leaving the DRC in empty state.
>=20
> - In the middle of CAS negotiations, the function
> 'spapr_hotplugged_dev_before_cas' goes through all the DRCs to see
> if there are any DRC that belongs to a hotplugged dev and it has
> empty state. This matches the condition of a hotplugged device before
> CAS, returning '1' in 'spapr_h_cas_compose_response' which will set
> spapr->cas_reboot to true in 'h_client_architecture_support', causing
> the machine to reboot.
>=20
> - after reboot, the hotplugged devs DTs will be added in the base FDT
> tree by ppc_spapr_reset and will behave as expected.
>=20
> - no changes are made for coldplug devices. A colplug device is either
> a device that has dev->hotplugged =3D false or any device that was added
> in the INMIGRATE runstate.
>=20
> [1] http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02855.html

Sorry I've taken so long to review this.  I still think it's a good
approach, at least for the time being.  There are few things to
address in the details though.

> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c              | 72 +++++++++++++++++++++++++++++++++++++++=
++----
>  hw/ppc/spapr_ovec.c         |  7 +++++
>  hw/ppc/spapr_pci.c          | 10 ++++++-
>  include/hw/ppc/spapr.h      |  2 ++
>  include/hw/ppc/spapr_ovec.h |  1 +
>  5 files changed, 85 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cec441c..10faae3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -790,6 +790,31 @@ out:
>      return ret;
>  }
> =20
> +static bool spapr_hotplugged_dev_before_cas(void)
> +{
> +    Object *drc_container, *obj;
> +    ObjectProperty *prop;
> +    ObjectPropertyIterator iter;
> +    sPAPRDRConnector *drc;
> +    sPAPRDRConnectorClass *drck;
> +
> +    drc_container =3D container_get(object_get_root(), "/dr-connector");
> +    object_property_iter_init(&iter, drc_container);
> +    while ((prop =3D object_property_iter_next(&iter))) {
> +        if (!strstart(prop->type, "link<", NULL)) {
> +            continue;
> +        }
> +        obj =3D object_property_get_link(drc_container, prop->name, NULL=
);
> +        drc =3D SPAPR_DR_CONNECTOR(obj);
> +        drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> +        if (drc->dev && drc->dev->hotplugged &&

So, I don't think checking dev->hotplugged is actually useful here.
In fact, despite the name, it's rarely useful in hotplug state
management, at least for PAPR.

Basically we want to reset if there are any devices that aren't in
their "long term" state.  That's either no device and DRC in empty
state or there is a device and the DRC is in ready state.  We can
probably actually use the same helper for this as we do for detecting
DRCs that need migration (spapr_drc_needed).

> +                (drc->state =3D=3D drck->empty_state)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>  int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
>                                   target_ulong addr, target_ulong size,
>                                   sPAPROptionVector *ov5_updates)
> @@ -797,6 +822,10 @@ int spapr_h_cas_compose_response(sPAPRMachineState *=
spapr,
>      void *fdt, *fdt_skel;
>      sPAPRDeviceTreeUpdateHeader hdr =3D { .version_id =3D 1 };
> =20
> +    if (spapr_hotplugged_dev_before_cas()) {
> +        return 1;
> +    }
> +
>      size -=3D sizeof(hdr);
> =20
>      /* Create sceleton */
> @@ -2710,9 +2739,22 @@ static void spapr_nmi(NMIState *n, int cpu_index, =
Error **errp)
>      }
>  }
> =20
> +/*
> + * 'h_client_architecture_support' will set at least OV5_FORM1_AFFINITY
> + * in ov5_cas when intersecting it with spapr->ov5 and ov5_guest. It's s=
afe
> + * then to assume that CAS ov5_cas will have something set after CAS.
> + */
> +bool spapr_cas_completed(sPAPRMachineState *spapr)
> +{
> +    if (spapr->ov5_cas =3D=3D NULL) {
> +        return false;
> +    }
> +    return !spapr_ovec_is_unset(spapr->ov5_cas);
> +}

Yeah, I wish we'd devised a cleaner way of detecting that CAS was
complete when we did the big CAS rework.  This is as good as an
approach as we're going to be able to get, I think, it at least
doesn't introduce any new state variables.

>  static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64=
_t size,
>                             uint32_t node, bool dedicated_hp_event_source,
> -                           Error **errp)
> +                           sPAPRMachineState *spapr, Error **errp)
>  {
>      sPAPRDRConnector *drc;
>      uint32_t nr_lmbs =3D size/SPAPR_MEMORY_BLOCK_SIZE;
> @@ -2748,10 +2790,18 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
>          }
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>      }
> -    /* send hotplug notification to the
> -     * guest only in case of hotplugged memory
> +
> +    /*
> +     * Send hotplug notification interrupt to the guest only
> +     * in case of hotplugged memory.
> +     *
> +     * Before CAS, we don't know how to queue up events yet because
> +     * we don't know if the guest is able to handle HOTPLUG or
> +     * EPOW (see rtas_event_log_to_source). In this case, do
> +     * not queue up the event. The memory will be left in
> +     * the 'empty_state' and will trigger a CAS reboot later.
>       */
> -    if (hotplugged) {
> +    if (hotplugged && spapr_cas_completed(spapr)) {

I suppose it's better not to send the events if we haven't completed
CAS.  I don't think we actually need to stop them - as long as we
clear the queues at the reset (which we should already do) then it
doesn't really matter what we do before the CAS.

>          if (dedicated_hp_event_source) {
>              drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
>                                    addr_start / SPAPR_MEMORY_BLOCK_SIZE);
> @@ -2795,7 +2845,7 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
> =20
>      spapr_add_lmbs(dev, addr, size, node,
>                     spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> -                   &local_err);
> +                   ms, &local_err);
>      if (local_err) {
>          goto out_unplug;
>      }
> @@ -3113,8 +3163,18 @@ static void spapr_core_plug(HotplugHandler *hotplu=
g_dev, DeviceState *dev,
>              /*
>               * Send hotplug notification interrupt to the guest only
>               * in case of hotplugged CPUs.
> +             *
> +             * Before CAS, we don't know how to queue up events yet beca=
use
> +             * we don't know if the guest is able to handle HOTPLUG or
> +             * EPOW (see rtas_event_log_to_source). In this case, do
> +             * not queue up the event.
> +             *
> +             * A hotplugged CPU before CAS will trigger a CAS reboot
> +             * later on.
>               */
> -            spapr_hotplug_req_add_by_index(drc);
> +            if (spapr_cas_completed(spapr)) {
> +                spapr_hotplug_req_add_by_index(drc);

Blech, we can at least put the test for post-CAS in the DRC request
code, rather than having to check it for every DRC type.

> +            }
>          } else {
>              spapr_drc_reset(drc);
>          }
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> index 41df4c3..fe7bc85 100644
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -134,6 +134,13 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long bit=
nr)
>      return test_bit(bitnr, ov->bitmap) ? true : false;
>  }
> =20
> +bool spapr_ovec_is_unset(sPAPROptionVector *ov)
> +{
> +    unsigned long lastbit;
> +    lastbit =3D find_last_bit(ov->bitmap, OV_MAXBITS);
> +    return (lastbit =3D=3D OV_MAXBITS);
> +}
> +
>  static void guest_byte_to_bitmap(uint8_t entry, unsigned long *bitmap,
>                                   long bitmap_offset)
>  {
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index d84abf1..4dffa2f 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1440,10 +1440,18 @@ static void spapr_pci_plug(HotplugHandler *plug_h=
andler,
> =20
>      /* If this is function 0, signal hotplug for all the device function=
s.
>       * Otherwise defer sending the hotplug event.
> +     *
> +     * Before CAS, we don't know how to queue up events yet because
> +     * we don't know if the guest is able to handle HOTPLUG or
> +     * EPOW (see rtas_event_log_to_source). In this case, do
> +     * not queue up the event. The device will be left in
> +     * the 'empty_state' and will trigger a CAS reboot later.
> +     *
>       */
>      if (!spapr_drc_hotplugged(plugged_dev)) {
>          spapr_drc_reset(drc);
> -    } else if (PCI_FUNC(pdev->devfn) =3D=3D 0) {
> +    } else if (PCI_FUNC(pdev->devfn) =3D=3D 0 &&
> +            spapr_cas_completed(SPAPR_MACHINE(qdev_get_machine()))) {
>          int i;
> =20
>          for (i =3D 0; i < 8; i++) {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2a303a7..a2999d1 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -662,6 +662,8 @@ void spapr_cpu_parse_features(sPAPRMachineState *spap=
r);
>  int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
>  void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
>                            Error **errp);
> +bool spapr_cas_completed(sPAPRMachineState *spapr);
> +
> =20
>  /* CPU and LMB DRC release callbacks. */
>  void spapr_core_release(DeviceState *dev);
> diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
> index 9edfa5f..8126374 100644
> --- a/include/hw/ppc/spapr_ovec.h
> +++ b/include/hw/ppc/spapr_ovec.h
> @@ -71,6 +71,7 @@ void spapr_ovec_cleanup(sPAPROptionVector *ov);
>  void spapr_ovec_set(sPAPROptionVector *ov, long bitnr);
>  void spapr_ovec_clear(sPAPROptionVector *ov, long bitnr);
>  bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr);
> +bool spapr_ovec_is_unset(sPAPROptionVector *ov);
>  sPAPROptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int =
vector);
>  int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
>                             sPAPROptionVector *ov, const char *name);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmfz3MACgkQbDjKyiDZ
s5JNnRAAurIleV6HkHSeSn05v6jRQObKarrsNjsMZFhYmXGveL/b77tyGl/ZSf8d
x1446y3PCrGt9ermHale6lYAXv2j4ZbkWBbQOz9vwclfp4oFVseuFP1YajFfORQ1
UnpCkLTXb1K2GysRQiU5OHK7nUn/1mZma6tZ8xahZN+FwrLg04uEWl+ldBeFAYsc
wshMPLyskitRmGPf7hlEvPAC6TlrGLY4C1zBCh027T1fB5ynCLIYiaHTvnSYtjjr
FRGoTNhHYKjn1IayAKiNAHBJhMhN2X3YefBk6+qTu9+kFiSySpz0RYg/8BvSMaaC
KEQvkmgjSrFkCVVn+CY2B21cBv9KpAqKWZ41IS4x++zGPBGATVa2Eo0wsZtY99Dx
+n7XCk3gPAxr09p570Mt46fGUnzLi9l2SBBlZnvtQA6ONnSPUBwUMg/75jk+ftf+
MFvNT55tnzeaVh0IkFrKMcdk2FqWGaIkn5go2xejkxJnwXBMhydlgKEiZ/rzr8Wb
IYXLwJn2Fo5IGz5F7mfEmiJ8HW/tT+BrMi4ebbxHZ5WQtK4FMaHYkXiprCCJbYs8
XiU6Wp9C7IIP0tBVO8LObZClwrbKzaOs5vf9+4uKVJ39sXXPij1ITIHM6oKdohE+
+61pzOK4m58bYFEe3u6ZH5JjFoTIaxclKzU3MW6PhX1q4S9LZ5U=
=KGhF
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
