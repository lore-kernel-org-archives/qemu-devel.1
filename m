Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60060C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3316F2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3316F2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiL6F-0006Ds-CS
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL3V-0001Yl-8k
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:55:25 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:8930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL3Q-0000yK-GV
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:55:24 -0400
IronPort-SDR: Khmbr5fiZqI6t24vgc6puH3jNWBnRnTSx1gJfTQcMe9/CO+dqeqkI2fEK/2BaOMQnrkP3ambwc
 eRPed7mxWkO587DYyl+eGoy/TKNAtURc5KsgkTwbrAviEkOdKDQUCu9LMm0wlPj40EEAanQHtk
 ieUWPw64QTAC+9GtfCQGVCaj2mJlzHnYE/2cIDG8c0Oa83vTZ/jSq6lZpp7teT5b4Bn/WWL1bH
 Pu3iU1djgpx6W5HYcGISEDsLYdmD1K9Rcqdu+Yzl0Bc7yih1CLKGYVRtAIMEdkf4Y4WMZzkIZb
 9lE=
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; d="scan'208";a="49689833"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 08 Jun 2020 08:55:17 -0800
IronPort-SDR: fduFEj/KvJtcW19ZwVW2A2cJDBiphUnRo/1Adt8HUYpAEUvgwKDG7BAknr61WOtkXPEWQ3rYk8
 UQ7+RuDzAfPU6YPd9Od0lAvtjnuQtMdt/6QMIubySVQkIBkJgZW4jlc073FPiRiJhistiQCdIi
 SDr4suwAsbIEexOOyWN/RcF0w24jJEHegTPOoLWfTBZlE6qaeXOJxDX6opf4sSzses6x5W5S9Q
 ArHJ3ykQfPhJ+M4coTI1o6V25GNqIhBLhY2xsmLBNUQPcimyD66r2hOaKn0g6RKmqD75bsed2Q
 ZUs=
Date: Mon, 8 Jun 2020 16:55:11 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <laurent@vivier.eu>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH v2 1/6] softfloat: merge floatx80_mod and floatx80_rem
In-Reply-To: <alpine.DEB.2.21.2006081653080.23637@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006081654280.23637@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006081653080.23637@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 12:55:19
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 fpu/softfloat.c         | 49 ++++++++++++++++++------
 include/fpu/softfloat.h |  2 +
 target/m68k/softfloat.c | 83 -----------------------------------------
 target/m68k/softfloat.h |  1 -
 4 files changed, 40 insertions(+), 95 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6c8f2d597a..7b1ce7664f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5682,10 +5682,13 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
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
@@ -5731,7 +5734,7 @@ floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
     expDiff = aExp - bExp;
     aSig1 = 0;
     if ( expDiff < 0 ) {
-        if ( expDiff < -1 ) return a;
+        if ( mod || expDiff < -1 ) return a;
         shift128Right( aSig0, 0, 1, &aSig0, &aSig1 );
         expDiff = 0;
     }
@@ -5763,14 +5766,16 @@ floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
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
@@ -5778,6 +5783,28 @@ floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
 
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
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

