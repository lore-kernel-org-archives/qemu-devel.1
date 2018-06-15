Received: from eggs.gnu.org ([2001:4830:134:3::10]:60827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfW-0001dy-Lr
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfV-0006Ev-E2
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfU-0006Ck-CW
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfJ-0003bj-M3
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:42 +0100
Message-Id: <20180615142521.19143-5-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/43] hw/m68k/mcf5206: Convert away from
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

Convert the mcf5206 device away from using the old_mmio field
of MemoryRegionOps. This device is used by the an5206 board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Thomas Huth <huth@tuxfamily.org>
Message-id: 20180601141223.26630-3-peter.maydell@linaro.org
---
 hw/m68k/mcf5206.c | 48 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 7abd84ac47f..d7f26d68106 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -512,19 +512,43 @@ static void m5206_mbar_writel(void *opaque, hwaddr offset,
     m5206_mbar_write(s, offset, value, 4);
 }
 
+static uint64_t m5206_mbar_readfn(void *opaque, hwaddr addr, unsigned size)
+{
+    switch (size) {
+    case 1:
+        return m5206_mbar_readb(opaque, addr);
+    case 2:
+        return m5206_mbar_readw(opaque, addr);
+    case 4:
+        return m5206_mbar_readl(opaque, addr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void m5206_mbar_writefn(void *opaque, hwaddr addr,
+                               uint64_t value, unsigned size)
+{
+    switch (size) {
+    case 1:
+        m5206_mbar_writeb(opaque, addr, value);
+        break;
+    case 2:
+        m5206_mbar_writew(opaque, addr, value);
+        break;
+    case 4:
+        m5206_mbar_writel(opaque, addr, value);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static const MemoryRegionOps m5206_mbar_ops = {
-    .old_mmio = {
-        .read = {
-            m5206_mbar_readb,
-            m5206_mbar_readw,
-            m5206_mbar_readl,
-        },
-        .write = {
-            m5206_mbar_writeb,
-            m5206_mbar_writew,
-            m5206_mbar_writel,
-        },
-    },
+    .read = m5206_mbar_readfn,
+    .write = m5206_mbar_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.17.1
