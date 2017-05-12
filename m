Received: from eggs.gnu.org ([2001:4830:134:3::10]:53476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d9Gm9-0001Lo-Ay
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d9Gm6-0001D0-3z
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:02:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37281
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d9Gm5-0001Co-Sw
	for qemu-devel@nongnu.org; Fri, 12 May 2017 16:02:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4CJtPFM033926
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:02:52 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2adepyv8uw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:02:52 -0400
Received: from localhost
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 12 May 2017 17:02:50 -0300
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<20170505204746.14116-7-danielhb@linux.vnet.ibm.com>
	<20170512062836.GI12908@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 12 May 2017 17:02:44 -0300
MIME-Version: 1.0
In-Reply-To: <20170512062836.GI12908@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <24ecdb76-f525-19e4-5674-1884ffcf2455@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 6/6] migration: spapr:
 migrate pending_events of spapr state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com



On 05/12/2017 03:28 AM, David Gibson wrote:
> On Fri, May 05, 2017 at 05:47:46PM -0300, Daniel Henrique Barboza wrote:
>> From: Jianjun Duan <duanj@linux.vnet.ibm.com>
>>
>> In racing situations between hotplug events and migration operation,
>> a rtas hotplug event could have not yet be delivered to the source
>> guest when migration is started. In this case the pending_events of
>> spapr state need be transmitted to the target so that the hotplug
>> event can be finished on the target.
>>
>> All the different fields of the events are encoded as defined by
>> PAPR. We can migrate them as uint8_t binary stream without any
>> concerns about data padding or endianess.
>>
>> pending_events is put in a subsection in the spapr state VMSD to make
>> sure migration across different versions is not broken.
>>
>> Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> This seems like it's probably a good idea, even independent of the
> hotplug migration stuff.  I suspect there are other races where we
> could lose a shutdown event or similar if there's a migration.
Perhaps we can detach this patch (and the ccs_list one) from this
series and evaluate them separately?


Daniel

