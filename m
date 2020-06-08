Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07ADC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466A72053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466A72053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiL9P-0001fq-Ek
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL4X-0003Kd-UB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:56:30 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:48649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jiL4X-0001LY-00
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:56:29 -0400
IronPort-SDR: kl0vj6Mr8xlsqc0ZPewTID8PjHyUVN5Bm0VuSHKD9aTHIFDsUxxwumKi1+j741QL8Z6GujWbI3
 Q9e8ABmBkVexa79LKrXOyk3bFyRY+Iz7ILFNcqUFTuLsPSeEkodOstO5RB+e8vddT8AK6iSgal
 VCMxO6EJxtE/ou5SSedK3U35fuP0bbgw+ipOwSsY2OvZBPgKENOH2g4PBZQ7fZpIbMS8JXxje6
 GQwtqdQMNJQOKomTqWf9bCwTwFt57B1vhlF7neMiRocUJjMSP840oKuX2xl9Tuhg2cXTDqsxeG
 OZw=
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; d="scan'208";a="51690305"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 08 Jun 2020 08:56:26 -0800
IronPort-SDR: +JtsbNUMQ1IT1m9Bp/ebcLXS3sI9oApZzrdNE5NNsOeKnbs1RVjviWzI7Xw6hXMgsrMA4/u1cw
 L4gToIW2LUVJEi2jm2LSyeVJbAvX2EL6h75NDZziarCbqf7vtLm8ZgFuXCJpMrorStt/+YBJmL
 NkOvv9k3Q0yx2G5ILwU40ePW3YaNplSWTdLPkPKFzwQL8XejcYqkXzw3Sf5P9hqgZF2e58bT5L
 55LH+rxTlKp+5EbzCSDUXLThKcfdxPyF4xGU/xLyfaDpwDEf4bNgEoLRkktTpP0iObFoeQPcY4
 ve0=
Date: Mon, 8 Jun 2020 16:56:20 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <laurent@vivier.eu>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH v2 3/6] softfloat: do not return pseudo-denormal from floatx80
 remainder
In-Reply-To: <alpine.DEB.2.21.2006081653080.23637@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006081655520.23637@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006081653080.23637@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 12:51:54
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 091847beb9..9d43868e4c 100644
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
@@ -5715,6 +5715,13 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         if ((uint64_t)(bSig << 1)) {
             return propagateFloatx80NaN(a, b, status);
         }
+        if (aExp == 0 && aSig0 >> 63) {
+            /*
+             * Pseudo-denormal argument must be returned in normalized
+             * form.
+             */
+            return packFloatx80(aSign, 1, aSig0);
+        }
         return a;
     }
     if ( bExp == 0 ) {
@@ -5734,7 +5741,16 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
     expDiff = aExp - bExp;
     aSig1 = 0;
     if ( expDiff < 0 ) {
-        if ( mod || expDiff < -1 ) return a;
+        if ( mod || expDiff < -1 ) {
+            if (aExp == 1 && aExpOrig == 0) {
+                /*
+                 * Pseudo-denormal argument must be returned in
+                 * normalized form.
+                 */
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

