Received: from eggs.gnu.org ([2001:4830:134:3::10]:60782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6eB-0006Ab-4J
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6e7-0005bz-5R
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:51 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:57399)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eS6e6-0005al-Pp
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:36:47 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 21 Dec 2017 20:36:38 +0100
Message-Id: <20171221193640.27418-4-laurent@vivier.eu>
In-Reply-To: <20171221193640.27418-1-laurent@vivier.eu>
References: <20171221193640.27418-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/5] target/m68k: add monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20171221083057.17942-1-laurent@vivier.eu>
---
 target/m68k/Makefile.objs |  1 +
 target/m68k/monitor.c     | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
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
index 0000000000..5605323a81
--- /dev/null
+++ b/target/m68k/monitor.c
@@ -0,0 +1,39 @@
+/*
+ * QEMU monitor for m68k
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "monitor/hmp-target.h"
+
+static const MonitorDef monitor_defs[] = {
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
