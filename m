Received: from eggs.gnu.org ([209.51.188.92]:43270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GrK-0003Sh-If
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3GrD-0005kG-Gs
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:04:33 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:00 +0100
Message-Id: <20190311090322.21603-12-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 11/33] s390x/tcg: Implement VECTOR LOAD ELEMENT
 IMMEDIATE
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

Take care of properly sign-extending the immediate.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-11-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  5 +++++
 target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index aec0a3ba971d..782d49e1db6e 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -991,6 +991,11 @@
     E(0xe701, VLEH,    VRX,   V,   la2, 0, 0, 0, vle, 0, ES_16, IF_VEC)
     E(0xe703, VLEF,    VRX,   V,   la2, 0, 0, 0, vle, 0, ES_32, IF_VEC)
     E(0xe702, VLEG,    VRX,   V,   la2, 0, 0, 0, vle, 0, ES_64, IF_VEC)
+/* VECTOR LOAD ELEMENT IMMEDIATE */
+    E(0xe740, VLEIB,   VRI_a, V,   0, 0, 0, 0, vlei, 0, ES_8, IF_VEC)
+    E(0xe741, VLEIH,   VRI_a, V,   0, 0, 0, 0, vlei, 0, ES_16, IF_VEC)
+    E(0xe743, VLEIF,   VRI_a, V,   0, 0, 0, 0, vlei, 0, ES_32, IF_VEC)
+    E(0xe742, VLEIG,   VRI_a, V,   0, 0, 0, 0, vlei, 0, ES_64, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 9134324aa80f..d450ce2d2baf 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -280,3 +280,20 @@ static DisasJumpType op_vle(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vlei(DisasContext *s, DisasOps *o)
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
+    tmp = tcg_const_i64((int16_t)get_field(s->fields, i2));
+    write_vec_element_i64(tmp, get_field(s->fields, v1), enr, es);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
