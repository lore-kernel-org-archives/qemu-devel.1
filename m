Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5150C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746412077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 19:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746412077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhHd5-0003RT-LC
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 15:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHbg-0001m8-A9
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:02:20 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:34075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jhHbf-00079E-8L
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 15:02:19 -0400
IronPort-SDR: lBm2zgaXa52gU9BgZFS7yOl7g/uy0ivLid77BkBYvU88+5elh4WW/6m7m7ALhTS/Bhr87ogz7w
 NYOaOMNHSVTxCVYVH56Qs0onVwGWBFL8mx0wgjXHDwaIXK46mvWeAsY5Z+yyK7A8q+rRWLeL1d
 CUnkkgf1w+/sifzxxh94b0xsfV2X1ApbWkUmx1LPF4fBg5bNH70tflZSPH6gxxxb64n3AbCEsO
 UwltTmJb/8hFLbXu2xZQgqtzPD03+Q2OSmifSjyb1qE74Bzlm8uHO4LKcVnUkliKSKZwzozUna
 xUI=
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; d="scan'208";a="49633101"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 05 Jun 2020 11:02:17 -0800
IronPort-SDR: 0raJVmDGsvqfEhq/MUoYe1P/HVwTIRmNY+sOSXA3ZtN7xAuhX0OlR6i3QyZL2N7sGGgV/bz7i2
 jtnyDj5jHUOsFHVSzA9ofsYtrsHPqyX0d3GA9dJ/VMVnLfEC2QvJMzuGyK7Je9h0U460pGxqxG
 TxMAGFcfsceo8EzdPio7c98rM7s9bb8+6ZaFQG1nsz2992NzaNPZctzdD51VJNYAkE/TDegFqH
 R6jGror8uPGWcxGPge33M284X3Fp0A3YK/TkBp+2X0TnjBvlGZroK9yQndn4Kp6jtKdd1pjz/u
 eF0=
Date: Fri, 5 Jun 2020 19:02:11 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>, <aurelien@aurel32.net>,
 <peter.maydell@linaro.org>, <alex.bennee@linaro.org>, <laurent@vivier.eu>,
 <pbonzini@redhat.com>, <rth@twiddle.net>, <ehabkost@redhat.com>
Subject: [PATCH 6/7] target/i386: reimplement fprem1 using floatx80 operations
In-Reply-To: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006051901480.13777@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 14:59:46
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

The x87 fprem1 emulation is currently based around conversion to
double, which is inherently unsuitable for a good emulation of any
floatx80 operation.  Reimplement using the soft-float floatx80
remainder operations.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 target/i386/fpu_helper.c | 96 +++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 51 deletions(-)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 8ef5b463ea..bab35e00a0 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -934,63 +934,57 @@ void helper_fxtract(CPUX86State *env)
     merge_exception_flags(env, old_flags);
 }
 
-void helper_fprem1(CPUX86State *env)
+static void helper_fprem_common(CPUX86State *env, bool mod)
 {
-    double st0, st1, dblq, fpsrcop, fptemp;
-    CPU_LDoubleU fpsrcop1, fptemp1;
-    int expdif;
-    signed long long int q;
-
-    st0 = floatx80_to_double(env, ST0);
-    st1 = floatx80_to_double(env, ST1);
-
-    if (isinf(st0) || isnan(st0) || isnan(st1) || (st1 == 0.0)) {
-        ST0 = double_to_floatx80(env, 0.0 / 0.0); /* NaN */
-        env->fpus &= ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
-        return;
-    }
-
-    fpsrcop = st0;
-    fptemp = st1;
-    fpsrcop1.d = ST0;
-    fptemp1.d = ST1;
-    expdif = EXPD(fpsrcop1) - EXPD(fptemp1);
-
-    if (expdif < 0) {
-        /* optimisation? taken from the AMD docs */
-        env->fpus &= ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
-        /* ST0 is unchanged */
-        return;
-    }
+    uint8_t old_flags = save_exception_flags(env);
+    uint64_t quotient;
+    CPU_LDoubleU temp0, temp1;
+    int exp0, exp1, expdiff;
 
-    if (expdif < 53) {
-        dblq = fpsrcop / fptemp;
-        /* round dblq towards nearest integer */
-        dblq = rint(dblq);
-        st0 = fpsrcop - fptemp * dblq;
+    temp0.d = ST0;
+    temp1.d = ST1;
+    exp0 = EXPD(temp0);
+    exp1 = EXPD(temp1);
 
-        /* convert dblq to q by truncating towards zero */
-        if (dblq < 0.0) {
-            q = (signed long long int)(-dblq);
+    env->fpus &= ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
+    if (floatx80_is_zero(ST0) || floatx80_is_zero(ST1) ||
+        exp0 == 0x7fff || exp1 == 0x7fff ||
+        floatx80_invalid_encoding(ST0) || floatx80_invalid_encoding(ST1)) {
+        ST0 = floatx80_modrem(ST0, ST1, mod, &quotient, &env->fp_status);
+    } else {
+        if (exp0 == 0) {
+            exp0 = 1 - clz64(temp0.l.lower);
+        }
+        if (exp1 == 0) {
+            exp1 = 1 - clz64(temp1.l.lower);
+        }
+        expdiff = exp0 - exp1;
+        if (expdiff < 64) {
+            ST0 = floatx80_modrem(ST0, ST1, mod, &quotient, &env->fp_status);
+            env->fpus |= (quotient & 0x4) << (8 - 2);  /* (C0) <-- q2 */
+            env->fpus |= (quotient & 0x2) << (14 - 1); /* (C3) <-- q1 */
+            env->fpus |= (quotient & 0x1) << (9 - 0);  /* (C1) <-- q0 */
         } else {
-            q = (signed long long int)dblq;
+            /* Partial remainder.  This choice of how many bits to
+             * process at once is specified in AMD instruction set
+             * manuals, and empirically is followed by Intel
+             * processors as well; it ensures that the final remainder
+             * operation in a loop does produce the correct low three
+             * bits of the quotient.  AMD manuals specify that the
+             * flags other than C2 are cleared, and empirically Intel
+             * processors clear them as well.  */
+            int n = 32 + (expdiff % 32);
+            temp1.d = floatx80_scalbn(temp1.d, expdiff - n, &env->fp_status);
+            ST0 = floatx80_mod(ST0, temp1.d, &env->fp_status);
+            env->fpus |= 0x400;  /* C2 <-- 1 */
         }
-
-        env->fpus &= ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
-        /* (C0,C3,C1) <-- (q2,q1,q0) */
-        env->fpus |= (q & 0x4) << (8 - 2);  /* (C0) <-- q2 */
-        env->fpus |= (q & 0x2) << (14 - 1); /* (C3) <-- q1 */
-        env->fpus |= (q & 0x1) << (9 - 0);  /* (C1) <-- q0 */
-    } else {
-        env->fpus |= 0x400;  /* C2 <-- 1 */
-        fptemp = pow(2.0, expdif - 50);
-        fpsrcop = (st0 / st1) / fptemp;
-        /* fpsrcop = integer obtained by chopping */
-        fpsrcop = (fpsrcop < 0.0) ?
-                  -(floor(fabs(fpsrcop))) : floor(fpsrcop);
-        st0 -= (st1 * fpsrcop * fptemp);
     }
-    ST0 = double_to_floatx80(env, st0);
+    merge_exception_flags(env, old_flags);
+}
+
+void helper_fprem1(CPUX86State *env)
+{
+    helper_fprem_common(env, false);
 }
 
 void helper_fprem(CPUX86State *env)
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

