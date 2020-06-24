Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C20C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EC62084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlFjTPZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EC62084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3B8-000794-6X
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zo-0001DB-DM
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41778
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zm-0001KL-3H
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T5/wZjLCEsp1lyazGjz/ndKkahIrSai2gpYmKualu5A=;
 b=IlFjTPZd0fXGuFOXSr5E/YRhdbWhJbHL8jBXYs8/lugY2XJFNRksdLh60qDzl0CtIOHdNq
 p+88RGlmstBYR9z2jW6CY/UHgOlUzfoOFomSXkG+Ce0Ecki3p0813kMrZY2xkxqoWbSY+s
 3Uc9N6ypj8xcJ22sPy0b8lcmB64VwU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-y5LsWPHKMvW7l_HviO6cmA-1; Wed, 24 Jun 2020 06:51:07 -0400
X-MC-Unique: y5LsWPHKMvW7l_HviO6cmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1358718A8220;
 Wed, 24 Jun 2020 10:51:06 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3ACE05D9C5;
 Wed, 24 Jun 2020 10:51:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/31] softfloat: merge floatx80_mod and floatx80_rem
Date: Wed, 24 Jun 2020 06:50:32 -0400
Message-Id: <20200624105048.375353-15-pbonzini@redhat.com>
In-Reply-To: <20200624104917.375143-1-pbonzini@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

The m68k-specific softfloat code includes a function floatx80_mod that
is extremely similar to floatx80_rem, but computing the remainder
based on truncating the quotient toward zero rather than rounding it
to nearest integer.  This is also useful for emulating the x87 fprem
and fprem1 instructions.  Change the floatx80_rem implementation into
floatx80_modrem that can perform either operation, with both
floatx80_rem and floatx80_mod as thin wrappers available for all
targets.

There does not appear to be any use for the _mod operation for other
floating-point formats in QEMU (the only other architectures using
_rem at all are linux-user/arm/nwfpe, for FPA emulation, and openrisc,
for instructions that have been removed in the latest version of the
architecture), so no change is made to the code for other formats.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <alpine.DEB.2.21.2006081654280.23637@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 fpu/softfloat.c         | 49 ++++++++++++++++++------
 include/fpu/softfloat.h |  2 +
 target/m68k/softfloat.c | 83 -----------------------------------------
 target/m68k/softfloat.h |  1 -
 4 files changed, 40 insertions(+), 95 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5e9746c287..b7dcf4d6c3 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5697,10 +5697,13 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
 /*----------------------------------------------------------------------------
 | Returns the remainder of the extended double-precision floating-point value
 | `a' with respect to the corresponding value `b'.  The operation is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic,
+| if 'mod' is false; if 'mod' is true, return the remainder based on truncating
+| the quotient toward zero instead.
 *----------------------------------------------------------------------------*/
 
-floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
+floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
+                         float_status *status)
 {
     bool aSign, zSign;
     int32_t aExp, bExp, expDiff;
@@ -5746,7 +5749,7 @@ floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
     expDiff = aExp - bExp;
     aSig1 = 0;
     if ( expDiff < 0 ) {
-        if ( expDiff < -1 ) return a;
+        if ( mod || expDiff < -1 ) return a;
         shift128Right( aSig0, 0, 1, &aSig0, &aSig1 );
         expDiff = 0;
     }
@@ -5778,14 +5781,16 @@ floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
         term1 = 0;
         term0 = bSig;
     }
