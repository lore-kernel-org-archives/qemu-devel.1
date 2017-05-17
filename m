Received: from eggs.gnu.org ([2001:4830:134:3::10]:49335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dB1Sj-00051N-W5
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dB1Sf-0007zE-0R
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:06:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35943
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dB1Se-0007yq-Qn
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:06:04 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4HG45d0053312
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 12:06:03 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2agmcahp3d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 12:06:03 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 17 May 2017 10:06:02 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <149490496947.29340.9833975295117328739@loki>
References: <20170515131052.23457-1-danielhb@linux.vnet.ibm.com>
	<20170515131052.23457-2-danielhb@linux.vnet.ibm.com>
	<149490496947.29340.9833975295117328739@loki>
Date: Wed, 17 May 2017 11:05:51 -0500
Message-Id: <149503715179.29340.5697635678777596504@loki>
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
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Quoting Michael Roth (2017-05-15 22:22:49)
> Quoting Daniel Henrique Barboza (2017-05-15 08:10:52)
> > From: Jianjun Duan <duanj@linux.vnet.ibm.com>
> > =

> > In racing situations between hotplug events and migration operation,
> > a rtas hotplug event could have not yet be delivered to the source
> > guest when migration is started. In this case the pending_events of
> > spapr state need be transmitted to the target so that the hotplug
> > event can be finished on the target.
> > =

> > All the different fields of the events are encoded as defined by
> > PAPR. We can migrate them as uint8_t binary stream without any
> > concerns about data padding or endianess.
> > =

> > pending_events is put in a subsection in the spapr state VMSD to make
> > sure migration across different versions is not broken.
> > =

> > Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
> > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> =

> I think you might've missed some of the review comments David made in
> v9.

Please ignore, didn't realize I still had this sitting in my outgoing
queue.

> =

> > ---
> >  hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++++++++
> >  hw/ppc/spapr_events.c  | 24 +++++++++++++-----------
> >  include/hw/ppc/spapr.h |  3 ++-
> >  3 files changed, 48 insertions(+), 12 deletions(-)
> > =

> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 80d12d0..8cfdc71 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1437,6 +1437,38 @@ static bool version_before_3(void *opaque, int v=
ersion_id)
> >      return version_id < 3;
> >  }
> > =

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
> > =

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
> > =

> > @@ -445,6 +447,7 @@ static void spapr_powerdown_req(Notifier *n, void *=
opaque)
> >      struct rtas_event_log_v6_mainb *mainb;
> >      struct rtas_event_log_v6_epow *epow;
> >      struct epow_log_full *new_epow;
> > +    uint32_t data_size;
> > =

> >      new_epow =3D g_malloc0(sizeof(*new_epow));
> >      hdr =3D &new_epow->hdr;
> > @@ -453,14 +456,13 @@ static void spapr_powerdown_req(Notifier *n, void=
 *opaque)
> >      mainb =3D &new_epow->mainb;
> >      epow =3D &new_epow->epow;
> > =

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
> > =

> > @@ -479,7 +481,7 @@ static void spapr_powerdown_req(Notifier *n, void *=
opaque)
> >      epow->event_modifier =3D RTAS_LOG_V6_EPOW_MODIFIER_NORMAL;
> >      epow->extended_modifier =3D RTAS_LOG_V6_EPOW_XMODIFIER_PARTITION_S=
PECIFIC;
> > =

> > -    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true);
> > +    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true, data_size=
);
> > =

> >      qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
> >                                   rtas_event_log_to_irq(spapr,
> > @@ -504,6 +506,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, =
uint8_t hp_action,
> >      struct rtas_event_log_v6_maina *maina;
> >      struct rtas_event_log_v6_mainb *mainb;
> >      struct rtas_event_log_v6_hp *hp;
> > +    uint32_t data_size;
> > =

> >      new_hp =3D g_malloc0(sizeof(struct hp_log_full));
> >      hdr =3D &new_hp->hdr;
> > @@ -512,14 +515,14 @@ static void spapr_hotplug_req_event(uint8_t hp_id=
, uint8_t hp_action,
> >      mainb =3D &new_hp->mainb;
> >      hp =3D &new_hp->hp;
> > =

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
> > =

> >      spapr_init_v6hdr(v6hdr);
> >      spapr_init_maina(maina, 3 /* Main-A, Main-B, HP */);
> > @@ -572,7 +575,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, =
uint8_t hp_action,
> >              cpu_to_be32(drc_id->count_indexed.index);
> >      }
> > =

> > -    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true);
> > +    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true, data_siz=
e);
> > =

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
> > =

> >      if (event_len < len) {
> > @@ -728,7 +730,7 @@ static void event_scan(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
> >          goto out_no_events;
> >      }
> > =

> > -    hdr =3D event->data;
> > +    hdr =3D (struct rtas_error_log *)event->data;
> >      event_len =3D be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
> > =

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
> > =

> > -- =

> > 2.9.3
> >=20
