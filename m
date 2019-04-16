Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3853C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BC6206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BC6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41441 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGTZu-0007dH-II
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 15:17:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTDh-0005O6-DS
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTDf-0005uf-Nl
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:54:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hGTDf-0005tA-CO; Tue, 16 Apr 2019 14:54:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BC768830F;
	Tue, 16 Apr 2019 18:54:10 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE6715D71A;
	Tue, 16 Apr 2019 18:54:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 20:52:49 +0200
Message-Id: <20190416185301.25344-30-david@redhat.com>
In-Reply-To: <20190416185301.25344-1-david@redhat.com>
References: <20190416185301.25344-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 16 Apr 2019 18:54:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 29/41] s390x/tcg: Implement VECTOR ELEMENT
 SHIFT
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
Message-ID: <20190416185249.vtsiizByEfA1ge7hMzWevqRuXMHnkr6j8HufIw-O8U0@z>

Only for one special case we can reuse real gvec helpers. Mostly
rely on oom helpers.

One important thing to take care of is always to properly mask of
unused bits from the shift count.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  18 +++++
 target/s390x/insn-data.def      |   9 +++
 target/s390x/translate_vx.inc.c | 113 ++++++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   |  99 ++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 80d82e698a..26837b43c5 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -206,6 +206,24 @@ DEF_HELPER_FLAGS_4(gvec_verll8, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_verll16, TCG_CALL_NO_RWG, void, ptr, cptr, i64, =
i32)
 DEF_HELPER_FLAGS_4(gvec_verim8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_verim16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_veslv8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_veslv16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_veslv32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_veslv64, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_vesrav8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_vesrav16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
+DEF_HELPER_FLAGS_4(gvec_vesrav32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
+DEF_HELPER_FLAGS_4(gvec_vesrav64, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
+DEF_HELPER_FLAGS_4(gvec_vesrlv8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_vesrlv16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
+DEF_HELPER_FLAGS_4(gvec_vesrlv32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
+DEF_HELPER_FLAGS_4(gvec_vesrlv64, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
+DEF_HELPER_FLAGS_4(gvec_vesl8, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i3=
2)
+DEF_HELPER_FLAGS_4(gvec_vesl16, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vesra8, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vesra16, TCG_CALL_NO_RWG, void, ptr, cptr, i64, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vesrl8, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i=
32)
+DEF_HELPER_FLAGS_4(gvec_vesrl16, TCG_CALL_NO_RWG, void, ptr, cptr, i64, =
i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 59c323a796..f4b67bda7e 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1151,6 +1151,15 @@
     F(0xe733, VERLL,   VRS_a, V,   la2, 0, 0, 0, verll, 0, IF_VEC)
 /* VECTOR ELEMENT ROTATE AND INSERT UNDER MASK */
     F(0xe772, VERIM,   VRI_d, V,   0, 0, 0, 0, verim, 0, IF_VEC)
+/* VECTOR ELEMENT SHIFT LEFT */
+    F(0xe770, VESLV,   VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
+    F(0xe730, VESL,    VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
+/* VECTOR ELEMENT SHIFT RIGHT ARITHMETIC */
+    F(0xe77a, VESRAV,  VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
+    F(0xe73a, VESRA,   VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
+/* VECTOR ELEMENT SHIFT RIGHT LOGICAL */
+    F(0xe778, VESRLV,  VRR_c, V,   0, 0, 0, 0, vesv, 0, IF_VEC)
+    F(0xe738, VESRL,   VRS_a, V,   la2, 0, 0, 0, ves, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 03f8d53d75..35a9161c2b 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -218,6 +218,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
 #define gen_gvec_fn_2(fn, es, v1, v2) \
     tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
                       16, 16)
+#define gen_gvec_fn_2i(fn, es, v1, v2, c) \
+    tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
+                      c, 16, 16)
 #define gen_gvec_fn_3(fn, es, v1, v2, v3) \
     tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v=
2), \
                       vec_full_reg_offset(v3), 16, 16)
@@ -1980,3 +1983,113 @@ static DisasJumpType op_verim(DisasContext *s, Di=
sasOps *o)
                 get_field(s->fields, v3), i4, &g[es]);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g_veslv[4] =3D {
+        { .fno =3D gen_helper_gvec_veslv8, },
+        { .fno =3D gen_helper_gvec_veslv16, },
+        { .fno =3D gen_helper_gvec_veslv32, },
+        { .fno =3D gen_helper_gvec_veslv64, },
+    };
+    static const GVecGen3 g_vesrav[4] =3D {
+        { .fno =3D gen_helper_gvec_vesrav8, },
+        { .fno =3D gen_helper_gvec_vesrav16, },
+        { .fno =3D gen_helper_gvec_vesrav32, },
+        { .fno =3D gen_helper_gvec_vesrav64, },
+    };
+    static const GVecGen3 g_vesrlv[4] =3D {
+        { .fno =3D gen_helper_gvec_vesrlv8, },
+        { .fno =3D gen_helper_gvec_vesrlv16, },
+        { .fno =3D gen_helper_gvec_vesrlv32, },
+        { .fno =3D gen_helper_gvec_vesrlv64, },
+    };
+    const GVecGen3 *fn;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0x70:
+        fn =3D &g_veslv[es];
+        break;
+    case 0x7a:
+        fn =3D &g_vesrav[es];
+        break;
+    case 0x78:
+        fn =3D &g_vesrlv[es];
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), fn);
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_ves(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    const uint8_t d2 =3D get_field(s->fields, d2) &
+                       (NUM_VEC_ELEMENT_BITS(es) - 1);
+    const uint8_t v1 =3D get_field(s->fields, v1);
+    const uint8_t v3 =3D get_field(s->fields, v3);
+    static const GVecGen2s g_vesl[4] =3D {
+        { .fno =3D gen_helper_gvec_vesl8, },
+        { .fno =3D gen_helper_gvec_vesl16, },
+        { .fni4 =3D tcg_gen_shl_i32, },
+        { .fni8 =3D tcg_gen_shl_i64, },
+    };
+    static const GVecGen2s g_vesra[4] =3D {
+        { .fno =3D gen_helper_gvec_vesra8, },
+        { .fno =3D gen_helper_gvec_vesra16, },
+        { .fni4 =3D tcg_gen_sar_i32, },
+        { .fni8 =3D tcg_gen_sar_i64, },
+    };
+    static const GVecGen2s g_vesrl[4] =3D {
+        { .fno =3D gen_helper_gvec_vesrl8, },
+        { .fno =3D gen_helper_gvec_vesrl16, },
+        { .fni4 =3D tcg_gen_shr_i32, },
+        { .fni8 =3D tcg_gen_shr_i64, },
+    };
+    const GVecGen2s *fn;
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0x30:
+        if (likely(!get_field(s->fields, b2))) {
+            gen_gvec_fn_2i(shli, es, v1, v3, d2);
+            return DISAS_NEXT;
+        }
+        fn =3D &g_vesl[es];
+        break;
+    case 0x3a:
+        if (likely(!get_field(s->fields, b2))) {
+            gen_gvec_fn_2i(sari, es, v1, v3, d2);
+            return DISAS_NEXT;
+        }
+        fn =3D &g_vesra[es];
+        break;
+    case 0x38:
+        if (likely(!get_field(s->fields, b2))) {
+            gen_gvec_fn_2i(shri, es, v1, v3, d2);
+            return DISAS_NEXT;
+        }
+        fn =3D &g_vesrl[es];
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_gen_andi_i64(o->addr1, o->addr1, NUM_VEC_ELEMENT_BITS(es) - 1);
+    gen_gvec_2s(v1, v3, o->addr1, fn);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 6bc7498572..266a752b76 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -543,3 +543,102 @@ void HELPER(gvec_verim##BITS)(void *v1, const void =
*v2, const void *v3,        \
 }
 DEF_VERIM(8)
 DEF_VERIM(16)
+
+#define DEF_VESLV(BITS)                                                 =
       \
+void HELPER(gvec_veslv##BITS)(void *v1, const void *v2, const void *v3, =
       \
+                              uint32_t desc)                            =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const uint##BITS##_t a =3D s390_vec_read_element##BITS(v2, i);  =
         \
+        const uint8_t shift =3D s390_vec_read_element##BITS(v3, i) & (BI=
TS - 1); \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, a << shift);                =
       \
+    }                                                                   =
       \
+}
+DEF_VESLV(8)
+DEF_VESLV(16)
+DEF_VESLV(32)
+DEF_VESLV(64)
+
+#define DEF_VESRAV(BITS)                                                =
       \
+void HELPER(gvec_vesrav##BITS)(void *v1, const void *v2, const void *v3,=
       \
+                               uint32_t desc)                           =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const int##BITS##_t a =3D s390_vec_read_element##BITS(v2, i);   =
         \
+        const uint8_t shift =3D s390_vec_read_element##BITS(v3, i) & (BI=
TS - 1); \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, a >> shift);                =
       \
