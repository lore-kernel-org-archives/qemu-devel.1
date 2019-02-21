Received: from eggs.gnu.org ([209.51.188.92]:52157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXq-0008Tw-Jy
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXp-0007SP-18
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:06 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:41440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXn-0007NM-8Z
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:04 -0500
Received: by mail-wr1-x429.google.com with SMTP id n2so19644084wrw.8
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:57:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.57.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:57:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:29 +0000
Message-Id: <20190221185739.25362-12-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
References: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/21] hw/char/pl011: Allow use as an
 embedded-struct device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Create a new include file for the pl011's device struct,
type macros, etc, so that it can be instantiated using
the "embedded struct" coding style.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
