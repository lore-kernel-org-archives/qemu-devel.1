Received: from eggs.gnu.org ([2001:4830:134:3::10]:59227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ds7Km-0002bP-1k
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ds7Kf-0000JD-28
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:04:04 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1ds7Ke-0000HR-PQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 09:03:56 -0400
Received: by mail-it0-x244.google.com with SMTP id o200so345625itg.1
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 06:03:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504879106-2225-2-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1504879106-2225-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1504879106-2225-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 13 Sep 2017 15:03:35 +0200
Message-ID: <CACXAS8DV2D+POpHy8BES0SueZXt0EgyLFGrHvfJmth4HOv-tQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] net: add Sun HME (Happy Meal Ethernet)
 on-board NIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Looks good to me, but networking is not my domain, so can only give Acked-by.

Dmitry, Jason can you please take a look at it?

Regards,
Artyom

On Fri, Sep 8, 2017 at 3:58 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Enable it by default for the sparc64-softmmu configuration.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  default-configs/sparc64-softmmu.mak |    1 +
>  hw/net/Makefile.objs                |    1 +
>  hw/net/sunhme.c                     |  978 +++++++++++++++++++++++++++++++++++
>  hw/net/trace-events                 |   29 ++
>  include/hw/net/mii.h                |    4 +
>  include/hw/pci/pci_ids.h            |    1 +
>  6 files changed, 1014 insertions(+)
>  create mode 100644 hw/net/sunhme.c
>
> diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
> index d07876a..3e177bb 100644
> --- a/default-configs/sparc64-softmmu.mak
> +++ b/default-configs/sparc64-softmmu.mak
> @@ -12,6 +12,7 @@ CONFIG_FDC=y
>  CONFIG_IDE_ISA=y
>  CONFIG_IDE_CMD646=y
>  CONFIG_PCI_APB=y
> +CONFIG_SUNHME=y
>  CONFIG_MC146818RTC=y
>  CONFIG_ISA_TESTDEV=y
>  CONFIG_EMPTY_SLOT=y
> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> index 5ddaffe..0fdc5a0 100644
> --- a/hw/net/Makefile.objs
> +++ b/hw/net/Makefile.objs
> @@ -26,6 +26,7 @@ common-obj-$(CONFIG_IMX_FEC) += imx_fec.o
>  common-obj-$(CONFIG_CADENCE) += cadence_gem.o
>  common-obj-$(CONFIG_STELLARIS_ENET) += stellaris_enet.o
>  common-obj-$(CONFIG_LANCE) += lance.o
> +common-obj-$(CONFIG_SUNHME) += sunhme.o
>  common-obj-$(CONFIG_FTGMAC100) += ftgmac100.o
>
>  obj-$(CONFIG_ETRAXFS) += etraxfs_eth.o
> diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
> new file mode 100644
> index 0000000..60277ad
> --- /dev/null
> +++ b/hw/net/sunhme.c
> @@ -0,0 +1,978 @@
> +/*
> + * QEMU Sun Happy Meal Ethernet emulation
> + *
> + * Copyright (c) 2017 Mark Cave-Ayland
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/hw.h"
> +#include "hw/pci/pci.h"
> +#include "hw/net/mii.h"
> +#include "net/net.h"
> +#include "net/checksum.h"
> +#include "net/eth.h"
> +#include "sysemu/sysemu.h"
> +#include "trace.h"
> +
> +#define HME_REG_SIZE                   0x8000
> +
> +#define HME_SEB_REG_SIZE               0x2000
> +
> +#define HME_SEBI_RESET                 0x0
> +#define HME_SEB_RESET_ETX              0x1
> +#define HME_SEB_RESET_ERX              0x2
> +
> +#define HME_SEBI_STAT                  0x100
> +#define HME_SEBI_STAT_LINUXBUG         0x108
> +#define HME_SEB_STAT_RXTOHOST          0x10000
> +#define HME_SEB_STAT_MIFIRQ            0x800000
> +#define HME_SEB_STAT_HOSTTOTX          0x1000000
> +#define HME_SEB_STAT_TXALL             0x2000000
> +
> +#define HME_SEBI_IMASK                 0x104
> +#define HME_SEBI_IMASK_LINUXBUG        0x10c
> +
> +#define HME_ETX_REG_SIZE               0x2000
> +
> +#define HME_ETXI_PENDING               0x0
> +
> +#define HME_ETXI_RING                  0x8
> +#define HME_ETXI_RING_ADDR             0xffffff00
> +#define HME_ETXI_RING_OFFSET           0xff
> +
> +#define HME_ETXI_RSIZE                 0x2c
> +
> +#define HME_ERX_REG_SIZE               0x2000
> +
> +#define HME_ERXI_CFG                   0x0
> +#define HME_ERX_CFG_RINGSIZE           0x600
> +#define HME_ERX_CFG_RINGSIZE_SHIFT     9
> +#define HME_ERX_CFG_BYTEOFFSET         0x38
> +#define HME_ERX_CFG_BYTEOFFSET_SHIFT   3
> +#define HME_ERX_CFG_CSUMSTART          0x7f0000
> +#define HME_ERX_CFG_CSUMSHIFT          16
> +
> +#define HME_ERXI_RING                  0x4
> +#define HME_ERXI_RING_ADDR             0xffffff00
> +#define HME_ERXI_RING_OFFSET           0xff
> +
> +#define HME_MAC_REG_SIZE               0x1000
> +
> +#define HME_MACI_TXCFG                 0x20c
> +#define HME_MAC_TXCFG_ENABLE           0x1
> +
> +#define HME_MACI_RXCFG                 0x30c
> +#define HME_MAC_RXCFG_ENABLE           0x1
> +#define HME_MAC_RXCFG_PMISC            0x40
> +#define HME_MAC_RXCFG_HENABLE          0x800
> +
> +#define HME_MACI_MACADDR2              0x318
> +#define HME_MACI_MACADDR1              0x31c
> +#define HME_MACI_MACADDR0              0x320
> +
> +#define HME_MACI_HASHTAB3              0x340
> +#define HME_MACI_HASHTAB2              0x344
> +#define HME_MACI_HASHTAB1              0x348
> +#define HME_MACI_HASHTAB0              0x34c
> +
> +#define HME_MIF_REG_SIZE               0x20
> +
> +#define HME_MIFI_FO                    0xc
> +#define HME_MIF_FO_ST                  0xc0000000
> +#define HME_MIF_FO_ST_SHIFT            30
> +#define HME_MIF_FO_OPC                 0x30000000
> +#define HME_MIF_FO_OPC_SHIFT           28
> +#define HME_MIF_FO_PHYAD               0x0f800000
> +#define HME_MIF_FO_PHYAD_SHIFT         23
> +#define HME_MIF_FO_REGAD               0x007c0000
> +#define HME_MIF_FO_REGAD_SHIFT         18
> +#define HME_MIF_FO_TAMSB               0x20000
> +#define HME_MIF_FO_TALSB               0x10000
> +#define HME_MIF_FO_DATA                0xffff
> +
> +#define HME_MIFI_CFG                   0x10
> +#define HME_MIF_CFG_MDI0               0x100
> +#define HME_MIF_CFG_MDI1               0x200
> +
> +#define HME_MIFI_IMASK                 0x14
> +
> +#define HME_MIFI_STAT                  0x18
> +
> +
> +/* Wired HME PHY addresses */
> +#define HME_PHYAD_INTERNAL     1
> +#define HME_PHYAD_EXTERNAL     0
> +
> +#define MII_COMMAND_START      0x1
> +#define MII_COMMAND_READ       0x2
> +#define MII_COMMAND_WRITE      0x1
> +
> +#define TYPE_SUNHME "sunhme"
> +#define SUNHME(obj) OBJECT_CHECK(SunHMEState, (obj), TYPE_SUNHME)
> +
> +/* Maximum size of buffer */
> +#define HME_FIFO_SIZE          0x800
> +
> +/* Size of TX/RX descriptor */
> +#define HME_DESC_SIZE          0x8
> +
> +#define HME_XD_OWN             0x80000000
> +#define HME_XD_OFL             0x40000000
> +#define HME_XD_SOP             0x40000000
> +#define HME_XD_EOP             0x20000000
> +#define HME_XD_RXLENMSK        0x3fff0000
> +#define HME_XD_RXLENSHIFT      16
> +#define HME_XD_RXCKSUM         0xffff
> +#define HME_XD_TXLENMSK        0x00001fff
> +#define HME_XD_TXCKSUM         0x10000000
> +#define HME_XD_TXCSSTUFF       0xff00000
> +#define HME_XD_TXCSSTUFFSHIFT  20
> +#define HME_XD_TXCSSTART       0xfc000
> +#define HME_XD_TXCSSTARTSHIFT  14
> +
> +#define HME_MII_REGS_SIZE      0x20
> +
> +typedef struct SunHMEState {
> +    /*< private >*/
> +    PCIDevice parent_obj;
> +
> +    NICState *nic;
> +    NICConf conf;
> +
> +    MemoryRegion hme;
> +    MemoryRegion sebreg;
> +    MemoryRegion etxreg;
> +    MemoryRegion erxreg;
> +    MemoryRegion macreg;
> +    MemoryRegion mifreg;
> +
> +    uint32_t sebregs[HME_SEB_REG_SIZE >> 2];
> +    uint32_t etxregs[HME_ETX_REG_SIZE >> 2];
> +    uint32_t erxregs[HME_ERX_REG_SIZE >> 2];
> +    uint32_t macregs[HME_MAC_REG_SIZE >> 2];
> +    uint32_t mifregs[HME_MIF_REG_SIZE >> 2];
> +
> +    uint16_t miiregs[HME_MII_REGS_SIZE];
> +} SunHMEState;
> +
> +static Property sunhme_properties[] = {
> +    DEFINE_NIC_PROPERTIES(SunHMEState, conf),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void sunhme_reset_tx(SunHMEState *s)
> +{
> +    /* Indicate TX reset complete */
> +    s->sebregs[HME_SEBI_RESET] &= ~HME_SEB_RESET_ETX;
> +}
> +
> +static void sunhme_reset_rx(SunHMEState *s)
> +{
> +    /* Indicate RX reset complete */
> +    s->sebregs[HME_SEBI_RESET] &= ~HME_SEB_RESET_ERX;
> +}
> +
> +static void sunhme_update_irq(SunHMEState *s)
> +{
> +    PCIDevice *d = PCI_DEVICE(s);
> +    int level;
> +
> +    /* MIF interrupt mask (16-bit) */
> +    uint32_t mifmask = ~(s->mifregs[HME_MIFI_IMASK >> 2]) & 0xffff;
> +    uint32_t mif = s->mifregs[HME_MIFI_STAT >> 2] & mifmask;
> +
> +    /* Main SEB interrupt mask (include MIF status from above) */
> +    uint32_t sebmask = ~(s->sebregs[HME_SEBI_IMASK >> 2]) &
> +                       ~HME_SEB_STAT_MIFIRQ;
> +    uint32_t seb = s->sebregs[HME_SEBI_STAT >> 2] & sebmask;
> +    if (mif) {
> +        seb |= HME_SEB_STAT_MIFIRQ;
> +    }
> +
> +    level = (seb ? 1 : 0);
> +    pci_set_irq(d, level);
> +}
> +
> +static void sunhme_seb_write(void *opaque, hwaddr addr,
> +                          uint64_t val, unsigned size)
> +{
> +    SunHMEState *s = SUNHME(opaque);
> +
> +    trace_sunhme_seb_write(addr, val);
> +
> +    /* Handly buggy Linux drivers before 4.13 which have
> +       the wrong offsets for HME_SEBI_STAT and HME_SEBI_IMASK */
> +    switch (addr) {
> +    case HME_SEBI_STAT_LINUXBUG:
> +        addr = HME_SEBI_STAT;
> +        break;
> +    case HME_SEBI_IMASK_LINUXBUG:
> +        addr = HME_SEBI_IMASK;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    switch (addr) {
> +    case HME_SEBI_RESET:
> +        if (val & HME_SEB_RESET_ETX) {
> +            sunhme_reset_tx(s);
> +        }
> +        if (val & HME_SEB_RESET_ERX) {
> +            sunhme_reset_rx(s);
> +        }
> +        val = s->sebregs[HME_SEBI_RESET >> 2];
> +        break;
> +    }
> +
> +    s->sebregs[addr >> 2] = val;
> +}
> +
> +static uint64_t sunhme_seb_read(void *opaque, hwaddr addr,
> +                             unsigned size)
> +{
> +    SunHMEState *s = SUNHME(opaque);
> +    uint64_t val;
> +
> +    /* Handly buggy Linux drivers before 4.13 which have
> +       the wrong offsets for HME_SEBI_STAT and HME_SEBI_IMASK */
> +    switch (addr) {
> +    case HME_SEBI_STAT_LINUXBUG:
> +        addr = HME_SEBI_STAT;
> +        break;
> +    case HME_SEBI_IMASK_LINUXBUG:
> +        addr = HME_SEBI_IMASK;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    val = s->sebregs[addr >> 2];
> +
> +    switch (addr) {
> +    case HME_SEBI_STAT:
> +        /* Autoclear status (except MIF) */
> +        s->sebregs[HME_SEBI_STAT >> 2] &= HME_SEB_STAT_MIFIRQ;
> +        sunhme_update_irq(s);
> +        break;
> +    }
> +
> +    trace_sunhme_seb_read(addr, val);
> +
> +    return val;
> +}
> +
> +static const MemoryRegionOps sunhme_seb_ops = {
> +    .read = sunhme_seb_read,
> +    .write = sunhme_seb_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void sunhme_transmit(SunHMEState *s);
> +
> +static void sunhme_etx_write(void *opaque, hwaddr addr,
> +                          uint64_t val, unsigned size)
> +{
> +    SunHMEState *s = SUNHME(opaque);
> +
> +    trace_sunhme_etx_write(addr, val);
> +
> +    switch (addr) {
> +    case HME_ETXI_PENDING:
> +        if (val) {
> +            sunhme_transmit(s);
> +        }
> +        break;
> +    }
> +
> +    s->etxregs[addr >> 2] = val;
> +}
> +
> +static uint64_t sunhme_etx_read(void *opaque, hwaddr addr,
> +                             unsigned size)
> +{
> +    SunHMEState *s = SUNHME(opaque);
> +    uint64_t val;
> +
> +    val = s->etxregs[addr >> 2];
> +
> +    trace_sunhme_etx_read(addr, val);
> +
> +    return val;
> +}
> +
> +static const MemoryRegionOps sunhme_etx_ops = {
> +    .read = sunhme_etx_read,
> +    .write = sunhme_etx_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void sunhme_erx_write(void *opaque, hwaddr addr,
> +                          uint64_t val, unsigned size)
> +{
> +    SunHMEState *s = SUNHME(opaque);
> +
> +    trace_sunhme_erx_write(addr, val);
> +
> +    s->erxregs[addr >> 2] = val;
> +}
> +
> +static uint64_t sunhme_erx_read(void *opaque, hwaddr addr,
> +                             unsigned size)
> +{
> +    SunHMEState *s = SUNHME(opaque);
> +    uint64_t val;
> +
> +    val = s->erxregs[addr >> 2];
> +
> +    trace_sunhme_erx_read(addr, val);
> +
> +    return val;
> +}
> +
> +static const MemoryRegionOps sunhme_erx_ops = {
> +    .read = sunhme_erx_read,
> +    .write = sunhme_erx_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void sunhme_mac_write(void *opaque, hwaddr addr,
> +                          uint64_t val, unsigned size)
> +{
> +    SunHMEState *s = SUNHME(opaque);
> +
> +    trace_sunhme_mac_write(addr, val);
> +
> +    s->macregs[addr >> 2] = val;
> +}
> +
> +static uint64_t sunhme_mac_read(void *opaque, hwaddr addr,
> +                             unsigned size)
> +{
> +    SunHMEState *s = SUNHME(opaque);
> +    uint64_t val;
> +
> +    val = s->macregs[addr >> 2];
> +
> +    trace_sunhme_mac_read(addr, val);
> +
> +    return val;
> +}
> +
> +static const MemoryRegionOps sunhme_mac_ops = {
> +    .read = sunhme_mac_read,
> +    .write = sunhme_mac_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void sunhme_mii_write(SunHMEState *s, uint8_t reg, uint16_t data)
> +{
> +    trace_sunhme_mii_write(reg, data);
> +
> +    switch (reg) {
> +    case MII_BMCR:
> +        if (data & MII_BMCR_RESET) {
> +            /* Autoclear reset bit, enable auto negotiation */
> +            data &= ~MII_BMCR_RESET;
> +            data |= MII_BMCR_AUTOEN;
> +        }
> +        if (data & MII_BMCR_ANRESTART) {
> +            /* Autoclear auto negotiation restart */
> +            data &= ~MII_BMCR_ANRESTART;
> +
> +            /* Indicate negotiation complete */
> +            s->miiregs[MII_BMSR] |= MII_BMSR_AN_COMP;
> +
> +            if (!qemu_get_queue(s->nic)->link_down) {
> +                s->miiregs[MII_ANLPAR] |= MII_ANLPAR_TXFD;
> +                s->miiregs[MII_BMSR] |= MII_BMSR_LINK_ST;
> +            }
> +        }
> +        break;
> +    }
> +
> +    s->miiregs[reg] = data;
> +}
> +
> +static uint16_t sunhme_mii_read(SunHMEState *s, uint8_t reg)
> +{
> +    uint16_t data = s->miiregs[reg];
> +
> +    trace_sunhme_mii_read(reg, data);
> +
> +    return data;
> +}
> +
> +static void sunhme_mif_write(void *opaque, hwaddr addr,
> +                          uint64_t val, unsigned size)
> +{
> +    SunHMEState *s = SUNHME(opaque);
> +    uint8_t cmd, reg;
> +    uint16_t data;
> +
> +    trace_sunhme_mif_write(addr, val);
> +
> +    switch (addr) {
> +    case HME_MIFI_CFG:
> +        /* Mask the read-only bits */
> +        val &= ~(HME_MIF_CFG_MDI0 | HME_MIF_CFG_MDI1);
> +        val |= s->mifregs[HME_MIFI_CFG >> 2] &
> +               (HME_MIF_CFG_MDI0 | HME_MIF_CFG_MDI1);
> +        break;
> +    case HME_MIFI_FO:
> +        /* Detect start of MII command */
> +        if ((val & HME_MIF_FO_ST) >> HME_MIF_FO_ST_SHIFT
> +                != MII_COMMAND_START) {
> +            val |= HME_MIF_FO_TALSB;
> +            break;
> +        }
> +
> +        /* Internal phy only */
> +        if ((val & HME_MIF_FO_PHYAD) >> HME_MIF_FO_PHYAD_SHIFT
> +                != HME_PHYAD_INTERNAL) {
> +            val |= HME_MIF_FO_TALSB;
> +            break;
> +        }
> +
> +        cmd = (val & HME_MIF_FO_OPC) >> HME_MIF_FO_OPC_SHIFT;
> +        reg = (val & HME_MIF_FO_REGAD) >> HME_MIF_FO_REGAD_SHIFT;
> +        data = (val & HME_MIF_FO_DATA);
> +
> +        switch (cmd) {
> +        case MII_COMMAND_WRITE:
> +            sunhme_mii_write(s, reg, data);
> +            break;
> +
> +        case MII_COMMAND_READ:
> +            val &= ~HME_MIF_FO_DATA;
> +            val |= sunhme_mii_read(s, reg);
> +            break;
> +        }
> +
> +        val |= HME_MIF_FO_TALSB;
> +        break;
> +    }
> +
> +    s->mifregs[addr >> 2] = val;
> +}
> +
> +static uint64_t sunhme_mif_read(void *opaque, hwaddr addr,
> +                             unsigned size)
> +{
> +    SunHMEState *s = SUNHME(opaque);
> +    uint64_t val;
> +
> +    val = s->mifregs[addr >> 2];
> +
> +    switch (addr) {
> +    case HME_MIFI_STAT:
> +        /* Autoclear MIF interrupt status */
> +        s->mifregs[HME_MIFI_STAT >> 2] = 0;
> +        sunhme_update_irq(s);
> +        break;
> +    }
> +
> +    trace_sunhme_mif_read(addr, val);
> +
> +    return val;
> +}
> +
> +static const MemoryRegionOps sunhme_mif_ops = {
> +    .read = sunhme_mif_read,
> +    .write = sunhme_mif_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void sunhme_transmit_frame(SunHMEState *s, uint8_t *buf, int size)
> +{
> +    qemu_send_packet(qemu_get_queue(s->nic), buf, size);
> +}
> +
> +static inline int sunhme_get_tx_ring_count(SunHMEState *s)
> +{
> +    return (s->etxregs[HME_ETXI_RSIZE >> 2] + 1) << 4;
> +}
> +
> +static inline int sunhme_get_tx_ring_nr(SunHMEState *s)
> +{
> +    return s->etxregs[HME_ETXI_RING >> 2] & HME_ETXI_RING_OFFSET;
> +}
> +
> +static inline void sunhme_set_tx_ring_nr(SunHMEState *s, int i)
> +{
> +    uint32_t ring = s->etxregs[HME_ETXI_RING >> 2] & ~HME_ETXI_RING_OFFSET;
> +    ring |= i & HME_ETXI_RING_OFFSET;
> +
> +    s->etxregs[HME_ETXI_RING >> 2] = ring;
> +}
> +
> +static void sunhme_transmit(SunHMEState *s)
> +{
> +    PCIDevice *d = PCI_DEVICE(s);
> +    dma_addr_t tb, addr;
> +    uint32_t intstatus, status, buffer, sum = 0;
> +    int cr, nr, len, xmit_pos, csum_offset = 0, csum_stuff_offset = 0;
> +    uint16_t csum = 0;
> +    uint8_t xmit_buffer[HME_FIFO_SIZE];
> +
> +    tb = s->etxregs[HME_ETXI_RING >> 2] & HME_ETXI_RING_ADDR;
> +    nr = sunhme_get_tx_ring_count(s);
> +    cr = sunhme_get_tx_ring_nr(s);
> +
> +    pci_dma_read(d, tb + cr * HME_DESC_SIZE, &status, 4);
> +    pci_dma_read(d, tb + cr * HME_DESC_SIZE + 4, &buffer, 4);
> +
> +    xmit_pos = 0;
> +    while (status & HME_XD_OWN) {
> +        trace_sunhme_tx_desc(buffer, status, cr, nr);
> +
> +        /* Copy data into transmit buffer */
> +        addr = buffer;
> +        len = status & HME_XD_TXLENMSK;
> +
> +        if (xmit_pos + len > HME_FIFO_SIZE) {
> +            len = HME_FIFO_SIZE - xmit_pos;
> +        }
> +
> +        pci_dma_read(d, addr, &xmit_buffer[xmit_pos], len);
> +        xmit_pos += len;
> +
> +        /* Detect start of packet for TX checksum */
> +        if (status & HME_XD_SOP) {
> +            sum = 0;
> +            csum_offset = (status & HME_XD_TXCSSTART) >> HME_XD_TXCSSTARTSHIFT;
> +            csum_stuff_offset = (status & HME_XD_TXCSSTUFF) >>
> +                                HME_XD_TXCSSTUFFSHIFT;
> +        }
> +
> +        if (status & HME_XD_TXCKSUM) {
> +            /* Only start calculation from csum_offset */
> +            if (xmit_pos - len <= csum_offset && xmit_pos > csum_offset) {
> +                sum += net_checksum_add(xmit_pos - csum_offset,
> +                                        xmit_buffer + csum_offset);
> +                trace_sunhme_tx_xsum_add(csum_offset, xmit_pos - csum_offset);
> +            } else {
> +                sum += net_checksum_add(len, xmit_buffer + xmit_pos - len);
> +                trace_sunhme_tx_xsum_add(xmit_pos - len, len);
> +            }
> +        }
> +
> +        /* Detect end of packet for TX checksum */
> +        if (status & HME_XD_EOP) {
> +            /* Stuff the checksum if required */
> +            if (status & HME_XD_TXCKSUM) {
> +                csum = net_checksum_finish(sum);
> +                stw_be_p(xmit_buffer + csum_stuff_offset, csum);
> +                trace_sunhme_tx_xsum_stuff(csum, csum_stuff_offset);
> +            }
> +
> +            if (s->macregs[HME_MACI_TXCFG >> 2] & HME_MAC_TXCFG_ENABLE) {
> +                sunhme_transmit_frame(s, xmit_buffer, xmit_pos);
> +                trace_sunhme_tx_done(xmit_pos);
> +            }
> +        }
> +
> +        /* Update status */
> +        status &= ~HME_XD_OWN;
> +        pci_dma_write(d, tb + cr * HME_DESC_SIZE, &status, 4);
> +
> +        /* Move onto next descriptor */
> +        cr++;
> +        if (cr >= nr) {
> +            cr = 0;
> +        }
> +        sunhme_set_tx_ring_nr(s, cr);
> +
> +        pci_dma_read(d, tb + cr * HME_DESC_SIZE, &status, 4);
> +        pci_dma_read(d, tb + cr * HME_DESC_SIZE + 4, &buffer, 4);
> +
> +        /* Indicate TX complete */
> +        intstatus = s->sebregs[HME_SEBI_STAT >> 2];
> +        intstatus |= HME_SEB_STAT_HOSTTOTX;
> +        s->sebregs[HME_SEBI_STAT >> 2] = intstatus;
> +
> +        /* Autoclear TX pending */
> +        s->etxregs[HME_ETXI_PENDING >> 2] = 0;
> +
> +        sunhme_update_irq(s);
> +    }
> +
> +    /* TX FIFO now clear */
> +    intstatus = s->sebregs[HME_SEBI_STAT >> 2];
> +    intstatus |= HME_SEB_STAT_TXALL;
> +    s->sebregs[HME_SEBI_STAT >> 2] = intstatus;
> +    sunhme_update_irq(s);
> +}
> +
> +static int sunhme_can_receive(NetClientState *nc)
> +{
> +    SunHMEState *s = qemu_get_nic_opaque(nc);
> +
> +    return s->macregs[HME_MAC_RXCFG_ENABLE >> 2] & HME_MAC_RXCFG_ENABLE;
> +}
> +
> +static void sunhme_link_status_changed(NetClientState *nc)
> +{
> +    SunHMEState *s = qemu_get_nic_opaque(nc);
> +
> +    if (nc->link_down) {
> +        s->miiregs[MII_ANLPAR] &= ~MII_ANLPAR_TXFD;
> +        s->miiregs[MII_BMSR] &= ~MII_BMSR_LINK_ST;
> +    } else {
> +        s->miiregs[MII_ANLPAR] |= MII_ANLPAR_TXFD;
> +        s->miiregs[MII_BMSR] |= MII_BMSR_LINK_ST;
> +    }
> +
> +    /* Exact bits unknown */
> +    s->mifregs[HME_MIFI_STAT >> 2] = 0xffff;
> +    sunhme_update_irq(s);
> +}
> +
> +static inline int sunhme_get_rx_ring_count(SunHMEState *s)
> +{
> +    uint32_t rings = (s->erxregs[HME_ERXI_CFG >> 2] & HME_ERX_CFG_RINGSIZE)
> +                      >> HME_ERX_CFG_RINGSIZE_SHIFT;
> +
> +    switch (rings) {
> +    case 0:
> +        return 32;
> +    case 1:
> +        return 64;
> +    case 2:
> +        return 128;
> +    case 3:
> +        return 256;
> +    }
> +
> +    return 0;
> +}
> +
> +static inline int sunhme_get_rx_ring_nr(SunHMEState *s)
> +{
> +    return s->erxregs[HME_ERXI_RING >> 2] & HME_ERXI_RING_OFFSET;
> +}
> +
> +static inline void sunhme_set_rx_ring_nr(SunHMEState *s, int i)
> +{
> +    uint32_t ring = s->erxregs[HME_ERXI_RING >> 2] & ~HME_ERXI_RING_OFFSET;
> +    ring |= i & HME_ERXI_RING_OFFSET;
> +
> +    s->erxregs[HME_ERXI_RING >> 2] = ring;
> +}
> +
> +#define POLYNOMIAL_LE 0xedb88320
> +static uint32_t sunhme_crc32_le(const uint8_t *p, int len)
> +{
> +    uint32_t crc;
> +    int carry, i, j;
> +    uint8_t b;
> +
> +    crc = 0xffffffff;
> +    for (i = 0; i < len; i++) {
> +        b = *p++;
> +        for (j = 0; j < 8; j++) {
> +            carry = (crc & 0x1) ^ (b & 0x01);
> +            crc >>= 1;
> +            b >>= 1;
> +            if (carry) {
> +                crc = crc ^ POLYNOMIAL_LE;
> +            }
> +        }
> +    }
> +
> +    return crc;
> +}
> +
> +#define MIN_BUF_SIZE 60
> +
> +static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
> +                              size_t size)
> +{
> +    SunHMEState *s = qemu_get_nic_opaque(nc);
> +    PCIDevice *d = PCI_DEVICE(s);
> +    dma_addr_t rb, addr;
> +    uint32_t intstatus, status, buffer, buffersize, sum;
> +    uint16_t csum;
> +    uint8_t buf1[60];
> +    int nr, cr, len, rxoffset, csum_offset;
> +
> +    trace_sunhme_rx_incoming(size);
> +
> +    /* Do nothing if MAC RX disabled */
> +    if (!(s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_ENABLE)) {
> +        return -1;
> +    }
> +
> +    trace_sunhme_rx_filter_destmac(buf[0], buf[1], buf[2],
> +                                   buf[3], buf[4], buf[5]);
> +
> +    /* Check destination MAC address */
> +    if (!(s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_PMISC)) {
> +        /* Try and match local MAC address */
> +        if (((s->macregs[HME_MACI_MACADDR0 >> 2] & 0xff00) >> 8) == buf[0] &&
> +             (s->macregs[HME_MACI_MACADDR0 >> 2] & 0xff) == buf[1] &&
> +            ((s->macregs[HME_MACI_MACADDR1 >> 2] & 0xff00) >> 8) == buf[2] &&
> +             (s->macregs[HME_MACI_MACADDR1 >> 2] & 0xff) == buf[3] &&
> +            ((s->macregs[HME_MACI_MACADDR2 >> 2] & 0xff00) >> 8) == buf[4] &&
> +             (s->macregs[HME_MACI_MACADDR2 >> 2] & 0xff) == buf[5]) {
> +            /* Matched local MAC address */
> +            trace_sunhme_rx_filter_local_match();
> +        } else if (buf[0] == 0xff && buf[1] == 0xff && buf[2] == 0xff &&
> +                   buf[3] == 0xff && buf[4] == 0xff && buf[5] == 0xff) {
> +            /* Matched broadcast address */
> +            trace_sunhme_rx_filter_bcast_match();
> +        } else if (s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_HENABLE) {
> +            /* Didn't match local address, check hash filter */
> +            int mcast_idx = sunhme_crc32_le(buf, 6) >> 26;
> +            if (!(s->macregs[(HME_MACI_HASHTAB0 >> 2) - (mcast_idx >> 4)] &
> +                    (1 << (mcast_idx & 0xf)))) {
> +                /* Didn't match hash filter */
> +                trace_sunhme_rx_filter_hash_nomatch();
> +                trace_sunhme_rx_filter_reject();
> +                return 0;
> +            } else {
> +                trace_sunhme_rx_filter_hash_match();
> +            }
> +        } else {
> +            /* Not for us */
> +            trace_sunhme_rx_filter_reject();
> +            return 0;
> +        }
> +    } else {
> +        trace_sunhme_rx_filter_promisc_match();
> +    }
> +
> +    trace_sunhme_rx_filter_accept();
> +
> +    /* If too small buffer, then expand it */
> +    if (size < MIN_BUF_SIZE) {
> +        memcpy(buf1, buf, size);
> +        memset(buf1 + size, 0, MIN_BUF_SIZE - size);
> +        buf = buf1;
> +        size = MIN_BUF_SIZE;
> +    }
> +
> +    rb = s->erxregs[HME_ERXI_RING >> 2] & HME_ERXI_RING_ADDR;
> +    nr = sunhme_get_rx_ring_count(s);
> +    cr = sunhme_get_rx_ring_nr(s);
> +
> +    pci_dma_read(d, rb + cr * HME_DESC_SIZE, &status, 4);
> +    pci_dma_read(d, rb + cr * HME_DESC_SIZE + 4, &buffer, 4);
> +
> +    rxoffset = (s->erxregs[HME_ERXI_CFG >> 2] & HME_ERX_CFG_BYTEOFFSET) >>
> +                HME_ERX_CFG_BYTEOFFSET_SHIFT;
> +
> +    addr = buffer + rxoffset;
> +    buffersize = (status & HME_XD_RXLENMSK) >> HME_XD_RXLENSHIFT;
> +
> +    /* Detect receive overflow */
> +    len = size;
> +    if (size > buffersize) {
> +        status |= HME_XD_OFL;
> +        len = buffersize;
> +    }
> +
> +    pci_dma_write(d, addr, buf, len);
> +
> +    trace_sunhme_rx_desc(buffer, rxoffset, status, len, cr, nr);
> +
> +    /* Calculate the receive checksum */
> +    csum_offset = (s->erxregs[HME_ERXI_CFG >> 2] & HME_ERX_CFG_CSUMSTART) >>
> +                  HME_ERX_CFG_CSUMSHIFT << 1;
> +    sum = 0;
> +    sum += net_checksum_add(len - csum_offset, (uint8_t *)buf + csum_offset);
> +    csum = net_checksum_finish(sum);
> +
> +    trace_sunhme_rx_xsum_calc(csum);
> +
> +    /* Update status */
> +    status &= ~HME_XD_OWN;
> +    status &= ~HME_XD_RXLENMSK;
> +    status |= len << HME_XD_RXLENSHIFT;
> +    status &= ~HME_XD_RXCKSUM;
> +    status |= csum;
> +
> +    pci_dma_write(d, rb + cr * HME_DESC_SIZE, &status, 4);
> +
> +    cr++;
> +    if (cr >= nr) {
> +        cr = 0;
> +    }
> +
> +    sunhme_set_rx_ring_nr(s, cr);
> +
> +    /* Indicate RX complete */
> +    intstatus = s->sebregs[HME_SEBI_STAT >> 2];
> +    intstatus |= HME_SEB_STAT_RXTOHOST;
> +    s->sebregs[HME_SEBI_STAT >> 2] = intstatus;
> +
> +    sunhme_update_irq(s);
> +
> +    return len;
> +}
> +
> +static NetClientInfo net_sunhme_info = {
> +    .type = NET_CLIENT_DRIVER_NIC,
> +    .size = sizeof(NICState),
> +    .can_receive = sunhme_can_receive,
> +    .receive = sunhme_receive,
> +    .link_status_changed = sunhme_link_status_changed,
> +};
> +
> +static void sunhme_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    SunHMEState *s = SUNHME(pci_dev);
> +    DeviceState *d = DEVICE(pci_dev);
> +    uint8_t *pci_conf;
> +
> +    pci_conf = pci_dev->config;
> +    pci_conf[PCI_INTERRUPT_PIN] = 1;    /* interrupt pin A */
> +
> +    memory_region_init(&s->hme, OBJECT(pci_dev), "sunhme", HME_REG_SIZE);
> +    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->hme);
> +
> +    memory_region_init_io(&s->sebreg, OBJECT(pci_dev), &sunhme_seb_ops, s,
> +                          "sunhme.seb", HME_SEB_REG_SIZE);
> +    memory_region_add_subregion(&s->hme, 0, &s->sebreg);
> +
> +    memory_region_init_io(&s->etxreg, OBJECT(pci_dev), &sunhme_etx_ops, s,
> +                          "sunhme.etx", HME_ETX_REG_SIZE);
> +    memory_region_add_subregion(&s->hme, 0x2000, &s->etxreg);
> +
> +    memory_region_init_io(&s->erxreg, OBJECT(pci_dev), &sunhme_erx_ops, s,
> +                          "sunhme.erx", HME_ERX_REG_SIZE);
> +    memory_region_add_subregion(&s->hme, 0x4000, &s->erxreg);
> +
> +    memory_region_init_io(&s->macreg, OBJECT(pci_dev), &sunhme_mac_ops, s,
> +                          "sunhme.mac", HME_MAC_REG_SIZE);
> +    memory_region_add_subregion(&s->hme, 0x6000, &s->macreg);
> +
> +    memory_region_init_io(&s->mifreg, OBJECT(pci_dev), &sunhme_mif_ops, s,
> +                          "sunhme.mif", HME_MIF_REG_SIZE);
> +    memory_region_add_subregion(&s->hme, 0x7000, &s->mifreg);
> +
> +    qemu_macaddr_default_if_unset(&s->conf.macaddr);
> +    s->nic = qemu_new_nic(&net_sunhme_info, &s->conf,
> +                          object_get_typename(OBJECT(d)), d->id, s);
> +    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
> +}
> +
> +static void sunhme_instance_init(Object *obj)
> +{
> +    SunHMEState *s = SUNHME(obj);
> +
> +    device_add_bootindex_property(obj, &s->conf.bootindex,
> +                                  "bootindex", "/ethernet-phy@0",
> +                                  DEVICE(obj), NULL);
> +}
> +
> +static void sunhme_reset(DeviceState *ds)
> +{
> +    SunHMEState *s = SUNHME(ds);
> +
> +    /* Configure internal transceiver */
> +    s->mifregs[HME_MIFI_CFG >> 2] |= HME_MIF_CFG_MDI0;
> +
> +    /* Advetise auto, 100Mbps FD */
> +    s->miiregs[MII_ANAR] = MII_ANAR_TXFD;
> +    s->miiregs[MII_BMSR] = MII_BMSR_AUTONEG | MII_BMSR_100TX_FD |
> +                           MII_BMSR_AN_COMP;
> +
> +    if (!qemu_get_queue(s->nic)->link_down) {
> +        s->miiregs[MII_ANLPAR] |= MII_ANLPAR_TXFD;
> +        s->miiregs[MII_BMSR] |= MII_BMSR_LINK_ST;
> +    }
> +
> +    /* Set manufacturer */
> +    s->miiregs[MII_PHYID1] = DP83840_PHYID1;
> +    s->miiregs[MII_PHYID2] = DP83840_PHYID2;
> +
> +    /* Configure default interrupt mask */
> +    s->mifregs[HME_MIFI_IMASK >> 2] = 0xffff;
> +    s->sebregs[HME_SEBI_IMASK >> 2] = 0xff7fffff;
> +}
> +
> +static const VMStateDescription vmstate_hme = {
> +    .name = "sunhme",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(parent_obj, SunHMEState),
> +        VMSTATE_MACADDR(conf.macaddr, SunHMEState),
> +        VMSTATE_UINT32_ARRAY(sebregs, SunHMEState, (HME_SEB_REG_SIZE >> 2)),
> +        VMSTATE_UINT32_ARRAY(etxregs, SunHMEState, (HME_ETX_REG_SIZE >> 2)),
> +        VMSTATE_UINT32_ARRAY(erxregs, SunHMEState, (HME_ERX_REG_SIZE >> 2)),
> +        VMSTATE_UINT32_ARRAY(macregs, SunHMEState, (HME_MAC_REG_SIZE >> 2)),
> +        VMSTATE_UINT32_ARRAY(mifregs, SunHMEState, (HME_MIF_REG_SIZE >> 2)),
> +        VMSTATE_UINT16_ARRAY(miiregs, SunHMEState, HME_MII_REGS_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void sunhme_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->realize = sunhme_realize;
> +    k->vendor_id = PCI_VENDOR_ID_SUN;
> +    k->device_id = PCI_DEVICE_ID_SUN_HME;
> +    k->class_id = PCI_CLASS_NETWORK_ETHERNET;
> +    dc->vmsd = &vmstate_hme;
> +    dc->reset = sunhme_reset;
> +    dc->props = sunhme_properties;
> +    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> +}
> +
> +static const TypeInfo sunhme_info = {
> +    .name          = TYPE_SUNHME,
> +    .parent        = TYPE_PCI_DEVICE,
> +    .class_init    = sunhme_class_init,
> +    .instance_size = sizeof(SunHMEState),
> +    .instance_init = sunhme_instance_init,
> +};
> +
> +static void sunhme_register_types(void)
> +{
> +    type_register_static(&sunhme_info);
> +}
> +
> +type_init(sunhme_register_types)
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 27e5482..7328bb9 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -278,3 +278,32 @@ spapr_vlan_h_send_logical_lan(uint64_t reg, uint64_t continue_token) "H_SEND_LOG
>  spapr_vlan_h_send_logical_lan_rxbufs(uint32_t rx_bufs) "rxbufs = %"PRIu32
>  spapr_vlan_h_send_logical_lan_buf_desc(uint64_t buf) "   buf desc: 0x%"PRIx64
>  spapr_vlan_h_send_logical_lan_total(int nbufs, unsigned total_len) "%d buffers, total length 0x%x"
> +
> +# hw/net/sunhme.c
> +sunhme_seb_write(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%"PRIx64
> +sunhme_seb_read(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%"PRIx64
> +sunhme_etx_write(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%"PRIx64
> +sunhme_etx_read(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%"PRIx64
> +sunhme_erx_write(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%"PRIx64
> +sunhme_erx_read(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%"PRIx64
> +sunhme_mac_write(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%"PRIx64
> +sunhme_mac_read(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%"PRIx64
> +sunhme_mii_write(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%"PRIx64
> +sunhme_mii_read(uint8_t addr, uint16_t value) "addr 0x%x value 0x%x"
> +sunhme_mif_write(uint8_t addr, uint16_t value) "addr 0x%x value 0x%x"
> +sunhme_mif_read(uint64_t addr, uint64_t value) "addr 0x%"PRIx64" value 0x%"PRIx64
> +sunhme_tx_desc(uint64_t buffer, uint32_t status, int cr, int nr) "addr 0x%"PRIx64" status 0x%"PRIx32 " (ring %d/%d)"
> +sunhme_tx_xsum_add(int offset, int len) "adding xsum at offset %d, len %d"
> +sunhme_tx_xsum_stuff(uint16_t xsum, int offset) "stuffing xsum 0x%x at offset %d"
> +sunhme_tx_done(int len) "successfully transmitted frame with len %d"
> +sunhme_rx_incoming(size_t len) "received incoming frame with len %zu"
> +sunhme_rx_filter_destmac(uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "received frame for MAC: %02x:%02x:%02x:%02x:%02x:%02x"
> +sunhme_rx_filter_local_match(void) "incoming frame matches local MAC address"
> +sunhme_rx_filter_bcast_match(void) "incoming frame matches broadcast MAC address"
> +sunhme_rx_filter_hash_nomatch(void) "incoming MAC address not in hash table"
> +sunhme_rx_filter_hash_match(void) "incoming MAC address found in hash table"
> +sunhme_rx_filter_promisc_match(void) "incoming frame accepted due to promiscuous mode"
> +sunhme_rx_filter_reject(void) "rejecting incoming frame"
> +sunhme_rx_filter_accept(void) "accepting incoming frame"
> +sunhme_rx_desc(uint32_t addr, int offset, uint32_t status, int len, int cr, int nr) "addr 0x%"PRIx32"(+0x%x) status 0x%"PRIx32 " len %d (ring %d/%d)"
> +sunhme_rx_xsum_calc(uint16_t xsum) "calculated incoming xsum as 0x%x"
> diff --git a/include/hw/net/mii.h b/include/hw/net/mii.h
> index 6ce48a6..4ae4dcc 100644
> --- a/include/hw/net/mii.h
> +++ b/include/hw/net/mii.h
> @@ -104,6 +104,10 @@
>  #define RTL8211E_PHYID1     0x001c
>  #define RTL8211E_PHYID2     0xc915
>
> +/* National Semiconductor DP83840 */
> +#define DP83840_PHYID1      0x2000
> +#define DP83840_PHYID2      0x5c01
> +
>  /* National Semiconductor DP83848 */
>  #define DP83848_PHYID1      0x2000
>  #define DP83848_PHYID2      0x5c90
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 3752ddc..7308e75 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -186,6 +186,7 @@
>
>  #define PCI_VENDOR_ID_SUN                0x108e
>  #define PCI_DEVICE_ID_SUN_EBUS           0x1000
> +#define PCI_DEVICE_ID_SUN_HME            0x1001
>  #define PCI_DEVICE_ID_SUN_SIMBA          0x5000
>  #define PCI_DEVICE_ID_SUN_SABRE          0xa000
>
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
 ,
