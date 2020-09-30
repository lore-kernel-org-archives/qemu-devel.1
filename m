Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A05C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965802071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRTdS+Aw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965802071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdrb-0007w1-70
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWU-0004Kr-L9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWO-0004Yh-61
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4LCiAqgooe34+SkheYO0tpyF+RaQ0QN3qOLcYiyCc8=;
 b=dRTdS+Awtm5ryyH4JXWXdcUEhRaLWGiGikVeqLfteOabUWBFbRUWspqg9s33VBVkhWpePp
 u0Nn0xHpJInONysUnV26Psn3HhxevuDOC0vu2uNX0e+/wV1Elv6tRjzgNlJgmhOEK7H5q9
 0BOHsZ4bP9jNbGLw7KEdhrWU7bdZK5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-VuSjdRMnN-q83-Ux4g1icw-1; Wed, 30 Sep 2020 10:55:53 -0400
X-MC-Unique: VuSjdRMnN-q83-Ux4g1icw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31D658015B0;
 Wed, 30 Sep 2020 14:55:52 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 572285C1C4;
 Wed, 30 Sep 2020 14:55:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/20] s390x/tcg: Implement 32/128 bit for VECTOR FP
 COMPARE *
Date: Wed, 30 Sep 2020 16:55:12 +0200
Message-Id: <20200930145523.71087-10-david@redhat.com>
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

