Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684A3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31460206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqX2unwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31460206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42599 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrOv-0001pW-G8
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42450)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG8-000610-NQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG7-0004BW-Lz
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:24 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG7-0004Ao-DG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so61462395wma.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9b3X+OxdFS4s7ijxIWOdR10EruuJKJ1r4dNBV9mBKeA=;
 b=GqX2unwfVNB4UDNslGdAIvSoHlJrPIqSs4kzXFgk1mcCrcKahuPQcvsASyxPI/zAkG
 C8uE1loDQXi6Q5g/9tJV1Ke8ZB4wiUf50qhO4Dr3lNGmBwMUHlKkXPJQesTVYap8MQsL
 ZWVS84BsT4xIpjhT1JtxJKLj4wA0/g95WJON2D+Lugnof1YO6iNtFXAUOJnC8pBgRf2C
 xz3iRFKZ+jLDtuuXjO/fvjphl2mEIoRen9ZAaOvb5a80pIC8dwQvcoezfu6CrDecoCoC
 aKipOLMDIWSxKJWIcuyQtQpS7YKG0x85wQxlUZRJeXs5dbeNHgOIt6WQJV479qMeZDMs
 y5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9b3X+OxdFS4s7ijxIWOdR10EruuJKJ1r4dNBV9mBKeA=;
 b=MIjCd2bsNoTevlaCGzNaawOo7tzF0MAKEG6TXAfSuveqNA8cKk4nbnzxLbAtusHae6
 jtUEkuqgpA/ibeB/7hgCiKBCUjGILKM1zZdwbLGtiw/FAqXLiir5gHpBcH1FsS/wNQI0
 U+C3yM1p64TGGR5j6TLupwMshVM5bLe+iIGtt7awuUs867ha+AaSEExCEcDZ40pZ8Kpa
 4iD36w5Tbdxnu0nc34emGGWlDAsjpOa/mcMazQt6yEBzIv3nCMFPVgCdiXiRERyLoK3y
 LsE0KP08G37HjfqnaPwNTT8auvb41bN+1BoPq9VYCb6yH+1tqTDqUcOwby/SyzKjZ1Tr
 bSCg==
X-Gm-Message-State: APjAAAVv9VlCRw8dNVIcJqCe8pounyaTE4f/EbVKVa6xiS7XSNp+iGN1
 3NGz6byskvkXilhFym/8uQC1Og==
X-Google-Smtp-Source: APXvYqxZmwoTcjgKOWMcrWp+z5Vn5mjWjCVx0gH3izl1zP0MGCxrdmwvS9T4Aywdbjx4/14oKLnQKQ==
X-Received: by 2002:a1c:cc0d:: with SMTP id
 h13mr109006434wmb.119.1564589722202; 
 Wed, 31 Jul 2019 09:15:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n9sm114528408wrp.54.2019.07.31.09.15.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:17 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 332B41FFBE;
 Wed, 31 Jul 2019 17:07:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:05 +0100
Message-Id: <20190731160719.11396-41-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v4 40/54] target/xtensa: fetch code with
 translator_ld
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, aaron@os.amperecomputing.com,
 cota@braap.org, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/xtensa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 6f1da878752..cb849ae2d9b 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -863,7 +863,7 @@ static int arg_copy_compare(const void *a, const void *b)
 static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 {
     xtensa_isa isa = dc->config->isa;
-    unsigned char b[MAX_INSN_LENGTH] = {cpu_ldub_code(env, dc->pc)};
+    unsigned char b[MAX_INSN_LENGTH] = {translator_ldub(env, dc->pc)};
     unsigned len = xtensa_op0_insn_len(dc, b[0]);
     xtensa_format fmt;
     int slot, slots;
@@ -887,7 +887,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 
     dc->base.pc_next = dc->pc + len;
     for (i = 1; i < len; ++i) {
-        b[i] = cpu_ldub_code(env, dc->pc + i);
+        b[i] = translator_ldub(env, dc->pc + i);
     }
     xtensa_insnbuf_from_chars(isa, dc->insnbuf, b, len);
     fmt = xtensa_format_decode(isa, dc->insnbuf);
-- 
2.20.1


