Received: from eggs.gnu.org ([2001:4830:134:3::10]:59352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWM-00039s-QP
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWL-0003R5-LA
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:46 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWL-0003Qf-HY
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:45 -0400
Received: by mail-qt0-x244.google.com with SMTP id q8so1046258qtb.1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:13:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 14:13:18 -0300
Message-Id: <20170922171323.10348-3-f4bug@amsat.org>
In-Reply-To: <20170922171323.10348-1-f4bug@amsat.org>
References: <20170922171323.10348-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 2/7] hw/mdio: Add PHY register definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Grant Likely <grant.likely@arm.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Grant Likely <grant.likely@arm.com>

Trivial patch to add #defines for defined PHY register address and bit fields

Signed-off-by: Grant Likely <grant.likely@arm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/net/mdio.h | 24 ++++++++++++++++++++++--
 hw/net/mdio.c         |  8 ++++----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/hw/net/mdio.h b/include/hw/net/mdio.h
index ac36aed3c3..7ffa4389b9 100644
--- a/include/hw/net/mdio.h
+++ b/include/hw/net/mdio.h
@@ -25,14 +25,34 @@
  * THE SOFTWARE.
  */
 
-/* PHY Advertisement control register */
+/* PHY MII Register/Bit Definitions */
+/* PHY Registers defined by IEEE */
+#define PHY_CTRL         0x00 /* Control Register */
+#define PHY_STATUS       0x01 /* Status Regiser */
+#define PHY_ID1          0x02 /* Phy Id Reg (word 1) */
+#define PHY_ID2          0x03 /* Phy Id Reg (word 2) */
+#define PHY_AUTONEG_ADV  0x04 /* Autoneg Advertisement */
+#define PHY_LP_ABILITY   0x05 /* Link Partner Ability (Base Page) */
+#define PHY_AUTONEG_EXP  0x06 /* Autoneg Expansion Reg */
+#define PHY_NEXT_PAGE_TX 0x07 /* Next Page TX */
+#define PHY_LP_NEXT_PAGE 0x08 /* Link Partner Next Page */
+#define PHY_1000T_CTRL   0x09 /* 1000Base-T Control Reg */
+#define PHY_1000T_STATUS 0x0A /* 1000Base-T Status Reg */
+#define PHY_EXT_STATUS   0x0F /* Extended Status Reg */
+
+#define NUM_PHY_REGS     0x20  /* 5 bit address bus (0-0x1F) */
+
+#define PHY_CTRL_RST            0x8000 /* PHY reset command */
+#define PHY_CTRL_ANEG_RST       0x0200 /* Autonegotiation reset command */
+
+/* PHY Advertisement control and remote capability registers (same bitfields) */
 #define PHY_ADVERTISE_10HALF    0x0020  /* Try for 10mbps half-duplex  */
 #define PHY_ADVERTISE_10FULL    0x0040  /* Try for 10mbps full-duplex  */
 #define PHY_ADVERTISE_100HALF   0x0080  /* Try for 100mbps half-duplex */
 #define PHY_ADVERTISE_100FULL   0x0100  /* Try for 100mbps full-duplex */
 
 struct qemu_phy {
-    uint32_t regs[32];
+    uint32_t regs[NUM_PHY_REGS];
 
     int link;
 
diff --git a/hw/net/mdio.c b/hw/net/mdio.c
index 3763fcc8af..3d70d99077 100644
--- a/hw/net/mdio.c
+++ b/hw/net/mdio.c
@@ -122,12 +122,12 @@ static void tdk_write(struct qemu_phy *phy, unsigned int req, unsigned int data)
 
 void tdk_init(struct qemu_phy *phy)
 {
-    phy->regs[0] = 0x3100;
+    phy->regs[PHY_CTRL] = 0x3100;
     /* PHY Id. */
-    phy->regs[2] = 0x0300;
-    phy->regs[3] = 0xe400;
+    phy->regs[PHY_ID1] = 0x0300;
+    phy->regs[PHY_ID2] = 0xe400;
     /* Autonegotiation advertisement reg. */
-    phy->regs[4] = 0x01e1;
+    phy->regs[PHY_AUTONEG_ADV] = 0x01e1;
     phy->link = 1;
 
     phy->read = tdk_read;
-- 
2.14.1
