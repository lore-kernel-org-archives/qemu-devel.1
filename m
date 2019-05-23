Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F3C04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D31920879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D31920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59865 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTjCG-0001tH-Cc
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 04:35:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTj2S-0002El-KZ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTit8-0000tI-9v
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hTit6-0000s0-9r
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:15:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B36CC3001822;
	Thu, 23 May 2019 08:15:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D60395D9D2;
	Thu, 23 May 2019 08:15:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id EBD2D1132B38; Thu, 23 May 2019 10:15:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 10:15:36 +0200
Message-Id: <20190523081538.2291-6-armbru@redhat.com>
In-Reply-To: <20190523081538.2291-1-armbru@redhat.com>
References: <20190523081538.2291-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 23 May 2019 08:15:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v4 5/7] tests: New make target check-source
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make target check-source is for checking the source code itself.  For
now, there's just one such check, make target check-headers.  It
checks basic header sanity: for each header "FOO.h", test whether

	#include "qemu/osdep.h"
	#include "FOO.h"
	#include "FOO.h"

compiles.

The test works only in a git tree, with git installed.  It is skipped
unless $(SRC_PATH)/.git exists.

Third-party headers we don't intend to clean up are excluded from this
test.  So are a few "funny" headers.  See make variable
excluded-headers.

A large number of headers don't pass this test, by design or by
accident.  To keep things more manageable, exclude all headers outside
include/ for now.

Headers known to fail the test are marked with

    /* FIXME Does not pass make check-headers, yet! */

Headers known to work only in certain configurations are marked like

    /* FIXME Does not pass make check-headers without CONFIG_WIN32, yet! */

I tried to find and mark all of them by testing various
configurations.  Still, "make check" might fail for configurations I
didn't test.

Known issue: some of these don't actually need fixing; they're *meant*
to work only in certain configurations.  We'll want to invent a
suitable marker that doesn't claim FIXME.

Some headers may only be included into target-dependent code: they use
identifiers poisoned by exec/poison.h, or include cpu.h.  These
headers are marked with a comment

    /* NOTE: May only be included into target-dependent code */

The test treats them specially.

Known issue: some of these are intended for specific targets.  The
test should skip them for other targets, but doesn't.  They're marked
FIXME instead, which is wrong.

New make target check-bad-headers runs the test for headers expected
to fail it.  This helps with examining the failures.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 Makefile                                  |  4 ++-
 Makefile.target                           | 19 ++++++++++
 include/block/raw-aio.h                   |  3 ++
 include/block/write-threshold.h           |  3 ++
 include/chardev/char-win.h                |  3 ++
 include/chardev/spice.h                   |  2 ++
 include/disas/disas.h                     |  2 ++
 include/exec/cpu-all.h                    |  4 +++
 include/exec/cpu-defs.h                   |  4 +++
 include/exec/cpu_ldst.h                   |  4 +++
 include/exec/cpu_ldst_template.h          |  3 ++
 include/exec/cpu_ldst_useronly_template.h |  3 ++
 include/exec/cputlb.h                     |  3 ++
 include/exec/exec-all.h                   |  3 ++
 include/exec/gen-icount.h                 |  2 ++
 include/exec/helper-gen.h                 |  2 ++
 include/exec/helper-proto.h               |  2 ++
 include/exec/helper-tcg.h                 |  2 ++
 include/exec/ioport.h                     |  2 ++
 include/exec/memory-internal.h            |  2 ++
 include/exec/memory_ldst.inc.h            |  2 ++
 include/exec/memory_ldst_cached.inc.h     |  2 ++
 include/exec/memory_ldst_phys.inc.h       |  2 ++
 include/exec/ram_addr.h                   |  3 ++
 include/exec/softmmu-semi.h               |  3 ++
 include/exec/tb-hash.h                    |  3 ++
 include/exec/tb-lookup.h                  |  3 ++
 include/exec/translator.h                 |  3 ++
 include/exec/user/abitypes.h              |  2 ++
 include/exec/user/thunk.h                 |  4 +++
 include/fpu/softfloat-macros.h            |  2 ++
 include/fpu/softfloat.h                   |  2 ++
 include/hw/acpi/piix4.h                   |  2 ++
 include/hw/acpi/tco.h                     |  3 ++
 include/hw/adc/stm32f2xx_adc.h            |  2 ++
 include/hw/arm/allwinner-a10.h            |  2 ++
 include/hw/arm/armsse.h                   |  3 ++
 include/hw/arm/armv7m.h                   |  3 ++
 include/hw/arm/aspeed_soc.h               |  2 ++
 include/hw/arm/bcm2835_peripherals.h      |  2 ++
 include/hw/arm/bcm2836.h                  |  2 ++
 include/hw/arm/digic.h                    |  3 ++
 include/hw/arm/fsl-imx25.h                |  2 ++
 include/hw/arm/fsl-imx31.h                |  2 ++
 include/hw/arm/fsl-imx6.h                 |  3 ++
 include/hw/arm/fsl-imx6ul.h               |  3 ++
 include/hw/arm/fsl-imx7.h                 |  3 ++
 include/hw/arm/msf2-soc.h                 |  3 ++
 include/hw/arm/nrf51_soc.h                |  3 ++
 include/hw/arm/omap.h                     |  3 ++
 include/hw/arm/sharpsl.h                  |  3 ++
 include/hw/arm/stm32f205_soc.h            |  3 ++
 include/hw/arm/xlnx-zynqmp.h              |  2 ++
 include/hw/block/fdc.h                    |  2 ++
 include/hw/block/flash.h                  |  2 ++
 include/hw/char/escc.h                    |  2 ++
 include/hw/char/xilinx_uartlite.h         |  2 ++
 include/hw/core/generic-loader.h          |  2 ++
 include/hw/cris/etraxfs.h                 |  2 ++
 include/hw/cris/etraxfs_dma.h             |  2 ++
 include/hw/display/bcm2835_fb.h           |  2 ++
 include/hw/display/i2c-ddc.h              |  2 ++
 include/hw/display/xlnx_dp.h              |  2 ++
 include/hw/dma/xlnx_dpdma.h               |  2 ++
 include/hw/elf_ops.h                      |  2 ++
 include/hw/empty_slot.h                   |  2 ++
 include/hw/gpio/bcm2835_gpio.h            |  2 ++
 include/hw/hyperv/hyperv.h                |  2 ++
 include/hw/i2c/aspeed_i2c.h               |  3 ++
 include/hw/i386/apic_internal.h           |  3 ++
 include/hw/i386/ioapic_internal.h         |  2 ++
 include/hw/input/hid.h                    |  2 ++
 include/hw/input/tsc2xxx.h                |  2 ++
 include/hw/intc/allwinner-a10-pic.h       |  2 ++
 include/hw/intc/armv7m_nvic.h             |  3 ++
 include/hw/intc/heathrow_pic.h            |  2 ++
 include/hw/intc/mips_gic.h                |  3 ++
 include/hw/isa/vt82c686.h                 |  2 ++
 include/hw/kvm/clock.h                    |  4 ++-
 include/hw/mips/bios.h                    |  2 ++
 include/hw/mips/cps.h                     |  3 ++
 include/hw/mips/cpudevs.h                 |  2 ++
 include/hw/misc/bcm2835_property.h        |  2 ++
 include/hw/misc/macio/cuda.h              |  2 ++
 include/hw/misc/macio/gpio.h              |  2 ++
 include/hw/misc/macio/macio.h             |  2 ++
 include/hw/misc/macio/pmu.h               |  2 ++
 include/hw/misc/mips_cmgcr.h              |  2 ++
 include/hw/misc/mips_cpc.h                |  2 ++
 include/hw/misc/pvpanic.h                 |  3 ++
 include/hw/net/allwinner_emac.h           |  2 ++
 include/hw/net/lance.h                    |  2 ++
 include/hw/nvram/chrp_nvram.h             |  2 ++
 include/hw/pci-bridge/simba.h             |  2 ++
 include/hw/pci-host/sabre.h               |  2 ++
 include/hw/pci-host/spapr.h               |  3 ++
 include/hw/pci-host/uninorth.h            |  2 ++
 include/hw/pci/pcie_aer.h                 |  2 ++
 include/hw/ppc/fdt.h                      |  2 ++
 include/hw/ppc/pnv.h                      |  2 ++
 include/hw/ppc/pnv_core.h                 |  2 ++
 include/hw/ppc/pnv_xscom.h                |  2 ++
 include/hw/ppc/ppc.h                      |  2 ++
 include/hw/ppc/ppc4xx.h                   |  2 ++
 include/hw/ppc/spapr.h                    |  3 ++
 include/hw/ppc/spapr_cpu_core.h           |  4 +++
 include/hw/ppc/spapr_irq.h                |  2 ++
 include/hw/ppc/spapr_ovec.h               |  2 ++
 include/hw/ppc/spapr_vio.h                |  2 ++
 include/hw/ppc/spapr_xive.h               |  2 ++
 include/hw/ppc/xics_spapr.h               |  3 ++
 include/hw/ppc/xive_regs.h                |  2 ++
 include/hw/riscv/riscv_hart.h             |  2 ++
 include/hw/riscv/riscv_htif.h             |  3 ++
 include/hw/riscv/sifive_clint.h           |  2 ++
 include/hw/riscv/sifive_e.h               |  2 ++
 include/hw/riscv/sifive_plic.h            |  2 ++
 include/hw/riscv/sifive_prci.h            |  2 ++
 include/hw/riscv/sifive_test.h            |  2 ++
 include/hw/riscv/sifive_u.h               |  2 ++
 include/hw/riscv/sifive_uart.h            |  2 ++
 include/hw/riscv/spike.h                  |  2 ++
 include/hw/riscv/virt.h                   |  2 ++
 include/hw/s390x/3270-ccw.h               |  3 ++
 include/hw/s390x/ap-device.h              |  3 ++
 include/hw/s390x/css-bridge.h             |  2 ++
 include/hw/s390x/css.h                    |  3 ++
 include/hw/s390x/s390-ccw.h               |  3 ++
 include/hw/s390x/storage-attributes.h     |  3 ++
 include/hw/s390x/tod.h                    |  2 ++
 include/hw/s390x/vfio-ccw.h               |  3 ++
 include/hw/sh4/sh.h                       |  2 ++
 include/hw/sh4/sh_intc.h                  |  2 ++
 include/hw/sparc/grlib.h                  |  2 ++
 include/hw/sparc/sparc64.h                |  1 +
 include/hw/ssi/aspeed_smc.h               |  2 ++
 include/hw/ssi/xilinx_spips.h             |  2 ++
 include/hw/timer/allwinner-a10-pit.h      |  2 ++
 include/hw/timer/i8254_internal.h         |  2 ++
 include/hw/timer/m48t59.h                 |  2 ++
 include/hw/timer/mc146818rtc.h            |  2 ++
 include/hw/timer/mc146818rtc_regs.h       |  2 ++
 include/hw/timer/sun4v-rtc.h              |  2 ++
 include/hw/timer/xlnx-zynqmp-rtc.h        |  2 ++
 include/hw/vfio/vfio-amd-xgbe.h           |  2 ++
 include/hw/vfio/vfio-calxeda-xgmac.h      |  2 ++
 include/hw/vfio/vfio-common.h             |  2 ++
 include/hw/vfio/vfio-platform.h           |  2 ++
 include/hw/virtio/virtio-access.h         |  3 ++
 include/hw/virtio/virtio-gpu.h            |  2 ++
 include/hw/virtio/virtio-input.h          |  2 ++
 include/hw/virtio/virtio-rng.h            |  2 ++
 include/hw/xen/io/ring.h                  |  2 ++
 include/hw/xen/xen-backend.h              |  2 ++
 include/hw/xen/xen-block.h                |  2 ++
 include/hw/xen/xen-bus-helper.h           |  2 ++
 include/hw/xen/xen-bus.h                  |  2 ++
 include/hw/xen/xen-legacy-backend.h       |  2 ++
 include/hw/xen/xen_common.h               |  2 ++
 include/hw/xen/xen_pvdev.h                |  2 ++
 include/libdecnumber/decNumberLocal.h     |  2 ++
 include/migration/cpu.h                   |  4 +++
 include/monitor/hmp-target.h              |  3 ++
 include/qemu/atomic128.h                  |  2 ++
 include/qemu/futex.h                      |  2 ++
 include/qemu/ratelimit.h                  |  2 ++
 include/qemu/thread-win32.h               |  2 ++
 include/qemu/xattr.h                      |  3 ++
 include/sysemu/balloon.h                  |  2 ++
 include/sysemu/cryptodev-vhost-user.h     |  3 ++
 include/sysemu/dump.h                     |  2 ++
 include/sysemu/hvf.h                      |  3 ++
 include/sysemu/iothread.h                 |  2 ++
 include/sysemu/kvm_int.h                  |  2 ++
 include/sysemu/memory_mapping.h           |  2 ++
 include/sysemu/os-posix.h                 |  2 ++
 include/sysemu/os-win32.h                 |  2 ++
 include/sysemu/xen-mapcache.h             |  2 ++
 include/trace-tcg.h                       |  2 ++
 include/ui/console.h                      |  2 ++
 include/ui/egl-context.h                  |  3 ++
 include/ui/egl-helpers.h                  |  2 ++
 include/ui/gtk.h                          |  2 ++
 include/ui/input.h                        |  2 ++
 include/ui/pixel_ops.h                    |  2 ++
 include/ui/qemu-pixman.h                  |  2 ++
 include/ui/sdl2.h                         |  2 ++
 include/ui/shader.h                       |  2 ++
 include/ui/spice-display.h                |  2 ++
 tests/Makefile.include                    | 32 +++++++++++++++--
 tests/check-headers.mak                   | 42 +++++++++++++++++++++++
 tests/header-test-template.c              | 16 +++++++++
 192 files changed, 542 insertions(+), 4 deletions(-)
 create mode 100644 tests/check-headers.mak
 create mode 100644 tests/header-test-template.c

