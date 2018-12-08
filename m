Received: from eggs.gnu.org ([2001:4830:134:3::10]:40336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQns-0003L2-RK
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8739c4fd6=Alistair.Francis@wdc.com>)
	id 1gVQnp-0001F8-Ib
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 19:49:08 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Sat, 8 Dec 2018 00:49:01 +0000
Message-ID: <1f6b3d26810eb969cf90f0ee978fe2817e6e6421.1544229872.git.alistair.francis@wdc.com>
References: <cover.1544229872.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544229872.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC v3 18/24] riscv: tcg-target: Add direct load and
 store instructions
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
---
 tcg/riscv/tcg-target.inc.c | 158 +++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/tcg/riscv/tcg-target.inc.c b/tcg/riscv/tcg-target.inc.c
index 9d07d5ecde..280ba699c9 100644
--- a/tcg/riscv/tcg-target.inc.c
+++ b/tcg/riscv/tcg-target.inc.c
@@ -1132,3 +1132,161 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s=
, TCGLabelQemuLdst *l)
     tcg_out_goto(s, l->raddr);
 }
 #endif /* CONFIG_SOFTMMU */
+
+static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
+                                   TCGReg base, TCGMemOp opc, bool is_64)
+{
+    const TCGMemOp bswap =3D opc & MO_BSWAP;
+
+    /* We don't yet handle byteswapping, assert */
+    g_assert(!bswap);
+
+    switch (opc & (MO_SSIZE)) {
+    case MO_UB:
+        tcg_out_opc_imm(s, OPC_LBU, lo, base, 0);
+        break;
+    case MO_SB:
+        tcg_out_opc_imm(s, OPC_LB, lo, base, 0);
+        break;
+    case MO_UW:
+        tcg_out_opc_imm(s, OPC_LHU, lo, base, 0);
+        break;
+    case MO_SW:
+        tcg_out_opc_imm(s, OPC_LH, lo, base, 0);
+        break;
+    case MO_UL:
+        if (TCG_TARGET_REG_BITS =3D=3D 64 && is_64) {
+            tcg_out_opc_imm(s, OPC_LWU, lo, base, 0);
+            break;
+        }
+        /* FALLTHRU */
+    case MO_SL:
+        tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
+        break;
+    case MO_Q:
+        /* Prefer to load from offset 0 first, but allow for overlap.  */
+        if (TCG_TARGET_REG_BITS =3D=3D 64) {
+            tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
+        } else if (lo !=3D base) {
+            tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
+            tcg_out_opc_imm(s, OPC_LW, hi, base, 4);
+        } else {
+            tcg_out_opc_imm(s, OPC_LW, hi, base, 4);
+            tcg_out_opc_imm(s, OPC_LW, lo, base, 0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_qemu_ld(TCGContext *s, const TCGArg *args, bool is_64)
+{
+    TCGReg addr_regl, addr_regh __attribute__((unused));
+    TCGReg data_regl, data_regh;
+    TCGMemOpIdx oi;
+    TCGMemOp opc;
+#if defined(CONFIG_SOFTMMU)
+    tcg_insn_unit *label_ptr[1];
+#endif
+    TCGReg base =3D TCG_REG_TMP0;
+
+    data_regl =3D *args++;
+    data_regh =3D (TCG_TARGET_REG_BITS =3D=3D 32 && is_64 ? *args++ : 0);
+    addr_regl =3D *args++;
+    addr_regh =3D (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
+    oi =3D *args++;
+    opc =3D get_memop(oi);
+
+#if defined(CONFIG_SOFTMMU)
+    tcg_out_tlb_load(s, addr_regl, addr_regh, oi, label_ptr, 1);
+    tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc, is_64);
+    add_qemu_ldst_label(s, 1, oi,
+                        (is_64 ? TCG_TYPE_I64 : TCG_TYPE_I32),
+                        data_regl, data_regh, addr_regl, addr_regh,
+                        s->code_ptr, label_ptr);
+#else
+    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+        tcg_out_ext32u(s, base, addr_regl);
+        addr_regl =3D base;
+    }
+
+    if (guest_base =3D=3D 0) {
+        tcg_out_opc_reg(s, OPC_ADD, base, addr_regl, TCG_REG_ZERO);
+    } else {
+        tcg_out_opc_reg(s, OPC_ADD, base, TCG_GUEST_BASE_REG, addr_regl);
+    }
+    tcg_out_qemu_ld_direct(s, data_regl, data_regh, base, opc, is_64);
+#endif
+}
+
+static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
+                                   TCGReg base, TCGMemOp opc)
+{
+    const TCGMemOp bswap =3D opc & MO_BSWAP;
+
+    /* We don't yet handle byteswapping, assert */
+    g_assert(!bswap);
+
+    switch (opc & (MO_SSIZE)) {
+    case MO_8:
+        tcg_out_opc_store(s, OPC_SB, base, lo, 0);
+        break;
+    case MO_16:
+        tcg_out_opc_store(s, OPC_SH, base, lo, 0);
+        break;
+    case MO_32:
+        tcg_out_opc_store(s, OPC_SW, base, lo, 0);
+        break;
+    case MO_64:
+        if (TCG_TARGET_REG_BITS =3D=3D 64) {
+            tcg_out_opc_store(s, OPC_SD, base, lo, 0);
+        } else {
+            tcg_out_opc_store(s, OPC_SW, base, lo, 0);
+            tcg_out_opc_store(s, OPC_SW, base, hi, 4);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
+{
+    TCGReg addr_regl, addr_regh __attribute__((unused));
+    TCGReg data_regl, data_regh;
+    TCGMemOpIdx oi;
+    TCGMemOp opc;
+#if defined(CONFIG_SOFTMMU)
+    tcg_insn_unit *label_ptr[1];
+#endif
+    TCGReg base =3D TCG_REG_TMP0;
+
+    data_regl =3D *args++;
+    data_regh =3D (TCG_TARGET_REG_BITS =3D=3D 32 && is_64 ? *args++ : 0);
+    addr_regl =3D *args++;
+    addr_regh =3D (TCG_TARGET_REG_BITS < TARGET_LONG_BITS ? *args++ : 0);
+    oi =3D *args++;
+    opc =3D get_memop(oi);
+
+#if defined(CONFIG_SOFTMMU)
+    tcg_out_tlb_load(s, addr_regl, addr_regh, oi, label_ptr, 0);
+    tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
+    add_qemu_ldst_label(s, 0, oi,
+                        (is_64 ? TCG_TYPE_I64 : TCG_TYPE_I32),
+                        data_regl, data_regh, addr_regl, addr_regh,
+                        s->code_ptr, label_ptr);
+#else
+    if (TCG_TARGET_REG_BITS > TARGET_LONG_BITS) {
+        tcg_out_ext32u(s, base, addr_regl);
+        addr_regl =3D base;
+    }
+
+    if (guest_base =3D=3D 0) {
+        tcg_out_opc_reg(s, OPC_ADD, base, addr_regl, TCG_REG_ZERO);
+    } else {
+        tcg_out_opc_reg(s, OPC_ADD, base, TCG_GUEST_BASE_REG, addr_regl);
+    }
+    tcg_out_qemu_st_direct(s, data_regl, data_regh, base, opc);
+#endif
+}
--=20
2.19.1
