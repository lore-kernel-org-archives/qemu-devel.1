Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26809C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1DD2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 23:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1DD2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ18o-0000EL-Uk
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 19:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZ185-0007zo-2S
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:49:37 -0400
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:57185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jZ183-0001nb-Ma
 for qemu-devel@nongnu.org; Wed, 13 May 2020 19:49:36 -0400
IronPort-SDR: RFcFTjgM5CyrE+T+tNxVvScx2f+vR9dJzuMB9FuLgBCBwCxBRyIdEpURwZXrWwoLkvR43s8F3V
 lBPlLpWbNTZVuKDUf6nOnW/++3AFmGZ9EKt4fCjzQQPbKU1ikR8Sb+qqYbvfUAa3ZUxd80OlTj
 2NqAlkFN8ZgNAitSNKsM6OQo/gXTwjyEFH265d/OvP8UzVmWEv5gDKp4/YC4NUqNhI9A3HjxEY
 1eRH9AW226Elxy287R88vWAoFud8xoqB4llLAUt0FNIZNdqhf/vQcFEyvj1Sc+5zQPvi0XJtPA
 hm8=
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; d="scan'208";a="48823184"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa3.mentor.iphmx.com with ESMTP; 13 May 2020 15:49:33 -0800
IronPort-SDR: bzphfi7peCmMi8TXG2X/RmTB++nbU4ff5bQuU/baxOMosWKOiP6r/tjjjP1x6PHwlwfctStyCz
 vUsFkAWf1r76WBnUaZbaUEpbWZg4OjV0OMFNPZT1M/t1yXWj7XrppYres4UPcMYXw0VghbGr61
 UDgEoWhNmVnF4hKzx+rz7eBzlsHYTgmVuQx0j9jwqyBvjYHVVpT+oorDmSdi2KtmtkYDojbWNo
 bQQ+1tb0ZB3mUKams6rSrwbkAMkeDFgGTLjl5uCIyCw8wURqDzODmq3g6WOEUMcfp2j5/W6CST
 L2o=
Date: Wed, 13 May 2020 23:49:27 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <rth@twiddle.net>,
 <ehabkost@redhat.com>
Subject: [PATCH 1/4] target/i386: fix floating-point load-constant rounding
In-Reply-To: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2005132348310.11687@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.180;
 envelope-from=joseph_myers@mentor.com; helo=esa3.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 19:49:34
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

The implementations of the fldl2t, fldl2e, fldpi, fldlg2 and fldln2
instructions load fixed constants independent of the rounding mode.
Fix them to load a value correctly rounded for the current rounding
mode (but always rounded to 64-bit precision independent of the
precision control, and without setting "inexact") as specified.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c          |  54 +++++++-
 tests/tcg/i386/test-i386-fldcst.c | 199 ++++++++++++++++++++++++++++++
 2 files changed, 248 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-fldcst.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 0c3fce933c..38968b2ec7 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -59,8 +59,13 @@
 #define FPUC_EM 0x3f
 
 #define floatx80_lg2 make_floatx80(0x3ffd, 0x9a209a84fbcff799LL)
+#define floatx80_lg2_d make_floatx80(0x3ffd, 0x9a209a84fbcff798LL)
 #define floatx80_l2e make_floatx80(0x3fff, 0xb8aa3b295c17f0bcLL)
+#define floatx80_l2e_d make_floatx80(0x3fff, 0xb8aa3b295c17f0bbLL)
 #define floatx80_l2t make_floatx80(0x4000, 0xd49a784bcd1b8afeLL)
+#define floatx80_l2t_u make_floatx80(0x4000, 0xd49a784bcd1b8affLL)
+#define floatx80_ln2_d make_floatx80(0x3ffe, 0xb17217f7d1cf79abLL)
+#define floatx80_pi_d make_floatx80(0x4000, 0xc90fdaa22168c234LL)
 
 #if !defined(CONFIG_USER_ONLY)
 static qemu_irq ferr_irq;
@@ -544,27 +549,66 @@ void helper_fld1_ST0(CPUX86State *env)
 
 void helper_fldl2t_ST0(CPUX86State *env)
 {
-    ST0 = floatx80_l2t;
+    switch (env->fpuc & FPU_RC_MASK) {
+    case FPU_RC_UP:
+        ST0 = floatx80_l2t_u;
+        break;
+    default:
+        ST0 = floatx80_l2t;
+        break;
+    }
 }
 
 void helper_fldl2e_ST0(CPUX86State *env)
 {
-    ST0 = floatx80_l2e;
+    switch (env->fpuc & FPU_RC_MASK) {
+    case FPU_RC_DOWN:
+    case FPU_RC_CHOP:
+        ST0 = floatx80_l2e_d;
+        break;
+    default:
+        ST0 = floatx80_l2e;
+        break;
+    }
 }
 
 void helper_fldpi_ST0(CPUX86State *env)
 {
-    ST0 = floatx80_pi;
+    switch (env->fpuc & FPU_RC_MASK) {
+    case FPU_RC_DOWN:
+    case FPU_RC_CHOP:
+        ST0 = floatx80_pi_d;
+        break;
+    default:
+        ST0 = floatx80_pi;
+        break;
+    }
 }
 
 void helper_fldlg2_ST0(CPUX86State *env)
 {
-    ST0 = floatx80_lg2;
+    switch (env->fpuc & FPU_RC_MASK) {
+    case FPU_RC_DOWN:
+    case FPU_RC_CHOP:
+        ST0 = floatx80_lg2_d;
+        break;
+    default:
+        ST0 = floatx80_lg2;
+        break;
+    }
 }
 
 void helper_fldln2_ST0(CPUX86State *env)
 {
-    ST0 = floatx80_ln2;
+    switch (env->fpuc & FPU_RC_MASK) {
+    case FPU_RC_DOWN:
+    case FPU_RC_CHOP:
+        ST0 = floatx80_ln2_d;
+        break;
+    default:
+        ST0 = floatx80_ln2;
+        break;
+    }
 }
 
 void helper_fldz_ST0(CPUX86State *env)
