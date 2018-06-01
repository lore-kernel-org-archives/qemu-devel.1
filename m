Received: from eggs.gnu.org ([2001:4830:134:3::10]:37630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOknB-0007Tg-SR
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOknA-0000mu-V0
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:12:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Jun 2018 15:12:18 +0100
Message-Id: <20180601141223.26630-2-peter.maydell@linaro.org>
In-Reply-To: <20180601141223.26630-1-peter.maydell@linaro.org>
References: <20180601141223.26630-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/6] hw/sh/sh7750: Convert away from old_mmio
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

Convert the sh7750 device away from using the old_mmio field
of MemoryRegionOps. This device is used by the sh4 r2d board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sh4/sh7750.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 5a7d47d31e..b932f33409 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -451,15 +451,43 @@ static void sh7750_mem_writel(void *opaque, hwaddr addr,
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
