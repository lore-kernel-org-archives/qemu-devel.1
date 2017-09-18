Received: from eggs.gnu.org ([2001:4830:134:3::10]:45375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dtvnw-0007Op-Le
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dtvnu-0000KC-K9
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:09:40 -0400
References: <1503312534-6642-1-git-send-email-Bharat.Bhushan@nxp.com>
	<1503312534-6642-3-git-send-email-Bharat.Bhushan@nxp.com>
	<98b80288-9c4f-874a-9604-aa1a71525a59@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a2a27ae2-9e05-fdd3-f861-d48ec63a264f@redhat.com>
Date: Mon, 18 Sep 2017 15:09:13 +0200
MIME-Version: 1.0
In-Reply-To: <98b80288-9c4f-874a-9604-aa1a71525a59@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] virtio-iommu: vfio integration with
 virtio-iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <Bharat.Bhushan@nxp.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wei@redhat.com, kevin.tian@intel.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org

Hi Bharat,

On 18/09/2017 09:47, Auger Eric wrote:
> Hi Bharat,
> 
> On 21/08/2017 12:48, Bharat Bhushan wrote:
>> This RFC patch allows virtio-iommu protection for PCI
>> device-passthrough.
>>
>> MSI region is mapped by current version of virtio-iommu driver.
>> This uses VFIO extension of map/unmap notification when an area
>> of memory is mappedi/unmapped in emulated iommu device.
>>
>> This series is tested with 2 PCI devices to virtual machine using
>> dma-ops and DPDK in VM is not yet tested.
>>
>> Also with this series we observe below prints for MSI region mapping
>>
>>    "qemu-system-aarch64: iommu map to non memory area 0"
>>
>>    This print comes when vfio/map-notifier is called for MSI region.
>>
>> vfio map/unmap notification is called for given device
>>    This assumes that devid passed in virtio_iommu_attach is same as devfn
>>    This assumption is based on 1:1 mapping of requested-id with device-id
>>    in QEMU.
>>
>> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
>> ---
>> v2->v3:
>>  - Addressed review comments:
>>     - virtio-iommu_map_region function is split in two functions
>>       virtio_iommu_notify_map/virtio_iommu_notify_unmap
>>     - use size received from driver and do not split in 4K pages
>>  
>>  - map/unmap notification is called for given device/as
>>    This relies on devid passed in virtio_iommu_attach is same as devfn
>>    This is assumed as iommu-map maps 1:1 requested-id to device-id in QEMU
>>    Looking for comment about this assumtion.
>>
>>  - Keeping track devices in address-space
>>
>>  - Verified with 2 PCI endpoints
>>  - some code cleanup
>>
>>  hw/virtio/trace-events           |   5 ++
>>  hw/virtio/virtio-iommu.c         | 163 +++++++++++++++++++++++++++++++++++++++
>>  include/hw/virtio/virtio-iommu.h |   6 ++
>>  3 files changed, 174 insertions(+)
>>
>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> index 8db3d91..7e9663f 100644
>> --- a/hw/virtio/trace-events
>> +++ b/hw/virtio/trace-events
>> @@ -39,3 +39,8 @@ virtio_iommu_unmap_left_interval(uint64_t low, uint64_t high, uint64_t next_low,
>>  virtio_iommu_unmap_right_interval(uint64_t low, uint64_t high, uint64_t next_low, uint64_t next_high) "Unmap right [0x%"PRIx64",0x%"PRIx64"], new interval=[0x%"PRIx64",0x%"PRIx64"]"
>>  virtio_iommu_unmap_inc_interval(uint64_t low, uint64_t high) "Unmap inc [0x%"PRIx64",0x%"PRIx64"]"
>>  virtio_iommu_translate_result(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
>> +virtio_iommu_notify_flag_add(const char *iommu) "Add virtio-iommu notifier node for memory region %s"
>> +virtio_iommu_notify_flag_del(const char *iommu) "Del virtio-iommu notifier node for memory region %s"
>> +virtio_iommu_remap(hwaddr iova, hwaddr pa, hwaddr size) "iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
>> +virtio_iommu_notify_map(hwaddr iova, hwaddr paddr, hwaddr map_size) "iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
>> +virtio_iommu_notify_unmap(hwaddr iova, hwaddr paddr, hwaddr map_size) "iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
> useless paddr
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 9217587..9eae050 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -55,11 +55,13 @@ typedef struct viommu_interval {
>>  typedef struct viommu_dev {
>>      uint32_t id;
>>      viommu_as *as;
>> +    QLIST_ENTRY(viommu_dev) next;
>>  } viommu_dev;
>>  
>>  struct viommu_as {
>>      uint32_t id;
>>      GTree *mappings;
>> +    QLIST_HEAD(, viommu_dev) device_list;
>>  };
>>  
>>  static inline uint16_t virtio_iommu_get_sid(IOMMUDevice *dev)
>> @@ -133,12 +135,70 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>>      }
>>  }
>>  
>> +static void virtio_iommu_notify_map(IOMMUMemoryRegion *mr, hwaddr iova,
>> +                                    hwaddr paddr, hwaddr size)
>> +{
>> +    IOMMUTLBEntry entry;
>> +
>> +    entry.target_as = &address_space_memory;
>> +    entry.addr_mask = size - 1;
>> +
>> +    entry.iova = iova;
>> +    trace_virtio_iommu_notify_map(iova, paddr, size);
>> +    entry.perm = IOMMU_RW;
>> +    entry.translated_addr = paddr;
>> +
>> +    memory_region_notify_iommu(mr, entry);
>> +}
>> +
>> +static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr iova,
>> +                                      hwaddr paddr, hwaddr size)
> unmap() doesn't need to have paddr arg.
>> +{
>> +    IOMMUTLBEntry entry;
>> +
>> +    entry.target_as = &address_space_memory;
>> +    entry.addr_mask = size - 1;
>> +
>> +    entry.iova = iova;
>> +    trace_virtio_iommu_notify_unmap(iova, paddr, size);
> ditto
>> +    entry.perm = IOMMU_NONE;
>> +    entry.translated_addr = 0;
>> +
>> +    memory_region_notify_iommu(mr, entry);
>> +}
>> +
>> +static gboolean virtio_iommu_maping_unmap(gpointer key, gpointer value,
>> +                                          gpointer data)
> s/virtio_iommu_maping_unmap/virtio_iommu_mapping_unmap
>> +{
>> +    viommu_mapping *mapping = (viommu_mapping *) value;
>> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
>> +
>> +    virtio_iommu_notify_unmap(mr, mapping->virt_addr, 0, mapping->size);
>> +
>> +    return true;
you need to return false here as well.
>> +}
>> +
>>  static void virtio_iommu_detach_dev(VirtIOIOMMU *s, viommu_dev *dev)
>>  {
>> +    VirtioIOMMUNotifierNode *node;
>>      viommu_as *as = dev->as;
>> +    int devid = dev->id;
>>  
>>      trace_virtio_iommu_detach(dev->id);
>>  
>> +    /* Remove device from address-space list */
>> +    QLIST_REMOVE(dev, next);
>> +    /* unmap all if no devices attached to address-spaceRemove */
> comment to be reworked
>> +    if (QLIST_EMPTY(&as->device_list)) {
> I don't get why you execute the code below only if the device_list is
> empty. Each time a device is detached don't you need to notify its
> associated iommu_mr?
>> +        QLIST_FOREACH(node, &s->notifiers_list, next) {
>> +            if (devid == node->iommu_dev->devfn) {
>> +                g_tree_foreach(as->mappings, virtio_iommu_maping_unmap,
>> +                               &node->iommu_dev->iommu_mr);
>> +            }
>> +        }
>> +    }
>> +
>> +    /* Remove device from global list */
>>      g_tree_remove(s->devices, GUINT_TO_POINTER(dev->id));
>>      g_tree_unref(as->mappings);
>>  }
>> @@ -171,6 +231,7 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>>      if (!as) {
>>          as = g_malloc0(sizeof(*as));
>>          as->id = asid;
>> +        QLIST_INIT(&as->device_list);
>>          as->mappings = g_tree_new_full((GCompareDataFunc)interval_cmp,
>>                                           NULL, NULL, (GDestroyNotify)g_free);
>>          g_tree_insert(s->address_spaces, GUINT_TO_POINTER(asid), as);
>> @@ -182,6 +243,7 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>>      dev->id = devid;
>>      trace_virtio_iommu_new_devid(devid);
>>      g_tree_insert(s->devices, GUINT_TO_POINTER(devid), dev);
>> +    QLIST_INSERT_HEAD(&as->device_list, dev, next);
>>      g_tree_ref(as->mappings);
You may attach a device on as which already has mappings. In this case
you need to replay the mappings on the iommu mr associated to the
device. So you need something similar to virtio_iommu_map(p)ing_unmap
but for map.

I now have something working with DPDK on top of v0.4. I will provide
you with a branch so that you can analyze my changes in the VFIO
integration.

Thanks

Eric
>>  
>>      return VIRTIO_IOMMU_S_OK;
>> @@ -219,6 +281,8 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
>>      viommu_as *as;
>>      viommu_interval *interval;
>>      viommu_mapping *mapping;
>> +    VirtioIOMMUNotifierNode *node;
>> +    viommu_dev *dev;
>>  
>>      interval = g_malloc0(sizeof(*interval));
>>  
>> @@ -230,6 +294,11 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
>>          return VIRTIO_IOMMU_S_NOENT;
>>      }
>>  
>> +    dev = QLIST_FIRST(&as->device_list);
>> +    if (!dev) {
>> +        return VIRTIO_IOMMU_S_NOENT;
>> +    }
>> +
>>      mapping = g_tree_lookup(as->mappings, (gpointer)interval);
>>      if (mapping) {
>>          g_free(interval);
>> @@ -246,6 +315,14 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
>>  
>>      g_tree_insert(as->mappings, interval, mapping);
>>  
>> +    /* All devices in an address-space share mapping */
>> +    QLIST_FOREACH(node, &s->notifiers_list, next) {
>> +        if (dev->id == node->iommu_dev->devfn) {
>> +            virtio_iommu_notify_map(&node->iommu_dev->iommu_mr, virt_addr,
>> +                                    phys_addr, size);
>> +        }
>> +    }
>> +
>>      return VIRTIO_IOMMU_S_OK;
>>  }
>>  
>> @@ -259,6 +336,8 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>>      viommu_mapping *mapping;
>>      viommu_interval interval;
>>      viommu_as *as;
>> +    VirtioIOMMUNotifierNode *node;
>> +    viommu_dev *dev;
>>  
>>      trace_virtio_iommu_unmap(asid, virt_addr, size, flags);
>>  
>> @@ -267,6 +346,12 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>>          error_report("%s: no as", __func__);
>>          return VIRTIO_IOMMU_S_NOENT;
>>      }
>> +
>> +    dev = QLIST_FIRST(&as->device_list);
>> +    if (!dev) {
>> +        return VIRTIO_IOMMU_S_NOENT;
>> +    }
>> +
>>      interval.low = virt_addr;
>>      interval.high = virt_addr + size - 1;
>>  
>> @@ -296,7 +381,15 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>>          } else {
>>              break;
>>          }
>> +
> extra line
>>          if (interval.low >= interval.high) {
>> +            /* All devices in an address-space share mapping */
>> +            QLIST_FOREACH(node, &s->notifiers_list, next) {
>> +                if (dev->id == node->iommu_dev->devfn) {
>> +                    virtio_iommu_notify_unmap(&node->iommu_dev->iommu_mr, virt_addr,
>> +                                              0, size);
> Why do you notify only a single mr? All devices belonging to the as are
> affected by this change. So don't you need to notify all as device's mr?
>> +                }
>> +            }
>>              return VIRTIO_IOMMU_S_OK;
>>          } else {
>>              mapping = g_tree_lookup(as->mappings, (gpointer)&interval);
>> @@ -439,6 +532,36 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>>      }
>>  }
>>  
>> +static void virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
>> +                                          IOMMUNotifierFlag old,
>> +                                          IOMMUNotifierFlag new)
>> +{
>> +    IOMMUDevice *sdev = container_of(iommu_mr, IOMMUDevice, iommu_mr);
>> +    VirtIOIOMMU *s = sdev->viommu;
>> +    VirtioIOMMUNotifierNode *node = NULL;
>> +    VirtioIOMMUNotifierNode *next_node = NULL;
>> +
>> +    if (old == IOMMU_NOTIFIER_NONE) {
>> +        trace_virtio_iommu_notify_flag_add(iommu_mr->parent_obj.name);
>> +        node = g_malloc0(sizeof(*node));
>> +        node->iommu_dev = sdev;
>> +        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
>> +        return;
>> +    }
>> +
>> +    /* update notifier node with new flags */
>> +    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
>> +        if (node->iommu_dev == sdev) {
>> +            if (new == IOMMU_NOTIFIER_NONE) {
>> +                trace_virtio_iommu_notify_flag_del(iommu_mr->parent_obj.name);
>> +                QLIST_REMOVE(node, next);
>> +                g_free(node);
>> +            }
>> +            return;
>> +        }
>> +    }
>> +}
>> +
>>  static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>                                              IOMMUAccessFlags flag)
>>  {
>> @@ -553,11 +676,49 @@ static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
>>      return (ua > ub) - (ua < ub);
>>  }
>>  
>> +static gboolean virtio_iommu_remap(gpointer key, gpointer value, gpointer data)
>> +{
>> +    viommu_mapping *mapping = (viommu_mapping *) value;
>> +    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
>> +
>> +    trace_virtio_iommu_remap(mapping->virt_addr, mapping->phys_addr,
>> +                             mapping->size);
>> +    /* unmap previous entry and map again */
>> +    virtio_iommu_notify_unmap(mr, mapping->virt_addr, 0, mapping->size);
>> +
>> +    virtio_iommu_notify_map(mr, mapping->virt_addr, mapping->phys_addr,
>> +                            mapping->size);
>> +    return true;
> you need to return false here otherwise  g_tree_foreach will return on
> the first as mapping.
> 
> Thanks
> 
> Eric
>> +}
>> +
>> +static void virtio_iommu_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n)
>> +{
>> +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
>> +    VirtIOIOMMU *s = sdev->viommu;
>> +    uint32_t sid;
>> +    viommu_dev *dev;
>> +
>> +    sid = virtio_iommu_get_sid(sdev);
>> +
>> +    qemu_mutex_lock(&s->mutex);
>> +
>> +    dev = g_tree_lookup(s->devices, GUINT_TO_POINTER(sid));
>> +    if (!dev) {
>> +        goto unlock;
>> +    }
>> +
>> +    g_tree_foreach(dev->as->mappings, virtio_iommu_remap, mr);
>> +
>> +unlock:
>> +    qemu_mutex_unlock(&s->mutex);
>> +}
>> +
>>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>  {
>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>      VirtIOIOMMU *s = VIRTIO_IOMMU(dev);
>>  
>> +    QLIST_INIT(&s->notifiers_list);
>>      virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
>>                  sizeof(struct virtio_iommu_config));
>>  
>> @@ -644,6 +805,8 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
>>      IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
>>  
>>      imrc->translate = virtio_iommu_translate;
>> +    imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
>> +    imrc->replay = virtio_iommu_replay;
>>  }
>>  
>>  static const TypeInfo virtio_iommu_info = {
>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>> index f9c988f..7e04184 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -46,6 +46,11 @@ typedef struct IOMMUPciBus {
>>      IOMMUDevice  *pbdev[0]; /* Parent array is sparse, so dynamically alloc */
>>  } IOMMUPciBus;
>>  
>> +typedef struct VirtioIOMMUNotifierNode {
>> +    IOMMUDevice *iommu_dev;
>> +    QLIST_ENTRY(VirtioIOMMUNotifierNode) next;
>> +} VirtioIOMMUNotifierNode;
>> +
>>  typedef struct VirtIOIOMMU {
>>      VirtIODevice parent_obj;
>>      VirtQueue *vq;
>> @@ -56,6 +61,7 @@ typedef struct VirtIOIOMMU {
>>      GTree *address_spaces;
>>      QemuMutex mutex;
>>      GTree *devices;
>> +    QLIST_HEAD(, VirtioIOMMUNotifierNode) notifiers_list;
>>  } VirtIOIOMMU;
>>  
>>  #endif
>>
