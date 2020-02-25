Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D353CC35DF0
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC0B24650
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Msg+2ZlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC0B24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Qhd-0004xv-Rv
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 22:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qfw-0002yZ-Fq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qfv-0005NP-JJ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:24 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:55326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6Qfv-0005Mm-Dg
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:23 -0500
Received: by mail-pj1-x1042.google.com with SMTP id d5so628354pjz.5
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 19:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oi7EF/ZZDkkxyzeBMO90cI5DXKAzhVbrdZpsDYTxfKg=;
 b=Msg+2ZlYfJZwBjEgd96JTAJxLDFY5epMzcgYf5k97yRLi9+WiX8dRiggeU/kcLwmE5
 XFRIvxjmLCU9Izv0CBs7ZbTSPfI0oXqEpJrbB+B1u6qtzu9yDO2ngmGIsx7pzCowpbJx
 eSGp843R6RUQ0kW2kA7AB3S1uSu4FTg2rt5ZZxkfxMJsdcOTa6MLPLh4vm9ausfmjP3p
 Otb/NN375+Bo8s2UDsG7bXiq9YUooiITR9Yj4QlDMOlK4zuTRx8RrDUzLAqYwiUo6kLy
 x/m/2I4qD1KpgnlNsmIDsLWLIrqXgLb63VNC/2Rtxrs8Gji5g0Wo1fFfDGxRatJYVzqe
 lzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oi7EF/ZZDkkxyzeBMO90cI5DXKAzhVbrdZpsDYTxfKg=;
 b=H16EMveP88DwvCDKlDrYggRtnWz9XsCRv5pq7xSEbgkqpBJQFtf/wZvSZGv3MELeY3
 w9+PndXzvPg26RKUQf5Ux6LGKVOFWNrASnj9dom8rqC8OjFlQr0PK850v/M4WEtRNOyg
 4KKtPQ94OOY6aBRJTfdaCQN1gagjb+IC3BdfMLhUSBO3JBhf4LB+zIq2anlHTeYIn/fp
 hpd5ZyvRDXRcYzYcn47D4xLD9w4PcKD/iccsQmjp7kA/ZKIf6wTktBZBHh8/qwXkYevo
 V7fwxZSq12fzeJC2p8zQ+5kyUzn82QRR5d1nZiyEqJniigiWVVSXAQjIuQJ6Ax/DlYxx
 oMZw==
X-Gm-Message-State: APjAAAVXg6HTeQtY4M/srjLxDcPVVmuo9Te4zfX1gcsQyTk39ruM0AUQ
 cDT38/JeBU+VTFAUf25rNRjrzla5yA0=
X-Google-Smtp-Source: APXvYqxSyQSvj5IHQYi5W6GBqa0MvffO8UAJufdNLhMvsnTfp68mFN2K9X5FolwEvZ+bXvOyRope/Q==
X-Received: by 2002:a17:902:b212:: with SMTP id
 t18mr51805731plr.135.1582600461555; 
 Mon, 24 Feb 2020 19:14:21 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id q66sm14975242pfq.27.2020.02.24.19.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 19:14:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] target/arm: Clean address for DC ZVA
Date: Mon, 24 Feb 2020 19:14:12 -0800
Message-Id: <20200225031414.15649-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225031414.15649-1-richard.henderson@linaro.org>
References: <20200225031222.15434-1-richard.henderson@linaro.org>
 <20200225031414.15649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This data access was forgotten when we added support for cleaning
addresses of TBI information.

Fixes: 3a471103ac1823ba
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 596bf4cf73..24c1fbd262 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1784,7 +1784,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         return;
     case ARM_CP_DC_ZVA:
         /* Writes clear the aligned block of memory which rt points into. */
-        tcg_rt = cpu_reg(s, rt);
+        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt));
         gen_helper_dc_zva(cpu_env, tcg_rt);
         return;
     default:
-- 
2.20.1


