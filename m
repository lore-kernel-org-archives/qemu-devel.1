Received: from eggs.gnu.org ([209.51.188.92]:40273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzgl4-0003aR-QV
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzgl4-0006oY-4T
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 06:55:18 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  1 Mar 2019 12:54:03 +0100
Message-Id: <20190301115413.27153-23-david@redhat.com>
In-Reply-To: <20190301115413.27153-1-david@redhat.com>
References: <20190301115413.27153-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 22/32] s390x/tcg: Implement VECTOR REPLICATE
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

Load the element and replicate it using gvec_dup.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 7314ae4704..14e010765d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1023,6 +1023,8 @@
     F(0xe78c, VPERM,   VRR_e, V,   0, 0, 0, 0, vperm, 0, IF_VEC)
 /* VECTOR PERMUTE DOUBLEWORD IMMEDIATE */
     F(0xe784, VPDI,    VRR_c, V,   0, 0, 0, 0, vpdi, 0, IF_VEC)
+/* VECTOR REPLICATE */
+    F(0xe74d, VREP,    VRI_c, V,   0, 0, 0, 0, vrep, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 8afde8fe2c..63bb37d0a1 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -685,3 +685,21 @@ static DisasJumpType op_vpdi(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(t1);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vrep(DisasContext *s, DisasOps *o)
+{
+    const uint8_t enr = get_field(s->fields, i2);
+    const uint8_t es = get_field(s->fields, m4);
+    TCGv_i64 tmp;
+
+    if (es > ES_64 || !valid_vec_element(enr, es)) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tmp = tcg_temp_new_i64();
+    read_vec_element_i64(tmp, get_field(s->fields, v3), enr, es);
+    gen_gvec_dup_i64(es, get_field(s->fields, v1), tmp);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
