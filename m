Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED645C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC957218A4
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTf84enz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC957218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4U0-0003j9-0w
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44219)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4He-00084J-6X
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4Hb-0002JO-VZ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:29 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj4HU-0002AT-99
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:22 -0400
Received: by mail-wr1-x433.google.com with SMTP id p11so1674609wro.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Fw40v64gwndWG5ZTpcv6OGPGniw0mg+4+kLx37gJbPc=;
 b=dTf84enzxEGbbHLJlNjJx0ux0knDfC7GnEcWwI9MObcb/+zOtSF3K0hqeZpPy8pUOP
 MBNTjKxUpjzeCYA/vnK7z5R4ngqL9jpLEefbSxRqbWU9fcOtG1XN+ZCayspheymYLxk2
 8jix/7o1bDY0XUdM2x7A8oHwnmvVC31SP8to4+PnHpZKyOhMYr8tba04//FBsqzaKmX7
 mPYAADmyw4HlNNENTyk5fDKzyE7rED7nolQApYwEPHtCVFvQyfGnXZ7RXZleOsiTS1o9
 reGqZZ+7cT+sMT1eMA+4sXxf9+/wqr/xb3Ce7mwXpIp5owlRDQYezqqsc3S/7I9frr4a
 VVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fw40v64gwndWG5ZTpcv6OGPGniw0mg+4+kLx37gJbPc=;
 b=WxsissNXbsvTUNFGTU5dm6UnCtP/EfMp8LRY+FKWUNh8C08c1/+mzdT1JV4WsxunuA
 GGcGnizHSWsduhBPtNMOqVgkeHp4Csv99pTWhAAQoihAsrTETyb4Q620R0HVz3TIOJ2H
 dtE/GWacpWHoxn4TsN96oLf3zBCeIfexzx8AONeRxA4aGE/GX4SklLvJ8RfiKn8swq/W
 1KSOxYtj95k2GfTdxF8+LnfiNjOLW9Eeh3dMq36l5Q4S/2aiTnEn0iteq4QsgH3PNyQP
 pt/jOSY/ulaoPf7a74tzTe8ACjytvgPey7IXoNinV7+bTbfW/ZIFMcYP7FvaJyeTHwGY
 vR7A==
X-Gm-Message-State: APjAAAW/1QptnS9qKYfd8hdFNUOjj7OpahDS4R0WqDNBCDwRkQqXDR/o
 ooCw7LDjcbZCMmqv3lSskGy3/IjC5Gwi9Q==
X-Google-Smtp-Source: APXvYqzPwNfZzzg/bCwrawXMW/8qx7DknDMEQaGe5JK/lJFoUAQwRMQwko71w9tBERnxnJ0NTgbEMQ==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr33618128wrv.347.1562256497574; 
 Thu, 04 Jul 2019 09:08:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s2sm3849690wmj.33.2019.07.04.09.08.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 09:08:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 17:08:02 +0100
Message-Id: <20190704160802.12419-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704160802.12419-1-peter.maydell@linaro.org>
References: <20190704160802.12419-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 9/9] target/arm: Correct VMOV_imm_dp handling of
 short vectors
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

Coverity points out (CID 1402195) that the loop in trans_VMOV_imm_dp()
that iterates over the destination registers in a short-vector VMOV
accidentally throws away the returned updated register number
from vfp_advance_dreg(). Add the missing assignment. (We got this
correct in trans_VMOV_imm_sp().)

Fixes: 18cf951af9a27ae573a
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190702105115.9465-1-peter.maydell@linaro.org
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


