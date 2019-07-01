Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F7C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B09208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYi+E5RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B09208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhoFQ-0000sx-U7
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56737)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho30-0005Ga-Ed
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2y-0004aJ-ES
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:10 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:36543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho2y-0004a0-8l
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:08 -0400
Received: by mail-yw1-xc41.google.com with SMTP id t126so7852457ywf.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YiHmuiCxSoCx0uekoQAyjkaK0zaClP7jIiAfcU7C2V4=;
 b=aYi+E5RBM6YNMCvdD+oFV6phFRmYn6Zm9QbqCkCjTHm+xHnS/UVmYw2O1CJDdvGmrl
 mK+b+6ZunM8zrUdcryk0qqxbvALq7n+5aBGMbXIqz5ALG66Z7JIWv/crZc2hhtXRItS9
 ph3GJfuXOApRwFPsn6Nrpcq2vqhPUfVf8UoJbhsuKJKsVbkFx7acscToffamhNUlFnpO
 4X8R/PLohZr7v3cW3tuPgQ8DA7BLLQFoVyWCyvGgmWuRg1FRYUU1GgDOuek+biIzL/HP
 /gf/47gJPKCYI65fALYfCvKGo4K3Q7dd+E8Y7kg041pOq0/wfjv5346IhSv5eNVxC0x8
 zEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YiHmuiCxSoCx0uekoQAyjkaK0zaClP7jIiAfcU7C2V4=;
 b=idFwkfos40pGCQRTWfzvGDoC0Tm2M0dGFU+ssNYPvr/TzOWAijWIifv+PFB9KNgRWd
 N71sOaMlGOURbJ1CUAg0jwM453FPbojc8dBeKO39UXgVl490OjC2juLEmSLxngMEVavh
 Jn7MNBcQsrHS5YfRAJOAaMUdWDHb1AUlnCP0YAPyapL6H8Ak7NJzCoRATT6rfYQQKbiW
 RIN+w8im35afMaRLGCnjq9/RDJWU3N6UbyOG623kz7FeNANLb0gAlvPK0dXcrBrDsAOK
 4F4TxodY802tnY2mFcxzzwNxkbmpGax56ZKM0GtxXJMR/2U08fy8u4XTooDWa4hEQBGO
 i3OA==
X-Gm-Message-State: APjAAAU21wSrK1+l8KBbdXgaq3GBCt0TgdrC3L9itZ0Bhr2An+wnmdhn
 pUo69L1M27SC9zKuZme49bQQOYbR
X-Google-Smtp-Source: APXvYqwdVmwnUbTGHyLhm6rbhaYyEOoDIwXbA3uJ4DciWgXrxb51vQVFRsMjGMnM+m158d+dBHhWmw==
X-Received: by 2002:a81:2e45:: with SMTP id u66mr13538311ywu.410.1561955767328; 
 Sun, 30 Jun 2019 21:36:07 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.36.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:36:06 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:33 -0400
Message-Id: <20190701043536.26019-12-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RISU RFC PATCH v2 11/14] x86.risu: add SSE4.1 and
 SSE4.2 instructions
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

