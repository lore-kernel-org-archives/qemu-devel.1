Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C752C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123F32184E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123F32184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWys-0000Vl-5P
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:30:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsD-0002dl-Cu
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWed-0007dN-BN
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:10:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hEWec-0007d1-VG; Thu, 11 Apr 2019 06:09:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44ADF70D6A;
	Thu, 11 Apr 2019 10:09:58 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9BEAA1001E71;
	Thu, 11 Apr 2019 10:09:54 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:08:30 +0200
Message-Id: <20190411100836.646-36-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 11 Apr 2019 10:09:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 35/41] s390x/tcg: Implement VECTOR SUBTRACT
 COMPUTE BORROW INDICATION
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411100830.NTyUNUaz2ufaBwi8rV1FKNlsRWrZkJvxcD7pnl35gBU@z>

Let's keep it simple for now and handle 8/16/128 bit elements via helpers=
.
Especially for 8/16, we could come up with some bit tricks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  3 +++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 30 +++++++++++++++++++++
 target/s390x/vec_int_helper.c   | 47 +++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index af7fb10f76..33e3e003f8 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -230,6 +230,9 @@ DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, p=
tr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_vsldb, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
 DEF_HELPER_FLAGS_4(gvec_vsra, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32=
)
 DEF_HELPER_FLAGS_4(gvec_vsrl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32=
)
+DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
+DEF_HELPER_FLAGS_4(gvec_vscbi128, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 58a61f41ef..94de3c9c7d 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1176,6 +1176,8 @@
     F(0xe77d, VSRLB,   VRR_c, V,   0, 0, 0, 0, vsrl, 0, IF_VEC)
 /* VECTOR SUBTRACT */
     F(0xe7f7, VS,      VRR_c, V,   0, 0, 0, 0, vs, 0, IF_VEC)
+/* VECTOR SUBTRACT COMPUTE BORROW INDICATION */
+    F(0xe7f5, VSCBI,   VRR_c, V,   0, 0, 0, 0, vscbi, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 83463155f6..7770ca4101 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2155,3 +2155,33 @@ static DisasJumpType op_vs(DisasContext *s, DisasO=
ps *o)
                   get_field(s->fields, v3));
     return DISAS_NEXT;
 }
+
+static void gen_scbi_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_setcond_i32(TCG_COND_LTU, d, a, b);
+}
+
+static void gen_scbi_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_setcond_i64(TCG_COND_LTU, d, a, b);
+}
+
+static DisasJumpType op_vscbi(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m4);
+    static const GVecGen3 g[5] =3D {
+        { .fno =3D gen_helper_gvec_vscbi8, },
+        { .fno =3D gen_helper_gvec_vscbi16, },
+        { .fni4 =3D gen_scbi_i32, },
+        { .fni8 =3D gen_scbi_i64, },
+        { .fno =3D gen_helper_gvec_vscbi128, },
+    };
+
+    if (es > ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+    gen_gvec_3(get_field(s->fields, v1), get_field(s->fields, v2),
+               get_field(s->fields, v3), &g[es]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 12502b48e8..699b399a26 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -38,6 +38,27 @@ static bool s390_vec_add(S390Vector *d, const S390Vect=
or *a,
     return high_carry;
 }
=20
+/*
+ * Subtract two 128 bit vectors, returning the borrow.
+ */
+static bool s390_vec_sub(S390Vector *d, const S390Vector *a,
+                         const S390Vector *b)
+{
+    bool low_borrow =3D false, high_borrow =3D false;
+
+    if (a->doubleword[0] < b->doubleword[0]) {
+        high_borrow =3D true;
+    } else if (a->doubleword[1] < b->doubleword[0]) {
+        low_borrow =3D true;
+        if (a->doubleword[0] =3D=3D b->doubleword[0]) {
+            high_borrow =3D true;
+        }
+    }
+    d->doubleword[0] =3D a->doubleword[0] - b->doubleword[0] - low_borro=
w;
+    d->doubleword[1] =3D a->doubleword[1] - b->doubleword[1];
+    return high_borrow;
+}
+
 static bool s390_vec_is_zero(const S390Vector *v)
 {
     return !v->doubleword[0] && !v->doubleword[1];
@@ -756,3 +777,29 @@ void HELPER(gvec_vsrl)(void *v1, const void *v2, uin=
t64_t count,
 {
     s390_vec_shr(v1, v2, count);
 }
+
+#define DEF_VSCBI(BITS)                                                 =
       \
+void HELPER(gvec_vscbi##BITS)(void *v1, const void *v2, const void *v3, =
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
+        const uint##BITS##_t b =3D s390_vec_read_element##BITS(v3, i);  =
         \
+                                                                        =
       \
+        s390_vec_write_element##BITS(v1, i, a < b);                     =
       \
+    }                                                                   =
       \
+}
+DEF_VSCBI(8)
+DEF_VSCBI(16)
+
+void HELPER(gvec_vscbi128)(void *v1, const void *v2, const void *v3,
+                           uint32_t desc)
+{
+    S390Vector *dst =3D v1;
+    S390Vector tmp;
+
+    dst->doubleword[0] =3D 0;
+    dst->doubleword[1] =3D s390_vec_sub(&tmp, v2, v3);
+}
--=20
2.20.1


