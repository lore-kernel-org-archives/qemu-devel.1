Received: from eggs.gnu.org ([2001:4830:134:3::10]:51876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHF-00024I-6y
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHE-0007ED-4T
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fXrHD-0007DT-Ru
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:57:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fXrHC-000072-RE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 17:57:10 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:56:41 +0100
Message-Id: <20180626165658.31394-16-peter.maydell@linaro.org>
In-Reply-To: <20180626165658.31394-1-peter.maydell@linaro.org>
References: <20180626165658.31394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/32] hw/arm/omap: Use
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20180624040609.17572-10-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 39abba753d4..e7fbd340f37 100644
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
2.17.1