diff --git a/Makefile b/Makefile
index 59de8e2494..42f02c5ceb 100644
--- a/Makefile
+++ b/Makefile
@@ -416,6 +416,8 @@ dummy := $(call unnest-vars,, \
                 audio-obj-m \
                 trace-obj-y)
 
+RECURSIVE_TARGETS := all clean install
+
 include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
@@ -436,7 +438,7 @@ config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
+TARGET_DIRS_RULES:=$(foreach t, $(RECURSIVE_TARGETS), $(addsuffix /$(t), $(TARGET_DIRS)))
 
 SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
 $(SOFTMMU_ALL_RULES): $(authz-obj-y)
diff --git a/Makefile.target b/Makefile.target
index fdbe7c89f4..a46cfda580 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -41,6 +41,7 @@ STPFILES=
 
 # Makefile Tests
 include $(SRC_PATH)/tests/tcg/Makefile.include
+include $(SRC_PATH)/tests/check-headers.mak
 
 config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak
@@ -216,6 +217,22 @@ hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
 hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
 
+.PHONY: check-headers
+ifeq ($(wildcard $(SRC_PATH)/.git),)
+check-headers check-bad-headers:
+	@echo "  SKIP  $@ (requires a git tree)"
+else
+check-headers: $(check-target-header-tests:.c=.o)
+
+# Expected to fail:
+check-bad-headers: $(check-bad-target-header-tests:.c=.o)
+
+.SECONDARY: $(check-target-header-tests)
+$(check-target-header-tests) $(check-bad-target-header-tests): tests/header-test-template.c
+	@mkdir -p $(dir $@)
+	@sed 's,@header@,$(subst tests/headers/,,$(@:.c=.h)),' <$< >$@
+endif
+
 clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
@@ -238,3 +255,5 @@ endif
 
 generated-files-y += config-target.h
 Makefile: $(generated-files-y)
+
+-include $(check-target-header-tests:.c=.d) $(check-bad-target-header-tests:.c=.d)
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index ba223dd1f1..c196cf7b2d 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -12,6 +12,9 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_RAW_AIO_H
 #define QEMU_RAW_AIO_H
 
diff --git a/include/block/write-threshold.h b/include/block/write-threshold.h
index 234d2193e0..b2cfd11219 100644
--- a/include/block/write-threshold.h
+++ b/include/block/write-threshold.h
@@ -9,6 +9,9 @@
  * This work is licensed under the terms of the GNU LGPL, version 2 or later.
  * See the COPYING.LIB file in the top-level directory.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef BLOCK_WRITE_THRESHOLD_H
 #define BLOCK_WRITE_THRESHOLD_H
 
