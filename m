Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB31C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20576206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20576206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmzKw-00011R-6J
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53262)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hmzKe-0000co-5b
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hmzKZ-0005X0-Bd
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:39:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hmzKZ-0005Vz-0v
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:39:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2FFC130862BE;
 Mon, 15 Jul 2019 11:39:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 424996012C;
 Mon, 15 Jul 2019 11:39:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C797E11386A0; Mon, 15 Jul 2019 13:39:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 13:39:39 +0200
Message-Id: <20190715113939.3256-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 15 Jul 2019 11:39:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] include: Make headers more self-contained
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Back in 2016, we discussed[1] rules for headers, and these were
generally liked:

1. Have a carefully curated header that's included everywhere first.  We
   got that already thanks to Peter: osdep.h.

2. Headers should normally include everything they need beyond osdep.h.
   If exceptions are needed for some reason, they must be documented in
   the header.  If all that's needed from a header is typedefs, put
   those into qemu/typedefs.h instead of including the header.

3. Cyclic inclusion is forbidden.

This patch gets include/ closer to obeying 2.

It's actually extracted from my "[RFC] Baby steps towards saner
headers" series[2], which demonstrates a possible path towards
checking 2 automatically.  It passes the RFC test there.

[1] Message-ID: <87h9g8j57d.fsf@blackfin.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg03345.htm=
l
[2] Message-Id: <20190711122827.18970-1-armbru@redhat.com>
    https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg02715.htm=
l

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/block/raw-aio.h               | 1 +
 include/block/write-threshold.h       | 1 +
 include/disas/disas.h                 | 1 +
 include/exec/cputlb.h                 | 2 ++
 include/exec/exec-all.h               | 1 +
 include/exec/ioport.h                 | 2 ++
 include/exec/memory-internal.h        | 2 ++
 include/exec/ram_addr.h               | 1 +
 include/exec/softmmu-semi.h           | 2 ++
 include/exec/tb-hash.h                | 2 ++
 include/exec/user/thunk.h             | 1 +
 include/fpu/softfloat-macros.h        | 2 ++
 include/hw/acpi/pci.h                 | 2 ++
 include/hw/acpi/tco.h                 | 2 ++
 include/hw/adc/stm32f2xx_adc.h        | 2 ++
 include/hw/arm/allwinner-a10.h        | 1 +
 include/hw/arm/aspeed_soc.h           | 1 +
 include/hw/arm/bcm2836.h              | 1 +
 include/hw/arm/exynos4210.h           | 2 +-
 include/hw/arm/fsl-imx25.h            | 1 +
 include/hw/arm/fsl-imx31.h            | 1 +
 include/hw/arm/sharpsl.h              | 2 ++
 include/hw/arm/xlnx-zynqmp.h          | 1 +
 include/hw/block/fdc.h                | 2 ++
 include/hw/block/flash.h              | 1 +
 include/hw/char/escc.h                | 1 +
 include/hw/char/xilinx_uartlite.h     | 2 ++
 include/hw/core/generic-loader.h      | 1 +
 include/hw/cris/etraxfs.h             | 1 +
 include/hw/cris/etraxfs_dma.h         | 3 +++
 include/hw/display/i2c-ddc.h          | 1 +
 include/hw/empty_slot.h               | 2 ++
 include/hw/gpio/bcm2835_gpio.h        | 1 +
 include/hw/i2c/aspeed_i2c.h           | 1 +
 include/hw/i386/apic_internal.h       | 1 +
 include/hw/i386/ioapic_internal.h     | 1 +
 include/hw/intc/allwinner-a10-pic.h   | 2 ++
 include/hw/intc/heathrow_pic.h        | 2 ++
 include/hw/intc/mips_gic.h            | 1 +
 include/hw/isa/vt82c686.h             | 2 ++
 include/hw/mips/cps.h                 | 1 +
 include/hw/misc/macio/cuda.h          | 2 ++
 include/hw/misc/macio/gpio.h          | 3 +++
 include/hw/misc/macio/macio.h         | 2 ++
 include/hw/misc/macio/pmu.h           | 3 +++
 include/hw/misc/mips_cmgcr.h          | 2 ++
 include/hw/misc/mips_cpc.h            | 2 ++
 include/hw/misc/pvpanic.h             | 2 ++
 include/hw/net/allwinner_emac.h       | 1 +
 include/hw/net/lance.h                | 1 +
 include/hw/nvram/chrp_nvram.h         | 2 ++
 include/hw/pci-host/sabre.h           | 2 ++
 include/hw/pci-host/uninorth.h        | 2 +-
 include/hw/pci/pcie_aer.h             | 1 +
 include/hw/ppc/pnv_core.h             | 1 +
 include/hw/ppc/ppc4xx.h               | 4 ++++
 include/hw/ppc/spapr_irq.h            | 3 +++
 include/hw/ppc/spapr_vio.h            | 1 +
 include/hw/ppc/spapr_xive.h           | 2 ++
 include/hw/ppc/xive_regs.h            | 3 +++
 include/hw/riscv/boot.h               | 2 ++
 include/hw/riscv/riscv_hart.h         | 3 +++
 include/hw/riscv/sifive_clint.h       | 2 ++
 include/hw/riscv/sifive_e.h           | 1 +
 include/hw/riscv/sifive_plic.h        | 2 +-
 include/hw/riscv/sifive_prci.h        | 2 ++
 include/hw/riscv/sifive_test.h        | 2 ++
 include/hw/riscv/sifive_u.h           | 1 +
 include/hw/riscv/sifive_uart.h        | 3 +++
 include/hw/riscv/spike.h              | 3 +++
 include/hw/riscv/virt.h               | 3 +++
 include/hw/s390x/ap-device.h          | 2 ++
 include/hw/s390x/css-bridge.h         | 3 ++-
 include/hw/s390x/css.h                | 1 +
 include/hw/s390x/tod.h                | 2 +-
 include/hw/semihosting/console.h      | 2 ++
 include/hw/sh4/sh_intc.h              | 1 +
 include/hw/sparc/sparc64.h            | 2 ++
 include/hw/ssi/aspeed_smc.h           | 1 +
 include/hw/ssi/xilinx_spips.h         | 1 +
 include/hw/timer/allwinner-a10-pit.h  | 1 +
 include/hw/timer/i8254_internal.h     | 1 +
 include/hw/timer/m48t59.h             | 2 ++
 include/hw/timer/mc146818rtc_regs.h   | 2 ++
 include/hw/timer/xlnx-zynqmp-rtc.h    | 1 +
 include/hw/virtio/virtio-access.h     | 1 +
 include/hw/virtio/virtio-gpu-bswap.h  | 1 +
 include/hw/virtio/virtio-rng.h        | 1 +
 include/hw/watchdog/wdt_aspeed.h      | 1 +
 include/libdecnumber/decNumberLocal.h | 1 +
 include/migration/cpu.h               | 2 ++
 include/monitor/hmp-target.h          | 2 ++
 include/qemu/atomic128.h              | 2 ++
 include/qemu/ratelimit.h              | 2 ++
 include/qemu/thread-win32.h           | 2 +-
 include/sysemu/balloon.h              | 1 +
 include/sysemu/cryptodev-vhost-user.h | 2 ++
 include/sysemu/hvf.h                  | 1 +
 include/sysemu/iothread.h             | 1 +
 include/sysemu/kvm_int.h              | 2 ++
 include/sysemu/memory_mapping.h       | 2 ++
 include/sysemu/xen-mapcache.h         | 2 ++
 include/ui/egl-helpers.h              | 3 +++
 include/ui/input.h                    | 1 +
 include/ui/spice-display.h            | 1 +
 target/hppa/cpu.h                     | 2 +-
 106 files changed, 171 insertions(+), 7 deletions(-)

diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 0cb7cc74a2..264e3eb10e 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -15,6 +15,7 @@
 #ifndef QEMU_RAW_AIO_H
 #define QEMU_RAW_AIO_H
=20
+#include "block/aio.h"
 #include "qemu/coroutine.h"
 #include "qemu/iov.h"
=20
diff --git a/include/block/write-threshold.h b/include/block/write-thresh=
old.h
index 80d8aab5d0..25c71b7374 100644
--- a/include/block/write-threshold.h
+++ b/include/block/write-threshold.h
@@ -12,6 +12,7 @@
 #ifndef BLOCK_WRITE_THRESHOLD_H
 #define BLOCK_WRITE_THRESHOLD_H
=20
+#include "block/block_int.h"
=20
 /*
  * bdrv_write_threshold_set:
diff --git a/include/disas/disas.h b/include/disas/disas.h
index 15da511f49..ba47e9197c 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_DISAS_H
 #define QEMU_DISAS_H
=20
+#include "exec/hwaddr.h"
=20
 #ifdef NEED_CPU_H
 #include "cpu.h"
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 5373188be3..23abd71579 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -19,6 +19,8 @@
 #ifndef CPUTLB_H
 #define CPUTLB_H
=20
+#include "exec/cpu-common.h"
+
 #if !defined(CONFIG_USER_ONLY)
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 16034ee651..135aeaab0d 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,6 +20,7 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
=20
+#include "cpu.h"
 #include "exec/tb-context.h"
 #include "sysemu/cpus.h"
=20
diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index a298b89ce1..97feb296d2 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -24,6 +24,8 @@
 #ifndef IOPORT_H
 #define IOPORT_H
=20
+#include "exec/memory.h"
+
 #define MAX_IOPORTS     (64 * 1024)
 #define IOPORTS_MASK    (MAX_IOPORTS - 1)
=20
diff --git a/include/exec/memory-internal.h b/include/exec/memory-interna=
l.h
index d1a9dd1ec8..ef4fb92371 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -20,6 +20,8 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
=20
+#include "cpu.h"
+
 #ifndef CONFIG_USER_ONLY
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index f96777bb99..5a774ca0be 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -20,6 +20,7 @@
 #define RAM_ADDR_H
=20
 #ifndef CONFIG_USER_ONLY
+#include "cpu.h"
 #include "hw/xen/xen.h"
 #include "sysemu/tcg.h"
 #include "exec/ramlist.h"
diff --git a/include/exec/softmmu-semi.h b/include/exec/softmmu-semi.h
index 970837992e..fbcae88f4b 100644
--- a/include/exec/softmmu-semi.h
+++ b/include/exec/softmmu-semi.h
@@ -10,6 +10,8 @@
 #ifndef SOFTMMU_SEMI_H
 #define SOFTMMU_SEMI_H
=20
+#include "cpu.h"
+
 static inline uint64_t softmmu_tget64(CPUArchState *env, target_ulong ad=
dr)
 {
     uint64_t val;
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 4f3a37d927..805235d321 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -20,6 +20,8 @@
 #ifndef EXEC_TB_HASH_H
 #define EXEC_TB_HASH_H
=20
+#include "exec/cpu-defs.h"
+#include "exec/exec-all.h"
 #include "qemu/xxhash.h"
=20
 #ifdef CONFIG_SOFTMMU
diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 8d3af5a3be..d05a8a4dab 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -20,6 +20,7 @@
 #define THUNK_H
=20
 #include "cpu.h"
+#include "exec/user/abitypes.h"
=20
 /* types enums definitions */
=20
diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macro=
s.h
index c55aa6d174..be83a833ec 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -82,6 +82,8 @@ this code that are retained.
 #ifndef FPU_SOFTFLOAT_MACROS_H
 #define FPU_SOFTFLOAT_MACROS_H
=20
+#include "fpu/softfloat.h"
+
 /*----------------------------------------------------------------------=
------
 | Shifts `a' right by the number of bits given in `count'.  If any nonze=
ro
 | bits are shifted off, they are ``jammed'' into the least significant b=
it of
diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 8bbd32cf45..4594d7dc62 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -25,6 +25,8 @@
 #ifndef HW_ACPI_PCI_H
 #define HW_ACPI_PCI_H
=20
+#include "hw/acpi/bios-linker-loader.h"
+
 typedef struct AcpiMcfgInfo {
     uint64_t base;
     uint32_t size;
diff --git a/include/hw/acpi/tco.h b/include/hw/acpi/tco.h
index d19dd59353..8adb7a0d20 100644
--- a/include/hw/acpi/tco.h
+++ b/include/hw/acpi/tco.h
@@ -9,6 +9,8 @@
 #ifndef HW_ACPI_TCO_H
 #define HW_ACPI_TCO_H
=20
+#include "exec/memory.h"
+#include "migration/vmstate.h"
=20
 /* As per ICH9 spec, the internal timer has an error of ~0.6s on every t=
ick */
 #define TCO_TICK_NSEC 600000000LL
