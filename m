Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5440720720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iP4rEnfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5440720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjThh-0007vq-75
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9h-0000U2-Ak
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49975
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9e-0001IR-N0
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jelj5re9VDPgLlS1Rkx1bkVLzds8Xhf8jBxfFi0V9HY=;
 b=iP4rEnfcuKLYqh+2smYJ26Fw5+rfw3OQM6UKc9uNO2x+yCCO+JGoFlkie0ysSn1K/X6eu6
 9ODG150odS4PnFINKSop9Ug3dN7arncpd0JbC0O1fY2zYNXFIsx8mRKFlBncVgTIw0CDSL
 v2uLJsIMhUkdMQEh7e+MQHELfnCr6TY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-O59X1wfHNlubvYXM2Qxx1Q-1; Thu, 11 Jun 2020 15:45:40 -0400
X-MC-Unique: O59X1wfHNlubvYXM2Qxx1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 353FA461;
 Thu, 11 Jun 2020 19:45:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1F3E619C8;
 Thu, 11 Jun 2020 19:45:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 060/115] target/i386: fix floating-point load-constant rounding
Date: Thu, 11 Jun 2020 15:43:54 -0400
Message-Id: <20200611194449.31468-61-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:52:10
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

The implementations of the fldl2t, fldl2e, fldpi, fldlg2 and fldln2
instructions load fixed constants independent of the rounding mode.
Fix them to load a value correctly rounded for the current rounding
mode (but always rounded to 64-bit precision independent of the
precision control, and without setting "inexact") as specified.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <alpine.DEB.2.21.2005132348310.11687@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c          |  54 +++++++-
 tests/tcg/i386/test-i386-fldcst.c | 199 ++++++++++++++++++++++++++++++
 2 files changed, 248 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-fldcst.c

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 4d14c1ca24..f0b9cb5de8 100644
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
2.26.2