diff --git a/include/chardev/char-win.h b/include/chardev/char-win.h
index fa59e9e423..423fa8dcd2 100644
--- a/include/chardev/char-win.h
+++ b/include/chardev/char-win.h
@@ -21,6 +21,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
+/* FIXME Does not pass make check-headers without CONFIG_WIN32, yet! */
+
 #ifndef CHAR_WIN_H
 #define CHAR_WIN_H
 
diff --git a/include/chardev/spice.h b/include/chardev/spice.h
index 1f7339b649..2bc2a992b5 100644
--- a/include/chardev/spice.h
+++ b/include/chardev/spice.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without CONFIG_SPICE, yet! */
+
 #ifndef CHARDEV_SPICE_H
 #define CHARDEV_SPICE_H
 
diff --git a/include/disas/disas.h b/include/disas/disas.h
index 4d48c13c65..b19e70b50c 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_DISAS_H
 #define QEMU_DISAS_H
 
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index da07ce311f..c18094bc59 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -16,6 +16,10 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CPU_ALL_H
 #define CPU_ALL_H
 
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 8f2a848bf5..361a2359aa 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -16,6 +16,10 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CPU_DEFS_H
 #define CPU_DEFS_H
 
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 7b28a839d2..9f71d36e42 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -44,6 +44,10 @@
  * (for softmmu configs)  a target-specific MMU mode suffix as defined
  * in target cpu.h.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CPU_LDST_H
 #define CPU_LDST_H
 
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 0f061d47ef..b5df25e2e0 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -24,6 +24,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #if !defined(SOFTMMU_CODE_ACCESS)
 #include "trace-root.h"
 #endif
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 0fd6019af0..2f5d1da7d0 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -23,6 +23,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #if !defined(CODE_ACCESS)
 #include "trace-root.h"
 #endif
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 5373188be3..361df6dee0 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CPUTLB_H
 #define CPUTLB_H
 
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 31f0ecc461..7fd70557f7 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 24f7991781..14e283aefa 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef GEN_ICOUNT_H
 #define GEN_ICOUNT_H
 
diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
index 22381a1708..63e4856b43 100644
--- a/include/exec/helper-gen.h
+++ b/include/exec/helper-gen.h
@@ -1,6 +1,8 @@
 /* Helper file for declaring TCG helper functions.
    This one expands generation functions for tcg opcodes.  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HELPER_GEN_H
 #define HELPER_GEN_H
 
diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
index 74943edb13..e5a1b9403d 100644
--- a/include/exec/helper-proto.h
+++ b/include/exec/helper-proto.h
@@ -1,6 +1,8 @@
 /* Helper file for declaring TCG helper functions.
    This one expands prototypes for the helper functions.  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HELPER_PROTO_H
 #define HELPER_PROTO_H
 
diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
index 268e0f804b..51e4758082 100644
--- a/include/exec/helper-tcg.h
+++ b/include/exec/helper-tcg.h
@@ -1,6 +1,8 @@
 /* Helper file for declaring TCG helper functions.
    This one defines data structures private to tcg.c.  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HELPER_TCG_H
 #define HELPER_TCG_H
 
diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index a298b89ce1..96dc6f5662 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -21,6 +21,8 @@
  * IO ports API
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef IOPORT_H
 #define IOPORT_H
 
diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index d1a9dd1ec8..d16ec2d36d 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -17,6 +17,8 @@
  * internals and the TCG TLB code. Do not include it from elsewhere.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
diff --git a/include/exec/memory_ldst.inc.h b/include/exec/memory_ldst.inc.h
index 272c20f02e..7846e99b6d 100644
--- a/include/exec/memory_ldst.inc.h
+++ b/include/exec/memory_ldst.inc.h
@@ -19,6 +19,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifdef TARGET_ENDIANNESS
 extern uint32_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
diff --git a/include/exec/memory_ldst_cached.inc.h b/include/exec/memory_ldst_cached.inc.h
index fd4bbb40e7..9725005455 100644
--- a/include/exec/memory_ldst_cached.inc.h
+++ b/include/exec/memory_ldst_cached.inc.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define ADDRESS_SPACE_LD_CACHED(size) \
     glue(glue(address_space_ld, size), glue(ENDIANNESS, _cached))
 #define ADDRESS_SPACE_LD_CACHED_SLOW(size) \
diff --git a/include/exec/memory_ldst_phys.inc.h b/include/exec/memory_ldst_phys.inc.h
index 91f72973cb..8cd1828f8c 100644
--- a/include/exec/memory_ldst_phys.inc.h
+++ b/include/exec/memory_ldst_phys.inc.h
@@ -19,6 +19,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifdef TARGET_ENDIANNESS
 static inline uint32_t glue(ldl_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 139ad79390..574427a505 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -16,6 +16,9 @@
  * The functions declared here will be removed soon.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef RAM_ADDR_H
 #define RAM_ADDR_H
 
diff --git a/include/exec/softmmu-semi.h b/include/exec/softmmu-semi.h
index 7eefad8f39..88f4deae26 100644
--- a/include/exec/softmmu-semi.h
+++ b/include/exec/softmmu-semi.h
@@ -7,6 +7,9 @@
  * This code is licensed under the GPL
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SOFTMMU_SEMI_H
 #define SOFTMMU_SEMI_H
 
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 4f3a37d927..79e53fb73d 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef EXEC_TB_HASH_H
 #define EXEC_TB_HASH_H
 
diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
index 26921b6daf..93d6ebd148 100644
--- a/include/exec/tb-lookup.h
+++ b/include/exec/tb-lookup.h
@@ -4,6 +4,9 @@
  * License: GNU GPL, version 2 or later.
  *   See the COPYING file in the top-level directory.
  */
+
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef EXEC_TB_LOOKUP_H
 #define EXEC_TB_LOOKUP_H
 
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 180c51d509..301c740c4e 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -7,6 +7,9 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef EXEC__TRANSLATOR_H
 #define EXEC__TRANSLATOR_H
 
diff --git a/include/exec/user/abitypes.h b/include/exec/user/abitypes.h
index 743b8bb9ea..626840d9c2 100644
--- a/include/exec/user/abitypes.h
+++ b/include/exec/user/abitypes.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef EXEC_USER_ABITYPES_H
 #define EXEC_USER_ABITYPES_H
 
diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 8d3af5a3be..933fd77436 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -16,6 +16,10 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef THUNK_H
 #define THUNK_H
 
diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index bd5b6418e3..112e1b21dc 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -79,6 +79,8 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
 | bits are shifted off, they are ``jammed'' into the least significant bit of
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3ff3fa5224..303512c8a3 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -79,6 +79,8 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef SOFTFLOAT_H
 #define SOFTFLOAT_H
 
diff --git a/include/hw/acpi/piix4.h b/include/hw/acpi/piix4.h
index 028bb53e3d..62ad6bf19f 100644
--- a/include/hw/acpi/piix4.h
+++ b/include/hw/acpi/piix4.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ACPI_PIIX4_H
 #define HW_ACPI_PIIX4_H
 
diff --git a/include/hw/acpi/tco.h b/include/hw/acpi/tco.h
index 52ad767ddd..d7ff814451 100644
--- a/include/hw/acpi/tco.h
+++ b/include/hw/acpi/tco.h
@@ -6,6 +6,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ACPI_TCO_H
 #define HW_ACPI_TCO_H
 
diff --git a/include/hw/adc/stm32f2xx_adc.h b/include/hw/adc/stm32f2xx_adc.h
index a72f734eb1..8e67c0f24d 100644
--- a/include/hw/adc/stm32f2xx_adc.h
+++ b/include/hw/adc/stm32f2xx_adc.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_STM32F2XX_ADC_H
 #define HW_STM32F2XX_ADC_H
 
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 389e128d0f..ea1385d76f 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALLWINNER_H_
 
 #include "qemu-common.h"
diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 81e082cccf..c60de46c92 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -81,6 +81,9 @@
  *  + named GPIO outputs mscexp_ns[0..15]
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ARMSSE_H
 #define ARMSSE_H
 
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index e96a98f809..28d80a3ba1 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -7,6 +7,9 @@
  * This code is licensed under the GPL version 2 or later.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_ARMV7M_H
 #define HW_ARM_ARMV7M_H
 
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 11ec0179db..0d266fc88e 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -9,6 +9,8 @@
  * the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ASPEED_SOC_H
 #define ASPEED_SOC_H
 
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index f5b193f670..aafa8adb06 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -8,6 +8,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef BCM2835_PERIPHERALS_H
 #define BCM2835_PERIPHERALS_H
 
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 93248399ba..01247b43b6 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -8,6 +8,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef BCM2836_H
 #define BCM2836_H
 
