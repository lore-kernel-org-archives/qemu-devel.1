Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D896EC2D0C8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC38206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TiDiSH0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC38206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihPxM-0002TH-Q7
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs1-00043A-9F
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs0-0002fY-28
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:29 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihPrz-0002eT-Sy
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:28 -0500
Received: by mail-pg1-x544.google.com with SMTP id k197so435102pga.10
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 19:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h8PHcS1tBBTVD9W0+xFnEcSw+EjWnL99+V49q3i39H0=;
 b=TiDiSH0CzvqeeXBY6u5uqYBDzw+ukp20Troi0DWC5YiyN9eps5Gk51TO1dEiYqrALj
 y+3JWVmb1TKwsyywrqz9TxjdvoJqf7SFodHAdib8JlrLi5flSNaJ80r0+CBfN/6NoqPp
 +tZq27GLropxlZVQ44Jx/vI186h6KxmxPeGR3aTDxj69vEd60dUYz02S4O3DfR57UpKr
 8oplMbNfv0xhBOMI1yRs2RlnKX8/I0Mg1sY8Q0T7DvZHxXsdCqJPIEfKJV+tEcnmhFbg
 Yws+Od9OPrtaWnS53f9qXtBiybDV3n1h064LITPgWv2qElmK6pbwIu9M5xzgstoNgUNp
 6+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h8PHcS1tBBTVD9W0+xFnEcSw+EjWnL99+V49q3i39H0=;
 b=Y6xUHWVhZtCUIMmtQV2/HBg73UanmpxrGWvS71ePCvN4pSyjrOdAn+sZk2CWl8QKQk
 7GQ1JzImyi8iQynY4hLVz4n2PDprWsOdmagmiTbUBoC0qNy1JVq2AQF1EidXkj8s3XAz
 KMBv0sQiXwp5ytHczPs1x49RjEymAW3JGVf/z69rQ2TCON1yVDfitPHSB/STw4VfH48+
 WefGTBTmNa8ncDBhQSHggOq2zajJNLs2XZJwn/CF97XI80b0uPN9FfMn4lcCCxfmsGNn
 7CSxBo48IXaabOZ0oZwoqp3Jo1269vXVL2jFUpoUSsYM0yt28/4v/H/BaHkbsi9O0qRU
 K/2g==
X-Gm-Message-State: APjAAAXPS+wn8wciLfPTtLmks3cu+556Oagghuk4uaDjHmSXzIZ2EFSs
 lKjFJ0YNeWKOvzhEOgCJHAhJhEQF0aI=
X-Google-Smtp-Source: APXvYqwe2x72/05jIOJeYOMIRFWSeh6d98ZCKwqk102Wd5QqpWzeUXBoKZelImajpcJezaTch3S50Q==
X-Received: by 2002:a65:538b:: with SMTP id x11mr273892pgq.395.1576639166549; 
 Tue, 17 Dec 2019 19:19:26 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id k27sm404870pfp.66.2019.12.17.19.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 19:19:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] tcg: Remove softmmu code_gen_buffer fixed address
Date: Tue, 17 Dec 2019 17:19:15 -1000
Message-Id: <20191218031920.6414-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218031920.6414-1-richard.henderson@linaro.org>
References: <20191218031920.6414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: philmd@redhat.com, i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commentary talks about "in concert with the addresses
assigned in the relevant linker script", except there is no
linker script for softmmu, nor has there been for some time.

(Do not confuse the user-only linker script editing that was
removed in the previous patch, because user-only does not
use this code_gen_buffer allocation method.)

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9f48da9472..88468a1c08 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1032,47 +1032,20 @@ static inline void *alloc_code_gen_buffer(void)
 {
     int prot = PROT_WRITE | PROT_READ | PROT_EXEC;
     int flags = MAP_PRIVATE | MAP_ANONYMOUS;
-    uintptr_t start = 0;
     size_t size = tcg_ctx->code_gen_buffer_size;
     void *buf;
 
-    /* Constrain the position of the buffer based on the host cpu.
-       Note that these addresses are chosen in concert with the
-       addresses assigned in the relevant linker script file.  */
-# if defined(__PIE__) || defined(__PIC__)
-    /* Don't bother setting a preferred location if we're building
-       a position-independent executable.  We're more likely to get
-       an address near the main executable if we let the kernel
-       choose the address.  */
-# elif defined(__x86_64__) && defined(MAP_32BIT)
-    /* Force the memory down into low memory with the executable.
-       Leave the choice of exact location with the kernel.  */
-    flags |= MAP_32BIT;
-    /* Cannot expect to map more than 800MB in low memory.  */
-    if (size > 800u * 1024 * 1024) {
-        tcg_ctx->code_gen_buffer_size = size = 800u * 1024 * 1024;
-    }
-# elif defined(__sparc__)
-    start = 0x40000000ul;
-# elif defined(__s390x__)
-    start = 0x90000000ul;
-# elif defined(__mips__)
-#  if _MIPS_SIM == _ABI64
-    start = 0x128000000ul;
-#  else
-    start = 0x08000000ul;
-#  endif
-# endif
-
-    buf = mmap((void *)start, size, prot, flags, -1, 0);
+    buf = mmap(NULL, size, prot, flags, -1, 0);
     if (buf == MAP_FAILED) {
         return NULL;
     }
 
 #ifdef __mips__
     if (cross_256mb(buf, size)) {
-        /* Try again, with the original still mapped, to avoid re-acquiring
-           that 256mb crossing.  This time don't specify an address.  */
+        /*
+         * Try again, with the original still mapped, to avoid re-acquiring
+         * the same 256mb crossing.
+         */
         size_t size2;
         void *buf2 = mmap(NULL, size, prot, flags, -1, 0);
         switch ((int)(buf2 != MAP_FAILED)) {
-- 
2.20.1


