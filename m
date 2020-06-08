Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CB6C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973022053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973022053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLB9-0004FF-NF
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL5R-0004sP-DY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:57:25 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:9046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL5Q-0001VG-6K
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:57:25 -0400
IronPort-SDR: L4DFM5pBJVnOB5D7ux5GBWd1sfxK9BQH5qL2ZPXOUbi4Xn45Z3U+ABpXPs72FSnohYBVblpSvZ
 b3r/wuigSkgehlKVJ3vZjH18QKypIYAvUxGIAxDq4qAbKw4htqlMw2IxDg8c8pWTosN5LxsqXj
 zwWkSu2kyVO8uD2uDwtXVI0eJ4h/ujOCYs0fQqHOlrW5nFFx6n4oh7SrVGajornb8et66+r/zh
 Yjxkzo7sH3Pqc88nr1uAm/UHR9x0gG+PIz0voFsXKxeiY/1/ezDVq/HOjr2xl2ZVJ/j5ViKZyV
 nuo=
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; d="scan'208";a="49689901"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 08 Jun 2020 08:57:22 -0800
IronPort-SDR: jke4R6POX1Lkh23iXyL1UHrNr7WeIOj7VOuSqAsu+rgZJhvPd1lKb1T9K/IzZkt/4N+3x8dY2K
 lGdRYAWTqol/lQe+lawd4N1QEsW9XuEeYUhMl4FIMekqMwSrWzpi+jqHEygtt1jIzpTDangcBH
 s9n/SME9uOQMrjM6vHAeQMVDaftvTu6Ly8giqpg0ifaFKV6vIxSUpUAslsGGwVKPB+Y0LBlBRL
 dMtaUIOXJq1TFj6Yrgd4UXIG96MPiWXAyAKb8IMeWftQte//hhR9WXcuDKKxbWfpy+a9GlIbaU
 WO8=
Date: Mon, 8 Jun 2020 16:57:16 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <laurent@vivier.eu>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH v2 5/6] softfloat: return low bits of quotient from
 floatx80_modrem
In-Reply-To: <alpine.DEB.2.21.2006081653080.23637@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006081656500.23637@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006081653080.23637@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
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

Both x87 and m68k need the low parts of the quotient for their
remainder operations.  Arrange for floatx80_modrem to track those bits
and return them via a pointer.

The architectures using float32_rem and float64_rem do not appear to
need this information, so the *_rem interface is left unchanged and
the information returned only from floatx80_modrem.  The logic used to
determine the low 7 bits of the quotient for m68k
(target/m68k/fpu_helper.c:make_quotient) appears completely bogus (it
looks at the result of converting the remainder to integer, the
quotient having been discarded by that point); this patch does not
change that, but the m68k maintainers may wish to do so.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c         | 23 ++++++++++++++++++-----
 include/fpu/softfloat.h |  3 ++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 1552241b5e..72f45b0103 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5684,10 +5684,11 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
 | `a' with respect to the corresponding value `b'.  The operation is performed
 | according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic,
 | if 'mod' is false; if 'mod' is true, return the remainder based on truncating
-| the quotient toward zero instead.
+| the quotient toward zero instead.  '*quotient' is set to the low 64 bits of
+| the absolute value of the integer quotient.
 *----------------------------------------------------------------------------*/
 
-floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
+floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod, uint64_t *quotient,
                          float_status *status)
 {
     bool aSign, zSign;
@@ -5695,6 +5696,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
     uint64_t aSig0, aSig1, bSig;
     uint64_t q, term0, term1, alternateASig0, alternateASig1;
 
+    *quotient = 0;
     if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
         float_raise(float_flag_invalid, status);
         return floatx80_default_nan(status);
@@ -5753,7 +5755,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         shift128Right( aSig0, 0, 1, &aSig0, &aSig1 );
         expDiff = 0;
     }
-    q = ( bSig <= aSig0 );
+    *quotient = q = ( bSig <= aSig0 );
     if ( q ) aSig0 -= bSig;
     expDiff -= 64;
     while ( 0 < expDiff ) {
@@ -5763,6 +5765,8 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         sub128( aSig0, aSig1, term0, term1, &aSig0, &aSig1 );
         shortShift128Left( aSig0, aSig1, 62, &aSig0, &aSig1 );
         expDiff -= 62;
+        *quotient <<= 62;
+        *quotient += q;
     }
     expDiff += 64;
     if ( 0 < expDiff ) {
@@ -5776,6 +5780,12 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
             ++q;
             sub128( aSig0, aSig1, term0, term1, &aSig0, &aSig1 );
         }
+        if (expDiff < 64) {
+            *quotient <<= expDiff;
+        } else {
+            *quotient = 0;
+        }
+        *quotient += q;
     }
     else {
         term1 = 0;
@@ -5790,6 +5800,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
             aSig0 = alternateASig0;
             aSig1 = alternateASig1;
             zSign = ! zSign;
+            ++*quotient;
         }
     }
     return
@@ -5806,7 +5817,8 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
 
 floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
 {
-    return floatx80_modrem(a, b, false, status);
+    uint64_t quotient;
+    return floatx80_modrem(a, b, false, &quotient, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -5817,7 +5829,8 @@ floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
 
 floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
 {
-    return floatx80_modrem(a, b, true, status);
+    uint64_t quotient;
+    return floatx80_modrem(a, b, true, &quotient, status);
 }
 
 /*----------------------------------------------------------------------------
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index bff6934d09..ff4e2605b1 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -687,7 +687,8 @@ floatx80 floatx80_add(floatx80, floatx80, float_status *status);
 floatx80 floatx80_sub(floatx80, floatx80, float_status *status);
 floatx80 floatx80_mul(floatx80, floatx80, float_status *status);
 floatx80 floatx80_div(floatx80, floatx80, float_status *status);
-floatx80 floatx80_modrem(floatx80, floatx80, bool, float_status *status);
+floatx80 floatx80_modrem(floatx80, floatx80, bool, uint64_t *,
+                         float_status *status);
 floatx80 floatx80_mod(floatx80, floatx80, float_status *status);
 floatx80 floatx80_rem(floatx80, floatx80, float_status *status);
 floatx80 floatx80_sqrt(floatx80, float_status *status);
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

