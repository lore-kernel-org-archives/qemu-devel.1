Received: from eggs.gnu.org ([2001:4830:134:3::10]:34855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1djkOr-00031u-0P
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1djkOp-00055r-2p
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:57:41 -0400
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Mon, 21 Aug 2017 10:57:27 +0000
Message-ID: <AM5PR0401MB2545562BA7146B129581C9719A870@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1500017104-3574-1-git-send-email-Bharat.Bhushan@nxp.com>
	<1500017104-3574-3-git-send-email-Bharat.Bhushan@nxp.com>
	<997bdcca-b84c-300c-bca0-5950c17db8d7@redhat.com>
In-Reply-To: <997bdcca-b84c-300c-bca0-5950c17db8d7@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 PATCH 2/2] virtio-iommu: vfio integration
 with virtio-iommu
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

Hi Eric,

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger@redhat.com]
> Sent: Thursday, August 17, 2017 9:03 PM
> To: Bharat Bhushan <bharat.bhushan@nxp.com>;
> eric.auger.pro@gmail.com; peter.maydell@linaro.org;
> alex.williamson@redhat.com; mst@redhat.com; qemu-arm@nongnu.org;
> qemu-devel@nongnu.org
> Cc: wei@redhat.com; kevin.tian@intel.com; marc.zyngier@arm.com;
> tn@semihalf.com; will.deacon@arm.com; drjones@redhat.com;
> robin.murphy@arm.com; christoffer.dall@linaro.org
> Subject: Re: [Qemu-devel] [RFC v2 PATCH 2/2] virtio-iommu: vfio integrati=
on
> with virtio-iommu
>=20
> Hi Bharat,
>=20
> On 14/07/2017 09:25, Bharat Bhushan wrote:
> > This patch allows virtio-iommu protection for PCI device-passthrough.
> >
> > MSI region is mapped by current version of virtio-iommu driver.
> > This MSI region mapping in not getting pushed on hw iommu
> > vfio_get_vaddr() allows only ram-region.
> Why is it an issue. As far as I understand this is not needed actually as=
 the
