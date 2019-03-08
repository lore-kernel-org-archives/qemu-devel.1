Received: from eggs.gnu.org ([209.51.188.92]:36759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h27AP-0004Jj-2u
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 23:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h27AI-0002Vi-4T
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 23:31:27 -0500
Date: Fri, 8 Mar 2019 15:30:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308043054.GT7722@umbus.fritz.box>
References: <20190308014420.29178-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UUTnfQ9jwG2TLY7y"
Content-Disposition: inline
In-Reply-To: <20190308014420.29178-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v5] spapr: Support NVIDIA V100 GPU
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>


--UUTnfQ9jwG2TLY7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2019 at 12:44:20PM +1100, Alexey Kardashevskiy wrote:
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
> This adds additional steps to sPAPR PHB setup:
>=20
> 1. Search for specific GPUs and NPUs, collect findings in
> sPAPRPHBState::nvgpus, manage system address space mappings;
>=20
> 2. Add device-specific properties such as "ibm,npu", "ibm,gpu",
> "memory-block", "link-speed" to advertise the NVLink2 function to
> the guest;
>=20
> 3. Add "mmio-atsd" to vPHB to advertise the ATSD capability;
>=20
> 4. Add new memory blocks (with extra "linux,memory-usable" to prevent
> the guest OS from accessing the new memory until it is onlined) and
> npuphb# nodes representing an NPU unit for every vPHB as the GPU driver
> uses it for link discovery.
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
> This is based on David's ppc-for-4.0 +
> applied but not pushed "iommu replay": https://patchwork.ozlabs.org/patch=
/1052644/
> acked "vfio_info_cap public": https://patchwork.ozlabs.org/patch/1052645/
>=20
>=20
> Changes:
> v5:
> * converted MRs to VFIOQuirk - this fixed leaks
>=20
> v4:
> * fixed ATSD placement
> * fixed spapr_phb_unrealize() to do nvgpu cleanup
> * replaced warn_report() with Error*
>=20
> v3:
> * moved GPU RAM above PCI MMIO limit
> * renamed QOM property to nvlink2-tgt
> * moved nvlink2 code to its own file
>=20
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
>  hw/ppc/Makefile.objs        |   2 +-
>  hw/vfio/pci.h               |   2 +
>  include/hw/pci-host/spapr.h |  45 ++++
>  include/hw/ppc/spapr.h      |   3 +-
>  hw/ppc/spapr.c              |  29 ++-
>  hw/ppc/spapr_pci.c          |  19 ++
>  hw/ppc/spapr_pci_nvlink2.c  | 441 ++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci-quirks.c        | 132 +++++++++++
>  hw/vfio/pci.c               |  14 ++
>  hw/vfio/trace-events        |   4 +
>  10 files changed, 686 insertions(+), 5 deletions(-)
>  create mode 100644 hw/ppc/spapr_pci_nvlink2.c
>=20
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 1111b218a048..636e717f207c 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -9,7 +9,7 @@ obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
>  # IBM PowerNV
>  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
> -obj-y +=3D spapr_pci_vfio.o
> +obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
>  endif
>  obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
>  # PowerPC 4xx boards
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index b1ae4c07549a..706c30443617 100644
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
> index ab0e3a0a6f72..912fb36807ee 100644
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
> @@ -105,6 +108,22 @@ struct sPAPRPHBState {
> =20
>  #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
> =20
> +#define SPAPR_PCI_NV2RAM64_WIN_BASE  SPAPR_PCI_LIMIT
> +#define SPAPR_PCI_NV2RAM64_WIN_SIZE  (2 * TiB) /* For up to 6 GPUs 256GB=
 each */
> +
> +/* Max number of these GPUsper a physical box */
> +#define NVGPU_MAX_NUM                6
> +/* Max number of NVLinks per GPU in any physical box */
> +#define NVGPU_MAX_LINKS              3
> +
> +/*
> + * GPU RAM starts at 64TiB so huge DMA window to cover it all ends at 12=
8TiB
> + * which is enough. We do not need DMA for ATSD so we put them at 128TiB.
> + */
> +#define SPAPR_PCI_NV2ATSD_WIN_BASE   (128 * TiB)
> +#define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS * \
> +                                      64 * KiB)
> +
>  static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int=
 pin)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> @@ -135,6 +154,13 @@ int spapr_phb_vfio_eeh_get_state(sPAPRPHBState *sphb=
, int *state);
>  int spapr_phb_vfio_eeh_reset(sPAPRPHBState *sphb, int option);
>  int spapr_phb_vfio_eeh_configure(sPAPRPHBState *sphb);
>  void spapr_phb_vfio_reset(DeviceState *qdev);
> +void spapr_phb_nvgpu_setup(sPAPRPHBState *sphb, Error **errp);
> +void spapr_phb_nvgpu_free(sPAPRPHBState *sphb);
> +void spapr_phb_nvgpu_populate_dt(sPAPRPHBState *sphb, void *fdt, int bus=
_off,
> +                                 Error **errp);
> +void spapr_phb_nvgpu_ram_populate_dt(sPAPRPHBState *sphb, void *fdt);
> +void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int o=
ffset,
> +                                        sPAPRPHBState *sphb);
>  #else
>  static inline bool spapr_phb_eeh_available(sPAPRPHBState *sphb)
>  {
> @@ -161,6 +187,25 @@ static inline int spapr_phb_vfio_eeh_configure(sPAPR=
PHBState *sphb)
>  static inline void spapr_phb_vfio_reset(DeviceState *qdev)
>  {
>  }
> +static inline void spapr_phb_nvgpu_setup(sPAPRPHBState *sphb, Error **er=
rp)
> +{
> +}
> +static inline void spapr_phb_nvgpu_free(sPAPRPHBState *sphb)
> +{
> +}
> +static inline void spapr_phb_nvgpu_populate_dt(sPAPRPHBState *sphb, void=
 *fdt,
> +                                               int bus_off, Error **errp)
> +{
> +}
> +static inline void spapr_phb_nvgpu_ram_populate_dt(sPAPRPHBState *sphb,
> +                                                   void *fdt)
> +{
> +}
> +static inline void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, vo=
id *fdt,
> +                                                      int offset,
> +                                                      sPAPRPHBState *sph=
b)
> +{
> +}
>  #endif
> =20
>  void spapr_phb_dma_reset(sPAPRPHBState *sphb);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f117a7ce6e90..5600f52b4386 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -122,7 +122,8 @@ struct sPAPRMachineClass {
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
> index 78fcc357ea68..73d25f5c96ac 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3935,7 +3935,9 @@ static void spapr_phb_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>      smc->phb_placement(spapr, sphb->index,
>                         &sphb->buid, &sphb->io_win_addr,
>                         &sphb->mem_win_addr, &sphb->mem64_win_addr,
> -                       windows_supported, sphb->dma_liobn, errp);
> +                       windows_supported, sphb->dma_liobn,
> +                       &sphb->nv2_gpa_win_addr, &sphb->nv2_atsd_win_addr,
> +                       errp);
>  }
> =20
>  static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> @@ -4136,7 +4138,8 @@ static const CPUArchIdList *spapr_possible_cpu_arch=
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
> @@ -4181,6 +4184,9 @@ static void spapr_phb_placement(sPAPRMachineState *=
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
> @@ -4385,6 +4391,18 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
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
> @@ -4404,6 +4422,7 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
>      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_OF=
F;
> +    smc->phb_placement =3D phb_placement_3_1;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> @@ -4535,7 +4554,8 @@ DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
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
> @@ -4579,6 +4599,9 @@ static void phb_placement_2_7(sPAPRMachineState *sp=
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
> index 69059c36ebb6..e908c9930d1a 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1355,6 +1355,8 @@ static void spapr_populate_pci_child_dt(PCIDevice *=
dev, void *fdt, int offset,
>      if (sphb->pcie_ecs && pci_is_express(dev)) {
>          _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", =
0x1));
>      }
> +
> +    spapr_phb_nvgpu_populate_pcidev_dt(dev, fdt, offset, sphb);
>  }
> =20
>  /* create OF node for pci device and required OF DT properties */
> @@ -1589,6 +1591,8 @@ static void spapr_phb_unrealize(DeviceState *dev, E=
rror **errp)
>      int i;
>      const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
> =20
> +    spapr_phb_nvgpu_free(sphb);
> +
>      if (sphb->msi) {
>          g_hash_table_unref(sphb->msi);
>          sphb->msi =3D NULL;
> @@ -1877,8 +1881,14 @@ void spapr_phb_dma_reset(sPAPRPHBState *sphb)
>  static void spapr_phb_reset(DeviceState *qdev)
>  {
>      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(qdev);
> +    Error *errp =3D NULL;
> =20
>      spapr_phb_dma_reset(sphb);
> +    spapr_phb_nvgpu_free(sphb);
> +    spapr_phb_nvgpu_setup(sphb, &errp);
> +    if (errp) {
> +        error_report_err(errp);
> +    }
> =20
>      /* Reset the IOMMU state */
>      object_child_foreach(OBJECT(qdev), spapr_phb_children_reset, NULL);
> @@ -1911,6 +1921,8 @@ static Property spapr_phb_properties[] =3D {
>                       pre_2_8_migration, false),
>      DEFINE_PROP_BOOL("pcie-extended-configuration-space", sPAPRPHBState,
>                       pcie_ecs, true),
> +    DEFINE_PROP_UINT64("gpa", sPAPRPHBState, nv2_gpa_win_addr, 0),
> +    DEFINE_PROP_UINT64("atsd", sPAPRPHBState, nv2_atsd_win_addr, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -2191,6 +2203,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint3=
2_t intc_phandle, void *fdt,
>      PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
>      sPAPRFDT s_fdt;
>      sPAPRDRConnector *drc;
> +    Error *errp =3D NULL;
> =20
>      /* Start populating the FDT */
>      nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
> @@ -2283,6 +2296,12 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uint=
32_t intc_phandle, void *fdt,
>          return ret;
>      }
> =20
> +    spapr_phb_nvgpu_populate_dt(phb, fdt, bus_off, &errp);
> +    if (errp) {
> +        error_report_err(errp);
> +    }
> +    spapr_phb_nvgpu_ram_populate_dt(phb, fdt);
> +
>      return 0;
>  }
> =20
> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> new file mode 100644
> index 000000000000..902cf4a39f80
> --- /dev/null
> +++ b/hw/ppc/spapr_pci_nvlink2.c
> @@ -0,0 +1,441 @@
> +/*
> + * QEMU sPAPR PCI for NVLink2 pass through
> + *
> + * Copyright (c) 2019 Alexey Kardashevskiy, IBM Corporation.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci-host/spapr.h"
> +#include "qemu/error-report.h"
> +#include "hw/ppc/fdt.h"
> +#include "hw/pci/pci_bridge.h"
> +
> +#define PHANDLE_PCIDEV(phb, pdev)    (0x12000000 | \
> +                                     (((phb)->index) << 16) | ((pdev)->d=
evfn))
> +#define PHANDLE_GPURAM(phb, n)       (0x110000FF | ((n) << 8) | \
> +                                     (((phb)->index) << 16))
> +/* NVLink2 wants a separate NUMA node for its RAM */
> +#define GPURAM_ASSOCIATIVITY(phb, n) (255 - ((phb)->index * 3 + (n)))
> +#define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8)=
 | \
> +                                     ((gn) << 4) | (nn))
> +
> +struct spapr_phb_pci_nvgpu_config {
> +    uint64_t nv2_ram_current;
> +    uint64_t nv2_atsd_current;
> +    int num; /* number of non empty (i.e. tgt!=3D0) entries in slots[] */
> +    struct spapr_phb_pci_nvgpu_slot {
> +        uint64_t tgt;
> +        uint64_t gpa;
> +        PCIDevice *gpdev;
> +        int linknum;
> +        struct {
> +            uint64_t atsd_gpa;
> +            PCIDevice *npdev;
> +            uint32_t link_speed;
> +        } links[NVGPU_MAX_LINKS];
> +    } slots[NVGPU_MAX_NUM];
> +    Error *errp;
> +};
> +
> +static struct spapr_phb_pci_nvgpu_slot *
> +spapr_nvgpu_get_slot(struct spapr_phb_pci_nvgpu_config *nvgpus,
> +                         uint64_t tgt)
> +{
> +    int i;
> +
> +    /* Search for partially collected "slot" */
> +    for (i =3D 0; i < nvgpus->num; ++i) {
> +        if (nvgpus->slots[i].tgt =3D=3D tgt) {
> +            return &nvgpus->slots[i];
> +        }
> +    }
> +
> +    if (nvgpus->num =3D=3D ARRAY_SIZE(nvgpus->slots)) {
> +        return NULL;
> +    }
> +
> +    i =3D nvgpus->num;
> +    nvgpus->slots[i].tgt =3D tgt;
> +    ++nvgpus->num;
> +
> +    return &nvgpus->slots[i];
> +}
> +
> +static void spapr_pci_collect_nvgpu(struct spapr_phb_pci_nvgpu_config *n=
vgpus,
> +                                    PCIDevice *pdev, uint64_t tgt,
> +                                    MemoryRegion *mr, Error **errp)
> +{
> +    struct spapr_phb_pci_nvgpu_slot *nvslot =3D spapr_nvgpu_get_slot(nvg=
pus, tgt);
> +
> +    if (!nvslot) {
> +        error_setg(errp, "Found too many NVLink bridges per GPU");
> +        return;
> +    }
> +    g_assert(!nvslot->gpdev);
> +    nvslot->gpdev =3D pdev;
> +
> +    nvslot->gpa =3D nvgpus->nv2_ram_current;
> +    nvgpus->nv2_ram_current +=3D memory_region_size(mr);
> +}
> +
> +static void spapr_pci_collect_nvnpu(struct spapr_phb_pci_nvgpu_config *n=
vgpus,
> +                                    PCIDevice *pdev, uint64_t tgt,
> +                                    MemoryRegion *mr, Error **errp)
> +{
> +    struct spapr_phb_pci_nvgpu_slot *nvslot =3D spapr_nvgpu_get_slot(nvg=
pus, tgt);
> +    int j;
> +
> +    if (!nvslot) {
> +        error_setg(errp, "Found too many NVLink bridges per GPU");
> +        return;
> +    }
> +
> +    j =3D nvslot->linknum;
> +    if (j =3D=3D ARRAY_SIZE(nvslot->links)) {
> +        error_setg(errp, "Found too many NVLink2 bridges");
> +        return;
> +    }
> +    ++nvslot->linknum;
> +
> +    g_assert(!nvslot->links[j].npdev);
> +    nvslot->links[j].npdev =3D pdev;
> +    nvslot->links[j].atsd_gpa =3D nvgpus->nv2_atsd_current;
> +    nvgpus->nv2_atsd_current +=3D memory_region_size(mr);
> +    nvslot->links[j].link_speed =3D
> +        object_property_get_uint(OBJECT(pdev), "nvlink2-link-speed", NUL=
L);
> +}
> +
> +static void spapr_phb_pci_collect_nvgpu(PCIBus *bus, PCIDevice *pdev,
> +                                        void *opaque)
> +{
> +    PCIBus *sec_bus;
> +    Object *po =3D OBJECT(pdev);
> +    uint64_t tgt =3D object_property_get_uint(po, "nvlink2-tgt", NULL);
> +
> +    if (tgt) {
> +        Error *local_err =3D NULL;
> +        struct spapr_phb_pci_nvgpu_config *nvgpus =3D opaque;
> +        Object *mr_gpu =3D object_property_get_link(po, "nvlink2-mr[0]",=
 NULL);
> +        Object *mr_npu =3D object_property_get_link(po, "nvlink2-atsd-mr=
[0]",
> +                                                  NULL);
> +
> +        g_assert(mr_gpu || mr_npu);
> +        if (mr_gpu) {
> +            spapr_pci_collect_nvgpu(nvgpus, pdev, tgt, MEMORY_REGION(mr_=
gpu),
> +                                    &local_err);
> +        } else {
> +            spapr_pci_collect_nvnpu(nvgpus, pdev, tgt, MEMORY_REGION(mr_=
npu),
> +                                    &local_err);
> +        }
> +        error_propagate(&nvgpus->errp, local_err);
> +    }
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
> +                        spapr_phb_pci_collect_nvgpu, opaque);
> +}
> +
> +void spapr_phb_nvgpu_setup(sPAPRPHBState *sphb, Error **errp)
> +{
> +    int i, j, valid_gpu_num;
> +    PCIBus *bus;
> +
> +    /* Search for GPUs and NPUs */
> +    if (!sphb->nv2_gpa_win_addr || !sphb->nv2_atsd_win_addr) {
> +        return;
> +    }
> +
> +    sphb->nvgpus =3D g_new0(struct spapr_phb_pci_nvgpu_config, 1);
> +    sphb->nvgpus->nv2_ram_current =3D sphb->nv2_gpa_win_addr;
> +    sphb->nvgpus->nv2_atsd_current =3D sphb->nv2_atsd_win_addr;
> +
> +    bus =3D PCI_HOST_BRIDGE(sphb)->bus;
> +    pci_for_each_device(bus, pci_bus_num(bus),
> +                        spapr_phb_pci_collect_nvgpu, sphb->nvgpus);
> +
> +    if (sphb->nvgpus->errp) {

I think this can discard an error without freeing if multiple errors
are generated during the scan.  That's sufficiently an edge case that
I'm ok to fix it later, though.

> +        error_propagate(errp, sphb->nvgpus->errp);
> +        sphb->nvgpus->errp =3D NULL;
> +        goto cleanup_exit;
> +    }
> +
> +    /* Add found GPU RAM and ATSD MRs if found */
> +    for (i =3D 0, valid_gpu_num =3D 0; i < sphb->nvgpus->num; ++i) {
> +        Object *nvmrobj;
> +        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
> +
> +        if (!nvslot->gpdev) {
> +            continue;
> +        }
> +        nvmrobj =3D object_property_get_link(OBJECT(nvslot->gpdev),
> +                                           "nvlink2-mr[0]", NULL);
> +        /* ATSD is pointless without GPU RAM MR so skip those */
> +        if (!nvmrobj) {
> +            continue;
> +        }
> +
> +        ++valid_gpu_num;
> +        memory_region_add_subregion(get_system_memory(), nvslot->gpa,
> +                                    MEMORY_REGION(nvmrobj));
> +
> +        for (j =3D 0; j < nvslot->linknum; ++j) {
> +            Object *atsdmrobj;
> +
> +            atsdmrobj =3D object_property_get_link(OBJECT(nvslot->links[=
j].npdev),
> +                                                 "nvlink2-atsd-mr[0]", N=
ULL);
> +            if (!atsdmrobj) {
> +                continue;
> +            }
> +            memory_region_add_subregion(get_system_memory(),
> +                                        nvslot->links[j].atsd_gpa,
> +                                        MEMORY_REGION(atsdmrobj));
> +        }
> +    }
> +
> +    if (valid_gpu_num) {
> +        return;
> +    }
> +    /* We did not find any interesting GPU */
> +cleanup_exit:
> +    g_free(sphb->nvgpus);
> +    sphb->nvgpus =3D NULL;
> +}
> +
> +void spapr_phb_nvgpu_free(sPAPRPHBState *sphb)
> +{
> +    int i, j;
> +
> +    if (!sphb->nvgpus) {
> +        return;
> +    }
> +
> +    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> +        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
> +        Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot->gpd=
ev),
> +                                                    "nvlink2-mr[0]", NUL=
L);
> +
> +        if (nv_mrobj) {
> +            memory_region_del_subregion(get_system_memory(),
> +                                        MEMORY_REGION(nv_mrobj));
> +        }
> +        for (j =3D 0; j < nvslot->linknum; ++j) {
> +            PCIDevice *npdev =3D nvslot->links[j].npdev;
> +            Object *atsd_mrobj;
> +            atsd_mrobj =3D object_property_get_link(OBJECT(npdev),
> +                                                  "nvlink2-atsd-mr[0]", =
NULL);
> +            if (atsd_mrobj) {
> +                memory_region_del_subregion(get_system_memory(),
> +                                            MEMORY_REGION(atsd_mrobj));
> +            }
> +        }
> +    }
> +    g_free(sphb->nvgpus);
> +    sphb->nvgpus =3D NULL;
> +}
> +
> +void spapr_phb_nvgpu_populate_dt(sPAPRPHBState *sphb, void *fdt, int bus=
_off,
> +                                 Error **errp)
> +{
> +    int i, j, atsdnum =3D 0;
> +    uint64_t atsd[8]; /* The existing limitation of known guests */
> +
> +    if (!sphb->nvgpus) {
> +        return;
> +    }
> +
> +    for (i =3D 0; (i < sphb->nvgpus->num) && (atsdnum < ARRAY_SIZE(atsd)=
); ++i) {
> +        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
> +
> +        if (!nvslot->gpdev) {
> +            continue;
> +        }
> +        for (j =3D 0; j < nvslot->linknum; ++j) {
> +            if (!nvslot->links[j].atsd_gpa) {
> +                continue;
> +            }
> +
> +            if (atsdnum =3D=3D ARRAY_SIZE(atsd)) {
> +                error_setg(errp, "Only %ld ATSD registers supported",
> +                            ARRAY_SIZE(atsd));

AFAICT, the intention here is to report this to user but not actually
fail this function.  In which case it should be an error_report()
rather than handing an error object to the caller.

> +                break;
> +            }
> +            atsd[atsdnum] =3D cpu_to_be64(nvslot->links[j].atsd_gpa);
> +            ++atsdnum;
> +        }
> +    }
> +
> +    if (!atsdnum) {
> +        error_setg(errp, "No ATSD registers found");
> +        return;
> +    }
> +
> +    if (!spapr_phb_eeh_available(sphb)) {
> +        /*
> +         * ibm,mmio-atsd contains ATSD registers; these belong to an NPU=
 PHB
> +         * which we do not emulate as a separate device. Instead we put
> +         * ibm,mmio-atsd to the vPHB with GPU and make sure that we do n=
ot
> +         * put GPUs from different IOMMU groups to the same vPHB to ensu=
re
> +         * that the guest will use ATSDs from the corresponding NPU.
> +         */
> +        error_prepend(errp, "ATSD requires separate vPHB per GPU IOMMU g=
roup");

As discussed on Slack, error_prepend() doesn't make sense here.  It's
not supposed to just mash together two errors because you want to
report them both, but for making high level errors which give details
about the low level errors that triggered them.

> +        return;
> +    }
> +
> +    _FDT((fdt_setprop(fdt, bus_off, "ibm,mmio-atsd", atsd,
> +                      atsdnum * sizeof(atsd[0]))));
> +}
> +
> +void spapr_phb_nvgpu_ram_populate_dt(sPAPRPHBState *sphb, void *fdt)
> +{
> +    int i, j, linkidx, npuoff;
> +    char *npuname;
> +
> +    if (!sphb->nvgpus) {
> +        return;
> +    }
> +
> +    npuname =3D g_strdup_printf("npuphb%d", sphb->index);
> +    npuoff =3D fdt_add_subnode(fdt, 0, npuname);
> +    _FDT(npuoff);
> +    _FDT(fdt_setprop_cell(fdt, npuoff, "#address-cells", 1));
> +    _FDT(fdt_setprop_cell(fdt, npuoff, "#size-cells", 0));
> +    /* Advertise NPU as POWER9 so the guest can enable NPU2 contexts */
> +    _FDT((fdt_setprop_string(fdt, npuoff, "compatible", "ibm,power9-npu"=
)));
> +    g_free(npuname);
> +
> +    for (i =3D 0, linkidx =3D 0; i < sphb->nvgpus->num; ++i) {
> +        for (j =3D 0; j < sphb->nvgpus->slots[i].linknum; ++j) {
> +            char *linkname =3D g_strdup_printf("link@%d", linkidx);
> +            int off =3D fdt_add_subnode(fdt, npuoff, linkname);
> +
> +            _FDT(off);
> +            /* _FDT((fdt_setprop_cell(fdt, off, "reg", linkidx))); */
> +            _FDT((fdt_setprop_string(fdt, off, "compatible",
> +                                     "ibm,npu-link")));
> +            _FDT((fdt_setprop_cell(fdt, off, "phandle",
> +                                   PHANDLE_NVLINK(sphb, i, j))));
> +            _FDT((fdt_setprop_cell(fdt, off, "ibm,npu-link-index", linki=
dx)));
> +            g_free(linkname);
> +            ++linkidx;
> +        }
> +    }
> +
> +    /* Add memory nodes for GPU RAM and mark them unusable */
> +    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> +        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
> +        Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot->gpd=
ev),
> +                                                    "nvlink2-mr[0]", NUL=
L);
> +        uint32_t at =3D cpu_to_be32(GPURAM_ASSOCIATIVITY(sphb, i));
> +        uint32_t associativity[] =3D { cpu_to_be32(0x4), at, at, at, at =
};

