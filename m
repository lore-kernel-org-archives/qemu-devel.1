Received: from eggs.gnu.org ([2001:4830:134:3::10]:59453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWX-0003bE-Un
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWW-0003ZK-QP
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:57 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWW-0003Z4-M6
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:56 -0400
Received: by mail-qk0-x241.google.com with SMTP id d70so1028194qkc.1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:13:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 14:13:22 -0300
Message-Id: <20170922171323.10348-7-f4bug@amsat.org>
In-Reply-To: <20170922171323.10348-1-f4bug@amsat.org>
References: <20170922171323.10348-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 6/7] hw/mdio: Add VMState support
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

The MDIO model needs to have VMState support before it can be used by
devices that support VMState. This patch adds VMState macros for both
qemu_mdio and qemu_phy.

Signed-off-by: Grant Likely <grant.likely@arm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: just rebased]
---
 include/hw/net/mdio.h | 22 ++++++++++++++++++++++
 hw/net/mdio.c         | 30 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/hw/net/mdio.h b/include/hw/net/mdio.h
index 7fca19784e..b94e5ec337 100644
--- a/include/hw/net/mdio.h
+++ b/include/hw/net/mdio.h
@@ -25,6 +25,8 @@
  * THE SOFTWARE.
  */
 
+#include "migration/vmstate.h"
+
 /* PHY MII Register/Bit Definitions */
 /* PHY Registers defined by IEEE */
 #define PHY_CTRL         0x00 /* Control Register */
@@ -61,6 +63,16 @@ struct qemu_phy {
     void (*write)(struct qemu_phy *phy, unsigned int req, uint16_t data);
 };
 
+extern const VMStateDescription vmstate_mdio_phy;
+
+#define VMSTATE_MDIO_PHY(_field, _state) {                           \
+    .name   = (stringify(_field)),                                   \
+    .size   = sizeof(struct qemu_phy),                               \
+    .vmsd   = &vmstate_mdio_phy,                                     \
+    .flags  = VMS_STRUCT,                                            \
+    .offset = vmstate_offset_value(_state, _field, struct qemu_phy), \
+}
+
 struct qemu_mdio {
     /* bitbanging state machine */
     bool mdc;
@@ -83,6 +95,16 @@ struct qemu_mdio {
     struct qemu_phy *devs[32];
 };
 
+extern const VMStateDescription vmstate_mdio;
+
+#define VMSTATE_MDIO(_field, _state) {                                 \
+    .name   = (stringify(_field)),                                     \
+    .size   = sizeof(struct qemu_mdio),                                \
+    .vmsd   = &vmstate_mdio,                                           \
+    .flags  = VMS_STRUCT,                                              \
+    .offset = vmstate_offset_value(_state, _field, struct qemu_mdio),  \
+}
+
 void mdio_phy_init(struct qemu_phy *phy, uint16_t id1, uint16_t id2);
 void mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy,
                  unsigned int addr);
diff --git a/hw/net/mdio.c b/hw/net/mdio.c
index 96e10fada0..6c13cc7272 100644
--- a/hw/net/mdio.c
+++ b/hw/net/mdio.c
@@ -248,3 +248,33 @@ void mdio_bitbang_set_clk(struct qemu_mdio *bus, bool mdc)
         break;
     }
 }
+
+const VMStateDescription vmstate_mdio = {
+    .name = "mdio",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(mdc, struct qemu_mdio),
+        VMSTATE_BOOL(mdio, struct qemu_mdio),
+        VMSTATE_UINT32(state, struct qemu_mdio),
+        VMSTATE_UINT16(cnt, struct qemu_mdio),
+        VMSTATE_UINT16(addr, struct qemu_mdio),
+        VMSTATE_UINT16(opc, struct qemu_mdio),
+        VMSTATE_UINT16(req, struct qemu_mdio),
+        VMSTATE_UINT32(shiftreg, struct qemu_mdio),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription vmstate_mdio_phy = {
+    .name = "mdio",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16_ARRAY(regs, struct qemu_phy, 32),
+        VMSTATE_BOOL(link, struct qemu_phy),
+        VMSTATE_END_OF_LIST()
+    }
+};
-- 
2.14.1
