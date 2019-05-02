Received: from eggs.gnu.org ([209.51.188.92]:38660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQU-0008LL-LZ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQT-0006uB-Jq
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:09:56 +0200
Message-Id: <20190502141019.6385-18-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 17/40] s390x/tcg: Implement VECTOR
 (MAXIMUM|MINIMUM) (LOGICAL)
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

Luckily, we already have gvec helpers for all four cases.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/insn-data.def      |  8 ++++++++
 target/s390x/translate_vx.inc.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index fc8886ff42..b22d9f0f6a 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1098,6 +1098,14 @@
     F(0xe7de, VLC,     VRR_a, V,   0, 0, 0, 0, vlc, 0, IF_VEC)
 /* VECTOR LOAD POSITIVE */
     F(0xe7df, VLP,     VRR_a, V,   0, 0, 0, 0, vlp, 0, IF_VEC)
+/* VECTOR MAXIMUM */
+    F(0xe7ff, VMX,     VRR_c, V,   0, 0, 0, 0, vmx, 0, IF_VEC)
+/* VECTOR MAXIMUM LOGICAL */
+    F(0xe7fd, VMXL,    VRR_c, V,   0, 0, 0, 0, vmx, 0, IF_VEC)
+/* VECTOR MINIMUM */
+    F(0xe7fe, VMN,     VRR_c, V,   0, 0, 0, 0, vmx, 0, IF_VEC)
+/* VECTOR MINIMUM LOGICAL */
+    F(0xe7fc, VMNL,    VRR_c, V,   0, 0, 0, 0, vmx, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index c2a3dbae32..efd42c6f9f 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1546,3 +1546,34 @@ static DisasJumpType op_vlp(DisasContext *s, Disas=
Ops *o)
     gen_gvec_fn_2(abs, es, get_field(s->fields, v1), get_field(s->fields=
, v2));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vmx(DisasContext *s, DisasOps *o)
+{
+    const uint8_t v1 =3D get_field(s->fields, v1);
+    const uint8_t v2 =3D get_field(s->fields, v2);
+    const uint8_t v3 =3D get_field(s->fields, v3);
+    const uint8_t es =3D get_field(s->fields, m4);
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0xff:
+        gen_gvec_fn_3(smax, es, v1, v2, v3);
+        break;
+    case 0xfd:
+        gen_gvec_fn_3(umax, es, v1, v2, v3);
+        break;
+    case 0xfe:
+        gen_gvec_fn_3(smin, es, v1, v2, v3);
+        break;
+    case 0xfc:
+        gen_gvec_fn_3(umin, es, v1, v2, v3);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return DISAS_NEXT;
+}
--=20
2.20.1
