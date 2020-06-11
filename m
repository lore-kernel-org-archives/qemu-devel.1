Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32284C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A5E2068E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/akjp+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A5E2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTbn-0004SQ-2W
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8y-0007ys-3P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8s-000123-Dq
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7pqCnSjTR2PzSL+AfGbFKdpToycd8SKN9cXtHQcKSko=;
 b=U/akjp+YdMq2I6G/7AR9okt3hteO/0A2aZe6hpSz5HMuoC9qP5fF9ALZFBHRdc6CzL+ld5
 3ctO1Stx7fDzI93piTzvktyhtOnCoPjibVpu1PyyYqsO4O4/iS5yPCRWueFoaowFzpMZEb
 31LNWLR2DPcGaiXRQoRdhWeo9ZcKCJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-cUdRcWTjPWyjC3MWTIT2Kg-1; Thu, 11 Jun 2020 15:45:35 -0400
X-MC-Unique: cUdRcWTjPWyjC3MWTIT2Kg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BFAE1800D41;
 Thu, 11 Jun 2020 19:45:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12AD38FF88;
 Thu, 11 Jun 2020 19:45:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 053/115] target/i386: fix fscale handling of invalid exponent
 encodings
Date: Thu, 11 Jun 2020 15:43:47 -0400
Message-Id: <20200611194449.31468-54-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

The fscale implementation does not check for invalid encodings in the
exponent operand, thus treating them like INT_MIN (the value returned
for invalid encodings by floatx80_to_int32_round_to_zero).  Fix it to
treat them similarly to signaling NaN exponents, thus generating a
quiet NaN result.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2005070044190.18350@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c          |  5 ++++-
 tests/tcg/i386/test-i386-fscale.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 0671de6952..10ff90370e 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -968,7 +968,10 @@ void helper_frndint(CPUX86State *env)
 
 void helper_fscale(CPUX86State *env)
 {
-    if (floatx80_is_any_nan(ST1)) {
+    if (floatx80_invalid_encoding(ST1)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST0 = floatx80_default_nan(&env->fp_status);
+    } else if (floatx80_is_any_nan(ST1)) {
         ST0 = ST1;
         if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
             float_raise(float_flag_invalid, &env->fp_status);
diff --git a/tests/tcg/i386/test-i386-fscale.c b/tests/tcg/i386/test-i386-fscale.c
index aecac5125f..b65a055d0a 100644
--- a/tests/tcg/i386/test-i386-fscale.c
+++ b/tests/tcg/i386/test-i386-fscale.c
@@ -8,6 +8,11 @@ union u {
     long double ld;
 };
 
+volatile union u ld_invalid_1 = { .s = { 1, 1234 } };
+volatile union u ld_invalid_2 = { .s = { 0, 1234 } };
+volatile union u ld_invalid_3 = { .s = { 0, 0x7fff } };
+volatile union u ld_invalid_4 = { .s = { (UINT64_C(1) << 63) - 1, 0x7fff } };
+
 volatile long double ld_res;
 
 int isnan_ld(long double x)
@@ -33,5 +38,29 @@ int main(void)
         printf("FAIL: fscale snan\n");
         ret = 1;
     }
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (2.5L), "u" (ld_invalid_1.ld));
+    if (!isnan_ld(ld_res) || issignaling_ld(ld_res)) {
+        printf("FAIL: fscale invalid 1\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (2.5L), "u" (ld_invalid_2.ld));
+    if (!isnan_ld(ld_res) || issignaling_ld(ld_res)) {
+        printf("FAIL: fscale invalid 2\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (2.5L), "u" (ld_invalid_3.ld));
+    if (!isnan_ld(ld_res) || issignaling_ld(ld_res)) {
+        printf("FAIL: fscale invalid 3\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (2.5L), "u" (ld_invalid_4.ld));
+    if (!isnan_ld(ld_res) || issignaling_ld(ld_res)) {
+        printf("FAIL: fscale invalid 4\n");
+        ret = 1;
+    }
     return ret;
 }
-- 
2.26.2



