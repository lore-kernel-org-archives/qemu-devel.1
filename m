Received: from eggs.gnu.org ([2001:4830:134:3::10]:40943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP9-0008H5-HS
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP8-0007b1-DV
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:35 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSP8-0007ai-41
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:34 -0400
Received: by mail-wr0-x241.google.com with SMTP id y25so546761wrd.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:40 +0200
Message-Id: <1497523981-38449-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/41] accel: split the tcg accelerator from
 accel.c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

there are some types of accelerators in qemu, and all accelerators
have their own file except tcg. tcg accelerator is also defined in
accel.c file. tcg accelerator file will be splited from accel.c and
re-name to tcg-all.c. accel/ directory will be created to include
kvm and tcg related files.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <1496383606-18060-2-git-send-email-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs            |  1 -
 Makefile.target          |  1 +
 accel/Makefile.objs      |  2 ++
 accel.c => accel/accel.c | 27 ---------------------
 accel/tcg/Makefile.objs  |  1 +
 accel/tcg/tcg-all.c      | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 65 insertions(+), 28 deletions(-)
 create mode 100644 accel/Makefile.objs
 rename accel.c => accel/accel.c (87%)
 create mode 100644 accel/tcg/Makefile.objs
 create mode 100644 accel/tcg/tcg-all.c

diff --git a/Makefile.objs b/Makefile.objs
index 0575802..d32f2db 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -52,7 +52,6 @@ common-obj-y += migration/
 
 common-obj-y += audio/
 common-obj-y += hw/
-common-obj-y += accel.o
 
 common-obj-y += replay/
 
diff --git a/Makefile.target b/Makefile.target
index ce8dfe4..c3c08ff 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -143,6 +143,7 @@ obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
 obj-y += qtest.o bootdevice.o
 obj-y += hw/
 obj-$(CONFIG_KVM) += kvm-all.o
+obj-y += accel/
 obj-y += memory.o cputlb.o
 obj-y += memory_mapping.o
 obj-y += dump.o
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
new file mode 100644
index 0000000..11ad823
--- /dev/null
+++ b/accel/Makefile.objs
@@ -0,0 +1,2 @@
+obj-$(CONFIG_SOFTMMU) += accel.o
+obj-y += tcg/
diff --git a/accel.c b/accel/accel.c
similarity index 87%
rename from accel.c
rename to accel/accel.c
index 664bb88..7c079a5 100644
--- a/accel.c
+++ b/accel/accel.c
@@ -34,15 +34,6 @@
 #include "hw/xen/xen.h"
 #include "qom/object.h"
 
-int tcg_tb_size;
-static bool tcg_allowed = true;
-
-static int tcg_init(MachineState *ms)
-{
-    tcg_exec_init(tcg_tb_size * 1024 * 1024);
-    return 0;
-}
-
 static const TypeInfo accel_type = {
     .name = TYPE_ACCEL,
     .parent = TYPE_OBJECT,
@@ -129,27 +120,9 @@ void configure_accelerator(MachineState *ms)
     }
 }
 
-
-static void tcg_accel_class_init(ObjectClass *oc, void *data)
-{
-    AccelClass *ac = ACCEL_CLASS(oc);
-    ac->name = "tcg";
-    ac->init_machine = tcg_init;
-    ac->allowed = &tcg_allowed;
-}
-
-#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
-
-static const TypeInfo tcg_accel_type = {
-    .name = TYPE_TCG_ACCEL,
-    .parent = TYPE_ACCEL,
-    .class_init = tcg_accel_class_init,
-};
-
 static void register_accel_types(void)
 {
     type_register_static(&accel_type);
-    type_register_static(&tcg_accel_type);
 }
 
 type_init(register_accel_types);
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
new file mode 100644
index 0000000..6e3211a
--- /dev/null
+++ b/accel/tcg/Makefile.objs
@@ -0,0 +1 @@
+obj-$(CONFIG_SOFTMMU) += tcg-all.o
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
new file mode 100644
index 0000000..dba9931
--- /dev/null
+++ b/accel/tcg/tcg-all.c
@@ -0,0 +1,61 @@
+/*
+ * QEMU System Emulator, accelerator interfaces
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2014 Red Hat Inc.
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
+#include "qemu/osdep.h"
+#include "sysemu/accel.h"
+#include "sysemu/sysemu.h"
+#include "qom/object.h"
+
+int tcg_tb_size;
+static bool tcg_allowed = true;
+
+static int tcg_init(MachineState *ms)
+{
+    tcg_exec_init(tcg_tb_size * 1024 * 1024);
+    return 0;
+}
+
+static void tcg_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+    ac->name = "tcg";
+    ac->init_machine = tcg_init;
+    ac->allowed = &tcg_allowed;
+}
+
+#define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
+
+static const TypeInfo tcg_accel_type = {
+    .name = TYPE_TCG_ACCEL,
+    .parent = TYPE_ACCEL,
+    .class_init = tcg_accel_class_init,
+};
+
+static void register_accel_types(void)
+{
+    type_register_static(&tcg_accel_type);
+}
+
+type_init(register_accel_types);
-- 
1.8.3.1
