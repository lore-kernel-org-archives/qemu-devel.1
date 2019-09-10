Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2F0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BEF20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtUEGblR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BEF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bwe-0007OG-9L
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bki-0003KR-Fk
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkh-0006HW-FS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkg-0006GW-0X
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id i1so17784268wro.4
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B3leNU2N9kDllIY2m7kdi0hOzfRjQ0Y6fJjuNSOgJCI=;
 b=FtUEGblRYzZEWnCpnDtLLYGec9B8NBMPxRF4VgCA1ZmPWBh7+r7LAMlJlkkxK69n4/
 OnAaCZ7CC09Z6aSEB9SY3Kuwqd3kNEGSN6VzpQUIaL6KiMGjRIO9RX24uM8IpDVzQdfr
 YjnIU+SeQ5bgogwUKjfSV/2BCFnSqQShiQAOFinkDFfaNBO/ur7FWOAdw16l2+S4k94q
 lexlD1lP/JQCwwv16an+7qz5K9iJGAgrxp26DzMOsNa3G16GVQPqwXUzwNI98rgVDlDq
 BmWC1XwTnRQPhxBF6kWhQeDfMfy9tO5JLSNgsia51jO8eOpW84HjzriWhec7gVrBSdBz
 8xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B3leNU2N9kDllIY2m7kdi0hOzfRjQ0Y6fJjuNSOgJCI=;
 b=ZJey1V1IMv6DOo89lrxMeoSwWrUGK0g+peSC8slToG44VRr6brPbxyH0MqYeJf0mBM
 yyWPG5s8+48lreqV71Y+6xEEI2NtWAGvAzyqEe05iW/bFT8JSwraXr6bCvYguAxA+l1E
 Et4jDFMv+aSvewRPS8u7oaZOl7Hu2XGtqF3j+xl/2BTFCoSrwacQ6UZByJQVcOvcGgAF
 SEHag6e/HSwjxNkReLGpi5B86EBGQfW8BrYLQ9+8BlsZoefkCEg1COMXyOLjF5x4wd+6
 6BbPzOnQM4ApfYGQIhHjuh/rFu0bwejsYmgR3RT9n3GKCuZPKAcNOxUC4mP4qyRjUNcK
 JvYQ==
X-Gm-Message-State: APjAAAXoVBKvqaol/E5p39S3MVbCxxmygOFLxd+qv1uWLZTFNOq7utTN
 UjOdfV6t8cGm12IFHARMaLaxjA==
X-Google-Smtp-Source: APXvYqyFx+tT5tqPwqvmBrVpdj8krTeGvM7WxDmAfai3lA4aElKln8Yc/zKMnqAhmTT8igA4ygWuHw==
X-Received: by 2002:adf:ef44:: with SMTP id c4mr25827921wrp.216.1568105032069; 
 Tue, 10 Sep 2019 01:43:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm1995092wmm.43.2019.09.10.01.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AFCFA1FF90;
 Tue, 10 Sep 2019 09:43:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:07 +0100
Message-Id: <20190910084349.28817-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 03/45] tests/docker: Use --userns=keep-id for
 podman
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

The workaround that attempts to accomplish the same result as --userns=keep-id
does not appear to work well with UIDs much above 1000 (like mine, which is
above 20000.)

Since we have official support for this "trick" now, use the supported method.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190904232451.26466-1-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index e23209f71ee..064026c8af8 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -369,9 +369,7 @@ class RunCommand(SubCommand):
             argv = [ "-u", str(uid) ] + argv
             docker = Docker()
             if docker._command[0] == "podman":
-                argv = [ "--uidmap", "%d:0:1" % uid,
-                         "--uidmap", "0:1:%d" % uid,
-                         "--uidmap", "%d:%d:64536" % (uid + 1, uid + 1)] + argv
+                argv.insert(0, '--userns=keep-id')
         return Docker().run(argv, args.keep, quiet=args.quiet)
 
 
-- 
2.20.1


