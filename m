Received: from eggs.gnu.org ([2001:4830:134:3::10]:59183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dKINe-00034Z-FQ
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 01:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dKINd-0000NR-BZ
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 01:59:14 -0400
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Mon, 12 Jun 2017 05:59:03 +0000
Message-ID: <AM5PR0401MB25452EEAC31C36F5745038619ACD0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1496851287-9428-1-git-send-email-eric.auger@redhat.com>
	<1496851287-9428-6-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1496851287-9428-6-git-send-email-eric.auger@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 5/8] virtio_iommu: Add the iommu regions
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
> Subject: [RFC v2 5/8] virtio_iommu: Add the iommu regions
>=20
> This patch initializes the iommu memory regions so that
> PCIe end point transactions get translated. The translation function
> is not yet implemented at that stage.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/virtio/trace-events   |  1 +
>  hw/virtio/virtio-iommu.c | 97
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+)
>=20
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index fba1da6..341dbdf 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -32,3 +32,4 @@ virtio_iommu_attach(uint32_t as, uint32_t dev, uint32_t
> flags) "as=3D%d dev=3D%d fla
>  virtio_iommu_detach(uint32_t dev, uint32_t flags) "dev=3D%d flags=3D%d"
>  virtio_iommu_map(uint32_t as, uint64_t phys_addr, uint64_t virt_addr,
> uint64_t size, uint32_t flags) "as=3D %d phys_addr=3D0x%"PRIx64"
> virt_addr=3D0x%"PRIx64" size=3D0x%"PRIx64" flags=3D%d"
>  virtio_iommu_unmap(uint32_t as, uint64_t virt_addr, uint64_t size, uint3=
2_t
> reserved) "as=3D %d virt_addr=3D0x%"PRIx64" size=3D0x%"PRIx64" reserved=
=3D%d"
> +virtio_iommu_translate(const char *name, uint32_t rid, uint64_t iova, in=
t
> flag) "mr=3D%s rid=3D%d addr=3D0x%"PRIx64" flag=3D%d"
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index ea1caa7..902c779 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -23,6 +23,7 @@
>  #include "hw/virtio/virtio.h"
>  #include "sysemu/kvm.h"
>  #include "qapi-event.h"
> +#include "qemu/error-report.h"
>  #include "trace.h"
>=20
>  #include "standard-headers/linux/virtio_ids.h"
> @@ -35,6 +36,59 @@
>  /* Max size */
>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>=20
> +static inline uint16_t smmu_get_sid(IOMMUDevice *dev)

This should be virtio-iommu not smmu ?

Thanks
-Bharat

> +{
> +    return  ((pci_bus_num(dev->bus) & 0xff) << 8) | dev->devfn;
> +}
> +
> +static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void
> *opaque,
> +                                              int devfn)
> +{
> +    VirtIOIOMMU *s =3D opaque;
> +    uintptr_t key =3D (uintptr_t)bus;
> +    IOMMUPciBus *sbus =3D g_hash_table_lookup(s->as_by_busptr, &key);
> +    IOMMUDevice *sdev;
> +
> +    if (!sbus) {
> +        uintptr_t *new_key =3D g_malloc(sizeof(*new_key));
> +
> +        *new_key =3D (uintptr_t)bus;
> +        sbus =3D g_malloc0(sizeof(IOMMUPciBus) +
> +                         sizeof(IOMMUDevice *) * IOMMU_PCI_DEVFN_MAX);
> +        sbus->bus =3D bus;
> +        g_hash_table_insert(s->as_by_busptr, new_key, sbus);
> +    }
> +
> +    sdev =3D sbus->pbdev[devfn];
> +    if (!sdev) {
> +        sdev =3D sbus->pbdev[devfn] =3D g_malloc0(sizeof(IOMMUDevice));
> +
> +        sdev->viommu =3D s;
> +        sdev->bus =3D bus;
> +        sdev->devfn =3D devfn;
> +
> +        memory_region_init_iommu(&sdev->iommu_mr, OBJECT(s),
> +                                 &s->iommu_ops, TYPE_VIRTIO_IOMMU,
> +                                 UINT64_MAX);
> +        address_space_init(&sdev->as, &sdev->iommu_mr,
> TYPE_VIRTIO_IOMMU);
> +    }
> +
> +    return &sdev->as;
> +
> +}
> +
> +static void virtio_iommu_init_as(VirtIOIOMMU *s)
> +{
> +    PCIBus *pcibus =3D pci_find_primary_bus();
> +
> +    if (pcibus) {
> +        pci_setup_iommu(pcibus, virtio_iommu_find_add_as, s);
> +    } else {
> +        error_report("No PCI bus, virtio-iommu is not registered");
> +    }
> +}
> +
> +
>  static int virtio_iommu_attach(VirtIOIOMMU *s,
>                                 struct virtio_iommu_req_attach *req)
>  {
> @@ -208,6 +262,26 @@ static void
> virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>      }
>  }
>=20
> +static IOMMUTLBEntry virtio_iommu_translate(MemoryRegion *mr,
> hwaddr addr,
> +                                            IOMMUAccessFlags flag)
> +{
> +    IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
> +    uint32_t sid;
> +
> +    IOMMUTLBEntry entry =3D {
> +        .target_as =3D &address_space_memory,
> +        .iova =3D addr,
> +        .translated_addr =3D addr,
> +        .addr_mask =3D ~(hwaddr)0,
> +        .perm =3D IOMMU_NONE,
> +    };
> +
> +    sid =3D smmu_get_sid(sdev);
> +
> +    trace_virtio_iommu_translate(mr->name, sid, addr, flag);
> +    return entry;
> +}
> +
>  static void virtio_iommu_get_config(VirtIODevice *vdev, uint8_t
> *config_data)
>  {
>      VirtIOIOMMU *dev =3D VIRTIO_IOMMU(vdev);
> @@ -253,6 +327,21 @@ static const VMStateDescription
> vmstate_virtio_iommu_device =3D {
>      },
>  };
>=20
> +/*****************************
> + * Hash Table
> + *****************************/
> +
> +static inline gboolean as_uint64_equal(gconstpointer v1, gconstpointer v=
2)
> +{
> +    return *((const uint64_t *)v1) =3D=3D *((const uint64_t *)v2);
> +}
> +
> +static inline guint as_uint64_hash(gconstpointer v)
> +{
> +    return (guint)*(const uint64_t *)v;
> +}
> +
> +
>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> @@ -266,6 +355,14 @@ static void virtio_iommu_device_realize(DeviceState
> *dev, Error **errp)
>=20
>      s->config.page_sizes =3D ~((1ULL << 12) - 1);
>      s->config.input_range.end =3D -1UL;
> +
> +    s->iommu_ops.translate =3D virtio_iommu_translate;
> +    memset(s->as_by_bus_num, 0, sizeof(s->as_by_bus_num));
> +    s->as_by_busptr =3D g_hash_table_new_full(as_uint64_hash,
> +                                            as_uint64_equal,
> +                                            g_free, g_free);
> +
> +    virtio_iommu_init_as(s);
>  }
>=20
>  static void virtio_iommu_device_unrealize(DeviceState *dev, Error **errp=
)
> --
> 2.5.5
