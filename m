Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793CC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E953D204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egvj6ZdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E953D204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WNQ-0001OO-5d
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnW-0007Ma-GD
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29604
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VnS-00036i-Sy
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVsDX30RTD9z+oD9dhmNp34h9p3joMXuW8pOt1DLvWk=;
 b=egvj6ZdSuzd8RovRjzX30PFS0MtVnmQG4Cf43GrkMVlA3Q33KL3vjr4OTru95z2AjDxyqW
 yAMyQ9dOE6o2zjOAcn8Dfv0URb3SBXCnkl0elteKbY9G1Wa3Zv/pVd0ZtClEL7cnx1aocl
 GQsM5ku+xexcdxrLQ32GfurZp/aFwK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-wM_v-myxM16c6OUM_w6x3A-1; Fri, 14 Aug 2020 05:14:43 -0400
X-MC-Unique: wM_v-myxM16c6OUM_w6x3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9DDB801AC3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:14:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 861A160C04;
 Fri, 14 Aug 2020 09:14:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 108/150] meson: convert hw/misc
Date: Fri, 14 Aug 2020 05:12:44 -0400
Message-Id: <20200814091326.16173-109-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 03:37:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs            |  1 -
 hw/meson.build              |  1 +
 hw/misc/Makefile.objs       | 95 -----------------------------------
 hw/misc/macio/Makefile.objs |  5 --
 hw/misc/macio/meson.build   |  8 +++
 hw/misc/meson.build         | 99 +++++++++++++++++++++++++++++++++++++
 6 files changed, 108 insertions(+), 101 deletions(-)
 delete mode 100644 hw/misc/Makefile.objs
 delete mode 100644 hw/misc/macio/Makefile.objs
 create mode 100644 hw/misc/macio/meson.build
 create mode 100644 hw/misc/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index d0d7816118..ac8278edf7 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -17,7 +17,6 @@ devices-dirs-y += intc/
 devices-dirs-$(CONFIG_IPACK) += ipack/
 devices-dirs-$(CONFIG_IPMI) += ipmi/
 devices-dirs-y += isa/
-devices-dirs-y += misc/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 1f7b2c4fb9..6ca82b0375 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,5 +1,6 @@
 subdir('core')
 subdir('mem')
