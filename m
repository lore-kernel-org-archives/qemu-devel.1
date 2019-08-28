Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E838C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178ED217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyOOI8lX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178ED217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33sr-0008La-BQ
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GV-0003oG-03
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GS-0000P1-Vp
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:54 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33GS-0000Ms-GI
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:52 -0400
Received: by mail-pf1-x442.google.com with SMTP id o70so392768pfg.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U00Zb093z+hXOMnaNizAdzZJk8lMkRiGoOKwHfvrSvk=;
 b=OyOOI8lXMBHwRm2Akw2bT40UBK9uvuraCgICZ2ejQoxP1HWKfw4W+9+YhQKKRBNgrS
 RukDgSM3RI8Lg4TW4WqhbO69lv6URPRPtlG57CHgeyiyR2weaonlx7eiOzUlO7fdcqnr
 3qIiN7x+fhpdCiP5HDBr/drzH4QRRKfihta2+iYeHpP0rP93cmmZuPfG2auf8yP/E2N8
 4MJFqUTL5/RPN7jbFDbH527THyMZt2VeCemXgZTl714h3kj4rpjpHgPf+HCtF8i/c537
 fzqc9jrsZRAgzsekFTz9JmE+iE/UFPCVzIGYaT7aJK3blR5yjphoYdjeEaPw32pTkep1
 e3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U00Zb093z+hXOMnaNizAdzZJk8lMkRiGoOKwHfvrSvk=;
 b=hi21YRmLrq0W1fF7KUXrYeO9cOExNlNrp5ovAWaLrsMLdWTh/4kxQv9lzgwczjbSJ4
 7yhIsmiOMWHACi+kh3xxpTgDrJOkccUzanMIK6JV2QadwPUu7Ua0ftGe9lF2kDY4nqez
 ioKGLuaPTTjkxgVJSx2qAJ7nTKB0d9cwBr1IzfhJ2gJs5uxNpIMrneR5xCtYhUn6x3zz
 9NhIrH1XkG8i4ruMBGmIyYr9iJ5DDUYSW9pyKiTJUKFPqwBwh2Tcz81CeWQDx4puywDb
 R/zk9SMBBi05i816PNw1uoZX4B9dgGRdVfm93mXwJ/h2/UvAV+55yB2o/suRN7G6brzb
 dg0Q==
X-Gm-Message-State: APjAAAUkfUqWPdN5s4zrij7Yh2KKdX0LXJjPQEnJZxyyqOzjPqP+T8FB
 HdIe5EajvAUdblGq7OYFvMpN08r55vg=
X-Google-Smtp-Source: APXvYqw0MKY8VphMIGtM3QC35F5Th/yNrB4dKS5qIJFij0JHjsikSKYyMZiUvejTPQv0HIo1kuSUSQ==
X-Received: by 2002:a17:90a:f995:: with SMTP id
 cq21mr5895568pjb.27.1567019148754; 
 Wed, 28 Aug 2019 12:05:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:25 -0700
Message-Id: <20190828190456.30315-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 38/69] target/arm: Convert PLI, PLD, PLDW
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 37 +++++++++++++++++++-----------------
 target/arm/a32-uncond.decode | 10 ++++++++++
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f81f369544..c55bd1e563 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10229,6 +10229,26 @@ static bool trans_SETEND(DisasContext *s, arg_SETEND *a)
     return true;
 }
 
+/*
+ * Preload instructions
+ * All are nops, contingent on the appropriate arch level.
+ */
+
+static bool trans_PLD(DisasContext *s, arg_PLD *a)
+{
+    return ENABLE_ARCH_5TE;
+}
+
+static bool trans_PLDW(DisasContext *s, arg_PLD *a)
+{
+    return arm_dc_feature(s, ARM_FEATURE_V7MP);
+}
+
+static bool trans_PLI(DisasContext *s, arg_PLD *a)
+{
+    return ENABLE_ARCH_7;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10289,23 +10309,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             return;
         }
-        if (((insn & 0x0f30f000) == 0x0510f000) ||
-            ((insn & 0x0f30f010) == 0x0710f000)) {
-            if ((insn & (1 << 22)) == 0) {
-                /* PLDW; v7MP */
-                if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
-                    goto illegal_op;
-                }
-            }
-            /* Otherwise PLD; v5TE+ */
-            ARCH(5TE);
-            return;
-        }
-        if (((insn & 0x0f70f000) == 0x0450f000) ||
-            ((insn & 0x0f70f010) == 0x0650f000)) {
-            ARCH(7);
-            return; /* PLI; V7 */
-        }
         if (((insn & 0x0f700000) == 0x04100000) ||
             ((insn & 0x0f700010) == 0x06100000)) {
             if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index 32253b4f9a..ddc5edfa5e 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -54,3 +54,13 @@ SB               1111 0101 0111 1111 1111 0000 0111 0000
 
 # Set Endianness
 SETEND           1111 0001 0000 0001 0000 00 E:1 0 0000 0000  &setend
+
+# Preload instructions
+
+PLD              1111 0101 -101 ---- 1111 ---- ---- ----    # (imm, lit) 5te
+PLDW             1111 0101 -001 ---- 1111 ---- ---- ----    # (imm, lit) 7mp
+PLI              1111 0100 -101 ---- 1111 ---- ---- ----    # (imm, lit) 7
+
+PLD              1111 0111 -101 ---- 1111 ----- -- 0 ----   # (register) 5te
+PLDW             1111 0111 -001 ---- 1111 ----- -- 0 ----   # (register) 7mp
+PLI              1111 0110 -101 ---- 1111 ----- -- 0 ----   # (register) 7
-- 
2.17.1


