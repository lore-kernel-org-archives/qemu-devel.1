Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81330C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2422087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjvILWiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2422087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Z1r-0003fT-Pi
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqe-0001bJ-Im
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqc-00076a-Rd
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5Yqc-00075x-KI; Wed, 04 Sep 2019 13:13:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id p13so4718393wmh.1;
 Wed, 04 Sep 2019 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4gzUK0T14zOkKkQ8x5EXERw/Gf3VD/73/5zTDUcL1hE=;
 b=BjvILWiF4qLG6ydc7sXZV+b4ENFYfebY0bn/ATMruaE57xjZHcEy1doK+ktwFAzi4y
 OY3krr0DIOH8ohQnKj9WJ4OFFYu7QeXYP0Z+kRhCbY1JiUs16kd40YcfM8EFvhnLgXti
 EJKq9UMhxKEIs1phJyIRTsoqdfjiDwMLk/4ky+L59GmsGof3ZHLf7pawxmGwbjDF25a+
 g1cL52h5CLnVz1p5DYMn49SEhVD1w5upXEFYhQgfVkUt3psHeTKj+nA2jH5FDTce7Nq+
 zeq3pj+0z55kYnTyQBTQxFId6xYWRtVKVYrGqxXnopVkvYG/glSUwdwmhmwKO4vUWYeV
 S00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4gzUK0T14zOkKkQ8x5EXERw/Gf3VD/73/5zTDUcL1hE=;
 b=du1T94+elOrqeVpkZllyL43EqtoMg98qm9+QPnSPsrCrMBs+pKDzuYF0EYpVCRwuEv
 V2ODIl1xiYHFFxW3gdhAQaw6QX93DC84DSuL4wtbm7OvdpEDwOX9wA0Sseu6++63ZSJj
 B2FJkdj2SvCdYGvtc8MSqm2tnv5tEymKzzxTscw+vBFYtdsrHE83BjUQ+0VMSXxBCdyM
 Etz4Rtl14eMYP0C1tGwx4IlmLcWBauAtNzJsQgvoTZcdCwcXCggDKwVpuTgdj+EsjqXZ
 ct5PQ91uCdDjJ9WECdIK1nGJW+r25SNH3oaWFwuSHA2AB4YJ8xNRJ4k2VXBalI4L21iL
 BEUg==
X-Gm-Message-State: APjAAAUiorXQ1vBdJmOWvom8iTKEUrEqGOK+K0Bmach9QjCErw5nHQle
 4/Gpdw4O+32esopjR+6Dy3w=
X-Google-Smtp-Source: APXvYqxfU9TXdwhXvhUG78+dsMWEZ1MePNFEJRIKUMXfhMSHDpuurfJddriMoTQ7T1jEA/FEEzgHzw==
X-Received: by 2002:a1c:6c11:: with SMTP id h17mr5120240wmc.128.1567617213584; 
 Wed, 04 Sep 2019 10:13:33 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:10 +0200
Message-Id: <20190904171315.8354-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 09/14] hw/arm/raspi: Make the board code modular
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our code currently create the raspi2 (based on the BCM2836)
and the raspi3 (on the BCM2837). Similarly, the raspi4 is
based on the BCM2838. To be able to add the new board,
make the current code more modular:

- Dynamically fills the 'board-rev' value
- Allow DRAM sizes different than 1 GiB

Rename the board model name as 'B' since this is the one
encoded in the 'board-rev' tag.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 107 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 94 insertions(+), 13 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 615d755879..b4db39661f 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/arm/bcm2836.h"
@@ -29,8 +30,67 @@
 #define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by default */
 #define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
 
