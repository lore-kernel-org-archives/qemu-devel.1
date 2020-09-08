Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368DC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EBFA2177B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtnWrrkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBFA2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYqP-0007mx-HZ
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlL-00065X-SN
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:59 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlJ-0000Ug-32
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:59 -0400
Received: by mail-pf1-x441.google.com with SMTP id n14so2383086pff.6
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=65uW6/eJtxdVQ3erFH0nAd+ZJZrP6B7JK355CS4Evd4=;
 b=DtnWrrkppBALmGDk6WyZ9zbWxElLLqFd9TEqM/7gVsatasdVioc4gVzJGhrkQU9CvY
 r2seFpZkf0Y1tPjBnQyLjqAuOpjzpCRNPksrPmfQNiigepK13Nzi5oVqsvBaVgNd7Yqt
 rL0zvLs0SSBsVDDts6Zuc+vRtb15G7Rzrwk+j1f9ka9gg+UzTcYTLTc3qaRMgja/OzLf
 /4wMqxn6l9fb19RXdpnL6D2BN+nM6O7UufmEBfKYS7tKXrYtn3dsCEjegd79OV55L3Cd
 SCS8xqINFAHT7ELkaZItAMT+PXx+/aful3FmFbCbdJI1Q6sB58nE4NNhcDMe0mOlTi4v
 ElYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=65uW6/eJtxdVQ3erFH0nAd+ZJZrP6B7JK355CS4Evd4=;
 b=InAqCmhOiu0jO7vXx6/dv3cvoD+2QMx4DGflnMASkJSwX7NJwepA5Un3phqEATwT1h
 fkB7ucnLqo5HzAWtp48sF8HZQuARnSU3zGIOgzbG1VvRTl5LSP+ih/thOXEHmIyBAptl
 AsFMWCp3Y7mrFK7lpq+xcOXf/TRgqKOTRmWVSDuC9IZXZoJw7CrIuVO6zJiKHAX3+uP9
 H/BWODq7esUOuzd+9xMlNuVs/TPZO9OUBY1IJj+zT5RwgxXgFlNPlQHLk7kNLXA2gTHH
 klD8ldZ9aJdPw2S26TJaktSua4wb/kKZ1AFlUt4IdMfnhksdYVQJfZr8CMLVP3IrvnMN
 CDGg==
X-Gm-Message-State: AOAM5306DJZC//L9hvwSk0F8pgceg2sQWW4Rtdrzr71Sb+7qWsX+E7c3
 hVVAPJbsj7TfR+MBIsBQSxgf
X-Google-Smtp-Source: ABdhPJyjW9Rf19phSJVRmmBhzz09xfjWkMYaw+EMA/BJBf1jliCjDfdBTTiFTJDMkLPh7KorHTtOBw==
X-Received: by 2002:a17:902:ba81:b029:d0:cbe1:e7ad with SMTP id
 k1-20020a170902ba81b02900d0cbe1e7admr104185pls.30.1599552835913; 
 Tue, 08 Sep 2020 01:13:55 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:55 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 11/12] target/arm/kvm: spe: Enable userspace irqchip
 support.
Date: Tue,  8 Sep 2020 08:13:29 +0000
Message-Id: <6aaa406b824d0c427acbc3f3abfbbe841f3bb93c.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599549462.git.haibo.xu@linaro.org>
References: <cover.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=haibo.xu@linaro.org; helo=mail-pf1-x441.google.com
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

Since the current kernel patches haven't enabled the
userspace irqchip support, this patch is not verified yet!

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 linux-headers/linux/kvm.h | 1 +
 target/arm/kvm.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 8840cbb01c..35ef0ae842 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1672,6 +1672,7 @@ struct kvm_assigned_msix_entry {
 #define KVM_ARM_DEV_EL1_VTIMER		(1 << 0)
 #define KVM_ARM_DEV_EL1_PTIMER		(1 << 1)
 #define KVM_ARM_DEV_PMU			(1 << 2)
+#define KVM_ARM_DEV_SPE			(1 << 3)
 
 struct kvm_hyperv_eventfd {
 	__u32 conn_id;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 58f991e890..7950ff1d83 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -820,6 +820,11 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
             switched_level &= ~KVM_ARM_DEV_PMU;
         }
 
+        if (switched_level & KVM_ARM_DEV_SPE) {
+            qemu_set_irq(cpu->spe_interrupt,
+                         !!(run->s.regs.device_irq_level & KVM_ARM_DEV_SPE));
+            switched_level &= ~KVM_ARM_DEV_SPE;
+        }
         if (switched_level) {
             qemu_log_mask(LOG_UNIMP, "%s: unhandled in-kernel device IRQ %x\n",
                           __func__, switched_level);
-- 
2.17.1


