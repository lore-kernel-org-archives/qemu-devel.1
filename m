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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C567AC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF5C206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PciCaGFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF5C206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Um-0002Lr-A9
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DS-00067y-Qb
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5DQ-0008P0-V4
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:14 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:32933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5DQ-0008O1-Qz
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:12 -0400
Received: by mail-yb1-xb41.google.com with SMTP id b16so413811ybq.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zP6GTQGfujsY6bqhJL3wQyBHXL9hxwznzMfUQ8cbGjY=;
 b=PciCaGFt/gJiUY2imck1zro8OnscZvJKLk91e3A64pwV1Q1yubSY+jzy8w/s1165Kc
 6AvsKsPjX/li71KCf3dniDYKv+dJRczk7jfPJ90ybPpCD/IAEo7iR6Q6TR777JtSrjil
 Qu7F7/FcBTEvGrQYfHe1FuBuhAmaDcmo2h2bR2F5z6czdpe2BNF/LTFEODj+PEmx0RXA
 1+HepDOiKMEKOiHHI8NGu2G8E9/7xKqCRStY6xE8NC+WHJ17tbBtdrZxObCgK4f8WDvt
 wJVmMGgjEi/zcI/eaESkFlXZaEGfuHya8sPq642aFm6vYq7ot7A+LkMz9l/P9j4DslU5
 IlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zP6GTQGfujsY6bqhJL3wQyBHXL9hxwznzMfUQ8cbGjY=;
 b=eoHaf/T8nDew14hkd1CJS0/wNP7V36qA1NJj99skwwJjIKJUQ6FFASexiI0lSG+8YF
 hhlkWAPcsHtQZYPxIUhjfLEUvcG3BKxUU+8DrGY5io0D+xlSFt3YaeEKyvBZ0bMO4D2Z
 RZyVvjPzIENIhT7rCzfRDCCkeJXK79iiKEDmBTimj/6ktUPhoPf3S40dEdUU48QdgBad
 2chYYeT7BCbEFPuWgc26YBdsGdw3ril43dOPch9sga0MYrxhKnGdaa7n2wLXxhoWtUgq
 qa4z0wUWgk+XQXTsowQ1spdFhj19B1F2f/ZNlNFmMCFnMi4hClfiySGAdUH696vepg6q
 zNrA==
X-Gm-Message-State: APjAAAXsAeI/Q5ciE2xzwVfsXKqFMymibVw/3MRHhrjb+tS6j6XRF0dS
 V/ZtK4DcOT/E7dSeqSbulOdCs/6u
X-Google-Smtp-Source: APXvYqxD5c1SlOM35fhS4ZgPTcnqDdXn8BqzUeJaDHdpUV2rDR7otHR7A0Yk6cELEyfY2U+kh4ecEA==
X-Received: by 2002:a25:c3:: with SMTP id 186mr2085522yba.417.1565835011295;
 Wed, 14 Aug 2019 19:10:11 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:10 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:00 -0400
Message-Id: <20190815020928.9679-19-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v3 18/46] target/i386: introduce generic
 either-or operand
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

The either-or operand attempts to decode one operand, and if it fails,
it falls back to a second operand. It is unifying, meaning that
insnop_arg_t of the second operand must be implicitly castable to
insnop_arg_t of the first operand.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 8989e6504c..a0b883c680 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4596,6 +4596,52 @@ static int ck_cpuid(CPUX86State *env, DisasContext *s, CkCpuidFeat feat)
         insnop_finalize(opT2)(ctxt, env, s, modrm, is_write, arg);      \
     }
 
+/*
+ * Generic unifying either-or operand
+ */
+#define DEF_INSNOP_EITHER(opT, opT1, opT2)                              \
+    typedef insnop_arg_t(opT1) insnop_arg_t(opT);                       \
+    typedef struct {                                                    \
+        bool is_ ## opT1;                                               \
+        union {                                                         \
+            insnop_ctxt_t(opT1) ctxt_ ## opT1;                          \
+            insnop_ctxt_t(opT2) ctxt_ ## opT2;                          \
+        };                                                              \
+    } insnop_ctxt_t(opT);                                               \
+                                                                        \
+    INSNOP_INIT(opT)                                                    \
+    {                                                                   \
+        int ret = insnop_init(opT1)(&ctxt->ctxt_ ## opT1,               \
+                                    env, s, modrm, is_write);           \
+        if (!ret) {                                                     \
+            ctxt->is_ ## opT1 = 1;                                      \
+            return 0;                                                   \
+        }                                                               \
+        ret = insnop_init(opT2)(&ctxt->ctxt_ ## opT2,                   \
+                                env, s, modrm, is_write);               \
+        if (!ret) {                                                     \
+            ctxt->is_ ## opT1 = 0;                                      \
+            return 0;                                                   \
+        }                                                               \
+        return ret;                                                     \
+    }                                                                   \
+    INSNOP_PREPARE(opT)                                                 \
+    {                                                                   \
+        return (ctxt->is_ ## opT1                                       \
+                ? insnop_prepare(opT1)(&ctxt->ctxt_ ## opT1,            \
+                                       env, s, modrm, is_write)         \
+                : insnop_prepare(opT2)(&ctxt->ctxt_ ## opT2,            \
+                                       env, s, modrm, is_write));       \
+    }                                                                   \
+    INSNOP_FINALIZE(opT)                                                \
+    {                                                                   \
+        (ctxt->is_ ## opT1                                              \
+         ? insnop_finalize(opT1)(&ctxt->ctxt_ ## opT1,                  \
+                                 env, s, modrm, is_write, arg)          \
+         : insnop_finalize(opT2)(&ctxt->ctxt_ ## opT2,                  \
+                                 env, s, modrm, is_write, arg));        \
+    }
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


