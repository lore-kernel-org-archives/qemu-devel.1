Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B933C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596E02083E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsF0c58M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596E02083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtXV-00076P-As
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtU2-0001oX-2Q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHtU0-0000ji-Vm
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:29 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHtU0-0000ip-Pw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:13:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id d5so12606097wrn.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mFcHuHvBSlpN6GNuePYdv4kQDYYjvabQ2NuBORJmALw=;
 b=WsF0c58MkcHb9XoDr0jA/5/kGC60lc7fehFaPkLVtrE1lLp/Sl99Aj8b0e2Cft+TIA
 R085JqFWM21awGJxIG869OoGVlpX2ptp49NEgY2axWY6wBjfFaQCbAMs+aHr23m9AgHf
 momcbsfLJKqBOidlUwo+sPF80b4cWIZkOg3SBZ/UYVgzilpVr5vzhMLQL+8SFrq3XSIW
 9AxKDhZ4shkcIdTW8O/lt4QOfjBa0mh6g/yyou99gAIUN0fEmFJltofaruBc4svIRzYg
 kHpCHNPZJmnESIb393mnU2bk4nEN37FMGSypzkeYU5nkLQqKaWSUirRjys/r3yHTDEhC
 88mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mFcHuHvBSlpN6GNuePYdv4kQDYYjvabQ2NuBORJmALw=;
 b=EN0lE5RD44Ge4hPiOMyV1DY5QakvAGcv7DAXq9OHhT26+b42vHCrIZpDLZ/RcsOKg6
 xDd+mumFgwkNmKFR7FRCYcn4jFJJydSfyV3Ck/KhC1MW1V+jQ1N7jUriRGwKkh3nhJGQ
 H6VG0a199T5qxP0oOFe6nzOhHxFepK8KcWhzA/nXYCH3oqMDuUykvy0mDsr+Qvsbzcgj
 6yEDXtDCMepXjthOmd57FV8MkupvIXr/eNu8oe5MBhxqb97XUfgUETZkSmsj5erp4GvU
 J+MaafBvKl8YRLGjS+Ib2/WC+aah53ehpEmXjlN+vT9OB34END+ZqlNO0xmwJcFUJKyT
 0jUw==
X-Gm-Message-State: ANhLgQ3oIZHyJ4uSbE9GFbhBqw2ZYV74mkqdNuuoxhlqxBCoYaqxeVum
 VNrpBHmAJ7nhRZHoPi5f20USJQ==
X-Google-Smtp-Source: ADFU+vvdB/vZqJiURq2RjIABjdwcFmvbcahrbN/JHC59GlXi8Qm01l0HBRs0tVS4JnXqWcmmhydDaQ==
X-Received: by 2002:a5d:4489:: with SMTP id j9mr648774wrq.161.1585332807754;
 Fri, 27 Mar 2020 11:13:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i21sm9468489wmb.23.2020.03.27.11.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 11:13:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A224E1FF90;
 Fri, 27 Mar 2020 18:13:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 04/12] tests/vm: update FreeBSD to 12.1
Date: Fri, 27 Mar 2020 18:13:12 +0000
Message-Id: <20200327181320.23329-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327181320.23329-1-alex.bennee@linaro.org>
References: <20200327181320.23329-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200310083218.26355-4-kraxel@redhat.com>
Message-Id: <20200323161514.23952-4-alex.bennee@linaro.org>

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 58166766d91..298967fe9cf 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -24,8 +24,8 @@ class FreeBSDVM(basevm.BaseVM):
     name = "freebsd"
     arch = "x86_64"
 
-    link = "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.0/FreeBSD-12.0-RELEASE-amd64-disc1.iso.xz"
-    csum = "1d40015bea89d05b8bd13e2ed80c40b522a9ec1abd8e7c8b80954fb485fb99db"
+    link = "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.1/FreeBSD-12.1-RELEASE-amd64-disc1.iso.xz"
+    csum = "7394c3f60a1e236e7bd3a05809cf43ae39a3b8e5d42d782004cf2f26b1cfcd88"
     size = "20G"
     pkgs = [
         # build tools
-- 
2.20.1


