Received: from eggs.gnu.org ([2001:4830:134:3::10]:43382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dBOZE-0007oT-9S
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dBOZ9-0000En-9b
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:46:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dBOZ8-0000CV-Vq
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:46:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4IGd3eb122980
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 12:46:17 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahd7pq3jp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 12:46:16 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 18 May 2017 12:46:15 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <b8f1d3bf-3656-802c-21c7-26de6146240a@linux.vnet.ibm.com>
References: <20170515131052.23457-1-danielhb@linux.vnet.ibm.com>
	<20170515131052.23457-2-danielhb@linux.vnet.ibm.com>
	<20170516042501.GC30022@umbus.fritz.box>
	<a7f35543-18f9-f1d0-67e8-d1d3b3a20be8@linux.vnet.ibm.com>
	<b8f1d3bf-3656-802c-21c7-26de6146240a@linux.vnet.ibm.com>
Date: Thu, 18 May 2017 11:46:08 -0500
Message-Id: <149512596881.29340.12338097735065415650@loki>
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
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Quoting Daniel Henrique Barboza (2017-05-17 15:31:44)
> =

> =

> On 05/16/2017 09:04 AM, Daniel Henrique Barboza wrote:
> >
> >
> > On 05/16/2017 01:25 AM, David Gibson wrote:
> >> On Mon, May 15, 2017 at 10:10:52AM -0300, Daniel Henrique Barboza wrot=
e:
> >>> From: Jianjun Duan <duanj@linux.vnet.ibm.com>
> >>>
> >>> In racing situations between hotplug events and migration operation,
> >>> a rtas hotplug event could have not yet be delivered to the source
> >>> guest when migration is started. In this case the pending_events of
> >>> spapr state need be transmitted to the target so that the hotplug
> >>> event can be finished on the target.
> >>>
> >>> All the different fields of the events are encoded as defined by
> >>> PAPR. We can migrate them as uint8_t binary stream without any
> >>> concerns about data padding or endianess.
> >>>
> >>> pending_events is put in a subsection in the spapr state VMSD to make
> >>> sure migration across different versions is not broken.
> >>>
> >>> Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
> >>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> >> Ok, thanks for splitting this out, but you don't seem to have
> >> addressed the other comments I had on this patch as presented before.
> >
> > Sorry, I haven't noticed you had previous comments on this patch. I'll =

> > address
> > them and re-send.
> >
> >
> > Daniel
> >
> >>
> >>> ---
> >>>   hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++++++++
> >>>   hw/ppc/spapr_events.c  | 24 +++++++++++++-----------
> >>>   include/hw/ppc/spapr.h |  3 ++-
> >>>   3 files changed, 48 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index 80d12d0..8cfdc71 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -1437,6 +1437,38 @@ static bool version_before_3(void *opaque, =

> >>> int version_id)
> >>>       return version_id < 3;
> >>>   }
> >>>   +static bool spapr_pending_events_needed(void *opaque)
> >>> +{
> >>> +    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
> >>> +    return !QTAILQ_EMPTY(&spapr->pending_events);
> >>> +}
> >>> +
> >>> +static const VMStateDescription vmstate_spapr_event_entry =3D {
> >>> +    .name =3D "spapr_event_log_entry",
> >>> +    .version_id =3D 1,
> >>> +    .minimum_version_id =3D 1,
> >>> +    .fields =3D (VMStateField[]) {
> >>> +        VMSTATE_INT32(log_type, sPAPREventLogEntry),
> >>> +        VMSTATE_BOOL(exception, sPAPREventLogEntry),
> >> I'd like some more information to convince me there isn't redundant
> >> data here.
> I'll quote David's v9 review here for reference:
> =

> "So, at the moment, AFAICT every event is marked as exception =3D=3D true,
> so this doesn't actually tell us anything.   If that becomes not the
> case in future, can the exception flag be derived from the log_type or
> information in the even buffer? "
> =

> I've checked the code and we're just using exception =3D=3D true.  The two
> event logs that we currently support are RTAS_LOG_TYPE_EPOW and
> RTAS_LOG_TYPE_HOTPLUG, both are being added in the queue by
> calling rtas_event_log_queue() with exception =3D=3D true.
> =

> This boolean is passed as a parameter in the functions =

> rtas_event_log_contains
> and rtas_event_log_dequeue. The former is called once with exception=3Dtr=
ue
> inside check_exception, the latter is called once with exception=3Dtrue i=
n =

> check_exception
> and exception=3Dfalse in event_scan.
> =

> I didn't find anywhere in the code where, once set as true, we change =

> this boolean
> to false. So in my opinion we can discard this boolean from the =

> migration and,
> in post_load, set it to true if log_type is RTAS_LOG_TYPE_EPOW or
> RTAS_LOG_TYPE_HOTPLUG. This would mean that when we implement more event
> log types we will need to also change the post_load to reflect the change.
> =

> =

> =

> PS: I've read the LoPAPR document [1] and it says in section 10.2.3 page =

> 289:
> =

> "Hot Plug Events, when implemented, are reported through the event-scan =

> RTAS call."
> =

> Why are we setting the RTAS_LOG_TYPE_HOTPLUG as exception=3D=3Dtrue and =

> therefore
> reporting it in check_exception instead? Does the sPAPR spec differ from =

> the LoPAPR
> in this regard?

Published versions of PAPR/LoPAPR are a bit behind on the current
documentation for hotplug (and a few other things). That section in
particular has been update to read:

  10.2.3 Hot Plug Events

  Hot Plug Events, when implemented, are reported through either the
  event-scan RTAS call or a hotplug interrupt.

  An OS that wants to be notified of hotplug events will need to set the
  appropriate arch-vector bit (XXX TBD) look for the
  hot-plug-events node in the /event-sources node of the OF device tree
  (see C.6.12.1.4), enable the interrupts listed in its
  =E2=80=9Cinterrupts=E2=80=9D property and provide an interrupt handler to=
 call
  check-exception when one of those interrupts are received.

  When a hotplug event occurs, whether reported by check-exception or
  event-scan, RTAS will directly pass back the Hotplug
  Event Log as described in Table XXX =E2=80=9CPlatform Event Log, Version =
6,
  Hotplug Section=E2=80=9D on page XXX.

Published documentation also lacks a description of the actual,
newly-added hotplug event format. A summary of that and most of the
other changes is included in:

  qemu.git/docs/specs/ppc-spapr-hotplug.txt

There's some work to get the changes published in LoPAPR but for now
that's probably the best reference.

> =

> [1] =

> https://openpowerfoundation.org/wp-content/uploads/2016/05/LoPAPR_DRAFT_v=
11_24March2016_cmt1.pdf
> =

> =

> Thanks,
> =

> Daniel
> =

> >>> +        VMSTATE_UINT32(data_size, sPAPREventLogEntry),
> >>> +        VMSTATE_VARRAY_UINT32_ALLOC(data, sPAPREventLogEntry, =

> >>> data_size,
> >>> +                                    0, vmstate_info_uint8, uint8_t),
> >> And I think this should be VBUFFER rather than VARRAY to avoid the
> >> data type change.
> >>
> >>> +        VMSTATE_END_OF_LIST()
> >>> +    },
> >>> +};
> >>> +
> >>> +static const VMStateDescription vmstate_spapr_pending_events =3D {
> >>> +    .name =3D "spapr_pending_events",
> >>> +    .version_id =3D 1,
> >>> +    .minimum_version_id =3D 1,
> >>> +    .needed =3D spapr_pending_events_needed,
> >>> +    .fields =3D (VMStateField[]) {
> >>> +        VMSTATE_QTAILQ_V(pending_events, sPAPRMachineState, 1,
> >>> +                         vmstate_spapr_event_entry, =

> >>> sPAPREventLogEntry, next),
> >>> +        VMSTATE_END_OF_LIST()
> >>> +    },
> >>> +};
> >>> +
> >>>   static bool spapr_ov5_cas_needed(void *opaque)
> >>>   {
> >>>       sPAPRMachineState *spapr =3D opaque;
> >>> @@ -1535,6 +1567,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
> >>>       .subsections =3D (const VMStateDescription*[]) {
> >>>           &vmstate_spapr_ov5_cas,
> >>>           &vmstate_spapr_patb_entry,
> >>> +        &vmstate_spapr_pending_events,
> >>>           NULL
> >>>       }
> >>>   };
> >>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> >>> index f0b28d8..70c7cfc 100644
> >>> --- a/hw/ppc/spapr_events.c
> >>> +++ b/hw/ppc/spapr_events.c
> >>> @@ -342,7 +342,8 @@ static int =

