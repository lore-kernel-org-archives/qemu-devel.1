Received: from eggs.gnu.org ([2001:4830:134:3::10]:59475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWf-0003jB-Tm
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWc-0003cI-Ix
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:14:05 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWc-0003c4-Dp
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:14:02 -0400
Received: by mail-qk0-x243.google.com with SMTP id d70so1028312qkc.1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:14:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 14:13:23 -0300
Message-Id: <20170922171323.10348-8-f4bug@amsat.org>
In-Reply-To: <20170922171323.10348-1-f4bug@amsat.org>
References: <20170922171323.10348-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 7/7] hw/mdio: Use bitbang core for smc91c111
 network device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Grant Likely <grant.likely@arm.com>, Jason Wang <jasowang@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Grant Likely <grant.likely@arm.com>

The smc91c111 device has bitbanged MDIO access, but the model doesn't
yet implement it. This patch uses the generalized bitbang MDIO support
pulled out of etraxfs Ethernet driver.

The MDIO state machine is driven by changes in state to the clock
control bit in the management register. The PHY model emulated is
currently trivial (being whatever was done for the etraxfs driver), but
it is enough to get an OS to recognize a PHY as being present.

Tested with the versatilepb model with U-Boot and the Linux Kernel as
client software.

Updated .version_id and .minimum_version_id fields because this patch
add fields to the state structure.

Signed-off-by: Grant Likely <grant.likely@arm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: just rebased]
---
 hw/net/smc91c111.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 3b16dcf5a1..b5cc493f9f 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -11,6 +11,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/devices.h"
+#include "hw/net/mdio.h"
 /* For crc32 */
 #include <zlib.h>
 
@@ -49,12 +50,16 @@ typedef struct {
     uint8_t int_level;
     uint8_t int_mask;
     MemoryRegion mmio;
+
+    /* MDIO bus and the attached phy */
+    struct qemu_mdio mdio_bus;
+    struct qemu_phy phy;
 } smc91c111_state;
 
 static const VMStateDescription vmstate_smc91c111 = {
     .name = "smc91c111",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT16(tcr, smc91c111_state),
         VMSTATE_UINT16(rcr, smc91c111_state),
@@ -76,6 +81,8 @@ static const VMStateDescription vmstate_smc91c111 = {
         VMSTATE_BUFFER_UNSAFE(data, smc91c111_state, 0, NUM_PACKETS * 2048),
         VMSTATE_UINT8(int_level, smc91c111_state),
         VMSTATE_UINT8(int_mask, smc91c111_state),
+        VMSTATE_MDIO(mdio_bus, smc91c111_state),
+        VMSTATE_MDIO_PHY(phy, smc91c111_state),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -466,7 +473,15 @@ static void smc91c111_writeb(void *opaque, hwaddr offset,
             /* Multicast table.  */
             /* Not implemented.  */
             return;
-        case 8: case 9: /* Management Interface.  */
+        case 8: /* Management Interface.  */
+            /* Update MDIO data line status; but only if output is enabled */
+            if (value & 8) {
+                mdio_bitbang_set_data(&s->mdio_bus, !!(value & 1));
+            }
+            /* Process the clock */
+            mdio_bitbang_set_clk(&s->mdio_bus, value & 4);
+            return;
+        case 9: /* Management Interface.  */
             /* Not implemented.  */
             return;
         case 12: /* Early receive.  */
@@ -606,8 +621,7 @@ static uint32_t smc91c111_readb(void *opaque, hwaddr offset)
             /* Not implemented.  */
             return 0;
         case 8: /* Management Interface.  */
-            /* Not implemented.  */
-            return 0x30;
+            return 0x30 | (mdio_bitbang_get_data(&s->mdio_bus) ? 2 : 0);
         case 9:
             return 0x33;
         case 10: /* Revision.  */
@@ -774,6 +788,9 @@ static int smc91c111_init1(SysBusDevice *sbd)
     s->nic = qemu_new_nic(&net_smc91c111_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+
+    mdio_phy_init(&s->phy, 0x0016, 0xf84);
+    mdio_attach(&s->mdio_bus, &s->phy, 0);
     /* ??? Save/restore.  */
     return 0;
 }
-- 
2.14.1
