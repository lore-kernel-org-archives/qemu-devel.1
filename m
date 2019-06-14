Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247EAC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81B420850
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPtRlsp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81B420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54124 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbr0L-0000sJ-54
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34207)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0T-0007A8-MP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0P-0004CT-DQ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0N-0003lJ-C9
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id n9so3385901wru.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aDs2dqXGIEF28FBqcTkP/2L64OJ8gLbRaNrMScFtO/w=;
 b=ZPtRlsp/dKt9phzGVfveJ4SI5hzBAoqTmaMYqWk3nCJ3rRIlHomccMJmVbcQc2N1Mk
 znKQOikQGwZdRcH50kRT5CVggCPB58o7e+G5veruU+mXkkqazfhjteS3LoLpmPaztuTB
 rvwyzR9apG09I8prKRts/e7DjwCFEREXcgamlPwqAShujI5jsrW7oSiv7voNyVYCyny/
 bX0gyzPdAceDYOuTS3jT7pMc1X9unVJXUOZFXmKaYgi/57qq1Or5fVmwYcIF2KdHmRGr
 VAus7RaRr8BbGLVIc40QNgm08sy9oTRAHrCHpzCaHexzPaTx5gGRqP7NiGwQwlunJ9CK
 dZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aDs2dqXGIEF28FBqcTkP/2L64OJ8gLbRaNrMScFtO/w=;
 b=HFIrl5vOIVNTDXB8OT1C24rJFW1XQoC9RboDWjB9hRYhV+thnSBmJW/TAggcQMPeo0
 KhfQEBgrVSqbjY9o6cuKtFGrJxkDkNljhXmg+ipLs/VmOoQbBsddDQzLqTN/uJRatryP
 nukeDPr15YR/aOr8pemlEixJJZkdugZFhs1zo/aWsnOcaOMu3EC9Q0VCIa14nGuhqMr/
 D1Led6zRuiWCn8NxjKK5C0FWlTa7sVO9EHu57NjvXSsL+n+1VBnODaYPaCcGAIJxbVs4
 FHae8NnmCxfaokI3U+Pwc/N7TCwx4X3c+M3apcxrVESufUCo9oxv9yVTzId3MThKcqur
 lhlg==
X-Gm-Message-State: APjAAAVEFmSFqCZv1qHXZbluPrqU10ElQ7MsWTajWYs7OR0Tm9eqSzLQ
 beSZOQmBMkawWHGaLLsOkW9Rxw==
X-Google-Smtp-Source: APXvYqzco7nNUfYr1iu+cc4QpsTc4Tr8Rt3RnNz/LIPV0+espOLlKE8A4IPihgBcusMYPLkV30tK1A==
X-Received: by 2002:adf:e301:: with SMTP id b1mr14118389wrj.304.1560533310627; 
 Fri, 14 Jun 2019 10:28:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l8sm9147281wrg.40.2019.06.14.10.28.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D52821FF9E;
 Fri, 14 Jun 2019 18:12:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:25 +0100
Message-Id: <20190614171200.21078-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH  v3 15/50] tcg: add MO_HADDR to TCGMemOp
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
Cc: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

We will use this from plugins to mark mem accesses so that
we can later obtain their host address.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index 2385e758e5..966e89104d 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -367,6 +367,13 @@ typedef enum TCGMemOp {
     MO_ALIGN_32 = 5 << MO_ASHIFT,
     MO_ALIGN_64 = 6 << MO_ASHIFT,
 
+    /*
+     * SoftMMU-only: if set, the TCG backend puts the corresponding host address
+     * in CPUArchState.hostaddr.
+     */
+    MO_HSHIFT = MO_ASHIFT + 3,
+    MO_HADDR = 1 << MO_HSHIFT,
+
     /* Combinations of the above, for ease of use.  */
     MO_UB    = MO_8,
     MO_UW    = MO_16,
-- 
2.20.1


