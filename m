Received: from eggs.gnu.org ([2001:4830:134:3::10]:37799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAAFi-0004tQ-Lb
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 04:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAAFe-0007cv-0d
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 04:21:42 -0400
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-2-david@redhat.com>
	<20180422042615.GY2434@umbus.fritz.box>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7809aad5-1513-caed-bc94-c5b08afe2ce6@redhat.com>
Date: Sun, 22 Apr 2018 10:21:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180422042615.GY2434@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] pc-dimm: factor out MemoryDevice
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>

On 22.04.2018 06:26, David Gibson wrote:
> On Fri, Apr 20, 2018 at 02:34:54PM +0200, David Hildenbrand wrote:
>> On the qmp level, we already have the concept of memory devices:
>>     "query-memory-devices"
>> Right now, we only support NVDIMM and PCDIMM.
>>
>> We want to map other devices later into the address space of the guest.
>> Such device could e.g. be virtio devices. These devices will have a
>> guest memory range assigned but won't be exposed via e.g. ACPI. We want
>> to make them look like memory device, but not glued to pc-dimm.
>>
>> Especially, it will not always be possible to have TYPE_PC_DIMM as a parent
>> class (e.g. virtio devices). Let's use an interface instead. As a first
>> part, convert handling of
>> - qmp_pc_dimm_device_list
>> - get_plugged_memory_size
>> to our new model. plug/unplug stuff etc. will follow later.
>>
>> A memory device will have to provide the following functions:
>> - get_addr(): Necessary, as the property "addr" can e.g. not be used for
>>               virtio devices (already defined).
>> - get_plugged_size(): The amount this device offers to the guest as of
>>                       now.
>> - get_region_size(): Because this can later on be bigger than the
>>                      plugged size.
>> - fill_device_info(): Fill MemoryDeviceInfo, e.g. for qmp.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> with the exception of some tiny nits..
> 
> [snip]
>> +static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
>> +{
>> +    MemoryDeviceState *md_a = MEMORY_DEVICE(a);
>> +    MemoryDeviceState *md_b = MEMORY_DEVICE(b);
> 
> These probably should be const MemoryDeviceState *.

Yes, that could work (depends on what the functions getting called
internally expect). Will look into it

> 
>> +    MemoryDeviceClass *mdc_a = MEMORY_DEVICE_GET_CLASS(a);
>> +    MemoryDeviceClass *mdc_b = MEMORY_DEVICE_GET_CLASS(b);
>> +    const uint64_t addr_a = mdc_a->get_addr(md_a);
>> +    const uint64_t addr_b = mdc_b->get_addr(md_b);
>> +
>> +    if (addr_a > addr_b) {
>> +        return 1;
>> +    } else if (addr_a < addr_b) {
>> +        return -1;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int memory_device_built_list(Object *obj, void *opaque)
> 
> s/built/build/ will read a bit more clearly I think.
> 

Indeed, thanks!

-- 

Thanks,

David / dhildenb
