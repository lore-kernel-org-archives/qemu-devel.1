Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E03C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E853B21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2yIWSPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E853B21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0aR-0005li-St
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB07Q-0008Ns-TT
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAzwg-0004KS-SW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAzwg-0004K4-LF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id b9so3963536wrs.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FDw1x34VjZz6x324dEY/m3Hhnbg5UxW8YU5wYZvVAME=;
 b=q2yIWSPSAf9fjPqgNG/rXlU+T0JvKFydD2ctGFGktNendO6jls3Eq4Fa1IF6Fv4p/z
 TuIeyaO0lj/8Tut9dPICR54zsBjCkSbACCR6c1J/uIAI8oxyyflDEhcr1nMfY3cpJ69s
 dJ7OYwGe4aRjFmNKD2cWVM2Z9Yu8Ruvb6t0TIZnHVlQv8jLW0xsRkPq3TmJphDFCpG9+
 U6Ruy5ORbtRos1mzcOoImQsS73yTZu1x5VAXM35lW0rPZke/JfHZNVVQCiFIX3HfZ95h
 KAkQKXDt8lnJr7vKWHfGJ6su9yiP53cec8NfYGsw3iBtykWVzF3K7Cob5avtK1CNlINV
 /zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FDw1x34VjZz6x324dEY/m3Hhnbg5UxW8YU5wYZvVAME=;
 b=l1sFvudeems6Z3wkePx/6iCt3puWsQLa+2oiVl9lrjPpRL2D9LHFqIwVHLq1hiz+Zs
 r632oEJLvbPPeThYl4H16Gq3qQlbsh4S7oZuMcB5uSRLH3F9c3ACB4ETpXDDK4BknVkW
 sa0Qhinx2hTW/Pa0PHx68ipVFwkH7FXmPblXG9qnqU9Gqy4hy7qEx9oojWuHkQJHqht5
 BO3myys0jg/ZWtFYwij5pxyF0i8q1TJykrY3v5nq4WncKTyYODgYSQrCjknHZixaXxWn
 6jAT6VVzl4/AeJaQKCpMcZqpEtCDt3W90V5QYzL0R6BkHGH/Km8HLdzZeK8Cp9bxsyoI
 08uQ==
X-Gm-Message-State: APjAAAXFb9qYYn8oCLToPADqjiajN4wQzpNy1EPEuMwcISE5FrksGGNx
 ZfiEkAVODY3CgT0B1GIR87O28g==
X-Google-Smtp-Source: APXvYqymttcg2yRpZ8Kn5IeAA+mXwEppmWcA4LJ/wGR+lrh5/E+faBFKa0qCI4Z+0ojgMJMHLXgUXg==
X-Received: by 2002:a5d:49cb:: with SMTP id t11mr468303wrs.158.1568913017117; 
 Thu, 19 Sep 2019 10:10:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i73sm4092669wmg.33.2019.09.19.10.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:10:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C06FB1FF8C;
 Thu, 19 Sep 2019 18:10:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 01/16] tests/docker: add sanitizers back to clang build
Date: Thu, 19 Sep 2019 18:10:00 +0100
Message-Id: <20190919171015.12681-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Fedora23 is but a distant twinkle. The sanitizer works again, and even
if not, we have --enable-sanitizers now.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190912014442.5757-1-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/test-clang | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/docker/test-clang b/tests/docker/test-clang
index 324e341cea9..db9e6970b78 100755
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


