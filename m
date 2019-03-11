Received: from eggs.gnu.org ([209.51.188.92]:43197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gr8-0003KJ-1n
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gr7-0005gA-7o
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:21 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:02:59 +0100
Message-Id: <20190311090322.21603-11-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/33] s390x/tcg: Implement VECTOR LOAD ELEMENT
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

Fairly easy, load with desired size and store it into the right element.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-10-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  5 +++++
 target/s390x/translate_vx.inc.c | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 7be8977989e2..aec0a3ba971d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -986,6 +986,11 @@
     F(0xe756, VLR,     VRR_a, V,   0, 0, 0, 0, vlr, 0, IF_VEC)
 /* VECTOR LOAD AND REPLICATE */
     F(0xe705, VLREP,   VRX,   V,   la2, 0, 0, 0, vlrep, 0, IF_VEC)
+/* VECTOR LOAD ELEMENT */
+    E(0xe700, VLEB,    VRX,   V,   la2, 0, 0, 0, vle, 0, ES_8, IF_VEC)
+    E(0xe701, VLEH,    VRX,   V,   la2, 0, 0, 0, vle, 0, ES_16, IF_VEC)
+    E(0xe703, VLEF,    VRX,   V,   la2, 0, 0, 0, vle, 0, ES_32, IF_VEC)
+    E(0xe702, VLEG,    VRX,   V,   la2, 0, 0, 0, vle, 0, ES_64, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index ede4cc4f6df8..9134324aa80f 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -262,3 +262,21 @@ static DisasJumpType op_vlrep(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vle(DisasContext *s, DisasOps *o)
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
+    tcg_gen_qemu_ld_i64(tmp, o->addr1, get_mem_index(s), MO_TE | es);
+    write_vec_element_i64(tmp, get_field(s->fields, v1), enr, es);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
