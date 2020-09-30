Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B111CC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B35206FC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtROxFUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B35206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdfv-0004v8-78
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWg-0004iq-W5
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWe-0004cI-IM
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:14 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tqrz6vvOyDSCBuunJKKuWbLMvpvXJG8qPADR4RQyyHc=;
 b=PtROxFUpoh4zUNNwc1iVg4ItJqMF5WL6LH+ryVhQBvbr7iOCMIehQV52av63aqS9JJO1oJ
 HtvQmxVE1CXaxz6TV3tjkTuFIqNr7hnnZy6uMaG8omHDQhFHdjcbAprF5yDlIZ7tiqnJsi
 hzqPtosHNwtlsHHHg9JxDpQkwOIfRik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-sfObWyOTOUy4BSh2jeCHPg-1; Wed, 30 Sep 2020 10:56:08 -0400
X-MC-Unique: sfObWyOTOUy4BSh2jeCHPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 884691021203;
 Wed, 30 Sep 2020 14:56:07 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20AB95C1C4;
 Wed, 30 Sep 2020 14:56:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 15/20] s390x/tcg: Implement 32/128 bit for VECTOR FP TEST
 DATA CLASS IMMEDIATE
Date: Wed, 30 Sep 2020 16:55:18 +0200
Message-Id: <20200930145523.71087-16-david@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
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
 target/s390x/helper.h           |  3 ++
 target/s390x/translate_vx.c.inc | 26 ++++++++---
 target/s390x/vec_fpu_helper.c   | 76 +++++++++++++++++++--------------
 3 files changed, 69 insertions(+), 36 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index bee283e3d4..c2ded83669 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -331,8 +331,11 @@ DEF_HELPER_FLAGS_5(gvec_vfs32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfs64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfs64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfs128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_4(gvec_vftci32, void, ptr, cptr, env, i32)
+DEF_HELPER_4(gvec_vftci32s, void, ptr, cptr, env, i32)
 DEF_HELPER_4(gvec_vftci64, void, ptr, cptr, env, i32)
 DEF_HELPER_4(gvec_vftci64s, void, ptr, cptr, env, i32)
+DEF_HELPER_4(gvec_vftci128, void, ptr, cptr, env, i32)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index 7d4811ccf7..6bd599b319 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2991,16 +2991,32 @@ static DisasJumpType op_vftci(DisasContext *s, DisasOps *o)
     const uint16_t i3 = get_field(s, i3);
     const uint8_t fpf = get_field(s, m4);
     const uint8_t m5 = get_field(s, m5);
-    gen_helper_gvec_2_ptr *fn = gen_helper_gvec_vftci64;
+    const bool se = extract32(m5, 3, 1);
+    gen_helper_gvec_2_ptr *fn = NULL;
 
-    if (fpf != FPF_LONG || extract32(m5, 0, 3)) {
+    switch (fpf) {
+    case FPF_SHORT:
+        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+            fn = se ? gen_helper_gvec_vftci32s : gen_helper_gvec_vftci32;
+        }
+        break;
+    case FPF_LONG:
+        fn = se ? gen_helper_gvec_vftci64s : gen_helper_gvec_vftci64;
+        break;
+    case FPF_EXT:
+        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+            fn = gen_helper_gvec_vftci128;
+        }
+        break;
+    default:
+        break;
+    }
+
+    if (!fn || extract32(m5, 0, 3)) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
 
-    if (extract32(m5, 3, 1)) {
-        fn = gen_helper_gvec_vftci64s;
-    }
     gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2), cpu_env, i3, fn);
     set_cc_static(s);
     return DISAS_NEXT;
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index b7045e85d6..f18f0ae8e2 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -23,6 +23,9 @@
 const float32 float32_ones = make_float32(-1u);
 const float64 float64_ones = make_float64(-1ull);
 const float128 float128_ones = make_float128(-1ull, -1ull);
+const float32 float32_zeroes = make_float32(0);
+const float64 float64_zeroes = make_float64(0);
+const float128 float128_zeroes = make_float128(0, 0);
 
 #define VIC_INVALID         0x1
 #define VIC_DIVBYZERO       0x2
@@ -782,39 +785,50 @@ void HELPER(gvec_vfs##BITS##s)(void *v1, const void *v2, const void *v3,       \
 DEF_GVEC_FVS_S(32)
 DEF_GVEC_FVS_S(64)
 
-static int vftci64(S390Vector *v1, const S390Vector *v2, CPUS390XState *env,
-                   bool s, uint16_t i3)
-{
-    int i, match = 0;
-
-    for (i = 0; i < 2; i++) {
-        float64 a = s390_vec_read_element64(v2, i);
-
-        if (float64_dcmask(env, a) & i3) {
-            match++;
-            s390_vec_write_element64(v1, i, -1ull);
-        } else {
-            s390_vec_write_element64(v1, i, 0);
-        }
-        if (s) {
-            break;
-        }
-    }
-
-    if (match) {
-        return s || match == 2 ? 0 : 1;
-    }
-    return 3;
+#define DEF_VFTCI(BITS)                                                        \
+static int vftci##BITS(S390Vector *v1, const S390Vector *v2,                   \
+                       CPUS390XState *env, bool s, uint16_t i3)                \
+{                                                                              \
+    int i, match = 0;                                                          \
+                                                                               \
+    for (i = 0; i < (128 / BITS); i++) {                                       \
+        float##BITS a = s390_vec_read_float##BITS(v2, i);                      \
+                                                                               \
+        if (float##BITS##_dcmask(env, a) & i3) {                               \
+            match++;                                                           \
+            s390_vec_write_float##BITS(v1, i, float##BITS##_ones);             \
+        } else {                                                               \
+            s390_vec_write_float##BITS(v1, i, float##BITS##_zeroes);           \
+        }                                                                      \
+        if (s) {                                                               \
+            break;                                                             \
+        }                                                                      \
+    }                                                                          \
+                                                                               \
+    if (match) {                                                               \
+        return s || match == (128 / BITS) ? 0 : 1;                             \
+    }                                                                          \
+    return 3;                                                                  \
 }
+DEF_VFTCI(32)
+DEF_VFTCI(64)
+DEF_VFTCI(128)
 
-void HELPER(gvec_vftci64)(void *v1, const void *v2, CPUS390XState *env,
-                          uint32_t desc)
-{
-    env->cc_op = vftci64(v1, v2, env, false, simd_data(desc));
+#define DEF_GVEC_VFTCI(BITS)                                                   \
+void HELPER(gvec_vftci##BITS)(void *v1, const void *v2, CPUS390XState *env,    \
+                              uint32_t desc)                                   \
+{                                                                              \
+    env->cc_op = vftci##BITS(v1, v2, env, false, simd_data(desc));             \
 }
+DEF_GVEC_VFTCI(32)
+DEF_GVEC_VFTCI(64)
+DEF_GVEC_VFTCI(128)
 
-void HELPER(gvec_vftci64s)(void *v1, const void *v2, CPUS390XState *env,
-                           uint32_t desc)
-{
-    env->cc_op = vftci64(v1, v2, env, true, simd_data(desc));
+#define DEF_GVEC_VFTCI_S(BITS)                                                 \
+void HELPER(gvec_vftci##BITS##s)(void *v1, const void *v2, CPUS390XState *env, \
+                                 uint32_t desc)                                \
+{                                                                              \
+    env->cc_op = vftci##BITS(v1, v2, env, true, simd_data(desc));              \
 }
+DEF_GVEC_VFTCI_S(32)
+DEF_GVEC_VFTCI_S(64)
-- 
2.26.2