diff --git a/include/hw/arm/digic.h b/include/hw/arm/digic.h
index 63785baaa8..79f9278c64 100644
--- a/include/hw/arm/digic.h
+++ b/include/hw/arm/digic.h
@@ -15,6 +15,9 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_DIGIC_H
 #define HW_ARM_DIGIC_H
 
diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 65a73714ef..db80831846 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -14,6 +14,8 @@
  * for more details.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FSL_IMX25_H
 #define FSL_IMX25_H
 
diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index d408abbba0..fb77d94366 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -14,6 +14,8 @@
  * for more details.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FSL_IMX31_H
 #define FSL_IMX31_H
 
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 06f8aaeda4..accec72f24 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -14,6 +14,9 @@
  * for more details.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FSL_IMX6_H
 #define FSL_IMX6_H
 
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 5897217194..f7b517119d 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -14,6 +14,9 @@
  * GNU General Public License for more details.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FSL_IMX6UL_H
 #define FSL_IMX6UL_H
 
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index d848262bfd..9e28691ae2 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -16,6 +16,9 @@
  * GNU General Public License for more details.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FSL_IMX7_H
 #define FSL_IMX7_H
 
diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
index 3cfe5c76ee..3a209e48b8 100644
--- a/include/hw/arm/msf2-soc.h
+++ b/include/hw/arm/msf2-soc.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_MSF2_SOC_H
 #define HW_ARM_MSF2_SOC_H
 
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index 0cb78aafea..b5a3da0bdc 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -7,6 +7,9 @@
  * the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef NRF51_SOC_H
 #define NRF51_SOC_H
 
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 9de867daa4..404e7d81af 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef hw_omap_h
 #include "exec/memory.h"
 # define hw_omap_h		"omap.h"
diff --git a/include/hw/arm/sharpsl.h b/include/hw/arm/sharpsl.h
index 5bf6db1fa2..dc456653e1 100644
--- a/include/hw/arm/sharpsl.h
+++ b/include/hw/arm/sharpsl.h
@@ -3,6 +3,9 @@
  *
  * This file is licensed under the GNU GPL.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_SHARPSL_H
 #define QEMU_SHARPSL_H
 
diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_soc.h
index 922a733f88..4558c64823 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_STM32F205_SOC_H
 #define HW_ARM_STM32F205_SOC_H
 
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 591515c760..bd7a5a0302 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -15,6 +15,8 @@
  * for more details.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XLNX_ZYNQMP_H
 
 #include "qemu-common.h"
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 3b813c7f7d..cf87f48317 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_FDC_H
 #define HW_FDC_H
 
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 1acaf7de80..15ce2b3f14 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_FLASH_H
 #define HW_FLASH_H
 
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 42aca83611..71b95dd152 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ESCC_H
 #define HW_ESCC_H
 
diff --git a/include/hw/char/xilinx_uartlite.h b/include/hw/char/xilinx_uartlite.h
index 634086b657..a003b5977f 100644
--- a/include/hw/char/xilinx_uartlite.h
+++ b/include/hw/char/xilinx_uartlite.h
@@ -12,6 +12,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XILINX_UARTLITE_H
 #define XILINX_UARTLITE_H
 
diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic-loader.h
index dd27c42ab0..3827144a5f 100644
--- a/include/hw/core/generic-loader.h
+++ b/include/hw/core/generic-loader.h
@@ -15,6 +15,8 @@
  * for more details.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef GENERIC_LOADER_H
 #define GENERIC_LOADER_H
 
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 8da965addb..108692bac3 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ETRAXFS_H
 #define HW_ETRAXFS_H
 
diff --git a/include/hw/cris/etraxfs_dma.h b/include/hw/cris/etraxfs_dma.h
index f6f33e0980..a1c6ce44ba 100644
--- a/include/hw/cris/etraxfs_dma.h
+++ b/include/hw/cris/etraxfs_dma.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ETRAXFS_DMA_H
 #define HW_ETRAXFS_DMA_H
 
diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index 228988ba05..baec7d1797 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -8,6 +8,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef BCM2835_FB_H
 #define BCM2835_FB_H
 
diff --git a/include/hw/display/i2c-ddc.h b/include/hw/display/i2c-ddc.h
index c29443c5af..814be09922 100644
--- a/include/hw/display/i2c-ddc.h
+++ b/include/hw/display/i2c-ddc.h
@@ -16,6 +16,8 @@
  *  with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef I2C_DDC_H
 #define I2C_DDC_H
 
diff --git a/include/hw/display/xlnx_dp.h b/include/hw/display/xlnx_dp.h
index 45a805033a..0fb42e8a77 100644
--- a/include/hw/display/xlnx_dp.h
+++ b/include/hw/display/xlnx_dp.h
@@ -22,6 +22,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #include "hw/sysbus.h"
 #include "ui/console.h"
 #include "hw/misc/auxbus.h"