diff --git a/tests/tcg/i386/test-i386-fldcst.c b/tests/tcg/i386/test-i386-fldcst.c
new file mode 100644
index 0000000000..e635432ccf
--- /dev/null
+++ b/tests/tcg/i386/test-i386-fldcst.c
@@ -0,0 +1,199 @@
+/* Test instructions loading floating-point constants.  */
+
+#include <stdint.h>
+#include <stdio.h>
+
+volatile long double ld_res;
+
+int main(void)
+{
+    short cw;
+    int ret = 0;
+
+    /* Round to nearest.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x000;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldl2t" : "=t" (ld_res));
+    if (ld_res != 0x3.5269e12f346e2bf8p+0L) {
+        printf("FAIL: fldl2t N\n");
+        ret = 1;
+    }
+    /* Round downward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x400;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldl2t" : "=t" (ld_res));
+    if (ld_res != 0x3.5269e12f346e2bf8p+0L) {
+        printf("FAIL: fldl2t D\n");
+        ret = 1;
+    }
+    /* Round toward zero.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0xc00;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldl2t" : "=t" (ld_res));
+    if (ld_res != 0x3.5269e12f346e2bf8p+0L) {
+        printf("FAIL: fldl2t Z\n");
+        ret = 1;
+    }
+    /* Round upward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x800;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldl2t" : "=t" (ld_res));
+    if (ld_res != 0x3.5269e12f346e2bfcp+0L) {
+        printf("FAIL: fldl2t U\n");
+        ret = 1;
+    }
+
+    /* Round to nearest.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x000;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldl2e" : "=t" (ld_res));
+    if (ld_res != 0x1.71547652b82fe178p+0L) {
+        printf("FAIL: fldl2e N\n");
+        ret = 1;
+    }
+    /* Round downward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x400;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldl2e" : "=t" (ld_res));
+    if (ld_res != 0x1.71547652b82fe176p+0L) {
+        printf("FAIL: fldl2e D\n");
+        ret = 1;
+    }
+    /* Round toward zero.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0xc00;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldl2e" : "=t" (ld_res));
+    if (ld_res != 0x1.71547652b82fe176p+0L) {
+        printf("FAIL: fldl2e Z\n");
+        ret = 1;
+    }
+    /* Round upward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x800;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldl2e" : "=t" (ld_res));
+    if (ld_res != 0x1.71547652b82fe178p+0L) {
+        printf("FAIL: fldl2e U\n");
+        ret = 1;
+    }
+
+    /* Round to nearest.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x000;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldpi" : "=t" (ld_res));
+    if (ld_res != 0x3.243f6a8885a308d4p+0L) {
+        printf("FAIL: fldpi N\n");
+        ret = 1;
+    }
+    /* Round downward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x400;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldpi" : "=t" (ld_res));
+    if (ld_res != 0x3.243f6a8885a308dp+0L) {
+        printf("FAIL: fldpi D\n");
+        ret = 1;
+    }
+    /* Round toward zero.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0xc00;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldpi" : "=t" (ld_res));
+    if (ld_res != 0x3.243f6a8885a308dp+0L) {
+        printf("FAIL: fldpi Z\n");
+        ret = 1;
+    }
+    /* Round upward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x800;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldpi" : "=t" (ld_res));
+    if (ld_res != 0x3.243f6a8885a308d4p+0L) {
+        printf("FAIL: fldpi U\n");
+        ret = 1;
+    }
+
+    /* Round to nearest.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x000;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldlg2" : "=t" (ld_res));
+    if (ld_res != 0x4.d104d427de7fbcc8p-4L) {
+        printf("FAIL: fldlg2 N\n");
+        ret = 1;
+    }
+    /* Round downward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x400;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldlg2" : "=t" (ld_res));
+    if (ld_res != 0x4.d104d427de7fbccp-4L) {
+        printf("FAIL: fldlg2 D\n");
+        ret = 1;
+    }
+    /* Round toward zero.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0xc00;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldlg2" : "=t" (ld_res));
+    if (ld_res != 0x4.d104d427de7fbccp-4L) {
+        printf("FAIL: fldlg2 Z\n");
+        ret = 1;
+    }
+    /* Round upward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x800;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldlg2" : "=t" (ld_res));
+    if (ld_res != 0x4.d104d427de7fbcc8p-4L) {
+        printf("FAIL: fldlg2 U\n");
+        ret = 1;
+    }
+
+    /* Round to nearest.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x000;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldln2" : "=t" (ld_res));
+    if (ld_res != 0xb.17217f7d1cf79acp-4L) {
+        printf("FAIL: fldln2 N\n");
+        ret = 1;
+    }
+    /* Round downward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x400;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldln2" : "=t" (ld_res));
+    if (ld_res != 0xb.17217f7d1cf79abp-4L) {
+        printf("FAIL: fldln2 D\n");
+        ret = 1;
+    }
+    /* Round toward zero.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0xc00;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldln2" : "=t" (ld_res));
+    if (ld_res != 0xb.17217f7d1cf79abp-4L) {
+        printf("FAIL: fldln2 Z\n");
+        ret = 1;
+    }
+    /* Round upward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x800;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ volatile ("fldln2" : "=t" (ld_res));
+    if (ld_res != 0xb.17217f7d1cf79acp-4L) {
+        printf("FAIL: fldln2 U\n");
+        ret = 1;
+    }
+
+    return ret;
+}
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

