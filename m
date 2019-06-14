Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA7BC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6372183E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxq5Zjpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6372183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbprb-0005hU-VO
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56054)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkL-0000fh-8e
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkJ-00033x-UJ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpkJ-00032n-N7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id n9so3339344wru.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZGytCy7dk/rtAnR0c8LWL1u/jXw6ywf1Xd8f/B0+XIs=;
 b=pxq5ZjpaQRToCSpwt1pPvpFRVNiQ/D2WAC20IMEsDa68lIbIrN10EdCAGtSUHvzw0E
 BrsvDTpj+l3hci0chuojJBL8/g7sVrs2Te8k0EjoDS2jo9AELtK9prZpz9yM1mwAf4SI
 VeijTvFGOH2HXejJGQBEzzn6hO4eleuDXd6X1gQ76auaK0mBDht1wWvlNNB08zKyxCoS
 s8VWmJax8aqMpLmZwj/tGAQAFLO+5AoFkomr5VneX0QCfVwxWXFCfSkNtZhWhBrFG5cn
 hQLpj/2WwACaD18/A0gJU7LI8naSZWC1So1W+s0Wge1B6McQBRbIkewb8PEJVm09J2Xi
 Oj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZGytCy7dk/rtAnR0c8LWL1u/jXw6ywf1Xd8f/B0+XIs=;
 b=gsfSNunZnPZdv+hWACWZZRdOqkj8/7I+yHw2dJFks9hTzsdwD+n+5y5scTqwMIUzRl
 VJE0pitMeZDQyQXz+YnkLcd/mVDS8rWK9w1vZMpQlqreC1XsmViPOhh7SCQReuBHGe71
 GIl/W6N+U9WcjGMZDUhZFe3Q5GT2H7gBWlk1SpLWA5PHtdCKnXHqsQnngw5AtlfGKlW/
 p+WclwZd+xEcvoqhHid4lfmSBLncxgpbPlJ7Aj5zXNmUivSQnbBmFAXflQIOFaJ9Z/Ac
 o/1VRVDxYYHs80KDFImDgdMv+adFT9PbpfGra1yqlD+6aGh9U225SLT4FUai58ZTtXH8
 QSdg==
X-Gm-Message-State: APjAAAXR2fQSXpiVabV6W2ADEvQcPGJiuyRNwqlD4GbFWPgy2Ynk16aS
 MRJXvUJLL9PQd685YAn9nMUtEw==
X-Google-Smtp-Source: APXvYqwynb8NZtUK5NtDBM3eDufFX+apCyNMFDI1h4I/cTv5ZVlV8uSDif5HIwmqA2z660sT8kv5tA==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr31265800wrq.350.1560532330517; 
 Fri, 14 Jun 2019 10:12:10 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d17sm5047352wrx.9.2019.06.14.10.12.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:12:06 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C11701FF8C;
 Fri, 14 Jun 2019 18:12:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:24 +0100
Message-Id: <20190614171200.21078-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH  v3 14/50] tcg: add tcg_gen_st_ptr
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

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg-op.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index e997346c97..edf12de1f3 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1260,6 +1260,11 @@ static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
     glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
 }
 
+static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
+}
+
 static inline void tcg_gen_discard_ptr(TCGv_ptr a)
 {
     glue(tcg_gen_discard_,PTR)((NAT)a);
-- 
2.20.1


