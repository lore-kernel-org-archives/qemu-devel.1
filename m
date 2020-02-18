Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B04EC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187CE21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+nUt1NZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187CE21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48oP-0004FI-BB
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48if-0003r4-RU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48ie-0004Xz-Rq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:45 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:46356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48ie-0004WR-Kb
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:39:44 -0500
Received: by mail-pf1-x42e.google.com with SMTP id k29so11140217pfp.13
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QSNJImV6Sv3hjKepfQ333kr7g+hkYoplwMWy8vc32R4=;
 b=p+nUt1NZPZDuAmJfkVnK457U7ab00RT3CzSfwMmbu1JFbVFfr0bYGKMDks1xhEa+jR
 jlwfmZYxHrnCmHI9src3LkTtA9CG5Jomo5lfLSz1IJs5EKnrN+MOcOdNovthW1OiFdjz
 ujCqSU3gKPIhzrddlFxDQTyNCWHONDeuFWP8h/3Zp2ci1SBMCDq+ZzzxrbC0j9SwpDLq
 QhVFTr5FErXWnyoN0O+bLOCnwX96wCMwD1qKFt/jxfaWVXuRZHYbzLIMNzWN/rrSghPu
 o4bp660AsTREEi46fPICnti0+M9SImkYe3Xv29zFj6nes/gTqoLHUo4awtmv2w2Bf1JY
 1Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QSNJImV6Sv3hjKepfQ333kr7g+hkYoplwMWy8vc32R4=;
 b=RXz2oHnZGVqyidS+6PSD/IiiyspTzkpobHC1wI+L1z1WEVcKrPiQVGGwkAzgIagQiH
 sVkq0t+Qwcf7FgloAeMnKsvDuW2I5ynUi3lI3HGR41JJbi2ans4tgUTRm4aK0vOrN+Kw
 gLI/1nNdSeRToAvZRYr9uryqMIaGwYt9JLQTIRWnIoDQ+4/sq3eT+OaHMBdw0gDGrXpX
 yH6iAnG94ulg4iOlqvq4k2+x1XFsOkfx8rakQ3/RWYeYPP7ZoK3WAI8Hquc9cFmYomJr
 IM6+8AiEz5Eu6HlcurnI1fWzQedbc/mSvrOTa5+xSEGF8ZWMEsr0VEoQjQgzalE3iYAx
 v5Hw==
X-Gm-Message-State: APjAAAX5tAfadVKDoz1GATq1GE9/2z3JIi/2KshS7vmHHKbDz/O9XwJz
 xJJ2JlNZHQcFW4AgW6IFPdVEcC0bquE=
X-Google-Smtp-Source: APXvYqz9xNWTqL3tgfuf8ghhq9A7rWrU9IEpJTWL1MMfFU/zPYRkEaoDEBcVwiIVYf+qVMJbSYc1LQ==
X-Received: by 2002:a63:5f4e:: with SMTP id t75mr23941327pgb.7.1582054783296; 
 Tue, 18 Feb 2020 11:39:43 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y15sm424395pgj.78.2020.02.18.11.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 11:39:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] hw/hppa/dino: Do not accept accesses to registers 0x818
 and 0x82c
Date: Tue, 18 Feb 2020 11:39:29 -0800
Message-Id: <20200218193929.11404-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218193929.11404-1-richard.henderson@linaro.org>
References: <20200218193929.11404-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
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

Register 0x818 is documented as 'undefined', and register
0x82c is not documented. Refuse their access.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200218063355.18577-5-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/dino.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index be799aad43..2b1b38c58a 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -181,7 +181,9 @@ static bool dino_chip_mem_valid(void *opaque, hwaddr addr,
     case DINO_IO_ADDR_EN:
     case DINO_PCI_IO_DATA:
     case DINO_TOC_ADDR:
-    case DINO_GMASK ... DINO_TLTIM:
+    case DINO_GMASK ... DINO_PCISTS:
+    case DINO_MLTIM ... DINO_PCIWOR:
+    case DINO_TLTIM:
         ret = true;
         break;
     case DINO_PCI_IO_DATA + 2:
-- 
2.20.1


