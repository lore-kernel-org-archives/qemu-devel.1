Received: from eggs.gnu.org ([2001:4830:134:3::10]:59821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dpQvY-00018z-Bv
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 23:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dpQvT-00059c-68
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 23:22:56 -0400
Date: Wed, 6 Sep 2017 13:16:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170906031619.GE2735@umbus.fritz.box>
References: <1504550378-2291-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1504550378-2291-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170905011343.GD2735@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <20170905011343.GD2735@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 1/1] net: Add SunGEM device emulation as
 found on Apple UniNorth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2017 at 11:13:43AM +1000, David Gibson wrote:
> On Mon, Sep 04, 2017 at 07:39:38PM +0100, Mark Cave-Ayland wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >=20
> > This adds a simplistic emulation of the Sun GEM ethernet controller
> > found in Apple ASICs.
> >=20
> > Currently we only support the Apple UniNorth 1.x variant, but the
> > other Apple or Sun variants should mostly be a matter of adding
> > PCI IDs options.
> >=20
> > We have a very primitive emulation of a single Broadcom 5201 PHY
> > which is supported by the MacOS driver.
> >=20
> > This model brings out-of-the-box networking to MacOS 9, and all
> > versions of OS X I tried with the mac99 platform.
> >=20
> > Further improvements from Mark:
> > - Remove sungem.h file, moving constants into sungem.c as required
> > - Switch to using tracepoints for debugging
> > - Split register blocks into separate memory regions
> > - Use arrays in SunGEMState to hold register values
> > - Add state-saving support
> >=20
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> Applied to ppc-for-2.11.

Until I discovered that it breaks compile with
--enable-trace-backend=3Dust.   So I've removed it again.

>=20
> > ---
> >  default-configs/ppc-softmmu.mak |    1 +
> >  hw/net/Makefile.objs            |    1 +
> >  hw/net/sungem.c                 | 1447 +++++++++++++++++++++++++++++++=
++++++++
> >  hw/net/trace-events             |   44 ++
> >  hw/pci/pci.c                    |    2 +
> >  include/hw/pci/pci_ids.h        |    1 +
> >  6 files changed, 1496 insertions(+)
> >  create mode 100644 hw/net/sungem.c
> >=20
> > diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-soft=
mmu.mak
> > index 1f1cd85..c12ba9e 100644
> > --- a/default-configs/ppc-softmmu.mak
> > +++ b/default-configs/ppc-softmmu.mak
> > @@ -17,6 +17,7 @@ CONFIG_PREP_PCI=3Dy
> >  CONFIG_I82378=3Dy
> >  CONFIG_PC87312=3Dy
> >  CONFIG_MACIO=3Dy
> > +CONFIG_SUNGEM=3Dy
> >  CONFIG_PCSPK=3Dy
> >  CONFIG_CS4231A=3Dy
> >  CONFIG_CUDA=3Dy
> > diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> > index 5ddaffe..7e87d01 100644
> > --- a/hw/net/Makefile.objs
> > +++ b/hw/net/Makefile.objs
> > @@ -27,6 +27,7 @@ common-obj-$(CONFIG_CADENCE) +=3D cadence_gem.o
> >  common-obj-$(CONFIG_STELLARIS_ENET) +=3D stellaris_enet.o
> >  common-obj-$(CONFIG_LANCE) +=3D lance.o
> >  common-obj-$(CONFIG_FTGMAC100) +=3D ftgmac100.o
> > +common-obj-$(CONFIG_SUNGEM) +=3D sungem.o
> > =20
> >  obj-$(CONFIG_ETRAXFS) +=3D etraxfs_eth.o
> >  obj-$(CONFIG_COLDFIRE) +=3D mcf_fec.o
> > diff --git a/hw/net/sungem.c b/hw/net/sungem.c
> > new file mode 100644
> > index 0000000..8c2ca4a
> > --- /dev/null
> > +++ b/hw/net/sungem.c
> > @@ -0,0 +1,1447 @@
> > +/*
> > + * QEMU model of SUN GEM ethernet controller
> > + *
> > + * As found in Apple ASICs among others
> > + *
> > + * Copyright 2016 Ben Herrenschmidt
> > + * Copyright 2017 Mark Cave-Ayland
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/pci/pci.h"
> > +#include "qemu/log.h"
> > +#include "net/net.h"
> > +#include "net/checksum.h"
> > +#include "hw/net/mii.h"
> > +#include "sysemu/sysemu.h"
> > +#include "trace.h"
> > +/* For crc32 */
> > +#include <zlib.h>
> > +
> > +#define TYPE_SUNGEM "sungem"
> > +
> > +#define SUNGEM(obj) OBJECT_CHECK(SunGEMState, (obj), TYPE_SUNGEM)
> > +
> > +#define MAX_PACKET_SIZE 9016
> > +
> > +#define SUNGEM_MMIO_SIZE        0x200000
> > +
> > +/* Global registers */
> > +#define SUNGEM_MMIO_GREG_SIZE   0x2000
> > +
> > +#define GREG_SEBSTATE     0x0000UL    /* SEB State Register */
> > +
> > +#define GREG_STAT         0x000CUL    /* Status Register */
> > +#define GREG_STAT_TXINTME     0x00000001    /* TX INTME frame transfer=
red */
> > +#define GREG_STAT_TXALL       0x00000002    /* All TX frames transferr=
ed */
> > +#define GREG_STAT_TXDONE      0x00000004    /* One TX frame transferre=
d */
> > +#define GREG_STAT_RXDONE      0x00000010    /* One RX frame arrived */
> > +#define GREG_STAT_RXNOBUF     0x00000020    /* No free RX buffers avai=
lable */
> > +#define GREG_STAT_RXTAGERR    0x00000040    /* RX tag framing is corru=
pt */
> > +#define GREG_STAT_TXMAC       0x00004000    /* TX MAC signalled interr=
upt */
> > +#define GREG_STAT_RXMAC       0x00008000    /* RX MAC signalled interr=
upt */
> > +#define GREG_STAT_MAC         0x00010000    /* MAC Control signalled i=
rq */
> > +#define GREG_STAT_TXNR        0xfff80000    /* =3D=3D TXDMA_TXDONE reg=
 val */
> > +#define GREG_STAT_TXNR_SHIFT  19
> > +
> > +/* These interrupts are edge latches in the status register,
> > + * reading it (or writing the corresponding bit in IACK) will
> > + * clear them
> > + */
> > +#define GREG_STAT_LATCH       (GREG_STAT_TXALL  | GREG_STAT_TXINTME | \
> > +                               GREG_STAT_RXDONE | GREG_STAT_RXDONE |  \
> > +                               GREG_STAT_RXNOBUF | GREG_STAT_RXTAGERR)
> > +
> > +#define GREG_IMASK        0x0010UL    /* Interrupt Mask Register */
> > +#define GREG_IACK         0x0014UL    /* Interrupt ACK Register */
> > +#define GREG_STAT2        0x001CUL    /* Alias of GREG_STAT */
> > +#define GREG_PCIESTAT     0x1000UL    /* PCI Error Status Register */
> > +#define GREG_PCIEMASK     0x1004UL    /* PCI Error Mask Register */
> > +
> > +#define GREG_SWRST        0x1010UL    /* Software Reset Register */
> > +#define GREG_SWRST_TXRST      0x00000001    /* TX Software Reset */
> > +#define GREG_SWRST_RXRST      0x00000002    /* RX Software Reset */
> > +#define GREG_SWRST_RSTOUT     0x00000004    /* Force RST# pin active */
> > +
> > +/* TX DMA Registers */
> > +#define SUNGEM_MMIO_TXDMA_SIZE   0x1000
> > +
> > +#define TXDMA_KICK        0x0000UL    /* TX Kick Register */
> > +
> > +#define TXDMA_CFG         0x0004UL    /* TX Configuration Register */
> > +#define TXDMA_CFG_ENABLE      0x00000001    /* Enable TX DMA channel */
> > +#define TXDMA_CFG_RINGSZ      0x0000001e    /* TX descriptor ring size=
 */
> > +
> > +#define TXDMA_DBLOW       0x0008UL    /* TX Desc. Base Low */
> > +#define TXDMA_DBHI        0x000CUL    /* TX Desc. Base High */
> > +#define TXDMA_PCNT        0x0024UL    /* TX FIFO Packet Counter */
> > +#define TXDMA_SMACHINE    0x0028UL    /* TX State Machine Register */
> > +#define TXDMA_DPLOW       0x0030UL    /* TX Data Pointer Low */
> > +#define TXDMA_DPHI        0x0034UL    /* TX Data Pointer High */
> > +#define TXDMA_TXDONE      0x0100UL    /* TX Completion Register */
> > +#define TXDMA_FTAG        0x0108UL    /* TX FIFO Tag */
> > +#define TXDMA_FSZ         0x0118UL    /* TX FIFO Size */
> > +
> > +/* Receive DMA Registers */
> > +#define SUNGEM_MMIO_RXDMA_SIZE   0x2000
> > +
> > +#define RXDMA_CFG         0x0000UL    /* RX Configuration Register */
> > +#define RXDMA_CFG_ENABLE      0x00000001    /* Enable RX DMA channel */
> > +#define RXDMA_CFG_RINGSZ      0x0000001e    /* RX descriptor ring size=
 */