-/* Table of Linux board IDs for different Pi versions */
-static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43, [3] = 0xc44};
+enum BoardIdManufacturer {
+    M_SONY_UK = 0,
+    M_EMBEST = 2,
+};
+
+enum BoardIdChip {
+    C_BCM2835 = 0,
+    C_BCM2836 = 1,
+    C_BCM2837 = 2,
+};
+
+enum BoardIdType {
+    T_2B = 0x04,
+    T_3B = 0x08,
+};
+
+enum BoardIdRevision {
+    R_1_0 = 0,
+    R_1_1 = 1,
+    R_1_2 = 2,
+    R_1_3 = 3,
+};
+
+static const char *processor_typename[] = {
+    [C_BCM2836] = TYPE_BCM2836,
+    [C_BCM2837] = TYPE_BCM2837,
+};
+
+typedef struct BoardInfo BoardInfo;
+
+struct BoardInfo {
+    /* Table of Linux board IDs for different Pi versions */
+    int board_id;
+    /*
+     * Board revision codes:
+     * www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/
+     */
+    struct {
+        enum BoardIdType type;
+        enum BoardIdRevision revision;
+        enum BoardIdChip chip;
+        enum BoardIdManufacturer manufacturer;
+    } board_rev;
+    uint64_t ram_size_min;
+    uint64_t ram_size_max;
+};
+
+static const BoardInfo bcm283x_boards[] = {
+    [2] = {
+        .board_id = 0xc43,
+        .board_rev = { T_2B, R_1_1, C_BCM2836, M_EMBEST },
+        .ram_size_min = 1 * GiB,
+        .ram_size_max = 1 * GiB,
+    },
+    [3] = {
+        .board_id = 0xc44,
+        .board_rev = { T_3B, R_1_2, C_BCM2837, M_SONY_UK },
+        .ram_size_min = 1 * GiB,
+        .ram_size_max = 1 * GiB,
+    },
+};
 
 typedef struct RasPiState {
     BCM283XState soc;
@@ -114,7 +174,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     static struct arm_boot_info binfo;
     int r;
 
-    binfo.board_id = raspi_boardid[version];
+    binfo.board_id = bcm283x_boards[version].board_id;
     binfo.ram_size = ram_size;
     binfo.nb_cpus = machine->smp.cpus;
 
@@ -146,7 +206,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
      * the normal Linux boot process
      */
     if (machine->firmware) {
-        hwaddr firmware_addr = version == 3 ? FIRMWARE_ADDR_3 : FIRMWARE_ADDR_2;
+        hwaddr firmware_addr = version >= 3 ? FIRMWARE_ADDR_3 : FIRMWARE_ADDR_2;
         /* load the firmware image (typically kernel.img) */
         r = load_image_targphys(machine->firmware, firmware_addr,
                                 ram_size - firmware_addr);
@@ -170,16 +230,32 @@ static void raspi_init(MachineState *machine, int version)
     BlockBackend *blk;
     BusState *bus;
     DeviceState *carddev;
+    char *size_str;
+    int board_rev;
+    const char *soc_type;
 
-    if (machine->ram_size > 1 * GiB) {
+    if (machine->ram_size < bcm283x_boards[version].ram_size_min) {
+        size_str = size_to_str(bcm283x_boards[version].ram_size_min);
+        error_report("Requested ram size is too small for this machine: "
+                     "minimum is %s", size_str);
+        g_free(size_str);
+        exit(1);
+    }
+    if (machine->ram_size > bcm283x_boards[version].ram_size_max) {
+        size_str = size_to_str(bcm283x_boards[version].ram_size_max);
         error_report("Requested ram size is too large for this machine: "
-                     "maximum is 1GB");
+                     "maximum is %s", size_str);
+        g_free(size_str);
+        exit(1);
+    }
+    if (!is_power_of_2(machine->ram_size)) {
+        error_report("Requested ram size is not a power of 2");
         exit(1);
     }
 
+    soc_type = processor_typename[bcm283x_boards[version].board_rev.chip];
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            version == 3 ? TYPE_BCM2837 : TYPE_BCM2836,
-                            &error_abort, NULL);
+                            soc_type, &error_abort, NULL);
 
     /* Allocate and map RAM */
     memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
@@ -192,9 +268,14 @@ static void raspi_init(MachineState *machine, int version)
                                    &error_abort);
     object_property_set_int(OBJECT(&s->soc), machine->smp.cpus, "enabled-cpus",
                             &error_abort);
-    int board_rev = version == 3 ? 0xa02082 : 0xa21041;
-    object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
-                            &error_abort);
+
+    board_rev = ((63 - clz64(machine->ram_size / MiB)) << 20)
+                | (bcm283x_boards[version].board_rev.manufacturer << 16)
+                | (bcm283x_boards[version].board_rev.chip << 12)
+                | (bcm283x_boards[version].board_rev.type << 4)
+                | (bcm283x_boards[version].board_rev.revision << 0);
+    object_property_set_int(OBJECT(&s->soc), board_rev,
+                            "board-rev", &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_abort);
 
     /* Create and plug in the SD cards */
@@ -221,7 +302,7 @@ static void raspi2_init(MachineState *machine)
 
 static void raspi2_machine_init(MachineClass *mc)
 {
-    mc->desc = "Raspberry Pi 2";
+    mc->desc = "Raspberry Pi 2B";
     mc->init = raspi2_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
@@ -243,7 +324,7 @@ static void raspi3_init(MachineState *machine)
 
 static void raspi3_machine_init(MachineClass *mc)
 {
-    mc->desc = "Raspberry Pi 3";
+    mc->desc = "Raspberry Pi 3B";
     mc->init = raspi3_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
-- 
2.20.1