diff --git a/include/hw/dma/xlnx_dpdma.h b/include/hw/dma/xlnx_dpdma.h
index 7a304a5bb4..5c9a003feb 100644
--- a/include/hw/dma/xlnx_dpdma.h
+++ b/include/hw/dma/xlnx_dpdma.h
@@ -22,6 +22,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef XLNX_DPDMA_H
 #define XLNX_DPDMA_H
 
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index 690f9238c8..f873519cfd 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 static void glue(bswap_ehdr, SZ)(struct elfhdr *ehdr)
 {
     bswap16s(&ehdr->e_type);			/* Object file type */
diff --git a/include/hw/empty_slot.h b/include/hw/empty_slot.h
index 123a9f8989..249092a1cd 100644
--- a/include/hw/empty_slot.h
+++ b/include/hw/empty_slot.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_EMPTY_SLOT_H
 #define HW_EMPTY_SLOT_H
 
diff --git a/include/hw/gpio/bcm2835_gpio.h b/include/hw/gpio/bcm2835_gpio.h
index 9f8e0c720c..c24106aba5 100644
--- a/include/hw/gpio/bcm2835_gpio.h
+++ b/include/hw/gpio/bcm2835_gpio.h
@@ -11,6 +11,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef BCM2835_GPIO_H
 #define BCM2835_GPIO_H
 
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 597381cb01..eab9724561 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_HYPERV_HYPERV_H
 #define HW_HYPERV_HYPERV_H
 
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index f9020acdef..ee215ff26e 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -17,6 +17,9 @@
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ASPEED_I2C_H
 #define ASPEED_I2C_H
 
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 1209eb483a..ec00577253 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -18,6 +18,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_APIC_INTERNAL_H
 #define QEMU_APIC_INTERNAL_H
 
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_internal.h
index 07002f9662..9a9cd96788 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -19,6 +19,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_IOAPIC_INTERNAL_H
 #define QEMU_IOAPIC_INTERNAL_H
 
diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
index 2127c7ce45..aec04352e0 100644
--- a/include/hw/input/hid.h
+++ b/include/hw/input/hid.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_HID_H
 #define QEMU_HID_H
 
diff --git a/include/hw/input/tsc2xxx.h b/include/hw/input/tsc2xxx.h
index dbfe5c55c1..37e620d79d 100644
--- a/include/hw/input/tsc2xxx.h
+++ b/include/hw/input/tsc2xxx.h
@@ -8,6 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef HW_INPUT_TSC2XXX_H
 #define HW_INPUT_TSC2XXX_H
 
diff --git a/include/hw/intc/allwinner-a10-pic.h b/include/hw/intc/allwinner-a10-pic.h
index 1d314a70d9..897d5ad6cc 100644
--- a/include/hw/intc/allwinner-a10-pic.h
+++ b/include/hw/intc/allwinner-a10-pic.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALLWINNER_A10_PIC_H
 #define ALLWINNER_A10_PIC_H
 
diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index a472c9b8f0..5bcb946035 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -7,6 +7,9 @@
  * This code is licensed under the GPL version 2 or later.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_ARMV7M_NVIC_H
 #define HW_ARM_ARMV7M_NVIC_H
 
diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pic.h
index 6c91ec91bb..9724912d59 100644
--- a/include/hw/intc/heathrow_pic.h
+++ b/include/hw/intc/heathrow_pic.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_INTC_HEATHROW_PIC_H
 #define HW_INTC_HEATHROW_PIC_H
 
diff --git a/include/hw/intc/mips_gic.h b/include/hw/intc/mips_gic.h
index 902a12b178..870daa94c1 100644
--- a/include/hw/intc/mips_gic.h
+++ b/include/hw/intc/mips_gic.h
@@ -8,6 +8,9 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_GIC_H
 #define MIPS_GIC_H
 
diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index c3c2b6e786..49b3a96e4a 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_VT82C686_H
 #define HW_VT82C686_H
 
diff --git a/include/hw/kvm/clock.h b/include/hw/kvm/clock.h
index 252ea13461..f719d9892e 100644
--- a/include/hw/kvm/clock.h
+++ b/include/hw/kvm/clock.h
@@ -8,9 +8,11 @@
  *
  * This work is licensed under the terms of the GNU GPL version 2.
  * See the COPYING file in the top-level directory.
- *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifdef CONFIG_KVM
 
 void kvmclock_create(void);
diff --git a/include/hw/mips/bios.h b/include/hw/mips/bios.h
index d67ef33e83..74ebed02c8 100644
--- a/include/hw/mips/bios.h
+++ b/include/hw/mips/bios.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #include "qemu/units.h"
 #include "cpu.h"
 
diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index aab1af926d..af8d25e142 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_CPS_H
 #define MIPS_CPS_H
 
diff --git a/include/hw/mips/cpudevs.h b/include/hw/mips/cpudevs.h
index 291f59281a..fc80c53980 100644
--- a/include/hw/mips/cpudevs.h
+++ b/include/hw/mips/cpudevs.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef HW_MIPS_CPUDEVS_H
 #define HW_MIPS_CPUDEVS_H
 
diff --git a/include/hw/misc/bcm2835_property.h b/include/hw/misc/bcm2835_property.h
index 11be0dbeac..e9faac1bca 100644
--- a/include/hw/misc/bcm2835_property.h
+++ b/include/hw/misc/bcm2835_property.h
@@ -3,6 +3,8 @@
  * This code is licensed under the GNU GPLv2 and later.
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef BCM2835_PROPERTY_H
 #define BCM2835_PROPERTY_H
 
diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
index 7dad469142..562927e1da 100644
--- a/include/hw/misc/macio/cuda.h
+++ b/include/hw/misc/macio/cuda.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CUDA_H
 #define CUDA_H
 
diff --git a/include/hw/misc/macio/gpio.h b/include/hw/misc/macio/gpio.h
index 2838ae5fde..c5231896ce 100644
--- a/include/hw/misc/macio/gpio.h
+++ b/include/hw/misc/macio/gpio.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MACIO_GPIO_H
 #define MACIO_GPIO_H
 
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 970058b6ed..f19f756f38 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MACIO_H
 #define MACIO_H
 
diff --git a/include/hw/misc/macio/pmu.h b/include/hw/misc/macio/pmu.h
index d10895ba5f..0ab3c06a7e 100644
--- a/include/hw/misc/macio/pmu.h
+++ b/include/hw/misc/macio/pmu.h
@@ -7,6 +7,8 @@
  * Copyright (C) 2016 Ben Herrenschmidt
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PMU_H
 #define PMU_H
 
diff --git a/include/hw/misc/mips_cmgcr.h b/include/hw/misc/mips_cmgcr.h
index c9dfcb4b84..70b95ab163 100644
--- a/include/hw/misc/mips_cmgcr.h
+++ b/include/hw/misc/mips_cmgcr.h
@@ -7,6 +7,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_CMGCR_H
 #define MIPS_CMGCR_H
 
diff --git a/include/hw/misc/mips_cpc.h b/include/hw/misc/mips_cpc.h
index 72c834e039..86d2705526 100644
--- a/include/hw/misc/mips_cpc.h
+++ b/include/hw/misc/mips_cpc.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_CPC_H
 #define MIPS_CPC_H
 
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 1ee071a703..65c67e31f4 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -11,6 +11,9 @@
  * See the COPYING file in the top-level directory.
  *
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_MISC_PVPANIC_H
 #define HW_MISC_PVPANIC_H
 
diff --git a/include/hw/net/allwinner_emac.h b/include/hw/net/allwinner_emac.h
index 905a43deb4..9389cb82c6 100644
--- a/include/hw/net/allwinner_emac.h
+++ b/include/hw/net/allwinner_emac.h
@@ -20,6 +20,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALLWINNER_EMAC_H
 #define ALLWINNER_EMAC_H
 
diff --git a/include/hw/net/lance.h b/include/hw/net/lance.h
index ffdd35c4d7..2b99153bbc 100644
--- a/include/hw/net/lance.h
+++ b/include/hw/net/lance.h
@@ -26,6 +26,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef LANCE_H
 #define LANCE_H
 
diff --git a/include/hw/nvram/chrp_nvram.h b/include/hw/nvram/chrp_nvram.h
index b4f5b2b104..ae99396eab 100644
--- a/include/hw/nvram/chrp_nvram.h
+++ b/include/hw/nvram/chrp_nvram.h
@@ -15,6 +15,8 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CHRP_NVRAM_H
 #define CHRP_NVRAM_H
 
diff --git a/include/hw/pci-bridge/simba.h b/include/hw/pci-bridge/simba.h
index e13ba27d0b..35ddfd9316 100644
--- a/include/hw/pci-bridge/simba.h
+++ b/include/hw/pci-bridge/simba.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "hw/pci/pci_bridge.h"
 
 
diff --git a/include/hw/pci-host/sabre.h b/include/hw/pci-host/sabre.h
index 9afa4938fd..003bd17842 100644
--- a/include/hw/pci-host/sabre.h
+++ b/include/hw/pci-host/sabre.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_PCI_HOST_SABRE_H
 #define HW_PCI_HOST_SABRE_H
 
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 53519c835e..ee07d1506a 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PCI_HOST_SPAPR_H
 #define PCI_HOST_SPAPR_H
 
diff --git a/include/hw/pci-host/uninorth.h b/include/hw/pci-host/uninorth.h
index 060324536a..b541fbc12d 100644
--- a/include/hw/pci-host/uninorth.h
+++ b/include/hw/pci-host/uninorth.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef UNINORTH_H
 #define UNINORTH_H
 
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 729a9439c8..a2e8bc77a7 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_PCIE_AER_H
 #define QEMU_PCIE_AER_H
 
diff --git a/include/hw/ppc/fdt.h b/include/hw/ppc/fdt.h
index a8cd85069f..39670f61a8 100644
--- a/include/hw/ppc/fdt.h
+++ b/include/hw/ppc/fdt.h
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef PPC_FDT_H
 #define PPC_FDT_H
 
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fc4678f757..026538f08d 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_PNV_H
 #define PPC_PNV_H
 
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index d0926454a9..403b9f1e49 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_PNV_CORE_H
 #define PPC_PNV_CORE_H
 
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index c842d950d2..e93b86cbd3 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_PNV_XSCOM_H
 #define PPC_PNV_XSCOM_H
 
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 4bdcb8bacd..d45cb675bf 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef HW_PPC_H
 #define HW_PPC_H
 
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 39a7ba1ce6..2732200997 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC4XX_H
 #define PPC4XX_H
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 7e32f309c2..d0f107613e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SPAPR_H
 #define HW_SPAPR_H
 
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index f9645a7290..980d9ded69 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -6,6 +6,10 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SPAPR_CPU_CORE_H
 #define HW_SPAPR_CPU_CORE_H
 
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index b855f74e44..89636112be 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SPAPR_IRQ_H
 #define HW_SPAPR_IRQ_H
 
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 5de5ecf5de..5d522b7526 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -34,6 +34,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef SPAPR_OVEC_H
 #define SPAPR_OVEC_H
 
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 04609f214e..50cf292803 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SPAPR_VIO_H
 #define HW_SPAPR_VIO_H
 
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index fc3e9652f9..9da1d979f9 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_SPAPR_XIVE_H
 #define PPC_SPAPR_XIVE_H
 
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index 15a8dcff66..be9c6cf04c 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -24,6 +24,9 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XICS_SPAPR_H
 #define XICS_SPAPR_H
 
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index bf36678a24..a268cf8ebc 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -13,6 +13,8 @@
  * COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_XIVE_REGS_H
 #define PPC_XIVE_REGS_H
 
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index 0671d88a44..846a22c17d 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -18,6 +18,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_RISCV_HART_H
 #define HW_RISCV_HART_H
 
diff --git a/include/hw/riscv/riscv_htif.h b/include/hw/riscv/riscv_htif.h
index fb5f88129e..df385dacf4 100644
--- a/include/hw/riscv/riscv_htif.h
+++ b/include/hw/riscv/riscv_htif.h
@@ -17,6 +17,9 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_RISCV_HTIF_H
 #define HW_RISCV_HTIF_H
 
diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
index e2865be1d1..dd9999333f 100644
--- a/include/hw/riscv/sifive_clint.h
+++ b/include/hw/riscv/sifive_clint.h
@@ -17,6 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_CLINT_H
 #define HW_SIFIVE_CLINT_H
 
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index f715f8606f..30bb9f2360 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_E_H
 #define HW_SIFIVE_E_H
 
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
index ce8907f6aa..c292e578c6 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -18,6 +18,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_PLIC_H
 #define HW_SIFIVE_PLIC_H
 
diff --git a/include/hw/riscv/sifive_prci.h b/include/hw/riscv/sifive_prci.h
index b6f4c486cc..bc3412875d 100644
--- a/include/hw/riscv/sifive_prci.h
+++ b/include/hw/riscv/sifive_prci.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_PRCI_H
 #define HW_SIFIVE_PRCI_H
 
diff --git a/include/hw/riscv/sifive_test.h b/include/hw/riscv/sifive_test.h
index 71d4c9fad7..ca775d8e68 100644
--- a/include/hw/riscv/sifive_test.h
+++ b/include/hw/riscv/sifive_test.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_TEST_H
 #define HW_SIFIVE_TEST_H
 
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 892f0eee21..74d8fbbf57 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_U_H
 #define HW_SIFIVE_U_H
 
diff --git a/include/hw/riscv/sifive_uart.h b/include/hw/riscv/sifive_uart.h
index c8dc1c57fd..62f36ec2d1 100644
--- a/include/hw/riscv/sifive_uart.h
+++ b/include/hw/riscv/sifive_uart.h
@@ -17,6 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_SIFIVE_UART_H
 #define HW_SIFIVE_UART_H
 
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 641b70da67..f259d2558b 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_RISCV_SPIKE_H
 #define HW_RISCV_SPIKE_H
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 568764b570..f3cf6c8279 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_RISCV_VIRT_H
 #define HW_RISCV_VIRT_H
 
diff --git a/include/hw/s390x/3270-ccw.h b/include/hw/s390x/3270-ccw.h
index 9d1d18e2bd..bc24e78ec6 100644
--- a/include/hw/s390x/3270-ccw.h
+++ b/include/hw/s390x/3270-ccw.h
@@ -10,6 +10,9 @@
  * directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390X_3270_CCW_H
 #define HW_S390X_3270_CCW_H
 
diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
index 765e9082a3..2f3488115e 100644
--- a/include/hw/s390x/ap-device.h
+++ b/include/hw/s390x/ap-device.h
@@ -7,6 +7,9 @@
  * your option) any later version. See the COPYING file in the top-level
  * directory.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390X_AP_DEVICE_H
 #define HW_S390X_AP_DEVICE_H
 
