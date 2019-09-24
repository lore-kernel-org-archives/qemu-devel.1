Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39ADC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702CF2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHqPaAQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702CF2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtNs-00007I-Gn
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs5D-0003NS-Qu
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs54-0007Zh-AV
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs53-0007ZS-4U
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id a11so3686568wrx.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KEWV6a4isQSGjL/MgkpnsnB2zYPoMG3iy1IbQBBhcf0=;
 b=RHqPaAQPO1CedMX+rnW5I57W9uplyIutv/cFLT8Pz5oNNLoVWBp5+nxJYarwK/ezJT
 Ad0otgy19LnMj/LDPwpRYVJDF41A8HuKz2jDCr4xaOpsgnvT/qiie3w2h+Cp6zdD+PW9
 ZRZtg1WkPYHVC266edl+aLmsFJ0D7U7FbLSjT3u6lWbG/SXpEGpZ5ja1gCKVTLkpLqB+
 ypo3O3UG0cxNVFYRAUS2m6SQgljWf176BwhYn6d16biDpm4wjeKJu1A8YEFV2kZYyRVr
 pdWi7uBfUTloqdd85M4KM9VFkTqfyH5UCLM7VI/Tzuhme1EzKFn1o9Lp9eSdE2uyUGBg
 cjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KEWV6a4isQSGjL/MgkpnsnB2zYPoMG3iy1IbQBBhcf0=;
 b=QPyIVjzTa4I9UoFZg14vC8HJoqLmqtuqs8aHm1qQQwskFwF53ZY3FYcXLX4JYTONE8
 pyLeWSs85hozW8rtpNzz6tCBCO1U1QjMzpuTNiFqM98Rg6BlJPSaQApSedzMz5qyzYnv
 IrQDBid91d89BxMO4ITuznEfXRJZfwTXAfoWaa3EzkQXVIHDWjbharwyAq8XQk9PEYvN
 XF0ADqNeeRMaUTOYnSEMGW3kC+pvybsiwhuyrX6ueuL6ijWuz572Ckwpyqu99Qj9BH98
 vvTx0aYsYOoQkcdrCVJEMwbem+s5XoaCYXbAyOA4zqHhkjxrmw/ZYIxbgidQDYyAsbAk
 kzXQ==
X-Gm-Message-State: APjAAAUTRV7Kb8TNbr37AyrA2lAsMuHwGt3FCV3tIgW+y0oPwtceOaLh
 9XaHnz4iFgcBM2l/qR7fjkvkOA==
X-Google-Smtp-Source: APXvYqyYQhChxQ9pi/cIDUzxq2EsfL0n0fJ7oIf+gOtQuDQXzCkDEjer6IcOGr5hog/Wy6tXl3+nqg==
X-Received: by 2002:adf:f150:: with SMTP id y16mr4532945wro.71.1569359440095; 
 Tue, 24 Sep 2019 14:10:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a10sm3731617wrm.52.2019.09.24.14.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 411171FF8C;
 Tue, 24 Sep 2019 22:01:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 16/33] podman: fix command invocation
Date: Tue, 24 Sep 2019 22:00:49 +0100
Message-Id: <20190924210106.27117-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, f4bug@amsat.org,
 jsnow@redhat.com, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Oops; there's no argv here.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190913193821.17756-1-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
 tests/docker/docker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 3112892fdf5..31d8adf836e 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -332,7 +332,7 @@ class Docker(object):
             cmd = [ "-u", str(uid) ] + cmd
             # podman requires a bit more fiddling
             if self._command[0] == "podman":
-                argv.insert(0, '--userns=keep-id')
+                cmd.insert(0, '--userns=keep-id')
 
         ret = self._do_check(["run", "--label",
                              "com.qemu.instance.uuid=" + label] + cmd,
-- 
2.20.1


