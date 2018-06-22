Received: from eggs.gnu.org ([2001:4830:134:3::10]:45784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPv-0000hh-Mc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPt-0003TY-C4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 20:35:18 +1000
Message-Id: <20180622103528.28598-16-david@gibson.dropbear.id.au>
In-Reply-To: <20180622103528.28598-1-david@gibson.dropbear.id.au>
References: <20180622103528.28598-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/25] ppc4xx_i2c: Remove unimplemented sdata
 and intr registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

We don't emulate slave mode so related registers are not needed.
[lh]sadr are only retained to avoid too many warnings and simplify
debugging but sdata is not even correct because device has a 4 byte
FIFO instead so just remove this unimplemented register for now.

The intr register is also not implemented correctly, it is for
diagnostics and normally not even visible on device without explicitly
enabling it. As no guests are known to need this remove it as well.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/i2c/ppc4xx_i2c.c         | 16 +---------------
 include/hw/i2c/ppc4xx_i2c.h |  4 +---
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index d1936dbdca..4e0aaae1fc 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2007 Jocelyn Mayer
  * Copyright (c) 2012 Fran=C3=A7ois Revol
- * Copyright (c) 2016 BALATON Zoltan
+ * Copyright (c) 2016-2018 BALATON Zoltan
  *
  * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
  * of this software and associated documentation files (the "Software"),=
 to deal
@@ -63,7 +63,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
     i2c->mdcntl =3D 0;
     i2c->sts =3D 0;
     i2c->extsts =3D 0x8f;
-    i2c->sdata =3D 0;
     i2c->lsadr =3D 0;
     i2c->hsadr =3D 0;
     i2c->clkdiv =3D 0;
@@ -71,7 +70,6 @@ static void ppc4xx_i2c_reset(DeviceState *s)
     i2c->xfrcnt =3D 0;
     i2c->xtcntlss =3D 0;
     i2c->directcntl =3D 0xf;
-    i2c->intr =3D 0;
 }
=20
 static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
@@ -139,9 +137,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr=
 addr, unsigned int size)
                           TYPE_PPC4xx_I2C, __func__);
         }
         break;
-    case 2:
-        ret =3D i2c->sdata;
-        break;
     case 4:
         ret =3D i2c->lmadr;
         break;
@@ -181,9 +176,6 @@ static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr=
 addr, unsigned int size)
     case 16:
         ret =3D i2c->directcntl;
         break;
-    case 17:
-        ret =3D i2c->intr;
-        break;
     default:
         if (addr < PPC4xx_I2C_MEM_SIZE) {
             qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
@@ -229,9 +221,6 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr ad=
dr, uint64_t value,
             }
         }
         break;
-    case 2:
-        i2c->sdata =3D value;
-        break;
     case 4:
         i2c->lmadr =3D value;
         if (i2c_bus_busy(i2c->bus)) {
@@ -302,9 +291,6 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr ad=
dr, uint64_t value,
     case 16:
         i2c->directcntl =3D value & 0x7;
         break;
-    case 17:
-        i2c->intr =3D value;
-        break;
     default:
         if (addr < PPC4xx_I2C_MEM_SIZE) {
             qemu_log_mask(LOG_UNIMP, "%s: Unimplemented register 0x%"
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index 3c603071bd..e4b6ded855 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2007 Jocelyn Mayer
  * Copyright (c) 2012 Fran=C3=A7ois Revol
- * Copyright (c) 2016 BALATON Zoltan
+ * Copyright (c) 2016-2018 BALATON Zoltan
  *
  * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
  * of this software and associated documentation files (the "Software"),=
 to deal
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
=20
 #endif /* PPC4XX_I2C_H */
--=20
2.17.1
