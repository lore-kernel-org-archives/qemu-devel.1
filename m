Received: from eggs.gnu.org ([209.51.188.92]:36139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guULk-0008U2-7A
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guU8j-0007LR-Cq
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:26:16 -0500
Date: Fri, 15 Feb 2019 14:22:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190215032203.GE4573@umbus.fritz.box>
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214052144.59541-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <20190214052144.59541-5-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2 4/4] spapr: Support NVIDIA V100 GPU
 with NVLink2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 04:21:44PM +1100, Alexey Kardashevskiy wrote:
> NVIDIA V100 GPUs have on-board RAM which is mapped into the host memory
> space and accessible as normal RAM via an NVLink bus. The VFIO-PCI driver
> implements special regions for such GPUs and emulates an NVLink bridge.
> NVLink2-enabled POWER9 CPUs also provide address translation services
> which includes an ATS shootdown (ATSD) register exported via the NVLink
> bridge device.
>=20
> This adds a quirk to VFIO to map the GPU memory and create an MR;
> the new MR is stored in a PCI device as a QOM link. The sPAPR PCI uses
> this to get the MR and map it to the system address space.
> Another quirk does the same for ATSD.
>=20
> This adds 4 additional steps to the FDT builder in spapr-pci:
>=20
> 1. Search for specific GPUs and NPUs and collect findings in
> sPAPRPHBState::nvgpus;
>=20
> 2. Add properties in the device tree such as "ibm,npu", "ibm,gpu",
> "memory-block" and others to advertise the NVLink2 function to the guest;
>=20
> 3. Add new memory blocks with an extra "linux,memory-usable" to prevent
> the guest OS from accessing the new memory until it is online by the GPU
> driver in the guest;
>=20
> 4. Add a npuphb# node representing an NPU unit for every vPHB as
> the GPU driver uses it to detect NPU2 hardware and discover links; this
> is not backed by any QEMU device as it does need to.
>=20
> This allocates space for GPU RAM and ATSD like we do for MMIOs by
> adding 2 new parameters to the phb_placement() hook. Older machine types
> set these to zero.
>=20
> This puts new memory nodes in a separate NUMA node to replicate the host
> system setup as the GPU driver relies on this.
>=20
> This adds requirement similar to EEH - one IOMMU group per vPHB.
> The reason for this is that ATSD registers belong to a physical NPU
> so they cannot invalidate translations on GPUs attached to another NPU.
> It is guaranteed by the host platform as it does not mix NVLink bridges
> or GPUs from different NPU in the same IOMMU group. If more than one
> IOMMU group is detected on a vPHB, this disables ATSD support for that
> vPHB and prints a warning.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> The example command line for redbud system:
>=20
> pbuild/qemu-aiku1804le-ppc64/ppc64-softmmu/qemu-system-ppc64 \
> -nodefaults \
> -chardev stdio,id=3DSTDIO0,signal=3Doff,mux=3Don \
> -device spapr-vty,id=3Dsvty0,reg=3D0x71000110,chardev=3DSTDIO0 \
> -mon id=3DMON0,chardev=3DSTDIO0,mode=3Dreadline -nographic -vga none \
> -enable-kvm -m 384G \
> -chardev socket,id=3DSOCKET0,server,nowait,host=3Dlocalhost,port=3D40000 \
> -mon chardev=3DSOCKET0,mode=3Dcontrol \
> -smp 80,sockets=3D1,threads=3D4 \
> -netdev "tap,id=3DTAP0,helper=3D/home/aik/qemu-bridge-helper --br=3Dbr0" \
> -device "virtio-net-pci,id=3Dvnet0,mac=3D52:54:00:12:34:56,netdev=3DTAP0"=
 \
