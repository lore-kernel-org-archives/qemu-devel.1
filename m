Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D73C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 05:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D510B2145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 05:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D510B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnG8J-0001i5-Ql
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 01:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46488)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hnG87-0001Fe-CG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 01:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hnG84-00065S-R1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 01:35:59 -0400
Received: from ozlabs.ru ([107.173.13.209]:58124)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1hnG84-00063k-JB; Tue, 16 Jul 2019 01:35:56 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id B68E8AE80597;
 Tue, 16 Jul 2019 01:35:19 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 15:35:22 +1000
Message-Id: <20190716053522.78813-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 107.173.13.209
Subject: [Qemu-devel] [RFC PATCH qemu] spapr: Stop providing RTAS blob
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SLOF implements one itself so let's remove it from QEMU. It is one less
image and simpler setup as the RTAS blob never stays in its initial place
anyway as the guest OS always decides where to put it.

This totally depends on https://patchwork.ozlabs.org/patch/1132440/ ,
hence RFC.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 configure                       |   6 +----
 Makefile                        |   2 +-
 pc-bios/spapr-rtas/Makefile     |  27 ---------------------
 include/hw/ppc/spapr.h          |   2 --
 hw/ppc/spapr.c                  |  32 ++-----------------------
 hw/ppc/spapr_rtas.c             |  41 --------------------------------
 MAINTAINERS                     |   2 --
 pc-bios/spapr-rtas.bin          | Bin 20 -> 0 bytes
 pc-bios/spapr-rtas/spapr-rtas.S |  37 ----------------------------
 9 files changed, 4 insertions(+), 145 deletions(-)
 delete mode 100644 pc-bios/spapr-rtas/Makefile
 delete mode 100644 pc-bios/spapr-rtas.bin
 delete mode 100644 pc-bios/spapr-rtas/spapr-rtas.S

diff --git a/configure b/configure
index 4983c8b53300..a132d2eb5666 100755
--- a/configure
+++ b/configure
@@ -6205,9 +6205,6 @@ if { test "$cpu" = "i386" || test "$cpu" = "x86_64"; } && \
         fi
     done
 fi
-if test "$ARCH" = "ppc64" && test "$targetos" != "Darwin" ; then
-  roms="$roms spapr-rtas"
-fi
 
 # Only build s390-ccw bios if we're on s390x and the compiler has -march=z900
 if test "$cpu" = "s390x" ; then
@@ -7919,14 +7916,13 @@ fi
 DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
 DIRS="$DIRS tests/fp tests/qgraph"
 DIRS="$DIRS docs docs/interop fsdev scsi"
-DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
+DIRS="$DIRS pc-bios/optionrom pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
 LINKS="Makefile tests/tcg/Makefile"
 LINKS="$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
 LINKS="$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
 LINKS="$LINKS tests/fp/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
-LINKS="$LINKS pc-bios/spapr-rtas/Makefile"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
 LINKS="$LINKS pc-bios/qemu-icon.bmp"
diff --git a/Makefile b/Makefile
index 1fcbaed62c76..d780f4eebceb 100644
--- a/Makefile
+++ b/Makefile
@@ -764,7 +764,7 @@ efi-e1000e.rom efi-vmxnet3.rom \
 bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb \
 multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \
 s390-ccw.img s390-netboot.img \
-spapr-rtas.bin slof.bin skiboot.lid \
+slof.bin skiboot.lid \
 palcode-clipper \
 u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
