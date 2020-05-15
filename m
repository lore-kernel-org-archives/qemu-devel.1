Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5150C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D87D2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vAIj+qaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D87D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfNz-0000yK-O7
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 14:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfMn-00082v-Vv
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:47:30 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:54226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfMm-0005vf-ER
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:47:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id hi11so1294372pjb.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D5lfLUHd4lnaHSGz0Uzj+dw+p5eXn34OnzAvB/PRrwk=;
 b=vAIj+qaYZmrkWNHCqy3TeRvftbE9jS4cYu6njMJpoxFgvGscx6HdkGmUaKJMgPPmqh
 ZIIZxjRN/TVHNijcjjYKqtr6i1G1XWi9Mn5qcGkf6LG7KgKmuWFpEXBfD14pjztgRgOx
 mY5w6Ma5RQtZm3Nukfscpp28ZEmEvI7bS0AoYvthvGcNelwh/jRtLSASTz5JCV6t7GyE
 kJya7irLY51v3TLc9oC1lVs+tdfQQPi2DW1ZqNmMSUf2bdDrXxZx2R9THaajNM8HqGif
 WnpB3qZf5Wfqhuj7ESiQKFozBUCRMCQUPqNUU4ZhXLNNLEsEtwy4J2GMFdR/KcYswyxE
 7+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D5lfLUHd4lnaHSGz0Uzj+dw+p5eXn34OnzAvB/PRrwk=;
 b=LO7U+MvwGYyrxb9qpth4RqF1cpG4ju+EIyqLmICdrc5LZtrG7KJulfURONMRy7AtPM
 ijcoV/053RC16rYv3i/Xbol5DyhBUtlGHFr/1o1pn2qpqAJSrcpudGaxbKIRMTV/CQHs
 TlpK8D7OYYcq6pAE4KWRnq43vnyO8XEbDnwXlMOz1GdRMQsgjk820V0yh6PUCvwvxUbj
 yR3KPGFtYg14pb4nhMm8ifYFoeBvnEUePFEas1tYnOFNgFhy4NbIncAS2VElegwO5i4c
 Xaal6HiY1lKGO0/Ket8lB4gEj7FBzZUF5recCt40oy9fE0PzL65z950c094Jvvm7RDH6
 W1DQ==
X-Gm-Message-State: AOAM530/jMSr/59VPWsXbUHsisXSJQDMwpZ7ILz0toZhitWfcwctPS4X
 Ps2zA1DQXH42soVZH4FlT779NVVOoJ8=
X-Google-Smtp-Source: ABdhPJwnZM66H2hBOpoAXtb9B0+Ju2kP2OTb60YltkZfrh1dEQADXlkhGUrxta0r6O+GEPVuTDfDKw==
X-Received: by 2002:a17:90a:154e:: with SMTP id
 y14mr5156293pja.180.1589568446764; 
 Fri, 15 May 2020 11:47:26 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u73sm2743630pfc.0.2020.05.15.11.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 11:47:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] softfloat: fix floatx80 pseudo-denormal addition /
 subtraction
Date: Fri, 15 May 2020 11:47:20 -0700
Message-Id: <20200515184722.31182-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515184722.31182-1-richard.henderson@linaro.org>
References: <20200515184722.31182-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

The softfloat function addFloatx80Sigs, used for addition of values
with the same sign and subtraction of values with opposite sign, fails
to handle the case where the two values both have biased exponent zero
and there is a carry resulting from adding the significands, which can
occur if one or both values are pseudo-denormals (biased exponent
zero, explicit integer bit 1).  Add a check for that case, so making
the results match those seen on x86 hardware for pseudo-denormals.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2005042337570.22972@digraph.polyomino.org.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c                            |  6 ++++++
 tests/tcg/i386/test-i386-pseudo-denormal.c | 24 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tests/tcg/i386/test-i386-pseudo-denormal.c

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index ac116c70b8..6094d267b5 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5866,6 +5866,12 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
         zSig1 = 0;
         zSig0 = aSig + bSig;
         if ( aExp == 0 ) {
+            if ((aSig | bSig) & UINT64_C(0x8000000000000000) && zSig0 < aSig) {
+                /* At least one of the values is a pseudo-denormal,
+                 * and there is a carry out of the result.  */
+                zExp = 1;
+                goto shiftRight1;
+            }
             if (zSig0 == 0) {
                 return packFloatx80(zSign, 0, 0);
             }
diff --git a/tests/tcg/i386/test-i386-pseudo-denormal.c b/tests/tcg/i386/test-i386-pseudo-denormal.c
new file mode 100644
index 0000000000..cfa2a500b0
--- /dev/null
+++ b/tests/tcg/i386/test-i386-pseudo-denormal.c
@@ -0,0 +1,24 @@
+/* Test pseudo-denormal operations.  */
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
+
+volatile long double ld_res;
+
+int main(void)
+{
+    int ret = 0;
+    ld_res = ld_pseudo_m16382.ld + ld_pseudo_m16382.ld;
+    if (ld_res != 0x1p-16381L) {
+        printf("FAIL: pseudo-denormal add\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.20.1


