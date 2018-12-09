Received: from eggs.gnu.org ([2001:4830:134:3::10]:33428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uF-0001Sy-MQ
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uD-0005tT-IQ
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:40653)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4uD-00054C-5v
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:21 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:32 -0500
Message-Id: <20181209193749.12277-22-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 21/38] translator: add translator_ld{ub, sw, uw,
 l, q}
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/translator.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 71e7b2c347..39f6f514a7 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -19,7 +19,10 @@
  */
 
 
+#include "qemu/bswap.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "exec/plugin-gen.h"
 #include "tcg/tcg.h"
 
 
@@ -141,4 +144,29 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
 
 void translator_loop_temp_check(DisasContextBase *db);
 
+#define GEN_TRANSLATOR_LD(fullname, name, type, swap_fn)                \
+    static inline type                                                  \
+    fullname ## _swap(CPUArchState *env, abi_ptr pc, bool do_swap)      \
+    {                                                                   \
+        type ret = cpu_ ## name ## _code(env, pc);                      \
+                                                                        \
+        if (do_swap) {                                                  \
+            ret = swap_fn(ret);                                         \
+        }                                                               \
+        plugin_insn_append(&ret, sizeof(ret));                          \
+        return ret;                                                     \
+    }                                                                   \
+                                                                        \
+    static inline type fullname(CPUArchState *env, abi_ptr pc)          \
+    {                                                                   \
+        return fullname ## _swap(env, pc, false);                       \
+    }
+
+GEN_TRANSLATOR_LD(translator_ldub, ldub, uint8_t, /* no swap needed */)
+GEN_TRANSLATOR_LD(translator_ldsw, ldsw, int16_t, bswap16)
+GEN_TRANSLATOR_LD(translator_lduw, lduw, uint16_t, bswap16)
+GEN_TRANSLATOR_LD(translator_ldl, ldl, uint32_t, bswap32)
+GEN_TRANSLATOR_LD(translator_ldq, ldq, uint64_t, bswap64)
+#undef GEN_TRANSLATOR_LD
+
 #endif  /* EXEC__TRANSLATOR_H */
-- 
2.17.1