> > +#define RXDMA_CFG_FBOFF       0x00001c00    /* Offset of first data by=
te */
> > +#define RXDMA_CFG_CSUMOFF     0x000fe000    /* Skip bytes before csum =
calc */
> > +
> > +#define RXDMA_DBLOW       0x0004UL    /* RX Descriptor Base Low */
> > +#define RXDMA_DBHI        0x0008UL    /* RX Descriptor Base High */
> > +#define RXDMA_PCNT        0x0018UL    /* RX FIFO Packet Counter */
> > +#define RXDMA_SMACHINE    0x001CUL    /* RX State Machine Register */
> > +#define RXDMA_PTHRESH     0x0020UL    /* Pause Thresholds */
> > +#define RXDMA_DPLOW       0x0024UL    /* RX Data Pointer Low */
> > +#define RXDMA_DPHI        0x0028UL    /* RX Data Pointer High */
> > +#define RXDMA_KICK        0x0100UL    /* RX Kick Register */
> > +#define RXDMA_DONE        0x0104UL    /* RX Completion Register */
> > +#define RXDMA_BLANK       0x0108UL    /* RX Blanking Register */
> > +#define RXDMA_FTAG        0x0110UL    /* RX FIFO Tag */
> > +#define RXDMA_FSZ         0x0120UL    /* RX FIFO Size */
> > +
> > +/* MAC Registers */
> > +#define SUNGEM_MMIO_MAC_SIZE   0x200
> > +
> > +#define MAC_TXRST         0x0000UL    /* TX MAC Software Reset Command=
 */
> > +#define MAC_RXRST         0x0004UL    /* RX MAC Software Reset Command=
 */
> > +#define MAC_TXSTAT        0x0010UL    /* TX MAC Status Register */
> > +#define MAC_RXSTAT        0x0014UL    /* RX MAC Status Register */
> > +
> > +#define MAC_CSTAT         0x0018UL    /* MAC Control Status Register */
> > +#define MAC_CSTAT_PTR         0xffff0000    /* Pause Time Received */
> > +
> > +#define MAC_TXMASK        0x0020UL    /* TX MAC Mask Register */
> > +#define MAC_RXMASK        0x0024UL    /* RX MAC Mask Register */
> > +#define MAC_MCMASK        0x0028UL    /* MAC Control Mask Register */
> > +
> > +#define MAC_TXCFG         0x0030UL    /* TX MAC Configuration Register=
 */
> > +#define MAC_TXCFG_ENAB        0x00000001    /* TX MAC Enable */
> > +
> > +#define MAC_RXCFG         0x0034UL    /* RX MAC Configuration Register=
 */
> > +#define MAC_RXCFG_ENAB        0x00000001    /* RX MAC Enable */
> > +#define MAC_RXCFG_SFCS        0x00000004    /* Strip FCS */
> > +#define MAC_RXCFG_PROM        0x00000008    /* Promiscuous Mode */
> > +#define MAC_RXCFG_PGRP        0x00000010    /* Promiscuous Group */
> > +#define MAC_RXCFG_HFE         0x00000020    /* Hash Filter Enable */
> > +
> > +#define MAC_XIFCFG        0x003CUL    /* XIF Configuration Register */
> > +#define MAC_XIFCFG_LBCK       0x00000002    /* Loopback TX to RX */
> > +
> > +#define MAC_MINFSZ        0x0050UL    /* MinFrameSize Register */
> > +#define MAC_MAXFSZ        0x0054UL    /* MaxFrameSize Register */
> > +#define MAC_ADDR0         0x0080UL    /* MAC Address 0 Register */
> > +#define MAC_ADDR1         0x0084UL    /* MAC Address 1 Register */
> > +#define MAC_ADDR2         0x0088UL    /* MAC Address 2 Register */
> > +#define MAC_ADDR3         0x008CUL    /* MAC Address 3 Register */
> > +#define MAC_ADDR4         0x0090UL    /* MAC Address 4 Register */
> > +#define MAC_ADDR5         0x0094UL    /* MAC Address 5 Register */
> > +#define MAC_HASH0         0x00C0UL    /* Hash Table 0 Register */
> > +#define MAC_PATMPS        0x0114UL    /* Peak Attempts Register */
> > +#define MAC_SMACHINE      0x0134UL    /* State Machine Register */
> > +
> > +/* MIF Registers */
> > +#define SUNGEM_MMIO_MIF_SIZE   0x20
> > +
> > +#define MIF_FRAME         0x000CUL    /* MIF Frame/Output Register */
> > +#define MIF_FRAME_OP          0x30000000    /* OPcode */
> > +#define MIF_FRAME_PHYAD       0x0f800000    /* PHY ADdress */
> > +#define MIF_FRAME_REGAD       0x007c0000    /* REGister ADdress */
> > +#define MIF_FRAME_TALSB       0x00010000    /* Turn Around LSB */
> > +#define MIF_FRAME_DATA        0x0000ffff    /* Instruction Payload */
> > +
> > +#define MIF_CFG           0x0010UL    /* MIF Configuration Register */
> > +#define MIF_CFG_MDI0          0x00000100    /* MDIO_0 present or read-=
bit */
> > +#define MIF_CFG_MDI1          0x00000200    /* MDIO_1 present or read-=
bit */
> > +
> > +#define MIF_STATUS        0x0018UL    /* MIF Status Register */
> > +#define MIF_SMACHINE      0x001CUL    /* MIF State Machine Register */
> > +
> > +/* PCS/Serialink Registers */
> > +#define SUNGEM_MMIO_PCS_SIZE   0x60
> > +#define PCS_MIISTAT       0x0004UL    /* PCS MII Status Register */
> > +#define PCS_ISTAT         0x0018UL    /* PCS Interrupt Status Reg */
> > +#define PCS_SSTATE        0x005CUL    /* Serialink State Register */
> > +
> > +/* Descriptors */
> > +struct gem_txd {
> > +    uint64_t control_word;
> > +    uint64_t buffer;
> > +};
> > +
> > +#define TXDCTRL_BUFSZ     0x0000000000007fffULL  /* Buffer Size */
> > +#define TXDCTRL_CSTART    0x00000000001f8000ULL  /* CSUM Start Offset =
*/
> > +#define TXDCTRL_COFF      0x000000001fe00000ULL  /* CSUM Stuff Offset =
*/
> > +#define TXDCTRL_CENAB     0x0000000020000000ULL  /* CSUM Enable */
> > +#define TXDCTRL_EOF       0x0000000040000000ULL  /* End of Frame */
> > +#define TXDCTRL_SOF       0x0000000080000000ULL  /* Start of Frame */
> > +#define TXDCTRL_INTME     0x0000000100000000ULL  /* "Interrupt Me" */
> > +
> > +struct gem_rxd {
> > +    uint64_t status_word;
> > +    uint64_t buffer;
> > +};
> > +
> > +#define RXDCTRL_HPASS     0x1000000000000000ULL  /* Passed Hash Filter=
 */
