Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD32C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60A722525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKOCD9L3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60A722525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrMX-0007qC-VY
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icrIL-0005b5-8P
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icrII-0000Qn-Nx
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:35:48 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icrII-0000Kj-DJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:35:46 -0500
Received: by mail-wr1-x42f.google.com with SMTP id y11so3616883wrt.6
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 05:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ojk/DQPD5yxe3f3qJM/gjK8YaBYa+zXsUEip1if0FLM=;
 b=rKOCD9L3meiIyOgEQNRLS3TDw2OoMphNKnf6kkU2Y3EZ7bMVe/ddDkJW4MdUnZJjuA
 vd03D6eYzVN52MtTcHt85x44EcpFZO+gLT6WhewyraJdPxlSWFg+0BIjG5j6pJ3gs0DK
 Ym08+PcuoVv7PMtIVezLIhGVC2fuxU00Ylo24zNv1hfFSaUiIsYPpd4KLhC0ck/gQ+sm
 gLafAmwXObk00LLFAPMvk6QwszyaMjJmx5aUnXJVOae4wNxRXLMjTAoYEYmQ35veHOh/
 AlcUBWlZmAhjHWklvS9X0MTJaAatl4V6dQTUxnOLyhrMOcGRQ9PUbb2yDU/guaU/e0h8
 lASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ojk/DQPD5yxe3f3qJM/gjK8YaBYa+zXsUEip1if0FLM=;
 b=BxPTWiQe1QunBIeqOiAqJudsn6pJo5HKV0DdOj+b4r6DO0xVQxFIsGMf8uBxQRzbmD
 EVGYVG/O5M807pjUtS+8fuW8650oB7KTElM59HNdMDkn2U4G47vOX0pz2nAjAHlgbKNC
 rIJBqyXG/XDlWMewu5JCJ25eRuIb8nLfOteRtjcxW/XrgsmSwTXegt1+d3dr7YpKMnIC
 /wm65G5cba+EuVPS7KWqbiUUpAWzeMK+VxGaLyeX/ixAMolV1+l4tCBPJEV9KJq7jyWL
 UJ0ZgTtK2EUFTpzhfr4kxe3WigexahuaoSC5N/CAwhoHufmtmkKXDR0S4+WNGc9osiZH
 onLw==
X-Gm-Message-State: APjAAAWnSla6qV6mWWkSmUl5ZQ/vZdl8IuN7IP5G/pXK1ZsgLnMQpRhC
 XRo7DKK/aklxHNByYIIL79jO9RykDQE=
X-Google-Smtp-Source: APXvYqz5Oa+2PH4m3D2Y8zwvkXvSzhC3OpGgHSFi8aBXOY+4aGKvlEahkfU8Exfpyt1jHa5uIXH7iw==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr10394205wrr.340.1575548721417; 
 Thu, 05 Dec 2019 04:25:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v20sm10471139wmj.32.2019.12.05.04.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 04:25:18 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3BF631FF8F;
 Thu,  5 Dec 2019 12:25:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 2/6] linux-user: convert target_mmap debug to tracepoint
Date: Thu,  5 Dec 2019 12:25:13 +0000
Message-Id: <20191205122518.10010-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205122518.10010-1-alex.bennee@linaro.org>
References: <20191205122518.10010-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

It is a pain to re-compile when you need to debug and tracepoints are
a fairly low impact way to instrument QEMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/mmap.c       | 27 +--------------------------
 linux-user/trace-events |  1 +
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 26a83e74069..f4f10deaeac 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -363,32 +363,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len;
 
     mmap_lock();
-#ifdef DEBUG_MMAP
-    {
-        printf("mmap: start=0x" TARGET_ABI_FMT_lx
-               " len=0x" TARGET_ABI_FMT_lx " prot=%c%c%c flags=",
-               start, len,
-               prot & PROT_READ ? 'r' : '-',
-               prot & PROT_WRITE ? 'w' : '-',
-               prot & PROT_EXEC ? 'x' : '-');
-        if (flags & MAP_FIXED)
-            printf("MAP_FIXED ");
-        if (flags & MAP_ANONYMOUS)
-            printf("MAP_ANON ");
-        switch(flags & MAP_TYPE) {
-        case MAP_PRIVATE:
-            printf("MAP_PRIVATE ");
-            break;
-        case MAP_SHARED:
-            printf("MAP_SHARED ");
-            break;
-        default:
-            printf("[MAP_TYPE=0x%x] ", flags & MAP_TYPE);
-            break;
-        }
-        printf("fd=%d offset=" TARGET_ABI_FMT_lx "\n", fd, offset);
-    }
-#endif
+    trace_target_mmap(start, len, prot, flags, fd, offset);
 
     if (!len) {
         errno = EINVAL;
diff --git a/linux-user/trace-events b/linux-user/trace-events
index 8419243de4e..8d8d4c3c68c 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -14,3 +14,4 @@ user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_add
 
 # mmap.c
 target_mprotect(uint64_t start, uint64_t len, int flags) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=0x%x"
+target_mmap(uint64_t start, uint64_t len, int pflags, int mflags, int fd, uint64_t offset) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=0x%x flags=0x%x fd=%d offset=0x%"PRIx64
-- 
2.20.1


