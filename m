Received: from eggs.gnu.org ([2001:4830:134:3::10]:56511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMt-0004C1-SV
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMp-0000NM-9o
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:11 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:35 +1000
Message-Id: <20180821043343.7514-19-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/26] hw/ppc/ppc405_uc: Convert away from
 old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Peter Maydell <peter.maydell@linaro.org>

Convert the devices in ppc405_uc away from using the old_mmio
MemoryRegion accessors:

 * opba's 32-bit and 16-bit accessors were just calling the
   8-bit accessors and assembling a big-endian order number,
   which we can do by setting the .impl.max_access_size to 1
   and the endianness to DEVICE_BIG_ENDIAN, and letting the
   core memory code do the assembly
 * ppc405_gpio's accessors were all just stubs
 * ppc4xx_gpt's 8-bit and 16-bit accessors were treating the
   access as invalid, which we can do by setting the
   .valid.min_access_size and .valid.max_access_size fields

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc405_uc.c | 173 +++++++--------------------------------------
 1 file changed, 25 insertions(+), 148 deletions(-)

diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 4bd9fbcc1e..5c58415cf1 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -283,7 +283,7 @@ struct ppc4xx_opba_t {
     uint8_t pr;
 };
=20
-static uint32_t opba_readb (void *opaque, hwaddr addr)
+static uint64_t opba_readb(void *opaque, hwaddr addr, unsigned size)
 {
     ppc4xx_opba_t *opba;
     uint32_t ret;
@@ -307,8 +307,8 @@ static uint32_t opba_readb (void *opaque, hwaddr addr=
)
     return ret;
 }
=20
-static void opba_writeb (void *opaque,
-                         hwaddr addr, uint32_t value)
+static void opba_writeb(void *opaque, hwaddr addr, uint64_t value,
+                        unsigned size)
 {
     ppc4xx_opba_t *opba;
=20
@@ -328,61 +328,14 @@ static void opba_writeb (void *opaque,
         break;
     }
 }
-
-static uint32_t opba_readw (void *opaque, hwaddr addr)
-{
-    uint32_t ret;
-
-#ifdef DEBUG_OPBA
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
-    ret =3D opba_readb(opaque, addr) << 8;
-    ret |=3D opba_readb(opaque, addr + 1);
-
-    return ret;
-}
-
-static void opba_writew (void *opaque,
-                         hwaddr addr, uint32_t value)
-{
-#ifdef DEBUG_OPBA
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
-           value);
-#endif
-    opba_writeb(opaque, addr, value >> 8);
-    opba_writeb(opaque, addr + 1, value);
-}
-
-static uint32_t opba_readl (void *opaque, hwaddr addr)
-{
-    uint32_t ret;
-
-#ifdef DEBUG_OPBA
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
-    ret =3D opba_readb(opaque, addr) << 24;
-    ret |=3D opba_readb(opaque, addr + 1) << 16;
-
-    return ret;
-}
-
-static void opba_writel (void *opaque,
-                         hwaddr addr, uint32_t value)
-{
-#ifdef DEBUG_OPBA
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
-           value);
-#endif
-    opba_writeb(opaque, addr, value >> 24);
-    opba_writeb(opaque, addr + 1, value >> 16);
-}
-
 static const MemoryRegionOps opba_ops =3D {
-    .old_mmio =3D {
-        .read =3D { opba_readb, opba_readw, opba_readl, },
-        .write =3D { opba_writeb, opba_writew, opba_writel, },
-    },
-    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .read =3D opba_readb,
+    .write =3D opba_writeb,
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 1,
+    .valid.min_access_size =3D 1,
+    .valid.max_access_size =3D 4,
+    .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
 static void ppc4xx_opba_reset (void *opaque)
@@ -750,65 +703,27 @@ struct ppc405_gpio_t {
     uint32_t isr1l;
 };
=20
-static uint32_t ppc405_gpio_readb (void *opaque, hwaddr addr)
+static uint64_t ppc405_gpio_read(void *opaque, hwaddr addr, unsigned siz=
e)
 {
 #ifdef DEBUG_GPIO
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
+    printf("%s: addr " TARGET_FMT_plx " size %d\n", __func__, addr, size=
);
 #endif
=20
     return 0;
 }
=20
-static void ppc405_gpio_writeb (void *opaque,
-                                hwaddr addr, uint32_t value)
-{
-#ifdef DEBUG_GPIO
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
-           value);
-#endif
-}
-
-static uint32_t ppc405_gpio_readw (void *opaque, hwaddr addr)
+static void ppc405_gpio_write(void *opaque, hwaddr addr, uint64_t value,
+                              unsigned size)
 {
 #ifdef DEBUG_GPIO
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
-
-    return 0;
-}
-
-static void ppc405_gpio_writew (void *opaque,
-                                hwaddr addr, uint32_t value)
-{
-#ifdef DEBUG_GPIO
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
-           value);
-#endif
-}
-
-static uint32_t ppc405_gpio_readl (void *opaque, hwaddr addr)
-{
-#ifdef DEBUG_GPIO
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
-
-    return 0;
-}
-
-static void ppc405_gpio_writel (void *opaque,
-                                hwaddr addr, uint32_t value)
-{
-#ifdef DEBUG_GPIO
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
-           value);
+    printf("%s: addr " TARGET_FMT_plx " size %d val %08" PRIx32 "\n",
+           __func__, addr, size, value);
 #endif
 }
