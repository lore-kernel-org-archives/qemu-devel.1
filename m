Received: from eggs.gnu.org ([2001:4830:134:3::10]:55428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILwJ-0004CU-0r
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILwI-0008RU-0c
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:31 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:39467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILwH-0008QR-Q3
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:29 -0400
Received: by mail-pg0-x242.google.com with SMTP id e1-v6so6079441pga.6
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:27:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:27:09 -0700
Message-Id: <20180514222714.7982-9-richard.henderson@linaro.org>
In-Reply-To: <20180514222714.7982-1-richard.henderson@linaro.org>
References: <20180514222714.7982-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 08/13] target/openrisc: Convert dec_logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, peter.maydell@linaro.org

Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c  | 62 +++++++++++++++---------------------
 target/openrisc/insns.decode |  6 ++++
 2 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 48e26c4349..b5ff7577bd 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -998,42 +998,36 @@ static bool trans_l_msbu(DisasContext *dc, arg_ab *a, uint32_t insn)
     return true;
 }
 
-static void dec_logic(DisasContext *dc, uint32_t insn)
+static bool trans_l_slli(DisasContext *dc, arg_dal *a, uint32_t insn)
 {
-    uint32_t op0;
-    uint32_t rd, ra, L6, S6;
-    op0 = extract32(insn, 6, 2);
-    rd = extract32(insn, 21, 5);
-    ra = extract32(insn, 16, 5);
-    L6 = extract32(insn, 0, 6);
-    S6 = L6 & (TARGET_LONG_BITS - 1);
+    LOG_DIS("l.slli r%d, r%d, %d\n", a->d, a->a, a->l);
+    check_r0_write(a->d);
+    tcg_gen_shli_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
+    return true;
+}
 
-    check_r0_write(rd);
-    switch (op0) {
-    case 0x00:    /* l.slli */
-        LOG_DIS("l.slli r%d, r%d, %d\n", rd, ra, L6);
-        tcg_gen_shli_tl(cpu_R[rd], cpu_R[ra], S6);
-        break;
+static bool trans_l_srli(DisasContext *dc, arg_dal *a, uint32_t insn)
+{
+    LOG_DIS("l.srli r%d, r%d, %d\n", a->d, a->a, a->l);
+    check_r0_write(a->d);
+    tcg_gen_shri_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
+    return true;
+}
 
-    case 0x01:    /* l.srli */
-        LOG_DIS("l.srli r%d, r%d, %d\n", rd, ra, L6);
-        tcg_gen_shri_tl(cpu_R[rd], cpu_R[ra], S6);
-        break;
+static bool trans_l_srai(DisasContext *dc, arg_dal *a, uint32_t insn)
+{
+    LOG_DIS("l.srai r%d, r%d, %d\n", a->d, a->a, a->l);
+    check_r0_write(a->d);
+    tcg_gen_sari_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
+    return true;
+}
 
-    case 0x02:    /* l.srai */
-        LOG_DIS("l.srai r%d, r%d, %d\n", rd, ra, L6);
-        tcg_gen_sari_tl(cpu_R[rd], cpu_R[ra], S6);
-        break;
-
-    case 0x03:    /* l.rori */
-        LOG_DIS("l.rori r%d, r%d, %d\n", rd, ra, L6);
-        tcg_gen_rotri_tl(cpu_R[rd], cpu_R[ra], S6);
-        break;
-
-    default:
-        gen_illegal_exception(dc);
-        break;
-    }
+static bool trans_l_rori(DisasContext *dc, arg_dal *a, uint32_t insn)
+{
+    LOG_DIS("l.rori r%d, r%d, %d\n", a->d, a->a, a->l);
+    check_r0_write(a->d);
+    tcg_gen_rotri_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
+    return true;
 }
 
 static void dec_M(DisasContext *dc, uint32_t insn)
@@ -1490,10 +1484,6 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
         dec_M(dc, insn);
         break;
 
-    case 0x2e:
-        dec_logic(dc, insn);
-        break;
-
     case 0x2f:
         dec_compi(dc, insn);
         break;
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index 7240c6fb77..fb8ba5812a 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -20,6 +20,7 @@
 &dab            d a b
 &da             d a
 &ab             a b
+&dal            d a l
 
 ####
 # System Instructions
@@ -130,3 +131,8 @@ l_mac           110001 ----- a:5 b:5 ------- 0001
 l_macu          110001 ----- a:5 b:5 ------- 0011
 l_msb           110001 ----- a:5 b:5 ------- 0010
 l_msbu          110001 ----- a:5 b:5 ------- 0100
+
+l_slli          101110 d:5 a:5 -------- 00 l:6
+l_srli          101110 d:5 a:5 -------- 01 l:6
+l_srai          101110 d:5 a:5 -------- 10 l:6
+l_rori          101110 d:5 a:5 -------- 11 l:6
-- 
2.17.0
