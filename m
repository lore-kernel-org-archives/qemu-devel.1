Received: from eggs.gnu.org ([2001:4830:134:3::10]:38405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSY-0008Vr-N3
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSX-0004qB-UK
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:46 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fETSX-0004pi-ON
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:45 -0400
Received: by mail-pg0-x243.google.com with SMTP id z129-v6so10551202pgz.3
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 22:40:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  3 May 2018 22:40:26 -0700
Message-Id: <20180504054030.24527-10-richard.henderson@linaro.org>
In-Reply-To: <20180504054030.24527-1-richard.henderson@linaro.org>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/13] target/openrisc: Convert dec_M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c  | 41 +++++++++++++----------------------------
 target/openrisc/insns.decode |  3 +++
 2 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index f2f9a0c0d2..548e0230b3 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1031,32 +1031,21 @@ static bool trans_l_rori(DisasContext *dc, arg_dal *a, uint32_t insn)
     return true;
 }
 
-static void dec_M(DisasContext *dc, uint32_t insn)
+static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a, uint32_t insn)
 {
-    uint32_t op0;
-    uint32_t rd;
-    uint32_t K16;
-    op0 = extract32(insn, 16, 1);
-    rd = extract32(insn, 21, 5);
-    K16 = extract32(insn, 0, 16);
+    LOG_DIS("l.movhi r%d, %d\n", a->d, a->k);
+    check_r0_write(a->d);
+    tcg_gen_movi_tl(cpu_R[a->d], a->k << 16);
+    return true;
+}
 
-    check_r0_write(rd);
-    switch (op0) {
-    case 0x0:    /* l.movhi */
-        LOG_DIS("l.movhi  r%d, %d\n", rd, K16);
-        tcg_gen_movi_tl(cpu_R[rd], (K16 << 16));
-        break;
-
-    case 0x1:    /* l.macrc */
-        LOG_DIS("l.macrc  r%d\n", rd);
-        tcg_gen_trunc_i64_tl(cpu_R[rd], cpu_mac);
-        tcg_gen_movi_i64(cpu_mac, 0);
-        break;
-
-    default:
-        gen_illegal_exception(dc);
-        break;
-    }
+static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a, uint32_t insn)
+{
+    LOG_DIS("l.macrc r%d\n", a->d);
+    check_r0_write(a->d);
+    tcg_gen_trunc_i64_tl(cpu_R[a->d], cpu_mac);
+    tcg_gen_movi_i64(cpu_mac, 0);
+    return true;
 }
 
 static void dec_comp(DisasContext *dc, uint32_t insn)
@@ -1481,10 +1470,6 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
 
     op0 = extract32(insn, 26, 6);
     switch (op0) {
-    case 0x06:
-        dec_M(dc, insn);
-        break;
-
     case 0x2f:
         dec_compi(dc, insn);
         break;
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index fb8ba5812a..84f71c13b3 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -95,6 +95,9 @@ l_mtspr         110000 ..... a:5 b:5 ...........        k=%mtspr_k
 
 l_maci          010011 ----- a:5 i:s16
 
+l_movhi         000110 d:5 ----0 k:16
+l_macrc         000110 d:5 ----1 00000000 00000000
+
 ####
 # Arithmetic Instructions
 ####
-- 
2.14.3
