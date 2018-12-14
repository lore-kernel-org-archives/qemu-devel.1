Received: from eggs.gnu.org ([2001:4830:134:3::10]:55676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxY-0004PO-KT
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxX-0005M9-ID
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:24 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxX-0005Ke-C4
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:23 -0500
Received: by mail-ot1-x343.google.com with SMTP id 81so4325841otj.2
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:23:48 -0600
Message-Id: <20181214052410.11863-6-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 05/27] target/arm: Decode PAuth within
 system hint space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 93 +++++++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7c1cc1ce8e..0df344f9e8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1471,33 +1471,102 @@ static void handle_hint(DisasContext *s, uint32_t insn,
     }
 
     switch (selector) {
-    case 0: /* NOP */
-        return;
-    case 3: /* WFI */
+    case 000: /* NOP */
+        break;
+    case 003: /* WFI */
         s->base.is_jmp = DISAS_WFI;
-        return;
+        break;
+    case 001: /* YIELD */
         /* When running in MTTCG we don't generate jumps to the yield and
          * WFE helpers as it won't affect the scheduling of other vCPUs.
          * If we wanted to more completely model WFE/SEV so we don't busy
          * spin unnecessarily we would need to do something more involved.
          */
-    case 1: /* YIELD */
         if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
             s->base.is_jmp = DISAS_YIELD;
         }
-        return;
-    case 2: /* WFE */
+        break;
+    case 002: /* WFE */
         if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
             s->base.is_jmp = DISAS_WFE;
         }
-        return;
-    case 4: /* SEV */
-    case 5: /* SEVL */
+        break;
+    case 004: /* SEV */
+    case 005: /* SEVL */
         /* we treat all as NOP at least for now */
-        return;
+        break;
+    case 007: /* XPACLRI */
+        if (s->pauth_active) {
+            gen_helper_xpaci(cpu_X[30], cpu_env, cpu_X[30]);
+        }
+        break;
+    case 010: /* PACIA1716 */
+        if (s->pauth_active) {
+            gen_helper_pacia(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+        }
+        break;
+    case 012: /* PACIB1716 */
+        if (s->pauth_active) {
+            gen_helper_pacib(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+        }
+        break;
+    case 014: /* AUTIA1716 */
+        if (s->pauth_active) {
+            gen_helper_autia(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+        }
+        break;
+    case 016: /* AUTIB1716 */
+        if (s->pauth_active) {
+            gen_helper_autib(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+        }
+        break;
+    case 030: /* PACIAZ */
+        if (s->pauth_active) {
+            gen_helper_pacia(cpu_X[30], cpu_env, cpu_X[30],
+                                new_tmp_a64_zero(s));
+        }
+        break;
+    case 031: /* PACIASP */
+        if (s->pauth_active) {
+            gen_helper_pacia(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
+        }
+        break;
+    case 032: /* PACIBZ */
+        if (s->pauth_active) {
+            gen_helper_pacib(cpu_X[30], cpu_env, cpu_X[30],
+                                new_tmp_a64_zero(s));
+        }
+        break;
+    case 033: /* PACIBSP */
+        if (s->pauth_active) {
+            gen_helper_pacib(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
+        }
+        break;
+    case 034: /* AUTIAZ */
+        if (s->pauth_active) {
+            gen_helper_autia(cpu_X[30], cpu_env, cpu_X[30],
+                              new_tmp_a64_zero(s));
+        }
+        break;
+    case 035: /* AUTIASP */
+        if (s->pauth_active) {
+            gen_helper_autia(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
+        }
+        break;
+    case 036: /* AUTIBZ */
+        if (s->pauth_active) {
+            gen_helper_autib(cpu_X[30], cpu_env, cpu_X[30],
+                              new_tmp_a64_zero(s));
+        }
+        break;
+    case 037: /* AUTIBSP */
+        if (s->pauth_active) {
+            gen_helper_autib(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
+        }
+        break;
     default:
         /* default specified as NOP equivalent */
-        return;
+        break;
     }
 }
 
-- 
2.17.2
