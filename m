Received: from eggs.gnu.org ([2001:4830:134:3::10]:35545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gQ7yQ-0007pA-Qh
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gQ7kC-0006Lk-9M
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:27:26 -0500
References: <20181122171538.12359-1-eric.auger@redhat.com>
	<20181122171538.12359-7-eric.auger@redhat.com>
	<VI1PR04MB484549F41959A613D3517F7D9AD40@VI1PR04MB4845.eurprd04.prod.outlook.com>
	<19f3bee1-48e3-444b-ec90-702d9dae4c70@redhat.com>
	<AM6PR04MB48383B55B9ECFE4E231405179AD40@AM6PR04MB4838.eurprd04.prod.outlook.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d8fd1a3b-f94c-8e6b-f25b-3ff5d8055ed8@redhat.com>
Date: Fri, 23 Nov 2018 10:26:57 +0100
MIME-Version: 1.0
In-Reply-To: <AM6PR04MB48383B55B9ECFE4E231405179AD40@AM6PR04MB4838.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v9 06/17] virtio-iommu: Endpoint and domains
 structs and helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Cc: "tn@semihalf.com" <tn@semihalf.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "peterx@redhat.com" <peterx@redhat.com>

Hi Bharat,

On 11/23/18 10:14 AM, Bharat Bhushan wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Auger Eric <eric.auger@redhat.com>
>> Sent: Friday, November 23, 2018 1:23 PM
>> To: Bharat Bhushan <bharat.bhushan@nxp.com>;
>> eric.auger.pro@gmail.com; qemu-devel@nongnu.org; qemu-
>> arm@nongnu.org; peter.maydell@linaro.org; mst@redhat.com; jean-
>> philippe.brucker@arm.com
>> Cc: tn@semihalf.com; kevin.tian@intel.com; peterx@redhat.com
>> Subject: Re: [Qemu-devel] [RFC v9 06/17] virtio-iommu: Endpoint and
>> domains structs and helpers
>>
>> Hi Bharat,
>>
>> On 11/23/18 7:38 AM, Bharat Bhushan wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Sent: Thursday, November 22, 2018 10:45 PM
>>>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>>>> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
>>>> mst@redhat.com; jean-philippe.brucker@arm.com
>>>> Cc: kevin.tian@intel.com; tn@semihalf.com; Bharat Bhushan
>>>> <bharat.bhushan@nxp.com>; peterx@redhat.com
>>>> Subject: [RFC v9 06/17] virtio-iommu: Endpoint and domains structs
>>>> and helpers
>>>>
>>>> This patch introduce domain and endpoint internal datatypes. Both are
>>>> stored in RB trees. The domain owns a list of endpoints attached to it.
>>>>
>>>> Helpers to get/put end points and domains are introduced.
>>>> get() helpers will become static in subsequent patches.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>>
>>>> v6 -> v7:
>>>> - on virtio_iommu_find_add_as the bus number computation may
>>>>   not be finalized yet so we cannot register the EPs at that time.
>>>>   Hence, let's remove the get_endpoint and also do not use the
>>>>   bus number for building the memory region name string (only
>>>>   used for debug though).
>>>
>>> Endpoint registration from virtio_iommu_find_add_as to PROBE request.
>>> It is mentioned that " the bus number computation may not be finalized ".
>> Can you please give some more information.
>>> I am asking this because from vfio perspective translate/replay will be
>> called much before the PROBE request and endpoint needed to be
>> registered by that time.
>> When from virtio_iommu_find_add() gets called, there are cases where the
>> BDF of the device is not yet computed, typically if the EP is plugged on a
>> secondary bus. That's why I postponed the registration. Do you have idea
>> When you would need the registration to happen?
> 
> We want the endpoint registeration before replay/translate() is called for both virtio/vfio and I am trying to understand when we should register the endpoint.
> I am looking at amd iommu, there pci_setup_iommu() provides the callback function which is called with "devfn" from pci_device_iommu_address_space(). Are you saying that devfn provided by pci_device_iommu_address_space() can be invalid?
pci_bus_num() can return something wrong if called from
virtio_iommu_find_add_as.

That's what on smmuv3 (same on Intel), we use a separate
smmu_find_smmu_pcibus() called later. See comment for smmu_find_smmu_pcibus.

Thanks

Eric

