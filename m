Received: from eggs.gnu.org ([2001:4830:134:3::10]:48195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e75Eu-0002q2-Uo
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1e75Eu-0003RB-0V
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:51:53 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:55509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
	id 1e75Et-0003Qd-PC
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:51:51 -0400
Received: by mail-lf0-x244.google.com with SMTP id p184so25267095lfe.12
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 12:51:51 -0700 (PDT)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
Date: Tue, 24 Oct 2017 21:51:31 +0200
Message-Id: <20171024195139.28179-6-frasse.iglesias@gmail.com>
In-Reply-To: <20171024195139.28179-1-frasse.iglesias@gmail.com>
References: <20171024195139.28179-1-frasse.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 05/13] xilinx_spips: Move FlashCMD,
 XilinxQSPIPS and XilinxSPIPSClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se

Move the FlashCMD enum, XilinxQSPIPS and XilinxSPIPSClass structures to the
header for consistency. Also move out a define and remove two dubbel included
headers (while touching the code). Finally, add 4 byte address commands to the
FlashCMD enum.

Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/ssi/xilinx_spips.c         | 35 -----------------------------------
 include/hw/ssi/xilinx_spips.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index ef56d35..559fa79 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -27,8 +27,6 @@
 #include "sysemu/sysemu.h"
 #include "hw/ptimer.h"
 #include "qemu/log.h"
-#include "qemu/fifo8.h"
-#include "hw/ssi/ssi.h"
 #include "qemu/bitops.h"
 #include "hw/ssi/xilinx_spips.h"
 #include "qapi/error.h"
@@ -116,44 +114,11 @@
 
 /* 16MB per linear region */
 #define LQSPI_ADDRESS_BITS 24
-/* Bite off 4k chunks at a time */
-#define LQSPI_CACHE_SIZE 1024
 
 #define SNOOP_CHECKING 0xFF
 #define SNOOP_NONE 0xFE
 #define SNOOP_STRIPING 0
 
-typedef enum {
-    READ = 0x3,
-    FAST_READ = 0xb,
-    DOR = 0x3b,
-    QOR = 0x6b,
-    DIOR = 0xbb,
-    QIOR = 0xeb,
-
-    PP = 0x2,
-    DPP = 0xa2,
-    QPP = 0x32,
-} FlashCMD;
-
-typedef struct {
-    XilinxSPIPS parent_obj;
-
-    uint8_t lqspi_buf[LQSPI_CACHE_SIZE];
-    hwaddr lqspi_cached_addr;
-    Error *migration_blocker;
-    bool mmio_execution_enabled;
-} XilinxQSPIPS;
-
-typedef struct XilinxSPIPSClass {
-    SysBusDeviceClass parent_class;
-
-    const MemoryRegionOps *reg_ops;
-
-    uint32_t rx_fifo_size;
-    uint32_t tx_fifo_size;
-} XilinxSPIPSClass;
-
 static inline int num_effective_busses(XilinxSPIPS *s)
 {
     return (s->regs[R_LQSPI_CFG] & LQSPI_CFG_SEP_BUS &&
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 06aa096..7f9e2fc 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -32,6 +32,22 @@ typedef struct XilinxSPIPS XilinxSPIPS;
 
 #define XLNX_SPIPS_R_MAX        (0x100 / 4)
 
+/* Bite off 4k chunks at a time */
+#define LQSPI_CACHE_SIZE 1024
+
+typedef enum {
+    READ = 0x3,         READ_4 = 0x13,
+    FAST_READ = 0xb,    FAST_READ_4 = 0x0c,
+    DOR = 0x3b,         DOR_4 = 0x3c,
+    QOR = 0x6b,         QOR_4 = 0x6c,
+    DIOR = 0xbb,        DIOR_4 = 0xbc,
+    QIOR = 0xeb,        QIOR_4 = 0xec,
+
+    PP = 0x2,           PP_4 = 0x12,
+    DPP = 0xa2,
+    QPP = 0x32,         QPP_4 = 0x34,
+} FlashCMD;
+
 struct XilinxSPIPS {
     SysBusDevice parent_obj;
 
@@ -56,6 +72,24 @@ struct XilinxSPIPS {
     uint32_t regs[XLNX_SPIPS_R_MAX];
 };
 
+typedef struct {
+    XilinxSPIPS parent_obj;
+
+    uint8_t lqspi_buf[LQSPI_CACHE_SIZE];
+    hwaddr lqspi_cached_addr;
+    Error *migration_blocker;
+    bool mmio_execution_enabled;
+} XilinxQSPIPS;
+
+typedef struct XilinxSPIPSClass {
+    SysBusDeviceClass parent_class;
+
+    const MemoryRegionOps *reg_ops;
+
+    uint32_t rx_fifo_size;
+    uint32_t tx_fifo_size;
+} XilinxSPIPSClass;
+
 #define TYPE_XILINX_SPIPS "xlnx.ps7-spi"
 #define TYPE_XILINX_QSPIPS "xlnx.ps7-qspi"
 
-- 
2.9.3
