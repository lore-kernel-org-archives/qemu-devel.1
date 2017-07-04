Received: from eggs.gnu.org ([2001:4830:134:3::10]:52744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dSJtz-0003ms-Kv
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dSJtx-0004yE-KH
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:13:47 -0400
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Tue, 4 Jul 2017 09:13:27 +0000
Message-ID: <AM5PR0401MB2545DC8F3114607C77E57AF19AD70@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<1496851287-9428-7-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1496851287-9428-7-git-send-email-eric.auger@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "drjones@redhat.com" <drjones@redhat.com>, "wei@redhat.com" <wei@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>

Hi Eric,

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: Wednesday, June 07, 2017 9:31 PM
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
> peter.maydell@linaro.org; alex.williamson@redhat.com; mst@redhat.com;
> qemu-arm@nongnu.org; qemu-devel@nongnu.org; jean-
> philippe.brucker@arm.com
> Cc: will.deacon@arm.com; robin.murphy@arm.com; kevin.tian@intel.com;
> marc.zyngier@arm.com; christoffer.dall@linaro.org; drjones@redhat.com;
> wei@redhat.com; tn@semihalf.com; Bharat Bhushan
> <bharat.bhushan@nxp.com>
> Subject: [RFC v2 6/8] virtio-iommu: Implement the translation and
> commands
>=20
> This patch adds the actual implementation for the translation routine
> and the virtio-iommu commands.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v1 -> v2:
> - fix compilation issue reported by autobuild system
> ---
>  hw/virtio/trace-events   |   6 ++
>  hw/virtio/virtio-iommu.c | 202
> +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 202 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 341dbdf..9196b63 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -33,3 +33,9 @@ virtio_iommu_detach(uint32_t dev, uint32_t flags)
> "dev=3D%d flags=3D%d"
>  virtio_iommu_map(uint32_t as, uint64_t phys_addr, uint64_t virt_addr,
> uint64_t size, uint32_t flags) "as=3D %d phys_addr=3D0x%"PRIx64"
> virt_addr=3D0x%"PRIx64" size=3D0x%"PRIx64" flags=3D%d"
>  virtio_iommu_unmap(uint32_t as, uint64_t virt_addr, uint64_t size, uint3=
2_t
> reserved) "as=3D %d virt_addr=3D0x%"PRIx64" size=3D0x%"PRIx64" reserved=
=3D%d"
>  virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, in=
t
> flag) "mr=3D%s rid=3D%d addr=3D0x%"PRIx64" flag=3D%d"
> +virtio_iommu_new_asid(uint32_t asid) "Allocate a new asid=3D%d"
> +virtio_iommu_new_devid(uint32_t devid) "Allocate a new devid=3D%d"
> +virtio_iommu_unmap_left_interval(uint64_t low, uint64_t high, uint64_t
> next_low, uint64_t next_high) "Unmap left [0x%"PRIx64",0x%"PRIx64"],
> new interval=3D[0x%"PRIx64",0x%"PRIx64"]"
> +virtio_iommu_unmap_right_interval(uint64_t low, uint64_t high, uint64_t
> next_low, uint64_t next_high) "Unmap right [0x%"PRIx64",0x%"PRIx64"],
> new interval=3D[0x%"PRIx64",0x%"PRIx64"]"
> +virtio_iommu_unmap_inc_interval(uint64_t low, uint64_t high) "Unmap inc
> [0x%"PRIx64",0x%"PRIx64"]"
> +virtio_iommu_translate_result(uint64_t virt_addr, uint64_t phys_addr,
> uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 902c779..cd188fc 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -32,10 +32,37 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci/pci.h"
>=20
>  /* Max size */
>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>=20
> +typedef struct viommu_as viommu_as;
> +
> +typedef struct viommu_mapping {
> +    uint64_t virt_addr;
> +    uint64_t phys_addr;
> +    uint64_t size;
> +    uint32_t flags;
> +} viommu_mapping;
> +
> +typedef struct viommu_interval {
> +    uint64_t low;
> +    uint64_t high;
> +} viommu_interval;
> +
> +typedef struct viommu_dev {
> +    uint32_t id;
> +    viommu_as *as;
> +} viommu_dev;
> +
> +struct viommu_as {
> +    uint32_t id;
> +    uint32_t nr_devices;
> +    GTree *mappings;
> +};
> +
>  static inline uint16_t smmu_get_sid(IOMMUDevice *dev)
>  {
>      return  ((pci_bus_num(dev->bus) & 0xff) << 8) | dev->devfn;
> @@ -88,6 +115,19 @@ static void virtio_iommu_init_as(VirtIOIOMMU *s)
>      }
>  }
>=20
> +static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer
> user_data)
> +{
> +    viommu_interval *inta =3D (viommu_interval *)a;
> +    viommu_interval *intb =3D (viommu_interval *)b;
> +
> +    if (inta->high <=3D intb->low) {
> +        return -1;
> +    } else if (intb->high <=3D inta->low) {
> +        return 1;
> +    } else {
> +        return 0;
> +    }
> +}
>=20
>  static int virtio_iommu_attach(VirtIOIOMMU *s,
>                                 struct virtio_iommu_req_attach *req)
> @@ -95,10 +135,34 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
>      uint32_t asid =3D le32_to_cpu(req->address_space);
>      uint32_t devid =3D le32_to_cpu(req->device);
>      uint32_t reserved =3D le32_to_cpu(req->reserved);
> +    viommu_as *as;
> +    viommu_dev *dev;
>=20
>      trace_virtio_iommu_attach(asid, devid, reserved);
>=20
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    dev =3D g_tree_lookup(s->devices, GUINT_TO_POINTER(devid));
> +    if (dev) {
> +        return -1;
> +    }
> +
> +    as =3D g_tree_lookup(s->address_spaces, GUINT_TO_POINTER(asid));
> +    if (!as) {
> +        as =3D g_malloc0(sizeof(*as));
> +        as->id =3D asid;
> +        as->mappings =3D g_tree_new_full((GCompareDataFunc)interval_cmp,
> +                                         NULL, NULL, (GDestroyNotify)g_f=
ree);

Created the tree here but seems like missed destroy tree on detach.

Thanks
-Bharat

> +        g_tree_insert(s->address_spaces, GUINT_TO_POINTER(asid), as);
> +        trace_virtio_iommu_new_asid(asid);
> +    }
> +
> +    dev =3D g_malloc0(sizeof(*dev));
> +    dev->as =3D as;
> +    dev->id =3D devid;
> +    as->nr_devices++;
> +    trace_virtio_iommu_new_devid(devid);
> +    g_tree_insert(s->devices, GUINT_TO_POINTER(devid), dev);
> +
> +    return VIRTIO_IOMMU_S_OK;
>  }
>=20
>  static int virtio_iommu_detach(VirtIOIOMMU *s,
> @@ -106,10 +170,13 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
>  {
>      uint32_t devid =3D le32_to_cpu(req->device);
>      uint32_t reserved =3D le32_to_cpu(req->reserved);
> +    int ret;
>=20
>      trace_virtio_iommu_detach(devid, reserved);
>=20
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    ret =3D g_tree_remove(s->devices, GUINT_TO_POINTER(devid));
> +
> +    return ret ? VIRTIO_IOMMU_S_OK : VIRTIO_IOMMU_S_INVAL;
>  }
>=20
>  static int virtio_iommu_map(VirtIOIOMMU *s,
> @@ -120,10 +187,37 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
>      uint64_t virt_addr =3D le64_to_cpu(req->virt_addr);
>      uint64_t size =3D le64_to_cpu(req->size);
>      uint32_t flags =3D le32_to_cpu(req->flags);
> +    viommu_as *as;
> +    viommu_interval *interval;
> +    viommu_mapping *mapping;
> +
> +    interval =3D g_malloc0(sizeof(*interval));
> +
> +    interval->low =3D virt_addr;
> +    interval->high =3D virt_addr + size - 1;
> +
> +    as =3D g_tree_lookup(s->address_spaces, GUINT_TO_POINTER(asid));
> +    if (!as) {
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
> +
> +    mapping =3D g_tree_lookup(as->mappings, (gpointer)interval);
> +    if (mapping) {
> +        g_free(interval);
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
>=20
>      trace_virtio_iommu_map(asid, phys_addr, virt_addr, size, flags);
>=20
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    mapping =3D g_malloc0(sizeof(*mapping));
> +    mapping->virt_addr =3D virt_addr;
> +    mapping->phys_addr =3D phys_addr;
> +    mapping->size =3D size;
> +    mapping->flags =3D flags;
> +
> +    g_tree_insert(as->mappings, interval, mapping);
> +
> +    return VIRTIO_IOMMU_S_OK;
>  }
>=20
>  static int virtio_iommu_unmap(VirtIOIOMMU *s,
> @@ -133,10 +227,64 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>      uint64_t virt_addr =3D le64_to_cpu(req->virt_addr);
>      uint64_t size =3D le64_to_cpu(req->size);
>      uint32_t flags =3D le32_to_cpu(req->flags);
> +    viommu_mapping *mapping;
> +    viommu_interval interval;
> +    viommu_as *as;
>=20
>      trace_virtio_iommu_unmap(asid, virt_addr, size, flags);
>=20
> -    return VIRTIO_IOMMU_S_UNSUPP;
> +    as =3D g_tree_lookup(s->address_spaces, GUINT_TO_POINTER(asid));
> +    if (!as) {
> +        error_report("%s: no as", __func__);
> +        return VIRTIO_IOMMU_S_INVAL;
> +    }
> +    interval.low =3D virt_addr;
> +    interval.high =3D virt_addr + size - 1;
> +
> +    mapping =3D g_tree_lookup(as->mappings, (gpointer)&interval);
> +
> +    while (mapping) {
> +        viommu_interval current;
> +        uint64_t low  =3D mapping->virt_addr;
> +        uint64_t high =3D mapping->virt_addr + mapping->size - 1;
> +
> +        current.low =3D low;
> +        current.high =3D high;
> +
> +        if (low =3D=3D interval.low && size >=3D mapping->size) {
> +            g_tree_remove(as->mappings, (gpointer)&current);
> +            interval.low =3D high + 1;
> +            trace_virtio_iommu_unmap_left_interval(current.low, current.=
high,
> +                interval.low, interval.high);
> +        } else if (high =3D=3D interval.high && size >=3D mapping->size)=
 {
> +            trace_virtio_iommu_unmap_right_interval(current.low, current=
.high,
> +                interval.low, interval.high);
> +            g_tree_remove(as->mappings, (gpointer)&current);
> +            interval.high =3D low - 1;
> +        } else if (low > interval.low && high < interval.high) {
> +            trace_virtio_iommu_unmap_inc_interval(current.low, current.h=
igh);
> +            g_tree_remove(as->mappings, (gpointer)&current);
> +        } else {
> +            break;
> +        }
> +        if (interval.low >=3D interval.high) {
> +            return VIRTIO_IOMMU_S_OK;
> +        } else {
> +            mapping =3D g_tree_lookup(as->mappings, (gpointer)&interval)=
;
> +        }
> +    }
> +
> +    if (mapping) {
> +        error_report("****** %s: Unmap 0x%"PRIx64" size=3D0x%"PRIx64
> +                     " from 0x%"PRIx64" size=3D0x%"PRIx64" is not suppor=
ted",
> +                     __func__, interval.low, size,
> +                     mapping->virt_addr, mapping->size);
> +    } else {
> +        error_report("****** %s: no mapping for
> [0x%"PRIx64",0x%"PRIx64"]",
> +                     __func__, interval.low, interval.high);
> +    }
> +
> +    return VIRTIO_IOMMU_S_INVAL;
>  }
>=20
>  #define get_payload_size(req) (\
> @@ -266,19 +414,46 @@ static IOMMUTLBEntry
> virtio_iommu_translate(MemoryRegion *mr, hwaddr addr,
>                                              IOMMUAccessFlags flag)
>  {
>      IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
> +    VirtIOIOMMU *s =3D sdev->viommu;
>      uint32_t sid;
> +    viommu_dev *dev;
> +    viommu_mapping *mapping;
> +    viommu_interval interval;
> +
> +    interval.low =3D addr;
> +    interval.high =3D addr + 1;
>=20
>      IOMMUTLBEntry entry =3D {
>          .target_as =3D &address_space_memory,
>          .iova =3D addr,
>          .translated_addr =3D addr,
> -        .addr_mask =3D ~(hwaddr)0,
> -        .perm =3D IOMMU_NONE,
> +        .addr_mask =3D (1 << 12) - 1, /* TODO */
> +        .perm =3D 3,
>      };
>=20
>      sid =3D smmu_get_sid(sdev);
>=20
>      trace_virtio_iommu_translate(mr->name, sid, addr, flag);
> +    qemu_mutex_lock(&s->mutex);
> +
> +    dev =3D g_tree_lookup(s->devices, GUINT_TO_POINTER(sid));
> +    if (!dev) {
> +        /* device cannot be attached to another as */
> +        printf("%s sid=3D%d is not known!!\n", __func__, sid);
> +        goto unlock;
> +    }
> +
> +    mapping =3D g_tree_lookup(dev->as->mappings, (gpointer)&interval);
> +    if (!mapping) {
> +        printf("%s no mapping for 0x%"PRIx64" for sid=3D%d\n", __func__,
> +               addr, sid);
> +        goto unlock;
> +    }
> +    entry.translated_addr =3D addr - mapping->virt_addr + mapping-
> >phys_addr,
> +    trace_virtio_iommu_translate_result(addr, entry.translated_addr, sid=
);
> +
> +unlock:
> +    qemu_mutex_unlock(&s->mutex);
>      return entry;
>  }
>=20
> @@ -341,6 +516,12 @@ static inline guint as_uint64_hash(gconstpointer v)
>      return (guint)*(const uint64_t *)v;
>  }
>=20
> +static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data=
)
> +{
> +    uint ua =3D GPOINTER_TO_UINT(a);
> +    uint ub =3D GPOINTER_TO_UINT(b);
> +    return (ua > ub) - (ua < ub);
> +}
>=20
>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>  {
> @@ -362,12 +543,21 @@ static void
> virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>                                              as_uint64_equal,
>                                              g_free, g_free);
>=20
> +    s->address_spaces =3D g_tree_new_full((GCompareDataFunc)int_cmp,
> +                                         NULL, NULL, (GDestroyNotify)g_f=
ree);
> +    s->devices =3D g_tree_new_full((GCompareDataFunc)int_cmp,
> +                                         NULL, NULL, (GDestroyNotify)g_f=
ree);
> +
>      virtio_iommu_init_as(s);
>  }
>=20
>  static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp=
)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIOIOMMU *s =3D VIRTIO_IOMMU(dev);
> +
> +    g_tree_destroy(s->address_spaces);
> +    g_tree_destroy(s->devices);
>=20
>      virtio_cleanup(vdev);
>  }
> --
> 2.5.5
