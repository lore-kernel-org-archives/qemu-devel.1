Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EC4C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A19B2064A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A19B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWUfp-0002FW-K0
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 20:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUew-0001JL-KF
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:45:06 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:6632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUev-0007N2-FQ
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:45:06 -0400
IronPort-SDR: RcBd7iQ6vPAYCfGpMVwjUS+HSzmQfxouSJykBxtrROkjLfT+JfNgX93nYviZkZZUPq4m6KfUZ0
 XEpfO0Ijbh/8Kw4We4XrGc1lwLxjwhviX47rfUsbqUAl06V/Q9lScJm/OIf8vnxIoR5ZU1DtlZ
 WJ3EJ5ZQ4FEk4+dgNNeyw45pTK7JeGTGTqEwgTmaI4eka2vFaLzym/rNlr1gA2qKD7lPcgXh+/
 53+L5cCIIoZ8kIRZ0GVZzZyPNzaPmmaly/oAV0y6GrXVZXXakhUWaPiIdX1InEQ66qGpgpjE29
 FNs=
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; d="scan'208";a="48600874"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa3.mentor.iphmx.com with ESMTP; 06 May 2020 16:45:03 -0800
IronPort-SDR: EQyaUGtq8GoXI30lDnR2v6W/U3uFe9CVFe1D8nRVDF3T+bJWZ7Pqa3EJrIIScThnLgqsZOKN4R
 VkiHkC4FUpuIfRxmbxe79qrSgyd6FGsaqqevUB1wxQHEJX/BQ0futdS+QqhvDPKb6Y0RHXdJkw
 eZuX5VzvbZtLXtpZlJF/3KGBk3se7HER8YiH1KVFrDgxjTZHQiO+LU+QesjpMCbPvL8OzHubnn
 pTJVXLq/3BvxlVPuIufkLDibqceJ2mlOVB1yhz2eFSu43SEehqDBv5aXSukcp7ATIVbrHYMRDE
 0Ww=
Date: Thu, 7 May 2020 00:44:57 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 3/5] target/i386: fix fscale handling of invalid exponent
 encodings
In-Reply-To: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005070044190.18350@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.180;
 envelope-from=joseph_myers@mentor.com; helo=esa3.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 20:45:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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

The fscale implementation does not check for invalid encodings in the
exponent operand, thus treating them like INT_MIN (the value returned
for invalid encodings by floatx80_to_int32_round_to_zero).  Fix it to
treat them similarly to signaling NaN exponents, thus generating a
quiet NaN result.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c          |  5 ++++-
 tests/tcg/i386/test-i386-fscale.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 60012c405c..7709af8fdd 100644
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
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

