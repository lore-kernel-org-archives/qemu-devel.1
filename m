Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43382C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E352177B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJ8gJHor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E352177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYpR-0005wS-3K
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlA-0005Zp-3i
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:48 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYl8-0000Qo-5b
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:47 -0400
Received: by mail-pf1-x442.google.com with SMTP id o20so10317087pfp.11
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NODmkJ7zv3Ze8nSAAv5Nj47e1RMWaOU9HVwH97SKsQI=;
 b=vJ8gJHor/P+Jl1BmkcHCpjIjT1JCsWa6RcvfIElzkZQMD3ubbmjT/n4HZwlmsc0Xfg
 WZ7W5PqRbzbppkxmUx5FGpPFmOo/le/LfovbCExJ/KZZb1+3Oe6rnMU4jFgKOoOz+16M
 afDRw36jeZOE7ot9hJBxsZKXf5HBp1DeBmcDM1sUJvKboUpteuu4Wv+1rm3eJtg3WlOo
 4zSYvpKY8QKbZlFF9utJce6omxNc2nR0jsI0Gb/LDmHVHGmStvtbHHA2orgC+UB/19dS
 gyjlh7/omwadkmQbqlsG5QM2n5klBJtQhsjwDpblHY4dtWrlyEpL81GgnwZrvD3jWHq3
 qYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NODmkJ7zv3Ze8nSAAv5Nj47e1RMWaOU9HVwH97SKsQI=;
 b=UBUtRqu8zIGwn81fM752ksqa1IdQtb2gzNvgk61e8BK+CZLQLB0hiDFbEKsmTUvNW8
 ZWVH3EDibZLnSZqYDXahJgXRAvoi5b+Gvvm75BgWomWKme3gXna4D/w5mms1iSUxrfuF
 1tToqAwg/oQgpeeWhSYYw0YDDuNKw5TPJlYjeg7i/YCE0No2JA5sFYsyUcBVgsfc7ByA
 cxKyc4OqOKZieUYr2S00iSXJKh39U0Dm6iOLZhcAhPrvLlcXuFL22BauvV3g8SoDm7F7
 76u/vUDJdpKJFRi+aZBon7kX872yBw0pZmDHc/c8/DRp9uCAl96+b5aipqqxkm1Ddhqq
 j21Q==
X-Gm-Message-State: AOAM532ZAbrY0CRVws6Z+4w2XcK9/ghjBea23OjlzVb6Qc8Hf9OuI94T
 Cq+hNtAdELc+aegXjyXhuMsC
X-Google-Smtp-Source: ABdhPJzgLx4UQgP6yyhdcInmJWMQ0HAUz7sgbFGB0lHVYb1i2OF/WDYChEOh9R+ur8iZII5VPn0UTw==
X-Received: by 2002:a17:902:8bc2:b029:d0:cbe1:e709 with SMTP id
 r2-20020a1709028bc2b02900d0cbe1e709mr98104plo.23.1599552824822; 
 Tue, 08 Sep 2020 01:13:44 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:44 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 02/12] target/arm/kvm: spe: Add helper to detect SPE when
 using KVM
Date: Tue,  8 Sep 2020 08:13:20 +0000
Message-Id: <e4a8f10ed4e3379994b7e260ad6ef715512289d4.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599549462.git.haibo.xu@linaro.org>
References: <cover.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=haibo.xu@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 target/arm/kvm.c     |  5 +++++
 target/arm/kvm_arm.h | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8bb7318378..58f991e890 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -214,6 +214,11 @@ bool kvm_arm_pmu_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
 }
 
+bool kvm_arm_spe_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_SPE_V1);
+}
+
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
 {
     KVMState *s = KVM_STATE(ms->accelerator);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index adb38514bf..f79655674e 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -283,6 +283,14 @@ bool kvm_arm_aarch32_supported(void);
  */
 bool kvm_arm_pmu_supported(void);
 
+/**
+ * kvm_arm_spe_supported:
+ *
+ * Returns: true if the KVM VCPU can enable its SPE
+ * and false otherwise.
+ */
+bool kvm_arm_spe_supported(void);
+
 /**
  * kvm_arm_sve_supported:
  *
@@ -366,6 +374,11 @@ static inline bool kvm_arm_pmu_supported(void)
     return false;
 }
 
+static inline bool kvm_arm_spe_supported(void)
+{
+    return false;
+}
+
 static inline bool kvm_arm_sve_supported(void)
 {
     return false;
-- 
2.17.1


