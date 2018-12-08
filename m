Received: from eggs.gnu.org ([2001:4830:134:3::10]:40462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQoC-0003ZE-1a
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQo8-0001Kx-O6
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:49:27 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 8 Dec 2018 00:49:21 +0000
Message-ID: <ae5ded1970b8015626a389cf4e977a55be6f8cdb.1544229872.git.alistair.francis@wdc.com>
References: <cover.1544229872.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544229872.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v3 20/24] riscv: tcg-target: Add the prologue
 generation and register the JIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 111 +++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 29c8a30a7d..e5a4642609 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1783,3 +1783,114 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGO=
pcode op)
         return NULL;
     }
 }
+
+static const int tcg_target_callee_save_regs[] =3D {
+    TCG_REG_S0,       /* used for the global env (TCG_AREG0) */
+    TCG_REG_S1,
+    TCG_REG_S2,
+    TCG_REG_S3,
+    TCG_REG_S4,
+    TCG_REG_S5,
+    TCG_REG_S6,
+    TCG_REG_S7,
+    TCG_REG_S8,
+    TCG_REG_S9,
+    TCG_REG_S10,
+    TCG_REG_S11,
+    TCG_REG_RA,       /* should be last for ABI compliance */
+};
+
+/* Stack frame parameters.  */
+#define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
+#define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZ=
E)
+#define TEMP_SIZE  (CPU_TEMP_BUF_NLONGS * (int)sizeof(long))
+#define FRAME_SIZE ((TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE + SAVE_SIZE \
+                     + TCG_TARGET_STACK_ALIGN - 1) \
+                    & -TCG_TARGET_STACK_ALIGN)
+#define SAVE_OFS   (TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE)
+
+/* We're expecting to be able to use an immediate for frame allocation.  *=
/
+QEMU_BUILD_BUG_ON(FRAME_SIZE > 0x7ff);
+
+/* Generate global QEMU prologue and epilogue code */
+static void tcg_target_qemu_prologue(TCGContext *s)
+{
+    int i;
+
+    tcg_set_frame(s, TCG_REG_SP, TCG_STATIC_CALL_ARGS_SIZE, TEMP_SIZE);
+
+    /* TB prologue */
+    tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_SP, TCG_REG_SP, -FRAME_SIZE);
+    for (i =3D 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
+        tcg_out_st(s, TCG_TYPE_REG, tcg_target_callee_save_regs[i],
+                   TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
+    }
+
+#if !defined(CONFIG_SOFTMMU)
+    tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
+    tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
+#endif
+
+    /* Call generated code */
+    tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
+    tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, tcg_target_call_iarg_regs[1=
], 0);
+
+    /* Return path for goto_ptr. Set return value to 0 */
+    s->code_gen_epilogue =3D s->code_ptr;
+    tcg_out_mov(s, TCG_TYPE_REG, TCG_REG_A0, TCG_REG_ZERO);
+
+    /* TB epilogue */
+    tb_ret_addr =3D s->code_ptr;
+    for (i =3D 0; i < ARRAY_SIZE(tcg_target_callee_save_regs); i++) {
+        tcg_out_ld(s, TCG_TYPE_REG, tcg_target_callee_save_regs[i],
+                   TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
+    }
+
+    tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_SP, TCG_REG_SP, FRAME_SIZE);
+    tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_RA, 0);
+}
+
+typedef struct {
+    DebugFrameHeader h;
+    uint8_t fde_def_cfa[4];
+    uint8_t fde_reg_ofs[ARRAY_SIZE(tcg_target_callee_save_regs) * 2];
+} DebugFrame;
+
+#define ELF_HOST_MACHINE EM_RISCV
+
+static const DebugFrame debug_frame =3D {
+    .h.cie.len =3D sizeof(DebugFrameCIE) - 4, /* length after .len member =
*/
+    .h.cie.id =3D -1,
+    .h.cie.version =3D 1,
+    .h.cie.code_align =3D 1,
+    .h.cie.data_align =3D -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.return_column =3D TCG_REG_RA,
+
+    /* Total FDE size does not include the "len" member.  */
+    .h.fde.len =3D sizeof(DebugFrame) - offsetof(DebugFrame, h.fde.cie_off=
set),
+
+    .fde_def_cfa =3D {
+        12, TCG_REG_SP,                 /* DW_CFA_def_cfa sp, ... */
+        (FRAME_SIZE & 0x7f) | 0x80,     /* ... uleb128 FRAME_SIZE */
+        (FRAME_SIZE >> 7)
+    },
+    .fde_reg_ofs =3D {
+        0x80 + 9,  12,                  /* DW_CFA_offset, s1,  -96 */
+        0x80 + 18, 11,                  /* DW_CFA_offset, s2,  -88 */
+        0x80 + 19, 10,                  /* DW_CFA_offset, s3,  -80 */
+        0x80 + 20, 9,                   /* DW_CFA_offset, s4,  -72 */
+        0x80 + 21, 8,                   /* DW_CFA_offset, s5,  -64 */
+        0x80 + 22, 7,                   /* DW_CFA_offset, s6,  -56 */
+        0x80 + 23, 6,                   /* DW_CFA_offset, s7,  -48 */
+        0x80 + 24, 5,                   /* DW_CFA_offset, s8,  -40 */
+        0x80 + 25, 4,                   /* DW_CFA_offset, s9,  -32 */
+        0x80 + 26, 3,                   /* DW_CFA_offset, s10, -24 */
+        0x80 + 27, 2,                   /* DW_CFA_offset, s11, -16 */
+        0x80 + 1 , 1,                   /* DW_CFA_offset, ra,  -8 */
+    }
+};
+
+void tcg_register_jit(void *buf, size_t buf_size)
+{
+    tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame))=
;
+}
--=20
2.19.1
