Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E52C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AB4206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWrIIqas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AB4206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvCj-0003GI-FE
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurI-00087g-EF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurD-0008Qt-75
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57966
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurC-0008Lr-Uj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZRYcmcm2zMP3xjEgp8csWkDkQVunkELrRkYZRsQpo0=;
 b=SWrIIqasGBCK8GeNr5nng4L5OI0LNv6Fin9ByYX7tK6XqNEeFqbSz1icxH13iJMSzoR1Jd
 n9kAEQMdbb9MohmPrztKmJ5w49bLIGPk363lv3PCKf4NexHkQNjJbRb98j7l4iMqVCqGFY
 VGCsUGKFGNmKl+vZcT1U+sbgVgHEGpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-lejpbxePO86JW4yWt0MzaQ-1; Thu, 19 Dec 2019 07:24:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99E0B107ACCC
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:39 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8447960C18;
 Thu, 19 Dec 2019 12:24:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 105/132] meson: convert hw/arch*
Date: Thu, 19 Dec 2019 13:23:25 +0100
Message-Id: <1576758232-12439-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: lejpbxePO86JW4yWt0MzaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile.target             |  7 ------
 hw/alpha/Makefile.objs      |  1 -
 hw/alpha/meson.build        |  8 +++++++
 hw/arm/Makefile.objs        | 53 -----------------------------------------=
-
 hw/arm/meson.build          | 56 +++++++++++++++++++++++++++++++++++++++++=
++++
 hw/cris/Makefile.objs       |  2 --
 hw/cris/meson.build         |  5 ++++
 hw/hppa/Makefile.objs       |  1 -
 hw/hppa/meson.build         |  4 ++++
 hw/i386/Makefile.objs       | 15 ------------
 hw/i386/kvm/Makefile.objs   |  1 -
 hw/i386/kvm/meson.build     |  7 ++++++
 hw/i386/meson.build         | 22 ++++++++++++++++++
 hw/i386/xen/Makefile.objs   |  1 -
 hw/i386/xen/meson.build     |  7 ++++++
 hw/lm32/Makefile.objs       |  3 ---
 hw/lm32/meson.build         |  6 +++++
 hw/m68k/Makefile.objs       |  2 --
 hw/m68k/meson.build         |  5 ++++
 hw/meson.build              | 23 +++++++++++++++++++
 hw/microblaze/Makefile.objs |  4 ----
 hw/microblaze/meson.build   |  7 ++++++
 hw/mips/Makefile.objs       |  8 -------
 hw/mips/meson.build         | 11 +++++++++
 hw/moxie/Makefile.objs      |  2 --
 hw/moxie/meson.build        |  4 ++++
 hw/nios2/Makefile.objs      |  3 ---
 hw/nios2/meson.build        |  6 +++++
 hw/openrisc/Makefile.objs   |  2 --
 hw/openrisc/meson.build     |  5 ++++
 hw/ppc/Makefile.objs        | 33 --------------------------
 hw/ppc/meson.build          | 39 +++++++++++++++++++++++++++++++
 hw/riscv/Makefile.objs      | 13 -----------
 hw/riscv/meson.build        | 16 +++++++++++++
 hw/s390x/Makefile.objs      | 36 -----------------------------
 hw/s390x/meson.build        | 45 ++++++++++++++++++++++++++++++++++++
 hw/sh4/Makefile.objs        |  4 ----
 hw/sh4/meson.build          | 10 ++++++++
 hw/sparc/Makefile.objs      |  3 ---
 hw/sparc/meson.build        |  6 +++++
 hw/sparc64/Makefile.objs    |  4 ----
 hw/sparc64/meson.build      |  6 +++++
 hw/tricore/Makefile.objs    |  1 -
 hw/tricore/meson.build      |  4 ++++
 hw/unicore32/Makefile.objs  |  4 ----
 hw/unicore32/meson.build    |  5 ++++
 hw/xenpv/Makefile.objs      |  2 --
 hw/xenpv/meson.build        |  1 +
 hw/xtensa/Makefile.objs     |  5 ----
 hw/xtensa/meson.build       | 10 ++++++++
 50 files changed, 318 insertions(+), 210 deletions(-)
 delete mode 100644 hw/alpha/Makefile.objs
 create mode 100644 hw/alpha/meson.build
 delete mode 100644 hw/arm/Makefile.objs
 create mode 100644 hw/arm/meson.build
 delete mode 100644 hw/cris/Makefile.objs
 create mode 100644 hw/cris/meson.build
 delete mode 100644 hw/hppa/Makefile.objs
 create mode 100644 hw/hppa/meson.build
 delete mode 100644 hw/i386/Makefile.objs
 delete mode 100644 hw/i386/kvm/Makefile.objs
 create mode 100644 hw/i386/kvm/meson.build
 create mode 100644 hw/i386/meson.build
 delete mode 100644 hw/i386/xen/Makefile.objs
 create mode 100644 hw/i386/xen/meson.build
 delete mode 100644 hw/lm32/Makefile.objs
 create mode 100644 hw/lm32/meson.build
 delete mode 100644 hw/m68k/Makefile.objs
 create mode 100644 hw/m68k/meson.build
 delete mode 100644 hw/microblaze/Makefile.objs
 create mode 100644 hw/microblaze/meson.build
 delete mode 100644 hw/mips/Makefile.objs
 create mode 100644 hw/mips/meson.build
 delete mode 100644 hw/moxie/Makefile.objs
 create mode 100644 hw/moxie/meson.build
 delete mode 100644 hw/nios2/Makefile.objs
 create mode 100644 hw/nios2/meson.build
 delete mode 100644 hw/openrisc/Makefile.objs
 create mode 100644 hw/openrisc/meson.build
 delete mode 100644 hw/ppc/Makefile.objs
 create mode 100644 hw/ppc/meson.build
 delete mode 100644 hw/riscv/Makefile.objs
 create mode 100644 hw/riscv/meson.build
 delete mode 100644 hw/s390x/Makefile.objs
 create mode 100644 hw/s390x/meson.build
 delete mode 100644 hw/sh4/Makefile.objs
 create mode 100644 hw/sh4/meson.build
 delete mode 100644 hw/sparc/Makefile.objs
 create mode 100644 hw/sparc/meson.build
 delete mode 100644 hw/sparc64/Makefile.objs
 create mode 100644 hw/sparc64/meson.build
 delete mode 100644 hw/tricore/Makefile.objs
 create mode 100644 hw/tricore/meson.build
 delete mode 100644 hw/unicore32/Makefile.objs
 create mode 100644 hw/unicore32/meson.build
 delete mode 100644 hw/xenpv/Makefile.objs
 create mode 100644 hw/xenpv/meson.build
 delete mode 100644 hw/xtensa/Makefile.objs
 create mode 100644 hw/xtensa/meson.build

