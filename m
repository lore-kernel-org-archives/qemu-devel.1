Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61835C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DE620872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DE620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYDf-0006NN-Dd
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53254)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hlYBk-0004yO-Lf
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hlYBb-0001sE-Ni
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hlYBb-0001pT-5P
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:28:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D23BA30821EC;
 Thu, 11 Jul 2019 12:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC8AC5C559;
 Thu, 11 Jul 2019 12:28:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 721A11138661; Thu, 11 Jul 2019 14:28:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 14:28:26 +0200
Message-Id: <20190711122827.18970-3-armbru@redhat.com>
In-Reply-To: <20190711122827.18970-1-armbru@redhat.com>
References: <20190711122827.18970-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 11 Jul 2019 12:28:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC v5 2/3] include: Make headers more
 self-contained
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous commit marked 182 headers FIXME:

      1 FIXME Does not pass make check-headers without CONFIG_CPUID_H, ye=
t!
      2 FIXME Does not pass make check-headers without CONFIG_LINUX, yet!
      2 FIXME Does not pass make check-headers without CONFIG_OPENGL, yet=
!
      1 FIXME Does not pass make check-headers without CONFIG_POSIX, yet!
      1 FIXME Does not pass make check-headers without CONFIG_SPICE, yet!
      2 FIXME Does not pass make check-headers without CONFIG_WIN32, yet!
      7 FIXME Does not pass make check-headers without CONFIG_XEN, yet!
     17 FIXME Does not pass make check-headers without pixman, yet!
      7 FIXME Does not pass make check-headers without system emulation, =
yet!
    150 FIXME Does not pass make check-headers, yet!

As explained in the commit message, the configuration-specific ones
may not actually need fixing.

Clean up the headers some, so that 56 of the 150 blanket FIXMEs go
away, and 76 get replaced by configuration-specific ones, and just 18
blanket FIXMEs remain:

     16 FIXME Does not pass make check-headers for TARGET_BASE_ARCH other=
 than arm, yet!
      1 FIXME Does not pass make check-headers for TARGET_BASE_ARCH other=
 than i386, yet!
      2 FIXME Does not pass make check-headers for TARGET_BASE_ARCH other=
 than mips, yet!
     41 FIXME Does not pass make check-headers for user emulation, yet!
      1 FIXME Does not pass make check-headers without CONFIG_CPUID_H, ye=
t!
      2 FIXME Does not pass make check-headers without CONFIG_LINUX, yet!
      3 FIXME Does not pass make check-headers without CONFIG_OPENGL, yet=
!
      1 FIXME Does not pass make check-headers without CONFIG_POSIX, yet!
      2 FIXME Does not pass make check-headers without CONFIG_SPICE, yet!
      3 FIXME Does not pass make check-headers without CONFIG_WIN32, yet!
      7 FIXME Does not pass make check-headers without CONFIG_XEN, yet!
     17 FIXME Does not pass make check-headers without pixman, yet!
      9 FIXME Does not pass make check-headers without system emulation, =
yet!
     18 FIXME Does not pass make check-headers, yet!

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/block/raw-aio.h               |  3 +--
 include/block/write-threshold.h       |  3 +--
 include/disas/disas.h                 |  3 +--
 include/exec/cputlb.h                 |  4 ++--
 include/exec/exec-all.h               |  2 +-
 include/exec/ioport.h                 |  4 ++--
 include/exec/memory-internal.h        |  4 +++-
 include/exec/ram_addr.h               |  2 +-
 include/exec/softmmu-semi.h           |  3 ++-
 include/exec/tb-hash.h                |  3 ++-
 include/exec/translator.h             |  1 -
 include/exec/user/thunk.h             |  2 +-
 include/fpu/softfloat-macros.h        |  4 +++-
 include/hw/acpi/pci.h                 |  4 ++--
 include/hw/acpi/tco.h                 |  4 ++--
 include/hw/adc/stm32f2xx_adc.h        |  4 ++--
 include/hw/arm/allwinner-a10.h        |  5 ++++-
 include/hw/arm/armsse.h               |  3 ++-
 include/hw/arm/armv7m.h               |  3 ++-
 include/hw/arm/aspeed_soc.h           |  5 ++++-
 include/hw/arm/bcm2836.h              |  5 ++++-
 include/hw/arm/digic.h                |  3 ++-
 include/hw/arm/exynos4210.h           |  4 +---
 include/hw/arm/fsl-imx25.h            |  5 ++++-
 include/hw/arm/fsl-imx31.h            |  5 ++++-
 include/hw/arm/fsl-imx6.h             |  3 ++-
 include/hw/arm/fsl-imx6ul.h           |  3 ++-
 include/hw/arm/fsl-imx7.h             |  3 ++-
 include/hw/arm/msf2-soc.h             |  3 ++-
 include/hw/arm/nrf51_soc.h            |  3 ++-
 include/hw/arm/sharpsl.h              |  4 ++--
 include/hw/arm/stm32f205_soc.h        |  3 ++-
 include/hw/arm/xlnx-zynqmp.h          |  5 ++++-
 include/hw/block/fdc.h                |  4 ++--
 include/hw/block/flash.h              |  3 +--
 include/hw/char/escc.h                |  3 +--
 include/hw/char/xilinx_uartlite.h     |  4 ++--
 include/hw/core/generic-loader.h      |  3 +--
 include/hw/cris/etraxfs.h             |  3 +--
 include/hw/cris/etraxfs_dma.h         |  5 +++--
 include/hw/display/i2c-ddc.h          |  3 +--
 include/hw/empty_slot.h               |  4 ++--
 include/hw/gpio/bcm2835_gpio.h        |  3 +--
 include/hw/i2c/aspeed_i2c.h           |  3 +--
 include/hw/i386/apic_internal.h       |  4 +++-
 include/hw/i386/ioapic_internal.h     |  3 +--
 include/hw/input/hid.h                |  2 --
 include/hw/intc/allwinner-a10-pic.h   |  4 ++--
 include/hw/intc/armv7m_nvic.h         |  3 ++-
 include/hw/intc/heathrow_pic.h        |  4 ++--
 include/hw/intc/mips_gic.h            |  4 +++-
 include/hw/isa/vt82c686.h             |  4 ++--
 include/hw/mips/cps.h                 |  4 +++-
 include/hw/misc/macio/cuda.h          |  4 ++--
 include/hw/misc/macio/gpio.h          |  5 +++--
 include/hw/misc/macio/macio.h         |  4 ++--
 include/hw/misc/macio/pmu.h           |  5 +++--
 include/hw/misc/mips_cmgcr.h          |  4 ++--
 include/hw/misc/mips_cpc.h            |  4 ++--
 include/hw/misc/pvpanic.h             |  4 ++--
 include/hw/net/allwinner_emac.h       |  3 +--
 include/hw/net/lance.h                |  3 +--
 include/hw/nvram/chrp_nvram.h         |  4 ++--
 include/hw/pci-host/sabre.h           |  4 ++--
 include/hw/pci-host/spapr.h           |  2 +-
 include/hw/pci-host/uninorth.h        |  4 +---
 include/hw/pci/pcie_aer.h             |  3 +--
 include/hw/ppc/pnv.h                  |  1 +
 include/hw/ppc/pnv_core.h             |  4 +++-
 include/hw/ppc/ppc4xx.h               |  7 ++++++-
 include/hw/ppc/spapr.h                |  2 +-
 include/hw/ppc/spapr_cpu_core.h       |  2 +-
 include/hw/ppc/spapr_irq.h            |  5 ++++-
 include/hw/ppc/spapr_vio.h            | 11 +++++++----
 include/hw/ppc/spapr_xive.h           |  5 ++++-
 include/hw/ppc/xics_spapr.h           |  2 +-
 include/hw/ppc/xive_regs.h            |  5 +++--
 include/hw/riscv/boot.h               |  4 +++-
 include/hw/riscv/riscv_hart.h         |  6 +++++-
 include/hw/riscv/riscv_htif.h         |  2 +-
 include/hw/riscv/sifive_clint.h       |  4 ++--
 include/hw/riscv/sifive_e.h           |  4 +++-
 include/hw/riscv/sifive_plic.h        |  4 +---
 include/hw/riscv/sifive_prci.h        |  4 ++--
 include/hw/riscv/sifive_test.h        |  4 ++--
 include/hw/riscv/sifive_u.h           |  4 +++-
 include/hw/riscv/sifive_uart.h        |  5 +++--
 include/hw/riscv/spike.h              |  6 +++++-
 include/hw/riscv/virt.h               |  6 +++++-
 include/hw/s390x/3270-ccw.h           |  2 +-
 include/hw/s390x/ap-device.h          |  4 ++--
 include/hw/s390x/css-bridge.h         |  5 ++---
 include/hw/s390x/css.h                |  3 ++-
 include/hw/s390x/s390-ccw.h           |  2 +-
 include/hw/s390x/storage-attributes.h |  2 +-
 include/hw/s390x/tod.h                |  4 +---
 include/hw/s390x/vfio-ccw.h           |  2 +-
 include/hw/semihosting/console.h      |  3 ++-
 include/hw/sh4/sh.h                   |  2 --
 include/hw/sh4/sh_intc.h              |  3 +--
 include/hw/sparc/sparc64.h            |  4 +++-
 include/hw/ssi/aspeed_smc.h           |  3 +--
 include/hw/ssi/xilinx_spips.h         |  3 +--
 include/hw/timer/allwinner-a10-pit.h  |  3 +--
 include/hw/timer/i8254_internal.h     |  3 +--
 include/hw/timer/m48t59.h             |  4 ++--
 include/hw/timer/mc146818rtc.h        |  2 --
 include/hw/timer/mc146818rtc_regs.h   |  4 ++--
 include/hw/timer/sun4v-rtc.h          |  7 ++++++-
 include/hw/timer/xlnx-zynqmp-rtc.h    |  3 +--
 include/hw/virtio/virtio-access.h     |  3 ++-
 include/hw/virtio/virtio-gpu-bswap.h  |  3 +--
 include/hw/virtio/virtio-input.h      |  2 --
 include/hw/virtio/virtio-rng.h        |  3 +--
 include/hw/watchdog/wdt_aspeed.h      |  3 +--
 include/libdecnumber/decNumberLocal.h |  3 +--
 include/migration/cpu.h               |  3 ++-
 include/monitor/hmp-target.h          |  3 ++-
 include/qemu/atomic128.h              |  4 ++--
 include/qemu/ratelimit.h              |  4 ++--
 include/qemu/thread-win32.h           |  4 ++--
 include/sysemu/balloon.h              |  3 +--
 include/sysemu/cryptodev-vhost-user.h |  4 ++--
 include/sysemu/dump.h                 |  3 ++-
 include/sysemu/hvf.h                  |  2 +-
 include/sysemu/iothread.h             |  3 +--
 include/sysemu/kvm_int.h              |  4 ++--
 include/sysemu/memory_mapping.h       |  5 ++++-
 include/sysemu/xen-mapcache.h         |  4 ++--
 include/ui/egl-helpers.h              |  6 +++++-
 include/ui/input.h                    |  3 +--
 include/ui/pixel_ops.h                |  5 ++++-
 include/ui/spice-display.h            |  4 +++-
 target/hppa/cpu.h                     |  2 +-
 tests/check-headers.mak               | 18 ++++++++++++++++++
 135 files changed, 291 insertions(+), 213 deletions(-)

diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 3e7692eb64..4629f24d08 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -13,11 +13,10 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_RAW_AIO_H
 #define QEMU_RAW_AIO_H
=20
+#include "block/aio.h"
 #include "qemu/coroutine.h"
 #include "qemu/iov.h"
=20
diff --git a/include/block/write-threshold.h b/include/block/write-thresh=
old.h
index 7b5adb2e6e..c646f267a4 100644
--- a/include/block/write-threshold.h
+++ b/include/block/write-threshold.h
@@ -10,11 +10,10 @@
  * See the COPYING.LIB file in the top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef BLOCK_WRITE_THRESHOLD_H
 #define BLOCK_WRITE_THRESHOLD_H
=20
+#include "block/block_int.h"
=20
 /*
  * bdrv_write_threshold_set:
diff --git a/include/disas/disas.h b/include/disas/disas.h
index f60bbc752c..ba47e9197c 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -1,8 +1,7 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_DISAS_H
 #define QEMU_DISAS_H
=20
+#include "exec/hwaddr.h"
=20
 #ifdef NEED_CPU_H
 #include "cpu.h"
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 361df6dee0..a62cfb28d5 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -17,11 +17,11 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef CPUTLB_H
 #define CPUTLB_H
=20
+#include "exec/cpu-common.h"
+
 #if !defined(CONFIG_USER_ONLY)
 /* cputlb.c */
 void tlb_protect_code(ram_addr_t ram_addr);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 547f539acc..4b6471014a 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -18,11 +18,11 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
=20
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
=20
+#include "cpu.h"
 #include "exec/tb-context.h"
 #include "sysemu/cpus.h"
=20
diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index 96dc6f5662..97feb296d2 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -21,11 +21,11 @@
  * IO ports API
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index d16ec2d36d..d9d871d827 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -17,11 +17,13 @@
  * internals and the TCG TLB code. Do not include it from elsewhere.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
=20
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
=20
+#include "cpu.h"
+
 #ifndef CONFIG_USER_ONLY
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 507050a2e7..27d567b192 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -17,12 +17,12 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
=20
 #ifndef RAM_ADDR_H
 #define RAM_ADDR_H
=20
 #ifndef CONFIG_USER_ONLY
+#include "cpu.h"
 #include "hw/xen/xen.h"
 #include "sysemu/tcg.h"
 #include "exec/ramlist.h"
diff --git a/include/exec/softmmu-semi.h b/include/exec/softmmu-semi.h
index 551c013652..e00efba166 100644
--- a/include/exec/softmmu-semi.h
+++ b/include/exec/softmmu-semi.h
@@ -8,11 +8,12 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
=20
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
index 79e53fb73d..a26f23d62d 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -18,11 +18,12 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
=20
 #ifndef EXEC_TB_HASH_H
 #define EXEC_TB_HASH_H
=20
+#include "exec/cpu-defs.h"
+#include "exec/exec-all.h"
 #include "qemu/xxhash.h"
=20
 #ifdef CONFIG_SOFTMMU
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 301c740c4e..7f7c4e7d71 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -8,7 +8,6 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
=20
 #ifndef EXEC__TRANSLATOR_H
 #define EXEC__TRANSLATOR_H
diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 933fd77436..4b345ba7ca 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -18,12 +18,12 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
=20
 #ifndef THUNK_H
 #define THUNK_H
