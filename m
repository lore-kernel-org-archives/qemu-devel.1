Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC49C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0B32133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 10:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0B32133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEWu5-0004R9-RJ
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 06:25:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWs8-0002dl-NG
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hEWf0-0007oi-En
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 06:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hEWf0-0007oS-3v; Thu, 11 Apr 2019 06:10:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62D663091740;
	Thu, 11 Apr 2019 10:10:21 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0D8E21001E71;
	Thu, 11 Apr 2019 10:10:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 12:08:36 +0200
Message-Id: <20190411100836.646-42-david@redhat.com>
In-Reply-To: <20190411100836.646-1-david@redhat.com>
References: <20190411100836.646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 11 Apr 2019 10:10:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 41/41] s390x/tcg: Implement VECTOR TEST
 UNDER MASK
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
Message-ID: <20190411100836.MypdY7s9d9a5d-2ClHGhUyPbFbCE3a18RxH_R4DaO0M@z>

Let's return the cc value directly via cpu_env. Unfortunately there
isn't a simple way to calculate the value lazily - one would have to
calculate and store e.g. the population count of the mask and the
result so it can be evaluated in a cc helper.

But as VTM only sets the cc, we can assume the value will be needed soon
either way.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  1 +
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c | 11 +++++++++++
 target/s390x/vec_int_helper.c   | 18 ++++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index d040e4cd07..200d1730f4 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -234,6 +234,7 @@ DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, void=
, ptr, cptr, cptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr,=
 i32)
 DEF_HELPER_FLAGS_4(gvec_vscbi128, TCG_CALL_NO_RWG, void, ptr, cptr, cptr=
, i32)
 DEF_HELPER_FLAGS_5(gvec_vsbcbi128, TCG_CALL_NO_RWG, void, ptr, cptr, cpt=
r, cptr, i32)
+DEF_HELPER_4(gvec_vtm, void, ptr, cptr, env, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index a52db41388..e61475bdc4 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1188,6 +1188,8 @@
     F(0xe767, VSUMQ,   VRR_c, V,   0, 0, 0, 0, vsumq, 0, IF_VEC)
 /* VECTOR SUM ACROSS WORD */
     F(0xe764, VSUM,    VRR_c, V,   0, 0, 0, 0, vsum, 0, IF_VEC)
+/* VECTOR TEST UNDER MASK */
+    F(0xe7d8, VTM,     VRR_a, V,   0, 0, 0, 0, vtm, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 59a9885892..eacf68ec28 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -191,6 +191,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uin=
t8_t reg, TCGv_i64 enr,
 #define gen_gvec_2i_ool(v1, v2, c, data, fn) \
     tcg_gen_gvec_2i_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2)=
, \
                         c, 16, 16, data, fn)
+#define gen_gvec_2_ptr(v1, v2, ptr, data, fn) \
+    tcg_gen_gvec_2_ptr(vec_full_reg_offset(v1), vec_full_reg_offset(v2),=
 \
+                       ptr, 16, 16, data, fn)
 #define gen_gvec_3(v1, v2, v3, gen) \
     tcg_gen_gvec_3(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                    vec_full_reg_offset(v3), 16, 16, gen)
@@ -2315,3 +2318,11 @@ static DisasJumpType op_vsum(DisasContext *s, Disa=
sOps *o)
     tcg_temp_free_i32(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vtm(DisasContext *s, DisasOps *o)
+{
+    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
+                   cpu_env, 0, gen_helper_gvec_vtm);
+    set_cc_static(s);
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.=
c
index 95686e79fd..f5bdaff633 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -819,3 +819,21 @@ void HELPER(gvec_vsbcbi128)(void *v1, const void *v2=
, const void *v3,
     dst->doubleword[0] =3D 0;
     dst->doubleword[1] =3D borrow;
 }
+
+void HELPER(gvec_vtm)(void *v1, const void *v2, CPUS390XState *env,
+                      uint32_t desc)
+{
+    S390Vector tmp;
+
+    s390_vec_and(&tmp, v1, v2);
+    if (s390_vec_is_zero(&tmp)) {
+        /* Selected bits all zeros; or all mask bits zero */
+        env->cc_op =3D 0;
+    } else if (s390_vec_equal(&tmp, v2)) {
+        /* Selected bits all ones */
+        env->cc_op =3D 3;
+    } else {
+        /* Selected bits a mix of zeros and ones */
+        env->cc_op =3D 1;
+    }
+}
--=20
2.20.1