> >>> rtas_event_log_to_irq(sPAPRMachineState *spapr, int log_type)
> >>>       return source->irq;
> >>>   }
> >>>   -static void rtas_event_log_queue(int log_type, void *data, bool =

> >>> exception)
> >>> +static void rtas_event_log_queue(int log_type, void *data, bool =

> >>> exception,
> >>   +                                 int data_size)
> >>
> >> This could derive data_size from the header passed in.
> >>
> >>>   {
> >>>       sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >>>       sPAPREventLogEntry *entry =3D g_new(sPAPREventLogEntry, 1);
> >>> @@ -351,6 +352,7 @@ static void rtas_event_log_queue(int log_type, =

> >>> void *data, bool exception)
> >>>       entry->log_type =3D log_type;
> >>>       entry->exception =3D exception;
> >>>       entry->data =3D data;
> >>> +    entry->data_size =3D data_size;
> >>>       QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
> >>>   }
> >>>   @@ -445,6 +447,7 @@ static void spapr_powerdown_req(Notifier *n, =

> >>> void *opaque)
> >>>       struct rtas_event_log_v6_mainb *mainb;
> >>>       struct rtas_event_log_v6_epow *epow;
> >>>       struct epow_log_full *new_epow;
> >>> +    uint32_t data_size;
> >>>         new_epow =3D g_malloc0(sizeof(*new_epow));
> >>>       hdr =3D &new_epow->hdr;
> >>> @@ -453,14 +456,13 @@ static void spapr_powerdown_req(Notifier *n, =

> >>> void *opaque)
> >>>       mainb =3D &new_epow->mainb;
> >>>       epow =3D &new_epow->epow;
> >>>   +    data_size =3D sizeof(*new_epow);
> >>>       hdr->summary =3D cpu_to_be32(RTAS_LOG_VERSION_6
> >>>                                  | RTAS_LOG_SEVERITY_EVENT
> >>>                                  | RTAS_LOG_DISPOSITION_NOT_RECOVERED
> >>>                                  | RTAS_LOG_OPTIONAL_PART_PRESENT
> >>>                                  | RTAS_LOG_TYPE_EPOW);
> >>> -    hdr->extended_length =3D cpu_to_be32(sizeof(*new_epow)
> >>> -                                       - sizeof(new_epow->hdr));
> >>> -
> >>> +    hdr->extended_length =3D cpu_to_be32(data_size - =

> >>> sizeof(new_epow->hdr));
> >>>       spapr_init_v6hdr(v6hdr);
> >>>       spapr_init_maina(maina, 3 /* Main-A, Main-B and EPOW */);
> >>>   @@ -479,7 +481,7 @@ static void spapr_powerdown_req(Notifier *n, =

> >>> void *opaque)
> >>>       epow->event_modifier =3D RTAS_LOG_V6_EPOW_MODIFIER_NORMAL;
> >>>       epow->extended_modifier =3D =

