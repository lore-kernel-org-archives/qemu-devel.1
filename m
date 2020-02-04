Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C06C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851CE21927
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5AVIYE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851CE21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz38i-0003lD-Mf
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37k-00026O-7q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37j-0002hK-8p
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:36 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz37j-0002dh-1z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:35 -0500
Received: by mail-wr1-x430.google.com with SMTP id y11so24406994wrt.6
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X/6RO0ey6PmRf1muRhvDBqcqrauxivbgrnnnZr0f7Aw=;
 b=H5AVIYE4YvEbYA/rwUakt3sK0btGZJPqsGuh4mJAaxfWIyFU0yKJSRiQs/dBayjQt/
 M2D5AF9fQKfgZ1rfmznGM5WxZvBWC6nu4qO3wWTylc9jjmCcoYeuW9SO7/7nNWCU2yWV
 JHJ+TJZaGUiNKZnx7RypuqE52gYkl+hDzEIWvsH/iUtnaWjikWRTJU5H6Nwbns/VrnWu
 016AfBESZcjv7IYMLMzu49qTJOMjvFZaTK3XfZaT4hKh/eqsYiPJAGJXO4Gu13ZHxMU5
 7lA/OfPo8lL6ATq10LJTK4yFQB0ZRvkNkYaoKVwOqXbwuy2aYGCmL0MmZIT8X5F4MZnC
 kDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X/6RO0ey6PmRf1muRhvDBqcqrauxivbgrnnnZr0f7Aw=;
 b=XvQ9nMiAttWVF0pAJX8AFLZlmchrPAYALBGGmqRR9WFQ8pOeLPn24r3eqbKrd2sG4u
 +0bW5jUVCTAXCB0UZI4e869PKlMSRcdR/sMxm0XFmLdme1/f+cZPjtYDCM6e+37C+Oq1
 3E8sYFNh8VypgPCSQiRia9ng1VmF706rlMQ4vo81rIJPCDyZWpQtoh02qSbAVZycqLew
 R3S0v0tWcf1cUVIlJ0B+m3si1KB8QkbQ8G7CD+DABBhtDBf1HvQIJf+b7aDc/rg1B2N/
 5KJFxhModo0oAjvn94kC/1k9WMEamGm4FklwBta/DRq1fa1FFVsKQTXQDnQ5ABHE3Vxn
 qmRw==
X-Gm-Message-State: APjAAAXPoCE87/2n/dU6F5Rdh4bOyHC/7gttYVXkCJRENFoqlO9tuE4z
 6bY9FxZfHr/de4FkRySzFfDxNA==
X-Google-Smtp-Source: APXvYqxXrDRXEbBNPL5A8YT53rf+apAqICzQnR9K7Rm/a2J5W84LNLbwlD/Z5mvX7YnErPfLcZPMzg==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr25178720wrm.394.1580841634080; 
 Tue, 04 Feb 2020 10:40:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y185sm5051757wmg.2.2020.02.04.10.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:40:31 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C28D61FF91;
 Tue,  4 Feb 2020 18:40:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/16] .shippable: --disable-docs for cross-compile tests
Date: Tue,  4 Feb 2020 18:40:16 +0000
Message-Id: <20200204184028.13708-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

The sphinx support is fairly new and we don't seem to have all the
bugs worked out for cross development environments right now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200203090932.19147-6-alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index 83aae08bb4c..2cce7b56890 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -37,5 +37,5 @@ build:
     - unset CC
     - mkdir build
     - cd build
-    - ../configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
+    - ../configure --disable-docs ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
     - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))
-- 
2.20.1


