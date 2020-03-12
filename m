Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A8EC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23F8206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqsNWxv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23F8206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR43-0008S8-3U
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxe-0000PE-M3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxd-0005CU-6s
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxc-0005CE-W2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id a132so6861587wme.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0qXFteYUhNwOiO+xUdaCVR+e7Yo1U4U6SKAxr37djug=;
 b=KqsNWxv5hrq/aA1luH26jK2qDx1nb3JKayAZizqmBS84P5Ys/SYM+4AX6UaEIdRXGF
 ccQNKEmzEBCkLzOQPDc3e1WWZaYD/sQHAddqctaSepUzE1Rdg+WQikae330eRHBEB2Dk
 4th3qxH0+XAa/GbkMYKywyIto/Ia2AVTkueVnGRU/EJsAT09DbZY75Rdo5NhMNRysGVb
 2hFYrmEMuyxOteDc7pa3R8lo00v+4cMfDf8JF57c7jmnIjP+g/pqsHJ2ehPUfVfVAqqG
 LnmtrosJ7wmZQ0dt73vr7zmL+wN2U6YRy97AUr0tgUCqWA+/xtpGWwAECBYN2Lc1B2zG
 peLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0qXFteYUhNwOiO+xUdaCVR+e7Yo1U4U6SKAxr37djug=;
 b=puOhjy4OMkintb81QgQNmzsAjHyrGHT721Q7ub3LpkTEudZRiBXJKkTR1Ll8LOn+dR
 ycw2MnNfVyPEUSEvcH38ubud4skKhiQAuc4mZCoyvgHNg5BHRZ65wv99okgC63DCofNb
 rYWkUh37Ah+nfXEPejVC4GiOaSokVDhOrVTz+NYhuiFvb9OlghrVgvDTC6lGHd2htTWV
 CTot6aWssZaAm3DVMl0w3Jgg5JPGeWhoR7rfxZLkBHekFnhBlAOnUwqraVuOFLBdEGJp
 k4nwOlGXe7yt7vKcIh4PYI9ZsZxT1jfk0QcYN6trMgLzTEY6YQXdwGB+EeStQbBQlF1e
 zsow==
X-Gm-Message-State: ANhLgQ3yL1cDnpShcdSCaEkawVRFvPvhL+jIKz7K4gzRrqo7qTSrqpU+
 4m2SEiBJkS5X2CrCiuwVSAQAk4p3XRw9BA==
X-Google-Smtp-Source: ADFU+vtUMn9BojiBw/+1pxvDHxTLDp2SOS3E7epy2NuDsoDGY+99eTbY26XQ0VwNSGJpMcva7eQiIg==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr5809499wmt.137.1584031527451; 
 Thu, 12 Mar 2020 09:45:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/36] hw/arm/allwinner-h3: add Boot ROM support
Date: Thu, 12 Mar 2020 16:44:44 +0000
Message-Id: <20200312164459.25924-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Niek Linnenbank <nieklinnenbank@gmail.com>

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
Message-id: 20200311221854.30370-11-nieklinnenbank@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-h3.h | 21 +++++++++++++++++++++
 hw/arm/allwinner-h3.c         | 17 +++++++++++++++++
 hw/arm/orangepi.c             |  5 +++++
 3 files changed, 43 insertions(+)

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index f9b9a023734..d338003724e 100644
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
index d1245d2b016..a9767c70c08 100644
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
index d65bbf8a2fe..b8ebcb08b76 100644
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
2.20.1


