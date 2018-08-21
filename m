Received: from eggs.gnu.org ([2001:4830:134:3::10]:56666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMx-0004GV-J5
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMu-0000SX-Hn
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:15 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:34 +1000
Message-Id: <20180821043343.7514-18-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/26] hw/ppc/ppc_boards: Don't use old_mmio for
 ref405ep_fpga
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

Switch the ref405ep_fpga device away from using the old_mmio
MemoryRegion accessors.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc405_boards.c | 60 +++++++-----------------------------------
 1 file changed, 10 insertions(+), 50 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 70111075b3..f5a9c24b6c 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -66,7 +66,7 @@ struct ref405ep_fpga_t {
     uint8_t reg1;
 };
=20
-static uint32_t ref405ep_fpga_readb (void *opaque, hwaddr addr)
+static uint64_t ref405ep_fpga_readb(void *opaque, hwaddr addr, unsigned =
size)
 {
     ref405ep_fpga_t *fpga;
     uint32_t ret;
@@ -87,8 +87,8 @@ static uint32_t ref405ep_fpga_readb (void *opaque, hwad=
dr addr)
     return ret;
 }
=20
-static void ref405ep_fpga_writeb (void *opaque,
-                                  hwaddr addr, uint32_t value)
+static void ref405ep_fpga_writeb(void *opaque, hwaddr addr, uint64_t val=
ue,
+                                 unsigned size)
 {
     ref405ep_fpga_t *fpga;
=20
@@ -105,54 +105,14 @@ static void ref405ep_fpga_writeb (void *opaque,
     }
 }
=20
-static uint32_t ref405ep_fpga_readw (void *opaque, hwaddr addr)
-{
-    uint32_t ret;
-
-    ret =3D ref405ep_fpga_readb(opaque, addr) << 8;
-    ret |=3D ref405ep_fpga_readb(opaque, addr + 1);
-
-    return ret;
-}
-
-static void ref405ep_fpga_writew (void *opaque,
-                                  hwaddr addr, uint32_t value)
-{
-    ref405ep_fpga_writeb(opaque, addr, (value >> 8) & 0xFF);
-    ref405ep_fpga_writeb(opaque, addr + 1, value & 0xFF);
-}
-
-static uint32_t ref405ep_fpga_readl (void *opaque, hwaddr addr)
-{
-    uint32_t ret;
-
-    ret =3D ref405ep_fpga_readb(opaque, addr) << 24;
-    ret |=3D ref405ep_fpga_readb(opaque, addr + 1) << 16;
-    ret |=3D ref405ep_fpga_readb(opaque, addr + 2) << 8;
-    ret |=3D ref405ep_fpga_readb(opaque, addr + 3);
-
-    return ret;
-}
-
-static void ref405ep_fpga_writel (void *opaque,
-                                  hwaddr addr, uint32_t value)
-{
-    ref405ep_fpga_writeb(opaque, addr, (value >> 24) & 0xFF);
-    ref405ep_fpga_writeb(opaque, addr + 1, (value >> 16) & 0xFF);
-    ref405ep_fpga_writeb(opaque, addr + 2, (value >> 8) & 0xFF);
-    ref405ep_fpga_writeb(opaque, addr + 3, value & 0xFF);
-}
-
 static const MemoryRegionOps ref405ep_fpga_ops =3D {
-    .old_mmio =3D {
-        .read =3D {
-            ref405ep_fpga_readb, ref405ep_fpga_readw, ref405ep_fpga_read=
l,
-        },
-        .write =3D {
-            ref405ep_fpga_writeb, ref405ep_fpga_writew, ref405ep_fpga_wr=
itel,
-        },
-    },
-    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .read =3D ref405ep_fpga_readb,
+    .write =3D ref405ep_fpga_writeb,
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 1,
+    .valid.min_access_size =3D 1,
+    .valid.max_access_size =3D 4,
+    .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
 static void ref405ep_fpga_reset (void *opaque)
--=20
2.17.1
