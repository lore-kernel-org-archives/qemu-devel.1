Received: from eggs.gnu.org ([2001:4830:134:3::10]:56963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xx-0007AO-Gp
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eJ4xw-0002ye-LW
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 16:59:57 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 26 Nov 2017 15:59:10 -0600
Message-Id: <6cafcb638eb9c002b16e2459475d8ef7a2440849.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
In-Reply-To: <cover.1511731946.git.mdavidsaver@gmail.com>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 12/17] e500: add i2c controller to CCSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Add i2c controller found on mpc8540,
mpc8544, and P2010 (newer ppc, unmodeled).

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/ppc/e500_ccsr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
index c479ed91ee..cd8216daaf 100644
--- a/hw/ppc/e500_ccsr.c
+++ b/hw/ppc/e500_ccsr.c
@@ -46,6 +46,8 @@
 #define E500_ERR_DETECT  (0x2e40)
 #define E500_ERR_DISABLE (0x2e44)
 
+#define E500_I2C_OFFSET  (0x3000)
+
 #define E500_DUART_OFFSET(N) (0x4500 + (N) * 0x100)
 
 #define E500_PORPLLSR    (0xE0000)
@@ -72,6 +74,7 @@ typedef struct {
     uint32_t ccb_freq;
 
     DeviceState *pic;
+    DeviceState *i2c;
 } CCSRState;
 
 #define TYPE_E500_CCSR "e500-ccsr"
@@ -272,6 +275,18 @@ static void e500_ccsr_realize(DeviceState *dev, Error **errp)
                                 sysbus_mmio_get_region(pic, 0));
     /* Note: MPIC internal interrupts are offset by 16 */
 
+    /* attach I2C controller */
+    ccsr->i2c = qdev_create(NULL, "mpc8540-i2c");
+    object_property_add_child(qdev_get_machine(), "i2c[*]",
+                              OBJECT(ccsr->i2c), NULL);
+    qdev_init_nofail(ccsr->i2c);
+    memory_region_add_subregion(&ccsr->iomem, E500_I2C_OFFSET,
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(ccsr->i2c), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(ccsr->i2c), 0,
+                          qdev_get_gpio_in(ccsr->pic, 16 + 27));
+
+
     /* DUARTS */
     /* for mpc8540, mpc8544, and P2010 (unmodeled), the DUART reference clock
      * is the CCB clock divided by 16.
-- 
2.11.0
