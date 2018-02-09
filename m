Received: from eggs.gnu.org ([2001:4830:134:3::10]:44722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDqY-0005Bo-LA
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDqV-0007za-N4
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:56:30 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  9 Feb 2018 18:51:41 +0000
Message-Id: <20180209185142.17151-12-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 11/12] ppc: move CUDAState and other
 CUDA-related definitions into separate cuda.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c         |   1 +
 hw/misc/macio/macio.c        |   1 +
 hw/ppc/mac.h                 |  77 -------------------------------
 include/hw/misc/macio/cuda.h | 107 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 77 deletions(-)
 create mode 100644 include/hw/misc/macio/cuda.h

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 54c02aeffb..377b91d266 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -27,6 +27,7 @@
 #include "hw/ppc/mac.h"
 #include "hw/input/adb.h"
 #include "hw/misc/mos6522.h"
+#include "hw/misc/macio/cuda.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index a639b09e00..024f8557ab 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
+#include "hw/misc/macio/cuda.h"
 #include "hw/pci/pci.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/char/escc.h"
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index 3e9f13d9b4..4702194f3f 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -45,83 +45,6 @@
 
 #define ESCC_CLOCK 3686400
 
-/* CUDA commands (2nd byte) */
-#define CUDA_WARM_START                0x0
-#define CUDA_AUTOPOLL                  0x1
-#define CUDA_GET_6805_ADDR             0x2
-#define CUDA_GET_TIME                  0x3
-#define CUDA_GET_PRAM                  0x7
-#define CUDA_SET_6805_ADDR             0x8
-#define CUDA_SET_TIME                  0x9
-#define CUDA_POWERDOWN                 0xa
-#define CUDA_POWERUP_TIME              0xb
-#define CUDA_SET_PRAM                  0xc
-#define CUDA_MS_RESET                  0xd
-#define CUDA_SEND_DFAC                 0xe
-#define CUDA_BATTERY_SWAP_SENSE        0x10
-#define CUDA_RESET_SYSTEM              0x11
-#define CUDA_SET_IPL                   0x12
-#define CUDA_FILE_SERVER_FLAG          0x13
-#define CUDA_SET_AUTO_RATE             0x14
-#define CUDA_GET_AUTO_RATE             0x16
-#define CUDA_SET_DEVICE_LIST           0x19
-#define CUDA_GET_DEVICE_LIST           0x1a
-#define CUDA_SET_ONE_SECOND_MODE       0x1b
-#define CUDA_SET_POWER_MESSAGES        0x21
-#define CUDA_GET_SET_IIC               0x22
-#define CUDA_WAKEUP                    0x23
-#define CUDA_TIMER_TICKLE              0x24
-#define CUDA_COMBINED_FORMAT_IIC       0x25
-
-/* Cuda */
-#define TYPE_CUDA "cuda"
-#define CUDA(obj) OBJECT_CHECK(CUDAState, (obj), TYPE_CUDA)
-
-typedef struct MOS6522CUDAState MOS6522CUDAState;
-
-typedef struct CUDAState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-    MemoryRegion mem;
-
-    ADBBusState adb_bus;
-    MOS6522CUDAState *mos6522_cuda;
-
-    uint32_t tick_offset;
-    uint64_t tb_frequency;
-
-    uint8_t last_b;
-    uint8_t last_acr;
-
-    /* MacOS 9 is racy and requires a delay upon setting the SR_INT bit */
-    uint64_t sr_delay_ns;
-    QEMUTimer *sr_delay_timer;
-
-    int data_in_size;
-    int data_in_index;
-    int data_out_index;
-
-    qemu_irq irq;
-    uint16_t adb_poll_mask;
-    uint8_t autopoll_rate_ms;
-    uint8_t autopoll;
-    uint8_t data_in[128];
-    uint8_t data_out[16];
-    QEMUTimer *adb_poll_timer;
-} CUDAState;
-
-/* MOS6522 CUDA */
-typedef struct MOS6522CUDAState {
-    /*< private >*/
-    MOS6522State parent_obj;
-
-    CUDAState *cuda;
-} MOS6522CUDAState;
-
-#define TYPE_MOS6522_CUDA "mos6522-cuda"
-#define MOS6522_CUDA(obj) OBJECT_CHECK(MOS6522CUDAState, (obj), \
-                                       TYPE_MOS6522_CUDA)
 
 /* MacIO */
 #define TYPE_OLDWORLD_MACIO "macio-oldworld"
diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
new file mode 100644
index 0000000000..6afbdd13ee
--- /dev/null
+++ b/include/hw/misc/macio/cuda.h
@@ -0,0 +1,107 @@
+/*
+ * QEMU PowerMac CUDA device support
+ *
+ * Copyright (c) 2004-2007 Fabrice Bellard
+ * Copyright (c) 2007 Jocelyn Mayer
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef CUDA_H
+#define CUDA_H
+
+/* CUDA commands (2nd byte) */
+#define CUDA_WARM_START                0x0
+#define CUDA_AUTOPOLL                  0x1
+#define CUDA_GET_6805_ADDR             0x2
+#define CUDA_GET_TIME                  0x3
+#define CUDA_GET_PRAM                  0x7
+#define CUDA_SET_6805_ADDR             0x8
+#define CUDA_SET_TIME                  0x9
+#define CUDA_POWERDOWN                 0xa
+#define CUDA_POWERUP_TIME              0xb
+#define CUDA_SET_PRAM                  0xc
+#define CUDA_MS_RESET                  0xd
+#define CUDA_SEND_DFAC                 0xe
+#define CUDA_BATTERY_SWAP_SENSE        0x10
+#define CUDA_RESET_SYSTEM              0x11
+#define CUDA_SET_IPL                   0x12
+#define CUDA_FILE_SERVER_FLAG          0x13
+#define CUDA_SET_AUTO_RATE             0x14
+#define CUDA_GET_AUTO_RATE             0x16
+#define CUDA_SET_DEVICE_LIST           0x19
+#define CUDA_GET_DEVICE_LIST           0x1a
+#define CUDA_SET_ONE_SECOND_MODE       0x1b
+#define CUDA_SET_POWER_MESSAGES        0x21
+#define CUDA_GET_SET_IIC               0x22
+#define CUDA_WAKEUP                    0x23
+#define CUDA_TIMER_TICKLE              0x24
+#define CUDA_COMBINED_FORMAT_IIC       0x25
+
+/* Cuda */
+#define TYPE_CUDA "cuda"
+#define CUDA(obj) OBJECT_CHECK(CUDAState, (obj), TYPE_CUDA)
+
+typedef struct MOS6522CUDAState MOS6522CUDAState;
+
+typedef struct CUDAState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    MemoryRegion mem;
+
+    ADBBusState adb_bus;
+    MOS6522CUDAState *mos6522_cuda;
+
+    uint32_t tick_offset;
+    uint64_t tb_frequency;
+
+    uint8_t last_b;
+    uint8_t last_acr;
+
+    /* MacOS 9 is racy and requires a delay upon setting the SR_INT bit */
+    uint64_t sr_delay_ns;
+    QEMUTimer *sr_delay_timer;
+
+    int data_in_size;
+    int data_in_index;
+    int data_out_index;
+
+    qemu_irq irq;
+    uint16_t adb_poll_mask;
+    uint8_t autopoll_rate_ms;
+    uint8_t autopoll;
+    uint8_t data_in[128];
+    uint8_t data_out[16];
+    QEMUTimer *adb_poll_timer;
+} CUDAState;
+
+/* MOS6522 CUDA */
+typedef struct MOS6522CUDAState {
+    /*< private >*/
+    MOS6522State parent_obj;
+
+    CUDAState *cuda;
+} MOS6522CUDAState;
+
+#define TYPE_MOS6522_CUDA "mos6522-cuda"
+#define MOS6522_CUDA(obj) OBJECT_CHECK(MOS6522CUDAState, (obj), \
+                                       TYPE_MOS6522_CUDA)
+
+#endif /* CUDA_H */
-- 
2.11.0