> img/vdisk0.img \
> -device "vfio-pci,id=3Dvfio0004_04_00_0,host=3D0004:04:00.0" \
> -device "vfio-pci,id=3Dvfio0006_00_00_0,host=3D0006:00:00.0" \
> -device "vfio-pci,id=3Dvfio0006_00_00_1,host=3D0006:00:00.1" \
> -device "vfio-pci,id=3Dvfio0006_00_00_2,host=3D0006:00:00.2" \
> -device "vfio-pci,id=3Dvfio0004_05_00_0,host=3D0004:05:00.0" \
> -device "vfio-pci,id=3Dvfio0006_00_01_0,host=3D0006:00:01.0" \
> -device "vfio-pci,id=3Dvfio0006_00_01_1,host=3D0006:00:01.1" \
> -device "vfio-pci,id=3Dvfio0006_00_01_2,host=3D0006:00:01.2" \
> -device spapr-pci-host-bridge,id=3Dphb1,index=3D1 \
> -device "vfio-pci,id=3Dvfio0035_03_00_0,host=3D0035:03:00.0" \
> -device "vfio-pci,id=3Dvfio0007_00_00_0,host=3D0007:00:00.0" \
> -device "vfio-pci,id=3Dvfio0007_00_00_1,host=3D0007:00:00.1" \
> -device "vfio-pci,id=3Dvfio0007_00_00_2,host=3D0007:00:00.2" \
> -device "vfio-pci,id=3Dvfio0035_04_00_0,host=3D0035:04:00.0" \
> -device "vfio-pci,id=3Dvfio0007_00_01_0,host=3D0007:00:01.0" \
> -device "vfio-pci,id=3Dvfio0007_00_01_1,host=3D0007:00:01.1" \
> -device "vfio-pci,id=3Dvfio0007_00_01_2,host=3D0007:00:01.2" -snapshot \
> -machine pseries \
> -L /home/aik/t/qemu-ppc64-bios/ -d guest_errors
>=20
> Note that QEMU attaches PCI devices to the last added vPHB so first
> 8 devices - 4:04:00.0 till 6:00:01.2 - go to the default vPHB, and
> 35:03:00.0..7:00:01.2 to the vPHB with id=3Dphb1.
> ---
>  hw/vfio/pci.h               |   2 +
>  include/hw/pci-host/spapr.h |   9 +
>  include/hw/ppc/spapr.h      |   3 +-
>  hw/ppc/spapr.c              |  25 ++-
>  hw/ppc/spapr_pci.c          | 333 +++++++++++++++++++++++++++++++++++-
>  hw/vfio/pci-quirks.c        | 120 +++++++++++++
>  hw/vfio/pci.c               |  14 ++
>  hw/vfio/trace-events        |   4 +
>  8 files changed, 506 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index b1ae4c0..706c304 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -194,6 +194,8 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **er=
rp);
>  int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>                                 struct vfio_region_info *info,
>                                 Error **errp);
> +int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp);
> +int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp);
> =20
>  void vfio_display_reset(VFIOPCIDevice *vdev);
>  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index 51d81c4..4a665cb 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -87,6 +87,9 @@ struct sPAPRPHBState {
>      uint32_t mig_liobn;
>      hwaddr mig_mem_win_addr, mig_mem_win_size;
>      hwaddr mig_io_win_addr, mig_io_win_size;
> +    hwaddr nv2_gpa_win_addr;
> +    hwaddr nv2_atsd_win_addr;
> +    struct spapr_phb_pci_nvgpu_config *nvgpus;
>  };
> =20
>  #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
> @@ -105,6 +108,12 @@ struct sPAPRPHBState {
> =20
>  #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
> =20
> +#define SPAPR_PCI_NV2RAM64_WIN_BASE  0x10000000000ULL /* 1 TiB */

This is not a good choice - we have POWER machines with well over 1
TiB RAM, and so it's also plausible we can get guests with over 1 TiB
RAM which will collide with this.  Especially likely with the sort of
giant HPC guests that are most likely to have the GPUs passed through
to them.

This is why we already moved the main PCI MMIO windows up to 32 TiB
=66rom the lower address they used to have.

> +#define SPAPR_PCI_NV2RAM64_WIN_SIZE  0x10000000000ULL /* 1 TiB for all 6=
xGPUs */
> +
> +#define SPAPR_PCI_NV2ATSD_WIN_BASE   SPAPR_PCI_LIMIT
> +#define SPAPR_PCI_NV2ATSD_WIN_SIZE   (16 * 0x10000)
> +
>  static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int=
 pin)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index cbd276e..d9edf23 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -112,7 +112,8 @@ struct sPAPRMachineClass {
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
> index b967024..d18834c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3844,7 +3844,8 @@ static const CPUArchIdList *spapr_possible_cpu_arch=
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
> @@ -3889,6 +3890,9 @@ static void spapr_phb_placement(sPAPRMachineState *=
spapr, uint32_t index,
>      *pio =3D SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
>      *mmio32 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_SIZE;
>      *mmio64 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
> +
> +    *nv2gpa =3D SPAPR_PCI_NV2RAM64_WIN_BASE + index * SPAPR_PCI_NV2RAM64=
_WIN_SIZE;
> +    *nv2atsd =3D SPAPR_PCI_NV2ATSD_WIN_BASE + index * SPAPR_PCI_NV2ATSD_=
WIN_SIZE;
>  }
> =20
>  static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
> @@ -4090,6 +4094,18 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
>  /*
>   * pseries-3.1
>   */
> +static void phb_placement_3_1(sPAPRMachineState *spapr, uint32_t index,
> +                              uint64_t *buid, hwaddr *pio,
> +                              hwaddr *mmio32, hwaddr *mmio64,
> +                              unsigned n_dma, uint32_t *liobns,
> +                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **e=
rrp)
> +{
> +    spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_dma, =
liobns,
> +                        nv2gpa, nv2atsd, errp);
> +    *nv2gpa =3D 0;
> +    *nv2atsd =3D 0;
> +}
> +
>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> @@ -4098,6 +4114,7 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
>      compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      smc->update_dt_enabled =3D false;
> +    smc->phb_placement =3D phb_placement_3_1;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> @@ -4229,7 +4246,8 @@ DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
>  static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
>                                uint64_t *buid, hwaddr *pio,
>                                hwaddr *mmio32, hwaddr *mmio64,
> -                              unsigned n_dma, uint32_t *liobns, Error **=
errp)
> +                              unsigned n_dma, uint32_t *liobns,
> +                              hwaddr *nv2gpa, hwaddr *nv2atsd, Error **e=
rrp)
>  {
>      /* Legacy PHB placement for pseries-2.7 and earlier machine types */
>      const uint64_t base_buid =3D 0x800000020000000ULL;
> @@ -4273,6 +4291,9 @@ static void phb_placement_2_7(sPAPRMachineState *sp=
apr, uint32_t index,
>       * fallback behaviour of automatically splitting a large "32-bit"
>       * window into contiguous 32-bit and 64-bit windows
>       */
> +
> +    *nv2gpa =3D 0;
> +    *nv2atsd =3D 0;
>  }
> =20
>  static void spapr_machine_2_7_class_options(MachineClass *mc)
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index c3fb0ac..04a679e 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -50,6 +50,46 @@
>  #include "sysemu/hostmem.h"
>  #include "sysemu/numa.h"
> =20
> +#define PHANDLE_PCIDEV(phb, pdev)    (0x12000000 | \
> +                                     (((phb)->index) << 16) | ((pdev)->d=
evfn))
> +#define PHANDLE_GPURAM(phb, n)       (0x110000FF | ((n) << 8) | \
> +                                     (((phb)->index) << 16))
> +/* NVLink2 wants a separate NUMA node for its RAM */
> +#define GPURAM_ASSOCIATIVITY(phb, n) (255 - ((phb)->index * 3 + (n)))

