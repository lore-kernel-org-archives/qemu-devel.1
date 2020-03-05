Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ACCC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98EF8207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYt7hCQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EF8207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tQX-0005IW-NS
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP2-0003PC-In
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP1-0002Cj-9b
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:16 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tP1-0002CP-3T
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id a141so6419368wme.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WMI9IS/4151YY1zP87VIipDGkxKqiZ8SfaHL8luM++M=;
 b=XYt7hCQwRprSKxafrpUTVq/kH+AUDgIX3tqBY3+U5MsSxW95VJNZfEQJu7ZNdyilwi
 HnWU0AZBj0R0ba5CUm/VhPrXQPAItfibQJ5i5nJmT0K7E7nkSXeqhQVPBsGn+2RwesOd
 OIgYMSJ5EFxKMqnaTd2K/uQcbY8whz8esVleqrYKC8+Wk3quv4Fk7oVwBBKEwEDu8jZl
 M4OhuJlYSvs/jp36bGKpC1eW6RtaIT3zhgDL7fMDTIChYf1nf3L4f1bAhE2M3+3xJ5HH
 cffNGqLzsW5xC9PjZ4Qi7j2TTCGu9sZtIUo8+Fu8HDQYAtOFA2tCy0X2Zl0Jor1FAGr2
 Rg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WMI9IS/4151YY1zP87VIipDGkxKqiZ8SfaHL8luM++M=;
 b=bgWp6t4tujsl3XRbDFebgGK0XRHjqHFcbtK8N4Sx61Mo8R2YGYUi9BBUwhsyHurAZE
 8xwBhB4ubLeFMAQkXWCIBlYA3ElxGBR1n+0jPyu5xXzH7Y4c6wUK5At6ioxdWi2eYtDQ
 VCRNSHUII1VsYrqN1qsK2sTUeStnohH6Yfp6APvXw75gidlvATDPpI41fcASPAOiBk9z
 3mmPhacSVMtr4VW1NkzDZmcK+NqjGrkX3Y8uP54agw7vLF7NI0M6hTfo5KrZEPsUsJAy
 cjPK9MHfaa99JOPzo01rIBnrupnG3if+d0JaysLN4MOp2KIfCsuvjfnw20TSV3wXoy16
 25gA==
X-Gm-Message-State: ANhLgQ3OmTwWtNMuZ5fshqob2N3pOkl748o4V72kxEaiEza5+15c5esU
 BkMDuDJ9eXp0na+olCPzC8GpgkfXydF4Tw==
X-Google-Smtp-Source: ADFU+vswPdjpIubOj0kyIUk0j1tsLOoXAuRHwGFJPLeZwjibKWsqBaXz1SgRT1vhk0BfzuPkCOYamA==
X-Received: by 2002:a1c:9c87:: with SMTP id f129mr10719065wme.26.1583425873852; 
 Thu, 05 Mar 2020 08:31:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/37] hw/arm/musicpal: Simplify since the machines are
 little-endian only
Date: Thu,  5 Mar 2020 16:30:33 +0000
Message-Id: <20200305163100.22912-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

We only build the little-endian softmmu configurations. Checking
for big endian is pointless, remove the unused code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/musicpal.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index db8b03cb833..b2d0cfdac8a 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1645,22 +1645,12 @@ static void musicpal_init(MachineState *machine)
          * 0xFF800000 (if there is 8 MB flash). So remap flash access if the
          * image is smaller than 32 MB.
          */
-#ifdef TARGET_WORDS_BIGENDIAN
-        pflash_cfi02_register(0x100000000ULL - MP_FLASH_SIZE_MAX,
-                              "musicpal.flash", flash_size,
-                              blk, 0x10000,
-                              MP_FLASH_SIZE_MAX / flash_size,
-                              2, 0x00BF, 0x236D, 0x0000, 0x0000,
-                              0x5555, 0x2AAA, 1);
-#else
         pflash_cfi02_register(0x100000000ULL - MP_FLASH_SIZE_MAX,
                               "musicpal.flash", flash_size,
                               blk, 0x10000,
                               MP_FLASH_SIZE_MAX / flash_size,
                               2, 0x00BF, 0x236D, 0x0000, 0x0000,
                               0x5555, 0x2AAA, 0);
-#endif
-
     }
     sysbus_create_simple(TYPE_MV88W8618_FLASHCFG, MP_FLASHCFG_BASE, NULL);
 
-- 
2.20.1


