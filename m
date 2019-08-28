Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D80C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF1320856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JsQihLIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF1320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2wrv-0006su-6I
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wlW-0002Ly-HR
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wlV-0004F6-DY
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:30 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2wlV-0004EX-84
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:09:29 -0400
Received: by mail-wr1-x436.google.com with SMTP id e16so2249797wro.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 05:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6n64Nbm4zcHPeK1V9SaqlIE5G/HdcRAqWB9Q6ja2DLc=;
 b=JsQihLIQN4xkP6edNT7ZHfjPd9CY4pkNo0cSSn8SI5qscreN4SfGPhS3j80+ay+0Jj
 iMrE5ri8Y0OEHX8L6QpI4z9N+NeKgYPQG57KqX8N8qA6GD/zvxkMfWqn+Pih96uCwD87
 rx3la33gEPhRBL/4CV1Z9JPGIJ0rdWd+SGHX05v+2nY2rR6gyF3UtaOu9j0NfmPTOT4k
 e19HV+uHn1LEI7bGhRPt1z01Pw+AW2HJaB8hTJWK5EF7RuI3guKmfJIZhGxf8Mu21OR6
 R7fI7c8o8wSt+u/ZSI4iu3u5Q2ouAKkehqpheNpiSOpO8gvXO6q+Iik9jjZAsP7xn3pj
 p0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6n64Nbm4zcHPeK1V9SaqlIE5G/HdcRAqWB9Q6ja2DLc=;
 b=b2rll+I4Ufy0zeCa4a1HX2oc8YckvQHrovJnzzCfXFlVSSs9JuejG/M9SvWQ3qtnde
 hrvv/Ls+spKgUaJbS6SIc3yXmoVVA6yeQs7fN4Q9tMq5Xcs+7Fv9OExICk5JyBHM4tqN
 ouHzTo4aLvd8TWGD8jtnxOcvfyZ3wEBLS9GQmUc32B2nTCs51PFPbpxm1buSWxPPRMpk
 M2T9VRIQZ1BZD2finptmZmGyk/zM3Wk21EjHpQqKcGw7Fl3bMwmLcdDbL5Cp3VMZReAQ
 a9Lk4cuDwbDyq7s+QkSe9gX55DEltH9KVAZ/u1vXjmbQPzz4dWzxwEDOQ4wJc0WIGmyu
 btcw==
X-Gm-Message-State: APjAAAWz6PlbX++3LsIDKBHewmGXDOrBwMbDH6kVKV6RQ7bRhTJ8aHKc
 J/IYT8Hs9LPOIkF9R6/pHUbicA==
X-Google-Smtp-Source: APXvYqzCnNG/OjDipz/wLmqfx+SZ8SIhRDwe6An3BWVIr/+49eq1hNLjRi+YBz2Md+QNIv+lUiX9rQ==
X-Received: by 2002:adf:eb8c:: with SMTP id t12mr3109756wrn.84.1566994168128; 
 Wed, 28 Aug 2019 05:09:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e6sm2411141wrw.35.2019.08.28.05.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 05:09:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 77C251FF96;
 Wed, 28 Aug 2019 13:09:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 13:09:20 +0100
Message-Id: <20190828120921.9586-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828120921.9586-1-alex.bennee@linaro.org>
References: <20190828120921.9586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PATCH v1 7/8] contrib/gitdm: add RT-RK to domain-map
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
Cc: Stefan Brankovic <stefan.brankovic@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I added this because Mateja is showing up in the top 10 stats for the
last year. I have noticed a bunch of the Wavecomp guys have been
sending messages from RT-RK but I'm assuming they are different
entities.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Cc: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index fa9d454473d..abee7e334b4 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -18,6 +18,7 @@ nokia.com       Nokia
 oracle.com      Oracle
 proxmox.com     Proxmox
 redhat.com      Red Hat
+rt-rk.com       RT RK
 siemens.com     Siemens
 sifive.com      SiFive
 suse.de         SUSE
-- 
2.20.1