diff --git a/include/hw/s390x/css-bridge.h b/include/hw/s390x/css-bridge.h
index 5a0203be5f..1f5efeb203 100644
--- a/include/hw/s390x/css-bridge.h
+++ b/include/hw/s390x/css-bridge.h
@@ -10,6 +10,8 @@
  * directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390X_CSS_BRIDGE_H
 #define HW_S390X_CSS_BRIDGE_H
 #include "qom/object.h"
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 7cc183ef43..921975efe7 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -9,6 +9,9 @@
  * directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CSS_H
 #define CSS_H
 
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 901d805d79..376351e8bc 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -10,6 +10,9 @@
  * directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390_CCW_H
 #define HW_S390_CCW_H
 
diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index d6403a0a7e..5bc4715c6b 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -9,6 +9,9 @@
  * directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef S390_STORAGE_ATTRIBUTES_H
 #define S390_STORAGE_ATTRIBUTES_H
 
diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index 9c4a6000c3..0ad708998b 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -8,6 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390_TOD_H
 #define HW_S390_TOD_H
 
diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
index ee5250d0d7..c35e86f9e8 100644
--- a/include/hw/s390x/vfio-ccw.h
+++ b/include/hw/s390x/vfio-ccw.h
@@ -11,6 +11,9 @@
  * directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_VFIO_CCW_H
 #define HW_VFIO_CCW_H
 
diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index 767a2df7e2..1884271351 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_SH_H
 #define QEMU_SH_H
 /* Definitions for SH board emulation.  */
diff --git a/include/hw/sh4/sh_intc.h b/include/hw/sh4/sh_intc.h
index adfedb2efc..3bffd67da1 100644
--- a/include/hw/sh4/sh_intc.h
+++ b/include/hw/sh4/sh_intc.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SH_INTC_H
 #define SH_INTC_H
 
diff --git a/include/hw/sparc/grlib.h b/include/hw/sparc/grlib.h
index 5606ff0a97..c278294cb1 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/sparc/grlib.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef GRLIB_H
 #define GRLIB_H
 
diff --git a/include/hw/sparc/sparc64.h b/include/hw/sparc/sparc64.h
index 5af4344459..131489689a 100644
--- a/include/hw/sparc/sparc64.h
+++ b/include/hw/sparc/sparc64.h
@@ -1,3 +1,4 @@
+/* FIXME Does not pass make check-headers, yet! */
 
 #define IVEC_MAX             0x40
 
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 3b1e7fce6c..953632d29f 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ASPEED_SMC_H
 #define ASPEED_SMC_H
 
diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index a0a0ae7584..7929546ad7 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XILINX_SPIPS_H
 #define XILINX_SPIPS_H
 
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwinner-a10-pit.h
index c0cc3e2169..16cfc0d62d 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALLWINNER_A10_PIT_H
 #define ALLWINNER_A10_PIT_H
 
diff --git a/include/hw/timer/i8254_internal.h b/include/hw/timer/i8254_internal.h
index c37a438f82..8d0e0ed17f 100644
--- a/include/hw/timer/i8254_internal.h
+++ b/include/hw/timer/i8254_internal.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_I8254_INTERNAL_H
 #define QEMU_I8254_INTERNAL_H
 
diff --git a/include/hw/timer/m48t59.h b/include/hw/timer/m48t59.h
index 6f8db04fce..bf71ecd137 100644
--- a/include/hw/timer/m48t59.h
+++ b/include/hw/timer/m48t59.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_M48T59_H
 #define HW_M48T59_H
 
diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rtc.h
index fe6ed63f71..a781ff1fb3 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/timer/mc146818rtc.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MC146818RTC_H
 #define MC146818RTC_H
 
diff --git a/include/hw/timer/mc146818rtc_regs.h b/include/hw/timer/mc146818rtc_regs.h
index c62f17bf2d..0b38971417 100644
--- a/include/hw/timer/mc146818rtc_regs.h
+++ b/include/hw/timer/mc146818rtc_regs.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MC146818RTC_REGS_H
 #define MC146818RTC_REGS_H
 
diff --git a/include/hw/timer/sun4v-rtc.h b/include/hw/timer/sun4v-rtc.h
index 407278f918..11ced390a3 100644
--- a/include/hw/timer/sun4v-rtc.h
+++ b/include/hw/timer/sun4v-rtc.h
@@ -1 +1,3 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 void sun4v_rtc_init(hwaddr addr);
diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zynqmp-rtc.h
index 5ba4d8bc4a..13a8dcaa11 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/timer/xlnx-zynqmp-rtc.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "hw/register.h"
 
 #define TYPE_XLNX_ZYNQMP_RTC "xlnx-zynmp.rtc"
diff --git a/include/hw/vfio/vfio-amd-xgbe.h b/include/hw/vfio/vfio-amd-xgbe.h
index 9fff65e99d..ced25a80ae 100644
--- a/include/hw/vfio/vfio-amd-xgbe.h
+++ b/include/hw/vfio/vfio-amd-xgbe.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef HW_VFIO_VFIO_AMD_XGBE_H
 #define HW_VFIO_VFIO_AMD_XGBE_H
 
