Received: from eggs.gnu.org ([2001:4830:134:3::10]:33426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uF-0001Sw-L6
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uE-0005ty-0K
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:23 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54877)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4uD-00054P-Mw
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:21 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:33 -0500
Message-Id: <20181209193749.12277-23-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 22/38] target/arm: call qemu_plugin_insn_append
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

I considered using translator_ld* from arm_ldl_code
et al. However, note that there's a helper that also calls
arm_ldl_code, so we'd have to change that caller.

In thumb's case I'm also calling plugin_insn_append directly,
since we can't assume that all instructions are 16 bits long.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/translate-a64.c | 2 ++
 target/arm/translate.c     | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 88195ab949..db95161c16 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -38,6 +38,7 @@
 #include "trace-tcg.h"
 #include "translate-a64.h"
 #include "qemu/atomic128.h"
+#include "qemu/plugin.h"
 
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
@@ -13321,6 +13322,7 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
     uint32_t insn;
 
     insn = arm_ldl_code(env, s->pc, s->sctlr_b);
+    plugin_insn_append(&insn, sizeof(insn));
     s->insn = insn;
     s->pc += 4;
 
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7c4675ffd8..d5171f54f6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -13234,6 +13234,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     }
 
     insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
+    plugin_insn_append(&insn, sizeof(insn));
     dc->insn = insn;
     dc->pc += 4;
     disas_arm_insn(dc, insn);
@@ -13304,11 +13305,16 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
     is_16bit = thumb_insn_is_16bit(dc, insn);
     dc->pc += 2;
-    if (!is_16bit) {
+    if (is_16bit) {
+        uint16_t insn16 = insn;
+
+        plugin_insn_append(&insn16, sizeof(insn16));
+    } else {
         uint32_t insn2 = arm_lduw_code(env, dc->pc, dc->sctlr_b);
 
         insn = insn << 16 | insn2;
         dc->pc += 2;
+        plugin_insn_append(&insn, sizeof(insn));
     }
     dc->insn = insn;
 
-- 
2.17.1
