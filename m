Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6ECC7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D69720857
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 03:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7i4Q4pZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D69720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Weq-0004W4-Bw
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 22:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Wdi-00039e-GP
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3Wdh-0003TN-Af
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:06 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3Wdh-0003SX-4L
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 22:00:05 -0500
Received: by mail-pf1-x443.google.com with SMTP id j9so8056577pfa.8
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 19:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cjiEN6evoksJ22gJdgVrmGMglErN9l7nWJMK6r0f5rQ=;
 b=i7i4Q4pZA4H2J35Cy+dVfly48eWVsHZF+Rs8aiG031mgvOOcSKvQz7Wk/LYlH7ITRV
 uqKSf2zqmdGJNm3K9RClSeBVR+lkV8Aqa8PNHN5ryxpdJhrjutvj6vJ5ESM4Cc2YmO6q
 +pev00wULzQEqI6Aha04yo6qR9ywfPf0SerxKdLaL4EETeoEQ3RJzb8YAfs0JbPuvzn0
 PVBM36DSCRocyGHuYO8EMhWapbQi14kspcVLsr8/9k/zdJc0FORg+hZI5Q2huVyzFMiB
 JUF15y9bENxdKvLq0DWHhI/Sbp/UdBG7qfzU6xJnwQRSHEi+jYr5z0/AZzpXjxvFQMeQ
 UeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cjiEN6evoksJ22gJdgVrmGMglErN9l7nWJMK6r0f5rQ=;
 b=oJKoCkb9ZZvnXwld7+ZTfgN6kROpztw85kWjqnMdgrBjPLyu1KVTYod3ZCsr4q040q
 6zBrthLb4E7TvxMM0sw08ivjK5FEIqop6yRFHPHKY6OfnpbK8O4GuQ0jtRh277mDU9Sp
 3SwsJMJdQmgYv5zAKGG7IIHE8LXoum2k1fgD/vXaIJehDkF5vx0AGboNmZIoAGHvtDTr
 +HRwfklrj3JMhYn+iGxaY05Unm2OtyZiIP58bYpYMbHnONfmZuhVmjFPQU0uunHF4Pq+
 CGhF0WV8xWQ0TXfCZhsBEImIzDtDxJPKeYd2y/Ma54o9JphcQYZrpS1SQJVV/29jTW6R
 /lOA==
X-Gm-Message-State: APjAAAUEfCYG7JbXvzSYjVVLIcK0qJ6CIPnGlcwEdiVlAbppKfr41oj+
 Fa7fuckK7u0Ps9MwC0ZbPm8dOQF1HyQ=
X-Google-Smtp-Source: APXvYqy1DTVzAfZCwiZ8savqZ9LwwqLM2AfrIY889WCLZ3Qh2MMIxwJmost7N8xD739Sn3EhhQA6nA==
X-Received: by 2002:aa7:9aa7:: with SMTP id x7mr14129890pfi.78.1581908403728; 
 Sun, 16 Feb 2020 19:00:03 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id u2sm14741060pgj.7.2020.02.16.19.00.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 19:00:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] tcg: Remove tcg-runtime-gvec.c DO_CMP0
Date: Sun, 16 Feb 2020 18:59:57 -0800
Message-Id: <20200217025957.12031-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200217025957.12031-1-richard.henderson@linaro.org>
References: <20200217025957.12031-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Partial cleanup from the CONFIG_VECTOR16 removal.
Replace DO_CMP0 with its scalar expansion, a simple negation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime-gvec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index f2199f14b4..ca449702e6 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -860,15 +860,13 @@ void HELPER(gvec_sar64v)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
-#define DO_CMP0(X)  -(X)
-
 #define DO_CMP1(NAME, TYPE, OP)                                            \
 void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                \
 {                                                                          \
     intptr_t oprsz = simd_oprsz(desc);                                     \
     intptr_t i;                                                            \
     for (i = 0; i < oprsz; i += sizeof(TYPE)) {                            \
-        *(TYPE *)(d + i) = DO_CMP0(*(TYPE *)(a + i) OP *(TYPE *)(b + i));  \
+        *(TYPE *)(d + i) = -(*(TYPE *)(a + i) OP *(TYPE *)(b + i));        \
     }                                                                      \
     clear_high(d, oprsz, desc);                                            \
 }
@@ -886,7 +884,6 @@ DO_CMP2(16)
 DO_CMP2(32)
 DO_CMP2(64)
 
-#undef DO_CMP0
 #undef DO_CMP1
 #undef DO_CMP2
 
-- 
2.20.1


