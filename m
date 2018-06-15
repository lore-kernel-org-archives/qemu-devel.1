Received: from eggs.gnu.org ([2001:4830:134:3::10]:60820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfW-0001dq-Ip
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfV-0006Eg-AE
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfU-0006Aw-CZ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfI-0003bI-Vs
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:41 +0100
Message-Id: <20180615142521.19143-4-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/43] hw/sh/sh7750: Convert away from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Convert the sh7750 device away from using the old_mmio field
of MemoryRegionOps. This device is used by the sh4 r2d board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180601141223.26630-2-peter.maydell@linaro.org
---
 hw/sh4/sh7750.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 2dc07a904b1..2fb6e618d93 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -450,15 +450,43 @@ static void sh7750_mem_writel(void *opaque, hwaddr addr,
     }
 }
 
+static uint64_t sh7750_mem_readfn(void *opaque, hwaddr addr, unsigned size)
+{
+    switch (size) {
+    case 1:
+        return sh7750_mem_readb(opaque, addr);
+    case 2:
+        return sh7750_mem_readw(opaque, addr);
+    case 4:
+        return sh7750_mem_readl(opaque, addr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void sh7750_mem_writefn(void *opaque, hwaddr addr,
+                               uint64_t value, unsigned size)
+{
+    switch (size) {
+    case 1:
+        sh7750_mem_writeb(opaque, addr, value);
+        break;
+    case 2:
+        sh7750_mem_writew(opaque, addr, value);
+        break;
+    case 4:
+        sh7750_mem_writel(opaque, addr, value);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static const MemoryRegionOps sh7750_mem_ops = {
-    .old_mmio = {
-        .read = {sh7750_mem_readb,
-                 sh7750_mem_readw,
-                 sh7750_mem_readl },
-        .write = {sh7750_mem_writeb,
-                  sh7750_mem_writew,
-                  sh7750_mem_writel },
-    },
+    .read = sh7750_mem_readfn,
+    .write = sh7750_mem_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.17.1
