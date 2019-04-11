Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48AAC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19392084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19392084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEX51-0006CR-OO
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:37:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWsJ-0002Xe-FI
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWeU-0007Zq-Gs
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:09:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hEWeU-0007ZQ-5a; Thu, 11 Apr 2019 06:09:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75DAB3082128;
	Thu, 11 Apr 2019 10:09:49 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 29C681001E71;
	Thu, 11 Apr 2019 10:09:48 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:08:26 +0200
Message-Id: <20190411100836.646-32-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 11 Apr 2019 10:09:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 31/41] s390x/tcg: Implement VECTOR SHIFT
 LEFT DOUBLE BY BYTE
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
Message-ID: <20190411100826.EMOFRwU7I1uppUdS7L6Iapri-HtCML5n5L78aVMkWg8@z>

Implement it via an ool helper. reusing the existing shift helpers.
In case the starting index is 0, it is basically a copy of v2 to v1.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 15 +++++++++++++++
 target/s390x/vec_int_helper.c   | 20 ++++++++++++++++++++
 4 files changed, 38 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 67037f6de6..a433f57009 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -227,6 +227,7 @@ DEF_HELPER_FLAGS_4(gvec_vesra16, TCG_CALL_NO_RWG, voi=
d, ptr, cptr, i64, i32)
 DEF_HELPER_FLAGS_4(gvec_vesrl8, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i=
32)
 DEF_HELPER_FLAGS_4(gvec_vesrl16, TCG_CALL_NO_RWG, void, ptr, cptr, i64, =
i32)
 DEF_HELPER_FLAGS_4(gvec_vsl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
+DEF_HELPER_FLAGS_4(gvec_vsldb, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i=
32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 2621e433cd..76aec5a21f 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1164,6 +1164,8 @@
     F(0xe774, VSL,     VRR_c, V,   0, 0, 0, 0, vsl, 0, IF_VEC)
 /* VECTOR SHIFT LEFT BY BYTE */
     F(0xe775, VSLB,    VRR_c, V,   0, 0, 0, 0, vsl, 0, IF_VEC)
+/* VECTOR SHIFT LEFT DOUBLE BY BYTE */
+    F(0xe777, VSLDB,   VRI_d, V,   0, 0, 0, 0, vsldb, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index c08710fd45..221b729ee0 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2089,3 +2089,18 @@ static DisasJumpType op_vsl(DisasContext *s, Disas=
Ops *o)
     tcg_temp_free_i64(shift);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vsldb(DisasContext *s, DisasOps *o)
+{
+    int src_idx =3D get_field(s->fields, i4) & 0xf;
+
+    if (src_idx =3D=3D 0) {
+        gen_gvec_mov(get_field(s->fields, v1), get_field(s->fields, v2))=
;
+    } else {
+        gen_gvec_3_ool(get_field(s->fields, v1), get_field(s->fields, v2=
),
+                       get_field(s->fields, v3), src_idx,
+                       gen_helper_gvec_vsldb);
+        return DISAS_NEXT;
+    }
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index b1a3a25f9f..8b922e717f 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -43,6 +43,13 @@ static bool s390_vec_is_zero(const S390Vector *v)
     return !v->doubleword[0] && !v->doubleword[1];
 }
=20
+static void s390_vec_or(S390Vector *res, const S390Vector *a,
+                        const S390Vector *b)
+{
+    res->doubleword[0] =3D a->doubleword[0] | b->doubleword[0];
+    res->doubleword[1] =3D a->doubleword[1] | b->doubleword[1];
+}
+
 static void s390_vec_xor(S390Vector *res, const S390Vector *a,
                          const S390Vector *b)
 {
@@ -704,3 +711,16 @@ void HELPER(gvec_vsl)(void *v1, const void *v2, uint=
64_t count,
 {
     s390_vec_shl(v1, v2, count);
 }
+
+void HELPER(gvec_vsldb)(void *v1, const void *v2, const void *v3,
+                        uint32_t desc)
+{
+    const uint8_t src_idx =3D simd_data(desc);
+    S390Vector t0;
+    S390Vector t1;
+
+    g_assert(src_idx > 0 && src_idx < 16);
+    s390_vec_shl(&t0, v2, src_idx * 8);
+    s390_vec_shr(&t1, v3, 128 - src_idx * 8);
+    s390_vec_or(v1, &t0, &t1);
+}
--=20
2.20.1


