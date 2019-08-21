Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A3AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2632082F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoMobaYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2632082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Uvv-0008HK-EJ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URA-0000vT-Ad
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0UR9-0007H0-1B
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:20 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:35834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0UR8-0007GN-TO
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:18 -0400
Received: by mail-yw1-xc44.google.com with SMTP id g19so1247117ywe.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R7SHwqk+rBA3T0M/WcbegqvZ7iRiLvL4LCeF6iLjNDw=;
 b=XoMobaYDKq6t4PZ9X95CtpSikcnYYEJAaVndZCQVQ2HnQt8cU9OohOjTnRXhTxlJXM
 2NQE9eO5++WR3nVQWFCtxtWT9ktxXmo+kPF7vR/Q5GsSjUVJ+7TD32XysKxXvu8A+NlD
 riPhfrNFrctpDJz1MYlsOb0cQUFlBCiCYTzHkn6mkKxT7bfrjtwuZzOZuTv+ihGrTr/R
 JfnLpoY6qqckbHDQFh2xKx9nyRDNIdR5IkwFn4j+3lycuLtkwnYfqZBSRlASj9GDWVr+
 Bnn5WwuTH/DLkUSEPB5p0cf88Sp6mDJh4dZ8XQLk7fCc+pYUYWE2yy1QRAJPOVRxn59z
 HP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R7SHwqk+rBA3T0M/WcbegqvZ7iRiLvL4LCeF6iLjNDw=;
 b=sEPEQmEqcJC0XF2wv4q7t9JSsM0EldITkR8xew8UaADNQn+GM1af8ZM3di3XMknq/Q
 X6a7NrRCmvnUVavTGmnATwfv65sj/x3SNFBgtaePx4pT621425MZKpo3mdHqt5Lsjml+
 5spcHtZPXzxwVNGkj6Y35vVIfFl1DgUtYps8TqJCD59+p12KEDF5LWEhwuxxkXVI//Xd
 2OgHokyN4RrUcBkbeZjcxWvHU0Op1k9Ck/DnhlIC97elgs7BcVrE367rrkLFWDWw8nIw
 x5fkoQQshm8T1H6aVS1BF5jAfQ8tUi3bH2TphOcOuCngUCcgtihFPsHENa/Uv2kquIXk
 DZVw==
X-Gm-Message-State: APjAAAV6Ho+HMRM3Ng+NALscqU7/sGV2ngI2X0MrlcPPXFJA7t7MfO/J
 7h+7iW7QG2SwtcAa5JDIPhFVUXAf
X-Google-Smtp-Source: APXvYqzt6kuFhdQGNnl8D2BZfjGQKBy9wtyM/I+G9jApxtS7OEGQeL1L04krXeRLmaojVK++NU6EUw==
X-Received: by 2002:a0d:ec12:: with SMTP id v18mr25003657ywe.458.1566408618252; 
 Wed, 21 Aug 2019 10:30:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:17 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:53 -0400
Message-Id: <20190821172951.15333-18-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v4 17/75] target/i386: introduce
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
index e7c2ad41bf..78ef0e6608 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4578,6 +4578,34 @@ static bool check_cpuid(CPUX86State *env, DisasContext *s, CheckCpuidFeat feat)
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
+    static bool insnop_init(opT)(insnop_ctxt_t(opT) *ctxt,      \
+                                 CPUX86State *env,              \
+                                 DisasContext *s,               \
+                                 int modrm, bool is_write)
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


