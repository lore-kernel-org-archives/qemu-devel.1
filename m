Received: from eggs.gnu.org ([2001:4830:134:3::10]:40211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQYwX-0008QL-LZ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQYwT-0000Vv-4k
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:57:41 -0400
Message-Id: <7017cb3e0ed918bc3a9df823175d91a24692e2ef.1528291908.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1528291908.git.balaton@eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 06 Jun 2018 15:31:48 +0200
Subject: [Qemu-devel] [PATCH v2 2/8] ppc4xx_i2c: Move register state to
 private struct and remove unimplemented sdata and intr registers
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
 hw/i2c/ppc4xx_i2c.c         | 75 +++++++++++++++++++++++++--------------------
 include/hw/i2c/ppc4xx_i2c.h | 19 ++----------
 2 files changed, 43 insertions(+), 51 deletions(-)

diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index d1936db..a68b5f7 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2007 Jocelyn Mayer
  * Copyright (c) 2012 François Revol
- * Copyright (c) 2016 BALATON Zoltan
+ * Copyright (c) 2016-2018 BALATON Zoltan
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -46,9 +46,26 @@
 
 #define IIC_XTCNTLSS_SRST   (1 << 0)
 
+typedef struct {
+    uint8_t mdata;
+    uint8_t lmadr;
+    uint8_t hmadr;
+    uint8_t cntl;
+    uint8_t mdcntl;
+    uint8_t sts;
+    uint8_t extsts;
+    uint8_t lsadr;
+    uint8_t hsadr;
+    uint8_t clkdiv;
+    uint8_t intrmsk;
+    uint8_t xfrcnt;
+    uint8_t xtcntlss;
+    uint8_t directcntl;
+} PPC4xxI2CRegs;
+
 static void ppc4xx_i2c_reset(DeviceState *s)
 {
-    PPC4xxI2CState *i2c = PPC4xx_I2C(s);
+    PPC4xxI2CRegs *i2c = PPC4xx_I2C(s)->regs;
 
     /* FIXME: Should also reset bus?
      *if (s->address != ADDR_RESET) {
@@ -63,7 +80,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
     i2c->mdcntl = 0;
     i2c->sts = 0;
     i2c->extsts = 0x8f;
-    i2c->sdata = 0;
     i2c->lsadr = 0;
     i2c->hsadr = 0;
     i2c->clkdiv = 0;
@@ -71,7 +87,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
     i2c->xfrcnt = 0;
     i2c->xtcntlss = 0;
     i2c->directcntl = 0xf;
-    i2c->intr = 0;
 }
 
 static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
@@ -81,13 +96,14 @@ static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
 
 static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
 {
-    PPC4xxI2CState *i2c = PPC4xx_I2C(opaque);
+    PPC4xxI2CState *s = PPC4xx_I2C(opaque);
+    PPC4xxI2CRegs *i2c = s->regs;
     uint64_t ret;
 
     switch (addr) {
     case 0:
         ret = i2c->mdata;
-        if (ppc4xx_i2c_is_master(i2c)) {
+        if (ppc4xx_i2c_is_master(s)) {
             ret = 0xff;
 
             if (!(i2c->sts & IIC_STS_MDBS)) {
@@ -98,7 +114,7 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
                 int pending = (i2c->cntl >> 4) & 3;
 
                 /* get the next byte */
-                int byte = i2c_recv(i2c->bus);
+                int byte = i2c_recv(s->bus);
 
                 if (byte < 0) {
                     qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: read failed "
@@ -113,13 +129,13 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
 
                 if (!pending) {
                     i2c->sts &= ~IIC_STS_MDBS;
-                    /*i2c_end_transfer(i2c->bus);*/
+                    /*i2c_end_transfer(s->bus);*/
                 /*} else if (i2c->cntl & (IIC_CNTL_RPST | IIC_CNTL_CHT)) {*/
                 } else if (pending) {
                     /* current smbus implementation doesn't like
                        multibyte xfer repeated start */
-                    i2c_end_transfer(i2c->bus);
-                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)) {
+                    i2c_end_transfer(s->bus);
+                    if (i2c_start_transfer(s->bus, i2c->lmadr >> 1, 1)) {
                         /* if non zero is returned, the adress is not valid */
                         i2c->sts &= ~IIC_STS_PT;
                         i2c->sts |= IIC_STS_ERR;
@@ -139,9 +155,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
                           TYPE_PPC4xx_I2C, __func__);
         }
         break;
-    case 2:
-        ret = i2c->sdata;
-        break;
     case 4:
         ret = i2c->lmadr;
         break;
@@ -181,9 +194,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
     case 16:
         ret = i2c->directcntl;
         break;
-    case 17:
-        ret = i2c->intr;
-        break;
     default:
         if (addr < PPC4xx_I2C_MEM_SIZE) {
             qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
@@ -201,14 +211,15 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
 static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
                               unsigned int size)
 {
-    PPC4xxI2CState *i2c = opaque;
+    PPC4xxI2CState *s = PPC4xx_I2C(opaque);
+    PPC4xxI2CRegs *i2c = s->regs;
 
     switch (addr) {
     case 0:
         i2c->mdata = value;
-        if (!i2c_bus_busy(i2c->bus)) {
+        if (!i2c_bus_busy(s->bus)) {
             /* assume we start a write transfer */
-            if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 0)) {
+            if (i2c_start_transfer(s->bus, i2c->lmadr >> 1, 0)) {
                 /* if non zero is returned, the adress is not valid */
                 i2c->sts &= ~IIC_STS_PT;
                 i2c->sts |= IIC_STS_ERR;
@@ -219,23 +230,20 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
                 i2c->extsts = 0;
             }
         }
-        if (i2c_bus_busy(i2c->bus)) {
-            if (i2c_send(i2c->bus, i2c->mdata)) {
+        if (i2c_bus_busy(s->bus)) {
+            if (i2c_send(s->bus, i2c->mdata)) {
                 /* if the target return non zero then end the transfer */
                 i2c->sts &= ~IIC_STS_PT;
                 i2c->sts |= IIC_STS_ERR;
                 i2c->extsts |= IIC_EXTSTS_XFRA;
-                i2c_end_transfer(i2c->bus);
+                i2c_end_transfer(s->bus);
             }
         }
         break;
-    case 2:
-        i2c->sdata = value;
-        break;
     case 4:
         i2c->lmadr = value;
-        if (i2c_bus_busy(i2c->bus)) {
-            i2c_end_transfer(i2c->bus);
+        if (i2c_bus_busy(s->bus)) {
+            i2c_end_transfer(s->bus);
         }
         break;
     case 5:
@@ -245,12 +253,12 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
         i2c->cntl = value;
         if (i2c->cntl & IIC_CNTL_PT) {
             if (i2c->cntl & IIC_CNTL_READ) {
-                if (i2c_bus_busy(i2c->bus)) {
+                if (i2c_bus_busy(s->bus)) {
                     /* end previous transfer */
                     i2c->sts &= ~IIC_STS_PT;
-                    i2c_end_transfer(i2c->bus);
+                    i2c_end_transfer(s->bus);
                 }
-                if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)) {
+                if (i2c_start_transfer(s->bus, i2c->lmadr >> 1, 1)) {
                     /* if non zero is returned, the adress is not valid */
                     i2c->sts &= ~IIC_STS_PT;
                     i2c->sts |= IIC_STS_ERR;
@@ -294,7 +302,7 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
     case 15:
         if (value & IIC_XTCNTLSS_SRST) {
             /* Is it actually a full reset? U-Boot sets some regs before */
-            ppc4xx_i2c_reset(DEVICE(i2c));
+            ppc4xx_i2c_reset(DEVICE(s));
             break;
         }
         i2c->xtcntlss = value;
@@ -302,9 +310,6 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
     case 16:
         i2c->directcntl = value & 0x7;
         break;
-    case 17:
-        i2c->intr = value;
-        break;
     default:
         if (addr < PPC4xx_I2C_MEM_SIZE) {
             qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
@@ -330,7 +335,9 @@ static const MemoryRegionOps ppc4xx_i2c_ops = {
 static void ppc4xx_i2c_init(Object *o)
 {
     PPC4xxI2CState *s = PPC4xx_I2C(o);
+    PPC4xxI2CRegs *r = g_malloc0(sizeof(PPC4xxI2CRegs));
 
+    s->regs = r;
     memory_region_init_io(&s->iomem, OBJECT(s), &ppc4xx_i2c_ops, s,
                           TYPE_PPC4xx_I2C, PPC4xx_I2C_MEM_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index 3c60307..1d5ba0c 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2007 Jocelyn Mayer
  * Copyright (c) 2012 François Revol
- * Copyright (c) 2016 BALATON Zoltan
+ * Copyright (c) 2016-2018 BALATON Zoltan
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -37,27 +37,12 @@
 typedef struct PPC4xxI2CState {
     /*< private >*/
     SysBusDevice parent_obj;
+    void *regs;
 
     /*< public >*/
     I2CBus *bus;
     qemu_irq irq;
     MemoryRegion iomem;
-    uint8_t mdata;
-    uint8_t lmadr;
-    uint8_t hmadr;
-    uint8_t cntl;
-    uint8_t mdcntl;
-    uint8_t sts;
-    uint8_t extsts;
-    uint8_t sdata;
-    uint8_t lsadr;
-    uint8_t hsadr;
-    uint8_t clkdiv;
-    uint8_t intrmsk;
-    uint8_t xfrcnt;
-    uint8_t xtcntlss;
-    uint8_t directcntl;
-    uint8_t intr;
 } PPC4xxI2CState;
 
 #endif /* PPC4XX_I2C_H */
-- 
2.7.6
