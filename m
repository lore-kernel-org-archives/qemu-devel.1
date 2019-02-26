Received: from eggs.gnu.org ([209.51.188.92]:48041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6I-0005UD-W4
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb6G-0007XZ-HI
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:39:14 +0100
Message-Id: <20190226113915.20150-33-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 32/33] s390x/tcg: Implement VECTOR STORE
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 13 +++++++++++++
 target/s390x/vec_helper.c       | 15 +++++++++++++++
 4 files changed, 31 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 969b124f6a..df449f4c53 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -133,6 +133,7 @@ DEF_HELPER_5(gvec_vpkls16, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vpkls32, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vpkls64, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vperm, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, cptr, i32)
+DEF_HELPER_FLAGS_4(vstl, TCG_CALL_NO_WG, void, env, cptr, i64, i64)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 60e4895f60..5d4d2ecc7e 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1044,6 +1044,8 @@
     E(0xe70a, VSTEG,   VRX,   V,   la2, 0, 0, 0, vste, 0, MO_64, IF_VEC)
 /* VECTOR STORE MULTIPLE */
     F(0xe73e, VSTM,    VRS_a, V,   la2, 0, 0, 0, vstm, 0, IF_VEC)
+/* VECTOR STORE WITH LENGTH */
+    F(0xe73f, VSTL,    VRS_b, V,   la2, r3_32u, 0, 0, vstl, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 7e7c96c974..d87f5bafcf 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -829,3 +829,16 @@ static DisasJumpType op_vstm(DisasContext *s, DisasOps *o)
     }
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
index bf8a91cdfa..eddc925101 100644
--- a/target/s390x/vec_helper.c
+++ b/target/s390x/vec_helper.c
@@ -203,3 +203,18 @@ void HELPER(gvec_vperm)(void *v1, const void *v2, const void *v3,
     }
     *(S390Vector *)v1 = tmp;
 }
+
+void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
+                  uint64_t bytes)
+{
+    int i;
+
+    /* FIXME: On exceptions we must not modify any memory. */
+    bytes = MIN(bytes, 16);
+    for (i = 0; i < bytes; i++) {
+        const uint8_t byte = s390_vec_read_element8(v1, i);
+
+        cpu_stb_data_ra(env, addr, byte, GETPC());
+        addr = wrap_address(env, addr + 1);
+    }
+}
-- 
2.17.2
