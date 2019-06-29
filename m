Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF1FC4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E1821773
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTRYFKYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E1821773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhD37-0001Oo-IV
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41138)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy8-0007ym-N7
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy7-0003ab-Fh
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:40 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy7-0003U9-5x
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:39 -0400
Received: by mail-wm1-x344.google.com with SMTP id g135so11587404wme.4
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2RzVzva0p3si7jPLhYz0L/MLVU9X0nppYnW+PugeGaM=;
 b=rTRYFKYcwuMfp84HPxxQyNe21scS6/5KdmDE3KHdxZ+YieNNv5m/bGhQTDDri9ieBE
 gMOT5irZe/hI/Zk4BPEj5cZ8WBCUilHiyWP3k2AIth0vJo9NGUg0B69TdFrkw35a+BTS
 b/8LoxAKx9uuF0VuqnQVzdRXvmnvfvzIaWPiEEVKmxHyvUhY07xmHHI9Kq89qLdPT7lF
 j4VEWzHxe8sYxsFquPW0vUW+9xZXNHUyLpphmxsvAljDkpFKKx+DrE7vNUPismGRJPoA
 d5OAoRgHp7CmPaSzaoA4y4+RMqhIGhOZA1y+a33mkcif9yBS87pnB1KmRmdw7w1ybyHl
 puuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2RzVzva0p3si7jPLhYz0L/MLVU9X0nppYnW+PugeGaM=;
 b=n0oipX74PQCtQ2+R4tj2pEvQRpGIqRq9+ynZM2N1U9huuG5MTc2qed+Ly+Rf3eHOZJ
 sbC/aWtxqIIwA+TnSSikIIpGl986iUCKvizXM+m8nahbJRTQyyFfqRGBPhgju4CabIGr
 HxdxSAWM31MIgCMcndwZ5dhucTOyGkhA/CiLGNmGGxb48P5fYE/VApP2mL5y2kjls7v0
 2Z2/uVWCocdVd1AYdBjhE/HlTidlt2KNuiVR/JvXAaDkfEMpYFMvugAcrFLtrYRCguA8
 hE/WCB0DF096QGjY3d8lsOWjBGKHwLHvyOJBqZR0xCHH4EOGHJkDdnAUuy/RcXAf5ZBn
 ZIew==
X-Gm-Message-State: APjAAAUVGztUQA7TJ2xTFLy5ZxaNYfR34SLebrOUhLUytkuBl0Q6B59Z
 EcuNK/STlhgli41gg40WO2XtIY5xN4T9Pg==
X-Google-Smtp-Source: APXvYqz50brG4C71dmclU62EqBJSGoKn7i9ovwD9wEHrNsbPX5siy0OoMRKz2pWK+LGTDuXzPjT/3g==
X-Received: by 2002:a1c:7ec7:: with SMTP id z190mr10464702wmc.17.1561813232210; 
 Sat, 29 Jun 2019 06:00:32 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:14 +0200
Message-Id: <20190629130017.2973-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v6 13/16] tcg/ppc: Enable Altivec detection
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we have implemented the required tcg operations,
we can enable detection of host vector support.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 9a44670180..c6defd4df7 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -3513,7 +3513,7 @@ static void tcg_target_init(TCGContext *s)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
 
-    if (hwcap & /* PPC_FEATURE_HAS_ALTIVEC -- NOT YET */ 0) {
+    if (hwcap & PPC_FEATURE_HAS_ALTIVEC) {
         have_isa_altivec = true;
     }
     if (hwcap & PPC_FEATURE_ARCH_2_06) {
-- 
2.17.1


