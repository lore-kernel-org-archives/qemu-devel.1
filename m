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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0288BC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1052216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orBbVQiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1052216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VIu-0001ed-Eu
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URa-0001Ys-7m
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URZ-0007xI-5t
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:46 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:38908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URZ-0007wt-28
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:45 -0400
Received: by mail-yb1-xb44.google.com with SMTP id j199so1342893ybg.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3WmwthMXAARi91QckFwEai37drlx513p6L/n0kwcJA0=;
 b=orBbVQiN7Xl+9YDnrXn0c7vWFYNEiVqeXB1EM9l8EJT+ftPf0/DHZRsyafF4EJT6Nv
 bFHwCjNWFQNG1Bm40IUzTUNMEkrRsVRca+0z4ERLGVcQS5LLiH/sVE5XPLFGaoGQw85u
 wKf42CTdSID0RFyWGvMjub8ubm7VhuHfGDu9E6IAACa63FLkSd1LJwiaTNKfwMRT8/F8
 2cF6JUe02YGNpph1gn1tdfp7UlVfrBXNjiV4guHeTAObYD6ooc6+DmJ543ihwIqHRhVW
 GDG+3dJFtWqtxIT5cNRgEGpyhmviRwJxTk5vJYyw8AdL1u1kArUYtUjlYvygKKaKDQzr
 cciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3WmwthMXAARi91QckFwEai37drlx513p6L/n0kwcJA0=;
 b=GzS3rkVpQ90gi3Wg+bgYCiJh2v/aCXEBVfgns99/t/29mLf9DpxNlOUlPw/hcasFkb
 7Ox4B2oiyxfIgSb6rt53xrsykKUnjosePY5ONl4QL4/hhniEu1CChtnzkEIaUvART9sI
 1VLwlgyHQtWJB2WW61Lm2KBw053guRQkNxpakCOLvs3brh1lGGtnK67w158UdHPYWp3H
 XRCcEJpaK/q0AW+LlyNL5hbvPxBVN/anrKjQGjATEfBFP4zh2Y8YJVmB4uDXjRZu9ZeR
 d/DSPwViguklEsO2TIt6Z5WBSbAQgCCK3S/5yP2S5KOEw5wFlHPknwRd0UfgSS6YFF/p
 5HwA==
X-Gm-Message-State: APjAAAWsOGhfj9xjhJxbS1H8g3AuWfk7bIq42r0E7oQ/zSx9WzsVH4Gb
 e9ba4UGHc4pWcgS9okbsaGCz6hMj
X-Google-Smtp-Source: APXvYqyggDawdm68NLIV0ccp3enaEwqG4hrwasjmx0XPHhU+o5/evcl2PKZN7eNmON17ZM29tT+0lQ==
X-Received: by 2002:a25:324b:: with SMTP id y72mr12448534yby.361.1566408644344; 
 Wed, 21 Aug 2019 10:30:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:43 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:21 -0400
Message-Id: <20190821172951.15333-46-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RFC PATCH v4 45/75] target/i386: introduce SSE3
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
index 3445b4cff1..a478f73c17 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6519,6 +6519,7 @@ DEF_TRANSLATE_INSN2(Vd, Wd)
 DEF_TRANSLATE_INSN2(Vd, Wq)
 DEF_TRANSLATE_INSN2(Vdq, Ed)
 DEF_TRANSLATE_INSN2(Vdq, Eq)
+DEF_TRANSLATE_INSN2(Vdq, Mdq)
 DEF_TRANSLATE_INSN2(Vdq, Nq)
 DEF_TRANSLATE_INSN2(Vdq, Qq)
 DEF_TRANSLATE_INSN2(Vdq, Udq)
-- 
2.20.1


