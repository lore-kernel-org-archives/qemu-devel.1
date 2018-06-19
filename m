Received: from eggs.gnu.org ([2001:4830:134:3::10]:33527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVChS-0003fB-Jz
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVChN-00084i-Pa
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:13:18 -0400
Message-Id: <b28d3ac4d357b86a1b4c9c868e148396857c36da.1529398335.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1529398335.git.balaton@eik.bme.hu>
References: <cover.1529398335.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 19 Jun 2018 10:52:15 +0200
Subject: [Qemu-devel] [PATCH v4 01/11] ppc4xx_i2c: Remove unimplemented
 sdata and intr registers
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

We don't emulate slave mode so related registers are not needed.
[lh]sadr are only retained to avoid too many warnings and simplify
debugging but sdata is not even correct because device has a 4 byte
FIFO instead so just remove this unimplemented register for now.

The intr register is also not implemented correctly, it is for
diagnostics and normally not even visible on device without explicitly
enabling it. As no guests are known to need this remove it as well.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v4: Updated commit message

 hw/i2c/ppc4xx_i2c.c         | 16 +---------------
 include/hw/i2c/ppc4xx_i2c.h |  4 +---
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index d1936db..4e0aaae 100644
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
@@ -63,7 +63,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
     i2c->mdcntl = 0;
     i2c->sts = 0;
     i2c->extsts = 0x8f;
-    i2c->sdata = 0;
     i2c->lsadr = 0;
     i2c->hsadr = 0;
     i2c->clkdiv = 0;
@@ -71,7 +70,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
     i2c->xfrcnt = 0;
     i2c->xtcntlss = 0;
     i2c->directcntl = 0xf;
-    i2c->intr = 0;
 }
 
 static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
@@ -139,9 +137,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
                           TYPE_PPC4xx_I2C, __func__);
         }
         break;
-    case 2:
-        ret = i2c->sdata;
-        break;
     case 4:
         ret = i2c->lmadr;
         break;
@@ -181,9 +176,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int size)
     case 16:
         ret = i2c->directcntl;
         break;
-    case 17:
-        ret = i2c->intr;
-        break;
     default:
         if (addr < PPC4xx_I2C_MEM_SIZE) {
             qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
@@ -229,9 +221,6 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
             }
         }
         break;
-    case 2:
-        i2c->sdata = value;
-        break;
     case 4:
         i2c->lmadr = value;
         if (i2c_bus_busy(i2c->bus)) {
@@ -302,9 +291,6 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
     case 16:
         i2c->directcntl = value & 0x7;
         break;
-    case 17:
-        i2c->intr = value;
-        break;
     default:
         if (addr < PPC4xx_I2C_MEM_SIZE) {
             qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index 3c60307..e4b6ded 100644
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
@@ -49,7 +49,6 @@ typedef struct PPC4xxI2CState {
     uint8_t mdcntl;
     uint8_t sts;
     uint8_t extsts;
-    uint8_t sdata;
     uint8_t lsadr;
     uint8_t hsadr;
     uint8_t clkdiv;
@@ -57,7 +56,6 @@ typedef struct PPC4xxI2CState {
     uint8_t xfrcnt;
     uint8_t xtcntlss;
     uint8_t directcntl;
-    uint8_t intr;
 } PPC4xxI2CState;
 
 #endif /* PPC4XX_I2C_H */
-- 
2.7.6
