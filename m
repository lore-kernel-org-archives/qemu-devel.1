Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF542CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7677F21D82
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYHC0m7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7677F21D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5xG-0000WI-5X
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Ok-0008Md-Qd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oj-0003Ag-HG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:22 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:43010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Oj-0003A2-BI
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:21 -0400
Received: by mail-wr1-x42e.google.com with SMTP id c2so3607637wrr.10
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=71jlC4Z8g9Q/EoUX8xnqEL9oQfxujIcEuUZtk5+Z8NY=;
 b=HYHC0m7rJtLxXDFJ7HtXiummyHF2f0KxQn/coOFjcjRoaAJm5KCf2+Uzx+Kb0u7q1/
 iD/ci333Gx0iURcTiL8Sc94YRDyswvnJwO93K/iiS6F9ZpPk1Am/Jb5qSeJuxtPNVbII
 GZAZ6d2qgqrnq7g6dyMoDmCg/BMZx8WOwEjr3wLRvmf7tEMD0LKCt7GzFa1G6XUNdSus
 irXnkmu2KVFj4yOokMLlXLs6yeoKga4ug0UMG/1w5Z4afli4X9/6seS8K9G4XmJKsVEW
 EntvmFarpHvrYvML+74h95mPIsex+Q7rCvHjDz0/cq3Sg51JGuV4ZIQYyIGMU8HbDzR9
 wZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=71jlC4Z8g9Q/EoUX8xnqEL9oQfxujIcEuUZtk5+Z8NY=;
 b=neH94tDV1qtcNZptYhK9UqgzmXB4n6AGVrlrfJTNGZ3OHdjH4+cvy53uLCDKvHNReO
 0j93TZXM1uWVxfOT+Pw/0eW1s0fVMrEIJ/x4qkw3oPH3/vcER28gpJWGOGx4m3Kix3pw
 spHBnos52PphjtUTTsFrtWiIzwNGfZjqaLNmFI5dKvU2jcY+YD7dsi25Owzb+ePg+Rrm
 gFOM1lCU0r+mlkQ9jo94B8L7eiSTP9HpuGPvnb2+IJ1FxDNyg/yriuqbDy1nd115ogRy
 TrTfDj0226PPVPKxRX2rVI9KbhNl6q4JyJ3fu4Mf5psR2OrI6JNOOs3BtQTPaxlSK2Tg
 72jg==
X-Gm-Message-State: APjAAAVQ+jEyJ8/FOROFymkZ6FuFeagearj7y81bN2IhRnOB5HzrIEuC
 xhlIrdofBTnGaDMV/t9qw0Pd1w==
X-Google-Smtp-Source: APXvYqyPbP0ONVPYsbxuGt7bEc10o+XxfqKcER/6taEyZyecVNCTBuqh2zaUp0FaRqmrULlaWsRvIQ==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr4396160wru.310.1572032240229; 
 Fri, 25 Oct 2019 12:37:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l22sm5000983wrb.45.2019.10.25.12.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF7BD1FF9F;
 Fri, 25 Oct 2019 20:37:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 15/15] tests/docker: update Travis image to a more current
 version
Date: Fri, 25 Oct 2019 20:37:09 +0100
Message-Id: <20191025193709.28783-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This isn't the latest one available on hub.docker.com but it does
match the ID reported by the Xenial builds running on Travis:

  instance: ... travis-ci-sardonyx-xenial-1553530528-f909ac5

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
index ea14da29d97..e8eb48dccfd 100644
--- a/tests/docker/dockerfiles/travis.docker
+++ b/tests/docker/dockerfiles/travis.docker
@@ -1,4 +1,8 @@
-FROM travisci/ci-sardonyx:packer-1546978056-2c98a19
+#
+# Travis Image - this is broadly the same image that we run our CI
+# tests on.
+#
+FROM travisci/ci-sardonyx:packer-1552557266-f909ac5
 ENV DEBIAN_FRONTEND noninteractive
 ENV LANG en_US.UTF-8
 ENV LC_ALL en_US.UTF-8
-- 
2.20.1


