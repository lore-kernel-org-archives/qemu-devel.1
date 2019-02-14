Received: from eggs.gnu.org ([209.51.188.92]:49454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8v-00034j-7s
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-00054W-8Y
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:02 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ03-0004us-D2
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:00:59 -0500
Received: by mail-lj1-x241.google.com with SMTP id f24-v6so6762953ljk.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:00:45 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:49 -0800
Message-Id: <20190214230000.24894-3-jcmvbkbc@gmail.com>
In-Reply-To: <20190214230000.24894-1-jcmvbkbc@gmail.com>
References: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 02/13] target/xtensa: don't require opcode
 table sorting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Requirement for alphabetical opcode sorting in opcode tables is awkward
and does not allow sharing implementation between multiple opcodes.
Use hash tables to find opcodes by name. Move implementation from the
translate.c to the helper.c to its only user and remove declaration from
the cpu.h

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  2 --
 target/xtensa/helper.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 target/xtensa/translate.c | 14 --------------
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 47d80a59e2f5..2765665ceca6 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -587,8 +587,6 @@ static inline void xtensa_select_static_vectors(CPUXtensaState *env,
     env->static_vectors = n;
 }
 void xtensa_runstall(CPUXtensaState *env, bool runstall);
-XtensaOpcodeOps *xtensa_find_opcode_ops(const XtensaOpcodeTranslators *t,
-                                        const char *opcode);
 
 #define XTENSA_OPTION_BIT(opt) (((uint64_t)1) << (opt))
 #define XTENSA_OPTION_ALL (~(uint64_t)0)
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 321ca4295521..57709fc20caf 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -30,10 +30,52 @@
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
+#include "qemu/error-report.h"
 #include "qemu/host-utils.h"
 
 static struct XtensaConfigList *xtensa_cores;
 
+static void add_translator_to_hash(GHashTable *translator,
+                                   const char *name,
+                                   const XtensaOpcodeOps *opcode)
+{
+    if (!g_hash_table_insert(translator, (void *)name, (void *)opcode)) {
+        error_report("Multiple definitions of '%s' opcode in a single table",
+                     name);
+    }
+}
+
+static GHashTable *hash_opcode_translators(const XtensaOpcodeTranslators *t)
+{
+    unsigned i, j;
+    GHashTable *translator = g_hash_table_new(g_str_hash, g_str_equal);
+
+    for (i = 0; i < t->num_opcodes; ++i) {
+        add_translator_to_hash(translator,
+                               (void *)t->opcode[i].name,
+                               (void *)(t->opcode + i));
+    }
+    return translator;
+}
+
+static XtensaOpcodeOps *
+xtensa_find_opcode_ops(const XtensaOpcodeTranslators *t,
+                       const char *name)
+{
+    static GHashTable *translators;
+    GHashTable *translator;
+
+    if (translators == NULL) {
+        translators = g_hash_table_new(g_direct_hash, g_direct_equal);
+    }
+    translator = g_hash_table_lookup(translators, t);
+    if (translator == NULL) {
+        translator = hash_opcode_translators(t);
+        g_hash_table_insert(translators, (void *)t, translator);
+    }
+    return g_hash_table_lookup(translator, name);
+}
+
 static void init_libisa(XtensaConfig *config)
 {
     unsigned i, j;
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 62283cd1ccc8..26342aaa1f82 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1274,20 +1274,6 @@ void restore_state_to_opc(CPUXtensaState *env, TranslationBlock *tb,
     env->pc = data[0];
 }
 
-static int compare_opcode_ops(const void *a, const void *b)
-{
-    return strcmp((const char *)a,
-                  ((const XtensaOpcodeOps *)b)->name);
-}
-
-XtensaOpcodeOps *
-xtensa_find_opcode_ops(const XtensaOpcodeTranslators *t,
-                       const char *name)
-{
-    return bsearch(name, t->opcode, t->num_opcodes,
-                   sizeof(XtensaOpcodeOps), compare_opcode_ops);
-}
-
 static void translate_abs(DisasContext *dc, const uint32_t arg[],
                           const uint32_t par[])
 {
-- 
2.11.0
