Received: from eggs.gnu.org ([2001:4830:134:3::10]:40844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cybGr-00024U-60
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cybGn-0000r3-EE
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:42:33 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:60267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cybGm-0000qk-Tq
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:42:29 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8E50C31531
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 11:42:27 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 13 Apr 2017 11:41:51 +0200
Message-Id: <1492076514-28821-3-git-send-email-clg@kaod.org>
In-Reply-To: <1492076514-28821-1-git-send-email-clg@kaod.org>
References: <1492076514-28821-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/5] net: add FTGMAC100 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The FTGMAC100 device is an Ethernet controller with DMA function that
can be found on Aspeed SoCs (which include NCSI).

It is fully compliant with IEEE 802.3 specification for 10/100 Mbps
Ethernet and IEEE 802.3z specification for 1000 Mbps Ethernet and
includes Reduced Media Independent Interface (RMII) and Reduced
Gigabit Media Independent Interface (RGMII) interfaces. It adopts an
AHB bus interface and integrates a link list DMA engine with direct
M-Bus accesses for transmitting and receiving packets. It has
independent TX/RX fifos, supports half and full duplex (1000 Mbps mode
only supports full duplex), flow control for full duplex and
backpressure for half duplex.

The FTGMAC100 also implements IP, TCP, UDP checksum offloads and
supports IEEE 802.1Q VLAN tag insertion and removal. It offers
high-priority transmit queue for QoS and CoS applications

This model is backed with a RealTek 8211E PHY which is the chip found
on the AST2500 EVB. It is complete enough to satisfy two different
Linux drivers and a U-Boot driver. Not supported features are :

 - IEEE 802.1Q VLAN
 - High Priority Transmit Queue
 - Wake-On-LAN functions

The code is based on the Coldfire Fast Ethernet Controller model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Tested on the palmetto, romulus, ast2500 evb machines.

 Changes since v1:
 - removed TODO comments and used LOG_UNIMP in the read/write ops
 - used camelcase for struct names and typedefs.=20
 - removed the useless struct definitions for ring descriptors and
   the alignment pragma  =20
 - introduced a frame buffer at the machine level to reduce stack
   usage in the tx path.
 - introduced symbolic constants for PHY values.
 - introduced rtl8211e PHY chip specific registers=20
 - removed qemu_set_irq() in reset path=20
 - checked for dma_memory_read() errors. Also for write but that was
   less important as the descriptor is first read so it should be
   valid for the write.
 - removed the irq state
 - removed the weird hack to catch a first valid descriptor.
 - fixed the read of the mac address=20

 default-configs/arm-softmmu.mak |    1 +
 hw/net/Makefile.objs            |    1 +
 hw/net/ftgmac100.c              | 1003 +++++++++++++++++++++++++++++++++=
++++++
 include/hw/net/ftgmac100.h      |   60 +++
 4 files changed, 1065 insertions(+)
 create mode 100644 hw/net/ftgmac100.c
 create mode 100644 include/hw/net/ftgmac100.h

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 15a53598d1c3..acc4c6c86297 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -30,6 +30,7 @@ CONFIG_LAN9118=3Dy
 CONFIG_SMC91C111=3Dy
 CONFIG_ALLWINNER_EMAC=3Dy
 CONFIG_IMX_FEC=3Dy
+CONFIG_FTGMAC100=3Dy
 CONFIG_DS1338=3Dy
 CONFIG_RX8900=3Dy
 CONFIG_PFLASH_CFI01=3Dy
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 6a95d92d37f8..5ddaffe63a46 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -26,6 +26,7 @@ common-obj-$(CONFIG_IMX_FEC) +=3D imx_fec.o
 common-obj-$(CONFIG_CADENCE) +=3D cadence_gem.o
 common-obj-$(CONFIG_STELLARIS_ENET) +=3D stellaris_enet.o
 common-obj-$(CONFIG_LANCE) +=3D lance.o
