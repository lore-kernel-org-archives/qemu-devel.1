Received: from eggs.gnu.org ([2001:4830:134:3::10]:50143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRl5W-0007Tl-MT
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRl5S-0000Zt-Mh
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:35:38 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:58306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRl5S-0000Yo-5e
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:35:34 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 20 Dec 2017 21:35:28 +0100
Message-Id: <20171220203528.21334-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] target/m68k: add monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>

This allows to use registers content in the monitor.

Example:

 BEFORE:
  (qemu) print $d0
  unknown register

 AFTER:
  (qemu) print $d0
  0
  (qemu) print $sr
  0x2000
  (qemu) x/10i $pc
  0x40010a2a:  movew %sr,%d0
  0x40010a2c:  oril #1792,%d0
  0x40010a32:  movew %d0,%sr
  0x40010a34:  movel %a0@,%d0
  0x40010a36:  btst #3,%d0
  0x40010a3a:  beqs 0x40010a26
  0x40010a3c:  movew %sr,%d0
  0x40010a3e:  andil #63743,%d0
  0x40010a44:  movew %d0,%sr
  0x40010a46:  rts

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/Makefile.objs |  1 +
 target/m68k/monitor.c     | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 target/m68k/monitor.c

diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
index 39141ab93d..d143f20270 100644
--- a/target/m68k/Makefile.objs
+++ b/target/m68k/Makefile.objs
@@ -1,3 +1,4 @@
 obj-y += m68k-semi.o
 obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o
 obj-y += gdbstub.o
+obj-$(CONFIG_SOFTMMU) += monitor.o
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
new file mode 100644
index 0000000000..03d037ccab
--- /dev/null
+++ b/target/m68k/monitor.c
@@ -0,0 +1,55 @@
+/*
+ * QEMU monitor
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
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
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "monitor/hmp-target.h"
+
+const MonitorDef monitor_defs[] = {
+    { "d0", offsetof(CPUM68KState, dregs[0]) },
+    { "d1", offsetof(CPUM68KState, dregs[1]) },
+    { "d2", offsetof(CPUM68KState, dregs[2]) },
+    { "d3", offsetof(CPUM68KState, dregs[3]) },
+    { "d4", offsetof(CPUM68KState, dregs[4]) },
+    { "d5", offsetof(CPUM68KState, dregs[5]) },
+    { "d6", offsetof(CPUM68KState, dregs[6]) },
+    { "d7", offsetof(CPUM68KState, dregs[7]) },
+    { "a0", offsetof(CPUM68KState, aregs[0]) },
+    { "a1", offsetof(CPUM68KState, aregs[1]) },
+    { "a2", offsetof(CPUM68KState, aregs[2]) },
+    { "a3", offsetof(CPUM68KState, aregs[3]) },
+    { "a4", offsetof(CPUM68KState, aregs[4]) },
+    { "a5", offsetof(CPUM68KState, aregs[5]) },
+    { "a6", offsetof(CPUM68KState, aregs[6]) },
+    { "a7", offsetof(CPUM68KState, aregs[7]) },
+    { "pc", offsetof(CPUM68KState, pc) },
+    { "sr", offsetof(CPUM68KState, sr) },
+    { "ssp", offsetof(CPUM68KState, sp[0]) },
+    { "usp", offsetof(CPUM68KState, sp[1]) },
+    { NULL },
+};
+
+const MonitorDef *target_monitor_defs(void)
+{
+    return monitor_defs;
+}
-- 
2.14.3
