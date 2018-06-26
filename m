Received: from eggs.gnu.org ([2001:4830:134:3::10]:51856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHE-00023V-Kr
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHD-0007Di-L7
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHD-0007CU-DU
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHC-00006T-45
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:10 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:40 +0100
Message-Id: <20180626165658.31394-15-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/32] hw/arm/omap1: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

TCMI_VERBOSE is no more used, drop the OMAP_8/16/32B_REG macros.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20180624040609.17572-9-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h | 18 ------------------
 hw/arm/omap1.c        | 18 ++++++++++++------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index b398607b06c..39abba753d4 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -993,24 +993,6 @@ enum {
 #define OMAP_GPIOSW_INVERTED	0x0001
 #define OMAP_GPIOSW_OUTPUT	0x0002
 
-# define TCMI_VERBOSE			1
-
-# ifdef TCMI_VERBOSE
-#  define OMAP_8B_REG(paddr)		\
-        fprintf(stderr, "%s: 8-bit register " OMAP_FMT_plx "\n",	\
-                        __func__, paddr)
-#  define OMAP_16B_REG(paddr)		\
-        fprintf(stderr, "%s: 16-bit register " OMAP_FMT_plx "\n",	\
-                        __func__, paddr)
-#  define OMAP_32B_REG(paddr)		\
-        fprintf(stderr, "%s: 32-bit register " OMAP_FMT_plx "\n",	\
-                        __func__, paddr)
-# else
-#  define OMAP_8B_REG(paddr)
-#  define OMAP_16B_REG(paddr)
-#  define OMAP_32B_REG(paddr)
-# endif
-
 # define OMAP_MPUI_REG_MASK		0x000007ff
 
 #endif /* hw_omap_h */
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 9af04728e39..539d29ef9ce 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -34,12 +34,18 @@
 #include "qemu/cutils.h"
 #include "qemu/bcd.h"
 
+static inline void omap_log_badwidth(const char *funcname, hwaddr addr, int sz)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: %d-bit register %#08" HWADDR_PRIx "\n",
+                  funcname, 8 * sz, addr);
+}
+
 /* Should signal the TCMI/GPMC */
 uint32_t omap_badwidth_read8(void *opaque, hwaddr addr)
 {
     uint8_t ret;
 
-    OMAP_8B_REG(addr);
+    omap_log_badwidth(__func__, addr, 1);
     cpu_physical_memory_read(addr, &ret, 1);
     return ret;
 }
@@ -49,7 +55,7 @@ void omap_badwidth_write8(void *opaque, hwaddr addr,
 {
     uint8_t val8 = value;
 
-    OMAP_8B_REG(addr);
+    omap_log_badwidth(__func__, addr, 1);
     cpu_physical_memory_write(addr, &val8, 1);
 }
 
@@ -57,7 +63,7 @@ uint32_t omap_badwidth_read16(void *opaque, hwaddr addr)
 {
     uint16_t ret;
 
-    OMAP_16B_REG(addr);
+    omap_log_badwidth(__func__, addr, 2);
     cpu_physical_memory_read(addr, &ret, 2);
     return ret;
 }
@@ -67,7 +73,7 @@ void omap_badwidth_write16(void *opaque, hwaddr addr,
 {
     uint16_t val16 = value;
 
-    OMAP_16B_REG(addr);
+    omap_log_badwidth(__func__, addr, 2);
     cpu_physical_memory_write(addr, &val16, 2);
 }
 
@@ -75,7 +81,7 @@ uint32_t omap_badwidth_read32(void *opaque, hwaddr addr)
 {
     uint32_t ret;
 
-    OMAP_32B_REG(addr);
+    omap_log_badwidth(__func__, addr, 4);
     cpu_physical_memory_read(addr, &ret, 4);
     return ret;
 }
@@ -83,7 +89,7 @@ uint32_t omap_badwidth_read32(void *opaque, hwaddr addr)
 void omap_badwidth_write32(void *opaque, hwaddr addr,
                 uint32_t value)
 {
-    OMAP_32B_REG(addr);
+    omap_log_badwidth(__func__, addr, 4);
     cpu_physical_memory_write(addr, &value, 4);
 }
 
-- 
2.17.1
