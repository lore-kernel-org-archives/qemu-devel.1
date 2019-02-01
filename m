Received: from eggs.gnu.org ([209.51.188.92]:56283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpZXl-0005cw-Pt
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpZXg-0002Xw-2I
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:11:42 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190123195527.29575-1-david@redhat.com>
	<20190123195527.29575-8-david@redhat.com>
	<20190125175818.GG2695@work-vm> <87ef8svg79.fsf@dusky.pond.sub.org>
	<20190201104906.GA3150@work-vm>
Date: Fri, 01 Feb 2019 15:11:18 +0100
In-Reply-To: <20190201104906.GA3150@work-vm> (David Alan Gilbert's message of
	"Fri, 1 Feb 2019 10:49:06 +0000")
Message-ID: <87munf61kp.fsf@dusky.pond.sub.org>
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
Cc: Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>> 
>> > * David Hildenbrand (david@redhat.com) wrote:
>> >> Print the memory device info just like for PCDIMM/NVDIMM.
>> >> 
>> >> Signed-off-by: David Hildenbrand <david@redhat.com>
>> >> ---
>> >>  hmp.c | 27 +++++++++++++++------------
>> >>  1 file changed, 15 insertions(+), 12 deletions(-)
>> >> 
>> >> diff --git a/hmp.c b/hmp.c
>> >> index 8da5fd8760..25c32e0810 100644
>> >> --- a/hmp.c
>> >> +++ b/hmp.c
>> >> @@ -2553,6 +2553,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>> >>      Error *err = NULL;
>> >>      MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
>> >>      MemoryDeviceInfoList *info;
>> >> +    VirtioPMEMDeviceInfo *vpi;
>> >>      MemoryDeviceInfo *value;
>> >>      PCDIMMDeviceInfo *di;
>> >>  
>> >> @@ -2562,19 +2563,9 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>> >>          if (value) {
>> >>              switch (value->type) {
>> >>              case MEMORY_DEVICE_INFO_KIND_DIMM:
>> >> -                di = value->u.dimm.data;
>> >> -                break;
>> >> -
>> >>              case MEMORY_DEVICE_INFO_KIND_NVDIMM:
>> >> -                di = value->u.nvdimm.data;
>> >> -                break;
>> >> -
>> >> -            default:
>> >> -                di = NULL;
>> >> -                break;
>> >> -            }
>> >> -
>> >> -            if (di) {
>> >> +                di = value->type == MEMORY_DEVICE_INFO_KIND_DIMM ?
>> >> +                     value->u.dimm.data : value->u.nvdimm.data;
>> >>                  monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>> >>                                 MemoryDeviceInfoKind_str(value->type),
>> >>                                 di->id ? di->id : "");
>> >> @@ -2587,6 +2578,18 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>> >>                                 di->hotplugged ? "true" : "false");
>> >>                  monitor_printf(mon, "  hotpluggable: %s\n",
>> >>                                 di->hotpluggable ? "true" : "false");
>> >> +                break;
>> >> +            case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
>> >> +                vpi = value->u.virtio_pmem.data;
>> >> +                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>> >> +                               MemoryDeviceInfoKind_str(value->type),
>> >> +                               vpi->id ? vpi->id : "");
>> >> +                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", vpi->memaddr);
>> >> +                monitor_printf(mon, "  size: %" PRIu64 "\n", vpi->size);
>> >> +                monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
>> >> +                break;
>> >> +            default:
>> >> +                g_assert_not_reached();
>> >
>> >
>> > Although I'd prefer if that assert was replaced by a print
>> > saying it was an unknown type.
>> 
>> I would not.  If we reach this, something must have scribbled over
>> value->type and who knows what else.  Continuing is unsafe.  Looks like
>> a textbook use of assertions to me.
>
> Or it could be that someone added a new type of memory device and forgot
> to update the hmp code.

Programming error -> assert.  Nothing catches attention in testing like
an assertion failure.
