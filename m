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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC4C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E092084F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXqW0KyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E092084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5Nv-0001xA-8F
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dg-0006Mb-5n
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5De-0000I8-VT
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:27 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:42257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5De-0000Hj-Qg
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:26 -0400
Received: by mail-yb1-xb41.google.com with SMTP id h8so397396ybq.9
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WM8y0lT7y/DeSDBY8jUzYMxHv/vhpAG3omkdmTHu+ac=;
 b=mXqW0KyJURums63ggkntZqsGZ3QMIFbrd+9BZTBQEo3Ti57a+L8fQWLNO3pFOgnxuX
 lSi4b+Xi8db58DI/9AX1EpvFCcBTahtU+8WBCKZh6kWYQjrIAQt/W5VOOc/rO3RIHyII
 Y6nHtz+gddirw5eZIj7vbc7Jr8/n3qdQA+p6uJbpY26ZsCCm1XWS22NtrjRIc2FxW7kK
 XetNq4p+Q5PBxlq+5ct9aZbNUGy2rMymgXjH38q+pde+ef4MTTzU5tnZKQQs8ItxJnF8
 IWPsQJmRE6S7Lt+z+rV2nDYbQxxDVDoPc2QNpg04i8ky3b15EieQiPx8uh4q7C8w/ZU/
 uHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WM8y0lT7y/DeSDBY8jUzYMxHv/vhpAG3omkdmTHu+ac=;
 b=JusK3l+8eWGQ5iWaWMF9NhUCWToGLhS4peBzBcg7NVa/c0S2g3XpzKhXk2VhOdna/5
 H2xjl+ou5rtebPl2+M6K4KBBUsA+dXELNzqgJJm3gbMNaIO7HxRlpDaYqNoRZGzZV8ve
 ydNxmeAxqP0Gp1arfVs2OxxmWv5NmfWzAfEOd4R0wDpArIInXyIS6zTPV2g0Hnq9DSmw
 Arrmd5DuT3nJVruYlj+T4wVY6m/V9oOad2fqUEXD+tq2O2GDadBgb5KHjuEeM2QbaEk6
 0idN39Vk4s3CN/vWwuYXKK2sMRjYVIkQel2I2+S8OSdTyl95zKcLCHACGPSUk5xj8oCE
 omXw==
X-Gm-Message-State: APjAAAWEGROV2VzBe9tk8Mv5/9VCBW9Yu2QRz/GrFInrGt703oxxaOyM
 pABs9UJWmFVQBVGnqLQ2qDVYRtEG
X-Google-Smtp-Source: APXvYqxlofHlYlT7F8XZ+Fge85cKTdr3CXvpHEmm05PFYSs8/1EcG2YHaX42IESLuR9kRpSwNfkEbQ==
X-Received: by 2002:a25:1a42:: with SMTP id a63mr2006997yba.446.1565835026171; 
 Wed, 14 Aug 2019 19:10:26 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:25 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:17 -0400
Message-Id: <20190815020928.9679-36-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v3 35/46] target/i386: introduce MMX
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
 target/i386/translate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 76c27d0380..4fecb0d240 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5457,6 +5457,15 @@ static void translate_insn0()(
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN2(Ed, Pq)
+DEF_TRANSLATE_INSN2(Eq, Pq)
+DEF_TRANSLATE_INSN2(Gd, Nq)
+DEF_TRANSLATE_INSN2(Gq, Nq)
+DEF_TRANSLATE_INSN2(Pq, Ed)
+DEF_TRANSLATE_INSN2(Pq, Eq)
+DEF_TRANSLATE_INSN2(Pq, Qq)
+DEF_TRANSLATE_INSN2(Qq, Pq)
+
 #define DEF_TRANSLATE_INSN3(opT1, opT2, opT3)                           \
     static void translate_insn3(opT1, opT2, opT3)(                      \
         CPUX86State *env, DisasContext *s, int modrm,                   \
@@ -5501,6 +5510,13 @@ static void translate_insn0()(
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN3(Gd, Nq, Ib)
+DEF_TRANSLATE_INSN3(Gq, Nq, Ib)
+DEF_TRANSLATE_INSN3(Nq, Nq, Ib)
+DEF_TRANSLATE_INSN3(Pq, Pq, Qd)
+DEF_TRANSLATE_INSN3(Pq, Pq, Qq)
+DEF_TRANSLATE_INSN3(Pq, Qq, Ib)
+
 #define DEF_TRANSLATE_INSN4(opT1, opT2, opT3, opT4)                     \
     static void translate_insn4(opT1, opT2, opT3, opT4)(                \
         CPUX86State *env, DisasContext *s, int modrm,                   \
-- 
2.20.1


