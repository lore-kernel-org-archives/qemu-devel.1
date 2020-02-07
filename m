Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BFAC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD08920720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJN+mxNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD08920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j020f-0004o9-01
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j01z6-0002qD-Is
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j01z5-0005eZ-K7
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:44 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j01z5-0005d8-Ed
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:43 -0500
Received: by mail-wr1-x443.google.com with SMTP id k11so2262977wrd.9
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aRRamzMzvjTZar30SD38wYqoFHYtaZyfi67Aj7iN5oE=;
 b=QJN+mxNEcUSB83RE+yAvX7LEl9RsUWKvT1vpTFEusgMzrjk53vglkMJNkVtfCeVW5k
 7/lUyUE+Lry2nFiPvs+ZyM57fl+5w+bNjyLj0QXeix6kcYrtx4dT3kbOKcGyqX/u2+QL
 RBL0XdQH4fCUfzJBV4/dhqHqbTPNZRRM3H/W48R15WAe8CphkdwVlWzJ9OJws+3g1loQ
 qTABgAlTLRvWYsElQ5FCcl+SmVC0L/vb4bnvbO2b3txcT+qpCCr7x9eAY1kwZ8jIglBY
 D/BTltBEr68bV5r9PJuE9VXAJ2Xj8hgM/6lmZ6FfqYbuLDWe5bN0/WaMZruVe2tIAaLn
 Hi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aRRamzMzvjTZar30SD38wYqoFHYtaZyfi67Aj7iN5oE=;
 b=ciGuOf0kt4tSeT8itIuYtX7mL6oKhKDa/ceSskMQVff3wrbDo5NcBuByREqOQFdr5x
 rSIrqE5L5/w0/J+sttQ8LSJUlmy0VTAMlE5DjXJ6EARL2XNpdvNZev/B6S+g/ljjDYjU
 bmtScvgYXpH8dG7lKloaVLxNwTJ0PIb0OToLxmJ7w2vKcqLQTkBoVyZ9UEsWGEVLRBRz
 Ad9bd6oYD8JCASWuGgx/PBrqLcG+e4AbM2c1c/X58URkpaG35H4mj4P4xvlwoWSJy1Qm
 CGT4QeKcWiAHGDSpRSonFeTjpev0ktYV0uY26x5kZ6atJoJ/tENoDr5IJYRfYD1s5oLj
 QIlw==
X-Gm-Message-State: APjAAAW+41w13T8lWsnBWc3gq5y6rXWmaE1k+pdzK/0x+PVX62xfdG4H
 0RxO0l+ii+mOzmgbmzhGXdmTng==
X-Google-Smtp-Source: APXvYqysKk6DcuOOosFohG0nj1UwoakYcdkRJxQfl76zAda1tP4pU1CZ2Q5StxRLbGC/vvIX0LAgDQ==
X-Received: by 2002:adf:f847:: with SMTP id d7mr4211389wrq.35.1581075582351;
 Fri, 07 Feb 2020 03:39:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l15sm3022744wrv.39.2020.02.07.03.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 03:39:40 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 809701FF8C;
 Fri,  7 Feb 2020 11:39:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/5] tests/tcg: include a skip runner for pauth3 with
 plugins
Date: Fri,  7 Feb 2020 11:39:35 +0000
Message-Id: <20200207113939.9247-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207113939.9247-1-alex.bennee@linaro.org>
References: <20200207113939.9247-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we have plugins enabled we still need to have built the test to be
able to run it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index d2299b98b76..71f72cfbe34 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -70,4 +70,6 @@ pauth-3:
 	$(call skip-test, "BUILD of $@", "missing compiler support")
 run-pauth-3:
 	$(call skip-test, "RUN of pauth-3", "not built")
+run-plugin-pauth-3-with-%:
+	$(call skip-test, "RUN of pauth-3 ($*)", "not built")
 endif
-- 
2.20.1


