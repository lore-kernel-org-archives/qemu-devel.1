Received: from eggs.gnu.org ([209.51.188.92]:58359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0M-0007Zv-It
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0K-0007BU-Kk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:26 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:41805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0K-0007B1-Cm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:24 -0400
Received: by mail-oi1-x22c.google.com with SMTP id v7so11304808oie.8
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:24 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
Date: Mon,  8 Apr 2019 14:27:45 -0400
Message-Id: <20190408182748.1238-3-jan.bobek@gmail.com>
In-Reply-To: <20190408182748.1238-1-jan.bobek@gmail.com>
References: <20190408182748.1238-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 2/5] risu_i386: move reginfo-related code
 to risu_reginfo_i386.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Bobek <jan.bobek@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

In order to build risu successfully for i386, we need files
risu_reginfo_i386.{h,c}; this patch adds the latter by extracting the
relevant code from risu_i386.c.

This patch is pure code motion; no functional changes were made.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c         | 54 -----------------------------------
 risu_reginfo_i386.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 54 deletions(-)
 create mode 100644 risu_reginfo_i386.c

diff --git a/risu_i386.c b/risu_i386.c
index 6798a78..2d2f325 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -33,43 +33,6 @@ void advance_pc(void *vuc)
     uc->uc_mcontext.gregs[REG_EIP] += 2;
 }
 
-static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
-{
-    int i;
-    for (i = 0; i < NGREG; i++) {
-        switch (i) {
-        case REG_ESP:
-        case REG_UESP:
-        case REG_GS:
-        case REG_FS:
-        case REG_ES:
-        case REG_DS:
-        case REG_TRAPNO:
-        case REG_EFL:
-            /* Don't store these registers as it results in mismatches.
-             * In particular valgrind has different values for some
-             * segment registers, and they're boring anyway.
-             * We really shouldn't be ignoring EFL but valgrind doesn't
-             * seem to set it right and I don't care to investigate.
-             */
-            ri->gregs[i] = 0xDEADBEEF;
-            break;
-        case REG_EIP:
-            /* Store the offset from the start of the test image */
-            ri->gregs[i] = uc->uc_mcontext.gregs[i] - image_start_address;
-            break;
-        default:
-            ri->gregs[i] = uc->uc_mcontext.gregs[i];
-            break;
-        }
-    }
-    /* x86 insns aren't 32 bit but we're not really testing x86 so
-     * this is just to distinguish 'do compare' from 'stop'
-     */
-    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
-}
-
-
 int send_register_info(int sock, void *uc)
 {
     struct reginfo ri;
@@ -100,23 +63,6 @@ int recv_and_compare_register_info(int sock, void *uc)
     return resp;
 }
 
-static char *regname[] = {
-    "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
-    "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
-    "CS", "EFL", "UESP", "SS", 0
-};
-
-static void dump_reginfo(struct reginfo *ri)
-{
-    int i;
-    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
-    for (i = 0; i < NGREG; i++) {
-        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
-                ri->gregs[i]);
-    }
-}
-
-
 /* Print a useful report on the status of the last comparison
  * done in recv_and_compare_register_info(). This is called on
  * exit, so need not restrict itself to signal-safe functions.
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
new file mode 100644
index 0000000..e8d671f
--- /dev/null
+++ b/risu_reginfo_i386.c
@@ -0,0 +1,68 @@
+/*******************************************************************************
+ * Copyright (c) 2010 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Peter Maydell (Linaro) - initial implementation
+ ******************************************************************************/
+
+#include <stdio.h>
+#include <ucontext.h>
+
+#include "risu.h"
+#include "risu_reginfo_i386.h"
+
+static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
+{
+    int i;
+    for (i = 0; i < NGREG; i++) {
+        switch (i) {
+        case REG_ESP:
+        case REG_UESP:
+        case REG_GS:
+        case REG_FS:
+        case REG_ES:
+        case REG_DS:
+        case REG_TRAPNO:
+        case REG_EFL:
+            /* Don't store these registers as it results in mismatches.
+             * In particular valgrind has different values for some
+             * segment registers, and they're boring anyway.
+             * We really shouldn't be ignoring EFL but valgrind doesn't
+             * seem to set it right and I don't care to investigate.
+             */
+            ri->gregs[i] = 0xDEADBEEF;
+            break;
+        case REG_EIP:
+            /* Store the offset from the start of the test image */
+            ri->gregs[i] = uc->uc_mcontext.gregs[i] - image_start_address;
+            break;
+        default:
+            ri->gregs[i] = uc->uc_mcontext.gregs[i];
+            break;
+        }
+    }
+    /* x86 insns aren't 32 bit but we're not really testing x86 so
+     * this is just to distinguish 'do compare' from 'stop'
+     */
+    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
+}
+
+static char *regname[] = {
+    "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
+    "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
+    "CS", "EFL", "UESP", "SS", 0
+};
+
+static void dump_reginfo(struct reginfo *ri)
+{
+    int i;
+    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
+    for (i = 0; i < NGREG; i++) {
+        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
+                ri->gregs[i]);
+    }
+}
-- 
2.20.1
