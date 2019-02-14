Received: from eggs.gnu.org ([209.51.188.92]:49695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGeS-0002tV-29
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGU0-0006Uj-KZ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:18 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGU0-0006Tn-Aa
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:16 -0500
Received: by mail-wr1-x444.google.com with SMTP id v13so6343987wrw.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 04:51:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 12:50:58 +0000
Message-Id: <20190214125107.22178-6-peter.maydell@linaro.org>
In-Reply-To: <20190214125107.22178-1-peter.maydell@linaro.org>
References: <20190214125107.22178-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/14] hw/char/pl011: Allow use as an
 embedded-struct device
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

Create a new include file for the pl011's device struct,
type macros, etc, so that it can be instantiated using
the "embedded struct" coding style.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/pl011.h | 34 ++++++++++++++++++++++++++++++++++
 hw/char/pl011.c         | 31 ++-----------------------------
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 83649324b6a..1b52bfd5c90 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -15,6 +15,40 @@
 #ifndef HW_PL011_H
 #define HW_PL011_H
 
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+
+#define TYPE_PL011 "pl011"
+#define PL011(obj) OBJECT_CHECK(PL011State, (obj), TYPE_PL011)
+
+/* This shares the same struct (and cast macro) as the base pl011 device */
+#define TYPE_PL011_LUMINARY "pl011_luminary"
+
+typedef struct PL011State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t readbuff;
+    uint32_t flags;
+    uint32_t lcr;
+    uint32_t rsr;
+    uint32_t cr;
+    uint32_t dmacr;
+    uint32_t int_enabled;
+    uint32_t int_level;
+    uint32_t read_fifo[16];
+    uint32_t ilpr;
+    uint32_t ibrd;
+    uint32_t fbrd;
+    uint32_t ifl;
+    int read_pos;
+    int read_count;
+    int read_trigger;
+    CharBackend chr;
+    qemu_irq irq;
+    const unsigned char *id;
+} PL011State;
+
 static inline DeviceState *pl011_create(hwaddr addr,
                                         qemu_irq irq,
                                         Chardev *chr)
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 2aa277fc4f2..0c4711e4027 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -8,39 +8,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/char/pl011.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
 #include "trace.h"
 
-#define TYPE_PL011 "pl011"
-#define PL011(obj) OBJECT_CHECK(PL011State, (obj), TYPE_PL011)
-
-typedef struct PL011State {
-    SysBusDevice parent_obj;
-
-    MemoryRegion iomem;
-    uint32_t readbuff;
-    uint32_t flags;
-    uint32_t lcr;
-    uint32_t rsr;
-    uint32_t cr;
-    uint32_t dmacr;
-    uint32_t int_enabled;
-    uint32_t int_level;
-    uint32_t read_fifo[16];
-    uint32_t ilpr;
-    uint32_t ibrd;
-    uint32_t fbrd;
-    uint32_t ifl;
-    int read_pos;
-    int read_count;
-    int read_trigger;
-    CharBackend chr;
-    qemu_irq irq;
-    const unsigned char *id;
-} PL011State;
-
 #define PL011_INT_TX 0x20
 #define PL011_INT_RX 0x10
 
@@ -357,7 +330,7 @@ static void pl011_luminary_init(Object *obj)
 }
 
 static const TypeInfo pl011_luminary_info = {
-    .name          = "pl011_luminary",
+    .name          = TYPE_PL011_LUMINARY,
     .parent        = TYPE_PL011,
     .instance_init = pl011_luminary_init,
 };
-- 
2.20.1
