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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53DDC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B69422D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhZR2peg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B69422D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0V1S-0008RH-DZ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URE-00013S-9H
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URD-0007Nd-6O
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:24 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:34115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URD-0007N8-2s
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:23 -0400
Received: by mail-yb1-xb44.google.com with SMTP id u68so1356179ybg.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HWIcXPysmeS2l7c7W0WqcjKf8OA5bIZKBcQSIeG2wd8=;
 b=OhZR2peg55sHT1qIxNFy+UUAURo5zRTulvbSkHsLq/WFTWKqXG2lTRgbtfzVhw3mjj
 E3unQu2qSVzltYX2jm7ba/WmltgO2gmvEjxHowVd92p6rWzVyqjHVlVPrhMerXfa24Uk
 20gd8ZvWM93KH8MN9ls7Sz4lm5n9CBNmYd3zJY3mlC8mG/g5yhwTBGldmTAIpS1ivnff
 Zpfqz1SLBalyMKypacYV/XC2whFl25DUjTh2n+Hl1O+JdFpFyI4rWiqtmWidT/GG8mSa
 7qXFZZdSxPt1GgTbJGOmMJy7JW2sw1FDm1LvRPRmyMvN3N89zszJ8DEAQ2cbMndtisps
 HMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HWIcXPysmeS2l7c7W0WqcjKf8OA5bIZKBcQSIeG2wd8=;
 b=rHc7x8wvLaR5/t9fM8OH8+0EPxa+NosA3EFZoLt6yN33Cz2nUnQ2ZpP0JAlcGNRXEx
 v3jU8ieRPtdM861INgehm9vUzWODxnlwSQBXi1s2LBtF9pBQn5vDCe3sL0hwglwm7ctQ
 jibIs5kwuZCKkn98EogZkrOZKKDpVglSZd6NFmnsK2MpB4wTgv6ZG1OYyaGNoKdXwAlc
 +LRYKVKKBoPS9YeJYDzJcLa0zWzC9I73q/PxRXgQzvAGec+l81PGOsYKLG+Mco54Zihf
 wCBdrMxNcYfYIUKdvJjgGBBuRFBOHxkqIWrNluA20q1yyo49eeC0TKPHGTPIA5diBWHO
 WtKQ==
X-Gm-Message-State: APjAAAUT8OtlN6aBzYMaRuY5UPrUHYBd7HO8ZuLw0NEmBrkl/6CpNV+O
 OfiLrT/zNvGDR7Y7SbF5yK1jRc6h
X-Google-Smtp-Source: APXvYqyBvZHNzUM2k0PLedAL9H2YzytwFvXdzEwb3XW5AS2v7C1sBbtQnfvVyokVlsbdWxXN12mE9w==
X-Received: by 2002:a25:7357:: with SMTP id o84mr26087341ybc.54.1566408622418; 
 Wed, 21 Aug 2019 10:30:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:21 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:58 -0400
Message-Id: <20190821172951.15333-23-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RFC PATCH v4 22/75] target/i386: introduce modrm
 operand
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

This permits the ModR/M byte to be passed raw into the code generator,
effectively allowing to short-circuit the operand decoding mechanism
and do the decoding work manually in the code generator.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 80cfb59978..a0a9f64ff3 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4771,6 +4771,26 @@ INSNOP_FINALIZE(tcg_i64)
     tcg_temp_free_i64(arg);
 }
 
+/*
+ * modrm
+ *
+ * Operand whose value is the ModR/M byte.
+ */
+typedef int insnop_arg_t(modrm);
+typedef struct {} insnop_ctxt_t(modrm);
+
+INSNOP_INIT(modrm)
+{
+    return true;
+}
+INSNOP_PREPARE(modrm)
+{
+    return modrm;
+}
+INSNOP_FINALIZE(modrm)
+{
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


