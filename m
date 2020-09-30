Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141F5C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DB120657
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkC+1aGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DB120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdmI-000396-K8
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWj-0004p4-CP
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWh-0004d0-FQ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6YFaVC1Nt7vvSQuV0+LErF2z1b29w6iTJNrcyQb5N88=;
 b=VkC+1aGzGmAP+mS+RyjSdyT9bwEOgkTffJ0QikwXGNBRH7NuQS++5b5ceNGoNQ58imMhNv
 D40E3g1kX2lx06jD8EDpKQuWQ448XGqEpBS21a4HE7TIGxiudkak6W70MWdoGthGGhlDwJ
 XBAwXJbYzkZNd4UkQj09MypTZmuUAps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-9Fkh9By1NniV_VrtJZwwHA-1; Wed, 30 Sep 2020 10:56:12 -0400
X-MC-Unique: 9Fkh9By1NniV_VrtJZwwHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87294802B68;
 Wed, 30 Sep 2020 14:56:11 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D91AF5C1C4;
 Wed, 30 Sep 2020 14:56:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 17/20] s390x/tcg: Implement VECTOR FP NEGATIVE MULTIPLY AND
 (ADD|SUBTRACT)
Date: Wed, 30 Sep 2020 16:55:20 +0200
Message-Id: <20200930145523.71087-18-david@redhat.com>
In-Reply-To: <20200930145523.71087-1-david@redhat.com>
References: <20200930145523.71087-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           | 10 ++++++++
 target/s390x/insn-data.def      |  4 +++
 target/s390x/translate_vx.c.inc | 26 +++++++++++++++++++
 target/s390x/vec_fpu_helper.c   | 45 +++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index e4d60299dc..6b4a6c5185 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -327,6 +327,16 @@ DEF_HELPER_FLAGS_6(gvec_vfms32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, en
 DEF_HELPER_FLAGS_6(gvec_vfms64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfms64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfms128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfnma32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfnma32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfnma64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfnma64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfnma128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfnms32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfnms32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfnms64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfnms64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_6(gvec_vfnms128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfsq32, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfsq32s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfsq64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index da7fe6f21c..082de27298 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1259,6 +1259,10 @@
     F(0xe78f, VFMA,    VRR_e, V,   0, 0, 0, 0, vfma, 0, IF_VEC)
 /* VECTOR FP MULTIPLY AND SUBTRACT */
     F(0xe78e, VFMS,    VRR_e, V,   0, 0, 0, 0, vfma, 0, IF_VEC)
+/* VECTOR FP NEGATIVE MULTIPLY AND ADD */
+    F(0xe79f, VFNMA,   VRR_e, VE,  0, 0, 0, 0, vfma, 0, IF_VEC)
+/* VECTOR FP NEGATIVE MULTIPLY AND SUBTRACT */
+    F(0xe79e, VFNMS,   VRR_e, VE,   0, 0, 0, 0, vfma, 0, IF_VEC)
 /* VECTOR FP PERFORM SIGN OPERATION */
     F(0xe7cc, VFPSO,   VRR_a, V,   0, 0, 0, 0, vfpso, 0, IF_VEC)
 /* VECTOR FP SQUARE ROOT */
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index 5d31498cc1..40e452f552 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2884,6 +2884,32 @@ static DisasJumpType op_vfma(DisasContext *s, DisasOps *o)
             break;
         }
         break;
+    case 0x9f:
+        switch (fpf) {
+        case FPF_SHORT:
+            fn = se ? gen_helper_gvec_vfnma32s : gen_helper_gvec_vfnma32;
+            break;
+        case FPF_LONG:
+            fn = se ? gen_helper_gvec_vfnma64s : gen_helper_gvec_vfnma64;
+            break;
+        default:
+            fn = gen_helper_gvec_vfnma128;
+            break;
+        }
+        break;
+    case 0x9e:
+        switch (fpf) {
+        case FPF_SHORT:
+            fn = se ? gen_helper_gvec_vfnms32s : gen_helper_gvec_vfnms32;
+            break;
+        case FPF_LONG:
+            fn = se ? gen_helper_gvec_vfnms64s : gen_helper_gvec_vfnms64;
+            break;
+        default:
+            fn = gen_helper_gvec_vfnms128;
+            break;
+        }
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index 0b25718365..92858c8c59 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -769,6 +769,51 @@ void HELPER(gvec_vfms##BITS##s)(void *v1, const void *v2, const void *v3,      \
 DEF_GVEC_VFMS_S(32)
 DEF_GVEC_VFMS_S(64)
 
+#define DEF_GVEC_VFNMA(BITS)                                                   \
+void HELPER(gvec_vfnma##BITS)(void *v1, const void *v2, const void *v3,        \
+                              const void *v4, CPUS390XState *env,              \
+                              uint32_t desc)                                   \
+{                                                                              \
+    vfma##BITS(v1, v2, v3, v4, env, false, float_muladd_negate_result,         \
+               GETPC());                                                       \
+}
+DEF_GVEC_VFNMA(32)
+DEF_GVEC_VFNMA(64)
+DEF_GVEC_VFNMA(128)
+
+#define DEF_GVEC_VFNMA_S(BITS)                                                 \
+void HELPER(gvec_vfnma##BITS##s)(void *v1, const void *v2, const void *v3,     \
+                                 const void *v4, CPUS390XState *env,           \
+                                 uint32_t desc)                                \
+{                                                                              \
+    vfma##BITS(v1, v2, v3, v4, env, true, float_muladd_negate_result, GETPC());\
+}
+DEF_GVEC_VFNMA_S(32)
+DEF_GVEC_VFNMA_S(64)
+
+#define DEF_GVEC_VFNMS(BITS)                                                   \
+void HELPER(gvec_vfnms##BITS)(void *v1, const void *v2, const void *v3,        \
+                              const void *v4, CPUS390XState *env,              \
+                              uint32_t desc)                                   \
+{                                                                              \
+    vfma##BITS(v1, v2, v3, v4, env, false,                                     \
+               float_muladd_negate_c | float_muladd_negate_result, GETPC());   \
+}
+DEF_GVEC_VFNMS(32)
+DEF_GVEC_VFNMS(64)
+DEF_GVEC_VFNMS(128)
+
+#define DEF_GVEC_VFNMS_S(BITS)                                                 \
+void HELPER(gvec_vfnms##BITS##s)(void *v1, const void *v2, const void *v3,     \
+                                 const void *v4, CPUS390XState *env,           \
+                                 uint32_t desc)                                \
+{                                                                              \
+    vfma##BITS(v1, v2, v3, v4, env, true,                                      \
+               float_muladd_negate_c | float_muladd_negate_result, GETPC());   \
+}
+DEF_GVEC_VFNMS_S(32)
+DEF_GVEC_VFNMS_S(64)
+
 #define DEF_GVEC_VFSQ(BITS)                                                    \
 void HELPER(gvec_vfsq##BITS)(void *v1, const void *v2, CPUS390XState *env,     \
                              uint32_t desc)                                    \
-- 
2.26.2


