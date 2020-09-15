Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD148C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E55320897
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WCB9iQFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E55320897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI1PA-0001xk-CD
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 23:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1O6-0000Dq-CK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:10 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:32933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1O2-0001fV-65
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:10 -0400
Received: by mail-pl1-x636.google.com with SMTP id d19so594194pld.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 20:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SVvavflqwBHyVfPeo3WkPtz2sD2s7cZLSNZLl+ZfUO0=;
 b=WCB9iQFeDkSIxhrOaxldsUCpTkakmnF3WXhKhUR08k7N3Cz8gNPyiQAK+sdNGusu4x
 M81u8VLniD7W7iDXb6O19pQlWstd2YyJcebF+nNjdl4XFMVj5/w63fzeXYFSxpbwFbNQ
 OJJj0wIIuBTTwoUUAW7zfFgdiEplas1GBENkhCwnD+5dFFlr2Kr11zfuMedEI9Gs4rFw
 3B2LhcsPm/K+6nZncZ4oATmTNPsQJN9n42CuEvIkoaTBtYE3pbs5vYJ53SxwJFH6nJ77
 GEwmkacaZDZf830deyyIFxZOxDrNMXnjCQVM/TWmIps8GxYqbr17dMQqSnVC+LnyOgAQ
 Xyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SVvavflqwBHyVfPeo3WkPtz2sD2s7cZLSNZLl+ZfUO0=;
 b=U6qw56JyydhkHrcUb4RAE7WojIYYb5U7KSHoJUyWBFBO12hDinzLvcik+EV0SRZC3u
 vwpHIem+dnbEAAv8e2N+O8Wuu+Ksq8NoIjnq5spqTAUER4CBkxRFrRz52tUk+fZIe4so
 o7OVPgr29mJbk3H+Mcs6kYPcXjgAa+Y+dQaIUbiLtRrASXZ7QIUM+PeWi/P7T3lpRcd+
 LKtKqcHtKquduyGsy/6xKh0h0JQhlVYkjelNW5Edn7e3P74uN1s+SAc7ClLdfdveXkNa
 KpBVdewYC4v3EmtGMlxjcosHM5TxRU24KkMGytFyNCqa8QRBf7EiUAxaSPxVGkn3Z9En
 h3zA==
X-Gm-Message-State: AOAM531fBR+JiP5gK465tOSarmmJVuQVf7ozsh5ZcD1uUuJ0mxH06bki
 dlZGIBhI6PcRnJKBcUCKstzq
X-Google-Smtp-Source: ABdhPJy4WyfSoPkhNCjMt4vcB0H/0IL3G7ppFyAhFYFNHqCkNIqj/D31GDKHxnn8V+pm7dFUDwBTqw==
X-Received: by 2002:a17:902:e901:b029:d1:920c:bf93 with SMTP id
 k1-20020a170902e901b02900d1920cbf93mr16620603pld.21.1600139524697; 
 Mon, 14 Sep 2020 20:12:04 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id g23sm11551776pfh.133.2020.09.14.20.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 20:12:04 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v3 01/12] update Linux headers with new vSPE macros
Date: Tue, 15 Sep 2020 03:11:37 +0000
Message-Id: <35e621987cca029c207c9ef68032364d2b765cf7.1600135462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600135462.git.haibo.xu@linaro.org>
References: <cover.1600135462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=haibo.xu@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 linux-headers/asm-arm64/kvm.h | 4 ++++
 linux-headers/linux/kvm.h     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 9e34f0f875..802319ee02 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -106,6 +106,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_SVE		4 /* enable SVE for this CPU */
 #define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
 #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
+#define KVM_ARM_VCPU_SPE_V1		7 /* Support guest SPEv1 */
 
 struct kvm_vcpu_init {
 	__u32 target;
@@ -334,6 +335,9 @@ struct kvm_vcpu_events {
 #define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
 #define KVM_ARM_VCPU_PVTIME_CTRL	2
 #define   KVM_ARM_VCPU_PVTIME_IPA	0
+#define KVM_ARM_VCPU_SPE_V1_CTRL	3
+#define   KVM_ARM_VCPU_SPE_V1_IRQ	0
+#define   KVM_ARM_VCPU_SPE_V1_INIT	1
 
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_VCPU2_SHIFT		28
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index a28c366737..35ef0ae842 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1031,6 +1031,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_SECURE_GUEST 181
 #define KVM_CAP_HALT_POLL 182
 #define KVM_CAP_ASYNC_PF_INT 183
+#define KVM_CAP_ARM_SPE_V1 184
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1671,6 +1672,7 @@ struct kvm_assigned_msix_entry {
 #define KVM_ARM_DEV_EL1_VTIMER		(1 << 0)
 #define KVM_ARM_DEV_EL1_PTIMER		(1 << 1)
 #define KVM_ARM_DEV_PMU			(1 << 2)
+#define KVM_ARM_DEV_SPE			(1 << 3)
 
 struct kvm_hyperv_eventfd {
 	__u32 conn_id;
-- 
2.17.1


