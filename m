Received: from eggs.gnu.org ([2001:4830:134:3::10]:45350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhLT-00015p-54
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=884a3e257=Alistair.Francis@wdc.com>)
	id 1gZhLO-0008UY-1Z
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:17:26 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Wed, 19 Dec 2018 19:17:07 +0000
Message-ID: <a135ee1a88cd7bd08993a519d4d654da27785254.1545246859.git.alistair.francis@wdc.com>
References: <cover.1545246859.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1545246859.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 05/23] riscv: Add the tcg-target header file
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
 MAINTAINERS            |  10 ++-
 tcg/riscv/tcg-target.h | 177 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 tcg/riscv/tcg-target.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b923f4c1b3..107bca486b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -268,7 +268,6 @@ F: hw/riscv/
 F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
-F: disas/riscv.c
=20
 S390
 M: Richard Henderson <rth@twiddle.net>
@@ -2166,6 +2165,15 @@ S: Odd Fixes
 F: tcg/ppc/
 F: disas/ppc.c
=20
+RISC-V
+M: Michael Clark <mjc@sifive.com>
+M: Palmer Dabbelt <palmer@sifive.com>
+M: Alistair Francis <Alistair.Francis@wdc.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: tcg/riscv/
+F: disas/riscv.c
+
 S390 target
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
new file mode 100644
index 0000000000..60918cacb4
--- /dev/null
+++ b/tcg/riscv/tcg-target.h
@@ -0,0 +1,177 @@
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2018 SiFive, Inc
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#ifndef RISCV_TCG_TARGET_H
+#define RISCV_TCG_TARGET_H
+
+#if __riscv_xlen =3D=3D 32
+# define TCG_TARGET_REG_BITS 32
+#elif __riscv_xlen =3D=3D 64
+# define TCG_TARGET_REG_BITS 64
+#endif
+
+#define TCG_TARGET_INSN_UNIT_SIZE 4
+#define TCG_TARGET_TLB_DISPLACEMENT_BITS 20
+#define TCG_TARGET_NB_REGS 32
+
+typedef enum {
+    TCG_REG_ZERO,
+    TCG_REG_RA,
+    TCG_REG_SP,
+    TCG_REG_GP,
+    TCG_REG_TP,
+    TCG_REG_T0,
+    TCG_REG_T1,
+    TCG_REG_T2,
+    TCG_REG_S0,
+    TCG_REG_S1,
+    TCG_REG_A0,
+    TCG_REG_A1,
+    TCG_REG_A2,
+    TCG_REG_A3,
+    TCG_REG_A4,
+    TCG_REG_A5,
+    TCG_REG_A6,
+    TCG_REG_A7,
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
+    TCG_REG_T3,
+    TCG_REG_T4,
+    TCG_REG_T5,
+    TCG_REG_T6,
+
+    /* aliases */
+    TCG_AREG0          =3D TCG_REG_S0,
+    TCG_GUEST_BASE_REG =3D TCG_REG_S1,
+    TCG_REG_TMP0       =3D TCG_REG_T6,
+    TCG_REG_TMP1       =3D TCG_REG_T5,
+    TCG_REG_TMP2       =3D TCG_REG_T4,
+} TCGReg;
+
+/* used for function call generation */
+#define TCG_REG_CALL_STACK              TCG_REG_SP
+#define TCG_TARGET_STACK_ALIGN          16
+#define TCG_TARGET_CALL_ALIGN_ARGS      1
+#define TCG_TARGET_CALL_STACK_OFFSET    0
+
+/* optional instructions */
+#define TCG_TARGET_HAS_goto_ptr         1
+#define TCG_TARGET_HAS_movcond_i32      0
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          1
+#define TCG_TARGET_HAS_div2_i32         0
+#define TCG_TARGET_HAS_rot_i32          0
+#define TCG_TARGET_HAS_deposit_i32      0
+#define TCG_TARGET_HAS_extract_i32      0
+#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_mulu2_i32        0
+#define TCG_TARGET_HAS_muls2_i32        0
+#define TCG_TARGET_HAS_muluh_i32        (TCG_TARGET_REG_BITS =3D=3D 32)
+#define TCG_TARGET_HAS_mulsh_i32        (TCG_TARGET_REG_BITS =3D=3D 32)
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        1
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_bswap16_i32      0
+#define TCG_TARGET_HAS_bswap32_i32      0
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_neg_i32          1
+#define TCG_TARGET_HAS_andc_i32         0
+#define TCG_TARGET_HAS_orc_i32          0
+#define TCG_TARGET_HAS_eqv_i32          0
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_nor_i32          0
+#define TCG_TARGET_HAS_clz_i32          0
+#define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_direct_jump      0
+#define TCG_TARGET_HAS_brcond2          1
+#define TCG_TARGET_HAS_setcond2         1
+
+#if TCG_TARGET_REG_BITS =3D=3D 64
+#define TCG_TARGET_HAS_movcond_i64      0
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
+#define TCG_TARGET_HAS_div2_i64         0
+#define TCG_TARGET_HAS_rot_i64          0
+#define TCG_TARGET_HAS_deposit_i64      0
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extrl_i64_i32    1
+#define TCG_TARGET_HAS_extrh_i64_i32    1
+#define TCG_TARGET_HAS_ext8s_i64        1
+#define TCG_TARGET_HAS_ext16s_i64       1
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext8u_i64        1
+#define TCG_TARGET_HAS_ext16u_i64       1
+#define TCG_TARGET_HAS_ext32u_i64       1
+#define TCG_TARGET_HAS_bswap16_i64      0
+#define TCG_TARGET_HAS_bswap32_i64      0
+#define TCG_TARGET_HAS_bswap64_i64      0
+#define TCG_TARGET_HAS_not_i64          1
+#define TCG_TARGET_HAS_neg_i64          1
+#define TCG_TARGET_HAS_andc_i64         0
+#define TCG_TARGET_HAS_orc_i64          0
+#define TCG_TARGET_HAS_eqv_i64          0
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_nor_i64          0
+#define TCG_TARGET_HAS_clz_i64          0
+#define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_ctpop_i64        0
+#define TCG_TARGET_HAS_add2_i64         1
+#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        1
+#define TCG_TARGET_HAS_mulsh_i64        1
+#endif
+
+static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
+{
+    __builtin___clear_cache((char *)start, (char *)stop);
+}
+
+/* not defined -- call should be eliminated at compile time */
+void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
+
+#define TCG_TARGET_DEFAULT_MO (0)
+
+#ifdef CONFIG_SOFTMMU
+#define TCG_TARGET_NEED_LDST_LABELS
+#endif
+#define TCG_TARGET_NEED_POOL_LABELS
+
+#define TCG_TARGET_HAS_MEMORY_BSWAP 0
+
+#endif
--=20
2.19.1