+    }                                                                   =
       \
+}
+DEF_VESRAV(8)
+DEF_VESRAV(16)
+DEF_VESRAV(32)
+DEF_VESRAV(64)
+
+#define DEF_VESRLV(BITS)                                                =
       \
+void HELPER(gvec_vesrlv##BITS)(void *v1, const void *v2, const void *v3,=
       \
+                               uint32_t desc)                           =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const uint##BITS##_t a =3D s390_vec_read_element##BITS(v2, i);  =
         \
+        const uint8_t shift =3D s390_vec_read_element##BITS(v3, i) & (BI=
TS - 1); \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, a >> shift);                =
       \
+    }                                                                   =
       \
+}
+DEF_VESRLV(8)
+DEF_VESRLV(16)
+DEF_VESRLV(32)
+DEF_VESRLV(64)
+
+#define DEF_VESL(BITS)                                                  =
       \
+void HELPER(gvec_vesl##BITS)(void *v1, const void *v3, uint64_t shift,  =
       \
+                             uint32_t desc)                             =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const uint##BITS##_t a =3D s390_vec_read_element##BITS(v3, i);  =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, a << shift);                =
       \
+    }                                                                   =
       \
+}
+DEF_VESL(8)
+DEF_VESL(16)
+
+#define DEF_VESRA(BITS)                                                 =
       \
+void HELPER(gvec_vesra##BITS)(void *v1, const void *v3, uint64_t shift, =
       \
+                              uint32_t desc)                            =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const int##BITS##_t a =3D s390_vec_read_element##BITS(v3, i);   =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, a >> shift);                =
       \
+    }                                                                   =
       \
+}
+DEF_VESRA(8)
+DEF_VESRA(16)
+
+#define DEF_VESRL(BITS)                                                 =
       \
+void HELPER(gvec_vesrl##BITS)(void *v1, const void *v3, uint64_t shift, =
       \
+                              uint32_t desc)                            =
       \
+{                                                                       =
       \
+    int i;                                                              =
       \
+                                                                        =
       \
+    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
+        const uint##BITS##_t a =3D s390_vec_read_element##BITS(v3, i);  =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, a >> shift);                =
       \
+    }                                                                   =
       \
+}
+DEF_VESRL(8)
+DEF_VESRL(16)
--=20
2.20.1