+common-obj-$(CONFIG_FTGMAC100) +=3D ftgmac100.o
=20
 obj-$(CONFIG_ETRAXFS) +=3D etraxfs_eth.o
 obj-$(CONFIG_COLDFIRE) +=3D mcf_fec.o
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
new file mode 100644
index 000000000000..fc309b3629fd
--- /dev/null
+++ b/hw/net/ftgmac100.c
@@ -0,0 +1,1003 @@
+/*
+ * Faraday FTGMAC100 Gigabit Ethernet
+ *
+ * Copyright (C) 2016-2017, IBM Corporation.
+ *
+ * Based on Coldfire Fast Ethernet Controller emulation.
+ *
+ * Copyright (c) 2007 CodeSourcery.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/net/ftgmac100.h"
+#include "sysemu/dma.h"
+#include "qemu/log.h"
+#include "net/checksum.h"
+#include "net/eth.h"
+#include "hw/net/mii.h"
+
+/* For crc32 */
+#include <zlib.h>
+
+/*
+ * FTGMAC100 registers
+ */
+#define FTGMAC100_ISR             0x00
+#define FTGMAC100_IER             0x04
+#define FTGMAC100_MAC_MADR        0x08
+#define FTGMAC100_MAC_LADR        0x0c
+#define FTGMAC100_MATH0           0x10
+#define FTGMAC100_MATH1           0x14
+#define FTGMAC100_NPTXPD          0x18
+#define FTGMAC100_RXPD            0x1C
+#define FTGMAC100_NPTXR_BADR      0x20
+#define FTGMAC100_RXR_BADR        0x24
+#define FTGMAC100_HPTXPD          0x28
+#define FTGMAC100_HPTXR_BADR      0x2c
+#define FTGMAC100_ITC             0x30
+#define FTGMAC100_APTC            0x34
+#define FTGMAC100_DBLAC           0x38
+#define FTGMAC100_REVR            0x40
+#define FTGMAC100_FEAR1           0x44
+#define FTGMAC100_RBSR            0x4c
+#define FTGMAC100_TPAFCR          0x48
+
+#define FTGMAC100_MACCR           0x50
+#define FTGMAC100_MACSR           0x54
+#define FTGMAC100_PHYCR           0x60
+#define FTGMAC100_PHYDATA         0x64
+#define FTGMAC100_FCR             0x68
+
+/*
+ * Interrupt status register & interrupt enable register
+ */
+#define FTGMAC100_INT_RPKT_BUF    (1 << 0)
+#define FTGMAC100_INT_RPKT_FIFO   (1 << 1)
+#define FTGMAC100_INT_NO_RXBUF    (1 << 2)
+#define FTGMAC100_INT_RPKT_LOST   (1 << 3)
+#define FTGMAC100_INT_XPKT_ETH    (1 << 4)
+#define FTGMAC100_INT_XPKT_FIFO   (1 << 5)
+#define FTGMAC100_INT_NO_NPTXBUF  (1 << 6)
+#define FTGMAC100_INT_XPKT_LOST   (1 << 7)
+#define FTGMAC100_INT_AHB_ERR     (1 << 8)
+#define FTGMAC100_INT_PHYSTS_CHG  (1 << 9)
+#define FTGMAC100_INT_NO_HPTXBUF  (1 << 10)
+
+/*
+ * Automatic polling timer control register
+ */
+#define FTGMAC100_APTC_RXPOLL_CNT(x)        ((x) & 0xf)
+#define FTGMAC100_APTC_RXPOLL_TIME_SEL      (1 << 4)
+#define FTGMAC100_APTC_TXPOLL_CNT(x)        (((x) >> 8) & 0xf)
+#define FTGMAC100_APTC_TXPOLL_TIME_SEL      (1 << 12)
+
+/*
+ * PHY control register
+ */
+#define FTGMAC100_PHYCR_MIIRD               (1 << 26)
+#define FTGMAC100_PHYCR_MIIWR               (1 << 27)
+
+#define FTGMAC100_PHYCR_DEV(x)              (((x) >> 16) & 0x1f)
+#define FTGMAC100_PHYCR_REG(x)              (((x) >> 21) & 0x1f)
+
+/*
+ * PHY data register
+ */
+#define FTGMAC100_PHYDATA_MIIWDATA(x)       ((x) & 0xffff)
+#define FTGMAC100_PHYDATA_MIIRDATA(x)       (((x) >> 16) & 0xffff)
+
+/*
+ * Feature Register
+ */
+#define FTGMAC100_REVR_NEW_MDIO_INTERFACE   (1 << 31)
+
+/*
+ * MAC control register
+ */
+#define FTGMAC100_MACCR_TXDMA_EN         (1 << 0)
+#define FTGMAC100_MACCR_RXDMA_EN         (1 << 1)
+#define FTGMAC100_MACCR_TXMAC_EN         (1 << 2)
+#define FTGMAC100_MACCR_RXMAC_EN         (1 << 3)
+#define FTGMAC100_MACCR_RM_VLAN          (1 << 4)
+#define FTGMAC100_MACCR_HPTXR_EN         (1 << 5)
+#define FTGMAC100_MACCR_LOOP_EN          (1 << 6)
+#define FTGMAC100_MACCR_ENRX_IN_HALFTX   (1 << 7)
+#define FTGMAC100_MACCR_FULLDUP          (1 << 8)
+#define FTGMAC100_MACCR_GIGA_MODE        (1 << 9)
+#define FTGMAC100_MACCR_CRC_APD          (1 << 10) /* not needed */
+#define FTGMAC100_MACCR_RX_RUNT          (1 << 12)
+#define FTGMAC100_MACCR_JUMBO_LF         (1 << 13)
+#define FTGMAC100_MACCR_RX_ALL           (1 << 14)
+#define FTGMAC100_MACCR_HT_MULTI_EN      (1 << 15)
+#define FTGMAC100_MACCR_RX_MULTIPKT      (1 << 16)
+#define FTGMAC100_MACCR_RX_BROADPKT      (1 << 17)
+#define FTGMAC100_MACCR_DISCARD_CRCERR   (1 << 18)
+#define FTGMAC100_MACCR_FAST_MODE        (1 << 19)
+#define FTGMAC100_MACCR_SW_RST           (1 << 31)
+
+/*
+ * Transmit descriptor
+ */
+#define FTGMAC100_TXDES0_TXBUF_SIZE(x)   ((x) & 0x3fff)
+#define FTGMAC100_TXDES0_EDOTR           (1 << 15)
+#define FTGMAC100_TXDES0_CRC_ERR         (1 << 19)
+#define FTGMAC100_TXDES0_LTS             (1 << 28)
+#define FTGMAC100_TXDES0_FTS             (1 << 29)
+#define FTGMAC100_TXDES0_TXDMA_OWN       (1 << 31)
+
+#define FTGMAC100_TXDES1_VLANTAG_CI(x)   ((x) & 0xffff)
+#define FTGMAC100_TXDES1_INS_VLANTAG     (1 << 16)
+#define FTGMAC100_TXDES1_TCP_CHKSUM      (1 << 17)
+#define FTGMAC100_TXDES1_UDP_CHKSUM      (1 << 18)
+#define FTGMAC100_TXDES1_IP_CHKSUM       (1 << 19)
+#define FTGMAC100_TXDES1_LLC             (1 << 22)
+#define FTGMAC100_TXDES1_TX2FIC          (1 << 30)
+#define FTGMAC100_TXDES1_TXIC            (1 << 31)
+
+/*
+ * Receive descriptor
+ */
+#define FTGMAC100_RXDES0_VDBC            0x3fff
+#define FTGMAC100_RXDES0_EDORR           (1 << 15)
+#define FTGMAC100_RXDES0_MULTICAST       (1 << 16)
+#define FTGMAC100_RXDES0_BROADCAST       (1 << 17)
+#define FTGMAC100_RXDES0_RX_ERR          (1 << 18)
+#define FTGMAC100_RXDES0_CRC_ERR         (1 << 19)
+#define FTGMAC100_RXDES0_FTL             (1 << 20)
+#define FTGMAC100_RXDES0_RUNT            (1 << 21)
+#define FTGMAC100_RXDES0_RX_ODD_NB       (1 << 22)
+#define FTGMAC100_RXDES0_FIFO_FULL       (1 << 23)
+#define FTGMAC100_RXDES0_PAUSE_OPCODE    (1 << 24)
+#define FTGMAC100_RXDES0_PAUSE_FRAME     (1 << 25)
+#define FTGMAC100_RXDES0_LRS             (1 << 28)
+#define FTGMAC100_RXDES0_FRS             (1 << 29)
+#define FTGMAC100_RXDES0_RXPKT_RDY       (1 << 31)
+
+#define FTGMAC100_RXDES1_VLANTAG_CI      0xffff
+#define FTGMAC100_RXDES1_PROT_MASK       (0x3 << 20)
+#define FTGMAC100_RXDES1_PROT_NONIP      (0x0 << 20)
+#define FTGMAC100_RXDES1_PROT_IP         (0x1 << 20)
+#define FTGMAC100_RXDES1_PROT_TCPIP      (0x2 << 20)
+#define FTGMAC100_RXDES1_PROT_UDPIP      (0x3 << 20)
+#define FTGMAC100_RXDES1_LLC             (1 << 22)
+#define FTGMAC100_RXDES1_DF              (1 << 23)
+#define FTGMAC100_RXDES1_VLANTAG_AVAIL   (1 << 24)
+#define FTGMAC100_RXDES1_TCP_CHKSUM_ERR  (1 << 25)
+#define FTGMAC100_RXDES1_UDP_CHKSUM_ERR  (1 << 26)
+#define FTGMAC100_RXDES1_IP_CHKSUM_ERR   (1 << 27)
+
+/*
+ * Receive and transmit Buffer Descriptor
+ */
+typedef struct {
+    uint32_t        des0;
+    uint32_t        des1;
+    uint32_t        des2;        /* not used by HW */
+    uint32_t        des3;
+} FTGMAC100Desc;
+
+/*
+ * Specific RTL8211E MII Registers
+ */
+#define RTL8211E_MII_PHYCR        16 /* PHY Specific Control */
+#define RTL8211E_MII_PHYSR        17 /* PHY Specific Status */
+#define RTL8211E_MII_INER         18 /* Interrupt Enable */
+#define RTL8211E_MII_INSR         19 /* Interrupt Status */
+#define RTL8211E_MII_RXERC        24 /* Receive Error Counter */
+#define RTL8211E_MII_LDPSR        27 /* Link Down Power Saving */
+#define RTL8211E_MII_EPAGSR       30 /* Extension Page Select */
+#define RTL8211E_MII_PAGSEL       31 /* Page Select */
+
+/*
+ * RTL8211E Interrupt Status
+ */
+#define PHY_INT_AUTONEG_ERROR       (1 << 15)
+#define PHY_INT_PAGE_RECV           (1 << 12)
+#define PHY_INT_AUTONEG_COMPLETE    (1 << 11)
+#define PHY_INT_LINK_STATUS         (1 << 10)
+#define PHY_INT_ERROR               (1 << 9)
+#define PHY_INT_DOWN                (1 << 8)
+#define PHY_INT_JABBER              (1 << 0)
+
+/*
+ * Max frame size for the receiving buffer
+ */
+#define FTGMAC100_MAX_FRAME_SIZE    10240
+
+/* Limits depending on the type of the frame
+ *
+ *   9216 for Jumbo frames (+ 4 for VLAN)
+ *   1518 for other frames (+ 4 for VLAN)
+ */
+static int ftgmac100_max_frame_size(FTGMAC100State *s)
+{
+    return (s->maccr & FTGMAC100_MACCR_JUMBO_LF ? 9216 : 1518) + 4;
+}
+
+static void ftgmac100_update_irq(FTGMAC100State *s)
+{
+    qemu_set_irq(s->irq, s->isr & s->ier);
+}
+
+/*
+ * The MII phy could raise a GPIO to the processor which in turn
+ * could be handled as an interrpt by the OS.
+ * For now we don't handle any GPIO/interrupt line, so the OS will
+ * have to poll for the PHY status.
+ */
+static void phy_update_irq(FTGMAC100State *s)
+{
+    ftgmac100_update_irq(s);
+}
+
+static void phy_update_link(FTGMAC100State *s)
+{
+    /* Autonegotiation status mirrors link status.  */
+    if (qemu_get_queue(s->nic)->link_down) {
+        s->phy_status &=3D ~(MII_BMSR_LINK_ST | MII_BMSR_AN_COMP);
+        s->phy_int |=3D PHY_INT_DOWN;
+    } else {
+        s->phy_status |=3D (MII_BMSR_LINK_ST | MII_BMSR_AN_COMP);
+        s->phy_int |=3D PHY_INT_AUTONEG_COMPLETE;
+    }
+    phy_update_irq(s);
+}
+
+static void ftgmac100_set_link(NetClientState *nc)
+{
+    phy_update_link(FTGMAC100(qemu_get_nic_opaque(nc)));
+}
+
+static void phy_reset(FTGMAC100State *s)
+{
+    s->phy_status =3D (MII_BMSR_100TX_FD | MII_BMSR_100TX_HD | MII_BMSR_=
10T_FD |
+                     MII_BMSR_10T_HD | MII_BMSR_EXTSTAT | MII_BMSR_MFPS =
|
+                     MII_BMSR_AN_COMP | MII_BMSR_AUTONEG | MII_BMSR_LINK=
_ST |
+                     MII_BMSR_EXTCAP);
+    s->phy_control =3D (MII_BMCR_AUTOEN | MII_BMCR_FD | MII_BMCR_SPEED10=
00);
+    s->phy_advertise =3D (MII_ANAR_PAUSE_ASYM | MII_ANAR_PAUSE | MII_ANA=
R_TXFD |
+                        MII_ANAR_TX | MII_ANAR_10FD | MII_ANAR_10 |
+                        MII_ANAR_CSMACD);
+    s->phy_int_mask =3D 0;
+    s->phy_int =3D 0;
+}
+
+static uint32_t do_phy_read(FTGMAC100State *s, int reg)
+{
+    uint32_t val;
+
+    switch (reg) {
+    case MII_BMCR: /* Basic Control */
+        val =3D s->phy_control;
+        break;
+    case MII_BMSR: /* Basic Status */
+        val =3D s->phy_status;
+        break;
+    case MII_PHYID1: /* ID1 */
+        val =3D RTL8211E_PHYID1;
+        break;
+    case MII_PHYID2: /* ID2 */
+        val =3D RTL8211E_PHYID2;
+        break;
+    case MII_ANAR: /* Auto-neg advertisement */
+        val =3D s->phy_advertise;
+        break;
+    case MII_ANLPAR: /* Auto-neg Link Partner Ability */
+        val =3D (MII_ANLPAR_ACK | MII_ANLPAR_PAUSE | MII_ANLPAR_TXFD |
+               MII_ANLPAR_TX | MII_ANLPAR_10FD | MII_ANLPAR_10 |
+               MII_ANLPAR_CSMACD);
+        break;
+    case MII_ANER: /* Auto-neg Expansion */
+        val =3D MII_ANER_NWAY;
+        break;
+    case MII_CTRL1000: /* 1000BASE-T control  */
+        val =3D (MII_CTRL1000_HALF | MII_CTRL1000_FULL);
+        break;
+    case MII_STAT1000: /* 1000BASE-T status  */
+        val =3D MII_STAT1000_FULL;
+        break;
+    case RTL8211E_MII_INSR:  /* Interrupt status.  */
+        val =3D s->phy_int;
+        s->phy_int =3D 0;
+        phy_update_irq(s);
+        break;
+    case RTL8211E_MII_INER:  /* Interrupt enable */
+        val =3D s->phy_int_mask;
+        break;
+    case RTL8211E_MII_PHYCR:
+    case RTL8211E_MII_PHYSR:
+    case RTL8211E_MII_RXERC:
+    case RTL8211E_MII_LDPSR:
+    case RTL8211E_MII_EPAGSR:
+    case RTL8211E_MII_PAGSEL:
+        qemu_log_mask(LOG_UNIMP, "%s: reg %d not implemented\n",
+                      __func__, reg);
+        val =3D 0;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset %d\n",
+                      __func__, reg);
+        val =3D 0;
+        break;
+    }
+
+    return val;
+}
+
+#define MII_BMCR_MASK (MII_BMCR_LOOPBACK | MII_BMCR_SPEED100 |          =
\
+                       MII_BMCR_SPEED | MII_BMCR_AUTOEN | MII_BMCR_PDOWN=
 | \
