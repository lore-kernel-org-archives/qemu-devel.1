Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715B7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D682077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D682077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhHdo-0004Lz-22
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 15:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHbH-00019D-E8
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:01:55 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:23580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHbG-00076X-63
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:01:54 -0400
IronPort-SDR: GESuwUlyosFx7RetCaBg7rzrfteYNguZE7SsASwaltADL/OLqJ8DyzdtgdqzMLBJ1Jnx50e+uf
 fYPMOrDWKfPZAbBBYWlSoomB3Y3ZJleHWXAMwEtC2/oBsBw0+tQTIfY/LvUnwstYXtW5JgblOH
 sSYwmPCu1yZKHgNWjkdid5wLit7nMMxk3NVYUztIOvyF/7A68rnJ0E1MTBQHIewxFsrqnuBetW
 /LHTvqcYVPfQXvUGIGw9HK+ByfGSeXPRNX3hdJvydHfpL6gU3Hx4ZNN2fHeHGZzbIJo1vRUhcU
 Hws=
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; d="scan'208";a="49520928"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 05 Jun 2020 11:01:52 -0800
IronPort-SDR: 0MqKEzmhVaRvFZrDZgkWBBV3SjyS1fZKaR7r85cI6dXFqt6lo92ZKt90CA7Qtsl96Br6VOGtFH
 X942gZLfkhce5SfNdlV/60t4tgu60xCD8P/CzHRssfy1bnouNkuvYjJza8e6Pwf0GjY7fcaR+Q
 SmiUwgOaQqcIjbjjV5U7NNxyhuEsI5R+dLDhBVshB0aC27X0k81PNi9i+Y0YR8wI9bnYy0wolz
 rEXbeK2lg2oidusI/tdKmWH+xYJVLIE3BwM4EGO4NKfgHVe7O5aPBx5t6Ao3G2pADPfgRmIV8g
 woM=
Date: Fri, 5 Jun 2020 19:01:46 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <laurent@vivier.eu>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH 5/7] softfloat: return low bits of quotient from
 floatx80_modrem
In-Reply-To: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006051901120.13777@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.141.98;
 envelope-from=joseph_myers@mentor.com; helo=esa2.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 14:58:48
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
---
 fpu/softfloat.c         | 23 ++++++++++++++++++-----
 include/fpu/softfloat.h |  3 ++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 423a815196..c3c3f382af 100644
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
@@ -5749,7 +5751,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         shift128Right( aSig0, 0, 1, &aSig0, &aSig1 );
         expDiff = 0;
     }
-    q = ( bSig <= aSig0 );
+    *quotient = q = ( bSig <= aSig0 );
     if ( q ) aSig0 -= bSig;
     expDiff -= 64;
     while ( 0 < expDiff ) {
@@ -5759,6 +5761,8 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         sub128( aSig0, aSig1, term0, term1, &aSig0, &aSig1 );
         shortShift128Left( aSig0, aSig1, 62, &aSig0, &aSig1 );
         expDiff -= 62;
+        *quotient <<= 62;
+        *quotient += q;
     }
     expDiff += 64;
     if ( 0 < expDiff ) {
@@ -5772,6 +5776,12 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
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
@@ -5786,6 +5796,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
             aSig0 = alternateASig0;
             aSig1 = alternateASig1;
             zSign = ! zSign;
+            ++*quotient;
         }
     }
     return
@@ -5802,7 +5813,8 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
 
 floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
 {
-    return floatx80_modrem(a, b, false, status);
+    uint64_t quotient;
+    return floatx80_modrem(a, b, false, &quotient, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -5813,7 +5825,8 @@ floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
 
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

