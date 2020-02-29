Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FC4C3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2B82469D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTW2B6nS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2B82469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7s9W-0003d5-5z
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 21:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6j-000781-LC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6i-0003El-Lx
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:44:01 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7s6i-0003DJ-Gp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:44:00 -0500
Received: by mail-pj1-x1043.google.com with SMTP id o2so115036pjp.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 18:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TW57DhO0hZ+3P3SjnpzoFpldCfzCdzjtWoVxdqtBZb0=;
 b=WTW2B6nS9zg235P5PEeVevoUS2Kka2++GMghpYF5V/3MbP21fMmWZ5nKm1mEeMXHgE
 0YSOmUHyrKX7Uo4g1yx6Qwhxsv5Zd6dKB730HHNZd7Hsjbc12A4YMo4D05gJK0x04e8l
 jMApYDMmttWaL4kcXoDfndMACJPjzGubnmwkuBLFUQzRX5CxOy9V84x8bLIIK5X+8hHD
 vMXA6JGVO1FEB6jJe6UG12OCBEpKRgPYcQhN8pJPFPSkU9X8b0/bUQnSrMkcmnfWwMNw
 e7vHiq9x61uk55YFIA/b+NHWBAvU8G8vxd1TXXHLp+DqM0uvLt+OLEq9zHZFWHQdmwFm
 HUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TW57DhO0hZ+3P3SjnpzoFpldCfzCdzjtWoVxdqtBZb0=;
 b=ZnSnMImyNvgHA+elDnjzI/bhBWeEo745SdPoAXheiciidbdj0iY6VILB/ln8X+cND5
 pFJsB0dnKPsz9TyyE+rGiHQs9W9GdrMG/PZ5ZwHp26pk8AOPR6sRbLwIJPtBH7AUu1Bd
 j4grGhlOtx+BIV2zszXEN3ADloZku56jeiogG51NnLgHUNK64kE8hyU2TjQrNPNK6aUX
 9RYtMc7rS5DyPe7jIgvAkytCMWRExL9hQPdgS78Rbx3RrUKQQapve0k2HwCXQs+4+FeZ
 YCtKcijUPVnjlkfWPivKJUEaZn3d5V/eVbjkXV70G3102lgQ4/8C5dW81hr5Ks555kaz
 EAIA==
X-Gm-Message-State: APjAAAWseuelQgrgkUT571Yb8MKuCcoD4YU8doAhfZg+W0BkVNsYJNxr
 oA4MYTobvmC76DXpyx6fNV7P5xU4HPM=
X-Google-Smtp-Source: APXvYqyP7es76PbvnBkyl8/jeB38cgqs03EKnQSZ3nlao0Jm6PVOqxuuabIVjp+1gu3Bfr3xp9J8sQ==
X-Received: by 2002:a17:902:bc4a:: with SMTP id
 t10mr6957286plz.103.1582944239196; 
 Fri, 28 Feb 2020 18:43:59 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id k9sm3649321pjo.19.2020.02.28.18.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 18:43:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] accel/tcg: only USE_STATIC_CODE_GEN_BUFFER on 32 bit hosts
Date: Fri, 28 Feb 2020 18:43:46 -0800
Message-Id: <20200229024347.22826-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229024347.22826-1-richard.henderson@linaro.org>
References: <20200229024347.22826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

There is no particular reason to use a static codegen buffer on 64 bit
hosts as we have address space to burn. Allow the common CONFIG_USER
case to use the mmap'ed buffers like SoftMMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-Id: <20200228192415.19867-4-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5b66af783b..4ce5d1b393 100644
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


