Received: from eggs.gnu.org ([2001:4830:134:3::10]:44996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zN-0007iK-DZ
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1el4zL-0006BD-19
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:41:09 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Feb 2018 14:40:45 +1100
Message-Id: <20180212034054.23441-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180212034054.23441-1-david@gibson.dropbear.id.au>
References: <20180212034054.23441-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 03/12] cuda: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/cuda.c | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 008d8bd4d5..6631017ca2 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -275,7 +275,7 @@ static void cuda_delay_set_sr_int(CUDAState *s)
     timer_mod(s->sr_delay_timer, expire);
 }
 
-static uint32_t cuda_readb(void *opaque, hwaddr addr)
+static uint64_t cuda_read(void *opaque, hwaddr addr, unsigned size)
 {
     CUDAState *s = opaque;
     uint32_t val;
@@ -350,7 +350,7 @@ static uint32_t cuda_readb(void *opaque, hwaddr addr)
     return val;
 }
 
-static void cuda_writeb(void *opaque, hwaddr addr, uint32_t val)
+static void cuda_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 {
     CUDAState *s = opaque;
 
@@ -780,38 +780,14 @@ static void cuda_receive_packet_from_host(CUDAState *s,
     }
 }
 
-static void cuda_writew (void *opaque, hwaddr addr, uint32_t value)
-{
-}
-
-static void cuda_writel (void *opaque, hwaddr addr, uint32_t value)
-{
-}
-
-static uint32_t cuda_readw (void *opaque, hwaddr addr)
-{
-    return 0;
-}
-
-static uint32_t cuda_readl (void *opaque, hwaddr addr)
-{
-    return 0;
-}
-
 static const MemoryRegionOps cuda_ops = {
-    .old_mmio = {
-        .write = {
-            cuda_writeb,
-            cuda_writew,
-            cuda_writel,
-        },
-        .read = {
-            cuda_readb,
-            cuda_readw,
-            cuda_readl,
-        },
+    .read = cuda_read,
+    .write = cuda_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
 static bool cuda_timer_exist(void *opaque, int version_id)
-- 
2.14.3
