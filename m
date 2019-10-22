Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE65BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DFB2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgDtlhSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DFB2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMufS-0006Vc-Ct
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHk-0003YD-4c
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHc-0001ej-Km
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:36789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuHa-0001dl-L9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:33:08 -0400
Received: by mail-wm1-x32e.google.com with SMTP id c22so7082397wmd.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bRVLYeRm52S1+mDtVEVVM44iNY6mCQd1H1UdrE+pTLs=;
 b=LgDtlhSZioQxUUTVC1mfFG86hTFQAyL6xIokL7y8ZSzU4DyCWYPAjkB8kj/yLJL+9Q
 veRnnNdKfF4Eef0g+MOsWuG/NwTyhK7J+UyLdjHCtIig76QRRNhATxHXabVB2SLFlIrN
 Hj9vRaYDghamRHpXUO+bBHhknMD4m04mfpFe+KCNsqAses9MABB2zQaPkn+s0ECoaFyp
 h8agvjWdLiGE+Dui8R1aSRicWvJL9W5EQpVWeE/FV8kLENn/69qb/w9GLRbglhFitkfX
 P7kRQ0jR/iucIXIJPM8GoG4g2STmOJeyWyjOP95e/tDZZZegY04bP/mKIoyJbn4Gc6n+
 D/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bRVLYeRm52S1+mDtVEVVM44iNY6mCQd1H1UdrE+pTLs=;
 b=dVXyOcA0mBJm52i4dtwIjLSRueh1cubWCVCopKyJA5vLSdsYS3EcGe7muyTfY4SAIN
 8yGvVADFudjnC74CZXEoJFUuSnuH1nSgKVyG3jNsyh16hOyVxWhyyba0x1ydo3IyayY0
 tf4zI5DVhMXJvOlc8Y2eepQaxnnin74ySsvWMiwyjOKHe3+E8vr62SPMrrta+BsuZMZr
 wHCGF/lmHBUPbe4/lyz0thXtGQ8g+Rj16wAyIWUmDqowJeFBsXZd/EwLFBVNsbNRjEwT
 m6K5JL6LSRoy7DrQG4gz63kvK7Mws7fdFMojj4/UB7Bqgwcu4BdpkPk1B8hhfzyBJNoF
 Ty/g==
X-Gm-Message-State: APjAAAXKHryWp8FMX8NNyRVygK2ySquH+MaPoMPWr3gugOMc3WZPpoz5
 VLX9KAPedkdDFfHcQiEVF2dg1dUDtsI=
X-Google-Smtp-Source: APXvYqzPTqVXxjA58+KIfjw82PbGByEnf/dXl5hOh0oMVAtmYSMCUsOP7+yIUxADILGTKnD9/AeFJA==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr3252813wmi.67.1571751184274;
 Tue, 22 Oct 2019 06:33:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.33.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:33:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/41] hw/arm/collie: Create the RAM in the board
Date: Tue, 22 Oct 2019 14:31:31 +0100
Message-Id: <20191022133134.14487-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The SDRAM is incorrectly created in the SA1110 SoC.
Move its creation in the board code, this will later allow the
board to have the QOM ownership of the RAM.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191021190653.9511-4-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/strongarm.h | 4 +---
 hw/arm/collie.c    | 8 ++++++--
 hw/arm/strongarm.c | 7 +------
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/arm/strongarm.h b/hw/arm/strongarm.h
index e98840b461a..192821f6aab 100644
--- a/hw/arm/strongarm.h
+++ b/hw/arm/strongarm.h
@@ -55,7 +55,6 @@ enum {
 
 typedef struct {
     ARMCPU *cpu;
-    MemoryRegion sdram;
     DeviceState *pic;
     DeviceState *gpio;
     DeviceState *ppc;
@@ -63,7 +62,6 @@ typedef struct {
     SSIBus *ssp_bus;
 } StrongARMState;
 
-StrongARMState *sa1110_init(MemoryRegion *sysmem,
-                            unsigned int sdram_size, const char *rev);
+StrongARMState *sa1110_init(const char *cpu_type);
 
 #endif
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index b1288ccea80..970a4405ccf 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -27,9 +27,13 @@ static void collie_init(MachineState *machine)
 {
     StrongARMState *s;
     DriveInfo *dinfo;
-    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *sdram = g_new(MemoryRegion, 1);
 
-    s = sa1110_init(sysmem, collie_binfo.ram_size, machine->cpu_type);
+    s = sa1110_init(machine->cpu_type);
+
+    memory_region_allocate_system_memory(sdram, NULL, "strongarm.sdram",
+                                         collie_binfo.ram_size);
+    memory_region_add_subregion(get_system_memory(), SA_SDCS0, sdram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(SA_CS0, "collie.fl1", 0x02000000,
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index dc65d88a657..6bee0349149 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1586,8 +1586,7 @@ static const TypeInfo strongarm_ssp_info = {
 };
 
 /* Main CPU functions */
-StrongARMState *sa1110_init(MemoryRegion *sysmem,
-                            unsigned int sdram_size, const char *cpu_type)
+StrongARMState *sa1110_init(const char *cpu_type)
 {
     StrongARMState *s;
     int i;
@@ -1601,10 +1600,6 @@ StrongARMState *sa1110_init(MemoryRegion *sysmem,
 
     s->cpu = ARM_CPU(cpu_create(cpu_type));
 
-    memory_region_allocate_system_memory(&s->sdram, NULL, "strongarm.sdram",
-                                         sdram_size);
-    memory_region_add_subregion(sysmem, SA_SDCS0, &s->sdram);
-
     s->pic = sysbus_create_varargs("strongarm_pic", 0x90050000,
                     qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ),
                     qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_FIQ),
-- 
2.20.1


