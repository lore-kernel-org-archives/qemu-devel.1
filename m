Received: from eggs.gnu.org ([2001:4830:134:3::10]:37619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f432V-0006qW-Ic
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 07:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f432S-0007WE-DR
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 07:26:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56354 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1f432S-0007U5-7S
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 07:26:44 -0400
References: <20180405104834.10457-1-pagupta@redhat.com>
	<20180405104834.10457-4-pagupta@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ad08ca09-71ee-08d5-3479-8b3d06380a03@redhat.com>
Date: Thu, 5 Apr 2018 13:26:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180405104834.10457-4-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org
Cc: jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, marcel@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com, imammedo@redhat.com

On 05.04.2018 12:48, Pankaj Gupta wrote:
>  This patch adds virtio-pmem Qemu device.
>=20
>  This device configures memory address range information with file
>  backend type. It acts like persistent memory device for KVM guest.
>  It presents the memory address range to virtio-pmem driver over
>  virtio channel and does the block flush whenever there is request
>  from guest to flush/sync. (Qemu part for backing file flush
>  is yet to be implemented).
>=20
>  Current code is a RFC to support guest with persistent memory=20
>  range & DAX.=20
>=20
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  hw/virtio/Makefile.objs                     |   2 +-
>  hw/virtio/virtio-pci.c                      |  44 +++++++++
>  hw/virtio/virtio-pci.h                      |  14 +++
>  hw/virtio/virtio-pmem.c                     | 133 ++++++++++++++++++++=
++++++++
>  include/hw/pci/pci.h                        |   1 +
>  include/hw/virtio/virtio-pmem.h             |  43 +++++++++
>  include/standard-headers/linux/virtio_ids.h |   1 +
>  7 files changed, 237 insertions(+), 1 deletion(-)
>  create mode 100644 hw/virtio/virtio-pmem.c
>  create mode 100644 include/hw/virtio/virtio-pmem.h
>=20
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 765d363c1f..bb5573d2ef 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -5,7 +5,7 @@ common-obj-y +=3D virtio-bus.o
>  common-obj-y +=3D virtio-mmio.o
> =20
>  obj-y +=3D virtio.o virtio-balloon.o=20
> -obj-$(CONFIG_LINUX) +=3D vhost.o vhost-backend.o vhost-user.o
> +obj-$(CONFIG_LINUX) +=3D vhost.o vhost-backend.o vhost-user.o virtio-p=
mem.o
>  obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock.o
>  obj-y +=3D virtio-crypto.o
>  obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-crypto-pci.o
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c20537f31d..114ca05497 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2491,6 +2491,49 @@ static const TypeInfo virtio_rng_pci_info =3D {
>      .class_init    =3D virtio_rng_pci_class_init,
>  };
> =20
> +/* virtio-pmem-pci */
> +
> +static void virtio_pmem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **=
errp)
> +{
> +    VirtIOPMEMPCI *vpmem =3D VIRTIO_PMEM_PCI(vpci_dev);
> +    DeviceState *vdev =3D DEVICE(&vpmem->vdev);
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> +    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> +}
> +
> +static void virtio_pmem_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> +    k->realize =3D virtio_pmem_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_PMEM;
> +    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id =3D PCI_CLASS_OTHERS;
> +}
> +
> +static void virtio_pmem_pci_instance_init(Object *obj)
> +{
> +    VirtIOPMEMPCI *dev =3D VIRTIO_PMEM_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_PMEM);
> +    object_property_add_alias(obj, "memdev", OBJECT(&dev->vdev), "memd=
ev",
> +                              &error_abort);
> +}
> +
> +static const TypeInfo virtio_pmem_pci_info =3D {
> +    .name          =3D TYPE_VIRTIO_PMEM_PCI,
> +    .parent        =3D TYPE_VIRTIO_PCI,
> +    .instance_size =3D sizeof(VirtIOPMEMPCI),
> +    .instance_init =3D virtio_pmem_pci_instance_init,
> +    .class_init    =3D virtio_pmem_pci_class_init,
> +};
> +
> +
>  /* virtio-input-pci */
> =20
>  static Property virtio_input_pci_properties[] =3D {
> @@ -2683,6 +2726,7 @@ static void virtio_pci_register_types(void)
>      type_register_static(&virtio_balloon_pci_info);
>      type_register_static(&virtio_serial_pci_info);
>      type_register_static(&virtio_net_pci_info);
> +    type_register_static(&virtio_pmem_pci_info);
>  #ifdef CONFIG_VHOST_SCSI
>      type_register_static(&vhost_scsi_pci_info);
>  #endif
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index 813082b0d7..fe74fcad3f 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -19,6 +19,7 @@
>  #include "hw/virtio/virtio-blk.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "hw/virtio/virtio-rng.h"
> +#include "hw/virtio/virtio-pmem.h"
>  #include "hw/virtio/virtio-serial.h"
>  #include "hw/virtio/virtio-scsi.h"
>  #include "hw/virtio/virtio-balloon.h"
> @@ -57,6 +58,7 @@ typedef struct VirtIOInputHostPCI VirtIOInputHostPCI;
>  typedef struct VirtIOGPUPCI VirtIOGPUPCI;
>  typedef struct VHostVSockPCI VHostVSockPCI;
>  typedef struct VirtIOCryptoPCI VirtIOCryptoPCI;
> +typedef struct VirtIOPMEMPCI VirtIOPMEMPCI;
> =20
>  /* virtio-pci-bus */
> =20
> @@ -274,6 +276,18 @@ struct VirtIOBlkPCI {
>      VirtIOBlock vdev;
>  };
> =20
> +/*
> + * virtio-pmem-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_PMEM_PCI "virtio-pmem-pci"
> +#define VIRTIO_PMEM_PCI(obj) \
> +        OBJECT_CHECK(VirtIOPMEMPCI, (obj), TYPE_VIRTIO_PMEM_PCI)
> +
> +struct VirtIOPMEMPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VirtIOPMEM vdev;
> +};
> +
>  /*
>   * virtio-balloon-pci: This extends VirtioPCIProxy.
>   */
> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> new file mode 100644
> index 0000000000..28d06fc501
> --- /dev/null
> +++ b/hw/virtio/virtio-pmem.c
> @@ -0,0 +1,133 @@
> +/*
> + * Virtio pmem device
> + *
> + */
> +
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "qemu/error-report.h"
> +#include "hw/virtio/virtio-pmem.h"
> +
> +
> +static void virtio_pmem_system_reset(void *opaque)
> +{
> +
> +}
> +
> +static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtQueueElement *elem;
> +
> +    elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    if (!elem) {
> +        return;
> +    }
> +    /* todo flush raw file */
> +
> +    virtio_notify(vdev, vq);
> +    g_free(elem);
> +
> +}
> +
> +static void virtio_pmem_get_config(VirtIODevice *vdev, uint8_t *config=
)
> +{
> +    VirtIOPMEM *pmem =3D VIRTIO_PMEM(vdev);
> +    struct virtio_pmem_config *pmemcfg =3D (struct virtio_pmem_config =
*) config;
> +
> +    pmemcfg->start =3D pmem->start;
> +    pmemcfg->size  =3D pmem->size;
> +    pmemcfg->align =3D pmem->align;
> +}
> +
> +static uint64_t virtio_pmem_get_features(VirtIODevice *vdev, uint64_t =
features,
> +                                        Error **errp)
> +{
> +    virtio_add_feature(&features, VIRTIO_PMEM_PLUG);
> +    return features;
> +}
> +
> +
> +static void virtio_pmem_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIODevice   *vdev   =3D VIRTIO_DEVICE(dev);
> +    VirtIOPMEM     *pmem   =3D VIRTIO_PMEM(dev);
> +    MachineState   *ms     =3D MACHINE(qdev_get_machine());
> +    MemoryRegion   *mr;
> +    PCMachineState *pcms   =3D PC_MACHINE(object_dynamic_cast(OBJECT(m=
s), TYPE_PC_MACHINE));
> +    uint64_t addr;
> +
> +    if (!pmem->memdev) {
> +        error_setg(errp, "virtio-pmem not set");
> +        return;
> +    }
> +
> +    mr               =3D host_memory_backend_get_memory(pmem->memdev, =
errp);
> +    addr             =3D pcms->hotplug_memory.base;
> +    pmem->start      =3D addr;
> +    pmem->size       =3D memory_region_size(mr);
> +    pmem->align      =3D memory_region_get_alignment(mr);
> +
> +    memory_region_init_alias(&pmem->mr, OBJECT(ms),
> +                             "virtio_pmem-memory", mr, 0, pmem->size);
> +
> +    host_memory_backend_set_mapped(pmem->memdev, true);
> +    virtio_init(vdev, TYPE_VIRTIO_PMEM, VIRTIO_ID_PMEM,
> +                sizeof(struct virtio_pmem_config));
> +
> +    pmem->rq_vq =3D virtio_add_queue(vdev, 128, virtio_pmem_flush);
> +    qemu_register_reset(virtio_pmem_system_reset, pmem);


So right now you're just using some memdev for testing.

I assume that the memory region we will provide to the guest will be a
simple memory mapped raw file. Dirty tracking (using the kvm slot) will
be used to detect which blocks actually changed and have to be flushed
to disk.

Will this raw file already have the "disk information header" (no idea
how that stuff is called) encoded? Are there any plans/possible ways to

a) automatically create the headers? (if that's even possible)
b) support anything but raw files?

Please note that under x86, a KVM memory slot still has a (in my
opinion) fairly big overhead depending on the size of the slot (rmap,
page_track). We might have to optimize that.

--=20

Thanks,

David / dhildenb
