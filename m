Received: from eggs.gnu.org ([209.51.188.92]:51150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC7K-0003X2-IB
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=910900a2a=Alistair.Francis@wdc.com>)
	id 1gjC7I-0000J4-GF
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 18:58:06 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Mon, 14 Jan 2019 23:57:59 +0000
Message-ID: <c0db51a0307fd7e46184b8e01ee60be508ea9da0.1547510220.git.alistair.francis@wdc.com>
References: <cover.1547510220.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1547510220.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 2/8] RISC-V: Mark mstatus.fs dirty
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

Modifed from Richard Henderson's patch [1] to integrate
with the new control and status register implementation.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg07034.html

Note: the f* CSRs already mark mstatus.FS dirty using
env->mstatus |=3D mstatus.FS so the bug in the first
spin of this patch has been fixed in a prior commit.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Co-authored-by: Michael Clark <mjc@sifive.com>
---
 target/riscv/csr.c       | 12 ------------
 target/riscv/translate.c | 40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5e7e7d16b8..5714147689 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -317,18 +317,6 @@ static int write_mstatus(CPURISCVState *env, int csrno=
, target_ulong val)
=20
     mstatus =3D (mstatus & ~mask) | (val & mask);
=20
-    /* Note: this is a workaround for an issue where mstatus.FS
-       does not report dirty after floating point operations
-       that modify floating point state. This workaround is
-       technically compliant with the RISC-V Privileged
-       specification as it is legal to return only off, or dirty.
-       at the expense of extra floating point save/restore. */
-
-    /* FP is always dirty or off */
-    if (mstatus & MSTATUS_FS) {
-        mstatus |=3D MSTATUS_FS;
-    }
-
     int dirty =3D ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS) |
                 ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
     mstatus =3D set_field(mstatus, MSTATUS_SD, dirty);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 3d07d651b6..0581b3c1f7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -651,6 +651,31 @@ static void gen_store(DisasContext *ctx, uint32_t opc,=
 int rs1, int rs2,
     tcg_temp_free(dat);
 }
=20
+#ifndef CONFIG_USER_ONLY
+/* The states of mstatus_fs are:
+ * 0 =3D disabled, 1 =3D initial, 2 =3D clean, 3 =3D dirty
+ * We will have already diagnosed disabled state,
+ * and need to turn initial/clean into dirty.
+ */
+static void mark_fs_dirty(DisasContext *ctx)
+{
+    TCGv tmp;
+    if (ctx->mstatus_fs =3D=3D MSTATUS_FS) {
+        return;
+    }
+    /* Remember the state change for the rest of the TB.  */
+    ctx->mstatus_fs =3D MSTATUS_FS;
+
+    tmp =3D tcg_temp_new();
+    tcg_gen_ld_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
+    tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
+    tcg_gen_st_tl(tmp, cpu_env, offsetof(CPURISCVState, mstatus));
+    tcg_temp_free(tmp);
+}
+#else
+static inline void mark_fs_dirty(DisasContext *ctx) { }
+#endif
+
 static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
         int rs1, target_long imm)
 {
@@ -679,6 +704,8 @@ static void gen_fp_load(DisasContext *ctx, uint32_t opc=
, int rd,
         break;
     }
     tcg_temp_free(t0);
+
+    mark_fs_dirty(ctx);
 }
=20
 static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
@@ -944,6 +971,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t op=
c, int rd,
                          int rs1, int rs2, int rm)
 {
     TCGv t0 =3D NULL;
+    bool fp_output =3D true;
=20
     if (ctx->mstatus_fs =3D=3D 0) {
         goto do_illegal;
@@ -1006,6 +1034,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t =
opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output =3D false;
         break;
=20
     case OPC_RISC_FCVT_W_S:
@@ -1035,6 +1064,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t =
opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output =3D false;
         break;
=20
     case OPC_RISC_FCVT_S_W:
@@ -1085,6 +1115,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t =
opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output =3D false;
         break;
=20
     case OPC_RISC_FMV_S_X:
@@ -1177,6 +1208,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t =
opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output =3D false;
         break;
=20
     case OPC_RISC_FCVT_W_D:
@@ -1206,6 +1238,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t =
opc, int rd,
         }
         gen_set_gpr(rd, t0);
         tcg_temp_free(t0);
+        fp_output =3D false;
         break;
=20
     case OPC_RISC_FCVT_D_W:
@@ -1254,6 +1287,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t =
opc, int rd,
         default:
             goto do_illegal;
         }
+        fp_output =3D false;
         break;
=20
 #if defined(TARGET_RISCV64)
@@ -1271,7 +1305,11 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t=
 opc, int rd,
             tcg_temp_free(t0);
         }
         gen_exception_illegal(ctx);
-        break;
+        return;
+    }
+
+    if (fp_output) {
+        mark_fs_dirty(ctx);
     }
 }
=20
--=20
2.19.1