> 
> Thanks
> -Bharat
> 
>>
>> Thanks
>>
>> Eric
>>>
>>>
>>> Thanks
>>> -Bharat
>>>
>>>>
>>>> v4 -> v5:
>>>> - initialize as->endpoint_list
>>>>
>>>> v3 -> v4:
>>>> - new separate patch
>>>> ---
>>>>  hw/virtio/trace-events   |   4 ++
>>>>  hw/virtio/virtio-iommu.c | 125
>>>> ++++++++++++++++++++++++++++++++++++++-
>>>>  2 files changed, 128 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events index
>>>> 9270b0463e..4b15086872 100644
>>>> --- a/hw/virtio/trace-events
>>>> +++ b/hw/virtio/trace-events
>>>> @@ -61,3 +61,7 @@ virtio_iommu_map(uint32_t domain_id, uint64_t
>>>> virt_start, uint64_t virt_end, uin  virtio_iommu_unmap(uint32_t
>>>> domain_id, uint64_t virt_start, uint64_t virt_end) "domain=%d
>> virt_start=0x%"PRIx64"
>>>> virt_end=0x%"PRIx64  virtio_iommu_translate(const char *name,
>>>> uint32_t rid, uint64_t iova, int flag) "mr=%s rid=%d addr=0x%"PRIx64"
>> flag=%d"
>>>>  virtio_iommu_init_iommu_mr(char *iommu_mr) "init %s"
>>>> +virtio_iommu_get_endpoint(uint32_t ep_id) "Alloc endpoint=%d"
>>>> +virtio_iommu_put_endpoint(uint32_t ep_id) "Free endpoint=%d"
>>>> +virtio_iommu_get_domain(uint32_t domain_id) "Alloc domain=%d"
>>>> +virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
>>>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>>>> index
>>>> dead062baf..1b9c3ba416 100644
>>>> --- a/hw/virtio/virtio-iommu.c
>>>> +++ b/hw/virtio/virtio-iommu.c
>>>> @@ -33,20 +33,124 @@
>>>>  #include "hw/virtio/virtio-bus.h"
>>>>  #include "hw/virtio/virtio-access.h"
>>>>  #include "hw/virtio/virtio-iommu.h"
>>>> +#include "hw/pci/pci_bus.h"
>>>> +#include "hw/pci/pci.h"
>>>>
>>>>  /* Max size */
>>>>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>>>>
>>>> +typedef struct viommu_domain {
>>>> +    uint32_t id;
>>>> +    GTree *mappings;
>>>> +    QLIST_HEAD(, viommu_endpoint) endpoint_list; } viommu_domain;
>>>> +
>>>> +typedef struct viommu_endpoint {
>>>> +    uint32_t id;
>>>> +    viommu_domain *domain;
>>>> +    QLIST_ENTRY(viommu_endpoint) next;
>>>> +    VirtIOIOMMU *viommu;
>>>> +} viommu_endpoint;
>>>> +
>>>> +typedef struct viommu_interval {
>>>> +    uint64_t low;
>>>> +    uint64_t high;
>>>> +} viommu_interval;
>>>> +
>>>>  static inline uint16_t virtio_iommu_get_sid(IOMMUDevice *dev)  {
>>>>      return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);  }
>>>>
>>>> +static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer
>>>> +user_data) {
>>>> +    viommu_interval *inta = (viommu_interval *)a;
>>>> +    viommu_interval *intb = (viommu_interval *)b;
>>>> +
>>>> +    if (inta->high <= intb->low) {
>>>> +        return -1;
>>>> +    } else if (intb->high <= inta->low) {
>>>> +        return 1;
>>>> +    } else {
>>>> +        return 0;
>>>> +    }
>>>> +}
>>>> +
>>>> +static void
>>>> virtio_iommu_detach_endpoint_from_domain(viommu_endpoint
>>>> +*ep) {
>>>> +    QLIST_REMOVE(ep, next);
>>>> +    ep->domain = NULL;
>>>> +}
>>>> +
>>>> +viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
>>>> uint32_t
>>>> +ep_id); viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU
>> *s,
>>>> +uint32_t ep_id) {
>>>> +    viommu_endpoint *ep;
>>>> +
>>>> +    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
>>>> +    if (ep) {
>>>> +        return ep;
>>>> +    }
>>>> +    ep = g_malloc0(sizeof(*ep));
>>>> +    ep->id = ep_id;
>>>> +    ep->viommu = s;
>>>> +    trace_virtio_iommu_get_endpoint(ep_id);
>>>> +    g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
>>>> +    return ep;
>>>> +}
>>>> +
>>>> +static void virtio_iommu_put_endpoint(gpointer data) {
>>>> +    viommu_endpoint *ep = (viommu_endpoint *)data;
>>>> +
>>>> +    if (ep->domain) {
>>>> +        virtio_iommu_detach_endpoint_from_domain(ep);
>>>> +        g_tree_unref(ep->domain->mappings);
>>>> +    }
>>>> +
>>>> +    trace_virtio_iommu_put_endpoint(ep->id);
>>>> +    g_free(ep);
>>>> +}
>>>> +
>>>> +viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s,
>> uint32_t
>>>> +domain_id); viommu_domain
>> *virtio_iommu_get_domain(VirtIOIOMMU
>>>> *s,
>>>> +uint32_t domain_id) {
>>>> +    viommu_domain *domain;
>>>> +
>>>> +    domain = g_tree_lookup(s->domains,
>> GUINT_TO_POINTER(domain_id));
>>>> +    if (domain) {
>>>> +        return domain;
>>>> +    }
>>>> +    domain = g_malloc0(sizeof(*domain));
>>>> +    domain->id = domain_id;
>>>> +    domain->mappings =
>>>> g_tree_new_full((GCompareDataFunc)interval_cmp,
>>>> +                                   NULL, (GDestroyNotify)g_free,
>>>> +                                   (GDestroyNotify)g_free);
>>>> +    g_tree_insert(s->domains, GUINT_TO_POINTER(domain_id),
>> domain);
>>>> +    QLIST_INIT(&domain->endpoint_list);
>>>> +    trace_virtio_iommu_get_domain(domain_id);
>>>> +    return domain;
>>>> +}
>>>> +
>>>> +static void virtio_iommu_put_domain(gpointer data) {
>>>> +    viommu_domain *domain = (viommu_domain *)data;
>>>> +    viommu_endpoint *iter, *tmp;
>>>> +
>>>> +    QLIST_FOREACH_SAFE(iter, &domain->endpoint_list, next, tmp) {
>>>> +        virtio_iommu_detach_endpoint_from_domain(iter);
>>>> +    }
>>>> +    g_tree_destroy(domain->mappings);
>>>> +    trace_virtio_iommu_put_domain(domain->id);
>>>> +    g_free(domain);
>>>> +}
>>>> +
>>>>  static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void
>>>> *opaque,
>>>>                                                int devfn)  {
>>>>      VirtIOIOMMU *s = opaque;
>>>>      IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
>>>> +    static uint32_t mr_index;
>>>>      IOMMUDevice *sdev;
>>>>
>>>>      if (!sbus) {
>>>> @@ -60,7 +164,7 @@ static AddressSpace
>>>> *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
>>>>      if (!sdev) {
>>>>          char *name = g_strdup_printf("%s-%d-%d",
>>>>                                       TYPE_VIRTIO_IOMMU_MEMORY_REGION,
>>>> -                                     pci_bus_num(bus), devfn);
>>>> +                                     mr_index++, devfn);
>>>>          sdev = sbus->pbdev[devfn] = g_malloc0(sizeof(IOMMUDevice));
>>>>
>>>>          sdev->viommu = s;
>>>> @@ -75,6 +179,7 @@ static AddressSpace
>>>> *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
>>>>                                   UINT64_MAX);
>>>>          address_space_init(&sdev->as,
>>>>                             MEMORY_REGION(&sdev->iommu_mr),
>>>> TYPE_VIRTIO_IOMMU);
>>>> +        g_free(name);
>>>>      }
>>>>
>>>>      return &sdev->as;
>>>> @@ -332,6 +437,13 @@ static const VMStateDescription
>>>> vmstate_virtio_iommu_device = {
>>>>      },
>>>>  };
>>>>
>>>> +static gint int_cmp(gconstpointer a, gconstpointer b, gpointer
>>>> +user_data) {
>>>> +    uint ua = GPOINTER_TO_UINT(a);
>>>> +    uint ub = GPOINTER_TO_UINT(b);
>>>> +    return (ua > ub) - (ua < ub);
>>>> +}
>>>> +
>>>>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>> {
>>>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev); @@ -356,6 +468,8 @@
>>>> static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
>>>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
>>>>
>>>> +    qemu_mutex_init(&s->mutex);
>>>> +
>>>>      memset(s->as_by_bus_num, 0, sizeof(s->as_by_bus_num));
>>>>      s->as_by_busptr = g_hash_table_new(NULL, NULL);
>>>>
>>>> @@ -364,11 +478,20 @@ static void
>>>> virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>>>      } else {
>>>>          error_setg(errp, "VIRTIO-IOMMU is not attached to any PCI bus!");
>>>>      }
>>>> +
>>>> +    s->domains = g_tree_new_full((GCompareDataFunc)int_cmp,
>>>> +                                 NULL, NULL, virtio_iommu_put_domain);
>>>> +    s->endpoints = g_tree_new_full((GCompareDataFunc)int_cmp,
>>>> +                                   NULL, NULL,
>>>> + virtio_iommu_put_endpoint);
>>>>  }
>>>>
>>>>  static void virtio_iommu_device_unrealize(DeviceState *dev, Error
>>>> **errp) {
>>>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>> +    VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
>>>> +
>>>> +    g_tree_destroy(s->domains);
>>>> +    g_tree_destroy(s->endpoints);
>>>>
>>>>      virtio_cleanup(vdev);
>>>>  }
>>>> --
>>>> 2.17.2
>>>
>>>
