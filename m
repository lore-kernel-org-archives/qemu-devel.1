Received: from eggs.gnu.org ([209.51.188.92]:60467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kAd-0006lh-7y
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kAY-0008Dp-Oi
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:58:11 -0500
Date: Thu, 7 Mar 2019 14:57:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307035752.GG7722@umbus.fritz.box>
References: <20190227085149.38596-1-aik@ozlabs.ru>
	<20190227085149.38596-7-aik@ozlabs.ru>
	<20190228033127.GA27799@umbus.fritz.box>
	<ac6da63d-d039-73dd-d18e-0845b9ab94f7@ozlabs.ru>
	<20190305014742.GD7877@umbus.fritz.box>
	<1120a65a-1df5-2dbf-9860-64a2f81996cf@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"
Content-Disposition: inline
In-Reply-To: <1120a65a-1df5-2dbf-9860-64a2f81996cf@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v3 6/6] spapr: Support NVIDIA V100 GPU
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


--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 01:40:33PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 05/03/2019 12:47, David Gibson wrote:
> > On Thu, Feb 28, 2019 at 05:11:32PM +1100, Alexey Kardashevskiy wrote:
> >> On 28/02/2019 14:31, David Gibson wrote:
> >>> On Wed, Feb 27, 2019 at 07:51:49PM +1100, Alexey Kardashevskiy wrote:
> >>>> NVIDIA V100 GPUs have on-board RAM which is mapped into the host mem=
ory
> >>>> space and accessible as normal RAM via an NVLink bus. The VFIO-PCI d=
river
> >>>> implements special regions for such GPUs and emulates an NVLink brid=
ge.
> >>>> NVLink2-enabled POWER9 CPUs also provide address translation services
> >>>> which includes an ATS shootdown (ATSD) register exported via the NVL=
ink
> >>>> bridge device.
> >>>>
> >>>> This adds a quirk to VFIO to map the GPU memory and create an MR;
> >>>> the new MR is stored in a PCI device as a QOM link. The sPAPR PCI us=
es
> >>>> this to get the MR and map it to the system address space.
> >>>> Another quirk does the same for ATSD.
> >>>>
> >>>> This adds additional steps to sPAPR PHB setup:
> >>>>
> >>>> 1. Search for specific GPUs and NPUs, collect findings in
> >>>> sPAPRPHBState::nvgpus, manage system address space mappings;
> >>>>
> >>>> 2. Add device-specific properties such as "ibm,npu", "ibm,gpu",
> >>>> "memory-block", "link-speed" to advertise the NVLink2 function to
> >>>> the guest;
> >>>>
> >>>> 3. Add "mmio-atsd" to vPHB to advertise the ATSD capability;
> >>>>
> >>>> 4. Add new memory blocks (with extra "linux,memory-usable" to prevent
> >>>> the guest OS from accessing the new memory until it is onlined) and
> >>>> npuphb# nodes representing an NPU unit for every vPHB as the GPU dri=
ver
> >>>> uses it for link discovery.
> >>>>
> >>>> This allocates space for GPU RAM and ATSD like we do for MMIOs by
> >>>> adding 2 new parameters to the phb_placement() hook. Older machine t=
ypes
> >>>> set these to zero.
> >>>>
> >>>> This puts new memory nodes in a separate NUMA node to replicate the =
host
> >>>> system setup as the GPU driver relies on this.
> >>>>
> >>>> This adds requirement similar to EEH - one IOMMU group per vPHB.
> >>>> The reason for this is that ATSD registers belong to a physical NPU
> >>>> so they cannot invalidate translations on GPUs attached to another N=
PU.
> >>>> It is guaranteed by the host platform as it does not mix NVLink brid=
ges
> >>>> or GPUs from different NPU in the same IOMMU group. If more than one
> >>>> IOMMU group is detected on a vPHB, this disables ATSD support for th=
at
> >>>> vPHB and prints a warning.
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>> ---
> >>>> Changes:
> >>>> v3:
> >>>> * moved GPU RAM above PCI MMIO limit
> >>>> * renamed QOM property to nvlink2-tgt
> >>>> * moved nvlink2 code to its own file
> >>>>
> >>>> ---
> >>>>
> >>>> The example command line for redbud system:
> >>>>
> >>>> pbuild/qemu-aiku1804le-ppc64/ppc64-softmmu/qemu-system-ppc64 \
> >>>> -nodefaults \
> >>>> -chardev stdio,id=3DSTDIO0,signal=3Doff,mux=3Don \
> >>>> -device spapr-vty,id=3Dsvty0,reg=3D0x71000110,chardev=3DSTDIO0 \
> >>>> -mon id=3DMON0,chardev=3DSTDIO0,mode=3Dreadline -nographic -vga none=
 \
> >>>> -enable-kvm -m 384G \
> >>>> -chardev socket,id=3DSOCKET0,server,nowait,host=3Dlocalhost,port=3D4=
0000 \
> >>>> -mon chardev=3DSOCKET0,mode=3Dcontrol \
> >>>> -smp 80,sockets=3D1,threads=3D4 \
> >>>> -netdev "tap,id=3DTAP0,helper=3D/home/aik/qemu-bridge-helper --br=3D=
br0" \
> >>>> -device "virtio-net-pci,id=3Dvnet0,mac=3D52:54:00:12:34:56,netdev=3D=
TAP0" \
> >>>> img/vdisk0.img \
> >>>> -device "vfio-pci,id=3Dvfio0004_04_00_0,host=3D0004:04:00.0" \
> >>>> -device "vfio-pci,id=3Dvfio0006_00_00_0,host=3D0006:00:00.0" \
> >>>> -device "vfio-pci,id=3Dvfio0006_00_00_1,host=3D0006:00:00.1" \
> >>>> -device "vfio-pci,id=3Dvfio0006_00_00_2,host=3D0006:00:00.2" \
> >>>> -device "vfio-pci,id=3Dvfio0004_05_00_0,host=3D0004:05:00.0" \
> >>>> -device "vfio-pci,id=3Dvfio0006_00_01_0,host=3D0006:00:01.0" \
> >>>> -device "vfio-pci,id=3Dvfio0006_00_01_1,host=3D0006:00:01.1" \
> >>>> -device "vfio-pci,id=3Dvfio0006_00_01_2,host=3D0006:00:01.2" \
> >>>> -device spapr-pci-host-bridge,id=3Dphb1,index=3D1 \
> >>>> -device "vfio-pci,id=3Dvfio0035_03_00_0,host=3D0035:03:00.0" \
> >>>> -device "vfio-pci,id=3Dvfio0007_00_00_0,host=3D0007:00:00.0" \
> >>>> -device "vfio-pci,id=3Dvfio0007_00_00_1,host=3D0007:00:00.1" \
> >>>> -device "vfio-pci,id=3Dvfio0007_00_00_2,host=3D0007:00:00.2" \
> >>>> -device "vfio-pci,id=3Dvfio0035_04_00_0,host=3D0035:04:00.0" \
> >>>> -device "vfio-pci,id=3Dvfio0007_00_01_0,host=3D0007:00:01.0" \
> >>>> -device "vfio-pci,id=3Dvfio0007_00_01_1,host=3D0007:00:01.1" \
> >>>> -device "vfio-pci,id=3Dvfio0007_00_01_2,host=3D0007:00:01.2" -snapsh=
ot \
> >>>> -machine pseries \
> >>>> -L /home/aik/t/qemu-ppc64-bios/ -d guest_errors
> >>>>
> >>>> Note that QEMU attaches PCI devices to the last added vPHB so first
> >>>> 8 devices - 4:04:00.0 till 6:00:01.2 - go to the default vPHB, and
> >>>> 35:03:00.0..7:00:01.2 to the vPHB with id=3Dphb1.
> >>>> ---
> >>>>  hw/ppc/Makefile.objs        |   2 +-
> >>>>  hw/vfio/pci.h               |   2 +
> >>>>  include/hw/pci-host/spapr.h |  41 ++++
> >>>>  include/hw/ppc/spapr.h      |   3 +-
> >>>>  hw/ppc/spapr.c              |  29 ++-
> >>>>  hw/ppc/spapr_pci.c          |   8 +
> >>>>  hw/ppc/spapr_pci_nvlink2.c  | 419 +++++++++++++++++++++++++++++++++=
+++
> >>>>  hw/vfio/pci-quirks.c        | 120 +++++++++++
> >>>>  hw/vfio/pci.c               |  14 ++
> >>>>  hw/vfio/trace-events        |   4 +
> >>>>  10 files changed, 637 insertions(+), 5 deletions(-)
> >>>>  create mode 100644 hw/ppc/spapr_pci_nvlink2.c
> >>>>
> >>>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> >>>> index 1111b21..636e717 100644
> >>>> --- a/hw/ppc/Makefile.objs
> >>>> +++ b/hw/ppc/Makefile.objs
> >>>> @@ -9,7 +9,7 @@ obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
> >>>>  # IBM PowerNV
> >>>>  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o p=
nv_psi.o pnv_occ.o pnv_bmc.o
> >>>>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
> >>>> -obj-y +=3D spapr_pci_vfio.o
> >>>> +obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
> >>>>  endif
> >>>>  obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
> >>>>  # PowerPC 4xx boards
> >>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> >>>> index b1ae4c0..706c304 100644
> >>>> --- a/hw/vfio/pci.h
> >>>> +++ b/hw/vfio/pci.h
> >>>> @@ -194,6 +194,8 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error=
 **errp);
