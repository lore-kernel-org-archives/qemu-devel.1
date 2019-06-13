Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22010C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E3A21721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUC/NR/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E3A21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43784 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUn5-0002QB-4N
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53848)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlK-00049x-PM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlG-0003OS-IX
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbSlG-0002Nk-0M
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id f9so21465419wre.12
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rimcTwT3jseYgOecETEoK3gV+MP4oaaAWnNA90CS1sc=;
 b=WUC/NR/reoeIEelJq/6TVn2rSH/Q5u9ChWO0s5e5z2VaAs/2A6a5/RRqKidEVi6T8J
 EeG6g1KJ3Ynlg5Cms0UYtrCGGGMty1ukQmn9FxJW6qv+RJ5vD1xcNLMPmdrHMYNjwloG
 e9wO83nv4MVf45s3I6/kEt8WTSY1kCjuuYWRNtn1qjUlRujjhE3Vdk0AVRwiuDQqC9gU
 kz8CWoLZdOY4Je9mwOORyOViqWL4xuGhLqoU5zXu2p51MJ84KWzY86jVieZJhliATfCx
 ZdpKJaue3OMzZ1X0eHS+8UAD8La9ESQQKAP5HbYtIuKrosQrkCbWEsOl7qZGgLDroTg7
 XeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rimcTwT3jseYgOecETEoK3gV+MP4oaaAWnNA90CS1sc=;
 b=A+qcaLeNkRE6uXU0OPrxh49TtSrXkF69GndC9JA5qKI4V7Yt2lmEM+ySN9ZzAgy604
 Ye00uEYfTdDK0MfzAZeqOQHUb1XkmPdBsji9Iw31bFnEMSd1Tnqk4yZdKxrJ5rvQbBZc
 FtGcZY5ZAngNPVDIM83s+TJgzR47pj3N/XStTc0ew+6l0kbiJZS3tfl06EpReW3Px3wE
 wfj5aXMkBAHCuR6JjR5BCK0cK/PaeGNCFlogVpkTlqW+W3KEPaTJ+T1sd3jvId+8sj5g
 FQNTPYPhghP5mIpwWkYtoC5IgnKdkthENJ/6eOwVbl48smhSHiN2kOiDyyLZ1Wl/ZRkg
 HmJQ==
X-Gm-Message-State: APjAAAUUnoaCE515yOKfCWoMxoIjWyHuQHgjbwywbxlLjAIEiQ3H+EXK
 xA/K4Ly8hxyoOUe/vdXyfLcg/g==
X-Google-Smtp-Source: APXvYqxtdgJyxLVeVzRUIfr+SqBYq0C2qNduSAdG/izCG59yDPc2rp3Wkia+Bo0dYNKPbLshAZkIJg==
X-Received: by 2002:adf:e9c3:: with SMTP id l3mr37413931wrn.148.1560443965631; 
 Thu, 13 Jun 2019 09:39:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f197sm358747wme.39.2019.06.13.09.39.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 09:39:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:39:11 +0100
Message-Id: <20190613163917.28589-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613163917.28589-1-peter.maydell@linaro.org>
References: <20190613163917.28589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 06/12] target/arm: Stop using cpu_F0s for
 NEON_2RM_VCVT[ANPM][US]
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

Stop using cpu_F0s for the NEON_2RM_VCVT[ANPM][US] ops.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 243dbee8357..124045a9ef6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4181,8 +4181,7 @@ static int neon_2rm_is_float_op(int op)
      * what we are asking here is "does the code for this case in
      * the Neon for-each-pass loop use cpu_F0s?".
      */
-    return ((op >= NEON_2RM_VCVTAU && op <= NEON_2RM_VCVTMS) ||
-            op >= NEON_2RM_VRECPE_F);
+    return op >= NEON_2RM_VRECPE_F;
 }
 
 static bool neon_2rm_is_v8_op(int op)
@@ -6818,10 +6817,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                                       cpu_env);
 
                             if (is_signed) {
-                                gen_helper_vfp_tosls(cpu_F0s, cpu_F0s,
+                                gen_helper_vfp_tosls(tmp, tmp,
                                                      tcg_shift, fpst);
                             } else {
-                                gen_helper_vfp_touls(cpu_F0s, cpu_F0s,
+                                gen_helper_vfp_touls(tmp, tmp,
                                                      tcg_shift, fpst);
                             }
 
-- 
2.20.1


