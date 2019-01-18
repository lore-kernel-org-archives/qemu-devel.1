Received: from eggs.gnu.org ([209.51.188.92]:42813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVb5-0002TM-I4
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVb4-000772-1G
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:15 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVb3-00076m-Nj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:13 -0500
Received: by mail-wr1-x42c.google.com with SMTP id j2so15495605wrw.1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:20 +0000
Message-Id: <20190118145805.6852-5-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/49] ftgmac100: implement the new MDIO
 interface on Aspeed SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

The PHY behind the MAC of an Aspeed SoC can be controlled using two
different MDC/MDIO interfaces. The same registers PHYCR (MAC60) and
PHYDATA (MAC64) are involved but they have a different layout.

BIT31 of the Feature Register (MAC40) controls which MDC/MDIO
interface is active.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190111125759.31577-1-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/ftgmac100.c | 80 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 909c1182eeb..790430346b5 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -89,6 +89,18 @@
 #define FTGMAC100_PHYDATA_MIIWDATA(x)       ((x) & 0xffff)
 #define FTGMAC100_PHYDATA_MIIRDATA(x)       (((x) >> 16) & 0xffff)
 
+/*
+ * PHY control register - New MDC/MDIO interface
+ */
+#define FTGMAC100_PHYCR_NEW_DATA(x)     (((x) >> 16) & 0xffff)
+#define FTGMAC100_PHYCR_NEW_FIRE        (1 << 15)
+#define FTGMAC100_PHYCR_NEW_ST_22       (1 << 12)
+#define FTGMAC100_PHYCR_NEW_OP(x)       (((x) >> 10) & 3)
+#define   FTGMAC100_PHYCR_NEW_OP_WRITE    0x1
+#define   FTGMAC100_PHYCR_NEW_OP_READ     0x2
+#define FTGMAC100_PHYCR_NEW_DEV(x)      (((x) >> 5) & 0x1f)
+#define FTGMAC100_PHYCR_NEW_REG(x)      ((x) & 0x1f)
+
 /*
  * Feature Register
  */
@@ -269,9 +281,9 @@ static void phy_reset(FTGMAC100State *s)
     s->phy_int = 0;
 }
 
-static uint32_t do_phy_read(FTGMAC100State *s, int reg)
+static uint16_t do_phy_read(FTGMAC100State *s, uint8_t reg)
 {
-    uint32_t val;
+    uint16_t val;
 
     switch (reg) {
     case MII_BMCR: /* Basic Control */
@@ -336,7 +348,7 @@ static uint32_t do_phy_read(FTGMAC100State *s, int reg)
                        MII_BMCR_FD | MII_BMCR_CTST)
 #define MII_ANAR_MASK 0x2d7f
 
-static void do_phy_write(FTGMAC100State *s, int reg, uint32_t val)
+static void do_phy_write(FTGMAC100State *s, uint8_t reg, uint16_t val)
 {
     switch (reg) {
     case MII_BMCR:     /* Basic Control */
@@ -373,6 +385,55 @@ static void do_phy_write(FTGMAC100State *s, int reg, uint32_t val)
     }
 }
 
+static void do_phy_new_ctl(FTGMAC100State *s)
+{
+    uint8_t reg;
+    uint16_t data;
+
+    if (!(s->phycr & FTGMAC100_PHYCR_NEW_ST_22)) {
+        qemu_log_mask(LOG_UNIMP, "%s: unsupported ST code\n", __func__);
+        return;
+    }
+
+    /* Nothing to do */
+    if (!(s->phycr & FTGMAC100_PHYCR_NEW_FIRE)) {
+        return;
+    }
+
+    reg = FTGMAC100_PHYCR_NEW_REG(s->phycr);
+    data = FTGMAC100_PHYCR_NEW_DATA(s->phycr);
+
+    switch (FTGMAC100_PHYCR_NEW_OP(s->phycr)) {
+    case FTGMAC100_PHYCR_NEW_OP_WRITE:
+        do_phy_write(s, reg, data);
+        break;
+    case FTGMAC100_PHYCR_NEW_OP_READ:
+        s->phydata = do_phy_read(s, reg) & 0xffff;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid OP code %08x\n",
+                      __func__, s->phycr);
+    }
+
+    s->phycr &= ~FTGMAC100_PHYCR_NEW_FIRE;
+}
+
+static void do_phy_ctl(FTGMAC100State *s)
+{
+    uint8_t reg = FTGMAC100_PHYCR_REG(s->phycr);
+
+    if (s->phycr & FTGMAC100_PHYCR_MIIWR) {
+        do_phy_write(s, reg, s->phydata & 0xffff);
+        s->phycr &= ~FTGMAC100_PHYCR_MIIWR;
+    } else if (s->phycr & FTGMAC100_PHYCR_MIIRD) {
+        s->phydata = do_phy_read(s, reg) << 16;
+        s->phycr &= ~FTGMAC100_PHYCR_MIIRD;
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no OP code %08x\n",
+                      __func__, s->phycr);
+    }
+}
+
 static int ftgmac100_read_bd(FTGMAC100Desc *bd, dma_addr_t addr)
 {
     if (dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd))) {
@@ -628,7 +689,6 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
                           uint64_t value, unsigned size)
 {
     FTGMAC100State *s = FTGMAC100(opaque);
-    int reg;
 
     switch (addr & 0xff) {
     case FTGMAC100_ISR: /* Interrupt status */
@@ -711,14 +771,11 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
         break;
 
     case FTGMAC100_PHYCR:  /* PHY Device control */
-        reg = FTGMAC100_PHYCR_REG(value);
         s->phycr = value;
-        if (value & FTGMAC100_PHYCR_MIIWR) {
-            do_phy_write(s, reg, s->phydata & 0xffff);
-            s->phycr &= ~FTGMAC100_PHYCR_MIIWR;
+        if (s->revr & FTGMAC100_REVR_NEW_MDIO_INTERFACE) {
+            do_phy_new_ctl(s);
         } else {
-            s->phydata = do_phy_read(s, reg) << 16;
-            s->phycr &= ~FTGMAC100_PHYCR_MIIRD;
+            do_phy_ctl(s);
         }
         break;
     case FTGMAC100_PHYDATA:
@@ -728,8 +785,7 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
         s->dblac = value;
         break;
     case FTGMAC100_REVR:  /* Feature Register */
-        /* TODO: Only Old MDIO interface is supported */
-        s->revr = value & ~FTGMAC100_REVR_NEW_MDIO_INTERFACE;
+        s->revr = value;
         break;
     case FTGMAC100_FEAR1: /* Feature Register 1 */
         s->fear1 = value;
-- 
2.20.1
