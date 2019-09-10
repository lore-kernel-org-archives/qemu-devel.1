Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998E8C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659742084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZjJ9G1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659742084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7lwL-0002pn-Qg
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lu3-0000vi-H1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lu2-0006lW-1m
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:15 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7lu1-0006kO-Ov
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id t9so833197wmi.5
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=05vMXPIxoWx34Tv2XwUiZnuEHt704CpxHZvOBau6J1M=;
 b=nZjJ9G1iqf2I/2iNeYJ8qtRThltUGZ4lmb+YPY9enONu1JgNvbIj0ME5o8R7rS7w2p
 uH3eCdGKUAg9DbG5ikgC45/WV4PbyErnNG9iSabL+p1uqGoUATYFZPmfVwZB9JIkBDS4
 P0U8cRO3WdWxOXS5R58I8S2lSI6OybmTltRaUnIPDHHGme+V6toCFaz5QVz8VL1Aktqj
 GMJ0iDg8JfuFWACyFiuVWaUqL7+Rfn8H457CiVDcs/o+PghTpp1HGoyJ30UIPQpGEqNC
 FjXXvzPHL95dyHjg3IjVgNq2aBS0EUoRlg3p0/ncVLkYJZHRkjHQCanGMB4EMssiD/wR
 WB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=05vMXPIxoWx34Tv2XwUiZnuEHt704CpxHZvOBau6J1M=;
 b=QlBvSNGxu6LNF8Kb+TvJi3h7JK5pSaGrkdAMfitUI+0vR0n/+pS0laXgPgYvIFF9YV
 2KWp0HG3GFMInOHi9Ix8QdACrxfNnPOKN+AHqT+mFhC+JITYA3udLB28jmTOtjGRElX7
 fGWwRlMWsXF49sAIJkf6+n3+ZmM4nsI2SmpuEgY4adVs9ZWF7a0iiCWAW3BveT8MhOWD
 fGwYKHE3phPAqAWRn9RrT4yx+hgGd20R+je+XXpvkIUiSXi7rvJQQBJ3IUUKYyMaS+lM
 qPxM4I8aJaP5G+Lpb9mVc91LKzWEx45aVKs0HGmYKZZ6+YF/5cjrCBkP+KEheVKJ5BCp
 LrsQ==
X-Gm-Message-State: APjAAAUsHfH9jmYQuDlQ7ADxFMwJvY8JMOd+AlpuzTvQmJEDlm7hNVjj
 0OCIbU4mW+nJk+bx1ZnPeD4phA==
X-Google-Smtp-Source: APXvYqyvT6FPzQBOrvV/uRW0YpzWW30ZUKWojq0ARBHCwdqzWttTsBZcE6BMfu5A/ictS88DnZ2qkg==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr876238wmb.73.1568144052633;
 Tue, 10 Sep 2019 12:34:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l1sm22205092wrb.1.2019.09.10.12.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 12:34:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 544321FF90;
 Tue, 10 Sep 2019 20:34:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 20:34:07 +0100
Message-Id: <20190910193408.28917-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910193408.28917-1-alex.bennee@linaro.org>
References: <20190910193408.28917-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v1 3/4] elf: move elf_ops.h into include/elf/
 and rename
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Lets keep all the Elf manipulation bits together. Also rename the file
to better reflect how it is used and add a little header to the file.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/loader.c                            | 4 ++--
 include/{hw/elf_ops.h => elf/elf_ops.inc.h} | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)
 rename include/{hw/elf_ops.h => elf/elf_ops.inc.h} (98%)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index e0c6563e643..886179a4947 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -302,7 +302,7 @@ static void *load_at(int fd, off_t offset, size_t size)
 #define elf_word        uint32_t
 #define elf_sword        int32_t
 #define bswapSZs	bswap32s
-#include "hw/elf_ops.h"
+#include "elf/elf_ops.inc.h"
 
 #undef elfhdr
 #undef elf_phdr
@@ -324,7 +324,7 @@ static void *load_at(int fd, off_t offset, size_t size)
 #define elf_sword        int64_t
 #define bswapSZs	bswap64s
 #define SZ		64
-#include "hw/elf_ops.h"
+#include "elf/elf_ops.inc.h"
 
 const char *load_elf_strerror(int error)
 {
diff --git a/include/hw/elf_ops.h b/include/elf/elf_ops.inc.h
similarity index 98%
rename from include/hw/elf_ops.h
rename to include/elf/elf_ops.inc.h
index 1496d7e7536..a820bd821d5 100644
--- a/include/hw/elf_ops.h
+++ b/include/elf/elf_ops.inc.h
@@ -1,3 +1,12 @@
+/*
+ * Macro expansions for Elf operations. This is included in a
+ * compilation unit with appropriate definitions for SZ and elf
+ * headers to generate utility functions for reading 32 and 64 bit elf
+ * headers.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
 static void glue(bswap_ehdr, SZ)(struct elfhdr *ehdr)
 {
     bswap16s(&ehdr->e_type);			/* Object file type */
-- 
2.20.1


