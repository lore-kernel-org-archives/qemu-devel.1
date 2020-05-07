Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8B8C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F86420736
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F86420736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWUh6-0003WM-Gm
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 20:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUfc-0002E2-Cf
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:45:48 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:50702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUfb-0008Mq-9w
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:45:48 -0400
IronPort-SDR: NMx6hQ/vDVrFkIpsNr9qd6sMQqRDFbgXLccMljreNhYzZBO7EOXN+FEhe2lkHnf7+q2nRMRpXx
 iFz3Jeq4ZD3f1D/hSUlqLJEpbek+wymws6lFVHwe2qORSqWOFUgMU5zUQnIakQnuXSPc2hAujn
 hujmW1eKkP3JfbmZikc2Bhx0sS21FVyLwZYb/cp1kDQl7MKP4en8z4eMV4KCFUncYTP6JSp19G
 rP1QRlRktaO7aPLy84Z/jIQ/wCEjZoGeqBZ6P9eLo3KnwUUpwQu38atDLPGFSSN++OcAzsiDFE
 FA0=
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; d="scan'208";a="48541271"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 06 May 2020 16:45:45 -0800
IronPort-SDR: qAOHe37JFgHzBd4LhAompjpE8YO5zhfpeffgCVNEqwvXFdAtRsbBwVRGXc+N8ptnsRbBLwLEOT
 6ciObTdj4b7mhLb45E8Ze3Lgvik9lWrfvcINTaH6Uu/YVVfiFe5yswQKHtM5RNdJVcqdNy1xrl
 eAbc8W6D8CMVMK/FDOuQ5XiKW15siwaCMPNqT05+7k4+uQuplECZSKf+3s8FC/G1Ou/R0T0Gxm
 I34P67k/DmZfKSCTW7l4Ao9ci+Jnmae4AUkWT6pyHX3hk5KQ1s3C3hWP9UdK0CSG2C3INRjzyN
 e2I=
Date: Thu, 7 May 2020 00:45:38 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 4/5] target/i386: fix fscale handling of infinite exponents
In-Reply-To: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005070045010.18350@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.141.98;
 envelope-from=joseph_myers@mentor.com; helo=esa2.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 20:42:37
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

The fscale implementation passes infinite exponents through to generic
code that rounds the exponent to a 32-bit integer before using
floatx80_scalbn.  In round-to-nearest mode, and ignoring exceptions,
this works in many cases.  But it fails to handle the special cases of
scaling 0 by a +Inf exponent or an infinity by a -Inf exponent, which
should produce a NaN, and because it produces an inexact result for
finite nonzero numbers being scaled, the result is sometimes incorrect
in other rounding modes.  Add appropriate handling of infinite
exponents to produce a NaN or an appropriately signed exact zero or
infinity as a result.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c          | 22 ++++++++++++++++++++++
 tests/tcg/i386/test-i386-fscale.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 7709af8fdd..d4c15728e1 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -977,6 +977,28 @@ void helper_fscale(CPUX86State *env)
             float_raise(float_flag_invalid, &env->fp_status);
             ST0 = floatx80_silence_nan(ST0, &env->fp_status);
         }
+    } else if (floatx80_is_infinity(ST1) &&
+               !floatx80_invalid_encoding(ST0) &&
+               !floatx80_is_any_nan(ST0)) {
+        if (floatx80_is_neg(ST1)) {
+            if (floatx80_is_infinity(ST0)) {
+                float_raise(float_flag_invalid, &env->fp_status);
+                ST0 = floatx80_default_nan(&env->fp_status);
+            } else {
+                ST0 = (floatx80_is_neg(ST0) ?
+                       floatx80_chs(floatx80_zero) :
+                       floatx80_zero);
+            }
+        } else {
+            if (floatx80_is_zero(ST0)) {
+                float_raise(float_flag_invalid, &env->fp_status);
+                ST0 = floatx80_default_nan(&env->fp_status);
+            } else {
+                ST0 = (floatx80_is_neg(ST0) ?
+                       floatx80_chs(floatx80_infinity) :
+                       floatx80_infinity);
+            }
+        }
     } else {
         int n = floatx80_to_int32_round_to_zero(ST1, &env->fp_status);
         ST0 = floatx80_scalbn(ST0, n, &env->fp_status);
diff --git a/tests/tcg/i386/test-i386-fscale.c b/tests/tcg/i386/test-i386-fscale.c
index b65a055d0a..b953e7c563 100644
--- a/tests/tcg/i386/test-i386-fscale.c
+++ b/tests/tcg/i386/test-i386-fscale.c
@@ -31,6 +31,7 @@ int issignaling_ld(long double x)
 
 int main(void)
 {
+    short cw;
     int ret = 0;
     __asm__ volatile ("fscale" : "=t" (ld_res) :
                       "0" (2.5L), "u" (__builtin_nansl("")));
@@ -62,5 +63,33 @@ int main(void)
         printf("FAIL: fscale invalid 4\n");
         ret = 1;
     }
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (0.0L), "u" (__builtin_infl()));
+    if (!isnan_ld(ld_res) || issignaling_ld(ld_res)) {
+        printf("FAIL: fscale 0 up inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (__builtin_infl()), "u" (-__builtin_infl()));
+    if (!isnan_ld(ld_res) || issignaling_ld(ld_res)) {
+        printf("FAIL: fscale inf down inf\n");
+        ret = 1;
+    }
+    /* Set round-downward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x400;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (1.0L), "u" (__builtin_infl()));
+    if (ld_res != __builtin_infl()) {
+        printf("FAIL: fscale finite up inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fscale" : "=t" (ld_res) :
+                      "0" (-1.0L), "u" (-__builtin_infl()));
+    if (ld_res != -0.0L || __builtin_copysignl(1.0L, ld_res) != -1.0L) {
+        printf("FAIL: fscale finite down inf\n");
+        ret = 1;
+    }
     return ret;
 }
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