In addition to 32/128bit variants, we also have to support the
"Signal-on-QNaN (SQ)" bit ... let's pass it as a simple flag, I don't
feel like duplicating all helpers and coming up with names like
"...s_cc_sq".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  18 +++
 target/s390x/translate_vx.c.inc |  91 +++++++++---
 target/s390x/vec_fpu_helper.c   | 250 ++++++++++++++++++++++----------
 3 files changed, 258 insertions(+), 101 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6bf4d3e7d0..538d55420b 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -258,18 +258,36 @@ DEF_HELPER_4(gvec_wfc64, void, cptr, cptr, env, i32)
 DEF_HELPER_4(gvec_wfk64, void, cptr, cptr, env, i32)
 DEF_HELPER_4(gvec_wfc128, void, cptr, cptr, env, i32)
 DEF_HELPER_4(gvec_wfk128, void, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfce32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfce32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfce64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfce64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfce128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfce32_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfce32s_cc, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfce64_cc, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfce64s_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfce128_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfch32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfch32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfch64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfch64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfch128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfch32_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfch32s_cc, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfch64_cc, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfch64s_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfch128_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfche32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfche32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfche64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfche64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfche128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfche32_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfche32s_cc, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfche64_cc, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_5(gvec_vfche64s_cc, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vfche128_cc, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vcdg64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vcdg64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
 DEF_HELPER_FLAGS_4(gvec_vcdlg64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index cc745784e5..fd1cd6f6d5 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2646,45 +2646,90 @@ static DisasJumpType op_vfc(DisasContext *s, DisasOps *o)
     const uint8_t m5 = get_field(s, m5);
     const uint8_t m6 = get_field(s, m6);
     const bool se = extract32(m5, 3, 1);
+    const bool sq = extract32(m5, 2, 1);
     const bool cs = extract32(m6, 0, 1);
-    gen_helper_gvec_3_ptr *fn;
-
-    if (fpf != FPF_LONG || extract32(m5, 0, 3) || extract32(m6, 1, 3)) {
-        gen_program_exception(s, PGM_SPECIFICATION);
-        return DISAS_NORETURN;
-    }
+    gen_helper_gvec_3_ptr *fn = NULL;
 
-    if (cs) {
-        switch (s->fields.op2) {
-        case 0xe8:
-            fn = se ? gen_helper_gvec_vfce64s_cc : gen_helper_gvec_vfce64_cc;
+    switch (s->fields.op2) {
+    case 0xe8:
+        switch (fpf) {
+        case FPF_SHORT:
+            fn = se ? gen_helper_gvec_vfce32s : gen_helper_gvec_vfce32;
+            if (cs) {
+                fn = se ? gen_helper_gvec_vfce32s_cc :
+                          gen_helper_gvec_vfce32_cc;
+            }
             break;
-        case 0xeb:
-            fn = se ? gen_helper_gvec_vfch64s_cc : gen_helper_gvec_vfch64_cc;
+        case FPF_LONG:
+            fn = se ? gen_helper_gvec_vfce64s : gen_helper_gvec_vfce64;
+            if (cs) {
+                fn = se ? gen_helper_gvec_vfce64s_cc :
+                          gen_helper_gvec_vfce64_cc;
+            }
             break;
-        case 0xea:
-            fn = se ? gen_helper_gvec_vfche64s_cc : gen_helper_gvec_vfche64_cc;
+        case FPF_EXT:
+            fn = cs ? gen_helper_gvec_vfce128_cc : gen_helper_gvec_vfce128;
             break;
         default:
-            g_assert_not_reached();
+            break;
         }
-    } else {
-        switch (s->fields.op2) {
-        case 0xe8:
-            fn = se ? gen_helper_gvec_vfce64s : gen_helper_gvec_vfce64;
+        break;
+    case 0xeb:
+        switch (fpf) {
+        case FPF_SHORT:
+            fn = se ? gen_helper_gvec_vfch32s : gen_helper_gvec_vfch32;
+            if (cs) {
+                fn = se ? gen_helper_gvec_vfch32s_cc : gen_helper_gvec_vfch32_cc;
+            }
             break;
-        case 0xeb:
+        case FPF_LONG:
             fn = se ? gen_helper_gvec_vfch64s : gen_helper_gvec_vfch64;
+            if (cs) {
+                fn = se ? gen_helper_gvec_vfch64s_cc : gen_helper_gvec_vfch64_cc;
+            }
+            break;
+        case FPF_EXT:
+            fn = cs ? gen_helper_gvec_vfch128_cc : gen_helper_gvec_vfch128;
             break;
-        case 0xea:
+        default:
+            break;
+        }
+        break;
+    case 0xea:
+        switch (fpf) {
+        case FPF_SHORT:
+            fn = se ? gen_helper_gvec_vfche32s : gen_helper_gvec_vfche32;
+            if (cs) {
+                fn = se ? gen_helper_gvec_vfche32s_cc :
+                          gen_helper_gvec_vfche32_cc;
+            }
+            break;
+        case FPF_LONG:
             fn = se ? gen_helper_gvec_vfche64s : gen_helper_gvec_vfche64;
+            if (cs) {
+                fn = se ? gen_helper_gvec_vfche64s_cc :
+                          gen_helper_gvec_vfche64_cc;
+            }
+            break;
+        case FPF_EXT:
+            fn = cs ? gen_helper_gvec_vfche128_cc : gen_helper_gvec_vfche128;
             break;
         default:
-            g_assert_not_reached();
+            break;
         }
+    default:
+        break;
     }
+
+    if (!fn || extract32(m5, 0, 2) || extract32(m6, 1, 3) ||
+        (!s390_has_feat(S390_FEAT_VECTOR_ENH) && (fpf != FPF_LONG || sq))) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    /* Pass the "sq" flag as data. */
     gen_gvec_3_ptr(get_field(s, v1), get_field(s, v2),
-                   get_field(s, v3), cpu_env, 0, fn);
+                   get_field(s, v3), cpu_env, sq, fn);
     if (cs) {
         set_cc_static(s);
     }
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index 1b78b6c088..e8ae608da6 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -20,6 +20,10 @@
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 
+const float32 float32_ones = make_float32(-1u);
+const float64 float64_ones = make_float64(-1ull);
+const float128 float128_ones = make_float128(-1ull, -1ull);
+
 #define VIC_INVALID         0x1
 #define VIC_DIVBYZERO       0x2
 #define VIC_OVERFLOW        0x3
@@ -227,109 +231,199 @@ DEF_GVEC_WFK(32)
 DEF_GVEC_WFK(64)
 DEF_GVEC_WFK(128)
 
-typedef bool (*vfc64_fn)(float64 a, float64 b, float_status *status);
-static int vfc64(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
-                 CPUS390XState *env, bool s, vfc64_fn fn, uintptr_t retaddr)
-{
-    uint8_t vxc, vec_exc = 0;
-    S390Vector tmp = {};
-    int match = 0;
-    int i;
-
-    for (i = 0; i < 2; i++) {
-        const float64 a = s390_vec_read_element64(v2, i);
-        const float64 b = s390_vec_read_element64(v3, i);
-
-        /* swap the order of the parameters, so we can use existing functions */
-        if (fn(b, a, &env->fpu_status)) {
-            match++;
-            s390_vec_write_element64(&tmp, i, -1ull);
-        }
-        vxc = check_ieee_exc(env, i, false, &vec_exc);
-        if (s || vxc) {
-            break;
-        }
-    }
-
-    handle_ieee_exc(env, vxc, vec_exc, retaddr);
-    *v1 = tmp;
-    if (match) {
-        return s || match == 2 ? 0 : 1;
-    }
-    return 3;
+#define DEF_VFC(BITS)                                                          \
+typedef bool (*vfc##BITS##_fn)(float##BITS a, float##BITS b,                   \
+                               float_status *status);                          \
+static int vfc##BITS(S390Vector *v1, const S390Vector *v2,                     \
+                     const S390Vector *v3, CPUS390XState *env, bool s,         \
+                     vfc##BITS##_fn fn, uintptr_t retaddr)                     \
+{                                                                              \
+    uint8_t vxc, vec_exc = 0;                                                  \
+    S390Vector tmp = {};                                                       \
+    int match = 0;                                                             \
+    int i;                                                                     \
+                                                                               \
+    for (i = 0; i < (128 / BITS); i++) {                                       \
+        const float##BITS a = s390_vec_read_float##BITS(v2, i);                \
+        const float##BITS b = s390_vec_read_float##BITS(v3, i);                \
+                                                                               \
+        /* swap the parameters, so we can use existing functions */            \
+        if (fn(b, a, &env->fpu_status)) {                                      \
+            match++;                                                           \
+            s390_vec_write_float##BITS(&tmp, i, float##BITS##_ones);           \
+        }                                                                      \
+        vxc = check_ieee_exc(env, i, false, &vec_exc);                         \
+        if (s || vxc) {                                                        \
+            break;                                                             \
+        }                                                                      \
+    }                                                                          \
+                                                                               \
+    handle_ieee_exc(env, vxc, vec_exc, retaddr);                               \
+    *v1 = tmp;                                                                 \
+    if (match) {                                                               \
+        return s || match == (128 / BITS) ? 0 : 1;                             \
+    }                                                                          \
+    return 3;                                                                  \
 }
+DEF_VFC(32)
+DEF_VFC(64)
+DEF_VFC(128)
 
-void HELPER(gvec_vfce64)(void *v1, const void *v2, const void *v3,
-                         CPUS390XState *env, uint32_t desc)
-{
-    vfc64(v1, v2, v3, env, false, float64_eq_quiet, GETPC());
+#define DEF_GVEC_VFCE(BITS)                                                    \
+void HELPER(gvec_vfce##BITS)(void *v1, const void *v2, const void *v3,         \
+                             CPUS390XState *env, uint32_t desc)                \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    vfc##BITS(v1, v2, v3, env, false,                                          \
+              sq ? float##BITS##_eq : float##BITS##_eq_quiet, GETPC());        \
 }
+DEF_GVEC_VFCE(32)
+DEF_GVEC_VFCE(64)
+DEF_GVEC_VFCE(128)
 
-void HELPER(gvec_vfce64s)(void *v1, const void *v2, const void *v3,
-                          CPUS390XState *env, uint32_t desc)
-{
-    vfc64(v1, v2, v3, env, true, float64_eq_quiet, GETPC());
+#define DEF_GVEC_VFCE_S(BITS)                                                  \
+void HELPER(gvec_vfce##BITS##s)(void *v1, const void *v2, const void *v3,      \
+                                CPUS390XState *env, uint32_t desc)             \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    vfc##BITS(v1, v2, v3, env, true,                                           \
+              sq ? float##BITS##_eq : float##BITS##_eq_quiet, GETPC());        \
 }
+DEF_GVEC_VFCE_S(32)
+DEF_GVEC_VFCE_S(64)
 
-void HELPER(gvec_vfce64_cc)(void *v1, const void *v2, const void *v3,
-                            CPUS390XState *env, uint32_t desc)
-{
-    env->cc_op = vfc64(v1, v2, v3, env, false, float64_eq_quiet, GETPC());
+#define DEF_GVEC_VFCE_CC(BITS)                                                 \
+void HELPER(gvec_vfce##BITS##_cc)(void *v1, const void *v2, const void *v3,    \
+                                  CPUS390XState *env, uint32_t desc)           \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    env->cc_op = vfc##BITS(v1, v2, v3, env, false,                             \
+                           sq ? float##BITS##_eq : float##BITS##_eq_quiet,     \
+                           GETPC());                                           \
 }
+DEF_GVEC_VFCE_CC(32)
+DEF_GVEC_VFCE_CC(64)
+DEF_GVEC_VFCE_CC(128)
 
-void HELPER(gvec_vfce64s_cc)(void *v1, const void *v2, const void *v3,
-                            CPUS390XState *env, uint32_t desc)
-{
-    env->cc_op = vfc64(v1, v2, v3, env, true, float64_eq_quiet, GETPC());
+#define DEF_GVEC_VFCE_S_CC(BITS)                                               \
+void HELPER(gvec_vfce##BITS##s_cc)(void *v1, const void *v2, const void *v3,   \
+                                   CPUS390XState *env, uint32_t desc)          \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    env->cc_op = vfc##BITS(v1, v2, v3, env, true,                              \
+                           sq ? float##BITS##_eq : float##BITS##_eq_quiet,     \
+                           GETPC());                                           \
 }
+DEF_GVEC_VFCE_S_CC(32)
+DEF_GVEC_VFCE_S_CC(64)
 
-void HELPER(gvec_vfch64)(void *v1, const void *v2, const void *v3,
-                         CPUS390XState *env, uint32_t desc)
-{
-    vfc64(v1, v2, v3, env, false, float64_lt_quiet, GETPC());
+#define DEF_GVEC_VFCH(BITS)                                                    \
+void HELPER(gvec_vfch##BITS)(void *v1, const void *v2, const void *v3,         \
+                             CPUS390XState *env, uint32_t desc)                \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    vfc##BITS(v1, v2, v3, env, false,                                          \
+              sq ? float##BITS##_lt : float##BITS##_lt_quiet, GETPC());        \
 }
+DEF_GVEC_VFCH(32)
+DEF_GVEC_VFCH(64)
+DEF_GVEC_VFCH(128)
 
-void HELPER(gvec_vfch64s)(void *v1, const void *v2, const void *v3,
-                          CPUS390XState *env, uint32_t desc)
-{
-    vfc64(v1, v2, v3, env, true, float64_lt_quiet, GETPC());
+#define DEF_GVEC_VFCH_S(BITS)                                                  \
+void HELPER(gvec_vfch##BITS##s)(void *v1, const void *v2, const void *v3,      \
+                                CPUS390XState *env, uint32_t desc)             \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    vfc##BITS(v1, v2, v3, env, true,                                           \
+              sq ? float##BITS##_lt : float##BITS##_lt_quiet, GETPC());        \
 }
+DEF_GVEC_VFCH_S(32)
+DEF_GVEC_VFCH_S(64)
 
-void HELPER(gvec_vfch64_cc)(void *v1, const void *v2, const void *v3,
-                            CPUS390XState *env, uint32_t desc)
-{
-    env->cc_op = vfc64(v1, v2, v3, env, false, float64_lt_quiet, GETPC());
+#define DEF_GVEC_VFCH_CC(BITS)                                                 \
+void HELPER(gvec_vfch##BITS##_cc)(void *v1, const void *v2, const void *v3,    \
+                                  CPUS390XState *env, uint32_t desc)           \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    env->cc_op = vfc##BITS(v1, v2, v3, env, false,                             \
+                           sq ? float##BITS##_lt : float##BITS##_lt_quiet,     \
+                           GETPC());                                           \
 }
+DEF_GVEC_VFCH_CC(32)
+DEF_GVEC_VFCH_CC(64)
+DEF_GVEC_VFCH_CC(128)
 
-void HELPER(gvec_vfch64s_cc)(void *v1, const void *v2, const void *v3,
-                             CPUS390XState *env, uint32_t desc)
-{
-    env->cc_op = vfc64(v1, v2, v3, env, true, float64_lt_quiet, GETPC());
+#define DEF_GVEC_VFCH_S_CC(BITS)                                               \
+void HELPER(gvec_vfch##BITS##s_cc)(void *v1, const void *v2, const void *v3,   \
+                                   CPUS390XState *env, uint32_t desc)          \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    env->cc_op = vfc##BITS(v1, v2, v3, env, true,                              \
+                           sq ? float##BITS##_lt : float##BITS##_lt_quiet,     \
+                           GETPC());                                           \
 }
+DEF_GVEC_VFCH_S_CC(32)
+DEF_GVEC_VFCH_S_CC(64)
 
-void HELPER(gvec_vfche64)(void *v1, const void *v2, const void *v3,
-                          CPUS390XState *env, uint32_t desc)
-{
-    vfc64(v1, v2, v3, env, false, float64_le_quiet, GETPC());
+#define DEF_GVEC_VFCHE(BITS)                                                   \
+void HELPER(gvec_vfche##BITS)(void *v1, const void *v2, const void *v3,        \
+                              CPUS390XState *env, uint32_t desc)               \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    vfc##BITS(v1, v2, v3, env, false,                                          \
+              sq ? float##BITS##_le : float##BITS##_le_quiet, GETPC());        \
 }
+DEF_GVEC_VFCHE(32)
+DEF_GVEC_VFCHE(64)
+DEF_GVEC_VFCHE(128)
 
-void HELPER(gvec_vfche64s)(void *v1, const void *v2, const void *v3,
-                           CPUS390XState *env, uint32_t desc)
-{
-    vfc64(v1, v2, v3, env, true, float64_le_quiet, GETPC());
+#define DEF_GVEC_VFCHE_S(BITS)                                                 \
+void HELPER(gvec_vfche##BITS##s)(void *v1, const void *v2, const void *v3,     \
+                                 CPUS390XState *env, uint32_t desc)            \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    vfc##BITS(v1, v2, v3, env, true,                                           \
+              sq ? float##BITS##_le : float##BITS##_le_quiet, GETPC());        \
 }
+DEF_GVEC_VFCHE_S(32)
+DEF_GVEC_VFCHE_S(64)
 
-void HELPER(gvec_vfche64_cc)(void *v1, const void *v2, const void *v3,
-                             CPUS390XState *env, uint32_t desc)
-{
-    env->cc_op = vfc64(v1, v2, v3, env, false, float64_le_quiet, GETPC());
+#define DEF_GVEC_VFCHE_CC(BITS)                                                \
+void HELPER(gvec_vfche##BITS##_cc)(void *v1, const void *v2, const void *v3,   \
+                                   CPUS390XState *env, uint32_t desc)          \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    env->cc_op = vfc##BITS(v1, v2, v3, env, false,                             \
+                           sq ? float##BITS##_le : float##BITS##_le_quiet,     \
+                           GETPC());                                           \
 }
+DEF_GVEC_VFCHE_CC(32)
+DEF_GVEC_VFCHE_CC(64)
+DEF_GVEC_VFCHE_CC(128)
 
-void HELPER(gvec_vfche64s_cc)(void *v1, const void *v2, const void *v3,
-                              CPUS390XState *env, uint32_t desc)
-{
-    env->cc_op = vfc64(v1, v2, v3, env, true, float64_le_quiet, GETPC());
+#define DEF_GVEC_VFCHE_S_CC(BITS)                                              \
+void HELPER(gvec_vfche##BITS##s_cc)(void *v1, const void *v2, const void *v3,  \
+                                    CPUS390XState *env, uint32_t desc)         \
+{                                                                              \
+    const bool sq = simd_data(desc);                                           \
+                                                                               \
+    env->cc_op = vfc##BITS(v1, v2, v3, env, true,                              \
+                           sq ? float##BITS##_le : float##BITS##_le_quiet,     \
+                           GETPC());                                           \
 }
+DEF_GVEC_VFCHE_S_CC(32)
+DEF_GVEC_VFCHE_S_CC(64)
 
 static uint64_t vcdg64(uint64_t a, float_status *s)
 {
-- 
2.26.2


