Received: from eggs.gnu.org ([2001:4830:134:3::10]:34171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOZpJ-0005wT-6B
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 22:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gOZpF-0002G8-6R
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 22:02:17 -0500
Date: Mon, 19 Nov 2018 14:01:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181119030131.GG23503@umbus>
References: <20181113083104.2692-1-aik@ozlabs.ru>
	<20181113083104.2692-8-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1giRMj6yz/+FOIRq"
Content-Disposition: inline
In-Reply-To: <20181113083104.2692-8-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu RFC 7/7] spapr: Add NVLink2 pass
 through support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>


--1giRMj6yz/+FOIRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 07:31:04PM +1100, Alexey Kardashevskiy wrote:
> The NVIDIA V100 GPU comes with some on-board RAM which is mapped into
> the host memory space and accessible as normal RAM via NVLink bus.
> The VFIO-PCI driver implements special regions for such GPU and emulated
> NVLink bridge (below referred as NPU). The POWER9 CPU also provides
> address translation services which includes TLB invalidation register
> exposes via the NVLink bridge; the feature is called "ATSD".
>=20
> This adds a quirk to VFIO to map the memory and create an MR; the new MR
> is stored in a GPU as a QOM link. The sPAPR PCI uses this to get the MR
> and map it to the system address space. Another quirk does the same for
> ATSD.
>=20
> This adds 3 additional steps to the FDT builder in spapr-pci:
> 1. Search for specific GPUs and NPUs, collects findings in sPAPRPHBState;
> 2. Adds several properties in the DT: "ibm,npu", "ibm,gpu", "memory-block=
",
> and some other. These are required by the guest platform and GPU driver;
> this also adds a new made-up compatible type for a PHB to signal
> a modified guest that this particular PHB needs the default DMA window
> removed as these GPUs have limited DMA mask size (way lower than usual 59=
);
> 3. Adds new memory blocks with one addition - they have
> "linux,memory-usable" property configured in the way which prevents
> the guest from onlining it automatically as it needs to be deferred till
> the guest GPU driver trains NVLink.
>=20
> A couple of notes:
> - this changes the FDT rendeder as doing 1-2-3 from sPAPRPHBClass::realize
> impossible - devices are not yet attached;
> - this does not add VFIO quirk MRs to the system address space as
> the address is selected in sPAPRPHBState, similar to MMIO.
>=20
> This puts new memory nodes in a separate NUMA node to replicate the host
> system setup as close as possible (the GPU driver relies on this too).
>=20
> This adds fake NPU nodes to make the guest platform code work,
> specifically "ibm,npu-link-index".
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  hw/vfio/pci.h               |   2 +
>  include/hw/pci-host/spapr.h |  28 ++++
>  include/hw/ppc/spapr.h      |   3 +-
>  hw/ppc/spapr.c              |  14 +-
>  hw/ppc/spapr_pci.c          | 256 +++++++++++++++++++++++++++++++++++-
>  hw/vfio/pci-quirks.c        |  93 +++++++++++++
>  hw/vfio/pci.c               |  14 ++
>  hw/vfio/trace-events        |   3 +
>  8 files changed, 408 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index f4c5fb6..b8954cc 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -195,6 +195,8 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **er=
rp);
>  int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>                                 struct vfio_region_info *info,
>                                 Error **errp);
> +int vfio_pci_nvlink2_ram_init(VFIOPCIDevice *vdev, Error **errp);
> +int vfio_pci_npu2_atsd_init(VFIOPCIDevice *vdev, Error **errp);
> =20
>  void vfio_display_reset(VFIOPCIDevice *vdev);
>  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 7c66c38..1f8ebf3 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -87,6 +87,24 @@ struct sPAPRPHBState {
>      uint32_t mig_liobn;
>      hwaddr mig_mem_win_addr, mig_mem_win_size;
>      hwaddr mig_io_win_addr, mig_io_win_size;
> +    hwaddr nv2_gpa_win_addr;
> +    hwaddr nv2_atsd_win_addr;
> +
> +    struct spapr_phb_pci_nvgpu_config {
> +        uint64_t nv2_ram;
> +        uint64_t nv2_atsd;
> +        int num;
> +        struct {
> +            int links;
> +            uint64_t tgt;
> +            uint64_t gpa;
> +            PCIDevice *gpdev;
> +            uint64_t atsd[3];
> +            PCIDevice *npdev[3];
> +        } gpus[6];
> +        uint64_t atsd[64]; /* Big Endian (BE), ready for the DT */
> +        int atsd_num;
> +    } nvgpus;

Is this information always relevant for the PHB, or only for PHBs
which have an NPU or GPU attached to them?  If the latter I'm
wondering if we can allocate it only when necessary.

>  };
> =20
>  #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
> @@ -104,6 +122,16 @@ struct sPAPRPHBState {
> =20
>  #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
> =20
> +#define PHANDLE_PCIDEV(phb, pdev)    (0x12000000 | \
> +                                     (((phb)->index) << 16) | ((pdev)->d=
evfn))
> +#define PHANDLE_GPURAM(phb, n)       (0x110000FF | ((n) << 8) | \
> +                                     (((phb)->index) << 16))
> +#define GPURAM_ASSOCIATIVITY(phb, n) (255 - ((phb)->index * 3 + (n)))
> +#define SPAPR_PCI_NV2RAM64_WIN_BASE  0x10000000000ULL /* 1 TiB */
> +#define SPAPR_PCI_NV2RAM64_WIN_SIZE  0x02000000000ULL
> +#define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8)=
 | \
