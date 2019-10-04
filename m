Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76792C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4198B207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RN7es1HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4198B207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGK8c-0003RC-L7
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2N-00050L-0k
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGK2J-00058L-Vx
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:38:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50269 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iGK2J-00054u-G1; Fri, 04 Oct 2019 05:38:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4YJ3d4Tz9sRk; Fri,  4 Oct 2019 19:37:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570181876;
 bh=qhp8RHf096mOtp4D26s6Ge6sWpLOYvIR3lVQ9gNlcXg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RN7es1HVXtjuUw39+XBI7wA4LhPA5YbYcqrYCUqe48LGmT5zHZIhA3L9PrVhH0nQM
 ZxPkSImqmanbIJTxfDf8YHbURekGkJ02pAM+3XtvnEjY3BQY7dvUBmTLsqSrzmw/3p
 e8nyQ+lfyFCveWqkh1l/Xbi7wVM5c1jEpSXQi1JU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 20/53] spapr: Stop providing RTAS blob
Date: Fri,  4 Oct 2019 19:37:14 +1000
Message-Id: <20191004093747.31350-21-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

SLOF implements one itself so let's remove it from QEMU. It is one less
image and simpler setup as the RTAS blob never stays in its initial place
anyway as the guest OS always decides where to put it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS                     |   2 --
 Makefile                        |   2 +-
 configure                       |   6 +----
 hw/ppc/spapr.c                  |  32 ++-----------------------
 hw/ppc/spapr_rtas.c             |  41 --------------------------------
 include/hw/ppc/spapr.h          |   2 --
 pc-bios/spapr-rtas.bin          | Bin 20 -> 0 bytes
 pc-bios/spapr-rtas/Makefile     |  27 ---------------------
 pc-bios/spapr-rtas/spapr-rtas.S |  37 ----------------------------
 9 files changed, 4 insertions(+), 145 deletions(-)
 delete mode 100644 pc-bios/spapr-rtas.bin
 delete mode 100644 pc-bios/spapr-rtas/Makefile
 delete mode 100644 pc-bios/spapr-rtas/spapr-rtas.S

diff --git a/MAINTAINERS b/MAINTAINERS
index 21264eae9c..3ca814850e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1077,8 +1077,6 @@ F: hw/*/spapr*
 F: include/hw/*/spapr*
 F: hw/*/xics*
 F: include/hw/*/xics*
-F: pc-bios/spapr-rtas/*
-F: pc-bios/spapr-rtas.bin
 F: pc-bios/slof.bin
 F: docs/specs/ppc-spapr-hcalls.txt
 F: docs/specs/ppc-spapr-hotplug.txt
diff --git a/Makefile b/Makefile
index 8da33595ed..30f0abfb42 100644
--- a/Makefile
+++ b/Makefile
@@ -769,7 +769,7 @@ qemu-nsis.bmp \
 bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb =
\
 multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin pvh.bin \
 s390-ccw.img s390-netboot.img \
-spapr-rtas.bin slof.bin skiboot.lid \
+slof.bin skiboot.lid \
 palcode-clipper \
 u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
diff --git a/configure b/configure
index 8f8446f52b..08ca4bcb46 100755
--- a/configure
+++ b/configure
@@ -6166,9 +6166,6 @@ if { test "$cpu" =3D "i386" || test "$cpu" =3D "x86=
_64"; } && \
         fi
     done
 fi
-if test "$ARCH" =3D "ppc64" && test "$targetos" !=3D "Darwin" ; then
-  roms=3D"$roms spapr-rtas"
-fi
=20
 # Only build s390-ccw bios if we're on s390x and the compiler has -march=
=3Dz900
 if test "$cpu" =3D "s390x" ; then
@@ -7800,13 +7797,12 @@ fi
 DIRS=3D"tests tests/tcg tests/tcg/lm32 tests/libqos tests/qapi-schema te=
sts/qemu-iotests tests/vm"
 DIRS=3D"$DIRS tests/fp tests/qgraph"
 DIRS=3D"$DIRS docs docs/interop fsdev scsi"
-DIRS=3D"$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
+DIRS=3D"$DIRS pc-bios/optionrom pc-bios/s390-ccw"
 DIRS=3D"$DIRS roms/seabios roms/vgabios"
 LINKS=3D"Makefile"
 LINKS=3D"$LINKS tests/tcg/lm32/Makefile po/Makefile"
 LINKS=3D"$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
 LINKS=3D"$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
-LINKS=3D"$LINKS pc-bios/spapr-rtas/Makefile"
 LINKS=3D"$LINKS pc-bios/s390-ccw/Makefile"
 LINKS=3D"$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
 LINKS=3D"$LINKS pc-bios/qemu-icon.bmp"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f1c57c21cc..3742a8cf06 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -96,7 +96,6 @@
  * We load our kernel at 4M, leaving space for SLOF initial image
  */
 #define FDT_MAX_SIZE            0x100000
-#define RTAS_MAX_SIZE           0x10000
 #define RTAS_MAX_ADDR           0x80000000 /* RTAS must stay below that =
*/
 #define FW_MAX_SIZE             0x400000
 #define FW_FILE_NAME            "slof.bin"
@@ -1723,8 +1722,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
     PowerPCCPU *first_ppc_cpu;
