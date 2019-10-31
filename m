Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20CFCA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB4220862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXZYEkmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB4220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ7M6-0003YQ-M4
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 06:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7Hy-0002Bh-9g
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7Hw-0008R1-CA
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iQ7Hu-00086z-6B
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id p21so5242567wmg.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=syiFzeWYPDMTIFQ14fZT5sQxSwiqagDLfCjgYeIT/h8=;
 b=uXZYEkmhn3p7bNWlCwdXphYFAgVdkk6vRYr/kVrX19VbW7lPQoQ07u659yYoAAkpUu
 d7h+oTaeMJQtYMQntSV5s/phug2uA7Y7yRC5Vv6bGIJoPu7fJlZv+vWiBE0QlcbLXRat
 el1Oq66beYKU/4ukFSVlduRuxP5MPPajWwfASHI8DQhsAkoQ21squdCU3StoajM0nqEk
 fZz3CuE41cxV/D9oIR0gGGjHTN+oVaJa0Oxal/1vRwlBdw/kudEHYd27Yl4jPEpNx/so
 wtHaaJ91WOVVU5cG7aACRn6N96DUXAth2wbSAEXeMApJvpfULiuwXw93r6M4pgqLNeiP
 9GiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=syiFzeWYPDMTIFQ14fZT5sQxSwiqagDLfCjgYeIT/h8=;
 b=mOfCy9m9wWQftuWmF/OnWNbZKcPFRWj8i41iqIPgEQlWsKxcG6vUkcHGLSaEG2JEGJ
 CmTVPrKKzMs6f1/Zpq7AB8AEykkQ9E6BBxK0SJLgv7HKhuwqjTGUDab2QgcnW7/FUioR
 HXE93DiS9GUkk6pcteUOLBu6HhAPr9q5BP7qZWRLyINxzz2D8D7hTTHAvWZ1g++wMm5I
 4oUSnDmSk1d1Gtus3Z43U6JV8WKiHhpX2xxKTcCsYJeeB3Mda4JV9pgAoalj6dUUA6JJ
 QW59YdSV7TlIiFz/1c+MZGgGrnIl5q1HUfIYBVkzjrZLAba+LaeNYvS4cmJ2fCup6PYk
 uU9A==
X-Gm-Message-State: APjAAAWtmcEoZqMF6NDFSSNvc6jHVjKtNEz6Ad8RmiqL+jxfI8nTU7tO
 EicCJ2mmnIRG9De0P5Y0x2R9uw==
X-Google-Smtp-Source: APXvYqxP1JWVwkbBayNNIdY6iAQ1hBOQsyA2w3tRb30qGR+xvJr/4q44j7kaETW+/hezWw0aV73r6A==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr4251018wma.80.1572516154802;
 Thu, 31 Oct 2019 03:02:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm3495392wrw.10.2019.10.31.03.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2019 03:02:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EE60F1FF8C;
 Thu, 31 Oct 2019 10:02:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 1/3] tests: fix conditional for disabling XTS test
Date: Thu, 31 Oct 2019 10:02:30 +0000
Message-Id: <20191031100232.21992-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100232.21992-1-alex.bennee@linaro.org>
References: <20191031100232.21992-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The intent is to only enable the XTS test if both CONFIG_BLOCK
and CONFIG_QEMU_PRIVATE_XTS are set to 'y'.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191030151740.14326-1-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c79402ab758..7715d8cd63a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -140,7 +140,7 @@ check-unit-y += tests/test-base64$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONFIG_GCRYPT))) += tests/test-crypto-pbkdf$(EXESUF)
 check-unit-$(CONFIG_BLOCK) += tests/test-crypto-ivgen$(EXESUF)
 check-unit-$(CONFIG_BLOCK)  += tests/test-crypto-afsplit$(EXESUF)
-check-unit-$(if $(CONFIG_BLOCK),$(CONFIG_QEMU_PRIVATE_XTS)) += tests/test-crypto-xts$(EXESUF)
+check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_QEMU_PRIVATE_XTS)) += tests/test-crypto-xts$(EXESUF)
 check-unit-$(CONFIG_BLOCK)  += tests/test-crypto-block$(EXESUF)
 check-unit-y += tests/test-logging$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_REPLICATION)) += tests/test-replication$(EXESUF)
-- 
2.20.1


