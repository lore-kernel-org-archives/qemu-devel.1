Received: from eggs.gnu.org ([2001:4830:134:3::10]:60779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfV-0001cp-JV
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfT-0006Dx-So
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfT-00065w-LI
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfK-0003cB-Ch
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:26 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:43 +0100
Message-Id: <20180615142521.19143-6-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/43] hw/block/pflash_cfi02: Convert away from
 old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Convert the pflash_cfi02 device away from using the old_mmio field
of MemoryRegionOps.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180601141223.26630-4-peter.maydell@linaro.org
---
 hw/block/pflash_cfi02.c | 97 ++++++++---------------------------------
 1 file changed, 18 insertions(+), 79 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index a8b3f7f9780..6c18e5e5786 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -493,102 +493,41 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
     pfl->cmd = 0;
 }
 
-
-static uint32_t pflash_readb_be(void *opaque, hwaddr addr)
+static uint64_t pflash_be_readfn(void *opaque, hwaddr addr, unsigned size)
 {
-    return pflash_read(opaque, addr, 1, 1);
+    return pflash_read(opaque, addr, size, 1);
 }
 
-static uint32_t pflash_readb_le(void *opaque, hwaddr addr)
+static void pflash_be_writefn(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned size)
 {
-    return pflash_read(opaque, addr, 1, 0);
+    pflash_write(opaque, addr, value, size, 1);
 }
 
-static uint32_t pflash_readw_be(void *opaque, hwaddr addr)
+static uint64_t pflash_le_readfn(void *opaque, hwaddr addr, unsigned size)
 {
-    pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 2, 1);
+    return pflash_read(opaque, addr, size, 0);
 }
 
-static uint32_t pflash_readw_le(void *opaque, hwaddr addr)
+static void pflash_le_writefn(void *opaque, hwaddr addr,
+                              uint64_t value, unsigned size)
 {
-    pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 2, 0);
-}
-
-static uint32_t pflash_readl_be(void *opaque, hwaddr addr)
-{
-    pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 4, 1);
-}
-
-static uint32_t pflash_readl_le(void *opaque, hwaddr addr)
-{
-    pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 4, 0);
-}
-
-static void pflash_writeb_be(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_write(opaque, addr, value, 1, 1);
-}
-
-static void pflash_writeb_le(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_write(opaque, addr, value, 1, 0);
-}
-
-static void pflash_writew_be(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 2, 1);
-}
-
-static void pflash_writew_le(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 2, 0);
-}
-
-static void pflash_writel_be(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 4, 1);
-}
-
-static void pflash_writel_le(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 4, 0);
+    pflash_write(opaque, addr, value, size, 0);
 }
 
 static const MemoryRegionOps pflash_cfi02_ops_be = {
-    .old_mmio = {
-        .read = { pflash_readb_be, pflash_readw_be, pflash_readl_be, },
-        .write = { pflash_writeb_be, pflash_writew_be, pflash_writel_be, },
-    },
+    .read = pflash_be_readfn,
+    .write = pflash_be_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
 static const MemoryRegionOps pflash_cfi02_ops_le = {
-    .old_mmio = {
-        .read = { pflash_readb_le, pflash_readw_le, pflash_readl_le, },
-        .write = { pflash_writeb_le, pflash_writew_le, pflash_writel_le, },
-    },
+    .read = pflash_le_readfn,
+    .write = pflash_le_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.17.1
