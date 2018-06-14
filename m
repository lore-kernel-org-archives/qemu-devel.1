Received: from eggs.gnu.org ([2001:4830:134:3::10]:40384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTGBL-0006SK-2I
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 20:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTGBJ-0003Cj-3z
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 20:32:07 -0400
Message-Id: <eae3a67f95bb28868416eb1e8547b48af1eec6f5.1528935420.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1528935420.git.balaton@eik.bme.hu>
References: <cover.1528935420.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 14 Jun 2018 02:17:00 +0200
Subject: [Qemu-devel] [PATCH v3 3/9] ppc4xx_i2c: Rewrite to model hardware
 more closely
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

Rewrite to make it closer to how real device works so that guest OS
drivers can access I2C devices. Previously this was only a hack to
allow U-Boot to get past accessing SPD EEPROMs but to support other
I2C devices and allow guests to access them we need to model real
device more properly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/i2c/ppc4xx_i2c.c         | 222 +++++++++++++++++++++-----------------------
 include/hw/i2c/ppc4xx_i2c.h |   3 +-
 2 files changed, 110 insertions(+), 115 deletions(-)

diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index c0a1930..73d6ba5 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -38,13 +38,26 @@
 #define IIC_CNTL_READ       (1 << 1)
 #define IIC_CNTL_CHT        (1 << 2)
 #define IIC_CNTL_RPST       (1 << 3)
+#define IIC_CNTL_AMD        (1 << 6)
+#define IIC_CNTL_HMT        (1 << 7)
+
+#define IIC_MDCNTL_EINT     (1 << 2)
+#define IIC_MDCNTL_ESM      (1 << 3)
+#define IIC_MDCNTL_FMDB     (1 << 6)
 
 #define IIC_STS_PT          (1 << 0)
+#define IIC_STS_IRQA        (1 << 1)
 #define IIC_STS_ERR         (1 << 2)
+#define IIC_STS_MDBF        (1 << 4)
 #define IIC_STS_MDBS        (1 << 5)
 
 #define IIC_EXTSTS_XFRA     (1 << 0)
 
+#define IIC_INTRMSK_EIMTC   (1 << 0)
+#define IIC_INTRMSK_EITA    (1 << 1)
+#define IIC_INTRMSK_EIIC    (1 << 2)
+#define IIC_INTRMSK_EIHE    (1 << 3)
+
 #define IIC_XTCNTLSS_SRST   (1 << 0)
 
 #define IIC_DIRECTCNTL_SDAC (1 << 3)
@@ -56,21 +69,13 @@ static void ppc4xx_i2c_reset(DeviceState *s)
 {
     PPC4xxI2CState *i2c = PPC4xx_I2C(s);
 
-    /* FIXME: Should also reset bus?
-     *if (s->address != ADDR_RESET) {
-     *    i2c_end_transfer(s->bus);
-     *}
-     */
-
-    i2c->mdata = 0;
-    i2c->lmadr = 0;
-    i2c->hmadr = 0;
+    i2c->mdidx = -1;
+    memset(i2c->mdata, 0, ARRAY_SIZE(i2c->mdata));
+    /* [hl][ms]addr are not affected by reset */
     i2c->cntl = 0;
     i2c->mdcntl = 0;
     i2c->sts = 0;
-    i2c->extsts = 0x8f;
-    i2c->lsadr = 0;
-    i2c->hsadr = 0;
+    i2c->extsts = (1 << 6);
     i2c->clkdiv = 0;
     i2c->intrmsk = 0;
     i2c->xfrcnt = 0;
@@ -78,69 +83,29 @@ static void ppc4xx_i2c_reset(DeviceState *s)
     i2c->directcntl = 0xf;
 }
 
-static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
-{
-    return true;
-}
-
 static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
 {
     PPC4xxI2CState *i2c = PPC4xx_I2C(opaque);
     uint64_t ret;
+    int i;
 
     switch (addr) {
     case 0:
-        ret = i2c->mdata;
-        if (ppc4xx_i2c_is_master(i2c)) {
+        if (i2c->mdidx < 0) {
             ret = 0xff;
-
-            if (!(i2c->sts & IIC_STS_MDBS)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Trying to read "
-                              "without starting transfer\n",
-                              TYPE_PPC4xx_I2C, __func__);
-            } else {
-                int pending = (i2c->cntl >> 4) & 3;
-
-                /* get the next byte */
-                int byte = i2c_recv(i2c->bus);
-
-                if (byte < 0) {
-                    qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: read failed "
-                                  "for device 0x%02x\n", TYPE_PPC4xx_I2C,
-                                  __func__, i2c->lmadr);
-                    ret = 0xff;
-                } else {
-                    ret = byte;
-                    /* Raise interrupt if enabled */
-                    /*ppc4xx_i2c_raise_interrupt(i2c)*/;
-                }
-
-                if (!pending) {
-                    i2c->sts &= ~IIC_STS_MDBS;
-                    /*i2c_end_transfer(i2c->bus);*/
-                /*} else if (i2c->cntl & (IIC_CNTL_RPST | IIC_CNTL_CHT)) {*/
-                } else if (pending) {
-                    /* current smbus implementation doesn't like
-                       multibyte xfer repeated start */
-                    i2c_end_transfer(i2c->bus);
-                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)) {
-                        /* if non zero is returned, the adress is not valid */
-                        i2c->sts &= ~IIC_STS_PT;
-                        i2c->sts |= IIC_STS_ERR;
-                        i2c->extsts |= IIC_EXTSTS_XFRA;
-                    } else {
-                        /*i2c->sts |= IIC_STS_PT;*/
-                        i2c->sts |= IIC_STS_MDBS;
-                        i2c->sts &= ~IIC_STS_ERR;
-                        i2c->extsts = 0;
-                    }
-                }
-                pending--;
-                i2c->cntl = (i2c->cntl & 0xcf) | (pending << 4);
-            }
-        } else {
-            qemu_log_mask(LOG_UNIMP, "[%s]%s: slave mode not implemented\n",
-                          TYPE_PPC4xx_I2C, __func__);
+            break;
+        }
+        ret = i2c->mdata[0];
+        if (i2c->mdidx == 3) {
+            i2c->sts &= ~IIC_STS_MDBF;
+        } else if (i2c->mdidx == 0) {
+            i2c->sts &= ~IIC_STS_MDBS;
+        }
+        for (i = 0; i < i2c->mdidx; i++) {
+            i2c->mdata[i] = i2c->mdata[i + 1];
+        }
+        if (i2c->mdidx >= 0) {
+            i2c->mdidx--;
         }
         break;
     case 4:
