Received: from eggs.gnu.org ([209.51.188.92]:60404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpH0P-0004tK-Rc
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpH0I-0001Ee-4G
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:24:01 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190123195527.29575-1-david@redhat.com>
	<20190123195527.29575-8-david@redhat.com>
	<20190125175818.GG2695@work-vm>
Date: Thu, 31 Jan 2019 19:23:54 +0100
In-Reply-To: <20190125175818.GG2695@work-vm> (David Alan Gilbert's message of
	"Fri, 25 Jan 2019 17:58:19 +0000")
Message-ID: <87ef8svg79.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFCv2 7/9] hmp: Handle virtio-pmem when
 printing memory device infos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * David Hildenbrand (david@redhat.com) wrote:
>> Print the memory device info just like for PCDIMM/NVDIMM.
>> 
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hmp.c | 27 +++++++++++++++------------
>>  1 file changed, 15 insertions(+), 12 deletions(-)
>> 
>> diff --git a/hmp.c b/hmp.c
>> index 8da5fd8760..25c32e0810 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -2553,6 +2553,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>>      Error *err = NULL;
>>      MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
>>      MemoryDeviceInfoList *info;
>> +    VirtioPMEMDeviceInfo *vpi;
>>      MemoryDeviceInfo *value;
>>      PCDIMMDeviceInfo *di;
>>  
>> @@ -2562,19 +2563,9 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>>          if (value) {
>>              switch (value->type) {
>>              case MEMORY_DEVICE_INFO_KIND_DIMM:
>> -                di = value->u.dimm.data;
>> -                break;
>> -
>>              case MEMORY_DEVICE_INFO_KIND_NVDIMM:
>> -                di = value->u.nvdimm.data;
>> -                break;
>> -
>> -            default:
>> -                di = NULL;
>> -                break;
>> -            }
>> -
>> -            if (di) {
>> +                di = value->type == MEMORY_DEVICE_INFO_KIND_DIMM ?
>> +                     value->u.dimm.data : value->u.nvdimm.data;
>>                  monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>>                                 MemoryDeviceInfoKind_str(value->type),
>>                                 di->id ? di->id : "");
>> @@ -2587,6 +2578,18 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>>                                 di->hotplugged ? "true" : "false");
>>                  monitor_printf(mon, "  hotpluggable: %s\n",
>>                                 di->hotpluggable ? "true" : "false");
>> +                break;
>> +            case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
>> +                vpi = value->u.virtio_pmem.data;
>> +                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>> +                               MemoryDeviceInfoKind_str(value->type),
>> +                               vpi->id ? vpi->id : "");
>> +                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", vpi->memaddr);
>> +                monitor_printf(mon, "  size: %" PRIu64 "\n", vpi->size);
>> +                monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
>> +                break;
>> +            default:
>> +                g_assert_not_reached();
>
>
> Although I'd prefer if that assert was replaced by a print
> saying it was an unknown type.

I would not.  If we reach this, something must have scribbled over
value->type and who knows what else.  Continuing is unsafe.  Looks like
a textbook use of assertions to me.

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>>              }
>>          }
>>      }
>> -- 
>> 2.17.2
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
