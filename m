Received: from eggs.gnu.org ([209.51.188.92]:43001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbU-0002lp-Ao
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbS-0007MP-JK
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:40 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:43674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007BH-9r
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:38 -0500
Received: by mail-wr1-x435.google.com with SMTP id r10so15380558wrs.10
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.19 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:28 +0000
Message-Id: <20190118145805.6852-13-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/49] target/arm: Decode PAuth within
 disas_data_proc_1src
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
Message-id: 20190108223129.5570-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 146 +++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index dac61a3c3a5..8a8408c1b7d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4564,6 +4564,7 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
 static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 {
     unsigned int sf, opcode, opcode2, rn, rd;
+    TCGv_i64 tcg_rd;
 
     if (extract32(insn, 29, 1)) {
         unallocated_encoding(s);
@@ -4602,7 +4603,152 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
     case MAP(1, 0x00, 0x05):
         handle_cls(s, sf, rn, rd);
         break;
+    case MAP(1, 0x01, 0x00): /* PACIA */
+        if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_pacia(tcg_rd, cpu_env, tcg_rd, cpu_reg_sp(s, rn));
+        } else if (!dc_isar_feature(aa64_pauth, s)) {
+            goto do_unallocated;
+        }
+        break;
+    case MAP(1, 0x01, 0x01): /* PACIB */
+        if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_pacib(tcg_rd, cpu_env, tcg_rd, cpu_reg_sp(s, rn));
+        } else if (!dc_isar_feature(aa64_pauth, s)) {
+            goto do_unallocated;
+        }
+        break;
+    case MAP(1, 0x01, 0x02): /* PACDA */
+        if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_pacda(tcg_rd, cpu_env, tcg_rd, cpu_reg_sp(s, rn));
+        } else if (!dc_isar_feature(aa64_pauth, s)) {
+            goto do_unallocated;
+        }
+        break;
+    case MAP(1, 0x01, 0x03): /* PACDB */
+        if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_pacdb(tcg_rd, cpu_env, tcg_rd, cpu_reg_sp(s, rn));
+        } else if (!dc_isar_feature(aa64_pauth, s)) {
+            goto do_unallocated;
+        }
+        break;
+    case MAP(1, 0x01, 0x04): /* AUTIA */
+        if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_autia(tcg_rd, cpu_env, tcg_rd, cpu_reg_sp(s, rn));
+        } else if (!dc_isar_feature(aa64_pauth, s)) {
+            goto do_unallocated;
+        }
+        break;
+    case MAP(1, 0x01, 0x05): /* AUTIB */
+        if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_autib(tcg_rd, cpu_env, tcg_rd, cpu_reg_sp(s, rn));
+        } else if (!dc_isar_feature(aa64_pauth, s)) {
+            goto do_unallocated;
+        }
+        break;
+    case MAP(1, 0x01, 0x06): /* AUTDA */
+        if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_autda(tcg_rd, cpu_env, tcg_rd, cpu_reg_sp(s, rn));
+        } else if (!dc_isar_feature(aa64_pauth, s)) {
+            goto do_unallocated;
+        }
+        break;
+    case MAP(1, 0x01, 0x07): /* AUTDB */
+        if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_autdb(tcg_rd, cpu_env, tcg_rd, cpu_reg_sp(s, rn));
+        } else if (!dc_isar_feature(aa64_pauth, s)) {
+            goto do_unallocated;
+        }
+        break;
+    case MAP(1, 0x01, 0x08): /* PACIZA */
+        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
+            goto do_unallocated;
+        } else if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_pacia(tcg_rd, cpu_env, tcg_rd, new_tmp_a64_zero(s));
+        }
+        break;
+    case MAP(1, 0x01, 0x09): /* PACIZB */
+        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
+            goto do_unallocated;
+        } else if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_pacib(tcg_rd, cpu_env, tcg_rd, new_tmp_a64_zero(s));
+        }
+        break;
+    case MAP(1, 0x01, 0x0a): /* PACDZA */
+        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
+            goto do_unallocated;
+        } else if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_pacda(tcg_rd, cpu_env, tcg_rd, new_tmp_a64_zero(s));
+        }
+        break;
+    case MAP(1, 0x01, 0x0b): /* PACDZB */
+        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
+            goto do_unallocated;
+        } else if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_pacdb(tcg_rd, cpu_env, tcg_rd, new_tmp_a64_zero(s));
+        }
+        break;
+    case MAP(1, 0x01, 0x0c): /* AUTIZA */
+        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
+            goto do_unallocated;
+        } else if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_autia(tcg_rd, cpu_env, tcg_rd, new_tmp_a64_zero(s));
+        }
+        break;
+    case MAP(1, 0x01, 0x0d): /* AUTIZB */
+        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
+            goto do_unallocated;
+        } else if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_autib(tcg_rd, cpu_env, tcg_rd, new_tmp_a64_zero(s));
+        }
+        break;
+    case MAP(1, 0x01, 0x0e): /* AUTDZA */
+        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
+            goto do_unallocated;
+        } else if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_autda(tcg_rd, cpu_env, tcg_rd, new_tmp_a64_zero(s));
+        }
+        break;
+    case MAP(1, 0x01, 0x0f): /* AUTDZB */
+        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
+            goto do_unallocated;
+        } else if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_autdb(tcg_rd, cpu_env, tcg_rd, new_tmp_a64_zero(s));
+        }
+        break;
+    case MAP(1, 0x01, 0x10): /* XPACI */
+        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
+            goto do_unallocated;
+        } else if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_xpaci(tcg_rd, cpu_env, tcg_rd);
+        }
+        break;
+    case MAP(1, 0x01, 0x11): /* XPACD */
+        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
+            goto do_unallocated;
+        } else if (s->pauth_active) {
+            tcg_rd = cpu_reg(s, rd);
+            gen_helper_xpacd(tcg_rd, cpu_env, tcg_rd);
+        }
+        break;
     default:
+    do_unallocated:
         unallocated_encoding(s);
         break;
     }
-- 
2.20.1
