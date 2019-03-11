Received: from eggs.gnu.org ([209.51.188.92]:43993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gse-0004gs-3V
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gsc-0007J1-26
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:55 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:16 +0100
Message-Id: <20190311090322.21603-28-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 27/33] s390x/tcg: Implement VECTOR SIGN EXTEND
 TO DOUBLEWORD
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

Load both elements signed and store them into the two 64 bit elements.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-27-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index ae58ff440b51..555250fd5aca 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1032,6 +1032,8 @@
     E(0xe71a, VSCEG,   VRV,   V,   la2, 0, 0, 0, vsce, 0, ES_64, IF_VEC)
 /* VECTOR SELECT */
     F(0xe78d, VSEL,    VRR_e, V,   0, 0, 0, 0, vsel, 0, IF_VEC)
+/* VECTOR SIGN EXTEND TO DOUBLEWORD */
+    F(0xe75f, VSEG,    VRR_a, V,   0, 0, 0, 0, vseg, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index e685506b8c39..cf1d319e4e27 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -784,3 +784,36 @@ static DisasJumpType op_vsel(DisasContext *s, DisasOps *o)
                get_field(s->fields, v3), get_field(s->fields, v4), &gvec_op);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vseg(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = get_field(s->fields, m3);
+    int idx1, idx2;
+    TCGv_i64 tmp;
+
+    switch (es) {
+    case ES_8:
+        idx1 = 7;
+        idx2 = 15;
+        break;
+    case ES_16:
+        idx1 = 3;
+        idx2 = 7;
+        break;
+    case ES_32:
+        idx1 = 1;
+        idx2 = 3;
+        break;
+    default:
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    tmp = tcg_temp_new_i64();
+    read_vec_element_i64(tmp, get_field(s->fields, v2), idx1, es | MO_SIGN);
+    write_vec_element_i64(tmp, get_field(s->fields, v1), 0, ES_64);
+    read_vec_element_i64(tmp, get_field(s->fields, v2), idx2, es | MO_SIGN);
+    write_vec_element_i64(tmp, get_field(s->fields, v1), 1, ES_64);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
