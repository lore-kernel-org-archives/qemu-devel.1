Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9318C47427
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2702076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLK9npUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2702076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdZS-0007Fr-Bg
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWb-0004Sm-2B
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWS-0004Z1-Bp
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:08 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nbEBF+4BBHaosGjopfBxFq9VoWAhW6zrFzy9lLwsLA=;
 b=VLK9npUJBvVDhbHQCPWBr3VbYjDBAZVImPqVEh+L3NUNjgdrWdS/+MGdAf4IIuSwlL+WY2
 ibxb6tea7fblwmJjFPUEEXe+8Z9t1LyDyWKX14Q+RSNj33KgLwfjohhwSDhj9VhbrXkn7g
 82QL0SIp2wAm1BdhJbKasxFP2Rzn2gw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-XS-Sxq8hNZ6F5Jf-DkYV4Q-1; Wed, 30 Sep 2020 10:55:55 -0400
X-MC-Unique: XS-Sxq8hNZ6F5Jf-DkYV4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2575A1021200;
 Wed, 30 Sep 2020 14:55:54 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EE765C1C4;
 Wed, 30 Sep 2020 14:55:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/20] s390x/tcg: Implement 32/128 bit for VECTOR LOAD FP
 INTEGER
Date: Wed, 30 Sep 2020 16:55:13 +0200
Message-Id: <20200930145523.71087-11-david@redhat.com>
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

Convert vop64_2 into a macro, similar to already done with vop64_3.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  3 ++
 target/s390x/translate_vx.c.inc | 51 ++++++++++++++-----
 target/s390x/vec_fpu_helper.c   | 90 ++++++++++++++++++---------------
 3 files changed, 91 insertions(+), 53 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 538d55420b..ae9f855b05 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -301,8 +301,11 @@ DEF_HELPER_FLAGS_5(gvec_vfd32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfd64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfd64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfd128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vfi32, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vfi32s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfi64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfi64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vfi128, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfll32, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vfll32s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vflr64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index fd1cd6f6d5..f6aed65ff5 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2742,35 +2742,62 @@ static DisasJumpType op_vcdg(DisasContext *s, DisasOps *o)
     const uint8_t m4 = get_field(s, m4);
     const uint8_t erm = get_field(s, m5);
     const bool se = extract32(m4, 3, 1);
-    gen_helper_gvec_2_ptr *fn;
-
-    if (fpf != FPF_LONG || extract32(m4, 0, 2) || erm > 7 || erm == 2) {
-        gen_program_exception(s, PGM_SPECIFICATION);
-        return DISAS_NORETURN;
-    }
+    gen_helper_gvec_2_ptr *fn = NULL;
 
     switch (s->fields.op2) {
     case 0xc3:
-        fn = se ? gen_helper_gvec_vcdg64s : gen_helper_gvec_vcdg64;
+        if (fpf == FPF_LONG) {
+            fn = se ? gen_helper_gvec_vcdg64s : gen_helper_gvec_vcdg64;
+        }
         break;
     case 0xc1:
-        fn = se ? gen_helper_gvec_vcdlg64s : gen_helper_gvec_vcdlg64;
+        if (fpf == FPF_LONG) {
+            fn = se ? gen_helper_gvec_vcdlg64s : gen_helper_gvec_vcdlg64;
+        }
         break;
     case 0xc2:
-        fn = se ? gen_helper_gvec_vcgd64s : gen_helper_gvec_vcgd64;
+        if (fpf == FPF_LONG) {
+            fn = se ? gen_helper_gvec_vcgd64s : gen_helper_gvec_vcgd64;
+        }
         break;
     case 0xc0:
-        fn = se ? gen_helper_gvec_vclgd64s : gen_helper_gvec_vclgd64;
+        if (fpf == FPF_LONG) {
+            fn = se ? gen_helper_gvec_vclgd64s : gen_helper_gvec_vclgd64;
+        }
         break;
     case 0xc7:
-        fn = se ? gen_helper_gvec_vfi64s : gen_helper_gvec_vfi64;
+        switch (fpf) {
+        case FPF_SHORT:
+            if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+                fn = se ? gen_helper_gvec_vfi32s : gen_helper_gvec_vfi32;
+            }
+            break;
+        case FPF_LONG:
+            fn = se ? gen_helper_gvec_vfi64s : gen_helper_gvec_vfi64;
+            break;
+        case FPF_EXT:
+            if (s390_has_feat(S390_FEAT_VECTOR_ENH)) {
+                fn = gen_helper_gvec_vfi128;
+            }
+            break;
+        default:
+            break;
+        }
         break;
     case 0xc5:
-        fn = se ? gen_helper_gvec_vflr64s : gen_helper_gvec_vflr64;
+        if (fpf == FPF_LONG) {
+            fn = se ? gen_helper_gvec_vflr64s : gen_helper_gvec_vflr64;
+        }
         break;
     default:
         g_assert_not_reached();
     }
+
+    if (!fn || extract32(m4, 0, 2) || erm > 7 || erm == 2) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
     gen_gvec_2_ptr(get_field(s, v1), get_field(s, v2), cpu_env,
                    deposit32(m4, 4, 4, erm), fn);
     return DISAS_NEXT;
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index e8ae608da6..9bc7f5c8d7 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -116,29 +116,33 @@ static void s390_vec_write_float128(S390Vector *v, uint8_t enr, float128 data)
     s390_vec_write_element64(v, 1, data.low);
 }
 
