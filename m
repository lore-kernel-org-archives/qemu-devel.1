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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351FCC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E8722D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4KzcmK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E8722D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VAp-0004Wj-Jf
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URS-0001Ow-Rn
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URR-0007mK-91
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:38 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:41407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URR-0007m8-53
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:37 -0400
Received: by mail-yw1-xc43.google.com with SMTP id i138so1232346ywg.8
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tGTWM/7NjsvRzqpXeVBnEsMojpdECNSYAS0P31ZubK0=;
 b=Q4KzcmK8TrQrlVIJQJaBIbQopAVlxyhC/j4MnUSUr8WVcYKPSzdkBHExuR2VNhN0lm
 5zh6xdv9oZxtOZzZtRp/2rWd2HKtmxAajQZq4USAVoGi5Kkg28dA2V29xAaBsOt7OmZr
 GZR0PYnE5sZ+1FQtXsK+RhPXslXMOk9J9u2hOvHrvTYxIxaoSfkXZNHT/V2a2N53LCbU
 AKqg4jXmwolS7mGgYTNnsuS4L2JsviRZa+hDSDCxF5A/LZqwCnbEXlwfo2UyRHHLGLAQ
 Edo2jKtd6OCh+W4jGe7VXhH2+DgmaTQ0hf2EKY4dzQL3UUhyFJUbaAcrUVM1rtotCH47
 +JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tGTWM/7NjsvRzqpXeVBnEsMojpdECNSYAS0P31ZubK0=;
 b=jQY00YH8EMkhyTIWQCa6/AjrMatXl0iYBsDuU9GOfmWsG1GqTPfGOZUFYlFYiqIR4u
 yS9Ft6perrqrAxb5i2vTSX3O92eSU0Weq93NabR46DrRzwTTeo3J4jPHlCUxTH44yRTe
 u7udEQDC4Nquq5y1fGg2a4XWvxHDZ+BjNFbVV0FBn+WS9u2KiosR43vUsZvnaMUqFTJa
 DKl5BfUYh6UYhUgGvcR7p0lNBfjCOKuQKlVus4RHiKhoqiW1R06skTjO96HwLINIjWgT
 zm/9QmRtvLsAteEHgI2iTXpP2/QaeRz8xygFrnaL3Tc2Fg08nw7vmYCy0y1JBQCUVt4B
 C/9A==
X-Gm-Message-State: APjAAAXazcobjavf9ZzDpzPyhEBi0vOIXWVxJogjMGFHZEH19q6icbQV
 eRvKdW0kJVFgLcL+TAhegEiJuG9q
X-Google-Smtp-Source: APXvYqzdlKKRM/N67ra66pzDUbkVRCJRsA48KbkkWnEfoEdPwjHNRm46NYyNp8wmjHzoKzTxDiVduA==
X-Received: by 2002:a81:70c8:: with SMTP id
 l191mr25402729ywc.425.1566408636367; 
 Wed, 21 Aug 2019 10:30:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:35 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:12 -0400
Message-Id: <20190821172951.15333-37-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v4 36/75] target/i386: introduce MMX
 translators
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

Use the translator macros to define instruction translators required
by MMX instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 1c2502ff50..96ba0f5704 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5651,6 +5651,13 @@ static void translate_insn0()(
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN2(Ed, Pq)
+DEF_TRANSLATE_INSN2(Eq, Pq)
+DEF_TRANSLATE_INSN2(Pq, Ed)
+DEF_TRANSLATE_INSN2(Pq, Eq)
+DEF_TRANSLATE_INSN2(Pq, Qq)
+DEF_TRANSLATE_INSN2(Qq, Pq)
+
 #define DEF_TRANSLATE_INSN3(opT1, opT2, opT3)                           \
     static void translate_insn3(opT1, opT2, opT3)(                      \
         CPUX86State *env, DisasContext *s, int modrm,                   \
@@ -5689,6 +5696,10 @@ static void translate_insn0()(
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN3(Nq, Nq, Ib)
+DEF_TRANSLATE_INSN3(Pq, Pq, Qd)
+DEF_TRANSLATE_INSN3(Pq, Pq, Qq)
+
 #define DEF_TRANSLATE_INSN4(opT1, opT2, opT3, opT4)                     \
     static void translate_insn4(opT1, opT2, opT3, opT4)(                \
         CPUX86State *env, DisasContext *s, int modrm,                   \
-- 
2.20.1


