Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B76DC4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D975B20775
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWKH3AOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D975B20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8Se-0007Zx-07
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JX-0000Sf-5C
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JW-0005hO-Ly
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:17:06 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:44779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jT8JW-0005Yi-76; Mon, 27 Apr 2020 14:17:06 -0400
Received: by mail-lj1-x244.google.com with SMTP id a21so15743494ljj.11;
 Mon, 27 Apr 2020 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JWgHPJnKQYolKo6AERewwuSdxCASwfshD8o828Vx+Fs=;
 b=qWKH3AOKaAR+IHh94Daojf76IXYc8nEIHIqimKRbvnDNb45mkrm8Axx590qB73LJdp
 tfyX+uy5kEKoY9E2KEZdjqDFCnzpVTg9f+0Cih3f8wpQ1jjylLCrJBj7pA/cMvHWzkm0
 sGsFghcJIb7GM34XgstGz+XnUv7/xtj4orV+bsXQmI0PYW2YrY1YRoI66xOz8ZXSe/Io
 6x6Zk+WSe40yNoIy7Y7sA8CSkW3kYQAMe/LIXDuBvz37UpiY2vFi8IO+VFOw8RClDohK
 XmLn3zVuLrlCqhqiZsfpQrhJt33WVzMSjBpZ679fffKCxkwCUE/I5IGKC3Y495Ov0RxA
 2j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JWgHPJnKQYolKo6AERewwuSdxCASwfshD8o828Vx+Fs=;
 b=qdeTeSpzAsEPvNq0YATisHEHGPQFVB4cxD0lGRBu7wVp60BwLwZeNuuIodrZkvxwDp
 fBxRplRjZ+p7gGJP+Rt2iLw3Mm1rZhnYWsKPLL8KVLWEbI98ifxWvFbVYRZdXGBgqrVI
 dzfb/YOMni27lFh4COj/wP5l6fwJrcIETtDuxd971QuPK9X0kNPi1p5pzx/s4nGFsLCt
 9ZVXBOhcU+qrd/oSFifV2joBFyuAu+ifPS3ZR3vpCjaqJxmkElnvc86MTiuyZ0xdNqiN
 0jEtBD4jiGDA7cLXDHPPLaL5VQjeb8S9GKPkwvoEX2hLGpSblMPSWYmjpUQySwDY99Ed
 Z2Kw==
X-Gm-Message-State: AGi0PuYXqARwEJUKwy0i+j958Sp1kutu+nNA5cGu8K9rC+k7jFsYSqgM
 qXi39L0SewMKUydaqTPKNFP/fO4VRfE=
X-Google-Smtp-Source: APiQypKPQ+AXK4wmcOK6ODmOeoRCg7SO8jJMw8RywnTo/Toh6jiRsf/EyNdyMfkZw25HqfNDKbocxg==
X-Received: by 2002:a2e:9c09:: with SMTP id s9mr15320068lji.169.1588011423816; 
 Mon, 27 Apr 2020 11:17:03 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id r9sm9855521ljh.36.2020.04.27.11.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 11:17:03 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/11] hw/arm: versal-virt: Add support for SD
Date: Mon, 27 Apr 2020 20:16:48 +0200
Message-Id: <20200427181649.26851-11-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427181649.26851-1-edgar.iglesias@gmail.com>
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::244
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for SD.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-versal-virt.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index d7be1ad494..0afee48672 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -20,6 +20,7 @@
 #include "hw/arm/sysbus-fdt.h"
 #include "hw/arm/fdt.h"
 #include "cpu.h"
+#include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
@@ -256,6 +257,32 @@ static void fdt_add_zdma_nodes(VersalVirt *s)
     }
 }
 
+static void fdt_add_sd_nodes(VersalVirt *s)
+{
+    const char clocknames[] = "clk_xin\0clk_ahb";
+    const char compat[] = "arasan,sdhci-8.9a";
+    int i;
+
+    for (i = ARRAY_SIZE(s->soc.pmc.iou.sd) - 1; i >= 0; i--) {
+        uint64_t addr = MM_PMC_SD0 + MM_PMC_SD0_SIZE * i;
+        char *name = g_strdup_printf("/sdhci@%" PRIx64, addr);
+
+        qemu_fdt_add_subnode(s->fdt, name);
+
+        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
+                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
+        qemu_fdt_setprop(s->fdt, name, "clock-names",
+                         clocknames, sizeof(clocknames));
+        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_SD0_IRQ_0 + i * 2,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+                                     2, addr, 2, MM_PMC_SD0_SIZE);
+        qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
+        g_free(name);
+    }
+}
+
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
@@ -411,10 +438,23 @@ static void create_virtio_regions(VersalVirt *s)
     }
 }
 
+static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
+{
+    BlockBackend *blk = di ? blk_by_legacy_dinfo(di) : NULL;
+    DeviceState *card;
+
+    card = qdev_create(qdev_get_child_bus(DEVICE(sd), "sd-bus"), TYPE_SD_CARD);
+    object_property_add_child(OBJECT(sd), "card[*]", OBJECT(card),
+                              &error_fatal);
+    qdev_prop_set_drive(card, "drive", blk, &error_fatal);
+    object_property_set_bool(OBJECT(card), true, "realized", &error_fatal);
+}
+
 static void versal_virt_init(MachineState *machine)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(machine);
     int psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
+    int i;
 
     /*
      * If the user provides an Operating System to be loaded, we expect them
@@ -455,6 +495,7 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
+    fdt_add_sd_nodes(s);
     fdt_add_cpu_nodes(s, psci_conduit);
     fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
     fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
@@ -464,6 +505,11 @@ static void versal_virt_init(MachineState *machine)
     memory_region_add_subregion_overlap(get_system_memory(),
                                         0, &s->soc.fpd.apu.mr, 0);
 
+    /* Plugin SD cards.  */
+    for (i = 0; i < ARRAY_SIZE(s->soc.pmc.iou.sd); i++) {
+        sd_plugin_card(&s->soc.pmc.iou.sd[i], drive_get_next(IF_SD));
+    }
+
     s->binfo.ram_size = machine->ram_size;
     s->binfo.loader_start = 0x0;
     s->binfo.get_dtb = versal_virt_get_dtb;
-- 
2.20.1


