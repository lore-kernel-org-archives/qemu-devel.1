Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71EFC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95671208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vifs8tzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95671208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopip-0002KC-B2
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iopIO-0000LS-DO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iopIN-0002IX-6h
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:20 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iopIN-0002Hm-0o
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:19 -0500
Received: by mail-wr1-x431.google.com with SMTP id t2so54021810wrr.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rt2Px2ccxS3QOQ8HuOIurdGrTuSjUHBCmbsVqBMFyYg=;
 b=vifs8tzJQDPdeuSZ/l4ons41Se/4k3giz1UnLQytKoIAokVkbyeibWgkv8Vp2ukFZ9
 sBkt2hJH8vohaNdvWY7EGjIVfFk5p5Im8/4BMHF/EN0PpcmidQAp6CFMQNORLSERmRrp
 IpHeVOOs+WOVrsO4Y9fb8ZE3KBApyzhmxq3MYYYCMgYZ6PI0PaZ5qpC1xYv1caw5u3t5
 x+2Dj9BQLfEH1C7XQnEeaF3vwNU5isIpZwCSh+jMKkCbPsO9us6m2fDif7JXGnZTIMh3
 Q+/Oj9nvrBKOwNU1l2R2Sx5LMDQDSgraJbJUgxm1ELDnABZ3sE7FwPNFVKVkUaed+/jR
 u4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rt2Px2ccxS3QOQ8HuOIurdGrTuSjUHBCmbsVqBMFyYg=;
 b=FXAKRnyUebSObTp+bYlgXgmyUTWIansaxT/T+U+0LUjReAI5rjZ30yH3urGYtlntWx
 aHltENjAxpUk1pgsGNRXyRuGngS5ljdD83xXMmwpzYUKTL1wfB82T+f1rWMkTP7pdx4f
 IbV1mTY/KZtElynk3qn7pzEQM5CasMCrIMGKddcGRfJSNFs5L4ozIG2Sq4pMt7iRs3l2
 jWnQeCilEFtErQwsBUTNA8Q4WQ3MB6PUNXk5IBZNdQ/ynDcic0MYdGvHKkWnu4W0Oimw
 75sjMCmNT69NRqXDpt0eqWHwX2QyHoVnG8eCOXlxqREgTkHnBlIpeXSPxc7JM3QcwJIk
 t4lQ==
X-Gm-Message-State: APjAAAVmHq+u2qlBaxCLxjt9rwfa78/ZxizdECgi+QwPc6H9/+lxTOxk
 AQPIwLeB05r67oxEGEudNT43Pw==
X-Google-Smtp-Source: APXvYqyUO1fFuM63aNzieakwp0CWr2eIsiYAR+DyyeC35FPcF6uVmfPAmzQ72n3kk0ZymaDEFBdebA==
X-Received: by 2002:a5d:4847:: with SMTP id n7mr109472515wrs.30.1578405198050; 
 Tue, 07 Jan 2020 05:53:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm76084527wrr.80.2020.01.07.05.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 05:53:14 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B66F1FF90;
 Tue,  7 Jan 2020 13:53:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/6] freebsd: use python37
Date: Tue,  7 Jan 2020 13:53:08 +0000
Message-Id: <20200107135311.5215-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107135311.5215-1-alex.bennee@linaro.org>
References: <20200107135311.5215-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

FreeBSD seems to use python37 by default now, which breaks the build
script.  Add python to the package list, to explicitly pick the version,
and also adapt the configure command line.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200106123746.18201-1-kraxel@redhat.com>
---
 tests/vm/freebsd | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 1825cc58218..33a736298a9 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -32,6 +32,7 @@ class FreeBSDVM(basevm.BaseVM):
         "git",
         "pkgconf",
         "bzip2",
+        "python37",
 
         # gnu tools
         "bash",
@@ -63,7 +64,7 @@ class FreeBSDVM(basevm.BaseVM):
         mkdir src build; cd src;
         tar -xf /dev/vtbd1;
         cd ../build
-        ../src/configure --python=python3.6 {configure_opts};
+        ../src/configure --python=python3.7 {configure_opts};
         gmake --output-sync -j{jobs} {target} {verbose};
     """
 
-- 
2.20.1