-    sub128( term0, term1, aSig0, aSig1, &alternateASig0, &alternateASig1 );
-    if (    lt128( alternateASig0, alternateASig1, aSig0, aSig1 )
-         || (    eq128( alternateASig0, alternateASig1, aSig0, aSig1 )
-              && ( q & 1 ) )
-       ) {
-        aSig0 = alternateASig0;
-        aSig1 = alternateASig1;
-        zSign = ! zSign;
+    if (!mod) {
+        sub128( term0, term1, aSig0, aSig1, &alternateASig0, &alternateASig1 );
+        if (    lt128( alternateASig0, alternateASig1, aSig0, aSig1 )
+                || (    eq128( alternateASig0, alternateASig1, aSig0, aSig1 )
+                        && ( q & 1 ) )
+            ) {
+            aSig0 = alternateASig0;
+            aSig1 = alternateASig1;
+            zSign = ! zSign;
+        }
     }
     return
         normalizeRoundAndPackFloatx80(
@@ -5793,6 +5798,28 @@ floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
 
 }
 
+/*----------------------------------------------------------------------------
+| Returns the remainder of the extended double-precision floating-point value
+| `a' with respect to the corresponding value `b'.  The operation is performed
+| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
+*----------------------------------------------------------------------------*/
+
+floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
+{
+    return floatx80_modrem(a, b, false, status);
+}
+
+/*----------------------------------------------------------------------------
+| Returns the remainder of the extended double-precision floating-point value
+| `a' with respect to the corresponding value `b', with the quotient truncated
+| toward zero.
+*----------------------------------------------------------------------------*/
+
+floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
+{
+    return floatx80_modrem(a, b, true, status);
+}
+
 /*----------------------------------------------------------------------------
 | Returns the square root of the extended double-precision floating-point
 | value `a'.  The operation is performed according to the IEC/IEEE Standard
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 16ca697a73..bff6934d09 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -687,6 +687,8 @@ floatx80 floatx80_add(floatx80, floatx80, float_status *status);
 floatx80 floatx80_sub(floatx80, floatx80, float_status *status);
 floatx80 floatx80_mul(floatx80, floatx80, float_status *status);
 floatx80 floatx80_div(floatx80, floatx80, float_status *status);
+floatx80 floatx80_modrem(floatx80, floatx80, bool, float_status *status);
+floatx80 floatx80_mod(floatx80, floatx80, float_status *status);
 floatx80 floatx80_rem(floatx80, floatx80, float_status *status);
 floatx80 floatx80_sqrt(floatx80, float_status *status);
 FloatRelation floatx80_compare(floatx80, floatx80, float_status *status);
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 9f120cf15e..b6d0ed7acf 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -42,89 +42,6 @@ static floatx80 propagateFloatx80NaNOneArg(floatx80 a, float_status *status)
     return a;
 }
 
-/*
- * Returns the modulo remainder of the extended double-precision floating-point
- * value `a' with respect to the corresponding value `b'.
- */
-
-floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
-{
-    bool aSign, zSign;
-    int32_t aExp, bExp, expDiff;
-    uint64_t aSig0, aSig1, bSig;
-    uint64_t qTemp, term0, term1;
-
-    aSig0 = extractFloatx80Frac(a);
-    aExp = extractFloatx80Exp(a);
-    aSign = extractFloatx80Sign(a);
-    bSig = extractFloatx80Frac(b);
-    bExp = extractFloatx80Exp(b);
-
-    if (aExp == 0x7FFF) {
-        if ((uint64_t) (aSig0 << 1)
-            || ((bExp == 0x7FFF) && (uint64_t) (bSig << 1))) {
-            return propagateFloatx80NaN(a, b, status);
-        }
-        goto invalid;
-    }
-    if (bExp == 0x7FFF) {
-        if ((uint64_t) (bSig << 1)) {
-            return propagateFloatx80NaN(a, b, status);
-        }
-        return a;
-    }
-    if (bExp == 0) {
-        if (bSig == 0) {
-        invalid:
-            float_raise(float_flag_invalid, status);
-            return floatx80_default_nan(status);
-        }
-        normalizeFloatx80Subnormal(bSig, &bExp, &bSig);
-    }
-    if (aExp == 0) {
-        if ((uint64_t) (aSig0 << 1) == 0) {
-            return a;
-        }
-        normalizeFloatx80Subnormal(aSig0, &aExp, &aSig0);
-    }
-    bSig |= UINT64_C(0x8000000000000000);
-    zSign = aSign;
-    expDiff = aExp - bExp;
-    aSig1 = 0;
-    if (expDiff < 0) {
-        return a;
-    }
-    qTemp = (bSig <= aSig0);
-    if (qTemp) {
-        aSig0 -= bSig;
-    }
-    expDiff -= 64;
-    while (0 < expDiff) {
-        qTemp = estimateDiv128To64(aSig0, aSig1, bSig);
-        qTemp = (2 < qTemp) ? qTemp - 2 : 0;
-        mul64To128(bSig, qTemp, &term0, &term1);
-        sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
-        shortShift128Left(aSig0, aSig1, 62, &aSig0, &aSig1);
-        expDiff -= 62;
-    }
-    expDiff += 64;
-    if (0 < expDiff) {
-        qTemp = estimateDiv128To64(aSig0, aSig1, bSig);
-        qTemp = (2 < qTemp) ? qTemp - 2 : 0;
-        qTemp >>= 64 - expDiff;
-        mul64To128(bSig, qTemp << (64 - expDiff), &term0, &term1);
-        sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
-        shortShift128Left(0, bSig, 64 - expDiff, &term0, &term1);
-        while (le128(term0, term1, aSig0, aSig1)) {
-            ++qTemp;
-            sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
-        }
-    }
-    return
-        normalizeRoundAndPackFloatx80(
-            80, zSign, bExp + expDiff, aSig0, aSig1, status);
-}
-
 /*
  * Returns the mantissa of the extended double-precision floating-point
  * value `a'.
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index 365ef6ac7a..4bb9567134 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -23,7 +23,6 @@
 #define TARGET_M68K_SOFTFLOAT_H
 #include "fpu/softfloat.h"
 
-floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status);
 floatx80 floatx80_getman(floatx80 a, float_status *status);
 floatx80 floatx80_getexp(floatx80 a, float_status *status);
 floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status);
-- 
2.26.2



