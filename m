Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED23DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9876221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vN+axuX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9876221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xUz-0002oZ-Qp
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k3xSh-00075y-Uc
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:47 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:36870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k3xSf-0001hr-5S
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:47 -0400
Received: by mail-il1-x142.google.com with SMTP id p13so1095983ilh.4
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FLxPSbNc8qBJd2uwAUxDf5Aqk4UdZ/EXxQhhbBHEloc=;
 b=vN+axuX0BiTVzrwJlPuTKVpTIsoUkb0OKxnRR0zclCIJ3Z/zZaU4og1CbUjcn5i5rg
 VhwXXsZASc0IBmkoeV04nKjHmKBl5cZwCm2pAeAIZU6gS1Q8JdScWa3yuI28/Mdqe5Pq
 hWblHShKWYdgYQSWOgxQOyAoeRy7AtDr+bzfVrgr0WxLryNaTrdM5vBZmWh+HoZxAspn
 zTF/FUUWrKjfAMWeCSVRL3RmBEchDFL5Ksfy5kxGJuX4JpXzv+4LYliEx6ww4tHLrkT3
 3U7+j6muzUzE51EwN+9VukgVSEKNBVLpzDPRfdO49m1CfaYhllpGHco8yGiVhYkd5fTp
 H2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FLxPSbNc8qBJd2uwAUxDf5Aqk4UdZ/EXxQhhbBHEloc=;
 b=sRuiFs0j98fNMuvurfWnBxlcOTeq0rgWPtS3xZ0l8yLpm6vxEf+jBqndc6Ui5qawQY
 CPeeG0UZ9Hrgh+eWGEJIuox6zXEQlRwJCrChoPmqWqrJbJunM3KEA4bvTxACk50Zz45S
 tfDLOz1NKe+SSalxByLo+CUCH+Uo3yZGWpfpnrF9Y84JrnPhnfEMPjYJ1k3lYY3Cx3iK
 GIRhZy+dZoi/707B1dy9E0IjUm28fFLXdBrE+CgEfHeeXm69e+YY8kXOKC1m+Bu0bicq
 Cj/rP4UtBWq62OzJ9dqkk8CRtexBfr27LzoobAHm15+XcT0AkVvSs247SNL0WlE9kPjB
 YVTg==
X-Gm-Message-State: AOAM530ahXFdo6FPOMZOGz+FjQk/CVJ9Em6bW3RUKMnLRG4RnpgTZnkA
 DHgbLdi0kRBmk1pzjvm6Z1Q6
X-Google-Smtp-Source: ABdhPJzOnMfnR8+eB4c2VwSlam7zHl15g5VSS9o0BOOPpI9TaAfvecdfSYSUWUwdfwBEmtwRjlQrHQ==
X-Received: by 2002:a92:d60b:: with SMTP id w11mr2984880ilm.156.1596787844021; 
 Fri, 07 Aug 2020 01:10:44 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id l144sm6233546ill.6.2020.08.07.01.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 01:10:43 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: peter.maydell@linaro.org
Subject: [PATCH 4/7] target/arm/kvm: spe: Unify device attr operatioin helper
Date: Fri,  7 Aug 2020 08:10:34 +0000
Message-Id: <3cc31df5191ae6b03e060ccd8e82df74416a3ef5.1596768588.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1596768588.git.haibo.xu@linaro.org>
References: <cover.1596768588.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=haibo.xu@linaro.org; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: drjones@redhat.com, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename kvm_arm_pmu_set_attr() to kvm_arm_dev_set_attr(),
So both the vPMU and vSPE device can share the same API.

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 target/arm/kvm64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 1169237905..75a417d65c 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -398,7 +398,7 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
     return NULL;
 }
 
-static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
+static bool kvm_arm_dev_set_attr(CPUState *cs, struct kvm_device_attr *attr)
 {
     int err;
 
@@ -427,7 +427,7 @@ void kvm_arm_pmu_init(CPUState *cs)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+    if (!kvm_arm_dev_set_attr(cs, &attr)) {
         error_report("failed to init PMU");
         abort();
     }
@@ -444,7 +444,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
     if (!ARM_CPU(cs)->has_pmu) {
         return;
     }
-    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
+    if (!kvm_arm_dev_set_attr(cs, &attr)) {
         error_report("failed to set irq for PMU");
         abort();
     }
-- 
2.17.1


