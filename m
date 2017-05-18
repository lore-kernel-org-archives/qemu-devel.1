Received: from eggs.gnu.org ([2001:4830:134:3::10]:44602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFi-00084F-Ms
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dBEFf-0003Qg-Ln
	for qemu-devel@nongnu.org; Thu, 18 May 2017 01:45:34 -0400
Date: Thu, 18 May 2017 14:30:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170518043037.GR15596@umbus.fritz.box>
References: <20170515131052.23457-1-danielhb@linux.vnet.ibm.com>
	<20170515131052.23457-2-danielhb@linux.vnet.ibm.com>
	<20170516042501.GC30022@umbus.fritz.box>
	<a7f35543-18f9-f1d0-67e8-d1d3b3a20be8@linux.vnet.ibm.com>
	<b8f1d3bf-3656-802c-21c7-26de6146240a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ffBYM5qgR8HH9Mta"
Content-Disposition: inline
In-Reply-To: <b8f1d3bf-3656-802c-21c7-26de6146240a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v10] migration: spapr: migrate
 pending_events of spapr state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com


--ffBYM5qgR8HH9Mta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 05:31:44PM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 05/16/2017 09:04 AM, Daniel Henrique Barboza wrote:
> >=20
> >=20
> > On 05/16/2017 01:25 AM, David Gibson wrote:
> > > On Mon, May 15, 2017 at 10:10:52AM -0300, Daniel Henrique Barboza wro=
te:
> > > > From: Jianjun Duan <duanj@linux.vnet.ibm.com>
> > > >=20
> > > > In racing situations between hotplug events and migration operation,
> > > > a rtas hotplug event could have not yet be delivered to the source
> > > > guest when migration is started. In this case the pending_events of
> > > > spapr state need be transmitted to the target so that the hotplug
> > > > event can be finished on the target.
> > > >=20
> > > > All the different fields of the events are encoded as defined by
> > > > PAPR. We can migrate them as uint8_t binary stream without any
> > > > concerns about data padding or endianess.
> > > >=20
> > > > pending_events is put in a subsection in the spapr state VMSD to ma=
ke
> > > > sure migration across different versions is not broken.
> > > >=20
> > > > Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
> > > > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > > Ok, thanks for splitting this out, but you don't seem to have
> > > addressed the other comments I had on this patch as presented before.
> >=20
> > Sorry, I haven't noticed you had previous comments on this patch. I'll
> > address
> > them and re-send.
> >=20
> >=20
> > Daniel
> >=20
> > >=20
> > > > ---
> > > >   hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++++++++
> > > >   hw/ppc/spapr_events.c  | 24 +++++++++++++-----------
> > > >   include/hw/ppc/spapr.h |  3 ++-
> > > >   3 files changed, 48 insertions(+), 12 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 80d12d0..8cfdc71 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -1437,6 +1437,38 @@ static bool version_before_3(void
> > > > *opaque, int version_id)
> > > >       return version_id < 3;
> > > >   }
> > > >   +static bool spapr_pending_events_needed(void *opaque)
> > > > +{
> > > > +    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
> > > > +    return !QTAILQ_EMPTY(&spapr->pending_events);
> > > > +}
> > > > +
> > > > +static const VMStateDescription vmstate_spapr_event_entry =3D {
> > > > +    .name =3D "spapr_event_log_entry",
> > > > +    .version_id =3D 1,
> > > > +    .minimum_version_id =3D 1,
> > > > +    .fields =3D (VMStateField[]) {
> > > > +        VMSTATE_INT32(log_type, sPAPREventLogEntry),
> > > > +        VMSTATE_BOOL(exception, sPAPREventLogEntry),
> > > I'd like some more information to convince me there isn't redundant
> > > data here.
> I'll quote David's v9 review here for reference:
>=20
> "So, at the moment, AFAICT every event is marked as exception =3D=3D true,
> so this doesn't actually tell us anything.   If that becomes not the
> case in future, can the exception flag be derived from the log_type or
> information in the even buffer? "
>=20
> I've checked the code and we're just using exception =3D=3D true.  The two
> event logs that we currently support are RTAS_LOG_TYPE_EPOW and
> RTAS_LOG_TYPE_HOTPLUG, both are being added in the queue by
> calling rtas_event_log_queue() with exception =3D=3D true.
>=20
> This boolean is passed as a parameter in the functions
> rtas_event_log_contains
> and rtas_event_log_dequeue. The former is called once with exception=3Dtr=
ue
> inside check_exception, the latter is called once with exception=3Dtrue in
> check_exception
> and exception=3Dfalse in event_scan.
>=20
> I didn't find anywhere in the code where, once set as true, we change this
> boolean
> to false. So in my opinion we can discard this boolean from the migration
> and,
> in post_load, set it to true if log_type is RTAS_LOG_TYPE_EPOW or
> RTAS_LOG_TYPE_HOTPLUG. This would mean that when we implement more event
> log types we will need to also change the post_load to reflect the
> change.

This actually suggests we should just remove the exception flag as a
preliminary cleanup.

>=20
>=20
>=20
> PS: I've read the LoPAPR document [1] and it says in section 10.2.3 page
> 289:
>=20
> "Hot Plug Events, when implemented, are reported through the event-scan R=
TAS
> call."
>=20
> Why are we setting the RTAS_LOG_TYPE_HOTPLUG as exception=3D=3Dtrue and
> therefore
> reporting it in check_exception instead? Does the sPAPR spec differ from =
the
> LoPAPR
> in this regard?
>=20
> [1] https://openpowerfoundation.org/wp-content/uploads/2016/05/LoPAPR_DRA=
FT_v11_24March2016_cmt1.pdf
>=20
>=20
> Thanks,
>=20
> Daniel
>=20
> > > > +        VMSTATE_UINT32(data_size, sPAPREventLogEntry),
> > > > +        VMSTATE_VARRAY_UINT32_ALLOC(data, sPAPREventLogEntry,
> > > > data_size,
> > > > +                                    0, vmstate_info_uint8, uint8_t=
),
> > > And I think this should be VBUFFER rather than VARRAY to avoid the
> > > data type change.
> > >=20
> > > > +        VMSTATE_END_OF_LIST()
> > > > +    },
> > > > +};
> > > > +
> > > > +static const VMStateDescription vmstate_spapr_pending_events =3D {
> > > > +    .name =3D "spapr_pending_events",
> > > > +    .version_id =3D 1,
> > > > +    .minimum_version_id =3D 1,
> > > > +    .needed =3D spapr_pending_events_needed,
> > > > +    .fields =3D (VMStateField[]) {
> > > > +        VMSTATE_QTAILQ_V(pending_events, sPAPRMachineState, 1,
> > > > +                         vmstate_spapr_event_entry,
> > > > sPAPREventLogEntry, next),
> > > > +        VMSTATE_END_OF_LIST()
> > > > +    },
> > > > +};
> > > > +
> > > >   static bool spapr_ov5_cas_needed(void *opaque)
> > > >   {
> > > >       sPAPRMachineState *spapr =3D opaque;
> > > > @@ -1535,6 +1567,7 @@ static const VMStateDescription vmstate_spapr=
 =3D {
> > > >       .subsections =3D (const VMStateDescription*[]) {
> > > >           &vmstate_spapr_ov5_cas,
> > > >           &vmstate_spapr_patb_entry,
> > > > +        &vmstate_spapr_pending_events,
> > > >           NULL
> > > >       }
> > > >   };
> > > > diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > > > index f0b28d8..70c7cfc 100644
> > > > --- a/hw/ppc/spapr_events.c
> > > > +++ b/hw/ppc/spapr_events.c
> > > > @@ -342,7 +342,8 @@ static int
> > > > rtas_event_log_to_irq(sPAPRMachineState *spapr, int log_type)
> > > >       return source->irq;
> > > >   }
> > > >   -static void rtas_event_log_queue(int log_type, void *data,
> > > > bool exception)
> > > > +static void rtas_event_log_queue(int log_type, void *data, bool
> > > > exception,
> > >   +                                 int data_size)
> > >=20
> > > This could derive data_size from the header passed in.
> > >=20
> > > >   {
> > > >       sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine()=
);
> > > >       sPAPREventLogEntry *entry =3D g_new(sPAPREventLogEntry, 1);
> > > > @@ -351,6 +352,7 @@ static void rtas_event_log_queue(int
> > > > log_type, void *data, bool exception)
> > > >       entry->log_type =3D log_type;
> > > >       entry->exception =3D exception;
> > > >       entry->data =3D data;
> > > > +    entry->data_size =3D data_size;
> > > >       QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
> > > >   }
> > > >   @@ -445,6 +447,7 @@ static void spapr_powerdown_req(Notifier
> > > > *n, void *opaque)
> > > >       struct rtas_event_log_v6_mainb *mainb;
> > > >       struct rtas_event_log_v6_epow *epow;
> > > >       struct epow_log_full *new_epow;
> > > > +    uint32_t data_size;
> > > >         new_epow =3D g_malloc0(sizeof(*new_epow));
> > > >       hdr =3D &new_epow->hdr;
> > > > @@ -453,14 +456,13 @@ static void spapr_powerdown_req(Notifier
> > > > *n, void *opaque)
> > > >       mainb =3D &new_epow->mainb;
> > > >       epow =3D &new_epow->epow;
> > > >   +    data_size =3D sizeof(*new_epow);
> > > >       hdr->summary =3D cpu_to_be32(RTAS_LOG_VERSION_6
> > > >                                  | RTAS_LOG_SEVERITY_EVENT
> > > >                                  | RTAS_LOG_DISPOSITION_NOT_RECOVER=
ED
> > > >                                  | RTAS_LOG_OPTIONAL_PART_PRESENT
> > > >                                  | RTAS_LOG_TYPE_EPOW);
> > > > -    hdr->extended_length =3D cpu_to_be32(sizeof(*new_epow)
> > > > -                                       - sizeof(new_epow->hdr));
> > > > -
> > > > +    hdr->extended_length =3D cpu_to_be32(data_size -
> > > > sizeof(new_epow->hdr));
> > > >       spapr_init_v6hdr(v6hdr);
> > > >       spapr_init_maina(maina, 3 /* Main-A, Main-B and EPOW */);
> > > >   @@ -479,7 +481,7 @@ static void spapr_powerdown_req(Notifier
> > > > *n, void *opaque)
> > > >       epow->event_modifier =3D RTAS_LOG_V6_EPOW_MODIFIER_NORMAL;
> > > >       epow->extended_modifier =3D
> > > > RTAS_LOG_V6_EPOW_XMODIFIER_PARTITION_SPECIFIC;
> > > >   -    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true);
> > > > +    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true,
> > > > data_size);
> > > >         qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
> > > > rtas_event_log_to_irq(spapr,
> > > > @@ -504,6 +506,7 @@ static void spapr_hotplug_req_event(uint8_t
> > > > hp_id, uint8_t hp_action,
> > > >       struct rtas_event_log_v6_maina *maina;
> > > >       struct rtas_event_log_v6_mainb *mainb;
> > > >       struct rtas_event_log_v6_hp *hp;
> > > > +    uint32_t data_size;
> > > >         new_hp =3D g_malloc0(sizeof(struct hp_log_full));
> > > >       hdr =3D &new_hp->hdr;
> > > > @@ -512,14 +515,14 @@ static void
> > > > spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
> > > >       mainb =3D &new_hp->mainb;
> > > >       hp =3D &new_hp->hp;
> > > >   +    data_size =3D sizeof(*new_hp);
> > > >       hdr->summary =3D cpu_to_be32(RTAS_LOG_VERSION_6
> > > >                                  | RTAS_LOG_SEVERITY_EVENT
> > > >                                  | RTAS_LOG_DISPOSITION_NOT_RECOVER=
ED
> > > >                                  | RTAS_LOG_OPTIONAL_PART_PRESENT
> > > >                                  | RTAS_LOG_INITIATOR_HOTPLUG
> > > >                                  | RTAS_LOG_TYPE_HOTPLUG);
> > > > -    hdr->extended_length =3D cpu_to_be32(sizeof(*new_hp)
> > > > -                                       - sizeof(new_hp->hdr));
> > > > +    hdr->extended_length =3D cpu_to_be32(data_size -
> > > > sizeof(new_hp->hdr));
> > > >         spapr_init_v6hdr(v6hdr);
> > > >       spapr_init_maina(maina, 3 /* Main-A, Main-B, HP */);
> > > > @@ -572,7 +575,7 @@ static void spapr_hotplug_req_event(uint8_t
> > > > hp_id, uint8_t hp_action,
> > > >               cpu_to_be32(drc_id->count_indexed.index);
> > > >       }
> > > >   -    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true);
> > > > +    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true,
> > > > data_size);
> > > >         qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
> > > > rtas_event_log_to_irq(spapr,
> > > > @@ -671,8 +674,7 @@ static void check_exception(PowerPCCPU *cpu,
> > > > sPAPRMachineState *spapr,
> > > >       if (!event) {
> > > >           goto out_no_events;
> > > >       }
> > > > -
> > > > -    hdr =3D event->data;
> > > > +    hdr =3D (struct rtas_error_log *)event->data;
> > > >       event_len =3D be32_to_cpu(hdr->extended_length) + sizeof(*hdr=
);
> > > >         if (event_len < len) {
> > > > @@ -728,7 +730,7 @@ static void event_scan(PowerPCCPU *cpu,
> > > > sPAPRMachineState *spapr,
> > > >           goto out_no_events;
> > > >       }
> > > >   -    hdr =3D event->data;
> > > > +    hdr =3D (struct rtas_error_log *)event->data;
> > > >       event_len =3D be32_to_cpu(hdr->extended_length) + sizeof(*hdr=
);
> > > >         if (event_len < len) {
> > > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > > index 5802f88..fbe1d93 100644
> > > > --- a/include/hw/ppc/spapr.h
> > > > +++ b/include/hw/ppc/spapr.h
> > > > @@ -599,7 +599,8 @@ sPAPRTCETable
> > > > *spapr_tce_find_by_liobn(target_ulong liobn);
> > > >   struct sPAPREventLogEntry {
> > > >       int log_type;
> > > >       bool exception;
> > > > -    void *data;
> > > > +    uint8_t *data;
> > > > +    uint32_t data_size;
> > > >       QTAILQ_ENTRY(sPAPREventLogEntry) next;
> > > >   };
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ffBYM5qgR8HH9Mta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHSNtAAoJEGw4ysog2bOSUgkP/1vLZxHzFKFLVuvXTh7X7NwW
bUzUgHog+9icq5OnomuK1C5hXquIwyYv+0IiWS3hYPJIGcMSPfRAbMD7sKhs1KtO
/SaWlOeSNB57g+Qv98a6omIfOSY9cqZUXJTSCGF4IPDwGYDw14tYsgvORznmAADf
KMdAWVraDETIsTzCJo1Hy9tdGbshLMLaeeTSZDh+XHA5WmOHWU7URKnDSdFW9l7B
6cDXAd9nUssRBwQn2DsxTGFV97Va6J3onL/RQ8fRv1go9noo8sDK9z3jL2MMaNLO
OJ5jtSEG6tzHznKSvEPpD0FfvquE/JtPEPwKabv04BHIoM166Gz2y7NiszqVAxhZ
K527xl+WtTtpLi33re2JLhiVF8yJEYKrpIVJEe5I81kxolNK3AOVE2t7mqqzF2bZ
zs/cMGvORmj3uPNOHRSjMvJDtFxq2WtLVOpvSuZFyzwrG9JshwVHgPyKb3SRqzQs
NYjf30rPDE50624idcaqtRtSC9/tGG8aWU7gIoUwZu8N2ZIaZAff6+sjUiZdj/ZF
KZ8ssgZpWc6XOXWtAC58qGU4jhbVVZ0ADrvNhlGea4UWl1NaYqkuIV1jcbQ56YFu
3cQr20wkglQXQKpehQD+8CGooO5YGIcy1freTVHS/wK2OrXL/NBB9ip5xNPiOeiS
arP3Wde7E/T1jCOK/Lli
=jDKl
-----END PGP SIGNATURE-----

--ffBYM5qgR8HH9Mta--
