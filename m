Received: from eggs.gnu.org ([209.51.188.92]:40516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzglU-00045y-32
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzglT-00074R-6g
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:55:44 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  1 Mar 2019 12:54:12 +0100
Message-Id: <20190301115413.27153-32-david@redhat.com>
In-Reply-To: <20190301115413.27153-1-david@redhat.com>
References: <20190301115413.27153-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 31/32] s390x/tcg: Implement VECTOR STORE
 WITH LENGTH
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

Very similar to VECTOR LOAD WITH LENGTH, just the opposite direction.
Properly probe write access before modifying memory.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 13 +++++++++++++
 target/s390x/vec_helper.c       | 24 ++++++++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index e2710f4fb3..0b494a2fd2 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -143,6 +143,7 @@ DEF_HELPER_5(gvec_vpkls_cc16, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vpkls_cc32, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vpkls_cc64, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vperm, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, cptr, i32)
+DEF_HELPER_FLAGS_4(vstl, TCG_CALL_NO_WG, void, env, cptr, i64, i64)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 17fd9a898b..00ba9444a3 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1043,6 +1043,8 @@
     E(0xe70a, VSTEG,   VRX,   V,   la2, 0, 0, 0, vste, 0, ES_64, IF_VEC)
 /* VECTOR STORE MULTIPLE */
     F(0xe73e, VSTM,    VRS_a, V,   la2, 0, 0, 0, vstm, 0, IF_VEC)
+/* VECTOR STORE WITH LENGTH */
+    F(0xe73f, VSTL,    VRS_b, V,   la2, r3_32u, 0, 0, vstl, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index cd69877270..2e7e5391c5 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -878,3 +878,16 @@ static DisasJumpType op_vstm(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vstl(DisasContext *s, DisasOps *o)
+{
+    const int v1_offs = vec_full_reg_offset(get_field(s->fields, v1));
+    TCGv_ptr a0 = tcg_temp_new_ptr();
+
+    /* convert highest index into an actual length */
+    tcg_gen_addi_i64(o->in2, o->in2, 1);
+    tcg_gen_addi_ptr(a0, cpu_env, v1_offs);
+    gen_helper_vstl(cpu_env, a0, o->addr1, o->in2);
+    tcg_temp_free_ptr(a0);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_helper.c b/target/s390x/vec_helper.c
index ea4f8af7ef..34867afc77 100644
--- a/target/s390x/vec_helper.c
+++ b/target/s390x/vec_helper.c
@@ -242,3 +242,27 @@ void HELPER(gvec_vperm)(void *v1, const void *v2, const void *v3,
     }
     *(S390Vector *)v1 = tmp;
 }
+
+void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
+                  uint64_t bytes)
+{
+    /* Probe write access before actually modifying memory */
+    probe_write_access(env, addr, bytes, GETPC());
+
+    if (likely(bytes >= 16)) {
+        cpu_stq_data_ra(env, addr, s390_vec_read_element64(v1, 0), GETPC());
+        addr = wrap_address(env, addr + 8);
+        cpu_stq_data_ra(env, addr, s390_vec_read_element64(v1, 1), GETPC());
+    } else {
+        S390Vector tmp = {};
+        int i;
+
+        for (i = 0; i < bytes; i++) {
+            uint8_t byte = s390_vec_read_element8(v1, i);
+
+            cpu_stb_data_ra(env, addr, byte, GETPC());
+            addr = wrap_address(env, addr + 1);
+        }
+        *(S390Vector *)v1 = tmp;
+    }
+}
-- 
2.17.2