IIUC this gives you non zero-based indices for the associtivity
property.  That's going to make a real mess of
ibm,max-associativity-domains.

> +#define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8)=
 | \
> +                                     ((gn) << 4) | (nn))
> +
> +/* Max number of these GPUs per a physical box */
> +#define NVGPU_MAX_NUM                6
> +
> +/* Max number of NVLinks per GPU in any physical box */
> +#define NVGPU_MAX_LINKS              3
> +
> +/*
> + * One NVLink bridge provides one ATSD register so it should be 18.
> + * In practice though since we allow only one group per vPHB

Uh.. we do?  Do you mean iommu group here?  We used to enforce one per
vPHB, but that's no longer the case.  Or have you reintroduced that
restriction?

> which equals
> + * to an NPU2 which has maximum 6 NVLink bridges.
> + */
> +#define NVGPU_MAX_ATSD               6
> +
> +struct spapr_phb_pci_nvgpu_config {
> +    uint64_t nv2_ram_current;
> +    uint64_t nv2_atsd_current;
> +    int num; /* number of valid entries in gpus[] */
> +    int gpunum; /* number of entries in gpus[] with gpdev!=3DNULL */
> +    struct {
> +        int links;
> +        uint64_t tgt;
> +        uint64_t gpa;
> +        PCIDevice *gpdev;
> +        uint64_t atsd_gpa[NVGPU_MAX_LINKS];
> +        PCIDevice *npdev[NVGPU_MAX_LINKS];
> +        uint32_t link_speed[NVGPU_MAX_LINKS];
> +    } gpus[NVGPU_MAX_NUM];
> +    uint64_t atsd_prop[NVGPU_MAX_ATSD]; /* Big Endian for DT */
> +    int atsd_num;
> +};
> +
>  /* Copied from the kernel arch/powerpc/platforms/pseries/msi.c */
>  #define RTAS_QUERY_FN           0
>  #define RTAS_CHANGE_FN          1
> @@ -1255,6 +1295,7 @@ static uint32_t spapr_phb_get_pci_drc_index(sPAPRPH=
BState *phb,
>  static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int o=
ffset,
>                                         sPAPRPHBState *sphb)
>  {
> +    int i, j;
>      ResourceProps rp;
>      bool is_bridge =3D false;
>      int pci_status;
> @@ -1355,6 +1396,60 @@ static void spapr_populate_pci_child_dt(PCIDevice =
*dev, void *fdt, int offset,
>      if (sphb->pcie_ecs && pci_is_express(dev)) {
>          _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", =
0x1));
>      }
> +
> +    if (sphb->nvgpus) {
> +        for (i =3D 0; i < sphb->nvgpus->num; ++i) {

So, if nvgpus->num is the number of valid entries in the table..

> +            PCIDevice *gpdev =3D sphb->nvgpus->gpus[i].gpdev;
> +
> +            if (!gpdev) {

=2E.but you can also have gaps, couldn't you miss some if the table is spar=
se?

> +                continue;
> +            }
> +            if (dev =3D=3D gpdev) {
> +                uint32_t npus[sphb->nvgpus->gpus[i].links];
> +
> +                for (j =3D 0; j < sphb->nvgpus->gpus[i].links; ++j) {
> +                    PCIDevice *npdev =3D sphb->nvgpus->gpus[i].npdev[j];
> +
> +                    npus[j] =3D cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
> +                }
> +                _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
> +                                 j * sizeof(npus[0])));
> +                _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> +                                       PHANDLE_PCIDEV(sphb, dev))));
> +                continue;
> +            }
> +            for (j =3D 0; j < sphb->nvgpus->gpus[i].links; ++j) {
> +                if (dev !=3D sphb->nvgpus->gpus[i].npdev[j]) {
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
> +                                     sphb->nvgpus->gpus[i].tgt));
> +                _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
> +                                      sphb->nvgpus->gpus[i].link_speed[j=
]));
> +            }
> +        }
> +    }
>  }
> =20
>  /* create OF node for pci device and required OF DT properties */
> @@ -1596,7 +1691,9 @@ static void spapr_phb_realize(DeviceState *dev, Err=
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
> @@ -1843,6 +1940,8 @@ static Property spapr_phb_properties[] =3D {
>                       pre_2_8_migration, false),
>      DEFINE_PROP_BOOL("pcie-extended-configuration-space", sPAPRPHBState,
>                       pcie_ecs, true),
> +    DEFINE_PROP_UINT64("gpa", sPAPRPHBState, nv2_gpa_win_addr, 0),
> +    DEFINE_PROP_UINT64("atsd", sPAPRPHBState, nv2_atsd_win_addr, 0),

Now that index is mandatory it's probably not essential to have these
properties, although I guess they don't hurt.

>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -2069,6 +2168,80 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState =
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
> +    uint64_t tgt =3D 0, gpa, atsd =3D 0;
> +    int i;
> +
> +    mr_gpu =3D object_property_get_link(OBJECT(pdev), "nvlink2-mr[0]", N=
ULL);
> +    mr_npu =3D object_property_get_link(OBJECT(pdev), "nvlink2-atsd-mr[0=
]", NULL);
> +    if (mr_gpu) {
> +        gpa =3D nvgpus->nv2_ram_current;
> +        nvgpus->nv2_ram_current +=3D memory_region_size(MEMORY_REGION(mr=
_gpu));

Hrm.  Changing persistent state in a function called "find" makes me
nervous.

> +    } else if (mr_npu) {
> +        if (nvgpus->atsd_num =3D=3D ARRAY_SIZE(nvgpus->atsd_prop)) {
> +            warn_report("Found too many ATSD registers per vPHB");
> +        } else {
> +            atsd =3D nvgpus->nv2_atsd_current;
> +            nvgpus->atsd_prop[nvgpus->atsd_num] =3D cpu_to_be64(atsd);
> +            ++nvgpus->atsd_num;
> +            nvgpus->nv2_atsd_current +=3D
> +                memory_region_size(MEMORY_REGION(mr_npu));
> +        }
> +    }
> +
> +    tgt =3D object_property_get_uint(OBJECT(pdev), "tgt", NULL);

It seems like you ought to have an object_dynamic_cast() up the top of
here to see if is a device you care about.  I guess you'd get away
with it in practice because other devices won't have the properties
you test for, but I'd prefer not to rely on that (especially since
"tgt" is such a brief, generic name, which come to think of it might
be a good idea to change anyway).

