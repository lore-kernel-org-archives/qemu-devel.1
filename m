Received: from eggs.gnu.org ([2001:4830:134:3::10]:40171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQYwW-0008Q4-0Y
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQYwT-0000VU-1I
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:57:40 -0400
Message-Id: <d13ea58b288f386a12a76c41a617c500c4454341.1528291908.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1528291908.git.balaton@eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 06 Jun 2018 15:31:48 +0200
Subject: [Qemu-devel] [PATCH v2 3/8] ppc4xx_i2c: Implement directcntl
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 default-configs/ppc-softmmu.mak    |  1 +
 default-configs/ppcemb-softmmu.mak |  1 +
 hw/i2c/ppc4xx_i2c.c                | 14 +++++++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 4d7be45..7d0dc2f 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -26,6 +26,7 @@ CONFIG_USB_EHCI_SYSBUS=y
 CONFIG_SM501=y
 CONFIG_IDE_SII3112=y
 CONFIG_I2C=y
+CONFIG_BITBANG_I2C=y
 
 # For Macs
 CONFIG_MAC=y
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
index 67d18b2..37af193 100644
--- a/default-configs/ppcemb-softmmu.mak
+++ b/default-configs/ppcemb-softmmu.mak
@@ -19,3 +19,4 @@ CONFIG_USB_EHCI_SYSBUS=y
 CONFIG_SM501=y
 CONFIG_IDE_SII3112=y
 CONFIG_I2C=y
+CONFIG_BITBANG_I2C=y
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index a68b5f7..5806209 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -30,6 +30,7 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/i2c/ppc4xx_i2c.h"
+#include "bitbang_i2c.h"
 
 #define PPC4xx_I2C_MEM_SIZE 18
 
@@ -46,7 +47,13 @@
 
 #define IIC_XTCNTLSS_SRST   (1 << 0)
 
+#define IIC_DIRECTCNTL_SDAC (1 << 3)
+#define IIC_DIRECTCNTL_SCLC (1 << 2)
+#define IIC_DIRECTCNTL_MSDA (1 << 1)
+#define IIC_DIRECTCNTL_MSCL (1 << 0)
+
 typedef struct {
+    bitbang_i2c_interface *bitbang;
     uint8_t mdata;
     uint8_t lmadr;
     uint8_t hmadr;
@@ -308,7 +315,11 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
         i2c->xtcntlss = value;
         break;
     case 16:
-        i2c->directcntl = value & 0x7;
+        i2c->directcntl = value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNTL_SCLC);
+        i2c->directcntl |= (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
+        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL, i2c->directcntl & 1);
+        i2c->directcntl |= bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SDA,
+                               (value & IIC_DIRECTCNTL_SDAC) != 0) << 1;
         break;
     default:
         if (addr < PPC4xx_I2C_MEM_SIZE) {
@@ -343,6 +354,7 @@ static void ppc4xx_i2c_init(Object *o)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
     s->bus = i2c_init_bus(DEVICE(s), "i2c");
+    r->bitbang = bitbang_i2c_init(s->bus);
 }
 
 static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
-- 
2.7.6
