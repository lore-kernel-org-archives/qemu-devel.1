Received: from eggs.gnu.org ([2001:4830:134:3::10]:50427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCh-0001ym-NG
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvCf-0008Sk-6h
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:51 -0500
Received: from chuckie.co.uk ([82.165.15.123]:36238
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ehvCe-0008Pn-T3
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:37:49 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat,  3 Feb 2018 10:37:18 +0000
Message-Id: <20180203103727.26457-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 01/10] cuda: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 008d8bd4d5..23b7e0f5b0 100644
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
-    },
+    .read = cuda_read,
+    .write = cuda_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
 };
 
 static bool cuda_timer_exist(void *opaque, int version_id)
-- 
2.11.0