-typedef uint64_t (*vop64_2_fn)(uint64_t a, float_status *s);
-static void vop64_2(S390Vector *v1, const S390Vector *v2, CPUS390XState *env,
-                    bool s, bool XxC, uint8_t erm, vop64_2_fn fn,
-                    uintptr_t retaddr)
-{
-    uint8_t vxc, vec_exc = 0;
-    S390Vector tmp = {};
-    int i, old_mode;
-
-    old_mode = s390_swap_bfp_rounding_mode(env, erm);
-    for (i = 0; i < 2; i++) {
-        const uint64_t a = s390_vec_read_element64(v2, i);
-
-        s390_vec_write_element64(&tmp, i, fn(a, &env->fpu_status));
-        vxc = check_ieee_exc(env, i, XxC, &vec_exc);
-        if (s || vxc) {
-            break;
-        }
-    }
-    s390_restore_bfp_rounding_mode(env, old_mode);
-    handle_ieee_exc(env, vxc, vec_exc, retaddr);
-    *v1 = tmp;
+#define DEF_VOP_2(BITS)                                                        \
+typedef float##BITS (*vop##BITS##_2_fn)(float##BITS a, float_status *s);       \
+static void vop##BITS##_2(S390Vector *v1, const S390Vector *v2,                \
+                          CPUS390XState *env, bool s, bool XxC, uint8_t erm,   \
+                          vop##BITS##_2_fn fn, uintptr_t retaddr)              \
+{                                                                              \
+    uint8_t vxc, vec_exc = 0;                                                  \
+    S390Vector tmp = {};                                                       \
+    int i, old_mode;                                                           \
+                                                                               \
+    old_mode = s390_swap_bfp_rounding_mode(env, erm);                          \
+    for (i = 0; i < (128 / BITS); i++) {                                       \
+        const float##BITS a = s390_vec_read_float##BITS(v2, i);                \
+                                                                               \
+        s390_vec_write_float##BITS(&tmp, i, fn(a, &env->fpu_status));          \
+        vxc = check_ieee_exc(env, i, XxC, &vec_exc);                           \
+        if (s || vxc) {                                                        \
+            break;                                                             \
+        }                                                                      \
+    }                                                                          \
+    s390_restore_bfp_rounding_mode(env, old_mode);                             \
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);                               \
+    *v1 = tmp;                                                                 \
 }
+DEF_VOP_2(32)
+DEF_VOP_2(64)
+DEF_VOP_2(128)
 
 #define DEF_VOP_3(BITS)                                                        \
 typedef float##BITS (*vop##BITS##_3_fn)(float##BITS a, float##BITS b,          \
@@ -536,28 +540,32 @@ void HELPER(gvec_vfd##BITS##s)(void *v1, const void *v2, const void *v3,       \
 DEF_GVEC_FVD_S(32)
 DEF_GVEC_FVD_S(64)
 
-static uint64_t vfi64(uint64_t a, float_status *s)
-{
-    return float64_round_to_int(a, s);
-}
-
-void HELPER(gvec_vfi64)(void *v1, const void *v2, CPUS390XState *env,
-                        uint32_t desc)
-{
-    const uint8_t erm = extract32(simd_data(desc), 4, 4);
-    const bool XxC = extract32(simd_data(desc), 2, 1);
-
-    vop64_2(v1, v2, env, false, XxC, erm, vfi64, GETPC());
+#define DEF_GVEC_VFI(BITS)                                                     \
+void HELPER(gvec_vfi##BITS)(void *v1, const void *v2, CPUS390XState *env,      \
+                            uint32_t desc)                                     \
+{                                                                              \
+    const uint8_t erm = extract32(simd_data(desc), 4, 4);                      \
+    const bool XxC = extract32(simd_data(desc), 2, 1);                         \
+                                                                               \
+    vop##BITS##_2(v1, v2, env, false, XxC, erm, float##BITS##_round_to_int,    \
+                  GETPC());                                                    \
 }
+DEF_GVEC_VFI(32)
+DEF_GVEC_VFI(64)
+DEF_GVEC_VFI(128)
 
-void HELPER(gvec_vfi64s)(void *v1, const void *v2, CPUS390XState *env,
-                         uint32_t desc)
-{
-    const uint8_t erm = extract32(simd_data(desc), 4, 4);
-    const bool XxC = extract32(simd_data(desc), 2, 1);
-
-    vop64_2(v1, v2, env, true, XxC, erm, vfi64, GETPC());
+#define DEF_GVEC_VFI_S(BITS)                                                   \
+void HELPER(gvec_vfi##BITS##s)(void *v1, const void *v2, CPUS390XState *env,   \
+                               uint32_t desc)                                  \
+{                                                                              \
+    const uint8_t erm = extract32(simd_data(desc), 4, 4);                      \
+    const bool XxC = extract32(simd_data(desc), 2, 1);                         \
+                                                                               \
+    vop##BITS##_2(v1, v2, env, true, XxC, erm, float##BITS##_round_to_int,     \
+                  GETPC());                                                    \
 }
+DEF_GVEC_VFI_S(32)
+DEF_GVEC_VFI_S(64)
 
 static void vfll32(S390Vector *v1, const S390Vector *v2, CPUS390XState *env,
                    bool s, uintptr_t retaddr)
-- 
2.26.2


