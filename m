Received: from eggs.gnu.org ([2001:4830:134:3::10]:42427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIe-00044p-7J
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWwIc-00045j-4g
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 00:06:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 24 Jun 2018 01:06:02 -0300
Message-Id: <20180624040609.17572-10-f4bug@amsat.org>
In-Reply-To: <20180624040609.17572-1-f4bug@amsat.org>
References: <20180624040609.17572-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 09/16] hw/arm/omap: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/omap.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 39abba753d..e7fbd340f3 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -21,6 +21,7 @@
 # define hw_omap_h		"omap.h"
 #include "hw/irq.h"
 #include "target/arm/cpu-qom.h"
+#include "qemu/log.h"
 
 # define OMAP_EMIFS_BASE	0x00000000
 # define OMAP2_Q0_BASE		0x00000000
@@ -944,8 +945,6 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRegion *sysmem,
                 unsigned long sdram_size,
                 const char *core);
 
-#define OMAP_FMT_plx "%#08" HWADDR_PRIx
-
 uint32_t omap_badwidth_read8(void *opaque, hwaddr addr);
 void omap_badwidth_write8(void *opaque, hwaddr addr,
                 uint32_t value);
@@ -959,11 +958,12 @@ void omap_badwidth_write32(void *opaque, hwaddr addr,
 void omap_mpu_wakeup(void *opaque, int irq, int req);
 
 # define OMAP_BAD_REG(paddr)		\
-        fprintf(stderr, "%s: Bad register " OMAP_FMT_plx "\n",	\
-                        __func__, paddr)
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad register %#08"HWADDR_PRIx"\n", \
+                      __func__, paddr)
 # define OMAP_RO_REG(paddr)		\
-        fprintf(stderr, "%s: Read-only register " OMAP_FMT_plx "\n",	\
-                        __func__, paddr)
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Read-only register %#08" \
+                                       HWADDR_PRIx "\n", \
+                      __func__, paddr)
 
 /* OMAP-specific Linux bootloader tags for the ATAG_BOARD area
    (Board-specifc tags are not here)  */
-- 
2.18.0
