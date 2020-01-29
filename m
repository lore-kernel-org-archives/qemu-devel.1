Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7C7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83DF206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8xEm648"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83DF206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxM7-0002kb-1Z
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCk-0004Ym-H3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCj-0000Pq-HQ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:06 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCi-0000Ls-Oq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:57:05 -0500
Received: by mail-pl1-x644.google.com with SMTP id ay11so601298plb.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qZMCkvURXMiFl3jYXkRerJw41ehWyPYg5p550RT7KeU=;
 b=m8xEm648dE8re7A+g7naS16xbiVJrcpimLXd+bd8rhDVbT7sFau62nhTfuWb5DPu/k
 6p13/cD6bB36IX8PRwRdT6Q+envGqY/4J4FdSlj0Gu/+2DUwIFJRWHFXjdoY6hRusW5W
 W1nMM74RHXkihiYsVdUYSwYjp5F61DeUiPvlWFws0cAp06g7XAe3DdWalF7mTvBNYlWu
 HbXOXNbh6mV6MEelZZeTccliBy3QmVp8rGKYTAEOA8jWPPRnnQxkA78c4gPQ8wIWrZf3
 H3z8qBybZQ9SS8fJHMDEOLE/JLqxdC/sKcVTci1af2itgWf1GNPgRWmBoh3lelM1LcUH
 uhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qZMCkvURXMiFl3jYXkRerJw41ehWyPYg5p550RT7KeU=;
 b=ogMNy5aY8g9xIF/o/93Rpr7XT8qP2E2W6AS/GtEy18OCGiDNux/n97MdV8PCzzy5+Q
 nw9mA/yOdTND1tML4Fb7URoL8sbvPwZCQ5Yy72h1PpLqEcFnl4zeA1S0OTPoH5kp3W83
 9fjvfUM1q5OUQa4F6l3z1+Smjfmi2sJU4JkjETCIiL7X0EgSn2NIevnv5UlDTw9O+RiK
 n88A4bmcfb3YLsEaKDtjcLKxL8BNWt95Yt8cJ0hJdskCtzmbwNfuTR9Xc56sCjN8wPIP
 qHLl+D+J5H5xOWwmY5CXJwoYwuQBAzNJE6i6iQzl1IVp4fV+U7LemvOM3jBZghIuDQII
 BLCg==
X-Gm-Message-State: APjAAAXM3sE6Fy5NRvmfRTc3z6MUXkUIe8ksUioIISOfn1e2ubC4VIav
 4ftrFzn3uloJUVDdTC57viKPjZzv0r8=
X-Google-Smtp-Source: APXvYqxn9kzqaBWDQSJnhHwTKF+rG7pcC5c2oOfkJlMILk1feItk38a30F1k0Xt6fGwsVixYzOWN5A==
X-Received: by 2002:a17:90a:9b88:: with SMTP id
 g8mr2544631pjp.72.1580342223584; 
 Wed, 29 Jan 2020 15:57:03 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:57:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 37/41] target/arm: Enable ARMv8.1-VHE in -cpu max
Date: Wed, 29 Jan 2020 15:56:10 -0800
Message-Id: <20200129235614.29829-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 61fd0ade29..d771e867fa 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -671,6 +671,7 @@ static void aarch64_max_initfn(Object *obj)
         t = cpu->isar.id_aa64mmfr1;
         t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 1); /* HPD */
         t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);
+        t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);
         cpu->isar.id_aa64mmfr1 = t;
 
         /* Replicate the same data to the 32-bit id registers.  */
-- 
2.20.1