diff --git a/pc-bios/spapr-rtas/Makefile b/pc-bios/spapr-rtas/Makefile
deleted file mode 100644
index 4b9bb1230658..000000000000
--- a/pc-bios/spapr-rtas/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-all: build-all
-# Dummy command so that make thinks it has done something
-	@true
-
-include ../../config-host.mak
-include $(SRC_PATH)/rules.mak
-
-$(call set-vpath, $(SRC_PATH)/pc-bios/spapr-rtas)
-
-.PHONY : all clean build-all
-
-#CFLAGS += -I$(SRC_PATH)
-#QEMU_CFLAGS = $(CFLAGS)
-
-build-all: spapr-rtas.bin
-
-%.o: %.S
-	$(call quiet-command,$(CCAS) -mbig -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
-
-%.img: %.o
-	$(call quiet-command,$(CC) -nostdlib -mbig -o $@ $<,"Building","$(TARGET_DIR)$@")
-
-%.bin: %.img
-	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"Building","$(TARGET_DIR)$@")
-
-clean:
-	rm -f *.o *.d *.img *.bin *~
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 60553d32c4fa..b6640370c839 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -152,8 +152,6 @@ struct SpaprMachineState {
 
     hwaddr rma_size;
     int vrma_adjust;
-    ssize_t rtas_size;
-    void *rtas_blob;
     uint32_t fdt_size;
     uint32_t fdt_initial_size;
     void *fdt_blob;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8783b433960c..36cd45bd78b3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -89,7 +89,6 @@
  * We load our kernel at 4M, leaving space for SLOF initial image
  */
 #define FDT_MAX_SIZE            0x100000
-#define RTAS_MAX_SIZE           0x10000
 #define RTAS_MAX_ADDR           0x80000000 /* RTAS must stay below that */
 #define FW_MAX_SIZE             0x400000
 #define FW_FILE_NAME            "slof.bin"
@@ -1704,8 +1703,7 @@ static void spapr_machine_reset(MachineState *machine)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(machine);
     PowerPCCPU *first_ppc_cpu;
-    uint32_t rtas_limit;
-    hwaddr rtas_addr, fdt_addr;
+    hwaddr fdt_addr;
     void *fdt;
     int rc;
 
@@ -1783,14 +1781,10 @@ static void spapr_machine_reset(MachineState *machine)
      * or just below 2GB, whichever is lower, so that it can be
      * processed with 32-bit real mode code if necessary
      */
-    rtas_limit = MIN(spapr->rma_size, RTAS_MAX_ADDR);
-    rtas_addr = rtas_limit - RTAS_MAX_SIZE;
-    fdt_addr = rtas_addr - FDT_MAX_SIZE;
+    fdt_addr = RTAS_MAX_ADDR - FDT_MAX_SIZE;
 
     fdt = spapr_build_fdt(spapr);
 
-    spapr_load_rtas(spapr, fdt, rtas_addr);
-
     rc = fdt_pack(fdt);
 
     /* Should only fail if we've built a corrupted tree */
@@ -2906,28 +2900,6 @@ static void spapr_machine_init(MachineState *machine)
         spapr_create_lmb_dr_connectors(spapr);
     }
 
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, "spapr-rtas.bin");
-    if (!filename) {
-        error_report("Could not find LPAR rtas '%s'", "spapr-rtas.bin");
-        exit(1);
-    }
-    spapr->rtas_size = get_image_size(filename);
-    if (spapr->rtas_size < 0) {
-        error_report("Could not get size of LPAR rtas '%s'", filename);
-        exit(1);
-    }
-    spapr->rtas_blob = g_malloc(spapr->rtas_size);
-    if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) < 0) {
-        error_report("Could not load LPAR rtas '%s'", filename);
-        exit(1);
-    }
-    if (spapr->rtas_size > RTAS_MAX_SIZE) {
-        error_report("RTAS too big ! 0x%zx bytes (max is 0x%x)",
-                     (size_t)spapr->rtas_size, RTAS_MAX_SIZE);
-        exit(1);
-    }
-    g_free(filename);
-
     /* Set up RTAS event infrastructure */
     spapr_events_init(spapr);
 
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index a618a2ac0f3f..b30a5817d7a8 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -431,47 +431,6 @@ void spapr_dt_rtas_tokens(void *fdt, int rtas)
     }
 }
 
-void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr)
-{
-    int rtas_node;
-    int ret;
-
-    /* Copy RTAS blob into guest RAM */
-    cpu_physical_memory_write(addr, spapr->rtas_blob, spapr->rtas_size);
-
-    ret = fdt_add_mem_rsv(fdt, addr, spapr->rtas_size);
-    if (ret < 0) {
-        error_report("Couldn't add RTAS reserve entry: %s",
-                     fdt_strerror(ret));
-        exit(1);
-    }
-
-    /* Update the device tree with the blob's location */
-    rtas_node = fdt_path_offset(fdt, "/rtas");
-    assert(rtas_node >= 0);
-
-    ret = fdt_setprop_cell(fdt, rtas_node, "linux,rtas-base", addr);
-    if (ret < 0) {
-        error_report("Couldn't add linux,rtas-base property: %s",
-                     fdt_strerror(ret));
-        exit(1);
-    }
-
-    ret = fdt_setprop_cell(fdt, rtas_node, "linux,rtas-entry", addr);
-    if (ret < 0) {
-        error_report("Couldn't add linux,rtas-entry property: %s",
-                     fdt_strerror(ret));
-        exit(1);
-    }
-
-    ret = fdt_setprop_cell(fdt, rtas_node, "rtas-size", spapr->rtas_size);
-    if (ret < 0) {
-        error_report("Couldn't add rtas-size property: %s",
-                     fdt_strerror(ret));
-        exit(1);
-    }
-}
-
 static void core_rtas_register_types(void)
 {
     spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
diff --git a/MAINTAINERS b/MAINTAINERS
index cc9636b43aab..11b9a4f6fa25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1070,8 +1070,6 @@ F: hw/*/spapr*
 F: include/hw/*/spapr*
 F: hw/*/xics*
 F: include/hw/*/xics*
-F: pc-bios/spapr-rtas/*
-F: pc-bios/spapr-rtas.bin
 F: pc-bios/slof.bin
 F: docs/specs/ppc-spapr-hcalls.txt
 F: docs/specs/ppc-spapr-hotplug.txt
diff --git a/pc-bios/spapr-rtas.bin b/pc-bios/spapr-rtas.bin
deleted file mode 100644
index fc24c8ed8b92a3a441aed6e2bd013b2ccece9229..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 20
bcmb<Pk*=^wU|>i{{=neEz@X&Uz@PvCJTV0q

diff --git a/pc-bios/spapr-rtas/spapr-rtas.S b/pc-bios/spapr-rtas/spapr-rtas.S
deleted file mode 100644
index 903bec215077..000000000000
--- a/pc-bios/spapr-rtas/spapr-rtas.S
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware System Emulator
- *
- * Trivial in-partition RTAS implementation, based on a hypercall
- *
- * Copyright (c) 2010,2011 David Gibson, IBM Corporation.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- *
- */
-
-#define KVMPPC_HCALL_BASE       0xf000
-#define KVMPPC_H_RTAS           (KVMPPC_HCALL_BASE + 0x0)
-
-.globl	_start
-_start:
-	mr	4,3
-	lis	3,KVMPPC_H_RTAS@h
-	ori	3,3,KVMPPC_H_RTAS@l
-	sc	1
-	blr
-- 
2.17.1


