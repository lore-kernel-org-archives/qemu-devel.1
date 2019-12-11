Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE92FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4BE20409
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snPIbuxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4BE20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5do-00023a-0q
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5WG-0003Kz-H7
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5WF-0003Km-Fu
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:24 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5WD-0003G1-MY
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:22 -0500
Received: by mail-wr1-x430.google.com with SMTP id t2so24916655wrr.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GcR62jJK0BW3+caFEfcaxbzAnsYTRWuQ/b8EWpbWxdw=;
 b=snPIbuxeuYrD+zyppp95kJ3GF8EFZ0gqInNSWmZ5h/RYF+ZgcXh2QNN7RYXlgIY4me
 sQr93MQ5+sP4zugREm2/fe6EhcJzcbEWdDPpKTLQ+/6+oQ91QqkMWQ5fKpPcLubp7N7y
 rayJeGjXJCH+im6NmCU2U2bp/eueE7Qyc8yT1grYv1UYgDNUnc1urz2qYFD2uBygJSGy
 ULVngibPN7jqzRRc0j8VcDx4wuKj3+iOU8GRcp9rMcoiwYsRUtR4BxRNvHkudKT3gadu
 4N1fA+tLLwAYMxKXM0VBjrDC8LUhG70cbZMbcs042YQWHbWefiPbg1q6ZPrEFqjjGPC9
 uQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GcR62jJK0BW3+caFEfcaxbzAnsYTRWuQ/b8EWpbWxdw=;
 b=R3Uxlh1YPhlQnCBnOkLhqYoypTwifeL1wVPRQuAU/u4D0fWVO9lsyLclaQnzZkLyOJ
 cVJaNZlmhcbNRAQOFNQosY5tMm0Atrk8jXaOXc+UszCaOmUOyCaDvlPbWC/t/4PW9T4u
 QPAXtHzf8z2B6OqXuh923lOwDfux2L81mj6A+5T7WyNJBH4WZP5OL8Q2XvsBfrpQDNH6
 kptWeZF38VzJw1KQ9vAzzjpmAiPwCjGSnwgjiBa7AtAvdN86L+7AWLSXS6qkKFzU2rLc
 3cUuUzigqSTfn93RNYssfCmNIYkgX81iujn9gwUJaylwnyLGFAD+NdO3r0pZXes5f6wi
 mHfw==
X-Gm-Message-State: APjAAAUUi8p4jWtwoljK5LgoUFSquJAuid42JEeOUxPKtyqVvhHfhNUG
 Vahs6G9c7VP/lbj9b5vJJhYhAQ==
X-Google-Smtp-Source: APXvYqzEeX/8Iab9U5GUxvSRljOtgc47PQRYS/KlPEHM+aQMJNWiigO92ejjAL5OJzxxuWTKIBs33g==
X-Received: by 2002:adf:f98c:: with SMTP id f12mr898817wrr.138.1576084280489; 
 Wed, 11 Dec 2019 09:11:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s15sm2937669wrp.4.2019.12.11.09.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:11:19 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 71BE81FF8C;
 Wed, 11 Dec 2019 17:05:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/20] tests/tcg: ensure we re-configure if configure.sh is
 updated
Date: Wed, 11 Dec 2019 17:05:16 +0000
Message-Id: <20191211170520.7747-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were only doing this if docker was enabled which isn't quite.

Fixes: fc76c56d3f47
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.prereqs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.prereqs b/tests/tcg/Makefile.prereqs
index 7494b31b952..9a29604a839 100644
--- a/tests/tcg/Makefile.prereqs
+++ b/tests/tcg/Makefile.prereqs
@@ -13,6 +13,6 @@ DOCKER_IMAGE:=
 
 ifneq ($(DOCKER_IMAGE),)
 build-tcg-tests-$(PROBE_TARGET): docker-image-$(DOCKER_IMAGE)
+endif
 $(BUILD_DIR)/tests/tcg/config_$(PROBE_TARGET).mak: config-host.mak
 config-host.mak: $(SRC_PATH)/tests/tcg/configure.sh
-endif
-- 
2.20.1


