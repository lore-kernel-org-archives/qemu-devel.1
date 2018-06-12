Received: from eggs.gnu.org ([2001:4830:134:3::10]:59004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3q-0002pB-5l
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3o-0001wf-LK
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:53 +1000
Message-Id: <20180612064503.14282-24-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/33] ppc4xx_i2c: Clean up and improve error
 logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Make it more readable by converting register indexes to decimal
(avoids lot of superfluous 0x0) and distinguish errors caused by
accessing non-existent vs. unimplemented registers.
No functional change.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/i2c/ppc4xx_i2c.c | 94 ++++++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index ab64d196be..d1936dbdca 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -31,7 +31,7 @@
 #include "hw/hw.h"
 #include "hw/i2c/ppc4xx_i2c.h"
 
-#define PPC4xx_I2C_MEM_SIZE 0x12
+#define PPC4xx_I2C_MEM_SIZE 18
 
 #define IIC_CNTL_PT         (1 << 0)
 #define IIC_CNTL_READ       (1 << 1)
@@ -70,7 +70,7 @@ static void ppc4xx_i2c_reset(DeviceState *s)
     i2c->intrmsk = 0;
     i2c->xfrcnt = 0;
     i2c->xtcntlss = 0;
-    i2c->directcntl = 0x0f;
+    i2c->directcntl = 0xf;
     i2c->intr = 0;
 }
 
@@ -85,7 +85,7 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
     uint64_t ret;
 
     switch (addr) {
-    case 0x00:
+    case 0:
         ret = i2c->mdata;
         if (ppc4xx_i2c_is_master(i2c)) {
             ret = 0xff;
@@ -139,58 +139,62 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
                           TYPE_PPC4xx_I2C, __func__);
         }
         break;
-    case 0x02:
+    case 2:
         ret = i2c->sdata;
         break;
-    case 0x04:
+    case 4:
         ret = i2c->lmadr;
         break;
-    case 0x05:
+    case 5:
         ret = i2c->hmadr;
         break;
-    case 0x06:
+    case 6:
         ret = i2c->cntl;
         break;
-    case 0x07:
+    case 7:
         ret = i2c->mdcntl;
         break;
-    case 0x08:
+    case 8:
         ret = i2c->sts;
         break;
-    case 0x09:
+    case 9:
         ret = i2c->extsts;
         break;
-    case 0x0A:
+    case 10:
         ret = i2c->lsadr;
         break;
-    case 0x0B:
+    case 11:
         ret = i2c->hsadr;
         break;
-    case 0x0C:
+    case 12:
         ret = i2c->clkdiv;
         break;
-    case 0x0D:
+    case 13:
         ret = i2c->intrmsk;
         break;
-    case 0x0E:
+    case 14:
         ret = i2c->xfrcnt;
         break;
-    case 0x0F:
+    case 15:
         ret = i2c->xtcntlss;
         break;
-    case 0x10:
+    case 16:
         ret = i2c->directcntl;
         break;
-    case 0x11:
+    case 17:
         ret = i2c->intr;
         break;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad address at offset 0x%"
-                      HWADDR_PRIx "\n", TYPE_PPC4xx_I2C, __func__, addr);
+        if (addr < PPC4xx_I2C_MEM_SIZE) {
+            qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
+                          HWADDR_PRIx "\n", __func__, addr);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%"
+                          HWADDR_PRIx "\n", __func__, addr);
+        }
         ret = 0;
         break;
     }
-
     return ret;
 }
 
@@ -200,7 +204,7 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
     PPC4xxI2CState *i2c = opaque;
 
     switch (addr) {
-    case 0x00:
+    case 0:
         i2c->mdata = value;
         if (!i2c_bus_busy(i2c->bus)) {
             /* assume we start a write transfer */
@@ -225,19 +229,19 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
             }
         }
         break;
-    case 0x02:
+    case 2:
         i2c->sdata = value;
         break;
-    case 0x04:
+    case 4:
         i2c->lmadr = value;
         if (i2c_bus_busy(i2c->bus)) {
             i2c_end_transfer(i2c->bus);
         }
         break;
-    case 0x05:
+    case 5:
         i2c->hmadr = value;
         break;
-    case 0x06:
+    case 6:
         i2c->cntl = value;
         if (i2c->cntl & IIC_CNTL_PT) {
             if (i2c->cntl & IIC_CNTL_READ) {
@@ -263,32 +267,31 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
             }
         }
         break;
-    case 0x07:
-        i2c->mdcntl = value & 0xDF;
+    case 7:
+        i2c->mdcntl = value & 0xdf;
         break;
-    case 0x08:
-        i2c->sts &= ~(value & 0x0A);
+    case 8:
+        i2c->sts &= ~(value & 0xa);
         break;
-    case 0x09:
-        i2c->extsts &= ~(value & 0x8F);
+    case 9:
+        i2c->extsts &= ~(value & 0x8f);
         break;
-    case 0x0A:
+    case 10:
         i2c->lsadr = value;
-        /*i2c_set_slave_address(i2c->bus, i2c->lsadr);*/
         break;
-    case 0x0B:
+    case 11:
         i2c->hsadr = value;
         break;
-    case 0x0C:
+    case 12:
         i2c->clkdiv = value;
         break;
-    case 0x0D:
+    case 13:
         i2c->intrmsk = value;
         break;
-    case 0x0E:
+    case 14:
         i2c->xfrcnt = value & 0x77;
         break;
-    case 0x0F:
+    case 15:
         if (value & IIC_XTCNTLSS_SRST) {
             /* Is it actually a full reset? U-Boot sets some regs before */
             ppc4xx_i2c_reset(DEVICE(i2c));
@@ -296,15 +299,20 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
         }
         i2c->xtcntlss = value;
         break;
-    case 0x10:
+    case 16:
         i2c->directcntl = value & 0x7;
         break;
-    case 0x11:
+    case 17:
         i2c->intr = value;
         break;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad address at offset 0x%"
-                      HWADDR_PRIx "\n", TYPE_PPC4xx_I2C, __func__, addr);
+        if (addr < PPC4xx_I2C_MEM_SIZE) {
+            qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
+                          HWADDR_PRIx "\n", __func__, addr);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%"
+                          HWADDR_PRIx "\n", __func__, addr);
+        }
         break;
     }
 }
-- 
2.17.1
