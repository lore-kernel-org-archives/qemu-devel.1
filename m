Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194B4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB55206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nyV4MZO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB55206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtw4-00031w-ME
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMu-0007vv-7D
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMr-00039A-EF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:53000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtMr-00038R-5Z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id p21so785936wmg.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2XLQtBEPkvpVzS5Ez75TVhX7pL/ZQUgLE51dTOXWFNU=;
 b=nyV4MZO3nNsDVfHLDXfj2Tnr7ibZOA3RmPz13tl9YjAn5eN3nOQ5jptNpTLg8NNExX
 bl0MOzWrNwBJUNoLmbNcSDLuF9oBbIHJH9s8m/jCtrFTVTv9/SZvrD39TmVvur8FL4Fe
 B0QIXPGuyUp8uY0uLFKVN+mewOaMzcXQYX6UHgAPwuegwVgQbi4hHkR3ShZSdqQyAtZe
 +8rqUXf4xBYuqD2NkGoGbhD7JuTUPbaBjV9wcNsv7fplahYn10qnF/IPa0rZPrvlTYXO
 UUFRq2X560lFidX+vQcSYPghJBRxQBi+hGXGD2164nnYsYestnbWICnyZrdaWnXJO8HQ
 ceag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2XLQtBEPkvpVzS5Ez75TVhX7pL/ZQUgLE51dTOXWFNU=;
 b=MU9GBWs97n15kkk0HSoE5o+4h/SHrq7J/144rrwOwAb4jWD2YMQu3McYgEFH05RE3k
 vdEXMz3VeTot+DzwRFL+fBCxDiues/aWLyRzszwTTQbVLHcjEkuCLJ9AyQsMpxzxTana
 FLxPJfJJJoqqjNA/PknEd8RPO2S9Ftm28ybh8qaqviRtO7amuCfQLDjeRHWeB35uxyqo
 27Y4GREtfvW5W4WqnzBIxd7E7eInH7tE5xojzU8LC2jdyNTwHMHV1w7EIYTsEAUSN/Kw
 Zt/qNQ1uqW7xiZ9liVbwfwe+qEgz8a0j1CxAr/fn8y1ficjGmQN1qZ5fdV7/7CmCyh49
 Noig==
X-Gm-Message-State: APjAAAUUywQs/5xrPyPu5RYKdVeKdDhVSSaaaBVIfnqViqZOutYvqlqU
 +V1EO/570rRu38Wz5FNgaVaMgw==
X-Google-Smtp-Source: APXvYqzT1m5dANepffE7DPwmBlEXeaB9PCV+jXDGydjo0E74S0nMw698c/FuIM0E1KU+K41Adr1T2Q==
X-Received: by 2002:a7b:cd86:: with SMTP id y6mr1927646wmj.101.1571985995965; 
 Thu, 24 Oct 2019 23:46:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x205sm1393092wmb.5.2019.10.24.23.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 909C11FFD4;
 Fri, 25 Oct 2019 07:37:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 62/73] tests/tcg: move "virtual" tests to EXTRA_TESTS
Date: Fri, 25 Oct 2019 07:37:02 +0100
Message-Id: <20191025063713.23374-63-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise clever expanders like the plugins test get unstuck.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 84abbd24f34..96646130020 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -66,6 +66,8 @@ conditional-diff-out = 							\
 
 # Tests we are building
 TESTS=
+# additional tests which may re-use existing binaries
+EXTRA_TESTS=
 
 # Start with a blank slate, the build targets get to add stuff first
 CFLAGS=
@@ -109,7 +111,7 @@ else
 
 endif
 
-all: $(TESTS)
+all: $(TESTS) $(EXTRA_TESTS)
 
 #
 # Test Runners
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index b4b39579634..950dbb4bac2 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -52,4 +52,4 @@ run-memory-replay: memory-replay run-memory-record
 	   	  $(QEMU_OPTS) memory, \
 	  "$< on $(TARGET_NAME)")
 
-TESTS+=memory-record memory-replay
+EXTRA_TESTS+=memory-record memory-replay
-- 
2.20.1


