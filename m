Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3503FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07FD2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 00:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="i93oxQc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07FD2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAMku-0007VN-8O
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 20:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qFhEXwsKCmsQbTRWWNVXNWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--hskinnemoen.bounces.google.com>)
 id 1kAMes-0004Va-Vy
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 20:17:51 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:38511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qFhEXwsKCmsQbTRWWNVXNWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--hskinnemoen.bounces.google.com>)
 id 1kAMep-00069Y-Q1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 20:17:50 -0400
Received: by mail-yb1-xb49.google.com with SMTP id l13so12783461ybf.5
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 17:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=1eUKc4mUKGxpAfRnn7edRuE+wT0NYPxDKPSyLd06AXc=;
 b=i93oxQc97gPif+5l4MHVqnL0YPMUFlN8wvY3LI9yWOg2mHfMPjZqLRqsQqH2ZNGD53
 uevKckWnlmqo2HG4m9p3FxLYYDgsBVFk9xZWf/KjF2fUZs5BsaAWOeV4lmHe6Gq0PIOl
 y6Veokzd3DM7fI5DO3EJks/63EmZLKJv3cqzXJgtrkQZiCw0Gprnq9eDBr9VoskVB/r0
 Gx5cQilHKjRRZhTJU8mvC8ZRDoq+TERAdsnDFDiUBLK6dXDvenB55D3Uo6awa9Mc5O5M
 Hs14JjX+++uxtEQMY7VDFU9ZhHS1H39ct+JdyNTxAL1h7DlL0/4TStCHfNv8v5CwEbtF
 Vcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=1eUKc4mUKGxpAfRnn7edRuE+wT0NYPxDKPSyLd06AXc=;
 b=DG6IyTmWVKlloM0kPsUCtD36PhAv0N4fLVxWw5zisma/mkCTv/qc1ESIk/l+JIuQ8Z
 Jef1zxeZ/Fn/SiRXJVYzv80Z1Kx571nM0hDdq1+ru6CPo+xzGiIRjQpv0DekepTAgtc7
 r8B1Yq9fIlRWq8qUA2LKMRX/iBKxn3mIfTt5quWbwj/snIJhnVGynzdAZ/MIOikZlqx5
 Fd+D0UBXsUOX3Lm71xDIypATj+7bzz93UIFHZvdUz+CIPYYDV52k5/VO9oLy42wc0LFE
 u4m6BcSeip9UjRS5m+X8f5opEmIDkT/zk7L0PvUA7kMya5gG7tYLP2BcLVmbge2bDIm+
 5dmQ==
X-Gm-Message-State: AOAM530obiKZyslmqCKgNeKazk0qkqQCiYiZr/51L99pGW0lpDDG+d3i
 3lQaGd1ajRs1EHPKsvRn3mMaNRwtntHbH5fPjQ==
X-Google-Smtp-Source: ABdhPJzd9A40C16FQ7mckCF2szmBWC4wIp0sz2fyD7zOHFPIGpTyPZMmbiOUOa0VGQUEpRzvWd2lKxkp0bX+4XYlTg==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a25:9004:: with SMTP id
 s4mr10468658ybl.247.1598314664144; Mon, 24 Aug 2020 17:17:44 -0700 (PDT)
Date: Mon, 24 Aug 2020 17:17:09 -0700
In-Reply-To: <20200825001711.1340443-1-hskinnemoen@google.com>
Message-Id: <20200825001711.1340443-13-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200825001711.1340443-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v8 12/14] hw/arm/npcm7xx: add board setup stub for CPU and
 UART clocks
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3qFhEXwsKCmsQbTRWWNVXNWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

When booting directly into a kernel, bypassing the boot loader, the CPU and
UART clocks are not set up correctly. This makes the system appear very
slow, and causes the initrd boot test to fail when optimization is off.

The UART clock must run at 24 MHz. The default 25 MHz reference clock
cannot achieve this, so switch to PLL2/2 @ 480 MHz, which works
perfectly with the default /20 divider.

The CPU clock should run at 800 MHz, so switch it to PLL1/2. PLL1 runs
at 800 MHz by default, so we need to double the feedback divider as well
to make it run at 1600 MHz (so PLL1/2 runs at 800 MHz).

We don't bother checking for PLL lock because we know our emulated PLLs
lock instantly.

Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 include/hw/arm/npcm7xx.h |  1 +
 hw/arm/npcm7xx.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 78d0d78c52..13106af215 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -37,6 +37,7 @@
 #define NPCM7XX_SMP_LOADER_START        (0xffff0000)  /* Boot ROM */
 #define NPCM7XX_SMP_BOOTREG_ADDR        (0xf080013c)  /* GCR.SCRPAD */
 #define NPCM7XX_GIC_CPU_IF_ADDR         (0xf03fe100)  /* GIC within A9 */
+#define NPCM7XX_BOARD_SETUP_ADDR        (0xffff1000)  /* Boot ROM */
 
 typedef struct NPCM7xxMachine {
     MachineState        parent;
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 7884b2b03d..037f3a26f2 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -55,6 +55,13 @@
 #define NPCM7XX_ROM_BA          (0xffff0000)
 #define NPCM7XX_ROM_SZ          (64 * KiB)
 
+/* Clock configuration values to be fixed up when bypassing bootloader */
+
+/* Run PLL1 at 1600 MHz */
+#define NPCM7XX_PLLCON1_FIXUP_VAL   (0x00402101)
+/* Run the CPU from PLL1 and UART from PLL2 */
+#define NPCM7XX_CLKSEL_FIXUP_VAL    (0x004aaba9)
+
 /*
  * Interrupt lines going into the GIC. This does not include internal Cortex-A9
  * interrupts.
@@ -132,6 +139,29 @@ static const struct {
     },
 };
 
+static void npcm7xx_write_board_setup(ARMCPU *cpu,
+                                      const struct arm_boot_info *info)
+{
+    uint32_t board_setup[] = {
+        0xe59f0010,     /* ldr r0, clk_base_addr */
+        0xe59f1010,     /* ldr r1, pllcon1_value */
+        0xe5801010,     /* str r1, [r0, #16] */
+        0xe59f100c,     /* ldr r1, clksel_value */
+        0xe5801004,     /* str r1, [r0, #4] */
+        0xe12fff1e,     /* bx lr */
+        NPCM7XX_CLK_BA,
+        NPCM7XX_PLLCON1_FIXUP_VAL,
+        NPCM7XX_CLKSEL_FIXUP_VAL,
+    };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(board_setup); i++) {
+        board_setup[i] = tswap32(board_setup[i]);
+    }
+    rom_add_blob_fixed("board-setup", board_setup, sizeof(board_setup),
+                       info->board_setup_addr);
+}
+
 static void npcm7xx_write_secondary_boot(ARMCPU *cpu,
                                          const struct arm_boot_info *info)
 {
@@ -170,6 +200,8 @@ static struct arm_boot_info npcm7xx_binfo = {
     .gic_cpu_if_addr        = NPCM7XX_GIC_CPU_IF_ADDR,
     .write_secondary_boot   = npcm7xx_write_secondary_boot,
     .board_id               = -1,
+    .board_setup_addr       = NPCM7XX_BOARD_SETUP_ADDR,
+    .write_board_setup      = npcm7xx_write_board_setup,
 };
 
 void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
-- 
2.28.0.297.g1956fa8f8d-goog


