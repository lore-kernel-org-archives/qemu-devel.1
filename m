Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC61C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8EC42245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M38C/sxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EC42245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrmq-0000bL-Ck
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:07:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icrbn-0007jf-Ll
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icrbm-0000Rt-1h
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:55:55 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icrbl-0000MS-NG
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:55:53 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so3708103wrt.6
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 05:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+aAcg7zfu3h11WqWsNjIj4w0+SSQrzO+SPiMdumxwPs=;
 b=M38C/sxQAU0NtdioFNZF9aZmTzys4b+YebJd6E6ryGA5szJQ/nxOY0gESlUJqu3pUY
 2WknaPFSyQYiaPkhe9NGpp6VPqCo4+mwI2mlrDojQO2QUvnqVG0CxhEwk1ApmpwpS2uX
 qmRqwB8i2zbCKprwTTBpHoUVJd+EBr3c9R1wEOvPzFZLvijJeN/HWt82TiioU2Hhxylx
 c9h4mfDBpyH7JOQAuWWsghvhHNzXL+mHqGEFTh0mHFH1P2exmzh7uf3C3tMqDPZ0RIQK
 QL38hjsnIkIf4qkMsGh1ucv4qKqpXlUgME4+s7K7Zec38ft+Vg9lHkKylpLEyZrqL0E5
 3l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+aAcg7zfu3h11WqWsNjIj4w0+SSQrzO+SPiMdumxwPs=;
 b=FyeS22JEpO5V8J05Ogzp4OtCQntqN2lFpfKSdcEAQfI9z6mUDrG/pUX3PSmZeNB2mC
 G4fV/XuYz4OcdAp1fwGda9/ERX/aatYGSeaZaJhGj0JSDbDjv4JWdwH38eAs7u9ugv1g
 wmACOP+cTLzoXCkMt2r9/eDliljQDChqATItAMHvXwW6KaocEhMYt4M+BFi52cyITMkY
 Jsil9mdQaidl1oCakqb0T8ZNJUj1/uJb7WND2GVdmUL+UHALlpffKj+a+9sFuytlnm5J
 4VvVcvkesrokxiDYfV/RNnytzPUy2fQMQVs/29wFLNODcyxmLrqW5O2h5n4cswrP5w22
 8nNg==
X-Gm-Message-State: APjAAAWd0vrPq5NOMMSXObL+DeFVCcDPqualrNlkB+7eVVsAzZkg4GuE
 4rH5sK/Z67hBEZoJ2OOi28pNaXr02Ds=
X-Google-Smtp-Source: APXvYqwy2+El1zorGSaAjV9lh9JnG3fvQrzwpUbWk9vOW/x19vOf2ZEg54rhbs+KB4t73Yjnwsb27Q==
X-Received: by 2002:adf:f382:: with SMTP id m2mr9800560wro.163.1575548725921; 
 Thu, 05 Dec 2019 04:25:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v3sm9639813wml.47.2019.12.05.04.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 04:25:22 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6A1A31FF91;
 Thu,  5 Dec 2019 12:25:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 4/6] linux-user: log page table changes under -d page
Date: Thu,  5 Dec 2019 12:25:15 +0000
Message-Id: <20191205122518.10010-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205122518.10010-1-alex.bennee@linaro.org>
References: <20191205122518.10010-1-alex.bennee@linaro.org>
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

The CPU_LOG_PAGE flag is woefully underused and could stand to do
extra duty tracking page changes. If the user doesn't want to see the
details as things change they still have the tracepoints available.

We push the locking into log_page_dump and pass a reason for the
banner text.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
  v2
    - reworded banner text
    - moved locking into helper
    - converted stray calls of page_dump
---
 include/exec/log.h | 5 ++++-
 bsd-user/main.c    | 2 +-
 linux-user/main.c  | 2 +-
 linux-user/mmap.c  | 8 ++++----
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/exec/log.h b/include/exec/log.h
index e2cfd436e61..012af09f9b3 100644
--- a/include/exec/log.h
+++ b/include/exec/log.h
@@ -50,9 +50,12 @@ static inline void log_disas(void *code, unsigned long size)
 
 #if defined(CONFIG_USER_ONLY)
 /* page_dump() output to the log file: */
-static inline void log_page_dump(void)
+static inline void log_page_dump(const char *operation)
 {
+    qemu_log_lock();
+    qemu_log("page layout changed following %s\n", operation);
     page_dump(qemu_logfile);
+    qemu_log_unlock();
 }
 #endif
 #endif
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 470a8bf79ed..7f4e3cd6271 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -963,7 +963,7 @@ int main(int argc, char **argv)
 
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         qemu_log("guest_base  0x%lx\n", guest_base);
-        log_page_dump();
+        log_page_dump("binary load");
 
         qemu_log("start_brk   0x" TARGET_ABI_FMT_lx "\n", info->start_brk);
         qemu_log("end_code    0x" TARGET_ABI_FMT_lx "\n", info->end_code);
diff --git a/linux-user/main.c b/linux-user/main.c
index 6ff7851e86f..8718d03ee21 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -826,7 +826,7 @@ int main(int argc, char **argv, char **envp)
 
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         qemu_log("guest_base  0x%lx\n", guest_base);
-        log_page_dump();
+        log_page_dump("binary load");
 
         qemu_log("start_brk   0x" TARGET_ABI_FMT_lx "\n", info->start_brk);
         qemu_log("end_code    0x" TARGET_ABI_FMT_lx "\n", info->end_code);
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 0b1b43ac3c0..3d90fa459ca 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "trace.h"
+#include "exec/log.h"
 #include "qemu.h"
 
 //#define DEBUG_MMAP
@@ -539,10 +540,9 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     page_set_flags(start, start + len, prot | PAGE_VALID);
  the_end:
     trace_target_mmap_complete(start);
-#ifdef DEBUG_MMAP
-    page_dump(stdout);
-    printf("\n");
-#endif
+    if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
+        log_page_dump(__func__);
+    }
     tb_invalidate_phys_range(start, start + len);
     mmap_unlock();
     return start;
-- 
2.20.1


