Received: from eggs.gnu.org ([2001:4830:134:3::10]:39986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKa-0002wC-Va
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKX-00074E-46
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:55 +1000
Message-Id: <20180703055804.13449-27-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/35] ppc4xx_i2c: Rewrite to model hardware
 more closely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Rewrite to make it closer to how real device works so that guest OS
drivers can access I2C devices. Previously this was only a hack to
allow U-Boot to get past accessing SPD EEPROMs but to support other
I2C devices and allow guests to access them we need to model real
device more properly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/i2c/ppc4xx_i2c.c         | 299 +++++++++++++++++++-----------------
 include/hw/i2c/ppc4xx_i2c.h |   3 +-
 2 files changed, 159 insertions(+), 143 deletions(-)

diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index fca80d695a..d6dfafab31 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -34,16 +34,50 @@
=20
 #define PPC4xx_I2C_MEM_SIZE 18
=20
+enum {
+    IIC_MDBUF =3D 0,
+    /* IIC_SDBUF =3D 2, */
+    IIC_LMADR =3D 4,
+    IIC_HMADR,
+    IIC_CNTL,
+    IIC_MDCNTL,
+    IIC_STS,
+    IIC_EXTSTS,
+    IIC_LSADR,
+    IIC_HSADR,
+    IIC_CLKDIV,
+    IIC_INTRMSK,
+    IIC_XFRCNT,
+    IIC_XTCNTLSS,
+    IIC_DIRECTCNTL
+    /* IIC_INTR */
+};
+
 #define IIC_CNTL_PT         (1 << 0)
 #define IIC_CNTL_READ       (1 << 1)
 #define IIC_CNTL_CHT        (1 << 2)
 #define IIC_CNTL_RPST       (1 << 3)
+#define IIC_CNTL_AMD        (1 << 6)
+#define IIC_CNTL_HMT        (1 << 7)
+
+#define IIC_MDCNTL_EINT     (1 << 2)
+#define IIC_MDCNTL_ESM      (1 << 3)
+#define IIC_MDCNTL_FMDB     (1 << 6)
=20
 #define IIC_STS_PT          (1 << 0)
+#define IIC_STS_IRQA        (1 << 1)
 #define IIC_STS_ERR         (1 << 2)
+#define IIC_STS_MDBF        (1 << 4)
 #define IIC_STS_MDBS        (1 << 5)
=20
 #define IIC_EXTSTS_XFRA     (1 << 0)
+#define IIC_EXTSTS_BCS_FREE (4 << 4)
+#define IIC_EXTSTS_BCS_BUSY (5 << 4)
+
+#define IIC_INTRMSK_EIMTC   (1 << 0)
+#define IIC_INTRMSK_EITA    (1 << 1)
+#define IIC_INTRMSK_EIIC    (1 << 2)
+#define IIC_INTRMSK_EIHE    (1 << 3)
=20
 #define IIC_XTCNTLSS_SRST   (1 << 0)
=20
@@ -56,130 +90,83 @@ static void ppc4xx_i2c_reset(DeviceState *s)
 {
     PPC4xxI2CState *i2c =3D PPC4xx_I2C(s);
=20
-    /* FIXME: Should also reset bus?
-     *if (s->address !=3D ADDR_RESET) {
-     *    i2c_end_transfer(s->bus);
-     *}
-     */
-
-    i2c->mdata =3D 0;
-    i2c->lmadr =3D 0;
-    i2c->hmadr =3D 0;
+    i2c->mdidx =3D -1;
+    memset(i2c->mdata, 0, ARRAY_SIZE(i2c->mdata));
+    /* [hl][ms]addr are not affected by reset */
     i2c->cntl =3D 0;
     i2c->mdcntl =3D 0;
     i2c->sts =3D 0;
-    i2c->extsts =3D 0x8f;
-    i2c->lsadr =3D 0;
-    i2c->hsadr =3D 0;
+    i2c->extsts =3D IIC_EXTSTS_BCS_FREE;
     i2c->clkdiv =3D 0;
     i2c->intrmsk =3D 0;
     i2c->xfrcnt =3D 0;
     i2c->xtcntlss =3D 0;
-    i2c->directcntl =3D 0xf;
-}
-
-static inline bool ppc4xx_i2c_is_master(PPC4xxI2CState *i2c)
-{
-    return true;
+    i2c->directcntl =3D 0xf; /* all non-reserved bits set */
 }
