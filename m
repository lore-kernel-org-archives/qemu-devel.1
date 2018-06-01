Received: from eggs.gnu.org ([2001:4830:134:3::10]:37593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOknA-0007SR-AF
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOkn9-0000jT-5o
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:12:32 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Jun 2018 15:12:23 +0100
Message-Id: <20180601141223.26630-7-peter.maydell@linaro.org>
In-Reply-To: <20180601141223.26630-1-peter.maydell@linaro.org>
References: <20180601141223.26630-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 6/6] hw/char/parallel: Convert away from
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
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, qemu-block@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>

Convert the parallel device away from using the old_mmio field
of MemoryRegionOps. This change only affects the memory-mapped
variant, which is used by the MIPS Jazz boards 'magnum' and 'pica61'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/parallel.c | 50 ++++++++++------------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 1542d62201..35748e6c1b 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -554,56 +554,28 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
 }
 
 /* Memory mapped interface */
-static uint32_t parallel_mm_readb (void *opaque, hwaddr addr)
+static uint64_t parallel_mm_readfn(void *opaque, hwaddr addr, unsigned size)
 {
     ParallelState *s = opaque;
 
-    return parallel_ioport_read_sw(s, addr >> s->it_shift) & 0xFF;
+    return parallel_ioport_read_sw(s, addr >> s->it_shift) &
+        MAKE_64BIT_MASK(0, size * 8);
 }
 
-static void parallel_mm_writeb (void *opaque,
-                                hwaddr addr, uint32_t value)
+static void parallel_mm_writefn(void *opaque, hwaddr addr,
+                                uint64_t value, unsigned size)
 {
     ParallelState *s = opaque;
 
-    parallel_ioport_write_sw(s, addr >> s->it_shift, value & 0xFF);
-}
-
-static uint32_t parallel_mm_readw (void *opaque, hwaddr addr)
-{
-    ParallelState *s = opaque;
-
-    return parallel_ioport_read_sw(s, addr >> s->it_shift) & 0xFFFF;
-}
-
-static void parallel_mm_writew (void *opaque,
-                                hwaddr addr, uint32_t value)
-{
-    ParallelState *s = opaque;
-
-    parallel_ioport_write_sw(s, addr >> s->it_shift, value & 0xFFFF);
-}
-
-static uint32_t parallel_mm_readl (void *opaque, hwaddr addr)
-{
-    ParallelState *s = opaque;
-
-    return parallel_ioport_read_sw(s, addr >> s->it_shift);
-}
-
-static void parallel_mm_writel (void *opaque,
-                                hwaddr addr, uint32_t value)
-{
-    ParallelState *s = opaque;
-
-    parallel_ioport_write_sw(s, addr >> s->it_shift, value);
+    parallel_ioport_write_sw(s, addr >> s->it_shift,
+                             value & MAKE_64BIT_MASK(0, size * 8));
 }
 
 static const MemoryRegionOps parallel_mm_ops = {
-    .old_mmio = {
-        .read = { parallel_mm_readb, parallel_mm_readw, parallel_mm_readl },
-        .write = { parallel_mm_writeb, parallel_mm_writew, parallel_mm_writel },
-    },
+    .read = parallel_mm_readfn,
+    .write = parallel_mm_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.17.1
