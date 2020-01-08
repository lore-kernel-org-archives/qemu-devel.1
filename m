Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC77EC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AF92077B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBdfX0Zj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AF92077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Ts-0003nj-Eb
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2J5-0004y2-G6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2J4-0003lz-FV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:55 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:46625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2J4-0003lC-A7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:54 -0500
Received: by mail-pl1-x62a.google.com with SMTP id y8so531785pll.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SVfGBVbDnSFcIUB7kDREDDgKw+EkqJztHZWHPhrl2hw=;
 b=CBdfX0Zjo93DRJx3DpIcEPyJgk2YVXylsCXc4DMQuBj5Vv7DphpaNjIat5tMw4nMAb
 3xKgjJVoKdnuSRihmX0JWG8C2RYEmzcqPeBZfdKxS+888Pn6PKz+vgPTUpZcftWjpgk7
 Rzw3vr3Ug6Di1V9wjKs3dU1ii3F7xZgnwWxDx5OCRUNUIU53xLD1Mobm0lXT20L7+/s9
 Yt9bJiEWEFWrAg8YHIFPedHHPF8BsqkhCG6kXfZQYBU2OydTkeVtYa3EmsQmtVYTaaFA
 0VCK6N/nd5qx3wN7uVaeEiyNebs69VHw8GdQiYSDBpbgG25otrw402FvrRxvPVRAUCyw
 Dlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SVfGBVbDnSFcIUB7kDREDDgKw+EkqJztHZWHPhrl2hw=;
 b=BfhakXq7bhKKnpOp04QewEkIk7wdteOa9vIbSyBJxL6BBpBpuXBIHC4TQXQEwfhZU1
 oHzdWCnAzqkaC5o/XxhfvJoqIMpRDSdGUaW7l9wQLhLaUQwPeU5o8TrQvb0ykuf8TKiw
 /JqWHaXICdHiP/LaaDijmNQTLPmn9yxoTJDMN3xw3fWTn7ZPtsgWYq/WEAlFFVxfFon7
 0QCQJJ3Pd7pGo9Bn0xOz5wh/KTdnAIvYoMbROnefM57yJyHbTDKv8Oep98jo3MVou2vM
 RibdabTF0o+Soz1hV4Q5QIcvi729S5rBAYwKMqhdiexF9rAs8XKVvs1qz+U0tiZYG5La
 uf6A==
X-Gm-Message-State: APjAAAVao3KDpSuD1CxsiTYeNf/2/nTypKtzez3CRTgfKrGGDjgWBOyW
 JMKo+CMWN68WEdNCo7iUg3Af+Pw4Auq/LQ==
X-Google-Smtp-Source: APXvYqxN1lUYHv10MHmOoEl4GpT8dyfcdnMT0kWQlGJ0yRb1k940N+uCCJ+3fgu+qTueZPGj/DDP6Q==
X-Received: by 2002:a17:90a:ead3:: with SMTP id
 ev19mr2129331pjb.80.1578455213094; 
 Tue, 07 Jan 2020 19:46:53 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/41] target/microblaze: Remove MMU_MODE{0,1,2}_SUFFIX
Date: Wed,  8 Jan 2020 14:45:09 +1100
Message-Id: <20200108034523.17349-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 95773089aa..32522f606b 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -328,9 +328,6 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 #define cpu_signal_handler cpu_mb_signal_handler
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _nommu
-#define MMU_MODE1_SUFFIX _kernel
-#define MMU_MODE2_SUFFIX _user
 #define MMU_NOMMU_IDX   0
 #define MMU_KERNEL_IDX  1
 #define MMU_USER_IDX    2
-- 
2.20.1