+                       MII_BMCR_FD | MII_BMCR_CTST)
+#define MII_ANAR_MASK 0x2d7f
+
+static void do_phy_write(FTGMAC100State *s, int reg, uint32_t val)
+{
+    switch (reg) {
+    case MII_BMCR:     /* Basic Control */
+        if (val & MII_BMCR_RESET) {
+            phy_reset(s);
+        } else {
+            s->phy_control =3D val & MII_BMCR_MASK;
+            /* Complete autonegotiation immediately.  */
+            if (val & MII_BMCR_AUTOEN) {
+                s->phy_status |=3D MII_BMSR_AN_COMP;
+            }
+        }
+        break;
+    case MII_ANAR:     /* Auto-neg advertisement */
+        s->phy_advertise =3D (val & MII_ANAR_MASK) | MII_ANAR_TX;
+        break;
+    case RTL8211E_MII_INER: /* Interrupt enable */
+        s->phy_int_mask =3D val & 0xff;
+        phy_update_irq(s);
+        break;
+    case RTL8211E_MII_PHYCR:
+    case RTL8211E_MII_PHYSR:
+    case RTL8211E_MII_RXERC:
+    case RTL8211E_MII_LDPSR:
+    case RTL8211E_MII_EPAGSR:
+    case RTL8211E_MII_PAGSEL:
+        qemu_log_mask(LOG_UNIMP, "%s: reg %d not implemented\n",
+                      __func__, reg);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset %d\n",
+                      __func__, reg);
+        break;
+    }
+}
+
+static int ftgmac100_read_bd(FTGMAC100Desc *bd, dma_addr_t addr)
+{
+    if (dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read descriptor @ =
0x%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        return -1;
+    }
+    bd->des0 =3D le32_to_cpu(bd->des0);
+    bd->des1 =3D le32_to_cpu(bd->des1);
+    bd->des2 =3D le32_to_cpu(bd->des2);
+    bd->des3 =3D le32_to_cpu(bd->des3);
+    return 0;
+}
+
+static int ftgmac100_write_bd(FTGMAC100Desc *bd, dma_addr_t addr)
+{
+    FTGMAC100Desc lebd;
+
+    lebd.des0 =3D cpu_to_le32(bd->des0);
+    lebd.des1 =3D cpu_to_le32(bd->des1);
+    lebd.des2 =3D cpu_to_le32(bd->des2);
+    lebd.des3 =3D cpu_to_le32(bd->des3);
+    if (dma_memory_write(&address_space_memory, addr, &lebd, sizeof(lebd=
))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to write descriptor @=
 0x%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        return -1;
+    }
+    return 0;
+}
+
+static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
+                            uint32_t tx_descriptor)
+{
+    int frame_size =3D 0;
+    uint8_t *ptr =3D s->frame;
+    uint32_t addr =3D tx_descriptor;
+    uint32_t flags =3D 0;
+    int max_frame_size =3D ftgmac100_max_frame_size(s);
+
+    while (1) {
+        FTGMAC100Desc bd;
+        int len;
+
+        if (ftgmac100_read_bd(&bd, addr) ||
+            ((bd.des0 & FTGMAC100_TXDES0_TXDMA_OWN) =3D=3D 0)) {
+            /* Run out of descriptors to transmit.  */
+            s->isr |=3D FTGMAC100_INT_NO_NPTXBUF;
+            break;
+        }
+
+        /* record transmit flags as they are valid only on the first
+         * segment */
+        if (bd.des0 & FTGMAC100_TXDES0_FTS) {
+            flags =3D bd.des1;
+        }
+
+        len =3D bd.des0 & 0x3FFF;
+        if (frame_size + len > max_frame_size) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %d bytes=
\n",
+                          __func__, len);
+            len =3D max_frame_size - frame_size;
+        }
+
+        if (dma_memory_read(&address_space_memory, bd.des3, ptr, len)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read packet @ =
0x%x\n",
+                          __func__, bd.des3);
+            s->isr |=3D FTGMAC100_INT_NO_NPTXBUF;
+            break;
+        }
+
+        ptr +=3D len;
+        frame_size +=3D len;
+        if (bd.des0 & FTGMAC100_TXDES0_LTS) {
+            if (flags & FTGMAC100_TXDES1_IP_CHKSUM) {
+                net_checksum_calculate(s->frame, frame_size);
+            }
+            /* Last buffer in frame.  */
+            qemu_send_packet(qemu_get_queue(s->nic), s->frame, frame_siz=
e);
+            ptr =3D s->frame;
+            frame_size =3D 0;
+            if (flags & FTGMAC100_TXDES1_TXIC) {
+                s->isr |=3D FTGMAC100_INT_XPKT_ETH;
+            }
+        }
+
+        if (flags & FTGMAC100_TXDES1_TX2FIC) {
+            s->isr |=3D FTGMAC100_INT_XPKT_FIFO;
+        }
+        bd.des0 &=3D ~FTGMAC100_TXDES0_TXDMA_OWN;
+
+        /* Write back the modified descriptor.  */
+        ftgmac100_write_bd(&bd, addr);
+        /* Advance to the next descriptor.  */
+        if (bd.des0 & FTGMAC100_TXDES0_EDOTR) {
+            addr =3D tx_ring;
+        } else {
+            addr +=3D sizeof(FTGMAC100Desc);
+        }
+    }
+
+    s->tx_descriptor =3D addr;
+
+    ftgmac100_update_irq(s);
+}
+
+static int ftgmac100_can_receive(NetClientState *nc)
+{
+    FTGMAC100State *s =3D FTGMAC100(qemu_get_nic_opaque(nc));
+    FTGMAC100Desc bd;
+
+    if ((s->maccr & (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN=
))
+         !=3D (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN)) {
+        return 0;
+    }
+
+    if (ftgmac100_read_bd(&bd, s->rx_descriptor)) {
+        return 0;
+    }
+    return !(bd.des0 & FTGMAC100_RXDES0_RXPKT_RDY);
+}
+
+/*
+ * This is purely informative. The HW can poll the RW (and RX) ring
+ * buffers for available descriptors but we don't need to trigger a
+ * timer for that in qemu.
+ */
+static uint32_t ftgmac100_rxpoll(FTGMAC100State *s)
+{
+    /* Polling times :
+     *
+     * Speed      TIME_SEL=3D0    TIME_SEL=3D1
+     *
+     *    10         51.2 ms      819.2 ms
+     *   100         5.12 ms      81.92 ms
+     *  1000        1.024 ms     16.384 ms
+     */
+    static const int div[] =3D { 20, 200, 1000 };
+
+    uint32_t cnt =3D 1024 * FTGMAC100_APTC_RXPOLL_CNT(s->aptcr);
+    uint32_t speed =3D (s->maccr & FTGMAC100_MACCR_FAST_MODE) ? 1 : 0;
+    uint32_t period;
+
+    if (s->aptcr & FTGMAC100_APTC_RXPOLL_TIME_SEL) {
+        cnt <<=3D 4;
+    }
+
+    if (s->maccr & FTGMAC100_MACCR_GIGA_MODE) {
+        speed =3D 2;
+    }
+
+    period =3D cnt / div[speed];
+
+    return period;
+}
+
+static void ftgmac100_reset(DeviceState *d)
+{
+    FTGMAC100State *s =3D FTGMAC100(d);
+
+    /* Reset the FTGMAC100 */
+    s->isr =3D 0;
+    s->ier =3D 0;
+    s->rx_enabled =3D 0;
+    s->rx_ring =3D 0;
+    s->rbsr =3D 0x640;
+    s->rx_descriptor =3D 0;
+    s->tx_ring =3D 0;
+    s->tx_descriptor =3D 0;
+    s->math[0] =3D 0;
+    s->math[1] =3D 0;
+    s->itc =3D 0;
+    s->aptcr =3D 1;
+    s->dblac =3D 0x00022f00;
+    s->revr =3D 0;
+    s->fear1 =3D 0;
+    s->tpafcr =3D 0xf1;
+
+    s->maccr =3D 0;
+    s->phycr =3D 0;
+    s->phydata =3D 0;
+    s->fcr =3D 0x400;
+
+    /* and the PHY */
+    phy_reset(s);
+}
+
+static uint64_t ftgmac100_read(void *opaque, hwaddr addr, unsigned size)
+{
+    FTGMAC100State *s =3D FTGMAC100(opaque);
+
+    switch (addr & 0xff) {
+    case FTGMAC100_ISR:
+        return s->isr;
+    case FTGMAC100_IER:
+        return s->ier;
+    case FTGMAC100_MAC_MADR:
+        return (s->conf.macaddr.a[0] << 8)  | s->conf.macaddr.a[1];
+    case FTGMAC100_MAC_LADR:
+        return ((uint32_t) s->conf.macaddr.a[2] << 24) |
+            (s->conf.macaddr.a[3] << 16) | (s->conf.macaddr.a[4] << 8) |
+            s->conf.macaddr.a[5];
+    case FTGMAC100_MATH0:
+        return s->math[0];
+    case FTGMAC100_MATH1:
+        return s->math[1];
+    case FTGMAC100_ITC:
+        return s->itc;
+    case FTGMAC100_DBLAC:
+        return s->dblac;
+    case FTGMAC100_REVR:
+        return s->revr;
+    case FTGMAC100_FEAR1:
+        return s->fear1;
+    case FTGMAC100_TPAFCR:
+        return s->tpafcr;
+    case FTGMAC100_FCR:
+        return s->fcr;
+    case FTGMAC100_MACCR:
+        return s->maccr;
+    case FTGMAC100_PHYCR:
+        return s->phycr;
+    case FTGMAC100_PHYDATA:
+        return s->phydata;
+
+        /* We might want to support these one day */
+    case FTGMAC100_HPTXPD: /* High Priority Transmit Poll Demand */
+    case FTGMAC100_HPTXR_BADR: /* High Priority Transmit Ring Base Addre=
ss */
+    case FTGMAC100_MACSR: /* MAC Status Register (MACSR) */
+        qemu_log_mask(LOG_UNIMP, "%s: read to unimplemented register 0x%=
"
+                      HWADDR_PRIx "\n", __func__, addr);
+        return 0;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        return 0;
+    }
+}
+
+static void ftgmac100_write(void *opaque, hwaddr addr,
+                          uint64_t value, unsigned size)
+{
+    FTGMAC100State *s =3D FTGMAC100(opaque);
+    int reg;
+
+    switch (addr & 0xff) {
+    case FTGMAC100_ISR: /* Interrupt status */
+        s->isr &=3D ~value;
+        break;
+    case FTGMAC100_IER: /* Interrupt control */
+        s->ier =3D value;
+        break;
+    case FTGMAC100_MAC_MADR: /* MAC */
+        s->conf.macaddr.a[0] =3D value >> 8;
+        s->conf.macaddr.a[1] =3D value;
+        break;
+    case FTGMAC100_MAC_LADR:
+        s->conf.macaddr.a[2] =3D value >> 24;
+        s->conf.macaddr.a[3] =3D value >> 16;
+        s->conf.macaddr.a[4] =3D value >> 8;
+        s->conf.macaddr.a[5] =3D value;
+        break;
+    case FTGMAC100_MATH0: /* Multicast Address Hash Table 0 */
+        s->math[0] =3D value;
+        break;
+    case FTGMAC100_MATH1: /* Multicast Address Hash Table 1 */
+        s->math[1] =3D value;
+        break;
+    case FTGMAC100_ITC: /* TODO: Interrupt Timer Control */
+        s->itc =3D value;
+        break;
+    case FTGMAC100_RXR_BADR: /* Ring buffer address */
+        s->rx_ring =3D value;
+        s->rx_descriptor =3D s->rx_ring;
+        break;
+
+    case FTGMAC100_RBSR: /* DMA buffer size */
+        s->rbsr =3D value;
+        break;
+
+    case FTGMAC100_NPTXR_BADR: /* Transmit buffer address */
+        s->tx_ring =3D value;
+        s->tx_descriptor =3D s->tx_ring;
+        break;
+
+    case FTGMAC100_NPTXPD: /* Trigger transmit */
+        if ((s->maccr & (FTGMAC100_MACCR_TXDMA_EN | FTGMAC100_MACCR_TXMA=
C_EN))
+            =3D=3D (FTGMAC100_MACCR_TXDMA_EN | FTGMAC100_MACCR_TXMAC_EN)=
) {
+            /* TODO: high priority tx ring */
+            ftgmac100_do_tx(s, s->tx_ring, s->tx_descriptor);
+        }
+        if (ftgmac100_can_receive(qemu_get_queue(s->nic))) {
+            qemu_flush_queued_packets(qemu_get_queue(s->nic));
+        }
+        break;
+
+    case FTGMAC100_RXPD: /* Receive Poll Demand Register */
+        if (ftgmac100_can_receive(qemu_get_queue(s->nic))) {
+            qemu_flush_queued_packets(qemu_get_queue(s->nic));
+        }
+        break;
+
+    case FTGMAC100_APTC: /* Automatic polling */
+        s->aptcr =3D value;
+
+        if (FTGMAC100_APTC_RXPOLL_CNT(s->aptcr)) {
+            ftgmac100_rxpoll(s);
+        }
+
+        if (FTGMAC100_APTC_TXPOLL_CNT(s->aptcr)) {
+            qemu_log_mask(LOG_UNIMP, "%s: no transmit polling\n", __func=
__);
+        }
+        break;
+
+    case FTGMAC100_MACCR: /* MAC Device control */
+        s->maccr =3D value;
+        if (value & FTGMAC100_MACCR_SW_RST) {
+            ftgmac100_reset(DEVICE(s));
+        }
+
+        if (ftgmac100_can_receive(qemu_get_queue(s->nic))) {
+            qemu_flush_queued_packets(qemu_get_queue(s->nic));
+        }
+        break;
+
+    case FTGMAC100_PHYCR:  /* PHY Device control */
+        reg =3D FTGMAC100_PHYCR_REG(value);
+        s->phycr =3D value;
+        if (value & FTGMAC100_PHYCR_MIIWR) {
+            do_phy_write(s, reg, s->phydata & 0xffff);
+            s->phycr &=3D ~FTGMAC100_PHYCR_MIIWR;
+        } else {
+            s->phydata =3D do_phy_read(s, reg) << 16;
+            s->phycr &=3D ~FTGMAC100_PHYCR_MIIRD;
+        }
+        break;
+    case FTGMAC100_PHYDATA:
+        s->phydata =3D value & 0xffff;
+        break;
+    case FTGMAC100_DBLAC: /* DMA Burst Length and Arbitration Control */
+        s->dblac =3D value;
+        break;
+    case FTGMAC100_REVR:  /* Feature Register */
+        /* TODO: Only Old MDIO interface is supported */
+        s->revr =3D value & ~FTGMAC100_REVR_NEW_MDIO_INTERFACE;
+        break;
+    case FTGMAC100_FEAR1: /* Feature Register 1 */
+        s->fear1 =3D value;
+        break;
+    case FTGMAC100_TPAFCR: /* Transmit Priority Arbitration and FIFO Con=
trol */
+        s->tpafcr =3D value;
+        break;
+    case FTGMAC100_FCR: /* Flow Control  */
+        s->fcr  =3D value;
+        break;
+
+    case FTGMAC100_HPTXPD: /* High Priority Transmit Poll Demand */
+    case FTGMAC100_HPTXR_BADR: /* High Priority Transmit Ring Base Addre=
ss */
+    case FTGMAC100_MACSR: /* MAC Status Register (MACSR) */
+        qemu_log_mask(LOG_UNIMP, "%s: write to unimplemented register 0x=
%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        break;
+    }
+
+    ftgmac100_update_irq(s);
+}
+
+static int ftgmac100_filter(FTGMAC100State *s, const uint8_t *buf, size_=
t len)
+{
+    unsigned mcast_idx;
+
+    if (s->maccr & FTGMAC100_MACCR_RX_ALL) {
+        return 1;
+    }
+
+    switch (get_eth_packet_type(PKT_GET_ETH_HDR(buf))) {
+    case ETH_PKT_BCAST:
+        if (!(s->maccr & FTGMAC100_MACCR_RX_BROADPKT)) {
+            return 0;
+        }
+        break;
+    case ETH_PKT_MCAST:
+        if (!(s->maccr & FTGMAC100_MACCR_RX_MULTIPKT)) {
+            if (!(s->maccr & FTGMAC100_MACCR_HT_MULTI_EN)) {
+                return 0;
+            }
+
+            /* TODO: this does not seem to work for ftgmac100 */
+            mcast_idx =3D compute_mcast_idx(buf);
+            if (!(s->math[mcast_idx / 32] & (1 << (mcast_idx % 32)))) {
+                return 0;
+            }
+        }
+        break;
+    case ETH_PKT_UCAST:
+        if (memcmp(s->conf.macaddr.a, buf, 6)) {
+            return 0;
+        }
+        break;
+    }
+
+    return 1;
+}
+
+static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
+                                 size_t len)
+{
+    FTGMAC100State *s =3D FTGMAC100(qemu_get_nic_opaque(nc));
+    FTGMAC100Desc bd;
+    uint32_t flags =3D 0;
+    uint32_t addr;
+    uint32_t crc;
+    uint32_t buf_addr;
+    uint8_t *crc_ptr;
+    uint32_t buf_len;
+    size_t size =3D len;
+    uint32_t first =3D FTGMAC100_RXDES0_FRS;
+    int max_frame_size =3D ftgmac100_max_frame_size(s);
+
+    if ((s->maccr & (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN=
))
+         !=3D (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN)) {
+        return -1;
+    }
+
+    /* TODO : Pad to minimum Ethernet frame length */
+    /* handle small packets.  */
+    if (size < 10) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: dropped frame of %zd bytes\n=
",
+                      __func__, size);
+        return size;
+    }
+
+    if (size < 64 && !(s->maccr && FTGMAC100_MACCR_RX_RUNT)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: dropped runt frame of %zd by=
tes\n",
+                      __func__, size);
+        return size;
+    }
+
+    if (!ftgmac100_filter(s, buf, size)) {
+        return size;
+    }
+
+    /* 4 bytes for the CRC.  */
+    size +=3D 4;
+    crc =3D cpu_to_be32(crc32(~0, buf, size));
+    crc_ptr =3D (uint8_t *) &crc;
+
+    /* Huge frames are truncated.  */
+    if (size > max_frame_size) {
+        size =3D max_frame_size;
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %zd bytes\n"=
,
+                      __func__, size);
+        flags |=3D FTGMAC100_RXDES0_FTL;
+    }
+
+    switch (get_eth_packet_type(PKT_GET_ETH_HDR(buf))) {
+    case ETH_PKT_BCAST:
+        flags |=3D FTGMAC100_RXDES0_BROADCAST;
+        break;
+    case ETH_PKT_MCAST:
+        flags |=3D FTGMAC100_RXDES0_MULTICAST;
+        break;
+    case ETH_PKT_UCAST:
+        break;
+    }
+
+    addr =3D s->rx_descriptor;
+    while (size > 0) {
+        if (!ftgmac100_can_receive(nc)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Unexpected packet\n", __=
func__);
+            return -1;
+        }
+
+        if (ftgmac100_read_bd(&bd, addr) ||
+            (bd.des0 & FTGMAC100_RXDES0_RXPKT_RDY)) {
+            /* No descriptors available.  Bail out.  */
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Lost end of frame\n",
+                          __func__);
+            s->isr |=3D FTGMAC100_INT_NO_RXBUF;
+            break;
+        }
+        buf_len =3D (size <=3D s->rbsr) ? size : s->rbsr;
+        bd.des0 |=3D buf_len & 0x3fff;
+        size -=3D buf_len;
+
+        /* The last 4 bytes are the CRC.  */
+        if (size < 4) {
+            buf_len +=3D size - 4;
+        }
+        buf_addr =3D bd.des3;
+        dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
+        buf +=3D buf_len;
+        if (size < 4) {
+            dma_memory_write(&address_space_memory, buf_addr + buf_len,
+                             crc_ptr, 4 - size);
+            crc_ptr +=3D 4 - size;
+        }
+
+        bd.des0 |=3D first | FTGMAC100_RXDES0_RXPKT_RDY;
+        first =3D 0;
+        if (size =3D=3D 0) {
+            /* Last buffer in frame.  */
+            bd.des0 |=3D flags | FTGMAC100_RXDES0_LRS;
+            s->isr |=3D FTGMAC100_INT_RPKT_BUF;
+        } else {
+            s->isr |=3D FTGMAC100_INT_RPKT_FIFO;
+        }
+        ftgmac100_write_bd(&bd, addr);
+        if (bd.des0 & FTGMAC100_RXDES0_EDORR) {
+            addr =3D s->rx_ring;
+        } else {
+            addr +=3D sizeof(FTGMAC100Desc);
+        }
+    }
+    s->rx_descriptor =3D addr;
+
+    ftgmac100_update_irq(s);
+    return len;
+}
+
+static const MemoryRegionOps ftgmac100_ops =3D {
+    .read =3D ftgmac100_read,
+    .write =3D ftgmac100_write,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+};
+
+static void ftgmac100_cleanup(NetClientState *nc)
+{
+    FTGMAC100State *s =3D FTGMAC100(qemu_get_nic_opaque(nc));
+
+    s->nic =3D NULL;
+}
+
+static NetClientInfo net_ftgmac100_info =3D {
+    .type =3D NET_CLIENT_DRIVER_NIC,
+    .size =3D sizeof(NICState),
+    .can_receive =3D ftgmac100_can_receive,
+    .receive =3D ftgmac100_receive,
+    .cleanup =3D ftgmac100_cleanup,
+    .link_status_changed =3D ftgmac100_set_link,
+};
+
+static void ftgmac100_realize(DeviceState *dev, Error **errp)
+{
+    FTGMAC100State *s =3D FTGMAC100(dev);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &ftgmac100_ops, s,
+                          TYPE_FTGMAC100, 0x2000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+    qemu_macaddr_default_if_unset(&s->conf.macaddr);
+
+    s->conf.peers.ncs[0] =3D nd_table[0].netdev;
+
+    s->nic =3D qemu_new_nic(&net_ftgmac100_info, &s->conf,
+                          object_get_typename(OBJECT(dev)), DEVICE(dev)-=
>id,
+                          s);
+    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+
+    s->frame =3D g_malloc(FTGMAC100_MAX_FRAME_SIZE);
+}
+
+static const VMStateDescription vmstate_ftgmac100 =3D {
+    .name =3D TYPE_FTGMAC100,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32(irq_state, FTGMAC100State),
+        VMSTATE_UINT32(isr, FTGMAC100State),
+        VMSTATE_UINT32(ier, FTGMAC100State),
+        VMSTATE_UINT32(rx_enabled, FTGMAC100State),
+        VMSTATE_UINT32(rx_ring, FTGMAC100State),
+        VMSTATE_UINT32(rbsr, FTGMAC100State),
+        VMSTATE_UINT32(tx_ring, FTGMAC100State),
+        VMSTATE_UINT32(rx_descriptor, FTGMAC100State),
+        VMSTATE_UINT32(tx_descriptor, FTGMAC100State),
+        VMSTATE_UINT32_ARRAY(math, FTGMAC100State, 2),
+        VMSTATE_UINT32(itc, FTGMAC100State),
+        VMSTATE_UINT32(aptcr, FTGMAC100State),
+        VMSTATE_UINT32(dblac, FTGMAC100State),
+        VMSTATE_UINT32(revr, FTGMAC100State),
+        VMSTATE_UINT32(fear1, FTGMAC100State),
+        VMSTATE_UINT32(tpafcr, FTGMAC100State),
+        VMSTATE_UINT32(maccr, FTGMAC100State),
+        VMSTATE_UINT32(phycr, FTGMAC100State),
+        VMSTATE_UINT32(phydata, FTGMAC100State),
+        VMSTATE_UINT32(fcr, FTGMAC100State),
+        VMSTATE_UINT32(phy_status, FTGMAC100State),
+        VMSTATE_UINT32(phy_control, FTGMAC100State),
+        VMSTATE_UINT32(phy_advertise, FTGMAC100State),
+        VMSTATE_UINT32(phy_int, FTGMAC100State),
+        VMSTATE_UINT32(phy_int_mask, FTGMAC100State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property ftgmac100_properties[] =3D {
+    DEFINE_NIC_PROPERTIES(FTGMAC100State, conf),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ftgmac100_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_ftgmac100;
+    dc->reset =3D ftgmac100_reset;
+    dc->props =3D ftgmac100_properties;
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->realize =3D ftgmac100_realize;
+    dc->desc =3D "Faraday FTGMAC100 Gigabit Ethernet emulation";
+}
+
+static const TypeInfo ftgmac100_info =3D {
+    .name =3D TYPE_FTGMAC100,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(FTGMAC100State),
+    .class_init =3D ftgmac100_class_init,
+};
+
+static void ftgmac100_register_types(void)
+{
+    type_register_static(&ftgmac100_info);
+}
+
+type_init(ftgmac100_register_types)
diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
new file mode 100644
index 000000000000..962a718f43b8
--- /dev/null
+++ b/include/hw/net/ftgmac100.h
@@ -0,0 +1,60 @@
+/*
+ * Faraday FTGMAC100 Gigabit Ethernet
+ *
+ * Copyright (C) 2016-2017, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef FTGMAC100_H
+#define FTGMAC100_H
+
+#define TYPE_FTGMAC100 "ftgmac100"
+#define FTGMAC100(obj) OBJECT_CHECK(FTGMAC100State, (obj), TYPE_FTGMAC10=
0)
+
+#include "hw/sysbus.h"
+#include "net/net.h"
+
+typedef struct FTGMAC100State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    NICState *nic;
+    NICConf conf;
+    qemu_irq irq;
+    MemoryRegion iomem;
+
+    uint8_t *frame;
+
+    uint32_t irq_state;
+    uint32_t isr;
+    uint32_t ier;
+    uint32_t rx_enabled;
+    uint32_t rx_ring;
+    uint32_t rx_descriptor;
+    uint32_t tx_ring;
+    uint32_t tx_descriptor;
+    uint32_t math[2];
+    uint32_t rbsr;
+    uint32_t itc;
+    uint32_t aptcr;
+    uint32_t dblac;
+    uint32_t revr;
+    uint32_t fear1;
+    uint32_t tpafcr;
+    uint32_t maccr;
+    uint32_t phycr;
+    uint32_t phydata;
+    uint32_t fcr;
+
+
+    uint32_t phy_status;
+    uint32_t phy_control;
+    uint32_t phy_advertise;
+    uint32_t phy_int;
+    uint32_t phy_int_mask;
+} FTGMAC100State;
+
+#endif
--=20
2.7.4
