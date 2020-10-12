Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F5C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDEC2076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bj7+/FdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDEC2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS04L-0000IU-GT
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqg-0007BP-RM
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqV-0007M0-PS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id b8so6466807wrn.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K3mgJCwncdqIipiYAU+wCrFh9fTPvR4OlTHmlok7qrM=;
 b=Bj7+/FdZqB9RAzExmsmOiXmF94g68Yoq7B3rRbQNJoLxARocJgq7e+/cd3Z2EB+fPL
 lpWhsjvXMp3+5/c9fVh1/3XC15ZLSRLegA8vP7gelQCXbn8DTXE5G2G2al0aUoZx70DX
 SZBB+pR9jP5nZR9pDBKsJJ6qzPoioWGFHXPGPqab0MKX6tuQoBExGuoJNybh5c/WfY06
 drAdICUToc0lzLUidzGmSPtruCnAGy6in3Gl6mK2CtVUqCzUB5pWomUcWh+QAwOqIj4U
 FGtXqmWgKaRhWOTHQCzmB+WEgVamfhGNzaS8IvUAmm2IcI82hmLbXraSs4/3Qr9WS3Hq
 s11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K3mgJCwncdqIipiYAU+wCrFh9fTPvR4OlTHmlok7qrM=;
 b=ExPBrmktJDOFP6dJxavfeQmQ7L+RRVJ/JgZN1ohJrEl/mciqrrGXiZ5UShwmygFgL6
 XQQ1AuL4ErPtoTMakmbt2q2ryQnADWf06OKRrQu+hhRF+b53zWg1Ha+nHuoZBkfrHN0X
 cH6bHjUp3SN10Bt35o7utZXTVYrCjC6Y/jdHmItU7Kego5tRjEOZ8lAWt3oxDHjGGaze
 HkdzQcjZgKTebP7/qn4j6Lxt85Qfxy3lcAbLXP78+AOpYU4F6xYnQUvRL9GHA8F7IdQ7
 WDxAqQhBN2GFDkpmA5QCgGJho50su641xcDpoPxPeePbl4YjBl7A6lcJCOS3H5CZOdzP
 n0SA==
X-Gm-Message-State: AOAM532zxtKal3h2m8mSpnQDcW1Q24eQd2ED/T25bdl4fiLoepJkYEcX
 gK9wDOIC2s0Qfw+51dk7CnKcHA==
X-Google-Smtp-Source: ABdhPJy9wuUwn1hc0KCqDmwk70wk0pFJBqFe3c+BBtGV26se4FEi9Ayxuoywz6ALEANsd5GGfWNK0g==
X-Received: by 2002:a5d:6a51:: with SMTP id t17mr14288975wrw.80.1602516877958; 
 Mon, 12 Oct 2020 08:34:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] msf2-soc, stellaris: Don't wire up SYSRESETREQ
Date: Mon, 12 Oct 2020 16:33:47 +0100
Message-Id: <20201012153408.9747-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MSF2 SoC model and the Stellaris board code both wire
SYSRESETREQ up to a function that just invokes
    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
This is now the default action that the NVIC does if the line is
not connected, so we can delete the handling code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/msf2-soc.c  | 11 -----------
 hw/arm/stellaris.c | 12 ------------
 2 files changed, 23 deletions(-)

diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 33ea7df342c..d2c29e82d13 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -30,7 +30,6 @@
 #include "hw/irq.h"
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
-#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 
 #define MSF2_TIMER_BASE       0x40004000
@@ -59,13 +58,6 @@ static const int spi_irq[MSF2_NUM_SPIS] = { 2, 3 };
 static const int uart_irq[MSF2_NUM_UARTS] = { 10, 11 };
 static const int timer_irq[MSF2_NUM_TIMERS] = { 14, 15 };
 
-static void do_sys_reset(void *opaque, int n, int level)
-{
-    if (level) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    }
-}
-
 static void m2sxxx_soc_initfn(Object *obj)
 {
     MSF2State *s = MSF2_SOC(obj);
@@ -130,9 +122,6 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    qdev_connect_gpio_out_named(DEVICE(&s->armv7m.nvic), "SYSRESETREQ", 0,
-                                qemu_allocate_irq(&do_sys_reset, NULL, 0));
-
     system_clock_scale = NANOSECONDS_PER_SECOND / s->m3clk;
 
     for (i = 0; i < MSF2_NUM_UARTS; i++) {
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 28eb15c76ca..5f9d0801807 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -18,7 +18,6 @@
 #include "hw/boards.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
-#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/armv7m.h"
 #include "hw/char/pl011.h"
@@ -1206,14 +1205,6 @@ static void stellaris_adc_init(Object *obj)
     qdev_init_gpio_in(dev, stellaris_adc_trigger, 1);
 }
 
-static
-void do_sys_reset(void *opaque, int n, int level)
-{
-    if (level) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    }
-}
-
 /* Board init.  */
 static stellaris_board_info stellaris_boards[] = {
   { "LM3S811EVB",
@@ -1317,9 +1308,6 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     /* This will exit with an error if the user passed us a bad cpu_type */
     sysbus_realize_and_unref(SYS_BUS_DEVICE(nvic), &error_fatal);
 
-    qdev_connect_gpio_out_named(nvic, "SYSRESETREQ", 0,
-                                qemu_allocate_irq(&do_sys_reset, NULL, 0));
-
     if (board->dc1 & (1 << 16)) {
         dev = sysbus_create_varargs(TYPE_STELLARIS_ADC, 0x40038000,
                                     qdev_get_gpio_in(nvic, 14),
-- 
2.20.1


