Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B1C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBEE20759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkPRP108"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBEE20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdxy-0004kT-IB
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWm-0004xB-8V
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kNdWj-0004dY-Gp
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QxEZVFMGaJPpsmTHND3kt4vGBuel7R3iAwe92R/4OE=;
 b=HkPRP108w+/h32uWHqRmyOqMRyUug91xinTMUzJ368/BIHg/OpAjFkSIuR7/r8GX7TQYS4
 ah6J1CDaiAcM7nmCLyAVdb1bv51hZy9X7z2CahCVnZOaqa67M8Obk8fTf5F1U5M0WQGRpq
 Nu1IUCIwziuRZzEaRaUW/ptr1+gxGbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-dlwdJ30VMmCOZUmrt-JOQw-1; Wed, 30 Sep 2020 10:56:14 -0400
X-MC-Unique: dlwdJ30VMmCOZUmrt-JOQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAFF31891E86;
 Wed, 30 Sep 2020 14:56:13 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E58D85C1CF;
 Wed, 30 Sep 2020 14:56:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 18/20] s390x/tcg: Implement VECTOR FP (MAXIMUM|MINIMUM)
Date: Wed, 30 Sep 2020 16:55:21 +0200
Message-Id: <20200930145523.71087-19-david@redhat.com>
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

For IEEE functions, we can reuse the softfloat implementations. For the
other functions, implement it generically for 32bit/64bit/128bit -
carefully taking care of all weird special cases according to the tables
defined in the PoP.

While we could add plenty of helpers to do the function selection at
translation time, I don't feel like adding 20*(3+2) helpers for that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  10 ++
 target/s390x/insn-data.def      |   4 +
 target/s390x/translate_vx.c.inc |  44 +++++
 target/s390x/vec_fpu_helper.c   | 300 ++++++++++++++++++++++++++++++++
 4 files changed, 358 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6b4a6c5185..b2f8ccc60d 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -317,6 +317,16 @@ DEF_HELPER_FLAGS_5(gvec_vfm32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfm64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfm64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_vfm128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfmax32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfmax32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfmax64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfmax64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfmax128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfmin32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfmin32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfmin64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfmin64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_vfmin128, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfma32, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfma32s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_vfma64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, cptr, env, i32)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 082de27298..e9a3fdbc5a 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1253,6 +1253,10 @@
     F(0xe7c4, VFLL,    VRR_a, V,   0, 0, 0, 0, vfll, 0, IF_VEC)
 /* VECTOR LOAD ROUNDED */
     F(0xe7c5, VFLR,    VRR_a, V,   0, 0, 0, 0, vcdg, 0, IF_VEC)
