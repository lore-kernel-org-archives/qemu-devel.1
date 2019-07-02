Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A520FC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A5A21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGibDmxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A5A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGoU-0001Os-L8
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiGNj-0000op-3R
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiGNf-00057t-0M
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:51:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiGNd-00050p-J3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:51:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id u8so475524wmm.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YeHRPGYbA8ZhQrAnDrwK7ooN6IkOvQIyHvP1gjf9j24=;
 b=XGibDmxUDYjPiY8630ypUeh1Crjc7UzuBDzvEKoKarSVnT3IAtcUkUHxSd9Od+mgtB
 pgFAJTfbO5ZkErOkyp8CBKFk9FTjYVUSh//kvs1yfqH6Wa4X/plg2xI+s7TzC6AKtbKB
 0+wn/h81QKma2XTRKwbHrKknQ6y2d+qnvGim+wwVKUp5NsjB0dX0ps6f1dkR24f2ypw/
 +GB1N/2Xxf0xOZkonrgOxya4ZkInOULEq7hPQmmcg/rNd4WxZ++AQek1ygJqe16hdXeU
 Xu33olZV2/h84RQUz9oapdyWnbwcbMge+7OZcimc4IsOBYl5yOlVC7uSEufq/hmGonrC
 Ie0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YeHRPGYbA8ZhQrAnDrwK7ooN6IkOvQIyHvP1gjf9j24=;
 b=UQCP2PzSqhcg4tDHZX0zLITC74WCxqkCcPU8yMLmXzEGkU1QekcJqs7HfaOa5YLDN2
 6AL8fMzLvPdTkm27aX0vs+nBkaoON3c7rP0XartCMOv7qakM+IE3Hk+s6oYUOQGBb+D+
 0/+D26djuq9fYo00qVlu0IKty3WjxpuOc2DdN1wZ5cz4VYGFDX4m9VNxW4QwzcYxUnyJ
 JKBj2umBF55nUf9hCiOzCiJM4Ywc/qeXPUf0uJsPz7oKEbBvNH0+2PvvNMfNtsGFf5JH
 Pl3EggNZd/9LSAUxR11CP3m48QpwLkMmZ0h7TB/0liUF9sPiALYjdWmojY4vabPR3rS5
 AtLg==
X-Gm-Message-State: APjAAAUWrTLtakUichyz5LyTHRQs1I65WUPwqaV6qe8HlwhcfpAZBk+a
 kk1cul8pel/deiKCCt7QIwUvzg==
X-Google-Smtp-Source: APXvYqzpZ4Avo86PZIZjJLNygWa0F8atpP1UqT+Y3Ok2r5mWSpOQDIOL4sbSgtX8P2tJFFZfGF63fg==
X-Received: by 2002:a1c:dc45:: with SMTP id t66mr3193545wmg.63.1562064677072; 
 Tue, 02 Jul 2019 03:51:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y133sm3219710wmg.5.2019.07.02.03.51.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 03:51:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 11:51:15 +0100
Message-Id: <20190702105115.9465-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH for-4.1] target/arm: Correct VMOV_imm_dp
 handling of short vectors
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity points out (CID 1402195) that the loop in trans_VMOV_imm_dp()
that iterates over the destination registers in a short-vector VMOV
accidentally throws away the returned updated register number
from vfp_advance_dreg(). Add the missing assignment. (We got this
correct in trans_VMOV_imm_sp().)

Fixes: 18cf951af9a27ae573a
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index deaddb04421..092eb5ec53d 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1971,7 +1971,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
 
         /* Set up the operands for the next iteration */
         veclen--;
-        vfp_advance_dreg(vd, delta_d);
+        vd = vfp_advance_dreg(vd, delta_d);
     }
 
     tcg_temp_free_i64(fd);
-- 
2.20.1


