Received: from eggs.gnu.org ([2001:4830:134:3::10]:56655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSpM-0002KX-Ma
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSpJ-0004V0-Mw
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:16 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=7372f4cb7=Alistair.Francis@wdc.com>)
	id 1fiSpJ-0004TS-8r
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 19:04:13 -0400
From: Alistair Francis <alistair.francis@wdc.com>
Date: Wed, 25 Jul 2018 16:04:00 -0700
Message-Id: <1df1097f91c1d8e1817200ac1feefb5407ccb842.1532559484.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1532559484.git.alistair.francis@wdc.com>
References: <cover.1532559484.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 2/4] target/riscv: Implement the mtval
 illegal instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mjc@sifive.com
Cc: alistair.francis@wdc.com, alistair23@gmail.com

The mtval register can optionally contain the faulting instruction
on an illegal instruction exception. This patch adds support for setting
the mtval register based on the CPU feature.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       |  4 +++-
 target/riscv/helper.c    | 13 +++++++++++--
 target/riscv/translate.c | 12 ++++++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0243f73129..1bc46aa952 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -85,7 +85,8 @@
    is currently no bit in misa to indicate whether an MMU exists or not
    so a cpu features bitfield is required */
 enum {
-    RISCV_FEATURE_MMU
+    RISCV_FEATURE_MMU,
+    RISCV_FEATURE_MTVAL_INST
 };
 
 #define USER_VERSION_2_02_0 0x00020200
@@ -113,6 +114,7 @@ struct CPURISCVState {
     target_ulong frm;
 
     target_ulong badaddr;
+    target_ulong bins;
 
     target_ulong user_ver;
     target_ulong priv_ver;
diff --git a/target/riscv/helper.c b/target/riscv/helper.c
index b4a3f80872..bd78bcff28 100644
--- a/target/riscv/helper.c
+++ b/target/riscv/helper.c
@@ -491,9 +491,18 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                     ": badaddr 0x" TARGET_FMT_lx, env->mhartid, env->badaddr);
             }
             env->mtval = env->badaddr;
+        } else if (cs->exception_index & RISCV_EXCP_ILLEGAL_INST) {
+            if (riscv_feature(env, RISCV_FEATURE_MTVAL_INST)) {
+                /* The mtval register can optionally also be used to
+                 * return the faulting instruction bits on an illegal
+                 * instruction exception.
+                 */
+                env->mtval = env->bins;
+            } else {
+                env->mtval = 0;
+            }
         } else {
-            /* otherwise we must clear mbadaddr/mtval
-             * todo: support populating mtval on illegal instructions */
+            /* Otherwise we must clear mbadaddr/mtval */
             env->mtval = 0;
         }
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0b6be74f2d..1fe8b9c982 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -102,6 +102,15 @@ static void gen_exception_debug(void)
 
 static void gen_exception_illegal(DisasContext *ctx)
 {
+#if defined(TARGET_RISCV64)
+    TCGv_i64 helper_tmp = tcg_const_i64(ctx->opcode);
+    tcg_gen_st_tl(helper_tmp, cpu_env, offsetof(CPURISCVState, bins));
+    tcg_temp_free_i64(helper_tmp);
+#else
+    TCGv_i32 helper_tmp = tcg_const_i32(ctx->opcode);
+    tcg_gen_st_tl(helper_tmp, cpu_env, offsetof(CPURISCVState, bins));
+    tcg_temp_free_i32(helper_tmp);
+#endif
     generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
 }
 
@@ -1287,6 +1296,9 @@ static void gen_system(CPURISCVState *env, DisasContext *ctx, uint32_t opc,
     tcg_gen_movi_tl(rs1_pass, rs1);
     tcg_gen_movi_tl(csr_store, csr); /* copy into temp reg to feed to helper */
 
+    /* Store the opcode code incase we need it for mtval/stval. */
+    env->bins = ctx->opcode;
+
 #ifndef CONFIG_USER_ONLY
     /* Extract funct7 value and check whether it matches SFENCE.VMA */
     if ((opc == OPC_RISC_ECALL) && ((csr >> 5) == 9)) {
-- 
2.17.1
