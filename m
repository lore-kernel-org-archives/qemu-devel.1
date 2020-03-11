Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6943CC2BAEE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5795D2074F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbPUho9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5795D2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC9kb-0002Ls-Bj
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC9h5-0003l8-MV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jC9h4-0004vG-2J
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:19:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jC9h3-0004rl-RM; Wed, 11 Mar 2020 18:19:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id p2so4798409wrw.7;
 Wed, 11 Mar 2020 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qq6b6ICYIOoBAymh+VHaM26CGU8Ea8JY2eFdBqFq9Ok=;
 b=SbPUho9bzLUffCbg9f0+tPZYRdexvqVQqEs+9mq5jUl2ieCqtOBVmDiHfWNWg2D8sK
 K4MNjLIsa/mDyGdHkaAYJOXdQp9Mh7IrVKC/sfU/ro2vmSm63LgsWEfHm10Qq6+xBN7F
 O3XDQiR6Uno4VqSe+gvJ34jLIcTeac/tEF2AVk0peMlPj4bYyhErMpxQXRuOqTFrnyrr
 D6aM18biwqcYi7HKPIthvygMGLkUsNUxq9lF+hZv4tM26+3d1MgJLC1JNF0QdY5hvxxS
 AiAeCm9/JHotNh3w3YO5kA1pvYgw/2LpNnpNf5JV4rNyGDCUPV8j+p+5FhqTDdu3+GCV
 dhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qq6b6ICYIOoBAymh+VHaM26CGU8Ea8JY2eFdBqFq9Ok=;
 b=gJ5ixlJ2YQ9upQMULGFTmsMWjAWseIFh5Zoja9Zf22AMb8K+R7AS4UsVqHO8P8X53H
 J2a2gaHkNVRqedr5LsAc0G5kPS/Uwg+ZnmeKfegyeRDgaUmzq4jv4FLTegKm79Q694zK
 yqKj7ury+JsX3HQjVMRy02wGVifpnAsH3PEowgzgpJcELiB+k1BZwTZGoq9YxWQll7JR
 vPLY+HN72kDULmuCqBrPGuwbL9yER2kMh4IJuhMI0ptcVnWjNSPT8hM81IJicB/phXhF
 C7sjZ9HPADZQgSjxgSv93uvLmxj5MlsYfF29+kEJWu4WI5Xx1RgQY3o8c58dz5aHfr44
 xoXw==
X-Gm-Message-State: ANhLgQ03nrWND/oJ/sMXJEp0wEvnJLpefQnGETlhONkDf/xgExjaoCrf
 Hk/yDATZffn5pa75LNJYp9mbjLHL
X-Google-Smtp-Source: ADFU+vsRt9mGcBaofv6nzhL9eneE1acOwU4fR857ckpzHAEyipHxWapo37PJawlg5AhDrMF7AUDzZg==
X-Received: by 2002:adf:c5c8:: with SMTP id v8mr2327487wrg.111.1583965152499; 
 Wed, 11 Mar 2020 15:19:12 -0700 (PDT)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id q7sm19346796wrd.54.2020.03.11.15.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 15:19:12 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 10/18] hw/arm/allwinner-h3: add Boot ROM support
Date: Wed, 11 Mar 2020 23:18:46 +0100
Message-Id: <20200311221854.30370-11-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311221854.30370-1-nieklinnenbank@gmail.com>
References: <20200311221854.30370-1-nieklinnenbank@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, jasowang@redhat.com,
 b.galvani@gmail.com, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A real Allwinner H3 SoC contains a Boot ROM which is the
first code that runs right after the SoC is powered on.
The Boot ROM is responsible for loading user code (e.g. a bootloader)
from any of the supported external devices and writing the downloaded
code to internal SRAM. After loading the SoC begins executing the code
written to SRAM.

This commits adds emulation of the Boot ROM firmware setup functionality
by loading user code from SD card in the A1 SRAM. While the A1 SRAM is
64KiB, we limit the size to 32KiB because the real H3 Boot ROM also rejects
sizes larger than 32KiB. For reference, this behaviour is documented
by the Linux Sunxi project wiki at:

  https://linux-sunxi.org/BROM#U-Boot_SPL_limitations

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/arm/allwinner-h3.h | 21 +++++++++++++++++++++
 hw/arm/allwinner-h3.c         | 17 +++++++++++++++++
 hw/arm/orangepi.c             |  5 +++++
 3 files changed, 43 insertions(+)

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index f9b9a02373..d338003724 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -46,6 +46,7 @@
 #include "hw/sd/allwinner-sdhost.h"
 #include "hw/net/allwinner-sun8i-emac.h"
 #include "target/arm/cpu.h"
+#include "sysemu/block-backend.h"
 
 /**
  * Allwinner H3 device list
@@ -129,4 +130,24 @@ typedef struct AwH3State {
     MemoryRegion sram_c;
 } AwH3State;
 
+/**
+ * Emulate Boot ROM firmware setup functionality.
+ *
+ * A real Allwinner H3 SoC contains a Boot ROM
+ * which is the first code that runs right after
+ * the SoC is powered on. The Boot ROM is responsible
+ * for loading user code (e.g. a bootloader) from any
+ * of the supported external devices and writing the
+ * downloaded code to internal SRAM. After loading the SoC
+ * begins executing the code written to SRAM.
+ *
+ * This function emulates the Boot ROM by copying 32 KiB
+ * of data from the given block device and writes it to
+ * the start of the first internal SRAM memory.
+ *
+ * @s: Allwinner H3 state object pointer
+ * @blk: Block backend device object pointer
+ */
+void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk);
+
 #endif /* HW_ARM_ALLWINNER_H3_H */
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index d1245d2b01..a9767c70c0 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -29,6 +29,7 @@
 #include "hw/char/serial.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/hcd-ehci.h"
+#include "hw/loader.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/allwinner-h3.h"
 
@@ -170,6 +171,22 @@ enum {
     AW_H3_GIC_NUM_SPI       = 128
 };
 
+void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk)
+{
+    const int64_t rom_size = 32 * KiB;
+    g_autofree uint8_t *buffer = g_new0(uint8_t, rom_size);
+
+    if (blk_pread(blk, 8 * KiB, buffer, rom_size) < 0) {
+        error_setg(&error_fatal, "%s: failed to read BlockBackend data",
+                   __func__);
+        return;
+    }
+
+    rom_add_blob("allwinner-h3.bootrom", buffer, rom_size,
+                  rom_size, s->memmap[AW_H3_SRAM_A1],
+                  NULL, NULL, NULL, NULL, false);
+}
+
 static void allwinner_h3_init(Object *obj)
 {
     AwH3State *s = AW_H3(obj);
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index d65bbf8a2f..b8ebcb08b7 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -97,6 +97,11 @@ static void orangepi_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), h3->memmap[AW_H3_SDRAM],
                                 machine->ram);
 
+    /* Load target kernel or start using BootROM */
+    if (!machine->kernel_filename && blk_is_available(blk)) {
+        /* Use Boot ROM to copy data from SD card to SRAM */
+        allwinner_h3_bootrom_setup(h3, blk);
+    }
     orangepi_binfo.loader_start = h3->memmap[AW_H3_SDRAM];
     orangepi_binfo.ram_size = machine->ram_size;
     arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
-- 
2.17.1


