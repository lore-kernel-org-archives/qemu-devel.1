Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A602C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE60722512
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkJ8avNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE60722512
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsC6-0008Gk-2h
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37896)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9h-00069P-53
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9g-0007Sp-0B
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9f-0007Rd-QA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id l2so38017599wmg.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c6E9BddK89xMbl9F10ybA11PGnEiUFETjL7X7/hYQAI=;
 b=mkJ8avNuFPrS7/mSRnN1lYprKD+kSvsejyVMs5szGduYgIgyUUvjWnf2Qju+B3wn1W
 RtImk9iGRf5xrz9SOdZSL4clXXh0cNDVh94piScbrB9u5BUp7aqlWzkcC+ud43wHjFgW
 kI+lROGOhR3cHytrTEauZMfYg2/Ocoblq/9dN3rQpTj+7m3ZVuKTPPojJdWhfjUg8/gy
 OkUJVyOn96sHjRvTnL180PlrOhoHZq06VsCB0uvUVfiTiRJg55o1kZhVov3iZx3UWySe
 BgqHY0uequD2WQjqXCnzp1n8Sa1h/L4XDPu5FlhXVuUlEC8HoOICfr9hedbf6p5agMVM
 vBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c6E9BddK89xMbl9F10ybA11PGnEiUFETjL7X7/hYQAI=;
 b=VEESpC0U/Rq2WBLSNZgGA0fpq9Nf/dl1YNskaWFrGS5VAtBL08SIqdUrPKc/oQz+uh
 vvc/FcpGocp060nJEeahU6+bETJUJjUUO6H8aK3n3b4MTZiv+oqwzwvLu4VlyDVAcoys
 nZ1XVPmQ7b0Xp2+hh2givYlyyH6hUCa7C3AUHEG2WifUEz+n1l1d/fOyQL5fA1hta9qz
 JLkT9qUvVHiFHBq7sAXUBeWZ8hTkmJTPV5REShCV2xqqN7SiSjEvClU9ICTi5KdODv2k
 pROo6jcwP+6psfW4ILzygduXhbVkg+3adWPec7lcNDXUGOr43zqSsaq1+ZPBHjsHd4u+
 xspg==
X-Gm-Message-State: APjAAAWDaDQ6r4gB6PM+h8kH7vE3v6qv2idMPYJW9UZ4HqbqMwgF8zis
 s9tUsL26p9p8F8eUYtaIyiGpcQ==
X-Google-Smtp-Source: APXvYqx1QSxN6ReV0NaHwWHL+PyjqZMv8MsYzecIxsaMinsYaZL+V7GiikYMZFmb+oBOmB3XsWZUxA==
X-Received: by 2002:a05:600c:291:: with SMTP id
 17mr67071325wmk.32.1563878182638; 
 Tue, 23 Jul 2019 03:36:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v204sm42941386wma.20.2019.07.23.03.36.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:19 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6FBA01FF9C;
 Tue, 23 Jul 2019 11:36:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:36:01 +0100
Message-Id: <20190723103612.5600-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PULL 12/23] tests/docker: Install texinfo in the
 Fedora image
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The 'makeinfo' is required to generate the documentation from
the 'html' Makefile rule (called by 'install-doc').
The NSIS installer uses these files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190715174817.18981-6-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 226ac1026fa..4ddc7dd112a 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -87,6 +87,7 @@ ENV PACKAGES \
     systemd-devel \
     systemtap-sdt-devel \
     tar \
+    texinfo \
     usbredir-devel \
     virglrenderer-devel \
     vte291-devel \
-- 
2.20.1


