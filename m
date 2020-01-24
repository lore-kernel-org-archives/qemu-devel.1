Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A240C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232C62071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXgqQdbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232C62071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv8IR-0001Ll-78
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 18:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8Fj-0004hO-A8
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8Fh-00064Y-6g
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:38 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:56301)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iv8Fg-00062Z-VS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:37 -0500
Received: by mail-pj1-x1035.google.com with SMTP id d5so460882pjz.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 15:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8oXffAFFos84hGLyMp+4FwyG83aEe0q98CSCZqlUHVE=;
 b=iXgqQdbK3I+mAtQn4OALCQIri1ty6l2Z+Vn3JwQOKaXH5/BIy6ZIR0XHYUfzKN2Jot
 gWIWOY/S+wy4pLlKEA6LzafklmIAi59Cp2HCiuXrvhx0D4az/BsCvNeEVoJ5ETpNTN6c
 pYpkE7Jz4170sy/erU0c7iRrb2wt26RrZzju1sasM5wxXQI3YZkRHvirv5x9BNMft/jo
 ivjUz+YOeEefBJLHhR0n5VpLzb4T/7r+qzsZ0Zmjsi/bQfvU8+gD3pyOsnKtWu87UJgA
 1hTpQJC+WwYllYC41MOPFhfa9ARYJnWTQngmcv68mTVvsdG4bPmMue4O6Y6Cf26MXSl1
 PNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8oXffAFFos84hGLyMp+4FwyG83aEe0q98CSCZqlUHVE=;
 b=QaUnMhOifQuTu8LCN0PFggdGs4+gQkbE7Opy8OBuEAT9oxOZG2++XMYoFi5lcXVkTV
 wNnu1J/1erkdytGWBjuONBYwtwYxBs5/yp+g0av11oMexyQTvQuWLKTNV0hWCKMaqFjC
 tn1PsXCyMSr+KvOQLitm2k29pBO7e6epsHA1Krm4KrsATtwXf13JJ80SQ9rf/D2Rjg3Q
 C4Xs8I3/OmgHyLnMdXjaVmvRz0nHVey1NLwy8sccJuxVI8YU3btpI3alwwtrnhC6jvQT
 mog/7yAtFLcOgT1d9edLVxA5nlfPp3J7Cgg5crlUfSI411lJR6kvmjCjJb2mOnZAbcRJ
 DBLA==
X-Gm-Message-State: APjAAAXw5E/T89arQjqZ1EUwfyfeGGLsvaHUkJUpxC2KoDh1xf8h9isa
 MPFnQiMcnQbVRuVfaZpfFMLJk5GxuGw=
X-Google-Smtp-Source: APXvYqypl5Pirr3vbNY6MY8oxCIeLjIA3uLpcjRim1U6juXp7YwCKXq1zsxlH7UQgVaar8JpLLkuUQ==
X-Received: by 2002:a17:90a:8042:: with SMTP id
 e2mr1875284pjw.16.1579908035316; 
 Fri, 24 Jan 2020 15:20:35 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id v4sm8377880pgo.63.2020.01.24.15.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 15:20:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 08/11] hw/hppa/machine: Correctly check the firmware is in
 PDC range
Date: Fri, 24 Jan 2020 13:20:06 -1000
Message-Id: <20200124232009.12928-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124232009.12928-1-richard.henderson@linaro.org>
References: <20200124232009.12928-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1035
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
Cc: peter.maydell@linaro.org, deller@gmx.de, svens@stackframe.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The firmware has to reside in the PDC range. If the Elf file
expects to load it below FIRMWARE_START, it is incorrect,
regardless the RAM size.

Acked-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200109000525.24744-2-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a35527cfc7..e57530950a 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -171,7 +171,7 @@ static void machine_hppa_init(MachineState *machine)
     qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
                   "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
                   firmware_low, firmware_high, firmware_entry);
-    if (firmware_low < ram_size || firmware_high >= FIRMWARE_END) {
+    if (firmware_low < FIRMWARE_START || firmware_high >= FIRMWARE_END) {
         error_report("Firmware overlaps with memory or IO space");
         exit(1);
     }
-- 
2.20.1


