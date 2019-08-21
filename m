Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C023C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F73214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXjtE/ML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F73214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UzZ-0005Zf-4Q
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URU-0001R1-Fp
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URT-0007o6-9B
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:40 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:41465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URT-0007ne-4v
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:39 -0400
Received: by mail-yb1-xb41.google.com with SMTP id 1so900566ybj.8
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u85Ude1ydVnfdQhG5ukKRSXQHHwYa85nY6X3O1K+7Jc=;
 b=gXjtE/MLwgsy1Kp8SgVU5ZJHLJxwz5RKUAIUtGan5NDJAe+vR6BbEP1cmvgQ4zw18N
 cNH3jpCvZs2YH4PT8cM9MJ0IbC7REAj340x6u/0dANtKJhVxB3q0ZgT4D1tbOau4YN1+
 OWRWXVbnXZfslrO2T0I/7T/7MnGNZ4Ah0i/lax/XLPKXqsRyA+OGCfFyyPHjqrdjnC5R
 dQyGuBuN8RTi0IYpjPzgFMrhimgcGWb5T5ZVg1fnpirNzHIijav7K85AwW1GJmwrujwc
 Mldgl4MFKKY4VtWm4+ZKw04lFYkJKHERhPv0rJCBqSdLdZCOxdxcP8Drh5KvW3N2JDbB
 2mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u85Ude1ydVnfdQhG5ukKRSXQHHwYa85nY6X3O1K+7Jc=;
 b=ZA+bsl2UByEyo2dI5UXZydMvje2ljbj6S9vLI4az0+fHTd6W3DHxxJge/cNDH6FbnN
 9fZl0ttYQhYrjSmxOM0S/u+UxSb586S13BjBOqrZfvxe3mqhBPPsZbZlyuWF6Iv35f4S
 lSIjnBiy0yYXOy+0HOxFG6wWsoud4qTqkL8VjEoIYUuV1GuT4UMmOqlkERncJrtYynbn
 UppWvMrcESlbJmxZQ2z2KgcoCPeCrLmMLbkJBDa0Unf2U8wRhh3ZkZutTQCcKXns24WA
 a1QCF4gaopH+u9MH6zRvcfmb6KfrxQTpnC0yemH9RBykIvP+fYDa3ltNyhg1SuevWpjA
 twQg==
X-Gm-Message-State: APjAAAUWaTffo7sGVQpKGn8Bo5E5zqdsrk9DKwp5uynKzL8mLiu3Sq8b
 IV67fen9LFaVRWmPTuMcCIVNoaPG
X-Google-Smtp-Source: APXvYqxoXWzVyPfoQGPjCCNRfHq3ab/JGkjXqnxv5r2/UJFoFdQ3o5hoNeer68oridnxNa5JOwgJGg==
X-Received: by 2002:a25:1806:: with SMTP id 6mr25564458yby.415.1566408638523; 
 Wed, 21 Aug 2019 10:30:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:37 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:15 -0400
Message-Id: <20190821172951.15333-40-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v4 39/75] target/i386: introduce SSE
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

Use the translator macros to define translators required by SSE
instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index fdfca03071..d77c08b7db 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5720,6 +5720,9 @@ static void translate_insn0()(
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN1(Mb)
+DEF_TRANSLATE_INSN1(Md)
+
 #define DEF_TRANSLATE_INSN2(opT1, opT2)                                 \
     static void translate_insn2(opT1, opT2)(                            \
         CPUX86State *env, DisasContext *s, int modrm,                   \
@@ -5753,10 +5756,29 @@ static void translate_insn0()(
 
 DEF_TRANSLATE_INSN2(Ed, Pq)
 DEF_TRANSLATE_INSN2(Eq, Pq)
+DEF_TRANSLATE_INSN2(Gd, Nq)
+DEF_TRANSLATE_INSN2(Gd, Udq)
+DEF_TRANSLATE_INSN2(Gd, Wd)
+DEF_TRANSLATE_INSN2(Gq, Nq)
+DEF_TRANSLATE_INSN2(Gq, Udq)
+DEF_TRANSLATE_INSN2(Gq, Wd)
+DEF_TRANSLATE_INSN2(Mdq, Vdq)
+DEF_TRANSLATE_INSN2(Mq, Pq)
+DEF_TRANSLATE_INSN2(Mq, Vdq)
+DEF_TRANSLATE_INSN2(Mq, Vq)
 DEF_TRANSLATE_INSN2(Pq, Ed)
 DEF_TRANSLATE_INSN2(Pq, Eq)
+DEF_TRANSLATE_INSN2(Pq, Nq)
 DEF_TRANSLATE_INSN2(Pq, Qq)
+DEF_TRANSLATE_INSN2(Pq, Wq)
 DEF_TRANSLATE_INSN2(Qq, Pq)
+DEF_TRANSLATE_INSN2(Vd, Ed)
+DEF_TRANSLATE_INSN2(Vd, Eq)
+DEF_TRANSLATE_INSN2(Vd, Wd)
+DEF_TRANSLATE_INSN2(Vdq, Qq)
+DEF_TRANSLATE_INSN2(Vdq, Wdq)
+DEF_TRANSLATE_INSN2(Wd, Vd)
+DEF_TRANSLATE_INSN2(Wdq, Vdq)
 
 #define DEF_TRANSLATE_INSN3(opT1, opT2, opT3)                           \
     static void translate_insn3(opT1, opT2, opT3)(                      \
@@ -5796,9 +5818,16 @@ DEF_TRANSLATE_INSN2(Qq, Pq)
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN3(Gd, Nq, Ib)
+DEF_TRANSLATE_INSN3(Gq, Nq, Ib)
 DEF_TRANSLATE_INSN3(Nq, Nq, Ib)
 DEF_TRANSLATE_INSN3(Pq, Pq, Qd)
 DEF_TRANSLATE_INSN3(Pq, Pq, Qq)
+DEF_TRANSLATE_INSN3(Pq, Qq, Ib)
+DEF_TRANSLATE_INSN3(Vd, Vd, Wd)
+DEF_TRANSLATE_INSN3(Vdq, Vdq, UdqMhq)
+DEF_TRANSLATE_INSN3(Vdq, Vdq, Wdq)
+DEF_TRANSLATE_INSN3(Vdq, Vq, Wq)
 
 #define DEF_TRANSLATE_INSN4(opT1, opT2, opT3, opT4)                     \
     static void translate_insn4(opT1, opT2, opT3, opT4)(                \
@@ -5844,6 +5873,11 @@ DEF_TRANSLATE_INSN3(Pq, Pq, Qq)
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN4(Pq, Pq, RdMw, Ib)
+DEF_TRANSLATE_INSN4(Vd, Vd, Wd, Ib)
+DEF_TRANSLATE_INSN4(Vdq, Vdq, Wd, modrm_mod)
+DEF_TRANSLATE_INSN4(Vdq, Vdq, Wdq, Ib)
+
 #define DEF_TRANSLATE_INSN5(opT1, opT2, opT3, opT4, opT5)               \
     static void translate_insn5(opT1, opT2, opT3, opT4, opT5)(          \
         CPUX86State *env, DisasContext *s, int modrm,                   \
-- 
2.20.1


