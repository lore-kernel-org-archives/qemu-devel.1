Received: from eggs.gnu.org ([2001:4830:134:3::10]:40769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5dDD-000617-CH
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5dDC-0005Xg-Bb
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:44:07 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:47563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gabriel291075@gmail.com>)
	id 1e5dDC-0005XV-6z
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:44:06 -0400
Received: by mail-qk0-x241.google.com with SMTP id m189so15626970qke.4
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 12:44:06 -0700 (PDT)
From: Gabriel Augusto Costa <gabriel291075@gmail.com>
Date: Fri, 20 Oct 2017 11:39:49 -0400
Message-Id: <1508513990-15730-1-git-send-email-gabriel291075@gmail.com>
Subject: [Qemu-devel] [PATCH v3 05/11] kinetis_k64_flextimer.h has been added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

I made a new arm machine with some peripherals. The machine is mk64fn1m0, a
cortex-m4 microcontroller from NXP Kinetis family. The machine can run a
simple arm binary file using UART0 in polling mode.
I have prepared a series of patchs to include this machine:
PATCH v3 n/11: It adds the machine and peripherals devices;
PATCH v4 n/2: It changes the Make files to compile this machine.

Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
---
 include/hw/timer/kinetis_k64_flextimer.h | 62 ++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/hw/timer/kinetis_k64_flextimer.h

diff --git a/include/hw/timer/kinetis_k64_flextimer.h b/include/hw/timer/kinetis_k64_flextimer.h
new file mode 100644
index 0000000..b0554f6
--- /dev/null
+++ b/include/hw/timer/kinetis_k64_flextimer.h
@@ -0,0 +1,62 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/* Kinetis K64 series FLEXTIMER controller.  */
+
+#ifndef KINETIS_FLEXTIMER_H
+#define KINETIS_FLEXTIMER_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
+#include "hw/hw.h"
+
+#define TYPE_KINETIS_K64_FLEXTIMER "kinetis_K64_flextimer"
+#define KINETIS_K64_FLEXTIMER(obj) \
+    OBJECT_CHECK(kinetis_k64_flextimer_state, (obj), TYPE_KINETIS_K64_FLEXTIMER)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t SC;        /**< Status And Control, offset: 0x0 */
+    uint32_t CNT;       /**< Counter, offset: 0x4 */
+    uint32_t MOD;       /**< Modulo, offset: 0x8 */
+    struct {            /* offset: 0xC, array step: 0x8 */
+     uint32_t CnSC;     /**< Ch(n) Status And Control, offset: 0xC, step: 0x8 */
+     uint32_t CnV;      /**< Ch(n) Value, array offset: 0x10, array step: 0x8 */
+    } CONTROLS[8];
+    uint32_t CNTIN;     /**< Counter Initial Value, offset: 0x4C */
+    uint32_t STATUS;    /**< Capture And Compare Status, offset: 0x50 */
+    uint32_t MODE;      /**< Features Mode Selection, offset: 0x54 */
+    uint32_t SYNC;      /**< Synchronization, offset: 0x58 */
+    uint32_t OUTINIT;   /**< Initial State For Channels Output, offset: 0x5C */
+    uint32_t OUTMASK;   /**< Output Mask, offset: 0x60 */
+    uint32_t COMBINE;   /**< Function For Linked Channels, offset: 0x64 */
+    uint32_t DEADTIME;  /**< Deadtime Insertion Control, offset: 0x68 */
+    uint32_t EXTTRIG;   /**< FTM External Trigger, offset: 0x6C */
+    uint32_t POL;       /**< Channels Polarity, offset: 0x70 */
+    uint32_t FMS;       /**< Fault Mode Status, offset: 0x74 */
+    uint32_t FILTER;    /**< Input Capture Filter Control, offset: 0x78 */
+    uint32_t FLTCTRL;   /**< Fault Control, offset: 0x7C */
+    uint32_t QDCTRL; /**< Quadrature Decoder Control And Status, offset: 0x80 */
+    uint32_t CONF;      /**< Configuration, offset: 0x84 */
+    uint32_t FLTPOL;    /**< FTM Fault Input Polarity, offset: 0x88 */
+    uint32_t SYNCONF;   /**< Synchronization Configuration, offset: 0x8C */
+    uint32_t INVCTRL;   /**< FTM Inverting Control, offset: 0x90 */
+    uint32_t SWOCTRL;   /**< FTM Software Output Control, offset: 0x94 */
+    uint32_t PWMLOAD;   /**< FTM PWM Load, offset: 0x98 */
+
+    qemu_irq irq;
+} kinetis_k64_flextimer_state;
+
+#endif
-- 
2.1.4
