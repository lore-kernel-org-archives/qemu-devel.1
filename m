Received: from eggs.gnu.org ([2001:4830:134:3::10]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXTa-0007Rm-7M
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXTX-0001mQ-2l
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:08:06 -0500
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Tue, 27 Nov 2018 07:07:56 +0000
Message-ID: <VI1PR04MB4845C9E1E371E73CEB446C5D9AD00@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20181122171538.12359-1-eric.auger@redhat.com>
	<20181122171538.12359-16-eric.auger@redhat.com>
In-Reply-To: <20181122171538.12359-16-eric.auger@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v9 15/17] hw/arm/virt: Add the virtio-iommu
 device tree mappings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>, "tn@semihalf.com" <tn@semihalf.com>, "peterx@redhat.com" <peterx@redhat.com>



> -----Original Message-----
> From: Eric Auger <eric.auger@redhat.com>
> Sent: Thursday, November 22, 2018 10:46 PM
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> mst@redhat.com; jean-philippe.brucker@arm.com
> Cc: kevin.tian@intel.com; tn@semihalf.com; Bharat Bhushan
> <bharat.bhushan@nxp.com>; peterx@redhat.com
> Subject: [RFC v9 15/17] hw/arm/virt: Add the virtio-iommu device tree
> mappings
>=20
> Adds the "virtio,pci-iommu" node in the host bridge node and the RID
> mapping, excluding the IOMMU RID.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Bharat Bhushan <bharat.bhushan@nxp.com>

>=20
> ---
>=20
> v8 -> v9:
> - disable msi-bypass property
> - addition of the subnode is handled is the hotplug handler
>   and IOMMU RID is notimposed anymore
>=20
> v6 -> v7:
> - align to the smmu instantiation code
>=20
> v4 -> v5:
> - VirtMachineClass no_iommu added in this patch
> - Use object_resolve_path_type
> ---
>  hw/arm/virt.c         | 57 +++++++++++++++++++++++++++++++++++++------
>  include/hw/arm/virt.h |  2 ++
>  2 files changed, 52 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c index a2b8d8f7c2..b2bbb0ef49
> 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -29,6 +29,7 @@
>   */
>=20
>  #include "qemu/osdep.h"
> +#include "monitor/qdev.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "hw/arm/arm.h"
> @@ -49,6 +50,7 @@
>  #include "qemu/bitops.h"
>  #include "qemu/error-report.h"
>  #include "hw/pci-host/gpex.h"
> +#include "hw/virtio/virtio-pci.h"
>  #include "hw/arm/sysbus-fdt.h"
>  #include "hw/platform-bus.h"
>  #include "hw/arm/fdt.h"
> @@ -59,6 +61,7 @@
>  #include "qapi/visitor.h"
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
> +#include "hw/virtio/virtio-iommu.h"
>=20
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \ @=
@ -
> 1085,6 +1088,33 @@ static void create_smmu(const VirtMachineState *vms,
> qemu_irq *pic,
>      g_free(node);
>  }
>=20
> +static void create_virtio_iommu(VirtMachineState *vms, Error **errp) {
> +    const char compat[] =3D "virtio,pci-iommu";
> +    uint16_t bdf =3D vms->virtio_iommu_bdf;
> +    char *node;
> +
> +    vms->iommu_phandle =3D qemu_fdt_alloc_phandle(vms->fdt);
> +
> +    node =3D g_strdup_printf("%s/virtio_iommu@%d", vms-
> >pciehb_nodename, bdf);
> +    qemu_fdt_add_subnode(vms->fdt, node);
> +    qemu_fdt_setprop(vms->fdt, node, "compatible", compat,
> sizeof(compat));
> +    qemu_fdt_setprop_sized_cells(vms->fdt, node, "reg",
> +                                 1, bdf << 8 /* phys.hi */,
> +                                 1, 0        /* phys.mid */,
> +                                 1, 0        /* phys.lo  */,
> +                                 1, 0        /* size.hi  */,
> +                                 1, 0        /* size.low */);
> +
> +    qemu_fdt_setprop_cell(vms->fdt, node, "#iommu-cells", 1);
> +    qemu_fdt_setprop_cell(vms->fdt, node, "phandle", vms-
> >iommu_phandle);
> +    g_free(node);
> +
> +    qemu_fdt_setprop_cells(vms->fdt, vms->pciehb_nodename, "iommu-
> map",
> +                           0x0, vms->iommu_phandle, 0x0, bdf,
> +                           bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff
> +- bdf); }
> +
>  static void create_pcie(VirtMachineState *vms, qemu_irq *pic)  {
>      hwaddr base_mmio =3D vms->memmap[VIRT_PCIE_MMIO].base; @@ -
> 1162,7 +1192,7 @@ static void create_pcie(VirtMachineState *vms,
> qemu_irq *pic)
>          }
>      }
>=20
> -    nodename =3D g_strdup_printf("/pcie@%" PRIx64, base);
> +    nodename =3D vms->pciehb_nodename =3D g_strdup_printf("/pcie@%"
> PRIx64,
> + base);
>      qemu_fdt_add_subnode(vms->fdt, nodename);
>      qemu_fdt_setprop_string(vms->fdt, nodename,
>                              "compatible", "pci-host-ecam-generic"); @@ -=
1205,13
> +1235,17 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
>      if (vms->iommu) {
>          vms->iommu_phandle =3D qemu_fdt_alloc_phandle(vms->fdt);
>=20
> -        create_smmu(vms, pic, pci->bus);
> +        switch (vms->iommu) {
> +        case VIRT_IOMMU_SMMUV3:
> +            create_smmu(vms, pic, pci->bus);
> +            qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
> +                                   0x0, vms->iommu_phandle, 0x0, 0x10000=
);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
>=20
> -        qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
> -                               0x0, vms->iommu_phandle, 0x0, 0x10000);
>      }
> -
> -    g_free(nodename);
>  }
>=20
>  static void create_platform_bus(VirtMachineState *vms, qemu_irq *pic)
> @@ -1736,12 +1770,21 @@ static void
> virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                       SYS_BUS_DEVICE(dev));
>          }
>      }
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        PCIDevice *pdev =3D PCI_DEVICE(dev);
> +
> +        vms->iommu =3D VIRT_IOMMU_VIRTIO;
> +        vms->virtio_iommu_bdf =3D pci_get_bdf(pdev);
> +        object_property_set_bool(OBJECT(dev), false, "msi-bypass", errp)=
;
> +        create_virtio_iommu(vms, errp);
> +    }
>  }
>=20
>  static HotplugHandler *virt_machine_get_hotplug_handler(MachineState
> *machine,
>                                                          DeviceState *dev=
)  {
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          return HOTPLUG_HANDLER(machine);
>      }
>=20
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h index
> 4cc57a7ef6..c330f6f4b7 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -115,7 +115,9 @@ typedef struct {
>      bool virt;
>      int32_t gic_version;
>      VirtIOMMUType iommu;
> +    uint16_t virtio_iommu_bdf;
>      struct arm_boot_info bootinfo;
> +    char *pciehb_nodename;
>      const MemMapEntry *memmap;
>      const int *irqmap;
>      int smp_cpus;
> --
> 2.17.2
