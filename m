Received: from eggs.gnu.org ([209.51.188.92]:41563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rwT-0004GR-BE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1h1rwS-0008Ev-Ed
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:16:05 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Mar 2019 13:15:17 +0100
Message-Id: <20190307121539.12842-11-david@redhat.com>
In-Reply-To: <20190307121539.12842-1-david@redhat.com>
References: <20190307121539.12842-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/32] s390x/tcg: Implement VECTOR LOAD
 ELEMENT IMMEDIATE
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

Take care of properly sign-extending the immediate.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  5 +++++
 target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index aec0a3ba97..782d49e1db 100644
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
index 9134324aa8..d450ce2d2b 100644
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
