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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EFDC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D805208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEP4EwYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D805208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5qf-00062J-RB
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Do-0006Z3-7Y
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dn-0000YG-5N
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:36 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:33202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Dn-0000XQ-0T
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:35 -0400
Received: by mail-yw1-xc43.google.com with SMTP id e65so307255ywh.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SqwvmHDVPtJ1VNAOlSBVqkwXsS/iGALpdig8lvEHZDs=;
 b=pEP4EwYSCl0eoTRTLDxgbEueOqOUDq3cd+AHfufZNJWGaY7vIymbULm/w+1pn3da1B
 su3h6ac7OdYF2Fgeh8YE8+4IEGzUoDj92ss+ERhJh9z2U/uFAbuTLWDVWUYpBJqSSRsV
 LQgvqnJaK2c5LvR/2V35LTW8MoVtjtmX/KkPPssk1SjcD+Qdg09tjyY2Grr8qTOPt7kY
 Lso+EzJ0aKxKXw0+i/xqaiecm7X2GYqpPGL2p9dp7PlgaY3ZlogQvnl7jFyvdw7fyDM4
 XcKerBSLF7zOqXzXlQelFbLg8kx4Hs9nUa5cVSkG1YeSI68cld2rfT88cNiHR501EUiV
 b3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SqwvmHDVPtJ1VNAOlSBVqkwXsS/iGALpdig8lvEHZDs=;
 b=H+v75hb8Hr/+SNrhBj6BLkIsjzzvSz2EDREFAKyZ6yP/MRY5OuGyEUqKod1FleABP1
 Sut9t9ny/8eBgMOgpWY4XqfpSTiQIx1ANdguXlU+ep2FNNnRlIWOGrkH1sGsdc9kAZBb
 8xlYBc/QNtghpVcktZREmDpDuTbQEX/kUeRvtuTZgiqSxCzoGvOv0H6CtwFMFcjjft3z
 ArDdxJLzUq5gCys7mNCV1tJi8QF0SE6ExWb2b7ZpNiz07tcJuB5tR8DybtCvh9CPrlzJ
 D+6jBVTIfv8eTlVf9G7sqSTsOGKq3biSmeY6uiuQ5xCK2OnnuYYIP5IwQBjlHbP92gvF
 aemg==
X-Gm-Message-State: APjAAAXmKBOEyMuM0wLYi56vLZWsCG69mXIQ+Z3qwgQnPdvajwNaQb4E
 Xi2y1kCXL30FvuQv9TQbM1v5EOV8
X-Google-Smtp-Source: APXvYqz9kBoCNGkdBsZedl7VDQlgMj/lp8aLcB0nFhMi8Wga5E2tf7pINVwy0rYA33Wrzy/YK7ki8w==
X-Received: by 2002:a0d:e897:: with SMTP id r145mr1671733ywe.80.1565835034345; 
 Wed, 14 Aug 2019 19:10:34 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:33 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:26 -0400
Message-Id: <20190815020928.9679-45-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v3 44/46] target/i386: introduce SSE3
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

Use the translator macros to define translators required by SSE3
instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 7ec082e79d..c72138014a 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6363,6 +6363,7 @@ DEF_TRANSLATE_INSN2(Vd, Wd)
 DEF_TRANSLATE_INSN2(Vd, Wq)
 DEF_TRANSLATE_INSN2(Vdq, Ed)
 DEF_TRANSLATE_INSN2(Vdq, Eq)
+DEF_TRANSLATE_INSN2(Vdq, Mdq)
 DEF_TRANSLATE_INSN2(Vdq, Nq)
 DEF_TRANSLATE_INSN2(Vdq, Qq)
 DEF_TRANSLATE_INSN2(Vdq, Udq)
-- 
2.20.1


