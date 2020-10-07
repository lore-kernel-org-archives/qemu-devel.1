Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD691C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91D020782
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="QGY03Oiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91D020782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6SK-00014B-JA
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kQ6MU-0005Re-1L
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:07:54 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kQ6MR-0004UT-SC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:07:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id l15so4138230wmh.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 03:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YihA7yp+FeuvnOD+ItdPRKyM2WwnF/945pTZ2qmhEKM=;
 b=QGY03OiviP3VO8EJ6Vrq0gX9uVLmo3GVKeYMImS2UtdssGZGUlh1kFYF/PN+2+McO0
 XBZYCSVIlY7HACV9cyVv7jSrBeFq3qtoUP+pKU29J7+PQujinyZnFImVM+pIVBz+ltE3
 Yqtd08BgIA2/L+AyQtmRW2NcD3sC5mJ6i0hdjyhTypXen2B4HQUzGMDrMwjB42urnJMM
 3tTz0vcjp98ZfFFWFQ3YrAjNVjo5op7vhCZNjOa5Occwv6i1UIK+i3u/dp65VmIJO9IJ
 uhnoXDH87tksEm0r3w2AxMvucx5mnF7e0bw3M+aIK4FsuYemmGlqTwr6el1deyCM/9yg
 ksbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YihA7yp+FeuvnOD+ItdPRKyM2WwnF/945pTZ2qmhEKM=;
 b=ONRJjuDrojmR2Fr3fdziVtGRtPhNkjDfaj9rs/pzerPIBaY1r/YVKS4eD9sr9vpJ9w
 UaVFmcx8yqw29LMJycWjMlXEt8hdbN8PrzHHIOvm5djihsnYh2bhtG+OQovKkhjqzABu
 yX/9/W7RmL2C/lBAw9jC91EWzXaHt6Jyr6HBYmUwFG891cR+PqTJNco4OXkjPMHdtaQ8
 VYnAuNALu66KpPAmICLwm9NTc/jNckCjN0FT7YKe6PjLWqCBPaRZhHZrhgmUe6lRzktF
 K6UXMhDPd2xWzi7cJ9Rtcx+LtmLR+A0xW1rQrjtejweTGzMgafLaPk1Yik7uJURsUFzn
 Bc6A==
X-Gm-Message-State: AOAM530TRI1eOhKPfh+1yJ8wUutDcaVmoSzkjueXRHA/FwCijEWL/nXm
 jmos/fGz8iOTZ7b0mjADTidG4w==
X-Google-Smtp-Source: ABdhPJxS3yG7sd6UGMq+wNUscNkUEe8IDkBvtKtB8kqnzDnAB970qm8tPgGrN3nwwBIORzSUaUklkg==
X-Received: by 2002:a1c:b707:: with SMTP id h7mr2578043wmf.105.1602065270332; 
 Wed, 07 Oct 2020 03:07:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id y6sm2208504wrt.80.2020.10.07.03.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 03:07:49 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH v2 1/2] hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
Date: Wed,  7 Oct 2020 11:07:31 +0100
Message-Id: <20201007100732.4103790-2-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007100732.4103790-1-graeme@nuviainc.com>
References: <20201007100732.4103790-1-graeme@nuviainc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Graeme Gregory <graeme@nuviainc.com>, peter.maydell@linaro.org,
 rad@semihalf.com, f4bug@amsat.org, qemu-devel@nongnu.org, leif@nuviainc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SMMUv3 has an error in a previous patch where an i was transposed to a 1
meaning interrupts would not have been correctly assigned to the SMMUv3
instance.

Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
---
 hw/arm/sbsa-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 9c3a893bed..65e64883b5 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -525,7 +525,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-                           qdev_get_gpio_in(sms->gic, irq + 1));
+                           qdev_get_gpio_in(sms->gic, irq + i));
     }
 }
 
-- 
2.25.1


