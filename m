Received: from eggs.gnu.org ([2001:4830:134:3::10]:44582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFh-00084D-Pj
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFg-0003Qz-09
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:33 -0400
Date: Thu, 18 May 2017 14:29:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170518042941.GQ15596@umbus.fritz.box>
References: <20170515131052.23457-1-danielhb@linux.vnet.ibm.com>
	<20170515131052.23457-2-danielhb@linux.vnet.ibm.com>
	<149490520655.29340.6582819494653467488@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hSZb4FHl1C2xfsUy"
Content-Disposition: inline
In-Reply-To: <149490520655.29340.6582819494653467488@loki>
Subject: Re: [Qemu-devel] [PATCH v10] migration: spapr: migrate
 pending_events of spapr state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--hSZb4FHl1C2xfsUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 10:26:46PM -0500, Michael Roth wrote:
> Quoting Daniel Henrique Barboza (2017-05-15 08:10:52)
> > From: Jianjun Duan <duanj@linux.vnet.ibm.com>
> >=20
> > In racing situations between hotplug events and migration operation,
> > a rtas hotplug event could have not yet be delivered to the source
> > guest when migration is started. In this case the pending_events of
> > spapr state need be transmitted to the target so that the hotplug
> > event can be finished on the target.
> >=20
> > All the different fields of the events are encoded as defined by
> > PAPR. We can migrate them as uint8_t binary stream without any
> > concerns about data padding or endianess.
> >=20
> > pending_events is put in a subsection in the spapr state VMSD to make
> > sure migration across different versions is not broken.
> >=20
> > Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
> > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>=20
> I'd also be a little weary of treating this patch as totally standalone.
> There's pros/cons, but, without migrated DRC state, migrated hotplug
> events won't necessarilly be handled better than the current behavior of
> just dropping them.

True, but alone it should at least stop powerdown messages being lost
on migration, which is also possible AFAICT.

>=20
> > ---
> >  hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++++++++
> >  hw/ppc/spapr_events.c  | 24 +++++++++++++-----------
> >  include/hw/ppc/spapr.h |  3 ++-
> >  3 files changed, 48 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 80d12d0..8cfdc71 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1437,6 +1437,38 @@ static bool version_before_3(void *opaque, int v=
ersion_id)
> >      return version_id < 3;
> >  }
> >=20
> > +static bool spapr_pending_events_needed(void *opaque)
> > +{
> > +    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
> > +    return !QTAILQ_EMPTY(&spapr->pending_events);
> > +}
> > +
> > +static const VMStateDescription vmstate_spapr_event_entry =3D {
> > +    .name =3D "spapr_event_log_entry",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_INT32(log_type, sPAPREventLogEntry),
> > +        VMSTATE_BOOL(exception, sPAPREventLogEntry),
> > +        VMSTATE_UINT32(data_size, sPAPREventLogEntry),
> > +        VMSTATE_VARRAY_UINT32_ALLOC(data, sPAPREventLogEntry, data_siz=
e,
> > +                                    0, vmstate_info_uint8, uint8_t),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> > +static const VMStateDescription vmstate_spapr_pending_events =3D {
> > +    .name =3D "spapr_pending_events",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D spapr_pending_events_needed,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_QTAILQ_V(pending_events, sPAPRMachineState, 1,
> > +                         vmstate_spapr_event_entry, sPAPREventLogEntry=
, next),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> >  static bool spapr_ov5_cas_needed(void *opaque)
> >  {
> >      sPAPRMachineState *spapr =3D opaque;
> > @@ -1535,6 +1567,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
> >      .subsections =3D (const VMStateDescription*[]) {
> >          &vmstate_spapr_ov5_cas,
> >          &vmstate_spapr_patb_entry,
> > +        &vmstate_spapr_pending_events,
> >          NULL
> >      }
> >  };
> > diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > index f0b28d8..70c7cfc 100644
> > --- a/hw/ppc/spapr_events.c
> > +++ b/hw/ppc/spapr_events.c
> > @@ -342,7 +342,8 @@ static int rtas_event_log_to_irq(sPAPRMachineState =
*spapr, int log_type)
> >      return source->irq;
> >  }
> >=20
> > -static void rtas_event_log_queue(int log_type, void *data, bool except=
ion)
> > +static void rtas_event_log_queue(int log_type, void *data, bool except=
ion,
> > +                                 int data_size)
> >  {
> >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >      sPAPREventLogEntry *entry =3D g_new(sPAPREventLogEntry, 1);
> > @@ -351,6 +352,7 @@ static void rtas_event_log_queue(int log_type, void=
 *data, bool exception)
> >      entry->log_type =3D log_type;
> >      entry->exception =3D exception;
> >      entry->data =3D data;
> > +    entry->data_size =3D data_size;
> >      QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
> >  }
> >=20
> > @@ -445,6 +447,7 @@ static void spapr_powerdown_req(Notifier *n, void *=
opaque)
> >      struct rtas_event_log_v6_mainb *mainb;
> >      struct rtas_event_log_v6_epow *epow;
> >      struct epow_log_full *new_epow;
> > +    uint32_t data_size;
> >=20
> >      new_epow =3D g_malloc0(sizeof(*new_epow));
> >      hdr =3D &new_epow->hdr;
> > @@ -453,14 +456,13 @@ static void spapr_powerdown_req(Notifier *n, void=
 *opaque)
> >      mainb =3D &new_epow->mainb;
> >      epow =3D &new_epow->epow;
> >=20
> > +    data_size =3D sizeof(*new_epow);
> >      hdr->summary =3D cpu_to_be32(RTAS_LOG_VERSION_6
> >                                 | RTAS_LOG_SEVERITY_EVENT
> >                                 | RTAS_LOG_DISPOSITION_NOT_RECOVERED
> >                                 | RTAS_LOG_OPTIONAL_PART_PRESENT
> >                                 | RTAS_LOG_TYPE_EPOW);
> > -    hdr->extended_length =3D cpu_to_be32(sizeof(*new_epow)
> > -                                       - sizeof(new_epow->hdr));
> > -
> > +    hdr->extended_length =3D cpu_to_be32(data_size - sizeof(new_epow->=
hdr));
> >      spapr_init_v6hdr(v6hdr);
> >      spapr_init_maina(maina, 3 /* Main-A, Main-B and EPOW */);
> >=20
> > @@ -479,7 +481,7 @@ static void spapr_powerdown_req(Notifier *n, void *=
opaque)
> >      epow->event_modifier =3D RTAS_LOG_V6_EPOW_MODIFIER_NORMAL;
> >      epow->extended_modifier =3D RTAS_LOG_V6_EPOW_XMODIFIER_PARTITION_S=
PECIFIC;
> >=20
> > -    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true);
> > +    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true, data_size=
);
> >=20
> >      qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
> >                                   rtas_event_log_to_irq(spapr,
> > @@ -504,6 +506,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, =
uint8_t hp_action,
> >      struct rtas_event_log_v6_maina *maina;
> >      struct rtas_event_log_v6_mainb *mainb;
> >      struct rtas_event_log_v6_hp *hp;
> > +    uint32_t data_size;
> >=20
> >      new_hp =3D g_malloc0(sizeof(struct hp_log_full));
> >      hdr =3D &new_hp->hdr;
> > @@ -512,14 +515,14 @@ static void spapr_hotplug_req_event(uint8_t hp_id=
, uint8_t hp_action,
> >      mainb =3D &new_hp->mainb;
> >      hp =3D &new_hp->hp;
> >=20
> > +    data_size =3D sizeof(*new_hp);
> >      hdr->summary =3D cpu_to_be32(RTAS_LOG_VERSION_6
> >                                 | RTAS_LOG_SEVERITY_EVENT
> >                                 | RTAS_LOG_DISPOSITION_NOT_RECOVERED
> >                                 | RTAS_LOG_OPTIONAL_PART_PRESENT
> >                                 | RTAS_LOG_INITIATOR_HOTPLUG
> >                                 | RTAS_LOG_TYPE_HOTPLUG);
> > -    hdr->extended_length =3D cpu_to_be32(sizeof(*new_hp)
> > -                                       - sizeof(new_hp->hdr));
> > +    hdr->extended_length =3D cpu_to_be32(data_size - sizeof(new_hp->hd=
r));
> >=20
> >      spapr_init_v6hdr(v6hdr);
> >      spapr_init_maina(maina, 3 /* Main-A, Main-B, HP */);
> > @@ -572,7 +575,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, =
uint8_t hp_action,
> >              cpu_to_be32(drc_id->count_indexed.index);
> >      }
> >=20
> > -    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true);
> > +    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true, data_siz=
e);
> >=20
> >      qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
> >                                   rtas_event_log_to_irq(spapr,
> > @@ -671,8 +674,7 @@ static void check_exception(PowerPCCPU *cpu, sPAPRM=
achineState *spapr,
> >      if (!event) {
> >          goto out_no_events;
> >      }
> > -
> > -    hdr =3D event->data;
> > +    hdr =3D (struct rtas_error_log *)event->data;
> >      event_len =3D be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
> >=20
> >      if (event_len < len) {
> > @@ -728,7 +730,7 @@ static void event_scan(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
> >          goto out_no_events;
> >      }
> >=20
> > -    hdr =3D event->data;
> > +    hdr =3D (struct rtas_error_log *)event->data;
> >      event_len =3D be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
> >=20
> >      if (event_len < len) {
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 5802f88..fbe1d93 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -599,7 +599,8 @@ sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong=
 liobn);
> >  struct sPAPREventLogEntry {
> >      int log_type;
> >      bool exception;
> > -    void *data;
> > +    uint8_t *data;
> > +    uint32_t data_size;
> >      QTAILQ_ENTRY(sPAPREventLogEntry) next;
> >  };
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hSZb4FHl1C2xfsUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHSMzAAoJEGw4ysog2bOSu/QQAKeAdXVZrkIEhKIKPKYD4dkl
komnup/DVzPN1/v3yes4UvXOP++C+pAXMF18GwyCQLrJSoPRvq3085ZaNM4z7OnT
jkRLvQz6FzT1S4878P7/+yuA0HSYvQPtT6FoMsvaoJ4akm+za9/yIDN2iQ/slJdb
rNN+F8JexpYd0MSYLU4BVWBfOsQuGe/ZbWobV/TmOJxsK/Ooc4pIYvcNsyH01zW9
hRRcGRw4vAqt4nY9CMxkmd4wkDJMQWS9h/zAVJNfqP+K9tmd1GVdCFHGCtOPmL29
VOFIVE+r2D4Sj++PiimGkGZ7hy+IKjtqYa9hYU9LmKBvxLQbGdyOZJjcf+NVBUuM
7ZWmm/fF1XsxcL3lj9FjB43axMwPY1pasT5tL+d1BuJc7jang4zy7RhoyquMKOf4
JmZlKWN1WqxxYvZlpHSpV9NmqAndjStx4gLV+ZWbYsuWO/4325x9+CUDoUz6WEZ4
QBsOzI/msplMkswB3PZmC1CyAMgSdpjIBUqP0YnlMbQKrwOoLtqKrSqlnKSTLgQF
8tJWltTWhTzUncIJUSFKk/WszbC93OxcRpTgHFCX24mkHaEOmXofu7illthyyNd1
khb2Lc/c4ZJAAD+2gM3fQW4Gz5elt/j4HPe+oTbV3cpOsV8RP2PH3vr+B6K3eC4P
NO8GO6p52j8AzffQChaZ
=cqTT
-----END PGP SIGNATURE-----

--hSZb4FHl1C2xfsUy--