diff --git a/Makefile.target b/Makefile.target
index eecb11e..a8e5902 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -169,13 +169,6 @@ LIBS :=3D $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 LIBS :=3D $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
 LIBS :=3D $(LIBS) $(VIRGL_LIBS)
=20
-# Hardware support
-ifeq ($(TARGET_NAME), sparc64)
-obj-y +=3D hw/sparc64/
-else
-obj-y +=3D hw/$(TARGET_BASE_ARCH)/
-endif
-
 generated-files-y +=3D hmp-commands.h hmp-commands-info.h
=20
 endif # CONFIG_SOFTMMU
diff --git a/hw/alpha/Makefile.objs b/hw/alpha/Makefile.objs
deleted file mode 100644
index 62fdf3e..0000000
--- a/hw/alpha/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_DP264) +=3D dp264.o pci.o typhoon.o
diff --git a/hw/alpha/meson.build b/hw/alpha/meson.build
new file mode 100644
index 0000000..81ca215
--- /dev/null
+++ b/hw/alpha/meson.build
@@ -0,0 +1,8 @@
+alpha_ss =3D ss.source_set()
+alpha_ss.add(when: 'CONFIG_DP264', if_true: files(
+  'dp264.c',
+  'pci.c',
+  'typhoon.c',
+))
+
+hw_arch +=3D {'alpha': alpha_ss}
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
deleted file mode 100644
index 43ce8d5..0000000
--- a/hw/arm/Makefile.objs
+++ /dev/null
@@ -1,53 +0,0 @@
-obj-y +=3D boot.o
-obj-$(CONFIG_PLATFORM_BUS) +=3D sysbus-fdt.o
-obj-$(CONFIG_ARM_VIRT) +=3D virt.o
-obj-$(CONFIG_ACPI) +=3D virt-acpi-build.o
-obj-$(CONFIG_DIGIC) +=3D digic_boards.o
-obj-$(CONFIG_EXYNOS4) +=3D exynos4_boards.o
-obj-$(CONFIG_EMCRAFT_SF2) +=3D msf2-som.o
-obj-$(CONFIG_HIGHBANK) +=3D highbank.o
-obj-$(CONFIG_INTEGRATOR) +=3D integratorcp.o
-obj-$(CONFIG_MAINSTONE) +=3D mainstone.o
-obj-$(CONFIG_MICROBIT) +=3D microbit.o
-obj-$(CONFIG_MUSICPAL) +=3D musicpal.o
-obj-$(CONFIG_NETDUINO2) +=3D netduino2.o
-obj-$(CONFIG_NSERIES) +=3D nseries.o
-obj-$(CONFIG_SX1) +=3D omap_sx1.o
-obj-$(CONFIG_CHEETAH) +=3D palm.o
-obj-$(CONFIG_GUMSTIX) +=3D gumstix.o
-obj-$(CONFIG_SPITZ) +=3D spitz.o
-obj-$(CONFIG_TOSA) +=3D tosa.o
-obj-$(CONFIG_Z2) +=3D z2.o
-obj-$(CONFIG_REALVIEW) +=3D realview.o
-obj-$(CONFIG_SBSA_REF) +=3D sbsa-ref.o
-obj-$(CONFIG_STELLARIS) +=3D stellaris.o
-obj-$(CONFIG_COLLIE) +=3D collie.o
-obj-$(CONFIG_VERSATILE) +=3D versatilepb.o
-obj-$(CONFIG_VEXPRESS) +=3D vexpress.o
-obj-$(CONFIG_ZYNQ) +=3D xilinx_zynq.o
-obj-$(CONFIG_SABRELITE) +=3D sabrelite.o
-
-obj-$(CONFIG_ARM_V7M) +=3D armv7m.o
-obj-$(CONFIG_EXYNOS4) +=3D exynos4210.o
-obj-$(CONFIG_PXA2XX) +=3D pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
-obj-$(CONFIG_DIGIC) +=3D digic.o
-obj-$(CONFIG_OMAP) +=3D omap1.o omap2.o
-obj-$(CONFIG_STRONGARM) +=3D strongarm.o
-obj-$(CONFIG_ALLWINNER_A10) +=3D allwinner-a10.o cubieboard.o
-obj-$(CONFIG_RASPI) +=3D bcm2835_peripherals.o bcm2836.o raspi.o
-obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
-obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu102.o
-obj-$(CONFIG_XLNX_VERSAL) +=3D xlnx-versal.o xlnx-versal-virt.o
-obj-$(CONFIG_FSL_IMX25) +=3D fsl-imx25.o imx25_pdk.o
-obj-$(CONFIG_FSL_IMX31) +=3D fsl-imx31.o kzm.o
-obj-$(CONFIG_FSL_IMX6) +=3D fsl-imx6.o
-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_soc.o aspeed.o
-obj-$(CONFIG_MPS2) +=3D mps2.o
-obj-$(CONFIG_MPS2) +=3D mps2-tz.o
-obj-$(CONFIG_MSF2) +=3D msf2-soc.o
-obj-$(CONFIG_MUSCA) +=3D musca.o
-obj-$(CONFIG_ARMSSE) +=3D armsse.o
-obj-$(CONFIG_FSL_IMX7) +=3D fsl-imx7.o mcimx7d-sabre.o
-obj-$(CONFIG_ARM_SMMUV3) +=3D smmu-common.o smmuv3.o
-obj-$(CONFIG_FSL_IMX6UL) +=3D fsl-imx6ul.o mcimx6ul-evk.o
-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_soc.o
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
new file mode 100644
index 0000000..9859331
--- /dev/null
+++ b/hw/arm/meson.build
@@ -0,0 +1,56 @@
+arm_ss =3D ss.source_set()
+arm_ss.add(files('boot.c'))
+arm_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
+arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
+arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
+arm_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
+arm_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
+arm_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
+arm_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
+arm_ss.add(when: 'CONFIG_MAINSTONE', if_true: files('mainstone.c'))
+arm_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
+arm_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
+arm_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
+arm_ss.add(when: 'CONFIG_NSERIES', if_true: files('nseries.c'))
+arm_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
+arm_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
+arm_ss.add(when: 'CONFIG_GUMSTIX', if_true: files('gumstix.c'))
+arm_ss.add(when: 'CONFIG_SPITZ', if_true: files('spitz.c'))
+arm_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
+arm_ss.add(when: 'CONFIG_Z2', if_true: files('z2.c'))
+arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
+arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
+arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
+arm_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
+arm_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
+arm_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
+arm_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
+arm_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
+
+arm_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m.c'))
+arm_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210.c'))
+arm_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx.c', 'pxa2xx_gpio.=
c', 'pxa2xx_pic.c'))
+arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic.c'))
+arm_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c', 'omap2.c'))
+arm_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
+arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c',=
 'cubieboard.c'))
+arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c', '=
bcm2836.c', 'raspi.c'))
+arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c')=
)
+arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c',=
 'xlnx-zcu102.c'))
+arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'xl=
nx-versal-virt.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_=
pdk.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'=
))
+arm_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
+arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_soc.c', 'aspe=
ed.c'))
+arm_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
+arm_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
+arm_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
+arm_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
+arm_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-=
sabre.c'))
+arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c', 'smm=
uv3.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcim=
x6ul-evk.c'))
+arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
+
+hw_arch +=3D {'arm': arm_ss}
diff --git a/hw/cris/Makefile.objs b/hw/cris/Makefile.objs
deleted file mode 100644
index a4a27b3..0000000
--- a/hw/cris/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y +=3D boot.o
-obj-$(CONFIG_AXIS) +=3D axis_dev88.o
diff --git a/hw/cris/meson.build b/hw/cris/meson.build
new file mode 100644
index 0000000..dc808a4
--- /dev/null
+++ b/hw/cris/meson.build
@@ -0,0 +1,5 @@
+cris_ss =3D ss.source_set()
+cris_ss.add(files('boot.c'))
+cris_ss.add(when: 'CONFIG_AXIS', if_true: files('axis_dev88.c'))
+
+hw_arch +=3D {'cris': cris_ss}
diff --git a/hw/hppa/Makefile.objs b/hw/hppa/Makefile.objs
deleted file mode 100644
index 67838f5..0000000
--- a/hw/hppa/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_DINO) +=3D pci.o machine.o dino.o
diff --git a/hw/hppa/meson.build b/hw/hppa/meson.build
new file mode 100644
index 0000000..392cf99
--- /dev/null
+++ b/hw/hppa/meson.build
@@ -0,0 +1,4 @@
+hppa_ss =3D ss.source_set()
+hppa_ss.add(when: 'CONFIG_DINO', if_true: files('pci.c', 'machine.c', 'din=
o.c'))
+
+hw_arch +=3D {'hppa': hppa_ss}
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
deleted file mode 100644
index 5d9c9ef..0000000
--- a/hw/i386/Makefile.objs
+++ /dev/null
@@ -1,15 +0,0 @@
-obj-$(CONFIG_KVM) +=3D kvm/
-obj-y +=3D multiboot.o
-obj-y +=3D pc.o
-obj-$(CONFIG_I440FX) +=3D pc_piix.o
-obj-$(CONFIG_Q35) +=3D pc_q35.o
-obj-y +=3D fw_cfg.o pc_sysfw.o
-obj-y +=3D x86-iommu.o
-obj-$(CONFIG_VTD) +=3D intel_iommu.o
-obj-$(CONFIG_AMD_IOMMU) +=3D amd_iommu.o
-obj-$(CONFIG_XEN) +=3D ../xenpv/ xen/
-obj-$(CONFIG_VMPORT) +=3D vmport.o
-obj-$(CONFIG_VMMOUSE) +=3D vmmouse.o
-
-obj-y +=3D kvmvapic.o
-obj-y +=3D acpi-build.o
diff --git a/hw/i386/kvm/Makefile.objs b/hw/i386/kvm/Makefile.objs
deleted file mode 100644
index 4224ed9..0000000
--- a/hw/i386/kvm/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-y +=3D clock.o apic.o i8259.o ioapic.o i8254.o
diff --git a/hw/i386/kvm/meson.build b/hw/i386/kvm/meson.build
new file mode 100644
index 0000000..731a357
--- /dev/null
+++ b/hw/i386/kvm/meson.build
@@ -0,0 +1,7 @@
+i386_ss.add(when: 'CONFIG_KVM', if_true: files(
+  'apic.c',
+  'clock.c',
+  'i8254.c',
+  'i8259.c',
+  'ioapic.c',
+))
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
new file mode 100644
index 0000000..e33cf58
--- /dev/null
+++ b/hw/i386/meson.build
@@ -0,0 +1,22 @@
+i386_ss =3D ss.source_set()
+i386_ss.add(files(
+  'acpi-build.c',
+  'fw_cfg.c',
+  'kvmvapic.c',
+  'multiboot.c',
+  'pc.c',
+  'pc_sysfw.c',
+  'x86-iommu.c',
+))
+
+i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'))
+i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
+i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
+i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
+i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
+i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
+
+subdir('kvm')
+subdir('xen')
+
+hw_arch +=3D {'i386': i386_ss}
diff --git a/hw/i386/xen/Makefile.objs b/hw/i386/xen/Makefile.objs
deleted file mode 100644
index be9d10c..0000000
--- a/hw/i386/xen/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-y +=3D xen_platform.o xen_apic.o xen_pvdevice.o xen-hvm.o xen-mapcache=
.o
diff --git a/hw/i386/xen/meson.build b/hw/i386/xen/meson.build
new file mode 100644
index 0000000..be84130
--- /dev/null
+++ b/hw/i386/xen/meson.build
@@ -0,0 +1,7 @@
+i386_ss.add(when: 'CONFIG_XEN', if_true: files(
+  'xen-hvm.c',
+  'xen-mapcache.c',
+  'xen_apic.c',
+  'xen_platform.c',
+  'xen_pvdevice.c',
+))
diff --git a/hw/lm32/Makefile.objs b/hw/lm32/Makefile.objs
deleted file mode 100644
index c394186..0000000
--- a/hw/lm32/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-# LM32 boards
-obj-$(CONFIG_LM32) +=3D lm32_boards.o
-obj-$(CONFIG_MILKYMIST) +=3D milkymist.o
diff --git a/hw/lm32/meson.build b/hw/lm32/meson.build
new file mode 100644
index 0000000..8caf0a7
--- /dev/null
+++ b/hw/lm32/meson.build
@@ -0,0 +1,6 @@
+lm32_ss =3D ss.source_set()
+# LM32 boards
+lm32_ss.add(when: 'CONFIG_LM32', if_true: files('lm32_boards.c'))
+lm32_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist.c'))
+
+hw_arch +=3D {'lm32': lm32_ss}
diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
deleted file mode 100644
index 482f847..0000000
--- a/hw/m68k/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-$(CONFIG_AN5206) +=3D an5206.o mcf5206.o
-obj-$(CONFIG_MCF5208) +=3D mcf5208.o mcf_intc.o
diff --git a/hw/m68k/meson.build b/hw/m68k/meson.build
new file mode 100644
index 0000000..fd8f744
--- /dev/null
+++ b/hw/m68k/meson.build
@@ -0,0 +1,5 @@
+m68k_ss =3D ss.source_set()
+m68k_ss.add(when: 'CONFIG_AN5206', if_true: files('an5206.c', 'mcf5206.c')=
)
+m68k_ss.add(when: 'CONFIG_MCF5208', if_true: files('mcf5208.c', 'mcf_intc.=
c'))
+
+hw_arch +=3D {'m68k': m68k_ss}
diff --git a/hw/meson.build b/hw/meson.build
index a79400b..7d8ff92 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -39,3 +39,26 @@ subdir('vfio')
 subdir('virtio')
 subdir('watchdog')
 subdir('xen')
+
+subdir('alpha')
+subdir('arm')
+subdir('cris')
+subdir('hppa')
+subdir('i386')
+subdir('lm32')
+subdir('m68k')
+subdir('microblaze')
+subdir('mips')
+subdir('moxie')
+subdir('nios2')
+subdir('openrisc')
+subdir('ppc')
+subdir('riscv')
+subdir('s390x')
+subdir('sh4')
+subdir('sparc')
+subdir('sparc64')
+subdir('tricore')
+subdir('unicore32')
+subdir('xenpv')
+subdir('xtensa')
diff --git a/hw/microblaze/Makefile.objs b/hw/microblaze/Makefile.objs
deleted file mode 100644
index 8595a62..0000000
--- a/hw/microblaze/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-$(CONFIG_PETALOGIX_S3ADSP1800) +=3D petalogix_s3adsp1800_mmu.o
-obj-$(CONFIG_PETALOGIX_ML605) +=3D petalogix_ml605_mmu.o
-obj-$(CONFIG_XLNX_ZYNQMP_PMU) +=3D xlnx-zynqmp-pmu.o
-obj-y +=3D boot.o
diff --git a/hw/microblaze/meson.build b/hw/microblaze/meson.build
new file mode 100644
index 0000000..bb9e4eb
--- /dev/null
+++ b/hw/microblaze/meson.build
@@ -0,0 +1,7 @@
+microblaze_ss =3D ss.source_set()
+microblaze_ss.add(files('boot.c'))
+microblaze_ss.add(when: 'CONFIG_PETALOGIX_S3ADSP1800', if_true: files('pet=
alogix_s3adsp1800_mmu.c'))
+microblaze_ss.add(when: 'CONFIG_PETALOGIX_ML605', if_true: files('petalogi=
x_ml605_mmu.c'))
+microblaze_ss.add(when: 'CONFIG_XLNX_ZYNQMP_PMU', if_true: files('xlnx-zyn=
qmp-pmu.c'))
+
+hw_arch +=3D {'microblaze': microblaze_ss}
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
deleted file mode 100644
index 525809a..0000000
--- a/hw/mips/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-obj-y +=3D addr.o mips_int.o
-obj-$(CONFIG_R4K) +=3D mips_r4k.o
-obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o mips_malta.o
-obj-$(CONFIG_MIPSSIM) +=3D mips_mipssim.o
-obj-$(CONFIG_JAZZ) +=3D mips_jazz.o
-obj-$(CONFIG_FULONG) +=3D mips_fulong2e.o
-obj-$(CONFIG_MIPS_CPS) +=3D cps.o
-obj-$(CONFIG_MIPS_BOSTON) +=3D boston.o
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
new file mode 100644
index 0000000..06adda2
--- /dev/null
+++ b/hw/mips/meson.build
@@ -0,0 +1,11 @@
+mips_ss =3D ss.source_set()
+mips_ss.add(files('addr.c', 'mips_int.c'))
+mips_ss.add(when: 'CONFIG_FULONG', if_true: files('mips_fulong2e.c'))
+mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('mips_jazz.c'))
+mips_ss.add(when: 'CONFIG_MALTA', if_true: files('gt64xxx_pci.c', 'mips_ma=
lta.c'))
+mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mips_mipssim.c'))
+mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: files('boston.c'))
+mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
+mips_ss.add(when: 'CONFIG_R4K', if_true: files('mips_r4k.c'))
+
+hw_arch +=3D {'mips': mips_ss}
diff --git a/hw/moxie/Makefile.objs b/hw/moxie/Makefile.objs
deleted file mode 100644
index ddbf300..0000000
--- a/hw/moxie/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-# moxie boards
-obj-$(CONFIG_MOXIESIM) +=3D moxiesim.o
diff --git a/hw/moxie/meson.build b/hw/moxie/meson.build
new file mode 100644
index 0000000..05a7c2e
--- /dev/null
+++ b/hw/moxie/meson.build
@@ -0,0 +1,4 @@
+moxie_ss =3D ss.source_set()
+moxie_ss.add(when: 'CONFIG_MOXIESIM', if_true: files('moxiesim.c'))
+
+hw_arch +=3D {'moxie': moxie_ss}
diff --git a/hw/nios2/Makefile.objs b/hw/nios2/Makefile.objs
deleted file mode 100644
index 3e01798..0000000
--- a/hw/nios2/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y =3D boot.o cpu_pic.o
-obj-$(CONFIG_NIOS2_10M50) +=3D 10m50_devboard.o
-obj-$(CONFIG_NIOS2_GENERIC_NOMMU) +=3D generic_nommu.o
diff --git a/hw/nios2/meson.build b/hw/nios2/meson.build
new file mode 100644
index 0000000..dd66ebb
--- /dev/null
+++ b/hw/nios2/meson.build
@@ -0,0 +1,6 @@
+nios2_ss =3D ss.source_set()
+nios2_ss.add(files('boot.c', 'cpu_pic.c'))
+nios2_ss.add(when: 'CONFIG_NIOS2_10M50', if_true: files('10m50_devboard.c'=
))
+nios2_ss.add(when: 'CONFIG_NIOS2_GENERIC_NOMMU', if_true: files('generic_n=
ommu.c'))
+
+hw_arch +=3D {'nios2': nios2_ss}
diff --git a/hw/openrisc/Makefile.objs b/hw/openrisc/Makefile.objs
deleted file mode 100644
index aa04de7..0000000
--- a/hw/openrisc/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y =3D pic_cpu.o cputimer.o
-obj-$(CONFIG_OR1K_SIM) +=3D openrisc_sim.o
diff --git a/hw/openrisc/meson.build b/hw/openrisc/meson.build
new file mode 100644
index 0000000..57c4255
--- /dev/null
+++ b/hw/openrisc/meson.build
@@ -0,0 +1,5 @@
+openrisc_ss =3D ss.source_set()
+openrisc_ss.add(files('pic_cpu.c', 'cputimer.c'))
+openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('openrisc_sim.c'))
+
+hw_arch +=3D {'openrisc': openrisc_ss}
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
deleted file mode 100644
index 2c4e1c8..0000000
--- a/hw/ppc/Makefile.objs
+++ /dev/null
@@ -1,33 +0,0 @@
-# shared objects
-obj-y +=3D ppc.o ppc_booke.o fdt.o fw_cfg.o
-# IBM pSeries (sPAPR)
-obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events.o
-obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
-obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
-obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
-obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
-obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
-# IBM PowerNV
-obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.=
o pnv_occ.o pnv_bmc.o
-ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
-obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
-endif
-obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
-# PowerPC 4xx boards
-obj-$(CONFIG_PPC405) +=3D ppc405_boards.o ppc405_uc.o
-obj-$(CONFIG_PPC440) +=3D ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
-obj-$(CONFIG_PPC4XX) +=3D ppc4xx_pci.o ppc4xx_devs.o
-obj-$(CONFIG_SAM460EX) +=3D sam460ex.o
-# PReP
-obj-$(CONFIG_PREP) +=3D prep.o
-obj-$(CONFIG_PREP) +=3D prep_systemio.o
-obj-${CONFIG_RS6000_MC} +=3D rs6000_mc.o
-# OldWorld PowerMac
-obj-$(CONFIG_MAC_OLDWORLD) +=3D mac_oldworld.o
-# NewWorld PowerMac
-obj-$(CONFIG_MAC_NEWWORLD) +=3D mac_newworld.o
-# e500
-obj-$(CONFIG_E500) +=3D e500.o mpc8544ds.o e500plat.o
-obj-$(CONFIG_E500) +=3D mpc8544_guts.o ppce500_spin.o
-# PowerPC 440 Xilinx ML507 reference board.
-obj-$(CONFIG_VIRTEX) +=3D virtex_ml507.o
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
new file mode 100644
index 0000000..6e2fdbb
--- /dev/null
+++ b/hw/ppc/meson.build
@@ -0,0 +1,39 @@
+ppc_ss =3D ss.source_set()
+ppc_ss.add(files(
+  'fdt.c',
+  'fw_cfg.c',
+  'ppc.c',
+  'ppc_booke.c',
+))
+
+# IBM pSeries (sPAPR)
+ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c', 'spapr_caps.c=
', 'spapr_vio.c', 'spapr_events.c'))
+ppc_ss.add(when: 'CONFIG_PSERIES', if_true: [files('spapr_hcall.c', 'spapr=
_iommu.c', 'spapr_rtas.c'), fdt])
+ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_pci.c', 'spapr_rt=
c.c', 'spapr_drc.c'))
+ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_cpu_core.c', 'spa=
pr_ovec.c', 'spapr_irq.c', 'spapr_tpm_proxy.c'))
+ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
+
+# IBM PowerNV
+ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files('pnv.c', 'pnv_xscom.c', =
'pnv_core.c', 'pnv_lpc.c', 'pnv_psi.c', 'pnv_occ.c', 'pnv_bmc.c'))
+ppc_ss.add(when: ['CONFIG_PCI', 'CONFIG_PSERIES', 'CONFIG_LINUX'], if_true=
: files('spapr_pci_vfio.c', 'spapr_pci_nvlink2.c'))
+ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_rtas_ddw.c'))
+# PowerPC 4xx boards
+ppc_ss.add(when: 'CONFIG_PPC405', if_true: files('ppc405_boards.c', 'ppc40=
5_uc.c'))
+ppc_ss.add(when: 'CONFIG_PPC440', if_true: files('ppc440_bamboo.c', 'ppc44=
0_pcix.c', 'ppc440_uc.c'))
+ppc_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_pci.c', 'ppc4xx_d=
evs.c'))
+ppc_ss.add(when: 'CONFIG_SAM460EX', if_true: files('sam460ex.c'))
+# PReP
+ppc_ss.add(when: 'CONFIG_PREP', if_true: files('prep.c'))
+ppc_ss.add(when: 'CONFIG_PREP', if_true: files('prep_systemio.c'))
+ppc_ss.add(when: 'CONFIG_RS6000_MC', if_true: files('rs6000_mc.c'))
+# OldWorld PowerMac
+ppc_ss.add(when: 'CONFIG_MAC_OLDWORLD', if_true: files('mac_oldworld.c'))
+# NewWorld PowerMac
+ppc_ss.add(when: 'CONFIG_MAC_NEWWORLD', if_true: files('mac_newworld.c'))
+# e500
+ppc_ss.add(when: 'CONFIG_E500', if_true: files('e500.c', 'mpc8544ds.c', 'e=
500plat.c'))
+ppc_ss.add(when: 'CONFIG_E500', if_true: files('mpc8544_guts.c', 'ppce500_=
spin.c'))
+# PowerPC 440 Xilinx ML507 reference board.
+ppc_ss.add(when: 'CONFIG_VIRTEX', if_true: files('virtex_ml507.c'))
+
+hw_arch +=3D {'ppc': ppc_ss}
diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
deleted file mode 100644
index eb9d4f9..0000000
--- a/hw/riscv/Makefile.objs
+++ /dev/null
@@ -1,13 +0,0 @@
-obj-y +=3D boot.o
-obj-$(CONFIG_SPIKE) +=3D riscv_htif.o
-obj-$(CONFIG_HART) +=3D riscv_hart.o
-obj-$(CONFIG_SIFIVE_E) +=3D sifive_e.o
-obj-$(CONFIG_SIFIVE) +=3D sifive_clint.o
-obj-$(CONFIG_SIFIVE) +=3D sifive_gpio.o
-obj-$(CONFIG_SIFIVE) +=3D sifive_prci.o
-obj-$(CONFIG_SIFIVE) +=3D sifive_plic.o
-obj-$(CONFIG_SIFIVE) +=3D sifive_test.o
-obj-$(CONFIG_SIFIVE_U) +=3D sifive_u.o
-obj-$(CONFIG_SIFIVE) +=3D sifive_uart.o
-obj-$(CONFIG_SPIKE) +=3D spike.o
-obj-$(CONFIG_RISCV_VIRT) +=3D virt.o
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
new file mode 100644
index 0000000..8a43eca
--- /dev/null
+++ b/hw/riscv/meson.build
@@ -0,0 +1,16 @@
+riscv_ss =3D ss.source_set()
+riscv_ss.add(files('boot.c'))
+riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_clint.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_gpio.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_plic.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_prci.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
+riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('riscv_htif.c'))
+riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
+
+hw_arch +=3D {'riscv': riscv_ss}
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
deleted file mode 100644
index e02ed80..0000000
--- a/hw/s390x/Makefile.objs
+++ /dev/null
@@ -1,36 +0,0 @@
-obj-y +=3D s390-virtio-hcall.o
-obj-y +=3D sclp.o
-obj-y +=3D event-facility.o
-obj-y +=3D sclpquiesce.o
-obj-y +=3D sclpcpu.o
-obj-y +=3D ipl.o
-obj-y +=3D css.o
-obj-$(CONFIG_S390_CCW_VIRTIO) +=3D s390-virtio-ccw.o
-obj-$(CONFIG_TERMINAL3270) +=3D 3270-ccw.o
-ifeq ($(CONFIG_VIRTIO_CCW),y)
-obj-y +=3D virtio-ccw.o
-obj-$(CONFIG_VIRTIO_SERIAL) +=3D virtio-ccw-serial.o
-obj-$(CONFIG_VIRTIO_BALLOON) +=3D virtio-ccw-balloon.o
-obj-$(CONFIG_VIRTIO_SCSI) +=3D virtio-ccw-scsi.o
-obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-ccw-rng.o
-obj-$(CONFIG_VIRTIO_CRYPTO) +=3D virtio-ccw-crypto.o
-obj-$(CONFIG_VIRTIO_GPU) +=3D virtio-ccw-gpu.o
-obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-ccw-input.o
-obj-$(CONFIG_VIRTIO_NET) +=3D virtio-ccw-net.o
-obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-ccw-blk.o
-obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) +=3D virtio-ccw-9p.o
-obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock-ccw.o
-endif
-obj-y +=3D css-bridge.o
-obj-y +=3D ccw-device.o
-obj-y +=3D s390-pci-bus.o s390-pci-inst.o
-obj-y +=3D s390-skeys.o
-obj-y +=3D s390-stattrib.o
-obj-y +=3D tod.o
-obj-y +=3D tod-qemu.o
-obj-$(CONFIG_KVM) +=3D tod-kvm.o
-obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
-obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o
-obj-y +=3D s390-ccw.o
-obj-y +=3D ap-device.o
-obj-y +=3D ap-bridge.o
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
new file mode 100644
index 0000000..f9a0bf8
--- /dev/null
+++ b/hw/s390x/meson.build
@@ -0,0 +1,45 @@
+s390x_ss =3D ss.source_set()
+s390x_ss.add(files(
+  'ap-bridge.c',
+  'ap-device.c',
+  'ccw-device.c',
+  'css-bridge.c',
+  'css.c',
+  'event-facility.c',
+  'ipl.c',
+  's390-ccw.c',
+  's390-pci-bus.c',
+  's390-pci-inst.c',
+  's390-skeys.c',
+  's390-stattrib.c',
+  's390-virtio-hcall.c',
+  'sclp.c',
+  'sclpcpu.c',
+  'sclpquiesce.c',
+  'tod-qemu.c',
+  'tod.c',
+))
+s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
+  'tod-kvm.c',
+  's390-skeys-kvm.c',
+  's390-stattrib-kvm.c',
+))
+s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-virtio-c=
cw.c'))
+s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
+
+virtio_ss =3D ss.source_set()
+virtio_ss.add(files('virtio-ccw.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-ccw-ba=
lloon.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-ccw-blk.c'=
))
+virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-ccw-cry=
pto.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_GPU', if_true: files('virtio-ccw-gpu.c'=
))
+virtio_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-ccw-inpu=
t.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-ccw-net.c'=
))
+virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-ccw-rng.c'=
))
+virtio_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio-ccw-scsi.=
c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-ccw-ser=
ial.c'))
+virtio_ss.add(when: ['CONFIG_VIRTIO_9P', 'CONFIG_VIRTFS'], if_true: files(=
'virtio-ccw-blk.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-ccw.=
c'))
+s390x_ss.add_all(when: 'CONFIG_VIRTIO_CCW', if_true: virtio_ss)
+
+hw_arch +=3D {'s390x': s390x_ss}
diff --git a/hw/sh4/Makefile.objs b/hw/sh4/Makefile.objs
deleted file mode 100644
index 2a707f9..0000000
--- a/hw/sh4/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-y +=3D sh7750.o sh7750_regnames.o
-obj-y +=3D sh_pci.o
-obj-$(CONFIG_R2D) +=3D  r2d.o
-obj-$(CONFIG_SHIX) +=3D shix.o
diff --git a/hw/sh4/meson.build b/hw/sh4/meson.build
new file mode 100644
index 0000000..303c0f4
--- /dev/null
+++ b/hw/sh4/meson.build
@@ -0,0 +1,10 @@
+sh4_ss =3D ss.source_set()
+sh4_ss.add(files(
+  'sh7750.c',
+  'sh7750_regnames.c',
+  'sh_pci.c'
+))
+sh4_ss.add(when: 'CONFIG_R2D', if_true: files('r2d.c'))
+sh4_ss.add(when: 'CONFIG_SHIX', if_true: files('shix.c'))
+
+hw_arch +=3D {'sh4': sh4_ss}
diff --git a/hw/sparc/Makefile.objs b/hw/sparc/Makefile.objs
deleted file mode 100644
index d57e33f..0000000
--- a/hw/sparc/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-$(CONFIG_SUN4M) +=3D sun4m_iommu.o
-obj-$(CONFIG_SUN4M) +=3D sun4m.o
-obj-$(CONFIG_LEON3) +=3D leon3.o
diff --git a/hw/sparc/meson.build b/hw/sparc/meson.build
new file mode 100644
index 0000000..19c442c
--- /dev/null
+++ b/hw/sparc/meson.build
@@ -0,0 +1,6 @@
+sparc_ss =3D ss.source_set()
+sparc_ss.add(when: 'CONFIG_LEON3', if_true: files('leon3.c'))
+sparc_ss.add(when: 'CONFIG_SUN4M', if_true: files('sun4m.c'))
+sparc_ss.add(when: 'CONFIG_SUN4M', if_true: files('sun4m_iommu.c'))
+
+hw_arch +=3D {'sparc': sparc_ss}
diff --git a/hw/sparc64/Makefile.objs b/hw/sparc64/Makefile.objs
deleted file mode 100644
index af0525c..0000000
--- a/hw/sparc64/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-y +=3D sparc64.o
-obj-$(CONFIG_SUN4U) +=3D sun4u_iommu.o
-obj-$(CONFIG_SUN4U) +=3D sun4u.o
-obj-$(CONFIG_NIAGARA) +=3D niagara.o
diff --git a/hw/sparc64/meson.build b/hw/sparc64/meson.build
new file mode 100644
index 0000000..58b5504
--- /dev/null
+++ b/hw/sparc64/meson.build
@@ -0,0 +1,6 @@
+sparc64_ss =3D ss.source_set()
+sparc64_ss.add(files('sparc64.c'))
+sparc64_ss.add(when: 'CONFIG_NIAGARA', if_true: files('niagara.c'))
+sparc64_ss.add(when: 'CONFIG_SUN4U', if_true: files('sun4u.c', 'sun4u_iomm=
u.c'))
+
+hw_arch +=3D {'sparc64': sparc64_ss}
diff --git a/hw/tricore/Makefile.objs b/hw/tricore/Makefile.objs
deleted file mode 100644
index 5501f6c..0000000
--- a/hw/tricore/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_TRICORE) +=3D tricore_testboard.o
diff --git a/hw/tricore/meson.build b/hw/tricore/meson.build
new file mode 100644
index 0000000..579aa13
--- /dev/null
+++ b/hw/tricore/meson.build
@@ -0,0 +1,4 @@
+tricore_ss =3D ss.source_set()
+tricore_ss.add(when: 'CONFIG_TRICORE', if_true: files('tricore_testboard.c=
'))
+
+hw_arch +=3D {'tricore': tricore_ss}
diff --git a/hw/unicore32/Makefile.objs b/hw/unicore32/Makefile.objs
deleted file mode 100644
index e0fd628..0000000
--- a/hw/unicore32/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-# For UniCore32 machines and boards
-
-# PKUnity-v3 SoC and board information
-obj-${CONFIG_PUV3} +=3D puv3.o
diff --git a/hw/unicore32/meson.build b/hw/unicore32/meson.build
new file mode 100644
index 0000000..fc26d6b
--- /dev/null
+++ b/hw/unicore32/meson.build
@@ -0,0 +1,5 @@
+unicore32_ss =3D ss.source_set()
+# PKUnity-v3 SoC and board information
+unicore32_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3.c'))
+
+hw_arch +=3D {'unicore32': unicore32_ss}
diff --git a/hw/xenpv/Makefile.objs b/hw/xenpv/Makefile.objs
deleted file mode 100644
index 8bfa458..0000000
--- a/hw/xenpv/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-# Xen PV machine support
-obj-$(CONFIG_XEN) +=3D xen_machine_pv.o
diff --git a/hw/xenpv/meson.build b/hw/xenpv/meson.build
new file mode 100644
index 0000000..d269a83
--- /dev/null
+++ b/hw/xenpv/meson.build
@@ -0,0 +1 @@
+i386_ss.add(when: 'CONFIG_XEN', if_true: files('xen_machine_pv.c'))
diff --git a/hw/xtensa/Makefile.objs b/hw/xtensa/Makefile.objs
deleted file mode 100644
index 0bbfccd..0000000
--- a/hw/xtensa/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-y +=3D mx_pic.o
-obj-y +=3D pic_cpu.o
-obj-y +=3D xtensa_memory.o
-obj-$(CONFIG_XTENSA_SIM) +=3D sim.o
-obj-$(CONFIG_XTENSA_XTFPGA) +=3D xtfpga.o
diff --git a/hw/xtensa/meson.build b/hw/xtensa/meson.build
new file mode 100644
index 0000000..b122f34
--- /dev/null
+++ b/hw/xtensa/meson.build
@@ -0,0 +1,10 @@
+xtensa_ss =3D ss.source_set()
+xtensa_ss.add(files(
+  'mx_pic.c',
+  'pic_cpu.c',
+  'xtensa_memory.c',
+))
+xtensa_ss.add(when: 'CONFIG_XTENSA_SIM', if_true: files('sim.c'))
+xtensa_ss.add(when: 'CONFIG_XTENSA_XTFPGA', if_true: files('xtfpga.c'))
+
+hw_arch +=3D {'xtensa': xtensa_ss}
--=20
1.8.3.1