-    uint32_t rtas_limit;
-    hwaddr rtas_addr, fdt_addr;
+    hwaddr fdt_addr;
     void *fdt;
     int rc;
=20
@@ -1788,14 +1786,10 @@ static void spapr_machine_reset(MachineState *mac=
hine)
      * or just below 2GB, whichever is lower, so that it can be
      * processed with 32-bit real mode code if necessary
      */
-    rtas_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR);
-    rtas_addr =3D rtas_limit - RTAS_MAX_SIZE;
-    fdt_addr =3D rtas_addr - FDT_MAX_SIZE;
+    fdt_addr =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
=20
     fdt =3D spapr_build_fdt(spapr);
=20
-    spapr_load_rtas(spapr, fdt, rtas_addr);
-
     rc =3D fdt_pack(fdt);
=20
     /* Should only fail if we've built a corrupted tree */
@@ -2955,28 +2949,6 @@ static void spapr_machine_init(MachineState *machi=
ne)
         spapr_create_lmb_dr_connectors(spapr);
     }
=20
-    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, "spapr-rtas.bin");
-    if (!filename) {
-        error_report("Could not find LPAR rtas '%s'", "spapr-rtas.bin");
-        exit(1);
-    }
-    spapr->rtas_size =3D get_image_size(filename);
-    if (spapr->rtas_size < 0) {
-        error_report("Could not get size of LPAR rtas '%s'", filename);
-        exit(1);
-    }
-    spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
-    if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) < =
0) {
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
=20
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index bee3835214..8d8d8cdfcb 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -477,47 +477,6 @@ void spapr_dt_rtas_tokens(void *fdt, int rtas)
     }
 }
=20
-void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr)
-{
-    int rtas_node;
-    int ret;
-
-    /* Copy RTAS blob into guest RAM */
-    cpu_physical_memory_write(addr, spapr->rtas_blob, spapr->rtas_size);
-
-    ret =3D fdt_add_mem_rsv(fdt, addr, spapr->rtas_size);
-    if (ret < 0) {
-        error_report("Couldn't add RTAS reserve entry: %s",
-                     fdt_strerror(ret));
-        exit(1);
-    }
-
-    /* Update the device tree with the blob's location */
-    rtas_node =3D fdt_path_offset(fdt, "/rtas");
-    assert(rtas_node >=3D 0);
-
-    ret =3D fdt_setprop_cell(fdt, rtas_node, "linux,rtas-base", addr);
-    if (ret < 0) {
-        error_report("Couldn't add linux,rtas-base property: %s",
-                     fdt_strerror(ret));
-        exit(1);
-    }
-
-    ret =3D fdt_setprop_cell(fdt, rtas_node, "linux,rtas-entry", addr);
-    if (ret < 0) {
-        error_report("Couldn't add linux,rtas-entry property: %s",
-                     fdt_strerror(ret));
-        exit(1);
-    }
-
-    ret =3D fdt_setprop_cell(fdt, rtas_node, "rtas-size", spapr->rtas_si=
ze);
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
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index dfec8e8e76..cbd1a4c9f3 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -154,8 +154,6 @@ struct SpaprMachineState {
=20
     hwaddr rma_size;
     int vrma_adjust;
-    ssize_t rtas_size;
-    void *rtas_blob;
     uint32_t fdt_size;
     uint32_t fdt_initial_size;
     void *fdt_blob;
diff --git a/pc-bios/spapr-rtas.bin b/pc-bios/spapr-rtas.bin
deleted file mode 100644
index fc24c8ed8b92a3a441aed6e2bd013b2ccece9229..0000000000000000000000000=
000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 20
bcmb<Pk*=3D^wU|>i{{=3DneEz@X&Uz@PvCJTV0q

diff --git a/pc-bios/spapr-rtas/Makefile b/pc-bios/spapr-rtas/Makefile
deleted file mode 100644
index 4b9bb12306..0000000000
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
-#CFLAGS +=3D -I$(SRC_PATH)
-#QEMU_CFLAGS =3D $(CFLAGS)
-
-build-all: spapr-rtas.bin
-
-%.o: %.S
-	$(call quiet-command,$(CCAS) -mbig -c -o $@ $<,"CCAS","$(TARGET_DIR)$@"=
)
-
-%.img: %.o
-	$(call quiet-command,$(CC) -nostdlib -mbig -o $@ $<,"Building","$(TARGE=
T_DIR)$@")
-
-%.bin: %.img
-	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"Building","$(=
TARGET_DIR)$@")
-
-clean:
-	rm -f *.o *.d *.img *.bin *~
diff --git a/pc-bios/spapr-rtas/spapr-rtas.S b/pc-bios/spapr-rtas/spapr-r=
tas.S
deleted file mode 100644
index 903bec2150..0000000000
--- a/pc-bios/spapr-rtas/spapr-rtas.S
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware System Em=
ulator
- *
- * Trivial in-partition RTAS implementation, based on a hypercall
- *
- * Copyright (c) 2010,2011 David Gibson, IBM Corporation.
- *
- * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
- * of this software and associated documentation files (the "Software"),=
 to deal
- * in the Software without restriction, including without limitation the=
 rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be includ=
ed in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
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
--=20
2.21.0