=20
 static const MemoryRegionOps ppc405_gpio_ops =3D {
-    .old_mmio =3D {
-        .read =3D { ppc405_gpio_readb, ppc405_gpio_readw, ppc405_gpio_re=
adl, },
-        .write =3D { ppc405_gpio_writeb, ppc405_gpio_writew, ppc405_gpio=
_writel, },
-    },
+    .read =3D ppc405_gpio_read,
+    .write =3D ppc405_gpio_write,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
@@ -1017,44 +932,6 @@ struct ppc4xx_gpt_t {
     uint32_t mask[5];
 };
=20
-static uint32_t ppc4xx_gpt_readb (void *opaque, hwaddr addr)
-{
-#ifdef DEBUG_GPT
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
-    /* XXX: generate a bus fault */
-    return -1;
-}
-
-static void ppc4xx_gpt_writeb (void *opaque,
-                               hwaddr addr, uint32_t value)
-{
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
-           value);
-#endif
-    /* XXX: generate a bus fault */
-}
-
-static uint32_t ppc4xx_gpt_readw (void *opaque, hwaddr addr)
-{
-#ifdef DEBUG_GPT
-    printf("%s: addr " TARGET_FMT_plx "\n", __func__, addr);
-#endif
-    /* XXX: generate a bus fault */
-    return -1;
-}
-
-static void ppc4xx_gpt_writew (void *opaque,
-                               hwaddr addr, uint32_t value)
-{
-#ifdef DEBUG_I2C
-    printf("%s: addr " TARGET_FMT_plx " val %08" PRIx32 "\n", __func__, =
addr,
-           value);
-#endif
-    /* XXX: generate a bus fault */
-}
-
 static int ppc4xx_gpt_compare (ppc4xx_gpt_t *gpt, int n)
 {
     /* XXX: TODO */
@@ -1107,7 +984,7 @@ static void ppc4xx_gpt_compute_timer (ppc4xx_gpt_t *=
gpt)
     /* XXX: TODO */
 }
=20
-static uint32_t ppc4xx_gpt_readl (void *opaque, hwaddr addr)
+static uint64_t ppc4xx_gpt_read(void *opaque, hwaddr addr, unsigned size=
)
 {
     ppc4xx_gpt_t *gpt;
     uint32_t ret;
@@ -1162,8 +1039,8 @@ static uint32_t ppc4xx_gpt_readl (void *opaque, hwa=
ddr addr)
     return ret;
 }
=20
-static void ppc4xx_gpt_writel (void *opaque,
-                               hwaddr addr, uint32_t value)
+static void ppc4xx_gpt_write(void *opaque, hwaddr addr, uint64_t value,
+                             unsigned size)
 {
     ppc4xx_gpt_t *gpt;
     int idx;
@@ -1225,10 +1102,10 @@ static void ppc4xx_gpt_writel (void *opaque,
 }
=20
 static const MemoryRegionOps gpt_ops =3D {
-    .old_mmio =3D {
-        .read =3D { ppc4xx_gpt_readb, ppc4xx_gpt_readw, ppc4xx_gpt_readl=
, },
-        .write =3D { ppc4xx_gpt_writeb, ppc4xx_gpt_writew, ppc4xx_gpt_wr=
itel, },
-    },
+    .read =3D ppc4xx_gpt_read,
+    .write =3D ppc4xx_gpt_write,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
--=20
2.17.1