Add SSE4.1 and SSE4.2 instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/x86.risu b/x86.risu
index 35992d6..a73e209 100644
--- a/x86.risu
+++ b/x86.risu
@@ -124,10 +124,12 @@ ADDSUBPD        SSE3    00001111 11010000 !emit { data16(); modrm(); mem(size =>
 
 PMULLW          MMX     00001111 11010101 !emit { modrm(); mem(size => 8); }
 PMULLW          SSE2    00001111 11010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMULLD          SSE4_1  00001111 00111000 01000000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PMULHW          MMX     00001111 11100101 !emit { modrm(); mem(size => 8); }
 PMULHW          SSE2    00001111 11100101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PMULHUW         SSE     00001111 11100100 !emit { modrm(); mem(size => 8); }
 PMULHUW         SSE2    00001111 11100100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMULDQ          SSE4_1  00001111 00111000 00101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PMULUDQ_64      SSE2    00001111 11110100 !emit { modrm(); mem(size => 8); }
 PMULUDQ         SSE2    00001111 11110100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
@@ -162,18 +164,28 @@ RSQRTSS         SSE     00001111 01010010 !emit { rep(); modrm(); mem(size => 4)
 
 PMINUB          SSE     00001111 11011010 !emit { modrm(); mem(size => 8); }
 PMINUB          SSE2    00001111 11011010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMINUW          SSE4_1  00001111 00111000 00111010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMINUD          SSE4_1  00001111 00111000 00111011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMINSB          SSE4_1  00001111 00111000 00111000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PMINSW          SSE     00001111 11101010 !emit { modrm(); mem(size => 8); }
 PMINSW          SSE2    00001111 11101010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMINSD          SSE4_1  00001111 00111000 00111001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 MINPS           SSE     00001111 01011101 !emit { modrm(); mem(size => 16, align => 16); }
 MINPD           SSE2    00001111 01011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 MINSS           SSE     00001111 01011101 !emit { rep(); modrm(); mem(size => 4); }
 MINSD           SSE2    00001111 01011101 !emit { repne(); modrm(); mem(size => 8); }
 
+PHMINPOSUW      SSE4_1  00001111 00111000 01000001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 PMAXUB          SSE     00001111 11011110 !emit { modrm(); mem(size => 8); }
 PMAXUB          SSE2    00001111 11011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMAXUW          SSE4_1  00001111 00111000 00111110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMAXUD          SSE4_1  00001111 00111000 00111111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMAXSB          SSE4_1  00001111 00111000 00111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PMAXSW          SSE     00001111 11101110 !emit { modrm(); mem(size => 8); }
 PMAXSW          SSE2    00001111 11101110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMAXSD          SSE4_1  00001111 00111000 00111101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 MAXPS           SSE     00001111 01011111 !emit { modrm(); mem(size => 16, align => 16); }
 MAXPD           SSE2    00001111 01011111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
@@ -187,6 +199,7 @@ PAVGW           SSE2    00001111 11100011 !emit { data16(); modrm(); mem(size =>
 
 PSADBW          SSE     00001111 11110110 !emit { modrm(); mem(size => 8); }
 PSADBW          SSE2    00001111 11110110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+MPSADBW         SSE4_1  00001111 00111010 01000010 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 
 PABSB_64        SSSE3   00001111 00111000 00011100 !emit { modrm(); mem(size => 8); }
 PABSB           SSSE3   00001111 00111000 00011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
@@ -202,6 +215,14 @@ PSIGNW          SSSE3   00001111 00111000 00001001 !emit { data16(); modrm(); me
 PSIGND_64       SSSE3   00001111 00111000 00001010 !emit { modrm(); mem(size => 8); }
 PSIGND          SSSE3   00001111 00111000 00001010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
+DPPS            SSE4_1  00001111 00111010 01000000 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+DPPD            SSE4_1  00001111 00111010 01000001 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+
+ROUNDPS         SSE4_1  00001111 00111010 00001000 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+ROUNDPD         SSE4_1  00001111 00111010 00001001 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+ROUNDSS         SSE4_1  00001111 00111010 00001010 !emit { data16(); modrm(); mem(size => 4); imm(size => 1); }
+ROUNDSD         SSE4_1  00001111 00111010 00001011 !emit { data16(); modrm(); mem(size => 8); imm(size => 1); }
+
 # Comparison Instructions
 PCMPEQB         MMX     00001111 01110100 !emit { modrm(); mem(size => 8); }
 PCMPEQB         SSE2    00001111 01110100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
@@ -209,12 +230,21 @@ PCMPEQW         MMX     00001111 01110101 !emit { modrm(); mem(size => 8); }
 PCMPEQW         SSE2    00001111 01110101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PCMPEQD         MMX     00001111 01110110 !emit { modrm(); mem(size => 8); }
 PCMPEQD         SSE2    00001111 01110110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PCMPEQQ         SSE4_1  00001111 00111000 00101001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PCMPGTB         MMX     00001111 01100100 !emit { modrm(); mem(size => 8); }
 PCMPGTB         SSE2    00001111 01100100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PCMPGTW         MMX     00001111 01100101 !emit { modrm(); mem(size => 8); }
 PCMPGTW         SSE2    00001111 01100101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PCMPGTD         MMX     00001111 01100110 !emit { modrm(); mem(size => 8); }
 PCMPGTD         SSE2    00001111 01100110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PCMPGTQ         SSE4_2  00001111 00111000 00110111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
+PCMPESTRM       SSE4_2  00001111 00111010 01100000 !emit { data16(); modrm(); mem(size => 16); imm(size => 1); }
+PCMPESTRI       SSE4_2  00001111 00111010 01100001 !emit { data16(); modrm(); mem(size => 16); imm(size => 1); }
+PCMPISTRM       SSE4_2  00001111 00111010 01100010 !emit { data16(); modrm(); mem(size => 16); imm(size => 1); }
+PCMPISTRI       SSE4_2  00001111 00111010 01100011 !emit { data16(); modrm(); mem(size => 16); imm(size => 1); }
+
+PTEST           SSE4_1  00001111 00111000 00010111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 CMPPS           SSE     00001111 11000010 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
 CMPPD           SSE2    00001111 11000010 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
@@ -299,6 +329,7 @@ PACKSSDW        MMX     00001111 01101011 !emit { modrm(); mem(size => 8); }
 PACKSSDW        SSE2    00001111 01101011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PACKUSWB        MMX     00001111 01100111 !emit { modrm(); mem(size => 8); }
 PACKUSWB        SSE2    00001111 01100111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PACKUSDW        SSE4_1  00001111 00111000 00101011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 PUNPCKHBW       MMX     00001111 01101000 !emit { modrm(); mem(size => 8); }
 PUNPCKHBW       SSE2    00001111 01101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
@@ -331,13 +362,50 @@ PSHUFD          SSE2    00001111 01110000 !emit { data16(); modrm(); mem(size =>
 SHUFPS          SSE     00001111 11000110 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
 SHUFPD          SSE2    00001111 11000110 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 
+BLENDPS         SSE4_1  00001111 00111010 00001100 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+BLENDPD         SSE4_1  00001111 00111010 00001101 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+BLENDVPS        SSE4_1  00001111 00111000 00010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+BLENDVPD        SSE4_1  00001111 00111000 00010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PBLENDVB        SSE4_1  00001111 00111000 00010000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PBLENDW         SSE4_1  00001111 00111010 00001110 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+
+INSERTPS        SSE4_1  00001111 00111010 00100001 !emit { data16(); modrm(); mem(size => 4); imm(size => 1); }
+PINSRB          SSE4_1  00001111 00111010 00100000 !emit { data16(); modrm(); mem(size => 1); imm(size => 1); }
 PINSRW          SSE     00001111 11000100 !emit { modrm(); mem(size => 2); imm(size => 1); }
 PINSRW          SSE2    00001111 11000100 !emit { data16(); modrm(); mem(size => 2); imm(size => 1); }
+PINSRD          SSE4_1  00001111 00111010 00100010 !emit { data16(); modrm(); mem(size => 4); imm(size => 1); }
+PINSRQ          SSE4_1  00001111 00111010 00100010 !emit { data16(); rex(w => 1); modrm(); mem(size => 8); imm(size => 1); }
+
+EXTRACTPS       SSE4_1  00001111 00111010 00010111 !emit { data16(); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
+EXTRACTPS_mem   SSE4_1  00001111 00111010 00010111 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 4); imm(size => 1); }
+
+PEXTRB          SSE4_1  00001111 00111010 00010100 !emit { data16(); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
+PEXTRB_mem      SSE4_1  00001111 00111010 00010100 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 1); imm(size => 1); }
+PEXTRW          SSE4_1  00001111 00111010 00010101 !emit { data16(); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
+PEXTRW_mem      SSE4_1  00001111 00111010 00010101 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 2); imm(size => 1); }
+PEXTRD          SSE4_1  00001111 00111010 00010110 !emit { data16(); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
+PEXTRD_mem      SSE4_1  00001111 00111010 00010110 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 4); imm(size => 1); }
+PEXTRQ          SSE4_1  00001111 00111010 00010110 !emit { data16(); rex(w => 1); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
+PEXTRQ_mem      SSE4_1  00001111 00111010 00010110 !emit { data16(); rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); imm(size => 1); }
 
 PEXTRW_reg      SSE     00001111 11000101 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); imm(size => 1); }
 PEXTRW_reg      SSE2    00001111 11000101 !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); imm(size => 1); }
 
 # Conversion Instructions
