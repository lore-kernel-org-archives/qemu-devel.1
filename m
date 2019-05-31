Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC6FC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CF0267E3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 10:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CF0267E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40997 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWfG8-0001x7-7A
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 06:59:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf1x-000760-BS
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWf1w-0001cd-B8
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:45:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hWf1w-0001ac-42
	for qemu-devel@nongnu.org; Fri, 31 May 2019 06:45:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 741EE3688E;
	Fri, 31 May 2019 10:44:59 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-233.ams2.redhat.com [10.36.116.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3AE23473DB;
	Fri, 31 May 2019 10:44:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 12:44:21 +0200
Message-Id: <20190531104432.29379-13-david@redhat.com>
In-Reply-To: <20190531104432.29379-1-david@redhat.com>
References: <20190531104432.29379-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 31 May 2019 10:44:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 12/23] s390x/tcg: Implement VECTOR LOAD FP
 INTEGER
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

We can reuse most of the infrastructure introduced for
VECTOR FP CONVERT FROM FIXED 64-BIT and friends.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c |  3 +++
 target/s390x/vec_fpu_helper.c   | 23 +++++++++++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 238bfa2509..10a9cb39b6 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -276,6 +276,8 @@ DEF_HELPER_FLAGS_4(gvec_vclgd64, TCG_CALL_NO_WG, void=
, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vclgd64s, TCG_CALL_NO_WG, void, ptr, cptr, env, =
i32)
 DEF_HELPER_FLAGS_5(gvec_vfd64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, en=
v, i32)
 DEF_HELPER_FLAGS_5(gvec_vfd64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
+DEF_HELPER_FLAGS_4(gvec_vfi64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32=
)
+DEF_HELPER_FLAGS_4(gvec_vfi64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i3=
2)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f9830deace..f77aa41253 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1228,6 +1228,8 @@
     F(0xe7c0, VCLGD,   VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
 /* VECTOR FP DIVIDE */
     F(0xe7e5, VFD,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
+/* VECTOR LOAD FP INTEGER */
+    F(0xe7c7, VFI,     VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 9e55d4488b..59d8b971c0 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2669,6 +2669,9 @@ static DisasJumpType op_vcdg(DisasContext *s, Disas=
Ops *o)
     case 0xc0:
         fn =3D se ? gen_helper_gvec_vclgd64s : gen_helper_gvec_vclgd64;
         break;
+    case 0xc7:
+        fn =3D se ? gen_helper_gvec_vfi64s : gen_helper_gvec_vfi64;
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index 2c085a8849..63ba4cf548 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -389,3 +389,26 @@ void HELPER(gvec_vfd64s)(void *v1, const void *v2, c=
onst void *v3,
 {
     vop64_3(v1, v2, v3, env, true, vfd64, GETPC());
 }
+
+static uint64_t vfi64(uint64_t a, float_status *s)
+{
+    return float64_val(float64_round_to_int(make_float64(a), s));
+}
+
+void HELPER(gvec_vfi64)(void *v1, const void *v2, CPUS390XState *env,
+                        uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vop64_2(v1, v2, env, false, XxC, erm, vfi64, GETPC());
+}
+
+void HELPER(gvec_vfi64s)(void *v1, const void *v2, CPUS390XState *env,
+                         uint32_t desc)
+{
+    const uint8_t erm =3D extract32(simd_data(desc), 4, 4);
+    const bool XxC =3D extract32(simd_data(desc), 2, 1);
+
+    vop64_2(v1, v2, env, true, XxC, erm, vfi64, GETPC());
+}
--=20
2.20.1