=20
 #include "cpu.h"
+#include "exec/user/abitypes.h"
=20
 /* types enums definitions */
=20
diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macro=
s.h
index df33e55c70..11690c3f89 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -79,11 +79,13 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
=20
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
index 45d8a38589..bf2a3ed0ba 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -23,11 +23,11 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_ACPI_PCI_H
 #define HW_ACPI_PCI_H
=20
+#include "hw/acpi/bios-linker-loader.h"
+
 typedef struct AcpiMcfgInfo {
     uint64_t base;
     uint32_t size;
diff --git a/include/hw/acpi/tco.h b/include/hw/acpi/tco.h
index 1f3c2d17fb..726f840cce 100644
--- a/include/hw/acpi/tco.h
+++ b/include/hw/acpi/tco.h
@@ -7,11 +7,11 @@
  * See the COPYING file in the top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index 8e67c0f24d..663b79f4f3 100644
--- a/include/hw/adc/stm32f2xx_adc.h
+++ b/include/hw/adc/stm32f2xx_adc.h
@@ -22,11 +22,11 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index e8b8cc2ceb..91cc544ac3 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -1,4 +1,6 @@
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_ARM_ALLWINNER_A10_H
 #define HW_ARM_ALLWINNER_A10_H
@@ -13,6 +15,7 @@
 #include "hw/ide/ahci.h"
=20
 #include "sysemu/sysemu.h"
+#include "target/arm/cpu.h"
=20
=20
 #define AW_A10_PIC_REG_BASE     0x01c20400
diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 201893ccf5..8ecfbf1a7d 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -87,7 +87,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef ARMSSE_H
 #define ARMSSE_H
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index fdb777d875..dfb87e0546 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -8,7 +8,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_ARM_ARMV7M_H
 #define HW_ARM_ARMV7M_H
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index c502ef0e65..70017e7cb6 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -9,7 +9,9 @@
  * the COPYING file in the top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef ASPEED_SOC_H
 #define ASPEED_SOC_H
@@ -24,6 +26,7 @@
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "hw/net/ftgmac100.h"
+#include "target/arm/cpu.h"
=20
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index aaa12f5cdb..da2a6eac4a 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -8,13 +8,16 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef BCM2836_H
 #define BCM2836_H
=20
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/intc/bcm2836_control.h"
+#include "target/arm/cpu.h"
=20
 #define TYPE_BCM283X "bcm283x"
 #define BCM283X(obj) OBJECT_CHECK(BCM283XState, (obj), TYPE_BCM283X)
diff --git a/include/hw/arm/digic.h b/include/hw/arm/digic.h
index 79f9278c64..7cbf6ad0cb 100644
--- a/include/hw/arm/digic.h
+++ b/include/hw/arm/digic.h
@@ -16,7 +16,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_ARM_DIGIC_H
 #define HW_ARM_DIGIC_H
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index 0d0898e613..f0f23b0e9b 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -21,12 +21,10 @@
  *  with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef EXYNOS4210_H
 #define EXYNOS4210_H
=20
-#include "exec/memory.h"
+#include "hw/sysbus.h"
 #include "target/arm/cpu-qom.h"
=20
 #define EXYNOS4210_NCPUS                    2
diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 61028eaa99..69732692cf 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -14,7 +14,9 @@
  * for more details.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef FSL_IMX25_H
 #define FSL_IMX25_H
@@ -29,6 +31,7 @@
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
 #include "exec/memory.h"
+#include "target/arm/cpu.h"
=20
 #define TYPE_FSL_IMX25 "fsl,imx25"
 #define FSL_IMX25(obj) OBJECT_CHECK(FslIMX25State, (obj), TYPE_FSL_IMX25=
)
diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index bff92e79c0..b844812eb9 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -14,7 +14,9 @@
  * for more details.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef FSL_IMX31_H
 #define FSL_IMX31_H
@@ -28,6 +30,7 @@
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
 #include "exec/memory.h"
+#include "target/arm/cpu.h"
=20
 #define TYPE_FSL_IMX31 "fsl,imx31"
 #define FSL_IMX31(obj) OBJECT_CHECK(FslIMX31State, (obj), TYPE_FSL_IMX31=
)
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 230d44c793..133d4e3e67 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -15,7 +15,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef FSL_IMX6_H
 #define FSL_IMX6_H
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 25e8540908..20ffb44ab6 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -15,7 +15,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef FSL_IMX6UL_H
 #define FSL_IMX6UL_H
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index e32873ca73..f1df5e3608 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -17,7 +17,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef FSL_IMX7_H
 #define FSL_IMX7_H
diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
index 3a209e48b8..d2d81364da 100644
--- a/include/hw/arm/msf2-soc.h
+++ b/include/hw/arm/msf2-soc.h
@@ -23,7 +23,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_ARM_MSF2_SOC_H
 #define HW_ARM_MSF2_SOC_H
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index b5a3da0bdc..8fef32792b 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -8,7 +8,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef NRF51_SOC_H
 #define NRF51_SOC_H
diff --git a/include/hw/arm/sharpsl.h b/include/hw/arm/sharpsl.h
index dc456653e1..89e168fbff 100644
--- a/include/hw/arm/sharpsl.h
+++ b/include/hw/arm/sharpsl.h
@@ -4,11 +4,11 @@
  * This file is licensed under the GNU GPL.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_SHARPSL_H
 #define QEMU_SHARPSL_H
