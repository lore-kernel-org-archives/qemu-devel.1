Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F902C282CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4332084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4332084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWzn-0001au-C0
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:31:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsB-0002Xe-T0
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWek-0007hl-0j
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:10:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hEWej-0007hZ-L8; Thu, 11 Apr 2019 06:10:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6298A77F;
	Thu, 11 Apr 2019 10:10:04 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DEA921001E71;
	Thu, 11 Apr 2019 10:10:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:08:32 +0200
Message-Id: <20190411100836.646-38-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 11 Apr 2019 10:10:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 37/41] s390x/tcg: Implement VECTOR SUBTRACT
 WITH BORROW COMPUTE BORROW INDICATION
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
Message-ID: <20190411100832.CeT3lGCDsRqjWdPHNUzWYoaXdKIxDSu_rWlaIGrn_bs@z>

Reuse s390_vec_sub() to perform two 128-bit subtraction, calculating the
borrow.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 13 +++++++++++++
 target/s390x/vec_int_helper.c   | 16 ++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 33e3e003f8..d040e4cd07 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -233,6 +233,7 @@ DEF_HELPER_FLAGS_4(gvec_vsrl, TCG_CALL_NO_RWG, void, =
ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
 DEF_HELPER_FLAGS_4(gvec_vscbi128, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
+DEF_HELPER_FLAGS_5(gvec_vsbcbi128, TCG_CALL_NO_RWG, void, ptr, cptr, cpt=
r, cptr, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a60d8531dc..a8d90517f6 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1180,6 +1180,8 @@
     F(0xe7f5, VSCBI,   VRR_c, V,   0, 0, 0, 0, vscbi, 0, IF_VEC)
 /* VECTOR SUBTRACT WITH BORROW INDICATION */
     F(0xe7bf, VSBI,    VRR_d, V,   0, 0, 0, 0, vsbi, 0, IF_VEC)
+/* VECTOR SUBTRACT WITH BORROW COMPUTE BORROW INDICATION */
+    F(0xe7bd, VSBCBI,  VRR_d, V,   0, 0, 0, 0, vsbcbi, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 3f60b97654..fd232ba6c3 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2212,3 +2212,16 @@ static DisasJumpType op_vsbi(DisasContext *s, Disa=
sOps *o)
                       get_field(s->fields, v4));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsbcbi(DisasContext *s, DisasOps *o)
+{
+    if (get_field(s->fields, m5) !=3D ES_128) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec_4_ool(get_field(s->fields, v1), get_field(s->fields, v2),
+                   get_field(s->fields, v3), get_field(s->fields, v4), 0=
,
+                   gen_helper_gvec_vsbcbi128);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 699b399a26..95686e79fd 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -803,3 +803,19 @@ void HELPER(gvec_vscbi128)(void *v1, const void *v2,=
 const void *v3,
     dst->doubleword[0] =3D 0;
     dst->doubleword[1] =3D s390_vec_sub(&tmp, v2, v3);
 }
+
+void HELPER(gvec_vsbcbi128)(void *v1, const void *v2, const void *v3,
+                            const void *v4, uint32_t desc)
+{
+    const S390Vector old_borrow =3D {
+        .doubleword[0] =3D 0,
+        .doubleword[1] =3D ((S390Vector *)v4)->doubleword[1] & 1,
+    };
+    S390Vector tmp, *dst =3D v1;
+    bool borrow;
+
+    borrow =3D s390_vec_sub(&tmp, v2, v3);
+    borrow |=3D s390_vec_sub(&tmp, &tmp, &old_borrow);
+    dst->doubleword[0] =3D 0;
+    dst->doubleword[1] =3D borrow;
+}
--=20
2.20.1


