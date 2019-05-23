Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81694C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493492075B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj4foZ+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493492075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTueT-00010h-Gm
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:49:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZj-0005yJ-Ox
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZh-0002y0-Gs
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:31 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:45608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTuZh-0002xM-4H
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:29 -0400
Received: by mail-yw1-xc42.google.com with SMTP id w18so2772920ywa.12
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=1BkgmbBnhQ3KAFq5DgAQAGgNp6ECl3V3D5Qd7pmmCaE=;
	b=Pj4foZ+/mtylVuJ+ZQh9biP5oJWScNf5UGRBhb+Z5FJN0LWvUBRMh0SLZ9y2gQ1cwS
	zuD+dobZy4FX6OqcjGdwSl2AIf4K25eDJPnvrxDV2kdv5saa6CV4of0AOndAb9/e5c+P
	O6y40lnAFvhI+PXHZHqYgmPI0aBFJeg+QLsAw90g4cR4rcoiZknuHz/Bu/Aa3pWBcP35
	HgTRvwSISH7unaxfjV9k7jogPxiDfuYQHJ8KQfQeOce7TLVAl2c61hcLX42IRnkZkTHR
	orhvXo0d7yIIIaxkWyGj63H3Q3PpkamZitQi+k2TgHXizRYDUymuTPnB4ZI4BdglNJNx
	r7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=1BkgmbBnhQ3KAFq5DgAQAGgNp6ECl3V3D5Qd7pmmCaE=;
	b=aHswg/vUOjbOQJsYcbcVrRWz6yGhyle72C7aF2ycJSMaMw6cshC8eY4xTWnNxZBi2a
	BtytyqBZy7NnI4XCARuGiI+rCcwzHxOHp8bs72drvxwfUmpfWiTXYVz+nELHlh9f1cUV
	PK+ag6aeWzZhSRcIKgF29Oj3kYiZcLqndJwHQEWsWSJAU4EILzUJN7PvHhzuoFbe/vyV
	LSf/yHDuBJZuhERlQ3LV+mhT1lLpTT1DpHWgVYu0UE+lGy+Mpd0Lydf9G6eofGOBHz+B
	5dhM3xDrGP7xCO+aD7YG2W9g4hwdhwsnJ5hoQGCcDn+ho251ggXsZ5o8aPhQbzXtVNpc
	cxvQ==
X-Gm-Message-State: APjAAAUietTf/mvSz7IGlE2dG2Z0qLSqsHOVivM+k00pPubmBnCR13Zv
	TsG+knkxlmzrTg5c5sJFuEQ0DxS3
X-Google-Smtp-Source: APXvYqzbY56sIs/BNnlLHq423Gj5R+OjXObRFtoz8XXpJVtDtYfENmoDXLc9OepMeX3PSVHn2Go3YQ==
X-Received: by 2002:a81:7cc5:: with SMTP id x188mr6215839ywc.381.1558644268147;
	Thu, 23 May 2019 13:44:28 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id p12sm87590ywg.72.2019.05.23.13.44.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:44:27 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:44:00 -0400
Message-Id: <20190523204409.21068-3-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523204409.21068-1-jan.bobek@gmail.com>
References: <20190523204409.21068-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RISU v3 02/11] risu_i386: move reginfo_t and related
 defines to risu_reginfo_i386.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to build risu successfully for i386, we need files
risu_reginfo_i386.{h,c}; this patch adds the former by extracting the
relevant code from risu_i386.c.

This patch is pure code motion; no functional changes were made.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_reginfo_i386.h | 37 +++++++++++++++++++++++++++++++++++++
 risu_i386.c         | 23 +----------------------
 2 files changed, 38 insertions(+), 22 deletions(-)
 create mode 100644 risu_reginfo_i386.h

diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
new file mode 100644
index 0000000..5bba439
--- /dev/null
+++ b/risu_reginfo_i386.h
@@ -0,0 +1,37 @@
+/*******************************************************************************
+ * Copyright (c) 2010 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Peter Maydell (Linaro) - initial implementation
+ ******************************************************************************/
+
+#ifndef RISU_REGINFO_I386_H
+#define RISU_REGINFO_I386_H
+
+/* This is the data structure we pass over the socket.
+ * It is a simplified and reduced subset of what can
+ * be obtained with a ucontext_t*
+ */
+struct reginfo {
+    uint32_t faulting_insn;
+    gregset_t gregs;
+};
+
+#ifndef REG_GS
+/* Assume that either we get all these defines or none */
+#   define REG_GS      0
+#   define REG_FS      1
+#   define REG_ES      2
+#   define REG_DS      3
+#   define REG_ESP     7
+#   define REG_TRAPNO 12
+#   define REG_EIP    14
+#   define REG_EFL    16
+#   define REG_UESP   17
+#endif /* !defined(REG_GS) */
+
+#endif /* RISU_REGINFO_I386_H */
diff --git a/risu_i386.c b/risu_i386.c
index 5e7e01d..6798a78 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -14,28 +14,7 @@
 #include <string.h>
 
 #include "risu.h"
-
-/* This is the data structure we pass over the socket.
- * It is a simplified and reduced subset of what can
- * be obtained with a ucontext_t*
- */
-struct reginfo {
-    uint32_t faulting_insn;
-    gregset_t gregs;
-};
-
-#ifndef REG_GS
-/* Assume that either we get all these defines or none */
-#define REG_GS 0
-#define REG_FS 1
-#define REG_ES 2
-#define REG_DS 3
-#define REG_ESP 7
-#define REG_TRAPNO 12
-#define REG_EIP 14
-#define REG_EFL 16
-#define REG_UESP 17
-#endif
+#include "risu_reginfo_i386.h"
 
 struct reginfo master_ri, apprentice_ri;
 
-- 
2.20.1


