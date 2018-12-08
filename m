Received: from eggs.gnu.org ([2001:4830:134:3::10]:40240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQni-0003CE-Ik
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQnf-0001AC-77
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:48:58 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 8 Dec 2018 00:48:51 +0000
Message-ID: <989024c7cf2a45f6e4a7d793f7760c90e1b36e45.1544229872.git.alistair.francis@wdc.com>
References: <cover.1544229872.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544229872.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v3 17/24] riscv: tcg-target: Add slowpath load
 and store instructions
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.inc.c | 254 +++++++++++++++++++++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index a00bbe8ff1..9d07d5ecde 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -878,3 +878,257 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit=
 *arg)
 {
     tcg_out_call_int(s, arg, false);
 }
+
+static void tcg_out_mb(TCGContext *s, TCGArg a0)
+{
+    tcg_insn_unit insn =3D OPC_FENCE;
+
+    if (a0 & TCG_MO_LD_LD) {
+        insn |=3D 0x02200000;
+    }
+    if (a0 & TCG_MO_ST_LD) {
+        insn |=3D 0x01200000;
+    }
+    if (a0 & TCG_MO_LD_ST) {
+        insn |=3D 0x02100000;
+    }
+    if (a0 & TCG_MO_ST_ST) {
+        insn |=3D 0x02200000;
+    }
+    tcg_out32(s, insn);
+}
+
+/*
+ * Load/store and TLB
+ */
+
+#if defined(CONFIG_SOFTMMU)
+#include "tcg-ldst.inc.c"
+
+/* helper signature: helper_ret_ld_mmu(CPUState *env, target_ulong addr,
+ *                                     TCGMemOpIdx oi, uintptr_t ra)
+ */
+static void * const qemu_ld_helpers[16] =3D {
+    [MO_UB]   =3D helper_ret_ldub_mmu,
+    [MO_SB]   =3D helper_ret_ldsb_mmu,
+    [MO_LEUW] =3D helper_le_lduw_mmu,
+    [MO_LESW] =3D helper_le_ldsw_mmu,
+    [MO_LEUL] =3D helper_le_ldul_mmu,
+#if TCG_TARGET_REG_BITS =3D=3D 64
+    [MO_LESL] =3D helper_le_ldsl_mmu,
+#endif
+    [MO_LEQ]  =3D helper_le_ldq_mmu,
+    [MO_BEUW] =3D helper_be_lduw_mmu,
+    [MO_BESW] =3D helper_be_ldsw_mmu,
+    [MO_BEUL] =3D helper_be_ldul_mmu,
+#if TCG_TARGET_REG_BITS =3D=3D 64
+    [MO_BESL] =3D helper_be_ldsl_mmu,
+#endif
+    [MO_BEQ]  =3D helper_be_ldq_mmu,
+};
+
+/* helper signature: helper_ret_st_mmu(CPUState *env, target_ulong addr,
+ *                                     uintxx_t val, TCGMemOpIdx oi,
+ *                                     uintptr_t ra)
+ */
+static void * const qemu_st_helpers[16] =3D {
+    [MO_UB]   =3D helper_ret_stb_mmu,
+    [MO_LEUW] =3D helper_le_stw_mmu,
+    [MO_LEUL] =3D helper_le_stl_mmu,
+    [MO_LEQ]  =3D helper_le_stq_mmu,
+    [MO_BEUW] =3D helper_be_stw_mmu,
+    [MO_BEUL] =3D helper_be_stl_mmu,
+    [MO_BEQ]  =3D helper_be_stq_mmu,
+};
+
+static void tcg_out_tlb_load(TCGContext *s, TCGReg addrl,
+                             TCGReg addrh, TCGMemOpIdx oi,
+                             tcg_insn_unit **label_ptr, bool is_load)
+{
+    TCGMemOp opc =3D get_memop(oi);
+    unsigned s_bits =3D opc & MO_SIZE;
+    unsigned a_bits =3D get_alignment_bits(opc);
+    target_ulong mask;
+    int mem_index =3D get_mmuidx(oi);
+    int cmp_off
+        =3D (is_load
+           ? offsetof(CPUArchState, tlb_table[mem_index][0].addr_read)
+           : offsetof(CPUArchState, tlb_table[mem_index][0].addr_write));
+    int add_off =3D offsetof(CPUArchState, tlb_table[mem_index][0].addend)=
;
+    RISCVInsn load_cmp_op =3D (TARGET_LONG_BITS =3D=3D 64 ? OPC_LD :
+                             TCG_TARGET_REG_BITS =3D=3D 64 ? OPC_LWU : OPC=
_LW);
+    RISCVInsn load_add_op =3D TCG_TARGET_REG_BITS =3D=3D 64 ? OPC_LD : OPC=
_LW;
+    TCGReg base =3D TCG_AREG0;
+
+    /* We don't support oversize guests */
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+        g_assert_not_reached();
+    }
+
+    /* We don't support unaligned accesses. */
+    if (a_bits < s_bits) {
+        a_bits =3D s_bits;
+    }
+    mask =3D (target_ulong)TARGET_PAGE_MASK | ((1 << a_bits) - 1);
+
+
+    /* Compensate for very large offsets.  */
+    if (add_off >=3D 0x1000) {
+        int adj;
+        base =3D TCG_REG_TMP2;
+        if (cmp_off <=3D 2 * 0xfff) {
+            adj =3D 0xfff;
+            tcg_out_opc_imm(s, OPC_ADDI, base, TCG_AREG0, adj);
+        } else {
+            adj =3D cmp_off - sextreg(cmp_off, 0, 12);
+            tcg_debug_assert(add_off - adj >=3D -0x1000
+                             && add_off - adj < 0x1000);
+
+            tcg_out_opc_upper(s, OPC_LUI, base, adj);
+            tcg_out_opc_reg(s, OPC_ADD, base, base, TCG_AREG0);
+        }
+        add_off -=3D adj;
+        cmp_off -=3D adj;
+    }
+
+    /* Extract the page index.  */
+    if (CPU_TLB_BITS + CPU_TLB_ENTRY_BITS < 12) {
+        tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP0, addrl,
+                        TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP0, TCG_REG_TMP0,
+                        MAKE_64BIT_MASK(CPU_TLB_ENTRY_BITS, CPU_TLB_BITS))=
;
+    } else if (TARGET_PAGE_BITS >=3D 12) {
+        tcg_out_opc_upper(s, OPC_LUI, TCG_REG_TMP0,
+                          MAKE_64BIT_MASK(TARGET_PAGE_BITS, CPU_TLB_BITS))=
;
+        tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP0, TCG_REG_TMP0, addrl);
+        tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP0, TCG_REG_TMP0,
+                        CPU_TLB_BITS - CPU_TLB_ENTRY_BITS);
+    } else {
+        tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP0, addrl, TARGET_PAGE_BITS=
);
+        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP0, TCG_REG_TMP0,
+                        MAKE_64BIT_MASK(0, CPU_TLB_BITS));
+        tcg_out_opc_imm(s, OPC_SLLI, TCG_REG_TMP0, TCG_REG_TMP0,
+                        CPU_TLB_ENTRY_BITS);
+    }
+
+    /* Add that to the base address to index the tlb.  */
+    tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, base, TCG_REG_TMP0);
+    base =3D TCG_REG_TMP2;
+
+    /* Load the tlb comparator and the addend.  */
+    tcg_out_ldst(s, load_cmp_op, TCG_REG_TMP0, base, cmp_off);
+    tcg_out_ldst(s, load_add_op, TCG_REG_TMP2, base, add_off);
+
+    /* Clear the non-page, non-alignment bits from the address.  */
+    if (mask =3D=3D sextreg(mask, 0, 12)) {
+        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addrl, mask);
+    } else {
+        tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP1, mask);
+        tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP1, TCG_REG_TMP1, addrl);
+     }
+
+    /* Compare masked address with the TLB entry. */
+    label_ptr[0] =3D s->code_ptr;
+    tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
+    /* TODO: Move this out of line
+     * see:
+     *   https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02234=
.html
+     */
+
+    /* TLB Hit - translate address using addend.  */
+    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+        tcg_out_ext32u(s, TCG_REG_TMP0, addrl);
+        addrl =3D TCG_REG_TMP0;
+    }
+    tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP2, addrl);
+}
+
+static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
+                                TCGType ext,
+                                TCGReg datalo, TCGReg datahi,
+                                TCGReg addrlo, TCGReg addrhi,
+                                void *raddr, tcg_insn_unit **label_ptr)
+{
+    TCGLabelQemuLdst *label =3D new_ldst_label(s);
+
+    label->is_ld =3D is_ld;
+    label->oi =3D oi;
+    label->type =3D ext;
+    label->datalo_reg =3D datalo;
+    label->datahi_reg =3D datahi;
+    label->addrlo_reg =3D addrlo;
+    label->addrhi_reg =3D addrhi;
+    label->raddr =3D raddr;
+    label->label_ptr[0] =3D label_ptr[0];
+}
+
+static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    TCGMemOpIdx oi =3D l->oi;
+    TCGMemOp opc =3D get_memop(oi);
+    TCGReg a0 =3D tcg_target_call_iarg_regs[0];
+    TCGReg a1 =3D tcg_target_call_iarg_regs[1];
+    TCGReg a2 =3D tcg_target_call_iarg_regs[2];
+    TCGReg a3 =3D tcg_target_call_iarg_regs[3];
+
+    /* We don't support oversize guests */
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+        g_assert_not_reached();
+    }
+
+    /* resolve label address */
+    reloc_sbimm12(l->label_ptr[0], s->code_ptr);
+
+    /* call load helper */
+    tcg_out_mov(s, TCG_TYPE_PTR, a0, TCG_AREG0);
+    tcg_out_mov(s, TCG_TYPE_PTR, a1, l->addrlo_reg);
+    tcg_out_movi(s, TCG_TYPE_PTR, a2, oi);
+    tcg_out_movi(s, TCG_TYPE_PTR, a3, (tcg_target_long)l->raddr);
+
+    tcg_out_call(s, qemu_ld_helpers[opc & (MO_BSWAP | MO_SSIZE)]);
+    tcg_out_mov(s, (opc & MO_SIZE) =3D=3D MO_64, l->datalo_reg, a0);
+
+    tcg_out_goto(s, l->raddr);
+}
+
+static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    TCGMemOpIdx oi =3D l->oi;
+    TCGMemOp opc =3D get_memop(oi);
+    TCGMemOp s_bits =3D opc & MO_SIZE;
+    TCGReg a0 =3D tcg_target_call_iarg_regs[0];
+    TCGReg a1 =3D tcg_target_call_iarg_regs[1];
+    TCGReg a2 =3D tcg_target_call_iarg_regs[2];
+    TCGReg a3 =3D tcg_target_call_iarg_regs[3];
+    TCGReg a4 =3D tcg_target_call_iarg_regs[4];
+
+    /* We don't support oversize guests */
+    if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
+        g_assert_not_reached();
+    }
+
+    /* resolve label address */
+    reloc_sbimm12(l->label_ptr[0], s->code_ptr);
+
+    /* call store helper */
+    tcg_out_mov(s, TCG_TYPE_PTR, a0, TCG_AREG0);
+    tcg_out_mov(s, TCG_TYPE_PTR, a1, l->addrlo_reg);
+    tcg_out_mov(s, TCG_TYPE_PTR, a2, l->datalo_reg);
+    switch (s_bits) {
+    case MO_8:
+        tcg_out_ext8u(s, a2, a2);
+        break;
+    case MO_16:
+        tcg_out_ext16u(s, a2, a2);
+        break;
+    default:
+        break;
+    }
+    tcg_out_movi(s, TCG_TYPE_PTR, a3, oi);
+    tcg_out_movi(s, TCG_TYPE_PTR, a4, (tcg_target_long)l->raddr);
+
+    tcg_out_call(s, qemu_st_helpers[opc & (MO_BSWAP | MO_SSIZE)]);
+
+    tcg_out_goto(s, l->raddr);
+}
+#endif /* CONFIG_SOFTMMU */
--=20
2.19.1
