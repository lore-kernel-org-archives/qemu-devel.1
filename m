Received: from eggs.gnu.org ([209.51.188.92]:43863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GsO-0004Rl-CP
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GsN-00078G-Bp
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:40 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:14 +0100
Message-Id: <20190311090322.21603-26-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 25/33] s390x/tcg: Implement VECTOR SCATTER
 ELEMENT
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

Similar to VECTOR GATHER ELEMENT, but the other direction.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-25-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  3 +++
 target/s390x/translate_vx.inc.c | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 99fb697d914b..8d7c834e7d4a 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1027,6 +1027,9 @@
     F(0xe74d, VREP,    VRI_c, V,   0, 0, 0, 0, vrep, 0, IF_VEC)
 /* VECTOR REPLICATE IMMEDIATE */
     F(0xe745, VREPI,   VRI_a, V,   0, 0, 0, 0, vrepi, 0, IF_VEC)
+/* VECTOR SCATTER ELEMENT */
+    E(0xe71b, VSCEF,   VRV,   V,   la2, 0, 0, 0, vsce, 0, ES_32, IF_VEC)
+    E(0xe71a, VSCEG,   VRV,   V,   la2, 0, 0, 0, vsce, 0, ES_64, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index b6061d7acfec..cd8c173b36eb 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -721,3 +721,25 @@ static DisasJumpType op_vrepi(DisasContext *s, DisasOps *o)
     gen_gvec_dupi(es, get_field(s->fields, v1), data);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsce(DisasContext *s, DisasOps *o)
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
+    read_vec_element_i64(tmp, get_field(s->fields, v1), enr, es);
+    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