+PMOVSXBW        SSE4_1  00001111 00111000 00100000 !emit { data16(); modrm(); mem(size => 8); }
+PMOVSXBD        SSE4_1  00001111 00111000 00100001 !emit { data16(); modrm(); mem(size => 4); }
+PMOVSXBQ        SSE4_1  00001111 00111000 00100010 !emit { data16(); modrm(); mem(size => 2); }
+PMOVSXWD        SSE4_1  00001111 00111000 00100011 !emit { data16(); modrm(); mem(size => 8); }
+PMOVSXWQ        SSE4_1  00001111 00111000 00100100 !emit { data16(); modrm(); mem(size => 4); }
+PMOVSXDQ        SSE4_1  00001111 00111000 00100101 !emit { data16(); modrm(); mem(size => 8); }
+
+PMOVZXBW        SSE4_1  00001111 00111000 00110000 !emit { data16(); modrm(); mem(size => 8); }
+PMOVZXBD        SSE4_1  00001111 00111000 00110001 !emit { data16(); modrm(); mem(size => 4); }
+PMOVZXBQ        SSE4_1  00001111 00111000 00110010 !emit { data16(); modrm(); mem(size => 2); }
+PMOVZXWD        SSE4_1  00001111 00111000 00110011 !emit { data16(); modrm(); mem(size => 8); }
+PMOVZXWQ        SSE4_1  00001111 00111000 00110100 !emit { data16(); modrm(); mem(size => 4); }
+PMOVZXDQ        SSE4_1  00001111 00111000 00110101 !emit { data16(); modrm(); mem(size => 8); }
+
 CVTPI2PS        SSE     00001111 00101010 !emit { modrm(); mem(size => 8); }
 CVTSI2SS        SSE     00001111 00101010 !emit { rep(); modrm(); mem(size => 4); }
 CVTSI2SS_64     SSE     00001111 00101010 !emit { rep(); rex(w => 1); modrm(); mem(size => 8); }
@@ -383,6 +451,7 @@ MOVNTI          SSE2    00001111 11000011 !emit { modrm(mod => ~MOD_DIRECT); mem
 MOVNTI_64       SSE2    00001111 11000011 !emit { rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVNTQ          SSE     00001111 11100111 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVNTDQ         SSE2    00001111 11100111 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+MOVNTDQA        SSE4_1  00001111 00111000 00101010 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
 
 PREFETCHT0      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 1); mem(size => 1); }
 PREFETCHT1      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 2); mem(size => 1); }
-- 
2.20.1


