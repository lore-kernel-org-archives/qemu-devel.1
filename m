Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94821C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67ED8218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTQ12VGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67ED8218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Qi-0002fT-5v
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57491)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mo-0002Yi-3y
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mm-0007p5-Vw
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:53 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Mm-0007Vn-Qh
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:52 -0400
Received: by mail-pg1-x543.google.com with SMTP id f20so15877252pgj.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Za01uaUS+E1JffTVMwXCPiCzGTAwavbcztjEMPVjIIo=;
 b=HTQ12VGSu11D/hpOGCcoiE8mxbiVZ3ioQ3SLZdSbQEZH39gCfmq0Mh5LPP8IieKPXp
 0isbaob2Qo4YwKI6fZVEtrdoD8ztCbcZGEtg8pMg/d4o18VvoF8xfao3HEFjMbdVYf9Q
 mfy4XWlk/VlSJQbiP1T8QlHLUbK/1k5ORD96UxIbYWkz9qg6PnvZ89eFsHrBSwzSLmFg
 g3xkzZf86Ctk+l9grsBxtF4joI1GtQ2uqIOUrOVYdrbtgh4Ud1hhsGvZ0ABp3OOCuPuG
 hazMVjv5wzqDF+g6/aPVeebrWcoJLlw5BdXdigpaO07muKqZG7XRnfc0Pfv9OJwQ8u7k
 fHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Za01uaUS+E1JffTVMwXCPiCzGTAwavbcztjEMPVjIIo=;
 b=T9/Jmf7tc6MOiXe0bjFx+Rt/f8ALuLZjwS1rNNegojUwqj1X2Pjz+RrOBbPosb5Wpp
 xBSfx50Iy/fIuS3eUsQvf3n6hBtfYTejebmfJ3yPz4dCf/DaUpyYRD0aGP6OMgOkLz9p
 +Uvt8FYk3oaDDKTBwLZFZKyvjlwUcBgY5sLbzS8YrXJ2COHnnivAIs0USES1ZtnKyUC1
 ZAma92Oa9OrRU29aAtKIH8RyNO3WwRnnlLuVMZ0a8OtpvhgRGuQwh3ykiTlL5v+fv5QG
 Fb6Ya8MHQ9KTnusNrrxkAtnZp9SlGzxYp4dWrgbyAammXc1e5uPAMLot66LNs0Ja7vEF
 LqEg==
X-Gm-Message-State: APjAAAWHBOtBKnPAFixVH0g/hiwn5eevBFvYd/RkoqmeTFlEYCox0r3o
 eMt12sRv00hau6LSb0Bpw9Sqc+9S4yQ=
X-Google-Smtp-Source: APXvYqwBWcHYIwS/IdbUWVqFtATsgzmUsVfYjdZWMUAXDkCDDdDlgl6R6/jLMKRS8nmuubRpdnRF6A==
X-Received: by 2002:a63:b904:: with SMTP id z4mr90747529pge.388.1564163444774; 
 Fri, 26 Jul 2019 10:50:44 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:34 -0700
Message-Id: <20190726175032.6769-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 09/67] target/arm: Fold a pc load into load_reg
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e316eeb312..53c46fcdc4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9161,11 +9161,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                             }
                         } else {
                             /* store */
-                            if (i == 15) {
-                                /* special case: r15 = PC + 8 */
-                                tmp = tcg_temp_new_i32();
-                                tcg_gen_movi_i32(tmp, s->pc_read);
-                            } else if (user) {
+                            if (user && i != 15) {
                                 tmp = tcg_temp_new_i32();
                                 tmp2 = tcg_const_i32(i);
                                 gen_helper_get_user_reg(tmp, cpu_env, tmp2);
-- 
2.17.1