> >>> RTAS_LOG_V6_EPOW_XMODIFIER_PARTITION_SPECIFIC;
> >>>   -    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true);
> >>> +    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true, =

> >>> data_size);
> >>>         qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
> >>> rtas_event_log_to_irq(spapr,
> >>> @@ -504,6 +506,7 @@ static void spapr_hotplug_req_event(uint8_t =

> >>> hp_id, uint8_t hp_action,
> >>>       struct rtas_event_log_v6_maina *maina;
> >>>       struct rtas_event_log_v6_mainb *mainb;
> >>>       struct rtas_event_log_v6_hp *hp;
> >>> +    uint32_t data_size;
> >>>         new_hp =3D g_malloc0(sizeof(struct hp_log_full));
> >>>       hdr =3D &new_hp->hdr;
> >>> @@ -512,14 +515,14 @@ static void spapr_hotplug_req_event(uint8_t =

> >>> hp_id, uint8_t hp_action,
> >>>       mainb =3D &new_hp->mainb;
> >>>       hp =3D &new_hp->hp;
> >>>   +    data_size =3D sizeof(*new_hp);
> >>>       hdr->summary =3D cpu_to_be32(RTAS_LOG_VERSION_6
> >>>                                  | RTAS_LOG_SEVERITY_EVENT
> >>>                                  | RTAS_LOG_DISPOSITION_NOT_RECOVERED
> >>>                                  | RTAS_LOG_OPTIONAL_PART_PRESENT
> >>>                                  | RTAS_LOG_INITIATOR_HOTPLUG
> >>>                                  | RTAS_LOG_TYPE_HOTPLUG);
> >>> -    hdr->extended_length =3D cpu_to_be32(sizeof(*new_hp)
> >>> -                                       - sizeof(new_hp->hdr));
> >>> +    hdr->extended_length =3D cpu_to_be32(data_size - =

> >>> sizeof(new_hp->hdr));
> >>>         spapr_init_v6hdr(v6hdr);
> >>>       spapr_init_maina(maina, 3 /* Main-A, Main-B, HP */);
> >>> @@ -572,7 +575,7 @@ static void spapr_hotplug_req_event(uint8_t =

> >>> hp_id, uint8_t hp_action,
> >>>               cpu_to_be32(drc_id->count_indexed.index);
> >>>       }
> >>>   -    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true);
> >>> +    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true, =

> >>> data_size);
> >>>         qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
> >>> rtas_event_log_to_irq(spapr,
> >>> @@ -671,8 +674,7 @@ static void check_exception(PowerPCCPU *cpu, =

> >>> sPAPRMachineState *spapr,
> >>>       if (!event) {
> >>>           goto out_no_events;
> >>>       }
> >>> -
> >>> -    hdr =3D event->data;
> >>> +    hdr =3D (struct rtas_error_log *)event->data;
> >>>       event_len =3D be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
> >>>         if (event_len < len) {
> >>> @@ -728,7 +730,7 @@ static void event_scan(PowerPCCPU *cpu, =

> >>> sPAPRMachineState *spapr,
> >>>           goto out_no_events;
> >>>       }
> >>>   -    hdr =3D event->data;
> >>> +    hdr =3D (struct rtas_error_log *)event->data;
> >>>       event_len =3D be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
> >>>         if (event_len < len) {
> >>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >>> index 5802f88..fbe1d93 100644
> >>> --- a/include/hw/ppc/spapr.h
> >>> +++ b/include/hw/ppc/spapr.h
> >>> @@ -599,7 +599,8 @@ sPAPRTCETable =

> >>> *spapr_tce_find_by_liobn(target_ulong liobn);
> >>>   struct sPAPREventLogEntry {
> >>>       int log_type;
> >>>       bool exception;
> >>> -    void *data;
> >>> +    uint8_t *data;
> >>> +    uint32_t data_size;
> >>>       QTAILQ_ENTRY(sPAPREventLogEntry) next;
> >>>   };
> >
> >
>=20
