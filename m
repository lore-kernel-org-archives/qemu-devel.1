Received: from eggs.gnu.org ([2001:4830:134:3::10]:35277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fffib-0001be-DB
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 02:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fffiR-0005iW-Ut
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 02:13:45 -0400
Date: Wed, 18 Jul 2018 16:13:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180718061322.GF2102@umbus.fritz.box>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<78672af5-1a6b-73d1-40ab-95746cb81aeb@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pgaa2uWPnPrfixyx"
Content-Disposition: inline
In-Reply-To: <78672af5-1a6b-73d1-40ab-95746cb81aeb@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--Pgaa2uWPnPrfixyx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 09:22:59AM +0200, C=E9dric Le Goater wrote:
> On 06/28/2018 10:36 AM, C=E9dric Le Goater wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >=20
> > This is a model of the PCIe Host Bridge (PHB3) found on a Power8
> > processor. It includes the PowerBus logic interface (PBCQ), IOMMU
> > support, PCIe root complex, the XICS MSI and LSI interrupt sources.
> >=20
> > The Power8 processor comes in different flavors: Venice, Murano,
> > Naple, each having a different number of PHBs. All are initialized but
> > the machine only needs one PCI bus to plug a couple of devices (net,
> > storage, usbs). The other busses are provided to test complex
> > configurations. Some platforms, like the Firestone, can also couple
> > PHBs on the first chip to provide more bandwidth but this is too
> > specific to model in QEMU.
> >=20
> > No default device layout is provided and PCI devices can be added on
> > any of the available PCI busses (pci.0..2 on a Power8 chip) using
> > command line options such as :
> >=20
> >   -device e1000,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpci.0,addr=
=3D0x2
> >   -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=
=3Dvirbr0,id=3Dhostnet0
> >=20
> >   -device megasas,id=3Dscsi0,bus=3Dpci.0,addr=3D0x1
> >   -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,c=
ache=3Dnone
> >   -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=
=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2
> >=20
> > Multi chip is supported, each chip adding its set of PHB3 controllers
> > and its PCI busses. The model doesn't emulate the EEH error handling
> > (and may never do).
> Some comments,
>=20
> The model should initialize *two* default PHBs per chip for all=20
> processor flavors. Extra ones would come with user creatable PHBs,
> which can be added later.
>=20
> Can someone take a closer look at pnv_phb3_pci_create() ? This is=20
> where the PCI busses, bridges, etc are created.

I had a bit of a look, and made a comment, though I think it's mostly
sane.

> PBCQ is a logic unit acting as a bridge on the PowerBus but the model=20
> might be adding some extra unnecessary complexity. may be the PHB3 and=20
> the PBCQ models could be merged. This is minor I think.
>=20
> In which sub-tree should this patchset be merged ? PCI or PPC ?

Through the ppc tree, I think.  Although review by the PCI folks would
be great if we can get it.

>=20
> Thanks,
>=20
> C. =20
> =20
>=20
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > [clg: rewrote the QOM models
> >       misc fixes
> >       lots of love and care]
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  default-configs/ppc64-softmmu.mak   |    1 +
> >  include/hw/pci-host/pnv_phb3.h      |  161 +++++
> >  include/hw/pci-host/pnv_phb3_regs.h |  467 ++++++++++++++
> >  include/hw/ppc/pnv.h                |   22 +
> >  include/hw/ppc/pnv_xscom.h          |    9 +
> >  include/hw/ppc/xics.h               |    1 +
> >  hw/intc/xics.c                      |    2 +-
> >  hw/pci-host/pnv_phb3.c              | 1219 +++++++++++++++++++++++++++=
++++++++
> >  hw/pci-host/pnv_phb3_msi.c          |  316 +++++++++
> >  hw/pci-host/pnv_phb3_pbcq.c         |  347 ++++++++++
> >  hw/ppc/pnv.c                        |   75 ++-
> >  hw/ppc/pnv_xscom.c                  |    6 +-
> >  hw/pci-host/Makefile.objs           |    1 +
> >  13 files changed, 2622 insertions(+), 5 deletions(-)
> >  create mode 100644 include/hw/pci-host/pnv_phb3.h
> >  create mode 100644 include/hw/pci-host/pnv_phb3_regs.h
> >  create mode 100644 hw/pci-host/pnv_phb3.c
> >  create mode 100644 hw/pci-host/pnv_phb3_msi.c
> >  create mode 100644 hw/pci-host/pnv_phb3_pbcq.c
> >=20
> > diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-=
softmmu.mak
> > index b94af6c7c62a..deebba2b044a 100644
> > --- a/default-configs/ppc64-softmmu.mak
> > +++ b/default-configs/ppc64-softmmu.mak
> > @@ -9,6 +9,7 @@ CONFIG_IPMI=3Dy
> >  CONFIG_IPMI_LOCAL=3Dy
> >  CONFIG_IPMI_EXTERN=3Dy
> >  CONFIG_ISA_IPMI_BT=3Dy
> > +CONFIG_PCIE_PORT=3Dy
> > =20
> >  # For pSeries
> >  CONFIG_PSERIES=3Dy
> > diff --git a/include/hw/pci-host/pnv_phb3.h b/include/hw/pci-host/pnv_p=
hb3.h
> > new file mode 100644
> > index 000000000000..459994b751ca
> > --- /dev/null
> > +++ b/include/hw/pci-host/pnv_phb3.h
> > @@ -0,0 +1,161 @@
> > +/*
> > + * QEMU PowerPC PowerNV PHB3 model
> > + *
> > + * Copyright (c) 2014-2018, IBM Corporation.
> > + *
> > + * This code is licensed under the GPL version 2 or later. See the
> > + * COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef PCI_HOST_PNV_PHB3_H
> > +#define PCI_HOST_PNV_PHB3_H
> > +
> > +#include "hw/pci/pci_host.h"
> > +#include "hw/ppc/xics.h"
> > +
> > +typedef struct PnvPHB3 PnvPHB3;
> > +typedef struct PnvChip PnvChip;
> > +
> > +/*
> > + * PHB3 XICS Source for MSIs
> > + */
> > +#define TYPE_PHB3_MSI "phb3-msi"
> > +#define PHB3_MSI(obj) OBJECT_CHECK(Phb3MsiState, (obj), TYPE_PHB3_MSI)
> > +
> > +#define PHB3_MAX_MSI     2048
> > +
> > +typedef struct Phb3MsiState {
> > +    ICSState ics;
> > +
> > +    PnvPHB3 *phb;
> > +    uint64_t rba[PHB3_MAX_MSI / 64];
> > +    uint32_t rba_sum;
> > +} Phb3MsiState;
> > +
> > +void pnv_phb3_msi_update_config(Phb3MsiState *msis, uint32_t base,
> > +                                uint32_t count);
> > +void pnv_phb3_msi_send(Phb3MsiState *msis, uint64_t addr, uint16_t dat=
a,
> > +                       int32_t dev_pe);
> > +void pnv_phb3_msi_ffi(Phb3MsiState *msis, uint64_t val);
> > +
> > +
> > +/* We have one such address space wrapper per possible device
> > + * under the PHB since they need to be assigned statically at
> > + * qemu device creation time. The relationship to a PE is done
> > + * later dynamically. This means we can potentially create a lot
> > + * of these guys. Q35 stores them as some kind of radix tree but
> > + * we never really need to do fast lookups so instead we simply
> > + * keep a QLIST of them for now, we can add the radix if needed
> > + * later on.
> > + *
> > + * We do cache the PE number to speed things up a bit though.
> > + */
> > +typedef struct PnvPhb3DMASpace {
> > +    PCIBus *bus;
> > +    uint8_t devfn;
> > +    int pe_num;         /* Cached PE number */
> > +#define PHB_INVALID_PE (-1)
> > +    PnvPHB3 *phb;
> > +    AddressSpace dma_as;
> > +    IOMMUMemoryRegion dma_mr;
> > +    MemoryRegion msi32_mr;
> > +    MemoryRegion msi64_mr;
> > +    bool msi32_mapped;
> > +    bool msi64_mapped;
> > +    QLIST_ENTRY(PnvPhb3DMASpace) list;
> > +} PnvPhb3DMASpace;
> > +
> > +/*
> > + * PHB3 Power Bus Common Queue
> > + */
> > +#define TYPE_PNV_PBCQ "pnv-pbcq"
> > +#define PNV_PBCQ(obj) OBJECT_CHECK(PnvPBCQState, (obj), TYPE_PNV_PBCQ)
> > +
> > +typedef struct PnvPBCQState {
> > +    DeviceState parent;
> > +
> > +    uint32_t nest_xbase;
> > +    uint32_t spci_xbase;
> > +    uint32_t pci_xbase;
> > +#define PBCQ_NEST_REGS_COUNT    0x46
> > +#define PBCQ_PCI_REGS_COUNT     0x15
> > +#define PBCQ_SPCI_REGS_COUNT    0x5
> > +
> > +    uint64_t nest_regs[PBCQ_NEST_REGS_COUNT];
> > +    uint64_t spci_regs[PBCQ_SPCI_REGS_COUNT];
> > +    uint64_t pci_regs[PBCQ_PCI_REGS_COUNT];
> > +    MemoryRegion mmbar0;
> > +    MemoryRegion mmbar1;
> > +    MemoryRegion phbbar;
> > +    bool mmio0_mapped;
> > +    bool mmio1_mapped;
> > +    bool phb_mapped;
> > +    uint64_t mmio0_base;
> > +    uint64_t mmio0_size;
> > +    uint64_t mmio1_base;
> > +    uint64_t mmio1_size;
> > +    PnvPHB3 *phb;
> > +
> > +    MemoryRegion xscom_nest_regs;
> > +    MemoryRegion xscom_pci_regs;
> > +    MemoryRegion xscom_spci_regs;
> > +} PnvPBCQState;
> > +
> > +/*
> > + * PHB3 PCI Host Bridge for PowerNV machines (POWER8)
> > + */
> > +#define TYPE_PNV_PHB3 "pnv-phb3"
> > +#define PNV_PHB3(obj) OBJECT_CHECK(PnvPHB3, (obj), TYPE_PNV_PHB3)
> > +
> > +#define PNV_PHB3_NUM_M64      16
> > +#define PNV_PHB3_NUM_REGS     (0x1000 >> 3)
> > +#define PNV_PHB3_NUM_LSI      8
> > +#define PNV_PHB3_NUM_PE       256
> > +
> > +#define PCI_MMIO_TOTAL_SIZE   (0x1ull << 60)
> > +
> > +struct PnvPHB3 {
> > +    PCIHostState parent_obj;
> > +
> > +    uint32_t chip_id;
> > +    uint32_t phb_id;
> > +    char bus_path[8];
> > +
> > +    uint64_t regs[PNV_PHB3_NUM_REGS];
> > +    MemoryRegion mr_regs;
> > +
> > +    MemoryRegion mr_m32;
> > +    MemoryRegion mr_m64[PNV_PHB3_NUM_M64];
> > +    bool regs_mapped;
> > +    bool m32_mapped;
> > +    bool m64_mapped[PNV_PHB3_NUM_M64];
> > +    MemoryRegion pci_mmio;
> > +    MemoryRegion pci_io;
> > +
> > +    uint64_t ioda_LIST[8];
> > +    uint64_t ioda_LXIVT[8];
> > +    uint64_t ioda_TVT[512];
> > +    uint64_t ioda_M64BT[16];
> > +    uint64_t ioda_MDT[256];
> > +    uint64_t ioda_PEEV[4];
> > +
> > +    uint32_t total_irq;
> > +    ICSState lsis;
> > +    Phb3MsiState msis;
> > +
> > +    PnvPBCQState pbcq;
> > +
> > +    QLIST_HEAD(, PnvPhb3DMASpace) dma_spaces;
> > +};
> > +
> > +#define TYPE_PNV_PHB3_RC "pnv-phb3-rc"
> > +
> > +#define TYPE_PNV_PHB3_ROOT_BUS "pnv-phb3-root-bus"
> > +
> > +uint64_t pnv_phb3_reg_read(void *opaque, hwaddr off, unsigned size);
> > +void pnv_phb3_reg_write(void *opaque, hwaddr off, uint64_t val, unsign=
ed size);
> > +void pnv_phb3_update_regions(PnvPHB3 *phb);
> > +void pnv_phb3_remap_irqs(PnvPHB3 *phb);
> > +
> > +
> > +#endif /* PCI_HOST_PNV_PHB3_H */
> > diff --git a/include/hw/pci-host/pnv_phb3_regs.h b/include/hw/pci-host/=
pnv_phb3_regs.h
> > new file mode 100644
> > index 000000000000..4ddbb5559eb5
> > --- /dev/null
> > +++ b/include/hw/pci-host/pnv_phb3_regs.h
> > @@ -0,0 +1,467 @@
> > +/* Copyright (c) 2013-2018, IBM Corporation.
> > + *
> > + * Licensed under the Apache License, Version 2.0 (the "License");
> > + * you may not use this file except in compliance with the License.
> > + * You may obtain a copy of the License at
> > + *
> > + *      http://www.apache.org/licenses/LICENSE-2.0
> > + *
> > + * Unless required by applicable law or agreed to in writing, software
> > + * distributed under the License is distributed on an "AS IS" BASIS,
> > + * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
> > + * implied.
> > + *
> > + * See the License for the specific language governing permissions and
> > + * limitations under the License.
> > + */
> > +
> > +#ifndef PCI_HOST_PNV_PHB3_REGS_H
> > +#define PCI_HOST_PNV_PHB3_REGS_H
> > +
> > +/*
> > + * PBCQ XSCOM registers
> > + */
> > +
> > +#define PBCQ_NEST_IRSN_COMPARE  0x1a
> > +#define PBCQ_NEST_IRSN_COMP           PPC_BITMASK(0, 18)
> > +#define PBCQ_NEST_IRSN_MASK     0x1b
> > +#define PBCQ_NEST_LSI_SRC_ID    0x1f
> > +#define   PBCQ_NEST_LSI_SRC           PPC_BITMASK(0, 7)
> > +#define PBCQ_NEST_REGS_COUNT    0x46
> > +#define PBCQ_NEST_MMIO_BAR0     0x40
> > +#define PBCQ_NEST_MMIO_BAR1     0x41
> > +#define PBCQ_NEST_PHB_BAR       0x42
> > +#define PBCQ_NEST_MMIO_MASK0    0x43
> > +#define PBCQ_NEST_MMIO_MASK1    0x44
> > +#define PBCQ_NEST_BAR_EN        0x45
> > +#define   PBCQ_NEST_BAR_EN_MMIO0    PPC_BIT(0)
> > +#define   PBCQ_NEST_BAR_EN_MMIO1    PPC_BIT(1)
> > +#define   PBCQ_NEST_BAR_EN_PHB      PPC_BIT(2)
> > +#define   PBCQ_NEST_BAR_EN_IRSN_RX  PPC_BIT(3)
> > +#define   PBCQ_NEST_BAR_EN_IRSN_TX  PPC_BIT(4)
> > +
> > +#define PBCQ_PCI_REGS_COUNT     0x15
> > +#define PBCQ_PCI_BAR2           0x0b
> > +
> > +#define PBCQ_SPCI_REGS_COUNT    0x5
> > +#define PBCQ_SPCI_ASB_ADDR      0x0
> > +#define PBCQ_SPCI_ASB_STATUS    0x1
> > +#define PBCQ_SPCI_ASB_DATA      0x2
> > +#define PBCQ_SPCI_AIB_CAPP_EN   0x3
> > +#define PBCQ_SPCI_CAPP_SEC_TMR  0x4
> > +
> > +/*
> > + * PHB MMIO registers
> > + */
> > +
> > +/* PHB Fundamental register set A */
> > +#define PHB_LSI_SOURCE_ID               0x100
> > +#define   PHB_LSI_SRC_ID                PPC_BITMASK(5, 12)
> > +#define PHB_DMA_CHAN_STATUS             0x110
> > +#define   PHB_DMA_CHAN_ANY_ERR          PPC_BIT(27)
> > +#define   PHB_DMA_CHAN_ANY_ERR1         PPC_BIT(28)
> > +#define   PHB_DMA_CHAN_ANY_FREEZE       PPC_BIT(29)
> > +#define PHB_CPU_LOADSTORE_STATUS        0x120
> > +#define   PHB_CPU_LS_ANY_ERR            PPC_BIT(27)
> > +#define   PHB_CPU_LS_ANY_ERR1           PPC_BIT(28)
> > +#define   PHB_CPU_LS_ANY_FREEZE         PPC_BIT(29)
> > +#define PHB_DMA_MSI_NODE_ID             0x128
> > +#define   PHB_DMAMSI_NID_FIXED          PPC_BIT(0)
> > +#define   PHB_DMAMSI_NID_MASK           PPC_BITMASK(24, 31)
> > +#define   PHB_DMAMSI_NID_LSH            PPC_BITLSHIFT(31)
> > +#define PHB_CONFIG_DATA                 0x130
> > +#define PHB_LOCK0                       0x138
> > +#define PHB_CONFIG_ADDRESS              0x140
> > +#define   PHB_CA_ENABLE                 PPC_BIT(0)
> > +#define   PHB_CA_BUS_MASK               PPC_BITMASK(4, 11)
> > +#define   PHB_CA_BUS_LSH                PPC_BITLSHIFT(11)
> > +#define   PHB_CA_DEV_MASK               PPC_BITMASK(12, 16)
> > +#define   PHB_CA_DEV_LSH                PPC_BITLSHIFT(16)
> > +#define   PHB_CA_FUNC_MASK              PPC_BITMASK(17, 19)
> > +#define   PHB_CA_FUNC_LSH               PPC_BITLSHIFT(19)
> > +#define   PHB_CA_REG_MASK               PPC_BITMASK(20, 31)
> > +#define   PHB_CA_REG_LSH                PPC_BITLSHIFT(31)
> > +#define   PHB_CA_PE_MASK                PPC_BITMASK(40, 47)
> > +#define   PHB_CA_PE_LSH                 PPC_BITLSHIFT(47)
> > +#define PHB_LOCK1                       0x148
> > +#define PHB_IVT_BAR                     0x150
> > +#define   PHB_IVT_BAR_ENABLE            PPC_BIT(0)
> > +#define   PHB_IVT_BASE_ADDRESS_MASK     PPC_BITMASK(14, 48)
> > +#define   PHB_IVT_BASE_ADDRESS_LSH      PPC_BITLSHIFT(48)
> > +#define   PHB_IVT_LENGTH_MASK           PPC_BITMASK(52, 63)
> > +#define   PHB_IVT_LENGTH_ADDRESS_LSH    PPC_BITLSHIFT(63)
> > +#define PHB_RBA_BAR                     0x158
> > +#define   PHB_RBA_BAR_ENABLE            PPC_BIT(0)
> > +#define   PHB_RBA_BASE_ADDRESS_MASK     PPC_BITMASK(14, 55)
> > +#define   PHB_RBA_BASE_ADDRESS_LSH      PPC_BITLSHIFT(55)
> > +#define PHB_PHB3_CONFIG                 0x160
> > +#define   PHB_PHB3C_64B_TCE_EN          PPC_BIT(2)
> > +#define   PHB_PHB3C_32BIT_MSI_EN        PPC_BIT(8)
> > +#define   PHB_PHB3C_64BIT_MSI_EN        PPC_BIT(14)
> > +#define   PHB_PHB3C_M32_EN              PPC_BIT(16)
> > +#define PHB_RTT_BAR                     0x168
> > +#define   PHB_RTT_BAR_ENABLE            PPC_BIT(0)
> > +#define   PHB_RTT_BASE_ADDRESS_MASK     PPC_BITMASK(14, 46)
> > +#define   PHB_RTT_BASE_ADDRESS_LSH      PPC_BITLSHIFT(46)
> > +#define PHB_PELTV_BAR                   0x188
> > +#define   PHB_PELTV_BAR_ENABLE          PPC_BIT(0)
> > +#define   PHB_PELTV_BASE_ADDRESS_MASK   PPC_BITMASK(14, 50)
> > +#define   PHB_PELTV_BASE_ADDRESS_LSH    PPC_BITLSHIFT(50)
> > +#define PHB_M32_BASE_ADDR               0x190
> > +#define PHB_M32_BASE_MASK               0x198
> > +#define PHB_M32_START_ADDR              0x1a0
> > +#define PHB_PEST_BAR                    0x1a8
> > +#define   PHB_PEST_BAR_ENABLE           PPC_BIT(0)
> > +#define   PHB_PEST_BASE_ADDRESS_MASK    PPC_BITMASK(14, 51)
> > +#define   PHB_PEST_BASE_ADDRESS_LSH     PPC_BITLSHIFT(51)
> > +#define PHB_M64_UPPER_BITS              0x1f0
> > +#define PHB_INTREP_TIMER                0x1f8
> > +#define PHB_DMARD_SYNC                  0x200
> > +#define PHB_RTC_INVALIDATE              0x208
> > +#define   PHB_RTC_INVALIDATE_ALL        PPC_BIT(0)
> > +#define   PHB_RTC_INVALIDATE_RID_MASK   PPC_BITMASK(16, 31)
> > +#define   PHB_RTC_INVALIDATE_RID_LSH    PPC_BITLSHIFT(31)
> > +#define PHB_TCE_KILL                    0x210
> > +#define   PHB_TCE_KILL_ALL              PPC_BIT(0)
> > +#define PHB_TCE_SPEC_CTL                0x218
> > +#define PHB_IODA_ADDR                   0x220
> > +#define   PHB_IODA_AD_AUTOINC           PPC_BIT(0)
> > +#define   PHB_IODA_AD_TSEL              PPC_BITMASK(11, 15)
> > +#define   PHB_IODA_AD_TADR              PPC_BITMASK(55, 63)
> > +#define PHB_IODA_DATA0                  0x228
> > +#define PHB_FFI_REQUEST                 0x238
> > +#define   PHB_FFI_LOCK_CLEAR            PPC_BIT(3)
> > +#define   PHB_FFI_REQUEST_ISN_MASK      PPC_BITMASK(49, 59)
> > +#define   PHB_FFI_REQUEST_ISN_LSH       PPC_BITLSHIFT(59)
> > +#define PHB_FFI_LOCK                    0x240
> > +#define   PHB_FFI_LOCK_STATE            PPC_BIT(0)
> > +#define PHB_XIVE_UPDATE                 0x248 /* Broken in DD1 */
> > +#define PHB_PHB3_GEN_CAP                0x250
> > +#define PHB_PHB3_TCE_CAP                0x258
> > +#define PHB_PHB3_IRQ_CAP                0x260
> > +#define PHB_PHB3_EEH_CAP                0x268
> > +#define PHB_IVC_INVALIDATE              0x2a0
> > +#define   PHB_IVC_INVALIDATE_ALL        PPC_BIT(0)
> > +#define   PHB_IVC_INVALIDATE_SID_MASK   PPC_BITMASK(16, 31)
> > +#define   PHB_IVC_INVALIDATE_SID_LSH    PPC_BITLSHIFT(31)
> > +#define PHB_IVC_UPDATE                  0x2a8
> > +#define   PHB_IVC_UPDATE_ENABLE_P       PPC_BIT(0)
> > +#define   PHB_IVC_UPDATE_ENABLE_Q       PPC_BIT(1)
> > +#define   PHB_IVC_UPDATE_ENABLE_SERVER  PPC_BIT(2)
> > +#define   PHB_IVC_UPDATE_ENABLE_PRI     PPC_BIT(3)
> > +#define   PHB_IVC_UPDATE_ENABLE_GEN     PPC_BIT(4)
> > +#define   PHB_IVC_UPDATE_ENABLE_CON     PPC_BIT(5)
> > +#define   PHB_IVC_UPDATE_GEN_MATCH_MASK PPC_BITMASK(6, 7)
> > +#define   PHB_IVC_UPDATE_GEN_MATCH_LSH  PPC_BITLSHIFT(7)
> > +#define   PHB_IVC_UPDATE_SERVER_MASK    PPC_BITMASK(8, 23)
> > +#define   PHB_IVC_UPDATE_SERVER_LSH     PPC_BITLSHIFT(23)
> > +#define   PHB_IVC_UPDATE_PRI_MASK       PPC_BITMASK(24, 31)
> > +#define   PHB_IVC_UPDATE_PRI_LSH        PPC_BITLSHIFT(31)
> > +#define   PHB_IVC_UPDATE_GEN_MASK       PPC_BITMASK(32, 33)
> > +#define   PHB_IVC_UPDATE_GEN_LSH        PPC_BITLSHIFT(33)
> > +#define   PHB_IVC_UPDATE_P_MASK         PPC_BITMASK(34, 34)
> > +#define   PHB_IVC_UPDATE_P_LSH          PPC_BITLSHIFT(34)
> > +#define   PHB_IVC_UPDATE_Q_MASK         PPC_BITMASK(35, 35)
> > +#define   PHB_IVC_UPDATE_Q_LSH          PPC_BITLSHIFT(35)
> > +#define   PHB_IVC_UPDATE_SID_MASK       PPC_BITMASK(48, 63)
> > +#define   PHB_IVC_UPDATE_SID_LSH        PPC_BITLSHIFT(63)
> > +#define PHB_PAPR_ERR_INJ_CTL            0x2b0
> > +#define   PHB_PAPR_ERR_INJ_CTL_INB      PPC_BIT(0)
> > +#define   PHB_PAPR_ERR_INJ_CTL_OUTB     PPC_BIT(1)
> > +#define   PHB_PAPR_ERR_INJ_CTL_STICKY   PPC_BIT(2)
> > +#define   PHB_PAPR_ERR_INJ_CTL_CFG      PPC_BIT(3)
> > +#define   PHB_PAPR_ERR_INJ_CTL_RD       PPC_BIT(4)
> > +#define   PHB_PAPR_ERR_INJ_CTL_WR       PPC_BIT(5)
> > +#define   PHB_PAPR_ERR_INJ_CTL_FREEZE   PPC_BIT(6)
> > +#define PHB_PAPR_ERR_INJ_ADDR           0x2b8
> > +#define   PHB_PAPR_ERR_INJ_ADDR_MMIO_MASK       PPC_BITMASK(16, 63)
> > +#define   PHB_PAPR_ERR_INJ_ADDR_MMIO_LSH        PPC_BITLSHIFT(63)
> > +#define PHB_PAPR_ERR_INJ_MASK           0x2c0
> > +#define   PHB_PAPR_ERR_INJ_MASK_CFG_MASK        PPC_BITMASK(4, 11)
> > +#define   PHB_PAPR_ERR_INJ_MASK_CFG_LSH         PPC_BITLSHIFT(11)
> > +#define   PHB_PAPR_ERR_INJ_MASK_MMIO_MASK       PPC_BITMASK(16, 63)
> > +#define   PHB_PAPR_ERR_INJ_MASK_MMIO_LSH        PPC_BITLSHIFT(63)
> > +#define PHB_ETU_ERR_SUMMARY             0x2c8
> > +
> > +/*  UTL registers */
> > +#define UTL_SYS_BUS_CONTROL             0x400
> > +#define UTL_STATUS                      0x408
> > +#define UTL_SYS_BUS_AGENT_STATUS        0x410
> > +#define UTL_SYS_BUS_AGENT_ERR_SEVERITY  0x418
> > +#define UTL_SYS_BUS_AGENT_IRQ_EN        0x420
> > +#define UTL_SYS_BUS_BURST_SZ_CONF       0x440
> > +#define UTL_REVISION_ID                 0x448
> > +#define UTL_BCLK_DOMAIN_DBG1            0x460
> > +#define UTL_BCLK_DOMAIN_DBG2            0x468
> > +#define UTL_BCLK_DOMAIN_DBG3            0x470
> > +#define UTL_BCLK_DOMAIN_DBG4            0x478
> > +#define UTL_BCLK_DOMAIN_DBG5            0x480
> > +#define UTL_BCLK_DOMAIN_DBG6            0x488
> > +#define UTL_OUT_POST_HDR_BUF_ALLOC      0x4c0
> > +#define UTL_OUT_POST_DAT_BUF_ALLOC      0x4d0
> > +#define UTL_IN_POST_HDR_BUF_ALLOC       0x4e0
> > +#define UTL_IN_POST_DAT_BUF_ALLOC       0x4f0
> > +#define UTL_OUT_NP_BUF_ALLOC            0x500
> > +#define UTL_IN_NP_BUF_ALLOC             0x510
> > +#define UTL_PCIE_TAGS_ALLOC             0x520
> > +#define UTL_GBIF_READ_TAGS_ALLOC        0x530
> > +#define UTL_PCIE_PORT_CONTROL           0x540
> > +#define UTL_PCIE_PORT_STATUS            0x548
> > +#define UTL_PCIE_PORT_ERROR_SEV         0x550
> > +#define UTL_PCIE_PORT_IRQ_EN            0x558
> > +#define UTL_RC_STATUS                   0x560
> > +#define UTL_RC_ERR_SEVERITY             0x568
> > +#define UTL_RC_IRQ_EN                   0x570
> > +#define UTL_EP_STATUS                   0x578
> > +#define UTL_EP_ERR_SEVERITY             0x580
> > +#define UTL_EP_ERR_IRQ_EN               0x588
> > +#define UTL_PCI_PM_CTRL1                0x590
> > +#define UTL_PCI_PM_CTRL2                0x598
> > +#define UTL_GP_CTL1                     0x5a0
> > +#define UTL_GP_CTL2                     0x5a8
> > +#define UTL_PCLK_DOMAIN_DBG1            0x5b0
> > +#define UTL_PCLK_DOMAIN_DBG2            0x5b8
> > +#define UTL_PCLK_DOMAIN_DBG3            0x5c0
> > +#define UTL_PCLK_DOMAIN_DBG4            0x5c8
> > +
> > +/* PCI-E Stack registers */
> > +#define PHB_PCIE_SYSTEM_CONFIG          0x600
> > +#define PHB_PCIE_BUS_NUMBER             0x608
> > +#define PHB_PCIE_SYSTEM_TEST            0x618
> > +#define PHB_PCIE_LINK_MANAGEMENT        0x630
> > +#define   PHB_PCIE_LM_LINK_ACTIVE       PPC_BIT(8)
> > +#define PHB_PCIE_DLP_TRAIN_CTL          0x640
> > +#define   PHB_PCIE_DLP_TCTX_DISABLE     PPC_BIT(1)
> > +#define   PHB_PCIE_DLP_TCRX_DISABLED    PPC_BIT(16)
> > +#define   PHB_PCIE_DLP_INBAND_PRESENCE  PPC_BIT(19)
> > +#define   PHB_PCIE_DLP_TC_DL_LINKUP     PPC_BIT(21)
> > +#define   PHB_PCIE_DLP_TC_DL_PGRESET    PPC_BIT(22)
> > +#define   PHB_PCIE_DLP_TC_DL_LINKACT    PPC_BIT(23)
> > +#define PHB_PCIE_SLOP_LOOPBACK_STATUS   0x648
> > +#define PHB_PCIE_SYS_LINK_INIT          0x668
> > +#define PHB_PCIE_UTL_CONFIG             0x670
> > +#define PHB_PCIE_DLP_CONTROL            0x678
> > +#define PHB_PCIE_UTL_ERRLOG1            0x680
> > +#define PHB_PCIE_UTL_ERRLOG2            0x688
> > +#define PHB_PCIE_UTL_ERRLOG3            0x690
> > +#define PHB_PCIE_UTL_ERRLOG4            0x698
> > +#define PHB_PCIE_DLP_ERRLOG1            0x6a0
> > +#define PHB_PCIE_DLP_ERRLOG2            0x6a8
> > +#define PHB_PCIE_DLP_ERR_STATUS         0x6b0
> > +#define PHB_PCIE_DLP_ERR_COUNTERS       0x6b8
> > +#define PHB_PCIE_UTL_ERR_INJECT         0x6c0
> > +#define PHB_PCIE_TLDLP_ERR_INJECT       0x6c8
> > +#define PHB_PCIE_LANE_EQ_CNTL0          0x6d0
> > +#define PHB_PCIE_LANE_EQ_CNTL1          0x6d8
> > +#define PHB_PCIE_LANE_EQ_CNTL2          0x6e0
> > +#define PHB_PCIE_LANE_EQ_CNTL3          0x6e8
> > +#define PHB_PCIE_STRAPPING              0x700
> > +
> > +/* Fundamental register set B */
> > +#define PHB_VERSION                     0x800
> > +#define PHB_RESET                       0x808
> > +#define PHB_CONTROL                     0x810
> > +#define   PHB_CTRL_IVE_128_BYTES        PPC_BIT(24)
> > +#define PHB_AIB_RX_CRED_INIT_TIMER      0x818
> > +#define PHB_AIB_RX_CMD_CRED             0x820
> > +#define PHB_AIB_RX_DATA_CRED            0x828
> > +#define PHB_AIB_TX_CMD_CRED             0x830
> > +#define PHB_AIB_TX_DATA_CRED            0x838
> > +#define PHB_AIB_TX_CHAN_MAPPING         0x840
> > +#define PHB_AIB_TAG_ENABLE              0x858
> > +#define PHB_AIB_FENCE_CTRL              0x860
> > +#define PHB_TCE_TAG_ENABLE              0x868
> > +#define PHB_TCE_WATERMARK               0x870
> > +#define PHB_TIMEOUT_CTRL1               0x878
> > +#define PHB_TIMEOUT_CTRL2               0x880
> > +#define PHB_QUIESCE_DMA_G               0x888
> > +#define PHB_AIB_TAG_STATUS              0x900
> > +#define PHB_TCE_TAG_STATUS              0x908
> > +
> > +/* FIR & Error registers */
> > +#define PHB_LEM_FIR_ACCUM               0xc00
> > +#define PHB_LEM_FIR_AND_MASK            0xc08
> > +#define PHB_LEM_FIR_OR_MASK             0xc10
> > +#define PHB_LEM_ERROR_MASK              0xc18
> > +#define PHB_LEM_ERROR_AND_MASK          0xc20
> > +#define PHB_LEM_ERROR_OR_MASK           0xc28
> > +#define PHB_LEM_ACTION0                 0xc30
> > +#define PHB_LEM_ACTION1                 0xc38
> > +#define PHB_LEM_WOF                     0xc40
> > +#define PHB_ERR_STATUS                  0xc80
> > +#define PHB_ERR1_STATUS                 0xc88
> > +#define PHB_ERR_INJECT                  0xc90
> > +#define PHB_ERR_LEM_ENABLE              0xc98
> > +#define PHB_ERR_IRQ_ENABLE              0xca0
> > +#define PHB_ERR_FREEZE_ENABLE           0xca8
> > +#define PHB_ERR_AIB_FENCE_ENABLE        0xcb0
> > +#define PHB_ERR_LOG_0                   0xcc0
> > +#define PHB_ERR_LOG_1                   0xcc8
> > +#define PHB_ERR_STATUS_MASK             0xcd0
> > +#define PHB_ERR1_STATUS_MASK            0xcd8
> > +
> > +#define PHB_OUT_ERR_STATUS              0xd00
> > +#define PHB_OUT_ERR1_STATUS             0xd08
> > +#define PHB_OUT_ERR_INJECT              0xd10
> > +#define PHB_OUT_ERR_LEM_ENABLE          0xd18
> > +#define PHB_OUT_ERR_IRQ_ENABLE          0xd20
> > +#define PHB_OUT_ERR_FREEZE_ENABLE       0xd28
> > +#define PHB_OUT_ERR_AIB_FENCE_ENABLE    0xd30
> > +#define PHB_OUT_ERR_LOG_0               0xd40
> > +#define PHB_OUT_ERR_LOG_1               0xd48
> > +#define PHB_OUT_ERR_STATUS_MASK         0xd50
> > +#define PHB_OUT_ERR1_STATUS_MASK        0xd58
> > +
> > +#define PHB_INA_ERR_STATUS              0xd80
> > +#define PHB_INA_ERR1_STATUS             0xd88
> > +#define PHB_INA_ERR_INJECT              0xd90
> > +#define PHB_INA_ERR_LEM_ENABLE          0xd98
> > +#define PHB_INA_ERR_IRQ_ENABLE          0xda0
> > +#define PHB_INA_ERR_FREEZE_ENABLE       0xda8
> > +#define PHB_INA_ERR_AIB_FENCE_ENABLE    0xdb0
> > +#define PHB_INA_ERR_LOG_0               0xdc0
> > +#define PHB_INA_ERR_LOG_1               0xdc8
> > +#define PHB_INA_ERR_STATUS_MASK         0xdd0
> > +#define PHB_INA_ERR1_STATUS_MASK        0xdd8
> > +
> > +#define PHB_INB_ERR_STATUS              0xe00
> > +#define PHB_INB_ERR1_STATUS             0xe08
> > +#define PHB_INB_ERR_INJECT              0xe10
> > +#define PHB_INB_ERR_LEM_ENABLE          0xe18
> > +#define PHB_INB_ERR_IRQ_ENABLE          0xe20
> > +#define PHB_INB_ERR_FREEZE_ENABLE       0xe28
> > +#define PHB_INB_ERR_AIB_FENCE_ENABLE    0xe30
> > +#define PHB_INB_ERR_LOG_0               0xe40
> > +#define PHB_INB_ERR_LOG_1               0xe48
> > +#define PHB_INB_ERR_STATUS_MASK         0xe50
> > +#define PHB_INB_ERR1_STATUS_MASK        0xe58
> > +
> > +/* Performance monitor & Debug registers */
> > +#define PHB_TRACE_CONTROL               0xf80
> > +#define PHB_PERFMON_CONFIG              0xf88
> > +#define PHB_PERFMON_CTR0                0xf90
> > +#define PHB_PERFMON_CTR1                0xf98
> > +#define PHB_PERFMON_CTR2                0xfa0
> > +#define PHB_PERFMON_CTR3                0xfa8
> > +#define PHB_HOTPLUG_OVERRIDE            0xfb0
> > +#define   PHB_HPOVR_FORCE_RESAMPLE      PPC_BIT(9)
> > +#define   PHB_HPOVR_PRESENCE_A          PPC_BIT(10)
> > +#define   PHB_HPOVR_PRESENCE_B          PPC_BIT(11)
> > +#define   PHB_HPOVR_LINK_ACTIVE         PPC_BIT(12)
> > +#define   PHB_HPOVR_LINK_BIFURCATED     PPC_BIT(13)
> > +#define   PHB_HPOVR_LINK_LANE_SWAPPED   PPC_BIT(14)
> > +
> > +/*
> > + * IODA2 on-chip tables
> > + */
> > +
> > +#define IODA2_TBL_LIST          1
> > +#define IODA2_TBL_LXIVT         2
> > +#define IODA2_TBL_IVC_CAM       3
> > +#define IODA2_TBL_RBA           4
> > +#define IODA2_TBL_RCAM          5
> > +#define IODA2_TBL_MRT           6
> > +#define IODA2_TBL_PESTA         7
> > +#define IODA2_TBL_PESTB         8
> > +#define IODA2_TBL_TVT           9
> > +#define IODA2_TBL_TCAM          10
> > +#define IODA2_TBL_TDR           11
> > +#define IODA2_TBL_M64BT         16
> > +#define IODA2_TBL_M32DT         17
> > +#define IODA2_TBL_PEEV          20
> > +
> > +/* LXIVT */
> > +#define IODA2_LXIVT_SERVER              PPC_BITMASK(8, 23)
> > +#define IODA2_LXIVT_PRIORITY            PPC_BITMASK(24, 31)
> > +#define IODA2_LXIVT_NODE_ID             PPC_BITMASK(56, 63)
> > +
> > +/* IVT */
> > +#define IODA2_IVT_SERVER                PPC_BITMASK(0, 23)
> > +#define IODA2_IVT_PRIORITY              PPC_BITMASK(24, 31)
> > +#define IODA2_IVT_GEN                   PPC_BITMASK(37, 38)
> > +#define IODA2_IVT_P                     PPC_BITMASK(39, 39)
> > +#define IODA2_IVT_Q                     PPC_BITMASK(47, 47)
> > +#define IODA2_IVT_PE                    PPC_BITMASK(48, 63)
> > +
> > +/* TVT */
> > +#define IODA2_TVT_TABLE_ADDR            PPC_BITMASK(0, 47)
> > +#define IODA2_TVT_NUM_LEVELS            PPC_BITMASK(48, 50)
> > +#define   IODA2_TVE_1_LEVEL     0
> > +#define   IODA2_TVE_2_LEVELS    1
> > +#define   IODA2_TVE_3_LEVELS    2
> > +#define   IODA2_TVE_4_LEVELS    3
> > +#define   IODA2_TVE_5_LEVELS    4
> > +#define IODA2_TVT_TCE_TABLE_SIZE        PPC_BITMASK(51, 55)
> > +#define IODA2_TVT_IO_PSIZE              PPC_BITMASK(59, 63)
> > +
> > +/* PESTA */
> > +#define IODA2_PESTA_MMIO_FROZEN         PPC_BIT(0)
> > +
> > +/* PESTB */
> > +#define IODA2_PESTB_DMA_STOPPED         PPC_BIT(0)
> > +
> > +/* M32DT */
> > +#define IODA2_M32DT_PE_MASK             PPC_BITMASK(8, 15)
> > +#define IODA2_M32DT_PE_LSH              PPC_BITLSHIFT(15)
> > +
> > +/* M64BT */
> > +#define IODA2_M64BT_ENABLE              PPC_BIT(0)
> > +#define IODA2_M64BT_SINGLE_PE           PPC_BIT(1)
> > +#define IODA2_M64BT_BASE                PPC_BITMASK(2, 31)
> > +#define IODA2_M64BT_MASK                PPC_BITMASK(34, 63)
> > +#define IODA2_M64BT_SINGLE_BASE_MASK    PPC_BITMASK(2, 26)
> > +#define IODA2_M64BT_SINGLE_BASE_LSH     PPC_BITLSHIFT(26)
> > +#define IODA2_M64BT_PE_HI_MASK          PPC_BITMASK(27, 31)
> > +#define IODA2_M64BT_PE_HI_LSH           PPC_BITLSHIFT(31)
> > +#define IODA2_M64BT_SINGLE_MASK_MASK    PPC_BITMASK(34, 58)
> > +#define IODA2_M64BT_SINGLE_MASK_LSH     PPC_BITLSHIFT(58)
> > +#define IODA2_M64BT_PE_LOW_MASK         PPC_BITMASK(59, 63)
> > +#define IODA2_M64BT_PE_LOW_LSH          PPC_BITLSHIFT(63)
> > +
> > +/*
> > + * IODA2 in-memory tables
> > + */
> > +
> > +/* PEST
> > + *
> > + * 2x8 bytes entries, PEST0 and PEST1
> > + */
> > +
> > +#define IODA2_PEST0_MMIO_CAUSE          PPC_BIT(2)
> > +#define IODA2_PEST0_CFG_READ            PPC_BIT(3)
> > +#define IODA2_PEST0_CFG_WRITE           PPC_BIT(4)
> > +#define IODA2_PEST0_TTYPE_MASK          PPC_BITMASK(5, 7)
> > +#define IODA2_PEST0_TTYPE_LSH           PPC_BITLSHIFT(7)
> > +#define   PEST_TTYPE_DMA_WRITE          0
> > +#define   PEST_TTYPE_MSI                1
> > +#define   PEST_TTYPE_DMA_READ           2
> > +#define   PEST_TTYPE_DMA_READ_RESP      3
> > +#define   PEST_TTYPE_MMIO_LOAD          4
> > +#define   PEST_TTYPE_MMIO_STORE         5
> > +#define   PEST_TTYPE_OTHER              7
> > +#define IODA2_PEST0_CA_RETURN           PPC_BIT(8)
> > +#define IODA2_PEST0_UTL_RTOS_TIMEOUT    PPC_BIT(8) /* Same bit as CA r=
eturn */
> > +#define IODA2_PEST0_UR_RETURN           PPC_BIT(9)
> > +#define IODA2_PEST0_UTL_NONFATAL        PPC_BIT(10)
> > +#define IODA2_PEST0_UTL_FATAL           PPC_BIT(11)
> > +#define IODA2_PEST0_PARITY_UE           PPC_BIT(13)
> > +#define IODA2_PEST0_UTL_CORRECTABLE     PPC_BIT(14)
> > +#define IODA2_PEST0_UTL_INTERRUPT       PPC_BIT(15)
> > +#define IODA2_PEST0_MMIO_XLATE          PPC_BIT(16)
> > +#define IODA2_PEST0_IODA2_ERROR         PPC_BIT(16) /* Same bit as MMI=
O xlate */
> > +#define IODA2_PEST0_TCE_PAGE_FAULT      PPC_BIT(18)
> > +#define IODA2_PEST0_TCE_ACCESS_FAULT    PPC_BIT(19)
> > +#define IODA2_PEST0_DMA_RESP_TIMEOUT    PPC_BIT(20)
> > +#define IODA2_PEST0_AIB_SIZE_INVALID    PPC_BIT(21)
> > +#define IODA2_PEST0_LEM_BIT_MASK        PPC_BITMASK(26, 31)
> > +#define IODA2_PEST0_LEM_BIT_LSH         PPC_BITLSHIFT(31)
> > +#define IODA2_PEST0_RID_MASK            PPC_BITMASK(32, 47)
> > +#define IODA2_PEST0_RID_LSH             PPC_BITLSHIFT(47)
> > +#define IODA2_PEST0_MSI_DATA_MASK       PPC_BITMASK(48, 63)
> > +#define IODA2_PEST0_MSI_DATA_LSH        PPC_BITLSHIFT(63)
> > +
> > +#define IODA2_PEST1_FAIL_ADDR_MASK      PPC_BITMASK(3, 63)
> > +#define IODA2_PEST1_FAIL_ADDR_LSH       PPC_BITLSHIFT(63)
> > +
> > +
> > +#endif /* PCI_HOST_PNV_PHB3_REGS_H */
> > diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> > index 86d5f54e5459..61af65fc0b76 100644
> > --- a/include/hw/ppc/pnv.h
> > +++ b/include/hw/ppc/pnv.h
> > @@ -25,6 +25,7 @@
> >  #include "hw/ppc/pnv_lpc.h"
> >  #include "hw/ppc/pnv_psi.h"
> >  #include "hw/ppc/pnv_occ.h"
> > +#include "hw/pci-host/pnv_phb3.h"
> > =20
> >  #define TYPE_PNV_CHIP "pnv-chip"
> >  #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
> > @@ -72,6 +73,9 @@ typedef struct Pnv8Chip {
> >      PnvLpcController lpc;
> >      PnvPsi       psi;
> >      PnvOCC       occ;
> > +
> > +#define PNV8_CHIP_PHB3_MAX 4
> > +    PnvPHB3      phbs[PNV8_CHIP_PHB3_MAX];
> >  } Pnv8Chip;
> > =20
> >  #define TYPE_PNV9_CHIP "pnv9-chip"
> > @@ -92,6 +96,7 @@ typedef struct PnvChipClass {
> >      PnvChipType  chip_type;
> >      uint64_t     chip_cfam_id;
> >      uint64_t     cores_mask;
> > +    uint32_t     num_phbs;
> > =20
> >      hwaddr       xscom_base;
> > =20
> > @@ -171,6 +176,23 @@ static inline bool pnv_is_power9(PnvMachineState *=
pnv)
> >      return pnv_chip_is_power9(pnv->chips[0]);
> >  }
> > =20
> > +/*
> > + * This is used by devices created on the command line to find a chip
> > + * on which to attach to.
> > + */
> > +static inline PnvChip *pnv_get_chip(PnvMachineState *pnv, uint chip_id)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < pnv->num_chips; i++) {
> > +        PnvChip *chip =3D pnv->chips[i];
> > +        if (chip->chip_id =3D=3D chip_id) {
> > +            return chip;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> >  #define PNV_FDT_ADDR          0x01000000
> >  #define PNV_TIMEBASE_FREQ     512000000ULL
> > =20
> > diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> > index 255b26a5aaf6..e7ebffa5cf8a 100644
> > --- a/include/hw/ppc/pnv_xscom.h
> > +++ b/include/hw/ppc/pnv_xscom.h
> > @@ -73,6 +73,15 @@ typedef struct PnvXScomInterfaceClass {
> >  #define PNV_XSCOM_OCC_BASE        0x0066000
> >  #define PNV_XSCOM_OCC_SIZE        0x6000
> > =20
> > +#define PNV_XSCOM_PBCQ_NEST_BASE  0x2012000
> > +#define PNV_XSCOM_PBCQ_NEST_SIZE  0x46
> > +
> > +#define PNV_XSCOM_PBCQ_PCI_BASE   0x9012000
> > +#define PNV_XSCOM_PBCQ_PCI_SIZE   0x15
> > +
> > +#define PNV_XSCOM_PBCQ_SPCI_BASE  0x9013c00
> > +#define PNV_XSCOM_PBCQ_SPCI_SIZE  0x5
> > +
> >  extern void pnv_xscom_realize(PnvChip *chip, Error **errp);
> >  extern int pnv_dt_xscom(PnvChip *chip, void *fdt, int offset);
> > =20
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 6ac8a9392da6..966a996c2eac 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -194,6 +194,7 @@ void icp_set_mfrr(ICPState *icp, uint8_t mfrr);
> >  uint32_t icp_accept(ICPState *ss);
> >  uint32_t icp_ipoll(ICPState *ss, uint32_t *mfrr);
> >  void icp_eoi(ICPState *icp, uint32_t xirr);
> > +void icp_irq(ICSState *ics, int server, int nr, uint8_t priority);
> > =20
> >  void ics_simple_write_xive(ICSState *ics, int nr, int server,
> >                             uint8_t priority, uint8_t saved_priority);
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index b9f1a3c97214..59e2a5217dcc 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -230,7 +230,7 @@ void icp_eoi(ICPState *icp, uint32_t xirr)
> >      }
> >  }
> > =20
> > -static void icp_irq(ICSState *ics, int server, int nr, uint8_t priorit=
y)
> > +void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
> >  {
> >      ICPState *icp =3D xics_icp_get(ics->xics, server);
> > =20
> > diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
> > new file mode 100644
> > index 000000000000..e11993e0e1fb
> > --- /dev/null
> > +++ b/hw/pci-host/pnv_phb3.c
> > @@ -0,0 +1,1219 @@
> > +/*
> > + * QEMU PowerPC PowerNV PHB3 model
> > + *
> > + * Copyright (c) 2014-2018, IBM Corporation.
> > + *
> > + * This code is licensed under the GPL version 2 or later. See the
> > + * COPYING file in the top-level directory.
> > + */
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "qapi/visitor.h"
> > +#include "qapi/error.h"
> > +#include "qemu-common.h"
> > +#include "target/ppc/cpu.h"
> > +#include "hw/pci-host/pnv_phb3_regs.h"
> > +#include "hw/pci-host/pnv_phb3.h"
> > +#include "hw/pci/pci_bridge.h"
> > +#include "hw/pci/pci_bus.h"
> > +#include "hw/pci/pcie_port.h"
> > +#include "hw/ppc/pnv.h"
> > +
> > +static PCIDevice *pnv_phb3_find_cfg_dev(PnvPHB3 *phb)
> > +{
> > +    PCIHostState *pci =3D PCI_HOST_BRIDGE(phb);
> > +    uint64_t addr =3D phb->regs[PHB_CONFIG_ADDRESS >> 3];
> > +    uint8_t bus, devfn;
> > +
> > +    if (!(addr >> 63)) {
> > +        return NULL;
> > +    }
> > +    bus =3D (addr >> 52) & 0xff;
> > +    devfn =3D (addr >> 44) & 0xff;
> > +
> > +    return pci_find_device(pci->bus, bus, devfn);
> > +}
> > +
> > +/*
> > + * The CONFIG_DATA register expects little endian accesses, but as the
> > + * region is big endian, we have to swap the value.
> > + */
> > +static void pnv_phb3_config_write(PnvPHB3 *phb, unsigned off,
> > +                                  unsigned size, uint64_t val)
> > +{
> > +    uint32_t cfg_addr, limit;
> > +    PCIDevice *pdev;
> > +
> > +    pdev =3D pnv_phb3_find_cfg_dev(phb);
> > +    if (!pdev) {
> > +        return;
> > +    }
> > +    cfg_addr =3D (phb->regs[PHB_CONFIG_ADDRESS >> 3] >> 32) & 0xfff;
> > +    cfg_addr |=3D off;
> > +    limit =3D pci_config_size(pdev);
> > +    if (limit <=3D cfg_addr) {
> > +        /* conventional pci device can be behind pcie-to-pci bridge.
> > +           256 <=3D addr < 4K has no effects. */
> > +        return;
> > +    }
> > +    switch (size) {
> > +    case 1:
> > +        break;
> > +    case 2:
> > +        val =3D bswap16(val);
> > +        break;
> > +    case 4:
> > +        val =3D bswap32(val);
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +    pci_host_config_write_common(pdev, cfg_addr, limit, val, size);
> > +}
> > +
> > +static uint64_t pnv_phb3_config_read(PnvPHB3 *phb, unsigned off,
> > +                                     unsigned size)
> > +{
> > +    uint32_t cfg_addr, limit;
> > +    PCIDevice *pdev;
> > +    uint64_t val;
> > +
> > +    pdev =3D pnv_phb3_find_cfg_dev(phb);
> > +    if (!pdev) {
> > +        return ~0ull;
> > +    }
> > +    cfg_addr =3D (phb->regs[PHB_CONFIG_ADDRESS >> 3] >> 32) & 0xffc;
> > +    cfg_addr |=3D off;
> > +    limit =3D pci_config_size(pdev);
> > +    if (limit <=3D cfg_addr) {
> > +        /* conventional pci device can be behind pcie-to-pci bridge.
> > +           256 <=3D addr < 4K has no effects. */
> > +        return ~0ull;
> > +    }
> > +    val =3D pci_host_config_read_common(pdev, cfg_addr, limit, size);
> > +    switch (size) {
> > +    case 1:
> > +        return val;
> > +    case 2:
> > +        return bswap16(val);
> > +    case 4:
> > +        return bswap32(val);
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +}
> > +
> > +static void pnv_phb3_check_m32(PnvPHB3 *phb)
> > +{
> > +    uint64_t base, start, size;
> > +    MemoryRegion *parent;
> > +    PnvPBCQState *pbcq =3D &phb->pbcq;
> > +
> > +    if (phb->m32_mapped) {
> > +        memory_region_del_subregion(phb->mr_m32.container, &phb->mr_m3=
2);
> > +        phb->m32_mapped =3D false;
> > +    }
> > +
> > +    /* Disabled ? move on with life ... */
> > +    if (!(phb->regs[PHB_PHB3_CONFIG >> 3] & PHB_PHB3C_M32_EN)) {
> > +        return;
> > +    }
> > +
> > +    /* Grab geometry from registers */
> > +    base =3D phb->regs[PHB_M32_BASE_ADDR >> 3];
> > +    start =3D phb->regs[PHB_M32_START_ADDR >> 3];
> > +    size =3D ~(phb->regs[PHB_M32_BASE_MASK >> 3] | 0xfffc000000000000u=
ll) + 1;
> > +
> > +    /* Check if it matches an enabled MMIO region in the PBCQ */
> > +    if (pbcq->mmio0_mapped && base >=3D pbcq->mmio0_base &&
> > +        (base + size) <=3D (pbcq->mmio0_base + pbcq->mmio0_size)) {
> > +        parent =3D &pbcq->mmbar0;
> > +        base -=3D pbcq->mmio0_base;
> > +    } else if (pbcq->mmio1_mapped && base >=3D pbcq->mmio1_base &&
> > +        (base + size) <=3D (pbcq->mmio1_base + pbcq->mmio1_size)) {
> > +        parent =3D &pbcq->mmbar1;
> > +        base -=3D pbcq->mmio1_base;
> > +    } else {
> > +        return;
> > +    }
> > +
> > +    /* Create alias */
> > +    memory_region_init_alias(&phb->mr_m32, OBJECT(phb), "phb3-m32",
> > +                             &phb->pci_mmio, start, size);
> > +    memory_region_add_subregion(parent, base, &phb->mr_m32);
> > +    phb->m32_mapped =3D true;
> > +}
> > +
> > +static void pnv_phb3_check_m64(PnvPHB3 *phb, uint32_t index)
> > +{
> > +    uint64_t base, start, size, m64;
> > +    MemoryRegion *parent;
> > +    PnvPBCQState *pbcq =3D &phb->pbcq;
> > +
> > +    if (phb->m64_mapped[index]) {
> > +        /* Should we destroy it in RCU friendly way... ? */
> > +        memory_region_del_subregion(phb->mr_m64[index].container,
> > +                                    &phb->mr_m64[index]);
> > +        phb->m64_mapped[index] =3D false;
> > +    }
> > +
> > +    /* Get table entry */
> > +    m64 =3D phb->ioda_M64BT[index];
> > +
> > +    /* Disabled ? move on with life ... */
> > +    if (!(m64 & IODA2_M64BT_ENABLE)) {
> > +        return;
> > +    }
> > +
> > +    /* Grab geometry from registers */
> > +    base =3D GETFIELD(IODA2_M64BT_BASE, m64) << 20;
> > +    if (m64 & IODA2_M64BT_SINGLE_PE) {
> > +        base &=3D ~0x1ffffffull;
> > +    }
> > +    size =3D GETFIELD(IODA2_M64BT_MASK, m64) << 20;
> > +    size |=3D 0xfffc000000000000ull;
> > +    size =3D ~size + 1;
> > +    start =3D base | (phb->regs[PHB_M64_UPPER_BITS >> 3]);
> > +
> > +    /* Check if it matches an enabled MMIO region in the PBCQ */
> > +    if (pbcq->mmio0_mapped && base >=3D pbcq->mmio0_base &&
> > +        (base + size) <=3D (pbcq->mmio0_base + pbcq->mmio0_size)) {
> > +        parent =3D &pbcq->mmbar0;
> > +        base -=3D pbcq->mmio0_base;
> > +    } else if (pbcq->mmio1_mapped && base >=3D pbcq->mmio1_base &&
> > +        (base + size) <=3D (pbcq->mmio1_base + pbcq->mmio1_size)) {
> > +        parent =3D &pbcq->mmbar1;
> > +        base -=3D pbcq->mmio1_base;
> > +    } else {
> > +        return;
> > +    }
> > +
> > +    /* Create alias */
> > +    memory_region_init_alias(&phb->mr_m64[index], OBJECT(phb), "phb3-m=
64",
> > +                             &phb->pci_mmio, start, size);
> > +    memory_region_add_subregion(parent, base, &phb->mr_m64[index]);
> > +    phb->m64_mapped[index] =3D true;
> > +}
> > +
> > +static void pnv_phb3_check_all_m64s(PnvPHB3 *phb)
> > +{
> > +    uint64_t i;
> > +
> > +    for (i =3D 0; i < PNV_PHB3_NUM_M64; i++) {
> > +        pnv_phb3_check_m64(phb, i);
> > +    }
> > +}
> > +
> > +static void pnv_phb3_lxivt_write(PnvPHB3 *phb, unsigned idx, uint64_t =
val)
> > +{
> > +    ICSState *ics =3D &phb->lsis;
> > +    uint8_t server, prio;
> > +
> > +    phb->ioda_LXIVT[idx] =3D val & (IODA2_LXIVT_SERVER |
> > +                                  IODA2_LXIVT_PRIORITY |
> > +                                  IODA2_LXIVT_NODE_ID);
> > +    server =3D GETFIELD(IODA2_LXIVT_SERVER, val);
> > +    prio =3D GETFIELD(IODA2_LXIVT_PRIORITY, val);
> > +
> > +    /*
> > +     * The low order 2 bits are the link pointer (Type II interrupts).
> > +     * Shift back to get a valid IRQ server.
> > +     */
> > +    server >>=3D 2;
> > +
> > +    ics_simple_write_xive(ics, idx, server, prio, prio);
> > +}
> > +
> > +static uint64_t *pnv_phb3_ioda_access(PnvPHB3 *phb,
> > +                                      unsigned *out_table, unsigned *o=
ut_idx)
> > +{
> > +    uint64_t adreg =3D phb->regs[PHB_IODA_ADDR >> 3];
> > +    unsigned int index =3D GETFIELD(PHB_IODA_AD_TADR, adreg);
> > +    unsigned int table =3D GETFIELD(PHB_IODA_AD_TSEL, adreg);
> > +    unsigned int mask;
> > +    uint64_t *tptr =3D NULL;
> > +
> > +    switch (table) {
> > +    case IODA2_TBL_LIST:
> > +        tptr =3D phb->ioda_LIST;
> > +        mask =3D 7;
> > +        break;
> > +    case IODA2_TBL_LXIVT:
> > +        tptr =3D phb->ioda_LXIVT;
> > +        mask =3D 7;
> > +        break;
> > +    case IODA2_TBL_IVC_CAM:
> > +    case IODA2_TBL_RBA:
> > +        mask =3D 31;
> > +        break;
> > +    case IODA2_TBL_RCAM:
> > +        mask =3D 63;
> > +        break;
> > +    case IODA2_TBL_MRT:
> > +        mask =3D 7;
> > +        break;
> > +    case IODA2_TBL_PESTA:
> > +    case IODA2_TBL_PESTB:
> > +        mask =3D 255;
> > +        break;
> > +    case IODA2_TBL_TVT:
> > +        tptr =3D phb->ioda_TVT;
> > +        mask =3D 511;
> > +        break;
> > +    case IODA2_TBL_TCAM:
> > +    case IODA2_TBL_TDR:
> > +        mask =3D 63;
> > +        break;
> > +    case IODA2_TBL_M64BT:
> > +        tptr =3D phb->ioda_M64BT;
> > +        mask =3D 15;
> > +        break;
> > +    case IODA2_TBL_M32DT:
> > +        tptr =3D phb->ioda_MDT;
> > +        mask =3D 255;
> > +        break;
> > +    case IODA2_TBL_PEEV:
> > +        tptr =3D phb->ioda_PEEV;
> > +        mask =3D 3;
> > +        break;
> > +    default:
> > +        return NULL;
> > +    }
> > +    index &=3D mask;
> > +    if (out_idx) {
> > +        *out_idx =3D index;
> > +    }
> > +    if (out_table) {
> > +        *out_table =3D table;
> > +    }
> > +    if (adreg & PHB_IODA_AD_AUTOINC) {
> > +        index =3D (index + 1) & mask;
> > +        adreg =3D SETFIELD(PHB_IODA_AD_TADR, adreg, index);
> > +    }
> > +    if (tptr) {
> > +        tptr +=3D index;
> > +    }
> > +    phb->regs[PHB_IODA_ADDR >> 3] =3D adreg;
> > +    return tptr;
> > +}
> > +
> > +static uint64_t pnv_phb3_ioda_read(PnvPHB3 *phb)
> > +{
> > +        unsigned table;
> > +        uint64_t *tptr;
> > +
> > +        tptr =3D pnv_phb3_ioda_access(phb, &table, NULL);
> > +        if (!tptr) {
> > +            /* Return 0 on unsupported tables, not ff's */
> > +            return 0;
> > +        }
> > +        return *tptr;
> > +}
> > +
> > +static void pnv_phb3_ioda_write(PnvPHB3 *phb, uint64_t val)
> > +{
> > +        unsigned table, idx;
> > +        uint64_t *tptr;
> > +
> > +        tptr =3D pnv_phb3_ioda_access(phb, &table, &idx);
> > +        if (!tptr) {
> > +            return;
> > +        }
> > +
> > +        /* Handle side effects */
> > +        switch (table) {
> > +        case IODA2_TBL_LXIVT:
> > +            pnv_phb3_lxivt_write(phb, idx, val);
> > +            break;
> > +        case IODA2_TBL_M64BT:
> > +            *tptr =3D val;
> > +            pnv_phb3_check_m64(phb, idx);
> > +            break;
> > +        default:
> > +            *tptr =3D val;
> > +        }
> > +}
> > +
> > +/* This is called whenever the PHB LSI, MSI source ID register or
> > + * the PBCQ irq filters are written.
> > + */
> > +void pnv_phb3_remap_irqs(PnvPHB3 *phb)
> > +{
> > +    ICSState *ics =3D &phb->lsis;
> > +    uint32_t local, global, count, mask, comp;
> > +    uint64_t baren;
> > +    PnvPBCQState *pbcq =3D &phb->pbcq;
> > +
> > +    /* First check if we are enabled. Unlike real HW we don't separate=
 TX and RX
> > +     * so we enable if both are set
> > +     */
> > +    baren =3D pbcq->nest_regs[PBCQ_NEST_BAR_EN];
> > +    if (!(baren & PBCQ_NEST_BAR_EN_IRSN_RX) ||
> > +        !(baren & PBCQ_NEST_BAR_EN_IRSN_TX)) {
> > +        ics->offset =3D 0;
> > +        return;
> > +    }
> > +
> > +    /* Grab local LSI source ID */
> > +    local =3D GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> =
3]) << 3;
> > +
> > +    /* Grab global one and compare */
> > +    global =3D GETFIELD(PBCQ_NEST_LSI_SRC,
> > +                      pbcq->nest_regs[PBCQ_NEST_LSI_SRC_ID]) << 3;
> > +    if (global !=3D local) {
> > +        /* This happens during initialization, let's come back when we
> > +         * are properly configured
> > +         */
> > +        ics->offset =3D 0;
> > +        return;
> > +    }
> > +
> > +    /* Get the base on the powerbus */
> > +    comp =3D GETFIELD(PBCQ_NEST_IRSN_COMP,
> > +                    pbcq->nest_regs[PBCQ_NEST_IRSN_COMPARE]);
> > +    mask =3D GETFIELD(PBCQ_NEST_IRSN_COMP,
> > +                    pbcq->nest_regs[PBCQ_NEST_IRSN_MASK]);
> > +    count =3D ((~mask) + 1) & 0x7ffff;
> > +    phb->total_irq =3D count;
> > +
> > +    /* Sanity checks */
> > +    if ((global + PNV_PHB3_NUM_LSI) > count) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "LSIs out of reach: LSI base=3D%d total irq=3D%d=
",
> > +                      global, count);
> > +    }
> > +
> > +    if (count > 2048) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "More interrupts than supported: %d", count);
> > +    }
> > +
> > +    if ((comp & mask) !=3D comp) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "IRQ compare bits not in mask: comp=3D0x%x mask=
=3D0x%x",
> > +                      comp, mask);
> > +        comp &=3D mask;
> > +    }
> > +    /* Setup LSI offset */
> > +    ics->offset =3D comp + global;
> > +
> > +    /* Setup MSI offset */
> > +    pnv_phb3_msi_update_config(&phb->msis, comp, count - PNV_PHB3_NUM_=
LSI);
> > +}
> > +
> > +static void pnv_phb3_lsi_src_id_write(PnvPHB3 *phb, uint64_t val)
> > +{
> > +    /* Sanitize content */
> > +    val &=3D PHB_LSI_SRC_ID;
> > +    phb->regs[PHB_LSI_SOURCE_ID >> 3] =3D val;
> > +    pnv_phb3_remap_irqs(phb);
> > +}
> > +
> > +static void pnv_phb3_rtc_invalidate(PnvPHB3 *phb, uint64_t val)
> > +{
> > +    PnvPhb3DMASpace *ds;
> > +
> > +    /* Always invalidate all for now ... */
> > +    QLIST_FOREACH(ds, &phb->dma_spaces, list) {
> > +        ds->pe_num =3D PHB_INVALID_PE;
> > +    }
> > +}
> > +
> > +
> > +static void pnv_phb3_update_msi_regions(PnvPhb3DMASpace *ds)
> > +{
> > +    uint64_t cfg =3D ds->phb->regs[PHB_PHB3_CONFIG >> 3];
> > +
> > +    if (cfg & PHB_PHB3C_32BIT_MSI_EN) {
> > +        if (!ds->msi32_mapped) {
> > +            memory_region_add_subregion(MEMORY_REGION(&ds->dma_mr),
> > +                                        0xffff0000, &ds->msi32_mr);
> > +            ds->msi32_mapped =3D true;
> > +        }
> > +    } else {
> > +        if (ds->msi32_mapped) {
> > +            memory_region_del_subregion(MEMORY_REGION(&ds->dma_mr),
> > +                                        &ds->msi32_mr);
> > +            ds->msi32_mapped =3D false;
> > +        }
> > +    }
> > +
> > +    if (cfg & PHB_PHB3C_64BIT_MSI_EN) {
> > +        if (!ds->msi64_mapped) {
> > +            memory_region_add_subregion(MEMORY_REGION(&ds->dma_mr),
> > +                                        (1ull << 60), &ds->msi64_mr);
> > +            ds->msi64_mapped =3D true;
> > +        }
> > +    } else {
> > +        if (ds->msi64_mapped) {
> > +            memory_region_del_subregion(MEMORY_REGION(&ds->dma_mr),
> > +                                        &ds->msi64_mr);
> > +            ds->msi64_mapped =3D false;
> > +        }
> > +    }
> > +}
> > +
> > +static void pnv_phb3_update_all_msi_regions(PnvPHB3 *phb)
> > +{
> > +    PnvPhb3DMASpace *ds;
> > +
> > +    QLIST_FOREACH(ds, &phb->dma_spaces, list) {
> > +        pnv_phb3_update_msi_regions(ds);
> > +    }
> > +}
> > +
> > +void pnv_phb3_reg_write(void *opaque, hwaddr off, uint64_t val, unsign=
ed size)
> > +{
> > +    PnvPHB3 *phb =3D opaque;
> > +    bool changed;
> > +
> > +    /* Special case configuration data */
> > +    if ((off & 0xfffc) =3D=3D PHB_CONFIG_DATA) {
> > +        pnv_phb3_config_write(phb, off & 0x3, size, val);
> > +        return;
> > +    }
> > +
> > +    /* Other registers are 64-bit only */
> > +    if (size !=3D 8 || off & 0x7) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Invalid register access, offset: 0x%"PRIx64" si=
ze: %d",
> > +                      off, size);
> > +        return;
> > +    }
> > +
> > +    /* Handle masking */
> > +    switch (off) {
> > +    case PHB_M64_UPPER_BITS:
> > +        val &=3D 0xfffc000000000000ull;
> > +        break;
> > +    }
> > +
> > +    /* Record whether it changed */
> > +    changed =3D phb->regs[off >> 3] !=3D val;
> > +
> > +    /* Store in register cache first */
> > +    phb->regs[off >> 3] =3D val;
> > +
> > +    /* Handle side effects */
> > +    switch (off) {
> > +    case PHB_PHB3_CONFIG:
> > +        if (changed) {
> > +            pnv_phb3_update_all_msi_regions(phb);
> > +        }
> > +        /* fall through */
> > +    case PHB_M32_BASE_ADDR:
> > +    case PHB_M32_BASE_MASK:
> > +    case PHB_M32_START_ADDR:
> > +        if (changed) {
> > +            pnv_phb3_check_m32(phb);
> > +        }
> > +        break;
> > +    case PHB_M64_UPPER_BITS:
> > +        if (changed) {
> > +            pnv_phb3_check_all_m64s(phb);
> > +        }
> > +        break;
> > +    case PHB_LSI_SOURCE_ID:
> > +        if (changed) {
> > +            pnv_phb3_lsi_src_id_write(phb, val);
> > +        }
> > +        break;
> > +
> > +    /* IODA table accesses */
> > +    case PHB_IODA_DATA0:
> > +        pnv_phb3_ioda_write(phb, val);
> > +        break;
> > +
> > +    /* RTC invalidation */
> > +    case PHB_RTC_INVALIDATE:
> > +        pnv_phb3_rtc_invalidate(phb, val);
> > +        break;
> > +
> > +    /* FFI request */
> > +    case PHB_FFI_REQUEST:
> > +        pnv_phb3_msi_ffi(&phb->msis, val);
> > +        break;
> > +
> > +    /* Silent simple writes */
> > +    case PHB_CONFIG_ADDRESS:
> > +    case PHB_IODA_ADDR:
> > +    case PHB_TCE_KILL:
> > +    case PHB_TCE_SPEC_CTL:
> > +    case PHB_PEST_BAR:
> > +    case PHB_PELTV_BAR:
> > +    case PHB_RTT_BAR:
> > +    case PHB_RBA_BAR:
> > +    case PHB_IVT_BAR:
> > +    case PHB_FFI_LOCK:
> > +        break;
> > +
> > +    /* Noise on anything else */
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "reg_write 0x%"PRIx64"=3D%"PRIx64, of=
f, val);
> > +    }
> > +}
> > +
> > +uint64_t pnv_phb3_reg_read(void *opaque, hwaddr off, unsigned size)
> > +{
> > +    PnvPHB3 *phb =3D opaque;
> > +    uint64_t val;
> > +
> > +    if ((off & 0xfffc) =3D=3D PHB_CONFIG_DATA) {
> > +        return pnv_phb3_config_read(phb, off & 0x3, size);
> > +    }
> > +
> > +    /* Other registers are 64-bit only */
> > +    if (size !=3D 8 || off & 0x7) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Invalid register access, offset: 0x%"PRIx64" si=
ze: %d",
> > +                      off, size);
> > +        return ~0ull;
> > +    }
> > +
> > +    /* Default read from cache */
> > +    val =3D phb->regs[off >> 3];
> > +
> > +    switch (off) {
> > +    /* Simulate venice DD2.0 */
> > +    case PHB_VERSION:
> > +        return 0x000000a300000005ull;
> > +
> > +    /* IODA table accesses */
> > +    case PHB_IODA_DATA0:
> > +        return pnv_phb3_ioda_read(phb);
> > +
> > +    /* Link training always appears trained */
> > +    case PHB_PCIE_DLP_TRAIN_CTL:
> > +        return PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TC_DL_LINKA=
CT;
> > +
> > +    /* FFI Lock */
> > +    case PHB_FFI_LOCK:
> > +        /* Set lock and return previous value */
> > +        phb->regs[off >> 3] |=3D PHB_FFI_LOCK_STATE;
> > +        return val;
> > +
> > +    /* Silent simple reads */
> > +    case PHB_PHB3_CONFIG:
> > +    case PHB_M32_BASE_ADDR:
> > +    case PHB_M32_BASE_MASK:
> > +    case PHB_M32_START_ADDR:
> > +    case PHB_CONFIG_ADDRESS:
> > +    case PHB_IODA_ADDR:
> > +    case PHB_RTC_INVALIDATE:
> > +    case PHB_TCE_KILL:
> > +    case PHB_TCE_SPEC_CTL:
> > +    case PHB_PEST_BAR:
> > +    case PHB_PELTV_BAR:
> > +    case PHB_RTT_BAR:
> > +    case PHB_RBA_BAR:
> > +    case PHB_IVT_BAR:
> > +    case PHB_M64_UPPER_BITS:
> > +        break;
> > +
> > +    /* Noise on anything else */
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "reg_read 0x%"PRIx64"=3D%"PRIx64, off=
, val);
> > +    }
> > +    return val;
> > +}
> > +
> > +static const MemoryRegionOps pnv_phb3_reg_ops =3D {
> > +    .read =3D pnv_phb3_reg_read,
> > +    .write =3D pnv_phb3_reg_write,
> > +    .valid.min_access_size =3D 1,
> > +    .valid.max_access_size =3D 8,
> > +    .impl.min_access_size =3D 1,
> > +    .impl.max_access_size =3D 8,
> > +    .endianness =3D DEVICE_BIG_ENDIAN,
> > +};
> > +
> > +static int pnv_phb3_map_irq(PCIDevice *pci_dev, int irq_num)
> > +{
> > +    /* Check that out properly ... */
> > +    return irq_num & 3;
> > +}
> > +
> > +static void pnv_phb3_set_irq(void *opaque, int irq_num, int level)
> > +{
> > +    PnvPHB3 *phb =3D opaque;
> > +
> > +    /* LSI only ... */
> > +    if (irq_num > 3) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "Unknown IRQ to set %d", irq_nu=
m);
> > +    }
> > +    qemu_set_irq(phb->lsis.qirqs[irq_num], level);
> > +}
> > +
> > +static bool pnv_phb3_resolve_pe(PnvPhb3DMASpace *ds)
> > +{
> > +    uint64_t rtt, addr;
> > +    uint16_t rte;
> > +    int bus_num;
> > +
> > +    /* Already resolved ? */
> > +    if (ds->pe_num !=3D PHB_INVALID_PE) {
> > +        return true;
> > +    }
> > +
> > +    /* We need to lookup the RTT */
> > +    rtt =3D ds->phb->regs[PHB_RTT_BAR >> 3];
> > +    if (!(rtt & PHB_RBA_BAR_ENABLE)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "DMA with RTT BAR disabled !");
> > +        /* Set error bits ? fence ? ... */
> > +        return false;
> > +    }
> > +
> > +    /* Read RTE */
> > +    bus_num =3D pci_bus_num(ds->bus);
> > +    addr =3D rtt & PHB_RTT_BASE_ADDRESS_MASK;
> > +    addr +=3D 2 * ((bus_num << 8) | ds->devfn);
> > +    if (dma_memory_read(&address_space_memory, addr, &rte, sizeof(rte)=
)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "Failed to read RTT entry at 0x=
%"PRIx64,
> > +                      addr);
> > +        /* Set error bits ? fence ? ... */
> > +        return false;
> > +    }
> > +    rte =3D be16_to_cpu(rte);
> > +
> > +    /* Fail upon reading of invalid PE# */
> > +    if (rte >=3D PNV_PHB3_NUM_PE) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "RTE for RID 0x%x invalid (%04x=
)",
> > +                      ds->devfn, rte);
> > +        /* Set error bits ? fence ? ... */
> > +        return false;
> > +    }
> > +    ds->pe_num =3D rte;
> > +    return true;
> > +}
> > +
> > +static void pnv_phb3_translate_tve(PnvPhb3DMASpace *ds, hwaddr addr,
> > +                                   bool is_write, uint64_t tve,
> > +                                   IOMMUTLBEntry *tlb)
> > +{
> > +    uint64_t tta =3D GETFIELD(IODA2_TVT_TABLE_ADDR, tve);
> > +    int32_t  lev =3D GETFIELD(IODA2_TVT_NUM_LEVELS, tve);
> > +    uint32_t tts =3D GETFIELD(IODA2_TVT_TCE_TABLE_SIZE, tve);
> > +    uint32_t tps =3D GETFIELD(IODA2_TVT_IO_PSIZE, tve);
> > +
> > +    /* Invalid levels */
> > +    if (lev > 4) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid #levels in TVE %d", le=
v);
> > +        return;
> > +    }
> > +
> > +    /* IO Page Size of 0 means untranslated, else use TCEs */
> > +    if (tps =3D=3D 0) {
> > +        /* We only support non-translate in top window
> > +         * XXX FIX THAT, Venice/Murano support it on bottom window
> > +         * above 4G and Naples suports it on everything
> > +         */
> > +        if (!(tve & PPC_BIT(51))) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "xlate for invalid non-translate TVE");
> > +            return;
> > +        }
> > +        /* XXX Handle boundaries */
> > +
> > +        /* XXX Use 4k pages like q35 ... for now */
> > +        tlb->iova =3D addr & 0xfffffffffffff000ull;
> > +        tlb->translated_addr =3D addr & 0x0003fffffffff000ull;
> > +        tlb->addr_mask =3D 0xfffull;
> > +        tlb->perm =3D IOMMU_RW;
> > +    } else {
> > +        uint32_t tce_shift, tbl_shift, sh;
> > +        uint64_t base, taddr, tce, tce_mask;
> > +
> > +        /* TVE disabled ? */
> > +        if (tts =3D=3D 0) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "xlate for invalid translat=
ed TVE");
> > +            return;
> > +        }
> > +
> > +        /* Address bits per bottom level TCE entry */
> > +        tce_shift =3D tps + 11;
> > +
> > +        /* Address bits per table level */
> > +        tbl_shift =3D tts + 8;
> > +
> > +        /* Top level table base address */
> > +        base =3D tta << 12;
> > +
> > +        /* Total shift to first level */
> > +        sh =3D tbl_shift * lev + tce_shift;
> > +
> > +        /* XXX Multi-level untested */
> > +        while ((lev--) >=3D 0) {
> > +            /* Grab the TCE address */
> > +            taddr =3D base | (((addr >> sh) & ((1ul << tbl_shift) - 1)=
) << 3);
> > +            if (dma_memory_read(&address_space_memory, taddr, &tce,
> > +                                sizeof(tce))) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "Failed to read TCE at 0x%"PRIx64, taddr=
);
> > +                return;
> > +            }
> > +            tce =3D be64_to_cpu(tce);
> > +
> > +            /* Check permission for indirect TCE */
> > +            if ((lev >=3D 0) && !(tce & 3)) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "Invalid indirect TCE at 0x%"PRIx64, tad=
dr);
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              " xlate %"PRIx64":%c TVE=3D%"PRIx64,
> > +                              addr, is_write ? 'W' : 'R', tve);
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              " tta=3D%"PRIx64" lev=3D%d tts=3D%d tps=
=3D%d",
> > +                              tta, lev, tts, tps);
> > +                return;
> > +            }
> > +            sh -=3D tbl_shift;
> > +            base =3D tce & ~0xfffull;
> > +        }
> > +
> > +        /* We exit the loop with TCE being the final TCE */
> > +        tce_mask =3D ~((1ull << tce_shift) - 1);
> > +        tlb->iova =3D addr & tce_mask;
> > +        tlb->translated_addr =3D tce & tce_mask;
> > +        tlb->addr_mask =3D ~tce_mask;
> > +        tlb->perm =3D tce & 3;
> > +        if ((is_write & !(tce & 2)) || ((!is_write) && !(tce & 1))) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "TCE access fault at 0x%"PR=
Ix64,
> > +                          taddr);
> > +            qemu_log_mask(LOG_GUEST_ERROR, " xlate %"PRIx64":%c TVE=3D=
%"PRIx64,
> > +                          addr, is_write ? 'W' : 'R', tve);
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          " tta=3D%"PRIx64" lev=3D%d tts=3D%d tps=3D%d=
",
> > +                          tta, lev, tts, tps);
> > +        }
> > +    }
> > +}
> > +
> > +static IOMMUTLBEntry pnv_phb3_translate_iommu(IOMMUMemoryRegion *iommu,
> > +                                              hwaddr addr,
> > +                                              IOMMUAccessFlags flag,
> > +                                              int iommu_idx)
> > +{
> > +    PnvPhb3DMASpace *ds =3D container_of(iommu, PnvPhb3DMASpace, dma_m=
r);
> > +    int tve_sel;
> > +    uint64_t tve, cfg;
> > +    IOMMUTLBEntry ret =3D {
> > +        .target_as =3D &address_space_memory,
> > +        .iova =3D addr,
> > +        .translated_addr =3D 0,
> > +        .addr_mask =3D ~(hwaddr)0,
> > +        .perm =3D IOMMU_NONE,
> > +    };
> > +
> > +    /* Resolve PE# */
> > +    if (!pnv_phb3_resolve_pe(ds)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Failed to resolve PE# for bus @%p (%d) devfn 0x=
%x",
> > +                      ds->bus, pci_bus_num(ds->bus), ds->devfn);
> > +        return ret;
> > +    }
> > +
> > +    /* Check top bits */
> > +    switch (addr >> 60) {
> > +    case 00:
> > +        /* DMA or 32-bit MSI ? */
> > +        cfg =3D ds->phb->regs[PHB_PHB3_CONFIG >> 3];
> > +        if ((cfg & PHB_PHB3C_32BIT_MSI_EN) &&
> > +            ((addr & 0xffffffffffff0000ull) =3D=3D 0xffff0000ull)) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "xlate on 32-bit MSI region=
");
> > +            return ret;
> > +        }
> > +        /* Choose TVE XXX Use PHB3 Control Register */
> > +        tve_sel =3D (addr >> 59) & 1;
> > +        tve =3D ds->phb->ioda_TVT[ds->pe_num * 2 + tve_sel];
> > +        pnv_phb3_translate_tve(ds, addr, flag & IOMMU_WO, tve, &ret);
> > +        break;
> > +    case 01:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "xlate on 64-bit MSI region");
> > +        break;
> > +    default:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "xlate on unsupported address 0=
x%"PRIx64,
> > +                      addr);
> > +    }
> > +    return ret;
> > +}
> > +
> > +#define TYPE_PNV_PHB3_IOMMU_MEMORY_REGION "pnv-phb3-iommu-memory-regio=
n"
> > +#define PNV_PHB3_IOMMU_MEMORY_REGION(obj) \
> > +    OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_PNV_PHB3_IOMMU_MEMORY_=
REGION)
> > +
> > +static void pnv_phb3_iommu_memory_region_class_init(ObjectClass *klass,
> > +                                                    void *data)
> > +{
> > +    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
> > +
> > +    imrc->translate =3D pnv_phb3_translate_iommu;
> > +}
> > +
> > +static const TypeInfo pnv_phb3_iommu_memory_region_info =3D {
> > +    .parent =3D TYPE_IOMMU_MEMORY_REGION,
> > +    .name =3D TYPE_PNV_PHB3_IOMMU_MEMORY_REGION,
> > +    .class_init =3D pnv_phb3_iommu_memory_region_class_init,
> > +};
> > +
> > +/*
> > + * MSI/MSIX memory region implementation.
> > + * The handler handles both MSI and MSIX.
> > + */
> > +static void pnv_phb3_msi_write(void *opaque, hwaddr addr,
> > +                               uint64_t data, unsigned size)
> > +{
> > +    PnvPhb3DMASpace *ds =3D opaque;
> > +
> > +    /* Resolve PE# */
> > +    if (!pnv_phb3_resolve_pe(ds)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Failed to resolve PE# for bus @%p (%d) devfn 0x=
%x",
> > +                      ds->bus, pci_bus_num(ds->bus), ds->devfn);
> > +        return;
> > +    }
> > +
> > +    pnv_phb3_msi_send(&ds->phb->msis, addr, data, ds->pe_num);
> > +}
> > +
> > +static const MemoryRegionOps pnv_phb3_msi_ops =3D {
> > +    /* There is no .read as the read result is undefined by PCI spec */
> > +    .read =3D NULL,
> > +    .write =3D pnv_phb3_msi_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN
> > +};
> > +
> > +static AddressSpace *pnv_phb3_dma_iommu(PCIBus *bus, void *opaque, int=
 devfn)
