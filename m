Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3F8C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0581820757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMX5xQML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0581820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7mK-0000gz-3G
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jL-0002YG-G2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jK-0000J9-M8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jK-0000IG-8z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id u16so1541386wmc.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=aa1qqIMnXpjpthzM2FPrENFyjimJ3PELzKEsUQJpRs8=;
 b=IMX5xQMLXV5vCVWhNk06NdmsJFZyfapHgFItGiUnuNTX1DnAly6kKAmFjFw9pNrk5F
 /Ao6io/ZQntIJoyijSaPn7i/OBhMBBkHdB5ELz3FQO6t7m9V1NnMQFCe5/QQOh7G87u9
 x1Ps4oq0uMLmMP2I0veFKTxnHHanmCJEcPLO8ZQAo1yzamTZ8DwRN3bCJMTBiIFF7JP0
 wX1J+WGmefotWajRECtj99m4e3iERpkj5VNZpWFb1om3EbjKN7OXFt6gR0HLtkv25/BU
 OV9qvvwZOgpXFH/5H6kg4dJy2mn/ooNSsZor4xEhjTUNk8sdpxJ4pa9vdXPrGywQreBE
 J6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aa1qqIMnXpjpthzM2FPrENFyjimJ3PELzKEsUQJpRs8=;
 b=gvjZFoW5zmpkxkeLbFKxDGEp1B570F+D2jr0XBkImwcDwP29Yz7nysLTPOaZjTDtKP
 ZG9RL1OC+edngK82C7M4rTpwkdvUekh0DaOmPn6FY1xJXHcuDOinGqHuLyVub1V4Smi+
 6/QlyZqHwVQyLKRE65SkwR5I75/yl1w4/P3qzAc0HaTyrXzGz3uX+qK549/9RRiQbdrq
 cLINSlk/C6XOfD3HhViJ4QjLVXADg/17wL9oFTqkpj/ehXpdfJdm/7fPqroFeTDGXE+A
 KS/v9YNLEVyHOB0R7eGEOuroFM7VH0qxok6u/YPhEAlYw8hCJfKe28hk7+MB/bwz3Owp
 crJQ==
X-Gm-Message-State: AGi0PuaHhF0jCq0Zg9EFEWixdyQgfPtBYV6hiREySV73ZEaBOdfnCP+w
 8CLWtKxH52GwgNklH8G2WAJ8NUhNfo/wKA==
X-Google-Smtp-Source: APiQypItK3+3K3yJyqhPcIpL+rTJvCuB5q/myiiHA5hA3hqBn4qmA2fYCITf1G9yzb9hwYUBp5Ml1A==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr2462301wmj.12.1588247508669; 
 Thu, 30 Apr 2020 04:51:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.51.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:51:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/31] bugfix: Use gicr_typer in arm_gicv3_icc_reset
Date: Thu, 30 Apr 2020 12:51:15 +0100
Message-Id: <20200430115142.13430-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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

From: Keqian Zhu <zhukeqian1@huawei.com>

The KVM_VGIC_ATTR macro expect the second parameter as gicr_typer,
of which high 32bit is constructed by mp_affinity. For most case,
the high 32bit of mp_affinity is zero, so it will always access the
ICC_CTLR_EL1 of CPU0.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Message-id: 20200413091552.62748-2-zhukeqian1@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_kvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 49304ca589d..ca43bf87cab 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -658,13 +658,11 @@ static void kvm_arm_gicv3_get(GICv3State *s)
 
 static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    ARMCPU *cpu;
     GICv3State *s;
     GICv3CPUState *c;
 
     c = (GICv3CPUState *)env->gicv3state;
     s = c->gic;
-    cpu = ARM_CPU(c->cpu);
 
     c->icc_pmr_el1 = 0;
     c->icc_bpr[GICV3_G0] = GIC_MIN_BPR;
@@ -681,7 +679,7 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
 
     /* Initialize to actual HW supported configuration */
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
-                      KVM_VGIC_ATTR(ICC_CTLR_EL1, cpu->mp_affinity),
+                      KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
                       &c->icc_ctlr_el1[GICV3_NS], false, &error_abort);
 
     c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
-- 
2.20.1


