Received: from eggs.gnu.org ([209.51.188.92]:34361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004r4-3J
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eo-0006kA-1z
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:35 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9em-0006cV-Rc
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id c5so17086369wrs.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.15
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:22 +0100
Message-Id: <20190429170030.11323-35-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 34/42] hw/devices: Move TC6393XB declarations
 into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-5-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/devices.h          |  6 ------
 include/hw/display/tc6393xb.h | 24 ++++++++++++++++++++++++
 hw/arm/tosa.c                 |  2 +-
 hw/display/tc6393xb.c         |  2 +-
 MAINTAINERS                   |  1 +
 5 files changed, 27 insertions(+), 8 deletions(-)
 create mode 100644 include/hw/display/tc6393xb.h

diff --git a/include/hw/devices.h b/include/hw/devices.h
index 0850f697451..1e2141caad1 100644
--- a/include/hw/devices.h
+++ b/include/hw/devices.h
@@ -50,10 +50,4 @@ void *tahvo_init(qemu_irq irq, int betty);
 
 void retu_key_event(void *retu, int state);
 
-/* tc6393xb.c */
-typedef struct TC6393xbState TC6393xbState;
-TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
-                             uint32_t base, qemu_irq irq);
-qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
-
 #endif
diff --git a/include/hw/display/tc6393xb.h b/include/hw/display/tc6393xb.h
new file mode 100644
index 00000000000..5c4da91f80d
--- /dev/null
+++ b/include/hw/display/tc6393xb.h
@@ -0,0 +1,24 @@
+/*
+ * Toshiba TC6393XB I/O Controller.
+ * Found in Sharp Zaurus SL-6000 (tosa) or some
+ * Toshiba e-Series PDAs.
+ *
+ * Copyright (c) 2007 Hervé Poussineau
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_DISPLAY_TC6393XB_H
+#define HW_DISPLAY_TC6393XB_H
+
+#include "exec/memory.h"
+#include "hw/irq.h"
+
+typedef struct TC6393xbState TC6393xbState;
+
+TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
+                             uint32_t base, qemu_irq irq);
+qemu_irq tc6393xb_l3v_get(TC6393xbState *s);
+
+#endif
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index eef9d427e76..9a1247797fe 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -16,10 +16,10 @@
 #include "hw/hw.h"
 #include "hw/arm/pxa.h"
 #include "hw/arm/arm.h"
-#include "hw/devices.h"
 #include "hw/arm/sharpsl.h"
 #include "hw/pcmcia.h"
 #include "hw/boards.h"
+#include "hw/display/tc6393xb.h"
 #include "hw/i2c/i2c.h"
 #include "hw/ssi/ssi.h"
 #include "hw/sysbus.h"
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 6d133d9a66c..0b7c59cde7d 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/host-utils.h"
 #include "hw/hw.h"
-#include "hw/devices.h"
+#include "hw/display/tc6393xb.h"
 #include "hw/block/flash.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index dabbfccf9c5..51eecd0ac19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -714,6 +714,7 @@ F: hw/misc/mst_fpga.c
 F: hw/misc/max111x.c
 F: include/hw/arm/pxa.h
 F: include/hw/arm/sharpsl.h
+F: include/hw/display/tc6393xb.h
 
 SABRELITE / i.MX6
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1
