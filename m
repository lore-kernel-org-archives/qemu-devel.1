Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870DDC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0B2214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0B2214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyGn-0006kD-9A
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8U-0005g3-1p
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8Q-0003Gm-3B
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23885)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8P-0003Do-PI
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:00:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 381FF106E978;
 Tue, 20 Aug 2019 07:00:46 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D624D11E52C;
 Tue, 20 Aug 2019 07:00:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:33 +0200
Message-Id: <1566284395-30287-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 20 Aug 2019 07:00:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/36] target/i386: Return 'indefinite integer
 value' for invalid SSE fp->int conversions
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The x86 architecture requires that all conversions from floating
point to integer which raise the 'invalid' exception (infinities of
both signs, NaN, and all values which don't fit in the destination
integer) return what the x86 spec calls the "indefinite integer
value", which is 0x8000_0000 for 32-bits or 0x8000_0000_0000_0000 for
64-bits.  The softfloat functions return the more usual behaviour of
positive overflows returning the maximum value that fits in the
destination integer format and negative overflows returning the
minimum value that fits.

Wrap the softfloat functions in x86-specific versions which
detect the 'invalid' condition and return the indefinite integer.

Note that we don't use these wrappers for the 3DNow! pf2id and pf2iw
instructions, which do return the minimum value that fits in
an int32 if the input float is a large negative number.

Fixes: https://bugs.launchpad.net/qemu/+bug/1815423
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190805180332.10185-1-peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/ops_sse.h | 88 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 28 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index ed05989..ec1ec74 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -710,102 +710,134 @@ void helper_cvtsq2sd(CPUX86State *env, ZMMReg *d, uint64_t val)
 #endif
 
 /* float to integer */
