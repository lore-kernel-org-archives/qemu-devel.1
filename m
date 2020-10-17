Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854A3C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B32E20658
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGTBbSiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B32E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnGJ-000735-83
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpb-0003lR-6Y
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmpZ-0003sq-3F
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:05:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id a72so6127153wme.5
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iLy9KPPIH/IaR0EvDlMGJ9V0mA4+5oswM3SWnu1jL9U=;
 b=SGTBbSiXbW9YLOK7kkSjYZ6om3fWfJYG/10jwtHMmJOtCUuOesQiFjCefKFKWNCyId
 kE/2D/EV2AaZppTg3YITIUdnBfJdqV/ZDuB7B9lfYwsvWVXxO+1/FDw4kWrJEMKVYB3G
 WtE5TudopTS7w1pyObY7jzoKiJ/ePPGApm/q3yF5+JQgI1cbaLM+y/MamyyBhivkvE8t
 fD5lrlUY/qmXcoLb5dpqcSKB+6E4WZlTTLVjgAFzL4wnHJoSI+tZhIzuW926A6k9xq8s
 f327sQ3y40/j80SdTn1XTe28FnbOzQYwAuAqfGFMOxbT4ixDnhJ1R+cG4rstGL+ahn2Z
 +D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iLy9KPPIH/IaR0EvDlMGJ9V0mA4+5oswM3SWnu1jL9U=;
 b=WO2yxmgvR/hecMIh121ugjAdyeGdHnU2qNBBgUaXM/XAkNj6+GzTS2sRl5oQDx2W06
 YNj8cSrC+8+wJKb+kOS6ev/IoE6o9Yqcjh4cx+7Xo1QO645uKn3wYbF3enb4aBPD0s8j
 z2P2byzzjJ+sw0ZsBQXg6a8Ql5vvfFK3vlvuxvL4V3bqyHZnWEmLIK+l1vpgKUYcJrx8
 JnQVACzHYuvh4SI36DzHIp6feaSX4FLqlwSP0Dcp2jMeizAKR0GpWHoQefqzQF+Ia7IW
 GARHJo6ZfLBCl0DnflBGWul/JmZAlyT7mruZZMw/AlbbK3Mw8eyT2r9aNMvqLcX6diHC
 WW3w==
X-Gm-Message-State: AOAM531xxEIh5BWsem74B+CA2w+ElRDmxDec7jwwDPdVoUl8IChn64GO
 o4qMsEEsuK/5zoC/csVH3g6ugvVFOVg=
X-Google-Smtp-Source: ABdhPJxZdWzeM2W3p56t8YM+Id/2hJtkmh3nJiJP4T26fcY+JVdpepPFWV8jt97BlY3BWaoDCQcWQw==
X-Received: by 2002:a1c:6302:: with SMTP id x2mr9141898wmb.121.1602943505962; 
 Sat, 17 Oct 2020 07:05:05 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id n5sm8920455wrm.2.2020.10.17.07.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:05:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/44] target/mips/cpu: Display warning when CPU is used
 without input clock
Date: Sat, 17 Oct 2020 16:02:29 +0200
Message-Id: <20201017140243.1078718-31-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All our QOM users provides an input clock. In order to avoid
avoid future machines added without clock, display a warning.

User-mode emulation use the CP0 timer with the RDHWR instruction
(see commit cdfcad788394) so keep using the fixed 200 MHz clock
without diplaying any warning. Only display it in system-mode
emulation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201012095804.3335117-22-f4bug@amsat.org>
---
 target/mips/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 33a9ed5c24b..76d50b00b42 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -19,12 +19,14 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "internal.h"
 #include "kvm_mips.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
+#include "sysemu/qtest.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
@@ -158,6 +160,14 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
     if (!clock_get(cpu->clock)) {
+#ifndef CONFIG_USER_ONLY
+        if (!qtest_enabled()) {
+            g_autofree char *cpu_freq_str = freq_to_str(CPU_FREQ_HZ_DEFAULT);
+
+            warn_report("CPU input clock is not connected to any output clock, "
+                        "using default frequency of %s.", cpu_freq_str);
+        }
+#endif
         /* Initialize the frequency in case the clock remains unconnected. */
         clock_set_hz(cpu->clock, CPU_FREQ_HZ_DEFAULT);
     }
-- 
2.26.2