This would probably also be clearer if you have the recursing over
bridges in one function and the handling of a single specific device
you're interested in delegated to a another function.

> +    if (tgt) {
> +        for (i =3D 0; i < nvgpus->num; ++i) {
> +            if (nvgpus->gpus[i].tgt =3D=3D tgt) {
> +                break;
> +            }
> +        }
> +
> +        if (i =3D=3D nvgpus->num) {
> +            if (nvgpus->num =3D=3D ARRAY_SIZE(nvgpus->gpus)) {
> +                warn_report("Found too many NVLink bridges per GPU");
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
> +            ++nvgpus->gpunum;
> +        } else {
> +            int j =3D nvgpus->gpus[i].links;
> +
> +            ++nvgpus->gpus[i].links;
> +
> +            g_assert(!nvgpus->gpus[i].npdev[j]);
> +            nvgpus->gpus[i].npdev[j] =3D pdev;
> +            nvgpus->gpus[i].atsd_gpa[j] =3D atsd;
> +            nvgpus->gpus[i].link_speed[j] =3D
> +                    object_property_get_uint(OBJECT(pdev), "link_speed",=
 NULL);
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
>  int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, voi=
d *fdt,
>                            uint32_t nr_msis)
>  {
> @@ -2187,6 +2360,69 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint=
32_t intc_phandle, void *fdt,
>      spapr_phb_pci_enumerate(phb);
>      _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,phb-enumerated", 0x1));
> =20
> +    /* If there are existing NVLink2 MRs, unmap those before recreating =
*/

Unmapping regions shouldn't be in a function that's about populating
the dt, it probably wants to be part of the reset path.

> +    if (phb->nvgpus) {
> +        for (i =3D 0; i < phb->nvgpus->num; ++i) {
> +            PCIDevice *gpdev =3D phb->nvgpus->gpus[i].gpdev;
> +            Object *nv_mrobj =3D object_property_get_link(OBJECT(gpdev),
> +                                                        "nvlink2-mr[0]",=
 NULL);
> +
> +            if (nv_mrobj) {
> +                memory_region_del_subregion(get_system_memory(),
> +                                            MEMORY_REGION(nv_mrobj));
> +            }
> +            for (j =3D 0; j < phb->nvgpus->gpus[i].links; ++j) {
> +                PCIDevice *npdev =3D phb->nvgpus->gpus[i].npdev[j];
> +                Object *atsd_mrobj;
> +                atsd_mrobj =3D object_property_get_link(OBJECT(npdev),
> +                                                         "nvlink2-atsd-m=
r[0]",
> +                                                         NULL);
> +                if (atsd_mrobj) {
> +                    memory_region_del_subregion(get_system_memory(),
> +                                                MEMORY_REGION(atsd_mrobj=
));
> +                }
> +            }
> +        }
> +        g_free(phb->nvgpus);
> +        phb->nvgpus =3D NULL;
> +    }
> +
> +    /* Search for GPUs and NPUs */
> +    if (phb->nv2_gpa_win_addr && phb->nv2_atsd_win_addr) {
> +        phb->nvgpus =3D g_new0(struct spapr_phb_pci_nvgpu_config, 1);

Likewise creating this internal state shouldn't be in a dt creation
function.

> +        phb->nvgpus->nv2_ram_current =3D phb->nv2_gpa_win_addr;
> +        phb->nvgpus->nv2_atsd_current =3D phb->nv2_atsd_win_addr;
> +
> +        pci_for_each_device(bus, pci_bus_num(bus),
> +                            spapr_phb_pci_find_nvgpu, phb->nvgpus);
> +
> +        if (!phb->nvgpus->gpunum) {
> +            /* We did not find any interesting GPU */
> +            g_free(phb->nvgpus);
> +            phb->nvgpus =3D NULL;
> +        } else {
> +            /*
> +             * ibm,mmio-atsd contains ATSD registers; these belong to an=
 NPU PHB
> +             * which we do not emulate as a separate device. Instead we =
put
> +             * ibm,mmio-atsd to the vPHB with GPU and make sure that we =
do not
> +             * put GPUs from different IOMMU groups to the same vPHB to =
ensure
> +             * that the guest will use ATSDs from the corresponding NPU.
> +             */
> +            if (!spapr_phb_eeh_available(phb)) {

That's making assumptions about what spapr_phb_eeh_available() tests
which might not always be warranted.

> +                warn_report("ATSD requires a separate vPHB per GPU IOMMU=
 group");
> +            } else if (!phb->nvgpus->atsd_num) {
> +                warn_report("No ATSD registers found");
> +            } else if (phb->nvgpus->atsd_num > 8) {
> +                warn_report("Bogus ATSD configuration is found");
> +            } else {
> +                _FDT((fdt_setprop(fdt, bus_off, "ibm,mmio-atsd",
> +                                  phb->nvgpus->atsd_prop,
> +                                  phb->nvgpus->atsd_num *
> +                                  sizeof(phb->nvgpus->atsd_prop[0]))));
> +            }
> +        }
> +    }
> +
>      /* Populate tree nodes with PCI devices attached */
>      s_fdt.fdt =3D fdt;
>      s_fdt.node_off =3D bus_off;
> @@ -2201,6 +2437,101 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uin=
t32_t intc_phandle, void *fdt,
>          return ret;
>      }
> =20
> +    if (phb->nvgpus) {
> +        /* Add memory nodes for GPU RAM and mark them unusable */
> +        for (i =3D 0; i < phb->nvgpus->num; ++i) {
> +            PCIDevice *gpdev =3D phb->nvgpus->gpus[i].gpdev;
> +            Object *nv_mrobj =3D object_property_get_link(OBJECT(gpdev),
> +                                                        "nvlink2-mr[0]",=
 NULL);
> +            char *mem_name;
> +            int off;
> +            uint32_t at =3D cpu_to_be32(GPURAM_ASSOCIATIVITY(phb, i));
> +            uint32_t associativity[] =3D { cpu_to_be32(0x4), at, at, at,=
 at };

Putting at at every level of the associativity property seems bogus.

I mean it's kind of bogus we have 4 or 5 levels of associativity
anyway (I think that was just copied from a PowerVM setup).  At
present level 4 is the qemu node, and the ones above it are always 0.

Possibly it would make sense for one of the higher levels to indicate
system vs. NVLink RAM (0 or 1), then a single value for which NVLink
node at level 4.

> +            uint64_t nv2_size =3D object_property_get_uint(nv_mrobj,
> +                                                         "size", NULL);
> +            uint64_t mem_reg_property[2] =3D {

If there's a newline here..

> +                cpu_to_be64(phb->nvgpus->gpus[i].gpa), cpu_to_be64(nv2_s=
ize) };

=2E.there should be one here ..............................................=
=2E....^

> +
> +            mem_name =3D g_strdup_printf("memory@%lx", phb->nvgpus->gpus=
[i].gpa);
> +            off =3D fdt_add_subnode(fdt, 0, mem_name);
> +            _FDT(off);
> +            _FDT((fdt_setprop_string(fdt, off, "device_type", "memory"))=
);
> +            _FDT((fdt_setprop(fdt, off, "reg", mem_reg_property,
> +                              sizeof(mem_reg_property))));
> +            _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativi=
ty,
> +                              sizeof(associativity))));
> +
> +            _FDT((fdt_setprop_string(fdt, off, "compatible",
> +                                     "ibm,coherent-device-memory")));
> +            mem_reg_property[1] =3D 0;
> +            _FDT((fdt_setprop(fdt, off, "linux,usable-memory", mem_reg_p=
roperty,
> +                              sizeof(mem_reg_property))));
> +            _FDT((fdt_setprop_cell(fdt, off, "phandle",
> +                                   PHANDLE_GPURAM(phb, i))));
> +
> +            g_free(mem_name);
> +        }
> +
> +        /* Add NPUs with links underneath */
> +        if (phb->nvgpus->num) {
> +            char *npuname =3D g_strdup_printf("npuphb%d", phb->index);
> +            int npuoff =3D fdt_add_subnode(fdt, 0, npuname);
> +            int linkidx =3D 0;
> +
> +            _FDT(npuoff);
> +            _FDT(fdt_setprop_cell(fdt, npuoff, "#address-cells", 1));
> +            _FDT(fdt_setprop_cell(fdt, npuoff, "#size-cells", 0));
> +            /* Advertise NPU as POWER9 so the guest can enable NPU2 cont=
exts */
> +            _FDT((fdt_setprop_string(fdt, npuoff, "compatible",
> +                                     "ibm,power9-npu")));
> +            g_free(npuname);
> +
> +            for (i =3D 0; i < phb->nvgpus->num; ++i) {
> +                for (j =3D 0; j < phb->nvgpus->gpus[i].links; ++j) {

Here you assume that every entry up to nvgpus->num is populated, which
you didn't elsewhere in the code.

> +                    char *linkname =3D g_strdup_printf("link@%d", linkid=
x);
> +                    int off =3D fdt_add_subnode(fdt, npuoff, linkname);
> +
> +                    _FDT(off);
> +                    _FDT((fdt_setprop_cell(fdt, off, "reg", linkidx)));

Generally it's better to base 'reg' off some absolute property rather
than arbitrary index.  Could you derive linkidx from i & j instead?

> +                    _FDT((fdt_setprop_string(fdt, off, "compatible",
> +                                             "ibm,npu-link")));
> +                    _FDT((fdt_setprop_cell(fdt, off, "phandle",
> +                                           PHANDLE_NVLINK(phb, i, j))));
> +                    _FDT((fdt_setprop_cell(fdt, off, "ibm,npu-link-index=
",
> +                                           linkidx)));
> +                    g_free(linkname);
> +                    ++linkidx;
> +                }
> +            }
> +        }
> +
> +        /* Finally, when we finished with the device tree, map subregion=
s */

Shouldn't be in a device tree function.

> +        for (i =3D 0; i < phb->nvgpus->num; ++i) {
> +            PCIDevice *gpdev =3D phb->nvgpus->gpus[i].gpdev;
> +            Object *nv_mrobj =3D object_property_get_link(OBJECT(gpdev),
> +                                                        "nvlink2-mr[0]",=
 NULL);
> +
> +            if (nv_mrobj) {
> +                memory_region_add_subregion(get_system_memory(),
> +                                            phb->nvgpus->gpus[i].gpa,
> +                                            MEMORY_REGION(nv_mrobj));
> +            }
> +            for (j =3D 0; j < phb->nvgpus->gpus[i].links; ++j) {
> +                PCIDevice *npdev =3D phb->nvgpus->gpus[i].npdev[j];
> +                Object *atsd_mrobj;
> +                atsd_mrobj =3D object_property_get_link(OBJECT(npdev),
> +                                                    "nvlink2-atsd-mr[0]",
> +                                                    NULL);
> +                if (atsd_mrobj) {
> +                    hwaddr atsd_gpa =3D phb->nvgpus->gpus[i].atsd_gpa[j];
> +
> +                    memory_region_add_subregion(get_system_memory(), ats=
d_gpa,
> +                                                MEMORY_REGION(atsd_mrobj=
));
> +                }
> +            }
> +        }
> +    } /* if (phb->nvgpus) */
> +
>      return 0;
>  }
> =20
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 40a1200..faeb9c5 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -2180,3 +2180,123 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error=
 **errp)
