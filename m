Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326ECC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF752084D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5CELZuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF752084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaRcn-0003j8-Eo
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 16:46:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iaPpP-0005c5-Ra
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iaPk4-0005J9-IQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:46:23 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iaPk0-00057J-Qc
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:46:19 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so7825079wrn.7
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 11:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IGkE42M4Q3eQbdw5NzOuWOoq/KgXpAh9fYfQ2Axv8vw=;
 b=t5CELZuy5IsnSKVq33/vHd6UsAbIp+WNKtT/fV6zNifx6sXJzyMpnMpwLBdlrYGI7P
 Jc8h0ZR0o30ZgS64CpEajP24pPnCUCNR079/oMc56yejh3RtOhpu8LPJZlWFk35yr49P
 8yO2L5QUmUg1RpGjcBElMpfRy0YeHjwtZxBjZekgHiE8JBHXHGwkJnh8PNBhOOc8kNP5
 BWnS46LIdOHUN9FjMov7Kwbj/R0pckcADMxrFE1Azp6vWsVQe+fdc4BNCvI0qy8ltwhy
 9hw+Tuk50kr//ovJbkyyhkcT2zVlDMQrB8x0Eqpq0mOdsRCAkjaXoDZa1lmMcRNYUlj0
 P8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IGkE42M4Q3eQbdw5NzOuWOoq/KgXpAh9fYfQ2Axv8vw=;
 b=DrI9ateNLqJfbPAtCHq1Q08xvQgAxYkrf4dfN6rT0IyITUDE5I9j59bUhnXQ80UESw
 iv4Njn+2eBRo7MzXTZ3S4R/TLFovHblgje+/4T2yYwGblOgLVljZ27MZMZ7opb+RWLEh
 mZ4CfvfREiZJz/L8+YfXcjwUD5g4qH3PoAtWr4+8OQyMfHx+Z0ATUwqStc74K9kFDMFd
 FuaaU1c/+izxrWhJlWStXBvA8FsZvRQsneswrQUCf/KA2xEb+wZdJATQ6yvsXmtKYjZL
 UWpxlgtFg6UfQgG8eeY50eFOlJae0MnRDXSQVG38nG8B8RTvI9VMjxlFna31f9Xssayk
 Tbpg==
X-Gm-Message-State: APjAAAWKM8IzoUA8fElq+9PEYJuJ43MEgzcSC1H+3bTlnfDFgGJmT55E
 zR+L0Z/U5HrMkdVQdCUTDRggpA==
X-Google-Smtp-Source: APXvYqzYEDxbwW18VYylleGOTbvv60+5s7sO3Gifiuvhgck1ZHOg9Wl3PXeRlDutt+lvHA7I5SWY+g==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr32189927wru.154.1574970372552; 
 Thu, 28 Nov 2019 11:46:12 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r6sm11550494wrv.40.2019.11.28.11.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 11:46:08 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E20F51FF92;
 Thu, 28 Nov 2019 19:46:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 5/5] linux-user: convert target_munmap debug to a tracepoint
Date: Thu, 28 Nov 2019 19:46:03 +0000
Message-Id: <20191128194603.24818-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128194603.24818-1-alex.bennee@linaro.org>
References: <20191128194603.24818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Convert the final bit of DEBUG_MMAP to a tracepoint and remove the
last remanents of the #ifdef hackery.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/mmap.c       | 9 ++-------
 linux-user/trace-events | 1 +
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index c2755fcba1f..137aa3eb95f 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -21,8 +21,6 @@
 #include "exec/log.h"
 #include "qemu.h"
 
-//#define DEBUG_MMAP
-
 static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
 static __thread int mmap_lock_count;
 
@@ -639,11 +637,8 @@ int target_munmap(abi_ulong start, abi_ulong len)
     abi_ulong end, real_start, real_end, addr;
     int prot, ret;
 
-#ifdef DEBUG_MMAP
-    printf("munmap: start=0x" TARGET_ABI_FMT_lx " len=0x"
-           TARGET_ABI_FMT_lx "\n",
-           start, len);
-#endif
+    trace_target_munmap(start, len);
+
     if (start & ~TARGET_PAGE_MASK)
         return -TARGET_EINVAL;
     len = TARGET_PAGE_ALIGN(len);
diff --git a/linux-user/trace-events b/linux-user/trace-events
index 774280cefbd..bd897add252 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -16,3 +16,4 @@ user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_add
 target_mprotect(uint64_t start, uint64_t len, char *flags) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=%s"
 target_mmap(uint64_t start, uint64_t len, char *pflags, char *mflags, int fd, uint64_t offset) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=%s flags=%s fd=%d offset=0x%"PRIx64
 target_mmap_complete(uint64_t retaddr) "retaddr=0x%"PRIx64
+target_munmap(uint64_t start, uint64_t len) "start=0x%"PRIx64" len=0x%"PRIx64
-- 
2.20.1


