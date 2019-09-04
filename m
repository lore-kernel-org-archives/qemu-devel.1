Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EFAC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4DD21883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e63ejY72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4DD21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bTt-0003p4-54
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0J-0004t9-Go
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0G-0002ZE-6U
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:43 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0F-0002YW-T4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id y22so8277263pfr.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aH/3YEr2M2jm0vMpMPf4pJC6xbTf5AjfAwZZFhTAH2w=;
 b=e63ejY72sEioWyaiQCpLM3xEYOOAhhtw0DG4+SExnKUVjm9aNEKrL5btXq6wusbXSr
 sS5pXwwUvKG7CnaJ+j0TkkVMql1OXsUFn++2Fgx4nkd7cUt8RBrtIxF/CDBLifWEqRFV
 pSbry/0Y6PduCsEzuD/nlGtmRJxDykFisKGaE+HfeP6Hdr8NYK+MTHqrLH97k+ogZ0c3
 Wb3zHxSNq2Baw2Zsb4yCLJeNrDM39lTmIfFRSznj6BUEHFnoSkdquRZuyGLK5jUTCULq
 0oF3x8N61lU51LFDOBPEfxXB9W8/nXPkcUDx0snA+SVjnENxfg8c+8lfh3rU8yySqv5b
 lY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aH/3YEr2M2jm0vMpMPf4pJC6xbTf5AjfAwZZFhTAH2w=;
 b=KC+owVVlIqBjpFg5DO6fyUkYiNteLGA1asdnw28eUZDQDbTkux/NdImuGamZaIql2o
 PpJvUhpLCijW3xdVk0S+3pDION2PuQUopxUrTZ2Pbeeefr9NpVp6c8nDAV7bjRcElYac
 UcGJw1bKNQPYImeBjI2zO0CUMPICBkpEeQbCy/gdwEUJfXhKTyrwMziO3/dW6xZBtS3u
 CG0EuMC4omV39sqGWHMjl4zpnr2SS77QMDRJDKl3sbn7tZcCBhLelK7lHf+SOhOiYpfA
 ld5A4QbgsNechijDrADyoHY97mTDiJNqd2127xpe/fh9w1lxlYgEQq6rAImUYDfaDehF
 H6Qw==
X-Gm-Message-State: APjAAAWpOYYIaSe3c221csoq/wrf2tGE/8DHO0Ki1+uL/U9vfxkD5yHf
 ZepeK1od/SL8PAOtklGzeSaO4UA5uEk=
X-Google-Smtp-Source: APXvYqxC/slEzOdenOWMz6a9YBW/Vyod8EJuAFm2zCYnqfDpd3mnKa3FKIiALemXtvP80GC22cWNng==
X-Received: by 2002:aa7:9117:: with SMTP id 23mr24816920pfh.94.1567625498662; 
 Wed, 04 Sep 2019 12:31:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:19 -0700
Message-Id: <20190904193059.26202-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v4 29/69] target/arm: Diagnose writeback
 register in list for LDM for v7
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

Prior to v7, for the A32 encoding, this operation wrote an UNKNOWN
value back to the base register.  Starting in v7 this is UNPREDICTABLE.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1f3c7bbd54..b67e7389d3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9997,6 +9997,15 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a)
 
 static bool trans_LDM_a32(DisasContext *s, arg_ldst_block *a)
 {
+    /*
+     * Writeback register in register list is UNPREDICTABLE
+     * for ArchVersion() >= 7.  Prior to v7, A32 would write
+     * an UNKNOWN value to the base register.
+     */
+    if (ENABLE_ARCH_7 && a->w && (a->list & (1 << a->rn))) {
+        unallocated_encoding(s);
+        return true;
+    }
     return do_ldm(s, a);
 }
 
-- 
2.17.1


