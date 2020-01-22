Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CF7C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D7A217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytsZGAAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D7A217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu5td-0006IC-4x
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:37:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pi-00017j-H6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5ph-0001xi-6D
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:30 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu5ph-0001xJ-02
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:29 -0500
Received: by mail-pg1-x541.google.com with SMTP id k197so2592471pga.10
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ueLaohMdpnj57qcG2jXXNJ0s60U0ZF3lFnQgnB/z7q8=;
 b=ytsZGAAT2VnOCp8ZYUaqvrlFv10qZhWrBPJSxTsyttunRhLYz70ZxWkcHsk9BNJH5S
 Xa0yg8dDsd8ccMcL+dEPXCJan6pAIRtmz0JyrsfmRtMsS+rfPUHT8NxEuSSFLS3AjH+a
 BmgxUJWe3tB7oe5pr7Pj3c3EuRLf1YDaWwv7NOoMsDfL22vDOCkCHXra6PUaJKKJZjrn
 NRg7BJeJEv8X0EGnJb6AY+toKQFPaQwpjG67sgbYekkJEspZ3DMVHjo0UX62WnPUb/QK
 82C9wnnXmgCFfUzKTWZid6qw0TOpRm1OJk8x6/NkHAFzIJ3qitJTR5zipV/EIKBYKN3g
 rxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ueLaohMdpnj57qcG2jXXNJ0s60U0ZF3lFnQgnB/z7q8=;
 b=eYD2H8emjqpQIegCnA6m5F9gFbMNO1bTHeHtQhoKu9oh+iaUQ/W0v1eAHYRREHl4s6
 1x3/ZeWoIcBDZrE5dWSa+hAYPckG+DdlI3a2NweXQusDdzSv2DNmf7FMsHQ2wXu70AUV
 /Z6GNQw3jKVuDaukyk1WXz9Y2xZULNyJHCnH7cyw6mLnmlvWvtHi1M1bsxp/WxH+vIec
 bLPY+lA6KjdyUsbhF9ylyc8j+vBqZXH50i5aWJNXIO1VF1mN8BUujvo236MhlQ1oh+k7
 W6yH+/0y6VgmT6JogkkEqc02Uu2zBaY7W6lLSGfkH3a5HWxJKTS/fM+BgMmFRoLRbMD+
 wA7Q==
X-Gm-Message-State: APjAAAUYfuz0VozOodr5IphVz8idrxBXa/AH+MQ8n2dTwmgeOfb07s0D
 tOHQxonxcFNUpQAq79xscIPZJJu+Z2Q=
X-Google-Smtp-Source: APXvYqyXJdlkLhLtO2U4G0l5OQafEf+90c/zOyPny2UMDMCI8QXE1BgfDwNlKerjuBYrcIAswYbkwg==
X-Received: by 2002:a63:465b:: with SMTP id v27mr8934109pgk.257.1579660407743; 
 Tue, 21 Jan 2020 18:33:27 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id t1sm42935209pgq.23.2020.01.21.18.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:33:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] hw/hppa/machine: Restrict the total memory size to 3GB
Date: Tue, 21 Jan 2020 16:32:54 -1000
Message-Id: <20200122023256.27556-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122023256.27556-1-richard.henderson@linaro.org>
References: <20200122023256.27556-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The hardware expects DIMM slots of 1 or 2 GB, allowing up to
4 GB of memory. We want to accept the same amount of memory the
hardware can deal with. DIMMs of 768MB are not available.

However we have to deal with a firmware limitation: currently
SeaBIOS only supports 32-bit, and expects the RAM size in a
32-bit register. When using a 4GB configuration, the 32-bit
register get truncated and we report a size of 0MB to SeaBIOS,
which ends halting the machine:

  $ qemu-system-hppa -m 4g -serial stdio

  SeaBIOS: Machine configured with too little memory (0 MB), minimum is 16 MB.

  SeaBIOS wants SYSTEM HALT.

The easiest way is to restrict the machine to 3GB of memory.

Acked-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200109000525.24744-3-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e57530950a..57cb4e0f34 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -92,12 +92,11 @@ static void machine_hppa_init(MachineState *machine)
         g_free(name);
     }
 
-    /* Limit main memory. */
-    if (ram_size > FIRMWARE_START) {
-        machine->ram_size = ram_size = FIRMWARE_START;
-    }
-
     /* Main memory region. */
+    if (machine->ram_size > 3 * GiB) {
+        error_report("RAM size is currently restricted to 3GB");
+        exit(EXIT_FAILURE);
+    }
     ram_region = g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ram_region, OBJECT(machine),
                                          "ram", ram_size);
-- 
2.20.1


