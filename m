Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7800CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CCF208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WMzbUqIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CCF208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8ER-0003lE-NW
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Pc-0005Jt-Sk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Pb-0003rz-Hx
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:32 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7Pb-0003rQ-Ci
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:31 -0400
Received: by mail-pg1-x542.google.com with SMTP id f14so7152375pgi.9
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=e7M7/g3Lxi9UwHK1x9XgkX5SPo7otVzIHSY4iLY4NQw=;
 b=WMzbUqIEG28xpHs6tMe/y+DW0zlwaXdKlHfXv8sJZowe0ki4eerPCVb9XTQ7tLIHkc
 dKBAl0vhKTr1y9PdXHjbNdwv3ShMUm0sfs80hvbBPjSulHo05HjyTIWDZFVdHEZFtfrB
 CAznVIdGtvpjNFoMuivYUgEJl1/srbvvZ7VPpKOZfkYRxV8LRknUKbAqLAVOuVCAY/g1
 o1dctuHostUthxAHDH6pTqo6x6rggjXXYTYyq3/JmXJvXojWVfMxYCeyrtFIloHtTWsP
 8MCDLIjY+wWhpYW29sQ7kupqFh2EVtHB+X2UhCIf8lWcykAztCCT9FU1l56qW6Mm87m+
 Fitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=e7M7/g3Lxi9UwHK1x9XgkX5SPo7otVzIHSY4iLY4NQw=;
 b=jcEJRJw1FQjk8uSLhg+MoLUBczLTZeDW2XMSr35gjVYzPpHFm1wGtBXZncu3k99BlS
 4KWohJbfsDhK950uBgRVwX2340s4Z+XV/GKqesFz4aWnc2ErDnFSyc1QG5mfoieQS53u
 m3wLAlq8zI7d/oWLBpNO8RYmc4vef7bsrfH/QCZS74vES7DD5KfQpj6JpA84S+il0Lw+
 iUR7dGIo0UkUvbR4zoCFwORSBSB8T2Vu50pXjAZrhyaH9+zywx6ZuQrKMCiUtX2Fi4OE
 y6iz0TI5rnHGEdfAggYkXm7ogjnkynM/P4wgSQ1R0/KlVfGM+YZqqs3Aeb59OruFB13/
 omvw==
X-Gm-Message-State: APjAAAUYqYEOuSOpiIEP7xgw4k5yxady/0hh/IO6VGMj6ILaZJeW/81+
 5Gp1UPg654+6YyVj/9NOcaLIgXiFdkLvIQ==
X-Google-Smtp-Source: APXvYqzHLJyhtdaSgzal0XpUko9I7J+6wasJrNFWVDwB0l7HmdoDXXNpG8+uLNIOO3QLOsZkAm4Omg==
X-Received: by 2002:a63:9543:: with SMTP id t3mr21805496pgn.350.1572278310012; 
 Mon, 28 Oct 2019 08:58:30 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id l11sm12942229pgf.73.2019.10.28.08.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:29 -0700 (PDT)
Subject: [PULL 08/18] riscv/sifive_u: Add QSPI memory region
Date: Mon, 28 Oct 2019 08:48:52 -0700
Message-Id: <20191028154902.32491-9-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

The HiFive Unleashed uses is25wp256 SPI NOR flash. There is currently no
model of this in QEMU, so to allow boot firmware developers to use QEMU
to target the Unleashed let's add a chunk of memory to represent the QSPI0
memory mapped flash. This can be targeted using QEMU's -device loader
command line option.

In the future we can look at adding a model for the is25wp256 flash.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 8 ++++++++
 include/hw/riscv/sifive_u.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index fbaa3a234e..a32d6773a8 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -71,6 +71,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
+    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
     [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
@@ -314,6 +315,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     SiFiveUState *s = g_new0(SiFiveUState, 1);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
+    MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     int i;
 
     /* Initialize SoC */
@@ -329,6 +331,12 @@ static void riscv_sifive_u_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DRAM].base,
                                 main_mem);
 
+    /* register QSPI0 Flash */
+    memory_region_init_ram(flash0, NULL, "riscv.sifive.u.flash0",
+                           memmap[SIFIVE_U_FLASH0].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_FLASH0].base,
+                                flash0);
+
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 66ee76a780..0062276190 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -64,6 +64,7 @@ enum {
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
     SIFIVE_U_OTP,
+    SIFIVE_U_FLASH0,
     SIFIVE_U_DRAM,
     SIFIVE_U_GEM,
     SIFIVE_U_GEM_MGMT
-- 
2.21.0


