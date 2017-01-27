Received: from eggs.gnu.org ([2001:4830:134:3::10]:47858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3sA-0007pp-NX
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3s9-00029G-E1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:14 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX3s9-00028i-8H
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:35:13 -0500
Received: by mail-wm0-x234.google.com with SMTP id r126so110787979wmr.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:35:13 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:34:44 +0000
Message-Id: <20170127103505.18606-5-alex.bennee@linaro.org>
In-Reply-To: <20170127103505.18606-1-alex.bennee@linaro.org>
References: <20170127103505.18606-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 04/25] tcg: move TCG_MO/BAR types into own
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>

We'll be using the memory ordering definitions to define values for
both the host and guest. To avoid fighting with circular header
dependencies just move these types into their own minimal header.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg-mo.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg.h    | 18 +-----------------
 2 files changed, 46 insertions(+), 17 deletions(-)
 create mode 100644 tcg/tcg-mo.h

diff --git a/tcg/tcg-mo.h b/tcg/tcg-mo.h
new file mode 100644
index 0000000000..429b022561
--- /dev/null
+++ b/tcg/tcg-mo.h
@@ -0,0 +1,45 @@
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2008 Fabrice Bellard
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
+#ifndef TCG_MO_H
+#define TCG_MO_H
+
+typedef enum {
+    /* Used to indicate the type of accesses on which ordering
+       is to be ensured.  Modeled after SPARC barriers.  */
+    TCG_MO_LD_LD  = 0x01,
+    TCG_MO_ST_LD  = 0x02,
+    TCG_MO_LD_ST  = 0x04,
+    TCG_MO_ST_ST  = 0x08,
+    TCG_MO_ALL    = 0x0F,  /* OR of the above */
+
+    /* Used to indicate the kind of ordering which is to be ensured by the
+       instruction.  These types are derived from x86/aarch64 instructions.
+       It should be noted that these are different from C11 semantics.  */
+    TCG_BAR_LDAQ  = 0x10,  /* Following ops will not come forward */
+    TCG_BAR_STRL  = 0x20,  /* Previous ops will not be delayed */
+    TCG_BAR_SC    = 0x30,  /* No ops cross barrier; OR of the above */
+} TCGBar;
+
+#endif /* TCG_MO_H */
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 631c6f69b1..f946452049 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -29,6 +29,7 @@
 #include "cpu.h"
 #include "exec/tb-context.h"
 #include "qemu/bitops.h"
+#include "tcg-mo.h"
 #include "tcg-target.h"
 
 /* XXX: make safe guess about sizes */
@@ -498,23 +499,6 @@ static inline intptr_t QEMU_ARTIFICIAL GET_TCGV_PTR(TCGv_ptr t)
 #define TCG_CALL_DUMMY_TCGV     MAKE_TCGV_I32(-1)
 #define TCG_CALL_DUMMY_ARG      ((TCGArg)(-1))
 
-typedef enum {
-    /* Used to indicate the type of accesses on which ordering
-       is to be ensured.  Modeled after SPARC barriers.  */
-    TCG_MO_LD_LD  = 0x01,
-    TCG_MO_ST_LD  = 0x02,
-    TCG_MO_LD_ST  = 0x04,
-    TCG_MO_ST_ST  = 0x08,
-    TCG_MO_ALL    = 0x0F,  /* OR of the above */
-
-    /* Used to indicate the kind of ordering which is to be ensured by the
-       instruction.  These types are derived from x86/aarch64 instructions.
-       It should be noted that these are different from C11 semantics.  */
-    TCG_BAR_LDAQ  = 0x10,  /* Following ops will not come forward */
-    TCG_BAR_STRL  = 0x20,  /* Previous ops will not be delayed */
-    TCG_BAR_SC    = 0x30,  /* No ops cross barrier; OR of the above */
-} TCGBar;
-
 /* Conditions.  Note that these are laid out for easy manipulation by
    the functions below:
      bit 0 is used for inverting;
-- 
2.11.0
