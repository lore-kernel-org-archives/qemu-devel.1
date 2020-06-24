Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63782C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF3E2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Askho5Ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF3E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3DS-0002L1-At
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zt-0001MP-0t
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57204
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2zq-0001NI-P8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dBdV5EbVu1MqYac8XKe1DTXsCoptCpDO61Z38fsy5I=;
 b=Askho5AcAsxzeIZoa2fOHmunUVrBSiX3qc9uw/kEpWP2Ad8h+/rFmopJz57y1B8UmLls3f
 SIzt3chyKZDoEFhF66ojHu1A0shvRTcryCIafQPABrbCncSa2uCUvY/90fdR55W4vHIist
 OHyN0uGfmIep/ZvXdyfGZoUiPEK3HM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-AtHDTaERNoCevpg1rRzrCg-1; Wed, 24 Jun 2020 06:51:10 -0400
X-MC-Unique: AtHDTaERNoCevpg1rRzrCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C7DB18A8220;
 Wed, 24 Jun 2020 10:51:09 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A370B5D9C5;
 Wed, 24 Jun 2020 10:51:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/31] target/i386: reimplement fprem,
 fprem1 using floatx80 operations
Date: Wed, 24 Jun 2020 06:50:37 -0400
Message-Id: <20200624105048.375353-20-pbonzini@redhat.com>
In-Reply-To: <20200624104917.375143-1-pbonzini@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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

The x87 fprem and fprem1 emulation is currently based around
conversion to double, which is inherently unsuitable for a good
emulation of any floatx80 operation.  Reimplement using the soft-float
floatx80 remainder operations.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <alpine.DEB.2.21.2006081657200.23637@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c | 156 ++++++++++++---------------------------
 1 file changed, 48 insertions(+), 108 deletions(-)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index e32a2aa74b..8f34ea9776 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -1313,124 +1313,64 @@ void helper_fxtract(CPUX86State *env)
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
+            /*
+             * Partial remainder.  This choice of how many bits to
+             * process at once is specified in AMD instruction set
+             * manuals, and empirically is followed by Intel
+             * processors as well; it ensures that the final remainder
+             * operation in a loop does produce the correct low three
+             * bits of the quotient.  AMD manuals specify that the
+             * flags other than C2 are cleared, and empirically Intel
+             * processors clear them as well.
+             */
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
 }
 
-void helper_fprem(CPUX86State *env)
+void helper_fprem1(CPUX86State *env)
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
-
-    if (expdif < 53) {
-        dblq = fpsrcop / fptemp; /* ST0 / ST1 */
-        /* round dblq towards zero */
-        dblq = (dblq < 0.0) ? ceil(dblq) : floor(dblq);
-        st0 = fpsrcop - fptemp * dblq; /* fpsrcop is ST0 */
-
-        /* convert dblq to q by truncating towards zero */
-        if (dblq < 0.0) {
-            q = (signed long long int)(-dblq);
-        } else {
-            q = (signed long long int)dblq;
-        }
-
-        env->fpus &= ~0x4700; /* (C3,C2,C1,C0) <-- 0000 */
-        /* (C0,C3,C1) <-- (q2,q1,q0) */
-        env->fpus |= (q & 0x4) << (8 - 2);  /* (C0) <-- q2 */
-        env->fpus |= (q & 0x2) << (14 - 1); /* (C3) <-- q1 */
-        env->fpus |= (q & 0x1) << (9 - 0);  /* (C1) <-- q0 */
-    } else {
-        int N = 32 + (expdif % 32); /* as per AMD docs */
+    helper_fprem_common(env, false);
+}
 
-        env->fpus |= 0x400;  /* C2 <-- 1 */
-        fptemp = pow(2.0, (double)(expdif - N));
-        fpsrcop = (st0 / st1) / fptemp;
-        /* fpsrcop = integer obtained by chopping */
-        fpsrcop = (fpsrcop < 0.0) ?
-                  -(floor(fabs(fpsrcop))) : floor(fpsrcop);
-        st0 -= (st1 * fpsrcop * fptemp);
-    }
-    ST0 = double_to_floatx80(env, st0);
+void helper_fprem(CPUX86State *env)
+{
+    helper_fprem_common(env, true);
 }
 
 void helper_fyl2xp1(CPUX86State *env)
-- 
2.26.2



