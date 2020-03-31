Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0005C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82FE2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFf0kUgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82FE2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ82N-0001uI-OR
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zV-0004Yz-BN
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zU-0008Dd-7Z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:05 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJ7zU-0008Bu-2E
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id o26so9721610pgc.12
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 20:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AVWo3TkNC8dRck4gxr30FMdUL1YEqwhhQceYuT351jQ=;
 b=bFf0kUgR2GoEiqNITsPTFpdjOaZesDn+wYad7Gh0iG49tzG5u2a2oEJQNnNhcTGX5B
 RyTqpddoBt4K2NCnDDl8Bnpvau+enrW5R2sP6RPrXFIH1kxVicUqy9nfeMZehHJHqMiW
 QB8RT4OJeJK5Nk8DLzvHNlOeomqP/Qg/TkxyZIQH+bMEu0Z1RH19ZQCgkKHN6BnSzs0k
 o0wcYBeW8qDwKlSL52l7aK+5p/46Zx+aHi3OgRyN2azTSdSmgT3LoJewLhg3b+E+K3gH
 1KhKt2CRUG8ghS9/P/GshRIb0tuR3lvd/Ju+f3feq1oCznGP7bDTAOXyeBSFOsquczAx
 /3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AVWo3TkNC8dRck4gxr30FMdUL1YEqwhhQceYuT351jQ=;
 b=ZrQU5/0m2NqhzHs9tEmCzB3CswxDyrlxocu0gwGQliW0KMZbo3+FwAjzTfawMzg0Az
 sVIU2JVKjlLDFItEEtRP3vqP7b8qvirXsurtd9a5oYEI6UcGCXof2phoU+CwWK0ECIWe
 KsSX9Q8Jsr76hu9HLugWqmKULRC+gzF489dcxE8LDN14/dmstkC6uB3GEadmAIMlk61f
 vaV6SstssYXRDMuOuTeadZFInCgE/Cykesp5UJsqe+WCnN+heMyPkP9tDXTGfDqn6Cx1
 6vSsHxLr3nVliRu+2YkSq32Hr8NK6ZA+ECOvOaGJpZIx6E+yBXIaikjnj7VD4SfO3FxE
 44Rg==
X-Gm-Message-State: ANhLgQ3ZtJdlZx8gc7Z1JWWpj4cwRhaGtLv6y7sPsPCLgalvXe0lIkn9
 feSvUAjP1soSdcF8yxzE+DUIR3wNgy8=
X-Google-Smtp-Source: ADFU+vunisiQ6ksAXwjczdamELpiWmiqQ+wlbalDvNLDpYI70g4P6Jg/1pCNAfkpoh1rpDq7tDy5Sw==
X-Received: by 2002:a62:7dd0:: with SMTP id
 y199mr15872936pfc.267.1585626902674; 
 Mon, 30 Mar 2020 20:55:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h11sm11386174pfq.56.2020.03.30.20.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 20:55:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 02/10] tcg: Remove softmmu code_gen_buffer fixed address
Date: Mon, 30 Mar 2020 20:54:48 -0700
Message-Id: <20200331035456.6494-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331035456.6494-1-richard.henderson@linaro.org>
References: <20200331035456.6494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
index 78914154bf..9924e66d1f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1043,47 +1043,20 @@ static inline void *alloc_code_gen_buffer(void)
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


