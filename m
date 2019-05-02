Received: from eggs.gnu.org ([209.51.188.92]:38421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQG-000882-53
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQE-0006j0-9x
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:52 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:09:47 +0200
Message-Id: <20190502141019.6385-9-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 08/40] s390x/tcg: Implement VECTOR CHECKSUM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Time to introduce read_vec_element_i32 and write_vec_element_i32.
Take proper care of properly adding the carry. We can perform both
additions including the carry via tcg_gen_add2_i32().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  2 +
 target/s390x/translate_vx.inc.c | 65 +++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 9889dc0b01..64459465c5 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1072,6 +1072,8 @@
     F(0xe7f2, VAVG,    VRR_c, V,   0, 0, 0, 0, vavg, 0, IF_VEC)
 /* VECTOR AVERAGE LOGICAL */
     F(0xe7f0, VAVGL,   VRR_c, V,   0, 0, 0, 0, vavgl, 0, IF_VEC)
+/* VECTOR CHECKSUM */
+    F(0xe766, VCKSM,   VRR_c, V,   0, 0, 0, 0, vcksm, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 7e8418e585..0f90f981b6 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -90,6 +90,33 @@ static void read_vec_element_i64(TCGv_i64 dst, uint8_t=
 reg, uint8_t enr,
     }
 }
=20
+static void read_vec_element_i32(TCGv_i32 dst, uint8_t reg, uint8_t enr,
+                                 TCGMemOp memop)
+{
+    const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);
+
+    switch (memop) {
+    case ES_8:
+        tcg_gen_ld8u_i32(dst, cpu_env, offs);
+        break;
+    case ES_16:
+        tcg_gen_ld16u_i32(dst, cpu_env, offs);
+        break;
+    case ES_8 | MO_SIGN:
+        tcg_gen_ld8s_i32(dst, cpu_env, offs);
+        break;
+    case ES_16 | MO_SIGN:
+        tcg_gen_ld16s_i32(dst, cpu_env, offs);
+        break;
+    case ES_32:
+    case ES_32 | MO_SIGN:
+        tcg_gen_ld_i32(dst, cpu_env, offs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void write_vec_element_i64(TCGv_i64 src, int reg, uint8_t enr,
                                   TCGMemOp memop)
 {
@@ -113,6 +140,25 @@ static void write_vec_element_i64(TCGv_i64 src, int =
reg, uint8_t enr,
     }
 }
=20
+static void write_vec_element_i32(TCGv_i32 src, int reg, uint8_t enr,
+                                  TCGMemOp memop)
+{
+    const int offs =3D vec_reg_offset(reg, enr, memop & MO_SIZE);
+
+    switch (memop) {
+    case ES_8:
+        tcg_gen_st8_i32(src, cpu_env, offs);
+        break;
+    case ES_16:
+        tcg_gen_st16_i32(src, cpu_env, offs);
+        break;
+    case ES_32:
+        tcg_gen_st_i32(src, cpu_env, offs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
=20
 static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 =
enr,
                                     uint8_t es)
@@ -1300,3 +1346,22 @@ static DisasJumpType op_vavgl(DisasContext *s, Dis=
asOps *o)
                get_field(s->fields, v3), &g[es]);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vcksm(DisasContext *s, DisasOps *o)
+{
+    TCGv_i32 tmp =3D tcg_temp_new_i32();
+    TCGv_i32 sum =3D tcg_temp_new_i32();
+    int i;
+
+    read_vec_element_i32(sum, get_field(s->fields, v3), 1, ES_32);
+    for (i =3D 0; i < 4; i++) {
+        read_vec_element_i32(tmp, get_field(s->fields, v2), i, ES_32);
+        tcg_gen_add2_i32(tmp, sum, sum, sum, tmp, tmp);
+    }
+    zero_vec(get_field(s->fields, v1));
+    write_vec_element_i32(sum, get_field(s->fields, v1), 1, ES_32);
+
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(sum);
+    return DISAS_NEXT;
+}
--=20
2.20.1
