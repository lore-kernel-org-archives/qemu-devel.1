Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468EDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D092469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2/Kdq6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D092469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7lGk-0005P9-8p
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 14:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lFI-0003Z4-M3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j7lFH-00062x-Kt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:24 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j7lFH-00061g-Ev
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:24:23 -0500
Received: by mail-wm1-x344.google.com with SMTP id g83so2293214wme.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qwNAqRvi6iGMEY7tiLR6IKWg1Rzq0J9dU0xZ2yHjmzk=;
 b=Y2/Kdq6ymA20vwIqp+ohfD/kYkY58CAGrLwDuyiuNDCH6K9WUiTgkJpu5sZI0qzH0S
 QqnF5qZ8AuPCZFYYpSV1DIB2LtB1uS9XfZQPXsVAtq4saIUakbqPrd4Zhycf6ilRXVAp
 CKrfaTKKOhhPMvZWFn/3Qo6rK/axje+MXEFjMTjoJ2oqtY7IR1Sayf3a3yiqJuHUqAeT
 TClmJ8wYxHnWZn+7ElMzTFCrh6VwN8dOuhnZHX16ZL5k85YinbSYDVFBUNRteY6zKqyO
 H0D9l7C16f8lcKi/KMwAHryEIMsHM51bXwCKvTI3IFWxA4TdWY6kWeAj0pyLeVJ99PJo
 UD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qwNAqRvi6iGMEY7tiLR6IKWg1Rzq0J9dU0xZ2yHjmzk=;
 b=mSxSLIzIMGCFYe0X4OuJfgZvcx7yC64IkuBz9uVZm2NDvQeoQAPeL0nxMVh+PJqRp0
 R82elX3iYiKtNsUltrCdbZdOagGGE/R/hqV92iipMpZV8OPxZ2e/NGVd0uPvKfQZ95ki
 tCXiWCh702zRIjkiAPsWUSKbx0CkGe2tRejEKrcUW3QZNURaHKQabPsCwuLVdxsSLgDh
 aOhgMpuyn9Pa6cLNlXhx488wQ+awvjTvy03dC0nrAR7lNe3d33mw5MQPbto3V6f1yw/r
 j2BoqnhulkgdTkyKVLSTMxk9SNLQhMG0ISAmUyZkORW3K3xQzBiQcKtZZi7VAK+GBjQs
 Uajg==
X-Gm-Message-State: APjAAAUex9hHfXXjZgIauhqtYps7LhoerAjQeT0IGK3PnGtKAiTIlj+h
 5p8otNSFVUhm9yBke/5BAPkMEg==
X-Google-Smtp-Source: APXvYqxdkk3tJqQi7DWRlMHefTfzVFtk7TMxi5+MVkrFHba/dZlDZmiRyPd0ApaXKOMdlFGKMyhV0Q==
X-Received: by 2002:a1c:1d90:: with SMTP id d138mr5906030wmd.163.1582917862533; 
 Fri, 28 Feb 2020 11:24:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c2sm3414429wma.39.2020.02.28.11.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 11:24:18 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AF0FE1FF90;
 Fri, 28 Feb 2020 19:24:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] accel/tcg: only USE_STATIC_CODE_GEN_BUFFER on 32 bit
 hosts
Date: Fri, 28 Feb 2020 19:24:14 +0000
Message-Id: <20200228192415.19867-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228192415.19867-1-alex.bennee@linaro.org>
References: <20200228192415.19867-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no particular reason to use a static codegen buffer on 64 bit
hosts as we have address space to burn. Allow the common CONFIG_USER
case to use the mmap'ed buffers like SoftMMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 accel/tcg/translate-all.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5b66af783b5..4ce5d1b3931 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -892,11 +892,12 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
     }
 }
 
-#if defined(CONFIG_USER_ONLY)
-/* Currently it is not recommended to allocate big chunks of data in
-   user mode. It will change when a dedicated libc will be used.  */
-/* ??? 64-bit hosts ought to have no problem mmaping data outside the
-   region in which the guest needs to run.  Revisit this.  */
+#if defined(CONFIG_USER_ONLY) && TCG_TARGET_REG_BITS == 32
+/*
+ * For user mode on smaller 32 bit systems we may run into trouble
+ * allocating big chunks of data in the right place. On these systems
+ * we utilise a static code generation buffer directly in the binary.
+ */
 #define USE_STATIC_CODE_GEN_BUFFER
 #endif
 
-- 
2.20.1


