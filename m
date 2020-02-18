Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18278C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC4F206EF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKxJiORA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC4F206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wV7-00037e-Un
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSX-000804-WF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSX-0007C6-02
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:17 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3wSW-00079a-JF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:34:16 -0500
Received: by mail-wm1-x342.google.com with SMTP id a9so1570845wmj.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2Ouq7XQLosFxrv2edg/baO3XM9qB7VdwC5zrCS7tFOI=;
 b=bKxJiORA0jLEcMV7/mcaMBwiChyd/75WZ2/7cQeXERBOLP9/B8ow/CXqdcLEb4jhN3
 4Yvgh1z2YCfOUQkObx19QEOlt6qxflCU3HJj2jPq9ZNAtcfy7fd09wgAyf9kc9fEVJ9k
 JbhlmGlYw4v1CvLotiH3WAvAc9kCF8fyP6gxp5PBiA2ZYomX3+fRArNfGDhDhQ1jvkB9
 FEg8b0RhxEuC3A20erXETk7iZCNThAzQWzzNi0+mKNpZJDp/Ldr9LOQpwOy8zZ17ssTJ
 TB9ZuBqwpZEcFFvPGhNZ/Vh7jG5B+UJb7dRFt9Nogi0kQnIuu4c7R4jWwhYwHYUC2EJJ
 EjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2Ouq7XQLosFxrv2edg/baO3XM9qB7VdwC5zrCS7tFOI=;
 b=mMpcZ36lpv/0GVoSa9Rm0Ok0bAJBhXj59k+nscHRvQWs7hr+gJZbhoE5Hty9frFXX0
 E5cb/LEtVgX4KwjPOg39b3roUOzRPzTaeieTQvQQ4YT5ONRXwXfmmgFc7V3fP9ZmPtpQ
 kLqUJCXcq7KnJvkM66xXxRdEeIrn9peu61yEcMSxd/vFRYJ0paZhBrfCU5wqI5MLUTt9
 d5JE7DOXcxsjcnrYNMXl6bJClXF8KYKVTdU+MBrjuAqA4vB0oKaPRWEUVhaShMDGkskI
 mZlnDVNCKewyKumygFm+XU8t5LPhcG1FT1vjz1VYV/7CYj8kXQGl3OpPgY0N17GkIOKv
 V2VQ==
X-Gm-Message-State: APjAAAVhZp0vq6IJGsf799CBK8R6eK1bPmnFPOKYDA3bavqFwFh88hpq
 8No2gCa3XD6uUUCVivAJ8/k=
X-Google-Smtp-Source: APXvYqzgpVhOrzUFGVjcgkdfbJn2zWj3DjYFVk9IQ6yewPjlo+lpOkSO2L33cAlBKQJvd/X0uIZPtw==
X-Received: by 2002:a05:600c:34b:: with SMTP id
 u11mr1074911wmd.69.1582007642317; 
 Mon, 17 Feb 2020 22:34:02 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y7sm4374683wrr.56.2020.02.17.22.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 22:34:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 4/4] hw/hppa/dino: Do not accept accesses to registers
 0x818 and 0x82c
Date: Tue, 18 Feb 2020 07:33:55 +0100
Message-Id: <20200218063355.18577-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218063355.18577-1-f4bug@amsat.org>
References: <20200218063355.18577-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Register 0x818 is documented as 'undefined', and register
0x82c is not documented. Refuse their access.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.21.1


