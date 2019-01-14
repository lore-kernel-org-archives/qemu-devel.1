Received: from eggs.gnu.org ([209.51.188.92]:51385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC84-00040q-Px
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC83-000107-UK
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:58:52 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 14 Jan 2019 23:58:32 +0000
Message-ID: <b17f45cb9053318f20ca2a5b2167afa96c1f933a.1547510220.git.alistair.francis@wdc.com>
References: <cover.1547510220.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1547510220.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 5/8] RISC-V: Add priv_ver to DisasContext
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

The gen methods should access state from DisasContext. Add priv_ver
field to the DisasContext struct.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0581b3c1f7..833adf1d6f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -43,6 +43,7 @@ typedef struct DisasContext {
     DisasContextBase base;
     /* pc_succ_insn points to the instruction following base.pc_next */
     target_ulong pc_succ_insn;
+    target_ulong priv_ver;
     uint32_t opcode;
     uint32_t mstatus_fs;
     uint32_t mem_idx;
@@ -1330,7 +1331,7 @@ static void gen_system(CPURISCVState *env, DisasConte=
xt *ctx, uint32_t opc,
 #ifndef CONFIG_USER_ONLY
     /* Extract funct7 value and check whether it matches SFENCE.VMA */
     if ((opc =3D=3D OPC_RISC_ECALL) && ((csr >> 5) =3D=3D 9)) {
-        if (env->priv_ver =3D=3D PRIV_VERSION_1_10_0) {
+        if (ctx->priv_ver =3D=3D PRIV_VERSION_1_10_0) {
             /* sfence.vma */
             /* TODO: handle ASID specific fences */
             gen_helper_tlb_flush(cpu_env);
@@ -1384,7 +1385,7 @@ static void gen_system(CPURISCVState *env, DisasConte=
xt *ctx, uint32_t opc,
             gen_helper_wfi(cpu_env);
             break;
         case 0x104: /* SFENCE.VM */
-            if (env->priv_ver <=3D PRIV_VERSION_1_09_1) {
+            if (ctx->priv_ver <=3D PRIV_VERSION_1_09_1) {
                 gen_helper_tlb_flush(cpu_env);
             } else {
                 gen_exception_illegal(ctx);
@@ -1851,13 +1852,15 @@ static void decode_opc(CPURISCVState *env, DisasCon=
text *ctx)
     }
 }
=20
-static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState=
 *cs)
+static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState=
 *cpu)
 {
     DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
+    CPURISCVState *env =3D cpu->env_ptr;
=20
     ctx->pc_succ_insn =3D ctx->base.pc_first;
     ctx->mem_idx =3D ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
     ctx->mstatus_fs =3D ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
+    ctx->priv_ver =3D env->priv_ver;
     ctx->frm =3D -1;  /* unknown rounding mode */
 }
=20
--=20
2.19.1
