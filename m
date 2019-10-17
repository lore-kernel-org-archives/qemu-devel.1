Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85467CA9EB3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5022B21D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT0mQUhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5022B21D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLEo9-0006kv-47
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 19:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEj0-0000vu-88
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEiy-0002Uc-O4
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:53090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEiy-0002UE-HS; Thu, 17 Oct 2019 18:58:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id r19so4179619wmh.2;
 Thu, 17 Oct 2019 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NVqM6/eMg5gUahCCntrXGBHs6P0goJRZ8NGaPOkjzKE=;
 b=AT0mQUhj8Uj2VNlxMoqKkcjmJL2BNduz/QbPN8gC5WjsItT8IrZ2rBZmUL/A2XfLIn
 xQLCvSZi3eCGGbYKPs4KinMBac+BzE7fwwRLzXICfISmb0PanwdSLQ6FVgwnGccIPkpn
 XDQmE3Le83iI+W2trWc8b9oKrafJzExguaqfy1iF63gbFvistNeAUo+CMTHHiSnIy87f
 EahHnc3fCdhrDl8SH39zlgPUp+JiZd7YXWOLENTNSQzacpkyUYVIKok6pSfo/w+aXAlS
 Jpj/sI7U8xMyuE0kczcX1cyyvfWLIrkNchz3l+sqFLr0imtOZ3r5LExsBwEM9IxWNByD
 GNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NVqM6/eMg5gUahCCntrXGBHs6P0goJRZ8NGaPOkjzKE=;
 b=gB2uL3PL2nvl2wwBbCNBFBtwC944LLvds1Hw+G1iWf4Rgas2Kqkjvm6g39w9Row5oX
 dSNTXy8AA8wZmdG1kHBHOusjYeg6FxaQEvkeYch04780dRurU4D/WBltZRLO9PK6dTId
 VCw6lsAGwj7yBK3HiX1tIt3YZ0wHQ/D0HPrDpruyHj5PbXv2PDu+PtwrQxg1Bgp78gkr
 BlxXtYk2mbi0giZrn+E9D358br1LKKc12MTYDlE28U9NUqBuR9vOr6tUZcEaoMFpXUzW
 RA/kYUQnJLWf9u4cId/mugFRJkciZNnybqtHqCdVn7h3j/q1D8PejPT+5kUx8LdCmfx3
 aahw==
X-Gm-Message-State: APjAAAULiHXthOO1EpQPkzCoZ22qSkLf7zDtJAAANQ3McKnfMANJaDkN
 aknljUMVbcYkuTexa3xBRXsisNfN
X-Google-Smtp-Source: APXvYqwa/M18m3UlLHb+vs9rS6psHfXWO+zZiRfuhpibu6Emp75+iKVTq+pUgX3pdnbhE9RZkwviCg==
X-Received: by 2002:a1c:2306:: with SMTP id j6mr4962500wmj.96.1571353106977;
 Thu, 17 Oct 2019 15:58:26 -0700 (PDT)
Received: from localhost.localdomain (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id m18sm3993873wrg.97.2019.10.17.15.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 15:58:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/10] hw/arm/raspi: Make the board code modular
Date: Fri, 18 Oct 2019 00:57:59 +0200
Message-Id: <20191017225800.6946-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017225800.6946-1-f4bug@amsat.org>
References: <20191017225800.6946-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Pekka Enberg <penberg@iki.fi>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Pete Batard <pete@akeo.ie>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>
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
index 569d85c11a..7ccb6ceb4f 100644
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
@@ -116,7 +176,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     static struct arm_boot_info binfo;
     int r;
 
-    binfo.board_id = raspi_boardid[version];
+    binfo.board_id = bcm283x_boards[version].board_id;
     binfo.ram_size = ram_size;
     binfo.nb_cpus = machine->smp.cpus;
 
@@ -148,7 +208,7 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
      * the normal Linux boot process
      */
     if (machine->firmware) {
-        hwaddr firmware_addr = version == 3 ? FIRMWARE_ADDR_3 : FIRMWARE_ADDR_2;
+        hwaddr firmware_addr = version >= 3 ? FIRMWARE_ADDR_3 : FIRMWARE_ADDR_2;
         /* load the firmware image (typically kernel.img) */
         r = load_image_targphys(machine->firmware, firmware_addr,
                                 ram_size - firmware_addr);
@@ -172,16 +232,32 @@ static void raspi_init(MachineState *machine, int version)
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
2.21.0


