Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B661AC3F2D3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833E22468D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLtRVeHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833E22468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ihj-000426-NK
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if2-0007Ea-R7
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if1-0001mi-Nc
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:48 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7if1-0001mC-HL
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id g83so1708038wme.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=p1vL82UhROt8QXhCUT1feYYkEotDCosoZbN7/fg2s9o=;
 b=bLtRVeHlZKlL18VRGYJDD8RjmhQMmybKM5kBfU8MORmkXVP0RJHB3iXYUByqB3bTbD
 Lmcq0P9KVVF95qjovTBAiEaGnc8LO1t/lXj4KAljghn+Pi+bIl3l9edFzMVpj8qGTx5B
 dDQQ06PMRxGrdp9bcZ1XKcRDy/vtTdhsgZx2YIu8sCamVlSDjdZAnFqVgVyPzUJfkWy0
 aUfylGXjhlzsS3z5YnzjK4aGqizQZW0yihBWdsEhyCKn2oL/rXJM6HVILiNuL0p+xtne
 n5SoUssf+D1ze0SEuw4NAvu313vUlRht6rfw3TMP08XuNfBOOH2ZCCMpuvrLpaSplmm/
 U6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p1vL82UhROt8QXhCUT1feYYkEotDCosoZbN7/fg2s9o=;
 b=ROWWdY/Pph5KxbJ68pFGr14KSOEpZDdLBjzxxsr4mcdaKb3uPT+VhJ+JZP8J8JWNNS
 P6XfLjI752XrWpJ+7EfwdeggjxCqXPWslxxOMg0dWAVsGjokXfebPn1gprvq8JjgaWNO
 5DKCxe0IlOgRL+/4hJNPi8wxty7UaSVgJ+goWFsnx1jXJFCV+i4JvS3GwGzGoSwMG02q
 60o3H/3fopZCCa4VgvjeTSp2rPQ/FEgq1mJT0J9MRz6mVeroy11rVZPVxGhLQY2t6BXh
 kmn9A71f/xk9LXqwoaa3j7b2nFhtLlh8a3P/ObPvZPELjNWjVW1dpSLzW4XyVUwhpneQ
 T4Yg==
X-Gm-Message-State: APjAAAW0lSjJ39fOBzvtyAS4RFzadvT+rdsPv4Y+B4VUKByhZj0E7sFC
 2qBZIf20Ce8Lf57BJvt+P3kbMOHCFhXFZQ==
X-Google-Smtp-Source: APXvYqxqaJ/auXTizGmmWTmVRcRwplohICnqvz0h1fnm5v5AaRUdJvgx18RYH69YA6KXWl0AbzbhTw==
X-Received: by 2002:a1c:1b41:: with SMTP id b62mr5353257wmb.97.1582907926188; 
 Fri, 28 Feb 2020 08:38:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/33] hw/arm/integratorcp: Map the audio codec controller
Date: Fri, 28 Feb 2020 16:38:10 +0000
Message-Id: <20200228163840.23585-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The Linux kernel displays errors why trying to detect the PL041
audio interface:

  Linux version 4.16.0 (linus@genomnajs) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #142 PREEMPT Wed May 9 13:24:55 CEST 2018
  CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00093177
  CPU: VIVT data cache, VIVT instruction cache
  OF: fdt: Machine model: ARM Integrator/CP
  ...
  OF: amba_device_add() failed (-19) for /fpga/aaci@1d000000

Since we have it already modelled, simply plug it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200223233033.15371-2-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/integratorcp.c | 1 +
 hw/arm/Kconfig        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index cc845b85340..6d69010d06b 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -642,6 +642,7 @@ static void integratorcp_init(MachineState *machine)
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_WPROT, 0));
     qdev_connect_gpio_out(dev, 1,
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_CARDIN, 0));
+    sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
 
     if (nd_table[0].used)
         smc91c111_init(&nd_table[0], 0xc8000000, pic[27]);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3d86691ae0c..61635f52c42 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -69,6 +69,7 @@ config INTEGRATOR
     select INTEGRATOR_DEBUG
     select PL011 # UART
     select PL031 # RTC
+    select PL041 # audio
     select PL050 # keyboard/mouse
     select PL110 # pl111 LCD controller
     select PL181 # display
-- 
2.20.1


