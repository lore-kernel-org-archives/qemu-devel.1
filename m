Received: from eggs.gnu.org ([2001:4830:134:3::10]:39763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1HV-0001hP-O7
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gB1HS-000052-2A
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:21 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:55372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gB1HP-0008SU-GK
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 13:31:17 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Fri, 12 Oct 2018 19:30:30 +0200
Message-Id: <20181012173047.25420-12-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
References: <20181012173047.25420-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/28] target/riscv: Convert RV64F insns to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de
Cc: qemu-devel@nongnu.org, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
 target/riscv/insn32.decode              |  6 +++
 target/riscv/insn_trans/trans_rvf.inc.c | 70 +++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index b6807ef8dd..a629a717dc 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -196,3 +196,9 @@ fclass_s   1110000  00000 ..... 001 ..... 1010011 @r2
 fcvt_s_w   1101000  00000 ..... ... ..... 1010011 @r2_rm
 fcvt_s_wu  1101000  00001 ..... ... ..... 1010011 @r2_rm
 fmv_w_x    1111000  00000 ..... 000 ..... 1010011 @r2
+
+# *** RV64F Standard Extension (in addition to RV32F) ***
+fcvt_l_s   1100000  00010 ..... ... ..... 1010011 @r2_rm
+fcvt_lu_s  1100000  00011 ..... ... ..... 1010011 @r2_rm
+fcvt_s_l   1101000  00010 ..... ... ..... 1010011 @r2_rm
+fcvt_s_lu  1101000  00011 ..... ... ..... 1010011 @r2_rm
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index e24efc76b4..d33a0113c2 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -324,3 +324,73 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a, uint32_t insn)
 
     return true;
 }
+
+static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a, uint32_t insn)
+{
+#if defined(TARGET_RISCV64)
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_l_s(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+#else
+    gen_exception_illegal(ctx);
+#endif
+
+    return true;
+}
+
+static bool trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a, uint32_t insn)
+{
+#if defined(TARGET_RISCV64)
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_lu_s(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+#else
+    gen_exception_illegal(ctx);
+#endif
+
+    return true;
+}
+
+static bool trans_fcvt_s_l(DisasContext *ctx, arg_fcvt_s_l *a, uint32_t insn)
+{
+#if defined(TARGET_RISCV64)
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_s_l(cpu_fpr[a->rd], cpu_env, t0);
+
+    tcg_temp_free(t0);
+#else
+    gen_exception_illegal(ctx);
+#endif
+    return true;
+}
+
+static bool trans_fcvt_s_lu(DisasContext *ctx, arg_fcvt_s_lu *a, uint32_t insn)
+{
+#if defined(TARGET_RISCV64)
+    REQUIRE_FPU;
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_s_lu(cpu_fpr[a->rd], cpu_env, t0);
+
+    tcg_temp_free(t0);
+#else
+    gen_exception_illegal(ctx);
+#endif
+    return true;
+}
-- 
2.19.1