>
>> ---
>>   hw/ppc/spapr.c         | 33 +++++++++++++++++++++++++++++++++
>>   hw/ppc/spapr_events.c  | 24 +++++++++++++-----------
>>   include/hw/ppc/spapr.h |  3 ++-
>>   3 files changed, 48 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index bc56249..e924fd4 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1498,6 +1498,38 @@ static const VMStateDescription vmstate_spapr_ccs_list = {
>>       },
>>   };
>>   
>> +static bool spapr_pending_events_needed(void *opaque)
>> +{
>> +    sPAPRMachineState *spapr = (sPAPRMachineState *)opaque;
>> +    return !QTAILQ_EMPTY(&spapr->pending_events);
>> +}
>> +
>> +static const VMStateDescription vmstate_spapr_event_entry = {
>> +    .name = "spapr_event_log_entry",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_INT32(log_type, sPAPREventLogEntry),
> This requires changing the actual type to int32_t in the structure.
>
>> +        VMSTATE_BOOL(exception, sPAPREventLogEntry),
> So, at the moment, AFAICT every event is marked as exception == true,
> so this doesn't actually tell us anything.   If that becomes not the
> case in future, can the exception flag be derived from the log_type or
> information in the even buffer?
>
>> +        VMSTATE_UINT32(data_size, sPAPREventLogEntry),
>> +        VMSTATE_VARRAY_UINT32_ALLOC(data, sPAPREventLogEntry, data_size,
>> +                                    0, vmstate_info_uint8, uint8_t),
> So, data_size duplicates information that's in the event header, which
> is a bit sad.  I suppose I'm ok with that, since setting up the VARRAY
> thing is going to be pretty awkward otherwise.
>
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>> +static const VMStateDescription vmstate_spapr_pending_events = {
>> +    .name = "spapr_pending_events",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = spapr_pending_events_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_QTAILQ_V(pending_events, sPAPRMachineState, 1,
>> +                         vmstate_spapr_event_entry, sPAPREventLogEntry, next),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>>   static bool spapr_ov5_cas_needed(void *opaque)
>>   {
>>       sPAPRMachineState *spapr = opaque;
>> @@ -1598,6 +1630,7 @@ static const VMStateDescription vmstate_spapr = {
>>           &vmstate_spapr_patb_entry,
>>           &vmstate_spapr_pending_dimm_unplugs,
>>           &vmstate_spapr_ccs_list,
>> +        &vmstate_spapr_pending_events,
>>           NULL
>>       }
>>   };
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index f0b28d8..70c7cfc 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -342,7 +342,8 @@ static int rtas_event_log_to_irq(sPAPRMachineState *spapr, int log_type)
>>       return source->irq;
>>   }
>>   
>> -static void rtas_event_log_queue(int log_type, void *data, bool exception)
>> +static void rtas_event_log_queue(int log_type, void *data, bool exception,
>> +                                 int data_size)
>>   {
>>       sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>       sPAPREventLogEntry *entry = g_new(sPAPREventLogEntry, 1);
>> @@ -351,6 +352,7 @@ static void rtas_event_log_queue(int log_type, void *data, bool exception)
>>       entry->log_type = log_type;
>>       entry->exception = exception;
>>       entry->data = data;
>> +    entry->data_size = data_size;
> I think it would make more sense to derive data_size from the buffer
> header contents here, rather than in all the callers.
>
>>       QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
>>   }
>>   
>> @@ -445,6 +447,7 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
>>       struct rtas_event_log_v6_mainb *mainb;
>>       struct rtas_event_log_v6_epow *epow;
>>       struct epow_log_full *new_epow;
>> +    uint32_t data_size;
>>   
>>       new_epow = g_malloc0(sizeof(*new_epow));
>>       hdr = &new_epow->hdr;
>> @@ -453,14 +456,13 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
>>       mainb = &new_epow->mainb;
>>       epow = &new_epow->epow;
>>   
>> +    data_size = sizeof(*new_epow);
>>       hdr->summary = cpu_to_be32(RTAS_LOG_VERSION_6
>>                                  | RTAS_LOG_SEVERITY_EVENT
>>                                  | RTAS_LOG_DISPOSITION_NOT_RECOVERED
>>                                  | RTAS_LOG_OPTIONAL_PART_PRESENT
>>                                  | RTAS_LOG_TYPE_EPOW);
>> -    hdr->extended_length = cpu_to_be32(sizeof(*new_epow)
>> -                                       - sizeof(new_epow->hdr));
>> -
>> +    hdr->extended_length = cpu_to_be32(data_size - sizeof(new_epow->hdr));
>>       spapr_init_v6hdr(v6hdr);
>>       spapr_init_maina(maina, 3 /* Main-A, Main-B and EPOW */);
>>   
>> @@ -479,7 +481,7 @@ static void spapr_powerdown_req(Notifier *n, void *opaque)
>>       epow->event_modifier = RTAS_LOG_V6_EPOW_MODIFIER_NORMAL;
>>       epow->extended_modifier = RTAS_LOG_V6_EPOW_XMODIFIER_PARTITION_SPECIFIC;
>>   
>> -    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true);
>> +    rtas_event_log_queue(RTAS_LOG_TYPE_EPOW, new_epow, true, data_size);
>>   
>>       qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
>>                                    rtas_event_log_to_irq(spapr,
>> @@ -504,6 +506,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>>       struct rtas_event_log_v6_maina *maina;
>>       struct rtas_event_log_v6_mainb *mainb;
>>       struct rtas_event_log_v6_hp *hp;
>> +    uint32_t data_size;
>>   
>>       new_hp = g_malloc0(sizeof(struct hp_log_full));
>>       hdr = &new_hp->hdr;
>> @@ -512,14 +515,14 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>>       mainb = &new_hp->mainb;
>>       hp = &new_hp->hp;
>>   
>> +    data_size = sizeof(*new_hp);
>>       hdr->summary = cpu_to_be32(RTAS_LOG_VERSION_6
>>                                  | RTAS_LOG_SEVERITY_EVENT
>>                                  | RTAS_LOG_DISPOSITION_NOT_RECOVERED
>>                                  | RTAS_LOG_OPTIONAL_PART_PRESENT
>>                                  | RTAS_LOG_INITIATOR_HOTPLUG
>>                                  | RTAS_LOG_TYPE_HOTPLUG);
>> -    hdr->extended_length = cpu_to_be32(sizeof(*new_hp)
>> -                                       - sizeof(new_hp->hdr));
>> +    hdr->extended_length = cpu_to_be32(data_size - sizeof(new_hp->hdr));
>>   
>>       spapr_init_v6hdr(v6hdr);
>>       spapr_init_maina(maina, 3 /* Main-A, Main-B, HP */);
>> @@ -572,7 +575,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>>               cpu_to_be32(drc_id->count_indexed.index);
>>       }
>>   
>> -    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true);
>> +    rtas_event_log_queue(RTAS_LOG_TYPE_HOTPLUG, new_hp, true, data_size);
>>   
>>       qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
>>                                    rtas_event_log_to_irq(spapr,
>> @@ -671,8 +674,7 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>>       if (!event) {
>>           goto out_no_events;
>>       }
>> -
>> -    hdr = event->data;
>> +    hdr = (struct rtas_error_log *)event->data;
>>       event_len = be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
>>   
>>       if (event_len < len) {
>> @@ -728,7 +730,7 @@ static void event_scan(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>>           goto out_no_events;
>>       }
>>   
>> -    hdr = event->data;
>> +    hdr = (struct rtas_error_log *)event->data;
>>       event_len = be32_to_cpu(hdr->extended_length) + sizeof(*hdr);
>>   
>>       if (event_len < len) {
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index adc9fdb..ddac014 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -603,7 +603,8 @@ sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
>>   struct sPAPREventLogEntry {
>>       int log_type;
>>       bool exception;
>> -    void *data;
>> +    uint8_t *data;
> I think you can avoid this type change (and the casts it requires) by
> using VBUFFER instead of VARRAY.
>
>> +    uint32_t data_size;
>>       QTAILQ_ENTRY(sPAPREventLogEntry) next;
>>   };
>>   
