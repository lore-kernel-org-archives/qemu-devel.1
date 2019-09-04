Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5908C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DC020449
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g97Iw9a4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DC020449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cke-0004lm-3Z
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9g-0006Ls-3c
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9e-0006xH-Hj
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:27 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9e-0006ve-9l
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:26 -0400
Received: by mail-pf1-x442.google.com with SMTP id q5so11663pfg.13
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1viOu5GL1Auv3D+RvMLd1iNczsL4mRxNizWgcflzx+Q=;
 b=g97Iw9a4YpDqZkxyCAAjqM0FLF7LhXGIg38+xJ9glbLWbFxnGD1TfdFfQqedu+wXJj
 U1M87erXHmQhHwTxR6c/CHe/dyzs81/+kBrQeKLsYcBujJp7DC/f/u7zxccrAYc9doUz
 048i8exZu6MWQg2DnND2wmfj263Z+wIQ2fDUJhrjL9U5WhHJlocqsPnTAFZxgVaak3ou
 Wg3rB5KKGhjyalIx5ApvXr+AhCz7K5/V9HefYLvO34Ie+o0hOzbFkewtWfkPhTSjXpHL
 CY+YZxa10MOh5652fsbYYsaYQOXy1elOlJg9caNmNPr+BlPZWuH/V7tfp8G7q8QgYVSq
 hhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1viOu5GL1Auv3D+RvMLd1iNczsL4mRxNizWgcflzx+Q=;
 b=ZF6MI9NAdctvTINeuofmU2XJ00gPv9oRVJV3Ovuth/HeZ1Rvgrh+qSLQZs9/2fEFCS
 Qx3YJjqvpKnszLQCW0YaPxj7eYv3jnQawgPP2znjw4DPYk9t0Dz4CclN1MLGreQVyzma
 bqrNv7bWU/INKJnliOfeK78H8PvYUKhgnq0puoPIaIrOqEnb1crDNJ9MWWJbrldZ+czx
 K1LciLnnk1Pe733hQHcKBCoDCdGOaAQeW4QvunMo6cEf7xModYDggSIp5xAVimg+2N3Y
 B9RC93+e9pbcdrZgwS7UpOq0wMomTg7uKsTinm2fh0F4KcyuP00EoW8iOJ21MmlHJ9EX
 rv8A==
X-Gm-Message-State: APjAAAU7ifHQfCvcd6jLZK3wRjdL5G39LpmWqPbvMwzf05czn5y+rVWW
 s3ie816gMHMt1z+jBVx+MdkbR+e0vMc=
X-Google-Smtp-Source: APXvYqzzLG0x7CGWVAZr2STWJ/AJRxbWAlGqePrKZdlICL4faMEAV1gpWZLoDT3q9Thu/DnHn4B3yg==
X-Received: by 2002:aa7:9591:: with SMTP id z17mr48833868pfj.215.1567629925120; 
 Wed, 04 Sep 2019 13:45:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:45:07 -0700
Message-Id: <20190904204507.32457-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
References: <20190904204507.32457-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PULL 13/13] target/openrisc: Update cpu "any" to v1.3
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the two updates from v1.3 are implemented,
update the "any" cpu to enable it.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index f96a69e278..506aec6bfb 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -129,7 +129,7 @@ static void openrisc_any_initfn(Object *obj)
 
     cpu->env.vr = 0x13000040;   /* Obsolete VER + UVRP for new SPRs */
     cpu->env.vr2 = 0;           /* No version specific id */
-    cpu->env.avr = 0x01010000;  /* Architecture v1.1 */
+    cpu->env.avr = 0x01030000;  /* Architecture v1.3 */
 
     cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP | UPR_PMP;
     cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_OF32S |
-- 
2.17.1


