Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15111C00454
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A0821655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqf50fW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A0821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOtQ-0008QL-DV
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz6-0004gH-Uu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNz5-00089D-4p
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:24 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:33956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNz4-000886-TR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:23 -0500
Received: by mail-wm1-x333.google.com with SMTP id f4so3557821wmj.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lvgh+zBmcPIkOu0PE+ZarIMV7ERHiR4np+NUTMKTHqo=;
 b=Mqf50fW4OxW24TolMZ37YcIheXsrd9uEMXhBiiUXCHLGIZ1uFtIYC2DYIEFMoSMcoE
 jHT4yqUYvr0/3D5JZuW3SyYlLd+1V5gRcy5gBy658Yht/koPRpLuvbdqbBzL6SzMJdik
 u5ab3MJkyNEp8lFB3nCqripIHenTyMusiSvXeL9Vsbjz3xDpasQNNfiQl1f5crH80w/a
 HgI+EbBEQiDs4gjgUJFXHaCLW0BbChx5OZvlJR4ayqUOxtyEC+yaa3ABC0VXZgzo58Wi
 6k1ZKKEE3skxDNyKy2L6yoC7sgMnJFyxQcllhHBz/aFTxWAez2H35yOSQwntAGuX55HV
 fDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lvgh+zBmcPIkOu0PE+ZarIMV7ERHiR4np+NUTMKTHqo=;
 b=lF1wApWJRUSC1kvzY25ombR+XfEcdPY/VHHE5EioUQz2fv/IAVdIhUV6/Z53k7STM7
 Gpgzrzz84EuuNkGQ1lspnYuoG7V1JRShj6zRQMz0o3yopTX7Fnf2lsjBXbraJ47GO6Y5
 ZVr28l6OAO+4FJshn/ysBhnQKgK9CoeltVZSQrlE/tYmgFzg/541kMP8qgECA7dNH4eR
 Lyinhc5hfpZIFZx/k161tLGYPYYur0myg6Bl7jsAFtEYNSiJZOB6/bjviULUH/IVP+5n
 mZJmT+cRvnP8QwOQMuC2eQxI4BJmKd++RcSrxO1LSvSwYAtQ2CcPcAGuB9YDaCL/RDtS
 rgbg==
X-Gm-Message-State: APjAAAXikLrAXsyzpN3/m/nIacgbtIviXHpW2Gq3s88ZI4MgfaY0Nkmn
 DD3wGxBQcJvnvQYnujvbtWdQOPUP
X-Google-Smtp-Source: APXvYqxihiIlbVuHBJGV4iejN9DA35PUkMq4VrdhXvWmeHN85MNYKQrEAWS3N6wH3K/P8HX5GDMGHg==
X-Received: by 2002:a7b:c8c7:: with SMTP id f7mr6453330wml.91.1576155261646;
 Thu, 12 Dec 2019 04:54:21 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 084/132] meson: convert hw/misc
Date: Thu, 12 Dec 2019 13:52:08 +0100
Message-Id: <1576155176-2464-85-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs            |  1 -
 hw/meson.build              |  1 +
 hw/misc/Makefile.objs       | 82 ---------------------------------------------
 hw/misc/macio/Makefile.objs |  5 ---
 hw/misc/macio/meson.build   |  8 +++++
 hw/misc/meson.build         | 79 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 88 insertions(+), 88 deletions(-)
 delete mode 100644 hw/misc/Makefile.objs
 delete mode 100644 hw/misc/macio/Makefile.objs
 create mode 100644 hw/misc/macio/meson.build
 create mode 100644 hw/misc/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index d9479e3..e630c54 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -18,7 +18,6 @@ devices-dirs-y += intc/
 devices-dirs-$(CONFIG_IPACK) += ipack/
 devices-dirs-$(CONFIG_IPMI) += ipmi/
 devices-dirs-y += isa/
-devices-dirs-y += misc/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 3b20fea..c83f37c 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,5 +1,6 @@
 subdir('core')
 subdir('mem')
