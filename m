Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07858C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C514D20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvTOsJOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C514D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bnK-0005OB-94
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkj-0003KZ-1i
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkh-0006Ht-Ml
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:56 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkh-0006Gm-FB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:55 -0400
Received: by mail-wr1-x42f.google.com with SMTP id l11so18361421wrx.5
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iEMfemb7tE5MHqpQBihqUqf10bZPCoUG3OSMR/N5oWA=;
 b=XvTOsJODk60fMpUpXvUxNjchYT1rYMD4Hq3XCqiqkB69wPkmGmALqFcaP6m0OHjTsZ
 84jX1xkOn8kno62cYehh4l484qo4pTUuFXAGlYSg2+YNLfkCKlnM/HshEiENJlTAjfhD
 k98RkJJoIqSRr5XOjTerrHCXMYAVewsZ0t6fzsiKuBMXOJAncJsLcZVLVIu9FDzbrVwv
 LOevg2yPEZa4oWifLX2Em7y2SsExyvGlVxqUVmBGkPxB6v3f7jnrUmtZZQgar3ud4Yxk
 aLlyAhk7tMmaH+kl8SbXOgWZ+/0OuAjlBslfk6ywpY8ZCU7/JKkOZZ3Y0PbPlsS4J3/q
 dYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iEMfemb7tE5MHqpQBihqUqf10bZPCoUG3OSMR/N5oWA=;
 b=OT7R+yf3ybkYsH5NxbKD70J1yRxMLWwFIgdqtcCb3uLsSJU14jQIvixcKsBYevGMZb
 bmMSd5x/Mq/b9UFVYCLXpMxv+kggLSdJ4QXQsoVJBJNBUWZVwfWkQuEt0e5RqnGXIXia
 oEMg6eAdv4gZ1yJqpl5biy7awn/O9SYNbi8e4GEdEAaEl9/d8i803RbqasrG1OV0NB4Y
 qceQPovXD+ZDc3zpGRV6gbmN5i27zihWHX5CX9O8CWs402Q4BAEqD1EN1EipNa3ytV9l
 5jPGvKLMtkcu8wc9stBDQCYV7obdJ64dPjk1jnmlgbpqTUsBg4J58g4tByvYPAyYO23/
 N+kQ==
X-Gm-Message-State: APjAAAX6ceLoyPDT+Ab8esvkrVODt+GYwNkCPMXoLO7YNaI5McJFfCPc
 GAI0VeJ2y6jNEeM/TPm6Yi47Pg==
X-Google-Smtp-Source: APXvYqy3Hr0rZt++Rt+gVt3v301ifFYDxXB1bJNsarenhQrkcZDciMAqAI24QXNI8zp16URaaHv9Pw==
X-Received: by 2002:a5d:5606:: with SMTP id l6mr1681123wrv.108.1568105033000; 
 Tue, 10 Sep 2019 01:43:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r18sm19131577wrx.36.2019.09.10.01.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 85F7E1FF8C;
 Tue, 10 Sep 2019 09:43:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:05 +0100
Message-Id: <20190910084349.28817-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 01/45] hw/misc: Mark most objects as "common"
 code to speed up compilation a litte bit
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Most of the code in hw/misc/ does not directly depend on CPU-specific
code. Mark it as "common" so that the code can be shared between e.g.
qemu-system-arm and qemu-system-aarch64, or between the various mips
flavours, instead of recompiling it for each and every target again
and again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190902162638.28142-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index e4aad707fb4..a1506809660 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -26,57 +26,57 @@ common-obj-$(CONFIG_PUV3) += puv3_pm.o
 
 common-obj-$(CONFIG_MACIO) += macio/
 
-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
+common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 
-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
-obj-$(CONFIG_NSERIES) += cbus.o
-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_pmu.o exynos4210_clk.o exynos4210_rng.o
-obj-$(CONFIG_IMX) += imx_ccm.o
-obj-$(CONFIG_IMX) += imx31_ccm.o
-obj-$(CONFIG_IMX) += imx25_ccm.o
-obj-$(CONFIG_IMX) += imx6_ccm.o
-obj-$(CONFIG_IMX) += imx6ul_ccm.o
+common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
+common-obj-$(CONFIG_NSERIES) += cbus.o
+common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
+common-obj-$(CONFIG_EXYNOS4) += exynos4210_pmu.o exynos4210_clk.o exynos4210_rng.o
+common-obj-$(CONFIG_IMX) += imx_ccm.o
+common-obj-$(CONFIG_IMX) += imx31_ccm.o
+common-obj-$(CONFIG_IMX) += imx25_ccm.o
+common-obj-$(CONFIG_IMX) += imx6_ccm.o
+common-obj-$(CONFIG_IMX) += imx6ul_ccm.o
 obj-$(CONFIG_IMX) += imx6_src.o
