Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4311C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4332070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUhKDNsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4332070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Jn-0005Fd-Re
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Hp-0002wj-4R
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Hn-0002QL-NZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:37 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Hn-0002PE-GX
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:35 -0500
Received: by mail-pg1-x543.google.com with SMTP id z124so846545pgb.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xIsBUaQmXMuEnS1tO54/55Y3/tYO/CJY1dsQmwqrvNE=;
 b=ZUhKDNsbepBldOdc5ELNy1AvL8cYTDY1m3Ol1SmDYh8vstL5R758B6yy9WMKF8CNBE
 lGdTacVSGdRHUFmSC7HTkjZyu+Mtv1BjZPwNAMTvK9Qp8CUK7CpPPPoTWwRSIaAge/M1
 JFoGQo0fOZCIUxpoHoFZ263MSx5SycZkd2GxbPneMMZzytS1V4rJE5wyqMx55WlRsYTD
 1PEQPlerxa9ft1fEnQvnVFvQ9+Z6rwXeLhMdmmm2WWl+J6mfok7KAVJNImssmkuvhFX4
 QB9rRpwAoRvPInI8EdHEj40Jm09AytU2HkCJ6LUmehPscAA2P4HoJfk99hxvUYQlod7t
 6VEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xIsBUaQmXMuEnS1tO54/55Y3/tYO/CJY1dsQmwqrvNE=;
 b=DO+AenAjfYK8NpN8tHyZ8+nCxBAgSzwMkz6AufdshotyMYJVKDNbDeERG4yswS4qk7
 RFEWkewnl4G4e6QLdIgqZXkf2fmySsjypmysrWCZ/RNa+EZam2nKua0gFf71ZyFJKi34
 S21mAFoxO+qzFesJtbrXSstERWMTC7lGS3FSfl1oWTtHPXup5zG3+M4FlDP70kaLgxLX
 XrVJIg3SNbMJYhT/+g+m4vXd7j12L9wyw3xl1WHa9+gJLxxdkvqr07Ht1uO/Zkhl/JZ2
 q1bfKupICqSihCZDyuZXvHvleUN7hu2qkZsRCJaBl5GRfpC5pqbnvpjSPk8LFhu1YCQ0
 cIgw==
X-Gm-Message-State: APjAAAW6/O+z88fyaIpQMeHYyp8LP92JeibdUCINkeKWQzIqGtFc2R1w
 DGnqKZYrrAY6dyWvuSNaMpEMNnmgmkUTCg==
X-Google-Smtp-Source: APXvYqzxFGnYm333AbApw5ouC64DuR5n6kW4w6fbCfqlzwMItaZquLghfC6FJw7Ofon5MBhHQWXotg==
X-Received: by 2002:a63:4702:: with SMTP id u2mr3090426pga.125.1578455134000; 
 Tue, 07 Jan 2020 19:45:34 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:45:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/41] tcg: Remove softmmu code_gen_buffer fixed address
Date: Wed,  8 Jan 2020 14:44:44 +1100
Message-Id: <20200108034523.17349-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commentary talks about "in concert with the addresses
assigned in the relevant linker script", except there is no
linker script for softmmu, nor has there been for some time.

(Do not confuse the user-only linker script editing that was
removed in the previous patch, because user-only does not
use this code_gen_buffer allocation method.)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index bb325a2bc4..7749c3dda5 100644
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


