Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADDDC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7104A206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxWlGVT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7104A206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYfb-0001LO-Ut
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcX-0007wH-0u
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcV-0006St-Hv
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:04 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYcV-0006RT-3p
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:03 -0400
Received: by mail-wr1-x42d.google.com with SMTP id r5so3585730wrm.12
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OAMnWz+3//G4B1uXoGsmYYeOSQ2vtmWEKTjtuJNZZeY=;
 b=XxWlGVT+bLrM1sSCEqs+9QEwu56urPwXDUzQoinGHdbc+493cX+yzWtRQxeiztJNQL
 n5BI7HPlyLHlLS+7Q3R5xN9doBRAAgwNMkoqUa9zvoN06NLIA/gN+kAcORP8oO6MgwKt
 DvsFwSHdlnUOtwbB7Uo1T1IqSk0A9ZkuzVU0NFqNWBCJXsvK7OpePSAtqw+oNR8ZEcvk
 WPRZGXFe6go4r/iMC1ZW2Jke6d5QynsWG3np0Y/4UgxbkK+TXB7Zou1Pcsteco16S/ty
 8n8vE7VC5ZuQKkRXogopnZOTDmNia2EcPAlN+Hpt9l6yR7BuBGDUk5q6rV28Sn4FHCoF
 XCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OAMnWz+3//G4B1uXoGsmYYeOSQ2vtmWEKTjtuJNZZeY=;
 b=NFxrlai9ZRArv+8bto9FqJYRB/S4YZu08K/BcycLGWx2U0ObgfzHP4znAFqyIVmUxa
 C4TMOBsEfBCu9z/yedaAWeeMJR1Y8kVk2o8EqKgv83AQvh3ZbgARhfCbHsLxKCDNNmdi
 U0GNSn72V1gwgMb29JV++JfkdktebMcK+HtrBhw4XKNtfJQeqTQngDMQittNDRC6nNng
 dXP39q183aWbwnBcr/geYdqBikT+EPzrpf0RvIFPL3vRJpoBZNDKpvDKEDDjGTLDUIAK
 M0ABDf/ImneI5w124McCCqJbZaz/YaoWhJE5LyXsarouU5yXAg4FkaJ9irKgjysFDi1O
 2EPg==
X-Gm-Message-State: APjAAAWHmXGk1RIaC+84MnHJrJEq+iDsVdqAyZRvXmth66/5PpPQM1L7
 +pR9unj/cSaSAH/HIfHVSKoo+Q==
X-Google-Smtp-Source: APXvYqzo1d8fRAtoTmUB04L+E7+LjWi0RqTOkxqHC2+FRYUBDI+WDyCR2l5m52/lazqc6mJc29x5tA==
X-Received: by 2002:a5d:6306:: with SMTP id i6mr4372250wru.323.1569522961957; 
 Thu, 26 Sep 2019 11:36:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r2sm5053204wma.1.2019.09.26.11.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:35:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F14E31FF99;
 Thu, 26 Sep 2019 19:35:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/28] tests/docker: add sanitizers back to clang build
Date: Thu, 26 Sep 2019 19:35:34 +0100
Message-Id: <20190926183553.13895-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Fedora23 is but a distant twinkle. The sanitizer works again, and even
if not, we have --enable-sanitizers now.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190912014442.5757-1-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/test-clang b/tests/docker/test-clang
index 324e341cea..db9e6970b7 100755
--- a/tests/docker/test-clang
+++ b/tests/docker/test-clang
@@ -17,11 +17,7 @@ requires clang
 
 cd "$BUILD_DIR"
 
-OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
-# -fsanitize=undefined is broken on Fedora 23, skip it for now
-# See also: https://bugzilla.redhat.com/show_bug.cgi?id=1263834
-#OPTS="$OPTS --extra-cflags=-fsanitize=undefined \
-    #--extra-cflags=-fno-sanitize=float-divide-by-zero"
+OPTS="--cxx=clang++ --cc=clang --host-cc=clang --enable-sanitizers"
 build_qemu $OPTS
 check_qemu
 install_qemu
-- 
2.20.1


