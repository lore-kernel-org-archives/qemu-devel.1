Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E2AC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6AE206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+LR7gzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6AE206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5WM-0004E8-Rd
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DQ-00066k-TO
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DP-0008NP-0M
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:12 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:45960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DO-0008MY-SC
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:10 -0400
Received: by mail-yb1-xb41.google.com with SMTP id u32so388321ybi.12
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8wDdpNnOpBiBo+lSxDp9N9yHcPIqinmnQJDNUxxNJsk=;
 b=B+LR7gzXiDcLruANd0sQMWx7C+AHdIynhqxVGnwz45WhMbi2dNlNga2mB0SAqpswDw
 P/vFZEKj/ctDH0MwwNpYzfWGOt3cDqnQAUWgYLkoKU40HqQuws2oRQ54+s1Gd3lTaniB
 6DR+EGPqz/9vtu33MdUqT5Vc3h3POiLQooNLBcoIyz2rzLjlivWUfzJ/5F+KI1N6tmOL
 Hq0Ovy3kt26ADJ1OxqFG2DeB1ZFyjsv5Q6X6WKZOZJQ117RiIJDHPMJGwfjgQIusHBsL
 NNQlWZV0Lwzb6OOtx54pO5YLvwAAsXWjgny4p7V3B79OnoJg6LqgfXOvwF1rUWk6Iy/+
 3bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8wDdpNnOpBiBo+lSxDp9N9yHcPIqinmnQJDNUxxNJsk=;
 b=Z6xsn4+8knUzGhfziEdYXCPALPMNs8rLNoinOMe0cEIbWYCHqQ29lWs4t9r7oRjorg
 pUph1t7qPmPV36pK3RIm59SyoVCXgnJC+P9iviUu2tgvQXlzHMngwho3MX2NYxIDxjLF
 URkh+2COOrRp6i9OLCU8xQJFOl/0xskLrEs+2AXiH6daf5ynDHw7d4mK76v3js3n6APj
 OJURxz+OAr64dY+uTvzc3OyoLohdws7xgV+WAeG/RGNZk1dKQ6/WLbVhKVjgzSd0SvRn
 2d9mnI+k5nJ7LLKl3rElyZ9UPJcZJcG2GWEDz5M8qppPeap45MySWHKN3lv0zH85l7HP
 7OMw==
X-Gm-Message-State: APjAAAULlDV8AOQmPAb2239k+a8w/T3K68dWGbBEfi4ZPvvr83mKmh83
 fYiF5gE1swG8VIwsPpt4uFn4pJkK
X-Google-Smtp-Source: APXvYqx2nvM/xyHQHg/604RIs6tMoS2D/H/SxQ0eFAfhCCV4UaarB2WvfL1RRnQMqeq9eS1iFIuG7A==
X-Received: by 2002:a25:9012:: with SMTP id s18mr1959286ybl.474.1565835009305; 
 Wed, 14 Aug 2019 19:10:09 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:08 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:08:58 -0400
Message-Id: <20190815020928.9679-17-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v3 16/46] target/i386: introduce
 instruction operand infrastructure
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

insnop_arg_t, insnop_ctxt_t and init, prepare and finalize functions
form the basis of instruction operand decoding. Introduce macros for
defining a generic instruction operand; use cases for operand decoding
will be introduced later.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0cffa2226b..9d00b36406 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4548,6 +4548,34 @@ static int ck_cpuid(CPUX86State *env, DisasContext *s, CkCpuidFeat feat)
     }
 }
 
+/*
+ * Instruction operand
+ */
+#define insnop_arg_t(opT)    insnop_ ## opT ## _arg_t
+#define insnop_ctxt_t(opT)   insnop_ ## opT ## _ctxt_t
+#define insnop_init(opT)     insnop_ ## opT ## _init
+#define insnop_prepare(opT)  insnop_ ## opT ## _prepare
+#define insnop_finalize(opT) insnop_ ## opT ## _finalize
+
+#define INSNOP_INIT(opT)                                        \
+    static int insnop_init(opT)(insnop_ctxt_t(opT) *ctxt,       \
+                                CPUX86State *env,               \
+                                DisasContext *s,                \
+                                int modrm, bool is_write)
+
+#define INSNOP_PREPARE(opT)                                             \
+    static insnop_arg_t(opT) insnop_prepare(opT)(insnop_ctxt_t(opT) *ctxt, \
+                                                 CPUX86State *env,      \
+                                                 DisasContext *s,       \
+                                                 int modrm, bool is_write)
+
+#define INSNOP_FINALIZE(opT)                                    \
+    static void insnop_finalize(opT)(insnop_ctxt_t(opT) *ctxt,  \
+                                     CPUX86State *env,          \
+                                     DisasContext *s,           \
+                                     int modrm, bool is_write,  \
+                                     insnop_arg_t(opT) arg)
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


