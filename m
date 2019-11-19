Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083F6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C605E20409
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/s1Irfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C605E20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3hM-0000Bo-Kd
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bo-0003NT-6H
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bm-0004BI-EW
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:56 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX3bk-0004AL-OE
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:53 -0500
Received: by mail-wr1-x442.google.com with SMTP id z10so23823614wrs.12
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 05:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iGWZ0PfY5IUQy4sucaflr8QXzQ3jHm0HWAjCaALUXUg=;
 b=m/s1IrfnWSgxOa2W2pTFCz+P34ugtLjXN5FRoCI8ef5mZM6tVaGkxaM7DbqUxkWtva
 i4dMsUr3IvQpKSvO7sPI/oTzrVFMxLR2LPpbIfNBfusFQXXyj2myFiWKY1d/F/KpTFzv
 Uk72r61nP7iJ4uvWgH2dG0zAVtru0l6klkEYXEuwzZWaa3ASGYnlZwVXWdsKz3GGvbpN
 IRGqjqiE03KSMauBHRxiOcu4FEFbB3wrp/M5MSFk8ddU6uTNXKcnfVh/lWbrtQ3AVN46
 xKZ7qmtjmnLsxnW2Xa+1h/LzIAXCC1wwhuijL+uiihPe5j1XB9ESTI2dfETveaH8UaO4
 2h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iGWZ0PfY5IUQy4sucaflr8QXzQ3jHm0HWAjCaALUXUg=;
 b=IhKvEBpBb/oubeTLOPECvTvZ46Uy0gw4aWYdBnye7V1OouCCJhTl8v1JGo5n5wViWs
 KOf+nVllVwfvetiCgOcIAgYdPz1Vh68+TfAVuALpQbbLkiE4fp0XRakvJlESVI65VLjk
 yWBbRPdUyWrexhY+ddaP8YbBhDOd9+ZQMisOocJ6adxqJap7V0dOADuOgVVNuuy6YxT8
 +Cvrp06hsG/JluXH5qzBrRtOpm1G1cCZLjiE4YuPjZ5AEDoKXahlv8LzBieoKAtS9Ej8
 zWGE2ksE1cnUZVNlr5WbZo6hMlERDsygV3BGIS6xnfudGsJuxiajby96Xjs9Aoqlp0jn
 uYJQ==
X-Gm-Message-State: APjAAAU1wN3AotZl/7+n6Zz7tSnP5AKFpUIY2rfDTGD3hEWNLGbeLSTG
 swlknRzEnaQjQmNFdBVj+1QgdOm7ii4Jzg==
X-Google-Smtp-Source: APXvYqw3NDE8CGMQPl/FMQ0jMbEqhV0lUVxnkAWBcA77FnwLF8rjPJ26TwKoVMJZ00ehk8SUkKNHJw==
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr35292359wrs.86.1574170311008; 
 Tue, 19 Nov 2019 05:31:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g8sm3094905wmk.23.2019.11.19.05.31.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 05:31:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] target/arm: Merge arm_cpu_vq_map_next_smaller into sole
 caller
Date: Tue, 19 Nov 2019 13:31:40 +0000
Message-Id: <20191119133145.31466-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119133145.31466-1-peter.maydell@linaro.org>
References: <20191119133145.31466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

From: Richard Henderson <richard.henderson@linaro.org>

Coverity reports, in sve_zcr_get_valid_len,

"Subtract operation overflows on operands
arm_cpu_vq_map_next_smaller(cpu, start_vq + 1U) and 1U"

First, the aarch32 stub version of arm_cpu_vq_map_next_smaller,
returning 0, does exactly what Coverity reports.  Remove it.

Second, the aarch64 version of arm_cpu_vq_map_next_smaller has
a set of asserts, but they don't cover the case in question.
Further, there is a fair amount of extra arithmetic needed to
convert from the 0-based zcr register, to the 1-base vq form,
to the 0-based bitmap, and back again.  This can be simplified
by leaving the value in the 0-based form.

Finally, use test_bit to simplify the common case, where the
length in the zcr registers is in fact a supported length.

Reported-by: Coverity (CID 1407217)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20191118091414.19440-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  3 ---
 target/arm/cpu64.c  | 15 ---------------
 target/arm/helper.c |  9 +++++++--
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e1a66a2d1cc..47d24a53758 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -185,12 +185,9 @@ typedef struct {
 #ifdef TARGET_AARCH64
 # define ARM_MAX_VQ    16
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
-uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq);
 #else
 # define ARM_MAX_VQ    1
 static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
-static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
-{ return 0; }
 #endif
 
 typedef struct ARMVectorReg {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 68baf0482ff..a39d6fcea34 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -458,21 +458,6 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
     cpu->sve_max_vq = max_vq;
 }
 
-uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
-{
-    uint32_t bitnum;
-
-    /*
-     * We allow vq == ARM_MAX_VQ + 1 to be input because the caller may want
-     * to find the maximum vq enabled, which may be ARM_MAX_VQ, but this
-     * function always returns the next smaller than the input.
-     */
-    assert(vq && vq <= ARM_MAX_VQ + 1);
-
-    bitnum = find_last_bit(cpu->sve_vq_map, vq - 1);
-    return bitnum == vq - 1 ? 0 : bitnum + 1;
-}
-
 static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index be67e2c66d6..a089fb5a690 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5363,9 +5363,14 @@ int sve_exception_el(CPUARMState *env, int el)
 
 static uint32_t sve_zcr_get_valid_len(ARMCPU *cpu, uint32_t start_len)
 {
-    uint32_t start_vq = (start_len & 0xf) + 1;
+    uint32_t end_len;
 
-    return arm_cpu_vq_map_next_smaller(cpu, start_vq + 1) - 1;
+    end_len = start_len &= 0xf;
+    if (!test_bit(start_len, cpu->sve_vq_map)) {
+        end_len = find_last_bit(cpu->sve_vq_map, start_len);
+        assert(end_len < start_len);
+    }
+    return end_len;
 }
 
 /*
-- 
2.20.1