+
+/*
+ * x86 mandates that we return the indefinite integer value for the result
+ * of any float-to-integer conversion that raises the 'invalid' exception.
+ * Wrap the softfloat functions to get this behaviour.
+ */
+#define WRAP_FLOATCONV(RETTYPE, FN, FLOATTYPE, INDEFVALUE)              \
+    static inline RETTYPE x86_##FN(FLOATTYPE a, float_status *s)        \
+    {                                                                   \
+        int oldflags, newflags;                                         \
+        RETTYPE r;                                                      \
+                                                                        \
+        oldflags = get_float_exception_flags(s);                        \
+        set_float_exception_flags(0, s);                                \
+        r = FN(a, s);                                                   \
+        newflags = get_float_exception_flags(s);                        \
+        if (newflags & float_flag_invalid) {                            \
+            r = INDEFVALUE;                                             \
+        }                                                               \
+        set_float_exception_flags(newflags | oldflags, s);              \
+        return r;                                                       \
+    }
+
+WRAP_FLOATCONV(int32_t, float32_to_int32, float32, INT32_MIN)
+WRAP_FLOATCONV(int32_t, float32_to_int32_round_to_zero, float32, INT32_MIN)
+WRAP_FLOATCONV(int32_t, float64_to_int32, float64, INT32_MIN)
+WRAP_FLOATCONV(int32_t, float64_to_int32_round_to_zero, float64, INT32_MIN)
+WRAP_FLOATCONV(int64_t, float32_to_int64, float32, INT64_MIN)
+WRAP_FLOATCONV(int64_t, float32_to_int64_round_to_zero, float32, INT64_MIN)
+WRAP_FLOATCONV(int64_t, float64_to_int64, float64, INT64_MIN)
+WRAP_FLOATCONV(int64_t, float64_to_int64_round_to_zero, float64, INT64_MIN)
+
 void helper_cvtps2dq(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
-    d->ZMM_L(0) = float32_to_int32(s->ZMM_S(0), &env->sse_status);
-    d->ZMM_L(1) = float32_to_int32(s->ZMM_S(1), &env->sse_status);
-    d->ZMM_L(2) = float32_to_int32(s->ZMM_S(2), &env->sse_status);
-    d->ZMM_L(3) = float32_to_int32(s->ZMM_S(3), &env->sse_status);
+    d->ZMM_L(0) = x86_float32_to_int32(s->ZMM_S(0), &env->sse_status);
+    d->ZMM_L(1) = x86_float32_to_int32(s->ZMM_S(1), &env->sse_status);
+    d->ZMM_L(2) = x86_float32_to_int32(s->ZMM_S(2), &env->sse_status);
+    d->ZMM_L(3) = x86_float32_to_int32(s->ZMM_S(3), &env->sse_status);
 }
 
 void helper_cvtpd2dq(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
-    d->ZMM_L(0) = float64_to_int32(s->ZMM_D(0), &env->sse_status);
-    d->ZMM_L(1) = float64_to_int32(s->ZMM_D(1), &env->sse_status);
+    d->ZMM_L(0) = x86_float64_to_int32(s->ZMM_D(0), &env->sse_status);
+    d->ZMM_L(1) = x86_float64_to_int32(s->ZMM_D(1), &env->sse_status);
     d->ZMM_Q(1) = 0;
 }
 
 void helper_cvtps2pi(CPUX86State *env, MMXReg *d, ZMMReg *s)
 {
-    d->MMX_L(0) = float32_to_int32(s->ZMM_S(0), &env->sse_status);
-    d->MMX_L(1) = float32_to_int32(s->ZMM_S(1), &env->sse_status);
+    d->MMX_L(0) = x86_float32_to_int32(s->ZMM_S(0), &env->sse_status);
+    d->MMX_L(1) = x86_float32_to_int32(s->ZMM_S(1), &env->sse_status);
 }
 
 void helper_cvtpd2pi(CPUX86State *env, MMXReg *d, ZMMReg *s)
 {
-    d->MMX_L(0) = float64_to_int32(s->ZMM_D(0), &env->sse_status);
-    d->MMX_L(1) = float64_to_int32(s->ZMM_D(1), &env->sse_status);
+    d->MMX_L(0) = x86_float64_to_int32(s->ZMM_D(0), &env->sse_status);
+    d->MMX_L(1) = x86_float64_to_int32(s->ZMM_D(1), &env->sse_status);
 }
 
 int32_t helper_cvtss2si(CPUX86State *env, ZMMReg *s)
 {
-    return float32_to_int32(s->ZMM_S(0), &env->sse_status);
+    return x86_float32_to_int32(s->ZMM_S(0), &env->sse_status);
 }
 
 int32_t helper_cvtsd2si(CPUX86State *env, ZMMReg *s)
 {
-    return float64_to_int32(s->ZMM_D(0), &env->sse_status);
+    return x86_float64_to_int32(s->ZMM_D(0), &env->sse_status);
 }
 
 #ifdef TARGET_X86_64
 int64_t helper_cvtss2sq(CPUX86State *env, ZMMReg *s)
 {
-    return float32_to_int64(s->ZMM_S(0), &env->sse_status);
+    return x86_float32_to_int64(s->ZMM_S(0), &env->sse_status);
 }
 
 int64_t helper_cvtsd2sq(CPUX86State *env, ZMMReg *s)
 {
-    return float64_to_int64(s->ZMM_D(0), &env->sse_status);
+    return x86_float64_to_int64(s->ZMM_D(0), &env->sse_status);
 }
 #endif
 
 /* float to integer truncated */
 void helper_cvttps2dq(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
-    d->ZMM_L(0) = float32_to_int32_round_to_zero(s->ZMM_S(0), &env->sse_status);
-    d->ZMM_L(1) = float32_to_int32_round_to_zero(s->ZMM_S(1), &env->sse_status);
-    d->ZMM_L(2) = float32_to_int32_round_to_zero(s->ZMM_S(2), &env->sse_status);
-    d->ZMM_L(3) = float32_to_int32_round_to_zero(s->ZMM_S(3), &env->sse_status);
+    d->ZMM_L(0) = x86_float32_to_int32_round_to_zero(s->ZMM_S(0), &env->sse_status);
+    d->ZMM_L(1) = x86_float32_to_int32_round_to_zero(s->ZMM_S(1), &env->sse_status);
+    d->ZMM_L(2) = x86_float32_to_int32_round_to_zero(s->ZMM_S(2), &env->sse_status);
+    d->ZMM_L(3) = x86_float32_to_int32_round_to_zero(s->ZMM_S(3), &env->sse_status);
 }
 
 void helper_cvttpd2dq(CPUX86State *env, ZMMReg *d, ZMMReg *s)
 {
-    d->ZMM_L(0) = float64_to_int32_round_to_zero(s->ZMM_D(0), &env->sse_status);
-    d->ZMM_L(1) = float64_to_int32_round_to_zero(s->ZMM_D(1), &env->sse_status);
+    d->ZMM_L(0) = x86_float64_to_int32_round_to_zero(s->ZMM_D(0), &env->sse_status);
+    d->ZMM_L(1) = x86_float64_to_int32_round_to_zero(s->ZMM_D(1), &env->sse_status);
     d->ZMM_Q(1) = 0;
 }
 
 void helper_cvttps2pi(CPUX86State *env, MMXReg *d, ZMMReg *s)
 {
-    d->MMX_L(0) = float32_to_int32_round_to_zero(s->ZMM_S(0), &env->sse_status);
-    d->MMX_L(1) = float32_to_int32_round_to_zero(s->ZMM_S(1), &env->sse_status);
+    d->MMX_L(0) = x86_float32_to_int32_round_to_zero(s->ZMM_S(0), &env->sse_status);
+    d->MMX_L(1) = x86_float32_to_int32_round_to_zero(s->ZMM_S(1), &env->sse_status);
 }
 
 void helper_cvttpd2pi(CPUX86State *env, MMXReg *d, ZMMReg *s)
 {
-    d->MMX_L(0) = float64_to_int32_round_to_zero(s->ZMM_D(0), &env->sse_status);
-    d->MMX_L(1) = float64_to_int32_round_to_zero(s->ZMM_D(1), &env->sse_status);
+    d->MMX_L(0) = x86_float64_to_int32_round_to_zero(s->ZMM_D(0), &env->sse_status);
+    d->MMX_L(1) = x86_float64_to_int32_round_to_zero(s->ZMM_D(1), &env->sse_status);
 }
 
 int32_t helper_cvttss2si(CPUX86State *env, ZMMReg *s)
 {
-    return float32_to_int32_round_to_zero(s->ZMM_S(0), &env->sse_status);
+    return x86_float32_to_int32_round_to_zero(s->ZMM_S(0), &env->sse_status);
 }
 
 int32_t helper_cvttsd2si(CPUX86State *env, ZMMReg *s)
 {
-    return float64_to_int32_round_to_zero(s->ZMM_D(0), &env->sse_status);
+    return x86_float64_to_int32_round_to_zero(s->ZMM_D(0), &env->sse_status);
 }
 
 #ifdef TARGET_X86_64
 int64_t helper_cvttss2sq(CPUX86State *env, ZMMReg *s)
 {
-    return float32_to_int64_round_to_zero(s->ZMM_S(0), &env->sse_status);
+    return x86_float32_to_int64_round_to_zero(s->ZMM_S(0), &env->sse_status);
 }
 
 int64_t helper_cvttsd2sq(CPUX86State *env, ZMMReg *s)
 {
-    return float64_to_int64_round_to_zero(s->ZMM_D(0), &env->sse_status);
+    return x86_float64_to_int64_round_to_zero(s->ZMM_D(0), &env->sse_status);
 }
 #endif
 
-- 
1.8.3.1



