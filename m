Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F856C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED05A2133D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzWEq8Bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED05A2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRlgM-0005UV-41
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:50:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbH-0001Hb-TU
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbG-0005T2-Ca
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:15 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:41326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hRlbG-0005Rq-8E
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:14 -0400
Received: by mail-yb1-xb41.google.com with SMTP id a13so3230074ybl.8
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2heJh5tCMxArqPxVmn3FS840JL0uYSXskTv3N4HdCKg=;
	b=jzWEq8BfFj0ZGxNoJkQhZJgUCfzhQXVefTcknyPau2RhGKm923Wf7PBrkUGpxF0skf
	Oosv4WETA7J3VJWyeGPryuZXbTD4f4TXjIGQXPPndCO7tjj//24RW2kb1eWOPfVVDt1x
	VuUcJWxQc+CmrJ1voBM78rD/Uo080w5YBxFN/s4ETYXhaDqrumtRkuSvcY5hY2b1dJjz
	s8AvNVXph5rmtmeE5+JekmC7VHKWte4J4tGJrni2Uds4khSOQa3NWcRFeUz3HQlXxtrd
	TX5PF2Zx2SZdvkn01V79XRHPemAInW8OkkS2lrSKvUDBsq2gHA/Odd/b/qq4tk3TLV+N
	1VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2heJh5tCMxArqPxVmn3FS840JL0uYSXskTv3N4HdCKg=;
	b=ten9EngP3eHhvYkmiQijRt+xsHzmmKXaH8AAgoaV3SDeQJHc1RiRiwOMIq5OraAEDt
	mr9GSGBTnye63KE3c1xV+v3oqzdtbfZNPE1Fdd6nQdxCPTcZGDSW8t7JnuKMMe4Ex/Xi
	d4xKtRcD5la7k03lI7sIyF8CYHqRkygXggZI8Rso3X0eoo2im+T7wDo8jTFGvlquk8eH
	gpiiSz6r9DbrXCICsMZf9/Q4EIjgwbOzxR9MgkF8rREsDrc4wpzwiLyxsocJigI6RCiu
	CQ5GiPkYTWiGaAiZ7samzaATv/ylu5Yj4dSnAz7XrX5LnI9V40sOGQBKN3jhwJCetq42
	9drA==
X-Gm-Message-State: APjAAAWGRH/+Y8Wk2WzNX5rY52aUXICKG5l3d2DoOzfxJ7eNzRvYs1r+
	1WW3fM8vUzaxamazhS4brUoIkzRCXyhMsA==
X-Google-Smtp-Source: APXvYqye3C8YWZd6QMbshI+9wVPb1zH4gvXgPvPF/rw5jukWSepaOCVKorQ1pAVQRCJvFxKtrF/+eA==
X-Received: by 2002:a25:a1e6:: with SMTP id a93mr5089114ybi.15.1558133113564; 
	Fri, 17 May 2019 15:45:13 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	u73sm2480260ywf.62.2019.05.17.15.45.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 15:45:13 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:44:42 -0400
Message-Id: <20190517224450.15566-4-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517224450.15566-1-jan.bobek@gmail.com>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RISU v2 03/11] risu_i386: move reginfo-related code
 to risu_reginfo_i386.c
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
risu_reginfo_i386.{h,c}; this patch adds the latter by extracting the
relevant code from risu_i386.c.

This patch is pure code motion; no functional changes were made.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c         | 54 -----------------------------------
 risu_reginfo_i386.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 54 deletions(-)
 create mode 100644 risu_reginfo_i386.c

diff --git a/risu_i386.c b/risu_i386.c
index 6798a78..2d2f325 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -33,43 +33,6 @@ void advance_pc(void *vuc)
     uc->uc_mcontext.gregs[REG_EIP] += 2;
 }
 
-static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
-{
-    int i;
-    for (i = 0; i < NGREG; i++) {
-        switch (i) {
-        case REG_ESP:
-        case REG_UESP:
-        case REG_GS:
-        case REG_FS:
-        case REG_ES:
-        case REG_DS:
-        case REG_TRAPNO:
-        case REG_EFL:
-            /* Don't store these registers as it results in mismatches.
-             * In particular valgrind has different values for some
-             * segment registers, and they're boring anyway.
-             * We really shouldn't be ignoring EFL but valgrind doesn't
-             * seem to set it right and I don't care to investigate.
-             */
-            ri->gregs[i] = 0xDEADBEEF;
-            break;
-        case REG_EIP:
-            /* Store the offset from the start of the test image */
-            ri->gregs[i] = uc->uc_mcontext.gregs[i] - image_start_address;
-            break;
-        default:
-            ri->gregs[i] = uc->uc_mcontext.gregs[i];
-            break;
-        }
-    }
-    /* x86 insns aren't 32 bit but we're not really testing x86 so
-     * this is just to distinguish 'do compare' from 'stop'
-     */
-    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
-}
-
-
 int send_register_info(int sock, void *uc)
 {
     struct reginfo ri;
@@ -100,23 +63,6 @@ int recv_and_compare_register_info(int sock, void *uc)
     return resp;
 }
 
-static char *regname[] = {
-    "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
-    "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
-    "CS", "EFL", "UESP", "SS", 0
-};
-
-static void dump_reginfo(struct reginfo *ri)
-{
-    int i;
-    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
-    for (i = 0; i < NGREG; i++) {
-        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
-                ri->gregs[i]);
-    }
-}
-
-
 /* Print a useful report on the status of the last comparison
  * done in recv_and_compare_register_info(). This is called on
  * exit, so need not restrict itself to signal-safe functions.
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
new file mode 100644
index 0000000..e8d671f
--- /dev/null
+++ b/risu_reginfo_i386.c
@@ -0,0 +1,68 @@
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
+#include <stdio.h>
+#include <ucontext.h>
+
+#include "risu.h"
+#include "risu_reginfo_i386.h"
+
+static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
+{
+    int i;
+    for (i = 0; i < NGREG; i++) {
+        switch (i) {
+        case REG_ESP:
+        case REG_UESP:
+        case REG_GS:
+        case REG_FS:
+        case REG_ES:
+        case REG_DS:
+        case REG_TRAPNO:
+        case REG_EFL:
+            /* Don't store these registers as it results in mismatches.
+             * In particular valgrind has different values for some
+             * segment registers, and they're boring anyway.
+             * We really shouldn't be ignoring EFL but valgrind doesn't
+             * seem to set it right and I don't care to investigate.
+             */
+            ri->gregs[i] = 0xDEADBEEF;
+            break;
+        case REG_EIP:
+            /* Store the offset from the start of the test image */
+            ri->gregs[i] = uc->uc_mcontext.gregs[i] - image_start_address;
+            break;
+        default:
+            ri->gregs[i] = uc->uc_mcontext.gregs[i];
+            break;
+        }
+    }
+    /* x86 insns aren't 32 bit but we're not really testing x86 so
+     * this is just to distinguish 'do compare' from 'stop'
+     */
+    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
+}
+
+static char *regname[] = {
+    "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
+    "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
+    "CS", "EFL", "UESP", "SS", 0
+};
+
+static void dump_reginfo(struct reginfo *ri)
+{
+    int i;
+    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
+    for (i = 0; i < NGREG; i++) {
+        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
+                ri->gregs[i]);
+    }
+}
-- 
2.20.1


