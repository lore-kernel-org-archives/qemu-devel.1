Received: from eggs.gnu.org ([2001:4830:134:3::10]:59406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWT-0003WF-NI
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWR-0003Vg-Kl
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:53 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:38070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWR-0003VW-Gn
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:51 -0400
Received: by mail-qk0-x241.google.com with SMTP id c69so1021460qke.5
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:13:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 14:13:20 -0300
Message-Id: <20170922171323.10348-5-f4bug@amsat.org>
In-Reply-To: <20170922171323.10348-1-f4bug@amsat.org>
References: <20170922171323.10348-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 4/7] hw/mdio: Mask out read-only bits.
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

The RST and ANEG_RST bits are commands, not settings. An operating
system will get confused (or at least u-boot does) if those bits remain
set after writing to them. Therefore, mask them out on write.

Similarly, no bits in the ID1, ID2, and remote capability registers are
writeable; so mask them out also.

Signed-off-by: Grant Likely <grant.likely@arm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: just rebased]
---
 include/hw/net/mdio.h |  1 +
 hw/net/mdio.c         | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/net/mdio.h b/include/hw/net/mdio.h
index b3b4f497c0..ed1879a728 100644
--- a/include/hw/net/mdio.h
+++ b/include/hw/net/mdio.h
@@ -53,6 +53,7 @@
 
 struct qemu_phy {
     uint32_t regs[NUM_PHY_REGS];
+    const uint16_t *regs_readonly_mask; /* 0=writable, 1=read-only */
 
     int link;
 
diff --git a/hw/net/mdio.c b/hw/net/mdio.c
index 33bfbb4623..89a6a3a590 100644
--- a/hw/net/mdio.c
+++ b/hw/net/mdio.c
@@ -109,17 +109,24 @@ static unsigned int mdio_phy_read(struct qemu_phy *phy, unsigned int req)
 
 static void mdio_phy_write(struct qemu_phy *phy, unsigned int req, unsigned int data)
 {
-    int regnum;
+    int regnum = req & 0x1f;
+    uint16_t mask = phy->regs_readonly_mask[regnum];
 
-    regnum = req & 0x1f;
-    D(printf("%s reg[%d] = %x\n", __func__, regnum, data));
+    D(printf("%s reg[%d] = %x; mask=%x\n", __func__, regnum, data, mask));
     switch (regnum) {
     default:
-        phy->regs[regnum] = data;
+        phy->regs[regnum] = (phy->regs[regnum] & mask) | (data & ~mask);
         break;
     }
 }
 
+static const uint16_t default_readonly_mask[32] = {
+    [PHY_CTRL] = PHY_CTRL_RST | PHY_CTRL_ANEG_RST,
+    [PHY_ID1] = 0xffff,
+    [PHY_ID2] = 0xffff,
+    [PHY_LP_ABILITY] = 0xffff,
+};
+
 void mdio_phy_init(struct qemu_phy *phy, uint16_t id1, uint16_t id2)
 {
     phy->regs[PHY_CTRL] = 0x3100;
@@ -128,6 +135,7 @@ void mdio_phy_init(struct qemu_phy *phy, uint16_t id1, uint16_t id2)
     phy->regs[PHY_ID2] = id2;
     /* Autonegotiation advertisement reg. */
     phy->regs[PHY_AUTONEG_ADV] = 0x01e1;
+    phy->regs_readonly_mask = default_readonly_mask;
     phy->link = 1;
 
     phy->read = mdio_phy_read;
-- 
2.14.1
