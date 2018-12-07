Received: from eggs.gnu.org ([2001:4830:134:3::10]:59106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDV5-000843-07
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDV1-0007RE-NF
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:50 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDV1-0007QO-GX
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:47 -0500
Received: by mail-oi1-x241.google.com with SMTP id j21so2984619oii.8
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:36:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:12 -0600
Message-Id: <20181207103631.28193-8-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/26] target/arm: Decode PAuth within
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
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 146 +++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c5ec430b42..7ba4c996cf 100644
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
2.17.2
