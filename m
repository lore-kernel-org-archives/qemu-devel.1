Received: from eggs.gnu.org ([2001:4830:134:3::10]:46613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWPRN-00080l-3f
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWPRK-0004Pb-Ln
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:33:56 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gWPRK-0004Oe-Cg
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:33:54 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 17:33:50 +0000
Message-Id: <20181210173350.13073-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC] hw/alpha/typhoon: Stop calling
 cpu_unassigned_access()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

The typhoon MemoryRegionOps callbacks directly call
cpu_unassigned_access(), presumably as the old-fashioned way
to provoke a CPU exception.  This won't work since commit
6ad4d7eed05a1e235 when we switched Alpha over to the
transaction_failed hook API, because now cpu_unassigned_access()
is a no-op for Alpha.

Make the MemoryRegionOps callbacks use the read_with_attrs
and write_with_attrs hooks, so they can signal a failure
that should cause a CPU exception by returning MEMTX_ERROR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
RFC because untested, since I don't have an alpha test image.

 hw/alpha/typhoon.c | 47 ++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 8004afe45b3..cbacea5fbd8 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -75,7 +75,9 @@ static void cpu_irq_change(AlphaCPU *cpu, uint64_t req)
     }
 }
 
-static uint64_t cchip_read(void *opaque, hwaddr addr, unsigned size)
+static MemTxResult cchip_read(void *opaque, hwaddr addr,
+                              uint64_t *data, unsigned size,
+                              MemTxAttrs attrs)
 {
     CPUState *cpu = current_cpu;
     TyphoonState *s = opaque;
@@ -196,11 +198,11 @@ static uint64_t cchip_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     default:
-        cpu_unassigned_access(cpu, addr, false, false, 0, size);
-        return -1;
+        return MEMTX_ERROR;
     }
 
-    return ret;
+    *data = ret;
+    return MEMTX_OK;
 }
 
 static uint64_t dchip_read(void *opaque, hwaddr addr, unsigned size)
@@ -209,7 +211,8 @@ static uint64_t dchip_read(void *opaque, hwaddr addr, unsigned size)
     return 0;
 }
 
-static uint64_t pchip_read(void *opaque, hwaddr addr, unsigned size)
+static MemTxResult pchip_read(void *opaque, hwaddr addr, uint64_t *data,
+                              unsigned size, MemTxAttrs attrs)
 {
     TyphoonState *s = opaque;
     uint64_t ret = 0;
@@ -294,15 +297,16 @@ static uint64_t pchip_read(void *opaque, hwaddr addr, unsigned size)
         break;
 
     default:
-        cpu_unassigned_access(current_cpu, addr, false, false, 0, size);
-        return -1;
+        return MEMTX_ERROR;
     }
 
-    return ret;
+    *data = ret;
+    return MEMTX_OK;
 }
 
-static void cchip_write(void *opaque, hwaddr addr,
-                        uint64_t val, unsigned size)
+static MemTxResult cchip_write(void *opaque, hwaddr addr,
+                               uint64_t val, unsigned size,
+                               MemTxAttrs attrs)
 {
     TyphoonState *s = opaque;
     uint64_t oldval, newval;
@@ -446,9 +450,10 @@ static void cchip_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        cpu_unassigned_access(current_cpu, addr, true, false, 0, size);
-        return;
+        return MEMTX_ERROR;
     }
+
+    return MEMTX_OK;
 }
 
 static void dchip_write(void *opaque, hwaddr addr,
@@ -457,8 +462,9 @@ static void dchip_write(void *opaque, hwaddr addr,
     /* Skip this.  It's all related to DRAM timing and setup.  */
 }
 
-static void pchip_write(void *opaque, hwaddr addr,
-                        uint64_t val, unsigned size)
+static MemTxResult pchip_write(void *opaque, hwaddr addr,
+                               uint64_t val, unsigned size,
+                               MemTxAttrs attrs)
 {
     TyphoonState *s = opaque;
     uint64_t oldval;
@@ -553,14 +559,15 @@ static void pchip_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        cpu_unassigned_access(current_cpu, addr, true, false, 0, size);
-        return;
+        return MEMTX_ERROR;
     }
+
+    return MEMTX_OK;
 }
 
 static const MemoryRegionOps cchip_ops = {
-    .read = cchip_read,
-    .write = cchip_write,
+    .read_with_attrs = cchip_read,
+    .write_with_attrs = cchip_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 8,
@@ -587,8 +594,8 @@ static const MemoryRegionOps dchip_ops = {
 };
 
 static const MemoryRegionOps pchip_ops = {
-    .read = pchip_read,
-    .write = pchip_write,
+    .read_with_attrs = pchip_read,
+    .write_with_attrs = pchip_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 8,
-- 
2.19.2
