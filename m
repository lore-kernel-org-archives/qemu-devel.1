Received: from eggs.gnu.org ([2001:4830:134:3::10]:45604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9N5-0005OK-Su
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9N4-00068B-Nv
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:23 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55888)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9N4-00067i-B9
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:22 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 05 Jun 2018 13:39:21 +0300
Message-ID: <152819516132.30857.1700667353240369481.stgit@pasha-ThinkPad-T60>
In-Reply-To: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v2 1/7] tcg: add headers for non-target
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu

From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>

This patch adds functions and headers for adding the helpers from
the modules other than the target translators.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 include/exec/helper-register.h |   53 ++++++++++++++++++++++++++++++++++++++++
 tcg/tcg.c                      |   12 +++++++++
 tcg/tcg.h                      |    3 ++
 3 files changed, 68 insertions(+)
 create mode 100644 include/exec/helper-register.h

diff --git a/include/exec/helper-register.h b/include/exec/helper-register.h
new file mode 100644
index 0000000..aeface9
--- /dev/null
+++ b/include/exec/helper-register.h
@@ -0,0 +1,53 @@
+#ifndef HELPER_REGISTER_H
+#define HELPER_REGISTER_H
+
+#include "exec/helper-head.h"
+
+/* Need one more level of indirection before stringification
+   to get all the macros expanded first.  */
+#define str(s) #s
+
+#define DEF_HELPER_FLAGS_0(NAME, FLAGS, ret) \
+    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, dh_sizemask(ret, 0));
+
+#define DEF_HELPER_FLAGS_1(NAME, FLAGS, ret, t1) \
+    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
+        dh_sizemask(ret, 0) | dh_sizemask(t1, 1));
+
+#define DEF_HELPER_FLAGS_2(NAME, FLAGS, ret, t1, t2) \
+    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
+        dh_sizemask(ret, 0) | dh_sizemask(t1, 1) | dh_sizemask(t2, 2));
+
+#define DEF_HELPER_FLAGS_3(NAME, FLAGS, ret, t1, t2, t3) \
+    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
+        dh_sizemask(ret, 0) | dh_sizemask(t1, 1) | dh_sizemask(t2, 2) \
+        | dh_sizemask(t3, 3));
+
+#define DEF_HELPER_FLAGS_4(NAME, FLAGS, ret, t1, t2, t3, t4) \
+    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
+        dh_sizemask(ret, 0) | dh_sizemask(t1, 1) | dh_sizemask(t2, 2) \
+        | dh_sizemask(t3, 3) | dh_sizemask(t4, 4));
+
+#define DEF_HELPER_FLAGS_5(NAME, FLAGS, ret, t1, t2, t3, t4, t5) \
+    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
+        dh_sizemask(ret, 0) | dh_sizemask(t1, 1) | dh_sizemask(t2, 2) \
+        | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) | dh_sizemask(t5, 5));
+
+#define DEF_HELPER_FLAGS_6(NAME, FLAGS, ret, t1, t2, t3, t4, t5, t6) \
+    tcg_register_helper(HELPER(NAME), str(NAME), FLAGS, \
+        dh_sizemask(ret, 0) | dh_sizemask(t1, 1) | dh_sizemask(t2, 2) \
+        | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) | dh_sizemask(t5, 5) \
+        | dh_sizemask(t6, 6));
+
+#include "helper.h"
+
+#undef str
+#undef DEF_HELPER_FLAGS_0
+#undef DEF_HELPER_FLAGS_1
+#undef DEF_HELPER_FLAGS_2
+#undef DEF_HELPER_FLAGS_3
+#undef DEF_HELPER_FLAGS_4
+#undef DEF_HELPER_FLAGS_5
+#undef DEF_HELPER_FLAGS_6
+
+#endif /* HELPER_REGISTER_H */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 6eeebe0..8191381 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1623,6 +1623,18 @@ static inline const char *tcg_find_helper(TCGContext *s, uintptr_t val)
     return ret;
 }
 
+void tcg_register_helper(void *func, const char *name,
+                         unsigned flags, unsigned sizemask)
+{
+    TCGHelperInfo *info = g_new0(TCGHelperInfo, 1);
+    info->func = func;
+    info->name = name;
+    info->flags = flags;
+    info->sizemask = sizemask;
+
+    g_hash_table_insert(helper_table, func, info);
+}
+
 static const char * const cond_name[] =
 {
     [TCG_COND_NEVER] = "never",
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 08f8bbf..7a4b750 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -890,6 +890,9 @@ void tcg_register_thread(void);
 void tcg_prologue_init(TCGContext *s);
 void tcg_func_start(TCGContext *s);
 
+void tcg_register_helper(void *func, const char *name,
+                         unsigned flags, unsigned sizemask);
+
 int tcg_gen_code(TCGContext *s, TranslationBlock *tb);
 
 void tcg_set_frame(TCGContext *s, TCGReg reg, intptr_t start, intptr_t size);
