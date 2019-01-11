Received: from eggs.gnu.org ([209.51.188.92]:58694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ghwO5-0001WX-K4
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ghwO4-0005DK-Jc
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:58:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34168
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ghwO4-0005Ct-EG
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:58:12 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0BCvVHp104797
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 07:58:11 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pxuks010q-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 07:58:10 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Fri, 11 Jan 2019 12:58:09 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 11 Jan 2019 13:57:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190111125759.31577-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ftgmac100: implement the new MDIO interface on
 Aspeed SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The PHY behind the MAC of an Aspeed SoC can be controlled using two
different MDC/MDIO interfaces. The same registers PHYCR (MAC60) and
PHYDATA (MAC64) are involved but they have a different layout.

BIT31 of the Feature Register (MAC40) controls which MDC/MDIO
interface is active.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/net/ftgmac100.c | 80 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 909c1182eebe..790430346b51 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -89,6 +89,18 @@
 #define FTGMAC100_PHYDATA_MIIWDATA(x)       ((x) & 0xffff)
 #define FTGMAC100_PHYDATA_MIIRDATA(x)       (((x) >> 16) & 0xffff)
=20
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
     s->phy_int =3D 0;
 }
=20
-static uint32_t do_phy_read(FTGMAC100State *s, int reg)
+static uint16_t do_phy_read(FTGMAC100State *s, uint8_t reg)
 {
-    uint32_t val;
+    uint16_t val;
=20
     switch (reg) {
     case MII_BMCR: /* Basic Control */
@@ -336,7 +348,7 @@ static uint32_t do_phy_read(FTGMAC100State *s, int re=
g)
                        MII_BMCR_FD | MII_BMCR_CTST)
 #define MII_ANAR_MASK 0x2d7f
=20
-static void do_phy_write(FTGMAC100State *s, int reg, uint32_t val)
+static void do_phy_write(FTGMAC100State *s, uint8_t reg, uint16_t val)
 {
     switch (reg) {
     case MII_BMCR:     /* Basic Control */
@@ -373,6 +385,55 @@ static void do_phy_write(FTGMAC100State *s, int reg,=
 uint32_t val)
     }
 }
=20
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
+    reg =3D FTGMAC100_PHYCR_NEW_REG(s->phycr);
+    data =3D FTGMAC100_PHYCR_NEW_DATA(s->phycr);
+
+    switch (FTGMAC100_PHYCR_NEW_OP(s->phycr)) {
+    case FTGMAC100_PHYCR_NEW_OP_WRITE:
+        do_phy_write(s, reg, data);
+        break;
+    case FTGMAC100_PHYCR_NEW_OP_READ:
+        s->phydata =3D do_phy_read(s, reg) & 0xffff;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid OP code %08x\n",
+                      __func__, s->phycr);
+    }
+
+    s->phycr &=3D ~FTGMAC100_PHYCR_NEW_FIRE;
+}
+
+static void do_phy_ctl(FTGMAC100State *s)
+{
+    uint8_t reg =3D FTGMAC100_PHYCR_REG(s->phycr);
+
+    if (s->phycr & FTGMAC100_PHYCR_MIIWR) {
+        do_phy_write(s, reg, s->phydata & 0xffff);
+        s->phycr &=3D ~FTGMAC100_PHYCR_MIIWR;
+    } else if (s->phycr & FTGMAC100_PHYCR_MIIRD) {
+        s->phydata =3D do_phy_read(s, reg) << 16;
+        s->phycr &=3D ~FTGMAC100_PHYCR_MIIRD;
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no OP code %08x\n",
+                      __func__, s->phycr);
+    }
+}
+
 static int ftgmac100_read_bd(FTGMAC100Desc *bd, dma_addr_t addr)
 {
     if (dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd))) {
@@ -628,7 +689,6 @@ static void ftgmac100_write(void *opaque, hwaddr addr=
,
                           uint64_t value, unsigned size)
 {
     FTGMAC100State *s =3D FTGMAC100(opaque);
-    int reg;
=20
     switch (addr & 0xff) {
     case FTGMAC100_ISR: /* Interrupt status */
@@ -711,14 +771,11 @@ static void ftgmac100_write(void *opaque, hwaddr ad=
dr,
         break;
=20
     case FTGMAC100_PHYCR:  /* PHY Device control */
-        reg =3D FTGMAC100_PHYCR_REG(value);
         s->phycr =3D value;
-        if (value & FTGMAC100_PHYCR_MIIWR) {
-            do_phy_write(s, reg, s->phydata & 0xffff);
-            s->phycr &=3D ~FTGMAC100_PHYCR_MIIWR;
+        if (s->revr & FTGMAC100_REVR_NEW_MDIO_INTERFACE) {
+            do_phy_new_ctl(s);
         } else {
-            s->phydata =3D do_phy_read(s, reg) << 16;
-            s->phycr &=3D ~FTGMAC100_PHYCR_MIIRD;
+            do_phy_ctl(s);
         }
         break;
     case FTGMAC100_PHYDATA:
@@ -728,8 +785,7 @@ static void ftgmac100_write(void *opaque, hwaddr addr=
,
         s->dblac =3D value;
         break;
     case FTGMAC100_REVR:  /* Feature Register */
-        /* TODO: Only Old MDIO interface is supported */
-        s->revr =3D value & ~FTGMAC100_REVR_NEW_MDIO_INTERFACE;
+        s->revr =3D value;
         break;
     case FTGMAC100_FEAR1: /* Feature Register 1 */
         s->fear1 =3D value;
--=20
2.20.1
