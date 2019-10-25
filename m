Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F1FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:07:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7111321929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcfxAIOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7111321929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtgy-0001K0-Mu
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE7-0003Sg-U2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE6-0008UN-VS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:33267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtE6-0008T0-PU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 6so3526588wmf.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yxnUmUrN/VmnORaacGEvXlk29KbZqX8IayMFp0qzT/w=;
 b=rcfxAIOD7fXlD4hqTjItQZG2EDF/kUjb+IH1qqUwW66D+X08EM0+jm1vJBcOXRNxA6
 PGCT0Nx9u+xeWWumHg0nzqL9r+gLMuYZtp1Up8uxFQhM6oigR6ZzMOPVKyZIwZwWYdf5
 fWPbSvu87ge0xfl2uIg+pGYVsYJKGeG8q939hHndRPAwJRn25LGDfP8Kkd5vWcPZLHJo
 c04Z5l+J5NMLHwKn5DZQmNQmm1B5yqDSbgbqG3nLwEveqBVgVDIRMO9G2PurLq6aBYFm
 g/PWJRRzyOgHOxNur2noYzc0+uZkHUVQCGb3oAmX3/Pgod7W3bKH2QZskbvv1lOCyobe
 6OhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yxnUmUrN/VmnORaacGEvXlk29KbZqX8IayMFp0qzT/w=;
 b=uR05BCWgZFelvW1XumywHB53dxadbDB5XV3jPCFsUGoPjuX1zMpfH/3HPlmlM0/CfF
 HXwraX5xjYT2HwoEhrrAEUa6wmC3vUn1wJcQOke73/NYGv2xlUImg7eweAU4LBevSl/c
 vJSSRAuU7IEeJgy/TZL3TE+Zlsscv2WR01fpG0EcSgkiFz5/MQfgLDYXwt96fji1n6yh
 QsfVEq6Qm17ZeBUBwKCOZZXwHiaTY2Xa5bcdXqOr2FkpayNR98jqTbvlms0h74nX73Td
 aqClLFhoGX8m/daT3bDYEdbTPfxLJKWH2vFP7dYEB1rIdL5SQT6TaVEDd9KoILRPwA7w
 1OFQ==
X-Gm-Message-State: APjAAAW7Ynx1hSC0X8kjCYIAZL7hfJi/jNBvVsNcGbctdX2xAR1ChTwA
 VGjAuTCXihobdWBKVN/pQbtuTw==
X-Google-Smtp-Source: APXvYqxsxlr3p06MvJIs2wYCbRbCY+R2auWsESflRXTyuy+SCq58XA3a8LoJ9K9J4IEjgo8Pqq+hrw==
X-Received: by 2002:a1c:f718:: with SMTP id v24mr1775983wmh.82.1571985452738; 
 Thu, 24 Oct 2019 23:37:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a17sm1408799wrx.84.2019.10.24.23.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 710871FFE0;
 Fri, 25 Oct 2019 07:37:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 72/73] MAINTAINERS: add me for the TCG plugins code
Date: Fri, 25 Oct 2019 07:37:12 +0100
Message-Id: <20191025063713.23374-73-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index ed41d7d1b6c..ade2187eae4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2328,6 +2328,12 @@ M: Richard Henderson <rth@twiddle.net>
 S: Maintained
 F: tcg/
 
+TCG Plugins
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
+F: plugins/
+F: tests/plugin
+
 AArch64 TCG target
 M: Claudio Fontana <claudio.fontana@huawei.com>
 M: Claudio Fontana <claudio.fontana@gmail.com>
-- 
2.20.1


