Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1A5C28CC7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E7327E2B
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E7327E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60025 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXiyd-0006yw-19
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:09:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXivy-0004Zx-CQ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hXivx-0002oM-9G
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:07:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hXivx-0002nR-1k; Mon, 03 Jun 2019 05:07:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57AC03086228;
	Mon,  3 Jun 2019 09:07:12 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.117.0])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5F6B061981;
	Mon,  3 Jun 2019 09:07:10 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 11:06:24 +0200
Message-Id: <20190603090635.10631-12-david@redhat.com>
In-Reply-To: <20190603090635.10631-1-david@redhat.com>
References: <20190603090635.10631-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 03 Jun 2019 09:07:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 11/22] s390x/tcg: Implement VECTOR FP DIVIDE
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
Cc: Thomas Huth <thuth@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Pino Toscano <ptoscano@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can reuse most of the infrastructure added for VECTOR FP ADD.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  2 ++
 target/s390x/insn-data.def      |  2 ++
 target/s390x/translate_vx.inc.c |  3 +++
 target/s390x/vec_fpu_helper.c   | 17 +++++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 9b9062970a..238bfa2509 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -274,6 +274,8 @@ DEF_HELPER_FLAGS_4(gvec_vcgd64, TCG_CALL_NO_WG, void,=
 ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vcgd64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
 DEF_HELPER_FLAGS_4(gvec_vclgd64, TCG_CALL_NO_WG, void, ptr, cptr, env, i=
32)
 DEF_HELPER_FLAGS_4(gvec_vclgd64s, TCG_CALL_NO_WG, void, ptr, cptr, env, =
i32)
+DEF_HELPER_FLAGS_5(gvec_vfd64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, en=
v, i32)
+DEF_HELPER_FLAGS_5(gvec_vfd64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, e=
nv, i32)
=20
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index ed8b888d59..f9830deace 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1226,6 +1226,8 @@
     F(0xe7c2, VCGD,    VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
 /* VECTOR FP CONVERT TO LOGICAL 64-BIT */
     F(0xe7c0, VCLGD,   VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
+/* VECTOR FP DIVIDE */
+    F(0xe7e5, VFD,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
=20
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.=
inc.c
index 0395d69968..9e55d4488b 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -2560,6 +2560,9 @@ static DisasJumpType op_vfa(DisasContext *s, DisasO=
ps *o)
     case 0xe3:
         fn =3D se ? gen_helper_gvec_vfa64s : gen_helper_gvec_vfa64;
         break;
+    case 0xe5:
+        fn =3D se ? gen_helper_gvec_vfd64s : gen_helper_gvec_vfd64;
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.=
c
index 09ef0abfb0..3c62eb5787 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -369,3 +369,20 @@ void HELPER(gvec_vclgd64s)(void *v1, const void *v2,=
 CPUS390XState *env,
=20
     vop64_2(v1, v2, env, true, XxC, erm, vclgd64, GETPC());
 }
+
+static uint64_t vfd64(uint64_t a, uint64_t b, float_status *s)
+{
+    return float64_div(a, b, s);
+}
+
+void HELPER(gvec_vfd64)(void *v1, const void *v2, const void *v3,
+                        CPUS390XState *env, uint32_t desc)
+{
+    vop64_3(v1, v2, v3, env, false, vfd64, GETPC());
+}
+
+void HELPER(gvec_vfd64s)(void *v1, const void *v2, const void *v3,
+                         CPUS390XState *env, uint32_t desc)
+{
+    vop64_3(v1, v2, v3, env, true, vfd64, GETPC());
+}
--=20
2.21.0