=20
 static uint64_t ppc4xx_i2c_readb(void *opaque, hwaddr addr, unsigned int=
 size)
 {
     PPC4xxI2CState *i2c =3D PPC4xx_I2C(opaque);
     uint64_t ret;
+    int i;
=20
     switch (addr) {
-    case 0:
-        ret =3D i2c->mdata;
-        if (ppc4xx_i2c_is_master(i2c)) {
+    case IIC_MDBUF:
+        if (i2c->mdidx < 0) {
             ret =3D 0xff;
-
-            if (!(i2c->sts & IIC_STS_MDBS)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Trying to read "
-                              "without starting transfer\n",
-                              TYPE_PPC4xx_I2C, __func__);
-            } else {
-                int pending =3D (i2c->cntl >> 4) & 3;
-
-                /* get the next byte */
-                int byte =3D i2c_recv(i2c->bus);
-
-                if (byte < 0) {
-                    qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: read failed =
"
-                                  "for device 0x%02x\n", TYPE_PPC4xx_I2C=
,
-                                  __func__, i2c->lmadr);
-                    ret =3D 0xff;
-                } else {
-                    ret =3D byte;
-                    /* Raise interrupt if enabled */
-                    /*ppc4xx_i2c_raise_interrupt(i2c)*/;
-                }
-
-                if (!pending) {
-                    i2c->sts &=3D ~IIC_STS_MDBS;
-                    /*i2c_end_transfer(i2c->bus);*/
-                /*} else if (i2c->cntl & (IIC_CNTL_RPST | IIC_CNTL_CHT))=
 {*/
-                } else if (pending) {
-                    /* current smbus implementation doesn't like
-                       multibyte xfer repeated start */
-                    i2c_end_transfer(i2c->bus);
-                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)=
) {
-                        /* if non zero is returned, the adress is not va=
lid */
-                        i2c->sts &=3D ~IIC_STS_PT;
-                        i2c->sts |=3D IIC_STS_ERR;
-                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
-                    } else {
-                        /*i2c->sts |=3D IIC_STS_PT;*/
-                        i2c->sts |=3D IIC_STS_MDBS;
-                        i2c->sts &=3D ~IIC_STS_ERR;
-                        i2c->extsts =3D 0;
-                    }
-                }
-                pending--;
-                i2c->cntl =3D (i2c->cntl & 0xcf) | (pending << 4);
-            }
-        } else {
-            qemu_log_mask(LOG_UNIMP, "[%s]%s: slave mode not implemented=
\n",
-                          TYPE_PPC4xx_I2C, __func__);
+            break;
+        }
+        ret =3D i2c->mdata[0];
+        if (i2c->mdidx =3D=3D 3) {
+            i2c->sts &=3D ~IIC_STS_MDBF;
+        } else if (i2c->mdidx =3D=3D 0) {
+            i2c->sts &=3D ~IIC_STS_MDBS;
+        }
+        for (i =3D 0; i < i2c->mdidx; i++) {
+            i2c->mdata[i] =3D i2c->mdata[i + 1];
+        }
+        if (i2c->mdidx >=3D 0) {
+            i2c->mdidx--;
         }
         break;
-    case 4:
+    case IIC_LMADR:
         ret =3D i2c->lmadr;
         break;
-    case 5:
+    case IIC_HMADR:
         ret =3D i2c->hmadr;
         break;
-    case 6:
+    case IIC_CNTL:
         ret =3D i2c->cntl;
         break;
-    case 7:
+    case IIC_MDCNTL:
         ret =3D i2c->mdcntl;
         break;
-    case 8:
+    case IIC_STS:
         ret =3D i2c->sts;
         break;
-    case 9:
-        ret =3D i2c->extsts;
+    case IIC_EXTSTS:
+        ret =3D i2c_bus_busy(i2c->bus) ?
+              IIC_EXTSTS_BCS_BUSY : IIC_EXTSTS_BCS_FREE;
         break;
-    case 10:
+    case IIC_LSADR:
         ret =3D i2c->lsadr;
         break;
-    case 11:
+    case IIC_HSADR:
         ret =3D i2c->hsadr;
         break;
-    case 12:
+    case IIC_CLKDIV:
         ret =3D i2c->clkdiv;
         break;
-    case 13:
+    case IIC_INTRMSK:
         ret =3D i2c->intrmsk;
         break;
