Received: from eggs.gnu.org ([2001:4830:134:3::10]:60533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dVyfs-0007eL-0n
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dVyfq-0004fc-Tq
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:22:20 -0400
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<1496851287-9428-7-git-send-email-eric.auger@redhat.com>
	<20170714021733.GA27284@pxdev.xzpeter.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <0c33beca-1d6d-e8e6-c880-8807ad77ae0b@arm.com>
Date: Fri, 14 Jul 2017 12:25:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170714021733.GA27284@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 6/8] virtio-iommu: Implement the
 translation and commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, wei@redhat.com, kevin.tian@intel.com, bharat.bhushan@nxp.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org

Hi Peter,

On 14/07/17 03:17, Peter Xu wrote:
>
> [...]
> 
>>  static int virtio_iommu_unmap(VirtIOIOMMU *s,
>> @@ -133,10 +227,64 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>>      uint64_t virt_addr = le64_to_cpu(req->virt_addr);
>>      uint64_t size = le64_to_cpu(req->size);
>>      uint32_t flags = le32_to_cpu(req->flags);
>> +    viommu_mapping *mapping;
>> +    viommu_interval interval;
>> +    viommu_as *as;
>>  
>>      trace_virtio_iommu_unmap(asid, virt_addr, size, flags);
>>  
>> -    return VIRTIO_IOMMU_S_UNSUPP;
>> +    as = g_tree_lookup(s->address_spaces, GUINT_TO_POINTER(asid));
>> +    if (!as) {
>> +        error_report("%s: no as", __func__);
>> +        return VIRTIO_IOMMU_S_INVAL;
>> +    }
>> +    interval.low = virt_addr;
>> +    interval.high = virt_addr + size - 1;
>> +
>> +    mapping = g_tree_lookup(as->mappings, (gpointer)&interval);
>> +
>> +    while (mapping) {
>> +        viommu_interval current;
>> +        uint64_t low  = mapping->virt_addr;
>> +        uint64_t high = mapping->virt_addr + mapping->size - 1;
>> +
>> +        current.low = low;
>> +        current.high = high;
>> +
>> +        if (low == interval.low && size >= mapping->size) {
>> +            g_tree_remove(as->mappings, (gpointer)&current);
>> +            interval.low = high + 1;
>> +            trace_virtio_iommu_unmap_left_interval(current.low, current.high,
>> +                interval.low, interval.high);
>> +        } else if (high == interval.high && size >= mapping->size) {
>> +            trace_virtio_iommu_unmap_right_interval(current.low, current.high,
>> +                interval.low, interval.high);
>> +            g_tree_remove(as->mappings, (gpointer)&current);
>> +            interval.high = low - 1;
>> +        } else if (low > interval.low && high < interval.high) {
>> +            trace_virtio_iommu_unmap_inc_interval(current.low, current.high);
>> +            g_tree_remove(as->mappings, (gpointer)&current);
>> +        } else {
>> +            break;
>> +        }
>> +        if (interval.low >= interval.high) {
>> +            return VIRTIO_IOMMU_S_OK;
>> +        } else {
>> +            mapping = g_tree_lookup(as->mappings, (gpointer)&interval);
>> +        }
>> +    }
> 
> IIUC for unmap here we are very strict - a extreme case is that when
> an address space is just created (so no mapping inside), if we send
> one UNMAP to a range, it'll fail currently, right? Should we loosen
> it?

In the next specification version I'd like to slightly redefine unmap
semantics (to make them more deterministic). Unmapping a range that is
only partially mapped or not mapped at all would not return an error, and
would unmap everything that is covered by the range.

Note that unmapping a partial range (splitting a single mapping) is still
forbidden. The following pseudocode sequences attempt to illustrate the
rules I'd like to set. There are no mappings in the address space prior to
each sequence.

(1) unmap(addr=0, size=5)        -> succeeds, doesn't unmap anything

(2) a = map(addr=0, size=10);
    unmap(0, 10)                 -> succeeds, unmaps a

(3) a = map(0, 5);
    b = map(5, 5);
    unmap(0, 10)                 -> succeeds, unmaps a and b

(4) a = map(0, 10);
    unmap(0, 5)                  -> faults, doesn't unmap anything

(5) a = map(0, 5);
    b = map(5, 5);
    unmap(0, 5)                  -> succeeds, unmaps a

(6) a = map(0, 5);
    unmap(0, 10)                 -> succeeds, unmaps a

(7) a = map(0, 5);
    b = map(10, 5);
    unmap(0, 15)                 -> succeeds, unmaps a and b

Previously I left (1), (6) and (7) as an implementation choice. The device
could either succeed and unmap, or fail and not unmap. This means that if
a driver wanted guarantees, it had to issue strict map/unmap sequences.

I believe that VFIO type1 v2 has these semantics, but "v1" allowed (4) to
succeed and unmap a.

Thanks,
Jean


> IMHO as long as we make sure all the mappings in the range of an UNMAP
> request are destroyed, then we are good. I think at least both vfio
> api and vt-d emuation have this assumption. But maybe I am wrong.
> Please correct me if so.
> 
>> +
>> +    if (mapping) {
>> +        error_report("****** %s: Unmap 0x%"PRIx64" size=0x%"PRIx64
>> +                     " from 0x%"PRIx64" size=0x%"PRIx64" is not supported",
>> +                     __func__, interval.low, size,
>> +                     mapping->virt_addr, mapping->size);
>> +    } else {
>> +        error_report("****** %s: no mapping for [0x%"PRIx64",0x%"PRIx64"]",
>> +                     __func__, interval.low, interval.high);
>> +    }
>> +
>> +    return VIRTIO_IOMMU_S_INVAL;
>>  }
> 
> Thanks,
> 
