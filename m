Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CA0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9DB20737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFsnxyyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9DB20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRn1-0008OS-6G
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjW-0003KN-RV
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjV-0002Ig-TK
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjV-0002Ft-Lm
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id e9so8904731wme.4
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g9xr3EL2jz3uIXqebGO8vaQXLJoFQmUrqrOGsA7SE/w=;
 b=GFsnxyynZgCjj4EsqktcZg00qrQza5SzQnhyq35gTpDDp9JcA/qzzP/vF18KaaWtMz
 BawuEpgGWs3FpP9bqoFqrwV+8LbHvhXEoVLAMBmmTNQbPajmknXUrZKkqW1jTw71KhuO
 dye6UMd7V68jHP9snRtylzp8TqtUU5z4cBt3ZavcrWnEC6+XSviEwyF38TmWJv18BrDp
 +S3Oa0YaGTtzutFl3RhiBqQ+AY6kpDLJP8vT1O5BpDK9L1CNWQvJhF5SxgRaeH7L/ac0
 kDs9yH5ZH8ceh9eGCQTGZVB4p629NbOFWbNPe8xuUbfRFo8xtl6wVPZI1v06XsW+rnKS
 f5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g9xr3EL2jz3uIXqebGO8vaQXLJoFQmUrqrOGsA7SE/w=;
 b=XRxk0tygvnh6yB0Xrp1J2A5fNne+UbBWygnwttw+HdH4986biaY4FQ0uVSR5HFeR1x
 Av97vrL9gI69e7BBJ+qAGM5FyHp9J2Ne5LD3Txk8GsfYTiQpoWpnYmo2pPYARfkB4Qsh
 OOzPU8hQ6wgcUxTa8lHtjFIFuWDENwa++WTm4OLPTNYZj29vr0+qJtVto0diLw//cA+0
 0R6+Qzm70rzqRJqNBsTNSLF+FrFkxZZTF/nCdAHgE2xk2KlXQlJ76wfo2YjKUcqvlzOV
 J1/Y0xruf2k8NVr24MkNb2u7mQLelRJQZRuPYvEbIu0oQqCm8hg5aGHfKJFTYGqwbmHr
 ehCA==
X-Gm-Message-State: AGi0PuZUjzyTD4N/DKrjzLxNlCYzKeiSu8TV8973yViJSZYRlDAqJEW+
 pvY/56dyCp6h/CMc81cqbZcm6Q==
X-Google-Smtp-Source: APiQypKiOgdyxzQsVnNUPGRwNgRvvmGJrMuX2lCCwpBvEqGG5rvMQTFc6+q+N2B4MlCxWKfl0TekVA==
X-Received: by 2002:a1c:4e11:: with SMTP id g17mr10422549wmh.80.1585941120598; 
 Fri, 03 Apr 2020 12:12:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm598120wrn.27.2020.04.03.12.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4886D1FF93;
 Fri,  3 Apr 2020 20:11:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/12] softfloat: Fix BAD_SHIFT from
 normalizeFloatx80Subnormal
Date: Fri,  3 Apr 2020 20:11:45 +0100
Message-Id: <20200403191150.863-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

All other calls to normalize*Subnormal detect zero input before
the call -- this is the only outlier.  This case can happen with
+0.0 + +0.0 = +0.0 or -0.0 + -0.0 = -0.0, so return a zero of
the correct sign.

Reported-by: Coverity (CID 1421991)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200327232042.10008-1-richard.henderson@linaro.org>
---
 fpu/softfloat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 301ce3b537b..ae6ba718540 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5856,6 +5856,9 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
         zSig1 = 0;
         zSig0 = aSig + bSig;
         if ( aExp == 0 ) {
+            if (zSig0 == 0) {
+                return packFloatx80(zSign, 0, 0);
+            }
             normalizeFloatx80Subnormal( zSig0, &zExp, &zSig0 );
             goto roundAndPack;
         }
-- 
2.20.1


