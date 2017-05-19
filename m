Received: from eggs.gnu.org ([2001:4830:134:3::10]:52080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBhh4-0002xC-6a
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dBhh0-00030D-7Y
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:11:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45463
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dBhh0-000302-1z
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:11:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JD9Bc3055093
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 09:11:41 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ahpwwtrry-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 09:11:41 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 19 May 2017 10:11:39 -0300
References: <20170518202402.12571-1-danielhb@linux.vnet.ibm.com>
	<20170518202402.12571-3-danielhb@linux.vnet.ibm.com>
	<20170519023216.GD12284@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 19 May 2017 10:10:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170519023216.GD12284@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <e8b5bb30-2f2d-7064-2131-99870d85e060@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v11 2/2] migration: spapr:
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



On 05/18/2017 11:32 PM, David Gibson wrote:
> On Thu, May 18, 2017 at 05:24:02PM -0300, Daniel Henrique Barboza wrote:
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
>> ---
>>   hw/ppc/spapr.c         | 32 ++++++++++++++++++++++++++++++++
>>   hw/ppc/spapr_events.c  |  1 +
>>   include/hw/ppc/spapr.h |  3 ++-
>>   3 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 0980d73..5afd328 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1444,6 +1444,37 @@ static bool version_before_3(void *opaque, int version_id)
>>       return version_id < 3;
>>   }
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
>> +        VMSTATE_UINT32(data_size, sPAPREventLogEntry),
>> +        VMSTATE_VBUFFER_ALLOC_UINT32(data, sPAPREventLogEntry, 0,
>> +                                     NULL, data_size),
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
>> @@ -1542,6 +1573,7 @@ static const VMStateDescription vmstate_spapr = {
>>       .subsections = (const VMStateDescription*[]) {
>>           &vmstate_spapr_ov5_cas,
>>           &vmstate_spapr_patb_entry,
>> +        &vmstate_spapr_pending_events,
>>           NULL
>>       }
>>   };
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index 73e2a18..96c1605 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -350,6 +350,7 @@ static void rtas_event_log_queue(int log_type, void *data)
>>       g_assert(data);
>>       entry->log_type = log_type;
>>       entry->data = data;
>> +    entry->data_size = sizeof(*data);
> This can't be right, since data is a void*.  I'm surprised it even
> compiles.  You'll need to actually look into the data buffer here and
> extract the size field.
Hehe completely forgot here that I was querying the sizeof void. Good catch.
I think it didn't throw an error because the compiler defaulted the type 
of void
in sizeof() to something else (char perhaps?).

I'll fix it by making a switch with the log_type and setting sizeof with 
the proper
structured used.


Daniel
>
>>       QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
>>   }
>>   
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 02239a5..0554e11 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -597,8 +597,9 @@ struct sPAPRTCETable {
>>   sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
>>   
>>   struct sPAPREventLogEntry {
>> -    int log_type;
>> +    int32_t log_type;
>>       void *data;
>> +    uint32_t data_size;
>>       QTAILQ_ENTRY(sPAPREventLogEntry) next;
>>   };
>>   
