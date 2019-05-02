Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BCBC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E2B206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E2B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51829 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMCXo-0006ZJ-Mz
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 10:18:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQN-0008Da-L4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCQM-0006pD-3a
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hMCQL-0006oc-S6; Thu, 02 May 2019 10:10:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13BBB81E1B;
	Thu,  2 May 2019 14:10:57 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-88.ams2.redhat.com [10.36.117.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 853B03793;
	Thu,  2 May 2019 14:10:55 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:09:53 +0200
Message-Id: <20190502141019.6385-15-david@redhat.com>
In-Reply-To: <20190502141019.6385-1-david@redhat.com>
References: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 02 May 2019 14:10:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 14/40] s390x/tcg: Implement VECTOR GALOIS
 FIELD MULTIPLY SUM (AND ACCUMULATE)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502140953.wgkmJCrCjgIbPcol_ZeHZ0H0N8bppfq9stExyR0P1MM@z>

A galois field multiplication in field 2 is like binary multiplication,
however instead of doing ordinary binary additions, xor's are performed.
So no carries are considered.

Implement all variants via helpers. s390_vec_sar() and s390_vec_shr()
will be reused later on.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |   8 ++
 target/s390x/insn-data.def      |   4 +
 target/s390x/translate_vx.inc.c |  38 ++++++++
 target/s390x/vec_int_helper.c   | 167 ++++++++++++++++++++++++++++++++
 4 files changed, 217 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 60b8bd3c43..6e6ba9bf32 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -154,6 +154,14 @@ DEF_HELPER_FLAGS_3(gvec_vclz8, TCG_CALL_NO_RWG, void=
, ptr, cptr, i32)
 DEF_HELPER_FLAGS_3(gvec_vclz16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
 DEF_HELPER_FLAGS_3(gvec_vctz8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
 DEF_HELPER_FLAGS_3(gvec_vctz16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vgfm8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vgfm16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vgfm32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vgfm64, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_5(gvec_vgfma8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vgfma16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vgfma32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vgfma64, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 cptr, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index b8400c191a..add174b793 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1090,6 +1090,10 @@
     F(0xe752, VCTZ,    VRR_a, V,   0, 0, 0, 0, vctz, 0, IF_VEC)
 /* VECTOR EXCLUSIVE OR */
     F(0xe76d, VX,      VRR_c, V,   0, 0, 0, 0, vx, 0, IF_VEC)
+/* VECTOR GALOIS FIELD MULTIPLY SUM */
+    F(0xe7b4, VGFM,    VRR_c, V,   0, 0, 0, 0, vgfm, 0, IF_VEC)
+/* VECTOR GALOIS FIELD MULTIPLY SUM AND ACCUMULATE */
+    F(0xe7bc, VGFMA,   VRR_d, V,   0, 0, 0, 0, vgfma, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 0c67f53d1c..dbe0b6a560 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1479,3 +1479,41 @@ static DisasJumpType op_vx(DisasContext *s, DisasO=
ps *o)
                  get_field(s->fields, v3));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vgfm(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g[4] =3D {
+        { .fno =3D gen_helper_gvec_vgfm8, },
+        { .fno =3D gen_helper_gvec_vgfm16, },
+        { .fno =3D gen_helper_gvec_vgfm32, },
+        { .fno =3D gen_helper_gvec_vgfm64, },
+    };
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), &g[es]);
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_vgfma(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m5);
+    static const GVecGen4 g[4] =3D {
+        { .fno =3D gen_helper_gvec_vgfma8, },
+        { .fno =3D gen_helper_gvec_vgfma16, },
+        { .fno =3D gen_helper_gvec_vgfma32, },
+        { .fno =3D gen_helper_gvec_vgfma64, },
+    };
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    gen_gvec_4(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), get_field(s->fields, v4), &g[es=
]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index d1b1f28509..20a1034dd8 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -15,6 +15,59 @@
 #include "vec.h"
 #include "exec/helper-proto.h"
=20
+static bool s390_vec_is_zero(const S390Vector *v)
+{
+    return !v->doubleword[0] && !v->doubleword[1];
+}
+
+static void s390_vec_xor(S390Vector *res, const S390Vector *a,
+                         const S390Vector *b)
+{
+    res->doubleword[0] =3D a->doubleword[0] ^ b->doubleword[0];
+    res->doubleword[1] =3D a->doubleword[1] ^ b->doubleword[1];
+}
+
+static void s390_vec_shl(S390Vector *d, const S390Vector *a, uint64_t co=
unt)
+{
+    uint64_t tmp;
+
+    g_assert(count < 128);
+    if (count =3D=3D 0) {
+        d->doubleword[0] =3D a->doubleword[0];
+        d->doubleword[1] =3D a->doubleword[1];
+    } else if (count =3D=3D 64) {
+        d->doubleword[0] =3D a->doubleword[1];
+        d->doubleword[1] =3D 0;
+    } else if (count < 64) {
+        tmp =3D extract64(a->doubleword[1], 64 - count, count);
+        d->doubleword[1] =3D a->doubleword[1] << count;
+        d->doubleword[0] =3D (a->doubleword[0] << count) | tmp;
+    } else {
+        d->doubleword[0] =3D a->doubleword[1] << (count - 64);
+        d->doubleword[1] =3D 0;
+    }
+}
+
+static void s390_vec_shr(S390Vector *d, const S390Vector *a, uint64_t co=
unt)
+{
+    uint64_t tmp;
+
+    g_assert(count < 128);
+    if (count =3D=3D 0) {
+        d->doubleword[0] =3D a->doubleword[0];
+        d->doubleword[1] =3D a->doubleword[1];
+    } else if (count =3D=3D 64) {
+        d->doubleword[1] =3D a->doubleword[0];
+        d->doubleword[0] =3D 0;
+    } else if (count < 64) {
+        tmp =3D a->doubleword[1] >> count;
+        d->doubleword[1] =3D deposit64(tmp, 64 - count, count, a->double=
word[0]);
+        d->doubleword[0] =3D a->doubleword[0] >> count;
+    } else {
+        d->doubleword[1] =3D a->doubleword[0] >> (count - 64);
+        d->doubleword[0] =3D 0;
+    }
+}
 #define DEF_VAVG(BITS)                                                  =
       \
 void HELPER(gvec_vavg##BITS)(void *v1, const void *v2, const void *v3,  =
       \
                              uint32_t desc)                             =
       \
@@ -74,3 +127,117 @@ void HELPER(gvec_vctz##BITS)(void *v1, const void *v=
2, uint32_t desc)          \
 }
 DEF_VCTZ(8)
 DEF_VCTZ(16)
+
+/* like binary multiplication, but XOR instead of addition */
+#define DEF_GALOIS_MULTIPLY(BITS, TBITS)                                =
       \
+static uint##TBITS##_t galois_multiply##BITS(uint##TBITS##_t a,         =
       \
+                                             uint##TBITS##_t b)         =
       \
+{                                                                       =
       \
+    uint##TBITS##_t res =3D 0;                                          =
         \
+                                                                        =
       \
+    while (b) {                                                         =
       \
+        if (b & 0x1) {                                                  =
       \
+            res =3D res ^ a;                                            =
         \
+        }                                                               =
       \
+        a =3D a << 1;                                                   =
         \
+        b =3D b >> 1;                                                   =
         \
+    }                                                                   =
       \
+    return res;                                                         =
       \
+}
+DEF_GALOIS_MULTIPLY(8, 16)
+DEF_GALOIS_MULTIPLY(16, 32)
+DEF_GALOIS_MULTIPLY(32, 64)
+
+static S390Vector galois_multiply64(uint64_t a, uint64_t b)
+{
+    S390Vector res =3D {};
+    S390Vector va =3D {
+        .doubleword[1] =3D a,
+    };
+    S390Vector vb =3D {
+        .doubleword[1] =3D b,
+    };
+
+    while (!s390_vec_is_zero(&vb)) {
+        if (vb.doubleword[1] & 0x1) {
+            s390_vec_xor(&res, &res, &va);
+        }
+        s390_vec_shl(&va, &va, 1);
+        s390_vec_shr(&vb, &vb, 1);
+    }
+    return res;
+}
+
+#define DEF_VGFM(BITS, TBITS)                                           =
       \
+void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,  =
       \
+                             uint32_t desc)                             =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / TBITS); i++) {                             =
         \
+        uint##BITS##_t a =3D s390_vec_read_element##BITS(v2, i * 2);    =
         \
+        uint##BITS##_t b =3D s390_vec_read_element##BITS(v3, i * 2);    =
         \
+        uint##TBITS##_t d =3D galois_multiply##BITS(a, b);              =
         \
+                                                                        =
       \
+        a =3D s390_vec_read_element##BITS(v2, i * 2 + 1);               =
         \
+        b =3D s390_vec_read_element##BITS(v3, i * 2 + 1);               =
         \
+        d =3D d ^ galois_multiply32(a, b);                              =
         \
+        s390_vec_write_element##TBITS(v1, i, d);                        =
       \
+    }                                                                   =
       \
