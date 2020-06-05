Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BD5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D692077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D692077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhHbe-0001Hj-Si
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 15:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHaD-0008PS-0l
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:00:49 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:23527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHaB-0006ti-TU
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:00:48 -0400
IronPort-SDR: o6OyhxX5WPW9Ivz+XOQSmu7wA963PKKC/fmCb2nUBqNhcVskOpK/i9QWucaKNx2RLlg8rTa5sN
 qLBaF3cjGQexwisqaWWjuw9TwFVRpoH2xhxV+p5nTKxhdzGuIEC09mUoZm2vwUbyw7Herulozj
 g/0rz8EjPAkDX94tzq4brxgPbvyC+mizFOrj3rBnI1SJt0utCd7McNnF2lKlLrAeI/RRenoFKV
 5aUd7cys9Rrmr4e0/+C+YkGXau3hhtejQTz2nodOEWbMtA9NM6IGx4CjVH050X7ibrL68uw/l8
 WxQ=
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; d="scan'208";a="49520896"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 05 Jun 2020 11:00:46 -0800
IronPort-SDR: BSk93enA7yO2QEG4arDdvltkG4B+ihlQv19LPP7LOT2XKUCNBupnNF79AJAIUwo7s1YZ/9WDx1
 yjfAB4x7YnUYIcW8Y/Nj3m3P1XrI0CMKE8+p34qf9ZE64pmDAai6Llm2AafNKqXp2H9gXgqQpJ
 Ve/uAay/ecrzmRZneg7LpTVBOjO1IfyMadYHoxm4aY/h25xE8DjPaFA6dGfrWLJY8P3LI/rzN2
 hfW5pC80CHU63IGWNQLi8tPDU3Mb/fNjrtaSUIAptu7nbJOs05bniMWQxGU55ry10a3FhHq9Av
 g/k=
Date: Fri, 5 Jun 2020 19:00:40 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <laurent@vivier.eu>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH 3/7] softfloat: do not return pseudo-denormal from floatx80
 remainder
In-Reply-To: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006051900130.13777@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
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

The floatx80 remainder implementation sometimes returns the numerator
unchanged when the denominator is sufficiently larger than the
numerator.  But if the value to be returned unchanged is a
pseudo-denormal, that is incorrect.  Fix it to normalize the numerator
in that case.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 fpu/softfloat.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 091847beb9..00f362af23 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5691,7 +5691,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
                          float_status *status)
 {
     bool aSign, zSign;
-    int32_t aExp, bExp, expDiff;
+    int32_t aExp, bExp, expDiff, aExpOrig;
     uint64_t aSig0, aSig1, bSig;
     uint64_t q, term0, term1, alternateASig0, alternateASig1;
 
@@ -5700,7 +5700,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         return floatx80_default_nan(status);
     }
     aSig0 = extractFloatx80Frac( a );
-    aExp = extractFloatx80Exp( a );
+    aExpOrig = aExp = extractFloatx80Exp( a );
     aSign = extractFloatx80Sign( a );
     bSig = extractFloatx80Frac( b );
     bExp = extractFloatx80Exp( b );
@@ -5715,6 +5715,11 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         if ((uint64_t)(bSig << 1)) {
             return propagateFloatx80NaN(a, b, status);
         }
+        if (aExp == 0 && aSig0 >> 63) {
+            /* Pseudo-denormal argument must be returned in normalized
+             * form.  */
+            return packFloatx80(aSign, 1, aSig0);
+        }
         return a;
     }
     if ( bExp == 0 ) {
@@ -5734,7 +5739,14 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
     expDiff = aExp - bExp;
     aSig1 = 0;
     if ( expDiff < 0 ) {
-        if ( mod || expDiff < -1 ) return a;
+        if ( mod || expDiff < -1 ) {
+            if (aExp == 1 && aExpOrig == 0) {
+                /* Pseudo-denormal argument must be returned in
+                 * normalized form.  */
+                return packFloatx80(aSign, aExp, aSig0);
+            }
+            return a;
+        }
         shift128Right( aSig0, 0, 1, &aSig0, &aSig1 );
         expDiff = 0;
     }
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

