Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11622C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 08:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DEF207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 08:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="qE6zTXif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DEF207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k92bi-0001Di-Kz
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 04:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1k92Zs-0008BJ-Uh
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 04:39:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1k92Zr-0005sZ-8M
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 04:39:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id k20so998327wmi.5
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 01:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MPOQTvWY5mkdTMoe7rAdUs/hKPaBZkWNb8pyJGwr0vQ=;
 b=qE6zTXif/EbApXibLnotpLxetU9HcUx8SDMRGNCtUKK93snTSfdY3ZqHsWi/dC6gdM
 IjpjO8hnqDixWu2VpyemRXYMSyNcFDaPt9+xfDfxspMEIZzqI3GWA8p/flpTXEX1YmI5
 qdWh/rL+qZ4PPlAiu35Z5lj4AND7ppujuMTuy4UlShgGeokugBCVw39nh3Y9PfwSrXu6
 7OVXn9HfJLOp5jibWxRmowTLQivPtDJxWVADdmyDNu1k8f57brC+/2Aecfn80TtvTr/9
 g1panFrDz1okvsWqk2ppmnnCrKbRSOoyFZnPmMLGtQCJF+vai9NpNtUDaOoIQQVnSgA8
 /FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MPOQTvWY5mkdTMoe7rAdUs/hKPaBZkWNb8pyJGwr0vQ=;
 b=fjBJUEtnCRl9vpyBdMsdLfsvrCqH5/Ke/0YWskczR1ebEMXOTdWHuBzZw86bAXuXLm
 QgEEwln2nKEhvl4FnwwC2az2kkEVQAnYH165fY71qluDkAsgop7wQqxdMdj8FZPUdHq8
 qLbalbisBWBlzjMvZEgEGQK2BTxoDE5/6rM07xnwHsgCL9li5Q/d7YjrjLDUNGF+7iAf
 DQJsDoFs7LASwaGu9cSAi968UC5BlAt/A32r5fIGljrZ68rzAZPykMWwCs057NdlH9Vo
 iroiwQ4N5ZjqbMC5gLm57gk+C3m8KxGpzvtm9MlKB3eQEHc+cVH3KLY8ypmuklK4mAAO
 +O/A==
X-Gm-Message-State: AOAM531avj657mjS5aCvVHmZMlvvY1GNIT9YNl4e7L5I+B5CMFrCXzK7
 qwR0PNyQP7dsq5m/4q8r9m89EQ==
X-Google-Smtp-Source: ABdhPJz2O6z3fK6kP7pvHKRrQLqM8z+eM2BPlOIWNzssUxKwcA5qwVQpBZaPpfL8jgsO4dPUGjLg8w==
X-Received: by 2002:a1c:ab06:: with SMTP id u6mr1994664wme.172.1597999149267; 
 Fri, 21 Aug 2020 01:39:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id n24sm3192206wmi.36.2020.08.21.01.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 01:39:08 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH] hw/arm/sbsa-ref: fix typo breaking PCIe IRQs
Date: Fri, 21 Aug 2020 09:38:53 +0100
Message-Id: <20200821083853.356490-1-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x343.google.com
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
 rad@semihalf.com, qemu-devel@nongnu.org, leif@nuviainc.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixing a typo in a previous patch that translated an "i" to a 1
and therefore breaking the allocation of PCIe interrupts. This was
discovered when virtio-net-pci devices ceased to function correctly.

Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
---
 hw/arm/sbsa-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 570faac6e2..48c7cea291 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -565,7 +565,7 @@ static void create_pcie(SBSAMachineState *sms)
 
     for (i = 0; i < GPEX_NUM_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-                           qdev_get_gpio_in(sms->gic, irq + 1));
+                           qdev_get_gpio_in(sms->gic, irq + i));
         gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
     }
 
-- 
2.25.1