-    case 14:
+    case IIC_XFRCNT:
         ret =3D i2c->xfrcnt;
         break;
-    case 15:
+    case IIC_XTCNTLSS:
         ret =3D i2c->xtcntlss;
         break;
-    case 16:
+    case IIC_DIRECTCNTL:
         ret =3D i2c->directcntl;
         break;
     default:
@@ -202,99 +189,127 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr=
 addr, uint64_t value,
     PPC4xxI2CState *i2c =3D opaque;
=20
     switch (addr) {
-    case 0:
-        i2c->mdata =3D value;
-        if (!i2c_bus_busy(i2c->bus)) {
-            /* assume we start a write transfer */
-            if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 0)) {
-                /* if non zero is returned, the adress is not valid */
-                i2c->sts &=3D ~IIC_STS_PT;
-                i2c->sts |=3D IIC_STS_ERR;
-                i2c->extsts |=3D IIC_EXTSTS_XFRA;
-            } else {
-                i2c->sts |=3D IIC_STS_PT;
-                i2c->sts &=3D ~IIC_STS_ERR;
-                i2c->extsts =3D 0;
-            }
+    case IIC_MDBUF:
+        if (i2c->mdidx >=3D 3) {
+            break;
         }
-        if (i2c_bus_busy(i2c->bus)) {
-            if (i2c_send(i2c->bus, i2c->mdata)) {
-                /* if the target return non zero then end the transfer *=
/
-                i2c->sts &=3D ~IIC_STS_PT;
-                i2c->sts |=3D IIC_STS_ERR;
-                i2c->extsts |=3D IIC_EXTSTS_XFRA;
-                i2c_end_transfer(i2c->bus);
-            }
+        i2c->mdata[++i2c->mdidx] =3D value;
+        if (i2c->mdidx =3D=3D 3) {
+            i2c->sts |=3D IIC_STS_MDBF;
+        } else if (i2c->mdidx =3D=3D 0) {
+            i2c->sts |=3D IIC_STS_MDBS;
         }
         break;
-    case 4:
+    case IIC_LMADR:
         i2c->lmadr =3D value;
-        if (i2c_bus_busy(i2c->bus)) {
-            i2c_end_transfer(i2c->bus);
-        }
         break;
-    case 5:
+    case IIC_HMADR:
         i2c->hmadr =3D value;
         break;
-    case 6:
-        i2c->cntl =3D value;
-        if (i2c->cntl & IIC_CNTL_PT) {
-            if (i2c->cntl & IIC_CNTL_READ) {
-                if (i2c_bus_busy(i2c->bus)) {
-                    /* end previous transfer */
-                    i2c->sts &=3D ~IIC_STS_PT;
-                    i2c_end_transfer(i2c->bus);
+    case IIC_CNTL:
+        i2c->cntl =3D value & ~IIC_CNTL_PT;
+        if (value & IIC_CNTL_AMD) {
+            qemu_log_mask(LOG_UNIMP, "%s: only 7 bit addresses supported=
\n",
+                          __func__);
+        }
+        if (value & IIC_CNTL_HMT && i2c_bus_busy(i2c->bus)) {
+            i2c_end_transfer(i2c->bus);
+            if (i2c->mdcntl & IIC_MDCNTL_EINT &&
+                i2c->intrmsk & IIC_INTRMSK_EIHE) {
+                i2c->sts |=3D IIC_STS_IRQA;
+                qemu_irq_raise(i2c->irq);
+            }
+        } else if (value & IIC_CNTL_PT) {
+            int recv =3D (value & IIC_CNTL_READ) >> 1;
+            int tct =3D value >> 4 & 3;
+            int i;
+
+            if (recv && (i2c->lmadr >> 1) >=3D 0x50 && (i2c->lmadr >> 1)=
 < 0x58) {
+                /* smbus emulation does not like multi byte reads w/o re=
start */
+                value |=3D IIC_CNTL_RPST;
+            }
+
+            for (i =3D 0; i <=3D tct; i++) {
+                if (!i2c_bus_busy(i2c->bus)) {
+                    i2c->extsts =3D IIC_EXTSTS_BCS_FREE;
+                    if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, re=
cv)) {
+                        i2c->sts |=3D IIC_STS_ERR;
+                        i2c->extsts |=3D IIC_EXTSTS_XFRA;
+                        break;
+                    } else {
+                        i2c->sts &=3D ~IIC_STS_ERR;
+                    }
                 }
-                if (i2c_start_transfer(i2c->bus, i2c->lmadr >> 1, 1)) {
-                    /* if non zero is returned, the adress is not valid =
*/
-                    i2c->sts &=3D ~IIC_STS_PT;
+                if (!(i2c->sts & IIC_STS_ERR) &&
+                    i2c_send_recv(i2c->bus, &i2c->mdata[i], !recv)) {
                     i2c->sts |=3D IIC_STS_ERR;
                     i2c->extsts |=3D IIC_EXTSTS_XFRA;
-                } else {
-                    /*i2c->sts |=3D IIC_STS_PT;*/
-                    i2c->sts |=3D IIC_STS_MDBS;
-                    i2c->sts &=3D ~IIC_STS_ERR;
-                    i2c->extsts =3D 0;
+                    break;
+                }
+                if (value & IIC_CNTL_RPST || !(value & IIC_CNTL_CHT)) {
+                    i2c_end_transfer(i2c->bus);
                 }
-            } else {
-                /* we actually already did the write transfer... */
-                i2c->sts &=3D ~IIC_STS_PT;
+            }
+            i2c->xfrcnt =3D i;
+            i2c->mdidx =3D i - 1;
+            if (recv && i2c->mdidx >=3D 0) {
+                i2c->sts |=3D IIC_STS_MDBS;
+            }
+            if (recv && i2c->mdidx =3D=3D 3) {
+                i2c->sts |=3D IIC_STS_MDBF;
+            }
+            if (i && i2c->mdcntl & IIC_MDCNTL_EINT &&
+                i2c->intrmsk & IIC_INTRMSK_EIMTC) {
+                i2c->sts |=3D IIC_STS_IRQA;
+                qemu_irq_raise(i2c->irq);
             }
         }
         break;
-    case 7:
-        i2c->mdcntl =3D value & 0xdf;
+    case IIC_MDCNTL:
+        i2c->mdcntl =3D value & 0x3d;
+        if (value & IIC_MDCNTL_ESM) {
+            qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
+                          __func__);
+        }
+        if (value & IIC_MDCNTL_FMDB) {
+            i2c->mdidx =3D -1;
+            memset(i2c->mdata, 0, ARRAY_SIZE(i2c->mdata));
+            i2c->sts &=3D ~(IIC_STS_MDBF | IIC_STS_MDBS);
+        }
         break;
