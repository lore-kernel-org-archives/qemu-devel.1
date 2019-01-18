Received: from eggs.gnu.org ([209.51.188.92]:42984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbT-0002lN-Vm
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbP-0007K4-TI
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:39 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:44105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbN-00079M-Uy
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:35 -0500
Received: by mail-wr1-x42f.google.com with SMTP id z5so15375021wrt.11
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:26 +0000
Message-Id: <20190118145805.6852-11-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/49] target/arm: Decode PAuth within system
 hint space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 93 +++++++++++++++++++++++++++++++++-----
 1 file changed, 81 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 37a57af7150..b72aea3e974 100644
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
2.20.1
