Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530EAC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4BE206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7GhC9rA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4BE206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2aTB-0005EO-Bd
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2aRr-0004V1-RD
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2aRm-00011X-Bn
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:19:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2aRk-0000zh-Jp
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:19:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so18568738wru.13
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 05:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LSr8udusvAKQfLLyJhhl5YxHdfLCgd98fSLGhAWYlM8=;
 b=c7GhC9rAOOWRSGiwDyr1nbxkIxrTJtyYpIq9ppC1pscvJaELKtD1ZXGPWS8O3xQJX1
 1OVIBbqis9Yolb9WrW4pNEvh7CcY6sd3EALoSp698TJK9d5o92w6SzLMvdRDCq9RLREs
 trH1CysrJ50Y8VuAMRb5FyhDEnt6xp6e+Ec5Y+7VFxmKq89uhc/s08q1kPjIn/2KbKMi
 NEHrvB0HzVay3rm34chUXDhxrlk3IrPbLIkdBzX5a/Z2UGGdYdqJup7/p0GegFNrX1bV
 OgBVx+vpHReaMnlfAB6p77GwiZRodtekgA4y5bLBCGdEqdcDkbQCvFv4AsJhmvSkOXR3
 QwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LSr8udusvAKQfLLyJhhl5YxHdfLCgd98fSLGhAWYlM8=;
 b=tgP/b6eSG4x9JJc5oiOiK/N3b/W1uQzvS8JlupVZaLeD++SU8aKXxhpZXeaU20SIGZ
 aoZFvmaombiy2Ek8y1xggBDVr6Q6Ynb/4aSzWfs59gKXRJARnfkVehWpvvmChqvzVr0U
 TvvS4CGuA1EosGoluhTR7ZhK+SZfkK+qUl4TxcFOXzT6NL6yBU8YXo/aegAm1Lwlnbep
 GqNTS92PqmJ+/cGQmgIU1X3orQbgbg1KwKefTTR9pZGujmmqhGA9ZSLo/WsUWzOYGNVk
 B/ejyPXfYITczcDiGG63YcUBVr5cFaFS2+FzIuj+f8f1k6iiDzy2v4lQ+NZBHWRYn0y4
 wQXw==
X-Gm-Message-State: APjAAAXGZNI6SPkJH13GoPJ38XuysR3GGmgMBWXs7TLokomy63KtIwsA
 96rFwD/L9BCHKBZYkDdNyHaEBc4ozihmsA==
X-Google-Smtp-Source: APXvYqx4UfDmID6dCDako/+YKFwWuN2fSLPk975ILQg/8Z03bKxkXQAHElrhMsYrIv5Rshj+BqTjEA==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr27642954wru.27.1566908373729; 
 Tue, 27 Aug 2019 05:19:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b136sm7142435wme.18.2019.08.27.05.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 05:19:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 13:19:31 +0100
Message-Id: <20190827121931.26836-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH] target/arm: Free TCG temps in
 trans_VMOV_64_sp()
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function neon_store_reg32() doesn't free the TCG temp that it
is passed, so the caller must do that. We got this right in most
places but forgot to free the TCG temps in trans_VMOV_64_sp().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 3e8ea80493b..9ae980bef63 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -880,8 +880,10 @@ static bool trans_VMOV_64_sp(DisasContext *s, arg_VMOV_64_sp *a)
         /* gpreg to fpreg */
         tmp = load_reg(s, a->rt);
         neon_store_reg32(tmp, a->vm);
+        tcg_temp_free_i32(tmp);
         tmp = load_reg(s, a->rt2);
         neon_store_reg32(tmp, a->vm + 1);
+        tcg_temp_free_i32(tmp);
     }
 
     return true;
-- 
2.20.1


