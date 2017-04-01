Received: from eggs.gnu.org ([2001:4830:134:3::10]:41875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuId6-0002kr-FL
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cuId2-0004Yd-2o
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:59:44 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:52586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cuId1-0004Xm-Sx
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 08:59:40 -0400
Received: from player799.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 86FE0E44EC
	for <qemu-devel@nongnu.org>; Sat,  1 Apr 2017 14:59:38 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  1 Apr 2017 14:57:55 +0200
Message-Id: <1491051477-10455-3-git-send-email-clg@kaod.org>
In-Reply-To: <1491051477-10455-1-git-send-email-clg@kaod.org>
References: <1491051477-10455-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] net/ftgmac100: add a 'aspeed' property
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

The Aspeed SoCs have a different definition of the end of the ring
buffer bit. Add a property to specify which set of bits should be used
by the NIC.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/net/ftgmac100.c         | 19 ++++++++++++++++---
 include/hw/net/ftgmac100.h |  4 ++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 331e87391962..8867c435ba9d 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -133,6 +133,7 @@ struct ftgmac100_txdes {
 #define FTGMAC100_TXDES0_CRC_ERR         (1 << 19)
 #define FTGMAC100_TXDES0_LTS             (1 << 28)
 #define FTGMAC100_TXDES0_FTS             (1 << 29)
+#define FTGMAC100_TXDES0_EDOTR_ASPEED    (1 << 30)
 #define FTGMAC100_TXDES0_TXDMA_OWN       (1 << 31)
=20
 #define FTGMAC100_TXDES1_VLANTAG_CI(x)   ((x) & 0xffff)
@@ -168,6 +169,7 @@ struct ftgmac100_rxdes {
 #define FTGMAC100_RXDES0_PAUSE_FRAME     (1 << 25)
 #define FTGMAC100_RXDES0_LRS             (1 << 28)
 #define FTGMAC100_RXDES0_FRS             (1 << 29)
+#define FTGMAC100_RXDES0_EDORR_ASPEED    (1 << 30)
 #define FTGMAC100_RXDES0_RXPKT_RDY       (1 << 31)
=20
 #define FTGMAC100_RXDES1_VLANTAG_CI      0xffff
@@ -387,7 +389,7 @@ static uint32_t ftgmac100_find_txdes(Ftgmac100State *=
s, uint32_t addr)
=20
     while (1) {
         ftgmac100_read_bd(&bd, addr);
-        if (bd.des0 & (FTGMAC100_TXDES0_FTS | FTGMAC100_TXDES0_EDOTR)) {
+        if (bd.des0 & (FTGMAC100_TXDES0_FTS | s->txdes0_edotr)) {
             break;
         }
         addr +=3D sizeof(Ftgmac100Desc);
@@ -453,7 +455,7 @@ static void ftgmac100_do_tx(Ftgmac100State *s, uint32=
_t tx_ring,
         /* Write back the modified descriptor.  */
         ftgmac100_write_bd(&bd, addr);
         /* Advance to the next descriptor.  */
-        if (bd.des0 & FTGMAC100_TXDES0_EDOTR) {
+        if (bd.des0 & s->txdes0_edotr) {
             addr =3D tx_ring;
         } else {
             addr +=3D sizeof(Ftgmac100Desc);
@@ -856,7 +858,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, =
const uint8_t *buf,
             s->isr |=3D FTGMAC100_INT_RPKT_FIFO;
         }
         ftgmac100_write_bd(&bd, addr);
-        if (bd.des0 & FTGMAC100_RXDES0_EDORR) {
+        if (bd.des0 & s->rxdes0_edorr) {
             addr =3D s->rx_ring;
         } else {
             addr +=3D sizeof(Ftgmac100Desc);
@@ -897,6 +899,14 @@ static void ftgmac100_realize(DeviceState *dev, Erro=
r **errp)
     Ftgmac100State *s =3D FTGMAC100(dev);
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
=20
+    if (s->aspeed) {
+        s->txdes0_edotr =3D FTGMAC100_TXDES0_EDOTR_ASPEED;
+        s->rxdes0_edorr =3D FTGMAC100_RXDES0_EDORR_ASPEED;
+    } else {
+        s->txdes0_edotr =3D FTGMAC100_TXDES0_EDOTR;
+        s->rxdes0_edorr =3D FTGMAC100_RXDES0_EDORR;
+    }
+
     memory_region_init_io(&s->iomem, OBJECT(dev), &ftgmac100_ops, s,
                           TYPE_FTGMAC100, 0x2000);
     sysbus_init_mmio(sbd, &s->iomem);
@@ -941,11 +951,14 @@ static const VMStateDescription vmstate_ftgmac100 =3D=
 {
         VMSTATE_UINT32(phy_advertise, Ftgmac100State),
         VMSTATE_UINT32(phy_int, Ftgmac100State),
         VMSTATE_UINT32(phy_int_mask, Ftgmac100State),
+        VMSTATE_UINT32(txdes0_edotr, Ftgmac100State),
+        VMSTATE_UINT32(rxdes0_edorr, Ftgmac100State),
         VMSTATE_END_OF_LIST()
     }
 };
=20
 static Property ftgmac100_properties[] =3D {
+    DEFINE_PROP_BOOL("aspeed", Ftgmac100State, aspeed, false),
     DEFINE_NIC_PROPERTIES(Ftgmac100State, conf),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index 3bb4fe1a3ece..feb387bf0e2d 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -53,6 +53,10 @@ typedef struct Ftgmac100State {
     uint32_t phy_advertise;
     uint32_t phy_int;
     uint32_t phy_int_mask;
+
+    bool aspeed;
+    uint32_t txdes0_edotr;
+    uint32_t rxdes0_edorr;
 } Ftgmac100State;
=20
 #endif
--=20
2.7.4