diff --git a/include/hw/adc/stm32f2xx_adc.h b/include/hw/adc/stm32f2xx_ad=
c.h
index a72f734eb1..663b79f4f3 100644
--- a/include/hw/adc/stm32f2xx_adc.h
+++ b/include/hw/adc/stm32f2xx_adc.h
@@ -25,6 +25,8 @@
 #ifndef HW_STM32F2XX_ADC_H
 #define HW_STM32F2XX_ADC_H
=20
+#include "hw/sysbus.h"
+
 #define ADC_SR    0x00
 #define ADC_CR1   0x04
 #define ADC_CR2   0x08
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a1=
0.h
index e99fe2ea2e..7182ce5c4b 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -11,6 +11,7 @@
 #include "hw/ide/ahci.h"
=20
 #include "sysemu/sysemu.h"
+#include "target/arm/cpu.h"
=20
=20
 #define AW_A10_PIC_REG_BASE     0x01c20400
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index cef605ad6b..976fd6be93 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -22,6 +22,7 @@
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "hw/net/ftgmac100.h"
+#include "target/arm/cpu.h"
=20
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index a2cb8454de..97187f72be 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -13,6 +13,7 @@
=20
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/intc/bcm2836_control.h"
+#include "target/arm/cpu.h"
=20
 #define TYPE_BCM283X "bcm283x"
 #define BCM283X(obj) OBJECT_CHECK(BCM283XState, (obj), TYPE_BCM283X)
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index aa137271c0..358f4619de 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -25,7 +25,7 @@
 #ifndef EXYNOS4210_H
 #define EXYNOS4210_H
=20
-#include "exec/memory.h"
+#include "hw/sysbus.h"
 #include "target/arm/cpu-qom.h"
=20
 #define EXYNOS4210_NCPUS                    2
diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 3280ab1fb0..241efb52ae 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -27,6 +27,7 @@
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
 #include "exec/memory.h"
+#include "target/arm/cpu.h"
=20
 #define TYPE_FSL_IMX25 "fsl,imx25"
 #define FSL_IMX25(obj) OBJECT_CHECK(FslIMX25State, (obj), TYPE_FSL_IMX25=
)
diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index e68a81efd7..ac5ca9826a 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -26,6 +26,7 @@
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
 #include "exec/memory.h"
+#include "target/arm/cpu.h"
=20
 #define TYPE_FSL_IMX31 "fsl,imx31"
 #define FSL_IMX31(obj) OBJECT_CHECK(FslIMX31State, (obj), TYPE_FSL_IMX31=
)
diff --git a/include/hw/arm/sharpsl.h b/include/hw/arm/sharpsl.h
index 5bf6db1fa2..a5ef797a67 100644
--- a/include/hw/arm/sharpsl.h
+++ b/include/hw/arm/sharpsl.h
@@ -6,6 +6,8 @@
 #ifndef QEMU_SHARPSL_H
 #define QEMU_SHARPSL_H
