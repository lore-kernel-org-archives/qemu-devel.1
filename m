Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF38C4360D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 15:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532E62086A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 15:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532E62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBgzP-0007wd-Fn
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 11:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iBgwC-0004PT-J4
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 11:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iBgwA-0003FV-KZ
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 11:04:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iBgw6-0003Du-4H; Sat, 21 Sep 2019 11:04:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C4D03082B45;
 Sat, 21 Sep 2019 15:04:33 +0000 (UTC)
Received: from thuth.com (ovpn-116-27.ams2.redhat.com [10.36.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F188560920;
 Sat, 21 Sep 2019 15:04:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/4] hw/arm: Move armv7m_nvic.c to hw/arm/ and always enable
 it for arm builds
Date: Sat, 21 Sep 2019 17:04:19 +0200
Message-Id: <20190921150420.30743-4-thuth@redhat.com>
In-Reply-To: <20190921150420.30743-1-thuth@redhat.com>
References: <20190921150420.30743-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Sat, 21 Sep 2019 15:04:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-system-arm/-aarch64 currently can't be built without setting the
switch CONFIG_ARM_V7M=y - which we currently always do in the config file
default-configs/arm-softmmu.mak. This is because the code in target/arm/
calls many functions from this armv7m_nvic.c, and thus linking fails
without this file.

So armv7m_nvic.c should not be under the CONFIG_ARM_V7M switch, but always
compiled for arm builds. Since we can not simply do this in hw/intc/ (with
"obj-y += ..." it would get compiled for all other architectures, too),
let's move the file to hw/arm/ instead and always enable it there.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/Makefile.objs           |  2 ++
 hw/{intc => arm}/armv7m_nvic.c |  0
 hw/arm/trace-events            | 17 +++++++++++++++++
 hw/intc/Makefile.objs          |  1 -
 hw/intc/trace-events           | 17 -----------------
 5 files changed, 19 insertions(+), 18 deletions(-)
 rename hw/{intc => arm}/armv7m_nvic.c (100%)

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 43ce8d5b19..3c94d383a0 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -27,6 +27,8 @@ obj-$(CONFIG_VEXPRESS) += vexpress.o
 obj-$(CONFIG_ZYNQ) += xilinx_zynq.o
 obj-$(CONFIG_SABRELITE) += sabrelite.o
 
+# Note: armv7m_nvic.o is currently always required for linking
+obj-y += armv7m_nvic.o
 obj-$(CONFIG_ARM_V7M) += armv7m.o
 obj-$(CONFIG_EXYNOS4) += exynos4210.o
 obj-$(CONFIG_PXA2XX) += pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
diff --git a/hw/intc/armv7m_nvic.c b/hw/arm/armv7m_nvic.c
similarity index 100%
rename from hw/intc/armv7m_nvic.c
rename to hw/arm/armv7m_nvic.c
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 0acedcedc6..3068202a4c 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -1,5 +1,22 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# armv7m_nvic.c
+nvic_recompute_state(int vectpending, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d vectpending_prio %d exception_prio %d"
+nvic_recompute_state_secure(int vectpending, bool vectpending_is_s_banked, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d is_s_banked %d vectpending_prio %d exception_prio %d"
+nvic_set_prio(int irq, bool secure, uint8_t prio) "NVIC set irq %d secure-bank %d priority %d"
+nvic_irq_update(int vectpending, int pendprio, int exception_prio, int level) "NVIC vectpending %d pending prio %d exception_prio %d: setting irq line to %d"
+nvic_escalate_prio(int irq, int irqprio, int runprio) "NVIC escalating irq %d to HardFault: insufficient priority %d >= %d"
+nvic_escalate_disabled(int irq) "NVIC escalating irq %d to HardFault: disabled"
+nvic_set_pending(int irq, bool secure, bool targets_secure, bool derived, int en, int prio) "NVIC set pending irq %d secure-bank %d targets_secure %d derived %d (enabled: %d priority %d)"
+nvic_clear_pending(int irq, bool secure, int en, int prio) "NVIC clear pending irq %d secure-bank %d (enabled: %d priority %d)"
+nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (prio %d)"
+nvic_get_pending_irq_info(int irq, bool secure) "NVIC next IRQ %d: targets_secure: %d"
+nvic_complete_irq(int irq, bool secure) "NVIC complete IRQ %d (secure %d)"
+nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
+nvic_set_nmi_level(int level) "NVIC external NMI level set to %d"
+nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
+
 # virt-acpi-build.c
 virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
 
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index f726d87532..2d981abb4e 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -26,7 +26,6 @@ obj-$(CONFIG_APIC) += apic.o apic_common.o
 obj-$(CONFIG_ARM_GIC_KVM) += arm_gic_kvm.o
 obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_kvm.o
 obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_its_kvm.o
-obj-$(CONFIG_ARM_V7M) += armv7m_nvic.o
 obj-$(CONFIG_EXYNOS4) += exynos4210_gic.o exynos4210_combiner.o
 obj-$(CONFIG_GRLIB) += grlib_irqmp.o
 obj-$(CONFIG_IOAPIC) += ioapic.o
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 90c9d07c1a..09a7fedee8 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -179,23 +179,6 @@ gicv3_redist_badwrite(uint32_t cpu, uint64_t offset, uint64_t data, unsigned siz
 gicv3_redist_set_irq(uint32_t cpu, int irq, int level) "GICv3 redistributor 0x%x interrupt %d level changed to %d"
 gicv3_redist_send_sgi(uint32_t cpu, int irq) "GICv3 redistributor 0x%x pending SGI %d"
 
-# armv7m_nvic.c
-nvic_recompute_state(int vectpending, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d vectpending_prio %d exception_prio %d"
-nvic_recompute_state_secure(int vectpending, bool vectpending_is_s_banked, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d is_s_banked %d vectpending_prio %d exception_prio %d"
-nvic_set_prio(int irq, bool secure, uint8_t prio) "NVIC set irq %d secure-bank %d priority %d"
-nvic_irq_update(int vectpending, int pendprio, int exception_prio, int level) "NVIC vectpending %d pending prio %d exception_prio %d: setting irq line to %d"
-nvic_escalate_prio(int irq, int irqprio, int runprio) "NVIC escalating irq %d to HardFault: insufficient priority %d >= %d"
-nvic_escalate_disabled(int irq) "NVIC escalating irq %d to HardFault: disabled"
-nvic_set_pending(int irq, bool secure, bool targets_secure, bool derived, int en, int prio) "NVIC set pending irq %d secure-bank %d targets_secure %d derived %d (enabled: %d priority %d)"
-nvic_clear_pending(int irq, bool secure, int en, int prio) "NVIC clear pending irq %d secure-bank %d (enabled: %d priority %d)"
-nvic_acknowledge_irq(int irq, int prio) "NVIC acknowledge IRQ: %d now active (prio %d)"
-nvic_get_pending_irq_info(int irq, bool secure) "NVIC next IRQ %d: targets_secure: %d"
-nvic_complete_irq(int irq, bool secure) "NVIC complete IRQ %d (secure %d)"
-nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set to %d"
-nvic_set_nmi_level(int level) "NVIC external NMI level set to %d"
-nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sysreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-
 # heathrow_pic.c
 heathrow_write(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
 heathrow_read(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64" %u: 0x%"PRIx64
-- 
2.18.1