> > +{
> > +    PnvPHB3 *phb =3D opaque;
> > +    PnvPhb3DMASpace *ds;
> > +
> > +    QLIST_FOREACH(ds, &phb->dma_spaces, list) {
> > +        if (ds->bus =3D=3D bus && ds->devfn =3D=3D devfn) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (ds =3D=3D NULL) {
> > +        ds =3D g_malloc0(sizeof(PnvPhb3DMASpace));
> > +        ds->bus =3D bus;
> > +        ds->devfn =3D devfn;
> > +        ds->pe_num =3D PHB_INVALID_PE;
> > +        ds->phb =3D phb;
> > +        memory_region_init_iommu(&ds->dma_mr, sizeof(ds->dma_mr),
> > +                                 TYPE_PNV_PHB3_IOMMU_MEMORY_REGION,
> > +                                 OBJECT(phb), "phb3_iommu", UINT64_MAX=
);
> > +        address_space_init(&ds->dma_as, MEMORY_REGION(&ds->dma_mr),
> > +                           "phb3_iommu");
> > +        memory_region_init_io(&ds->msi32_mr, OBJECT(phb), &pnv_phb3_ms=
i_ops,
> > +                              ds, "msi32", 0x10000);
> > +        memory_region_init_io(&ds->msi64_mr, OBJECT(phb), &pnv_phb3_ms=
i_ops,
> > +                              ds, "msi64", 0x100000);
> > +        pnv_phb3_update_msi_regions(ds);
> > +
> > +        QLIST_INSERT_HEAD(&phb->dma_spaces, ds, list);
> > +    }
> > +    return &ds->dma_as;
> > +}
> > +
> > +static void pnv_phb3_instance_init(Object *obj)
> > +{
> > +    PnvPHB3 *phb =3D PNV_PHB3(obj);
> > +
> > +    /* Create LSI source */
> > +    object_initialize(&phb->lsis, sizeof(phb->lsis), TYPE_ICS_SIMPLE);
> > +    object_property_add_child(obj, "ics-phb-lsi", OBJECT(&phb->lsis), =
NULL);
> > +
> > +    /* Default init ... will be fixed by HW inits */
> > +    phb->lsis.offset =3D 0;
> > +
> > +    /* Create MSI source */
> > +    object_initialize(&phb->msis, sizeof(phb->msis), TYPE_PHB3_MSI);
> > +    object_property_add_const_link(OBJECT(&phb->msis), "phb", obj,
> > +                                   &error_abort);
> > +    object_property_add_child(obj, "ics-phb-msi", OBJECT(&phb->msis), =
NULL);
> > +
> > +    /* Create PBCQ */
> > +    object_initialize(&phb->pbcq, sizeof(phb->pbcq), TYPE_PNV_PBCQ);
> > +    object_property_add_const_link(OBJECT(&phb->pbcq), "phb", obj,
> > +                                   &error_abort);
> > +    object_property_add_child(obj, "pbcq", OBJECT(&phb->pbcq), NULL);
> > +
> > +    QLIST_INIT(&phb->dma_spaces);
> > +}
> > +
> > +/*
> > + * This could be done under pnv_pbcq_realize
> > + */
> > +static void pnv_phb3_pci_create(PnvPHB3 *phb, Error **errp)
> > +{
> > +    PCIHostState *pcih =3D PCI_HOST_BRIDGE(phb);
> > +    PCIDevice *brdev;
> > +    PCIDevice *pdev;
> > +    PCIBus *parent;
> > +    uint8_t chassis =3D phb->chip_id * 4 + phb->phb_id;
> > +    uint8_t chassis_nr =3D 128;
> > +
> > +    /* Add root complex */
> > +    pdev =3D pci_create(pcih->bus, 0, TYPE_PNV_PHB3_RC);
> > +    object_property_add_child(OBJECT(phb), "phb3-rc", OBJECT(pdev), NU=
LL);
> > +    qdev_prop_set_uint8(DEVICE(pdev), "chassis", chassis);
> > +    qdev_prop_set_uint16(DEVICE(pdev), "slot", 1);
> > +    qdev_init_nofail(DEVICE(pdev));
> > +
> > +    /* Setup bus for that chip */
> > +    parent =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
> > +
> > +    brdev =3D pci_create(parent, 0, "pci-bridge");
> > +    object_property_add_child(OBJECT(parent), "pci-bridge", OBJECT(brd=
ev),
> > +                              NULL);
> > +    qdev_prop_set_uint8(DEVICE(brdev), PCI_BRIDGE_DEV_PROP_CHASSIS_NR,
> > +                        chassis_nr);
> > +    qdev_init_nofail(DEVICE(brdev));
> > +}
> > +
> > +static void pnv_phb3_realize(DeviceState *dev, Error **errp)
> > +{
> > +    PnvPHB3 *phb =3D PNV_PHB3(dev);
> > +    PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);
> > +    Object *xics =3D OBJECT(qdev_get_machine());
> > +    Error *local_err =3D NULL;
> > +    int i;
> > +
> > +    memory_region_init(&phb->pci_mmio, OBJECT(phb), "pci-mmio",
> > +                       PCI_MMIO_TOTAL_SIZE);
> > +
> > +    /* PHB3 doesn't support IO space. However, qemu gets very upset if
> > +     * we don't have an IO region to anchor IO BARs onto so we just
> > +     * initialize one which we never hook up to anything
> > +     */
> > +    memory_region_init(&phb->pci_io, OBJECT(phb), "pci-io", 0x10000);
> > +
> > +    memory_region_init_io(&phb->mr_regs, OBJECT(phb), &pnv_phb3_reg_op=
s, phb,
> > +                          "phb3-regs", 0x1000);
> > +
> > +    object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "nr-=
irqs",
> > +                            &error_abort);
> > +    object_property_add_const_link(OBJECT(&phb->lsis), "xics", xics,
> > +                                   &error_abort);
> > +    object_property_set_bool(OBJECT(&phb->lsis), true, "realized", &lo=
cal_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    for (i =3D 0; i < PNV_PHB3_NUM_LSI; i++) {
> > +        ics_set_irq_type(&phb->lsis, i, true);
> > +    }
> > +
> > +    object_property_add_const_link(OBJECT(&phb->msis), "xics", xics,
> > +                                   &error_abort);
> > +    object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-irqs=
",
> > +                            &error_abort);
> > +    object_property_set_bool(OBJECT(&phb->msis), true, "realized", &lo=
cal_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    object_property_set_bool(OBJECT(&phb->pbcq), true, "realized", &lo=
cal_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    pci->bus =3D pci_register_root_bus(dev, "phb3-root-bus",
> > +                                pnv_phb3_set_irq, pnv_phb3_map_irq, ph=
b,
> > +                                &phb->pci_mmio, &phb->pci_io,
> > +                                0, 4, TYPE_PNV_PHB3_ROOT_BUS);
> > +    pci_setup_iommu(pci->bus, pnv_phb3_dma_iommu, phb);
> > +
> > +    /* Setup the PCI busses */
> > +    pnv_phb3_pci_create(phb, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +}
> > +
> > +void pnv_phb3_update_regions(PnvPHB3 *phb)
> > +{
> > +    PnvPBCQState *pbcq =3D &phb->pbcq;
> > +
> > +    /* Unmap first always */
> > +    if (phb->regs_mapped) {
> > +        memory_region_del_subregion(&pbcq->phbbar, &phb->mr_regs);
> > +        phb->regs_mapped =3D false;
> > +    }
> > +
> > +    /* Map registers if enabled */
> > +    if (pbcq->phb_mapped) {
> > +        /* XXX We should use the PHB BAR 2 register but we don't ... */
> > +        memory_region_add_subregion(&pbcq->phbbar, 0, &phb->mr_regs);
> > +        phb->regs_mapped =3D true;
> > +    }
> > +
> > +    /* Check/update m32 */
> > +    if (phb->m32_mapped) {
> > +        pnv_phb3_check_m32(phb);
> > +    }
> > +}
> > +
> > +static const char *pnv_phb3_root_bus_path(PCIHostState *host_bridge,
> > +                                          PCIBus *rootbus)
> > +{
> > +    PnvPHB3 *phb =3D PNV_PHB3(host_bridge);
> > +
> > +    snprintf(phb->bus_path, sizeof(phb->bus_path), "00%02x:%02x",
> > +             phb->chip_id, phb->phb_id);
> > +    return phb->bus_path;
> > +}
> > +
> > +static void pnv_phb3_get_phb_id(Object *obj, Visitor *v, const char *n=
ame,
> > +                              void *opaque, Error **errp)
> > +{
> > +    Property *prop =3D opaque;
> > +    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> > +
> > +    visit_type_uint32(v, name, ptr, errp);
> > +}
> > +
> > +static void pnv_phb3_set_phb_id(Object *obj, Visitor *v, const char *n=
ame,
> > +                              void *opaque, Error **errp)
> > +{
> > +    PnvPHB3 *phb =3D PNV_PHB3(obj);
> > +    uint32_t phb_id;
> > +    Error *local_err =3D NULL;
> > +
> > +    visit_type_uint32(v, name, &phb_id, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Limit to a maximum of 6 PHBs per chip
> > +     */
> > +    if (phb_id >=3D PNV8_CHIP_PHB3_MAX) {
> > +        error_setg(errp, "invalid PHB index: '%d'", phb_id);
> > +        return;
> > +    }
> > +
> > +    phb->phb_id =3D phb_id;
> > +}
> > +
> > +static const PropertyInfo pnv_phb3_phb_id_propinfo =3D {
> > +    .name =3D "irq",
> > +    .get =3D pnv_phb3_get_phb_id,
> > +    .set =3D pnv_phb3_set_phb_id,
> > +};
> > +
> > +static void pnv_phb3_get_chip_id(Object *obj, Visitor *v, const char *=
name,
> > +                              void *opaque, Error **errp)
> > +{
> > +    Property *prop =3D opaque;
> > +    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> > +
> > +    visit_type_uint32(v, name, ptr, errp);
> > +}
> > +
> > +static void pnv_phb3_set_chip_id(Object *obj, Visitor *v, const char *=
name,
> > +                                 void *opaque, Error **errp)
> > +{
> > +    PnvPHB3 *phb =3D PNV_PHB3(obj);
> > +    uint32_t chip_id;
> > +    Error *local_err =3D NULL;
> > +    PnvChip *chip;
> > +
> > +    visit_type_uint32(v, name, &chip_id, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Check that the chip owning the device is valid.
> > +     */
> > +    chip =3D pnv_get_chip(PNV_MACHINE(qdev_get_machine()), chip_id);
> > +    if (!chip) {
> > +        error_setg(errp, "chip id '%d' is invalid", chip_id);
> > +        return;
> > +    }
> > +
> > +    phb->chip_id =3D chip_id;
> > +}
> > +
> > +static const PropertyInfo pnv_phb3_chip_id_propinfo =3D {
> > +    .name =3D "irq",
> > +    .get =3D pnv_phb3_get_chip_id,
> > +    .set =3D pnv_phb3_set_chip_id,
> > +};
> > +
> > +static Property pnv_phb3_properties[] =3D {
> > +    DEFINE_PROP("phb-id", PnvPHB3, phb_id, pnv_phb3_phb_id_propinfo,
> > +                uint32_t),
> > +    DEFINE_PROP("chip-id", PnvPHB3, chip_id, pnv_phb3_chip_id_propinfo,
> > +                uint32_t),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void pnv_phb3_class_init(ObjectClass *klass, void *data)
> > +{
> > +    PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    hc->root_bus_path =3D pnv_phb3_root_bus_path;
> > +    dc->realize =3D pnv_phb3_realize;
> > +    dc->props =3D pnv_phb3_properties;
> > +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> > +}
> > +
> > +static const TypeInfo pnv_phb3_type_info =3D {
> > +    .name          =3D TYPE_PNV_PHB3,
> > +    .parent        =3D TYPE_PCI_HOST_BRIDGE,
> > +    .instance_size =3D sizeof(PnvPHB3),
> > +    .class_init    =3D pnv_phb3_class_init,
> > +    .instance_init =3D pnv_phb3_instance_init,
> > +};
> > +
> > +static void pnv_phb3_root_bus_class_init(ObjectClass *klass, void *dat=
a)
> > +{
> > +    BusClass *k =3D BUS_CLASS(klass);
> > +
> > +    k->max_dev =3D 1;
> > +}
> > +
> > +static const TypeInfo pnv_phb3_root_bus_info =3D {
> > +    .name =3D TYPE_PNV_PHB3_ROOT_BUS,
> > +    .parent =3D TYPE_PCIE_BUS,
> > +    .class_init =3D pnv_phb3_root_bus_class_init,
> > +};
> > +
> > +static void pnv_phb3_rc_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> > +    PCIERootPortClass *rpc =3D PCIE_ROOT_PORT_CLASS(klass);
> > +
> > +    dc->desc     =3D "IBM PHB3 PCIE Root Port";
> > +
> > +    k->vendor_id =3D PCI_VENDOR_ID_IBM;
> > +    k->device_id =3D 0x03dc;
> > +    k->revision  =3D 0;
> > +    rpc->exp_offset =3D 0x48;
> > +    rpc->aer_offset =3D 0x100;
> > +}
> > +
> > +static const TypeInfo pnv_phb3_rc_info =3D {
> > +    .name          =3D TYPE_PNV_PHB3_RC,
> > +    .parent        =3D TYPE_PCIE_ROOT_PORT,
> > +    .class_init    =3D pnv_phb3_rc_class_init,
> > +};
> > +
> > +static void pnv_phb3_register_types(void)
> > +{
> > +    type_register_static(&pnv_phb3_rc_info);
> > +    type_register_static(&pnv_phb3_type_info);
> > +    type_register_static(&pnv_phb3_root_bus_info);
> > +    type_register_static(&pnv_phb3_iommu_memory_region_info);
> > +}
> > +
> > +type_init(pnv_phb3_register_types)
> > diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
> > new file mode 100644
> > index 000000000000..36927da25b61
> > --- /dev/null
> > +++ b/hw/pci-host/pnv_phb3_msi.c
> > @@ -0,0 +1,316 @@
> > +/*
> > + * QEMU PowerPC PowerNV PHB3 model
> > + *
> > + * Copyright (c) 2014-2018, IBM Corporation.
> > + *
> > + * This code is licensed under the GPL version 2 or later. See the
> > + * COPYING file in the top-level directory.
> > + */
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "qapi/error.h"
> > +#include "qemu-common.h"
> > +#include "target/ppc/cpu.h"
> > +#include "hw/pci-host/pnv_phb3_regs.h"
> > +#include "hw/pci-host/pnv_phb3.h"
> > +#include "hw/ppc/pnv.h"
> > +#include "hw/pci/msi.h"
> > +
> > +static uint64_t phb3_msi_ive_addr(PnvPHB3 *phb, int srcno)
> > +{
> > +    uint64_t ivtbar =3D phb->regs[PHB_IVT_BAR >> 3];
> > +    uint64_t phbctl =3D phb->regs[PHB_CONTROL >> 3];
> > +
> > +    if (!(ivtbar & PHB_IVT_BAR_ENABLE)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "Failed access to disable IVT B=
AR !");
> > +        return 0;
> > +    }
> > +
> > +    if (srcno >=3D (ivtbar & PHB_IVT_LENGTH_MASK)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "MSI out of bounds (%d vs  0x%"=
PRIx64")",
> > +                      srcno, ivtbar & PHB_IVT_LENGTH_MASK);
> > +        return 0;
> > +    }
> > +
> > +    ivtbar &=3D PHB_IVT_BASE_ADDRESS_MASK;
> > +
> > +    if (phbctl & PHB_CTRL_IVE_128_BYTES) {
> > +        return ivtbar + 128 * srcno;
> > +    } else {
> > +        return ivtbar + 16 * srcno;
> > +    }
> > +}
> > +
> > +static bool phb3_msi_read_ive(PnvPHB3 *phb, int srcno, uint64_t *out_i=
ve)
> > +{
> > +    uint64_t ive_addr, ive;
> > +
> > +    ive_addr =3D phb3_msi_ive_addr(phb, srcno);
> > +    if (!ive_addr) {
> > +        return false;
> > +    }
> > +
> > +    if (dma_memory_read(&address_space_memory, ive_addr, &ive, sizeof(=
ive))) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "Failed to read IVE at 0x%" PRI=
x64,
> > +                      ive_addr);
> > +        return false;
> > +    }
> > +    *out_ive =3D be64_to_cpu(ive);
> > +
> > +    return true;
> > +}
> > +
> > +static void phb3_msi_set_p(Phb3MsiState *msi, int srcno, uint8_t gen)
> > +{
> > +    uint64_t ive_addr;
> > +    uint8_t p =3D 0x01 | (gen << 1);
> > +
> > +    ive_addr =3D phb3_msi_ive_addr(msi->phb, srcno);
> > +    if (!ive_addr) {
> > +        return;
> > +    }
> > +
> > +    if (dma_memory_write(&address_space_memory, ive_addr + 4, &p, 1)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Failed to write IVE (set P) at 0x%" PRIx64, ive=
_addr);
> > +    }
> > +}
> > +
> > +static void phb3_msi_set_q(Phb3MsiState *msi, int srcno)
> > +{
> > +    uint64_t ive_addr;
> > +    uint8_t q =3D 0x01;
> > +
> > +    ive_addr =3D phb3_msi_ive_addr(msi->phb, srcno);
> > +    if (!ive_addr) {
> > +        return;
> > +    }
> > +
> > +    if (dma_memory_write(&address_space_memory, ive_addr + 5, &q, 1)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Failed to write IVE (set Q) at 0x%" PRIx64, ive=
_addr);
> > +    }
> > +}
> > +
> > +static void phb3_msi_try_send(Phb3MsiState *msi, int srcno, bool ignor=
e_p)
> > +{
> > +    ICSState *ics =3D ICS_BASE(msi);
> > +    uint64_t ive;
> > +    uint64_t server, prio, pq, gen;
> > +
> > +    if (!phb3_msi_read_ive(msi->phb, srcno, &ive)) {
> > +        return;
> > +    }
> > +
> > +    server =3D GETFIELD(IODA2_IVT_SERVER, ive);
> > +    prio =3D GETFIELD(IODA2_IVT_PRIORITY, ive);
> > +    pq =3D GETFIELD(IODA2_IVT_Q, ive);
> > +    if (!ignore_p) {
> > +        pq |=3D GETFIELD(IODA2_IVT_P, ive) << 1;
> > +    }
> > +    gen =3D GETFIELD(IODA2_IVT_GEN, ive);
> > +
> > +    /*
> > +     * The low order 2 bits are the link pointer (Type II interrupts).
> > +     * Shift back to get a valid IRQ server.
> > +     */
> > +    server >>=3D 2;
> > +
> > +    switch (pq) {
> > +    case 0: /* 00 */
> > +        if (prio =3D=3D 0xff) {
> > +            /* Masked, set Q */
> > +            phb3_msi_set_q(msi, srcno);
> > +        } else {
> > +            /* Enabled, set P and send */
> > +            phb3_msi_set_p(msi, srcno, gen);
> > +            icp_irq(ics, server, srcno + ics->offset, prio);
> > +        }
> > +        break;
> > +    case 2: /* 10 */
> > +        /* Already pending, set Q */
> > +        phb3_msi_set_q(msi, srcno);
> > +        break;
> > +    case 1: /* 01 */
> > +    case 3: /* 11 */
> > +    default:
> > +        /* Just drop stuff if Q already set */
> > +        break;
> > +    }
> > +}
> > +
> > +static void phb3_msi_set_irq(void *opaque, int srcno, int val)
> > +{
> > +    Phb3MsiState *msi =3D PHB3_MSI(opaque);
> > +
> > +    if (val) {
> > +        phb3_msi_try_send(msi, srcno, false);
> > +    }
> > +}
> > +
> > +
> > +void pnv_phb3_msi_send(Phb3MsiState *msi, uint64_t addr, uint16_t data,
> > +                       int32_t dev_pe)
> > +{
> > +    ICSState *ics =3D ICS_BASE(msi);
> > +    uint64_t ive;
> > +    uint16_t pe;
> > +    uint32_t src =3D ((addr >> 4) & 0xffff) | (data & 0x1f);
> > +
> > +    if (src >=3D ics->nr_irqs) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "MSI %d out of bounds", src);
> > +        return;
> > +    }
> > +    if (dev_pe >=3D 0) {
> > +        if (!phb3_msi_read_ive(msi->phb, src, &ive)) {
> > +            return;
> > +        }
> > +        pe =3D GETFIELD(IODA2_IVT_PE, ive);
> > +        if (pe !=3D dev_pe) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "MSI %d send by PE#%d but assigned to PE#%d",
> > +                          src, dev_pe, pe);
> > +            return;
> > +        }
> > +    }
> > +    qemu_irq_pulse(ics->qirqs[src]);
> > +}
> > +
> > +void pnv_phb3_msi_ffi(Phb3MsiState *msi, uint64_t val)
> > +{
> > +    /* Emit interrupt */
> > +    pnv_phb3_msi_send(msi, val, 0, -1);
> > +
> > +    /* Clear FFI lock */
> > +    msi->phb->regs[PHB_FFI_LOCK >> 3] =3D 0;
> > +}
> > +
> > +static void phb3_msi_reject(ICSState *ics, uint32_t nr)
> > +{
> > +    Phb3MsiState *msi =3D PHB3_MSI(ics);
> > +    unsigned int srcno =3D nr - ics->offset;
> > +    unsigned int idx =3D srcno >> 6;
> > +    unsigned int bit =3D 1ull << (srcno & 0x3f);
> > +
> > +    assert(srcno < PHB3_MAX_MSI);
> > +
> > +    msi->rba[idx] |=3D bit;
> > +    msi->rba_sum |=3D (1u << idx);
> > +}
> > +
> > +static void phb3_msi_resend(ICSState *ics)
> > +{
> > +    Phb3MsiState *msi =3D PHB3_MSI(ics);
> > +    unsigned int i, j;
> > +
> > +    if (msi->rba_sum =3D=3D 0) {
> > +        return;
> > +    }
> > +
> > +    for (i =3D 0; i < 32; i++) {
> > +        if ((msi->rba_sum & (1u << i)) =3D=3D 0) {
> > +            continue;
> > +        }
> > +        msi->rba_sum &=3D ~(1u << i);
> > +        for (j =3D 0; j < 64; j++) {
> > +            if ((msi->rba[i] & (1ull << j)) =3D=3D 0) {
> > +                continue;
> > +            }
> > +            msi->rba[i] &=3D ~(1u << j);
> > +            phb3_msi_try_send(msi, i * 64 + j, true);
> > +        }
> > +    }
> > +}
> > +
> > +static void phb3_msi_reset(DeviceState *dev)
> > +{
> > +    Phb3MsiState *msi =3D PHB3_MSI(dev);
> > +    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
> > +
> > +    icsc->parent_reset(dev);
> > +
> > +    memset(msi->rba, 0, sizeof(msi->rba));
> > +    msi->rba_sum =3D 0;
> > +}
> > +
> > +static void phb3_msi_reset_handler(void *dev)
> > +{
> > +    phb3_msi_reset(dev);
> > +}
> > +
> > +void pnv_phb3_msi_update_config(Phb3MsiState *msi, uint32_t base,
> > +                                uint32_t count)
> > +{
> > +    ICSState *ics =3D ICS_BASE(msi);
> > +
> > +    if (count > PHB3_MAX_MSI) {
> > +        count =3D PHB3_MAX_MSI;
> > +    }
> > +    ics->nr_irqs =3D count;
> > +    ics->offset =3D base;
> > +}
> > +
> > +static void phb3_msi_realize(DeviceState *dev, Error **errp)
> > +{
> > +    Phb3MsiState *msi =3D PHB3_MSI(dev);
> > +    ICSState *ics =3D ICS_BASE(msi);
> > +    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
> > +    Object *obj;
> > +    Error *local_err =3D NULL;
> > +
> > +    icsc->parent_realize(dev, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    obj =3D object_property_get_link(OBJECT(dev), "phb", &local_err);
> > +    if (!obj) {
> > +        error_propagate(errp, local_err);
> > +        error_prepend(errp, "required link 'phb' not found: ");
> > +        return;
> > +    }
> > +    msi->phb =3D PNV_PHB3(obj);
> > +
> > +    ics->qirqs =3D qemu_allocate_irqs(phb3_msi_set_irq, msi, PHB3_MAX_=
MSI);
> > +
> > +    qemu_register_reset(phb3_msi_reset_handler, dev);
> > +}
> > +
> > +static void phb3_msi_instance_init(Object *obj)
> > +{
> > +    ICSState *ics =3D ICS_BASE(obj);
> > +
> > +    /* Will be overriden later */
> > +    ics->offset =3D 0;
> > +}
> > +
> > +static void phb3_msi_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
> > +
> > +    device_class_set_parent_realize(dc, phb3_msi_realize,
> > +                                    &isc->parent_realize);
> > +    device_class_set_parent_reset(dc, phb3_msi_reset,
> > +                                  &isc->parent_reset);
> > +
> > +    isc->reject =3D phb3_msi_reject;
> > +    isc->resend =3D phb3_msi_resend;
> > +}
> > +
> > +static const TypeInfo phb3_msi_info =3D {
> > +    .name =3D TYPE_PHB3_MSI,
> > +    .parent =3D TYPE_ICS_BASE,
> > +    .instance_size =3D sizeof(Phb3MsiState),
> > +    .class_init =3D phb3_msi_class_init,
> > +    .class_size =3D sizeof(ICSStateClass),
> > +    .instance_init =3D phb3_msi_instance_init,
> > +};
> > +
> > +static void pnv_phb3_msi_register_types(void)
> > +{
> > +    type_register_static(&phb3_msi_info);
> > +}
> > +
> > +type_init(pnv_phb3_msi_register_types)
> > diff --git a/hw/pci-host/pnv_phb3_pbcq.c b/hw/pci-host/pnv_phb3_pbcq.c
> > new file mode 100644
> > index 000000000000..34df3ac684e4
> > --- /dev/null
> > +++ b/hw/pci-host/pnv_phb3_pbcq.c
> > @@ -0,0 +1,347 @@
> > +/*
> > + * QEMU PowerPC PowerNV PHB3 model
> > + *
> > + * Copyright (c) 2014-2018, IBM Corporation.
> > + *
> > + * This code is licensed under the GPL version 2 or later. See the
> > + * COPYING file in the top-level directory.
> > + */
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu-common.h"
> > +#include "qemu/log.h"
> > +#include "target/ppc/cpu.h"
> > +#include "hw/ppc/fdt.h"
> > +#include "hw/pci-host/pnv_phb3_regs.h"
> > +#include "hw/pci-host/pnv_phb3.h"
> > +#include "hw/ppc/pnv_xscom.h"
> > +#include "hw/pci/pci_bridge.h"
> > +#include "hw/pci/pci_bus.h"
> > +
> > +#include <libfdt.h>
> > +
> > +static uint64_t pnv_pbcq_nest_xscom_read(void *opaque, hwaddr addr,
> > +                                         unsigned size)
> > +{
> > +    PnvPBCQState *pbcq =3D PNV_PBCQ(opaque);
> > +    uint32_t offset =3D addr >> 3;
> > +
> > +    return pbcq->nest_regs[offset];
> > +}
> > +
> > +static uint64_t pnv_pbcq_pci_xscom_read(void *opaque, hwaddr addr,
> > +                                        unsigned size)
> > +{
> > +    PnvPBCQState *pbcq =3D PNV_PBCQ(opaque);
> > +    uint32_t offset =3D addr >> 3;
> > +
> > +    return pbcq->pci_regs[offset];
> > +}
> > +
> > +static uint64_t pnv_pbcq_spci_xscom_read(void *opaque, hwaddr addr,
> > +                                         unsigned size)
> > +{
> > +    PnvPBCQState *pbcq =3D PNV_PBCQ(opaque);
> > +    uint32_t offset =3D addr >> 3;
> > +
> > +    if (offset =3D=3D PBCQ_SPCI_ASB_DATA) {
> > +        return pnv_phb3_reg_read(pbcq->phb,
> > +                                 pbcq->spci_regs[PBCQ_SPCI_ASB_ADDR], =
8);
> > +    }
> > +    return pbcq->spci_regs[offset];
> > +}
> > +
> > +static void pnv_pbcq_update_map(PnvPBCQState *pbcq)
> > +{
> > +    uint64_t bar_en =3D pbcq->nest_regs[PBCQ_NEST_BAR_EN];
> > +    uint64_t bar, mask, size;
> > +
> > +    /*
> > +     * NOTE: This will really not work well if those are remapped
> > +     * after the PHB has created its sub regions. We could do better
> > +     * if we had a way to resize regions but we don't really care
> > +     * that much in practice as the stuff below really only happens
> > +     * once early during boot
> > +     */
> > +
> > +    /* Handle unmaps */
> > +    if (pbcq->mmio0_mapped && !(bar_en & PBCQ_NEST_BAR_EN_MMIO0)) {
> > +        memory_region_del_subregion(get_system_memory(), &pbcq->mmbar0=
);
> > +        pbcq->mmio0_mapped =3D false;
> > +    }
> > +    if (pbcq->mmio1_mapped && !(bar_en & PBCQ_NEST_BAR_EN_MMIO1)) {
> > +        memory_region_del_subregion(get_system_memory(), &pbcq->mmbar1=
);
> > +        pbcq->mmio1_mapped =3D false;
> > +    }
> > +    if (pbcq->phb_mapped && !(bar_en & PBCQ_NEST_BAR_EN_PHB)) {
> > +        memory_region_del_subregion(get_system_memory(), &pbcq->phbbar=
);
> > +        pbcq->phb_mapped =3D false;
> > +    }
> > +
> > +    /* Update PHB */
> > +    pnv_phb3_update_regions(pbcq->phb);
> > +
> > +    /* Handle maps */
> > +    if (!pbcq->mmio0_mapped && (bar_en & PBCQ_NEST_BAR_EN_MMIO0)) {
> > +        bar =3D pbcq->nest_regs[PBCQ_NEST_MMIO_BAR0] >> 14;
> > +        mask =3D pbcq->nest_regs[PBCQ_NEST_MMIO_MASK0];
> > +        size =3D ((~mask) >> 14) + 1;
> > +        memory_region_init(&pbcq->mmbar0, OBJECT(pbcq), "pbcq-mmio0", =
size);
> > +        memory_region_add_subregion(get_system_memory(), bar, &pbcq->m=
mbar0);
> > +        pbcq->mmio0_mapped =3D true;
> > +        pbcq->mmio0_base =3D bar;
> > +        pbcq->mmio0_size =3D size;
> > +    }
> > +    if (!pbcq->mmio1_mapped && (bar_en & PBCQ_NEST_BAR_EN_MMIO1)) {
> > +        bar =3D pbcq->nest_regs[PBCQ_NEST_MMIO_BAR1] >> 14;
> > +        mask =3D pbcq->nest_regs[PBCQ_NEST_MMIO_MASK1];
> > +        size =3D ((~mask) >> 14) + 1;
> > +        memory_region_init(&pbcq->mmbar1, OBJECT(pbcq), "pbcq-mmio1", =
size);
> > +        memory_region_add_subregion(get_system_memory(), bar, &pbcq->m=
mbar1);
> > +        pbcq->mmio1_mapped =3D true;
> > +        pbcq->mmio1_base =3D bar;
> > +        pbcq->mmio1_size =3D size;
> > +    }
> > +    if (!pbcq->phb_mapped && (bar_en & PBCQ_NEST_BAR_EN_PHB)) {
> > +        bar =3D pbcq->nest_regs[PBCQ_NEST_PHB_BAR] >> 14;
> > +        size =3D 0x1000;
> > +        memory_region_init(&pbcq->phbbar, OBJECT(pbcq), "pbcq-phb", si=
ze);
> > +        memory_region_add_subregion(get_system_memory(), bar, &pbcq->p=
hbbar);
> > +        pbcq->phb_mapped =3D true;
> > +    }
> > +
> > +    /* Update PHB */
> > +    pnv_phb3_update_regions(pbcq->phb);
> > +}
> > +
> > +static void pnv_pbcq_nest_xscom_write(void *opaque, hwaddr addr,
> > +                                uint64_t val, unsigned size)
> > +{
> > +    PnvPBCQState *pbcq =3D PNV_PBCQ(opaque);
> > +    uint32_t reg =3D addr >> 3;
> > +
> > +    switch (reg) {
> > +    case PBCQ_NEST_MMIO_BAR0:
> > +    case PBCQ_NEST_MMIO_BAR1:
> > +    case PBCQ_NEST_MMIO_MASK0:
> > +    case PBCQ_NEST_MMIO_MASK1:
> > +        if (pbcq->nest_regs[PBCQ_NEST_BAR_EN] &
> > +            (PBCQ_NEST_BAR_EN_MMIO0 |
> > +             PBCQ_NEST_BAR_EN_MMIO1)) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                           "PHB3: Changing enabled BAR unsupported\n");
> > +        }
> > +        pbcq->nest_regs[reg] =3D val & 0xffffffffc0000000ull;
> > +        break;
> > +    case PBCQ_NEST_PHB_BAR:
> > +        if (pbcq->nest_regs[PBCQ_NEST_BAR_EN] & PBCQ_NEST_BAR_EN_PHB) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                           "PHB3: Changing enabled BAR unsupported\n");
> > +        }
> > +        pbcq->nest_regs[reg] =3D val & 0xfffffffffc000000ull;
> > +        break;
> > +    case PBCQ_NEST_BAR_EN:
> > +        pbcq->nest_regs[reg] =3D val & 0xf800000000000000ull;
> > +        pnv_pbcq_update_map(pbcq);
> > +        pnv_phb3_remap_irqs(pbcq->phb);
> > +        break;
> > +    case PBCQ_NEST_IRSN_COMPARE:
> > +    case PBCQ_NEST_IRSN_MASK:
> > +        pbcq->nest_regs[reg] =3D val & PBCQ_NEST_IRSN_COMP;
> > +        pnv_phb3_remap_irqs(pbcq->phb);
> > +        break;
> > +    case PBCQ_NEST_LSI_SRC_ID:
> > +        pbcq->nest_regs[reg] =3D val & PBCQ_NEST_LSI_SRC;
> > +        pnv_phb3_remap_irqs(pbcq->phb);
> > +        break;
> > +    }
> > +
> > +    /* XXX Don't error out on other regs for now ... */
> > +}
> > +
> > +static void pnv_pbcq_pci_xscom_write(void *opaque, hwaddr addr,
> > +                                     uint64_t val, unsigned size)
> > +{
> > +    PnvPBCQState *pbcq =3D PNV_PBCQ(opaque);
> > +    uint32_t reg =3D addr >> 3;
> > +
> > +    switch (reg) {
> > +    case PBCQ_PCI_BAR2:
> > +        pbcq->pci_regs[reg] =3D val & 0xfffffffffc000000ull;
> > +        pnv_pbcq_update_map(pbcq);
> > +        break;
> > +    }
> > +
> > +    /* XXX Don't error out on other regs for now ... */
> > +}
> > +
> > +static void pnv_pbcq_spci_xscom_write(void *opaque, hwaddr addr,
> > +                                uint64_t val, unsigned size)
> > +{
> > +    PnvPBCQState *pbcq =3D PNV_PBCQ(opaque);
> > +    uint32_t reg =3D addr >> 3;
> > +
> > +    switch (reg) {
> > +    case PBCQ_SPCI_ASB_ADDR:
> > +        pbcq->spci_regs[reg] =3D val & 0xfff;
> > +        break;
> > +    case PBCQ_SPCI_ASB_STATUS:
> > +        pbcq->spci_regs[reg] &=3D ~val;
> > +        break;
> > +    case PBCQ_SPCI_ASB_DATA:
> > +        pnv_phb3_reg_write(pbcq->phb, pbcq->spci_regs[PBCQ_SPCI_ASB_AD=
DR],
> > +                           val, 8);
> > +        break;
> > +    case PBCQ_SPCI_AIB_CAPP_EN:
> > +    case PBCQ_SPCI_CAPP_SEC_TMR:
> > +        break;
> > +    }
> > +
> > +    /* XXX Don't error out on other regs for now ... */
> > +}
> > +
> > +static const MemoryRegionOps pnv_pbcq_nest_xscom_ops =3D {
> > +    .read =3D pnv_pbcq_nest_xscom_read,
> > +    .write =3D pnv_pbcq_nest_xscom_write,
> > +    .valid.min_access_size =3D 8,
> > +    .valid.max_access_size =3D 8,
> > +    .impl.min_access_size =3D 8,
> > +    .impl.max_access_size =3D 8,
> > +    .endianness =3D DEVICE_BIG_ENDIAN,
> > +};
> > +
> > +static const MemoryRegionOps pnv_pbcq_pci_xscom_ops =3D {
> > +    .read =3D pnv_pbcq_pci_xscom_read,
> > +    .write =3D pnv_pbcq_pci_xscom_write,
> > +    .valid.min_access_size =3D 8,
> > +    .valid.max_access_size =3D 8,
> > +    .impl.min_access_size =3D 8,
> > +    .impl.max_access_size =3D 8,
> > +    .endianness =3D DEVICE_BIG_ENDIAN,
> > +};
> > +
> > +static const MemoryRegionOps pnv_pbcq_spci_xscom_ops =3D {
> > +    .read =3D pnv_pbcq_spci_xscom_read,
> > +    .write =3D pnv_pbcq_spci_xscom_write,
> > +    .valid.min_access_size =3D 8,
> > +    .valid.max_access_size =3D 8,
> > +    .impl.min_access_size =3D 8,
> > +    .impl.max_access_size =3D 8,
> > +    .endianness =3D DEVICE_BIG_ENDIAN,
> > +};
> > +
> > +static void pnv_pbcq_default_bars(PnvPBCQState *pbcq)
> > +{
> > +    uint64_t mm0, mm1, reg;
> > +    PnvPHB3 *phb =3D pbcq->phb;
> > +
> > +    mm0 =3D 0x3d00000000000ull + 0x4000000000ull * phb->chip_id +
> > +            0x1000000000ull * phb->phb_id;
> > +    mm1 =3D 0x3ff8000000000ull + 0x0200000000ull * phb->chip_id +
> > +            0x0080000000ull * phb->phb_id;
> > +    reg =3D 0x3fffe40000000ull + 0x0000400000ull * phb->chip_id +
> > +            0x0000100000ull * phb->phb_id;
> > +
> > +    pbcq->nest_regs[PBCQ_NEST_MMIO_BAR0] =3D mm0 << 14;
> > +    pbcq->nest_regs[PBCQ_NEST_MMIO_BAR1] =3D mm1 << 14;
> > +    pbcq->nest_regs[PBCQ_NEST_PHB_BAR] =3D reg << 14;
> > +    pbcq->nest_regs[PBCQ_NEST_MMIO_MASK0] =3D 0x3fff000000000ull << 14;
> > +    pbcq->nest_regs[PBCQ_NEST_MMIO_MASK1] =3D 0x3ffff80000000ull << 14;
> > +    pbcq->pci_regs[PBCQ_PCI_BAR2] =3D reg << 14;
> > +}
> > +
> > +static void pnv_pbcq_realize(DeviceState *dev, Error **errp)
> > +{
> > +    PnvPBCQState *pbcq =3D PNV_PBCQ(dev);
> > +    PnvPHB3 *phb;
> > +    Object *obj;
> > +    Error *local_err =3D NULL;
> > +    char name[32];
> > +
> > +    obj =3D object_property_get_link(OBJECT(dev), "phb", &local_err);
> > +    if (!obj) {
> > +        error_propagate(errp, local_err);
> > +        error_prepend(errp, "required link 'phb' not found: ");
> > +        return;
> > +    }
> > +    phb =3D pbcq->phb =3D PNV_PHB3(obj);
> > +
> > +    /* XXX Fix OPAL to do that: establish default BAR values */
> > +    pnv_pbcq_default_bars(pbcq);
> > +
> > +    /* Initialize the XSCOM region for the PBCQ registers */
> > +    snprintf(name, sizeof(name), "xscom-pbcq-nest-%d.%d",
> > +             phb->chip_id, phb->phb_id);
> > +    pnv_xscom_region_init(&pbcq->xscom_nest_regs, OBJECT(dev),
> > +                          &pnv_pbcq_nest_xscom_ops, pbcq, name,
> > +                          PNV_XSCOM_PBCQ_NEST_SIZE);
> > +    snprintf(name, sizeof(name), "xscom-pbcq-pci-%d.%d",
> > +             phb->chip_id, phb->phb_id);
> > +    pnv_xscom_region_init(&pbcq->xscom_pci_regs, OBJECT(dev),
> > +                          &pnv_pbcq_pci_xscom_ops, pbcq, name,
> > +                          PNV_XSCOM_PBCQ_PCI_SIZE);
> > +    snprintf(name, sizeof(name), "xscom-pbcq-spci-%d.%d",
> > +             phb->chip_id, phb->phb_id);
> > +    pnv_xscom_region_init(&pbcq->xscom_spci_regs, OBJECT(dev),
> > +                          &pnv_pbcq_spci_xscom_ops, pbcq, name,
> > +                          PNV_XSCOM_PBCQ_SPCI_SIZE);
> > +}
> > +
> > +static int pnv_pbcq_dt_xscom(PnvXScomInterface *dev, void *fdt,
> > +                             int xscom_offset)
> > +{
> > +    const char compat[] =3D "ibm,power8-pbcq";
> > +    PnvPHB3 *phb =3D PNV_PBCQ(dev)->phb;
> > +    char *name;
> > +    int offset;
> > +    uint32_t lpc_pcba =3D PNV_XSCOM_PBCQ_NEST_BASE + 0x400 * phb->phb_=
id;
> > +    uint32_t reg[] =3D {
> > +        cpu_to_be32(lpc_pcba),
> > +        cpu_to_be32(PNV_XSCOM_PBCQ_NEST_SIZE),
> > +        cpu_to_be32(PNV_XSCOM_PBCQ_PCI_BASE + 0x400 * phb->phb_id),
> > +        cpu_to_be32(PNV_XSCOM_PBCQ_PCI_SIZE),
> > +        cpu_to_be32(PNV_XSCOM_PBCQ_SPCI_BASE + 0x040 * phb->phb_id),
> > +        cpu_to_be32(PNV_XSCOM_PBCQ_SPCI_SIZE)
> > +    };
> > +
> > +    name =3D g_strdup_printf("pbcq@%x", lpc_pcba);
> > +    offset =3D fdt_add_subnode(fdt, xscom_offset, name);
> > +    _FDT(offset);
> > +    g_free(name);
> > +
> > +    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
> > +
> > +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,phb-index", phb->phb_id))=
);
> > +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id", phb->chip_id)));
> > +    _FDT((fdt_setprop(fdt, offset, "compatible", compat,
> > +                      sizeof(compat))));
> > +    return 0;
> > +}
> > +
> > +static void pnv_pbcq_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
> > +
> > +    xdc->dt_xscom =3D pnv_pbcq_dt_xscom;
> > +
> > +    dc->realize =3D pnv_pbcq_realize;
> > +}
> > +
> > +static const TypeInfo pnv_pbcq_type_info =3D {
> > +    .name          =3D TYPE_PNV_PBCQ,
> > +    .parent        =3D TYPE_DEVICE,
> > +    .instance_size =3D sizeof(PnvPBCQState),
> > +    .class_init    =3D pnv_pbcq_class_init,
> > +    .interfaces    =3D (InterfaceInfo[]) {
> > +        { TYPE_PNV_XSCOM_INTERFACE },
> > +        { }
> > +    }
> > +};
> > +
> > +static void pnv_pbcq_register_types(void)
> > +{
> > +    type_register_static(&pnv_pbcq_type_info);
> > +}
> > +
> > +type_init(pnv_pbcq_register_types)
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 7401ffe5b01c..77e92d5e2e66 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -44,6 +44,7 @@
> >  #include "hw/isa/isa.h"
> >  #include "hw/char/serial.h"
> >  #include "hw/timer/mc146818rtc.h"
> > +#include "hw/pci/msi.h"
> > =20
> >  #include <libfdt.h>
> > =20
> > @@ -555,6 +556,9 @@ static void pnv_init(MachineState *machine)
> >      int i;
> >      char *chip_typename;
> > =20
> > +    /* MSIs are supported on this platform */
> > +    msi_nonbroken =3D true;
> > +
> >      /* allocate RAM */
> >      if (machine->ram_size < (1 * G_BYTE)) {
> >          warn_report("skiboot may not work with < 1GB of RAM");
> > @@ -725,6 +729,8 @@ static Object *pnv_chip_power9_intc_create(PnvChip =
*chip, Object *child,
> >  static void pnv_chip_power8_instance_init(Object *obj)
> >  {
> >      Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
> > +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(obj);
> > +    int i;
> > =20
> >      object_initialize(&chip8->psi, sizeof(chip8->psi), TYPE_PNV_PSI);
> >      object_property_add_child(obj, "psi", OBJECT(&chip8->psi), NULL);
> > @@ -740,6 +746,12 @@ static void pnv_chip_power8_instance_init(Object *=
obj)
> >      object_property_add_child(obj, "occ", OBJECT(&chip8->occ), NULL);
> >      object_property_add_const_link(OBJECT(&chip8->occ), "psi",
> >                                     OBJECT(&chip8->psi), &error_abort);
> > +
> > +    for (i =3D 0; i < pcc->num_phbs; i++) {
> > +        object_initialize(&chip8->phbs[i], sizeof(chip8->phbs[i]),
> > +                          TYPE_PNV_PHB3);
> > +        object_property_add_child(obj, "phb[*]", OBJECT(&chip8->phbs[i=
]), NULL);
> > +    }
> >  }
> > =20
> >  static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
> > @@ -780,6 +792,7 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
> >      PnvChip *chip =3D PNV_CHIP(dev);
> >      Pnv8Chip *chip8 =3D PNV8_CHIP(dev);
> >      Error *local_err =3D NULL;
> > +    int i;
> > =20
> >      pcc->parent_realize(dev, &local_err);
> >      if (local_err) {
> > @@ -817,6 +830,33 @@ static void pnv_chip_power8_realize(DeviceState *d=
ev, Error **errp)
> >          return;
> >      }
> >      pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xsco=
m_regs);
> > +
> > +    /* Create the PHB3 controllers */
> > +    for (i =3D 0; i < pcc->num_phbs; i++) {
> > +        PnvPHB3 *phb =3D &chip8->phbs[i];
> > +        PnvPBCQState *pbcq =3D &phb->pbcq;
> > +
> > +        object_property_set_int(OBJECT(phb), i, "phb-id", &error_fatal=
);
> > +        object_property_set_int(OBJECT(phb), chip->chip_id, "chip-id",
> > +                                &error_fatal);
> > +        object_property_set_bool(OBJECT(phb), true, "realized", &local=
_err);
> > +        if (local_err) {
> > +            error_propagate(errp, local_err);
> > +            return;
> > +        }
> > +        qdev_set_parent_bus(DEVICE(phb), sysbus_get_default());
> > +
> > +        /* Populate the XSCOM address space. */
> > +        pnv_xscom_add_subregion(chip,
> > +                                PNV_XSCOM_PBCQ_NEST_BASE + 0x400 * phb=
->phb_id,
> > +                                &pbcq->xscom_nest_regs);
> > +        pnv_xscom_add_subregion(chip,
> > +                                PNV_XSCOM_PBCQ_PCI_BASE + 0x400 * phb-=
>phb_id,
> > +                                &pbcq->xscom_pci_regs);
> > +        pnv_xscom_add_subregion(chip,
> > +                                PNV_XSCOM_PBCQ_SPCI_BASE + 0x040 * phb=
->phb_id,
> > +                                &pbcq->xscom_spci_regs);
> > +    }
> >  }
> > =20
> >  static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
> > @@ -827,6 +867,7 @@ static void pnv_chip_power8e_class_init(ObjectClass=
 *klass, void *data)
