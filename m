Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65001C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3416C23A6C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcUhZmAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3416C23A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7h1F-00084z-Af
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKM-0002oj-WA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7gKJ-0006qA-86
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uaUF+HI5OBgPlVZE1fhg1N02BtoL1RcmK+wFLwcqqGk=;
 b=fcUhZmAyxYpOd6DcdqE1Z3f0SYh8Rk/SbZ4NaMh+WSq+ajjYiXEWFXY+Hk9CmGTLuanUk9
 l9tpnt+gv/mdUd3ANGV72oFBBKFqphboA+cdEZOgXod6Q5XytKa3al2qvgM1yNPaU62Tbs
 NtaeF/gaMPzCsuUnN43gGVkea3D76r4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-9aw427-bMhiwYLkk4Xg4hg-1; Mon, 17 Aug 2020 10:41:28 -0400
X-MC-Unique: 9aw427-bMhiwYLkk4Xg4hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D870B801AC3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:41:27 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A034756AB;
 Mon, 17 Aug 2020 14:41:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 111/150] meson: convert hw/intc
Date: Mon, 17 Aug 2020 16:40:14 +0200
Message-Id: <20200817144053.345107-16-pbonzini@redhat.com>
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:13:21
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
 hw/Makefile.objs      |  1 -
 hw/intc/Makefile.objs | 54 ------------------------------------------
 hw/intc/meson.build   | 55 +++++++++++++++++++++++++++++++++++++++++++
 hw/meson.build        |  1 +
 4 files changed, 56 insertions(+), 55 deletions(-)
 delete mode 100644 hw/intc/Makefile.objs
 create mode 100644 hw/intc/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 76d9305959..80b104168a 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -13,7 +13,6 @@ devices-dirs-$(CONFIG_HYPERV) += hyperv/
 devices-dirs-$(CONFIG_I2C) += i2c/
 devices-dirs-y += ide/
 devices-dirs-y += input/