> +                                     ((gn) << 4) | (nn))

AFAICT many of these values are only used in spapr_pci.c, so I don't
see a reason to put them into the header.

>  static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int=
 pin)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f5dcaf4..0ceca47 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -108,7 +108,8 @@ struct sPAPRMachineClass {
>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
>                            hwaddr *mmio32, hwaddr *mmio64,
> -                          unsigned n_dma, uint32_t *liobns, Error **errp=
);
> +                          unsigned n_dma, uint32_t *liobns, hwaddr *nv2g=
pa,
> +                          hwaddr *nv2atsd, Error **errp);
>      sPAPRResizeHPT resize_hpt_default;
>      sPAPRCapabilities default_caps;
>      sPAPRIrq *irq;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 38a8218..760b0b5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3723,7 +3723,8 @@ static const CPUArchIdList *spapr_possible_cpu_arch=
_ids(MachineState *machine)
>  static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
>                                  uint64_t *buid, hwaddr *pio,
>                                  hwaddr *mmio32, hwaddr *mmio64,
> -                                unsigned n_dma, uint32_t *liobns, Error =
**errp)
> +                                unsigned n_dma, uint32_t *liobns,
> +                                hwaddr *nv2gpa, hwaddr *nv2atsd, Error *=
*errp)
>  {
>      /*
>       * New-style PHB window placement.
> @@ -3770,6 +3771,11 @@ static void spapr_phb_placement(sPAPRMachineState =
*spapr, uint32_t index,
>      *pio =3D SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
>      *mmio32 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
>      *mmio64 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
> +
> +    *nv2gpa =3D SPAPR_PCI_NV2RAM64_WIN_BASE +
> +        (index + 1) * SPAPR_PCI_NV2RAM64_WIN_SIZE;
> +
> +    *nv2atsd =3D SPAPR_PCI_BASE + (index + 8192) * 0x10000;
>  }
> =20
>  static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
> @@ -4182,7 +4188,8 @@ DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
>  static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
>                                uint64_t *buid, hwaddr *pio,
>                                hwaddr *mmio32, hwaddr *mmio64,
> -                              unsigned n_dma, uint32_t *liobns, Error **=
errp)
> +                              unsigned n_dma, uint32_t *liobns,
> +                              hwaddr *nv2_gpa, hwaddr *nv2atsd, Error **=
errp)
>  {
>      /* Legacy PHB placement for pseries-2.7 and earlier machine types */
>      const uint64_t base_buid =3D 0x800000020000000ULL;
> @@ -4226,6 +4233,9 @@ static void phb_placement_2_7(sPAPRMachineState *sp=
apr, uint32_t index,
>       * fallback behaviour of automatically splitting a large "32-bit"
>       * window into contiguous 32-bit and 64-bit windows
>       */
> +
> +    *nv2_gpa =3D 0;
> +    *nv2atsd =3D 0;
>  }
> =20
>  static void spapr_machine_2_7_instance_options(MachineState *machine)
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 58afa46..417ea1d 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1249,6 +1249,7 @@ static uint32_t spapr_phb_get_pci_drc_index(sPAPRPH=
BState *phb,
>  static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int o=
ffset,
>                                         sPAPRPHBState *sphb)
>  {
> +    int i, j;
>      ResourceProps rp;
>      bool is_bridge =3D false;
>      int pci_status;
> @@ -1349,6 +1350,56 @@ static void spapr_populate_pci_child_dt(PCIDevice =
*dev, void *fdt, int offset,
>      if (sphb->pcie_ecs && pci_is_express(dev)) {
>          _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", =
0x1));
>      }
> +
> +    for (i =3D 0; i < sphb->nvgpus.num; ++i) {
> +        PCIDevice *gpdev =3D sphb->nvgpus.gpus[i].gpdev;
> +
> +        if (dev =3D=3D gpdev) {
> +            uint32_t npus[sphb->nvgpus.gpus[i].links];
> +
> +            for (j =3D 0; j < sphb->nvgpus.gpus[i].links; ++j) {
> +                PCIDevice *npdev =3D sphb->nvgpus.gpus[i].npdev[j];
> +
> +                npus[j] =3D cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
> +            }
> +            _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
> +                             j * sizeof(npus[0])));
> +            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> +                                   PHANDLE_PCIDEV(sphb, dev))));
> +        } else {
> +            for (j =3D 0; j < sphb->nvgpus.gpus[i].links; ++j) {
> +                if (dev !=3D sphb->nvgpus.gpus[i].npdev[j]) {
> +                    continue;
> +                }
> +
> +                _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> +                                       PHANDLE_PCIDEV(sphb, dev))));
> +
> +                _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
> +                                      PHANDLE_PCIDEV(sphb, gpdev)));
> +
> +                _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
> +                                       PHANDLE_NVLINK(sphb, i, j))));
> +
> +                /*
> +                 * If we ever want to emulate GPU RAM at the same locati=
on as on
> +                 * the host - here is the encoding GPA->TGT:
> +                 *
> +                 * gta  =3D ((sphb->nv2_gpa >> 42) & 0x1) << 42;
> +                 * gta |=3D ((sphb->nv2_gpa >> 45) & 0x3) << 43;
> +                 * gta |=3D ((sphb->nv2_gpa >> 49) & 0x3) << 45;
> +                 * gta |=3D sphb->nv2_gpa & ((1UL << 43) - 1);
> +                 */
> +                _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
> +                                      PHANDLE_GPURAM(sphb, i)));
> +                _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
> +                                     sphb->nvgpus.gpus[i].tgt));
> +                /* _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink", 0x16=
4)); */
> +                /* Unknown magic value of 9 */
> +                _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed", 9=
));
> +            }
> +        }
> +    }
>  }
> =20
>  /* create OF node for pci device and required OF DT properties */
> @@ -1582,7 +1633,9 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>          smc->phb_placement(spapr, sphb->index,
>                             &sphb->buid, &sphb->io_win_addr,
>                             &sphb->mem_win_addr, &sphb->mem64_win_addr,
> -                           windows_supported, sphb->dma_liobn, &local_er=
r);
> +                           windows_supported, sphb->dma_liobn,
> +                           &sphb->nv2_gpa_win_addr,
> +                           &sphb->nv2_atsd_win_addr, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
> @@ -1829,6 +1882,8 @@ static Property spapr_phb_properties[] =3D {
>                       pre_2_8_migration, false),
>      DEFINE_PROP_BOOL("pcie-extended-configuration-space", sPAPRPHBState,
>                       pcie_ecs, true),
> +    DEFINE_PROP_UINT64("gpa", sPAPRPHBState, nv2_gpa_win_addr, 0),
> +    DEFINE_PROP_UINT64("atsd", sPAPRPHBState, nv2_atsd_win_addr, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -2068,6 +2123,73 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState =
*phb)
> =20
>  }
> =20
> +static void spapr_phb_pci_find_nvgpu(PCIBus *bus, PCIDevice *pdev, void =
*opaque)
> +{
> +    struct spapr_phb_pci_nvgpu_config *nvgpus =3D opaque;
> +    PCIBus *sec_bus;
> +    Object *mr_gpu, *mr_npu;
> +    uint64_t tgt =3D 0, gpa, atsd;
> +    int i;
> +
> +    mr_gpu =3D object_property_get_link(OBJECT(pdev), "nvlink2-mr[0]", N=
ULL);
> +    mr_npu =3D object_property_get_link(OBJECT(pdev), "nvlink2-atsd-mr[0=
]", NULL);
> +    if (mr_gpu) {
> +        tgt =3D object_property_get_uint(mr_gpu, "tgt", NULL);
> +        gpa =3D nvgpus->nv2_ram;
> +        nvgpus->nv2_ram +=3D memory_region_size(MEMORY_REGION(mr_gpu));
> +    } else if (mr_npu) {
> +        tgt =3D object_property_get_uint(mr_npu, "tgt", NULL);
> +        atsd =3D nvgpus->nv2_atsd;
> +        nvgpus->atsd[nvgpus->atsd_num] =3D cpu_to_be64(atsd);
> +        ++nvgpus->atsd_num;
> +        nvgpus->nv2_atsd +=3D memory_region_size(MEMORY_REGION(mr_npu));
> +    }
> +
> +    if (tgt) {

Are you certain 0 can never be a valid tgt value?

> +        for (i =3D 0; i < nvgpus->num; ++i) {
> +            if (nvgpus->gpus[i].tgt =3D=3D tgt) {
> +                break;
> +            }
> +        }
> +
> +        if (i =3D=3D nvgpus->num) {
> +            if (nvgpus->num =3D=3D ARRAY_SIZE(nvgpus->gpus)) {

This means you've run out of space in your array to describe the
system you're dealing with, yes?  In which case you probably want some
sort of error message.

> +                return;
> +            }
> +            ++nvgpus->num;
> +        }
> +
> +        nvgpus->gpus[i].tgt =3D tgt;
> +        if (mr_gpu) {
> +            g_assert(!nvgpus->gpus[i].gpdev);
> +            nvgpus->gpus[i].gpdev =3D pdev;
> +            nvgpus->gpus[i].gpa =3D gpa;
> +        } else {
> +            int j =3D nvgpus->gpus[i].links;
> +
> +            ++nvgpus->gpus[i].links;
> +
> +            g_assert(mr_npu);
> +            g_assert(!nvgpus->gpus[i].npdev[j]);
> +            nvgpus->gpus[i].npdev[j] =3D pdev;
> +            nvgpus->gpus[i].atsd[j] =3D atsd;
> +        }
> +    }
> +
> +    if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=3D
> +         PCI_HEADER_TYPE_BRIDGE)) {
> +        return;
> +    }
> +
> +    sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> +    if (!sec_bus) {
> +        return;
> +    }
> +
> +    pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
> +                        spapr_phb_pci_find_nvgpu, opaque);
> +}
> +
>  int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t xics_phandle, voi=
d *fdt,
>                            uint32_t nr_msis)
>  {
> @@ -2127,7 +2249,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint3=
2_t xics_phandle, void *fdt,
> =20
>      /* Write PHB properties */
>      _FDT(fdt_setprop_string(fdt, bus_off, "device_type", "pci"));
> -    _FDT(fdt_setprop_string(fdt, bus_off, "compatible", "IBM,Logical_PHB=
"));
> +
>      _FDT(fdt_setprop_cell(fdt, bus_off, "#address-cells", 0x3));
>      _FDT(fdt_setprop_cell(fdt, bus_off, "#size-cells", 0x2));
>      _FDT(fdt_setprop_cell(fdt, bus_off, "#interrupt-cells", 0x1));
> @@ -2186,6 +2308,45 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint=
32_t xics_phandle, void *fdt,
>      spapr_phb_pci_enumerate(phb);
>      _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,phb-enumerated", 0x1));
> =20
> +    for (i =3D 0; i < phb->nvgpus.num; ++i) {
> +        PCIDevice *gpdev =3D phb->nvgpus.gpus[i].gpdev;
> +        Object *nvlink2_mrobj =3D object_property_get_link(OBJECT(gpdev),
> +                                                         "nvlink2-mr[0]"=
, NULL);
> +        MemoryRegion *mr =3D MEMORY_REGION(nvlink2_mrobj);
> +
> +        memory_region_del_subregion(get_system_memory(), mr);
> +
> +        for (j =3D 0; j < phb->nvgpus.gpus[i].links; ++j) {
> +            PCIDevice *npdev =3D phb->nvgpus.gpus[i].npdev[j];
> +            Object *nvlink2_mrobj;
> +            nvlink2_mrobj =3D object_property_get_link(OBJECT(npdev),
> +                                                     "nvlink2-atsd-mr[0]=
",
> +                                                     NULL);
> +            if (nvlink2_mrobj) {
> +                MemoryRegion *mr =3D MEMORY_REGION(nvlink2_mrobj);
> +                memory_region_del_subregion(get_system_memory(), mr);
> +            }
> +        }
> +    }
> +
> +    memset(&phb->nvgpus, 0, sizeof(phb->nvgpus));
> +    phb->nvgpus.nv2_ram =3D phb->nv2_gpa_win_addr;
> +    phb->nvgpus.nv2_atsd =3D phb->nv2_atsd_win_addr;
> +    pci_for_each_device(bus, pci_bus_num(bus),
> +                        spapr_phb_pci_find_nvgpu, &phb->nvgpus);
> +    if (phb->nvgpus.num) {
> +        const char compat_npu[] =3D "IBM,Logical_PHB\x00IBM,npu-vphb";
> +
> +        /* 1 GPU and at least one NVLink2 */
> +        _FDT(fdt_setprop(fdt, bus_off, "compatible", compat_npu,
> +                         sizeof(compat_npu)));
> +        _FDT((fdt_setprop(fdt, bus_off, "ibm,mmio-atsd", phb->nvgpus.ats=
d,
> +                          phb->nvgpus.atsd_num *
> +                          sizeof(phb->nvgpus.atsd[0]))));
> +    } else {
> +        _FDT(fdt_setprop_string(fdt, bus_off, "compatible", "IBM,Logical=
_PHB"));
> +    }
> +
>      /* Populate tree nodes with PCI devices attached */
>      s_fdt.fdt =3D fdt;
>      s_fdt.node_off =3D bus_off;
> @@ -2200,6 +2361,97 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint=
32_t xics_phandle, void *fdt,
>          return ret;
>      }
> =20
> +    /* NVLink: Add memory nodes; map GPU RAM and ATSD */
> +    for (i =3D 0; i < phb->nvgpus.num; ++i) {
> +        PCIDevice *gpdev =3D phb->nvgpus.gpus[i].gpdev;
> +        Object *nvlink2_mrobj =3D object_property_get_link(OBJECT(gpdev),
> +                                                         "nvlink2-mr[0]"=
, NULL);
> +        char *mem_name;
> +        int off;
> +        /* For some reason NVLink2 wants a separate NUMA node for its RA=
M */
> +        uint32_t at =3D cpu_to_be32(GPURAM_ASSOCIATIVITY(phb, i));
> +        uint32_t associativity[] =3D { cpu_to_be32(0x4), at, at, at, at =
};
> +        uint64_t nv2_size =3D object_property_get_uint(nvlink2_mrobj,
> +                                                     "size", NULL);
> +        uint64_t mem_reg_property[2] =3D {
> +            cpu_to_be64(phb->nvgpus.gpus[i].gpa), cpu_to_be64(nv2_size) =
};
> +
> +        mem_name =3D g_strdup_printf("memory@" TARGET_FMT_lx,
> +                                   phb->nvgpus.gpus[i].gpa);
> +        off =3D fdt_add_subnode(fdt, 0, mem_name);
> +        _FDT(off);
> +        _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
> +        _FDT((fdt_setprop(fdt, off, "reg", mem_reg_property,
> +                          sizeof(mem_reg_property))));
> +        _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
> +                          sizeof(associativity))));
> +
> +        _FDT((fdt_setprop_string(fdt, off, "compatible",
> +                                 "ibm,coherent-device-memory")));
> +        mem_reg_property[1] =3D 0;
> +        _FDT((fdt_setprop(fdt, off, "linux,usable-memory", mem_reg_prope=
rty,
> +                          sizeof(mem_reg_property))));
> +        /*_FDT((fdt_setprop_cell(fdt, off, "ibm,chip-id", phb->index)));=
 */
> +        _FDT((fdt_setprop_cell(fdt, off, "phandle", PHANDLE_GPURAM(phb, =
i))));
> +
> +        g_free(mem_name);
> +    }
> +
> +    /* NVLink: Add fake NPU Links for NPU bridge's "ibm,nvlink" property=
 */
> +    if (phb->nvgpus.num) {
> +        char *npuname =3D g_strdup_printf("npuphb%d", phb->index);
> +        int npuoff =3D fdt_add_subnode(fdt, 0, npuname);
> +        int linkidx =3D 0;
> +
> +        _FDT(npuoff);
> +        _FDT(fdt_setprop_cell(fdt, npuoff, "#address-cells", 1));
> +        _FDT(fdt_setprop_cell(fdt, npuoff, "#size-cells", 0));
> +        _FDT((fdt_setprop_string(fdt, npuoff, "compatible", "ibm,power9-=
npu")));
> +        g_free(npuname);
> +
> +        for (i =3D 0; i < phb->nvgpus.num; ++i) {
> +            for (j =3D 0; j < phb->nvgpus.gpus[i].links; ++j) {
> +                char *linkname =3D g_strdup_printf("link@%d", linkidx);
> +                int off =3D fdt_add_subnode(fdt, npuoff, linkname);
> +
> +                _FDT(off);
> +                _FDT((fdt_setprop_cell(fdt, off, "reg", linkidx)));
> +                _FDT((fdt_setprop_string(fdt, off, "compatible",
> +                                         "ibm,npu-link")));
> +                _FDT((fdt_setprop_cell(fdt, off, "phandle",
> +                                       PHANDLE_NVLINK(phb, i, j))));
> +                _FDT((fdt_setprop_cell(fdt, off, "ibm,npu-link-index",
> +                                       linkidx)));
> +                g_free(linkname);
> +                ++linkidx;
> +            }
> +        }
> +    }
> +
> +    for (i =3D 0; i < phb->nvgpus.num; ++i) {
> +        PCIDevice *gpdev =3D phb->nvgpus.gpus[i].gpdev;
> +        Object *nvlink2_mrobj =3D object_property_get_link(OBJECT(gpdev),
> +                                                         "nvlink2-mr[0]"=
, NULL);
> +        MemoryRegion *mr =3D MEMORY_REGION(nvlink2_mrobj);
> +
> +        memory_region_add_subregion(get_system_memory(),
> +                                    phb->nvgpus.gpus[i].gpa, mr);
> +
> +        for (j =3D 0; j < phb->nvgpus.gpus[i].links; ++j) {
> +            PCIDevice *npdev =3D phb->nvgpus.gpus[i].npdev[j];
> +            Object *nvlink2_mrobj;
> +            nvlink2_mrobj =3D object_property_get_link(OBJECT(npdev),
> +                                                     "nvlink2-atsd-mr[0]=
",
> +                                                     NULL);
> +            if (nvlink2_mrobj) {
> +                MemoryRegion *mr =3D MEMORY_REGION(nvlink2_mrobj);
> +                memory_region_add_subregion(get_system_memory(),
> +                                            phb->nvgpus.gpus[i].atsd[j],
> +                                            mr);
> +            }
> +        }
> +    }
> +
>      return 0;
>  }
> =20
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 2796837..e655dbc 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -2206,3 +2206,96 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error =
**errp)
> =20
>      return 0;
>  }
> +
> +static void vfio_pci_npu2_atsd_get_tgt(Object *obj, Visitor *v,
> +                                       const char *name,
> +                                       void *opaque, Error **errp)
> +{
> +    uint64_t tgt =3D (uint64_t) opaque;
> +    visit_type_uint64(v, name, &tgt, errp);
> +}
> +
> +int vfio_pci_nvlink2_ram_init(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    int ret;
> +    void *p;
> +    struct vfio_region_info *nv2region =3D NULL;
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_region_info_cap_npu2 *cap;
> +    MemoryRegion *nv2mr =3D g_malloc0(sizeof(*nv2mr));
> +
> +    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> +                                   PCI_VENDOR_ID_NVIDIA,
> +                                   VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RA=
M,
> +                                   &nv2region);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    p =3D mmap(NULL, nv2region->size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +             MAP_SHARED, vdev->vbasedev.fd, nv2region->offset);
> +
> +    if (!p) {
> +        return -errno;
> +    }
> +
> +    memory_region_init_ram_ptr(nv2mr, OBJECT(vdev), "nvlink2-mr",
> +                               nv2region->size, p);
> +
> +    hdr =3D vfio_get_region_info_cap(nv2region, VFIO_REGION_INFO_CAP_NPU=
2);
> +    cap =3D (struct vfio_region_info_cap_npu2 *) hdr;
> +
> +    object_property_add(OBJECT(nv2mr), "tgt", "uint64",
> +                        vfio_pci_npu2_atsd_get_tgt, NULL, NULL,
> +                        (void *) cap->tgt, NULL);
> +    trace_vfio_pci_nvidia_gpu_ram_setup_quirk(vdev->vbasedev.name, cap->=
tgt,
> +                                              nv2region->size);
> +    g_free(nv2region);
> +
> +    return 0;
> +}
> +
> +int vfio_pci_npu2_atsd_init(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    int ret;
> +    void *p;
> +    struct vfio_region_info *atsd_region =3D NULL;
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_region_info_cap_npu2 *cap;
> +    MemoryRegion *atsd_mr =3D g_malloc0(sizeof(*atsd_mr));
> +
> +    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> +                                   PCI_VENDOR_ID_IBM,
> +                                   VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD,
> +                                   &atsd_region);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    p =3D mmap(NULL, atsd_region->size, PROT_READ | PROT_WRITE | PROT_EX=
EC,
> +             MAP_SHARED, vdev->vbasedev.fd, atsd_region->offset);
> +
> +    if (!p) {
> +        return -errno;
> +    }
> +
> +    memory_region_init_ram_device_ptr(atsd_mr, OBJECT(vdev),
> +                                      "nvlink2-atsd-mr",
> +                                      atsd_region->size,
> +                                      p);
> +
> +    hdr =3D vfio_get_region_info_cap(atsd_region, VFIO_REGION_INFO_CAP_N=
PU2);
> +    cap =3D (struct vfio_region_info_cap_npu2 *) hdr;
> +
> +    object_property_add(OBJECT(atsd_mr), "tgt", "uint64",
> +                        vfio_pci_npu2_atsd_get_tgt, NULL, NULL,
> +                        (void *) cap->tgt, NULL);
> +
> +    trace_vfio_pci_npu2_setup_quirk(vdev->vbasedev.name, cap->tgt,
> +                                    atsd_region->size);
> +    g_free(atsd_region);
> +
> +    return 0;
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7848b28..d7de202 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3074,6 +3074,20 @@ static void vfio_realize(PCIDevice *pdev, Error **=
errp)
>          goto out_teardown;
>      }
> =20
> +    if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_NVIDIA && vdev->device_id =
=3D=3D 0x1db1) {
> +        ret =3D vfio_pci_nvlink2_ram_init(vdev, errp);
> +        if (ret) {
> +            error_report("Failed to setup GPU RAM");
> +        }
> +    }
> +
> +    if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_IBM && vdev->device_id =3D=
=3D 0x04ea) {
> +        ret =3D vfio_pci_npu2_atsd_init(vdev, errp);
> +        if (ret) {
> +            error_report("Failed to setup ATSD");
> +        }
> +    }
> +
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index adfa75e..7595009 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -88,6 +88,9 @@ vfio_pci_igd_opregion_enabled(const char *name) "%s"
>  vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
>  vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
> =20
> +vfio_pci_nvidia_gpu_ram_setup_quirk(const char *name, uint64_t tgt, uint=
64_t size) "%s tgt=3D0x%"PRIx64" size=3D0x%"PRIx64
> +vfio_pci_npu2_setup_quirk(const char *name, uint64_t tgt, uint64_t size)=
 "%s tgt=3D0x%"PRIx64" size=3D0x%"PRIx64
