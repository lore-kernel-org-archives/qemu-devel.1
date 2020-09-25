Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC031C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C622076D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="RLWl3Fcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C622076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnxn-0002nS-1l
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kLnwc-0001vu-6Y
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:39:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kLnwa-0007h9-8F
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:39:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id d4so3058069wmd.5
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LEapBT5lGA8vRx16w4G1jp1xfCgBRVKisEf5jOFHwNk=;
 b=RLWl3FczdndaCQi72oSqFi7gKVxG4d3TI/DKrEKNspCwS/LDF2qLUaQAh01iiQWhGh
 BILQvgjftHjqR/mDwjXlzkV/x8Pvzas7ezgn4nUIuOHMKfYLkGXxxY0p3JiIkc7MMMcg
 3g5Sswy1YvQW9yTzjOySfBDpOTAtYBYAU1JN89EWMc1ZHQtO2xTuT0EZNY/S/fVIb8i0
 LXzDj98UbrEOlFIetefcIgJj0dcJawaTGUG0NorQtP4Vd32nex3bq+N+hXob4Twfrcm4
 3gcnPr9EqSEjlXNIU6voD7sBqKBeN8rNo8SgCzk4B8lDwich5zKdlEbUCisF38N9LJf9
 bWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LEapBT5lGA8vRx16w4G1jp1xfCgBRVKisEf5jOFHwNk=;
 b=gnATZRcAO8NaCey+T73z3s/1OqWWYdDi/n54/DwFohSNF9NbD+eOVbA9raE9727hSa
 QpZxKUMoVhkr+UiS90yzx9CR7KIvc3y4A2YqnSRqgSyJuRHFK4FLyFLS2c/zO8T8y/F2
 JL+YDW71/azktcMrupq2hgnSsaV2lBZgoT7Yf5pT/O3Q7IdHYyN1ed4wn6NPd3YK1RmN
 IHbNjhrQXn9+JW0tr9Z4EsGwjFapPBWFYA+A7kZI2+Y53gw5l68pX2Bi0GJyZp+0uOaK
 6kspCGneliDs2BY1wA009j8Jv9GN+xd5wzSA1oAM9Lw455cDFUW+li7ofNvk+mCXMimY
 +xZw==
X-Gm-Message-State: AOAM530z3Z72xPYtUeuBQUejzuXEew8NJjEAR1KEkkrQcX1H724K0TuG
 j5qJcICrHTYOZXt2YGx3r27VyQ==
X-Google-Smtp-Source: ABdhPJz+0ee5DDPSTzodMmcCR3wUh/2zd8CCBLSRxEum+RTwgUd1LwyUPP5xLa+oiu9cGyVAIsNpEw==
X-Received: by 2002:a1c:9d43:: with SMTP id g64mr3536112wme.16.1601041162147; 
 Fri, 25 Sep 2020 06:39:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id d19sm2860921wmd.0.2020.09.25.06.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 06:39:21 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH] hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
Date: Fri, 25 Sep 2020 14:39:02 +0100
Message-Id: <20200925133902.28349-1-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x341.google.com
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
 jamie@nuviainc.com, rad@semihalf.com, qemu-devel@nongnu.org, leif@nuviainc.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SMMUv3 has an error in previous patch where a i was transposed to a 1
meaning interrupts would not have been correctly assigned to the SMMUv3
instance.

The code also contained an error in that the IRQs were never allocated
in the irqmap.

Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
---
 hw/arm/sbsa-ref.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 257ada9425..9109fb58be 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -138,6 +138,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_SECURE_UART_MM] = 9,
     [SBSA_AHCI] = 10,
     [SBSA_EHCI] = 11,
+    [SBSA_SMMU] = 12, /* ... to 15 */
 };
 
 static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
@@ -530,7 +531,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-                           qdev_get_gpio_in(sms->gic, irq + 1));
+                           qdev_get_gpio_in(sms->gic, irq + i));
     }
 }
 
-- 
2.25.1