> guest MSI doorbell is not used by the host.
>  This RFC patch needed
> > to be improved.
> >
> > Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > ---
> > v1-v2:
> >   - Added trace events
> >
> >  hw/virtio/trace-events           |   5 ++
> >  hw/virtio/virtio-iommu.c         | 133
> +++++++++++++++++++++++++++++++++++++++
> >  include/hw/virtio/virtio-iommu.h |   6 ++
> >  3 files changed, 144 insertions(+)
> >
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events index
> > 9196b63..3a3968b 100644
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
> > +virtio_iommu_map_region(hwaddr iova, hwaddr paddr, hwaddr
> map_size) "iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D0x%"PRIx64""
> > +virtio_iommu_unmap_region(hwaddr iova, hwaddr paddr, hwaddr
> map_size) "iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D0x%"PRIx64""
> > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c index
> > cd188fc..61f33cb 100644
> > --- a/hw/virtio/virtio-iommu.c
> > +++ b/hw/virtio/virtio-iommu.c
> > @@ -129,6 +129,48 @@ static gint interval_cmp(gconstpointer a,
> gconstpointer b, gpointer user_data)
> >      }
> >  }
> >
> > +static void virtio_iommu_map_region(VirtIOIOMMU *s, hwaddr iova,
> hwaddr paddr,
> > +                                    hwaddr size, int map)
> bool map?
>=20
> the function name is a bit misleading to me and does not really explain w=
hat
> the function does. It "notifies" so why not using something like
> virtio_iommu_map_notify and virtio_iommu_unmap_notify. I tend to think
> having separate proto is cleaner and more standard.
>=20
> Binding should happen on a specific IOMMUmemoryRegion (see next
> comment).
>=20
> > +{
> > +    VirtioIOMMUNotifierNode *node;
> > +    IOMMUTLBEntry entry;
> > +    uint64_t map_size =3D (1 << 12);
> TODO: handle something else than 4K page.
> > +    int npages;
> > +    int i;
> > +
> > +    npages =3D size / map_size;
> > +    entry.target_as =3D &address_space_memory;
> > +    entry.addr_mask =3D map_size - 1;
> > +
> > +    for (i =3D 0; i < npages; i++) {
> Although I understand we currently fail checking the consistency between
> pIOMMU and vIOMMU page sizes, this will be very slow for guest DPDK use
> case where hugepages are used.
>=20
> Why not directly using the full size?  vfio_iommu_map_notify will report
> errors if vfio_dma_map/unmap() fail.
> > +        entry.iova =3D iova + (i * map_size);
> > +        if (map) {
> > +                trace_virtio_iommu_map_region(iova, paddr, map_size);
> > +                entry.perm =3D IOMMU_RW;
> > +                entry.translated_addr =3D paddr + (i * map_size);
> > +        } else {
> > +                trace_virtio_iommu_unmap_region(iova, paddr, map_size)=
;
> > +                entry.perm =3D IOMMU_NONE;
> > +                entry.translated_addr =3D 0;
> > +        }
> > +
> > +        QLIST_FOREACH(node, &s->notifiers_list, next) {
> > +            memory_region_notify_iommu(&node->iommu_dev->iommu_mr,
> > + entry);
> So as discussed this will notify *all* IOMMU memory regions and all their
> notifiers which is not what we want. You may have a look at
> vsmmuv3 v6 (or intel_iommu) where smmuv3_context_device_invalidate
> retrieves the mr from the sid.

I sent out next version of the patch and I took different approach, I assum=
ed that device-id in
virtio_iommu_attach is stream-id, and same as requested-id. This assumption=
 is because the
"iommu-map" property maps 1:1. Looking forward your view about this.

Hopefully I addressed other comments and fixed/code-rework planned.

Thanks
-Bharat

>=20
> > +        }
> > +    }
> > +}
> > +
> > +static gboolean virtio_iommu_unmap_single(gpointer key, gpointer
> value,
> > +                                          gpointer data) {
> > +    viommu_mapping *mapping =3D (viommu_mapping *) value;
> > +    VirtIOIOMMU *s =3D (VirtIOIOMMU *) data;
> > +
> > +    virtio_iommu_map_region(s, mapping->virt_addr, 0, mapping->size,
> > + 0);
> paddr=3D0? mapping->phys_addr as the trace() will be misleading. But as
> mentioned earlier better use unmap() separate function.
> > +
> > +    return true;
> > +}
> > +
> >  static int virtio_iommu_attach(VirtIOIOMMU *s,
> >                                 struct virtio_iommu_req_attach *req)
> > { @@ -170,10 +212,26 @@ static int virtio_iommu_detach(VirtIOIOMMU
> *s,
> > {
> >      uint32_t devid =3D le32_to_cpu(req->device);
> >      uint32_t reserved =3D le32_to_cpu(req->reserved);
> > +    viommu_dev *dev;
> >      int ret;
> >
> >      trace_virtio_iommu_detach(devid, reserved);
> >
> > +    dev =3D g_tree_lookup(s->devices, GUINT_TO_POINTER(devid));
> > +    if (!dev || !dev->as) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    dev->as->nr_devices--;
> > +
> > +    /* Unmap all if this is last device detached */
> > +    if (dev->as->nr_devices =3D=3D 0) {
> > +        g_tree_foreach(dev->as->mappings, virtio_iommu_unmap_single,
> > + s);
> > +
> > +        g_tree_remove(s->address_spaces, GUINT_TO_POINTER(dev->as-
> >id));
> > +        g_tree_destroy(dev->as->mappings);
> > +    }
> so this should be rebased on new ref count code.
> > +
> >      ret =3D g_tree_remove(s->devices, GUINT_TO_POINTER(devid));
> >
> >      return ret ? VIRTIO_IOMMU_S_OK : VIRTIO_IOMMU_S_INVAL; @@ -
> 217,6
> > +275,7 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
> >
> >      g_tree_insert(as->mappings, interval, mapping);
> >
> > +    virtio_iommu_map_region(s, virt_addr, phys_addr, size, 1);
> >      return VIRTIO_IOMMU_S_OK;
> >  }
> >
> > @@ -267,7 +326,9 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
> >          } else {
> >              break;
> >          }
> > +
> >          if (interval.low >=3D interval.high) {
> > +            virtio_iommu_map_region(s, virt_addr, 0, size, 0);
> >              return VIRTIO_IOMMU_S_OK;
> >          } else {
> >              mapping =3D g_tree_lookup(as->mappings,
> > (gpointer)&interval); @@ -410,6 +471,37 @@ static void
> virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
> >      }
> >  }
> >
> > +static void virtio_iommu_notify_flag_changed(MemoryRegion *iommu,
> > +                                          IOMMUNotifierFlag old,
> > +                                          IOMMUNotifierFlag new) {
> > +    IOMMUDevice *sdev =3D container_of(iommu, IOMMUDevice,
> iommu_mr);
> > +    VirtIOIOMMU *s =3D sdev->viommu;
> > +    VirtioIOMMUNotifierNode *node =3D NULL;
> > +    VirtioIOMMUNotifierNode *next_node =3D NULL;
> > +
> > +    if (old =3D=3D IOMMU_NOTIFIER_NONE) {
> > +        trace_virtio_iommu_notify_flag_add(iommu->name);
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
> > +                trace_virtio_iommu_notify_flag_del(iommu->name);
> > +                QLIST_REMOVE(node, next);
> > +                g_free(node);
> > +            }
> > +            return;
> > +        }
> > +    }
> > +}
> I think all that mechanics should be factorized somewhere else as all
> vIOMMUs use that but this goes beyond the scope of this series.
> > +
> > +
> >  static IOMMUTLBEntry virtio_iommu_translate(MemoryRegion *mr,
> hwaddr addr,
> >                                              IOMMUAccessFlags flag)  {
> > @@ -523,11 +615,50 @@ static gint int_cmp(gconstpointer a, gconstpointe=
r
> b, gpointer user_data)
> >      return (ua > ub) - (ua < ub);
> >  }
> >
> > +static gboolean virtio_iommu_remap(gpointer key, gpointer value,
> > +gpointer data) {
> > +    viommu_mapping *mapping =3D (viommu_mapping *) value;
> > +    VirtIOIOMMU *s =3D (VirtIOIOMMU *) data;
> > +
> > +    trace_virtio_iommu_remap(mapping->virt_addr, mapping->phys_addr,
> > +                             mapping->size);
> > +    /* unmap previous entry and map again */
> > +    virtio_iommu_map_region(s, mapping->virt_addr, 0, mapping->size,
> > + 0);
> > +
> > +    virtio_iommu_map_region(s, mapping->virt_addr, mapping-
> >phys_addr,
> > +                            mapping->size, 1);
> > +    return true;
> > +}
> > +
> > +static void virtio_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
> {
> > +    IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
> > +    VirtIOIOMMU *s =3D sdev->viommu;
> > +    uint32_t sid;
> > +    viommu_dev *dev;
> > +
> > +    sid =3D smmu_get_sid(sdev);
> > +
> > +    qemu_mutex_lock(&s->mutex);
> > +
> > +    dev =3D g_tree_lookup(s->devices, GUINT_TO_POINTER(sid));
> > +    if (!dev) {
> > +        goto unlock;
> > +    }
> > +
> > +    g_tree_foreach(dev->as->mappings, virtio_iommu_remap, s);
> > +
> > +unlock:
> > +    qemu_mutex_unlock(&s->mutex);
> > +    return;
> not needed
>=20
> Thanks
>=20
> Eric
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
> > @@ -538,6 +669,8 @@ static void
> virtio_iommu_device_realize(DeviceState *dev, Error **errp)
> >      s->config.input_range.end =3D -1UL;
> >
> >      s->iommu_ops.translate =3D virtio_iommu_translate;
> > +    s->iommu_ops.notify_flag_changed =3D
> virtio_iommu_notify_flag_changed;
> > +    s->iommu_ops.replay =3D virtio_iommu_replay;
> >      memset(s->as_by_bus_num, 0, sizeof(s->as_by_bus_num));
> >      s->as_by_busptr =3D g_hash_table_new_full(as_uint64_hash,
> >                                              as_uint64_equal, diff
> > --git a/include/hw/virtio/virtio-iommu.h
> > b/include/hw/virtio/virtio-iommu.h
> > index 2259413..76c758d 100644
> > --- a/include/hw/virtio/virtio-iommu.h
> > +++ b/include/hw/virtio/virtio-iommu.h
> > @@ -44,6 +44,11 @@ typedef struct IOMMUPciBus {
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
> > @@ -55,6 +60,7 @@ typedef struct VirtIOIOMMU {
> >      GTree *address_spaces;
> >      QemuMutex mutex;
> >      GTree *devices;
> > +    QLIST_HEAD(, VirtioIOMMUNotifierNode) notifiers_list;
> >  } VirtIOIOMMU;
> >
> >  #endif
> >