@@ -160,6 +125,7 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
         break;
     case 9:
         ret = i2c->extsts;
+        ret |= !!i2c_bus_busy(i2c->bus) << 4;
         break;
     case 10:
         ret = i2c->lsadr;
@@ -203,70 +169,98 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
 
     switch (addr) {
     case 0:
-        i2c->mdata = value;
-        if (!i2c_bus_busy(i2c->bus)) {
-            /* assume we start a write transfer */
-            if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 0)) {
-                /* if non zero is returned, the adress is not valid */
-                i2c->sts &= ~IIC_STS_PT;
-                i2c->sts |= IIC_STS_ERR;
-                i2c->extsts |= IIC_EXTSTS_XFRA;
-            } else {
-                i2c->sts |= IIC_STS_PT;
-                i2c->sts &= ~IIC_STS_ERR;
-                i2c->extsts = 0;
-            }
+        if (i2c->mdidx >= 3) {
+            break;
         }
-        if (i2c_bus_busy(i2c->bus)) {
-            if (i2c_send(i2c->bus, i2c->mdata)) {
-                /* if the target return non zero then end the transfer */
-                i2c->sts &= ~IIC_STS_PT;
-                i2c->sts |= IIC_STS_ERR;
-                i2c->extsts |= IIC_EXTSTS_XFRA;
-                i2c_end_transfer(i2c->bus);
-            }
+        i2c->mdata[++i2c->mdidx] = value;
+        if (i2c->mdidx == 3) {
+            i2c->sts |= IIC_STS_MDBF;
+        } else if (i2c->mdidx == 0) {
+            i2c->sts |= IIC_STS_MDBS;
         }
         break;
     case 4:
         i2c->lmadr = value;
-        if (i2c_bus_busy(i2c->bus)) {
-            i2c_end_transfer(i2c->bus);
-        }
         break;
     case 5:
         i2c->hmadr = value;
         break;
     case 6:
-        i2c->cntl = value;
-        if (i2c->cntl & IIC_CNTL_PT) {
-            if (i2c->cntl & IIC_CNTL_READ) {
-                if (i2c_bus_busy(i2c->bus)) {
-                    /* end previous transfer */
-                    i2c->sts &= ~IIC_STS_PT;
-                    i2c_end_transfer(i2c->bus);
+        i2c->cntl = value & 0xfe;
+        if (value & IIC_CNTL_AMD) {
+            qemu_log_mask(LOG_UNIMP, "%s: only 7 bit addresses supported\n",
+                          __func__);
+        }
+        if (value & IIC_CNTL_HMT && i2c_bus_busy(i2c->bus)) {
+            i2c_end_transfer(i2c->bus);
+            if (i2c->mdcntl & IIC_MDCNTL_EINT &&
+                i2c->intrmsk & IIC_INTRMSK_EIHE) {
+                    i2c->sts |= IIC_STS_IRQA;
+                    qemu_irq_raise(i2c->irq);
+            }
+        } else if (value & IIC_CNTL_PT) {
+            int recv = (value & IIC_CNTL_READ) >> 1;
+            int tct = value >> 4 & 3;
+            int i;
+
+            if (recv && (i2c->lmadr >> 1) >= 0x50 && (i2c->lmadr >> 1) < 0x58) {
+                /* smbus emulation does not like multi byte reads w/o restart */
+                value |= IIC_CNTL_RPST;
+            }
+
+            for (i = 0; i <= tct; i++) {
+                if (!i2c_bus_busy(i2c->bus)) {
+                    i2c->extsts = (1 << 6);
+                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, recv)) {
+                        i2c->sts |= IIC_STS_ERR;
+                        i2c->extsts |= IIC_EXTSTS_XFRA;
+                        break;
+                    } else {
+                        i2c->sts &= ~IIC_STS_ERR;
+                    }
+                }
+                if (!(i2c->sts & IIC_STS_ERR) &&
+                    i2c_send_recv(i2c->bus, &i2c->mdata[i], !recv)) {
+                        i2c->sts |= IIC_STS_ERR;
+                        i2c->extsts |= IIC_EXTSTS_XFRA;
+                        break;
                 }
-                if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)) {
-                    /* if non zero is returned, the adress is not valid */
-                    i2c->sts &= ~IIC_STS_PT;
-                    i2c->sts |= IIC_STS_ERR;
-                    i2c->extsts |= IIC_EXTSTS_XFRA;
-                } else {
-                    /*i2c->sts |= IIC_STS_PT;*/
-                    i2c->sts |= IIC_STS_MDBS;
-                    i2c->sts &= ~IIC_STS_ERR;
-                    i2c->extsts = 0;
+                if (value & IIC_CNTL_RPST || !(value & IIC_CNTL_CHT)) {
+                    i2c_end_transfer(i2c->bus);
                 }
-            } else {
-                /* we actually already did the write transfer... */
-                i2c->sts &= ~IIC_STS_PT;
+            }
+            i2c->xfrcnt = i;
+            i2c->mdidx = i - 1;
+            if (recv && i2c->mdidx >= 0) {
+                i2c->sts |= IIC_STS_MDBS;
+            }
+            if (recv && i2c->mdidx == 3) {
+                i2c->sts |= IIC_STS_MDBF;
+            }
+            if (i && i2c->mdcntl & IIC_MDCNTL_EINT &&
+                i2c->intrmsk & IIC_INTRMSK_EIMTC) {
+                i2c->sts |= IIC_STS_IRQA;
+                qemu_irq_raise(i2c->irq);
             }
         }
         break;
     case 7:
-        i2c->mdcntl = value & 0xdf;
+        i2c->mdcntl = value & 0x3d;
+        if (value & IIC_MDCNTL_ESM) {
+            qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
+                          __func__);
+        }
+        if (value & IIC_MDCNTL_FMDB) {
+            i2c->mdidx = -1;
+            memset(i2c->mdata, 0, ARRAY_SIZE(i2c->mdata));
+            i2c->sts &= ~(IIC_STS_MDBF | IIC_STS_MDBS);
+        }
         break;
     case 8:
