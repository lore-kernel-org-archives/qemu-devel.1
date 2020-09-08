Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D8EC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1337921D20
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lsduiPeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1337921D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYmC-0007mt-0y
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlD-0005in-LG
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:51 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlB-0000Ri-OE
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:51 -0400
Received: by mail-pg1-x543.google.com with SMTP id m5so9504319pgj.9
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bjXqJB5fZDovb5keozBFqhrjyKCJ3LE/1kjYNOFtg8s=;
 b=lsduiPeW2KAAqBLIvyI/8FZJf9DdqV11oODQYW+mHmktQWlrq8JKQhBNqHOYftlV8h
 kXnXOB4iC+DAgzeakNlWC4mNsxowb3AjsLhw7SoVQJLykH3p+XSU1EE7DnAEgZ2v2p1X
 ekkD+zYHj1MiH5pEojjHtb4uT+E64xMw7Ntu4A3PH9GBAkrFbIVm4tKz7m5UUO2PU5af
 P/1yJq0WITCZQ9wSs2lqC0gSjozPi7bDCHT49gJPophxYlo9LQdEcLLQDrA73F7HYFkH
 bxh7JFNVg+Xim7DSmlptXBxIEGjWo8q70Ds6gbW0/vxky7gsUI7f5Uzralry/LBmvac0
 hyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bjXqJB5fZDovb5keozBFqhrjyKCJ3LE/1kjYNOFtg8s=;
 b=O4KMVVhQbrYzhZLDzsDEpgWq7qp0dG8d2SJ4W6S/qLomjMuyWSOuB8sXm+LyLRkg1f
 gH0l+nOdQiPPx1KZO3/dxwzmSbmX9DfnCZ/tzcy/0JMpIqaoUsrFtR8IcMdFtvP4qmMU
 NPeCYqkaM3LCt/2C/aFWSGM1SZIxU2NPULTA6rbNFtDxOATujirnNWDjNSGeAWTt5yZq
 5JdnQrb2EFbxNHO+DA6kP/CbXIIP4Ty01wUHBgV5kcTGtFsTWYtjABgFqnNHcxNQepIe
 5N6R9IOBZ6x5BpfsE4VIS4jzdDBR1CdfKkDWRV4u9mJHxjzxad7sCNeDuoSgkJc4U0Wn
 MiAg==
X-Gm-Message-State: AOAM530OO+DArrX5Y4rNzYYJ1YXM+Rs+pFGzyXEhJXHd7SigcB2Ij33Z
 ZvHi68X1hAXmm+tqYDkcQZWC
X-Google-Smtp-Source: ABdhPJylmtrJl17mr9kZtPXSvMv1JK628xdtlWEQ3D0RT9vLOo5U+gL+MQC9+74EXMsdmc2cdyoHRw==
X-Received: by 2002:a17:902:465:b029:d0:89f1:9e2a with SMTP id
 92-20020a1709020465b02900d089f19e2amr21643144ple.6.1599552828430; 
 Tue, 08 Sep 2020 01:13:48 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:48 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 05/12] target/arm/kvm: spe: Unify device attr operation
 helper
Date: Tue,  8 Sep 2020 08:13:23 +0000
Message-Id: <45eecae26272efc7a09837573cd5278296b58dc5.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599549462.git.haibo.xu@linaro.org>
References: <cover.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=haibo.xu@linaro.org; helo=mail-pg1-x543.google.com
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

From: Andrew Jones <drjones@redhat.com>

Rename kvm_arm_pmu_set_attr() to kvm_arm_set_device_attr(),
So both the vPMU and vSPE device can share the same API.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 target/arm/kvm64.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index ef1e960285..8ffd31ffdf 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -397,19 +397,20 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
     return NULL;
 }
 
-static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
+static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
+                                    const char *name)
 {
     int err;
 
     err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
     if (err != 0) {
-        error_report("PMU: KVM_HAS_DEVICE_ATTR: %s", strerror(-err));
+        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
         return false;
     }
 
     err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
     if (err != 0) {
-        error_report("PMU: KVM_SET_DEVICE_ATTR: %s", strerror(-err));
+        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
         return false;
     }
 
@@ -426,7 +427,7 @@ void kvm_arm_pmu_init(CPUState *cs)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
         error_report("failed to init PMU");
         abort();
     }
@@ -443,7 +444,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
         error_report("failed to set irq for PMU");
         abort();
     }
-- 
2.17.1


