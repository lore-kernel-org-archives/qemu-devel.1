Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B460BC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817222245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnkFp6iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817222245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrpC-0003hM-BG
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icrnW-0001z4-AA
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icrnU-0006Mr-Uh
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:08:01 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icrnU-0006Es-L3
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:08:00 -0500
Received: by mail-wr1-x442.google.com with SMTP id z7so3696269wrl.13
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 06:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LlKAQUU8BKqjO5SGyRq373lXLOzaiq/UNvhXOUrnIRc=;
 b=PnkFp6iwJHjJz5h4WFjkI0alqjBMd1+8kTpKE8H0jcyRQIY8Xu9PxjqlShj/GfZxOJ
 AR1UgiQfnS+hSiz3S98XmqRggV5a1ht7JN7ZrJJ2lu4zLshalRb9WTNIatbQM+GL10y6
 miuyiQLVClhZWSZz6AeiWN3udkVhLFC46yTuCeFgDTz/IXPgpUQgp49X920SJ4ac2+o7
 HYYqeYCOkzw3DiIeIuCDEOlT9Xk2lj2NvwBHaiU4Vkg2/ElUjfbc5fVbepyjZJ63fZvI
 gUxTgW0uhov6oOxlxlD/QswX3eBzeqK8R/LXhdok4rr/4a0pePK+mp6TfVUJdu+YL+wS
 z5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LlKAQUU8BKqjO5SGyRq373lXLOzaiq/UNvhXOUrnIRc=;
 b=iI/RonqgHwVdnEn1dOGrTQfb2+q6laKxeK6Rrjqb3OtJ8c87D6JdkfSv7St6a2qxXt
 qnY+vFAI8pM4IPy1pwSz5OZqXFUfsDGv7kPQaAFyVcxpEjfG1MWdB7l5OZ3vnaLQiwts
 bFO4lpjJZSds4KYzYaQBN7aB9oV8k5B1Fw1ASxpu7I7KTQC75xf/LKhcJbwGTC5EAoDr
 SPgSR/Zg01texl4WeQI2TzB72m+7XtGm61e0Bi+l9KpJi37kOYtMQZiEt9ESLMrbcDiV
 CU1Q9tMFS8iFV/10hmt78YcA5LOaITva82yhoo9eT0WbQMU/TO4t16wRLP8GzL/kfKPj
 mx2A==
X-Gm-Message-State: APjAAAXxjuMCxgoxyK/nVw3f8QHqrWJHgq8Rvs3Dfe/vjGB1MjBwPMPl
 oVSFg5Ls5Au01ayzHImU8R/lOfZPuXg=
X-Google-Smtp-Source: APXvYqz9TOS7bca2SwKFuCPe0c/tREBtWUGY/+v4q6e4uxDXLkqfSO+ISmTHFY8LOm9MaeHm96nHrw==
X-Received: by 2002:adf:f581:: with SMTP id f1mr10237571wro.264.1575548727599; 
 Thu, 05 Dec 2019 04:25:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm10125668wmd.1.2019.12.05.04.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 04:25:23 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7EB841FF92;
 Thu,  5 Dec 2019 12:25:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] linux-user: convert target_munmap debug to a tracepoint
Date: Thu,  5 Dec 2019 12:25:16 +0000
Message-Id: <20191205122518.10010-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205122518.10010-1-alex.bennee@linaro.org>
References: <20191205122518.10010-1-alex.bennee@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the final bit of DEBUG_MMAP to a tracepoint and remove the
last remanents of the #ifdef hackery.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c       | 9 ++-------
 linux-user/trace-events | 1 +
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 3d90fa459ca..8685f02e7e9 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -21,8 +21,6 @@
 #include "exec/log.h"
 #include "qemu.h"
 
-//#define DEBUG_MMAP
-
 static pthread_mutex_t mmap_mutex = PTHREAD_MUTEX_INITIALIZER;
 static __thread int mmap_lock_count;
 
@@ -597,11 +595,8 @@ int target_munmap(abi_ulong start, abi_ulong len)
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
index 6d6aeef7b52..f6de1b8befc 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -16,3 +16,4 @@ user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_add
 target_mprotect(uint64_t start, uint64_t len, int flags) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=0x%x"
 target_mmap(uint64_t start, uint64_t len, int pflags, int mflags, int fd, uint64_t offset) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=0x%x flags=0x%x fd=%d offset=0x%"PRIx64
 target_mmap_complete(uint64_t retaddr) "retaddr=0x%"PRIx64
+target_munmap(uint64_t start, uint64_t len) "start=0x%"PRIx64" len=0x%"PRIx64
-- 
2.20.1