-        i2c->sts &= ~(value & 0xa);
+        i2c->sts &= ~(value & 0x0a);
+        if (value & IIC_STS_IRQA && i2c->mdcntl & IIC_MDCNTL_EINT) {
+            qemu_irq_lower(i2c->irq);
+        }
         break;
     case 9:
         i2c->extsts &= ~(value & 0x8f);
@@ -287,12 +281,12 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
         i2c->xfrcnt = value & 0x77;
         break;
     case 15:
+        i2c->xtcntlss &= ~(value & 0xf0);
         if (value & IIC_XTCNTLSS_SRST) {
             /* Is it actually a full reset? U-Boot sets some regs before */
             ppc4xx_i2c_reset(DEVICE(i2c));
             break;
         }
-        i2c->xtcntlss = value;
         break;
     case 16:
         i2c->directcntl = value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNTL_SCLC);
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index ea6c8e1..0891a9c 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -46,7 +46,8 @@ typedef struct PPC4xxI2CState {
     qemu_irq irq;
     MemoryRegion iomem;
     bitbang_i2c_interface *bitbang;
-    uint8_t mdata;
+    int mdidx;
+    uint8_t mdata[4];
     uint8_t lmadr;
     uint8_t hmadr;
     uint8_t cntl;
-- 
2.7.6
