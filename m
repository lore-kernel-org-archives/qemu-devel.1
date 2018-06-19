Received: from eggs.gnu.org ([2001:4830:134:3::10]:33587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVCi4-000497-6D
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVChz-0008AZ-6m
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:13:56 -0400
Message-Id: <ce619ddd11a875caae4c221c18ebf7c6a6f4bd4f.1529398335.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1529398335.git.balaton@eik.bme.hu>
References: <cover.1529398335.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 19 Jun 2018 10:52:15 +0200
Subject: [Qemu-devel] [PATCH v4 02/11] ppc4xx_i2c: Implement directcntl
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

As well as being able to generate its own i2c transactions, the ppc4xx
i2c controller has a DIRECTCNTL register which allows explicit control
of the i2c lines.

Using this register an OS can directly bitbang i2c operations. In
order to let emulated i2c devices respond to this, we need to wire up
the DIRECTCNTL register to qemu's bitbanged i2c handling code.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v4: Updated commit message and use defined constant where appropriate

 default-configs/ppc-softmmu.mak    |  1 +
 default-configs/ppcemb-softmmu.mak |  1 +
 hw/i2c/ppc4xx_i2c.c                | 14 +++++++++++++-
 include/hw/i2c/ppc4xx_i2c.h        |  4 ++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index abeeb04..851b4af 100644
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
index 4e0aaae..fca80d6 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -30,6 +30,7 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/i2c/ppc4xx_i2c.h"
+#include "bitbang_i2c.h"
 
 #define PPC4xx_I2C_MEM_SIZE 18
 
@@ -46,6 +47,11 @@
 
 #define IIC_XTCNTLSS_SRST   (1 << 0)
 
+#define IIC_DIRECTCNTL_SDAC (1 << 3)
+#define IIC_DIRECTCNTL_SCLC (1 << 2)
+#define IIC_DIRECTCNTL_MSDA (1 << 1)
+#define IIC_DIRECTCNTL_MSCL (1 << 0)
+
 static void ppc4xx_i2c_reset(DeviceState *s)
 {
     PPC4xxI2CState *i2c = PPC4xx_I2C(s);
@@ -289,7 +295,12 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
         i2c->xtcntlss = value;
         break;
     case 16:
-        i2c->directcntl = value & 0x7;
+        i2c->directcntl = value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNTL_SCLC);
+        i2c->directcntl |= (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
+        bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL,
+                        i2c->directcntl & IIC_DIRECTCNTL_MSCL);
+        i2c->directcntl |= bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SDA,
+                               (value & IIC_DIRECTCNTL_SDAC) != 0) << 1;
         break;
     default:
         if (addr < PPC4xx_I2C_MEM_SIZE) {
@@ -322,6 +333,7 @@ static void ppc4xx_i2c_init(Object *o)
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
     s->bus = i2c_init_bus(DEVICE(s), "i2c");
+    s->bitbang = bitbang_i2c_init(s->bus);
 }
 
 static void ppc4xx_i2c_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index e4b6ded..ea6c8e1 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -31,6 +31,9 @@
 #include "hw/sysbus.h"
 #include "hw/i2c/i2c.h"
 
+/* from hw/i2c/bitbang_i2c.h */
+typedef struct bitbang_i2c_interface bitbang_i2c_interface;
+
 #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
 #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_I2C)
 
@@ -42,6 +45,7 @@ typedef struct PPC4xxI2CState {
     I2CBus *bus;
     qemu_irq irq;
     MemoryRegion iomem;
+    bitbang_i2c_interface *bitbang;
     uint8_t mdata;
     uint8_t lmadr;
     uint8_t hmadr;
-- 
2.7.6
