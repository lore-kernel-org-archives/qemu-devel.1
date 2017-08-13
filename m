Received: from eggs.gnu.org ([2001:4830:134:3::10]:51824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh271-0007Pm-Qj
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh26y-0005uF-PY
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:03 -0400
Message-Id: <ec3cefa6be2cfafb8195f86780ef1a87f8503748.1502643878.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1502643878.git.balaton@eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Aug 2017 19:04:38 +0200
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 07/12] ppc4xx_i2c: Implement basic I2C
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

Enough to please U-Boot and make it able to detect SDRAM SPD EEPROMs

Signed-off-by: Fran=C3=A7ois Revol <revol@free.fr>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc4xx_i2c.c         | 214 +++++++++++++++++++++++++++++++++++++-=
------
 include/hw/i2c/ppc4xx_i2c.h |   5 ++
 2 files changed, 189 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/ppc4xx_i2c.c b/hw/ppc/ppc4xx_i2c.c
index fafbb34..0b088e6 100644
--- a/hw/ppc/ppc4xx_i2c.c
+++ b/hw/ppc/ppc4xx_i2c.c
@@ -2,6 +2,8 @@
  * PPC4xx I2C controller emulation
  *
  * Copyright (c) 2007 Jocelyn Mayer
+ * Copyright (c) 2012 Fran=C3=A7ois Revol
+ * Copyright (c) 2016 BALATON Zoltan
  *
  * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
  * of this software and associated documentation files (the "Software"),=
 to deal
@@ -25,25 +27,126 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/i2c/ppc4xx_i2c.h"
=20
 /*#define DEBUG_I2C*/
=20
-#define PPC4xx_I2C_MEM_SIZE 0x11
+#ifdef DEBUG_I2C
+#define DPRINTF(fmt, args...) printf("[%s]%s: " fmt, TYPE_PPC4xx_I2C, \
+                                     __func__, ##args);
+#else
+#define DPRINTF(fmt, args...)
+#endif
+
+#define PPC4xx_I2C_MEM_SIZE 0x12
+
+#define IIC_CNTL_PT         (1 << 0)
+#define IIC_CNTL_READ       (1 << 1)
+#define IIC_CNTL_CHT        (1 << 2)
+#define IIC_CNTL_RPST       (1 << 3)
+
+#define IIC_STS_PT          (1 << 0)
+#define IIC_STS_ERR         (1 << 2)
+#define IIC_STS_MDBS        (1 << 5)
+
+#define IIC_EXTSTS_XFRA     (1 << 0)
+
+#define IIC_XTCNTLSS_SRST   (1 << 0)
+
+static void ppc4xx_i2c_reset(DeviceState *s)
+{
+    PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
+
+    /* FIXME: Should also reset bus?
+     *if (s->address !=3D ADDR_RESET) {
+     *    i2c_end_transfer(s->bus);
+     *}
+     */
+
+    i2c->mdata =3D 0;
+    i2c->lmadr =3D 0;
+    i2c->hmadr =3D 0;
+    i2c->cntl =3D 0;
+    i2c->mdcntl =3D 0;
+    i2c->sts =3D 0;
+    i2c->extsts =3D 0x8f;
+    i2c->sdata =3D 0;
+    i2c->lsadr =3D 0;
+    i2c->hsadr =3D 0;
+    i2c->clkdiv =3D 0;
+    i2c->intrmsk =3D 0;
+    i2c->xfrcnt =3D 0;
+    i2c->xtcntlss =3D 0;
+    i2c->directcntl =3D 0x0f;
+    i2c->intr =3D 0;
+}
+
+static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
+{
+    return true;
+}
=20
 static uint8_t ppc4xx_i2c_readb(PPC4xxI2CState *i2c, hwaddr addr)
 {
-    uint8_t ret;
+    int ret;
=20
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
     switch (addr) {
     case 0x00:
-        /*i2c_readbyte(&i2c->mdata);*/
         ret =3D i2c->mdata;
+        if (ppc4xx_i2c_is_master(i2c)) {
+            ret =3D 0xff;
+
+            if (!(i2c->sts & IIC_STS_MDBS)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Trying to read "
+                              "without starting transfer\n",
+                              TYPE_PPC4xx_I2C, __func__);
+            } else {
+                int pending =3D (i2c->cntl >> 4) & 3;
+
+                /* get the next byte */
+                ret =3D i2c_recv(i2c->bus);
+                DPRINTF("received byte %04x\n", ret);
+
+                if (ret < 0) {
+                    qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: read failed =
"
+                                  "for device 0x%02x\n", TYPE_PPC4xx_I2C=
,
+                                  __func__, i2c->lmadr);
+                    ret =3D 0xff;
+                } else {
+                    /* Raise interrupt if enabled */
+                    /*ppc4xx_i2c_raise_interrupt(i2c)*/;
+                }
+
+                if (!pending) {
+                    i2c->sts &=3D ~IIC_STS_MDBS;
+                    /*i2c_end_transfer(i2c->bus);*/
+                /*} else if (i2c->cntl & (IIC_CNTL_RPST | IIC_CNTL_CHT))=
 {*/
+                } else if (pending) {
+                    /* current smbus implementation doesn't like
+                       multibyte xfer repeated start */
+                    i2c_end_transfer(i2c->bus);
+                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)=
) {
+                        /* if non zero is returned, the adress is not va=
lid */
+                        i2c->sts &=3D ~IIC_STS_PT;
+                        i2c->sts |=3D IIC_STS_ERR;
+                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
+                    } else {
+                        /*i2c->sts |=3D IIC_STS_PT;*/
+                        i2c->sts |=3D IIC_STS_MDBS;
+                        i2c->sts &=3D ~IIC_STS_ERR;
+                        i2c->extsts =3D 0;
+                    }
+                }
+                pending--;
+                i2c->cntl =3D (i2c->cntl & 0xcf) | (pending << 4);
+            }
+        } else {
+            qemu_log_mask(LOG_UNIMP, "[%s]%s: slave mode not implemented=
\n",
+                          TYPE_PPC4xx_I2C, __func__);
+        }
         break;
     case 0x02:
         ret =3D i2c->sdata;
