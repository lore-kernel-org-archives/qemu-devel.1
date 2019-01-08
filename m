Received: from eggs.gnu.org ([209.51.188.92]:52523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzub-00087Q-Lv
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzua-0004Lt-Nj
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:53 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzua-0004Kg-Hs
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:31:52 -0500
Received: by mail-pl1-x643.google.com with SMTP id b5so2568920plr.4
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:31:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:04 +1000
Message-Id: <20190108223129.5570-7-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 06/31] target/arm: Decode PAuth within
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Use binary literals.
---
 target/arm/translate-a64.c | 93 +++++++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 37a57af715..b72aea3e97 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1471,33 +1471,102 @@ static void handle_hint(DisasContext *s, uint32_t insn,
     }
 
     switch (selector) {
-    case 0: /* NOP */
-        return;
-    case 3: /* WFI */
+    case 0b00000: /* NOP */
+        break;
+    case 0b00011: /* WFI */
         s->base.is_jmp = DISAS_WFI;
-        return;
+        break;
+    case 0b00001: /* YIELD */
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
+    case 0b00010: /* WFE */
         if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
             s->base.is_jmp = DISAS_WFE;
         }
-        return;
-    case 4: /* SEV */
-    case 5: /* SEVL */
+        break;
+    case 0b00100: /* SEV */
+    case 0b00101: /* SEVL */
         /* we treat all as NOP at least for now */
-        return;
+        break;
+    case 0b00111: /* XPACLRI */
+        if (s->pauth_active) {
+            gen_helper_xpaci(cpu_X[30], cpu_env, cpu_X[30]);
+        }
+        break;
+    case 0b01000: /* PACIA1716 */
+        if (s->pauth_active) {
+            gen_helper_pacia(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+        }
+        break;
+    case 0b01010: /* PACIB1716 */
+        if (s->pauth_active) {
+            gen_helper_pacib(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+        }
+        break;
+    case 0b01100: /* AUTIA1716 */
+        if (s->pauth_active) {
+            gen_helper_autia(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+        }
+        break;
+    case 0b01110: /* AUTIB1716 */
+        if (s->pauth_active) {
+            gen_helper_autib(cpu_X[17], cpu_env, cpu_X[17], cpu_X[16]);
+        }
+        break;
+    case 0b11000: /* PACIAZ */
+        if (s->pauth_active) {
+            gen_helper_pacia(cpu_X[30], cpu_env, cpu_X[30],
+                                new_tmp_a64_zero(s));
+        }
+        break;
+    case 0b11001: /* PACIASP */
+        if (s->pauth_active) {
+            gen_helper_pacia(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
+        }
+        break;
+    case 0b11010: /* PACIBZ */
+        if (s->pauth_active) {
+            gen_helper_pacib(cpu_X[30], cpu_env, cpu_X[30],
+                                new_tmp_a64_zero(s));
+        }
+        break;
+    case 0b11011: /* PACIBSP */
+        if (s->pauth_active) {
+            gen_helper_pacib(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
+        }
+        break;
+    case 0b11100: /* AUTIAZ */
+        if (s->pauth_active) {
+            gen_helper_autia(cpu_X[30], cpu_env, cpu_X[30],
+                              new_tmp_a64_zero(s));
+        }
+        break;
+    case 0b11101: /* AUTIASP */
+        if (s->pauth_active) {
+            gen_helper_autia(cpu_X[30], cpu_env, cpu_X[30], cpu_X[31]);
+        }
+        break;
+    case 0b11110: /* AUTIBZ */
+        if (s->pauth_active) {
+            gen_helper_autib(cpu_X[30], cpu_env, cpu_X[30],
+                              new_tmp_a64_zero(s));
+        }
+        break;
+    case 0b11111: /* AUTIBSP */
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
