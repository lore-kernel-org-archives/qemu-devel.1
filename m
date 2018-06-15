Received: from eggs.gnu.org ([2001:4830:134:3::10]:60782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfV-0001cs-Kj
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfT-0006DX-MA
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfT-0006Aw-7q
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfL-0003ch-2z
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:27 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:44 +0100
Message-Id: <20180615142521.19143-7-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/43] hw/watchdog/wdt_i6300esb: Convert away
 from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Convert the wdt_i6300esb device away from using the old_mmio field
of MemoryRegionOps.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180601141223.26630-5-peter.maydell@linaro.org
---
 hw/watchdog/wdt_i6300esb.c | 48 ++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index e596b0804d8..7b594698887 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -361,19 +361,43 @@ static void i6300esb_mem_writel(void *vp, hwaddr addr, uint32_t val)
     }
 }
 
+static uint64_t i6300esb_mem_readfn(void *opaque, hwaddr addr, unsigned size)
+{
+    switch (size) {
+    case 1:
+        return i6300esb_mem_readb(opaque, addr);
+    case 2:
+        return i6300esb_mem_readw(opaque, addr);
+    case 4:
+        return i6300esb_mem_readl(opaque, addr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void i6300esb_mem_writefn(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size)
+{
+    switch (size) {
+    case 1:
+        i6300esb_mem_writeb(opaque, addr, value);
+        break;
+    case 2:
+        i6300esb_mem_writew(opaque, addr, value);
+        break;
+    case 4:
+        i6300esb_mem_writel(opaque, addr, value);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static const MemoryRegionOps i6300esb_ops = {
-    .old_mmio = {
-        .read = {
-            i6300esb_mem_readb,
-            i6300esb_mem_readw,
-            i6300esb_mem_readl,
-        },
-        .write = {
-            i6300esb_mem_writeb,
-            i6300esb_mem_writew,
-            i6300esb_mem_writel,
-        },
-    },
+    .read = i6300esb_mem_readfn,
+    .write = i6300esb_mem_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-- 
2.17.1
