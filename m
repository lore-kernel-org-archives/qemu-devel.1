Received: from eggs.gnu.org ([209.51.188.92]:50181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gzq3Q-0003Pj-3X
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gzq3M-0002y9-Kv
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:50:51 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:45296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gzq3K-0002EI-3w
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:50:48 -0500
Received: by mail-pg1-x534.google.com with SMTP id y4so12023633pgc.12
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 13:50:18 -0800 (PST)
Date: Fri,  1 Mar 2019 13:49:23 -0800
Message-Id: <20190301214945.4353-13-palmer@sifive.com>
In-Reply-To: <20190301214945.4353-1-palmer@sifive.com>
References: <20190301214945.4353-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 12/34] target/riscv: Convert RV64F insns to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/insn32-64.decode           |  6 +++
 target/riscv/insn_trans/trans_rvf.inc.c | 60 +++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/target/riscv/insn32-64.decode b/target/riscv/insn32-64.decode
index 0bee95c9840d..6319f872ac1d 100644
--- a/target/riscv/insn32-64.decode
+++ b/target/riscv/insn32-64.decode
@@ -56,3 +56,9 @@ amomin_d   10000 . . ..... ..... 011 ..... 0101111 @atom_st
 amomax_d   10100 . . ..... ..... 011 ..... 0101111 @atom_st
 amominu_d  11000 . . ..... ..... 011 ..... 0101111 @atom_st
 amomaxu_d  11100 . . ..... ..... 011 ..... 0101111 @atom_st
+
+# *** RV64F Standard Extension (in addition to RV32F) ***
+fcvt_l_s   1100000  00010 ..... ... ..... 1010011 @r2_rm
+fcvt_lu_s  1100000  00011 ..... ... ..... 1010011 @r2_rm
+fcvt_s_l   1101000  00010 ..... ... ..... 1010011 @r2_rm
+fcvt_s_lu  1101000  00011 ..... ... ..... 1010011 @r2_rm
diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 0f837903491b..172dbfa919b6 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -377,3 +377,63 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a)
 
     return true;
 }
+
+#ifdef TARGET_RISCV64
+static bool trans_fcvt_l_s(DisasContext *ctx, arg_fcvt_l_s *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVF);
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_l_s(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fcvt_lu_s(DisasContext *ctx, arg_fcvt_lu_s *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVF);
+
+    TCGv t0 = tcg_temp_new();
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_lu_s(t0, cpu_env, cpu_fpr[a->rs1]);
+    gen_set_gpr(a->rd, t0);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fcvt_s_l(DisasContext *ctx, arg_fcvt_s_l *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVF);
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_s_l(cpu_fpr[a->rd], cpu_env, t0);
+
+    mark_fs_dirty(ctx);
+    tcg_temp_free(t0);
+    return true;
+}
+
+static bool trans_fcvt_s_lu(DisasContext *ctx, arg_fcvt_s_lu *a)
+{
+    REQUIRE_FPU;
+    REQUIRE_EXT(ctx, RVF);
+
+    TCGv t0 = tcg_temp_new();
+    gen_get_gpr(t0, a->rs1);
+
+    gen_set_rm(ctx, a->rm);
+    gen_helper_fcvt_s_lu(cpu_fpr[a->rd], cpu_env, t0);
+
+    mark_fs_dirty(ctx);
+    tcg_temp_free(t0);
+    return true;
+}
+#endif
-- 
2.18.1
