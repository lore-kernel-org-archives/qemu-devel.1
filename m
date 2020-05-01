Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB19BC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 00:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73646208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 00:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73646208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUJhE-0006KH-EH
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 20:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joseph_myers@mentor.com>) id 1jUJgK-0005ft-IB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 20:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <joseph_myers@mentor.com>) id 1jUJg5-0005XS-MP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 20:37:32 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:58032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jUJg3-0005IV-Dl
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 20:37:15 -0400
IronPort-SDR: d9STBZl0rUdSdhkP+IH+QcFwCu8TmtqQeS6LfenwG+nCE41pmJ0ZL1obMXJrDhcZItZYwUrBrG
 fpszhVU/Ea85zhkYQK7oF5KtSelH5ER8oNY43mgB3gscj/fRL3FYdT0RIhyt9eND8xNpQ7quu+
 CPIgVvbE8Zr1EdkkX+ddXKC59ncxe6VTw0isTqVsVVh/vULzTyBKptaozZW4YtYDHI5BJH7lUd
 UfbvA2n3ti0PlCgY6mN5BqpCxN1u3jOiISojezs+XapQZAYgkE9x3s7R7924GXskxjsLgOba0E
 E+I=
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400"; d="scan'208";a="48472346"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 30 Apr 2020 16:37:11 -0800
IronPort-SDR: 1/npmwckhFEIuLorwj/AiqSM6hSeI2Sgo+DvEJPwLDvLZTZaH8rgK9IwnSBTkC6NlqjnsySxZd
 C4l7xhRqEUViKOJEVXTp6bBiKjOtLEnEHl4nEqRpyrH2KWcPQU3zq7zVatKL72hCmdNJiLy4Ol
 J8ZP61Ug689sgFkiD28iM9kc21Qem6885l0KjTY+VIrkruOc72n8FDpc1bnRgAgjsQRDjazb22
 qM6JedJOpKWRenjrgORanv4jCmXjNnTwCZgL1frKm+b/KBxBB+heP+8EfeEaFIz7h8MQGYvBpF
 O68=
Date: Fri, 1 May 2020 00:37:06 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/4] softfloat: silence sNaN for conversions to/from floatx80
Message-ID: <alpine.DEB.2.21.2005010036120.30535@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 20:37:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 68.232.137.252
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

Conversions between IEEE floating-point formats should convert
signaling NaNs to quiet NaNs.  Most of those in QEMU's softfloat code
do so, but those for floatx80 fail to.  Fix those conversions to
silence signaling NaNs as well.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 fpu/softfloat.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index ae6ba71854..ac116c70b8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4498,7 +4498,9 @@ floatx80 float32_to_floatx80(float32 a, float_status *status)
     aSign = extractFloat32Sign( a );
     if ( aExp == 0xFF ) {
         if (aSig) {
-            return commonNaNToFloatx80(float32ToCommonNaN(a, status), status);
+            floatx80 res = commonNaNToFloatx80(float32ToCommonNaN(a, status),
+                                               status);
+            return floatx80_silence_nan(res, status);
         }
         return packFloatx80(aSign,
                             floatx80_infinity_high,
@@ -5016,7 +5018,9 @@ floatx80 float64_to_floatx80(float64 a, float_status *status)
     aSign = extractFloat64Sign( a );
     if ( aExp == 0x7FF ) {
         if (aSig) {
-            return commonNaNToFloatx80(float64ToCommonNaN(a, status), status);
+            floatx80 res = commonNaNToFloatx80(float64ToCommonNaN(a, status),
+                                               status);
+            return floatx80_silence_nan(res, status);
         }
         return packFloatx80(aSign,
                             floatx80_infinity_high,
@@ -5618,7 +5622,9 @@ float32 floatx80_to_float32(floatx80 a, float_status *status)
     aSign = extractFloatx80Sign( a );
     if ( aExp == 0x7FFF ) {
         if ( (uint64_t) ( aSig<<1 ) ) {
-            return commonNaNToFloat32(floatx80ToCommonNaN(a, status), status);
+            float32 res = commonNaNToFloat32(floatx80ToCommonNaN(a, status),
+                                             status);
+            return float32_silence_nan(res, status);
         }
         return packFloat32( aSign, 0xFF, 0 );
     }
@@ -5650,7 +5656,9 @@ float64 floatx80_to_float64(floatx80 a, float_status *status)
     aSign = extractFloatx80Sign( a );
     if ( aExp == 0x7FFF ) {
         if ( (uint64_t) ( aSig<<1 ) ) {
-            return commonNaNToFloat64(floatx80ToCommonNaN(a, status), status);
+            float64 res = commonNaNToFloat64(floatx80ToCommonNaN(a, status),
+                                             status);
+            return float64_silence_nan(res, status);
         }
         return packFloat64( aSign, 0x7FF, 0 );
     }
@@ -5681,7 +5689,9 @@ float128 floatx80_to_float128(floatx80 a, float_status *status)
     aExp = extractFloatx80Exp( a );
     aSign = extractFloatx80Sign( a );
     if ( ( aExp == 0x7FFF ) && (uint64_t) ( aSig<<1 ) ) {
-        return commonNaNToFloat128(floatx80ToCommonNaN(a, status), status);
+        float128 res = commonNaNToFloat128(floatx80ToCommonNaN(a, status),
+                                           status);
+        return float128_silence_nan(res, status);
     }
     shift128Right( aSig<<1, 0, 16, &zSig0, &zSig1 );
     return packFloat128( aSign, aExp, zSig0, zSig1 );
@@ -6959,7 +6969,9 @@ floatx80 float128_to_floatx80(float128 a, float_status *status)
     aSign = extractFloat128Sign( a );
     if ( aExp == 0x7FFF ) {
         if ( aSig0 | aSig1 ) {
-            return commonNaNToFloatx80(float128ToCommonNaN(a, status), status);
+            floatx80 res = commonNaNToFloatx80(float128ToCommonNaN(a, status),
+                                               status);
+            return floatx80_silence_nan(res, status);
         }
         return packFloatx80(aSign, floatx80_infinity_high,
                                    floatx80_infinity_low);
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

