Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB831C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757B2216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMm/G4fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757B2216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUY0m-0004Ho-Ix
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUXwd-0005ku-OX
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jUXwN-0006l9-U2
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:19 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUXwN-0006gd-Fi; Fri, 01 May 2020 11:51:03 -0400
Received: by mail-pf1-x441.google.com with SMTP id d184so1741676pfd.4;
 Fri, 01 May 2020 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CWtFn701sinBOxhOKzCgy46Wo8AsJsqHmA7csOwe7Hw=;
 b=lMm/G4fAT/Qor5DK8BtKiM9ko32mwIQkN6kqDk6eG5+zTjeWZUI+Clmf9SdUDWTY/O
 +UomSNo8tBWZ0qb8XqLYdJhUp824iJMKadbY1VkEDCvbki3yZfGeB5OSIGF8+ctJZrqs
 QxwIhBZlocca9UyW55RqqLfUYuVR6A2PPpfRhjeYj450aYTOdf3U2faHjdl9FdrMW0aT
 HyraH8GIOyChA3KXgmu2uBaTM4xbVzZaxuDbF3SqEG1PA17/3eHBC7C2V5fJH237doB7
 V2MhFHK6oK+9qalYI6TtbNIO9C1e6n14VBacnYIIOdYhYfD0deGWpD5hlrpXZ3s4hZO0
 4w+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CWtFn701sinBOxhOKzCgy46Wo8AsJsqHmA7csOwe7Hw=;
 b=NhJan7CHR52qht8NQTa91szYbTYmv8nqz05ZFyqr5+DNFRnujkFrvfRygqf0hfdeQ6
 k27SHfQz/sTZIxv0Y47Xz3Om7LKNWVsOZtXtDI+zHSjHWNlAAvkHIsW2UrX7+CiZuZhd
 afxuualohgrInB4EnzOrc5RgVz2wA7l5RyU4URomxKJkrdCBH4aV8TkZ1JddmC/duGsN
 rFjy4VmJiXgDRuhip0csa6KQ7r6Ifu4gY928B8V0B9dfRc23/yS2APzq1k3owch1y/lB
 18mNqhRWcjMrCqz1ws3lh0mJXPVulq5pzox9BeRyPnS5gmwIqgwMqBJIAgE8whvrQ3hg
 vKvQ==
X-Gm-Message-State: AGi0PuYCWPXv2AV7gu+zVKlHzQ1/8TphkpUNb0TojtVoMjHun0PvUF1X
 N7eny4zNUHxK5+UVawZmtoQ=
X-Google-Smtp-Source: APiQypI2zJGN/pnqUl/l/G6wiLMnk7R/HgsMcjyHXFLD4h650u5tJnR9L2iBHL0NaB7Uv0pQUQY2ng==
X-Received: by 2002:aa7:9345:: with SMTP id 5mr4788231pfn.145.1588348261642;
 Fri, 01 May 2020 08:51:01 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id e4sm2385968pge.45.2020.05.01.08.51.00
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 01 May 2020 08:51:01 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 1/5] roms/opensbi: Update to support building bios images for
 generic platform
Date: Fri,  1 May 2020 08:50:50 -0700
Message-Id: <1588348254-7241-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Bin Meng <bin.meng@windriver.com>, Anup Patel <Anup.Patel@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

The RISC-V generic platform is a flattened device tree (FDT) based
platform where all platform specific functionality is provided based
on FDT passed by previous booting stage. The support was added in
upstream opensbi recently.

