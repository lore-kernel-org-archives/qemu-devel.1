Received: from eggs.gnu.org ([2001:4830:134:3::10]:33417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uF-0001Sa-AK
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uD-0005ri-2E
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4uC-00054E-Mb
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:20 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:31 -0500
Message-Id: <20181209193749.12277-21-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 20/38] plugin-gen: add plugin_insn_append
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

By adding it to plugin-gen's header file, we can export is as
an inline, since tcg.h is included in the header (we need tcg_ctx).

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/plugin-gen.h | 27 ++++++++++++++++++---------
 accel/tcg/plugin-gen.c    | 10 +++++++++-
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index 449ea16034..b09c16b720 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -15,15 +15,6 @@
 #include "qemu/plugin.h"
 #include "tcg/tcg.h"
 
-/* used by plugin_callback_start and plugin_callback_end TCG ops */
-enum plugin_gen_from {
-    PLUGIN_GEN_FROM_TB,
-    PLUGIN_GEN_FROM_INSN,
-    PLUGIN_GEN_FROM_MEM,
-    PLUGIN_GEN_AFTER_INSN,
-    PLUGIN_GEN_N_FROMS,
-};
-
 struct DisasContextBase;
 
 #ifdef CONFIG_PLUGIN
@@ -36,6 +27,21 @@ void plugin_gen_insn_end(void);
 void plugin_gen_disable_mem_helpers(void);
 void plugin_gen_empty_mem_callback(TCGv addr, uint8_t info);
 
+static inline void plugin_insn_append(const void *from, size_t size)
+{
+    struct qemu_plugin_insn *insn = tcg_ctx->plugin_insn;
+
+    if (insn == NULL) {
+        return;
+    }
+    if (unlikely(insn->size + size > insn->capacity)) {
+        insn->data = g_realloc(insn->data, insn->size + size);
+        insn->capacity = insn->size + size;
+    }
+    memcpy(insn->data + insn->size, from, size);
+    insn->size += size;
+}
+
 #else /* !CONFIG_PLUGIN */
 
 static inline
@@ -60,6 +66,9 @@ static inline void plugin_gen_disable_mem_helpers(void)
 static inline void plugin_gen_empty_mem_callback(TCGv addr, uint8_t info)
 { }
 
+static inline void plugin_insn_append(const void *from, size_t size)
+{ }
+
 #endif /* CONFIG_PLUGIN */
 
 #endif /* QEMU_PLUGIN_GEN_H */
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 06ec23e9f5..e6dd79e4d8 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -60,9 +60,17 @@
 /*
  * plugin_cb_start TCG op args[]:
  * 0: enum plugin_gen_from
- * 1: enum plugin_gen_cb (defined below)
+ * 1: enum plugin_gen_cb
  * 2: set to 1 if it's a mem callback and it's a write, 0 otherwise.
  */
+enum plugin_gen_from {
+    PLUGIN_GEN_FROM_TB,
+    PLUGIN_GEN_FROM_INSN,
+    PLUGIN_GEN_FROM_MEM,
+    PLUGIN_GEN_AFTER_INSN,
+    PLUGIN_GEN_N_FROMS,
+};
+
 enum plugin_gen_cb {
     PLUGIN_GEN_CB_UDATA,
     PLUGIN_GEN_CB_INLINE,
-- 
2.17.1
