Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7425CC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B92A20830
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cf5DZK8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B92A20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57155 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZ3I-0001Ir-Fk
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 14:31:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0M-0007Zv-It
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0K-0007BU-Kk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:26 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:41805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0K-0007B1-Cm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:24 -0400
Received: by mail-oi1-x22c.google.com with SMTP id v7so11304808oie.8
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ZZX//Rv+ayyPhWmMCWfxTWkZjELBsgYzluMsiNdCjJI=;
	b=cf5DZK8urg91rpQk9z3hQbVqJlnjvlM2+fTRHJd2mryWj1M4izBQ9tXA5fmijk8Dna
	j3PkNN8KRfknwKTe5NHNKsnjsZEtM4ypmGq5Vq2geq7TXKn94uvHVriJBTcPqTbap0yY
	HGyEMHWIeVbtOQeKP6zj8re3B2K8l6X/G6g7rm+V0a9rEv785ePe2HXey1c07KdnVrZ7
	cMzWGdXk1tn6MOit2O1B3CiBn5XgXLOBciD1kIvOjL3vrDn7N1uUkUP2GUWVLH9T86wU
	d7yChCtSM1jGxBVbvdN+Z9k+blHAlFZlntuOGnlP0h1fsQvclTlL5Zgxeh/CHCfvMSAr
	b27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ZZX//Rv+ayyPhWmMCWfxTWkZjELBsgYzluMsiNdCjJI=;
	b=BKs23AdH6R3M4LJSesSeG63g7RlnYfXEB/mgLufqSXV52NfsE0mDPkJKd5oNrDgEC3
	qDmbnQAIxQcHODLJUBwDWq/HHDFX6hSKEH3kTkvAm6bPE/EWou9OI/eKDHX5ZuP9i4k1
	y3VqA/gYPehmVbUsxr2r+JpdexmqXTQ8wp2W654WIrB/cHgq+6EzbrG8ksfY8Fzwpm+P
	6KPW7IOofQvIYeMWBwPMRjw2redvEjTY2BVQUb93cZ8/4ujm+zkDWa+rVJH4N4C1YKDw
	6xLgTHMQa5C9EM0rtet8uRIUs9glvCs6CdBG4HU2TkTs3nHuiIA+oEr2zeTP92p3+HSP
	wDug==
X-Gm-Message-State: APjAAAXUPiR/TczVni//TsNs/gedbXBC54cSrT7wT6HfUHWCfkDDz4fw
	UMO38chYQ1Qr0quqVNf3JCuwVuF4108=
X-Google-Smtp-Source: APXvYqzYnv4D2Vtva/Gvum0qbcCYA8A/L4Ira3kiAz0cKrMMdjW2WSZZp1C3uD9lTVDgPx/aptgdkw==
X-Received: by 2002:aca:407:: with SMTP id 7mr16289515oie.90.1554748103343;
	Mon, 08 Apr 2019 11:28:23 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	r133sm9940295oib.21.2019.04.08.11.28.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 11:28:22 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 14:27:45 -0400
Message-Id: <20190408182748.1238-3-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408182748.1238-1-jan.bobek@gmail.com>
References: <20190408182748.1238-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Subject: [Qemu-devel] [RISU PATCH 2/5] risu_i386: move reginfo-related code
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Jan Bobek <jan.bobek@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408182745.pvB_S7GmUwbvI7CaWHPDWTuwjiwUbPUV3LfXYDbQwfg@z>

In order to build risu successfully for i386, we need files
risu_reginfo_i386.{h,c}; this patch adds the latter by extracting the
relevant code from risu_i386.c.

This patch is pure code motion; no functional changes were made.

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


