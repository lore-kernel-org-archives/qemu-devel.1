Received: from eggs.gnu.org ([2001:4830:134:3::10]:40913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTp-0002JS-MD
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gDlTh-0004Ut-Lq
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:22 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:36866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gDlTh-0004IX-Ea
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 03:15:17 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Sat, 20 Oct 2018 09:14:34 +0200
Message-Id: <20181020071451.27808-13-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
References: <20181020071451.27808-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 12/29] target/riscv: Convert RV64F insns to
 decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, kbastian@mail.uni-paderborn.de
Cc: peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, richard.henderson@linaro.org, qemu-devel@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
---
v1 -> v2:
    - RISCV32 now returns false instead of raising an exception

 target/riscv/insn32.decode              |  6 +++
 target/riscv/insn_trans/trans_rvf.inc.c | 68 +++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f27bdab245..5d3d2a25ac 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -195,3 +195,9 @@ fclass_s   1110000  00000 ..... 001 ..... 1010011 @r2
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
index 3f806b8238..bd79ef96f8 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -332,3 +332,71 @@ static bool trans_fmv_w_x(DisasContext *ctx, arg_fmv_w_x *a, uint32_t insn)
 
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
+    return true;
+#else
+    return false;
+#endif
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
+    return true;
+#else
+    return false;
+#endif
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
+    return true;
+#else
+    return false;
+#endif
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
+    return true;
+#else
+    return false;
+#endif
+}
-- 
2.19.1
