Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C775AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939652084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlNQIRIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939652084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo35X-0005Aa-RZ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zs-0001Ki-1j
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zp-0001Mv-5i
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfWmKVtlzJzmVnGlIOqAhf5WncSgnYrib8hvRbYqs8c=;
 b=VlNQIRIQ/00p8RkIeg1A74XqzmJ6irR4hKyZp10mxhN8rO/VDgF/DVpO6mqgZdPOaSMBwR
 CbF90AHPRQOh1txKlhy/Yub8Exyeh2gUUTRNgcS83t+kw8BOuwetaQFP1AZJznoZQWqA/y
 GsaNlgmG0OXqgQ/m73Epp3GogAgzjVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-zlVWYBeWMImNMkGWZ_7LJQ-1; Wed, 24 Jun 2020 06:51:08 -0400
X-MC-Unique: zlVWYBeWMImNMkGWZ_7LJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 477CF8015F6;
 Wed, 24 Jun 2020 10:51:07 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE84B5D9C5;
 Wed, 24 Jun 2020 10:51:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/31] softfloat: do not return pseudo-denormal from floatx80
 remainder
Date: Wed, 24 Jun 2020 06:50:34 -0400
Message-Id: <20200624105048.375353-17-pbonzini@redhat.com>
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

The floatx80 remainder implementation sometimes returns the numerator
unchanged when the denominator is sufficiently larger than the
numerator.  But if the value to be returned unchanged is a
pseudo-denormal, that is incorrect.  Fix it to normalize the numerator
in that case.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <alpine.DEB.2.21.2006081655520.23637@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 fpu/softfloat.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f164b5c0ad..ab50088c35 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5706,7 +5706,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
                          float_status *status)
 {
     bool aSign, zSign;
-    int32_t aExp, bExp, expDiff;
+    int32_t aExp, bExp, expDiff, aExpOrig;
     uint64_t aSig0, aSig1, bSig;
     uint64_t q, term0, term1, alternateASig0, alternateASig1;
 
@@ -5715,7 +5715,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         return floatx80_default_nan(status);
     }
     aSig0 = extractFloatx80Frac( a );
-    aExp = extractFloatx80Exp( a );
+    aExpOrig = aExp = extractFloatx80Exp( a );
     aSign = extractFloatx80Sign( a );
     bSig = extractFloatx80Frac( b );
     bExp = extractFloatx80Exp( b );
@@ -5730,6 +5730,13 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
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
@@ -5749,7 +5756,16 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
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
2.26.2



