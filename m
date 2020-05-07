Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84572C54E4B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:44:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFE620936
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 00:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFE620936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWUeC-0000Oo-Ht
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 20:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUdW-0008IH-AE
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:43:38 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:64318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jWUdV-0005Hr-77
 for qemu-devel@nongnu.org; Wed, 06 May 2020 20:43:38 -0400
IronPort-SDR: IVAgpWDatbo3gUJbYGUafrA5CnHOq9OBqvzByIZa6LAAsBeThi8M9d3/+NmS7Pa1Nn7a1gXyxu
 nyLpZDJXS789Y1TUry0hs72yr1VlY4j9mOWjHJXl+XEXRHvbzScZ3G+Acvkm/7bp+Qg8KIe1EA
 bOOSSrs3TG2/gtFCfhIQKl8/5MAC+9DzO0VYosU723wUTevEI9Tyz1hI9Xip57bHs/TMKWHF4G
 /y7vyQZpbZhBOtmI1m5TyTzxFS9yrzoHaHJQfRdREOpYn1yxyaT/K1PGbdd4FRExcNUmil0AK5
 xX8=
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; d="scan'208";a="48541250"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 06 May 2020 16:43:35 -0800
IronPort-SDR: ZpAXnzSfiifbSkHIYJm8z22yEw3tkzeVG1XVQyltkkxkDzwcdHRVAIbCzvOo2wyiduUOkHOKJ1
 0M6PDYafp8t5IYqfp8QqjXvYAi28e3X3LaG2xG8w1yyRbcB+68bfLgW18zqcn5gFVKdiXHn3fU
 zM02hShcH0iJmhNuVpAbms9OOaG/lmijxHYd4Fkuz9n14fgOolsD9v3P++qrKZKLnIvs0jT6RB
 vIfTmXXDonT8kttTR0iXnPRPGL5Hz7CVi4EqIugpLL8Jd7eS6StbC8Y+s94Sev/HqDcls4QE5N
 RAo=
Date: Thu, 7 May 2020 00:43:30 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 1/5] target/i386: implement special cases for fxtract
In-Reply-To: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005070042360.18350@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005070038550.18350@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
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

The implementation of the fxtract instruction treats all nonzero
operands as normal numbers, so yielding incorrect results for invalid
formats, infinities, NaNs and subnormal and pseudo-denormal operands.
Implement appropriate handling of all those cases.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c           |  25 +++++-
 tests/tcg/i386/test-i386-fxtract.c | 120 +++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/i386/test-i386-fxtract.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 792a128a6d..71a696a863 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -767,10 +767,33 @@ void helper_fxtract(CPUX86State *env)
                            &env->fp_status);
         fpush(env);
         ST0 = temp.d;
+    } else if (floatx80_invalid_encoding(ST0)) {
+        float_raise(float_flag_invalid, &env->fp_status);
+        ST0 = floatx80_default_nan(&env->fp_status);
+        fpush(env);
+        ST0 = ST1;
+    } else if (floatx80_is_any_nan(ST0)) {
+        if (floatx80_is_signaling_nan(ST0, &env->fp_status)) {
+            float_raise(float_flag_invalid, &env->fp_status);
+            ST0 = floatx80_silence_nan(ST0, &env->fp_status);
+        }
+        fpush(env);
+        ST0 = ST1;
+    } else if (floatx80_is_infinity(ST0)) {
+        fpush(env);
+        ST0 = ST1;
+        ST1 = floatx80_infinity;
     } else {
         int expdif;
 
-        expdif = EXPD(temp) - EXPBIAS;
+        if (EXPD(temp) == 0) {
+            int shift = clz64(temp.l.lower);
+            temp.l.lower <<= shift;
+            expdif = 1 - EXPBIAS - shift;
+            float_raise(float_flag_input_denormal, &env->fp_status);
+        } else {
+            expdif = EXPD(temp) - EXPBIAS;
+        }
         /* DP exponent bias */
         ST0 = int32_to_floatx80(expdif, &env->fp_status);
         fpush(env);
diff --git a/tests/tcg/i386/test-i386-fxtract.c b/tests/tcg/i386/test-i386-fxtract.c
new file mode 100644
index 0000000000..64fd93d333
--- /dev/null
+++ b/tests/tcg/i386/test-i386-fxtract.c
@@ -0,0 +1,120 @@
+/* Test fxtract instruction.  */
+
+#include <stdint.h>
+#include <stdio.h>
+
+union u {
+    struct { uint64_t sig; uint16_t sign_exp; } s;
+    long double ld;
+};
+
+volatile union u ld_pseudo_m16382 = { .s = { UINT64_C(1) << 63, 0 } };
+volatile union u ld_invalid_1 = { .s = { 1, 1234 } };
+volatile union u ld_invalid_2 = { .s = { 0, 1234 } };
+volatile union u ld_invalid_3 = { .s = { 0, 0x7fff } };
+volatile union u ld_invalid_4 = { .s = { (UINT64_C(1) << 63) - 1, 0x7fff } };
+
+volatile long double ld_sig, ld_exp;
+
+int isnan_ld(long double x)
+{
+  union u tmp = { .ld = x };
+  return ((tmp.s.sign_exp & 0x7fff) == 0x7fff &&
+          (tmp.s.sig >> 63) != 0 &&
+          (tmp.s.sig << 1) != 0);
+}
+
+int issignaling_ld(long double x)
+{
+    union u tmp = { .ld = x };
+    return isnan_ld(x) && (tmp.s.sig & UINT64_C(0x4000000000000000)) == 0;
+}
+
+int main(void)
+{
+    int ret = 0;
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) : "0" (2.5L));
+    if (ld_sig != 1.25L || ld_exp != 1.0L) {
+        printf("FAIL: fxtract 2.5\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) : "0" (0.0L));
+    if (ld_sig != 0.0L || __builtin_copysignl(1.0L, ld_sig) != 1.0L ||
+        ld_exp != -__builtin_infl()) {
+        printf("FAIL: fxtract 0.0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) : "0" (-0.0L));
+    if (ld_sig != -0.0L || __builtin_copysignl(1.0L, ld_sig) != -1.0L ||
+        ld_exp != -__builtin_infl()) {
+        printf("FAIL: fxtract -0.0\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (__builtin_infl()));
+    if (ld_sig != __builtin_infl() || ld_exp != __builtin_infl()) {
+        printf("FAIL: fxtract inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (-__builtin_infl()));
+    if (ld_sig != -__builtin_infl() || ld_exp != __builtin_infl()) {
+        printf("FAIL: fxtract -inf\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (__builtin_nanl("")));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract qnan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (__builtin_nansl("")));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract snan\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (0x1p-16445L));
+    if (ld_sig != 1.0L || ld_exp != -16445.0L) {
+        printf("FAIL: fxtract subnormal\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (ld_pseudo_m16382.ld));
+    if (ld_sig != 1.0L || ld_exp != -16382.0L) {
+        printf("FAIL: fxtract pseudo\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (ld_invalid_1.ld));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract invalid 1\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (ld_invalid_2.ld));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract invalid 2\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (ld_invalid_3.ld));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract invalid 3\n");
+        ret = 1;
+    }
+    __asm__ volatile ("fxtract" : "=t" (ld_sig), "=u" (ld_exp) :
+                      "0" (ld_invalid_4.ld));
+    if (!isnan_ld(ld_sig) || issignaling_ld(ld_sig) ||
+        !isnan_ld(ld_exp) || issignaling_ld(ld_exp)) {
+        printf("FAIL: fxtract invalid 4\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

