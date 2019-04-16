Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1787C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A482064A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A482064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGTWZ-0004fg-Ol
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 15:13:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTDe-0005K7-DK
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGTDd-0005qh-4B
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:54:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hGTDc-0005oA-Pp; Tue, 16 Apr 2019 14:54:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04C2F308620D;
	Tue, 16 Apr 2019 18:54:07 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 818FE5D707;
	Tue, 16 Apr 2019 18:54:05 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 20:52:47 +0200
Message-Id: <20190416185301.25344-28-david@redhat.com>
In-Reply-To: <20190416185301.25344-1-david@redhat.com>
References: <20190416185301.25344-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 16 Apr 2019 18:54:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 27/41] s390x/tcg: Implement VECTOR ELEMENT
 ROTATE LEFT LOGICAL
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
Message-ID: <20190416185247.Uvg9XPU3jyVqKVU9Kc34LFvgU2BOym5iZSxc-X09MFg@z>

Take care of properly taking the modulo of the count. We might later
want to come back and create a variant of VERLL where the base register
is 0, resulting in an immediate.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  4 +++
 target/s390x/insn-data.def      |  3 ++
 target/s390x/translate_vx.inc.c | 60 +++++++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 31 +++++++++++++++++
 4 files changed, 98 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 239d45220d..20b30133f9 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -200,6 +200,10 @@ DEF_HELPER_FLAGS_4(gvec_vmlo16, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vmlo32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_3(gvec_vpopct8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
 DEF_HELPER_FLAGS_3(gvec_vpopct16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_verllv8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_verllv16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
+DEF_HELPER_FLAGS_4(gvec_verll8, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i=
32)
+DEF_HELPER_FLAGS_4(gvec_verll16, TCG_CALL_NO_RWG, void, ptr, cptr, i64, =
i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 0f786d6ab1..e765c15941 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1146,6 +1146,9 @@
     F(0xe76f, VOC,     VRR_c, VE,  0, 0, 0, 0, voc, 0, IF_VEC)
 /* VECTOR POPULATION COUNT */
     F(0xe750, VPOPCT,  VRR_a, V,   0, 0, 0, 0, vpopct, 0, IF_VEC)
+/* VECTOR ELEMENT ROTATE LEFT LOGICAL */
+    F(0xe773, VERLLV,  VRR_c, V,   0, 0, 0, 0, verllv, 0, IF_VEC)
+    F(0xe733, VERLL,   VRS_a, V,   la2, 0, 0, 0, verll, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 077da3b06e..6282615462 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -185,6 +185,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
 #define gen_gvec_2(v1, v2, gen) \
     tcg_gen_gvec_2(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                    16, 16, gen)
+#define gen_gvec_2s(v1, v2, c, gen) \
+    tcg_gen_gvec_2s(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                    16, 16, c, gen)
 #define gen_gvec_3(v1, v2, v3, gen) \
     tcg_gen_gvec_3(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                    vec_full_reg_offset(v3), 16, 16, gen)
@@ -1869,3 +1872,60 @@ static DisasJumpType op_vpopct(DisasContext *s, Di=
sasOps *o)
     gen_gvec_2(get_field(s->fields, v1), get_field(s->fields, v2), &g[es=
]);
     return DISAS_NEXT;
 }
+
+static void gen_rll_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t0 =3D tcg_temp_new_i32();
+
+    tcg_gen_andi_i32(t0, b, 31);
+    tcg_gen_rotl_i32(d, a, t0);
+    tcg_temp_free_i32(t0);
+}
+
+static void gen_rll_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t0 =3D tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(t0, b, 63);
+    tcg_gen_rotl_i64(d, a, t0);
+    tcg_temp_free_i64(t0);
+}
+
+static DisasJumpType op_verllv(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g[4] =3D {
+        { .fno =3D gen_helper_gvec_verllv8, },
+        { .fno =3D gen_helper_gvec_verllv16, },
+        { .fni4 =3D gen_rll_i32, },
+        { .fni8 =3D gen_rll_i64, },
+    };
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), &g[es]);
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_verll(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen2s g[4] =3D {
+        { .fno =3D gen_helper_gvec_verll8, },
+        { .fno =3D gen_helper_gvec_verll16, },
+        { .fni4 =3D gen_rll_i32, },
+        { .fni8 =3D gen_rll_i64, },
+    };
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    gen_gvec_2s(get_field(s->fields, v1), get_field(s->fields, v3), o->a=
ddr1,
+                &g[es]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index c66ec3d2f4..3cb9119536 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -492,3 +492,34 @@ void HELPER(gvec_vpopct##BITS)(void *v1, const void =
*v2, uint32_t desc)        \
 }
 DEF_VPOPCT(8)
 DEF_VPOPCT(16)
+
+#define DEF_VERLLV(BITS)                                                =
       \
+void HELPER(gvec_verllv##BITS)(void *v1, const void *v2, const void *v3,=
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
+        const uint##BITS##_t b =3D s390_vec_read_element##BITS(v3, i);  =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, rol##BITS(a, b));           =
       \
+    }                                                                   =
       \
+}
+DEF_VERLLV(8)
+DEF_VERLLV(16)
+
+#define DEF_VERLL(BITS)                                                 =
       \
+void HELPER(gvec_verll##BITS)(void *v1, const void *v2, uint64_t count, =
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
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, rol##BITS(a, count));       =
       \
+    }                                                                   =
       \
+}
+DEF_VERLL(8)
+DEF_VERLL(16)
--=20
2.20.1


