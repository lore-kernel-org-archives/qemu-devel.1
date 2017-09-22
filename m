Received: from eggs.gnu.org ([2001:4830:134:3::10]:37213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dvIeM-00076m-7p
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dvIeJ-0000ND-Us
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:45:26 -0400
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Fri, 22 Sep 2017 07:45:14 +0000
Message-ID: <AM5PR0401MB25458E4A0B2134C51B438E2D9A670@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1503312534-6642-1-git-send-email-Bharat.Bhushan@nxp.com>
	<1503312534-6642-3-git-send-email-Bharat.Bhushan@nxp.com>
	<98b80288-9c4f-874a-9604-aa1a71525a59@redhat.com>
In-Reply-To: <98b80288-9c4f-874a-9604-aa1a71525a59@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Auger Eric <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "wei@redhat.com" <wei@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>



> -----Original Message-----
> From: Auger Eric [mailto:eric.auger@redhat.com]
> Sent: Monday, September 18, 2017 1:18 PM
> To: Bharat Bhushan <bharat.bhushan@nxp.com>;
> eric.auger.pro@gmail.com; peter.maydell@linaro.org;
> alex.williamson@redhat.com; mst@redhat.com; qemu-arm@nongnu.org;
> qemu-devel@nongnu.org
> Cc: wei@redhat.com; kevin.tian@intel.com; marc.zyngier@arm.com;
> tn@semihalf.com; will.deacon@arm.com; drjones@redhat.com;
> robin.murphy@arm.com; christoffer.dall@linaro.org
> Subject: Re: [Qemu-devel] [PATCH v3 2/2] virtio-iommu: vfio integration w=
ith
> virtio-iommu
>=20
> Hi Bharat,
>=20
> On 21/08/2017 12:48, Bharat Bhushan wrote:
> > This RFC patch allows virtio-iommu protection for PCI
> > device-passthrough.
> >
> > MSI region is mapped by current version of virtio-iommu driver.
> > This uses VFIO extension of map/unmap notification when an area of
> > memory is mappedi/unmapped in emulated iommu device.
> >
> > This series is tested with 2 PCI devices to virtual machine using
> > dma-ops and DPDK in VM is not yet tested.
> >
> > Also with this series we observe below prints for MSI region mapping
> >
> >    "qemu-system-aarch64: iommu map to non memory area 0"
> >
> >    This print comes when vfio/map-notifier is called for MSI region.
> >
> > vfio map/unmap notification is called for given device
> >    This assumes that devid passed in virtio_iommu_attach is same as dev=
fn
> >    This assumption is based on 1:1 mapping of requested-id with device-=
id
> >    in QEMU.
> >
> > Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > ---
> > v2->v3:
> >  - Addressed review comments:
> >     - virtio-iommu_map_region function is split in two functions
> >       virtio_iommu_notify_map/virtio_iommu_notify_unmap
> >     - use size received from driver and do not split in 4K pages
> >
> >  - map/unmap notification is called for given device/as
> >    This relies on devid passed in virtio_iommu_attach is same as devfn
> >    This is assumed as iommu-map maps 1:1 requested-id to device-id in
> QEMU
> >    Looking for comment about this assumtion.
> >
> >  - Keeping track devices in address-space
> >
> >  - Verified with 2 PCI endpoints
> >  - some code cleanup
> >
> >  hw/virtio/trace-events           |   5 ++
> >  hw/virtio/virtio-iommu.c         | 163
> +++++++++++++++++++++++++++++++++++++++
> >  include/hw/virtio/virtio-iommu.h |   6 ++
> >  3 files changed, 174 insertions(+)
> >
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events index
> > 8db3d91..7e9663f 100644
> > --- a/hw/virtio/trace-events
> > +++ b/hw/virtio/trace-events
> > @@ -39,3 +39,8 @@ virtio_iommu_unmap_left_interval(uint64_t low,
> > uint64_t high, uint64_t next_low,
> virtio_iommu_unmap_right_interval(uint64_t low, uint64_t high, uint64_t
> next_low, uint64_t next_high) "Unmap right [0x%"PRIx64",0x%"PRIx64"],
> new interval=3D[0x%"PRIx64",0x%"PRIx64"]"
> >  virtio_iommu_unmap_inc_interval(uint64_t low, uint64_t high) "Unmap
> inc [0x%"PRIx64",0x%"PRIx64"]"
> >  virtio_iommu_translate_result(uint64_t virt_addr, uint64_t phys_addr,
> uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
> > +virtio_iommu_notify_flag_add(const char *iommu) "Add virtio-iommu
> notifier node for memory region %s"
> > +virtio_iommu_notify_flag_del(const char *iommu) "Del virtio-iommu
> notifier node for memory region %s"
> > +virtio_iommu_remap(hwaddr iova, hwaddr pa, hwaddr size)
> "iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D0x%"PRIx64""
> > +virtio_iommu_notify_map(hwaddr iova, hwaddr paddr, hwaddr
> map_size) "iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D0x%"PRIx64""
> > +virtio_iommu_notify_unmap(hwaddr iova, hwaddr paddr, hwaddr
> map_size) "iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D0x%"PRIx64""
> useless paddr
> > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c index
> > 9217587..9eae050 100644
> > --- a/hw/virtio/virtio-iommu.c
> > +++ b/hw/virtio/virtio-iommu.c
> > @@ -55,11 +55,13 @@ typedef struct viommu_interval {  typedef struct
> > viommu_dev {
> >      uint32_t id;
> >      viommu_as *as;
> > +    QLIST_ENTRY(viommu_dev) next;
> >  } viommu_dev;
> >
> >  struct viommu_as {
> >      uint32_t id;
> >      GTree *mappings;
> > +    QLIST_HEAD(, viommu_dev) device_list;
> >  };
> >
> >  static inline uint16_t virtio_iommu_get_sid(IOMMUDevice *dev) @@
> > -133,12 +135,70 @@ static gint interval_cmp(gconstpointer a, gconstpoin=
ter
> b, gpointer user_data)
> >      }
> >  }
> >
> > +static void virtio_iommu_notify_map(IOMMUMemoryRegion *mr,
> hwaddr iova,
> > +                                    hwaddr paddr, hwaddr size) {
> > +    IOMMUTLBEntry entry;
> > +
> > +    entry.target_as =3D &address_space_memory;
> > +    entry.addr_mask =3D size - 1;
> > +
> > +    entry.iova =3D iova;
> > +    trace_virtio_iommu_notify_map(iova, paddr, size);
> > +    entry.perm =3D IOMMU_RW;
> > +    entry.translated_addr =3D paddr;
> > +
> > +    memory_region_notify_iommu(mr, entry); }
> > +
> > +static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr,
> hwaddr iova,
> > +                                      hwaddr paddr, hwaddr size)
> unmap() doesn't need to have paddr arg.

Yes, will fix this

> > +{
> > +    IOMMUTLBEntry entry;
> > +
> > +    entry.target_as =3D &address_space_memory;
> > +    entry.addr_mask =3D size - 1;
> > +
> > +    entry.iova =3D iova;
> > +    trace_virtio_iommu_notify_unmap(iova, paddr, size);
> ditto
> > +    entry.perm =3D IOMMU_NONE;
> > +    entry.translated_addr =3D 0;
> > +
> > +    memory_region_notify_iommu(mr, entry); }
> > +
> > +static gboolean virtio_iommu_maping_unmap(gpointer key, gpointer
> value,
> > +                                          gpointer data)
> s/virtio_iommu_maping_unmap/virtio_iommu_mapping_unmap
> > +{
> > +    viommu_mapping *mapping =3D (viommu_mapping *) value;
> > +    IOMMUMemoryRegion *mr =3D (IOMMUMemoryRegion *) data;
> > +
> > +    virtio_iommu_notify_unmap(mr, mapping->virt_addr, 0,
> > + mapping->size);
> > +
> > +    return true;
> > +}
> > +
> >  static void virtio_iommu_detach_dev(VirtIOIOMMU *s, viommu_dev
> *dev)
> > {
> > +    VirtioIOMMUNotifierNode *node;
> >      viommu_as *as =3D dev->as;
> > +    int devid =3D dev->id;
> >
> >      trace_virtio_iommu_detach(dev->id);
> >
> > +    /* Remove device from address-space list */
> > +    QLIST_REMOVE(dev, next);
> > +    /* unmap all if no devices attached to address-spaceRemove */
> comment to be reworked
> > +    if (QLIST_EMPTY(&as->device_list)) {
> I don't get why you execute the code below only if the device_list is emp=
ty.
> Each time a device is detached don't you need to notify its associated
> iommu_mr?

There can be multiple devices share same address space, should not we unmap=
 address space when last device in removed?=20

> > +        QLIST_FOREACH(node, &s->notifiers_list, next) {
> > +            if (devid =3D=3D node->iommu_dev->devfn) {
> > +                g_tree_foreach(as->mappings, virtio_iommu_maping_unmap=
,
> > +                               &node->iommu_dev->iommu_mr);
> > +            }
> > +        }
> > +    }
> > +
> > +    /* Remove device from global list */
> >      g_tree_remove(s->devices, GUINT_TO_POINTER(dev->id));
> >      g_tree_unref(as->mappings);
> >  }
> > @@ -171,6 +231,7 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
> >      if (!as) {
> >          as =3D g_malloc0(sizeof(*as));
> >          as->id =3D asid;
> > +        QLIST_INIT(&as->device_list);
> >          as->mappings =3D g_tree_new_full((GCompareDataFunc)interval_cm=
p,
> >                                           NULL, NULL, (GDestroyNotify)g=
_free);
> >          g_tree_insert(s->address_spaces, GUINT_TO_POINTER(asid), as);
> > @@ -182,6 +243,7 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
> >      dev->id =3D devid;
> >      trace_virtio_iommu_new_devid(devid);
> >      g_tree_insert(s->devices, GUINT_TO_POINTER(devid), dev);
> > +    QLIST_INSERT_HEAD(&as->device_list, dev, next);
> >      g_tree_ref(as->mappings);
> >
> >      return VIRTIO_IOMMU_S_OK;
> > @@ -219,6 +281,8 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
> >      viommu_as *as;
> >      viommu_interval *interval;
> >      viommu_mapping *mapping;
> > +    VirtioIOMMUNotifierNode *node;
> > +    viommu_dev *dev;
> >
> >      interval =3D g_malloc0(sizeof(*interval));
> >
> > @@ -230,6 +294,11 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
> >          return VIRTIO_IOMMU_S_NOENT;
> >      }
> >
> > +    dev =3D QLIST_FIRST(&as->device_list);
> > +    if (!dev) {
> > +        return VIRTIO_IOMMU_S_NOENT;
> > +    }
> > +
> >      mapping =3D g_tree_lookup(as->mappings, (gpointer)interval);
> >      if (mapping) {
> >          g_free(interval);
> > @@ -246,6 +315,14 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
> >
> >      g_tree_insert(as->mappings, interval, mapping);
> >
> > +    /* All devices in an address-space share mapping */
> > +    QLIST_FOREACH(node, &s->notifiers_list, next) {
> > +        if (dev->id =3D=3D node->iommu_dev->devfn) {
> > +            virtio_iommu_notify_map(&node->iommu_dev->iommu_mr,
> virt_addr,
> > +                                    phys_addr, size);
> > +        }
> > +    }
> > +
> >      return VIRTIO_IOMMU_S_OK;
> >  }
> >
> > @@ -259,6 +336,8 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
> >      viommu_mapping *mapping;
> >      viommu_interval interval;
> >      viommu_as *as;
> > +    VirtioIOMMUNotifierNode *node;
> > +    viommu_dev *dev;
> >
> >      trace_virtio_iommu_unmap(asid, virt_addr, size, flags);
> >
> > @@ -267,6 +346,12 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
> >          error_report("%s: no as", __func__);
> >          return VIRTIO_IOMMU_S_NOENT;
> >      }
> > +
> > +    dev =3D QLIST_FIRST(&as->device_list);
> > +    if (!dev) {
> > +        return VIRTIO_IOMMU_S_NOENT;
> > +    }
> > +
> >      interval.low =3D virt_addr;
> >      interval.high =3D virt_addr + size - 1;
> >
> > @@ -296,7 +381,15 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
> >          } else {
> >              break;
> >          }
> > +
> extra line
> >          if (interval.low >=3D interval.high) {
> > +            /* All devices in an address-space share mapping */
> > +            QLIST_FOREACH(node, &s->notifiers_list, next) {
> > +                if (dev->id =3D=3D node->iommu_dev->devfn) {
> > +                    virtio_iommu_notify_unmap(&node->iommu_dev-
> >iommu_mr, virt_addr,
> > +                                              0, size);
> Why do you notify only a single mr? All devices belonging to the as are
> affected by this change. So don't you need to notify all as device's mr?
> > +                }
> > +            }
> >              return VIRTIO_IOMMU_S_OK;
> >          } else {
> >              mapping =3D g_tree_lookup(as->mappings,
> > (gpointer)&interval); @@ -439,6 +532,36 @@ static void
> virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
> >      }
> >  }
> >
> > +static void virtio_iommu_notify_flag_changed(IOMMUMemoryRegion
> *iommu_mr,
> > +                                          IOMMUNotifierFlag old,
> > +                                          IOMMUNotifierFlag new) {
> > +    IOMMUDevice *sdev =3D container_of(iommu_mr, IOMMUDevice,
> iommu_mr);
> > +    VirtIOIOMMU *s =3D sdev->viommu;
> > +    VirtioIOMMUNotifierNode *node =3D NULL;
> > +    VirtioIOMMUNotifierNode *next_node =3D NULL;
> > +
> > +    if (old =3D=3D IOMMU_NOTIFIER_NONE) {
> > +        trace_virtio_iommu_notify_flag_add(iommu_mr-
> >parent_obj.name);
> > +        node =3D g_malloc0(sizeof(*node));
> > +        node->iommu_dev =3D sdev;
> > +        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
> > +        return;
> > +    }
> > +
> > +    /* update notifier node with new flags */
> > +    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
> > +        if (node->iommu_dev =3D=3D sdev) {
> > +            if (new =3D=3D IOMMU_NOTIFIER_NONE) {
> > +                trace_virtio_iommu_notify_flag_del(iommu_mr-
> >parent_obj.name);
> > +                QLIST_REMOVE(node, next);
> > +                g_free(node);
> > +            }
> > +            return;
> > +        }
> > +    }
> > +}
> > +
> >  static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion
> *mr, hwaddr addr,
> >                                              IOMMUAccessFlags flag)  {
> > @@ -553,11 +676,49 @@ static gint int_cmp(gconstpointer a, gconstpointe=
r
> b, gpointer user_data)
> >      return (ua > ub) - (ua < ub);
> >  }
> >
> > +static gboolean virtio_iommu_remap(gpointer key, gpointer value,
> > +gpointer data) {
> > +    viommu_mapping *mapping =3D (viommu_mapping *) value;
> > +    IOMMUMemoryRegion *mr =3D (IOMMUMemoryRegion *) data;
> > +
> > +    trace_virtio_iommu_remap(mapping->virt_addr, mapping->phys_addr,
> > +                             mapping->size);
> > +    /* unmap previous entry and map again */
> > +    virtio_iommu_notify_unmap(mr, mapping->virt_addr, 0,
> > + mapping->size);
> > +
> > +    virtio_iommu_notify_map(mr, mapping->virt_addr, mapping-
> >phys_addr,
> > +                            mapping->size);
> > +    return true;
> you need to return false here otherwise  g_tree_foreach will return on th=
e
> first as mapping.

Yes,

Thanks
-Bharat
>=20
> Thanks
>=20
> Eric
> > +}
> > +
> > +static void virtio_iommu_replay(IOMMUMemoryRegion *mr,
> IOMMUNotifier
> > +*n) {
> > +    IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
> > +    VirtIOIOMMU *s =3D sdev->viommu;
> > +    uint32_t sid;
> > +    viommu_dev *dev;
> > +
> > +    sid =3D virtio_iommu_get_sid(sdev);
> > +
> > +    qemu_mutex_lock(&s->mutex);
> > +
> > +    dev =3D g_tree_lookup(s->devices, GUINT_TO_POINTER(sid));
> > +    if (!dev) {
> > +        goto unlock;
> > +    }
> > +
> > +    g_tree_foreach(dev->as->mappings, virtio_iommu_remap, mr);
> > +
> > +unlock:
> > +    qemu_mutex_unlock(&s->mutex);
> > +}
> > +
> >  static void virtio_iommu_device_realize(DeviceState *dev, Error
> > **errp)  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      VirtIOIOMMU *s =3D VIRTIO_IOMMU(dev);
> >
> > +    QLIST_INIT(&s->notifiers_list);
> >      virtio_init(vdev, "virtio-iommu", VIRTIO_ID_IOMMU,
> >                  sizeof(struct virtio_iommu_config));
> >
> > @@ -644,6 +805,8 @@ static void
> virtio_iommu_memory_region_class_init(ObjectClass *klass,
> >      IOMMUMemoryRegionClass *imrc =3D
> IOMMU_MEMORY_REGION_CLASS(klass);
> >
> >      imrc->translate =3D virtio_iommu_translate;
> > +    imrc->notify_flag_changed =3D virtio_iommu_notify_flag_changed;
> > +    imrc->replay =3D virtio_iommu_replay;
> >  }
> >
> >  static const TypeInfo virtio_iommu_info =3D { diff --git
> > a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> > index f9c988f..7e04184 100644
> > --- a/include/hw/virtio/virtio-iommu.h
> > +++ b/include/hw/virtio/virtio-iommu.h
> > @@ -46,6 +46,11 @@ typedef struct IOMMUPciBus {
> >      IOMMUDevice  *pbdev[0]; /* Parent array is sparse, so dynamically
> > alloc */  } IOMMUPciBus;
> >
> > +typedef struct VirtioIOMMUNotifierNode {
> > +    IOMMUDevice *iommu_dev;
> > +    QLIST_ENTRY(VirtioIOMMUNotifierNode) next; }
> > +VirtioIOMMUNotifierNode;
> > +
> >  typedef struct VirtIOIOMMU {
> >      VirtIODevice parent_obj;
> >      VirtQueue *vq;
> > @@ -56,6 +61,7 @@ typedef struct VirtIOIOMMU {
> >      GTree *address_spaces;
> >      QemuMutex mutex;
> >      GTree *devices;
> > +    QLIST_HEAD(, VirtioIOMMUNotifierNode) notifiers_list;
> >  } VirtIOIOMMU;
> >
> >  #endif
> >
