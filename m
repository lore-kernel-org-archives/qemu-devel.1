Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49CDCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D5B205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D5B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUya-0007Ug-PD
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iLUqJ-0007WN-9s
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iLUqE-0007UZ-CA
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:11:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iLUqD-0007Su-AB; Fri, 18 Oct 2019 12:11:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 37FEEC0495A1;
 Fri, 18 Oct 2019 16:10:59 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF6CE3CC8;
 Fri, 18 Oct 2019 16:10:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/6] s390x/tcg: Fix VECTOR SUBTRACT COMPUTE BORROW
 INDICATION
Date: Fri, 18 Oct 2019 18:10:42 +0200
Message-Id: <20191018161044.6983-5-david@redhat.com>
In-Reply-To: <20191018161044.6983-1-david@redhat.com>
References: <20191018161044.6983-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 18 Oct 2019 16:10:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ivan Warren <ivan@vmfacility.fr>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks like my idea of what a "borrow" is was wrong. We are dealing with
unsigned numbers. A subtraction is simply an addition with the bitwise
complement. If we get a carry during the addition, that's the borrow.
"The operands are treated as unsigned binary integers."

This is nice, as we can reuse the VECTOR ADD COMPUTE CARRY functions
and avoid helpers, all we have to do is compute the bitwise complement.

Fixes: 1ee2d7ba72f6 ("s390x/tcg: Implement VECTOR SUBTRACT COMPUTE BORROW=
 INDICATION")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 --
 target/s390x/translate_vx.inc.c | 45 ++++++++++++++++++++++++---------
 target/s390x/vec_int_helper.c   | 16 ------------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 56e8149866..ca1e08100a 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -207,8 +207,6 @@ DEF_HELPER_FLAGS_4(gvec_verim16, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_vsra, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32=
)
 DEF_HELPER_FLAGS_4(gvec_vsrl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32=
)
-DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
-DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
 DEF_HELPER_4(gvec_vtm, void, ptr, cptr, env, i32)
=20
 /* =3D=3D=3D Vector String Instructions =3D=3D=3D */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 5ce7bfb0af..40bcc1604e 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2130,14 +2130,40 @@ static DisasJumpType op_vs(DisasContext *s, Disas=
Ops *o)
     return DISAS_NEXT;
 }
=20
+static void gen_scbi8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t =3D tcg_temp_new_i64();
+
+    tcg_gen_not_i64(t, b);
+    gen_acc(d, a, t, ES_8);
+    tcg_temp_free_i64(t);
+}
+
+static void gen_scbi16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t =3D tcg_temp_new_i64();
+
+    tcg_gen_not_i64(t, b);
+    gen_acc(d, a, t, ES_16);
+    tcg_temp_free_i64(t);
+}
+
 static void gen_scbi_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
-    tcg_gen_setcond_i32(TCG_COND_LTU, d, a, b);
+    TCGv_i32 t =3D tcg_temp_new_i32();
+
+    tcg_gen_not_i32(t, b);
+    gen_acc_i32(d, a, t);
+    tcg_temp_free_i32(t);
 }
=20
 static void gen_scbi_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    tcg_gen_setcond_i64(TCG_COND_LTU, d, a, b);
+    TCGv_i64 t =3D tcg_temp_new_i64();
+
+    tcg_gen_not_i64(t, b);
+    gen_acc_i64(d, a, t);
+    tcg_temp_free_i64(t);
 }
=20
 static void gen_scbi2_i64(TCGv_i64 dl, TCGv_i64 dh, TCGv_i64 al,
@@ -2145,26 +2171,21 @@ static void gen_scbi2_i64(TCGv_i64 dl, TCGv_i64 d=
h, TCGv_i64 al,
 {
     TCGv_i64 th =3D tcg_temp_new_i64();
     TCGv_i64 tl =3D tcg_temp_new_i64();
-    TCGv_i64 zero =3D tcg_const_i64(0);
=20
-    tcg_gen_sub2_i64(tl, th, al, zero, bl, zero);
-    tcg_gen_andi_i64(th, th, 1);
-    tcg_gen_sub2_i64(tl, th, ah, zero, th, zero);
-    tcg_gen_sub2_i64(tl, th, tl, th, bh, zero);
-    tcg_gen_andi_i64(dl, th, 1);
-    tcg_gen_mov_i64(dh, zero);
+    tcg_gen_not_i64(tl, bl);
+    tcg_gen_not_i64(th, bh);
+    gen_acc2_i64(dl, dh, al, ah, tl, th);
=20
     tcg_temp_free_i64(th);
     tcg_temp_free_i64(tl);
-    tcg_temp_free_i64(zero);
 }
=20
 static DisasJumpType op_vscbi(DisasContext *s, DisasOps *o)
 {
     const uint8_t es =3D get_field(s->fields, m4);
     static const GVecGen3 g[4] =3D {
-        { .fno =3D gen_helper_gvec_vscbi8, },
-        { .fno =3D gen_helper_gvec_vscbi16, },
+        { .fni8 =3D gen_scbi8_i64, },
+        { .fni8 =3D gen_scbi16_i64, },
         { .fni4 =3D gen_scbi_i32, },
         { .fni8 =3D gen_scbi_i64, },
     };
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index d38405848f..e8fe7af496 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -583,22 +583,6 @@ void HELPER(gvec_vsrl)(void *v1, const void *v2, uin=
t64_t count,
     s390_vec_shr(v1, v2, count);
 }
=20
-#define DEF_VSCBI(BITS)                                                 =
       \
-void HELPER(gvec_vscbi##BITS)(void *v1, const void *v2, const void *v3, =
       \
-                              uint32_t desc)                            =
       \
-{                                                                       =
       \
-    int i;                                                              =
       \
-                                                                        =
       \
-    for (i =3D 0; i < (128 / BITS); i++) {                              =
         \
-        const uint##BITS##_t a =3D s390_vec_read_element##BITS(v2, i);  =
         \
-        const uint##BITS##_t b =3D s390_vec_read_element##BITS(v3, i);  =
         \
-                                                                        =
       \
-        s390_vec_write_element##BITS(v1, i, a < b);                     =
       \
-    }                                                                   =
       \
-}
-DEF_VSCBI(8)
-DEF_VSCBI(16)
-
 void HELPER(gvec_vtm)(void *v1, const void *v2, CPUS390XState *env,
                       uint32_t desc)
 {
--=20
2.21.0


