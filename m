Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C39C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AADA2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TywaZMPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AADA2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHx8j-0007iq-GK
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 18:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx57-0003Bj-5x
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx56-0000Ox-2Z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:01 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHx55-0000JZ-TF
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:00 -0400
Received: by mail-pg1-x542.google.com with SMTP id k191so5213653pgc.13
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 15:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AVWo3TkNC8dRck4gxr30FMdUL1YEqwhhQceYuT351jQ=;
 b=TywaZMPBxS36l1077IGjGjRIwMvxk6h+ckm+IZ2ZxT4wkG2fvSASNvVRwC74lg9IBK
 RWkYPVXbZQAS14XwoRydTHccywGqvyxEkIPN7ZOS6BvLsu6whpessyympzMfHn+HYXF+
 qvw5DExOM13dPeQ47KUW5HS4R5D8xbFTXGg42zLPW/wfI2CEX2KrAF043ZuHlvBQAf2T
 dJzB0IjhjhgL8l0kLQKx7JGmlsxtWUWuh5Z5a0wFlgoHtzNi327oSNkmLZIAN6BF1oYN
 hGETAKSoHICMbT30GLiwyV1owGs0wC/8gqhvoxlLE+UvISSvY+oksTaE3wPrOderYn6h
 ofQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AVWo3TkNC8dRck4gxr30FMdUL1YEqwhhQceYuT351jQ=;
 b=akpbeSwfR7OnNhyCpcBX6wnoHw6NwlbpSfIrgLWEKBPwndcs6gcPCH0SXFwK2rzAMF
 BqHXE85gIKpRrIysqWx+8YtCfaJp95fZRBeV50lUSuI7SwKSlpte9tgJFXHBIwqIQKSQ
 806fP3SfeBgT5Ti76Wp5DNxEuhvyafW7CSY+mvnMdVuDjvPpHuKG3cVr3Y4ja+qc9j6x
 9gC7IS8PTIaZugnBo+POtKwJ0pDtvXKc5vBodfnsrGCJINpIJI/SRUwLbSqKcVnpD7A2
 G3xeIRDT/hPafn99eRGdezItIh54EYRJf/06C6hCNKp3sPbDd/UVL9qFlbaB21hW+df2
 CP6A==
X-Gm-Message-State: ANhLgQ0u9xZ0k+6ALu7CP6xaJa1fiR8J74NhN+b+agBGjKH1qkMuAUKI
 MQbtiXoiCxzg9gO4parFzQNkMQRVqdA=
X-Google-Smtp-Source: ADFU+vt1BaMX3C12VyD+uTFPajirso7jSCoEdnN1WgNIxypn00i9s7+3r2eygsJaV1QCfCRZtuiO2g==
X-Received: by 2002:a63:bf4e:: with SMTP id i14mr1405683pgo.41.1585346638398; 
 Fri, 27 Mar 2020 15:03:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id y29sm4516929pge.22.2020.03.27.15.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 15:03:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v3 2/7] tcg: Remove softmmu code_gen_buffer fixed
 address
Date: Fri, 27 Mar 2020 15:03:48 -0700
Message-Id: <20200327220353.27233-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327220353.27233-1-richard.henderson@linaro.org>
References: <20200327220353.27233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: dim@FreeBSD.org, Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org,
 roger.pau@citrix.com
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