=20
+#include "exec/hwaddr.h"
+
 #define zaurus_printf(format, ...)	\
     fprintf(stderr, "%s: " format, __func__, ##__VA_ARGS__)
=20
diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_so=
c.h
index 4558c64823..7842fe616b 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -23,7 +23,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_ARM_STM32F205_SOC_H
 #define HW_ARM_STM32F205_SOC_H
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 8c4a3a2815..0d2b8f20a0 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -15,7 +15,9 @@
  * for more details.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef XLNX_ZYNQMP_H
 #define XLNX_ZYNQMP_H
@@ -34,6 +36,7 @@
 #include "hw/intc/xlnx-zynqmp-ipi.h"
 #include "hw/timer/xlnx-zynqmp-rtc.h"
 #include "hw/cpu/cluster.h"
+#include "target/arm/cpu.h"
=20
 #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
 #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index d43a2fbd66..f4fe2f471b 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -1,8 +1,8 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_FDC_H
 #define HW_FDC_H
=20
+#include "exec/hwaddr.h"
+#include "hw/irq.h"
 #include "qapi/qapi-types-block.h"
=20
 /* fdc.c */
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 15ce2b3f14..83a75f3170 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -1,11 +1,10 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_FLASH_H
 #define HW_FLASH_H
=20
 /* NOR flash devices */
=20
 #include "exec/memory.h"
+#include "migration/vmstate.h"
=20
 /* pflash_cfi01.c */
=20
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 71b95dd152..d5196c53e6 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -1,10 +1,9 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_ESCC_H
 #define HW_ESCC_H
=20
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
+#include "hw/sysbus.h"
 #include "ui/input.h"
=20
 /* escc.c */
diff --git a/include/hw/char/xilinx_uartlite.h b/include/hw/char/xilinx_u=
artlite.h
index a003b5977f..99d8bbf405 100644
--- a/include/hw/char/xilinx_uartlite.h
+++ b/include/hw/char/xilinx_uartlite.h
@@ -12,11 +12,11 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index 3827144a5f..9ffce1c5a3 100644
--- a/include/hw/core/generic-loader.h
+++ b/include/hw/core/generic-loader.h
@@ -15,12 +15,11 @@
  * for more details.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef GENERIC_LOADER_H
 #define GENERIC_LOADER_H
=20
 #include "elf.h"
+#include "hw/qdev-core.h"
=20
 typedef struct GenericLoaderState {
     /* <private> */
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 108692bac3..494222d315 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -22,13 +22,12 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_ETRAXFS_H
 #define HW_ETRAXFS_H
=20
 #include "net/net.h"
 #include "hw/cris/etraxfs_dma.h"
+#include "hw/sysbus.h"
=20
 /* Instantiate an ETRAXFS Ethernet MAC.  */
 static inline DeviceState *
diff --git a/include/hw/cris/etraxfs_dma.h b/include/hw/cris/etraxfs_dma.=
h
index a1c6ce44ba..31ae360611 100644
--- a/include/hw/cris/etraxfs_dma.h
+++ b/include/hw/cris/etraxfs_dma.h
@@ -1,8 +1,9 @@
-/* FIXME Does not pass make check-headers, yet! */
-
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
index 814be09922..1cf53a0c8d 100644
--- a/include/hw/display/i2c-ddc.h
+++ b/include/hw/display/i2c-ddc.h
@@ -16,12 +16,11 @@
  *  with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef I2C_DDC_H
 #define I2C_DDC_H
=20
 #include "hw/display/edid.h"
+#include "hw/i2c/i2c.h"
=20
 /* A simple I2C slave which just returns the contents of its EDID blob. =
*/
 struct I2CDDCState {
diff --git a/include/hw/empty_slot.h b/include/hw/empty_slot.h
index 249092a1cd..cb9a221aa6 100644
--- a/include/hw/empty_slot.h
+++ b/include/hw/empty_slot.h
@@ -1,8 +1,8 @@
-/* FIXME Does not pass make check-headers, yet! */
-
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
index c24106aba5..b0de0a3c74 100644
--- a/include/hw/gpio/bcm2835_gpio.h
+++ b/include/hw/gpio/bcm2835_gpio.h
@@ -11,12 +11,11 @@
  * See the COPYING file in the top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef BCM2835_GPIO_H
 #define BCM2835_GPIO_H
=20
 #include "hw/sd/sd.h"
+#include "hw/sysbus.h"
=20
 typedef struct BCM2835GpioState {
     SysBusDevice parent_obj;
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index ee215ff26e..a2753f0bbb 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -18,12 +18,11 @@
  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef ASPEED_I2C_H
 #define ASPEED_I2C_H
=20
 #include "hw/i2c/i2c.h"
+#include "hw/sysbus.h"
=20
 #define TYPE_ASPEED_I2C "aspeed.i2c"
 #define ASPEED_I2C(obj) \
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_inter=
nal.h
index ec00577253..1dbee70cfd 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -19,7 +19,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n i386, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef QEMU_APIC_INTERNAL_H
 #define QEMU_APIC_INTERNAL_H
@@ -27,6 +28,7 @@
 #include "cpu.h"
 #include "exec/memory.h"
 #include "qemu/timer.h"
+#include "target/i386/cpu-qom.h"
=20
 /* APIC Local Vector Table */
 #define APIC_LVT_TIMER                  0
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_i=
nternal.h
index 9a9cd96788..3d2eec2aa7 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -19,13 +19,12 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_IOAPIC_INTERNAL_H
 #define QEMU_IOAPIC_INTERNAL_H
=20
 #include "hw/hw.h"
 #include "exec/memory.h"
+#include "hw/i386/ioapic.h"
 #include "hw/sysbus.h"
 #include "qemu/notify.h"
=20
diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
index aec04352e0..2127c7ce45 100644
--- a/include/hw/input/hid.h
+++ b/include/hw/input/hid.h
@@ -1,5 +1,3 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_HID_H
 #define QEMU_HID_H
=20
diff --git a/include/hw/intc/allwinner-a10-pic.h b/include/hw/intc/allwin=
ner-a10-pic.h
index 897d5ad6cc..a5895401d1 100644
--- a/include/hw/intc/allwinner-a10-pic.h
+++ b/include/hw/intc/allwinner-a10-pic.h
@@ -1,8 +1,8 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef ALLWINNER_A10_PIC_H
 #define ALLWINNER_A10_PIC_H
=20
+#include "hw/sysbus.h"
+
 #define TYPE_AW_A10_PIC  "allwinner-a10-pic"
 #define AW_A10_PIC(obj) OBJECT_CHECK(AwA10PICState, (obj), TYPE_AW_A10_P=
IC)
=20
diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.=
h
index 5bcb946035..7dd0a14830 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -8,7 +8,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n arm, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_ARM_ARMV7M_NVIC_H
 #define HW_ARM_ARMV7M_NVIC_H
diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pi=
c.h
index 9724912d59..b163e27ab9 100644
--- a/include/hw/intc/heathrow_pic.h
+++ b/include/hw/intc/heathrow_pic.h
@@ -23,11 +23,11 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_INTC_HEATHROW_PIC_H
 #define HW_INTC_HEATHROW_PIC_H
=20
+#include "hw/sysbus.h"
+
 #define TYPE_HEATHROW "heathrow"
 #define HEATHROW(obj) OBJECT_CHECK(HeathrowState, (obj), TYPE_HEATHROW)
=20
diff --git a/include/hw/intc/mips_gic.h b/include/hw/intc/mips_gic.h
index 870daa94c1..9a2185bf9b 100644
--- a/include/hw/intc/mips_gic.h
+++ b/include/hw/intc/mips_gic.h
@@ -9,13 +9,15 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n mips, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef MIPS_GIC_H
 #define MIPS_GIC_H
=20
 #include "qemu/units.h"
 #include "hw/timer/mips_gictimer.h"
+#include "hw/sysbus.h"
 #include "cpu.h"
 /*
  * GIC Specific definitions
diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index 49b3a96e4a..a54c3fe60a 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -1,8 +1,8 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_VT82C686_H
 #define HW_VT82C686_H
=20
+#include "hw/irq.h"
+
 #define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
=20
 /* vt82c686.c */
diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index af8d25e142..52cd4bed93 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -18,7 +18,8 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for TARGET_BASE_ARCH other tha=
n mips, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef MIPS_CPS_H
 #define MIPS_CPS_H
@@ -28,6 +29,7 @@
 #include "hw/intc/mips_gic.h"
 #include "hw/misc/mips_cpc.h"
 #include "hw/misc/mips_itu.h"
+#include "target/mips/cpu.h"
=20
 #define TYPE_MIPS_CPS "mips-cps"
 #define MIPS_CPS(obj) OBJECT_CHECK(MIPSCPSState, (obj), TYPE_MIPS_CPS)
diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
index 562927e1da..5768075ac5 100644
--- a/include/hw/misc/macio/cuda.h
+++ b/include/hw/misc/macio/cuda.h
@@ -23,11 +23,11 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef CUDA_H
 #define CUDA_H
=20
+#include "hw/misc/mos6522.h"
+
 /* CUDA commands (2nd byte) */
 #define CUDA_WARM_START                0x0
 #define CUDA_AUTOPOLL                  0x1
diff --git a/include/hw/misc/macio/gpio.h b/include/hw/misc/macio/gpio.h
index c5231896ce..24a4364b39 100644
--- a/include/hw/misc/macio/gpio.h
+++ b/include/hw/misc/macio/gpio.h
@@ -23,11 +23,12 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index f19f756f38..070a694eb5 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -23,16 +23,16 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef MACIO_H
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
index 0ab3c06a7e..7ef83dee4c 100644
--- a/include/hw/misc/macio/pmu.h
+++ b/include/hw/misc/macio/pmu.h
@@ -7,11 +7,12 @@
  * Copyright (C) 2016 Ben Herrenschmidt
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index 70b95ab163..3e6e223273 100644
--- a/include/hw/misc/mips_cmgcr.h
+++ b/include/hw/misc/mips_cmgcr.h
@@ -7,11 +7,11 @@
  *
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef MIPS_CMGCR_H
 #define MIPS_CMGCR_H
=20
+#include "hw/sysbus.h"
+
 #define TYPE_MIPS_GCR "mips-gcr"
 #define MIPS_GCR(obj) OBJECT_CHECK(MIPSGCRState, (obj), TYPE_MIPS_GCR)
=20
diff --git a/include/hw/misc/mips_cpc.h b/include/hw/misc/mips_cpc.h
index 86d2705526..3f670578b0 100644
--- a/include/hw/misc/mips_cpc.h
+++ b/include/hw/misc/mips_cpc.h
@@ -17,11 +17,11 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef MIPS_CPC_H
 #define MIPS_CPC_H
=20
+#include "hw/sysbus.h"
+
 #define CPC_ADDRSPACE_SZ    0x6000
=20
 /* CPC blocks offsets relative to base address */
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 65c67e31f4..ae0c8188ce 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -12,11 +12,11 @@
  *
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index 9389cb82c6..5013207d15 100644
--- a/include/hw/net/allwinner_emac.h
+++ b/include/hw/net/allwinner_emac.h
@@ -20,8 +20,6 @@
  *
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef ALLWINNER_EMAC_H
 #define ALLWINNER_EMAC_H
=20
@@ -29,6 +27,7 @@
 #include "net/net.h"
 #include "qemu/fifo8.h"
 #include "hw/net/mii.h"
+#include "hw/sysbus.h"
=20
 #define TYPE_AW_EMAC "allwinner-emac"
 #define AW_EMAC(obj) OBJECT_CHECK(AwEmacState, (obj), TYPE_AW_EMAC)
diff --git a/include/hw/net/lance.h b/include/hw/net/lance.h
index 2b99153bbc..0357f5f65c 100644
--- a/include/hw/net/lance.h
+++ b/include/hw/net/lance.h
@@ -26,13 +26,12 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef LANCE_H
 #define LANCE_H
=20
 #include "net/net.h"
 #include "hw/net/pcnet.h"
+#include "hw/sysbus.h"
=20
 #define TYPE_LANCE "lance"
 #define SYSBUS_PCNET(obj) \
diff --git a/include/hw/nvram/chrp_nvram.h b/include/hw/nvram/chrp_nvram.=
h
index ae99396eab..09941a9be4 100644
--- a/include/hw/nvram/chrp_nvram.h
+++ b/include/hw/nvram/chrp_nvram.h
@@ -15,11 +15,11 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef CHRP_NVRAM_H
 #define CHRP_NVRAM_H
=20
+#include "qemu/bswap.h"
+
 /* OpenBIOS NVRAM partition */
 typedef struct {
     uint8_t signature;
diff --git a/include/hw/pci-host/sabre.h b/include/hw/pci-host/sabre.h
index 003bd17842..99b5aefbec 100644
--- a/include/hw/pci-host/sabre.h
+++ b/include/hw/pci-host/sabre.h
@@ -1,8 +1,8 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_PCI_HOST_SABRE_H
 #define HW_PCI_HOST_SABRE_H
=20
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
 #include "hw/sparc/sun4u_iommu.h"
=20
 #define MAX_IVEC 0x40
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 9d2e3e313c..0f75b03924 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -18,7 +18,7 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef PCI_HOST_SPAPR_H
 #define PCI_HOST_SPAPR_H
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninort=
h.h
index b541fbc12d..9a5cabd4c5 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -22,13 +22,11 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef UNINORTH_H
 #define UNINORTH_H
=20
 #include "hw/hw.h"
-
+#include "hw/pci/pci_host.h"
 #include "hw/ppc/openpic.h"
=20
 /* UniNorth version */
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index a2e8bc77a7..502dcd7eba 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -18,12 +18,11 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_PCIE_AER_H
 #define QEMU_PCIE_AER_H
=20
 #include "hw/hw.h"
+#include "hw/pci/pci_regs.h"
=20
 /* definitions which PCIExpressDevice uses */
=20
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 3435ac4d13..0bc9c26bda 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+/* NOTE: May only be included into target-dependent code */
 /* FIXME Does not pass make check-headers, yet! */
=20
 #ifndef PPC_PNV_H
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 403b9f1e49..cf597f45f4 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -17,12 +17,14 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef PPC_PNV_CORE_H
 #define PPC_PNV_CORE_H
=20
 #include "hw/cpu/core.h"
+#include "target/ppc/cpu.h"
=20
 #define TYPE_PNV_CORE "powernv-cpu-core"
 #define PNV_CORE(obj) \
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 2732200997..757ff6bee1 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -22,11 +22,16 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
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
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c7a31e43ea..1f63ad2e59 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -1,5 +1,5 @@
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_SPAPR_H
 #define HW_SPAPR_H
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index 980d9ded69..372ed69440 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -8,7 +8,7 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_SPAPR_CPU_CORE_H
 #define HW_SPAPR_CPU_CORE_H
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 9d9ef40388..f541b80fb0 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -7,11 +7,14 @@
  * COPYING file in the top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
=20
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
index 50cf292803..6f81b37901 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -1,8 +1,11 @@
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_SPAPR_VIO_H
 #define HW_SPAPR_VIO_H
=20
+#include "hw/ppc/spapr.h"
+
 /*
  * QEMU sPAPR VIO bus definitions
  *
@@ -39,6 +42,9 @@
=20
 #define TYPE_SPAPR_VIO_BRIDGE "spapr-vio-bridge"
=20
+typedef struct SpaprVioDevice SpaprVioDevice;
+typedef struct SpaprVioBus SpaprVioBus;
+
 typedef struct SpaprVioCrq {
     uint64_t qladdr;
     uint32_t qsize;
@@ -46,9 +52,6 @@ typedef struct SpaprVioCrq {
     int(*SendFunc)(struct SpaprVioDevice *vdev, uint8_t *crq);
 } SpaprVioCrq;
=20
-typedef struct SpaprVioDevice SpaprVioDevice;
-typedef struct SpaprVioBus SpaprVioBus;
-
 typedef struct SpaprVioDeviceClass {
     DeviceClass parent_class;
=20
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 45a06cf4aa..aba36eefbd 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -7,12 +7,15 @@
  * COPYING file in the top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef PPC_SPAPR_XIVE_H
 #define PPC_SPAPR_XIVE_H
=20
+#include "hw/ppc/spapr_irq.h"
 #include "hw/ppc/xive.h"
+#include "sysemu/sysemu.h"
=20
 #define TYPE_SPAPR_XIVE "spapr-xive"
 #define SPAPR_XIVE(obj) OBJECT_CHECK(SpaprXive, (obj), TYPE_SPAPR_XIVE)
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 5372a160ab..fbc2d52174 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -25,7 +25,7 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef XICS_SPAPR_H
 #define XICS_SPAPR_H
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 4a6ed49215..b0c68ab5f7 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -13,11 +13,12 @@
  * COPYING file in the top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index 01c67335b1..84dcb239fd 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -17,11 +17,13 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
=20
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
index 846a22c17d..d1ad1dade4 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -18,11 +18,15 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_RISCV_HART_H
 #define HW_RISCV_HART_H
=20
+#include "hw/sysbus.h"
+#include "target/riscv/cpu.h"
+
 #define TYPE_RISCV_HART_ARRAY "riscv.hart_array"
=20
 #define RISCV_HART_ARRAY(obj) \
diff --git a/include/hw/riscv/riscv_htif.h b/include/hw/riscv/riscv_htif.=
h
index df385dacf4..44f90d5eca 100644
--- a/include/hw/riscv/riscv_htif.h
+++ b/include/hw/riscv/riscv_htif.h
@@ -18,7 +18,7 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_RISCV_HTIF_H
 #define HW_RISCV_HTIF_H
diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_cl=
int.h
index dd9999333f..ae8286c884 100644
--- a/include/hw/riscv/sifive_clint.h
+++ b/include/hw/riscv/sifive_clint.h
@@ -17,11 +17,11 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_SIFIVE_CLINT_H
 #define HW_SIFIVE_CLINT_H
=20
+#include "hw/sysbus.h"
+
 #define TYPE_SIFIVE_CLINT "riscv.sifive.clint"
=20
 #define SIFIVE_CLINT(obj) \
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index a799718f2a..ce7083f4c1 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -16,11 +16,13 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_SIFIVE_E_H
 #define HW_SIFIVE_E_H
=20
+#include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_gpio.h"
=20
 #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_pli=
c.h
index c292e578c6..b0edba2884 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -18,12 +18,10 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index 1fc80724c2..8b7de134f8 100644
--- a/include/hw/riscv/sifive_prci.h
+++ b/include/hw/riscv/sifive_prci.h
@@ -16,11 +16,11 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index ca775d8e68..3a603a6ead 100644
--- a/include/hw/riscv/sifive_test.h
+++ b/include/hw/riscv/sifive_test.h
@@ -16,11 +16,11 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_SIFIVE_TEST_H
 #define HW_SIFIVE_TEST_H
=20
+#include "hw/sysbus.h"
+
 #define TYPE_SIFIVE_TEST "riscv.sifive.test"
=20
 #define SIFIVE_TEST(obj) \
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 74d8fbbf57..0f361a827a 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -16,12 +16,14 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_SIFIVE_U_H
 #define HW_SIFIVE_U_H
=20
 #include "hw/net/cadence_gem.h"
+#include "hw/riscv/riscv_hart.h"
=20
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
 #define RISCV_U_SOC(obj) \
diff --git a/include/hw/riscv/sifive_uart.h b/include/hw/riscv/sifive_uar=
t.h
index 62f36ec2d1..65668825a3 100644
--- a/include/hw/riscv/sifive_uart.h
+++ b/include/hw/riscv/sifive_uart.h
@@ -17,11 +17,12 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index f259d2558b..835b94162e 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -16,11 +16,15 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
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
index d6f34cd19f..ac693a33f8 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -16,11 +16,15 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_RISCV_VIRT_H
 #define HW_RISCV_VIRT_H
=20
+#include "hw/riscv/riscv_hart.h"
+#include "hw/sysbus.h"
+
 typedef struct {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/include/hw/s390x/3270-ccw.h b/include/hw/s390x/3270-ccw.h
index bc24e78ec6..4921e44654 100644
--- a/include/hw/s390x/3270-ccw.h
+++ b/include/hw/s390x/3270-ccw.h
@@ -11,7 +11,7 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_S390X_3270_CCW_H
 #define HW_S390X_3270_CCW_H
diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
index 2f3488115e..8df9cd2954 100644
--- a/include/hw/s390x/ap-device.h
+++ b/include/hw/s390x/ap-device.h
@@ -8,11 +8,11 @@
  * directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index 1f5efeb203..f7ed2d9a03 100644
--- a/include/hw/s390x/css-bridge.h
+++ b/include/hw/s390x/css-bridge.h
@@ -10,12 +10,11 @@
  * directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index 3d55971ef5..49433718a4 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -10,7 +10,7 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef CSS_H
 #define CSS_H
@@ -20,6 +20,7 @@
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
 #include "sysemu/kvm.h"
+#include "target/s390x/cpu-qom.h"
=20
 /* Channel subsystem constants. */
 #define MAX_DEVNO 65535
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 91c1a8d21f..a940eeb469 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -11,7 +11,7 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_S390_CCW_H
 #define HW_S390_CCW_H
diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/sto=
rage-attributes.h
index 5bc4715c6b..d859bd5ff0 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -10,7 +10,7 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef S390_STORAGE_ATTRIBUTES_H
 #define S390_STORAGE_ATTRIBUTES_H
diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index 0ad708998b..d71f4ea8a7 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -8,13 +8,11 @@
  * See the COPYING file in the top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_S390_TOD_H
 #define HW_S390_TOD_H
=20
 #include "hw/qdev.h"
-#include "s390-tod.h"
+#include "target/s390x/s390-tod.h"
=20
 typedef struct S390TOD {
     uint8_t high;
diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
index c35e86f9e8..e0db828023 100644
--- a/include/hw/s390x/vfio-ccw.h
+++ b/include/hw/s390x/vfio-ccw.h
@@ -12,7 +12,7 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef HW_VFIO_CCW_H
 #define HW_VFIO_CCW_H
diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/co=
nsole.h
index 03e6bdb985..0649bc60c7 100644
--- a/include/hw/semihosting/console.h
+++ b/include/hw/semihosting/console.h
@@ -7,11 +7,12 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
=20
 #ifndef SEMIHOST_CONSOLE_H
 #define SEMIHOST_CONSOLE_H
=20
+#include "cpu.h"
+
 /**
  * qemu_semihosting_console_outs:
  * @env: CPUArchState
diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index 1884271351..767a2df7e2 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -1,5 +1,3 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_SH_H
 #define QEMU_SH_H
 /* Definitions for SH board emulation.  */
diff --git a/include/hw/sh4/sh_intc.h b/include/hw/sh4/sh_intc.h
index ed56215736..3d3efde059 100644
--- a/include/hw/sh4/sh_intc.h
+++ b/include/hw/sh4/sh_intc.h
@@ -1,8 +1,7 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef SH_INTC_H
 #define SH_INTC_H
=20
+#include "exec/memory.h"
 #include "hw/irq.h"
=20
 typedef unsigned char intc_enum;
diff --git a/include/hw/sparc/sparc64.h b/include/hw/sparc/sparc64.h
index 81b9c8a675..c778453b6d 100644
--- a/include/hw/sparc/sparc64.h
+++ b/include/hw/sparc/sparc64.h
@@ -1,8 +1,10 @@
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
=20
 #ifndef HW_SPARC_SPARC64_H
 #define HW_SPARC_SPARC64_H
=20
+#include "target/sparc/cpu-qom.h"
+
 #define IVEC_MAX             0x40
=20
 SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr);
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 06b50143c3..aa07dac4fe 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -22,12 +22,11 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef ASPEED_SMC_H
 #define ASPEED_SMC_H
=20
 #include "hw/ssi/ssi.h"
+#include "hw/sysbus.h"
=20
 typedef struct AspeedSegments {
     hwaddr addr;
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.=
h
index 7929546ad7..6a39b55a7b 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -22,14 +22,13 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef XILINX_SPIPS_H
 #define XILINX_SPIPS_H
=20
 #include "hw/ssi/ssi.h"
 #include "qemu/fifo32.h"
 #include "hw/stream.h"
+#include "hw/sysbus.h"
=20
 typedef struct XilinxSPIPS XilinxSPIPS;
=20
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allw=
inner-a10-pit.h
index 16cfc0d62d..871c95b512 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -1,9 +1,8 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef ALLWINNER_A10_PIT_H
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
index 8d0e0ed17f..e611c6f227 100644
--- a/include/hw/timer/i8254_internal.h
+++ b/include/hw/timer/i8254_internal.h
@@ -22,13 +22,12 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_I8254_INTERNAL_H
 #define QEMU_I8254_INTERNAL_H
=20
 #include "hw/hw.h"
 #include "hw/isa/isa.h"
+#include "hw/timer/i8254.h"
 #include "qemu/timer.h"
=20
 typedef struct PITChannelState {
diff --git a/include/hw/timer/m48t59.h b/include/hw/timer/m48t59.h
index 97c2471f2c..d3fb50e08c 100644
--- a/include/hw/timer/m48t59.h
+++ b/include/hw/timer/m48t59.h
@@ -1,8 +1,8 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_M48T59_H
 #define HW_M48T59_H
=20
+#include "exec/hwaddr.h"
+#include "hw/irq.h"
 #include "qom/object.h"
=20
 #define TYPE_NVRAM "nvram"
diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rt=
c.h
index a781ff1fb3..fe6ed63f71 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/timer/mc146818rtc.h
@@ -1,5 +1,3 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef MC146818RTC_H
 #define MC146818RTC_H
=20
diff --git a/include/hw/timer/mc146818rtc_regs.h b/include/hw/timer/mc146=
818rtc_regs.h
index 0b38971417..bfbb57e570 100644
--- a/include/hw/timer/mc146818rtc_regs.h
+++ b/include/hw/timer/mc146818rtc_regs.h
@@ -22,11 +22,11 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef MC146818RTC_REGS_H
 #define MC146818RTC_REGS_H
=20
+#include "qemu/timer.h"
+
 #define RTC_ISA_IRQ 8
=20
 #define RTC_SECONDS             0
diff --git a/include/hw/timer/sun4v-rtc.h b/include/hw/timer/sun4v-rtc.h
index 11ced390a3..4db0352e2b 100644
--- a/include/hw/timer/sun4v-rtc.h
+++ b/include/hw/timer/sun4v-rtc.h
@@ -1,3 +1,8 @@
-/* FIXME Does not pass make check-headers, yet! */
+#ifndef HW_TIMER_SUN4V_RTC_H
+#define HW_TIMER_SUN4V_RTC_H
+
+#include "exec/hwaddr.h"
=20
 void sun4v_rtc_init(hwaddr addr);
+
+#endif
diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-z=
ynqmp-rtc.h
index 23f37fe21a..97e32322ed 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/timer/xlnx-zynqmp-rtc.h
@@ -24,12 +24,11 @@
  * THE SOFTWARE.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_TIMER_XLNX_ZYNQMP_RTC_H
 #define HW_TIMER_XLNX_ZYNQMP_RTC_H
=20
 #include "hw/register.h"
+#include "hw/sysbus.h"
=20
 #define TYPE_XLNX_ZYNQMP_RTC "xlnx-zynmp.rtc"
=20
diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio=
-access.h
index 9a155f4c69..eaaf4dd033 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -14,11 +14,12 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef QEMU_VIRTIO_ACCESS_H
 #define QEMU_VIRTIO_ACCESS_H
=20
+#include "exec/hwaddr.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
=20
diff --git a/include/hw/virtio/virtio-gpu-bswap.h b/include/hw/virtio/vir=
tio-gpu-bswap.h
index b3c749ebf2..203f9e1718 100644
--- a/include/hw/virtio/virtio-gpu-bswap.h
+++ b/include/hw/virtio/virtio-gpu-bswap.h
@@ -11,12 +11,11 @@
  * See the COPYING file in the top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef HW_VIRTIO_GPU_BSWAP_H
 #define HW_VIRTIO_GPU_BSWAP_H
=20
 #include "qemu/bswap.h"
+#include "standard-headers/linux/virtio_gpu.h"
=20
 static inline void
 virtio_gpu_ctrl_hdr_bswap(struct virtio_gpu_ctrl_hdr *hdr)
diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-=
input.h
index 0727d5449b..4fca03e796 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -1,5 +1,3 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_VIRTIO_INPUT_H
 #define QEMU_VIRTIO_INPUT_H
=20
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rn=
g.h
index ee650297c2..ff699335e3 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -9,11 +9,10 @@
  * top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_VIRTIO_RNG_H
 #define QEMU_VIRTIO_RNG_H
=20
+#include "hw/virtio/virtio.h"
 #include "sysemu/rng.h"
 #include "sysemu/rng-random.h"
 #include "standard-headers/linux/virtio_rng.h"
diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_a=
speed.h
index 39e5689165..8c5691ce20 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -7,11 +7,10 @@
  * COPYING file in the top-level directory.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef WDT_ASPEED_H
 #define WDT_ASPEED_H
=20
+#include "hw/misc/aspeed_scu.h"
 #include "hw/sysbus.h"
=20
 #define TYPE_ASPEED_WDT "aspeed.wdt"
diff --git a/include/libdecnumber/decNumberLocal.h b/include/libdecnumber=
/decNumberLocal.h
index 01ba6c7aea..4d53c077f2 100644
--- a/include/libdecnumber/decNumberLocal.h
+++ b/include/libdecnumber/decNumberLocal.h
@@ -37,8 +37,6 @@
 /* decNumber.h or one of decDouble (etc.) must be included first.     */
 /* ------------------------------------------------------------------ */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef DECNUMBERLOCAL_H
 #define DECNUMBERLOCAL_H
=20
@@ -46,6 +44,7 @@
   #define DECNLAUTHOR	"Mike Cowlishaw"	      /* Who to blame */
=20
   #include "libdecnumber/dconfig.h"
+  #include "libdecnumber/decContext.h"
=20
   /* Conditional code flag -- set this to match hardware platform     */
   /* 1=3Dlittle-endian, 0=3Dbig-endian	                              */
diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index 4c8dde2e95..37c04fe9e7 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -1,11 +1,12 @@
 /* Declarations for use for CPU state serialization.  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
=20
 #ifndef MIGRATION_CPU_H
 #define MIGRATION_CPU_H
=20
+#include "exec/cpu-defs.h"
+
 #if TARGET_LONG_BITS =3D=3D 64
 #define qemu_put_betl qemu_put_be64
 #define qemu_get_betl qemu_get_be64
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index c022fd3b39..8d4a172efa 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -23,11 +23,12 @@
  */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
=20
 #ifndef MONITOR_HMP_TARGET_H
 #define MONITOR_HMP_TARGET_H
=20
+#include "cpu.h"
+
 #define MD_TLONG 0
 #define MD_I32   1
=20
diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index 8dcf19482d..6b34484e15 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -10,11 +10,11 @@
  * atomic primitive is meant to provide.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_ATOMIC128_H
 #define QEMU_ATOMIC128_H
=20
+#include "qemu/int128.h"
+
 /*
  * GCC is a house divided about supporting large atomic operations.
  *
diff --git a/include/qemu/ratelimit.h b/include/qemu/ratelimit.h
index efd6074823..01da8d63f1 100644
--- a/include/qemu/ratelimit.h
+++ b/include/qemu/ratelimit.h
@@ -11,11 +11,11 @@
  *
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_RATELIMIT_H
 #define QEMU_RATELIMIT_H
=20
+#include "qemu/timer.h"
+
 typedef struct {
     int64_t slice_start_time;
     int64_t slice_end_time;
diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index e09a7ba397..94e7579b4e 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -1,4 +1,4 @@
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers without CONFIG_WIN32, yet! */
=20
 #ifndef QEMU_THREAD_WIN32_H
 #define QEMU_THREAD_WIN32_H
@@ -49,6 +49,6 @@ struct QemuThread {
 };
=20
 /* Only valid for joinable threads.  */
-HANDLE qemu_thread_get_handle(QemuThread *thread);
+HANDLE qemu_thread_get_handle(struct QemuThread *thread);
=20
 #endif
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index ec77a48925..aea0c44985 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -11,11 +11,10 @@
  *
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef QEMU_BALLOON_H
 #define QEMU_BALLOON_H
=20
+#include "exec/cpu-common.h"
 #include "qapi/qapi-types-misc.h"
=20
 typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
diff --git a/include/sysemu/cryptodev-vhost-user.h b/include/sysemu/crypt=
odev-vhost-user.h
index d2bbd854c4..0d3421e7e8 100644
--- a/include/sysemu/cryptodev-vhost-user.h
+++ b/include/sysemu/cryptodev-vhost-user.h
@@ -21,11 +21,11 @@
  *
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef CRYPTODEV_VHOST_USER_H
 #define CRYPTODEV_VHOST_USER_H
=20
+#include "sysemu/cryptodev-vhost.h"
+
 #define VHOST_USER_MAX_AUTH_KEY_LEN    512
 #define VHOST_USER_MAX_CIPHER_KEY_LEN  64
=20
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index c5efa8b2f2..82be70d46a 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -11,7 +11,8 @@
  *
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef DUMP_H
 #define DUMP_H
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 2df17c4ed3..25b1e58cf4 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -11,11 +11,11 @@
 /* header to be included in non-HVF-specific code */
=20
 /* NOTE: May only be included into target-dependent code */
-/* FIXME Does not pass make check-headers, yet! */
=20
 #ifndef HVF_H
 #define HVF_H
=20
+#include "cpu.h"
 #include "qemu/bitops.h"
 #include "exec/memory.h"
 #include "sysemu/accel.h"
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 8d8af53df8..6181486401 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -11,13 +11,12 @@
  *
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef IOTHREAD_H
 #define IOTHREAD_H
=20
 #include "block/aio.h"
 #include "qemu/thread.h"
+#include "qom/object.h"
=20
 #define TYPE_IOTHREAD "iothread"
=20
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 18f48589c1..7a1c3cdcb1 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -6,11 +6,11 @@
  *
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
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
index 6fb5b42cf1..b02978543c 100644
--- a/include/sysemu/memory_mapping.h
+++ b/include/sysemu/memory_mapping.h
@@ -11,12 +11,15 @@
  *
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers for user emulation, yet! */
=20
 #ifndef MEMORY_MAPPING_H
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
index e3acb95b42..c8e7c2f6cf 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -6,11 +6,11 @@
  *
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef XEN_MAPCACHE_H
 #define XEN_MAPCACHE_H
=20
+#include "exec/cpu-common.h"
+
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
                                          ram_addr_t size);
 #ifdef CONFIG_XEN
diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 5ea65ddfa1..151e1c92b6 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -1,4 +1,5 @@
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers without CONFIG_OPENGL, yet! */
+/* FIXME Does not pass make check-headers without system emulation, yet!=
 */
=20
 #ifndef EGL_HELPERS_H
 #define EGL_HELPERS_H
@@ -6,6 +7,9 @@
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
index 718f152f98..c86219a1c1 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -1,9 +1,8 @@
-/* FIXME Does not pass make check-headers, yet! */
-
 #ifndef INPUT_H
 #define INPUT_H
=20
 #include "qapi/qapi-types-ui.h"
+#include "qemu/notify.h"
=20
 #define INPUT_EVENT_MASK_KEY   (1<<INPUT_EVENT_KIND_KEY)
 #define INPUT_EVENT_MASK_BTN   (1<<INPUT_EVENT_KIND_BTN)
diff --git a/include/ui/pixel_ops.h b/include/ui/pixel_ops.h
index 18d5e181a6..7952be77bf 100644
--- a/include/ui/pixel_ops.h
+++ b/include/ui/pixel_ops.h
@@ -1,4 +1,5 @@
-/* FIXME Does not pass make check-headers, yet! */
+#ifndef UI_PIXEL_OPS_H
+#define UI_PIXEL_OPS_H
=20
 static inline unsigned int rgb_to_pixel8(unsigned int r, unsigned int g,
                                          unsigned int b)
@@ -53,3 +54,5 @@ static inline unsigned int rgb_to_pixel32bgr(unsigned i=
nt r, unsigned int g,
 {
     return (b << 16) | (g << 8) | r;
 }
+
+#endif
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 4bb30522a6..93930889cc 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -15,11 +15,13 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
-/* FIXME Does not pass make check-headers, yet! */
+/* FIXME Does not pass make check-headers without CONFIG_SPICE, yet! */
+/* FIXME Does not pass make check-headers without system emulation, yet!=
 */
=20
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
diff --git a/tests/check-headers.mak b/tests/check-headers.mak
index 367b9dfb9a..fee538c33b 100644
--- a/tests/check-headers.mak
+++ b/tests/check-headers.mak
@@ -25,6 +25,24 @@ untarget-headers :=3D include/exec/poison.h
 # Extended regular expression matching the FIXME comment in headers
 # not expected to pass the test in this build's configuration:
 bad-header-regexp :=3D FIXME Does not pass make check-headers(
+# Fails in %-user:
+ifneq ($(TARGET_DIR),)
+ifneq ($(CONFIG_USER_ONLY),)
+bad-header-regexp +=3D for user emulation|
+endif
+endif
+# Target-dependent arm only:
+ifneq ($(TARGET_BASE_ARCH),arm)
+bad-header-regexp +=3D for TARGET_BASE_ARCH other than arm|
+endif
+# Target-dependent i386 only:
+ifneq ($(TARGET_BASE_ARCH),i386)
+bad-header-regexp +=3D for TARGET_BASE_ARCH other than i386|
+endif
+# Target-dependent mips only:
+ifneq ($(TARGET_BASE_ARCH),mips)
+bad-header-regexp +=3D for TARGET_BASE_ARCH other than mips|
+endif
 # Require <cpuid.h>:
 ifneq ($(CONFIG_CPUID_H),y)
 bad-header-regexp +=3D without CONFIG_CPUID_H|
--=20
2.21.0