> +
>  # hw/vfio/common.c
>  vfio_region_write(const char *name, int index, uint64_t addr, uint64_t d=
ata, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>  vfio_region_read(char *name, int index, uint64_t addr, unsigned size, ui=
nt64_t data) " (%s:region%d+0x%"PRIx64", %d) =3D 0x%"PRIx64

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1giRMj6yz/+FOIRq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvyJ4UACgkQbDjKyiDZ
s5LiWA/9GpNSqAoKibUdvX3CffQugCSZA8/NIz5QbqWVdcr0H88Qkj3d0lQK+tyP
eJi7kzvB5ciESWKo9UCsrkhfPkEsRHr//Z/VGLX25n3Jjfbigx5q/ZpiE9eg+Ir1
ZNr3DB/GflanygqPeYydrSwdzsrQ8lGtpnxWHw1ogoq04WbVXzBuikkDfz8OOpeX
scMWtvVzFgYaYrpcPoFpuRW21GNlXrQM+qNb7KuXRc0Bcsj99sDTldpoQujJ4Pvg
DSs2zZeHHurbTPkY+ecjXuDDEyWAtRenFDYGFVIfmRVePBQTHUg+V1qoA2ksTNK6
qldyJItKBkNg8p17uGEpHPd4ic3/9zDPYog2CT6ejnmLvoEGJWRdOlUAd5JHwwh1
s14cMt1MHgD/tu+MH2mLUuhEVyV5X2iEnwmBK/Yof91zmjGlrX2q3MSH9Zk41O/K
512yrKqTToiXuWm5YXZrza9u0cLfq6zT4tMXe9sgnHJ1VoPU/yF3hjBvZ1f9bbmg
vTVxxSvgzoX3Q84Z32SDT+l0fy8IdGqpcRF9y8GHgu+V7egyxrz/+PxYruwjOUSC
gumqN5FOgONj5/hXlqUEV6uxzWyxbLD41X5cGq95xhtO67KzOuUXseJs9mUiISf7
SrQ1a6rssbqf6M0DyZRwbW6qNRZZvo6OJjHMSuZ0R1TUiBS3sJc=
=EWdB
-----END PGP SIGNATURE-----

--1giRMj6yz/+FOIRq--