+subdir('misc')
 subdir('net')
 subdir('nvram')
 subdir('pci')
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
deleted file mode 100644
index e4aad70..0000000
--- a/hw/misc/Makefile.objs
+++ /dev/null
@@ -1,82 +0,0 @@
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
-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
-
-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
-obj-$(CONFIG_NSERIES) += cbus.o
-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_pmu.o exynos4210_clk.o exynos4210_rng.o
-obj-$(CONFIG_IMX) += imx_ccm.o
-obj-$(CONFIG_IMX) += imx31_ccm.o
-obj-$(CONFIG_IMX) += imx25_ccm.o
-obj-$(CONFIG_IMX) += imx6_ccm.o
-obj-$(CONFIG_IMX) += imx6ul_ccm.o
-obj-$(CONFIG_IMX) += imx6_src.o
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
-obj-$(CONFIG_MIPS_CPS) += mips_cmgcr.o
-obj-$(CONFIG_MIPS_CPS) += mips_cpc.o
-obj-$(CONFIG_MIPS_ITU) += mips_itu.o
-obj-$(CONFIG_MPS2_FPGAIO) += mps2-fpgaio.o
-obj-$(CONFIG_MPS2_SCC) += mps2-scc.o
-
-obj-$(CONFIG_TZ_MPC) += tz-mpc.o
-obj-$(CONFIG_TZ_MSC) += tz-msc.o
-obj-$(CONFIG_TZ_PPC) += tz-ppc.o
-obj-$(CONFIG_IOTKIT_SECCTL) += iotkit-secctl.o
-obj-$(CONFIG_IOTKIT_SYSCTL) += iotkit-sysctl.o
-obj-$(CONFIG_IOTKIT_SYSINFO) += iotkit-sysinfo.o
-obj-$(CONFIG_ARMSSE_CPUID) += armsse-cpuid.o
-obj-$(CONFIG_ARMSSE_MHU) += armsse-mhu.o
-
-obj-$(CONFIG_PVPANIC) += pvpanic.o
-obj-$(CONFIG_AUX) += auxbus.o
-obj-$(CONFIG_ASPEED_SOC) += aspeed_xdma.o
-obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
-obj-$(CONFIG_MSF2) += msf2-sysreg.o
-obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
-
-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
diff --git a/hw/misc/macio/Makefile.objs b/hw/misc/macio/Makefile.objs
deleted file mode 100644
index 07fdb32..0000000
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
index 0000000..17282da
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
index 0000000..8a971b4
--- /dev/null
+++ b/hw/misc/meson.build
@@ -0,0 +1,79 @@
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
+specific_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem.c'))
+
+specific_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
+specific_ss.add(when: 'CONFIG_NSERIES', if_true: files('cbus.c'))
+specific_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
+specific_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
+specific_ss.add(when: 'CONFIG_IMX', if_true: files(
+  'imx25_ccm.c',
+  'imx2_wdt.c',
+  'imx31_ccm.c',
+  'imx6_ccm.c',
+  'imx6_src.c',
+  'imx6ul_ccm.c',
+  'imx7_ccm.c',
+  'imx7_gpr.c',
+  'imx7_snvs.c',
+  'imx_ccm.c',
+))
+specific_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-hpdmc.c', 'milkymist-pfpu.c'))
+specific_ss.add(when: 'CONFIG_MAINSTONE', if_true: files('mst_fpga.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files(
+  'omap_clk.c',
+  'omap_gpmc.c',
+  'omap_l4.c',
+  'omap_sdrc.c',
+  'omap_tap.c',
+))
+specific_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_mbox.c', 'bcm2835_property.c', 'bcm2835_rng.c'))
+specific_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
+specific_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c', 'zynq-xadc.c'))
+specific_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
+specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
+specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
+specific_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'))
+specific_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
+
+specific_ss.add(when: 'CONFIG_TZ_MPC', if_true: files('tz-mpc.c'))
+specific_ss.add(when: 'CONFIG_TZ_MSC', if_true: files('tz-msc.c'))
+specific_ss.add(when: 'CONFIG_TZ_PPC', if_true: files('tz-ppc.c'))
+specific_ss.add(when: 'CONFIG_IOTKIT_SECCTL', if_true: files('iotkit-secctl.c'))
+specific_ss.add(when: 'CONFIG_IOTKIT_SYSCTL', if_true: files('iotkit-sysctl.c'))
+specific_ss.add(when: 'CONFIG_IOTKIT_SYSINFO', if_true: files('iotkit-sysinfo.c'))
+specific_ss.add(when: 'CONFIG_ARMSSE_CPUID', if_true: files('armsse-cpuid.c'))
+specific_ss.add(when: 'CONFIG_ARMSSE_MHU', if_true: files('armsse-mhu.c'))
+
+specific_ss.add(when: 'CONFIG_PVPANIC', if_true: files('pvpanic.c'))
+specific_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
+specific_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_scu.c', 'aspeed_sdmc.c', 'aspeed_xdma.c'))
+specific_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-sysreg.c'))
+specific_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_rng.c'))
+
+specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_ahb_apb_pnp.c'))
-- 
1.8.3.1



