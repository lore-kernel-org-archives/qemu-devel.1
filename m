Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C75AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BD520828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfPjHZ23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BD520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2wmv-000360-5D
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wkj-0001TK-Nr
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wkh-00041Y-AL
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:08:41 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:45082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2wkh-00041F-4i
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:08:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id q12so2218461wrj.12
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 05:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6n64Nbm4zcHPeK1V9SaqlIE5G/HdcRAqWB9Q6ja2DLc=;
 b=sfPjHZ23PpTwGtyfufPZ20PCqhIS+jJkxVG8w9KOGrlcuB4IxLrDZAwoJN7yPAe+Dn
 Rax0FQqZqUkxw1YKY4OCeRT70g1Of6wy612Nm3OXCMmFSko2hFDoY7YYHNgyfSZKaxBn
 SKZBD+RXMHvTgQzP8r2pFhKczOXt8wf91fC7R8WY5wDKycM4jEhm7CKSTCPDZfE5C3j4
 P8RCtHCcbW4yvUwrNXJI5Ssoay7GcKzkMv7bcHHFGjisQ2Yk/kLpdW4/dz2lWkTruPQS
 oeDw+o9O0voc95A91SzAfp0TZ4fCxIACWZzU5bnjkio6dHKVFNrMtOrh9L6aDoG7B0+q
 C3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6n64Nbm4zcHPeK1V9SaqlIE5G/HdcRAqWB9Q6ja2DLc=;
 b=rlEza9NfPueFx4FBeP3CAVzXYUKjZUxknODCkvoNEjPAlhiHUQ53nF1jvkpAEcgxbz
 gZwA/EqFFo58B4NMNzDSfn4CRXqDBpakQMYFthabL2g/1wuy07w4H13Dv4QsYGQymMK4
 xz4crwj3CHrxNFpbExfuBd6PUk0WNUdnCkSoZX9jX554MF48BXz0et0q+IDtpE4YMVNQ
 v8Ytm1XVP3O0/KCFT53B+RIM1CRvaN+4cAx2Ader/BVXcV1emjJYaTMMwhuKu/6QNZdL
 c6BcLHISd72E28HNwjMuq+Nhh1/YV15YJ0GOUMEXL/JGQ8hmoFZEu7NDVUE3b1L8Cs53
 fWSQ==
X-Gm-Message-State: APjAAAWXpSZFBlRnD+eNFvhkSJ+tqjiMbdVvGJpJOPoChD6kB/WLBDse
 OtWalswkoALrFvPq9LC2tM0naw==
X-Google-Smtp-Source: APXvYqxfyj7/69We00WanrekkzgH187GIZJYvSjPRaMwB+vAQYD0n8Vqb6var4k1UVGggI5cgaOvUg==
X-Received: by 2002:adf:fc8d:: with SMTP id g13mr4096648wrr.234.1566994118072; 
 Wed, 28 Aug 2019 05:08:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e6sm2179061wrr.14.2019.08.28.05.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 05:08:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 194601FF96;
 Wed, 28 Aug 2019 13:08:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 13:08:31 +0100
Message-Id: <20190828120832.9208-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828120832.9208-1-alex.bennee@linaro.org>
References: <20190828120832.9208-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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