> =20
>      return 0;
>  }
> +
> +static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
> +                                     const char *name,
> +                                     void *opaque, Error **errp)
> +{
> +    uint64_t tgt =3D (uint64_t) opaque;
> +    visit_type_uint64(v, name, &tgt, errp);
> +}
> +
> +static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
> +                                                 const char *name,
> +                                                 void *opaque, Error **e=
rrp)
> +{
> +    uint32_t link_speed =3D (uint32_t)(uint64_t) opaque;
> +    visit_type_uint32(v, name, &link_speed, errp);
> +}
> +
> +int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    int ret;
> +    void *p;
> +    struct vfio_region_info *nv2region =3D NULL;
> +    struct vfio_info_cap_header *hdr;
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
> +    hdr =3D vfio_get_region_info_cap(nv2region,
> +                                   VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
> +    if (hdr) {
> +        struct vfio_region_info_cap_nvlink2_ssatgt *cap =3D (void *) hdr;
> +
> +        object_property_add(OBJECT(vdev), "tgt", "uint64",
> +                            vfio_pci_nvlink2_get_tgt, NULL, NULL,
> +                            (void *) cap->tgt, NULL);
> +        trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->=
tgt,
> +                                              nv2region->size);
> +    }
> +    g_free(nv2region);
> +
> +    return 0;
> +}
> +
> +int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    int ret;
> +    void *p;
> +    struct vfio_region_info *atsd_region =3D NULL;
> +    struct vfio_info_cap_header *hdr;
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
> +    /* Some NVLink bridges come without assigned ATSD, skip MR part */
> +    if (atsd_region->size) {
> +        MemoryRegion *atsd_mr =3D g_malloc0(sizeof(*atsd_mr));
> +
> +        p =3D mmap(NULL, atsd_region->size, PROT_READ | PROT_WRITE | PRO=
T_EXEC,

PROT_EXEC ?

> +                 MAP_SHARED, vdev->vbasedev.fd, atsd_region->offset);
> +
> +        if (!p) {
> +            return -errno;
> +        }
> +
> +        memory_region_init_ram_device_ptr(atsd_mr, OBJECT(vdev),
> +                                          "nvlink2-atsd-mr",
> +                                          atsd_region->size,
> +                                          p);
> +    }
> +
> +    hdr =3D vfio_get_region_info_cap(atsd_region,
> +                                   VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
> +    if (hdr) {
> +        struct vfio_region_info_cap_nvlink2_ssatgt *cap =3D (void *) hdr;
> +
> +        object_property_add(OBJECT(vdev), "tgt", "uint64",
> +                            vfio_pci_nvlink2_get_tgt, NULL, NULL,
> +                            (void *) cap->tgt, NULL);
> +        trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, c=
ap->tgt,
> +                                                  atsd_region->size);
> +    }
> +
> +    hdr =3D vfio_get_region_info_cap(atsd_region,
> +                                   VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD);
> +    if (hdr) {
> +        struct vfio_region_info_cap_nvlink2_lnkspd *cap =3D (void *) hdr;
> +
> +        object_property_add(OBJECT(vdev), "link_speed", "uint32",
> +                            vfio_pci_nvlink2_get_link_speed, NULL, NULL,
> +                            (void *) (uint64_t) cap->link_speed, NULL);
> +        trace_vfio_pci_nvlink2_setup_quirk_lnkspd(vdev->vbasedev.name,
> +                                                  cap->link_speed);
> +    }
> +    g_free(atsd_region);
> +
> +    return 0;
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index dd12f36..07aa141 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3069,6 +3069,20 @@ static void vfio_realize(PCIDevice *pdev, Error **=
errp)
>          goto out_teardown;
>      }
> =20
> +    if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_NVIDIA) {

Surely we should be checking device id as well as vendor.  nVidia
makes a lot of cards and most of them don't do nvlink2.

> +        ret =3D vfio_pci_nvidia_v100_ram_init(vdev, errp);
> +        if (ret && ret !=3D -ENODEV) {
> +            error_report("Failed to setup NVIDIA V100 GPU RAM");
> +        }
> +    }
> +
> +    if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_IBM) {

And IBM makes even more.

> +        ret =3D vfio_pci_nvlink2_init(vdev, errp);
> +        if (ret && ret !=3D -ENODEV) {
> +            error_report("Failed to setup NVlink2 bridge");
> +        }
> +    }
> +
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 579be19..6866884 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -87,6 +87,10 @@ vfio_pci_igd_opregion_enabled(const char *name) "%s"
>  vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
>  vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
> =20
> +vfio_pci_nvidia_gpu_setup_quirk(const char *name, uint64_t tgt, uint64_t=
 size) "%s tgt=3D0x%"PRIx64" size=3D0x%"PRIx64
