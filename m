Received: from eggs.gnu.org ([2001:4830:134:3::10]:33103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMtfw-0000Ul-66
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dMtfs-0003On-4F
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:12:52 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:40233)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dMtfr-0003MD-Q0
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:12:48 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 4B5954D9A6
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:12:45 +0200 (CEST)
Date: Mon, 19 Jun 2017 12:12:38 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170619121238.6e44414b@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170608050930.2613-3-david@gibson.dropbear.id.au>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
	<20170608050930.2613-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/iKRlq9=MVo80DIpIbbCL/q=";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 2/6] spapr: Eliminate DRC 'signalled' state
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/iKRlq9=MVo80DIpIbbCL/q=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  8 Jun 2017 15:09:26 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The 'signalled' field in the DRC appears to be entirely a torturous
> workaround for the fact that PCI devices were started in UNISOLATED state
> for unclear reasons.
>=20
> 1) 'signalled' is already meaningless for logical (so far, all non PCI)
> DRCs.  It's always set to true (at least at any point it might be tested),
> and can't be assigned any real meaning due to the way signalling works for
> logical DRCs.
>=20
> 2) For PCI DRCs, the only time signalled would be false is when non-zero
> functions of a multifunction device are hotplugged, followed by function
> zero (the other way around is explicitly not permitted). In that case the
> secondary function DRCs are attached, but the notification isn't sent to
> the guest until function 0 is plugged.
>=20
> 3) signalled being false is used to allow a DRC detach to switch mode
> back to ISOLATED state, which allows a secondary function to be hotplugged
> then unplugged with function 0 never inserted.  Without this a secondary
> function starting in UNISOLATED state couldn't be detached again without
> function 0 being inserted, all the functions configured by the guest, then
> sent back to ISOLATED state.
>=20
> 4) But now that PCI DRCs start in ISOLATED state, there's nothing to be
> done.  If the guest doesn't get the notification, it won't switch the
> device to UNISOLATED state, so nothing prevents it from being unplugged.
> If the guest does move it to UNISOLATED state without the signal (due to
> a manual drmgr call, for instance) then it really isn't safe to unplug it.
>=20
>=20
> So, this patch removes the signalled variable and all code related to it.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_drc.c         | 45 +---------------------------------------=
-----
>  hw/ppc/spapr_events.c      | 10 ----------
>  include/hw/ppc/spapr_drc.h |  2 --
>  3 files changed, 1 insertion(+), 56 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 6186f79..afd68f4 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -183,12 +183,6 @@ static const char *spapr_drc_name(sPAPRDRConnector *=
drc)
>      return g_strdup_printf("%s%d", drck->drc_name_prefix, drc->id);
>  }
> =20
> -/* has the guest been notified of device attachment? */
> -static void set_signalled(sPAPRDRConnector *drc)
> -{
> -    drc->signalled =3D true;
> -}
> -
>  /*
>   * dr-entity-sense sensor value
>   * returned via get-sensor-state RTAS calls
> @@ -321,17 +315,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceS=
tate *d, void *fdt,
>      drc->fdt =3D fdt;
>      drc->fdt_start_offset =3D fdt_start_offset;
>      drc->configured =3D coldplug;
> -    /* 'logical' DR resources such as memory/cpus are in some cases trea=
ted
> -     * as a pool of resources from which the guest is free to choose from
> -     * based on only a count. for resources that can be assigned in this
> -     * fashion, we must assume the resource is signalled immediately
> -     * since a single hotplug request might make an arbitrary number of
> -     * such attached resources available to the guest, as opposed to
> -     * 'physical' DR resources such as PCI where each device/resource is
> -     * signalled individually.
> -     */
> -    drc->signalled =3D (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE=
_PCI)
> -                     ? true : coldplug;
> =20
>      if (spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
>          drc->awaiting_allocation =3D true;
> @@ -347,26 +330,6 @@ void spapr_drc_detach(sPAPRDRConnector *drc, DeviceS=
tate *d, Error **errp)
>  {
>      trace_spapr_drc_detach(spapr_drc_index(drc));
> =20
> -    /* if we've signalled device presence to the guest, or if the guest
> -     * has gone ahead and configured the device (via manually-executed
> -     * device add via drmgr in guest, namely), we need to wait
> -     * for the guest to quiesce the device before completing detach.
> -     * Otherwise, we can assume the guest hasn't seen it and complete the
> -     * detach immediately. Note that there is a small race window
> -     * just before, or during, configuration, which is this context
> -     * refers mainly to fetching the device tree via RTAS.
> -     * During this window the device access will be arbitrated by
> -     * associated DRC, which will simply fail the RTAS calls as invalid.
> -     * This is recoverable within guest and current implementations of
> -     * drmgr should be able to cope.
> -     */
> -    if (!drc->signalled && !drc->configured) {
> -        /* if the guest hasn't seen the device we can't rely on it to
> -         * set it back to an isolated state via RTAS, so do it here manu=
ally
> -         */
> -        drc->isolation_state =3D SPAPR_DR_ISOLATION_STATE_ISOLATED;
> -    }
> -
>      if (drc->isolation_state !=3D SPAPR_DR_ISOLATION_STATE_ISOLATED) {
>          trace_spapr_drc_awaiting_isolated(spapr_drc_index(drc));
>          drc->awaiting_release =3D true;
> @@ -455,10 +418,6 @@ static void reset(DeviceState *d)
>              drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_UN=
USABLE);
>          }
>      }
> -
> -    if (drck->dr_entity_sense(drc) =3D=3D SPAPR_DR_ENTITY_SENSE_PRESENT)=
 {
> -        drck->set_signalled(drc);
> -    }
>  }
> =20
>  static bool spapr_drc_needed(void *opaque)
> @@ -483,7 +442,7 @@ static bool spapr_drc_needed(void *opaque)
>      case SPAPR_DR_CONNECTOR_TYPE_LMB:
>          rc =3D !((drc->isolation_state =3D=3D SPAPR_DR_ISOLATION_STATE_U=
NISOLATED) &&
>                 (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_U=
SABLE) &&
> -               drc->configured && drc->signalled && !drc->awaiting_relea=
se);
> +               drc->configured && !drc->awaiting_release);
>          break;
>      case SPAPR_DR_CONNECTOR_TYPE_PHB:
>      case SPAPR_DR_CONNECTOR_TYPE_VIO:
> @@ -505,7 +464,6 @@ static const VMStateDescription vmstate_spapr_drc =3D=
 {
>          VMSTATE_BOOL(configured, sPAPRDRConnector),
>          VMSTATE_BOOL(awaiting_release, sPAPRDRConnector),
>          VMSTATE_BOOL(awaiting_allocation, sPAPRDRConnector),
> -        VMSTATE_BOOL(signalled, sPAPRDRConnector),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -603,7 +561,6 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
>      drck->set_isolation_state =3D set_isolation_state;
>      drck->set_allocation_state =3D set_allocation_state;
>      drck->release_pending =3D release_pending;
> -    drck->set_signalled =3D set_signalled;
>      /*
>       * Reason: it crashes FIXME find and document the real reason
>       */
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 171aedc..587a3da 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -475,13 +475,6 @@ static void spapr_powerdown_req(Notifier *n, void *o=
paque)
>                                                         RTAS_LOG_TYPE_EPO=
W)));
>  }
> =20
> -static void spapr_hotplug_set_signalled(uint32_t drc_index)
> -{
> -    sPAPRDRConnector *drc =3D spapr_drc_by_index(drc_index);
> -    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    drck->set_signalled(drc);
> -}
> -
>  static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>                                      sPAPRDRConnectorType drc_type,
>                                      union drc_identifier *drc_id)
> @@ -528,9 +521,6 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
>      switch (drc_type) {
>      case SPAPR_DR_CONNECTOR_TYPE_PCI:
>          hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_PCI;
> -        if (hp->hotplug_action =3D=3D RTAS_LOG_V6_HP_ACTION_ADD) {
> -            spapr_hotplug_set_signalled(drc_id->index);
> -        }
>          break;
>      case SPAPR_DR_CONNECTOR_TYPE_LMB:
>          hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_MEMORY;
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index c487123..f24188d 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -199,7 +199,6 @@ typedef struct sPAPRDRConnector {
>      sPAPRConfigureConnectorState *ccs;
> =20
>      bool awaiting_release;
> -    bool signalled;
>      bool awaiting_allocation;
>      bool awaiting_allocation_skippable;
> =20
> @@ -226,7 +225,6 @@ typedef struct sPAPRDRConnectorClass {
> =20
>      /* QEMU interfaces for managing hotplug operations */
>      bool (*release_pending)(sPAPRDRConnector *drc);
> -    void (*set_signalled)(sPAPRDRConnector *drc);
>  } sPAPRDRConnectorClass;
> =20
>  uint32_t spapr_drc_index(sPAPRDRConnector *drc);


--Sig_/iKRlq9=MVo80DIpIbbCL/q=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllHo5YACgkQAvw66wEB28IQawCgmlqyVDXg4FcnCYzvjtTjoZCo
JU0An3Sz3a4OsuhpFPSlFlbAoWehihX3
=jJ/d
-----END PGP SIGNATURE-----

--Sig_/iKRlq9=MVo80DIpIbbCL/q=--
