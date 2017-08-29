Received: from eggs.gnu.org ([2001:4830:134:3::10]:51218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeIA-0005q5-9X
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeI8-0001HB-Cs
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:46 -0400
Date: Tue, 29 Aug 2017 16:45:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170829064513.GI2578@umbus.fritz.box>
References: <20170825211119.474-1-danielhb@linux.vnet.ibm.com>
	<20170825211119.474-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G44BJl3Aq1QbV/QL"
Content-Disposition: inline
In-Reply-To: <20170825211119.474-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2] hw/ppc: CAS reset on early
 device hotplug
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


--G44BJl3Aq1QbV/QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 06:11:19PM -0300, Daniel Henrique Barboza wrote:
> This patch is a follow up on the discussions made in patch
> "hw/ppc: disable hotplug before CAS is completed" that can be
> found at [1].
>=20
> At this moment, we do not support CPU/memory hotplug in early
> boot stages, before CAS. When a hotplug occurs, the event is logged
> in an internal RTAS event log queue and an IRQ pulse is fired. In
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
> analysis would be necessary for LMBs and PCI devices. There are
> questions to be made in QEMU/SLOF/kernel level about how we can make
> this change in a sustainable way.
>=20
> Until we go all the way with the proper fix, this patch works around
> the situation by issuing a CAS reset if a hotplugged device is detected
> during CAS:
>=20
> - the DRC conditions that warrant a CAS reset is the same as those that
> triggers a DRC migration - the DRC must have a device attached and
> the DRC state is not equal to its ready_state. With that in mind, this
> patch makes use of 'spapr_drc_needed' to determine if a CAS reset
> is needed.
>=20
> - In the middle of CAS negotiations, the function
> 'spapr_hotplugged_dev_before_cas' goes through all the DRCs to see
> if there are any DRC that requires a reset, using spapr_drc_needed. If
> that happens, returns '1' in 'spapr_h_cas_compose_response' which will set
> spapr->cas_reboot to true, causing the machine to reboot.
>=20
> - a small fix was made in 'spapr_drc_needed' to change how we detect
> a DRC device. Using dr_entity_sense worked for physical DRCs but,
> for logical DRCs, it didn't cover the case where a logical DRC has
> a drc->dev but the state is LOGICAL_UNUSABLE (e.g. a hotplugged CPU before
> CAS). In this case, the dr_entity_sense of this DRC returns UNUSABLE and
> spapr_drc_needed was return 'false' for a scenario what we would like
> to migrate the DRC (or issue a CAS reset). Changing it to check for
> drc->dev instead works for all DRC types.
>=20
> - a new function called 'spapr_clear_pending_events' was created
> and is being called inside ppc_spapr_reset. This function clears
> the pending_events QTAILQ that holds the RTAS event logs. This prevents
> old/deprecated events from persisting after a reset.
>=20
> No changes are made for coldplug devices.
>=20
> [1] http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02855.html
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Sorry I've taken a while to review.

> ---
>  hw/ppc/spapr.c             | 34 ++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_drc.c         |  5 ++---
>  include/hw/ppc/spapr_drc.h |  1 +
>  3 files changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index fb1e5e0..4b23ad3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -790,6 +790,26 @@ out:
>      return ret;
>  }
> =20
> +static bool spapr_hotplugged_dev_before_cas(void)
> +{
> +    Object *drc_container, *obj;
> +    ObjectProperty *prop;
> +    ObjectPropertyIterator iter;
> +
> +    drc_container =3D container_get(object_get_root(), "/dr-connector");
> +    object_property_iter_init(&iter, drc_container);
> +    while ((prop =3D object_property_iter_next(&iter))) {
> +        if (!strstart(prop->type, "link<", NULL)) {
> +            continue;
> +        }
> +        obj =3D object_property_get_link(drc_container, prop->name, NULL=
);
> +        if (spapr_drc_needed(obj)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>  int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
>                                   target_ulong addr, target_ulong size,
>                                   sPAPROptionVector *ov5_updates)
> @@ -797,6 +817,10 @@ int spapr_h_cas_compose_response(sPAPRMachineState *=
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
> @@ -1369,6 +1393,15 @@ static void find_unknown_sysbus_device(SysBusDevic=
e *sbdev, void *opaque)
>      }
>  }
> =20
> +static void spapr_clear_pending_events(sPAPRMachineState *spapr)
> +{
> +    sPAPREventLogEntry *entry =3D NULL;
> +
> +    QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
> +        QTAILQ_REMOVE(&spapr->pending_events, entry, next);
> +    }
> +}