+subdir('misc')
 subdir('net')
 subdir('nubus')
 subdir('nvram')
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
deleted file mode 100644
index 6be3d255ab..0000000000
--- a/hw/misc/Makefile.objs
+++ /dev/null
@@ -1,95 +0,0 @@
-common-obj-$(CONFIG_APPLESMC) += applesmc.o
-common-obj-$(CONFIG_MAX111X) += max111x.o
-common-obj-$(CONFIG_TMP105) += tmp105.o
-common-obj-$(CONFIG_TMP421) += tmp421.o
-common-obj-$(CONFIG_ISA_DEBUG) += debugexit.o
-common-obj-$(CONFIG_SGA) += sga.o
-common-obj-$(CONFIG_ISA_TESTDEV) += pc-testdev.o
-common-obj-$(CONFIG_PCI_TESTDEV) += pci-testdev.o
-common-obj-$(CONFIG_EDU) += edu.o
-common-obj-$(CONFIG_PCA9552) += pca9552.o
-
-common-obj-$(CONFIG_UNIMP) += unimp.o
-common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
-common-obj-$(CONFIG_FW_CFG_DMA) += vmcoreinfo.o
-
-# ARM devices
-common-obj-$(CONFIG_PL310) += arm_l2x0.o
-common-obj-$(CONFIG_INTEGRATOR_DEBUG) += arm_integrator_debug.o
-common-obj-$(CONFIG_A9SCU) += a9scu.o
-common-obj-$(CONFIG_ARM11SCU) += arm11scu.o
-
-# Mac devices
-common-obj-$(CONFIG_MOS6522) += mos6522.o
-
-# PKUnity SoC devices
-common-obj-$(CONFIG_PUV3) += puv3_pm.o
-
-common-obj-$(CONFIG_MACIO) += macio/
-
-common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
-
-common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-ccu.o
-obj-$(CONFIG_ALLWINNER_H3) += allwinner-cpucfg.o
-common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-dramc.o
-common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-sysctrl.o
-common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-sid.o
-common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
-common-obj-$(CONFIG_NSERIES) += cbus.o
-common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
-common-obj-$(CONFIG_EXYNOS4) += exynos4210_pmu.o exynos4210_clk.o exynos4210_rng.o
-common-obj-$(CONFIG_IMX) += imx_ccm.o
-common-obj-$(CONFIG_IMX) += imx31_ccm.o
-common-obj-$(CONFIG_IMX) += imx25_ccm.o
-common-obj-$(CONFIG_IMX) += imx6_ccm.o
-common-obj-$(CONFIG_IMX) += imx6ul_ccm.o
-obj-$(CONFIG_IMX) += imx6_src.o
-common-obj-$(CONFIG_IMX) += imx7_ccm.o
-common-obj-$(CONFIG_IMX) += imx7_snvs.o
-common-obj-$(CONFIG_IMX) += imx7_gpr.o
-common-obj-$(CONFIG_IMX) += imx_rngc.o
-common-obj-$(CONFIG_MILKYMIST) += milkymist-hpdmc.o
-common-obj-$(CONFIG_MILKYMIST) += milkymist-pfpu.o
-common-obj-$(CONFIG_MAINSTONE) += mst_fpga.o
-common-obj-$(CONFIG_OMAP) += omap_clk.o
-common-obj-$(CONFIG_OMAP) += omap_gpmc.o
-common-obj-$(CONFIG_OMAP) += omap_l4.o
-common-obj-$(CONFIG_OMAP) += omap_sdrc.o
-common-obj-$(CONFIG_OMAP) += omap_tap.o
-common-obj-$(CONFIG_RASPI) += bcm2835_mbox.o
-common-obj-$(CONFIG_RASPI) += bcm2835_mphi.o
-common-obj-$(CONFIG_RASPI) += bcm2835_property.o
-common-obj-$(CONFIG_RASPI) += bcm2835_rng.o
-common-obj-$(CONFIG_RASPI) += bcm2835_thermal.o
-common-obj-$(CONFIG_SLAVIO) += slavio_misc.o
-common-obj-$(CONFIG_ZYNQ) += zynq_slcr.o
-common-obj-$(CONFIG_ZYNQ) += zynq-xadc.o
-common-obj-$(CONFIG_STM32F2XX_SYSCFG) += stm32f2xx_syscfg.o
-common-obj-$(CONFIG_STM32F4XX_SYSCFG) += stm32f4xx_syscfg.o
-common-obj-$(CONFIG_STM32F4XX_EXTI) += stm32f4xx_exti.o
-obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
-obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
-obj-$(CONFIG_MIPS_ITU) += mips_itu.o
-common-obj-$(CONFIG_MPS2_FPGAIO) += mps2-fpgaio.o
-common-obj-$(CONFIG_MPS2_SCC) += mps2-scc.o
-
-common-obj-$(CONFIG_TZ_MPC) += tz-mpc.o
-common-obj-$(CONFIG_TZ_MSC) += tz-msc.o
-common-obj-$(CONFIG_TZ_PPC) += tz-ppc.o
-common-obj-$(CONFIG_IOTKIT_SECCTL) += iotkit-secctl.o
-obj-$(CONFIG_IOTKIT_SYSCTL) += iotkit-sysctl.o
-common-obj-$(CONFIG_IOTKIT_SYSINFO) += iotkit-sysinfo.o
-common-obj-$(CONFIG_ARMSSE_CPUID) += armsse-cpuid.o
-common-obj-$(CONFIG_ARMSSE_MHU) += armsse-mhu.o
-
-common-obj-$(CONFIG_PVPANIC) += pvpanic.o
-common-obj-$(CONFIG_AUX) += auxbus.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_xdma.o
-common-obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
-common-obj-$(CONFIG_MSF2) += msf2-sysreg.o
-common-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
-obj-$(CONFIG_MAC_VIA) += mac_via.o
-
-common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
-
-obj-$(CONFIG_AVR_POWER) += avr_power.o
diff --git a/hw/misc/macio/Makefile.objs b/hw/misc/macio/Makefile.objs
deleted file mode 100644
index 07fdb320d4..0000000000
--- a/hw/misc/macio/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-common-obj-y += macio.o
-common-obj-$(CONFIG_CUDA) += cuda.o
-common-obj-$(CONFIG_MAC_PMU) += pmu.o
-common-obj-$(CONFIG_MAC_DBDMA) += mac_dbdma.o
-common-obj-$(CONFIG_MACIO_GPIO) += gpio.o
diff --git a/hw/misc/macio/meson.build b/hw/misc/macio/meson.build
new file mode 100644
index 0000000000..17282da20a
--- /dev/null
+++ b/hw/misc/macio/meson.build
@@ -0,0 +1,8 @@
+macio_ss = ss.source_set()
+macio_ss.add(files('macio.c'))
+macio_ss.add(when: 'CONFIG_CUDA', if_true: files('cuda.c'))
+macio_ss.add(when: 'CONFIG_MACIO_GPIO', if_true: files('gpio.c'))
+macio_ss.add(when: 'CONFIG_MAC_DBDMA', if_true: files('mac_dbdma.c'))
+macio_ss.add(when: 'CONFIG_MAC_PMU', if_true: files('pmu.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_MACIO', if_true: macio_ss)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
new file mode 100644
index 0000000000..84fed0494d
--- /dev/null
+++ b/hw/misc/meson.build
@@ -0,0 +1,99 @@
+softmmu_ss.add(when: 'CONFIG_APPLESMC', if_true: files('applesmc.c'))
+softmmu_ss.add(when: 'CONFIG_EDU', if_true: files('edu.c'))
+softmmu_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
+softmmu_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
+softmmu_ss.add(when: 'CONFIG_MAX111X', if_true: files('max111x.c'))
+softmmu_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
+softmmu_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
+softmmu_ss.add(when: 'CONFIG_SGA', if_true: files('sga.c'))
+softmmu_ss.add(when: 'CONFIG_TMP105', if_true: files('tmp105.c'))
+softmmu_ss.add(when: 'CONFIG_TMP421', if_true: files('tmp421.c'))
+softmmu_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
+softmmu_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
+
+# ARM devices
+softmmu_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
+softmmu_ss.add(when: 'CONFIG_INTEGRATOR_DEBUG', if_true: files('arm_integrator_debug.c'))
+softmmu_ss.add(when: 'CONFIG_A9SCU', if_true: files('a9scu.c'))
+softmmu_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
+
+# Mac devices
+softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
+
+# PKUnity SoC devices
+softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_pm.c'))
+
+subdir('macio')
+
+softmmu_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem.c'))
+
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-ccu.c'))
+specific_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-dramc.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-sysctrl.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sid.c'))
+softmmu_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
+softmmu_ss.add(when: 'CONFIG_NSERIES', if_true: files('cbus.c'))
+softmmu_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
+softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files(
+  'imx25_ccm.c',
+  'imx31_ccm.c',
+  'imx6_ccm.c',
+  'imx6ul_ccm.c',
+  'imx7_ccm.c',
+  'imx7_gpr.c',
+  'imx7_snvs.c',
+  'imx_ccm.c',
+  'imx_rngc.c',
+))
+softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-hpdmc.c', 'milkymist-pfpu.c'))
+softmmu_ss.add(when: 'CONFIG_MAINSTONE', if_true: files('mst_fpga.c'))
+softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files(
+  'omap_clk.c',
+  'omap_gpmc.c',
+  'omap_l4.c',
+  'omap_sdrc.c',
+  'omap_tap.c',
+))
+softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files(
+  'bcm2835_mbox.c',
+  'bcm2835_mphi.c',
+  'bcm2835_property.c',
+  'bcm2835_rng.c',
+  'bcm2835_thermal.c',
+))
+softmmu_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
+softmmu_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c', 'zynq-xadc.c'))
+softmmu_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
+softmmu_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
+softmmu_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_exti.c'))
+softmmu_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'))
+softmmu_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
+
+softmmu_ss.add(when: 'CONFIG_TZ_MPC', if_true: files('tz-mpc.c'))
+softmmu_ss.add(when: 'CONFIG_TZ_MSC', if_true: files('tz-msc.c'))
+softmmu_ss.add(when: 'CONFIG_TZ_PPC', if_true: files('tz-ppc.c'))
+softmmu_ss.add(when: 'CONFIG_IOTKIT_SECCTL', if_true: files('iotkit-secctl.c'))
+softmmu_ss.add(when: 'CONFIG_IOTKIT_SYSINFO', if_true: files('iotkit-sysinfo.c'))
+softmmu_ss.add(when: 'CONFIG_ARMSSE_CPUID', if_true: files('armsse-cpuid.c'))
+softmmu_ss.add(when: 'CONFIG_ARMSSE_MHU', if_true: files('armsse-mhu.c'))
+
+softmmu_ss.add(when: 'CONFIG_PVPANIC', if_true: files('pvpanic.c'))
+softmmu_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
+softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_scu.c', 'aspeed_sdmc.c', 'aspeed_xdma.c'))
+softmmu_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-sysreg.c'))
+softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_rng.c'))
+
+softmmu_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_ahb_apb_pnp.c'))
+
+specific_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
+
+specific_ss.add(when: 'CONFIG_IMX', if_true: files('imx6_src.c'))
+specific_ss.add(when: 'CONFIG_IOTKIT_SYSCTL', if_true: files('iotkit-sysctl.c'))
+
+specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
+
+specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
+specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
-- 
2.26.2



