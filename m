Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C916C2D0BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57FCE227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 22:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3aoTvBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FCE227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihhvR-0002pd-5N
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 17:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhu7-0001TH-3c
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihhu5-0003ub-G1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:51 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihhu5-0003ty-A8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 17:34:49 -0500
Received: by mail-pg1-x543.google.com with SMTP id a33so2030337pgm.5
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 14:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M89NR5346hcsRB2SUkQwEfQ5idMR/OARU10zt8sGydk=;
 b=x3aoTvBdaO578ZgCkCRuB0yRK+lJgM0k+ebUU7JwVoU4ixYOvNbAWMgor1/uLQAY0y
 KCTJ0bFqjEiUyvgGigEGFc2YQcBFNCBJoLKR4Z9sk23zCtrUS2FWwx06YGflycnJiMHp
 ZcdtxB/iXP+mHiA9mJR9tF0FpLjLgAbPvpYXX4yOTAK+C7no+yBIBCenwYbVr5ZK2Kwc
 qcqsSVIVG8FQX19MJSJvyTUwuQAuo8rQznCoyHVUTmuwMNcO+oQRcEyFyUuqJRWxvcRO
 Dh7NgorLwbJYrZyTEwYuMcrDbCKUfTW4wPtZqg+QzpGoxVTesitF4yk3vYDpwNRdSGH0
 DkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M89NR5346hcsRB2SUkQwEfQ5idMR/OARU10zt8sGydk=;
 b=kbRl3pJrHIKkCfKxLpeNVymRTEFWuONTdwcuVs+kqPz2FP5xqK4BBrHrVAb9kKj2Pz
 mx9bzx5tdJlDUP2WSyVknZOmeY71ctkPR1shFOnU7FycNN6Ou/EzzNimwpJi4dUxET9P
 BdpCQgiepy3QZAFQVYP4smrbGJj8bt0jLKPVeiaUGqIZZfXhf2acpqHf46RA10OTo9AW
 OOH26oaDUZZYYMVt32LKoGeKRh0G6PVyzJ2k7C9/t0o9t+1dgHA3XzDKi73XEnTHOnsL
 To4QE9uJuzV5SELSCxY4tG/ItQFB04wFwMuZMvzIAS6us3IhWZBhtj5Edyaswj4oG2LH
 hZhQ==
X-Gm-Message-State: APjAAAV15zbH6O/afwIk+PM9Zcwvkbx7A7/jHpLvGLxk/081vlI51QN1
 ba40ICJb/IFt+09rFy/abnvFdQ0+CSY=
X-Google-Smtp-Source: APXvYqwhQxe5p8Ly8ZhgZcfBzf8D85LYBxGa/P2YXidEiJOFI5wArS//a2b0oO9tr32QXkCc3RapgA==
X-Received: by 2002:a63:d047:: with SMTP id s7mr5495335pgi.81.1576708487922;
 Wed, 18 Dec 2019 14:34:47 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id j1sm4627779pff.107.2019.12.18.14.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 14:34:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] tcg: Remove softmmu code_gen_buffer fixed address
Date: Wed, 18 Dec 2019 12:34:36 -1000
Message-Id: <20191218223441.23852-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218223441.23852-1-richard.henderson@linaro.org>
References: <20191218223441.23852-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: philmd@redhat.com, Thomas Huth <thuth@redhat.com>, i@maskray.me,
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commentary talks about "in concert with the addresses
assigned in the relevant linker script", except there is no
linker script for softmmu, nor has there been for some time.

(Do not confuse the user-only linker script editing that was
removed in the previous patch, because user-only does not
use this code_gen_buffer allocation method.)

Reviewed-by: Thomas Huth <thuth@redhat.com>
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


