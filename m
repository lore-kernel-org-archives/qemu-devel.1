Received: from eggs.gnu.org ([2001:4830:134:3::10]:51623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ8-0005bZ-Df
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ7-0000Vn-E8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fEeJ7-0000Tm-6r
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:15:45 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fEeJ6-00030x-7p
	for qemu-devel@nongnu.org; Fri, 04 May 2018 18:15:44 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  4 May 2018 18:15:20 +0100
Message-Id: <20180504171540.25813-5-peter.maydell@linaro.org>
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/24] hw/usb/tusb6010: Convert away from
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

Convert the tusb6010 device away from using the old_mmio field
of MemoryRegionOps. This device is used only in the n800 and n810
boards.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180427173611.10281-2-peter.maydell@linaro.org
---
 hw/usb/tusb6010.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index 2662c060ed..a2128024c1 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -641,11 +641,43 @@ static void tusb_async_writew(void *opaque, hwaddr addr,
     }
 }
 
+static uint64_t tusb_async_readfn(void *opaque, hwaddr addr, unsigned size)
+{
+    switch (size) {
+    case 1:
+        return tusb_async_readb(opaque, addr);
+    case 2:
+        return tusb_async_readh(opaque, addr);
+    case 4:
+        return tusb_async_readw(opaque, addr);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tusb_async_writefn(void *opaque, hwaddr addr,
+                               uint64_t value, unsigned size)
+{
+    switch (size) {
+    case 1:
+        tusb_async_writeb(opaque, addr, value);
+        break;
+    case 2:
+        tusb_async_writeh(opaque, addr, value);
+        break;
+    case 4:
+        tusb_async_writew(opaque, addr, value);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static const MemoryRegionOps tusb_async_ops = {
-    .old_mmio = {
-        .read = { tusb_async_readb, tusb_async_readh, tusb_async_readw, },
-        .write =  { tusb_async_writeb, tusb_async_writeh, tusb_async_writew, },
-    },
+    .read = tusb_async_readfn,
+    .write = tusb_async_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.17.0