> >>>>  int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> >>>>                                 struct vfio_region_info *info,
> >>>>                                 Error **errp);
> >>>> +int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp=
);
> >>>> +int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp);
> >>>> =20
> >>>>  void vfio_display_reset(VFIOPCIDevice *vdev);
> >>>>  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> >>>> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr=
=2Eh
> >>>> index ab0e3a0..e791dd4 100644
> >>>> --- a/include/hw/pci-host/spapr.h
> >>>> +++ b/include/hw/pci-host/spapr.h
> >>>> @@ -87,6 +87,9 @@ struct sPAPRPHBState {
> >>>>      uint32_t mig_liobn;
> >>>>      hwaddr mig_mem_win_addr, mig_mem_win_size;
> >>>>      hwaddr mig_io_win_addr, mig_io_win_size;
> >>>> +    hwaddr nv2_gpa_win_addr;
> >>>> +    hwaddr nv2_atsd_win_addr;
> >>>> +    struct spapr_phb_pci_nvgpu_config *nvgpus;
> >>>>  };
> >>>> =20
> >>>>  #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
> >>>> @@ -105,6 +108,23 @@ struct sPAPRPHBState {
> >>>> =20
> >>>>  #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
> >>>> =20
> >>>> +#define SPAPR_PCI_NV2RAM64_WIN_BASE  SPAPR_PCI_LIMIT
> >>>> +#define SPAPR_PCI_NV2RAM64_WIN_SIZE  0x10000000000ULL /* 1 TiB for =
all 6xGPUs */
> >>>
> >>> The comments and values below suggest that it is 1TiB for each GPU,
> >>> rather than 1TiB shared by all 6.  Which is it?
> >>
> >>
> >> 1TiB for all of them within 1 vPHB. Not sure where it suggests 1TiB for
> >> each GPU.
> >=20
> > The fact that NV2ATSD_WIN_BASE is set at 6TiB above NV2RAM64_WIN_BASE
> > is what suggested to me that there was one 1TiB window for each of the
> > 6 possible GPUs.
> >=20
> >>>> +
> >>>> +/* Max number of these GPUs per a physical box */
> >>>> +#define NVGPU_MAX_NUM                6
> >>>
> >>> Is there any possibility later hardware revisions could increase this?
> >>> If so we should probably leave some extra room in the address space.
> >>
> >> A GPU RAM window is 256GiB (and only 32GiB is used), and 3 is the
> >> maximum in one group so far. So 1TiB should be enough for quite some
> >> time. Having more GPUs in a box is probably possible but for now 6xGPU
> >> require water cooling while 4xGPU does not so unless there is a new
> >> generation of these GPUs comes out, the numbers won't change much.
> >=20
> > Hm, ok.
> >=20
> >> I'll double SPAPR_PCI_NV2RAM64_WIN_SIZE.
> >=20
> > Um.. I'm not sure how that follows from the above.
>=20
> 1TiB is enough now but 2TiB is more future proof. That was it.

Ok.

> >>>> +/*
> >>>> + * One NVLink bridge provides one ATSD register so it should be 18.
> >>>> + * In practice though since we allow only one group per vPHB which =
equals
> >>>> + * to an NPU2 which has maximum 6 NVLink bridges.
> >>>> + */
> >>>> +#define NVGPU_MAX_ATSD               6
> >>>> +
> >>>> +#define SPAPR_PCI_NV2ATSD_WIN_BASE   (SPAPR_PCI_NV2RAM64_WIN_BASE +=
 \
> >>>> +                                      SPAPR_PCI_NV2RAM64_WIN_SIZE *=
 \
> >>>> +                                      NVGPU_MAX_NUM)
> >>>> +#define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_ATSD * 0x10000)
> >>>
> >>> What's the significance of the 64 kiB constant here?  Should it be a
> >>> symbolic name, or speleed "64 * kiB".
> >>
> >> Ok.
> >=20
> >=20
> > Hmm.  Am I right in thinking that both each 64-bit RAM and each ATSD
> > RAM slot is per-vPHB?=20
>=20
> These are windows from which I allocated RAM base and ATSD per GPU/NPU.

Ok, I guess that per-vPHB set of windows is what I'm meaning by "slot"
then.

> > Would it make more sense to directly index into
> > the array of slots with the phb index, rather than having a separate
> > GPU index?
>=20
> There can be 1 or many "slots" per PHBs ("many" is not really encouraged
> as they will miss ATSD but nevertheless), and "slots" are not in a
> global list of any kind.

Ok, I think we're using different meanings of "slot" here.  By "slot"
I was meaning one 64-bit and one ATS window with a common index
(i.e. a slot in the array indices, rather than a physical slot on the
system).  IIUC all the GPUs and NPUs on a vPHB will sit in a single
"slot" by that sense.

> >>>> +
> >>>>  static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb=
, int pin)
> >>>>  {
> >>>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >>>> @@ -135,6 +155,11 @@ int spapr_phb_vfio_eeh_get_state(sPAPRPHBState =
*sphb, int *state);
> >>>>  int spapr_phb_vfio_eeh_reset(sPAPRPHBState *sphb, int option);
> >>>>  int spapr_phb_vfio_eeh_configure(sPAPRPHBState *sphb);
> >>>>  void spapr_phb_vfio_reset(DeviceState *qdev);
> >>>> +void spapr_phb_nvgpu_setup(sPAPRPHBState *sphb);
> >>>> +void spapr_phb_nvgpu_populate_dt(sPAPRPHBState *sphb, void *fdt, in=
t bus_off);
> >>>> +void spapr_phb_nvgpu_ram_populate_dt(sPAPRPHBState *sphb, void *fdt=
);
> >>>> +void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, =
int offset,
> >>>> +                                        sPAPRPHBState *sphb);
> >>>>  #else
> >>>>  static inline bool spapr_phb_eeh_available(sPAPRPHBState *sphb)
> >>>>  {
> >>>> @@ -161,6 +186,22 @@ static inline int spapr_phb_vfio_eeh_configure(=
sPAPRPHBState *sphb)
> >>>>  static inline void spapr_phb_vfio_reset(DeviceState *qdev)
> >>>>  {
> >>>>  }
> >>>> +static inline void spapr_phb_nvgpu_setup(sPAPRPHBState *sphb)
> >>>> +{
> >>>> +}
> >>>> +static inline void spapr_phb_nvgpu_populate_dt(sPAPRPHBState *sphb,=
 void *fdt,
> >>>> +                                               int bus_off)
> >>>> +{
> >>>> +}
> >>>> +static inline void spapr_phb_nvgpu_ram_populate_dt(sPAPRPHBState *s=
phb,
> >>>> +                                                   void *fdt)
> >>>> +{
> >>>> +}
> >>>> +static inline void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *de=
v, void *fdt,
> >>>> +                                                      int offset,
> >>>> +                                                      sPAPRPHBState=
 *sphb)
