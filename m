Received: from eggs.gnu.org ([209.51.188.92]:40044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzgkg-00039X-7f
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:54:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzgkf-0006ZB-4x
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:54:54 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  1 Mar 2019 12:53:55 +0100
Message-Id: <20190301115413.27153-15-david@redhat.com>
In-Reply-To: <20190301115413.27153-1-david@redhat.com>
References: <20190301115413.27153-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/32] s390x/tcg: Implement VECTOR LOAD TO
 BLOCK BOUNDARY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

Very similar to LOAD COUNT TO BLOCK BOUNDARY, but instead of only
calculating, the actual vector is loaded. Use a temporary vector to
not modify the real vector on exceptions. Initialize that one to zero,
to not leak any data. Provide a fast path if we're loading a full
vector.

As we don't have gvec ool handlers for single vectors, just calculate
the vector address manually.

We can reuse the helper later on for VECTOR LOAD WITH LENGTH. In fact,
we are going to name it "vll" right from the beginning, because that's
a better match.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  3 +++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 25 +++++++++++++++++++++++++
 target/s390x/vec_helper.c       | 29 +++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index bb659257f6..6c745ba0f6 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -124,6 +124,9 @@ DEF_HELPER_5(msa, i32, env, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_1(stpt, TCG_CALL_NO_RWG, i64, env)
 DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
 
+/* === Vector Support Instructions === */
+DEF_HELPER_FLAGS_4(vll, TCG_CALL_NO_WG, void, env, ptr, i64, i64)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
 DEF_HELPER_4(diag, void, env, i32, i32, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index fa0f3a9003..ad8df5283c 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1002,6 +1002,8 @@
     F(0xe704, VLLEZ,   VRX,   V,   la2, 0, 0, 0, vllez, 0, IF_VEC)
 /* VECTOR LOAD MULTIPLE */
     F(0xe736, VLM,     VRS_a, V,   la2, 0, 0, 0, vlm, 0, IF_VEC)
+/* VECTOR LOAD TO BLOCK BOUNDARY */
+    F(0xe707, VLBB,    VRX,   V,   la2, 0, 0, 0, vlbb, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 93f9c0f804..f9d0ecf29d 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -440,3 +440,28 @@ static DisasJumpType op_vlm(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(t);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlbb(DisasContext *s, DisasOps *o)
+{
+    const int64_t block_size = (1ull << (get_field(s->fields, m3) + 6));
+    const int v1_offs = vec_full_reg_offset(get_field(s->fields, v1));
+    TCGv_ptr a0;
+    TCGv_i64 bytes;
+
+    if (get_field(s->fields, m3) > 6) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    bytes = tcg_temp_new_i64();
+    a0 = tcg_temp_new_ptr();
+    /* calculate the number of bytes until the next block boundary */
+    tcg_gen_ori_i64(bytes, o->addr1, -block_size);
+    tcg_gen_neg_i64(bytes, bytes);
+
+    tcg_gen_addi_ptr(a0, cpu_env, v1_offs);
+    gen_helper_vll(cpu_env, a0, o->addr1, bytes);
+    tcg_temp_free_i64(bytes);
+    tcg_temp_free_ptr(a0);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_helper.c b/target/s390x/vec_helper.c
index 3e21e440ba..b76c4e3284 100644
--- a/target/s390x/vec_helper.c
+++ b/target/s390x/vec_helper.c
@@ -11,8 +11,13 @@
  */
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "cpu.h"
+#include "internal.h"
 #include "vec.h"
 #include "tcg/tcg.h"
+#include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
+#include "exec/exec-all.h"
 
 /*
  * Each vector is stored as two 64bit host values. So when talking about
@@ -88,3 +93,27 @@ void s390_vec_write_element64(S390Vector *v, uint8_t enr, uint64_t data)
     g_assert(enr < 2);
     v->doubleword[enr] = data;
 }
+
+void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
+{
+    if (likely(bytes >= 16)) {
+        uint64_t t0, t1;
+
+        t0 = cpu_ldq_data_ra(env, addr, GETPC());
+        addr = wrap_address(env, addr + 8);
+        t1 = cpu_ldq_data_ra(env, addr, GETPC());
+        s390_vec_write_element64(v1, 0, t0);
+        s390_vec_write_element64(v1, 1, t1);
+    } else {
+        S390Vector tmp = {};
+        int i;
+
+        for (i = 0; i < bytes; i++) {
+            uint8_t byte = cpu_ldub_data_ra(env, addr, GETPC());
+
+            s390_vec_write_element8(&tmp, i, byte);
+            addr = wrap_address(env, addr + 1);
+        }
+        *(S390Vector *)v1 = tmp;
+    }
+}
-- 
2.17.2
