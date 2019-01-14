Received: from eggs.gnu.org ([209.51.188.92]:51099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC78-0003Lg-LV
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:57:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC77-0008Vv-4R
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:57:54 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 14 Jan 2019 23:57:50 +0000
Message-ID: <c03e616f16ca91d5d6b6004949820109d8283791.1547510220.git.alistair.francis@wdc.com>
References: <cover.1547510220.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1547510220.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 1/8] RISC-V: Split out mstatus_fs from
 tb_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       |  6 +++---
 target/riscv/translate.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 743f02c8b9..681341f5d5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -275,8 +275,8 @@ void QEMU_NORETURN do_raise_exception_err(CPURISCVState=
 *env,
 target_ulong cpu_riscv_get_fflags(CPURISCVState *env);
 void cpu_riscv_set_fflags(CPURISCVState *env, target_ulong);
=20
-#define TB_FLAGS_MMU_MASK  3
-#define TB_FLAGS_FP_ENABLE MSTATUS_FS
+#define TB_FLAGS_MMU_MASK   3
+#define TB_FLAGS_MSTATUS_FS MSTATUS_FS
=20
 static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *=
pc,
                                         target_ulong *cs_base, uint32_t *f=
lags)
@@ -284,7 +284,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *=
env, target_ulong *pc,
     *pc =3D env->pc;
     *cs_base =3D 0;
 #ifdef CONFIG_USER_ONLY
-    *flags =3D TB_FLAGS_FP_ENABLE;
+    *flags =3D TB_FLAGS_MSTATUS_FS;
 #else
     *flags =3D cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
 #endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 312bf298b3..3d07d651b6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -44,7 +44,7 @@ typedef struct DisasContext {
     /* pc_succ_insn points to the instruction following base.pc_next */
     target_ulong pc_succ_insn;
     uint32_t opcode;
-    uint32_t flags;
+    uint32_t mstatus_fs;
     uint32_t mem_idx;
     /* Remember the rounding mode encoded in the previous fp instruction,
        which we have already installed into env->fp_status.  Or -1 for
@@ -656,7 +656,7 @@ static void gen_fp_load(DisasContext *ctx, uint32_t opc=
, int rd,
 {
     TCGv t0;
=20
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
+    if (ctx->mstatus_fs =3D=3D 0) {
         gen_exception_illegal(ctx);
         return;
     }
@@ -686,7 +686,7 @@ static void gen_fp_store(DisasContext *ctx, uint32_t op=
c, int rs1,
 {
     TCGv t0;
=20
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
+    if (ctx->mstatus_fs =3D=3D 0) {
         gen_exception_illegal(ctx);
         return;
     }
@@ -945,7 +945,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t op=
c, int rd,
 {
     TCGv t0 =3D NULL;
=20
-    if (!(ctx->flags & TB_FLAGS_FP_ENABLE)) {
+    if (ctx->mstatus_fs =3D=3D 0) {
         goto do_illegal;
     }
=20
@@ -1818,8 +1818,8 @@ static void riscv_tr_init_disas_context(DisasContextB=
ase *dcbase, CPUState *cs)
     DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
=20
     ctx->pc_succ_insn =3D ctx->base.pc_first;
-    ctx->flags =3D ctx->base.tb->flags;
     ctx->mem_idx =3D ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
+    ctx->mstatus_fs =3D ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
     ctx->frm =3D -1;  /* unknown rounding mode */
 }
=20
--=20
2.19.1
