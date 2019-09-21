Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94A3C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 05:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC0E21835
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 05:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1zX/Bqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC0E21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBYAf-0005ZJ-NY
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 01:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBY9q-000572-KJ
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 01:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBY9p-00053l-AA
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 01:42:10 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iBY9p-00053Q-3g; Sat, 21 Sep 2019 01:42:09 -0400
Received: by mail-pg1-x544.google.com with SMTP id z12so5032297pgp.9;
 Fri, 20 Sep 2019 22:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=ZhxeS5KvFiNdQD+MF8eDIJquaqEG3L5t9TLx8TUM7rU=;
 b=j1zX/Bqap52XMXrDJTJBUG7l0lGs7fjejjM9PWLXIfi/NFqppU3nV2PxpdAClD1jX/
 +ncTFQDCLu59O1Ly8cwORJwNyRUQRAcVG9efLDnZTB6dVGRNM3cwCJEcaS5xXLJau44z
 rzOGbdVYij+Rc7Ao/qsmnXbPRoyJhQph2t5eedF7J2P48Jqtx4RkwZ59sp8hJbqRXSnK
 sSnxlGow6fnNa3i4fNQJGWrDx8IU4N+GXn7H78on07VD0FcjL+ylN0pVSuuT2GJ3Kiem
 RIE6gs6OXuxS30tucpjr6kMveOe00CIRgUhaMVa7m6s9Jn/FrZgslh46cEaC4RkF+ZIg
 F1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=ZhxeS5KvFiNdQD+MF8eDIJquaqEG3L5t9TLx8TUM7rU=;
 b=QiA/umrZ0bR0H4JNznAWUW2rHV/+zI9he4OHksUnjYPhxSnZ2+/2AXBgGBRX/FyA+o
 UZ0L5d87Jbu/kqwHppLVZYqsN9SUMpQOXXbWoPI/uJ6YYXkZw1LGtkxALLAFJ+rHnyR3
 jJN0Wk0cQrZeZ09pCTgGiiPuFZV4ORY0yTJHYH5FO9aCGY9KXMorUPr83AcYmuXCZoKC
 UPmleXWYgnJxBS/SWqDe9AtQ430phDBpyYvXHfBPvpk1z3wg7AQh4pZBRZ9V2VQRmCaO
 9Sqwj5DKJXqsmajaxP+yQ9t2GqfXOArnCJzsUZaw+fqoaaS1M8yvn/pMzLdGMKT+IUvM
 3jpg==
X-Gm-Message-State: APjAAAVtD3vuL/wfqKLXs986WcxLniVYEG8p7MHUVVZYXwXFXJOnRNwT
 eSnpQxYvhrITozxT2cgmR64=
X-Google-Smtp-Source: APXvYqw0BT5tdrgseXpiYnvmCaIhVRKO30aoi3disSxTWfZgf3HVdaINkQVwvAKXRV+7Gxe8Cb84cw==
X-Received: by 2002:a17:90a:1609:: with SMTP id
 n9mr8639149pja.64.1569044527026; 
 Fri, 20 Sep 2019 22:42:07 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d69sm3461953pfd.175.2019.09.20.22.42.06
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 20 Sep 2019 22:42:06 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 1/2] riscv: hw: Drop "clock-frequency" property of cpu nodes
Date: Fri, 20 Sep 2019 22:41:30 -0700
Message-Id: <1569044491-7875-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

The "clock-frequency" property of cpu nodes isn't required. Drop it.

This is to keep in sync with Linux kernel commit below:
https://patchwork.kernel.org/patch/11133031/

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v2:
- drop the one in spike and virt machines too

 hw/riscv/sifive_u.c         | 2 --
 hw/riscv/spike.c            | 2 --
 hw/riscv/virt.c             | 2 --
 include/hw/riscv/sifive_u.h | 1 -
 include/hw/riscv/spike.h    | 4 ----
 include/hw/riscv/virt.h     | 4 ----
 6 files changed, 15 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9f8e84b..02dd761 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -151,8 +151,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa;
         qemu_fdt_add_subnode(fdt, nodename);
-        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
-                              SIFIVE_U_CLOCK_FREQ);
         /* cpu 0 is the management hart that does not have mmu */
         if (cpu != 0) {
             qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index d60415d..8bbffbc 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -102,8 +102,6 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa = riscv_isa_string(&s->soc.harts[cpu]);
         qemu_fdt_add_subnode(fdt, nodename);
-        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
-                              SPIKE_CLOCK_FREQ);
         qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d36f562..1303061 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -161,8 +161,6 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
         char *isa = riscv_isa_string(&s->soc.harts[cpu]);
         qemu_fdt_add_subnode(fdt, nodename);
-        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
-                              VIRT_CLOCK_FREQ);
         qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
         qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index e4df298..4850805 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -75,7 +75,6 @@ enum {
 };
 
 enum {
-    SIFIVE_U_CLOCK_FREQ = 1000000000,
     SIFIVE_U_HFCLK_FREQ = 33333333,
     SIFIVE_U_RTCCLK_FREQ = 1000000
 };
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 03d8703..dc77042 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -38,10 +38,6 @@ enum {
     SPIKE_DRAM
 };
 
-enum {
-    SPIKE_CLOCK_FREQ = 1000000000
-};
-
 #if defined(TARGET_RISCV32)
 #define SPIKE_V1_09_1_CPU TYPE_RISCV_CPU_RV32GCSU_V1_09_1
 #define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_RV32GCSU_V1_10_0
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 6e5fbe5..68978a1 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,10 +55,6 @@ enum {
     VIRTIO_NDEV = 0x35 /* Arbitrary maximum number of interrupts */
 };
 
-enum {
-    VIRT_CLOCK_FREQ = 1000000000
-};
-
 #define VIRT_PLIC_HART_CONFIG "MS"
 #define VIRT_PLIC_NUM_SOURCES 127
 #define VIRT_PLIC_NUM_PRIORITIES 7
-- 
2.7.4


