Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5CAC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069852087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcuIgzP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069852087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cNT-0004SX-9J
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bv7-00087O-DP
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bv2-0006W1-Vr
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bv0-0006UG-BN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id k1so204945wmi.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xETLZAwStJiPTA1iTveb1EK9m8PyaZc484o5SN7kXzM=;
 b=rcuIgzP3lIG1kEuTPD29MnJojHabum3zRstwD98/oHz8ZAsi6TuXSQ2rfOUeD1F1gA
 rOe8weNH7MCOBt2Tqo/aX1Xml65w7gN8tRrYfJWSJUdh+o4zwRkx0kMWNCes2fuDdc7M
 ANaod76clnGMYmLZgVlrW75xUJEtM/XkOcP7a+6S2U9eo8oBDoRwSav9XmDxehwT93/H
 Shv3Pz//ZKSPZENypmcyFbD9sNf4gC3HEhY+Eotuv66EL532mScT3fVzRCEKCq6QqfHS
 ZXyuzVnnqAzMdZV4JiNeQanxiQDhWwMLdno30vIoLDFjnGM18H3DXy1D6Fzf6vb4XgTd
 LV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xETLZAwStJiPTA1iTveb1EK9m8PyaZc484o5SN7kXzM=;
 b=T0+hHlkVxwki0PoZ26rpHWrnGo1F7WRNZXB7paQpJjqr4Iwvr/6ipZoMUbz6jg7lGB
 MK955uU8Rypy6UWuWvGsMWVhXkB/kUcmsoyvM5oqj+aGmutLNkh4EBf/aeFCojUa6tam
 i5CDgC2TgtD/nS8ZdYg+Fsz4GAehDJngqxLwoqe9xnLweb40x4z3oQtWrHN2D9LZGgPh
 FKmMloF7v2A/Wa4YWRmYHoZCh/smIFw/BBLjjjG+Yv6zAIOU4IVVqEIqK36eYL90coSg
 M0rxOF4lEi0QQDAdr9v4LplHpfZAlOyBlSsBKQeUkBnOvQ2N6odBJS2GobZ5Nni0gGwI
 wa7w==
X-Gm-Message-State: APjAAAVlptHM0+cGL20z3ezqrv+VxzkCUQJG/KfAXXRlezYgehMaCkRU
 aLgQ1qA7/kuVu/SacHLwBm0wswt3pmg=
X-Google-Smtp-Source: APXvYqz6uqNr6jXVC4yHV1i53b00nBUhiZVbECEqzNWwEd0JYnKWY6PT6Blmc73YZKvVJFtewV7Vxg==
X-Received: by 2002:a7b:cd97:: with SMTP id y23mr101486wmj.74.1567629015796;
 Wed, 04 Sep 2019 13:30:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u68sm251105wmu.12.2019.09.04.13.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6E63A1FF8C;
 Wed,  4 Sep 2019 21:30:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:32 +0100
Message-Id: <20190904203013.9028-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v1 01/42] hw/misc: Mark most objects as
 "common" code to speed up compilation a litte bit
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
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
---
 hw/misc/Makefile.objs | 90 +++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

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