-devices-dirs-y += intc/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
deleted file mode 100644
index 3ac2b40fbb..0000000000
--- a/hw/intc/Makefile.objs
+++ /dev/null
@@ -1,54 +0,0 @@
-common-obj-$(CONFIG_HEATHROW_PIC) += heathrow_pic.o
-common-obj-$(CONFIG_I8259) += i8259_common.o i8259.o
-common-obj-$(CONFIG_PL190) += pl190.o
-common-obj-$(CONFIG_PUV3) += puv3_intc.o
-common-obj-$(CONFIG_XILINX) += xilinx_intc.o
-common-obj-$(CONFIG_XLNX_ZYNQMP_PMU) += xlnx-pmu-iomod-intc.o
-common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-ipi.o
-common-obj-$(CONFIG_ETRAXFS) += etraxfs_pic.o
-common-obj-$(CONFIG_IMX) += imx_avic.o imx_gpcv2.o
-common-obj-$(CONFIG_LM32) += lm32_pic.o
-common-obj-$(CONFIG_REALVIEW) += realview_gic.o
-common-obj-$(CONFIG_SLAVIO) += slavio_intctl.o
-common-obj-$(CONFIG_IOAPIC) += ioapic_common.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gic_common.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gic.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv2m.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_common.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv3.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_dist.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_redist.o
-common-obj-$(CONFIG_ARM_GIC) += arm_gicv3_its_common.o
-common-obj-$(CONFIG_OPENPIC) += openpic.o
-common-obj-$(CONFIG_RX_ICU) += rx_icu.o
-common-obj-y += intc.o
-
-obj-$(CONFIG_APIC) += apic.o apic_common.o
-obj-$(CONFIG_ARM_GIC_KVM) += arm_gic_kvm.o
-obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_kvm.o
-obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_its_kvm.o
-obj-$(CONFIG_ARM_V7M) += armv7m_nvic.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_gic.o exynos4210_combiner.o
-obj-$(CONFIG_GRLIB) += grlib_irqmp.o
-obj-$(CONFIG_IOAPIC) += ioapic.o
-obj-$(CONFIG_OMAP) += omap_intc.o
-obj-$(CONFIG_OPENPIC_KVM) += openpic_kvm.o
-obj-$(CONFIG_RASPI) += bcm2835_ic.o bcm2836_control.o
-obj-$(CONFIG_SH4) += sh_intc.o
-obj-$(CONFIG_XICS) += xics.o
-obj-$(CONFIG_XICS_SPAPR) += xics_spapr.o
-obj-$(CONFIG_XICS_KVM) += xics_kvm.o
-obj-$(CONFIG_XIVE) += xive.o
-obj-$(CONFIG_XIVE_SPAPR) += spapr_xive.o
-obj-$(CONFIG_XIVE_KVM) += spapr_xive_kvm.o
-obj-$(CONFIG_POWERNV) += xics_pnv.o pnv_xive.o
-obj-$(CONFIG_ALLWINNER_A10_PIC) += allwinner-a10-pic.o
-obj-$(CONFIG_S390_FLIC) += s390_flic.o
-obj-$(CONFIG_S390_FLIC_KVM) += s390_flic_kvm.o
-obj-$(CONFIG_ASPEED_SOC) += aspeed_vic.o
-obj-$(CONFIG_ARM_GIC) += arm_gicv3_cpuif.o
-obj-$(CONFIG_MIPS_CPS) += mips_gic.o
-obj-$(CONFIG_NIOS2) += nios2_iic.o
-obj-$(CONFIG_OMPIC) += ompic.o
-obj-$(CONFIG_IBEX) += ibex_plic.o
-obj-$(CONFIG_LOONGSON_LIOINTC) += loongson_liointc.o
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
new file mode 100644
index 0000000000..c16f7f036e
--- /dev/null
+++ b/hw/intc/meson.build
@@ -0,0 +1,55 @@
+softmmu_ss.add(files('intc.c'))
+softmmu_ss.add(when: 'CONFIG_ARM_GIC', if_true: files(
+  'arm_gic.c',
+  'arm_gic_common.c',
+  'arm_gicv2m.c',
+  'arm_gicv3.c',
+  'arm_gicv3_common.c',
+  'arm_gicv3_dist.c',
+  'arm_gicv3_its_common.c',
+  'arm_gicv3_redist.c',
+))
+softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_pic.c'))
+softmmu_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic.c'))
+softmmu_ss.add(when: 'CONFIG_I8259', if_true: files('i8259_common.c', 'i8259.c'))
+softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_avic.c', 'imx_gpcv2.c'))
+softmmu_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic_common.c'))
+softmmu_ss.add(when: 'CONFIG_LM32', if_true: files('lm32_pic.c'))
+softmmu_ss.add(when: 'CONFIG_OPENPIC', if_true: files('openpic.c'))
+softmmu_ss.add(when: 'CONFIG_PL190', if_true: files('pl190.c'))
+softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_intc.c'))
+softmmu_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_gic.c'))
+softmmu_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_intctl.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_intc.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-ipi.c'))
+softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_PMU', if_true: files('xlnx-pmu-iomod-intc.c'))
+
+specific_ss.add(when: 'CONFIG_ALLWINNER_A10_PIC', if_true: files('allwinner-a10-pic.c'))
+specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
+specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif.c'))
+specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
+specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
+specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
+specific_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_vic.c'))
+specific_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_gic.c', 'exynos4210_combiner.c'))
+specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
+specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_plic.c'))
+specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
+specific_ss.add(when: 'CONFIG_LOONGSON_LIOINTC', if_true: files('loongson_liointc.c'))
+specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gic.c'))
+specific_ss.add(when: 'CONFIG_NIOS2', if_true: files('nios2_iic.c'))
+specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
+specific_ss.add(when: 'CONFIG_OMPIC', if_true: files('ompic.c'))
+specific_ss.add(when: 'CONFIG_OPENPIC_KVM', if_true: files('openpic_kvm.c'))
+specific_ss.add(when: 'CONFIG_POWERNV', if_true: files('xics_pnv.c', 'pnv_xive.c'))
+specific_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_ic.c', 'bcm2836_control.c'))
+specific_ss.add(when: 'CONFIG_RX_ICU', if_true: files('rx_icu.c'))
+specific_ss.add(when: 'CONFIG_S390_FLIC', if_true: files('s390_flic.c'))
+specific_ss.add(when: 'CONFIG_S390_FLIC_KVM', if_true: files('s390_flic_kvm.c'))
+specific_ss.add(when: 'CONFIG_SH4', if_true: files('sh_intc.c'))
+specific_ss.add(when: 'CONFIG_XICS', if_true: files('xics.c'))
+specific_ss.add(when: 'CONFIG_XICS_KVM', if_true: files('xics_kvm.c'))
+specific_ss.add(when: 'CONFIG_XICS_SPAPR', if_true: files('xics_spapr.c'))
+specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
+specific_ss.add(when: 'CONFIG_XIVE_KVM', if_true: files('spapr_xive_kvm.c'))
+specific_ss.add(when: 'CONFIG_XIVE_SPAPR', if_true: files('spapr_xive.c'))
diff --git a/hw/meson.build b/hw/meson.build
index ec4bb48a0f..986e710287 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,4 +1,5 @@
 subdir('core')
+subdir('intc')
 subdir('ipack')
 subdir('ipmi')
 subdir('isa')
-- 
2.26.2