> >>>> +{
> >>>> +}
> >>>
> >>> I'm guessing some of these should never get called on systems without
> >>> NVLink2, in which case they should probably have a
> >>> g_assert_not_reached() in there.
> >>
> >> I guess if you compile QEMU for --target-list=3Dppc64-softmmu in Windo=
ws
> >> (i.e. tcg + pseries + pci but no vfio), these will be called and crash
> >> then, no?
> >=20
> > Well, if they can be called in that situation then, yes, they need to
> > be no-ops like they are now.  But is that true for all of them?
> > Hmm.. yes it might be, never mind.
> >=20
> >>>
> >>>>  #endif
> >>>> =20
> >>>>  void spapr_phb_dma_reset(sPAPRPHBState *sphb);
> >>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >>>> index 358bb38..9acf867 100644
> >>>> --- a/include/hw/ppc/spapr.h
> >>>> +++ b/include/hw/ppc/spapr.h
> >>>> @@ -113,7 +113,8 @@ struct sPAPRMachineClass {
> >>>>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
> >>>>                            uint64_t *buid, hwaddr *pio,=20
> >>>>                            hwaddr *mmio32, hwaddr *mmio64,
> >>>> -                          unsigned n_dma, uint32_t *liobns, Error *=
*errp);
> >>>> +                          unsigned n_dma, uint32_t *liobns, hwaddr =
*nv2gpa,
> >>>> +                          hwaddr *nv2atsd, Error **errp);
> >>>>      sPAPRResizeHPT resize_hpt_default;
> >>>>      sPAPRCapabilities default_caps;
> >>>>      sPAPRIrq *irq;
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index 74c9b07..fda6e7e 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -3929,7 +3929,9 @@ static void spapr_phb_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
> >>>>      smc->phb_placement(spapr, sphb->index,
> >>>>                         &sphb->buid, &sphb->io_win_addr,
> >>>>                         &sphb->mem_win_addr, &sphb->mem64_win_addr,
> >>>> -                       windows_supported, sphb->dma_liobn, errp);
> >>>> +                       windows_supported, sphb->dma_liobn,
> >>>> +                       &sphb->nv2_gpa_win_addr, &sphb->nv2_atsd_win=
_addr,
> >>>> +                       errp);
> >>>>  }
> >>>> =20
> >>>>  static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
> >>>> @@ -4129,7 +4131,8 @@ static const CPUArchIdList *spapr_possible_cpu=
_arch_ids(MachineState *machine)
> >>>>  static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t =
index,
> >>>>                                  uint64_t *buid, hwaddr *pio,
> >>>>                                  hwaddr *mmio32, hwaddr *mmio64,
> >>>> -                                unsigned n_dma, uint32_t *liobns, E=
rror **errp)
> >>>> +                                unsigned n_dma, uint32_t *liobns,
> >>>> +                                hwaddr *nv2gpa, hwaddr *nv2atsd, Er=
ror **errp)
> >>>>  {
> >>>>      /*
> >>>>       * New-style PHB window placement.
> >>>> @@ -4174,6 +4177,9 @@ static void spapr_phb_placement(sPAPRMachineSt=
ate *spapr, uint32_t index,
> >>>>      *pio =3D SPAPR_PCI_BASE + index * SPAPR_PCI_IO_WIN_SIZE;
> >>>>      *mmio32 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM32_WIN_=
SIZE;
> >>>>      *mmio64 =3D SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_=
SIZE;
> >>>> +
> >>>
> >>> This doesn't look right.  SPAPR_PCI_NV2ATSD_WIN_BASE appears to be
> >>> defined such that there slots for NVGPU_MAX_NUM gpa "slots" of size
> >>> SPAPR_PCI_NV2RAM64_WIN_SIZE before we get to the ATSD base.
> >>>
> >>>> +    *nv2gpa =3D SPAPR_PCI_NV2RAM64_WIN_BASE + index * SPAPR_PCI_NV2=
RAM64_WIN_SIZE;
> >>>
> >>> But this implies you need a "slot" for every possible PHB index, which
> >>> is rather more than NVGPU_MAX_NUM.
> >>>
> >>>> +    *nv2atsd =3D SPAPR_PCI_NV2ATSD_WIN_BASE + index * SPAPR_PCI_NV2=
ATSD_WIN_SIZE;
> >>
> >>
> >> Ah right :( These should go then above 128TiB I guess as I do not real=
ly
> >> want them to appear inside a huge dma window.
> >=20
> > Right.  So actually looks like you are already indexing the window
> > slots by phb index, in which case you need to allow for 32 slots even
> > though only 6 can be populated at the moment.
>=20
>=20
> Why precisely 32? Round up of 18?

Because 32 is the allowed number of vPHBs.

> >>>>  }
> >>>> =20
> >>>>  static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
> >>>> @@ -4376,6 +4382,18 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> >>>>  /*
> >>>>   * pseries-3.1
> >>>>   */
> >>>> +static void phb_placement_3_1(sPAPRMachineState *spapr, uint32_t in=
dex,
> >>>> +                              uint64_t *buid, hwaddr *pio,
> >>>> +                              hwaddr *mmio32, hwaddr *mmio64,
> >>>> +                              unsigned n_dma, uint32_t *liobns,
> >>>> +                              hwaddr *nv2gpa, hwaddr *nv2atsd, Erro=
r **errp)
> >>>> +{
> >>>> +    spapr_phb_placement(spapr, index, buid, pio, mmio32, mmio64, n_=
dma, liobns,
> >>>> +                        nv2gpa, nv2atsd, errp);
> >>>> +    *nv2gpa =3D 0;
> >>>> +    *nv2atsd =3D 0;
> >>>> +}
> >>>> +
> >>>>  static void spapr_machine_3_1_class_options(MachineClass *mc)
> >>>>  {
> >>>>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> >>>> @@ -4391,6 +4409,7 @@ static void spapr_machine_3_1_class_options(Ma=
chineClass *mc)
> >>>>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
> >>>>      smc->update_dt_enabled =3D false;
> >>>>      smc->dr_phb_enabled =3D false;
> >>>> +    smc->phb_placement =3D phb_placement_3_1;
> >>>>  }
> >>>> =20
> >>>>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> >>>> @@ -4522,7 +4541,8 @@ DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
> >>>>  static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t in=
dex,
> >>>>                                uint64_t *buid, hwaddr *pio,
> >>>>                                hwaddr *mmio32, hwaddr *mmio64,
> >>>> -                              unsigned n_dma, uint32_t *liobns, Err=
or **errp)
> >>>> +                              unsigned n_dma, uint32_t *liobns,
> >>>> +                              hwaddr *nv2gpa, hwaddr *nv2atsd, Erro=
r **errp)
> >>>>  {
> >>>>      /* Legacy PHB placement for pseries-2.7 and earlier machine typ=
es */
> >>>>      const uint64_t base_buid =3D 0x800000020000000ULL;
> >>>> @@ -4566,6 +4586,9 @@ static void phb_placement_2_7(sPAPRMachineStat=
e *spapr, uint32_t index,
> >>>>       * fallback behaviour of automatically splitting a large "32-bi=
t"
> >>>>       * window into contiguous 32-bit and 64-bit windows
> >>>>       */
> >>>> +
> >>>> +    *nv2gpa =3D 0;
> >>>> +    *nv2atsd =3D 0;
> >>>>  }
> >>>> =20
> >>>>  static void spapr_machine_2_7_class_options(MachineClass *mc)
> >>>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> >>>> index 06a5ffd..f076462 100644
> >>>> --- a/hw/ppc/spapr_pci.c
> >>>> +++ b/hw/ppc/spapr_pci.c
> >>>> @@ -1355,6 +1355,8 @@ static void spapr_populate_pci_child_dt(PCIDev=
ice *dev, void *fdt, int offset,
> >>>>      if (sphb->pcie_ecs && pci_is_express(dev)) {
> >>>>          _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-ty=
pe", 0x1));
> >>>>      }
> >>>> +
> >>>> +    spapr_phb_nvgpu_populate_pcidev_dt(dev, fdt, offset, sphb);
> >>>>  }
> >>>> =20
> >>>>  /* create OF node for pci device and required OF DT properties */
> >>>> @@ -1878,6 +1880,7 @@ static void spapr_phb_reset(DeviceState *qdev)
> >>>>      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(qdev);
> >>>> =20
> >>>>      spapr_phb_dma_reset(sphb);
> >>>> +    spapr_phb_nvgpu_setup(sphb);
> >>>> =20
> >>>>      /* Reset the IOMMU state */
> >>>>      object_child_foreach(OBJECT(qdev), spapr_phb_children_reset, NU=
LL);
> >>>> @@ -1910,6 +1913,8 @@ static Property spapr_phb_properties[] =3D {
> >>>>                       pre_2_8_migration, false),
> >>>>      DEFINE_PROP_BOOL("pcie-extended-configuration-space", sPAPRPHBS=
tate,
> >>>>                       pcie_ecs, true),
> >>>> +    DEFINE_PROP_UINT64("gpa", sPAPRPHBState, nv2_gpa_win_addr, 0),
> >>>> +    DEFINE_PROP_UINT64("atsd", sPAPRPHBState, nv2_atsd_win_addr, 0),
> >>>>      DEFINE_PROP_END_OF_LIST(),
> >>>>  };
> >>>> =20
> >>>> @@ -2282,6 +2287,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, =
uint32_t intc_phandle, void *fdt,
> >>>>          return ret;
> >>>>      }
> >>>> =20
> >>>> +    spapr_phb_nvgpu_populate_dt(phb, fdt, bus_off);
> >>>> +    spapr_phb_nvgpu_ram_populate_dt(phb, fdt);
> >>>> +
> >>>>      return 0;
> >>>>  }
> >>>> =20
> >>>> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> >>>> new file mode 100644
> >>>> index 0000000..965a6be
> >>>> --- /dev/null
> >>>> +++ b/hw/ppc/spapr_pci_nvlink2.c
> >>>> @@ -0,0 +1,419 @@
> >>>> +/*
> >>>> + * QEMU sPAPR PCI for NVLink2 pass through
> >>>> + *
> >>>> + * Copyright (c) 2019 Alexey Kardashevskiy, IBM Corporation.
> >>>> + *
> >>>> + * Permission is hereby granted, free of charge, to any person obta=
ining a copy
> >>>> + * of this software and associated documentation files (the "Softwa=
re"), to deal
> >>>> + * in the Software without restriction, including without limitatio=
n the rights
> >>>> + * to use, copy, modify, merge, publish, distribute, sublicense, an=
d/or sell
> >>>> + * copies of the Software, and to permit persons to whom the Softwa=
re is
> >>>> + * furnished to do so, subject to the following conditions:
> >>>> + *
> >>>> + * The above copyright notice and this permission notice shall be i=
ncluded in
> >>>> + * all copies or substantial portions of the Software.
> >>>> + *
> >>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
> >>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANT=
ABILITY,
> >>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVEN=
T SHALL
> >>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGE=
S OR OTHER
> >>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, =
ARISING FROM,
> >>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DE=
ALINGS IN
> >>>> + * THE SOFTWARE.
> >>>> + */
> >>>> +#include "qemu/osdep.h"
> >>>> +#include "qapi/error.h"
> >>>> +#include "qemu-common.h"
> >>>> +#include "hw/pci/pci.h"
> >>>> +#include "hw/pci-host/spapr.h"
> >>>> +#include "qemu/error-report.h"
> >>>> +#include "hw/ppc/fdt.h"
> >>>> +#include "hw/pci/pci_bridge.h"
> >>>> +
> >>>> +#define PHANDLE_PCIDEV(phb, pdev)    (0x12000000 | \
> >>>> +                                     (((phb)->index) << 16) | ((pde=
v)->devfn))
> >>>> +#define PHANDLE_GPURAM(phb, n)       (0x110000FF | ((n) << 8) | \
> >>>> +                                     (((phb)->index) << 16))
> >>>> +/* NVLink2 wants a separate NUMA node for its RAM */
> >>>> +#define GPURAM_ASSOCIATIVITY(phb, n) (255 - ((phb)->index * 3 + (n)=
))
> >>>> +#define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) =
<< 8) | \
> >>>> +                                     ((gn) << 4) | (nn))
> >>>> +
> >>>> +/* Max number of NVLinks per GPU in any physical box */
> >>>> +#define NVGPU_MAX_LINKS              3
> >>>> +
> >>>> +struct spapr_phb_pci_nvgpu_config {
> >>>> +    uint64_t nv2_ram_current;
> >>>> +    uint64_t nv2_atsd_current;
> >>>> +    int num; /* number of non empty (i.e. tgt!=3D0) entries in slot=
s[] */
> >>>> +    struct spapr_phb_pci_nvgpu_slot {
> >>>> +        uint64_t tgt;
> >>>> +        uint64_t gpa;
> >>>> +        PCIDevice *gpdev;
> >>>> +        int linknum;
> >>>> +        struct {
> >>>> +            uint64_t atsd_gpa;
> >>>> +            PCIDevice *npdev;
> >>>> +            uint32_t link_speed;
> >>>> +        } links[NVGPU_MAX_LINKS];
> >>>> +    } slots[NVGPU_MAX_NUM];
> >>>> +};
> >>>> +
> >>>> +static int spapr_pci_nvgpu_get_slot(struct spapr_phb_pci_nvgpu_conf=
ig *nvgpus,
> >>>> +                                    uint64_t tgt)
> >>>> +{
> >>>> +    int i;
> >>>> +
> >>>> +    /* Search for partially collected "slot" */
> >>>> +    for (i =3D 0; i < nvgpus->num; ++i) {
> >>>> +        if (nvgpus->slots[i].tgt =3D=3D tgt) {
> >>>> +            return i;
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    if (nvgpus->num =3D=3D ARRAY_SIZE(nvgpus->slots)) {
> >>>> +        warn_report("Found too many NVLink bridges per GPU");
> >>>> +        return -1;
> >>>
> >>> This is within qemu so it would be better to use the qemu error API
> >>> than returning an error code.
> >>
> >> You mean returning Error**? Oh. Ok.
> >=20
> > Well, not returning, technically, but taking an Error ** parameter
> > which is checked by the caller to detect errors.
>=20
>=20
> None of these is actually propagated to the upper level as neither of
> these is fatal (well, except one which I am turning into assert).

Oh, ok.  In that case you don't need an Error **.

> >>>> +    }
> >>>> +
> >>>> +    i =3D nvgpus->num;
> >>>> +    nvgpus->slots[i].tgt =3D tgt;
> >>>> +    ++nvgpus->num;
> >>>> +
> >>>> +    return i;
> >>>
> >>> Might be nicer to return a pointer to the slot structure.
> >>
> >>
> >> This can work.
> >>
> >>
> >>>
> >>>> +}
> >>>> +
> >>>> +static void spapr_pci_collect_nvgpu(struct spapr_phb_pci_nvgpu_conf=
ig *nvgpus,
> >>>> +                                    PCIDevice *pdev, uint64_t tgt,
> >>>> +                                    MemoryRegion *mr)
> >>>> +{
> >>>> +    int i =3D spapr_pci_nvgpu_get_slot(nvgpus, tgt);
> >>>> +
> >>>> +    if (i < 0) {
> >>>> +        return;
> >>>> +    }
> >>>> +    g_assert(!nvgpus->slots[i].gpdev);
> >>>> +    nvgpus->slots[i].gpdev =3D pdev;
> >>>> +
> >>>> +    nvgpus->slots[i].gpa =3D nvgpus->nv2_ram_current;
> >>>> +    nvgpus->nv2_ram_current +=3D memory_region_size(mr);
> >>>> +}
> >>>> +
> >>>> +static void spapr_pci_collect_nvnpu(struct spapr_phb_pci_nvgpu_conf=
ig *nvgpus,
> >>>> +                                    PCIDevice *pdev, uint64_t tgt,
> >>>> +                                    MemoryRegion *mr)
> >>>> +{
> >>>> +    int i =3D spapr_pci_nvgpu_get_slot(nvgpus, tgt), j;
> >>>> +    struct spapr_phb_pci_nvgpu_slot *nvslot;
> >>>> +
> >>>> +    if (i < 0) {
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>> +    nvslot =3D &nvgpus->slots[i];
> >>>> +    j =3D nvslot->linknum;
> >>>> +    if (j =3D=3D ARRAY_SIZE(nvslot->links)) {
> >>>> +        warn_report("Found too many NVLink2 bridges");
> >>>> +        return;
> >>>> +    }
> >>>> +    ++nvslot->linknum;
> >>>> +
> >>>> +    g_assert(!nvslot->links[j].npdev);
> >>>> +    nvslot->links[j].npdev =3D pdev;
> >>>> +    nvslot->links[j].atsd_gpa =3D nvgpus->nv2_atsd_current;
> >>>> +    nvgpus->nv2_atsd_current +=3D memory_region_size(mr);
> >>>> +    nvslot->links[j].link_speed =3D
> >>>> +        object_property_get_uint(OBJECT(pdev), "nvlink2-link-speed"=
, NULL);
> >>>> +}
> >>>> +
> >>>> +static void spapr_phb_pci_collect_nvgpu(PCIBus *bus, PCIDevice *pde=
v,
> >>>> +                                        void *opaque)
> >>>> +{
> >>>> +    PCIBus *sec_bus;
> >>>> +    Object *po =3D OBJECT(pdev);
> >>>> +    uint64_t tgt =3D object_property_get_uint(po, "nvlink2-tgt", NU=
LL);
> >>>> +
> >>>> +    if (tgt) {
> >>>> +        Object *mr_gpu =3D object_property_get_link(po, "nvlink2-mr=
[0]", NULL);
> >>>> +        Object *mr_npu =3D object_property_get_link(po, "nvlink2-at=
sd-mr[0]",
> >>>> +                                                  NULL);
> >>>> +
> >>>> +        if (mr_gpu) {
> >>>> +            spapr_pci_collect_nvgpu(opaque, pdev, tgt, MEMORY_REGIO=
N(mr_gpu));
> >>>> +        } else if (mr_npu) {
> >>>> +            spapr_pci_collect_nvnpu(opaque, pdev, tgt, MEMORY_REGIO=
N(mr_npu));
> >>>> +        } else {
> >>>> +            warn_report("Unexpected device with \"nvlink2-tgt\"");
> >>>
> >>> IIUC this would have to be a code error, so should be an assert() not
> >>> a warning.
> >>
> >>
> >> Ok.
> >>
> >>>
> >>>> +        }
> >>>> +    }
> >>>> +    if ((pci_default_read_config(pdev, PCI_HEADER_TYPE, 1) !=3D
> >>>> +         PCI_HEADER_TYPE_BRIDGE)) {
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>> +    sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> >>>> +    if (!sec_bus) {
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>> +    pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
> >>>> +                        spapr_phb_pci_collect_nvgpu, opaque);
> >>>> +}
> >>>> +
> >>>> +void spapr_phb_nvgpu_setup(sPAPRPHBState *sphb)
> >>>> +{
> >>>> +    int i, j, valid_gpu_num;
> >>>> +
> >>>> +    /* If there are existing NVLink2 MRs, unmap those before recrea=
ting */
> >>>> +    if (sphb->nvgpus) {
> >>>> +        for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> >>>> +            struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgp=
us->slots[i];
> >>>> +            Object *nv_mrobj =3D object_property_get_link(OBJECT(nv=
slot->gpdev),
> >>>> +                                                        "nvlink2-mr=
[0]", NULL);
> >>>> +
> >>>> +            if (nv_mrobj) {
> >>>> +                memory_region_del_subregion(get_system_memory(),
> >>>> +                                            MEMORY_REGION(nv_mrobj)=
);
> >>>> +            }
> >>>> +            for (j =3D 0; j < nvslot->linknum; ++j) {
> >>>> +                PCIDevice *npdev =3D nvslot->links[j].npdev;
> >>>> +                Object *atsd_mrobj;
> >>>> +                atsd_mrobj =3D object_property_get_link(OBJECT(npde=
v),
> >>>> +                                                      "nvlink2-atsd=
-mr[0]",
> >>>> +                                                      NULL);
> >>>> +                if (atsd_mrobj) {
> >>>> +                    memory_region_del_subregion(get_system_memory(),
> >>>> +                                                MEMORY_REGION(atsd_=
mrobj));
> >>>> +                }
> >>>> +            }
> >>>> +        }
> >>>> +        g_free(sphb->nvgpus);
> >>>
> >>> Probably worth collecting the above into a nvgpu_free() helper -
> >>> chances are you'll want it on cleanup paths as well.
> >>
> >> The only other cleanup path is below and it only executes if there is =
no
> >> MR added so for now it does not seem useful.
> >=20
> > Hrm... I've merged PHB hotplug recently.. so there should be a cleanup
> > path for unplug as well.
>=20
>=20
> ah right. Wooohooo :) btw with phb hotplug we can try supporting EEH on
> hotplugged VFIO devices.

Yeah, Sam is looking into it.

> >>>> +        sphb->nvgpus =3D NULL;
> >>>> +    }
> >>>> +
> >>>> +    /* Search for GPUs and NPUs */
> >>>> +    if (sphb->nv2_gpa_win_addr && sphb->nv2_atsd_win_addr) {
> >>>> +        PCIBus *bus =3D PCI_HOST_BRIDGE(sphb)->bus;
> >>>> +
> >>>> +        sphb->nvgpus =3D g_new0(struct spapr_phb_pci_nvgpu_config, =
1);
> >>>> +        sphb->nvgpus->nv2_ram_current =3D sphb->nv2_gpa_win_addr;
> >>>> +        sphb->nvgpus->nv2_atsd_current =3D sphb->nv2_atsd_win_addr;
> >>>> +
> >>>> +        pci_for_each_device(bus, pci_bus_num(bus),
> >>>> +                            spapr_phb_pci_collect_nvgpu, sphb->nvgp=
us);
> >>>> +    }
> >>>> +
> >>>> +    /* Add found GPU RAM and ATSD MRs if found */
> >>>> +    for (i =3D 0, valid_gpu_num =3D 0; i < sphb->nvgpus->num; ++i) {
> >>>> +        Object *nvmrobj;
> >>>> +        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->=
slots[i];
> >>>> +
> >>>> +        if (!nvslot->gpdev) {
> >>>> +            continue;
> >>>> +        }
> >>>> +        nvmrobj =3D object_property_get_link(OBJECT(nvslot->gpdev),
> >>>> +                                           "nvlink2-mr[0]", NULL);
> >>>> +        /* ATSD is pointless without GPU RAM MR so skip those */
> >>>> +        if (!nvmrobj) {
> >>>> +            continue;
> >>>> +        }
> >>>> +
> >>>> +        ++valid_gpu_num;
> >>>> +        memory_region_add_subregion(get_system_memory(), nvslot->gp=
a,
> >>>> +                                    MEMORY_REGION(nvmrobj));
> >>>> +
> >>>> +        for (j =3D 0; j < nvslot->linknum; ++j) {
> >>>> +            Object *atsdmrobj;
> >>>> +
> >>>> +            atsdmrobj =3D object_property_get_link(OBJECT(nvslot->l=
inks[j].npdev),
> >>>> +                                                 "nvlink2-atsd-mr[0=
]",
> >>>> +                                                 NULL);
> >>>> +            if (!atsdmrobj) {
> >>>> +                continue;
> >>>> +            }
> >>>> +            memory_region_add_subregion(get_system_memory(),
> >>>> +                                        nvslot->links[j].atsd_gpa,
> >>>> +                                        MEMORY_REGION(atsdmrobj));
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    if (!valid_gpu_num) {
> >>>> +        /* We did not find any interesting GPU */
> >>>> +        g_free(sphb->nvgpus);
> >>>> +        sphb->nvgpus =3D NULL;
> >>>> +    }
> >>>> +}
> >>>> +
> >>>> +void spapr_phb_nvgpu_populate_dt(sPAPRPHBState *sphb, void *fdt, in=
t bus_off)
> >>>> +{
> >>>> +    int i, j, atsdnum =3D 0;
> >>>> +    uint64_t atsd[8]; /* The existing limitation of known guests */
> >>>> +
> >>>> +    if (!sphb->nvgpus) {
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>> +    for (i =3D 0; (i < sphb->nvgpus->num) && (atsdnum < ARRAY_SIZE(=
atsd)); ++i) {
> >>>> +        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->=
slots[i];
> >>>> +
> >>>> +        if (!nvslot->gpdev) {
> >>>> +            continue;
> >>>> +        }
> >>>> +        for (j =3D 0; j < nvslot->linknum; ++j) {
> >>>> +            if (!nvslot->links[j].atsd_gpa) {
> >>>> +                continue;
> >>>> +            }
> >>>> +
> >>>> +            if (atsdnum =3D=3D ARRAY_SIZE(atsd)) {
> >>>> +                warn_report("Only %ld ATSD registers allowed",
> >>>> +                            ARRAY_SIZE(atsd));
> >>>
> >>> Probably should be an error not a warning.
> >>
> >> We can still continue though, it is not fatal. These things come from
> >> skiboot (which we control) but skiboot itself could compose the
> >> properties itself or use whatever hostboot provided (does not happen n=
ow
> >> though) and I would not like to be blocked by hostboot if/when this ha=
ppens.
> >=20
> > Um.. what?  atsdnum is just a counter incremented below, it doesn't
> > come from skiboot or any other host-significant value.  The situation
> > here is that we have more nvlinks assigned to a guest that qemu can
> > support.  Yes, you could technically run the guest with some of the
> > links unavailable, but that seems pretty clearly not what the user
> > wanted.  Hence, an error is appropriate.
>=20
>=20
> Not exactly. NVlinks are available whether there come with an ATSD VFIO
> region or not, it was my choice to accompany ATSD with a NVLink2 bridge.
> So it is quite possible to pass way too many links and yes QEMU won't
> expose all accompaniying ATSDs to the guest but 1) guest might not need
> this many ATSDs anyway (right now the NVIDIA driver always uses just one
> and nobody complained about performance) 2) nvlink is functional as long
> as the guest can access its config space.

Sure, it can work.  But remember the qemu user is setting up this
configuration.  I think it makes sense to error if it's a stupid and
pointless configuration, even if the guest could technically work with
it.

> >>>> +                break;
> >>>> +            }
> >>>> +            atsd[atsdnum] =3D cpu_to_be64(nvslot->links[j].atsd_gpa=
);
> >>>> +            ++atsdnum;
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    if (!atsdnum) {
> >>>> +        warn_report("No ATSD registers found");
> >>>> +    } else if (!spapr_phb_eeh_available(sphb)) {
> >>>> +        /*
> >>>> +         * ibm,mmio-atsd contains ATSD registers; these belong to a=
n NPU PHB
> >>>> +         * which we do not emulate as a separate device. Instead we=
 put
> >>>> +         * ibm,mmio-atsd to the vPHB with GPU and make sure that we=
 do not
> >>>> +         * put GPUs from different IOMMU groups to the same vPHB to=
 ensure
> >>>> +         * that the guest will use ATSDs from the corresponding NPU.
> >>>> +         */
> >>>> +        warn_report("ATSD requires separate vPHB per GPU IOMMU grou=
p");
> >>>> +    } else {
> >>>> +        _FDT((fdt_setprop(fdt, bus_off, "ibm,mmio-atsd",
> >>>> +                          atsd, atsdnum * sizeof(atsd[0]))));
> >>>> +    }
> >>>> +}
> >>>> +
> >>>> +void spapr_phb_nvgpu_ram_populate_dt(sPAPRPHBState *sphb, void *fdt)
> >>>> +{
> >>>> +    int i, j, linkidx, npuoff;
> >>>> +    char *npuname;
> >>>> +
> >>>> +    if (!sphb->nvgpus) {
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>> +    npuname =3D g_strdup_printf("npuphb%d", sphb->index);
> >>>> +    npuoff =3D fdt_add_subnode(fdt, 0, npuname);
> >>>> +    _FDT(npuoff);
> >>>> +    _FDT(fdt_setprop_cell(fdt, npuoff, "#address-cells", 1));
> >>>> +    _FDT(fdt_setprop_cell(fdt, npuoff, "#size-cells", 0));
> >>>> +    /* Advertise NPU as POWER9 so the guest can enable NPU2 context=
s */
> >>>> +    _FDT((fdt_setprop_string(fdt, npuoff, "compatible", "ibm,power9=
-npu")));
> >>>> +    g_free(npuname);
> >>>> +
> >>>> +    for (i =3D 0, linkidx =3D 0; i < sphb->nvgpus->num; ++i) {
> >>>> +        for (j =3D 0; j < sphb->nvgpus->slots[i].linknum; ++j) {
> >>>> +            char *linkname =3D g_strdup_printf("link@%d", linkidx);
> >>>> +            int off =3D fdt_add_subnode(fdt, npuoff, linkname);
> >>>> +
> >>>> +            _FDT(off);
> >>>> +            /* _FDT((fdt_setprop_cell(fdt, off, "reg", linkidx)));
> >>>> */
> >>>
> >>> Are the indices you're using for 'reg' and the unit name arbitrary?
> >>> If so it's generally best to base them on some static property of the
> >>> device, rather than just allocating sequentially.
> >>
> >> On the host reg is the link index. Here it is actually commented out as
> >> a reminder for the future.
> >>
> >>>
> >>>> +            _FDT((fdt_setprop_string(fdt, off, "compatible",
> >>>> +                                     "ibm,npu-link")));
> >>>> +            _FDT((fdt_setprop_cell(fdt, off, "phandle",
> >>>> +                                   PHANDLE_NVLINK(sphb, i, j))));
> >>>> +            _FDT((fdt_setprop_cell(fdt, off, "ibm,npu-link-index", =
linkidx)));
> >>>
> >>> Why do you need the index here as well as in reg?
> >>
> >> I do not need "reg" really and I need index for this:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/arch/powerpc/platforms/powernv/npu-dma.c?h=3Dv4.20#n692
> >=20
> >=20
> > Ok, because of a silly binding.  That's a good enough reason.
> >=20
> >>>> +            g_free(linkname);
> >>>> +            ++linkidx;
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    /* Add memory nodes for GPU RAM and mark them unusable */
> >>>> +    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> >>>> +        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->=
slots[i];
> >>>> +        Object *nv_mrobj =3D object_property_get_link(OBJECT(nvslot=
->gpdev),
> >>>> +                                                    "nvlink2-mr[0]"=
, NULL);
> >>>> +        uint32_t at =3D cpu_to_be32(GPURAM_ASSOCIATIVITY(sphb, i));
> >>>> +        uint32_t associativity[] =3D { cpu_to_be32(0x4), at, at, at=
, at };
> >>>> +        uint64_t size =3D object_property_get_uint(nv_mrobj, "size"=
, NULL);
> >>>> +        uint64_t mem_reg[2] =3D { cpu_to_be64(nvslot->gpa), cpu_to_=
be64(size) };
> >>>> +        char *mem_name =3D g_strdup_printf("memory@%lx", nvslot->gp=
a);
> >>>> +        int off =3D fdt_add_subnode(fdt, 0, mem_name);
> >>>> +
> >>>> +        _FDT(off);
> >>>> +        _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")=
));
> >>>> +        _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg)=
)));
> >>>> +        _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativ=
ity,
> >>>> +                          sizeof(associativity))));
> >>>> +
> >>>> +        _FDT((fdt_setprop_string(fdt, off, "compatible",
> >>>> +                                 "ibm,coherent-device-memory")));
> >>>> +
> >>>> +        mem_reg[1] =3D cpu_to_be64(0);
> >>>> +        _FDT((fdt_setprop(fdt, off, "linux,usable-memory", mem_reg,
> >>>> +                          sizeof(mem_reg))));
> >>>> +        _FDT((fdt_setprop_cell(fdt, off, "phandle",
> >>>> +                               PHANDLE_GPURAM(sphb, i))));
> >>>> +        g_free(mem_name);
> >>>> +    }
> >>>> +
> >>>> +}
> >>>> +
> >>>> +void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, =
int offset,
> >>>> +                                        sPAPRPHBState *sphb)
> >>>> +{
> >>>> +    int i, j;
> >>>> +
> >>>> +    if (!sphb->nvgpus) {
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>> +    for (i =3D 0; i < sphb->nvgpus->num; ++i) {
> >>>> +        struct spapr_phb_pci_nvgpu_slot *nvslot =3D &sphb->nvgpus->=
slots[i];
> >>>> +
> >>>> +        /* Skip "slot" without attached GPU */
> >>>
> >>> IIUC a "slot" should always have at least one GPU.  You need to handle
> >>> the case of an unitialized GPU in the "collect" functions because you
> >>> don't know if you'll discover the GPU or an NPU first.  But here not
> >>> having a GPU should be an error, shouldn't it?
> >>
> >>
> >> If someone decides to pass 1 GPU with all related nvlinks and just
> >> nvlinks from another GPU but without related GPU for whatever reason,
> >> should we really stop him/her? Things won't work exactly at their best
> >> but this still might be useful for weird debugging.
> >=20
> > Hm, ok, I guess so.
> >=20
> >>>> +        if (!nvslot->gpdev) {
> >>>> +            continue;
> >>>> +        }
> >>>> +        if (dev =3D=3D nvslot->gpdev) {
> >>>> +            uint32_t npus[nvslot->linknum];
> >>>> +
> >>>> +            for (j =3D 0; j < nvslot->linknum; ++j) {
> >>>> +                PCIDevice *npdev =3D nvslot->links[j].npdev;
> >>>> +
> >>>> +                npus[j] =3D cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev)=
);
> >>>> +            }
> >>>> +            _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
> >>>> +                             j * sizeof(npus[0])));
> >>>> +            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> >>>> +                                   PHANDLE_PCIDEV(sphb, dev))));
> >>>> +            continue;
> >>>> +        }
> >>>> +
> >>>> +        for (j =3D 0; j < nvslot->linknum; ++j) {
> >>>> +            if (dev !=3D nvslot->links[j].npdev) {
> >>>> +                continue;
> >>>> +            }
> >>>> +
> >>>> +            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> >>>> +                                   PHANDLE_PCIDEV(sphb, dev))));
> >>>> +            _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
> >>>> +                                  PHANDLE_PCIDEV(sphb, nvslot->gpde=
v)));
> >>>> +            _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
> >>>> +                                   PHANDLE_NVLINK(sphb, i, j))));
> >>>> +            /*
> >>>> +             * If we ever want to emulate GPU RAM at the same locat=
ion as on
> >>>> +             * the host - here is the encoding GPA->TGT:
> >>>> +             *
> >>>> +             * gta  =3D ((sphb->nv2_gpa >> 42) & 0x1) << 42;
> >>>> +             * gta |=3D ((sphb->nv2_gpa >> 45) & 0x3) << 43;
> >>>> +             * gta |=3D ((sphb->nv2_gpa >> 49) & 0x3) << 45;
> >>>> +             * gta |=3D sphb->nv2_gpa & ((1UL << 43) - 1);
> >>>> +             */
> >>>> +            _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
> >>>> +                                  PHANDLE_GPURAM(sphb, i)));
> >>>> +            _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
> >>>> +                                 nvslot->tgt));
> >>>> +            _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
> >>>> +                                  nvslot->links[j].link_speed));
> >>>> +        }
> >>>> +    }
> >>>> +}
> >>>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> >>>> index 40a1200..15ec0b4 100644
> >>>> --- a/hw/vfio/pci-quirks.c
> >>>> +++ b/hw/vfio/pci-quirks.c
> >>>> @@ -2180,3 +2180,123 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, =
Error **errp)
> >>>> =20
> >>>>      return 0;
> >>>>  }
> >>>> +
> >>>> +static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
> >>>> +                                     const char *name,
> >>>> +                                     void *opaque, Error **errp)
> >>>> +{
> >>>> +    uint64_t tgt =3D (uint64_t) opaque;
> >>>> +    visit_type_uint64(v, name, &tgt, errp);
> >>>> +}
> >>>> +
> >>>> +static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
> >>>> +                                                 const char *name,
> >>>> +                                                 void *opaque, Erro=
r **errp)
> >>>> +{
> >>>> +    uint32_t link_speed =3D (uint32_t)(uint64_t) opaque;
> >>>> +    visit_type_uint32(v, name, &link_speed, errp);
> >>>> +}
> >>>> +
> >>>> +int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
> >>>> +{
> >>>> +    int ret;
> >>>> +    void *p;
> >>>> +    struct vfio_region_info *nv2region =3D NULL;
> >>>> +    struct vfio_info_cap_header *hdr;
> >>>> +    MemoryRegion *nv2mr =3D g_malloc0(sizeof(*nv2mr));
> >>>> +
> >>>> +    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
> >>>> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE=
 |
> >>>> +                                   PCI_VENDOR_ID_NVIDIA,
> >>>> +                                   VFIO_REGION_SUBTYPE_NVIDIA_NVLIN=
K2_RAM,
> >>>> +                                   &nv2region);
> >>>> +    if (ret) {
> >>>> +        return ret;
> >>>> +    }
> >>>> +
> >>>> +    p =3D mmap(NULL, nv2region->size, PROT_READ | PROT_WRITE | PROT=
_EXEC,
> >>>> +             MAP_SHARED, vdev->vbasedev.fd, nv2region->offset);
> >>>> +
> >>>> +    if (!p) {
> >>>> +        return -errno;
> >>>> +    }
> >>>> +
> >>>> +    memory_region_init_ram_ptr(nv2mr, OBJECT(vdev), "nvlink2-mr",
> >>>> +                               nv2region->size, p);
> >>>> +
> >>>> +    hdr =3D vfio_get_region_info_cap(nv2region,
> >>>> +                                   VFIO_REGION_INFO_CAP_NVLINK2_SSA=
TGT);
> >>>> +    if (hdr) {
> >>>> +        struct vfio_region_info_cap_nvlink2_ssatgt *cap =3D (void *=
) hdr;
> >>>> +
> >>>> +        object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
> >>>> +                            vfio_pci_nvlink2_get_tgt, NULL, NULL,
> >>>> +                            (void *) cap->tgt, NULL);
> >>>> +        trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, =
cap->tgt,
> >>>> +                                              nv2region->size);
> >>>> +    }
> >>>> +    g_free(nv2region);
> >>>> +
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Error **errp)
> >>>> +{
> >>>> +    int ret;
> >>>> +    void *p;
> >>>> +    struct vfio_region_info *atsd_region =3D NULL;
> >>>> +    struct vfio_info_cap_header *hdr;
> >>>> +
> >>>> +    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
> >>>> +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE=
 |
> >>>> +                                   PCI_VENDOR_ID_IBM,
> >>>> +                                   VFIO_REGION_SUBTYPE_IBM_NVLINK2_=
ATSD,
> >>>> +                                   &atsd_region);
> >>>> +    if (ret) {
> >>>> +        return ret;
> >>>> +    }
> >>>> +
> >>>> +    /* Some NVLink bridges come without assigned ATSD, skip MR part=
 */
