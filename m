Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FF4C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7DA21739
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpSpTaCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7DA21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaQ6N-0004mq-Qk
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 15:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iaPpR-0005lQ-4e
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iaPk4-0005Ja-Kq
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:46:23 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iaPk0-00052o-3b
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:46:16 -0500
Received: by mail-wm1-x342.google.com with SMTP id l1so12033441wme.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 11:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xd6QfwNiUuZdPTT7wpujCjGiQ2e91NoQmlqER4ZPXuQ=;
 b=JpSpTaCwy7M3rrf1KrlwDUZKqph0ZZLFcsYpaw9TPn68evSYwfZZzQ+VHXdahJgONJ
 qqrfXpBZHmOk0y5u4lapig6U01UJrjCvTCyPhnlGjSxpKeLr5CG3jeXcUpO87K1XzLes
 sZa79T7/HBZbNb8WDrxjX0tPP16E9+ebyC4vjEqVCQDoKe30nrvHRlrcc8anUnsm1Twl
 czBmIqZBJNsbMATdEZ/qghMXLMakyYiGhGvRYM/lRzSdDKf2xa5cN3dfTtlhvnpe0AYZ
 8ID9VOAlMNSqUy1tBM9SuiC7o0cqGBiCwyZSL3d3+Da+w4yj4euNnEubvZ5xNaUQVZdC
 USAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xd6QfwNiUuZdPTT7wpujCjGiQ2e91NoQmlqER4ZPXuQ=;
 b=IG6X4YrE+k6alAm5CbsyaUszZtmc5NYYv9G8608sMiPlqJ2DURlovHf6/3R4Iz9wVm
 WX9Olsn2J+k+rQWGC6ECoucSeUAM/DMeRXQWtOmcBUcYkwxHfTgv0BR+i87tJ/j+tl4F
 AxBEYtJTVvOkyhhslkfeHw4tPB6amv5kmtvA/aPeLbJ3DNcvuBfTkpxAiOHST5C1h4l1
 jhEvlcWOOqYMswAbuS6sol/qI/6ohSRDfRLTwQwLOpb3r63vK0K0dVbh+9EDFH6kZuvK
 cz7HlU5OcD6+ngW0u0c7NX3Opb5wqqN2zyet/uCZEMgXk0RiI61HUUJ+ZxLWSqkYsXon
 DCnA==
X-Gm-Message-State: APjAAAVMCAobEc1ZM/UqblXKfkadIZU471xuTZaI+ngkm9EGqNnuDCXF
 gzNIPh1Q6h8tO4y8q8XkuAbp1w==
X-Google-Smtp-Source: APXvYqwwdXI9W841RWRP9xk6AKlaSsDVF8zFT12ENySsW9yFtHYiT+Mwrei9O6bPaEv8TyOJjrHoAg==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr6418427wme.133.1574970369864; 
 Thu, 28 Nov 2019 11:46:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v188sm801710wma.10.2019.11.28.11.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 11:46:06 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B86CB1FF90;
 Thu, 28 Nov 2019 19:46:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/5] linux-user: add target_mmap_complete tracepoint
Date: Thu, 28 Nov 2019 19:46:01 +0000
Message-Id: <20191128194603.24818-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128194603.24818-1-alex.bennee@linaro.org>
References: <20191128194603.24818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For full details we also want to see where the mmaps end up.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/mmap.c       | 2 +-
 linux-user/trace-events | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index c81fd85fbd2..a2c7037f1b6 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -577,8 +577,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
  the_end1:
     page_set_flags(start, start + len, prot | PAGE_VALID);
  the_end:
+    trace_target_mmap_complete(start);
 #ifdef DEBUG_MMAP
-    printf("ret=0x" TARGET_ABI_FMT_lx "\n", start);
     page_dump(stdout);
     printf("\n");
 #endif
diff --git a/linux-user/trace-events b/linux-user/trace-events
index 9411ab357c9..774280cefbd 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -15,3 +15,4 @@ user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_add
 # mmap.c
 target_mprotect(uint64_t start, uint64_t len, char *flags) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=%s"
 target_mmap(uint64_t start, uint64_t len, char *pflags, char *mflags, int fd, uint64_t offset) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=%s flags=%s fd=%d offset=0x%"PRIx64
+target_mmap_complete(uint64_t retaddr) "retaddr=0x%"PRIx64
-- 
2.20.1