@@ -87,39 +190,88 @@ static uint8_t ppc4xx_i2c_readb(PPC4xxI2CState *i2c,=
 hwaddr addr)
     case 0x10:
         ret =3D i2c->directcntl;
         break;
+    case 0x11:
+        ret =3D i2c->intr;
+        break;
     default:
-        ret =3D 0x00;
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad address at offset 0x=
%"
+                      HWADDR_PRIx "\n", TYPE_PPC4xx_I2C, __func__, addr)=
;
+        ret =3D 0;
         break;
     }
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " %02" PRIx32 "\n", __func__, addr=
, ret);
-#endif
=20
     return ret;
 }
=20
 static void ppc4xx_i2c_writeb(PPC4xxI2CState *i2c, hwaddr addr, uint8_t =
value)
 {
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n",
-           __func__, addr, value);
-#endif
     switch (addr) {
     case 0x00:
         i2c->mdata =3D value;
-        /*i2c_sendbyte(&i2c->mdata);*/
+        if (!i2c_bus_busy(i2c->bus)) {
+            /* assume we start a write transfer */
+            if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 0)) {
+                /* if non zero is returned, the adress is not valid */
+                i2c->sts &=3D ~IIC_STS_PT;
+                i2c->sts |=3D IIC_STS_ERR;
+                i2c->extsts |=3D IIC_EXTSTS_XFRA;
+            } else {
+                i2c->sts |=3D IIC_STS_PT;
+                i2c->sts &=3D ~IIC_STS_ERR;
+                i2c->extsts =3D 0;
+            }
+        }
+        if (i2c_bus_busy(i2c->bus)) {
+            DPRINTF("sending byte %02x\n", i2c->mdata);
+            if (i2c_send(i2c->bus, i2c->mdata)) {
+                /* if the target return non zero then end the transfer *=
/
+                i2c->sts &=3D ~IIC_STS_PT;
+                i2c->sts |=3D IIC_STS_ERR;
+                i2c->extsts |=3D IIC_EXTSTS_XFRA;
+                i2c_end_transfer(i2c->bus);
+            }
+        }
         break;
     case 0x02:
         i2c->sdata =3D value;
         break;
     case 0x04:
         i2c->lmadr =3D value;
+        if (i2c_bus_busy(i2c->bus)) {
+            i2c_end_transfer(i2c->bus);
+        }
+        DPRINTF("%s: device addr %02x\n", __func__, i2c->lmadr);
         break;
     case 0x05:
         i2c->hmadr =3D value;
         break;
     case 0x06:
         i2c->cntl =3D value;
+        if (i2c->cntl & IIC_CNTL_PT) {
+            if (i2c->cntl & IIC_CNTL_READ) {
+                DPRINTF("read xfer %d\n", ((i2c->cntl >> 4) & 3) + 1);
+                if (i2c_bus_busy(i2c->bus)) {
+                    /* end previous transfer */
+                    i2c->sts &=3D ~IIC_STS_PT;
+                    i2c_end_transfer(i2c->bus);
+                }
+                if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)) {
+                    /* if non zero is returned, the adress is not valid =
*/
+                    i2c->sts &=3D ~IIC_STS_PT;
+                    i2c->sts |=3D IIC_STS_ERR;
+                    i2c->extsts |=3D IIC_EXTSTS_XFRA;
+                } else {
+                    /*i2c->sts |=3D IIC_STS_PT;*/
+                    i2c->sts |=3D IIC_STS_MDBS;
+                    i2c->sts &=3D ~IIC_STS_ERR;
+                    i2c->extsts =3D 0;
+                }
+            } else {
+                DPRINTF("write xfer %d\n", ((i2c->cntl >> 4) & 3) + 1);
+                /* we actually already did the write transfer... */
+                i2c->sts &=3D ~IIC_STS_PT;
+            }
+        }
         break;
     case 0x07:
         i2c->mdcntl =3D value & 0xDF;
