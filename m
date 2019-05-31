Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A25C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64613267BF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64613267BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40913 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWfA9-0005G8-HF
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 06:53:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf1p-0006sT-Bc
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf1n-0001QL-Sf
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hWf1n-0001Ne-Hv
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:44:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD763317917C;
	Fri, 31 May 2019 10:44:50 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-233.ams2.redhat.com [10.36.116.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BDEF9473DB;
	Fri, 31 May 2019 10:44:49 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 12:44:18 +0200
Message-Id: <20190531104432.29379-10-david@redhat.com>
In-Reply-To: <20190531104432.29379-1-david@redhat.com>
References: <20190531104432.29379-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 31 May 2019 10:44:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 09/23] s390x/tcg: Implement VECTOR FP
 CONVERT TO FIXED 64-BIT
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c |  3 +++
 target/s390x/vec_fpu_helper.c   | 23 +++++++++++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6fd996e924..9893c677da 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -270,6 +270,8 @@ DEF_HELPER_FLAGS_4(gvec_vcdg64, TCG_CALL_NO_WG, void,=
 ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vcdg64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
 DEF_HELPER_FLAGS_4(gvec_vcdlg64, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
 DEF_HELPER_FLAGS_4(gvec_vcdlg64s, TCG_CALL_NO_WG, void, ptr, cptr, env, =
i32)
+DEF_HELPER_FLAGS_4(gvec_vcgd64, TCG_CALL_NO_WG, void, ptr, cptr, env, i3=
2)
+DEF_HELPER_FLAGS_4(gvec_vcgd64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 465b36dd70..97c62a8af5 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1222,6 +1222,8 @@
     F(0xe7c3, VCDG,    VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
 /* VECTOR FP CONVERT FROM LOGICAL 64-BIT */
     F(0xe7c1, VCDLG,   VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
+/* VECTOR FP CONVERT TO FIXED 64-BIT */
+    F(0xe7c2, VCGD,    VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index fa755cd1d6..a42de2ff01 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2660,6 +2660,9 @@ static DisasJumpType op_vcdg(DisasContext *s, Disas=
Ops *o)
     case 0xc1:
         fn =3D se ? gen_helper_gvec_vcdlg64s : gen_helper_gvec_vcdlg64;
         break;
+    case 0xc2:
+        fn =3D se ? gen_helper_gvec_vcgd64s : gen_helper_gvec_vcgd64;
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index 8f7dac0439..e1a797ecca 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -326,3 +326,26 @@ void HELPER(gvec_vcdlg64s)(void *v1, const void *v2,=
 CPUS390XState *env,
=20
     vop64_2(v1, v2, env, true, XxC, erm, vcdlg64, GETPC());
 }
+
+static uint64_t vcgd64(uint64_t a, float_status *s)
+{
+    return float64_to_int64(make_float64(a), s);
+}
+
+void HELPER(gvec_vcgd64)(void *v1, const void *v2, CPUS390XState *env,
+                         uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vop64_2(v1, v2, env, false, XxC, erm, vcgd64, GETPC());
+}
+
+void HELPER(gvec_vcgd64s)(void *v1, const void *v2, CPUS390XState *env,
+                          uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vop64_2(v1, v2, env, true, XxC, erm, vcgd64, GETPC());
+}
--=20
2.20.1


