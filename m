Received: from eggs.gnu.org ([2001:4830:134:3::10]:35027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWR6p-0007mf-IG
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWR6m-000418-C7
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:11:47 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cWR6m-00040u-3D
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:11:44 -0500
Received: by mail-wm0-x243.google.com with SMTP id r126so43874209wmr.3
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 09:11:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
	<1485253571-19058-3-git-send-email-peterx@redhat.com>
	<20170124092905.41832531@t450s.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ef03816-0bef-f54b-63fe-daf27eab4a40@redhat.com>
Date: Wed, 25 Jan 2017 18:11:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170124092905.41832531@t450s.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 02/18] vfio: introduce vfio_get_vaddr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, qemu-devel@nongnu.org, bd.aviv@gmail.com



On 24/01/2017 17:29, Alex Williamson wrote:
> On Tue, 24 Jan 2017 18:25:55 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
>> A cleanup for vfio_iommu_map_notify(). Should have no functional change,
>> just to make the function shorter and easier to understand.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  hw/vfio/common.c | 58 +++++++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 38 insertions(+), 20 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 174f351..ce55dff 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -294,25 +294,14 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>             section->offset_within_address_space & (1ULL << 63);
>>  }
>>  
>> -static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>> +static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
>> +                           bool *read_only)
>>  {
>> -    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>> -    VFIOContainer *container = giommu->container;
>> -    hwaddr iova = iotlb->iova + giommu->iommu_offset;
>>      MemoryRegion *mr;
>>      hwaddr xlat;
>>      hwaddr len = iotlb->addr_mask + 1;
>> -    void *vaddr;
>> -    int ret;
>> -
>> -    trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
>> -                                iova, iova + iotlb->addr_mask);
>> -
>> -    if (iotlb->target_as != &address_space_memory) {
>> -        error_report("Wrong target AS \"%s\", only system memory is allowed",
>> -                     iotlb->target_as->name ? iotlb->target_as->name : "none");
>> -        return;
>> -    }
>> +    bool ret = false;
>> +    bool writable = iotlb->perm & IOMMU_WO;
>>  
>>      /*
>>       * The IOMMU TLB entry we have just covers translation through
>> @@ -322,12 +311,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>      rcu_read_lock();
>>      mr = address_space_translate(&address_space_memory,
>>                                   iotlb->translated_addr,
>> -                                 &xlat, &len, iotlb->perm & IOMMU_WO);
>> +                                 &xlat, &len, writable);
>>      if (!memory_region_is_ram(mr)) {
>>          error_report("iommu map to non memory area %"HWADDR_PRIx"",
>>                       xlat);
>>          goto out;
>>      }
>> +
>>      /*
>>       * Translation truncates length to the IOMMU page size,
>>       * check that it did not truncate too much.
>> @@ -337,11 +327,41 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>          goto out;
>>      }
>>  
>> +    *vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> +    *read_only = !writable || mr->readonly;
>> +    ret = true;
>> +
>> +out:
>> +    rcu_read_unlock();
>> +    return ret;
>> +}
>> +
>> +static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>> +{
>> +    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>> +    VFIOContainer *container = giommu->container;
>> +    hwaddr iova = iotlb->iova + giommu->iommu_offset;
>> +    bool read_only;
>> +    void *vaddr;
>> +    int ret;
>> +
>> +    trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
>> +                                iova, iova + iotlb->addr_mask);
>> +
>> +    if (iotlb->target_as != &address_space_memory) {
>> +        error_report("Wrong target AS \"%s\", only system memory is allowed",
>> +                     iotlb->target_as->name ? iotlb->target_as->name : "none");
>> +        return;
>> +    }
>> +
>> +    if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
>> +        return;
>> +    }
>> +
>>      if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>> -        vaddr = memory_region_get_ram_ptr(mr) + xlat;
>>          ret = vfio_dma_map(container, iova,
>>                             iotlb->addr_mask + 1, vaddr,
>> -                           !(iotlb->perm & IOMMU_WO) || mr->readonly);
>> +                           read_only);
>>          if (ret) {
>>              error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
>>                           "0x%"HWADDR_PRIx", %p) = %d (%m)",
>> @@ -357,8 +377,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>                           iotlb->addr_mask + 1, ret);
>>          }
>>      }
>> -out:
>> -    rcu_read_unlock();
> 
> The comment from v4 still needs input from Paolo, is it valid to make
> use of vaddr (based on address_space_translate ->
> memory_region_get_ram_ptr) outside of the rcu read lock or could future
> BQL reduction efforts allow this to race?

You need to keep a reference to the MemoryRegion if you do
rcu_read_unlock.  But it's simpler to call vfio_get_vaddr within
rcu_read_lock, and keep the lock/unlock in vfio_iommu_map_notify.

You probably should also put a comment about why VFIO does *not* need to
keep a reference between vfio_dma_map and vfio_dma_unmap (which doesn't
sound easy to do either).  Would any well-behaved guest invalidate the
IOMMU page tables before a memory hot-unplug?

Paolo

>>  }
>>  
>>  static void vfio_listener_region_add(MemoryListener *listener,
> 
> 
> 
