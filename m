Received: from eggs.gnu.org ([2001:4830:134:3::10]:52656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEI-0008HK-2X
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dtGEH-0007BL-8c
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 12:46:06 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 17:46:13 +0100
Message-Id: <1505580378-9044-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/6] hw/arm/palm.c: Don't use old_mmio for
 static_ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Update the static_ops functions to use new-style mmio
rather than the legacy old_mmio functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/palm.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index bf070a2..264f5bd 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -30,26 +30,16 @@
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
 
-static uint32_t static_readb(void *opaque, hwaddr offset)
+static uint64_t static_read(void *opaque, hwaddr offset, unsigned size)
 {
-    uint32_t *val = (uint32_t *) opaque;
-    return *val >> ((offset & 3) << 3);
-}
+    uint32_t *val = (uint32_t *)opaque;
+    uint32_t sizemask = 7 >> size;
 
-static uint32_t static_readh(void *opaque, hwaddr offset)
-{
-    uint32_t *val = (uint32_t *) opaque;
-    return *val >> ((offset & 1) << 3);
-}
-
-static uint32_t static_readw(void *opaque, hwaddr offset)
-{
-    uint32_t *val = (uint32_t *) opaque;
-    return *val >> ((offset & 0) << 3);
+    return *val >> ((offset & sizemask) << 3);
 }
 
-static void static_write(void *opaque, hwaddr offset,
-                uint32_t value)
+static void static_write(void *opaque, hwaddr offset, uint64_t value,
+                         unsigned size)
 {
 #ifdef SPY
     printf("%s: value %08lx written at " PA_FMT "\n",
@@ -58,10 +48,10 @@ static void static_write(void *opaque, hwaddr offset,
 }
 
 static const MemoryRegionOps static_ops = {
-    .old_mmio = {
-        .read = { static_readb, static_readh, static_readw, },
-        .write = { static_write, static_write, static_write, },
-    },
+    .read = static_read,
+    .write = static_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.7.4