diff --git a/include/hw/vfio/vfio-calxeda-xgmac.h b/include/hw/vfio/vfio-calxeda-xgmac.h
index f994775c09..29d48d4586 100644
--- a/include/hw/vfio/vfio-calxeda-xgmac.h
+++ b/include/hw/vfio/vfio-calxeda-xgmac.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef HW_VFIO_VFIO_CALXEDA_XGMAC_H
 #define HW_VFIO_VFIO_CALXEDA_XGMAC_H
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1155b79678..5190ce02b5 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -18,6 +18,8 @@
  *  Copyright (C) 2008, IBM, Muli Ben-Yehuda (muli@il.ibm.com)
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef HW_VFIO_VFIO_COMMON_H
 #define HW_VFIO_VFIO_COMMON_H
 
diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
index 30d3c28d3b..39140e1bba 100644
--- a/include/hw/vfio/vfio-platform.h
+++ b/include/hw/vfio/vfio-platform.h
@@ -13,6 +13,8 @@
  *  Copyright Red Hat, Inc. 2012
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef HW_VFIO_VFIO_PLATFORM_H
 #define HW_VFIO_VFIO_PLATFORM_H
 
diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index bdf58f3119..9a155f4c69 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -13,6 +13,9 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_VIRTIO_ACCESS_H
 #define QEMU_VIRTIO_ACCESS_H
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 60425c5d58..c629cf3298 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -11,6 +11,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef HW_VIRTIO_GPU_H
 #define HW_VIRTIO_GPU_H
 
diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-input.h
index 4fca03e796..0727d5449b 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_VIRTIO_INPUT_H
 #define QEMU_VIRTIO_INPUT_H
 
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rng.h
index 922dce7cac..ee650297c2 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -9,6 +9,8 @@
  * top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_VIRTIO_RNG_H
 #define QEMU_VIRTIO_RNG_H
 
diff --git a/include/hw/xen/io/ring.h b/include/hw/xen/io/ring.h
index 1adacf09f9..d8365494e0 100644
--- a/include/hw/xen/io/ring.h
+++ b/include/hw/xen/io/ring.h
@@ -24,6 +24,8 @@
  * Tim Deegan and Andrew Warfield November 2004.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef __XEN_PUBLIC_IO_RING_H__
 #define __XEN_PUBLIC_IO_RING_H__
 
diff --git a/include/hw/xen/xen-backend.h b/include/hw/xen/xen-backend.h
index 010d712638..9957c671c3 100644
--- a/include/hw/xen/xen-backend.h
+++ b/include/hw/xen/xen-backend.h
@@ -5,6 +5,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+
 #ifndef HW_XEN_BACKEND_H
 #define HW_XEN_BACKEND_H
 
diff --git a/include/hw/xen/xen-block.h b/include/hw/xen/xen-block.h
index 11d351b4b3..a1b02af5d6 100644
--- a/include/hw/xen/xen-block.h
+++ b/include/hw/xen/xen-block.h
@@ -5,6 +5,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+
 #ifndef HW_XEN_BLOCK_H
 #define HW_XEN_BLOCK_H
 
diff --git a/include/hw/xen/xen-bus-helper.h b/include/hw/xen/xen-bus-helper.h
index 4c0f747445..c48f224572 100644
--- a/include/hw/xen/xen-bus-helper.h
+++ b/include/hw/xen/xen-bus-helper.h
@@ -5,6 +5,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+
 #ifndef HW_XEN_BUS_HELPER_H
 #define HW_XEN_BUS_HELPER_H
 
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 3183f10e3c..cd02f66b59 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -5,6 +5,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+
 #ifndef HW_XEN_BUS_H
 #define HW_XEN_BUS_H
 
diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index 07d4176ac1..1857455284 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+
 #ifndef HW_XEN_LEGACY_BACKEND_H
 #define HW_XEN_LEGACY_BACKEND_H
 
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 9a8155e172..34ed53b9fc 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+
 #ifndef QEMU_HW_XEN_COMMON_H
 #define QEMU_HW_XEN_COMMON_H
 
diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
index 83e5174d90..7d33e0c230 100644
--- a/include/hw/xen/xen_pvdev.h
+++ b/include/hw/xen/xen_pvdev.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+
 #ifndef QEMU_HW_XEN_PVDEV_H
 #define QEMU_HW_XEN_PVDEV_H
 
diff --git a/include/libdecnumber/decNumberLocal.h b/include/libdecnumber/decNumberLocal.h
index 12cf1d8b6f..01ba6c7aea 100644
--- a/include/libdecnumber/decNumberLocal.h
+++ b/include/libdecnumber/decNumberLocal.h
@@ -37,6 +37,8 @@
 /* decNumber.h or one of decDouble (etc.) must be included first.     */
 /* ------------------------------------------------------------------ */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef DECNUMBERLOCAL_H
 #define DECNUMBERLOCAL_H
 
diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index a40bd3549f..4c8dde2e95 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -1,4 +1,8 @@
 /* Declarations for use for CPU state serialization.  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIGRATION_CPU_H
 #define MIGRATION_CPU_H
 
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 454e8ed155..c022fd3b39 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MONITOR_HMP_TARGET_H
 #define MONITOR_HMP_TARGET_H
 
diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index ddd0d55d31..8dcf19482d 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -10,6 +10,8 @@
  * atomic primitive is meant to provide.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_ATOMIC128_H
 #define QEMU_ATOMIC128_H
 
diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index 91ae88966e..0fa19d30df 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef QEMU_FUTEX_H
 #define QEMU_FUTEX_H
 
diff --git a/include/qemu/ratelimit.h b/include/qemu/ratelimit.h
index 1b38291823..efd6074823 100644
--- a/include/qemu/ratelimit.h
+++ b/include/qemu/ratelimit.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_RATELIMIT_H
 #define QEMU_RATELIMIT_H
 
diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index 50af5dd7ab..e09a7ba397 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_THREAD_WIN32_H
 #define QEMU_THREAD_WIN32_H
 
diff --git a/include/qemu/xattr.h b/include/qemu/xattr.h
index a83fe8e749..8dae5620e4 100644
--- a/include/qemu/xattr.h
+++ b/include/qemu/xattr.h
@@ -10,6 +10,9 @@
  * later version.  See the COPYING file in the top-level directory.
  *
  */
+
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef QEMU_XATTR_H
 #define QEMU_XATTR_H
 
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index c8f6145257..ec77a48925 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_BALLOON_H
 #define QEMU_BALLOON_H
 
diff --git a/include/sysemu/cryptodev-vhost-user.h b/include/sysemu/cryptodev-vhost-user.h
index 6debf53fc5..d2bbd854c4 100644
--- a/include/sysemu/cryptodev-vhost-user.h
+++ b/include/sysemu/cryptodev-vhost-user.h
@@ -20,6 +20,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  *
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CRYPTODEV_VHOST_USER_H
 #define CRYPTODEV_VHOST_USER_H
 
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index d824bc0941..e728f26e8e 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef DUMP_H
 #define DUMP_H
 
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 300bf3e9a8..f8d3e1802b 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -10,6 +10,9 @@
 
 /* header to be included in non-HVF-specific code */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HVF_H
 #define HVF_H
 
diff --git a/include/sysemu/iothread.h b/include/sysemu/iothread.h
index 5f6240d5cb..8d8af53df8 100644
--- a/include/sysemu/iothread.h
+++ b/include/sysemu/iothread.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef IOTHREAD_H
 #define IOTHREAD_H
 
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index f838412491..18f48589c1 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -6,6 +6,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_KVM_INT_H
 #define QEMU_KVM_INT_H
 
diff --git a/include/sysemu/memory_mapping.h b/include/sysemu/memory_mapping.h
index 58452457ce..6fb5b42cf1 100644
--- a/include/sysemu/memory_mapping.h
+++ b/include/sysemu/memory_mapping.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MEMORY_MAPPING_H
 #define MEMORY_MAPPING_H
 
diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index 629c8c648b..5a7dabe22c 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_POSIX, yet! */
+
 #ifndef QEMU_OS_POSIX_H
 #define QEMU_OS_POSIX_H
 
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index ff18b23db1..b828117bb6 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_WIN32, yet! */
+
 #ifndef QEMU_OS_WIN32_H
 #define QEMU_OS_WIN32_H
 
diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcache.h
index a03e2f1878..e3acb95b42 100644
--- a/include/sysemu/xen-mapcache.h
+++ b/include/sysemu/xen-mapcache.h
@@ -6,6 +6,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XEN_MAPCACHE_H
 #define XEN_MAPCACHE_H
 