@@ -132,6 +284,7 @@ static void ppc4xx_i2c_writeb(PPC4xxI2CState *i2c, hw=
addr addr, uint8_t value)
         break;
     case 0x0A:
         i2c->lsadr =3D value;
+        /*i2c_set_slave_address(i2c->bus, i2c->lsadr);*/
         break;
     case 0x0B:
         i2c->hsadr =3D value;
@@ -146,11 +299,23 @@ static void ppc4xx_i2c_writeb(PPC4xxI2CState *i2c, =
hwaddr addr, uint8_t value)
         i2c->xfrcnt =3D value & 0x77;
         break;
     case 0x0F:
+        if (value & IIC_XTCNTLSS_SRST) {
+            /* Is it actually a full reset? U-Boot sets some regs before=
 */
+            ppc4xx_i2c_reset(DEVICE(i2c));
+            break;
+        }
         i2c->xtcntlss =3D value;
         break;
     case 0x10:
         i2c->directcntl =3D value & 0x7;
         break;
+    case 0x11:
+        i2c->intr =3D value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad address at offset 0x=
%"
+                      HWADDR_PRIx "\n", TYPE_PPC4xx_I2C, __func__, addr)=
;
+        break;
     }
 }
=20
@@ -160,10 +325,12 @@ static uint64_t ppc4xx_i2c_read(void *opaque, hwadd=
r addr, unsigned int size)
     int i;
     uint64_t ret =3D 0;
=20
+    DPRINTF("read I2C " TARGET_FMT_plx " size %u\n", addr, size);
     for (i =3D 0; i < size; i++) {
         ret <<=3D 8;
         ret |=3D ppc4xx_i2c_readb(s, addr + i);
     }
+    DPRINTF("read I2C " TARGET_FMT_plx " %02" PRIx64 "\n", addr, ret);
=20
     return ret;
 }
@@ -174,6 +341,8 @@ static void ppc4xx_i2c_write(void *opaque, hwaddr add=
r, uint64_t value,
     PPC4xxI2CState *s =3D PPC4xx_I2C(opaque);
     int i;
=20
+    DPRINTF("write I2C " TARGET_FMT_plx " size %u val %08" PRIx64 "\n",
+            addr, size, value);
     for (i =3D 0; i < size; i++) {
         ppc4xx_i2c_writeb(s, addr + i, value & 0xff);
         value >>=3D 8;
@@ -188,21 +357,6 @@ static const MemoryRegionOps ppc4xx_i2c_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
-static void ppc4xx_i2c_reset(DeviceState *s)
-{
-    PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
-
-    i2c->mdata =3D 0x00;
-    i2c->sdata =3D 0x00;
-    i2c->cntl =3D 0x00;
-    i2c->mdcntl =3D 0x00;
-    i2c->sts =3D 0x00;
-    i2c->extsts =3D 0x00;
-    i2c->clkdiv =3D 0x00;
-    i2c->xfrcnt =3D 0x00;
-    i2c->directcntl =3D 0x0F;
-}
-
 static void ppc4xx_i2c_init(Object *o)
 {
     PPC4xxI2CState *s =3D PPC4xx_I2C(o);
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index 7f1e6be..71fb392 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -2,6 +2,8 @@
  * PPC4xx I2C controller emulation
  *
  * Copyright (c) 2007 Jocelyn Mayer
+ * Copyright (c) 2012 Fran=C3=A7ois Revol
+ * Copyright (c) 2016 BALATON Zoltan
  *
  * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
  * of this software and associated documentation files (the "Software"),=
 to deal
@@ -28,6 +30,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/sysbus.h"
+#include "hw/i2c/i2c.h"
=20
 #define TYPE_PPC4xx_I2C "ppc4xx-i2c"
 #define PPC4xx_I2C(obj) OBJECT_CHECK(PPC4xxI2CState, (obj), TYPE_PPC4xx_=
I2C)
@@ -37,6 +40,7 @@ typedef struct PPC4xxI2CState {
     SysBusDevice parent_obj;
=20
     /*< public >*/
+    I2CBus *bus;
     qemu_irq irq;
     MemoryRegion iomem;
     uint8_t mdata;
@@ -54,6 +58,7 @@ typedef struct PPC4xxI2CState {
     uint8_t xfrcnt;
     uint8_t xtcntlss;
     uint8_t directcntl;
+    uint8_t intr;
 } PPC4xxI2CState;
=20
 #endif /* PPC4XX_I2C_H */
--=20
2.7.4