+}
+DEF_VGFM(8, 16)
+DEF_VGFM(16, 32)
+DEF_VGFM(32, 64)
+
+void HELPER(gvec_vgfm64)(void *v1, const void *v2, const void *v3,
+                         uint32_t desc)
+{
+    S390Vector tmp1, tmp2;
+    uint64_t a, b;
+
+    a =3D s390_vec_read_element64(v2, 0);
+    b =3D s390_vec_read_element64(v3, 0);
+    tmp1 =3D galois_multiply64(a, b);
+    a =3D s390_vec_read_element64(v2, 1);
+    b =3D s390_vec_read_element64(v3, 1);
+    tmp2 =3D galois_multiply64(a, b);
+    s390_vec_xor(v1, &tmp1, &tmp2);
+}
+
+#define DEF_VGFMA(BITS, TBITS)                                          =
       \
+void HELPER(gvec_vgfma##BITS)(void *v1, const void *v2, const void *v3, =
       \
+                              const void *v4, uint32_t desc)            =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / TBITS); i++) {                             =
         \
+        uint##BITS##_t a =3D s390_vec_read_element##BITS(v2, i * 2);    =
         \
+        uint##BITS##_t b =3D s390_vec_read_element##BITS(v3, i * 2);    =
         \
+        uint##TBITS##_t d =3D galois_multiply##BITS(a, b);              =
         \
+                                                                        =
       \
+        a =3D s390_vec_read_element##BITS(v2, i * 2 + 1);               =
         \
+        b =3D s390_vec_read_element##BITS(v3, i * 2 + 1);               =
         \
+        d =3D d ^ galois_multiply32(a, b);                              =
         \
+        d =3D d ^ s390_vec_read_element##TBITS(v4, i);                  =
         \
+        s390_vec_write_element##TBITS(v1, i, d);                        =
       \
+    }                                                                   =
       \
+}
+DEF_VGFMA(8, 16)
+DEF_VGFMA(16, 32)
+DEF_VGFMA(32, 64)
+
+void HELPER(gvec_vgfma64)(void *v1, const void *v2, const void *v3,
+                          const void *v4, uint32_t desc)
+{
+    S390Vector tmp1, tmp2;
+    uint64_t a, b;
+
+    a =3D s390_vec_read_element64(v2, 0);
+    b =3D s390_vec_read_element64(v3, 0);
+    tmp1 =3D galois_multiply64(a, b);
+    a =3D s390_vec_read_element64(v2, 1);
+    b =3D s390_vec_read_element64(v3, 1);
+    tmp2 =3D galois_multiply64(a, b);
+    s390_vec_xor(&tmp1, &tmp1, &tmp2);
+    s390_vec_xor(v1, &tmp1, v4);
+}
--=20
2.20.1