-obj-$(CONFIG_IMX) += imx7_ccm.o
-obj-$(CONFIG_IMX) += imx2_wdt.o
-obj-$(CONFIG_IMX) += imx7_snvs.o
-obj-$(CONFIG_IMX) += imx7_gpr.o
-obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
-obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
-obj-$(CONFIG_MAINSTONE) += mst_fpga.o
-obj-$(CONFIG_OMAP) += omap_clk.o
-obj-$(CONFIG_OMAP) += omap_gpmc.o
-obj-$(CONFIG_OMAP) += omap_l4.o
-obj-$(CONFIG_OMAP) += omap_sdrc.o
-obj-$(CONFIG_OMAP) += omap_tap.o
-obj-$(CONFIG_RASPI) += bcm2835_mbox.o
-obj-$(CONFIG_RASPI) += bcm2835_property.o
-obj-$(CONFIG_RASPI) += bcm2835_rng.o
-obj-$(CONFIG_SLAVIO) += slavio_misc.o
-obj-$(CONFIG_ZYNQ) += zynq_slcr.o
-obj-$(CONFIG_ZYNQ) += zynq-xadc.o
-obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
+common-obj-$(CONFIG_IMX) += imx7_ccm.o
+common-obj-$(CONFIG_IMX) += imx2_wdt.o
+common-obj-$(CONFIG_IMX) += imx7_snvs.o
+common-obj-$(CONFIG_IMX) += imx7_gpr.o
+common-obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
+common-obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
+common-obj-$(CONFIG_MAINSTONE) += mst_fpga.o
+common-obj-$(CONFIG_OMAP) += omap_clk.o
+common-obj-$(CONFIG_OMAP) += omap_gpmc.o
+common-obj-$(CONFIG_OMAP) += omap_l4.o
+common-obj-$(CONFIG_OMAP) += omap_sdrc.o
+common-obj-$(CONFIG_OMAP) += omap_tap.o
+common-obj-$(CONFIG_RASPI) += bcm2835_mbox.o
+common-obj-$(CONFIG_RASPI) += bcm2835_property.o
+common-obj-$(CONFIG_RASPI) += bcm2835_rng.o
+common-obj-$(CONFIG_SLAVIO) += slavio_misc.o
+common-obj-$(CONFIG_ZYNQ) += zynq_slcr.o
+common-obj-$(CONFIG_ZYNQ) += zynq-xadc.o
+common-obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
 obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
 obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
 obj-$(CONFIG_MIPS_ITU) += mips_itu.o
-obj-$(CONFIG_MPS2_FPGAIO) += mps2-fpgaio.o
-obj-$(CONFIG_MPS2_SCC) += mps2-scc.o
+common-obj-$(CONFIG_MPS2_FPGAIO) += mps2-fpgaio.o
+common-obj-$(CONFIG_MPS2_SCC) += mps2-scc.o
 
-obj-$(CONFIG_TZ_MPC) += tz-mpc.o
-obj-$(CONFIG_TZ_MSC) += tz-msc.o
-obj-$(CONFIG_TZ_PPC) += tz-ppc.o
-obj-$(CONFIG_IOTKIT_SECCTL) += iotkit-secctl.o
+common-obj-$(CONFIG_TZ_MPC) += tz-mpc.o
+common-obj-$(CONFIG_TZ_MSC) += tz-msc.o
+common-obj-$(CONFIG_TZ_PPC) += tz-ppc.o
+common-obj-$(CONFIG_IOTKIT_SECCTL) += iotkit-secctl.o
 obj-$(CONFIG_IOTKIT_SYSCTL) += iotkit-sysctl.o
-obj-$(CONFIG_IOTKIT_SYSINFO) += iotkit-sysinfo.o
-obj-$(CONFIG_ARMSSE_CPUID) += armsse-cpuid.o
-obj-$(CONFIG_ARMSSE_MHU) += armsse-mhu.o
+common-obj-$(CONFIG_IOTKIT_SYSINFO) += iotkit-sysinfo.o
+common-obj-$(CONFIG_ARMSSE_CPUID) += armsse-cpuid.o
+common-obj-$(CONFIG_ARMSSE_MHU) += armsse-mhu.o
 
-obj-$(CONFIG_PVPANIC) += pvpanic.o
-obj-$(CONFIG_AUX) += auxbus.o
-obj-$(CONFIG_ASPEED_SOC) += aspeed_xdma.o
-obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
-obj-$(CONFIG_MSF2) += msf2-sysreg.o
-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
+common-obj-$(CONFIG_PVPANIC) += pvpanic.o
+common-obj-$(CONFIG_AUX) += auxbus.o
+common-obj-$(CONFIG_ASPEED_SOC) += aspeed_xdma.o
+common-obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
+common-obj-$(CONFIG_MSF2) += msf2-sysreg.o
+common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
 
-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
+common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
-- 
2.20.1


