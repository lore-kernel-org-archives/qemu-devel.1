Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C24EC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460F72081E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MYB/HUHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460F72081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Rn-0000h5-0Z
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IW-0004BZ-So
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2IV-0003Bi-R6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:20 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:45076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2IV-0003Az-Lc
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:19 -0500
Received: by mail-pf1-x42d.google.com with SMTP id 2so891015pfg.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pn0fekFXNL0OWRArNV6f/06ch7ZUVwBYGTtvKiM2998=;
 b=MYB/HUHxSH7qSH3pT0CL0DGlqsJEr1uotx52IOEKkIfZAHFSy68IEFh2AE8/mMuHXU
 kahTPKrHssIQPBkg0rM/jChsRBl04r9UWstQx4l9qWGtdXU3vBhFL4hosAtEUUDrdQNu
 VbBo6tVNNLeYHZl25/V+hu88GEKno511kDloqjsnDfj9v4i3hhGi35KMOMsWMGoG+ioo
 ecAmHlXl0GWPAvdUHqJ90bj+JVXwcFKzw45dGC/YKR3I+pVTikzhFvidzDrtr5i8d/0a
 kWAlaC82owQ/8DUqBzo2Sg9eIO9G766QVqVgAfP7M+YEDrfq6JgsI/X5lBjliYa9I1OU
 dXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pn0fekFXNL0OWRArNV6f/06ch7ZUVwBYGTtvKiM2998=;
 b=aACKyXkK0e8B3Y3XHq9QcXxcWTo24cD2bKbdzmWawFNEvHFAfATWe+r+iprw4rQdzo
 iSQ7dZ+xyy3av69cawu3Yg65gtKWVQdzGP0Tucv5zRutB7vnZK2JIV0fixvPWrYCSvaV
 nApCOLMHvyBfYR8muem/A2n12/UE6roPP151mMiSkOIxSxggsLbmZty/ySsFXonE4fUq
 5Xpu/K5I/wEuGsuLGFCqRjhQWdcfJfzEZaVFj0RjnH44kO3K/NOvlf7NDtMJnsEZcS6O
 KqAI+iuSo2qU15k74bx7MrqKOH5T2kS68c39HvcGuZ1UD3lRsesTiq0LmsB1dyGv77Ur
 R1Qg==
X-Gm-Message-State: APjAAAVmOFEBU7wKVej6FC4ecJ/UFu2dQ7jzChenh+Lgbu20BISdOEwB
 QwvB8oqmKP+5P6gAVMaRYtfBHDIuYtHEwg==
X-Google-Smtp-Source: APXvYqwEDgZjzzFUwjOYma+bVfPH/14SQbVm6cqyqevBheRc5HEtF8+j1F/q/ns68akWfdSGPZjddw==
X-Received: by 2002:a63:48d:: with SMTP id 135mr3110716pge.66.1578455178323;
 Tue, 07 Jan 2020 19:46:18 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/41] plugins: Include trace/mem.h in api.c
Date: Wed,  8 Jan 2020 14:44:58 +1100
Message-Id: <20200108034523.17349-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on trace/mem.h being included beforehand.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/api.c b/plugins/api.c
index fa1d9f276d..53c8a73582 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -46,6 +46,7 @@
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
 #endif
+#include "trace/mem.h"
 
 /* Uninstall and Reset handlers */
 
-- 
2.20.1


