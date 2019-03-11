Received: from eggs.gnu.org ([209.51.188.92]:44085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gsk-0004nD-Pf
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Gsj-0007Ny-8X
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:06:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:18 +0100
Message-Id: <20190311090322.21603-30-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 29/33] s390x/tcg: Implement VECTOR STORE
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

Properly probe the whole access first.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-29-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 555250fd5aca..4525d5b1452f 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1034,6 +1034,8 @@
     F(0xe78d, VSEL,    VRR_e, V,   0, 0, 0, 0, vsel, 0, IF_VEC)
 /* VECTOR SIGN EXTEND TO DOUBLEWORD */
     F(0xe75f, VSEG,    VRR_a, V,   0, 0, 0, 0, vseg, 0, IF_VEC)
+/* VECTOR STORE */
+    F(0xe70e, VST,     VRX,   V,   la2, 0, 0, 0, vst, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index cf1d319e4e27..fcddd0cde713 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -113,6 +113,7 @@ static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,
     }
 }
 
+
 static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
                                     uint8_t es)
 {
@@ -817,3 +818,19 @@ static DisasJumpType op_vseg(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vst(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 tmp = tcg_const_i64(16);
+
+    /* Probe write access before actually modifying memory */
+    gen_helper_probe_write_access(cpu_env, o->addr1, tmp);
+
+    read_vec_element_i64(tmp,  get_field(s->fields, v1), 0, ES_64);
+    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TEQ);
+    gen_addi_and_wrap_i64(s, o->addr1, o->addr1, 8);
+    read_vec_element_i64(tmp,  get_field(s->fields, v1), 1, ES_64);
+    tcg_gen_qemu_st_i64(tmp, o->addr1, get_mem_index(s), MO_TEQ);
+    tcg_temp_free_i64(tmp);
+    return DISAS_NEXT;
+}
-- 
2.17.2
