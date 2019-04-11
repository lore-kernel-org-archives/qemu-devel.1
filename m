Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0641FC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAECF2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAECF2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45976 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEX8k-0000v5-TA
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:41:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsS-000390-D9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWeM-0007Wi-G5
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hEWeM-0007WJ-2h; Thu, 11 Apr 2019 06:09:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6165030BB366;
	Thu, 11 Apr 2019 10:09:41 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 11A571001E82;
	Thu, 11 Apr 2019 10:09:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:08:21 +0200
Message-Id: <20190411100836.646-27-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 11 Apr 2019 10:09:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 26/41] s390x/tcg: Implement VECTOR
 POPULATION COUNT
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
Message-ID: <20190411100821.q9ZM5nAVi1MItyjSSBQExYw124GPVyiUXp3jljD0leM@z>

Similar to VECTOR COUNT TRAILING ZEROES.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 19 +++++++++++++++++++
 target/s390x/vec_int_helper.c   | 14 ++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index a44cc462ae..a306378950 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -200,6 +200,8 @@ DEF_HELPER_FLAGS_4(gvec_vmo32, TCG_CALL_NO_RWG, void,=
 ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vmlo8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
 DEF_HELPER_FLAGS_4(gvec_vmlo16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
 DEF_HELPER_FLAGS_4(gvec_vmlo32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, =
i32)
+DEF_HELPER_FLAGS_3(gvec_vpopct8, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
+DEF_HELPER_FLAGS_3(gvec_vpopct16, TCG_CALL_NO_RWG, void, ptr, cptr, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 52171252be..0f786d6ab1 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1144,6 +1144,8 @@
     F(0xe76a, VO,      VRR_c, V,   0, 0, 0, 0, vo, 0, IF_VEC)
 /* VECTOR OR WITH COMPLEMENT */
     F(0xe76f, VOC,     VRR_c, VE,  0, 0, 0, 0, voc, 0, IF_VEC)
+/* VECTOR POPULATION COUNT */
+    F(0xe750, VPOPCT,  VRR_a, V,   0, 0, 0, 0, vpopct, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 08ebc7fc4c..df17b8242d 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -1824,3 +1824,22 @@ static DisasJumpType op_voc(DisasContext *s, Disas=
Ops *o)
                   get_field(s->fields, v3));
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vpopct(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es =3D get_field(s->fields, m3);
+    static const GVecGen2 g[4] =3D {
+        { .fno =3D gen_helper_gvec_vpopct8, },
+        { .fno =3D gen_helper_gvec_vpopct16, },
+        { .fni4 =3D tcg_gen_ctpop_i32, },
+        { .fni8 =3D tcg_gen_ctpop_i64, },
+    };
+
+    if (es > ES_64 || (es !=3D ES_8 && !s390_has_feat(S390_FEAT_VECTOR_E=
NH))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec_2(get_field(s->fields, v1), get_field(s->fields, v2), &g[es=
]);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index b818c513a9..f49d5c2ffb 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -526,3 +526,17 @@ void HELPER(gvec_vmlo##BITS)(void *v1, const void *v=
2, const void *v3,         \
 DEF_VMLO(8, 16)
 DEF_VMLO(16, 32)
 DEF_VMLO(32, 64)
+
+#define DEF_VPOPCT(BITS)                                                =
       \
+void HELPER(gvec_vpopct##BITS)(void *v1, const void *v2, uint32_t desc) =
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
+        s390_vec_write_element##BITS(v1, i, ctpop32(a));                =
       \
+    }                                                                   =
       \
+}
+DEF_VPOPCT(8)
+DEF_VPOPCT(16)
--=20
2.20.1


