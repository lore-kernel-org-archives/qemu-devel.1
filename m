Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B26C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872DF20737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJTYoCy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872DF20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRnO-0000Q4-Ku
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjT-0003Gx-IH
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjS-00028i-BN
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjS-00026Z-4F
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id p10so9799909wrt.6
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L6skE25jv77X3Ic3q30MQuACWpAXjktUtUIdWwwluKc=;
 b=fJTYoCy/lEiJMV48/JGCu+kfV9Bkzb2MWZwVR/fDUJdJsFcy9Be50ItHs2ID/3dj2p
 9zvkmRmQagwdHDeAEoTlV7cpeL0nmXMXrk1VLm6/qZvYF5PxcSUbw6ZDDS0VSwebWMyO
 xSargiPA4+W9iiDULBOO9TonftJ8/t1AcHgLt7yM8fgBSf3nrR29xLf1//4yUhc9b/pB
 yjRHEkL3HaxYD6prgUKgXNaOiEoIPa/V1VGPzzTxJHve4bpCMMPW8zGcUK9mWXSSiaes
 vKtfx/13xyU5hZOocR04YhTmV5o3erbZwuSWG6Z7+ayMHzYaAkCL2R/cuCIrVJY3hNX/
 O2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L6skE25jv77X3Ic3q30MQuACWpAXjktUtUIdWwwluKc=;
 b=jA+BHlfwOADfI66iMR4KELREAIWFxk9f2hzI3tZutKACVTuO3Vj+Afua/wgMGR+Yos
 GstgwXQ+gjyXFoN6RmTxnwrYk4QPOUgdGRXVBEuO6jfJuBHw5n74BBoUNF427VaKbRJo
 LahIb/Ika8dml2jOp8dgxXiC1be3NXYYg+/eIYsOh/i8lRri9SYC3ZTtsfSD8bjetQ/i
 9ag6WzZZRRgf6KazmsRr8mAwx79hW4ko0+2lkVEcm158EjSc4la1mlmoPjkXj9NNy5/l
 HYK4IPLqi3EQEaOtE5x+4vOw9BTaTMmYxyiiTzaS1wHwdGRRwUf2hpw98/jkVQVxGIfX
 hMPA==
X-Gm-Message-State: AGi0PuYVsGZ7Uf+T/MPMc+EoXsuuGzkHYP3DZSkJkEEVsiRJQ1KVsXvN
 bRGecu5gUruQGv1NE0E3Qq+tsw==
X-Google-Smtp-Source: APiQypJWhBpbhvItGrxG9ZozVVZn9ZxdulOkke/J1l/9hFBgGbjIpBaTdJgst8/1FyKhI3m3ftsj1w==
X-Received: by 2002:adf:a48d:: with SMTP id g13mr11235534wrb.38.1585941117105; 
 Fri, 03 Apr 2020 12:11:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s66sm12965448wme.40.2020.04.03.12.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F39E41FF90;
 Fri,  3 Apr 2020 20:11:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 04/12] linux-user: more debug for init_guest_space
Date: Fri,  3 Apr 2020 20:11:42 +0100
Message-Id: <20200403191150.863-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Searching for memory space can cause problems so lets extend the
CPU_LOG_PAGE output so you can watch init_guest_space fail to
allocate memory. A more involved fix is actually required to make this
function play nicely with the large guard pages the sanitiser likes to
use.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8198be04460..619c054cc48 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2172,6 +2172,8 @@ unsigned long init_guest_space(unsigned long host_start,
 
         /* Check to see if the address is valid.  */
         if (host_start && real_start != current_start) {
+            qemu_log_mask(CPU_LOG_PAGE, "invalid %lx && %lx != %lx\n",
+                          host_start, real_start, current_start);
             goto try_again;
         }
 
@@ -2240,7 +2242,11 @@ unsigned long init_guest_space(unsigned long host_start,
          * probably a bad strategy if not, which means we got here
          * because of trouble with ARM commpage setup.
          */
-        munmap((void *)real_start, real_size);
+        if (munmap((void *)real_start, real_size) != 0) {
+            error_report("%s: failed to unmap %lx:%lx (%s)", __func__,
+                         real_start, real_size, strerror(errno));
+            abort();
+        }
         current_start += align;
         if (host_start == current_start) {
             /* Theoretically possible if host doesn't have any suitably
-- 
2.20.1


