Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2375FECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63FF206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tsEjXFXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63FF206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJybt-0004gP-QY
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyC8-00081n-VD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJyC6-0007eB-WD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJyC6-0007cy-Pd
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:07:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id f22so16306178wmc.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FKYCRxM54+fFieoPbxriSyiRx4DZwuJ1T6+6ndzyCSc=;
 b=tsEjXFXDWa9AFkxcomh08i3oHIYhxMC8mpxDWsszOIooj8mrSGrIs1KW6eprejRHaJ
 BrEptceNGBulQEcfvL0P9F2/KhrUUJo87JHbsiiHggO9nbs9si0IVPY9YiqNsrfm3WYa
 tzjYHp0Hew9tjd1gCwBgpZVr4QdQjifCc6xTxR9upbjkVOuHOMtelWfFQdkg8KnIPgsf
 4Im1r9jUDRN/2syi5ynj0X9nBxb9JEvdKBN6/Nzdhpo1xEEZ23WqQhNpCbGE7B26a8a7
 pX1vdhMj/jTczoQyi2zliOr1AirROrekidKjNrC/MJzR8sbzeMm/NmggTGK6a1B3Eh42
 VdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FKYCRxM54+fFieoPbxriSyiRx4DZwuJ1T6+6ndzyCSc=;
 b=D6N3ObiAxYyTWBjC6QIb+XQCvwAIknuSF5M5s6mGxqsPgD2eBZi4s02HkLgpQkylXV
 ND5JD3sm0BW1EQ+N8yb/choS8ZTt0LVZv0OHWR3wgKPoA7l04m9xNf9V4GryX/mekO1n
 zrf0UxzKzmYT1McXbAn0Q19f2XaOgWnzLZ9mdKAGV4mYWWZr+oeLDzMVNdzaFR3um8E7
 fUlhb02g9bKiz443D4+d+TIeuIY4OgOYQcBxwj08WAVyYr4MggFxpEIeJQAl19VSPImM
 UZTkcE30DiMzJFFINMkwo6MWR+f5pWY7cnqFBa29uwHWI2MekAx8JnzPDlsjLaGFPWHs
 TFEA==
X-Gm-Message-State: APjAAAWLKwjGOiUC8p/uyo8HNsYwvtJd0cMkxNgDQckP8oGmgFkRn67u
 J8EpWAoK/2cdeUkp4Y2l2qAcPw==
X-Google-Smtp-Source: APXvYqwU6U54LfTFG7qexz5kUVHV0APIHj7NwkrvmnAh6ZNvYgi+Pxv+jBGGP2jUr+RVOsdMCdADEA==
X-Received: by 2002:a1c:1bc5:: with SMTP id
 b188mr14875814wmb.164.1571051237154; 
 Mon, 14 Oct 2019 04:07:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m7sm19094537wrv.40.2019.10.14.04.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 04:07:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CD6A51FFD9;
 Mon, 14 Oct 2019 11:50:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 53/55] plugins: add sparc64 instruction classification table
Date: Mon, 14 Oct 2019 11:49:46 +0100
Message-Id: <20191014104948.4291-54-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@futurewei.com, peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As an example of another set of instructions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/howvec.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/plugin/howvec.c b/tests/plugin/howvec.c
index 5f7c740833..9ec0d25e3b 100644
--- a/tests/plugin/howvec.c
+++ b/tests/plugin/howvec.c
@@ -112,6 +112,27 @@ InsnClassExecCount aarch64_insn_classes[] = {
     { "Unclassified",        "unclas", 0x00000000, 0x00000000, COUNT_CLASS},
 };
 
+InsnClassExecCount sparc32_insn_classes[] = {
+    { "Call",                "call",   0xc0000000, 0x40000000, COUNT_CLASS},
+    { "Branch ICond",        "bcc",    0xc1c00000, 0x00800000, COUNT_CLASS},
+    { "Branch Fcond",        "fbcc",   0xc1c00000, 0x01800000, COUNT_CLASS},
+    { "SetHi",               "sethi",  0xc1c00000, 0x01000000, COUNT_CLASS},
+    { "FPU ALU",             "fpu",    0xc1f00000, 0x81a00000, COUNT_CLASS},
+    { "ALU",                 "alu",    0xc0000000, 0x80000000, COUNT_CLASS},
+    { "Load/Store",          "ldst",   0xc0000000, 0xc0000000, COUNT_CLASS},
+    /* Unclassified */
+    { "Unclassified",        "unclas", 0x00000000, 0x00000000, COUNT_INDIVIDUAL},
+};
+
+InsnClassExecCount sparc64_insn_classes[] = {
+    { "SetHi & Branches",     "op0",   0xc0000000, 0x00000000, COUNT_CLASS},
+    { "Call",                 "op1",   0xc0000000, 0x40000000, COUNT_CLASS},
+    { "Arith/Logical/Move",   "op2",   0xc0000000, 0x80000000, COUNT_CLASS},
+    { "Arith/Logical/Move",   "op3",   0xc0000000, 0xc0000000, COUNT_CLASS},
+    /* Unclassified */
+    { "Unclassified",        "unclas", 0x00000000, 0x00000000, COUNT_INDIVIDUAL},
+};
+
 /* Default matcher for currently unclassified architectures */
 InsnClassExecCount default_insn_classes[] = {
     { "Unclassified",        "unclas", 0x00000000, 0x00000000, COUNT_INDIVIDUAL},
@@ -126,6 +147,7 @@ typedef struct {
 ClassSelector class_tables[] =
 {
     { "aarch64", aarch64_insn_classes, ARRAY_SIZE(aarch64_insn_classes) },
+    { "sparc64", sparc64_insn_classes, ARRAY_SIZE(sparc64_insn_classes) },
     { NULL, default_insn_classes, ARRAY_SIZE(default_insn_classes) },
 };
 
-- 
2.20.1


