Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3649BC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058AB20578
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOvBBPMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058AB20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAIWB-0000Nh-HG
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 14:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIPb-00036k-1s
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIPa-00009g-0T
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:14 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAIPZ-00009A-RS
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:13 -0400
Received: by mail-wr1-x42d.google.com with SMTP id v8so4293254wrt.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 11:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LMbOHPanbSykXXA3FNnL/gV88488o6eu7tgtLxglpcc=;
 b=BOvBBPMzK/yLqpcq4iJQQJoCaaIxnqwDXzMezDFTUkspC4YLhAA7iXvfBoyiPrzeIw
 tDnxO9sYhZcoNvL+MerLNV21c5B3j++lWaw7pZ9GQ2has6Q+hN455DNiaQIk4iq0U4Vm
 K+uMyVP97mXHo8ohGOy2jKKIJ0JniKqyZerd9wEPioG7o7u132FHCgCMxHcJdiOJ38uw
 gaguMALpubsePsReTw6OWVp0oB946nLKGOKc3kFFJQv7T6nxjT7EH0bRB4QL1VM2oobk
 IgYXAi3tzk6jXlDSGzZ0BlhGrLr7iTlHo7NnoaaavolJGeJRx1cHlg+GbCyUhDm3S5zh
 cW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LMbOHPanbSykXXA3FNnL/gV88488o6eu7tgtLxglpcc=;
 b=UBS27jQ65ntzqorB7oku6gIJRSSQvfsCz8vibtFihEcDr6/uH9OXGlngwVTc2BFq7G
 9HnWj662fXFszO/z52mLLORu8XPUkPHPVEuLUWIfyJERoq83fDA4WNPunRCrvp10hBjw
 tevvzgPk4thgFCGPcfPGd9EVUMwf/lS+KIevHGVM8LtmtpEo7YrIgh/0TWXOxr6mboTG
 ydAg9Anh9BnVeSMCguW3ata1vRvoVSGS4GMUQEgJwpvIWMZYoW+lnZzTv7AajQ8WL+Bv
 r2xxE2cNNpcp8dTZ66Bz8DxVsUArvFXYckigawdazA7az/5KNo0mfRGCSWqsak+9HTRs
 1M9w==
X-Gm-Message-State: APjAAAVVbe36GkuX7z8renfgug/HUAPteYDUcIt39WHZwvm9VvELVldn
 i2oEPMmHHbfuhMaSJP7dibhxKQ==
X-Google-Smtp-Source: APXvYqyiMkqAGbw+67Pr9z3yNNVV2hQ+p28n/fm/Zme/+j//6jVaSXJO4Zp9GEViJpV3Osdz1yIHqw==
X-Received: by 2002:a5d:49c2:: with SMTP id t2mr27333wrs.351.1568745672685;
 Tue, 17 Sep 2019 11:41:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s13sm1647623wmc.28.2019.09.17.11.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 11:41:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ACACA1FF90;
 Tue, 17 Sep 2019 19:41:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 17 Sep 2019 19:41:03 +0100
Message-Id: <20190917184109.12564-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917184109.12564-1-alex.bennee@linaro.org>
References: <20190917184109.12564-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PATCH  v1 3/9] podman: fix command invocation
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
Cc: Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Oops; there's no argv here.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190913193821.17756-1-jsnow@redhat.com>
---
 tests/docker/docker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 29613afd489..bc7a470ca2a 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -334,7 +334,7 @@ class Docker(object):
             cmd = [ "-u", str(uid) ] + cmd
             # podman requires a bit more fiddling
             if self._command[0] == "podman":
-                argv.insert(0, '--userns=keep-id')
+                cmd.insert(0, '--userns=keep-id')
 
         ret = self._do_check(["run", "--label",
                              "com.qemu.instance.uuid=" + label] + cmd,
-- 
2.20.1