> >      k->chip_type =3D PNV_CHIP_POWER8E;
> >      k->chip_cfam_id =3D 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
> >      k->cores_mask =3D POWER8E_CORE_MASK;
> > +    k->num_phbs =3D 2;
> >      k->core_pir =3D pnv_chip_core_pir_p8;
> >      k->intc_create =3D pnv_chip_power8_intc_create;
> >      k->isa_create =3D pnv_chip_power8_isa_create;
> > @@ -845,6 +886,7 @@ static void pnv_chip_power8_class_init(ObjectClass =
*klass, void *data)
> >      k->chip_type =3D PNV_CHIP_POWER8;
> >      k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
> >      k->cores_mask =3D POWER8_CORE_MASK;
> > +    k->num_phbs =3D 3;
> >      k->core_pir =3D pnv_chip_core_pir_p8;
> >      k->intc_create =3D pnv_chip_power8_intc_create;
> >      k->isa_create =3D pnv_chip_power8_isa_create;
> > @@ -863,6 +905,7 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
> >      k->chip_type =3D PNV_CHIP_POWER8NVL;
> >      k->chip_cfam_id =3D 0x120d304980000000ull;  /* P8 Naples DD1.0 */
> >      k->cores_mask =3D POWER8_CORE_MASK;
> > +    k->num_phbs =3D 4;
> >      k->core_pir =3D pnv_chip_core_pir_p8;
> >      k->intc_create =3D pnv_chip_power8_intc_create;
> >      k->isa_create =3D pnv_chip_power8nvl_isa_create;
> > @@ -897,6 +940,7 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
> >      k->chip_type =3D PNV_CHIP_POWER9;
> >      k->chip_cfam_id =3D 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
> >      k->cores_mask =3D POWER9_CORE_MASK;
> > +    k->num_phbs =3D 0;
> >      k->core_pir =3D pnv_chip_core_pir_p9;
> >      k->intc_create =3D pnv_chip_power9_intc_create;
> >      k->isa_create =3D pnv_chip_power9_isa_create;
> > @@ -1047,14 +1091,24 @@ static void pnv_chip_class_init(ObjectClass *kl=
ass, void *data)
> >  static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
> >  {
> >      PnvMachineState *pnv =3D PNV_MACHINE(xi);
> > -    int i;
> > +    int i, j;
> > =20
> >      for (i =3D 0; i < pnv->num_chips; i++) {
> > +        PnvChip *chip =3D pnv->chips[i];
> >          Pnv8Chip *chip8 =3D PNV8_CHIP(pnv->chips[i]);
> > +        PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> > =20
> >          if (ics_valid_irq(&chip8->psi.ics, irq)) {
> >              return &chip8->psi.ics;
> >          }
> > +        for (j =3D 0; j < pcc->num_phbs; j++) {
> > +            if (ics_valid_irq(&chip8->phbs[j].lsis, irq)) {
> > +                return &chip8->phbs[j].lsis;
> > +            }
> > +            if (ics_valid_irq(ICS_BASE(&chip8->phbs[j].msis), irq)) {
> > +                return ICS_BASE(&chip8->phbs[j].msis);
> > +            }
> > +        }
> >      }
> >      return NULL;
> >  }
> > @@ -1062,11 +1116,18 @@ static ICSState *pnv_ics_get(XICSFabric *xi, in=
t irq)
> >  static void pnv_ics_resend(XICSFabric *xi)
> >  {
> >      PnvMachineState *pnv =3D PNV_MACHINE(xi);
> > -    int i;
> > +    int i, j;
> > =20
> >      for (i =3D 0; i < pnv->num_chips; i++) {
> > +        PnvChip *chip =3D pnv->chips[i];
> >          Pnv8Chip *chip8 =3D PNV8_CHIP(pnv->chips[i]);
> > +        PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> > +
> >          ics_resend(&chip8->psi.ics);
> > +        for (j =3D 0; j < pcc->num_phbs; j++) {
> > +            ics_resend(&chip8->phbs[j].lsis);
> > +            ics_resend(ICS_BASE(&chip8->phbs[j].msis));
> > +        }
> >      }
> >  }
> > =20
> > @@ -1097,7 +1158,7 @@ static void pnv_pic_print_info(InterruptStatsProv=
ider *obj,
> >                                 Monitor *mon)
> >  {
> >      PnvMachineState *pnv =3D PNV_MACHINE(obj);
> > -    int i;
> > +    int i, j;
> >      CPUState *cs;
> > =20
> >      CPU_FOREACH(cs) {
> > @@ -1107,8 +1168,16 @@ static void pnv_pic_print_info(InterruptStatsPro=
vider *obj,
> >      }
> > =20
> >      for (i =3D 0; i < pnv->num_chips; i++) {
> > +        PnvChip *chip =3D pnv->chips[i];
> >          Pnv8Chip *chip8 =3D PNV8_CHIP(pnv->chips[i]);
> > +        PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> > +
> >          ics_pic_print_info(&chip8->psi.ics, mon);
> > +
> > +        for (j =3D 0; j < pcc->num_phbs; j++) {
> > +            ics_pic_print_info(&chip8->phbs[j].lsis, mon);
> > +            ics_pic_print_info(ICS_BASE(&chip8->phbs[j].msis), mon);
> > +        }
> >      }
> >  }
> > =20
> > diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> > index 46fae41f32b0..83f05d06053f 100644
> > --- a/hw/ppc/pnv_xscom.c
> > +++ b/hw/ppc/pnv_xscom.c
> > @@ -252,7 +252,11 @@ int pnv_dt_xscom(PnvChip *chip, void *fdt, int roo=
t_offset)
> >      args.fdt =3D fdt;
> >      args.xscom_offset =3D xscom_offset;
> > =20
> > -    object_child_foreach(OBJECT(chip), xscom_dt_child, &args);
> > +    /* Some PnvXScomInterface objects lie a bit deeper (PnvPBCQState)
> > +     * than the first layer, so we need to loop on the whole object
> > +     * hierarchy to catch them
> > +     */
> > +    object_child_foreach_recursive(OBJECT(chip), xscom_dt_child, &args=
);
> >      return 0;
> >  }
> > =20
> > diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> > index 6d6597c06563..1b5b782bd986 100644
> > --- a/hw/pci-host/Makefile.objs
> > +++ b/hw/pci-host/Makefile.objs
> > @@ -19,3 +19,4 @@ common-obj-$(CONFIG_PCI_GENERIC) +=3D gpex.o
> >  common-obj-$(CONFIG_PCI_XILINX) +=3D xilinx-pcie.o
> > =20
> >  common-obj-$(CONFIG_PCI_DESIGNWARE) +=3D designware.o
> > +obj-$(CONFIG_POWERNV) +=3D pnv_phb3.o pnv_phb3_pbcq.o pnv_phb3_msi.o
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Pgaa2uWPnPrfixyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltO2oIACgkQbDjKyiDZ
s5KoJg//YmpDKKTC6oqnVSDVM/ntFi+xfMDYsucgeeYfMiaTJe7dDZcw8p/jwzY8
vwVmQ2kNFmRQc1ro2GtnKDhWLx0vaTqaGikpDpLQDGSQj/MstRRLOtoxqv4QmgYS
C1R5aiMoKPO1/65qV42hcWbBI70sYyOd/kd0WFp6fYMFsJTClcFc66Fpw04kQBte
r4Ov3jdZYwugIap/7jhiiymBD/5zmbC/WacmmgxQWDYzQMDVor8ktVBwplmzompa
h/38YsCUK4TJBvdgssAQ5glGdA6DwHxwf6O6SjdHohnS3PruAuUUxw4pA8AxmZJ1
JL/HEnE7ziRvqzncGn7qyDwAsb4rA/udv2NwIQHm7++VD8oaXUPQPTAu09uj0z0o
M0eSbe4fl7cDO3StSw/5RTCoH5wSAayOsYHxWAnYjLwXg2tWMnPW9BelADkdBlXF
OMqR+ebnQqlsuMbyis1r2Y8KhLpTDg6H2lENFhWEb/kp/VZswU/e6ker/6TFa6FL
0vtK1m9MsAvsBo8cwOLeI3F9Q/gCNK7xyidb7lk1AQzFi+LIzN7vlpdDImfM8hrb
tbwIDhLEQU2rg/3Hl1swtPZLWZzhcAKhlul52y9VUJXtlOlLKAIAgf6N/d2hM1zX
QMwGdkM7LKQ3Sy1RO4MLCNYlfNCFecm48XpDiLwb96IkSggmCjI=
=deLl
-----END PGP SIGNATURE-----

--Pgaa2uWPnPrfixyx--