=20
+#include "exec/hwaddr.h"
+
 #define zaurus_printf(format, ...)	\
     fprintf(stderr, "%s: " format, __func__, ##__VA_ARGS__)
=20
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 35804ea80a..6cb65e7537 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -32,6 +32,7 @@
 #include "hw/intc/xlnx-zynqmp-ipi.h"
 #include "hw/timer/xlnx-zynqmp-rtc.h"
 #include "hw/cpu/cluster.h"
+#include "target/arm/cpu.h"
=20
 #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
 #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 8cece84326..f4fe2f471b 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -1,6 +1,8 @@
 #ifndef HW_FDC_H
 #define HW_FDC_H
=20
+#include "exec/hwaddr.h"
+#include "hw/irq.h"
 #include "qapi/qapi-types-block.h"
=20
 /* fdc.c */
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 1acaf7de80..83a75f3170 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -4,6 +4,7 @@
 /* NOR flash devices */
=20
 #include "exec/memory.h"
+#include "migration/vmstate.h"
=20
 /* pflash_cfi01.c */
=20
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 42aca83611..d5196c53e6 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -3,6 +3,7 @@
=20
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
+#include "hw/sysbus.h"
 #include "ui/input.h"
=20
 /* escc.c */
diff --git a/include/hw/char/xilinx_uartlite.h b/include/hw/char/xilinx_u=
artlite.h
index 634086b657..99d8bbf405 100644
--- a/include/hw/char/xilinx_uartlite.h
+++ b/include/hw/char/xilinx_uartlite.h
@@ -15,6 +15,8 @@
 #ifndef XILINX_UARTLITE_H
 #define XILINX_UARTLITE_H
=20
+#include "hw/sysbus.h"
+
 static inline DeviceState *xilinx_uartlite_create(hwaddr addr,
                                         qemu_irq irq,
                                         Chardev *chr)
diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic-l=
oader.h
index dd27c42ab0..9ffce1c5a3 100644
--- a/include/hw/core/generic-loader.h
+++ b/include/hw/core/generic-loader.h
@@ -19,6 +19,7 @@
 #define GENERIC_LOADER_H
=20
 #include "elf.h"
+#include "hw/qdev-core.h"
=20
 typedef struct GenericLoaderState {
     /* <private> */
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 8da965addb..494222d315 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -27,6 +27,7 @@
=20
 #include "net/net.h"
 #include "hw/cris/etraxfs_dma.h"
+#include "hw/sysbus.h"
=20
 /* Instantiate an ETRAXFS Ethernet MAC.  */
 static inline DeviceState *
diff --git a/include/hw/cris/etraxfs_dma.h b/include/hw/cris/etraxfs_dma.=
h
index f6f33e0980..31ae360611 100644
--- a/include/hw/cris/etraxfs_dma.h
+++ b/include/hw/cris/etraxfs_dma.h
@@ -1,6 +1,9 @@
 #ifndef HW_ETRAXFS_DMA_H
 #define HW_ETRAXFS_DMA_H
=20
+#include "exec/hwaddr.h"
+#include "hw/irq.h"
+
 struct dma_context_metadata {
 	/* data descriptor md */
 	uint16_t metadata;
diff --git a/include/hw/display/i2c-ddc.h b/include/hw/display/i2c-ddc.h
index c29443c5af..1cf53a0c8d 100644
--- a/include/hw/display/i2c-ddc.h
+++ b/include/hw/display/i2c-ddc.h
@@ -20,6 +20,7 @@
 #define I2C_DDC_H
=20
 #include "hw/display/edid.h"
+#include "hw/i2c/i2c.h"
=20
 /* A simple I2C slave which just returns the contents of its EDID blob. =
*/
 struct I2CDDCState {
diff --git a/include/hw/empty_slot.h b/include/hw/empty_slot.h
index 123a9f8989..cb9a221aa6 100644
--- a/include/hw/empty_slot.h
+++ b/include/hw/empty_slot.h
@@ -1,6 +1,8 @@
 #ifndef HW_EMPTY_SLOT_H
 #define HW_EMPTY_SLOT_H
=20
+#include "exec/hwaddr.h"
+
 /* empty_slot.c */
 void empty_slot_init(hwaddr addr, uint64_t slot_size);
=20
diff --git a/include/hw/gpio/bcm2835_gpio.h b/include/hw/gpio/bcm2835_gpi=
o.h
index 9f8e0c720c..b0de0a3c74 100644
--- a/include/hw/gpio/bcm2835_gpio.h
+++ b/include/hw/gpio/bcm2835_gpio.h
@@ -15,6 +15,7 @@
 #define BCM2835_GPIO_H
=20
 #include "hw/sd/sd.h"
+#include "hw/sysbus.h"
=20
 typedef struct BCM2835GpioState {
     SysBusDevice parent_obj;
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index f9020acdef..f742936175 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -21,6 +21,7 @@
 #define ASPEED_I2C_H
=20
 #include "hw/i2c/i2c.h"
+#include "hw/sysbus.h"
=20
 #define TYPE_ASPEED_I2C "aspeed.i2c"
 #define ASPEED_I2C(obj) \
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_inter=
nal.h
index 1209eb483a..b04bdd947f 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -24,6 +24,7 @@
 #include "cpu.h"
 #include "exec/memory.h"
 #include "qemu/timer.h"
+#include "target/i386/cpu-qom.h"
=20
 /* APIC Local Vector Table */
 #define APIC_LVT_TIMER                  0
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_i=
nternal.h
index 07002f9662..3d2eec2aa7 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -24,6 +24,7 @@
=20
 #include "hw/hw.h"
 #include "exec/memory.h"
+#include "hw/i386/ioapic.h"
 #include "hw/sysbus.h"
 #include "qemu/notify.h"
=20
diff --git a/include/hw/intc/allwinner-a10-pic.h b/include/hw/intc/allwin=
ner-a10-pic.h
index 1d314a70d9..a5895401d1 100644
--- a/include/hw/intc/allwinner-a10-pic.h
+++ b/include/hw/intc/allwinner-a10-pic.h
@@ -1,6 +1,8 @@
 #ifndef ALLWINNER_A10_PIC_H
 #define ALLWINNER_A10_PIC_H
=20
+#include "hw/sysbus.h"
+
 #define TYPE_AW_A10_PIC  "allwinner-a10-pic"
 #define AW_A10_PIC(obj) OBJECT_CHECK(AwA10PICState, (obj), TYPE_AW_A10_P=
IC)
=20
diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pi=
c.h
index 6c91ec91bb..b163e27ab9 100644
--- a/include/hw/intc/heathrow_pic.h
+++ b/include/hw/intc/heathrow_pic.h
@@ -26,6 +26,8 @@
 #ifndef HW_INTC_HEATHROW_PIC_H
 #define HW_INTC_HEATHROW_PIC_H
=20
+#include "hw/sysbus.h"
+
 #define TYPE_HEATHROW "heathrow"
 #define HEATHROW(obj) OBJECT_CHECK(HeathrowState, (obj), TYPE_HEATHROW)
=20
diff --git a/include/hw/intc/mips_gic.h b/include/hw/intc/mips_gic.h
index 902a12b178..8428287bf9 100644
--- a/include/hw/intc/mips_gic.h
+++ b/include/hw/intc/mips_gic.h
@@ -13,6 +13,7 @@
=20
 #include "qemu/units.h"
 #include "hw/timer/mips_gictimer.h"
+#include "hw/sysbus.h"
 #include "cpu.h"
 /*
  * GIC Specific definitions
diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index c3c2b6e786..a54c3fe60a 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -1,6 +1,8 @@
 #ifndef HW_VT82C686_H
 #define HW_VT82C686_H
=20
+#include "hw/irq.h"
+
 #define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
=20
 /* vt82c686.c */
diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index aab1af926d..a941c55f27 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -25,6 +25,7 @@
 #include "hw/intc/mips_gic.h"
 #include "hw/misc/mips_cpc.h"
 #include "hw/misc/mips_itu.h"
+#include "target/mips/cpu.h"
=20
 #define TYPE_MIPS_CPS "mips-cps"
 #define MIPS_CPS(obj) OBJECT_CHECK(MIPSCPSState, (obj), TYPE_MIPS_CPS)
diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
index 7dad469142..5768075ac5 100644
--- a/include/hw/misc/macio/cuda.h
+++ b/include/hw/misc/macio/cuda.h
@@ -26,6 +26,8 @@
 #ifndef CUDA_H
 #define CUDA_H
=20
+#include "hw/misc/mos6522.h"
+
 /* CUDA commands (2nd byte) */
 #define CUDA_WARM_START                0x0
 #define CUDA_AUTOPOLL                  0x1
diff --git a/include/hw/misc/macio/gpio.h b/include/hw/misc/macio/gpio.h
index 2838ae5fde..24a4364b39 100644
--- a/include/hw/misc/macio/gpio.h
+++ b/include/hw/misc/macio/gpio.h
@@ -26,6 +26,9 @@
 #ifndef MACIO_GPIO_H
 #define MACIO_GPIO_H
=20
+#include "hw/ppc/openpic.h"
+#include "hw/sysbus.h"
+
 #define TYPE_MACIO_GPIO "macio-gpio"
 #define MACIO_GPIO(obj) OBJECT_CHECK(MacIOGPIOState, (obj), TYPE_MACIO_G=
PIO)
=20
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.=
h
index 970058b6ed..070a694eb5 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -27,10 +27,12 @@
 #define MACIO_H
=20
 #include "hw/char/escc.h"
+#include "hw/ide/internal.h"
 #include "hw/intc/heathrow_pic.h"
 #include "hw/misc/macio/cuda.h"
 #include "hw/misc/macio/gpio.h"
 #include "hw/misc/macio/pmu.h"
+#include "hw/ppc/mac.h"
 #include "hw/ppc/mac_dbdma.h"
 #include "hw/ppc/openpic.h"
=20
diff --git a/include/hw/misc/macio/pmu.h b/include/hw/misc/macio/pmu.h
index d10895ba5f..7ef83dee4c 100644
--- a/include/hw/misc/macio/pmu.h
+++ b/include/hw/misc/macio/pmu.h
@@ -10,6 +10,9 @@
 #ifndef PMU_H
 #define PMU_H
=20
+#include "hw/misc/mos6522.h"
+#include "hw/misc/macio/gpio.h"
+
 /*
  * PMU commands
  */
diff --git a/include/hw/misc/mips_cmgcr.h b/include/hw/misc/mips_cmgcr.h
index c9dfcb4b84..3e6e223273 100644
--- a/include/hw/misc/mips_cmgcr.h
+++ b/include/hw/misc/mips_cmgcr.h
@@ -10,6 +10,8 @@
 #ifndef MIPS_CMGCR_H
 #define MIPS_CMGCR_H
=20
+#include "hw/sysbus.h"
+
 #define TYPE_MIPS_GCR "mips-gcr"
 #define MIPS_GCR(obj) OBJECT_CHECK(MIPSGCRState, (obj), TYPE_MIPS_GCR)
=20
diff --git a/include/hw/misc/mips_cpc.h b/include/hw/misc/mips_cpc.h
index 72c834e039..3f670578b0 100644
--- a/include/hw/misc/mips_cpc.h
+++ b/include/hw/misc/mips_cpc.h
@@ -20,6 +20,8 @@
 #ifndef MIPS_CPC_H
 #define MIPS_CPC_H
=20
+#include "hw/sysbus.h"
+
 #define CPC_ADDRSPACE_SZ    0x6000
=20
 /* CPC blocks offsets relative to base address */
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 1ee071a703..840bf4ec09 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -14,6 +14,8 @@
 #ifndef HW_MISC_PVPANIC_H
 #define HW_MISC_PVPANIC_H
=20
+#include "qom/object.h"
+
 #define TYPE_PVPANIC "pvpanic"
=20
 #define PVPANIC_IOPORT_PROP "ioport"
diff --git a/include/hw/net/allwinner_emac.h b/include/hw/net/allwinner_e=
mac.h
index 905a43deb4..5013207d15 100644
--- a/include/hw/net/allwinner_emac.h
+++ b/include/hw/net/allwinner_emac.h
@@ -27,6 +27,7 @@
 #include "net/net.h"
 #include "qemu/fifo8.h"
 #include "hw/net/mii.h"
+#include "hw/sysbus.h"
=20
 #define TYPE_AW_EMAC "allwinner-emac"
 #define AW_EMAC(obj) OBJECT_CHECK(AwEmacState, (obj), TYPE_AW_EMAC)
diff --git a/include/hw/net/lance.h b/include/hw/net/lance.h
index ffdd35c4d7..0357f5f65c 100644
--- a/include/hw/net/lance.h
+++ b/include/hw/net/lance.h
@@ -31,6 +31,7 @@
=20
 #include "net/net.h"
 #include "hw/net/pcnet.h"
+#include "hw/sysbus.h"
=20
 #define TYPE_LANCE "lance"
 #define SYSBUS_PCNET(obj) \
diff --git a/include/hw/nvram/chrp_nvram.h b/include/hw/nvram/chrp_nvram.=
h
index b4f5b2b104..09941a9be4 100644
--- a/include/hw/nvram/chrp_nvram.h
+++ b/include/hw/nvram/chrp_nvram.h
@@ -18,6 +18,8 @@
 #ifndef CHRP_NVRAM_H
 #define CHRP_NVRAM_H
=20
+#include "qemu/bswap.h"
+
 /* OpenBIOS NVRAM partition */
 typedef struct {
     uint8_t signature;
diff --git a/include/hw/pci-host/sabre.h b/include/hw/pci-host/sabre.h
index 9afa4938fd..99b5aefbec 100644
--- a/include/hw/pci-host/sabre.h
+++ b/include/hw/pci-host/sabre.h
@@ -1,6 +1,8 @@
 #ifndef HW_PCI_HOST_SABRE_H
 #define HW_PCI_HOST_SABRE_H
=20
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
 #include "hw/sparc/sun4u_iommu.h"
=20
 #define MAX_IVEC 0x40
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
index 060324536a..9a5cabd4c5 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -26,7 +26,7 @@
 #define UNINORTH_H
=20
 #include "hw/hw.h"
-
+#include "hw/pci/pci_host.h"
 #include "hw/ppc/openpic.h"
=20
 /* UniNorth version */
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 729a9439c8..502dcd7eba 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -22,6 +22,7 @@
 #define QEMU_PCIE_AER_H
=20
 #include "hw/hw.h"
+#include "hw/pci/pci_regs.h"
=20
 /* definitions which PCIExpressDevice uses */
=20
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index d0926454a9..bfbd2ec42a 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -21,6 +21,7 @@
 #define PPC_PNV_CORE_H
=20
 #include "hw/cpu/core.h"
+#include "target/ppc/cpu.h"
=20
 #define TYPE_PNV_CORE "powernv-cpu-core"
 #define PNV_CORE(obj) \
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 39a7ba1ce6..90f8866138 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -25,6 +25,10 @@
 #ifndef PPC4XX_H
 #define PPC4XX_H
=20
+#include "hw/ppc/ppc.h"
+#include "exec/cpu-common.h"
+#include "exec/memory.h"
+
 /* PowerPC 4xx core initialization */
 PowerPCCPU *ppc4xx_init(const char *cpu_model,
                         clk_setup_t *cpu_clk, clk_setup_t *tb_clk,
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index f965a58f89..cd6e18b05e 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -10,6 +10,9 @@
 #ifndef HW_SPAPR_IRQ_H
 #define HW_SPAPR_IRQ_H
=20
+#include "hw/irq.h"
+#include "target/ppc/cpu-qom.h"
+
 /*
  * IRQ range offsets per device type
  */
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 04609f214e..875be28cdd 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -22,6 +22,7 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+#include "hw/ppc/spapr.h"
 #include "sysemu/dma.h"
=20
 #define TYPE_VIO_SPAPR_DEVICE "vio-spapr-device"
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 7197144265..a39e672f27 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -10,7 +10,9 @@
 #ifndef PPC_SPAPR_XIVE_H
 #define PPC_SPAPR_XIVE_H
=20
+#include "hw/ppc/spapr_irq.h"
 #include "hw/ppc/xive.h"
+#include "sysemu/sysemu.h"
=20
 #define TYPE_SPAPR_XIVE "spapr-xive"
 #define SPAPR_XIVE(obj) OBJECT_CHECK(SpaprXive, (obj), TYPE_SPAPR_XIVE)
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 1a8c5b5e64..b0c68ab5f7 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -16,6 +16,9 @@
 #ifndef PPC_XIVE_REGS_H
 #define PPC_XIVE_REGS_H
=20
+#include "qemu/bswap.h"
+#include "qemu/host-utils.h"
+
 /*
  * Interrupt source number encoding on PowerBUS
  */
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index daa179b600..bf12fa4d61 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -20,6 +20,8 @@
 #ifndef RISCV_BOOT_H
 #define RISCV_BOOT_H
=20
+#include "exec/cpu-defs.h"
+
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr);
 target_ulong riscv_load_kernel(const char *kernel_filename);
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.=
h
index 0671d88a44..3b52b50571 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -21,6 +21,9 @@
 #ifndef HW_RISCV_HART_H
 #define HW_RISCV_HART_H
=20
+#include "hw/sysbus.h"
+#include "target/riscv/cpu.h"
+
 #define TYPE_RISCV_HART_ARRAY "riscv.hart_array"
=20
 #define RISCV_HART_ARRAY(obj) \
diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_cl=
int.h
index e2865be1d1..ae8286c884 100644
--- a/include/hw/riscv/sifive_clint.h
+++ b/include/hw/riscv/sifive_clint.h
@@ -20,6 +20,8 @@
 #ifndef HW_SIFIVE_CLINT_H
 #define HW_SIFIVE_CLINT_H
=20
+#include "hw/sysbus.h"
+
 #define TYPE_SIFIVE_CLINT "riscv.sifive.clint"
=20
 #define SIFIVE_CLINT(obj) \
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index d175b24cb2..9c868dd7f9 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -19,6 +19,7 @@
 #ifndef HW_SIFIVE_E_H
 #define HW_SIFIVE_E_H
=20
+#include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_gpio.h"
=20
 #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_pli=
c.h
index ce8907f6aa..b0edba2884 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -21,7 +21,7 @@
 #ifndef HW_SIFIVE_PLIC_H
 #define HW_SIFIVE_PLIC_H
=20
-#include "hw/irq.h"
+#include "hw/sysbus.h"
=20
 #define TYPE_SIFIVE_PLIC "riscv.sifive.plic"
=20
diff --git a/include/hw/riscv/sifive_prci.h b/include/hw/riscv/sifive_prc=
i.h
index bd51c4af3c..8b7de134f8 100644
--- a/include/hw/riscv/sifive_prci.h
+++ b/include/hw/riscv/sifive_prci.h
@@ -19,6 +19,8 @@
 #ifndef HW_SIFIVE_PRCI_H
 #define HW_SIFIVE_PRCI_H
=20
+#include "hw/sysbus.h"
+
 enum {
     SIFIVE_PRCI_HFROSCCFG   =3D 0x0,
     SIFIVE_PRCI_HFXOSCCFG   =3D 0x4,
diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_tes=
t.h
index 71d4c9fad7..3a603a6ead 100644
--- a/include/hw/riscv/sifive_test.h
+++ b/include/hw/riscv/sifive_test.h
@@ -19,6 +19,8 @@
 #ifndef HW_SIFIVE_TEST_H
 #define HW_SIFIVE_TEST_H
=20
+#include "hw/sysbus.h"
+
 #define TYPE_SIFIVE_TEST "riscv.sifive.test"
=20
 #define SIFIVE_TEST(obj) \
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 892f0eee21..be021ce256 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -20,6 +20,7 @@
 #define HW_SIFIVE_U_H
=20
 #include "hw/net/cadence_gem.h"
+#include "hw/riscv/riscv_hart.h"
=20
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
 #define RISCV_U_SOC(obj) \
diff --git a/include/hw/riscv/sifive_uart.h b/include/hw/riscv/sifive_uar=
t.h
index c8dc1c57fd..65668825a3 100644
--- a/include/hw/riscv/sifive_uart.h
+++ b/include/hw/riscv/sifive_uart.h
@@ -20,6 +20,9 @@
 #ifndef HW_SIFIVE_UART_H
 #define HW_SIFIVE_UART_H
=20
+#include "chardev/char-fe.h"
+#include "hw/sysbus.h"
+
 enum {
     SIFIVE_UART_TXFIFO        =3D 0,
     SIFIVE_UART_RXFIFO        =3D 4,
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 641b70da67..03d870363c 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -19,6 +19,9 @@
 #ifndef HW_RISCV_SPIKE_H
 #define HW_RISCV_SPIKE_H
=20
+#include "hw/riscv/riscv_hart.h"
+#include "hw/sysbus.h"
+
 typedef struct {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index d01a1a85c4..6e5fbe5d3b 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -19,6 +19,9 @@
 #ifndef HW_RISCV_VIRT_H
 #define HW_RISCV_VIRT_H
=20
+#include "hw/riscv/riscv_hart.h"
+#include "hw/sysbus.h"
+
 typedef struct {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
index 765e9082a3..1aa89c36be 100644
--- a/include/hw/s390x/ap-device.h
+++ b/include/hw/s390x/ap-device.h
@@ -10,6 +10,8 @@
 #ifndef HW_S390X_AP_DEVICE_H
 #define HW_S390X_AP_DEVICE_H
=20
+#include "hw/qdev-core.h"
+
 #define AP_DEVICE_TYPE       "ap-device"
=20
 typedef struct APDevice {
diff --git a/include/hw/s390x/css-bridge.h b/include/hw/s390x/css-bridge.=
h
index 5a0203be5f..f7ed2d9a03 100644
--- a/include/hw/s390x/css-bridge.h
+++ b/include/hw/s390x/css-bridge.h
@@ -12,8 +12,9 @@
=20
 #ifndef HW_S390X_CSS_BRIDGE_H
 #define HW_S390X_CSS_BRIDGE_H
+
 #include "qom/object.h"
-#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
=20
 /* virtual css bridge */
 typedef struct VirtualCssBridge {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index d033387fba..f46bcafb16 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -17,6 +17,7 @@
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
 #include "sysemu/kvm.h"
+#include "target/s390x/cpu-qom.h"
=20
 /* Channel subsystem constants. */
 #define MAX_DEVNO 65535
diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index 9c4a6000c3..d71f4ea8a7 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -12,7 +12,7 @@
 #define HW_S390_TOD_H
=20
 #include "hw/qdev.h"
-#include "s390-tod.h"
+#include "target/s390x/s390-tod.h"
=20
 typedef struct S390TOD {
     uint8_t high;
diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/co=
nsole.h
index cfab572c0c..9be9754bcd 100644
--- a/include/hw/semihosting/console.h
+++ b/include/hw/semihosting/console.h
@@ -9,6 +9,8 @@
 #ifndef SEMIHOST_CONSOLE_H
 #define SEMIHOST_CONSOLE_H
=20
+#include "cpu.h"
+
 /**
  * qemu_semihosting_console_outs:
  * @env: CPUArchState
diff --git a/include/hw/sh4/sh_intc.h b/include/hw/sh4/sh_intc.h
index b7c2404334..3d3efde059 100644
--- a/include/hw/sh4/sh_intc.h
+++ b/include/hw/sh4/sh_intc.h
@@ -1,6 +1,7 @@
 #ifndef SH_INTC_H
 #define SH_INTC_H
=20
+#include "exec/memory.h"
 #include "hw/irq.h"
=20
 typedef unsigned char intc_enum;
diff --git a/include/hw/sparc/sparc64.h b/include/hw/sparc/sparc64.h
index 21ab79e343..4ced36fb5a 100644
--- a/include/hw/sparc/sparc64.h
+++ b/include/hw/sparc/sparc64.h
@@ -1,6 +1,8 @@
 #ifndef HW_SPARC_SPARC64_H
 #define HW_SPARC_SPARC64_H
=20
+#include "target/sparc/cpu-qom.h"
+
 #define IVEC_MAX             0x40
=20
 SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr);
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 591279ba1f..aa07dac4fe 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -26,6 +26,7 @@
 #define ASPEED_SMC_H
=20
 #include "hw/ssi/ssi.h"
+#include "hw/sysbus.h"
=20
 typedef struct AspeedSegments {
     hwaddr addr;
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.=
h
index a0a0ae7584..6a39b55a7b 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -28,6 +28,7 @@
 #include "hw/ssi/ssi.h"
 #include "qemu/fifo32.h"
 #include "hw/stream.h"
+#include "hw/sysbus.h"
=20
 typedef struct XilinxSPIPS XilinxSPIPS;
=20
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allw=
inner-a10-pit.h
index c0cc3e2169..871c95b512 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -2,6 +2,7 @@
 #define ALLWINNER_A10_PIT_H
=20
 #include "hw/ptimer.h"
+#include "hw/sysbus.h"
=20
 #define TYPE_AW_A10_PIT "allwinner-A10-timer"
 #define AW_A10_PIT(obj) OBJECT_CHECK(AwA10PITState, (obj), TYPE_AW_A10_P=
IT)
diff --git a/include/hw/timer/i8254_internal.h b/include/hw/timer/i8254_i=
nternal.h
index c37a438f82..e611c6f227 100644
--- a/include/hw/timer/i8254_internal.h
+++ b/include/hw/timer/i8254_internal.h
@@ -27,6 +27,7 @@
=20
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
+#include "hw/timer/i8254.h"
 #include "qemu/timer.h"
=20
 typedef struct PITChannelState {
diff --git a/include/hw/timer/m48t59.h b/include/hw/timer/m48t59.h
index 43efc91f56..d3fb50e08c 100644
--- a/include/hw/timer/m48t59.h
+++ b/include/hw/timer/m48t59.h
@@ -1,6 +1,8 @@
 #ifndef HW_M48T59_H
 #define HW_M48T59_H
=20
+#include "exec/hwaddr.h"
+#include "hw/irq.h"
 #include "qom/object.h"
=20
 #define TYPE_NVRAM "nvram"
diff --git a/include/hw/timer/mc146818rtc_regs.h b/include/hw/timer/mc146=
818rtc_regs.h
index c62f17bf2d..bfbb57e570 100644
--- a/include/hw/timer/mc146818rtc_regs.h
+++ b/include/hw/timer/mc146818rtc_regs.h
@@ -25,6 +25,8 @@
 #ifndef MC146818RTC_REGS_H
 #define MC146818RTC_REGS_H
=20
+#include "qemu/timer.h"
+
 #define RTC_ISA_IRQ 8
=20
 #define RTC_SECONDS             0
diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-z=
ynqmp-rtc.h
index 6e9134edf6..97e32322ed 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/timer/xlnx-zynqmp-rtc.h
@@ -28,6 +28,7 @@
 #define HW_TIMER_XLNX_ZYNQMP_RTC_H
=20
 #include "hw/register.h"
+#include "hw/sysbus.h"
=20
 #define TYPE_XLNX_ZYNQMP_RTC "xlnx-zynmp.rtc"
=20
diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio=
-access.h
index bdf58f3119..6818a23a2d 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -16,6 +16,7 @@
 #ifndef QEMU_VIRTIO_ACCESS_H
 #define QEMU_VIRTIO_ACCESS_H
=20
+#include "exec/hwaddr.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
=20
diff --git a/include/hw/virtio/virtio-gpu-bswap.h b/include/hw/virtio/vir=
tio-gpu-bswap.h
index 38d12160f6..203f9e1718 100644
--- a/include/hw/virtio/virtio-gpu-bswap.h
+++ b/include/hw/virtio/virtio-gpu-bswap.h
@@ -15,6 +15,7 @@
 #define HW_VIRTIO_GPU_BSWAP_H
=20
 #include "qemu/bswap.h"
+#include "standard-headers/linux/virtio_gpu.h"
=20
 static inline void
 virtio_gpu_ctrl_hdr_bswap(struct virtio_gpu_ctrl_hdr *hdr)
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rn=
g.h
index 922dce7cac..ff699335e3 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -12,6 +12,7 @@
 #ifndef QEMU_VIRTIO_RNG_H
 #define QEMU_VIRTIO_RNG_H
=20
+#include "hw/virtio/virtio.h"
 #include "sysemu/rng.h"
 #include "sysemu/rng-random.h"
 #include "standard-headers/linux/virtio_rng.h"
diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_a=
speed.h
index daef0c0e23..8c5691ce20 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -10,6 +10,7 @@
 #ifndef WDT_ASPEED_H
 #define WDT_ASPEED_H
=20
+#include "hw/misc/aspeed_scu.h"
 #include "hw/sysbus.h"
=20
 #define TYPE_ASPEED_WDT "aspeed.wdt"
diff --git a/include/libdecnumber/decNumberLocal.h b/include/libdecnumber=
/decNumberLocal.h
index 12cf1d8b6f..4d53c077f2 100644
--- a/include/libdecnumber/decNumberLocal.h
+++ b/include/libdecnumber/decNumberLocal.h
@@ -44,6 +44,7 @@
   #define DECNLAUTHOR	"Mike Cowlishaw"	      /* Who to blame */
=20
   #include "libdecnumber/dconfig.h"
+  #include "libdecnumber/decContext.h"
=20
   /* Conditional code flag -- set this to match hardware platform     */
   /* 1=3Dlittle-endian, 0=3Dbig-endian	                              */
diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index a40bd3549f..8424f1631a 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -2,6 +2,8 @@
 #ifndef MIGRATION_CPU_H
 #define MIGRATION_CPU_H
=20
+#include "exec/cpu-defs.h"
+
 #if TARGET_LONG_BITS =3D=3D 64
 #define qemu_put_betl qemu_put_be64
 #define qemu_get_betl qemu_get_be64
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 454e8ed155..8b7820a3ad 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -25,6 +25,8 @@
 #ifndef MONITOR_HMP_TARGET_H
 #define MONITOR_HMP_TARGET_H
=20
+#include "cpu.h"
+
 #define MD_TLONG 0
 #define MD_I32   1
=20
diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index ddd0d55d31..6b34484e15 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -13,6 +13,8 @@
 #ifndef QEMU_ATOMIC128_H
 #define QEMU_ATOMIC128_H
=20
+#include "qemu/int128.h"
+
 /*
  * GCC is a house divided about supporting large atomic operations.
  *
diff --git a/include/qemu/ratelimit.h b/include/qemu/ratelimit.h
index 1b38291823..01da8d63f1 100644
--- a/include/qemu/ratelimit.h
+++ b/include/qemu/ratelimit.h
@@ -14,6 +14,8 @@
 #ifndef QEMU_RATELIMIT_H
 #define QEMU_RATELIMIT_H
=20
+#include "qemu/timer.h"
+
 typedef struct {
     int64_t slice_start_time;
     int64_t slice_end_time;
diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index 50af5dd7ab..d0a1a9597e 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -47,6 +47,6 @@ struct QemuThread {
 };
=20
 /* Only valid for joinable threads.  */
-HANDLE qemu_thread_get_handle(QemuThread *thread);
+HANDLE qemu_thread_get_handle(struct QemuThread *thread);
=20
 #endif
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index c8f6145257..aea0c44985 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -14,6 +14,7 @@
 #ifndef QEMU_BALLOON_H
 #define QEMU_BALLOON_H
=20
+#include "exec/cpu-common.h"
 #include "qapi/qapi-types-misc.h"
=20
 typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
diff --git a/include/sysemu/cryptodev-vhost-user.h b/include/sysemu/crypt=
odev-vhost-user.h
index 6debf53fc5..2c0a0a1cd8 100644
--- a/include/sysemu/cryptodev-vhost-user.h
+++ b/include/sysemu/cryptodev-vhost-user.h
@@ -23,6 +23,8 @@
 #ifndef CRYPTODEV_VHOST_USER_H
 #define CRYPTODEV_VHOST_USER_H
=20
+#include "sysemu/cryptodev-vhost.h"
+
 #define VHOST_USER_MAX_AUTH_KEY_LEN    512
 #define VHOST_USER_MAX_CIPHER_KEY_LEN  64
=20
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index d275b5a843..dd1722f2df 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -13,6 +13,7 @@
 #ifndef HVF_H
 #define HVF_H
=20
+#include "cpu.h"
 #include "qemu/bitops.h"
 #include "exec/memory.h"
 #include "sysemu/accel.h"
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 5f6240d5cb..6181486401 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -16,6 +16,7 @@
=20
 #include "block/aio.h"
 #include "qemu/thread.h"
+#include "qom/object.h"
=20
 #define TYPE_IOTHREAD "iothread"
=20
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index f838412491..7a1c3cdcb1 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -9,6 +9,8 @@
 #ifndef QEMU_KVM_INT_H
 #define QEMU_KVM_INT_H
=20
+#include "exec/cpu-common.h"
+#include "exec/memory.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/accel.h"
 #include "sysemu/kvm.h"
diff --git a/include/sysemu/memory_mapping.h b/include/sysemu/memory_mapp=
ing.h
index 58452457ce..1b440df486 100644
--- a/include/sysemu/memory_mapping.h
+++ b/include/sysemu/memory_mapping.h
@@ -15,6 +15,8 @@
 #define MEMORY_MAPPING_H
=20
 #include "qemu/queue.h"
+#include "exec/cpu-common.h"
+#include "exec/cpu-defs.h"
 #include "exec/memory.h"
=20
 typedef struct GuestPhysBlock {
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.=
h
index a03e2f1878..c8e7c2f6cf 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -9,6 +9,8 @@
 #ifndef XEN_MAPCACHE_H
 #define XEN_MAPCACHE_H
=20
+#include "exec/cpu-common.h"
+
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
                                          ram_addr_t size);
 #ifdef CONFIG_XEN
diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index d714127799..58bd3a1ec4 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -4,6 +4,9 @@
 #include <epoxy/gl.h>
 #include <epoxy/egl.h>
 #include <gbm.h>
+#include "qapi/qapi-types-ui.h"
+#include "ui/console.h"
+#include "ui/shader.h"
=20
 extern EGLDisplay *qemu_egl_display;
 extern EGLConfig qemu_egl_config;
diff --git a/include/ui/input.h b/include/ui/input.h
index 8c8ccb999f..c86219a1c1 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -2,6 +2,7 @@
 #define INPUT_H
=20
 #include "qapi/qapi-types-ui.h"
+#include "qemu/notify.h"
=20
 #define INPUT_EVENT_MASK_KEY   (1<<INPUT_EVENT_KIND_KEY)
 #define INPUT_EVENT_MASK_BTN   (1<<INPUT_EVENT_KIND_BTN)
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index eed60e4fae..58bb5b4c53 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -18,6 +18,7 @@
 #ifndef UI_SPICE_DISPLAY_H
 #define UI_SPICE_DISPLAY_H
=20
+#include <spice.h>
 #include <spice/ipc_ring.h>
 #include <spice/enums.h>
 #include <spice/qxl_dev.h>
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index aab251bc4b..e9fba96be9 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -22,7 +22,7 @@
=20
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
-
+#include "exec/memory.h"
=20
 /* PA-RISC 1.x processors have a strong memory model.  */
 /* ??? While we do not yet implement PA-RISC 2.0, those processors have
--=20
2.21.0