> +vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt, uint=
64_t size) "%s tgt=3D0x%"PRIx64" size=3D0x%"PRIx64
> +vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link_spee=
d) "%s link_speed=3D0x%x"
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

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxmMFgACgkQbDjKyiDZ
s5ICPBAA2S4losuO4i1WE8gviSd+5h+4xQQ6s9+iOJ775am9Nh3AEOI7G09xuY5V
RofFV3Lw1GX3EjR6wHm0lXXvNO94/rRrPp1eRJ0flXiV6b1FMcCIGrSfdW5hjUDW
X22YcW9JnCmAHLjIEBBLrPSJJ87yWeU+iCi0qEiwwxSrb4Gv9YzosFWq18rAfM+a
GQIyqrhL9Vg49zwCOPlV3mQxu4v4LpxnW7x4iZllpmvImxHbbyV6tKMNjiM4kiNZ
LlgyBSEqU29MsUw1oOL43AjQIAs1jJJ4nFg8jHDrl66Lv0/vN0R+1CvQfb9muh2k
gyyEDC5RlI57BO0sCzEvuu4qlN+BmY4i5DYrg4kmO0XOs/R4FGAamYjaQn2APkwN
lQKpTmLtAEMH6EOAySXn/mhEn5KFm5frLb/l6P6YFGfQLaHTy7Apqr6mECa/NVmu
hmQuXcr3JK0kiktORtXBvLQPXOYSpMrKE5iDg+Yvn9C2PNvbmjC0I5L84xFlhDL+
U+Lm+7TEe9WXL7UCwMzqwsH6aqLqJ5sg7Ik30o8MvaQz7jr5q9VjlguOcU74n3Yd
X6jnl6vyLmN9LzL48Qf70JkITezdn10rFeb2hKLLkx7yUD7dO9krOBlCiIw03Bxl
ZojwWfQ8q3lTARM78/bgTlET8r4OR74S/+/uRkF7+zoKsVY7V7k=
=gwg6
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