diff --git a/include/trace-tcg.h b/include/trace-tcg.h
index da68608c85..6084376731 100644
--- a/include/trace-tcg.h
+++ b/include/trace-tcg.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TRACE_TCG_H
 #define TRACE_TCG_H
 
diff --git a/include/ui/console.h b/include/ui/console.h
index fef900db76..e209301433 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef CONSOLE_H
 #define CONSOLE_H
 
diff --git a/include/ui/egl-context.h b/include/ui/egl-context.h
index f004ce11a7..09de0bab21 100644
--- a/include/ui/egl-context.h
+++ b/include/ui/egl-context.h
@@ -1,3 +1,6 @@
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+/* FIXME Does not pass make check-headers without CONFIG_OPENGL, yet! */
+
 #ifndef EGL_CONTEXT_H
 #define EGL_CONTEXT_H
 
diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index b976cb8728..745781a2f1 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef EGL_HELPERS_H
 #define EGL_HELPERS_H
 
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index d9eedad976..1bad122097 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef UI_GTK_H
 #define UI_GTK_H
 
diff --git a/include/ui/input.h b/include/ui/input.h
index 8c8ccb999f..718f152f98 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef INPUT_H
 #define INPUT_H
 
diff --git a/include/ui/pixel_ops.h b/include/ui/pixel_ops.h
index d390adfd1b..18d5e181a6 100644
--- a/include/ui/pixel_ops.h
+++ b/include/ui/pixel_ops.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 static inline unsigned int rgb_to_pixel8(unsigned int r, unsigned int g,
                                          unsigned int b)
 {
diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 0668109305..a57e7f71a3 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -3,6 +3,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef QEMU_PIXMAN_H
 #define QEMU_PIXMAN_H
 
diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 0875b8d56b..c57525755f 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SDL2_H
 #define SDL2_H
 
diff --git a/include/ui/shader.h b/include/ui/shader.h
index 4c5acb2ce8..c062cac55f 100644
--- a/include/ui/shader.h
+++ b/include/ui/shader.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without CONFIG_OPENGL, yet! */
+
 #ifndef QEMU_SHADER_H
 #define QEMU_SHADER_H
 
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 53c3612c32..ce02c03a91 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -15,6 +15,8 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include <spice/ipc_ring.h>
 #include <spice/enums.h>
 #include <spice/qxl_dev.h>
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2b8d34ca25..16f9657553 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -15,6 +15,7 @@ check-help:
 	@echo " $(MAKE) check-tcg            Run TCG tests"
 	@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
 	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) tests"
+	@echo " $(MAKE) check-source         Run source code tests"
 	@echo
 	@echo " $(MAKE) check-report.html    Generates an HTML test report"
 	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
@@ -485,6 +486,7 @@ generated-files-y += tests/test-qapi-introspect.h
 
 QEMU_CFLAGS += -I$(SRC_PATH)/tests
 
+include $(SRC_PATH)/tests/check-headers.mak
 
 # Deps that are common to various different sets of tests below
 test-util-obj-y = libqemuutil.a
@@ -1147,13 +1149,38 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
             --failfast=on $(SRC_PATH)/tests/acceptance, \
             "AVOCADO", "tests/acceptance")
 
+# Header sanity checking
+
+RECURSIVE_TARGETS += check-headers check-bad-headers
+
+.PHONY: check-headers check-bad-headers
+ifeq ($(wildcard $(SRC_PATH)/.git),)
+check-headers check-bad-headers:
+	@echo "  SKIP  $@ (requires a git tree)"
+else
+check-headers: $(check-header-tests:.c=.o)
+check-headers: $(addsuffix /check-headers, $(TARGET_DIRS))
+
+# Expected to fail:
+check-bad-headers: $(check-bad-header-tests:.c=.o)
+check-bad-headers: $(addsuffix /check-bad-headers, $(TARGET_DIRS))
+
+.SECONDARY: $(check-header-tests) $(check-bad-header-tests)
+$(check-header-tests) $(check-bad-header-tests): tests/header-test-template.c
+	@mkdir -p $(dir $@)
+	@sed 's,@header@,$(subst tests/headers/,,$(@:.c=.h)),' <$< >$@
+endif
+
 # Consolidated targets
 
-.PHONY: check-block check-qapi-schema check-qtest check-unit check check-clean
+.PHONY: check-block check-qapi-schema check-qtest check-unit check-source
+.PHONY: check check-clean
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
-check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
+check-source: check-headers
+check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree check-source
+
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
@@ -1168,5 +1195,6 @@ all: $(QEMU_IOTESTS_HELPERS-y)
 
 -include $(wildcard tests/*.d)
 -include $(wildcard tests/libqos/*.d)
+-include $(check-header-tests:.c=.d) $(check-bad-header-tests:.c=.d)
 
 endif
diff --git a/tests/check-headers.mak b/tests/check-headers.mak
new file mode 100644
index 0000000000..1facce517e
--- /dev/null
+++ b/tests/check-headers.mak
@@ -0,0 +1,42 @@
+# -*- Mode: makefile -*-
+
+ifneq ($(wildcard $(SRC_PATH)/.git),)
+
+# All headers:
+src-headers := $(filter %.h, $(shell cd $(SRC_PATH) && git ls-files))
+
+# Third party headers we don't want to mess with:
+excluded-headers := $(filter disas/libvixl/vixl/% include/standard-headers/% linux-headers/% pc-bios/% slirp/%, $(src-headers))
+# Funny stuff we don't want to mess with:
+excluded-headers += $(filter tests/multiboot/% tests/tcg/% tests/uefi-test-tools/%, $(src-headers))
+excluded-headers += scripts/cocci-macro-file.h
+# Exclude all but include/ for now:
+excluded-headers += $(filter-out include/%, $(src-headers))
+
+# Headers that require -DNEED_CPU_H etc.
+target-header-comment := NOTE: May only be included into target-dependent code
+target-headers := $(shell cd $(SRC_PATH) && egrep -l '$(target-header-comment)' $(src-headers))
+
+# Headers carrying a FIXME about this test:
+bad-header-without-linux$(CONFIG_LINUX) := | without CONFIG_LINUX
+bad-header-without-opengl$(CONFIG_OPENGL) := | without CONFIG_OPENGL
+bad-header-without-posix$(CONFIG_POSIX) := | without CONFIG_POSIX
+bad-header-without-spice$(CONFIG_SPICE) := | without CONFIG_SPICE
+bad-header-without-system-emu$(TARGET_DIRS) := | without system emulation
+bad-header-without-win32$(CONFIG_WIN32) := | without CONFIG_WIN32
+bad-header-without-xen$(CONFIG_XEN) := | without CONFIG_XEN
+bad-header-comment := FIXME Does not pass make check-headers($(bad-header-without-linux)$(bad-header-without-opengl)$(bad-header-without-posix)$(bad-header-without-spice)$(bad-header-without-system-emu)$(bad-header-without-win32)$(bad-header-without-xen)), yet!
+bad-headers := $(shell cd $(SRC_PATH) && egrep -l '$(bad-header-comment)' $(src-headers))
+bad-target-headers := $(filter $(target-headers), $(bad-headers))
+
+# Checked headers (all less excluded and bad):
+checked-headers := $(filter-out $(excluded-headers) $(bad-headers) $(target-headers), $(src-headers))
+check-header-tests := $(patsubst %.h, tests/headers/%.c, $(checked-headers))
+checked-target-headers := $(filter-out $(excluded-headers) $(bad-headers), $(target-headers))
+check-target-header-tests := $(patsubst %.h, tests/headers/%.c, $(checked-target-headers))
+
+# Bad headers (all less excluded and checked):
+check-bad-header-tests := $(patsubst %.h, tests/headers/%.c, $(filter-out $(bad-target-headers), $(bad-headers)))
+check-bad-target-header-tests := $(patsubst %.h, tests/headers/%.c, $(bad-target-headers))
+
+endif
diff --git a/tests/header-test-template.c b/tests/header-test-template.c
new file mode 100644
index 0000000000..b6f86f4abc
--- /dev/null
+++ b/tests/header-test-template.c
@@ -0,0 +1,16 @@
+/*
+ * Template for make check-headers
+ *
+ * Copyright (C) 2016 Red Hat, Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "@header@"
+/* Include a second time to catch missing header guard */
+#include "@header@"
-- 
2.17.2