+/* VECTOR FP MAXIMUM */
+    F(0xe7ef, VFMAX,   VRR_c, VE,  0, 0, 0, 0, vfmax, 0, IF_VEC)
+/* VECTOR FP MINIMUM */
+    F(0xe7ee, VFMIN,   VRR_c, VE,  0, 0, 0, 0, vfmax, 0, IF_VEC)
 /* VECTOR FP MULTIPLY */
     F(0xe7e7, VFM,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
 /* VECTOR FP MULTIPLY AND ADD */
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index 40e452f552..e2bde426e0 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -2842,6 +2842,50 @@ static DisasJumpType op_vfll(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_vfmax(DisasContext *s, DisasOps *o)
+{
+    const bool se = extract32(get_field(s, m5), 3, 1);
+    const uint8_t fpf = get_field(s, m4);
+    const uint8_t m6 = get_field(s, m6);
+    gen_helper_gvec_3_ptr *fn;
+
+    if (m6 == 5 || m6 == 6 || m6 == 7 || m6 > 13) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (fpf) {
+    case FPF_SHORT:
+        if (s->fields.op2 == 0xef) {
+            fn = se ? gen_helper_gvec_vfmax32s : gen_helper_gvec_vfmax32;
+        } else {
+            fn = se ? gen_helper_gvec_vfmin32s : gen_helper_gvec_vfmin32;
+        }
+        break;
+    case FPF_LONG:
+        if (s->fields.op2 == 0xef) {
+            fn = se ? gen_helper_gvec_vfmax64s : gen_helper_gvec_vfmax64;
+        } else {
+            fn = se ? gen_helper_gvec_vfmin64s : gen_helper_gvec_vfmin64;
+        }
+        break;
+    case FPF_EXT:
+        if (s->fields.op2 == 0xef) {
+            fn = gen_helper_gvec_vfmax128;
+        } else {
+            fn = gen_helper_gvec_vfmin128;
+        }
+        break;
+    default:
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    gen_gvec_3_ptr(get_field(s, v1), get_field(s, v2), get_field(s, v3),
+                   cpu_env, m6, fn);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_vfma(DisasContext *s, DisasOps *o)
 {
     const uint8_t m5 = get_field(s, m5);
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index 92858c8c59..80c6b644bf 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -899,3 +899,303 @@ void HELPER(gvec_vftci##BITS##s)(void *v1, const void *v2, CPUS390XState *env, \
 }
 DEF_GVEC_VFTCI_S(32)
 DEF_GVEC_VFTCI_S(64)
+
+typedef enum S390MinMaxType {
+    s390_minmax_java_math_min,
+    s390_minmax_java_math_max,
+    s390_minmax_c_macro_min,
+    s390_minmax_c_macro_max,
+    s390_minmax_fmin,
+    s390_minmax_fmax,
+    s390_minmax_cpp_alg_min,
+    s390_minmax_cpp_alg_max,
+} S390MinMaxType;
+
+#define S390_MINMAX(BITS, TYPE)                                                \
+static float##BITS TYPE##BITS(float##BITS a, float##BITS b, float_status *s)   \
+{                                                                              \
+    const bool zero_a = float##BITS##_is_infinity(a);                          \
+    const bool zero_b = float##BITS##_is_infinity(b);                          \
+    const bool inf_a = float##BITS##_is_infinity(a);                           \
+    const bool inf_b = float##BITS##_is_infinity(b);                           \
+    const bool nan_a = float##BITS##_is_infinity(a);                           \
+    const bool nan_b = float##BITS##_is_infinity(b);                           \
+    const bool neg_a = float##BITS##_is_neg(a);                                \
+    const bool neg_b = float##BITS##_is_neg(b);                                \
+                                                                               \
+    if (unlikely(nan_a || nan_b)) {                                            \
+        const bool sig_a = float##BITS##_is_signaling_nan(a, s);               \
+        const bool sig_b = float##BITS##_is_signaling_nan(b, s);               \
+                                                                               \
+        if (sig_a || sig_b) {                                                  \
+            s->float_exception_flags |= float_flag_invalid;                    \
+        }                                                                      \
+        switch (TYPE) {                                                        \
+        case s390_minmax_java_math_min:                                        \
+        case s390_minmax_java_math_max:                                        \
+            if (sig_a) {                                                       \
+                return float##BITS##_silence_nan(a, s);                        \
+            } else if (sig_b) {                                                \
+                return float##BITS##_silence_nan(b, s);                        \
+            }                                                                  \
+            /* fall through */                                                 \
+        case s390_minmax_fmin:                                                 \
+        case s390_minmax_fmax:                                                 \
+            return nan_a ? a : b;                                              \
+        case s390_minmax_c_macro_min:                                          \
+        case s390_minmax_c_macro_max:                                          \
+            s->float_exception_flags |= float_flag_invalid;                    \
+            return b;                                                          \
+        case s390_minmax_cpp_alg_min:                                          \
+        case s390_minmax_cpp_alg_max:                                          \
+            s->float_exception_flags |= float_flag_invalid;                    \
+            return a;                                                          \
+        default:                                                               \
+            g_assert_not_reached();                                            \
+        }                                                                      \
+    } else if (unlikely(inf_a && inf_b)) {                                     \
+        switch (TYPE) {                                                        \
+        case s390_minmax_java_math_min:                                        \
+            return neg_a && !neg_b ? a : b;                                    \
+        case s390_minmax_java_math_max:                                        \
+        case s390_minmax_fmax:                                                 \
+        case s390_minmax_cpp_alg_max:                                          \
+            return neg_a && !neg_b ? b : a;                                    \
+        case s390_minmax_c_macro_min:                                          \
+        case s390_minmax_cpp_alg_min:                                          \
+            return neg_b ? b : a;                                              \
+        case s390_minmax_c_macro_max:                                          \
+            return !neg_a && neg_b ? a : b;                                    \
+        case s390_minmax_fmin:                                                 \
+            return !neg_a && neg_b ? b : a;                                    \
+        default:                                                               \
+            g_assert_not_reached();                                            \
+        }                                                                      \
+    } else if (unlikely(zero_a && zero_b)) {                                   \
+        switch (TYPE) {                                                        \
+        case s390_minmax_java_math_min:                                        \
+            return neg_a && !neg_b ? a : b;                                    \
+        case s390_minmax_java_math_max:                                        \
+        case s390_minmax_fmax:                                                 \
+            return neg_a && !neg_b ? b : a;                                    \
+        case s390_minmax_c_macro_min:                                          \
+        case s390_minmax_c_macro_max:                                          \
+            return b;                                                          \
+        case s390_minmax_fmin:                                                 \
+            return !neg_a && neg_b ? b : a;                                    \
+        case s390_minmax_cpp_alg_min:                                          \
+        case s390_minmax_cpp_alg_max:                                          \
+            return a;                                                          \
+        default:                                                               \
+            g_assert_not_reached();                                            \
+        }                                                                      \
+    }                                                                          \
+                                                                               \
+    /* We can process all remaining cases using simple comparison. */          \
+    switch (TYPE) {                                                            \
+    case s390_minmax_java_math_min:                                            \
+    case s390_minmax_c_macro_min:                                              \
+    case s390_minmax_fmin:                                                     \
+    case s390_minmax_cpp_alg_min:                                              \
+        if (float##BITS##_le_quiet(a, b, s)) {                                 \
+            return a;                                                          \
+        }                                                                      \
+        return b;                                                              \
+    case s390_minmax_java_math_max:                                            \
+    case s390_minmax_c_macro_max:                                              \
+    case s390_minmax_fmax:                                                     \
+    case s390_minmax_cpp_alg_max:                                              \
+        if (float##BITS##_le_quiet(a, b, s)) {                                 \
+            return b;                                                          \
+        }                                                                      \
+        return a;                                                              \
+    default:                                                                   \
+        g_assert_not_reached();                                                \
+    }                                                                          \
+}
+
+#define S390_MINMAX_ABS(BITS, TYPE)                                            \
+static float##BITS TYPE##_abs##BITS(float##BITS a, float##BITS b,              \
+                                    float_status *s)                           \
+{                                                                              \
+    return TYPE##BITS(float##BITS##_abs(a), float##BITS##_abs(b), s);          \
+}
+
+S390_MINMAX(32, s390_minmax_java_math_min)
+S390_MINMAX(32, s390_minmax_java_math_max)
+S390_MINMAX(32, s390_minmax_c_macro_min)
+S390_MINMAX(32, s390_minmax_c_macro_max)
+S390_MINMAX(32, s390_minmax_fmin)
+S390_MINMAX(32, s390_minmax_fmax)
+S390_MINMAX(32, s390_minmax_cpp_alg_min)
+S390_MINMAX(32, s390_minmax_cpp_alg_max)
+S390_MINMAX_ABS(32, s390_minmax_java_math_min)
+S390_MINMAX_ABS(32, s390_minmax_java_math_max)
+S390_MINMAX_ABS(32, s390_minmax_c_macro_min)
+S390_MINMAX_ABS(32, s390_minmax_c_macro_max)
+S390_MINMAX_ABS(32, s390_minmax_fmin)
+S390_MINMAX_ABS(32, s390_minmax_fmax)
+S390_MINMAX_ABS(32, s390_minmax_cpp_alg_min)
+S390_MINMAX_ABS(32, s390_minmax_cpp_alg_max)
+
+S390_MINMAX(64, s390_minmax_java_math_min)
+S390_MINMAX(64, s390_minmax_java_math_max)
+S390_MINMAX(64, s390_minmax_c_macro_min)
+S390_MINMAX(64, s390_minmax_c_macro_max)
+S390_MINMAX(64, s390_minmax_fmin)
+S390_MINMAX(64, s390_minmax_fmax)
+S390_MINMAX(64, s390_minmax_cpp_alg_min)
+S390_MINMAX(64, s390_minmax_cpp_alg_max)
+S390_MINMAX_ABS(64, s390_minmax_java_math_min)
+S390_MINMAX_ABS(64, s390_minmax_java_math_max)
+S390_MINMAX_ABS(64, s390_minmax_c_macro_min)
+S390_MINMAX_ABS(64, s390_minmax_c_macro_max)
+S390_MINMAX_ABS(64, s390_minmax_fmin)
+S390_MINMAX_ABS(64, s390_minmax_fmax)
+S390_MINMAX_ABS(64, s390_minmax_cpp_alg_min)
+S390_MINMAX_ABS(64, s390_minmax_cpp_alg_max)
+
+S390_MINMAX(128, s390_minmax_java_math_min)
+S390_MINMAX(128, s390_minmax_java_math_max)
+S390_MINMAX(128, s390_minmax_c_macro_min)
+S390_MINMAX(128, s390_minmax_c_macro_max)
+S390_MINMAX(128, s390_minmax_fmin)
+S390_MINMAX(128, s390_minmax_fmax)
+S390_MINMAX(128, s390_minmax_cpp_alg_min)
+S390_MINMAX(128, s390_minmax_cpp_alg_max)
+S390_MINMAX_ABS(128, s390_minmax_java_math_min)
+S390_MINMAX_ABS(128, s390_minmax_java_math_max)
+S390_MINMAX_ABS(128, s390_minmax_c_macro_min)
+S390_MINMAX_ABS(128, s390_minmax_c_macro_max)
+S390_MINMAX_ABS(128, s390_minmax_fmin)
+S390_MINMAX_ABS(128, s390_minmax_fmax)
+S390_MINMAX_ABS(128, s390_minmax_cpp_alg_min)
+S390_MINMAX_ABS(128, s390_minmax_cpp_alg_max)
+
+static vop32_3_fn const vfmax_fns32[16] = {
+    [0] = float32_maxnum,
+    [1] = s390_minmax_java_math_max32,
+    [2] = s390_minmax_c_macro_max32,
+    [3] = s390_minmax_cpp_alg_max32,
+    [4] = s390_minmax_fmax32,
+    [8] = float32_maxnummag,
+    [9] = s390_minmax_java_math_max_abs32,
+    [10] = s390_minmax_c_macro_max_abs32,
+    [11] = s390_minmax_cpp_alg_max_abs32,
+    [12] = s390_minmax_fmax_abs32,
+};
+
+static vop64_3_fn const vfmax_fns64[16] = {
+    [0] = float64_maxnum,
+    [1] = s390_minmax_java_math_max64,
+    [2] = s390_minmax_c_macro_max64,
+    [3] = s390_minmax_cpp_alg_max64,
+    [4] = s390_minmax_fmax64,
+    [8] = float64_maxnummag,
+    [9] = s390_minmax_java_math_max_abs64,
+    [10] = s390_minmax_c_macro_max_abs64,
+    [11] = s390_minmax_cpp_alg_max_abs64,
+    [12] = s390_minmax_fmax_abs64,
+};
+
+static vop128_3_fn const vfmax_fns128[16] = {
+    [0] = float128_maxnum,
+    [1] = s390_minmax_java_math_max128,
+    [2] = s390_minmax_c_macro_max128,
+    [3] = s390_minmax_cpp_alg_max128,
+    [4] = s390_minmax_fmax128,
+    [8] = float128_maxnummag,
+    [9] = s390_minmax_java_math_max_abs128,
+    [10] = s390_minmax_c_macro_max_abs128,
+    [11] = s390_minmax_cpp_alg_max_abs128,
+    [12] = s390_minmax_fmax_abs128,
+};
+
+#define DEF_GVEC_VFMAX(BITS)                                                   \
+void HELPER(gvec_vfmax##BITS)(void *v1, const void *v2, const void *v3,        \
+                              CPUS390XState *env, uint32_t desc)               \
+{                                                                              \
+    vop##BITS##_3_fn fn = vfmax_fns##BITS[simd_data(desc)];                    \
+                                                                               \
+    g_assert(fn);                                                              \
+    vop##BITS##_3(v1, v2, v3, env, false, fn, GETPC());                        \
+}
+DEF_GVEC_VFMAX(32)
+DEF_GVEC_VFMAX(64)
+DEF_GVEC_VFMAX(128)
+
+#define DEF_GVEC_VFMAX_S(BITS)                                                 \
+void HELPER(gvec_vfmax##BITS##s)(void *v1, const void *v2, const void *v3,     \
+                                 CPUS390XState *env, uint32_t desc)            \
+{                                                                              \
+    vop##BITS##_3_fn fn = vfmax_fns##BITS[simd_data(desc)];                    \
+                                                                               \
+    g_assert(fn);                                                              \
+    vop##BITS##_3(v1, v2, v3, env, true, fn, GETPC());                         \
+}
+DEF_GVEC_VFMAX_S(32)
+DEF_GVEC_VFMAX_S(64)
+
+static vop32_3_fn const vfmin_fns32[16] = {
+    [0] = float32_minnum,
+    [1] = s390_minmax_java_math_min32,
+    [2] = s390_minmax_c_macro_min32,
+    [3] = s390_minmax_cpp_alg_min32,
+    [4] = s390_minmax_fmin32,
+    [8] = float32_minnummag,
+    [9] = s390_minmax_java_math_min_abs32,
+    [10] = s390_minmax_c_macro_min_abs32,
+    [11] = s390_minmax_cpp_alg_min_abs32,
+    [12] = s390_minmax_fmin_abs32,
+};
+
+static vop64_3_fn const vfmin_fns64[16] = {
+    [0] = float64_minnum,
+    [1] = s390_minmax_java_math_min64,
+    [2] = s390_minmax_c_macro_min64,
+    [3] = s390_minmax_cpp_alg_min64,
+    [4] = s390_minmax_fmin64,
+    [8] = float64_minnummag,
+    [9] = s390_minmax_java_math_min_abs64,
+    [10] = s390_minmax_c_macro_min_abs64,
+    [11] = s390_minmax_cpp_alg_min_abs64,
+    [12] = s390_minmax_fmin_abs64,
+};
+
+static vop128_3_fn const vfmin_fns128[16] = {
+    [0] = float128_minnum,
+    [1] = s390_minmax_java_math_min128,
+    [2] = s390_minmax_c_macro_min128,
+    [3] = s390_minmax_cpp_alg_min128,
+    [4] = s390_minmax_fmin128,
+    [8] = float128_minnummag,
+    [9] = s390_minmax_java_math_min_abs128,
+    [10] = s390_minmax_c_macro_min_abs128,
+    [11] = s390_minmax_cpp_alg_min_abs128,
+    [12] = s390_minmax_fmin_abs128,
+};
+
+#define DEF_GVEC_VFMIN(BITS)                                                   \
+void HELPER(gvec_vfmin##BITS)(void *v1, const void *v2, const void *v3,        \
+                              CPUS390XState *env, uint32_t desc)               \
+{                                                                              \
+    vop##BITS##_3_fn fn = vfmin_fns##BITS[simd_data(desc)];                    \
+                                                                               \
+    g_assert(fn);                                                              \
+    vop##BITS##_3(v1, v2, v3, env, false, fn, GETPC());                        \
+}
+DEF_GVEC_VFMIN(32)
+DEF_GVEC_VFMIN(64)
+DEF_GVEC_VFMIN(128)
+
+#define DEF_GVEC_VFMIN_S(BITS)                                                 \
+void HELPER(gvec_vfmin##BITS##s)(void *v1, const void *v2, const void *v3,     \
+                                 CPUS390XState *env, uint32_t desc)            \
+{                                                                              \
+    vop##BITS##_3_fn fn = vfmin_fns##BITS[simd_data(desc)];                    \
+                                                                               \
+    g_assert(fn);                                                              \
+    vop##BITS##_3(v1, v2, v3, env, true, fn, GETPC());                         \
+}
+DEF_GVEC_VFMIN_S(32)
+DEF_GVEC_VFMIN_S(64)
-- 
2.26.2