> > +#define RXDCTRL_ALTMAC    0x2000000000000000ULL  /* Matched ALT MAC */
> > +
> > +
> > +typedef struct {
> > +    PCIDevice pdev;
> > +
> > +    MemoryRegion sungem;
> > +    MemoryRegion greg;
> > +    MemoryRegion txdma;
> > +    MemoryRegion rxdma;
> > +    MemoryRegion mac;
> > +    MemoryRegion mif;
> > +    MemoryRegion pcs;
> > +    NICState *nic;
> > +    NICConf conf;
> > +    uint32_t phy_addr;
> > +
> > +    uint32_t gregs[SUNGEM_MMIO_GREG_SIZE >> 2];
> > +    uint32_t txdmaregs[SUNGEM_MMIO_TXDMA_SIZE >> 2];
> > +    uint32_t rxdmaregs[SUNGEM_MMIO_RXDMA_SIZE >> 2];
> > +    uint32_t macregs[SUNGEM_MMIO_MAC_SIZE >> 2];
> > +    uint32_t mifregs[SUNGEM_MMIO_MIF_SIZE >> 2];
> > +    uint32_t pcsregs[SUNGEM_MMIO_PCS_SIZE >> 2];
> > +
> > +    /* Cache some useful things */
> > +    uint32_t rx_mask;
> > +    uint32_t tx_mask;
> > +
> > +    /* Current tx packet */
> > +    uint8_t tx_data[MAX_PACKET_SIZE];
> > +    uint32_t tx_size;
> > +    uint64_t tx_first_ctl;
> > +} SunGEMState;
> > +
> > +
> > +static void sungem_eval_irq(SunGEMState *s)
> > +{
> > +    uint32_t stat, mask;
> > +
> > +    mask =3D s->gregs[GREG_IMASK >> 2];
> > +    stat =3D s->gregs[GREG_STAT >> 2] & ~GREG_STAT_TXNR;
> > +    if (stat & ~mask) {
> > +        pci_set_irq(PCI_DEVICE(s), 1);
> > +    } else {
> > +        pci_set_irq(PCI_DEVICE(s), 0);
> > +    }
> > +}
> > +
> > +static void sungem_update_status(SunGEMState *s, uint32_t bits, bool v=
al)
> > +{
> > +    uint32_t stat;
> > +
> > +    stat =3D s->gregs[GREG_STAT >> 2];
> > +    if (val) {
> > +        stat |=3D bits;
> > +    } else {
> > +        stat &=3D ~bits;
> > +    }
> > +    s->gregs[GREG_STAT >> 2] =3D stat;
> > +    sungem_eval_irq(s);
> > +}
> > +
> > +static void sungem_eval_cascade_irq(SunGEMState *s)
> > +{
> > +    uint32_t stat, mask;
> > +
> > +    mask =3D s->macregs[MAC_TXSTAT >> 2];
> > +    stat =3D s->macregs[MAC_TXMASK >> 2];
> > +    if (stat & ~mask) {
> > +        sungem_update_status(s, GREG_STAT_TXMAC, true);
> > +    } else {
> > +        sungem_update_status(s, GREG_STAT_TXMAC, false);
> > +    }
> > +
> > +    mask =3D s->macregs[MAC_RXSTAT >> 2];
> > +    stat =3D s->macregs[MAC_RXMASK >> 2];
> > +    if (stat & ~mask) {
> > +        sungem_update_status(s, GREG_STAT_RXMAC, true);
> > +    } else {
> > +        sungem_update_status(s, GREG_STAT_RXMAC, false);
> > +    }
> > +
> > +    mask =3D s->macregs[MAC_CSTAT >> 2];
> > +    stat =3D s->macregs[MAC_MCMASK >> 2] & ~MAC_CSTAT_PTR;
> > +    if (stat & ~mask) {
> > +        sungem_update_status(s, GREG_STAT_MAC, true);
> > +    } else {
> > +        sungem_update_status(s, GREG_STAT_MAC, false);
> > +    }
> > +}
> > +
> > +static void sungem_do_tx_csum(SunGEMState *s)
> > +{
> > +    uint16_t start, off;
> > +    uint32_t csum;
> > +
> > +    start =3D (s->tx_first_ctl & TXDCTRL_CSTART) >> 15;
> > +    off =3D (s->tx_first_ctl & TXDCTRL_COFF) >> 21;
> > +
> > +    trace_sungem_tx_checksum(start, off);
> > +
> > +    if (start > (s->tx_size - 2) || off > (s->tx_size - 2)) {
> > +        trace_sungem_tx_checksum_oob();
> > +        return;
> > +    }
> > +
> > +    csum =3D net_raw_checksum(s->tx_data + start, s->tx_size - start);
> > +    stw_be_p(s->tx_data + off, csum);
> > +}
> > +
> > +static void sungem_send_packet(SunGEMState *s, const uint8_t *buf,
> > +                               int size)
> > +{
> > +    NetClientState *nc =3D qemu_get_queue(s->nic);
> > +
> > +    if (s->macregs[MAC_XIFCFG >> 2] & MAC_XIFCFG_LBCK) {
> > +        nc->info->receive(nc, buf, size);
> > +    } else {
> > +        qemu_send_packet(nc, buf, size);
> > +    }
> > +}
> > +
> > +static void sungem_process_tx_desc(SunGEMState *s, struct gem_txd *des=
c)
> > +{
> > +    PCIDevice *d =3D PCI_DEVICE(s);
> > +    uint32_t len;
> > +
> > +    /* If it's a start of frame, discard anything we had in the
> > +     * buffer and start again. This should be an error condition
> > +     * if we had something ... for now we ignore it
> > +     */
> > +    if (desc->control_word & TXDCTRL_SOF) {
> > +        if (s->tx_first_ctl) {
> > +            trace_sungem_tx_unfinished();
> > +        }
> > +        s->tx_size =3D 0;
> > +        s->tx_first_ctl =3D desc->control_word;
> > +    }
> > +
> > +    /* Grab data size */
> > +    len =3D desc->control_word & TXDCTRL_BUFSZ;
> > +
> > +    /* Clamp it to our max size */
> > +    if ((s->tx_size + len) > MAX_PACKET_SIZE) {
> > +        trace_sungem_tx_overflow();
> > +        len =3D MAX_PACKET_SIZE - s->tx_size;
> > +    }
> > +
> > +    /* Read the data */
> > +    pci_dma_read(d, desc->buffer, &s->tx_data[s->tx_size], len);
> > +    s->tx_size +=3D len;
> > +
> > +    /* If end of frame, send packet */
> > +    if (desc->control_word & TXDCTRL_EOF) {
> > +        trace_sungem_tx_finished(s->tx_size);
> > +
> > +        /* Handle csum */
> > +        if (s->tx_first_ctl & TXDCTRL_CENAB) {
> > +            sungem_do_tx_csum(s);
> > +        }
> > +
> > +        /* Send it */
> > +        sungem_send_packet(s, s->tx_data, s->tx_size);
> > +
> > +        /* No more pending packet */
> > +        s->tx_size =3D 0;
> > +        s->tx_first_ctl =3D 0;
> > +    }
> > +}
> > +
> > +static void sungem_tx_kick(SunGEMState *s)
> > +{
> > +    PCIDevice *d =3D PCI_DEVICE(s);
> > +    uint32_t comp, kick;
> > +    uint32_t txdma_cfg, txmac_cfg, ints;
> > +    uint64_t dbase;
> > +
> > +    trace_sungem_tx_kick();
> > +
> > +    /* Check that both TX MAC and TX DMA are enabled. We don't
> > +     * handle DMA-less direct FIFO operations (we don't emulate
> > +     * the FIFO at all).
> > +     *
> > +     * A write to TXDMA_KICK while DMA isn't enabled can happen
> > +     * when the driver is resetting the pointer.
> > +     */
> > +    txdma_cfg =3D s->txdmaregs[TXDMA_CFG >> 2];
> > +    txmac_cfg =3D s->macregs[MAC_TXCFG >> 2];
> > +    if (!(txdma_cfg & TXDMA_CFG_ENABLE) ||
> > +        !(txmac_cfg & MAC_TXCFG_ENAB)) {
> > +        trace_sungem_tx_disabled();
> > +        return;
> > +    }
> > +
> > +    /* XXX Test min frame size register ? */
> > +    /* XXX Test max frame size register ? */
> > +
> > +    dbase =3D s->txdmaregs[TXDMA_DBHI >> 2];
> > +    dbase =3D (dbase << 32) | s->txdmaregs[TXDMA_DBLOW >> 2];
> > +
> > +    comp =3D s->txdmaregs[TXDMA_TXDONE >> 2] & s->tx_mask;
> > +    kick =3D s->txdmaregs[TXDMA_KICK >> 2] & s->tx_mask;
> > +
> > +    trace_sungem_tx_process(comp, kick, s->tx_mask + 1);
> > +
> > +    /* This is rather primitive for now, we just send everything we
> > +     * can in one go, like e1000. Ideally we should do the sending
> > +     * from some kind of background task
> > +     */
> > +    while (comp !=3D kick) {
> > +        struct gem_txd desc;
> > +
> > +        /* Read the next descriptor */
> > +        pci_dma_read(d, dbase + comp * sizeof(desc), &desc, sizeof(des=
c));
> > +
> > +        /* Byteswap descriptor */
> > +        desc.control_word =3D le64_to_cpu(desc.control_word);
> > +        desc.buffer =3D le64_to_cpu(desc.buffer);
> > +        trace_sungem_tx_desc(comp, desc.control_word, desc.buffer);
> > +
> > +        /* Send it for processing */
> > +        sungem_process_tx_desc(s, &desc);
> > +
> > +        /* Interrupt */
> > +        ints =3D GREG_STAT_TXDONE;
> > +        if (desc.control_word & TXDCTRL_INTME) {
> > +            ints |=3D GREG_STAT_TXINTME;
> > +        }
> > +        sungem_update_status(s, ints, true);
> > +
> > +        /* Next ! */
> > +        comp =3D (comp + 1) & s->tx_mask;
> > +        s->txdmaregs[TXDMA_TXDONE >> 2] =3D comp;
> > +    }
> > +
> > +    /* We sent everything, set status/irq bit */
> > +    sungem_update_status(s, GREG_STAT_TXALL, true);
> > +}
> > +
> > +static bool sungem_rx_full(SunGEMState *s, uint32_t kick, uint32_t don=
e)
> > +{
> > +    return kick =3D=3D ((done + 1) & s->rx_mask);
> > +}
> > +
> > +static int sungem_can_receive(NetClientState *nc)
> > +{
> > +    SunGEMState *s =3D qemu_get_nic_opaque(nc);
> > +    uint32_t kick, done, rxdma_cfg, rxmac_cfg;
> > +    bool full;
> > +
> > +    rxmac_cfg =3D s->macregs[MAC_RXCFG >> 2];
> > +    rxdma_cfg =3D s->rxdmaregs[RXDMA_CFG >> 2];
> > +
> > +    /* If MAC disabled, can't receive */
> > +    if ((rxmac_cfg & MAC_RXCFG_ENAB) =3D=3D 0) {
> > +        trace_sungem_rx_mac_disabled();
> > +        return 0;
> > +    }
> > +    if ((rxdma_cfg & RXDMA_CFG_ENABLE) =3D=3D 0) {
> > +        trace_sungem_rx_txdma_disabled();
> > +        return 0;
> > +    }
> > +
> > +    /* Check RX availability */
> > +    kick =3D s->rxdmaregs[RXDMA_KICK >> 2];
> > +    done =3D s->rxdmaregs[RXDMA_DONE >> 2];
> > +    full =3D sungem_rx_full(s, kick, done);
> > +
> > +    trace_sungem_rx_check(!full, kick, done);
> > +
> > +    return !full;
> > +}
> > +
> > +enum {
> > +        rx_no_match,
> > +        rx_match_promisc,
> > +        rx_match_bcast,
> > +        rx_match_allmcast,
> > +        rx_match_mcast,
> > +        rx_match_mac,
> > +        rx_match_altmac,
> > +};
> > +
> > +static int sungem_check_rx_mac(SunGEMState *s, const uint8_t *mac, uin=
t32_t crc)
> > +{
> > +    uint32_t rxcfg =3D s->macregs[MAC_RXCFG >> 2];
> > +    uint32_t mac0, mac1, mac2;
> > +
> > +    /* Promisc enabled ? */
> > +    if (rxcfg & MAC_RXCFG_PROM) {
> > +        return rx_match_promisc;
> > +    }
> > +
> > +    /* Format MAC address into dwords */
> > +    mac0 =3D (mac[4] << 8) | mac[5];
> > +    mac1 =3D (mac[2] << 8) | mac[3];
> > +    mac2 =3D (mac[0] << 8) | mac[1];
> > +
> > +    trace_sungem_rx_mac_check(mac0, mac1, mac2);
> > +
> > +    /* Is this a broadcast frame ? */
> > +    if (mac0 =3D=3D 0xffff && mac1 =3D=3D 0xffff && mac2 =3D=3D 0xffff=
) {
> > +        return rx_match_bcast;
> > +    }
> > +
> > +    /* TODO: Implement address filter registers (or we don't care ?) */
> > +
> > +    /* Is this a multicast frame ? */
> > +    if (mac[0] & 1) {
> > +        trace_sungem_rx_mac_multicast();
> > +
> > +        /* Promisc group enabled ? */
> > +        if (rxcfg & MAC_RXCFG_PGRP) {
> > +            return rx_match_allmcast;
> > +        }
> > +
> > +        /* TODO: Check MAC control frames (or we don't care) ? */
> > +
> > +        /* Check hash filter (somebody check that's correct ?) */
> > +        if (rxcfg & MAC_RXCFG_HFE) {
> > +            uint32_t hash, idx;
> > +
> > +            crc >>=3D 24;
> > +            idx =3D (crc >> 2) & 0x3c;
> > +            hash =3D s->macregs[(MAC_HASH0 + idx) >> 2];
> > +            if (hash & (1 << (15 - (crc & 0xf)))) {
> > +                return rx_match_mcast;
> > +            }
> > +        }
> > +        return rx_no_match;
> > +    }
> > +
> > +    /* Main MAC check */
> > +    trace_sungem_rx_mac_compare(s->macregs[MAC_ADDR0 >> 2],
> > +                                s->macregs[MAC_ADDR1 >> 2],
> > +                                s->macregs[MAC_ADDR2 >> 2]);
> > +
> > +    if (mac0 =3D=3D s->macregs[MAC_ADDR0 >> 2] &&
> > +        mac1 =3D=3D s->macregs[MAC_ADDR1 >> 2] &&
> > +        mac2 =3D=3D s->macregs[MAC_ADDR2 >> 2]) {
> > +        return rx_match_mac;
> > +    }
> > +
> > +    /* Alt MAC check */
> > +    if (mac0 =3D=3D s->macregs[MAC_ADDR3 >> 2] &&
> > +        mac1 =3D=3D s->macregs[MAC_ADDR4 >> 2] &&
> > +        mac2 =3D=3D s->macregs[MAC_ADDR5 >> 2]) {
> > +        return rx_match_altmac;
> > +    }
> > +
> > +    return rx_no_match;
> > +}
> > +
> > +static ssize_t sungem_receive(NetClientState *nc, const uint8_t *buf,
> > +                              size_t size)
> > +{
> > +    SunGEMState *s =3D qemu_get_nic_opaque(nc);
> > +    PCIDevice *d =3D PCI_DEVICE(s);
> > +    uint32_t mac_crc, done, kick, max_fsize;
> > +    uint32_t fcs_size, ints, rxdma_cfg, rxmac_cfg, csum, coff;
> > +    uint8_t smallbuf[60];
> > +    struct gem_rxd desc;
> > +    uint64_t dbase, baddr;
> > +    unsigned int rx_cond;
> > +
> > +    trace_sungem_rx_packet(size);
> > +
> > +    rxmac_cfg =3D s->macregs[MAC_RXCFG >> 2];
> > +    rxdma_cfg =3D s->rxdmaregs[RXDMA_CFG >> 2];
> > +    max_fsize =3D s->macregs[MAC_MAXFSZ >> 2] & 0x7fff;
> > +
> > +    /* If MAC or DMA disabled, can't receive */
> > +    if (!(rxdma_cfg & RXDMA_CFG_ENABLE) ||
> > +        !(rxmac_cfg & MAC_RXCFG_ENAB)) {
> > +        trace_sungem_rx_disabled();
> > +        return 0;
> > +    }
> > +
> > +    /* Size adjustment for FCS */
> > +    if (rxmac_cfg & MAC_RXCFG_SFCS) {
> > +        fcs_size =3D 0;
> > +    } else {
> > +        fcs_size =3D 4;
> > +    }
> > +
> > +    /* Discard frame smaller than a MAC or larger than max frame size
> > +     * (when accounting for FCS)
> > +     */
> > +    if (size < 6 || (size + 4) > max_fsize) {
> > +        trace_sungem_rx_bad_frame_size(size);
> > +        /* XXX Increment error statistics ? */
> > +        return size;
> > +    }
> > +
> > +    /* We don't drop too small frames since we get them in qemu, we pad
> > +     * them instead. We should probably use the min frame size register
> > +     * but I don't want to use a variable size staging buffer and I
> > +     * know both MacOS and Linux use the default 64 anyway. We use 60
> > +     * here to account for the non-existent FCS.
> > +     */
> > +    if (size < 60) {
> > +        memcpy(smallbuf, buf, size);
> > +        memset(&smallbuf[size], 0, 60 - size);
> > +        buf =3D smallbuf;
> > +        size =3D 60;
> > +    }
> > +
> > +    /* Get MAC crc */
> > +    mac_crc =3D crc32(~0, buf, 6);
> > +
> > +    /* Packet isn't for me ? */
> > +    rx_cond =3D sungem_check_rx_mac(s, buf, mac_crc);
> > +    if (rx_cond =3D=3D rx_no_match) {
> > +        /* Just drop it */
> > +        trace_sungem_rx_unmatched();
> > +        return size;
> > +    }
> > +
> > +    /* Get ring pointers */
> > +    kick =3D s->rxdmaregs[RXDMA_KICK >> 2] & s->rx_mask;
> > +    done =3D s->rxdmaregs[RXDMA_DONE >> 2] & s->rx_mask;
> > +
> > +    trace_sungem_rx_process(done, kick, s->rx_mask + 1);
> > +
> > +    /* Ring full ? Can't receive */
> > +    if (sungem_rx_full(s, kick, done)) {
> > +        trace_sungem_rx_ringfull();
> > +        return 0;
> > +    }
> > +
> > +    /* Note: The real GEM will fetch descriptors in blocks of 4,
> > +     * for now we handle them one at a time, I think the driver will
> > +     * cope
> > +     */
> > +
> > +    dbase =3D s->rxdmaregs[RXDMA_DBHI >> 2];
> > +    dbase =3D (dbase << 32) | s->rxdmaregs[RXDMA_DBLOW >> 2];
> > +
> > +    /* Read the next descriptor */
> > +    pci_dma_read(d, dbase + done * sizeof(desc), &desc, sizeof(desc));
> > +
> > +    trace_sungem_rx_desc(le64_to_cpu(desc.status_word),
> > +                         le64_to_cpu(desc.buffer));
> > +
> > +    /* Effective buffer address */
> > +    baddr =3D le64_to_cpu(desc.buffer) & ~7ull;
> > +    baddr |=3D (rxdma_cfg & RXDMA_CFG_FBOFF) >> 10;
> > +
> > +    /* Write buffer out */
> > +    pci_dma_write(d, baddr, buf, size);
> > +
> > +    if (fcs_size) {
> > +        /* Should we add an FCS ? Linux doesn't ask us to strip it,
> > +         * however I believe nothing checks it... For now we just
> > +         * do nothing. It's faster this way.
> > +         */
> > +    }
> > +
> > +    /* Calculate the checksum */
> > +    coff =3D (rxdma_cfg & RXDMA_CFG_CSUMOFF) >> 13;
> > +    csum =3D net_raw_checksum((uint8_t *)buf + coff, size - coff);
> > +
> > +    /* Build the updated descriptor */
> > +    desc.status_word =3D (size + fcs_size) << 16;
> > +    desc.status_word |=3D ((uint64_t)(mac_crc >> 16)) << 44;
> > +    desc.status_word |=3D csum;
> > +    if (rx_cond =3D=3D rx_match_mcast) {
> > +        desc.status_word |=3D RXDCTRL_HPASS;
> > +    }
> > +    if (rx_cond =3D=3D rx_match_altmac) {
> > +        desc.status_word |=3D RXDCTRL_ALTMAC;
> > +    }
> > +    desc.status_word =3D cpu_to_le64(desc.status_word);
> > +
> > +    pci_dma_write(d, dbase + done * sizeof(desc), &desc, sizeof(desc));
> > +
> > +    done =3D (done + 1) & s->rx_mask;
> > +    s->rxdmaregs[RXDMA_DONE >> 2] =3D done;
> > +
> > +    /* XXX Unconditionally set RX interrupt for now. The interrupt
> > +     * mitigation timer might well end up adding more overhead than
> > +     * helping here...
> > +     */
> > +    ints =3D GREG_STAT_RXDONE;
> > +    if (sungem_rx_full(s, kick, done)) {
> > +        ints |=3D GREG_STAT_RXNOBUF;
> > +    }
> > +    sungem_update_status(s, ints, true);
> > +
> > +    return size;
> > +}
> > +
> > +static void sungem_set_link_status(NetClientState *nc)
> > +{
> > +    /* We don't do anything for now as I believe none of the OSes
> > +     * drivers use the MIF autopoll feature nor the PHY interrupt
> > +     */
> > +}
> > +
> > +static void sungem_update_masks(SunGEMState *s)
> > +{
> > +    uint32_t sz;
> > +
> > +    sz =3D 1 << (((s->rxdmaregs[RXDMA_CFG >> 2] & RXDMA_CFG_RINGSZ) >>=
 1) + 5);
> > +    s->rx_mask =3D sz - 1;
> > +
> > +    sz =3D 1 << (((s->txdmaregs[TXDMA_CFG >> 2] & TXDMA_CFG_RINGSZ) >>=
 1) + 5);
> > +    s->tx_mask =3D sz - 1;
> > +}
> > +
> > +static void sungem_reset_rx(SunGEMState *s)
> > +{
> > +    trace_sungem_rx_reset();
> > +
> > +    /* XXX Do RXCFG */
> > +    /* XXX Check value */
> > +    s->rxdmaregs[RXDMA_FSZ >> 2] =3D 0x140;
> > +    s->rxdmaregs[RXDMA_DONE >> 2] =3D 0;
> > +    s->rxdmaregs[RXDMA_KICK >> 2] =3D 0;
> > +    s->rxdmaregs[RXDMA_CFG >> 2] =3D 0x1000010;
> > +    s->rxdmaregs[RXDMA_PTHRESH >> 2] =3D 0xf8;
> > +    s->rxdmaregs[RXDMA_BLANK >> 2] =3D 0;
> > +
> > +    sungem_update_masks(s);
> > +}
> > +
> > +static void sungem_reset_tx(SunGEMState *s)
> > +{
> > +    trace_sungem_tx_reset();
> > +
> > +    /* XXX Do TXCFG */
> > +    /* XXX Check value */
> > +    s->txdmaregs[TXDMA_FSZ >> 2] =3D 0x90;
> > +    s->txdmaregs[TXDMA_TXDONE >> 2] =3D 0;
> > +    s->txdmaregs[TXDMA_KICK >> 2] =3D 0;
> > +    s->txdmaregs[TXDMA_CFG >> 2] =3D 0x118010;
> > +
> > +    sungem_update_masks(s);
> > +
> > +    s->tx_size =3D 0;
> > +    s->tx_first_ctl =3D 0;
> > +}
> > +
> > +static void sungem_reset_all(SunGEMState *s, bool pci_reset)
> > +{
> > +    trace_sungem_reset(pci_reset);
> > +
> > +    sungem_reset_rx(s);
> > +    sungem_reset_tx(s);
> > +
> > +    s->gregs[GREG_IMASK >> 2] =3D 0xFFFFFFF;
> > +    s->gregs[GREG_STAT >> 2] =3D 0;
> > +    if (pci_reset) {
> > +        uint8_t *ma =3D s->conf.macaddr.a;
> > +
> > +        s->gregs[GREG_SWRST >> 2] =3D 0;
> > +        s->macregs[MAC_ADDR0 >> 2] =3D (ma[4] << 8) | ma[5];
> > +        s->macregs[MAC_ADDR1 >> 2] =3D (ma[2] << 8) | ma[3];
> > +        s->macregs[MAC_ADDR2 >> 2] =3D (ma[0] << 8) | ma[1];
> > +    } else {
> > +        s->gregs[GREG_SWRST >> 2] &=3D GREG_SWRST_RSTOUT;
> > +    }
> > +    s->mifregs[MIF_CFG >> 2] =3D MIF_CFG_MDI0;
> > +}
> > +
> > +static void sungem_mii_write(SunGEMState *s, uint8_t phy_addr,
> > +                             uint8_t reg_addr, uint16_t val)
> > +{
> > +    trace_sungem_mii_write(phy_addr, reg_addr, val);
> > +
> > +    /* XXX TODO */
> > +}
> > +
> > +static uint16_t __sungem_mii_read(SunGEMState *s, uint8_t phy_addr,
> > +                                  uint8_t reg_addr)
> > +{
> > +    if (phy_addr !=3D s->phy_addr) {
> > +        return 0xffff;
> > +    }
> > +    /* Primitive emulation of a BCM5201 to please the driver,
> > +     * ID is 0x00406210. TODO: Do a gigabit PHY like BCM5400
> > +     */
> > +    switch (reg_addr) {
> > +    case MII_BMCR:
> > +        return 0;
> > +    case MII_PHYID1:
> > +        return 0x0040;
> > +    case MII_PHYID2:
> > +        return 0x6210;
> > +    case MII_BMSR:
> > +        if (qemu_get_queue(s->nic)->link_down) {
> > +            return MII_BMSR_100TX_FD  | MII_BMSR_AUTONEG;
> > +        } else {
> > +            return MII_BMSR_100TX_FD | MII_BMSR_AN_COMP |
> > +                    MII_BMSR_AUTONEG | MII_BMSR_LINK_ST;
> > +        }
> > +    case MII_ANLPAR:
> > +    case MII_ANAR:
> > +        return MII_ANLPAR_TXFD;
> > +    case 0x18: /* 5201 AUX status */
> > +        return 3; /* 100FD */
> > +    default:
> > +        return 0;
> > +    };
> > +}
> > +static uint16_t sungem_mii_read(SunGEMState *s, uint8_t phy_addr,
> > +                                uint8_t reg_addr)
> > +{
> > +    uint16_t val;
> > +
> > +    val =3D __sungem_mii_read(s, phy_addr, reg_addr);
> > +
> > +    trace_sungem_mii_read(phy_addr, reg_addr, val);
> > +
> > +    return val;
> > +}
> > +
> > +static uint32_t sungem_mii_op(SunGEMState *s, uint32_t val)
> > +{
> > +    uint8_t phy_addr, reg_addr, op;
> > +
> > +    /* Ignore not start of frame */
> > +    if ((val >> 30) !=3D 1) {
> > +        trace_sungem_mii_invalid_sof(val >> 30);
> > +        return 0xffff;
> > +    }
> > +    phy_addr =3D (val & MIF_FRAME_PHYAD) >> 23;
> > +    reg_addr =3D (val & MIF_FRAME_REGAD) >> 18;
> > +    op =3D (val & MIF_FRAME_OP) >> 28;
> > +    switch (op) {
> > +    case 1:
> > +        sungem_mii_write(s, phy_addr, reg_addr, val & MIF_FRAME_DATA);
> > +        return val | MIF_FRAME_TALSB;
> > +    case 2:
> > +        return sungem_mii_read(s, phy_addr, reg_addr) | MIF_FRAME_TALS=
B;
> > +    default:
> > +        trace_sungem_mii_invalid_op(op);
> > +    }
> > +    return 0xffff | MIF_FRAME_TALSB;
> > +}
> > +
> > +static void sungem_mmio_greg_write(void *opaque, hwaddr addr, uint64_t=
 val,
> > +                                   unsigned size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +
> > +    if (!(addr < 0x20) && !(addr >=3D 0x1000 && addr <=3D 0x1010)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Write to unknown GREG register 0x%"HWADDR_PRIx"=
\n",
> > +                      addr);
> > +        return;
> > +    }
> > +
> > +    trace_sungem_mmio_greg_write(addr, val);
> > +
> > +    /* Pre-write filter */
> > +    switch (addr) {
> > +    /* Read only registers */
> > +    case GREG_SEBSTATE:
> > +    case GREG_STAT:
> > +    case GREG_STAT2:
> > +    case GREG_PCIESTAT:
> > +        return; /* No actual write */
> > +    case GREG_IACK:
> > +        val &=3D GREG_STAT_LATCH;
> > +        s->gregs[GREG_STAT >> 2] &=3D ~val;
> > +        sungem_eval_irq(s);
> > +        return; /* No actual write */
> > +    case GREG_PCIEMASK:
> > +        val &=3D 0x7;
> > +        break;
> > +    }
> > +
> > +    s->gregs[addr  >> 2] =3D val;
> > +
> > +    /* Post write action */
> > +    switch (addr) {
> > +    case GREG_IMASK:
> > +        /* Re-evaluate interrupt */
> > +        sungem_eval_irq(s);
> > +        break;
> > +    case GREG_SWRST:
> > +        switch (val & (GREG_SWRST_TXRST | GREG_SWRST_RXRST)) {
> > +        case GREG_SWRST_RXRST:
> > +            sungem_reset_rx(s);
> > +            break;
> > +        case GREG_SWRST_TXRST:
> > +            sungem_reset_tx(s);
> > +            break;
> > +        case GREG_SWRST_RXRST | GREG_SWRST_TXRST:
> > +            sungem_reset_all(s, false);
> > +        }
> > +        break;
> > +    }
> > +}
> > +
> > +static uint64_t sungem_mmio_greg_read(void *opaque, hwaddr addr, unsig=
ned size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +    uint32_t val;
> > +
> > +    if (!(addr < 0x20) && !(addr >=3D 0x1000 && addr <=3D 0x1010)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Read from unknown GREG register 0x%"HWADDR_PRIx=
"\n",
> > +                      addr);
> > +        return 0;
> > +    }
> > +
> > +    val =3D s->gregs[addr >> 2];
> > +
> > +    trace_sungem_mmio_greg_read(addr, val);
> > +
> > +    switch (addr) {
> > +    case GREG_STAT:
> > +        /* Side effect, clear bottom 7 bits */
> > +        s->gregs[GREG_STAT >> 2] &=3D ~GREG_STAT_LATCH;
> > +        sungem_eval_irq(s);
> > +
> > +        /* Inject TX completion in returned value */
> > +        val =3D (val & ~GREG_STAT_TXNR) |
> > +                (s->txdmaregs[TXDMA_TXDONE >> 2] << GREG_STAT_TXNR_SHI=
FT);
> > +        break;
> > +    case GREG_STAT2:
> > +        /* Return the status reg without side effect
> > +         * (and inject TX completion in returned value)
> > +         */
> > +        val =3D (s->gregs[GREG_STAT >> 2] & ~GREG_STAT_TXNR) |
> > +              (s->txdmaregs[TXDMA_TXDONE >> 2] << GREG_STAT_TXNR_SHIFT=
);
> > +        break;
> > +    }
> > +
> > +    return val;
> > +}
> > +
> > +static const MemoryRegionOps sungem_mmio_greg_ops =3D {
> > +    .read =3D sungem_mmio_greg_read,
> > +    .write =3D sungem_mmio_greg_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void sungem_mmio_txdma_write(void *opaque, hwaddr addr, uint64_=
t val,
> > +                                    unsigned size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +
> > +    if (!(addr < 0x38) && !(addr >=3D 0x100 && addr <=3D 0x118)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Write to unknown TXDMA register 0x%"HWADDR_PRIx=
"\n",
> > +                      addr);
> > +        return;
> > +    }
> > +
> > +    trace_sungem_mmio_txdma_write(addr, val);
> > +
> > +    /* Pre-write filter */
> > +    switch (addr) {
> > +    /* Read only registers */
> > +    case TXDMA_TXDONE:
> > +    case TXDMA_PCNT:
> > +    case TXDMA_SMACHINE:
> > +    case TXDMA_DPLOW:
> > +    case TXDMA_DPHI:
> > +    case TXDMA_FSZ:
> > +    case TXDMA_FTAG:
> > +        return; /* No actual write */
> > +    }
> > +
> > +    s->txdmaregs[addr >> 2] =3D val;
> > +
> > +    /* Post write action */
> > +    switch (addr) {
> > +    case TXDMA_KICK:
> > +        sungem_tx_kick(s);
> > +        break;
> > +    case TXDMA_CFG:
> > +        sungem_update_masks(s);
> > +        break;
> > +    }
> > +}
> > +
> > +static uint64_t sungem_mmio_txdma_read(void *opaque, hwaddr addr, unsi=
gned size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +    uint32_t val;
> > +
> > +    if (!(addr < 0x38) && !(addr >=3D 0x100 && addr <=3D 0x118)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Read from unknown TXDMA register 0x%"HWADDR_PRI=
x"\n",
> > +                      addr);
> > +        return 0;
> > +    }
> > +
> > +    val =3D s->txdmaregs[addr >> 2];
> > +
> > +    trace_sungem_mmio_txdma_read(addr, val);
> > +
> > +    return val;
> > +}
> > +
> > +static const MemoryRegionOps sungem_mmio_txdma_ops =3D {
> > +    .read =3D sungem_mmio_txdma_read,
> > +    .write =3D sungem_mmio_txdma_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void sungem_mmio_rxdma_write(void *opaque, hwaddr addr, uint64_=
t val,
> > +                                    unsigned size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +
> > +    if (!(addr <=3D 0x28) && !(addr >=3D 0x100 && addr <=3D 0x120)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Write to unknown RXDMA register 0x%"HWADDR_PRIx=
"\n",
> > +                      addr);
> > +        return;
> > +    }
> > +
> > +    trace_sungem_mmio_rxdma_write(addr, val);
> > +
> > +    /* Pre-write filter */
> > +    switch (addr) {
> > +    /* Read only registers */
> > +    case RXDMA_DONE:
> > +    case RXDMA_PCNT:
> > +    case RXDMA_SMACHINE:
> > +    case RXDMA_DPLOW:
> > +    case RXDMA_DPHI:
> > +    case RXDMA_FSZ:
> > +    case RXDMA_FTAG:
> > +        return; /* No actual write */
> > +    }
> > +
> > +    s->rxdmaregs[addr >> 2] =3D val;
> > +
> > +    /* Post write action */
> > +    switch (addr) {
> > +    case RXDMA_KICK:
> > +        trace_sungem_rx_kick(val);
> > +        break;
> > +    case RXDMA_CFG:
> > +        sungem_update_masks(s);
> > +        if ((s->macregs[MAC_RXCFG >> 2] & MAC_RXCFG_ENAB) !=3D 0 &&
> > +            (s->rxdmaregs[RXDMA_CFG >> 2] & RXDMA_CFG_ENABLE) !=3D 0) {
> > +            qemu_flush_queued_packets(qemu_get_queue(s->nic));
> > +        }
> > +        break;
> > +    }
> > +}
> > +
> > +static uint64_t sungem_mmio_rxdma_read(void *opaque, hwaddr addr, unsi=
gned size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +    uint32_t val;
> > +
> > +    if (!(addr <=3D 0x28) && !(addr >=3D 0x100 && addr <=3D 0x120)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Read from unknown RXDMA register 0x%"HWADDR_PRI=
x"\n",
> > +                      addr);
> > +        return 0;
> > +    }
> > +
> > +    val =3D s->rxdmaregs[addr >> 2];
> > +
> > +    trace_sungem_mmio_rxdma_read(addr, val);
> > +
> > +    return val;
> > +}
> > +
> > +static const MemoryRegionOps sungem_mmio_rxdma_ops =3D {
> > +    .read =3D sungem_mmio_rxdma_read,
> > +    .write =3D sungem_mmio_rxdma_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void sungem_mmio_mac_write(void *opaque, hwaddr addr, uint64_t =
val,
> > +                                  unsigned size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +
> > +    if (!(addr <=3D 0x134)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Write to unknown MAC register 0x%"HWADDR_PRIx"\=
n",
> > +                      addr);
> > +        return;
> > +    }
> > +
> > +    trace_sungem_mmio_mac_write(addr, val);
> > +
> > +    /* Pre-write filter */
> > +    switch (addr) {
> > +    /* Read only registers */
> > +    case MAC_TXRST: /* Not technically read-only but will do for now */
> > +    case MAC_RXRST: /* Not technically read-only but will do for now */
> > +    case MAC_TXSTAT:
> > +    case MAC_RXSTAT:
> > +    case MAC_CSTAT:
> > +    case MAC_PATMPS:
> > +    case MAC_SMACHINE:
> > +        return; /* No actual write */
> > +    case MAC_MINFSZ:
> > +        /* 10-bits implemented */
> > +        val &=3D 0x3ff;
> > +        break;
> > +    }
> > +
> > +    s->macregs[addr >> 2] =3D val;
> > +
> > +    /* Post write action */
> > +    switch (addr) {
> > +    case MAC_TXMASK:
> > +    case MAC_RXMASK:
> > +    case MAC_MCMASK:
> > +        sungem_eval_cascade_irq(s);
> > +        break;
> > +    case MAC_RXCFG:
> > +        sungem_update_masks(s);
> > +        if ((s->macregs[MAC_RXCFG >> 2] & MAC_RXCFG_ENAB) !=3D 0 &&
> > +            (s->rxdmaregs[RXDMA_CFG >> 2] & RXDMA_CFG_ENABLE) !=3D 0) {
> > +            qemu_flush_queued_packets(qemu_get_queue(s->nic));
> > +        }
> > +        break;
> > +    }
> > +}
> > +
> > +static uint64_t sungem_mmio_mac_read(void *opaque, hwaddr addr, unsign=
ed size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +    uint32_t val;
> > +
> > +    if (!(addr <=3D 0x134)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Read from unknown MAC register 0x%"HWADDR_PRIx"=
\n",
> > +                      addr);
> > +        return 0;
> > +    }
> > +
> > +    val =3D s->macregs[addr >> 2];
> > +
> > +    trace_sungem_mmio_mac_read(addr, val);
> > +
> > +    switch (addr) {
> > +    case MAC_TXSTAT:
> > +        /* Side effect, clear all */
> > +        s->macregs[addr >> 2] =3D 0;
> > +        sungem_update_status(s, GREG_STAT_TXMAC, false);
> > +        break;
> > +    case MAC_RXSTAT:
> > +        /* Side effect, clear all */
> > +        s->macregs[addr >> 2] =3D 0;
> > +        sungem_update_status(s, GREG_STAT_RXMAC, false);
> > +        break;
> > +    case MAC_CSTAT:
> > +        /* Side effect, interrupt bits */
> > +        s->macregs[addr >> 2] &=3D MAC_CSTAT_PTR;
> > +        sungem_update_status(s, GREG_STAT_MAC, false);
> > +        break;
> > +    }
> > +
> > +    return val;
> > +}
> > +
> > +static const MemoryRegionOps sungem_mmio_mac_ops =3D {
> > +    .read =3D sungem_mmio_mac_read,
> > +    .write =3D sungem_mmio_mac_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void sungem_mmio_mif_write(void *opaque, hwaddr addr, uint64_t =
val,
> > +                                  unsigned size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +
> > +    if (!(addr <=3D 0x1c)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Write to unknown MIF register 0x%"HWADDR_PRIx"\=
n",
> > +                      addr);
> > +        return;
> > +    }
> > +
> > +    trace_sungem_mmio_mif_write(addr, val);
> > +
> > +    /* Pre-write filter */
> > +    switch (addr) {
> > +    /* Read only registers */
> > +    case MIF_STATUS:
> > +    case MIF_SMACHINE:
> > +        return; /* No actual write */
> > +    case MIF_CFG:
> > +        /* Maintain the RO MDI bits to advertize an MDIO PHY on MDI0 */
> > +        val &=3D ~MIF_CFG_MDI1;
> > +        val |=3D MIF_CFG_MDI0;
> > +        break;
> > +    }
> > +
> > +    s->mifregs[addr >> 2] =3D val;
> > +
> > +    /* Post write action */
> > +    switch (addr) {
> > +    case MIF_FRAME:
> > +        s->mifregs[addr >> 2] =3D sungem_mii_op(s, val);
> > +        break;
> > +    }
> > +}
> > +
> > +static uint64_t sungem_mmio_mif_read(void *opaque, hwaddr addr, unsign=
ed size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +    uint32_t val;
> > +
> > +    if (!(addr <=3D 0x1c)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Read from unknown MIF register 0x%"HWADDR_PRIx"=
\n",
> > +                      addr);
> > +        return 0;
> > +    }
> > +
> > +    val =3D s->mifregs[addr >> 2];
> > +
> > +    trace_sungem_mmio_mif_read(addr, val);
> > +
> > +    return val;
> > +}
> > +
> > +static const MemoryRegionOps sungem_mmio_mif_ops =3D {
> > +    .read =3D sungem_mmio_mif_read,
> > +    .write =3D sungem_mmio_mif_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void sungem_mmio_pcs_write(void *opaque, hwaddr addr, uint64_t =
val,
> > +                                  unsigned size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +
> > +    if (!(addr <=3D 0x18) && !(addr >=3D 0x50 && addr <=3D 0x5c)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Write to unknown PCS register 0x%"HWADDR_PRIx"\=
n",
> > +                      addr);
> > +        return;
> > +    }
> > +
> > +    trace_sungem_mmio_pcs_write(addr, val);
> > +
> > +    /* Pre-write filter */
> > +    switch (addr) {
> > +    /* Read only registers */
> > +    case PCS_MIISTAT:
> > +    case PCS_ISTAT:
> > +    case PCS_SSTATE:
> > +        return; /* No actual write */
> > +    }
> > +
> > +    s->pcsregs[addr >> 2] =3D val;
> > +}
> > +
> > +static uint64_t sungem_mmio_pcs_read(void *opaque, hwaddr addr, unsign=
ed size)
> > +{
> > +    SunGEMState *s =3D opaque;
> > +    uint32_t val;
> > +
> > +    if (!(addr <=3D 0x18) && !(addr >=3D 0x50 && addr <=3D 0x5c)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Read from unknown PCS register 0x%"HWADDR_PRIx"=
\n",
> > +                      addr);
> > +        return 0;
> > +    }
> > +
> > +    val =3D s->pcsregs[addr >> 2];
> > +
> > +    trace_sungem_mmio_pcs_read(addr, val);
> > +
> > +    return val;
> > +}
> > +
> > +static const MemoryRegionOps sungem_mmio_pcs_ops =3D {
> > +    .read =3D sungem_mmio_pcs_read,
> > +    .write =3D sungem_mmio_pcs_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void sungem_uninit(PCIDevice *dev)
> > +{
> > +    SunGEMState *s =3D SUNGEM(dev);
> > +
> > +    qemu_del_nic(s->nic);
> > +}
> > +
> > +static NetClientInfo net_sungem_info =3D {
> > +    .type =3D NET_CLIENT_DRIVER_NIC,
> > +    .size =3D sizeof(NICState),
> > +    .can_receive =3D sungem_can_receive,
> > +    .receive =3D sungem_receive,
> > +    .link_status_changed =3D sungem_set_link_status,
> > +};
> > +
> > +static void sungem_realize(PCIDevice *pci_dev, Error **errp)
> > +{
> > +    DeviceState *dev =3D DEVICE(pci_dev);
> > +    SunGEMState *s =3D SUNGEM(pci_dev);
> > +    uint8_t *pci_conf;
> > +
> > +    pci_conf =3D pci_dev->config;
> > +
> > +    pci_set_word(pci_conf + PCI_STATUS,
> > +                 PCI_STATUS_FAST_BACK |
> > +                 PCI_STATUS_DEVSEL_MEDIUM |
> > +                 PCI_STATUS_66MHZ);
> > +
> > +    pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID, 0x0);
> > +    pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, 0x0);
> > +
> > +    pci_conf[PCI_INTERRUPT_PIN] =3D 1; /* interrupt pin A */
> > +    pci_conf[PCI_MIN_GNT] =3D 0x40;
> > +    pci_conf[PCI_MAX_LAT] =3D 0x40;
> > +
> > +    sungem_reset_all(s, true);
> > +    memory_region_init(&s->sungem, OBJECT(s), "sungem", SUNGEM_MMIO_SI=
ZE);
> > +
> > +    memory_region_init_io(&s->greg, OBJECT(s), &sungem_mmio_greg_ops, =
s,
> > +                          "sungem.greg", SUNGEM_MMIO_GREG_SIZE);
> > +    memory_region_add_subregion(&s->sungem, 0, &s->greg);
> > +
> > +    memory_region_init_io(&s->txdma, OBJECT(s), &sungem_mmio_txdma_ops=
, s,
> > +                          "sungem.txdma", SUNGEM_MMIO_TXDMA_SIZE);
> > +    memory_region_add_subregion(&s->sungem, 0x2000, &s->txdma);
> > +
> > +    memory_region_init_io(&s->rxdma, OBJECT(s), &sungem_mmio_rxdma_ops=
, s,
> > +                          "sungem.rxdma", SUNGEM_MMIO_RXDMA_SIZE);
> > +    memory_region_add_subregion(&s->sungem, 0x4000, &s->rxdma);
> > +
> > +    memory_region_init_io(&s->mac, OBJECT(s), &sungem_mmio_mac_ops, s,
> > +                          "sungem.mac", SUNGEM_MMIO_MAC_SIZE);
> > +    memory_region_add_subregion(&s->sungem, 0x6000, &s->mac);
> > +
> > +    memory_region_init_io(&s->mif, OBJECT(s), &sungem_mmio_mif_ops, s,
> > +                          "sungem.mif", SUNGEM_MMIO_MIF_SIZE);
> > +    memory_region_add_subregion(&s->sungem, 0x6200, &s->mif);
> > +
> > +    memory_region_init_io(&s->pcs, OBJECT(s), &sungem_mmio_pcs_ops, s,
> > +                          "sungem.pcs", SUNGEM_MMIO_PCS_SIZE);
> > +    memory_region_add_subregion(&s->sungem, 0x9000, &s->pcs);
> > +
> > +    pci_register_bar(pci_dev, 0, 0, &s->sungem);
> > +
> > +    qemu_macaddr_default_if_unset(&s->conf.macaddr);
> > +    s->nic =3D qemu_new_nic(&net_sungem_info, &s->conf,
> > +                          object_get_typename(OBJECT(dev)),
> > +                          dev->id, s);
> > +    qemu_format_nic_info_str(qemu_get_queue(s->nic),
> > +                             s->conf.macaddr.a);
> > +}
> > +
> > +static void sungem_reset(DeviceState *dev)
> > +{
> > +    SunGEMState *s =3D SUNGEM(dev);
> > +
> > +    sungem_reset_all(s, true);
> > +}
> > +
> > +static void sungem_instance_init(Object *obj)
> > +{
> > +    SunGEMState *s =3D SUNGEM(obj);
> > +
> > +    device_add_bootindex_property(obj, &s->conf.bootindex,
> > +                                  "bootindex", "/ethernet-phy@0",
> > +                                  DEVICE(obj), NULL);
> > +}
> > +
> > +static Property sungem_properties[] =3D {
> > +    DEFINE_NIC_PROPERTIES(SunGEMState, conf),
> > +    /* Phy address should be 0 for most Apple machines except
> > +     * for K2 in which case it's 1. Will be set by a machine
> > +     * override.
> > +     */
> > +    DEFINE_PROP_UINT32("phy_addr", SunGEMState, phy_addr, 0),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static const VMStateDescription vmstate_sungem =3D {
> > +    .name =3D "sungem",
> > +    .version_id =3D 0,
> > +    .minimum_version_id =3D 0,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_PCI_DEVICE(pdev, SunGEMState),
> > +        VMSTATE_MACADDR(conf.macaddr, SunGEMState),
> > +        VMSTATE_UINT32(phy_addr, SunGEMState),
> > +        VMSTATE_UINT32_ARRAY(gregs, SunGEMState, (SUNGEM_MMIO_GREG_SIZ=
E >> 2)),
> > +        VMSTATE_UINT32_ARRAY(txdmaregs, SunGEMState,
> > +                             (SUNGEM_MMIO_TXDMA_SIZE >> 2)),
> > +        VMSTATE_UINT32_ARRAY(rxdmaregs, SunGEMState,
> > +                             (SUNGEM_MMIO_RXDMA_SIZE >> 2)),
> > +        VMSTATE_UINT32_ARRAY(macregs, SunGEMState, (SUNGEM_MMIO_MAC_SI=
ZE >> 2)),
> > +        VMSTATE_UINT32_ARRAY(mifregs, SunGEMState, (SUNGEM_MMIO_MIF_SI=
ZE >> 2)),
> > +        VMSTATE_UINT32_ARRAY(pcsregs, SunGEMState, (SUNGEM_MMIO_PCS_SI=
ZE >> 2)),
> > +        VMSTATE_UINT32(rx_mask, SunGEMState),
> > +        VMSTATE_UINT32(tx_mask, SunGEMState),
> > +        VMSTATE_UINT8_ARRAY(tx_data, SunGEMState, MAX_PACKET_SIZE),
> > +        VMSTATE_UINT32(tx_size, SunGEMState),
> > +        VMSTATE_UINT64(tx_first_ctl, SunGEMState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void sungem_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> > +
> > +    k->realize =3D sungem_realize;
> > +    k->exit =3D sungem_uninit;
> > +    k->vendor_id =3D PCI_VENDOR_ID_APPLE;
> > +    k->device_id =3D PCI_DEVICE_ID_APPLE_UNI_N_GMAC;
> > +    k->revision =3D 0x01;
> > +    k->class_id =3D PCI_CLASS_NETWORK_ETHERNET;
> > +    dc->vmsd =3D &vmstate_sungem;
> > +    dc->reset =3D sungem_reset;
> > +    dc->props =3D sungem_properties;
> > +    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> > +}
> > +
> > +static const TypeInfo sungem_info =3D {
> > +    .name          =3D TYPE_SUNGEM,
> > +    .parent        =3D TYPE_PCI_DEVICE,
> > +    .instance_size =3D sizeof(SunGEMState),
> > +    .class_init    =3D sungem_class_init,
> > +    .instance_init =3D sungem_instance_init,
> > +};
> > +
> > +static void sungem_register_types(void)
> > +{
> > +    type_register_static(&sungem_info);
> > +}
> > +
> > +type_init(sungem_register_types)
> > diff --git a/hw/net/trace-events b/hw/net/trace-events
> > index 27e5482..cd74ded 100644
> > --- a/hw/net/trace-events
> > +++ b/hw/net/trace-events
> > @@ -278,3 +278,47 @@ spapr_vlan_h_send_logical_lan(uint64_t reg, uint64=
_t continue_token) "H_SEND_LOG
> >  spapr_vlan_h_send_logical_lan_rxbufs(uint32_t rx_bufs) "rxbufs =3D %"P=
RIu32
> >  spapr_vlan_h_send_logical_lan_buf_desc(uint64_t buf) "   buf desc: 0x%=
"PRIx64
> >  spapr_vlan_h_send_logical_lan_total(int nbufs, unsigned total_len) "%d=
 buffers, total length 0x%x"
> > +
> > +# hw/net/sungem.c
> > +sungem_tx_checksum(uint16_t start, uint16_t off) "TX checksumming from=
 byte %d, inserting at %d"
> > +sungem_tx_checksum_oob(void) "TX checksum out of packet bounds"
> > +sungem_tx_unfinished(void) "TX packet started without finishing the pr=
evious one"
> > +sungem_tx_overflow(void) "TX packet queue overflow"
> > +sungem_tx_finished(uint32_t size) "TX completing %"PRIu32 " bytes pack=
et"
> > +sungem_tx_kick(void) "TX Kick..."
> > +sungem_tx_disabled(void) "TX not enabled"
> > +sungem_tx_process(uint32_t comp, uint32_t kick, uint32_t size) "TX pro=
cessing comp=3D%"PRIu32", kick=3D%"PRIu32" out of %"PRIu32
> > +sungem_tx_desc(uint32_t comp, uint64_t control, uint64_t buffer) "TX d=
esc %"PRIu32 ": 0x%"PRIx64" 0x%"PRIx64
> > +sungem_tx_reset(void) "TX reset"
> > +sungem_rx_mac_disabled(void) "Check RX MAC disabled"
> > +sungem_rx_txdma_disabled(void) "Check RX TXDMA disabled"
> > +sungem_rx_check(bool full, uint32_t kick, uint32_t done) "Check RX %d =
(kick=3D%"PRIu32", done=3D%"PRIu32")"
> > +sungem_rx_mac_check(uint32_t mac0, uint32_t mac1, uint32_t mac2) "Word=
 MAC: 0x%"PRIx32" 0x%"PRIx32" 0x%"PRIx32
> > +sungem_rx_mac_multicast(void) "Multicast"
> > +sungem_rx_mac_compare(uint32_t mac0, uint32_t mac1, uint32_t mac2) "Co=
mpare MAC to 0x%"PRIx32" 0x%"PRIx32" 0x%"PRIx32".."
> > +sungem_rx_packet(size_t size) "RX got %zu bytes packet"
> > +sungem_rx_disabled(void) "RX not enabled"
> > +sungem_rx_bad_frame_size(size_t size) "RX bad frame size %zu, dropped"
> > +sungem_rx_unmatched(void) "No match, dropped"
> > +sungem_rx_process(uint32_t done, uint32_t kick, uint32_t size) "RX pro=
cessing done=3D%"PRIu32", kick=3D%"PRIu32" out of %"PRIu32
> > +sungem_rx_ringfull(void) "RX ring full"
> > +sungem_rx_desc(uint64_t control, uint64_t buffer) "RX desc: 0x%"PRIx64=
" 0x%"PRIx64
> > +sungem_rx_reset(void) "RX reset"
> > +sungem_rx_kick(uint64_t val) "RXDMA_KICK written to %"PRIu64
> > +sungem_reset(bool pci_reset) "Full reset (PCI:%d)"
> > +sungem_mii_write(uint8_t phy_addr, uint8_t reg_addr, uint16_t val) "MI=
I write addr 0x%x reg 0x%02x val 0x%04x"
> > +sungem_mii_read(uint8_t phy_addr, uint8_t reg_addr, uint16_t val) "MII=
 read addr 0x%x reg 0x%02x val 0x%04x"
> > +sungem_mii_invalid_sof(uint32_t val) "MII op, invalid SOF field 0x%"PR=
Ix32
> > +sungem_mii_invalid_op(uint8_t op) "MII op, invalid op field 0x%x"
> > +sungem_mmio_greg_write(hwaddr addr, uint64_t val) "MMIO greg write to =
0x%"HWADDR_PRIx" val=3D0x%"PRIx64
> > +sungem_mmio_greg_read(hwaddr addr, uint64_t val) "MMIO greg read from =
0x%"PRIx64" val=3D0x%"PRIx64
> > +sungem_mmio_txdma_write(hwaddr addr, uint64_t val) "MMIO txdma write t=
o 0x%"HWADDR_PRIx" val=3D0x%"PRIx64
> > +sungem_mmio_txdma_read(hwaddr addr, uint64_t val) "MMIO txdma read fro=
m 0x%"PRIx64" val=3D0x%"PRIx64
> > +sungem_mmio_rxdma_write(hwaddr addr, uint64_t val) "MMIO rxdma write t=
o 0x%"HWADDR_PRIx" val=3D0x%"PRIx64
> > +sungem_mmio_rxdma_read(hwaddr addr, uint64_t val) "MMIO rxdma read fro=
m 0x%"PRIx64" val=3D0x%"PRIx64
> > +sungem_mmio_mac_write(hwaddr addr, uint64_t val) "MMIO mac write to 0x=
%"HWADDR_PRIx" val=3D0x%"PRIx64
> > +sungem_mmio_mac_read(hwaddr addr, uint64_t val) "MMIO mac read from 0x=
%"PRIx64" val=3D0x%"PRIx64
> > +sungem_mmio_mif_write(hwaddr addr, uint64_t val) "MMIO mif write to 0x=
%"HWADDR_PRIx" val=3D0x%"PRIx64
> > +sungem_mmio_mif_read(hwaddr addr, uint64_t val) "MMIO mif read from 0x=
%"PRIx64" val=3D0x%"PRIx64
> > +sungem_mmio_pcs_write(hwaddr addr, uint64_t val) "MMIO pcs write to 0x=
%"HWADDR_PRIx" val=3D0x%"PRIx64
> > +sungem_mmio_pcs_read(hwaddr addr, uint64_t val) "MMIO pcs read from 0x=
%"PRIx64" val=3D0x%"PRIx64
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 26f346d..9947fc5 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -1803,6 +1803,7 @@ static const char * const pci_nic_models[] =3D {
> >      "e1000",
> >      "pcnet",
> >      "virtio",
> > +    "sungem",
> >      NULL
> >  };
> > =20
> > @@ -1815,6 +1816,7 @@ static const char * const pci_nic_names[] =3D {
> >      "e1000",
> >      "pcnet",
> >      "virtio-net-pci",
> > +    "sungem",
> >      NULL
> >  };
> > =20
> > diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> > index 3752ddc..b9c2bad 100644
> > --- a/include/hw/pci/pci_ids.h
> > +++ b/include/hw/pci/pci_ids.h
> > @@ -183,6 +183,7 @@
> >  #define PCI_VENDOR_ID_APPLE              0x106b
> >  #define PCI_DEVICE_ID_APPLE_UNI_N_AGP    0x0020
> >  #define PCI_DEVICE_ID_APPLE_U3_AGP       0x004b
> > +#define PCI_DEVICE_ID_APPLE_UNI_N_GMAC   0x0021
> > =20
> >  #define PCI_VENDOR_ID_SUN                0x108e
> >  #define PCI_DEVICE_ID_SUN_EBUS           0x1000
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmvaIEACgkQbDjKyiDZ
s5JC0BAAhwiMhGe5Bi5c7O9H1iLpxFPB17FztV4uu6+uUdUqbcliK/04OJxCuh2T
K62ZAh9irj+cLobtue2DH6/vo4wn4OgOuGPn342N0xfGKUVq3cpmxGVSiekR/zrk
jrNDfwwS8fpRdv9MbX9kNevVzcekOZu7i/DOXGtdTIRschABJkxZhayP416or6Dq
p2I8Mc9BpP0hTYvubbsIzAUhHOhIy0JJanFHq4Td4orLjC74UshFxzqx6CEiYONm
u43RfXG6TlgJDEhoHGbJ0bTvSohO1VL+ClMb5gVK83zhXQguL2/CAPsNZ3+I8p/g
yHzrLZr0vvQtfB31U9k5BaMrF8IMV7YwhD8lHF57Hm5Yz/rKCc4ytLoRWDE1U2SH
HgfiGud96RvkTqWXM7PeUi8avLgZPj8dW1TOUtHMcP8v1V/YD9eKR9F4GtDoFvWV
gjiWnLeDkQGcrf8rON91RSBzRFt3zGIwi7SFv1YIV6YSt7WngNm3xAJqg4zV9Zyu
Qt5CMDuZ7Xk5hTRAEO+zw3ulo1+Rh6VMruvVCuWOi2bZLuHO8SJuZRzRuw5+PHrM
Tn9JlR/82cNzK8GzOS6DKMZ9bN0KJ1kaSYGzhsnxreaT31/+yF2jENoHE+rggUTq
2i3J5d/Jhx6lSW36KVovht8tcHEaiur2BS99LgTKE+VL7ybGqCQ=
=/fN6
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
