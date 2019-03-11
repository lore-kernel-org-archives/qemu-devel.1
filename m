Received: from eggs.gnu.org ([209.51.188.92]:43040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gqg-0002yP-T7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gqf-0005MA-Ge
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:03:54 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:02:54 +0100
Message-Id: <20190311090322.21603-6-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 05/33] s390x/tcg: Implement VECTOR GATHER ELEMENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's start with a more involved one, but it is the first in the list
of vector support instructions (introduced with the vector facility).

Good thing is, we need a lot of basic infrastructure for this. Reading
and writing vector elements as well as checking element validity.

All vector instruction related translation functions will reside in
translate_vx.inc.c, to be included in translate.c - similar to how
other architectures handle it.

While at it, directly add some documentation (which contains parts about
things added in follow-up patches, but splitting this up does not make
too much sense). Also add ES_* defines heavily used later.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-5-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |   6 ++
 target/s390x/translate.c        |   2 +
 target/s390x/translate_vx.inc.c | 135 ++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 target/s390x/translate_vx.inc.c

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 61b750a855e9..7d128ac9d61d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -972,6 +972,12 @@
     D(0xb93e, KIMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KIMD)
     D(0xb93f, KLMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, S390_FEAT_TYPE_KLMD)
 
+/* === Vector Support Instructions === */
+
+/* VECTOR GATHER ELEMENT */
+    E(0xe713, VGEF,    VRV,   V,   la2, 0, 0, 0, vge, 0, ES_32, IF_VEC)
+    E(0xe712, VGEG,    VRV,   V,   la2, 0, 0, 0, vge, 0, ES_64, IF_VEC)
+
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
     E(0xb250, CSP,     RRE,   Z,   r1_32u, ra2, r1_P, 0, csp, 0, MO_TEUL, IF_PRIV)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d52c02c572bb..a1c6698dea9c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5120,6 +5120,8 @@ static DisasJumpType op_mpcifc(DisasContext *s, DisasOps *o)
 }
 #endif
 
+#include "translate_vx.inc.c"
+
 /* ====================================================================== */
 /* The "Cc OUTput" generators.  Given the generated output (and in some cases
    the original inputs), update the various cc data structures in order to
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
new file mode 100644
index 000000000000..9864ec5134de
--- /dev/null
+++ b/target/s390x/translate_vx.inc.c
@@ -0,0 +1,135 @@
+/*
+ * QEMU TCG support -- s390x vector instruction translation functions
+ *
+ * Copyright (C) 2019 Red Hat Inc
+ *
+ * Authors:
+ *   David Hildenbrand <david@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * For most instructions that use the same element size for reads and
+ * writes, we can use real gvec vector expansion, which potantially uses
+ * real host vector instructions. As they only work up to 64 bit elements,
+ * 128 bit elements (vector is a single element) have to be handled
+ * differently. Operations that are too complicated to encode via TCG ops
+ * are handled via gvec ool (out-of-line) handlers.
+ *
+ * As soon as instructions use different element sizes for reads and writes
+ * or access elements "out of their element scope" we expand them manually
+ * in fancy loops, as gvec expansion does not deal with actual element
+ * numbers and does also not support access to other elements.
+ *
+ * 128 bit elements:
+ *  As we only have i32/i64, such elements have to be loaded into two
+ *  i64 values and can then be processed e.g. by tcg_gen_add2_i64.
+ *
+ * Sizes:
+ *  On s390x, the operand size (oprsz) and the maximum size (maxsz) are
+ *  always 16 (128 bit). What gvec code calls "vece", s390x calls "es",
+ *  a.k.a. "element size". These values nicely map to MO_8 ... MO_64. Only
+ *  128 bit element size has to be treated in a special way (MO_64 + 1).
+ *  We will use ES_* instead of MO_* for this reason in this file.
+ *
+ * CC handling:
+ *  As gvec ool-helpers can currently not return values (besides via
+ *  pointers like vectors or cpu_env), whenever we have to set the CC and
+ *  can't conclude the value from the result vector, we will directly
+ *  set it in "env->cc_op" and mark it as static via set_cc_static()".
+ *  Whenever this is done, the helper writes globals (cc_op).
+ */
+
+#define NUM_VEC_ELEMENT_BYTES(es) (1 << (es))
+#define NUM_VEC_ELEMENTS(es) (16 / NUM_VEC_ELEMENT_BYTES(es))
+
+#define ES_8    MO_8
+#define ES_16   MO_16
+#define ES_32   MO_32
+#define ES_64   MO_64
+#define ES_128  4
+
+static inline bool valid_vec_element(uint8_t enr, TCGMemOp es)
+{
+    return !(enr & ~(NUM_VEC_ELEMENTS(es) - 1));
+}
+
+static void read_vec_element_i64(TCGv_i64 dst, uint8_t reg, uint8_t enr,
+                                 TCGMemOp memop)
+{
+    const int offs = vec_reg_offset(reg, enr, memop & MO_SIZE);
+
+    switch (memop) {
+    case ES_8:
+        tcg_gen_ld8u_i64(dst, cpu_env, offs);
+        break;
+    case ES_16:
+        tcg_gen_ld16u_i64(dst, cpu_env, offs);
+        break;
+    case ES_32:
+        tcg_gen_ld32u_i64(dst, cpu_env, offs);
+        break;
+    case ES_8 | MO_SIGN:
+        tcg_gen_ld8s_i64(dst, cpu_env, offs);
+        break;
+    case ES_16 | MO_SIGN:
+        tcg_gen_ld16s_i64(dst, cpu_env, offs);
+        break;
+    case ES_32 | MO_SIGN:
+        tcg_gen_ld32s_i64(dst, cpu_env, offs);
+        break;
+    case ES_64:
+    case ES_64 | MO_SIGN:
+        tcg_gen_ld_i64(dst, cpu_env, offs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,
+                                  TCGMemOp memop)
+{
+    const int offs = vec_reg_offset(reg, enr, memop & MO_SIZE);
+
+    switch (memop) {
+    case ES_8:
+        tcg_gen_st8_i64(src, cpu_env, offs);
+        break;
+    case ES_16:
+        tcg_gen_st16_i64(src, cpu_env, offs);
+        break;
+    case ES_32:
+        tcg_gen_st32_i64(src, cpu_env, offs);
+        break;
+    case ES_64:
+        tcg_gen_st_i64(src, cpu_env, offs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static DisasJumpType op_vge(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = s->insn->data;
+    const uint8_t enr = get_field(s->fields, m3);
+    TCGv_i64 tmp;
+
+    if (!valid_vec_element(enr, es)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tmp = tcg_temp_new_i64();
+    read_vec_element_i64(tmp, get_field(s->fields, v2), enr, es);
+    tcg_gen_add_i64(o->addr1, o->addr1, tmp);
+    gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 0);
+
+    tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    write_vec_element_i64(tmp, get_field(s->fields, v1), enr, es);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
