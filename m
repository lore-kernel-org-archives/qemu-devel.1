Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF79CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BBF2465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Af9MJSlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BBF2465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtYs-0006FS-Ng
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWa-0003i9-7I
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWY-0000eQ-NE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:19 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtWY-0000VY-F5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:18 -0500
Received: by mail-wr1-x433.google.com with SMTP id j42so5479467wrj.12
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vwsTQPLMkDuqXqnHi4Oibs2v+97DJuoFfknErpqUpNE=;
 b=Af9MJSlwmcFM1EyaVAjOHCcP/0vc/RH8OufuqYNjr+v2PEiw92eL/9YcIkadDD7Ecc
 1h66rs5r/VGb0d6uV3foNFneNrrizUXCxJD9FuHje+VelPLuQLMbUsnahZutIQ1EGbdx
 knOTwHpLSVrlrO6eDPm5Ha10a5DrvBVsV5lkNZe4xS7lFlFJBNXLKp1MVD12QBpqVcKD
 6u01T4ZtrrZXmwkn6WFETBMtwY4QrdkchxzJVGvcht5D07RMimy2rBkzb46qMZSQ3xs2
 m1AMlgxUjnxtetxF6rfFi3zFt2363OqpBM7KymSR5Zvowa6/+zXC86mq+ISlAdVb4AHs
 Gxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vwsTQPLMkDuqXqnHi4Oibs2v+97DJuoFfknErpqUpNE=;
 b=st2iEteRYDY1clSdNfGD6eSZo8tol8+jWCSQ0MLhGUv/KUm/WW3J4f5hiee57Q3hAN
 YQNe3ldRCrhszVX5+wcAzuNELDw2nbzVfOzxhClKbVsPUCwz9LcRMPsn4F+vhr4WmHH0
 tYZ0wKP6izdzNNzy8N7KRWeU8kLoEFy+RecpBy/UsvXnhzy0bI8UnRo7xHJ1RUmHxzOg
 y05XaEjqRy9rOCO4McdmU1oGQgENi29wbicWrTjXu4howGPEyUYw8wS2jm1uRZWn6WM2
 rakPIea3ehMgB7b4RfOen7zBRMTp8AyyxIqrErYPZiHLb9mBDjP23OxOtWVIZNV0kyRC
 04iQ==
X-Gm-Message-State: APjAAAUVaKtZB562e5ZXGQbGGx8Kf8B9Ta38EXlypiL5f6sDedFw3XfO
 u+y2UbkGf74JMX29u/ByDwk4+Q==
X-Google-Smtp-Source: APXvYqzsYQgMZ2y5JSVz2/J3WIuRGW5TLXFsuCtMHHfCcRTlmMnOS9/2Br5f7LhRCcXUlbGbGyMzng==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr8496917wrw.165.1576753156608; 
 Thu, 19 Dec 2019 02:59:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm5962764wru.6.2019.12.19.02.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:59:15 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5C5DF1FFAA;
 Thu, 19 Dec 2019 10:49:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 20/25] linux-user: convert target_mmap debug to tracepoint
Date: Thu, 19 Dec 2019 10:49:29 +0000
Message-Id: <20191219104934.866-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is a pain to re-compile when you need to debug and tracepoints are
a fairly low impact way to instrument QEMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191205122518.10010-3-alex.bennee@linaro.org>

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