> >>>> +    if (atsd_region->size) {
> >>>> +        MemoryRegion *atsd_mr =3D g_malloc0(sizeof(*atsd_mr));
> >>>> +
> >>>> +        p =3D mmap(NULL, atsd_region->size, PROT_READ | PROT_WRITE =
| PROT_EXEC,
> >>>> +                 MAP_SHARED, vdev->vbasedev.fd, atsd_region->offset=
);
> >>>> +
> >>>> +        if (!p) {
> >>>> +            return -errno;
> >>>> +        }
> >>>> +
> >>>> +        memory_region_init_ram_device_ptr(atsd_mr, OBJECT(vdev),
> >>>> +                                          "nvlink2-atsd-mr",
> >>>> +                                          atsd_region->size,
> >>>> +                                          p);
> >>>> +    }
> >>>> +
> >>>> +    hdr =3D vfio_get_region_info_cap(atsd_region,
> >>>> +                                   VFIO_REGION_INFO_CAP_NVLINK2_SSA=
TGT);
> >>>> +    if (hdr) {
> >>>> +        struct vfio_region_info_cap_nvlink2_ssatgt *cap =3D (void *=
) hdr;
> >>>> +
> >>>> +        object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
> >>>> +                            vfio_pci_nvlink2_get_tgt, NULL, NULL,
> >>>> +                            (void *) cap->tgt, NULL);
> >>>> +        trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.na=
me, cap->tgt,
> >>>> +                                                  atsd_region->size=
);
> >>>> +    }
> >>>> +
> >>>> +    hdr =3D vfio_get_region_info_cap(atsd_region,
> >>>> +                                   VFIO_REGION_INFO_CAP_NVLINK2_LNK=
SPD);
> >>>> +    if (hdr) {
> >>>> +        struct vfio_region_info_cap_nvlink2_lnkspd *cap =3D (void *=
) hdr;
> >>>> +
> >>>> +        object_property_add(OBJECT(vdev), "nvlink2-link-speed", "ui=
nt32",
> >>>> +                            vfio_pci_nvlink2_get_link_speed, NULL, =
NULL,
> >>>> +                            (void *) (uint64_t) cap->link_speed, NU=
LL);
> >>>> +        trace_vfio_pci_nvlink2_setup_quirk_lnkspd(vdev->vbasedev.na=
me,
> >>>> +                                                  cap->link_speed);
> >>>> +    }
> >>>> +    g_free(atsd_region);
> >>>> +
> >>>> +    return 0;
> >>>> +}
> >>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >>>> index dd12f36..07aa141 100644
> >>>> --- a/hw/vfio/pci.c
> >>>> +++ b/hw/vfio/pci.c
> >>>> @@ -3069,6 +3069,20 @@ static void vfio_realize(PCIDevice *pdev, Err=
or **errp)
> >>>>          goto out_teardown;
> >>>>      }
> >>>> =20
> >>>> +    if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_NVIDIA) {
> >>>> +        ret =3D vfio_pci_nvidia_v100_ram_init(vdev, errp);
> >>>> +        if (ret && ret !=3D -ENODEV) {
> >>>> +            error_report("Failed to setup NVIDIA V100 GPU RAM");
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_IBM) {
> >>>> +        ret =3D vfio_pci_nvlink2_init(vdev, errp);
> >>>> +        if (ret && ret !=3D -ENODEV) {
> >>>> +            error_report("Failed to setup NVlink2 bridge");
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>>      vfio_register_err_notifier(vdev);
> >>>>      vfio_register_req_notifier(vdev);
> >>>>      vfio_setup_resetfn_quirk(vdev);
> >>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> >>>> index cf1e886..88841e9 100644
> >>>> --- a/hw/vfio/trace-events
> >>>> +++ b/hw/vfio/trace-events
> >>>> @@ -87,6 +87,10 @@ vfio_pci_igd_opregion_enabled(const char *name) "=
%s"
> >>>>  vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
> >>>>  vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
> >>>> =20
> >>>> +vfio_pci_nvidia_gpu_setup_quirk(const char *name, uint64_t tgt, uin=
t64_t size) "%s tgt=3D0x%"PRIx64" size=3D0x%"PRIx64
> >>>> +vfio_pci_nvlink2_setup_quirk_ssatgt(const char *name, uint64_t tgt,=
 uint64_t size) "%s tgt=3D0x%"PRIx64" size=3D0x%"PRIx64
> >>>> +vfio_pci_nvlink2_setup_quirk_lnkspd(const char *name, uint32_t link=
_speed) "%s link_speed=3D0x%x"
> >>>> +
> >>>>  # hw/vfio/common.c
> >>>>  vfio_region_write(const char *name, int index, uint64_t addr, uint6=
4_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
> >>>>  vfio_region_read(char *name, int index, uint64_t addr, unsigned siz=
e, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) =3D 0x%"PRIx64
> >>>
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAlr0ACgkQbDjKyiDZ
s5JSvxAA1s1+QDmqN6bhwrHthR12cZ7Gdwg26H66Q4NX6vvRmRQRYLltFdaE4KNp
ZbqbdE+3Uc0neXVk6/t57gOUmm9jWQCow8o7WZ+22H2/FrfhyyOo6ocdKY7x9DLR
VSWNVxQBuV1Ao4t1BsWawPG++Ui9QMOfeLn5rp114Vbr+Avb0pcqKPDDTJJ9rOX9
vYwuyyQwPCbwA95Dk4BfbFCxCBKVCQgr/qxEHE3fBUqpN1ws+e2LBbJkVcPFChp/
m7407hfOqiuEaAX1MGPSndoIDcdMXig85vhMJfijthbo8Tr2W4kdUJbgeDnp/JpD
UhO6GdIIfoj3unU5M1dhJVgesAIpX6cEw5oYKc4VUM+rasxB+PXsPme9/g9pdCK0
91OnXU3txFXmNld7UHfzectoCP66F1EG2APXNA3d9eFC9NXP2LtKT7MIOFOy5RO+
WPnTu9bXZw7x4nCMVTPh8NX5vAp3EvKYIUylblsVn+gITit8akGpprBiDsaeCdpl
Ykd2AnY3LurFba8FXtW4GDpYP+foWVPxCbwFSJOv3e87WePcnQMumiZWA4oZd8su
ZayT0Y2lwZYY+RyD+W2a8HDhTk1VwGsrWimVFSqwXkekmbDLpyB2w/3MUUa1N3HY
KFa13pbcBvgNmh8PgHc3kCkBJdCRz/+BIVMWwgUzMA77qLls9wM=
=I+mk
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--
