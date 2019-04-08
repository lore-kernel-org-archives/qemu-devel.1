Received: from eggs.gnu.org ([209.51.188.92]:58337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0L-0007Zk-03
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0J-0007Ap-ME
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:24 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0J-0007A3-BJ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:23 -0400
Received: by mail-oi1-x242.google.com with SMTP id e5so11346717oii.0
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:23 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
Date: Mon,  8 Apr 2019 14:27:44 -0400
Message-Id: <20190408182748.1238-2-jan.bobek@gmail.com>
In-Reply-To: <20190408182748.1238-1-jan.bobek@gmail.com>
References: <20190408182748.1238-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 1/5] risu_i386: move reginfo_t and related
 defines to risu_reginfo_i386.h
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
risu_reginfo_i386.{h,c}; this patch adds the former by extracting the
relevant code from risu_i386.c.

This patch is pure code motion; no functional changes were made.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c         | 23 +----------------------
 risu_reginfo_i386.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 22 deletions(-)
 create mode 100644 risu_reginfo_i386.h

diff --git a/risu_i386.c b/risu_i386.c
index 5e7e01d..6798a78 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -14,28 +14,7 @@
 #include <string.h>
 
 #include "risu.h"
-
-/* This is the data structure we pass over the socket.
- * It is a simplified and reduced subset of what can
- * be obtained with a ucontext_t*
- */
-struct reginfo {
-    uint32_t faulting_insn;
-    gregset_t gregs;
-};
-
-#ifndef REG_GS
-/* Assume that either we get all these defines or none */
-#define REG_GS 0
-#define REG_FS 1
-#define REG_ES 2
-#define REG_DS 3
-#define REG_ESP 7
-#define REG_TRAPNO 12
-#define REG_EIP 14
-#define REG_EFL 16
-#define REG_UESP 17
-#endif
+#include "risu_reginfo_i386.h"
 
 struct reginfo master_ri, apprentice_ri;
 
diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
new file mode 100644
index 0000000..5bba439
--- /dev/null
+++ b/risu_reginfo_i386.h
@@ -0,0 +1,37 @@
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
+#ifndef RISU_REGINFO_I386_H
+#define RISU_REGINFO_I386_H
+
+/* This is the data structure we pass over the socket.
+ * It is a simplified and reduced subset of what can
+ * be obtained with a ucontext_t*
+ */
+struct reginfo {
+    uint32_t faulting_insn;
+    gregset_t gregs;
+};
+
+#ifndef REG_GS
+/* Assume that either we get all these defines or none */
+#   define REG_GS      0
+#   define REG_FS      1
+#   define REG_ES      2
+#   define REG_DS      3
+#   define REG_ESP     7
+#   define REG_TRAPNO 12
+#   define REG_EIP    14
+#   define REG_EFL    16
+#   define REG_UESP   17
+#endif /* !defined(REG_GS) */
+
+#endif /* RISU_REGINFO_I386_H */
-- 
2.20.1
