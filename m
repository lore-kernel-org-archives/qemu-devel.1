Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8694DC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFB12071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBmy1j+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFB12071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdvE-00020d-M9
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWj-0004qM-Tx
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWa-0004an-8O
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IX2Z9mOEG2EBJSY/JwVni8dnEhaWd6X971tJ1/9Og94=;
 b=dBmy1j+VUBZnvnUBiD1n7GX3uUTyYB5QzOSraYKaza4mGQAD5crxFEb9cv4N0f0IN4czdt
 A73tFVeT7D6XL4G2KsI5ysUL54E0weTO5Prdfr6w3ldv1Znhg3xa6EN6rLknBzveBcsKaj
 JiP2VPZpJq4ari4TeURBJmG6rEodMwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-WmDvmeDmO-ag7J_0bgllSw-1; Wed, 30 Sep 2020 10:56:03 -0400
X-MC-Unique: WmDvmeDmO-ag7J_0bgllSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B844580B73A;
 Wed, 30 Sep 2020 14:56:02 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8243A5C1C4;
 Wed, 30 Sep 2020 14:56:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 14/20] s390x/tcg: Implement 32/128 bit for VECTOR FP SQUARE
 ROOT
Date: Wed, 30 Sep 2020 16:55:17 +0200
Message-Id: <20200930145523.71087-15-david@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/s390x/helper.h           |  3 +++
 target/s390x/translate_vx.c.inc | 26 +++++++++++++++++++++-----
 target/s390x/vec_fpu_helper.c   | 28 +++++++++++++++-------------
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 79e3fa14f8..bee283e3d4 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -321,8 +321,11 @@ DEF_HELPER_FLAGS_6(gvec_vfma64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env
 DEF_HELPER_FLAGS_6(gvec_vfma64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfms64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfms64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vfsq32, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vfsq32s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfsq64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfsq64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vfsq128, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfs32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfs32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfs64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index ee79d97e19..7d4811ccf7 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2955,16 +2955,32 @@ static DisasJumpType op_vfsq(DisasContext *s, DisasOps *o)
 {
     const uint8_t fpf = get_field(s, m3);
     const uint8_t m4 = get_field(s, m4);
-    gen_helper_gvec_2_ptr *fn = gen_helper_gvec_vfsq64;
+    const bool se = extract32(m4, 3, 1);
+    gen_helper_gvec_2_ptr *fn = NULL;
 
-    if (fpf != FPF_LONG || extract32(m4, 0, 3)) {
+    switch (fpf) {
+    case FPF_SHORT:
+        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+            fn = se ? gen_helper_gvec_vfsq32s : gen_helper_gvec_vfsq32;
+        }
+        break;
+    case FPF_LONG:
+        fn = se ? gen_helper_gvec_vfsq64s : gen_helper_gvec_vfsq64;
+        break;
+    case FPF_EXT:
+        if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+            fn = gen_helper_gvec_vfsq128;
+        }
+        break;
+    default:
+        break;
+    }
+
+    if (!fn || extract32(m4, 0, 3)) {
         gen_program_exception(s, PGM_SPECIFICATION);
         return DISAS_NORETURN;
     }
 
-    if (extract32(m4, 3, 1)) {
-        fn = gen_helper_gvec_vfsq64s;
-    }
     gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2), cpu_env,
                    0, fn);
     return DISAS_NEXT;
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index f8ebd04516..b7045e85d6 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -744,22 +744,24 @@ void HELPER(gvec_vfms64s)(void *v1, const void *v2, const void *v3,
     vfma64(v1, v2, v3, v4, env, true, float_muladd_negate_c, GETPC());
 }
 
-static uint64_t vfsq64(uint64_t a, float_status *s)
-{
-    return float64_sqrt(a, s);
-}
-
-void HELPER(gvec_vfsq64)(void *v1, const void *v2, CPUS390XState *env,
-                         uint32_t desc)
-{
-    vop64_2(v1, v2, env, false, false, 0, vfsq64, GETPC());
+#define DEF_GVEC_VFSQ(BITS)                                                    \
+void HELPER(gvec_vfsq##BITS)(void *v1, const void *v2, CPUS390XState *env,     \
+                             uint32_t desc)                                    \
+{                                                                              \
+    vop##BITS##_2(v1, v2, env, false, false, 0, float##BITS##_sqrt, GETPC());  \
 }
+DEF_GVEC_VFSQ(32)
+DEF_GVEC_VFSQ(64)
+DEF_GVEC_VFSQ(128)
 
-void HELPER(gvec_vfsq64s)(void *v1, const void *v2, CPUS390XState *env,
-                          uint32_t desc)
-{
-    vop64_2(v1, v2, env, true, false, 0, vfsq64, GETPC());
+#define DEF_GVEC_VFSQ_S(BITS)                                                  \
+void HELPER(gvec_vfsq##BITS##s)(void *v1, const void *v2, CPUS390XState *env,  \
+                                uint32_t desc)                                 \
+{                                                                              \
+    vop##BITS##_2(v1, v2, env, true, false, 0, float##BITS##_sqrt, GETPC());   \
 }
+DEF_GVEC_VFSQ_S(32)
+DEF_GVEC_VFSQ_S(64)
 
 #define DEF_GVEC_FVS(BITS)                                                     \
 void HELPER(gvec_vfs##BITS)(void *v1, const void *v2, const void *v3,          \
-- 
2.26.2


