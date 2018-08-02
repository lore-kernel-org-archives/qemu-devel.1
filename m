Received: from eggs.gnu.org ([2001:4830:134:3::10]:38606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flF01-0007EL-Fk
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flF00-00031S-Kz
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:54:45 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Aug 2018 15:44:29 +0100
Message-Id: <20180802144430.13870-3-peter.maydell@linaro.org>
In-Reply-To: <20180802144430.13870-1-peter.maydell@linaro.org>
References: <20180802144430.13870-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/3] hw/ppc/ppc_boards: Don't use old_mmio for
 ref405ep_fpga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-ppc@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

Switch the ref405ep_fpga device away from using the old_mmio
MemoryRegion accessors.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ppc/ppc405_boards.c | 60 +++++++-----------------------------------
 1 file changed, 10 insertions(+), 50 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 70111075b33..f5a9c24b6ce 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -66,7 +66,7 @@ struct ref405ep_fpga_t {
     uint8_t reg1;
 };
 
-static uint32_t ref405ep_fpga_readb (void *opaque, hwaddr addr)
+static uint64_t ref405ep_fpga_readb(void *opaque, hwaddr addr, unsigned size)
 {
     ref405ep_fpga_t *fpga;
     uint32_t ret;
@@ -87,8 +87,8 @@ static uint32_t ref405ep_fpga_readb (void *opaque, hwaddr addr)
     return ret;
 }
 
-static void ref405ep_fpga_writeb (void *opaque,
-                                  hwaddr addr, uint32_t value)
+static void ref405ep_fpga_writeb(void *opaque, hwaddr addr, uint64_t value,
+                                 unsigned size)
 {
     ref405ep_fpga_t *fpga;
 
@@ -105,54 +105,14 @@ static void ref405ep_fpga_writeb (void *opaque,
     }
 }
 
-static uint32_t ref405ep_fpga_readw (void *opaque, hwaddr addr)
-{
-    uint32_t ret;
-
-    ret = ref405ep_fpga_readb(opaque, addr) << 8;
-    ret |= ref405ep_fpga_readb(opaque, addr + 1);
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
-    ret = ref405ep_fpga_readb(opaque, addr) << 24;
-    ret |= ref405ep_fpga_readb(opaque, addr + 1) << 16;
-    ret |= ref405ep_fpga_readb(opaque, addr + 2) << 8;
-    ret |= ref405ep_fpga_readb(opaque, addr + 3);
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
 static const MemoryRegionOps ref405ep_fpga_ops = {
-    .old_mmio = {
-        .read = {
-            ref405ep_fpga_readb, ref405ep_fpga_readw, ref405ep_fpga_readl,
-        },
-        .write = {
-            ref405ep_fpga_writeb, ref405ep_fpga_writew, ref405ep_fpga_writel,
-        },
-    },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .read = ref405ep_fpga_readb,
+    .write = ref405ep_fpga_writeb,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 1,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void ref405ep_fpga_reset (void *opaque)
-- 
2.17.1