Bring the QEMU roms/opensbi submodule to the upstream opensbi commit:
commit 4f18c6e55049 ("platform: generic: Add Sifive FU540 TLB flush range limit override")
with the following changes since v0.7 release:

  1bb00ab lib: No need to provide default PMP region using platform callbacks
  a9eac67 include: sbi_platform: Combine reboot and shutdown into one callback
  6585fab lib: utils: Add SiFive test device
  4781545 platform: Add Nuclei UX600 platform
  3a326af scripts: adapt binary archive script for Nuclei UX600
  5bdf022 firmware: fw_base: Remove CSR_MTVEC update check
  e6c1345 lib: utils/serial: Skip baudrate config if input frequency is zero
  01a8c8e lib: utils: Improve fdt_parse_uart8250() API
  0a0093b lib: utils: Add fdt_parse_uart8250_node() function
  243b0d0 lib: utils: Remove redundant clint_ipi_sync() declaration
  e3ad7c1 lib: utils: Rename fdt_parse_clint() to fdt_parse_compat_addr()
  a39cd6f lib: utils: Add FDT match table based node lookup
  dd33b9e lib: utils: Make fdt_get_node_addr_size() public function
  66185b3 lib: utils: Add fdt_parse_sifive_uart_node() function
  19e966b lib: utils: Add fdt_parse_hart_id() function
  44dd7be lib: utils: Add fdt_parse_max_hart_id() API
  f0eb503 lib: utils: Add fdt_parse_plic_node() function
  1ac794c include: Add array_size() macro
  8ff2b94 lib: utils: Add simple FDT timer framework
  76f0f81 lib: utils: Add simple FDT ipi framework
  75322a6 lib: utils: Add simple FDT irqchip framework
  76a8940 lib: utils: Add simple FDT serial framework
  7cc6fa4 lib: utils: Add simple FDT reset framework
  4d06353 firmware: fw_base: Introduce optional fw_platform_init()
  f1aa9e5 platform: Add generic FDT based platform support
  1f21b99 lib: sbi: Print platform hart count at boot time
  2ba7087 scripts: Add generic platform to create-binary-archive.sh
  4f18c6e platform: generic: Add Sifive FU540 TLB flush range limit override

Update our Makefile to build the generic platform instead of building
virt and sifive_u separately.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 roms/Makefile | 30 ++++++++----------------------
 roms/opensbi  |  2 +-
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index f9acf39..cb00628 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -64,10 +64,8 @@ default help:
 	@echo "  u-boot.e500        -- update u-boot.e500"
 	@echo "  u-boot.sam460      -- update u-boot.sam460"
 	@echo "  efi                -- update UEFI (edk2) platform firmware"
-	@echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
-	@echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
-	@echo "  opensbi32-sifive_u -- update OpenSBI for 32-bit sifive_u machine"
-	@echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
+	@echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
+	@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
 	@echo "  bios-microvm       -- update bios-microvm.bin (qboot)"
 	@echo "  clean              -- delete the files generated by the previous" \
 	                              "build targets"
@@ -170,29 +168,17 @@ skiboot:
 efi: edk2-basetools
 	$(MAKE) -f Makefile.edk2
 
-opensbi32-virt:
+opensbi32-generic:
 	$(MAKE) -C opensbi \
 		CROSS_COMPILE=$(riscv32_cross_prefix) \
-		PLATFORM="qemu/virt"
-	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
+		PLATFORM="generic"
+	cp opensbi/build/platform/generic/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-generic-fw_jump.bin
 
-opensbi64-virt:
+opensbi64-generic:
 	$(MAKE) -C opensbi \
 		CROSS_COMPILE=$(riscv64_cross_prefix) \
-		PLATFORM="qemu/virt"
-	cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
-
-opensbi32-sifive_u:
-	$(MAKE) -C opensbi \
-		CROSS_COMPILE=$(riscv32_cross_prefix) \
-		PLATFORM="sifive/fu540"
-	cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
-
-opensbi64-sifive_u:
-	$(MAKE) -C opensbi \
-		CROSS_COMPILE=$(riscv64_cross_prefix) \
-		PLATFORM="sifive/fu540"
-	cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
+		PLATFORM="generic"
+	cp opensbi/build/platform/generic/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-generic-fw_jump.bin
 
 bios-microvm:
 	$(MAKE) -C qboot
diff --git a/roms/opensbi b/roms/opensbi
index 9f1b72c..4f18c6e 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 9f1b72ce66d659e91013b358939e832fb27223f5
+Subproject commit 4f18c6e55049d858c62e87d2605dd41c06956e4e
-- 
2.7.4


