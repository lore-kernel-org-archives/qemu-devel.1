Received: from eggs.gnu.org ([2001:4830:134:3::10]:37143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUI-0003tl-Ky
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUH-0005av-NZ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:42 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUH-0005Zs-AX
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:41 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUG-0003Bn-1A
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:40 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:32:04 +0100
Message-Id: <20180820103212.2810-18-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/25] hw/timer/m48t59: Move away from old_mmio
 accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move the m48t59 device away from using old_mmio MemoryRegionOps
accessors.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-id: 20180802180602.22047-1-peter.maydell@linaro.org
---
 hw/timer/m48t59.c | 59 +++++++++--------------------------------------
 1 file changed, 11 insertions(+), 48 deletions(-)

diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index f2991762ab0..ca3ed445de7 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -493,66 +493,29 @@ static uint64_t NVRAM_readb(void *opaque, hwaddr addr, unsigned size)
     return retval;
 }
 
-static void nvram_writeb (void *opaque, hwaddr addr, uint32_t value)
-{
-    M48t59State *NVRAM = opaque;
-
-    m48t59_write(NVRAM, addr, value & 0xff);
-}
-
-static void nvram_writew (void *opaque, hwaddr addr, uint32_t value)
-{
-    M48t59State *NVRAM = opaque;
-
-    m48t59_write(NVRAM, addr, (value >> 8) & 0xff);
-    m48t59_write(NVRAM, addr + 1, value & 0xff);
-}
-
-static void nvram_writel (void *opaque, hwaddr addr, uint32_t value)
-{
-    M48t59State *NVRAM = opaque;
-
-    m48t59_write(NVRAM, addr, (value >> 24) & 0xff);
-    m48t59_write(NVRAM, addr + 1, (value >> 16) & 0xff);
-    m48t59_write(NVRAM, addr + 2, (value >> 8) & 0xff);
-    m48t59_write(NVRAM, addr + 3, value & 0xff);
-}
-
-static uint32_t nvram_readb (void *opaque, hwaddr addr)
+static uint64_t nvram_read(void *opaque, hwaddr addr, unsigned size)
 {
     M48t59State *NVRAM = opaque;
 
     return m48t59_read(NVRAM, addr);
 }
 
-static uint32_t nvram_readw (void *opaque, hwaddr addr)
+static void nvram_write(void *opaque, hwaddr addr, uint64_t value,
+                        unsigned size)
 {
     M48t59State *NVRAM = opaque;
-    uint32_t retval;
 
-    retval = m48t59_read(NVRAM, addr) << 8;
-    retval |= m48t59_read(NVRAM, addr + 1);
-    return retval;
-}
-
-static uint32_t nvram_readl (void *opaque, hwaddr addr)
-{
-    M48t59State *NVRAM = opaque;
-    uint32_t retval;
-
-    retval = m48t59_read(NVRAM, addr) << 24;
-    retval |= m48t59_read(NVRAM, addr + 1) << 16;
-    retval |= m48t59_read(NVRAM, addr + 2) << 8;
-    retval |= m48t59_read(NVRAM, addr + 3);
-    return retval;
+    return m48t59_write(NVRAM, addr, value);
 }
 
 static const MemoryRegionOps nvram_ops = {
-    .old_mmio = {
-        .read = { nvram_readb, nvram_readw, nvram_readl, },
-        .write = { nvram_writeb, nvram_writew, nvram_writel, },
-    },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .read = nvram_read,
+    .write = nvram_write,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 1,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static const VMStateDescription vmstate_m48t59 = {
-- 
2.18.0