-    case 8:
-        i2c->sts &=3D ~(value & 0xa);
+    case IIC_STS:
+        i2c->sts &=3D ~(value & 0x0a);
+        if (value & IIC_STS_IRQA && i2c->mdcntl & IIC_MDCNTL_EINT) {
+            qemu_irq_lower(i2c->irq);
+        }
         break;
-    case 9:
+    case IIC_EXTSTS:
         i2c->extsts &=3D ~(value & 0x8f);
         break;
-    case 10:
+    case IIC_LSADR:
         i2c->lsadr =3D value;
         break;
-    case 11:
+    case IIC_HSADR:
         i2c->hsadr =3D value;
         break;
-    case 12:
+    case IIC_CLKDIV:
         i2c->clkdiv =3D value;
         break;
-    case 13:
+    case IIC_INTRMSK:
         i2c->intrmsk =3D value;
         break;
-    case 14:
+    case IIC_XFRCNT:
         i2c->xfrcnt =3D value & 0x77;
         break;
-    case 15:
+    case IIC_XTCNTLSS:
+        i2c->xtcntlss &=3D ~(value & 0xf0);
         if (value & IIC_XTCNTLSS_SRST) {
             /* Is it actually a full reset? U-Boot sets some regs before=
 */
             ppc4xx_i2c_reset(DEVICE(i2c));
             break;
         }
-        i2c->xtcntlss =3D value;
         break;
-    case 16:
+    case IIC_DIRECTCNTL:
         i2c->directcntl =3D value & (IIC_DIRECTCNTL_SDAC & IIC_DIRECTCNT=
L_SCLC);
         i2c->directcntl |=3D (value & IIC_DIRECTCNTL_SCLC ? 1 : 0);
         bitbang_i2c_set(i2c->bitbang, BITBANG_I2C_SCL,
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index ea6c8e1a58..0891a9c948 100644
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
--=20
2.17.1