Ah.. unfortunately this isn't right.  You need to free each of the
events removed, as well as removing them from the list.  Since that
will require a respin anyway, can you make the following more minor
changes:
  * Move this helper function to spapr_events.c
  * Make this a preliminary patch - we should be clearing the queue at
    system reset even without the complicating case of eearly hotplug

>  static void ppc_spapr_reset(void)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
> @@ -1392,6 +1425,7 @@ static void ppc_spapr_reset(void)
>      }
> =20
>      qemu_devices_reset();
> +    spapr_clear_pending_events(spapr);
> =20
>      /*
>       * We place the device tree and RTAS just below either the top of th=
e RMA,
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 6541a52..915e9b5 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -460,14 +460,13 @@ static void drc_reset(void *opaque)
>      spapr_drc_reset(SPAPR_DR_CONNECTOR(opaque));
>  }
> =20
> -static bool spapr_drc_needed(void *opaque)
> +bool spapr_drc_needed(void *opaque)
>  {
>      sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
>      sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    sPAPRDREntitySense value =3D drck->dr_entity_sense(drc);
> =20
>      /* If no dev is plugged in there is no need to migrate the DRC state=
 */
> -    if (value !=3D SPAPR_DR_ENTITY_SENSE_PRESENT) {
> +    if (!drc->dev) {

Nice.  I'm not sure why on earth I did that weird indirect via
entity_sense in the first place.  Just using drc->dev is a much better
idea.
>          return false;
>      }
> =20
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index a7958d0..f8d9f5b 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -257,6 +257,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, =
Object *owner,
>  void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
>                        int fdt_start_offset, Error **errp);
>  void spapr_drc_detach(sPAPRDRConnector *drc);
> +bool spapr_drc_needed(void *opaque);
> =20
>  static inline bool spapr_drc_unplug_requested(sPAPRDRConnector *drc)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--G44BJl3Aq1QbV/QL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmlDXcACgkQbDjKyiDZ
s5LoXA//eIt+/PLxBdWptkJSkVc5hP+x5bi0tlKFEyMGFe2/93kQZFzYu+1Yqdj7
fj4OVFVHYFO9IYfwZmbtmOY0cxRuT7duz1QjkcI8PuqeyzwzhhW0Bkq75CcqN+y5
mTl5NlmGHRK4peombjBLC0SfULy6I2fiGrOV44gOeecYTlRCSRLEmqnspLE5r3Mu
/xazf3uA971VUEl1eQE3IiXfrubHsDFf8yP+7dkZrubhQJ72BABRrFewBWBAZktr
R0e7OK18JaxPgmNGgkgicJF79EWwS8LnDHMLWCmT0SX7A6aDKE4c9/JResBmjMZL
V1tFaoATPYM7/Xhox0aAWfyeP8krnt1ENF/mmUfbzR+uLUFc98mGEzb6Z55Vsg/c
7CRlcl31uHQyqNiM3qfj3o6vzs3pS7va73OKfI08kPaDV1TC7u6HeaqFTx5UDT8C
uGGUp/1UC11tZzF2ImCX/4OFn29mjmsI28sGGGFm4UurYUH10wdXMjncqeYD2HyS
VyyPrwjh0QNquaE3iBTpRhbDUuMNRXu5VPk9FdLIfH/ybRGZMYUbmz2pT6z4Z0Hi
kHI73oa8Un3/hvpd9drl+t7ruOszDOeAqEbthT0LYSkoqtcCztm0NlRjCFymVc8a
bUpNJdsscTDFBpEyExjxnfQnIMuKCwr+WQyy00z8YCxxYcedbAY=
=mOQA
-----END PGP SIGNATURE-----

--G44BJl3Aq1QbV/QL--
