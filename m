Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7137DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6942082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI4KIqXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6942082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3FC-0006cA-Fn
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zr-0001Js-ME
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zo-0001M7-II
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+e44PK7Fg88toihiGf2bKkm4Ptn4UtPgBDIsEqYnl0=;
 b=gI4KIqXDxqM6EhPdKeGCGuTpFfupg9HP64n2KXYWO984vnj+j0Mu7bS3mmkD7itajnvbky
 G53c/bohF0VIazp/t0NVvdYEnv+FcyRQRoHapUIYSlhzUnMR2Shb9IvNFHBCFCGyrwlBWH
 SKX8GtMpTfR6IENgBz2ANW3qe9g6Y+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-WhIw6673MHytzpkXEGEeLg-1; Wed, 24 Jun 2020 06:51:09 -0400
X-MC-Unique: WhIw6673MHytzpkXEGEeLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C142107ACCA;
 Wed, 24 Jun 2020 10:51:08 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E7DD5D9C5;
 Wed, 24 Jun 2020 10:51:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/31] softfloat: return low bits of quotient from
 floatx80_modrem
Date: Wed, 24 Jun 2020 06:50:36 -0400
Message-Id: <20200624105048.375353-19-pbonzini@redhat.com>
In-Reply-To: <20200624104917.375143-1-pbonzini@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
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
Message-Id: <alpine.DEB.2.21.2006081656500.23637@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 fpu/softfloat.c         | 23 ++++++++++++++++++-----
 include/fpu/softfloat.h |  3 ++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 1ee3342715..79be4f5840 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5699,10 +5699,11 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
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
@@ -5710,6 +5711,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
     uint64_t aSig0, aSig1, bSig;
     uint64_t q, term0, term1, alternateASig0, alternateASig1;
 
+    *quotient = 0;
     if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
         float_raise(float_flag_invalid, status);
         return floatx80_default_nan(status);
@@ -5768,7 +5770,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         shift128Right( aSig0, 0, 1, &aSig0, &aSig1 );
         expDiff = 0;
     }
-    q = ( bSig <= aSig0 );
+    *quotient = q = ( bSig <= aSig0 );
     if ( q ) aSig0 -= bSig;
     expDiff -= 64;
     while ( 0 < expDiff ) {
@@ -5778,6 +5780,8 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
         sub128( aSig0, aSig1, term0, term1, &aSig0, &aSig1 );
         shortShift128Left( aSig0, aSig1, 62, &aSig0, &aSig1 );
         expDiff -= 62;
+        *quotient <<= 62;
+        *quotient += q;
     }
     expDiff += 64;
     if ( 0 < expDiff ) {
@@ -5791,6 +5795,12 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
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
@@ -5805,6 +5815,7 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
             aSig0 = alternateASig0;
             aSig1 = alternateASig1;
             zSign = ! zSign;
+            ++*quotient;
         }
     }
     return
@@ -5821,7 +5832,8 @@ floatx80 floatx80_modrem(floatx80 a, floatx80 b, bool mod,
 
 floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
 {
-    return floatx80_modrem(a, b, false, status);
+    uint64_t quotient;
+    return floatx80_modrem(a, b, false, &quotient, status);
 }
 
 /*----------------------------------------------------------------------------
@@ -5832,7 +5844,8 @@ floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
 
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
2.26.2