This is still bogus.  We need to actually make a design decision about
how to fit the GPU RAM into the *guest*'s associativity heirarchy, not
just copy host values in here.

I think it makes sense to use one of the currently unused levels as a
"GPU vs. normal" flag.  Probably the top level
(i.e. associativity[1]).  So we'd have 0 for regular RAM, 1 for GPU
RAM.  We'd need to update the matching level of
ibm,max-associativity-domains accordingly (i.e. to 1 from 0).

Then we'd re-use the associativity[4] level to represent the actual
GPU that the RAM comes from.  How exactly to represent that bit in a
PAPRly correct way might need some research.

> +        uint64_t size =3D object_property_get_uint(nv_mrobj, "size", NUL=
L);
> +        uint64_t mem_reg[2] =3D { cpu_to_be64(nvslot->gpa), cpu_to_be64(=
size) };
> +        char *mem_name =3D g_strdup_printf("memory@%lx", nvslot->gpa);
> +        int off =3D fdt_add_subnode(fdt, 0, mem_name);
> +
> +        _FDT(off);
> +        _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
> +        _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg))));
> +        _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
> +                          sizeof(associativity))));
> +
> +        _FDT((fdt_setprop_string(fdt, off, "compatible",
> +                                 "ibm,coherent-device-memory")));
> +
> +        mem_reg[1] =3D cpu_to_be64(0);
> +        _FDT((fdt_setprop(fdt, off, "linux,usable-memory", mem_reg,
> +                          sizeof(mem_reg))));
> +        _FDT((fdt_setprop_cell(fdt, off, "phandle",
> +                               PHANDLE_GPURAM(sphb, i))));
> +        g_free(mem_name);
> +    }
> +
> +}
> +
> +void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int o=
ffset,
> +                                        sPAPRPHBState *sphb)
> +{
> +    int i, j;
> +
> +    if (!sphb->nvgpus) {
> +        return;
> +    }
> +
> +    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> +        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->slots=
[i];
> +
> +        /* Skip "slot" without attached GPU */
> +        if (!nvslot->gpdev) {
> +            continue;
> +        }
> +        if (dev =3D=3D nvslot->gpdev) {
> +            uint32_t npus[nvslot->linknum];
> +
> +            for (j =3D 0; j < nvslot->linknum; ++j) {
> +                PCIDevice *npdev =3D nvslot->links[j].npdev;
> +
> +                npus[j] =3D cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
> +            }
> +            _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
> +                             j * sizeof(npus[0])));
> +            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> +                                   PHANDLE_PCIDEV(sphb, dev))));
> +            continue;
> +        }
> +
> +        for (j =3D 0; j < nvslot->linknum; ++j) {
> +            if (dev !=3D nvslot->links[j].npdev) {
> +                continue;
> +            }
> +
> +            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> +                                   PHANDLE_PCIDEV(sphb, dev))));
> +            _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
> +                                  PHANDLE_PCIDEV(sphb, nvslot->gpdev)));
> +            _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
> +                                   PHANDLE_NVLINK(sphb, i, j))));
> +            /*
> +             * If we ever want to emulate GPU RAM at the same location a=
s on
> +             * the host - here is the encoding GPA->TGT:
> +             *
> +             * gta  =3D ((sphb->nv2_gpa >> 42) & 0x1) << 42;
> +             * gta |=3D ((sphb->nv2_gpa >> 45) & 0x3) << 43;
> +             * gta |=3D ((sphb->nv2_gpa >> 49) & 0x3) << 45;
> +             * gta |=3D sphb->nv2_gpa & ((1UL << 43) - 1);
> +             */
> +            _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
> +                                  PHANDLE_GPURAM(sphb, i)));
> +            _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
> +                                 nvslot->tgt));
> +            _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
> +                                  nvslot->links[j].link_speed));
> +        }
> +    }
> +}
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 40a12001f580..99d4180a5479 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -2180,3 +2180,135 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error=
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
> +    struct vfio_region_info *nv2reg =3D NULL;
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_region_info_cap_nvlink2_ssatgt *cap;
> +    VFIOQuirk *quirk;
> +
> +    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> +                                   PCI_VENDOR_ID_NVIDIA,
> +                                   VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_RA=
M,
> +                                   &nv2reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    hdr =3D vfio_get_region_info_cap(nv2reg, VFIO_REGION_INFO_CAP_NVLINK=
2_SSATGT);
> +    if (!hdr) {
> +        ret =3D -ENODEV;
> +        goto free_exit;
> +    }
> +    cap =3D (void *) hdr;
> +
> +    p =3D mmap(NULL, nv2reg->size, PROT_READ | PROT_WRITE | PROT_EXEC,
> +             MAP_SHARED, vdev->vbasedev.fd, nv2reg->offset);
> +
> +    if (!p) {
> +        ret =3D -errno;
> +        goto free_exit;
> +    }
> +
> +    quirk =3D vfio_quirk_alloc(1);
> +    memory_region_init_ram_ptr(&quirk->mem[0], OBJECT(vdev), "nvlink2-mr=
",
> +                               nv2reg->size, p);
> +    QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
> +
> +    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
> +                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
> +                        (void *) cap->tgt, NULL);
> +    trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
> +                                          nv2reg->size);
> +free_exit:
> +    g_free(nv2reg);
> +
> +    return ret;
> +}
> +
> +int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    int ret;
> +    void *p;
> +    struct vfio_region_info *atsdreg =3D NULL;
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_region_info_cap_nvlink2_ssatgt *captgt;
> +    struct vfio_region_info_cap_nvlink2_lnkspd *capspeed;
> +    VFIOQuirk *quirk;
> +
> +    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> +                                   PCI_VENDOR_ID_IBM,
> +                                   VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD,
> +                                   &atsdreg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    hdr =3D vfio_get_region_info_cap(atsdreg,
> +                                   VFIO_REGION_INFO_CAP_NVLINK2_SSATGT);
> +    if (!hdr) {
> +        ret =3D -ENODEV;
> +        goto free_exit;
> +    }
> +    captgt =3D (void *) hdr;
> +
> +    hdr =3D vfio_get_region_info_cap(atsdreg,
> +                                   VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD);
> +    if (!hdr) {
> +        ret =3D -ENODEV;
> +        goto free_exit;
> +    }
> +    capspeed =3D (void *) hdr;
> +
> +    /* Some NVLink bridges may not have assigned ATSD */
> +    if (atsdreg->size) {
> +        p =3D mmap(NULL, atsdreg->size, PROT_READ | PROT_WRITE | PROT_EX=
EC,
> +                 MAP_SHARED, vdev->vbasedev.fd, atsdreg->offset);
> +        if (!p) {
> +            ret =3D -errno;
> +            goto free_exit;
> +        }
> +
> +        quirk =3D vfio_quirk_alloc(1);
> +        memory_region_init_ram_device_ptr(&quirk->mem[0], OBJECT(vdev),
> +                                          "nvlink2-atsd-mr", atsdreg->si=
ze, p);
> +        QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
> +    }
> +
> +    object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
> +                        vfio_pci_nvlink2_get_tgt, NULL, NULL,
> +                        (void *) captgt->tgt, NULL);
> +    trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, captg=
t->tgt,
> +                                              atsdreg->size);
> +
> +    object_property_add(OBJECT(vdev), "nvlink2-link-speed", "uint32",
> +                        vfio_pci_nvlink2_get_link_speed, NULL, NULL,
> +                        (void *) (uint64_t) capspeed->link_speed, NULL);
> +    trace_vfio_pci_nvlink2_setup_quirk_lnkspd(vdev->vbasedev.name,
> +                                              capspeed->link_speed);
> +free_exit:
> +    g_free(atsdreg);
> +
> +    return ret;
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index dd12f363915d..07aa141aabe6 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3069,6 +3069,20 @@ static void vfio_realize(PCIDevice *pdev, Error **=
errp)
>          goto out_teardown;
>      }
> =20
> +    if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_NVIDIA) {
> +        ret =3D vfio_pci_nvidia_v100_ram_init(vdev, errp);
> +        if (ret && ret !=3D -ENODEV) {
> +            error_report("Failed to setup NVIDIA V100 GPU RAM");
> +        }
> +    }
> +
> +    if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_IBM) {
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
> index cf1e8868182b..88841e9a61da 100644
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

--UUTnfQ9jwG2TLY7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyB7/wACgkQbDjKyiDZ
s5IzFw/+L4/uE5aPOHGjKpcR7N4uXJne9lnGsUU42MEuApdrVoDqqjEWaUM/rxjF
gWWNnpooJ23SQUCHGsgCmEpNkPuDu8SVI0jPFHQLRu9+va70mV3MGGTtL5MeXGl/
sEnoS0+klJhZY/bDWh+7qXN0ggaVJD4aVv52q/zk/sEl8c1MOt7GSekpD0tjg400
4WZ5ykAJDkMDVse0Qxhz0x+qpH0AJoDMYyzJCh0Jj5HEfKbxybbekLVCnWMBIC+U
9gfJKO+6hifp7YfFYOzvYB2SdIixjzrukRhtKiGvYMdYUh/Yn6dQHT+ivYSPp82Q
BxbS5Jc8fiTX4qsmzTTx8vc7o9d3aIyqFnkC8iPj4CZtlpsce31iAH96/IPbglLb
/qlGoflsnRYOo18cfW8vpUoO+I4ywqqXjqLhvgNuZl/WRfdXRmjcOFg7t+Fl60Dz
6bwlRvS3tO8epJB3Vt8je66i/CYO7CDnlKLYiCZH0m98K2XQt3VTWcJyrbF4sO1u
CtyBMbvQbFeSf8KgHxJyqU8ZfrBDgeiilnKoXfQbGj7MeXa0wwoLv9w+EASUijVo
aA6Ev7h8kkHHexrSA7o9eMyV8jfU8tdmwVuLIkZ0CPf/f8rVOtAzka3vED2FZR6p
iv48n7/aTFhQYQTVhrjECOScFcpi3g+MQTEQufcZTswrFQCFEI0=
=kd3y
-----END PGP SIGNATURE-----

--UUTnfQ9jwG2TLY7y--
