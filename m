Received: from eggs.gnu.org ([209.51.188.92]:43512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gre-0003qf-Vs
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Grd-0006CK-Vz
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:54 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:07 +0100
Message-Id: <20190311090322.21603-19-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 18/33] s390x/tcg: Implement VECTOR LOAD WITH
 LENGTH
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

We can reuse the helper introduced along with VECTOR LOAD TO BLOCK
BOUNDARY. We just have to take care of converting the highest index into
a length.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-18-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate.c        |  7 +++++++
 target/s390x/translate_vx.inc.c | 13 +++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index bdd66758fa62..3c0b14bafd88 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1008,6 +1008,8 @@
     F(0xe722, VLVG,    VRS_b, V,   la2, r3, 0, 0, vlvg, 0, IF_VEC)
 /* VECTOR LOAD VR FROM GRS DISJOINT */
     F(0xe762, VLVGP,   VRR_f, V,   r2, r3, 0, 0, vlvgp, 0, IF_VEC)
+/* VECTOR LOAD WITH LENGTH */
+    F(0xe737, VLL,     VRS_b, V,   la2, r3_32u, 0, 0, vll, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 588fc21dd2a7..0afa8f7ca534 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5794,6 +5794,13 @@ static void in2_r3_sr32(DisasContext *s, DisasFields *f, DisasOps *o)
 }
 #define SPEC_in2_r3_sr32 0
 
+static void in2_r3_32u(DisasContext *s, DisasFields *f, DisasOps *o)
+{
+    o->in2 = tcg_temp_new_i64();
+    tcg_gen_ext32u_i64(o->in2, regs[get_field(f, r3)]);
+}
+#define SPEC_in2_r3_32u 0
+
 static void in2_r2_32s(DisasContext *s, DisasFields *f, DisasOps *o)
 {
     o->in2 = tcg_temp_new_i64();
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index abd33a9e3d96..b8e69856cdf3 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -519,3 +519,16 @@ static DisasJumpType op_vlvgp(DisasContext *s, DisasOps *o)
     write_vec_element_i64(o->in2, get_field(s->fields, v1), 1, ES_64);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vll(DisasContext *s, DisasOps *o)
+{
+    const int v1_offs = vec_full_reg_offset(get_field(s->fields, v1));
+    TCGv_ptr a0 = tcg_temp_new_ptr();
+
+    /* convert highest index into an actual length */
+    tcg_gen_addi_i64(o->in2, o->in2, 1);
+    tcg_gen_addi_ptr(a0, cpu_env, v1_offs);
+    gen_helper_vll(cpu_env, a0, o->addr1, o->in2);
+    tcg_temp_free_ptr(a0);
+    return DISAS_NEXT;
+}
-- 
2.17.2
