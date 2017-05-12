Received: from eggs.gnu.org ([2001:4830:134:3::10]:58349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d8znD-0000e3-OF
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d8znA-0000oH-Lm
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:54:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d8znA-0000mh-CE
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:54:52 -0400
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
	<1494403315-12760-13-git-send-email-peterx@redhat.com>
	<2a328f26-bf49-a0e8-1582-2179720b0cb1@redhat.com>
	<20170511085901.GI28293@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fee8f447-051b-23dc-8e5b-eb5b73e25020@redhat.com>
Date: Fri, 12 May 2017 09:54:38 +0800
MIME-Version: 1.0
In-Reply-To: <20170511085901.GI28293@pxdev.xzpeter.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/12] vhost: iommu: cache static
 mapping if there is
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>



On 2017=E5=B9=B405=E6=9C=8811=E6=97=A5 16:59, Peter Xu wrote:
> On Thu, May 11, 2017 at 04:35:21PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B405=E6=9C=8810=E6=97=A5 16:01, Peter Xu wrote:
>>> This patch pre-heat vhost iotlb cache when passthrough mode enabled.
>>>
>>> Sometimes, even if user specified iommu_platform for vhost devices,
>>> IOMMU might still be disabled. One case is passthrough mode in VT-d
>>> implementation. We can detect this by observing iommu_list. If it's
>>> empty, it means IOMMU translation is disabled, then we can actually
>>> pre-heat the translation (it'll be static mapping then) by first
>>> invalidating all IOTLB, then cache existing memory ranges into vhost
>>> backend iotlb using 1:1 mapping.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>   hw/virtio/trace-events |  4 ++++
>>>   hw/virtio/vhost.c      | 49 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>   2 files changed, 53 insertions(+)
>>>
>>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>>> index 1f7a7c1..54dcbb3 100644
>>> --- a/hw/virtio/trace-events
>>> +++ b/hw/virtio/trace-events
>>> @@ -24,3 +24,7 @@ virtio_balloon_handle_output(const char *name, uint=
64_t gpa) "section name: %s g
>>>   virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num=
_pages: %d actual: %d"
>>>   virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "act=
ual: %d oldactual: %d"
>>>   virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "ball=
oon target: %"PRIx64" num_pages: %d"
>>> +
>>> +# hw/virtio/vhost.c
>>> +vhost_iommu_commit(void) ""
>>> +vhost_iommu_static_preheat(void) ""
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index 0001e60..1c92e62 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -27,6 +27,7 @@
>>>   #include "hw/virtio/virtio-access.h"
>>>   #include "migration/migration.h"
>>>   #include "sysemu/dma.h"
>>> +#include "trace.h"
>>>   /* enabled until disconnected backend stabilizes */
>>>   #define _VHOST_DEBUG 1
>>> @@ -730,6 +731,11 @@ static void vhost_iommu_unmap_notify(IOMMUNotifi=
er *n, IOMMUTLBEntry *iotlb)
>>>       }
>>>   }
>>> +static bool vhost_iommu_mr_enabled(struct vhost_dev *dev)
>>> +{
>>> +    return !QLIST_EMPTY(&dev->iommu_list);
>>> +}
>>> +
>>>   static void vhost_iommu_region_add(MemoryListener *listener,
>>>                                      MemoryRegionSection *section)
>>>   {
>>> @@ -782,6 +788,48 @@ static void vhost_iommu_region_del(MemoryListene=
r *listener,
>>>       }
>>>   }
>>> +static void vhost_iommu_commit(MemoryListener *listener)
>>> +{
>>> +    struct vhost_dev *dev =3D container_of(listener, struct vhost_de=
v,
>>> +                                         iommu_listener);
>>> +    struct vhost_memory_region *r;
>>> +    int i;
>>> +
>>> +    trace_vhost_iommu_commit();
>>> +
>>> +    if (!vhost_iommu_mr_enabled(dev)) {
>>> +        /*
>>> +        * This means iommu_platform is enabled, however iommu memory
>>> +        * region is disabled, e.g., when device passthrough is setup=
.
>>> +        * Then, no translation is needed any more.
>>> +        *
>>> +        * Let's first invalidate the whole IOTLB, then pre-heat the
>>> +        * static mapping by looping over vhost memory ranges.
>>> +        */
>>> +
>>> +        if (dev->vhost_ops->vhost_invalidate_device_iotlb(dev, 0,
>>> +                                                          UINT64_MAX=
-1)) {
>>> +            error_report("%s: flush existing IOTLB failed", __func__=
);
>>> +            return;
>>> +        }
>>> +
>>> +        for (i =3D 0; i < dev->mem->nregions; i++) {
>>> +            r =3D &dev->mem->regions[i];
>>> +            /* Vhost regions are writable RAM, so IOMMU_RW suites. *=
/
>>> +            if (dev->vhost_ops->vhost_update_device_iotlb(dev,
>>> +                                                          r->guest_p=
hys_addr,
>>> +                                                          r->userspa=
ce_addr,
>>> +                                                          r->memory_=
size,
>>> +                                                          IOMMU_RW))=
 {
>>> +                error_report("%s: pre-heat static mapping failed", _=
_func__);
>>> +                return;
>>> +            }
>>> +        }
>>> +
>>> +        trace_vhost_iommu_static_preheat();
>>> +    }
>>> +}
>> Looks like vfio does the map in region_add(), if we can have different=
 types
>> of memory regions (e.g some were under an IOMMU but others were not), =
do we
>> need to switch to do this in vhost_iommu_region_add() ?
> Currently this is only a pre-heat of cache only if IOMMU is totally
> disabled (!vhost_iommu_mr_enabled(dev) means no IOMMU memory regions).
> This patch won't be activated without this condition, so for the cases
> (non-x86 platforms) where there are some IOMMU regions, it'll be just
> automatically disabled. And, I don't really quite sure whether we
> should cache non-IOMMU regions when there are some IOMMU regions... So
> imho we can keep this until one day we really want to support some
> non-x86 platforms for vhost-dmar, then we can work on top. Thanks,
>

Right, so let's keep this as is and do optimization on top.

Thanks
