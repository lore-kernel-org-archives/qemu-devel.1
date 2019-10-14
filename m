Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC789C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2022083B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mfzlu0GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2022083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0z7-0008GP-6f
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sS-0002VD-Tz
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sR-0007DQ-Kq
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK0sR-0007Co-Eh
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id r3so19884239wrj.6
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jUAlfFUMJneaz1vxlicFE0rqbhGzRN+iFBHQ7w5EtL0=;
 b=Mfzlu0GSv0OgYPUWKtrkBPJV3xoB8EUmfbH3jUZ2GIbiAydIG0795zKXpZWWUXx5lF
 ExlhczxYRAU4l/FJaQTSxiBxWPK/U9LO4j56ODNtV2KTd1RS8TzYXcH4xs3Cv1RdLmht
 sYbrTdtmx/Y3dbR5OgHexsvNS4pIq8up339f6QCmAMFAkwmel8jA/KSvvwBIHmS5UmD1
 5H1nGPSGJ7M19xZZB7oJ9IH8gJwo/V1iT66iPE2zB/4mpj8SwpthGC9Pq99ImRQ41ls4
 /HbLN9YQ9v17Sa3+ab42gan2C5jbD90Pn9WzfPzAT/Vl7C305pQjlVWmY8z+HKO8/rdb
 kQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jUAlfFUMJneaz1vxlicFE0rqbhGzRN+iFBHQ7w5EtL0=;
 b=EktJ8si6QaDg+hfftQyoS+Ru/INp5kehSweDyTXbjgI1QqLKYxre00i1x8BzbZc0tv
 bv2hm3pVirj9zMImqlKN+y+BRCirNogsEOH9nz9xC75mTZl23/4aAIMFZwaPiXuGBXlc
 gC25AwQcQvuKIt9izYJUUPu6km8uJaOylCZo8EqnO/tNJXIsYfNhycFdiEAGYnz/F3LW
 srvUpp+D5YnObTH1tyKB1DnYdgboVVdV1+XgwGqrYD5X3qHho1dy3CHP5cmYxkPXSln6
 ex9ceDBLg03lo4/7EplWDNc/JT0dtzwWeA7K29LGnImKEcogFoLuG6rQIxwzAIqEWBSB
 Eifw==
X-Gm-Message-State: APjAAAXEunryNYDLWaFmESYF082kaAIjHCYkorjhJomNvjrMH1+osT7I
 QB7kJZOywEsj+NmnYtxWCPgSFw==
X-Google-Smtp-Source: APXvYqy+pYaCTehGf1/VbOKGfjSkJlFQM76wypslFVFQrFvg9NFIfX+cIVispERPsyv025OUtS6jDw==
X-Received: by 2002:a5d:6608:: with SMTP id n8mr17393993wru.92.1571061550214; 
 Mon, 14 Oct 2019 06:59:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p5sm24862755wmi.4.2019.10.14.06.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 06:59:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A0DEC1FF92;
 Mon, 14 Oct 2019 14:59:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 5/5] contrib/gitdm: add China Mobile to the domain map
Date: Mon, 14 Oct 2019 14:59:05 +0100
Message-Id: <20191014135905.24364-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014135905.24364-1-alex.bennee@linaro.org>
References: <20191014135905.24364-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We've had a number of contributions from this domain. I think they are
from the company rather than customers using the email address but
it's hard for me to tell. Please confirm.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 304e91010a..7fc7fda68f 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -5,6 +5,7 @@
 #
 
 amd.com         AMD
+cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 greensocs.com   GreenSocs
 fujitsu.com     Fujitsu
-- 
2.20.1


