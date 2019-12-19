Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83E4C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740D22465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ip/iydWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740D22465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtYi-0005xv-3M
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWa-0003io-Ao
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWZ-0000gz-1f
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:20 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtWY-0000a6-Ny
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:18 -0500
Received: by mail-wm1-x32c.google.com with SMTP id t14so5122389wmi.5
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=19SBTiRGWbT4vIjJk9Btd3tdZPysUx36M7Ps9JJHnt4=;
 b=ip/iydWfZAwQtCTh9V5ZyVbRlA6tbMomQDS9Qrd388MqjwC0pa1PDBE9N3U//ZpMNY
 Zmwpa/wmaeGDVbbKCklHDUVrR98T3pXDSxVIaLIVBanCzrwZMwJToMBtPnIXGFbqMXqH
 PmeEUN17iadP49iYyXJlwmvCJS1dhvZE6+GuidpgJ1D7+/CBXzKmr+2XjWJop8higKN8
 XPBVUdMgk5mi9mtzHji7uDFvK6DaY8p+d2aABuNcU5ejM9dkKKsJd68B9m1MZ1rP4UCL
 EA7nf5ymgqtWD4qzdPpTuXa6XqOiKbpYomRhvciDUqA6OqxiSXKzgeOq4A4oVTe0BEJp
 4YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=19SBTiRGWbT4vIjJk9Btd3tdZPysUx36M7Ps9JJHnt4=;
 b=oaoHwGjhUzov0pT6C8RP6e/Up6KQzOwFd6w7+WO1Feer9USXamFCUN9DXp6S0kSkOR
 bgWEimnnV0HrmhiGtr8wD9ANtkXZ/eEdmJFe98boBjKfP2AEVqShLJDLVgjd/qpuL3gh
 Wn/WbB3JHR8Q4ENhvwcaiwSvYITUoxNiGbeP4ZF2PZ3p+5zJkCXxj+/eSpvLxAv+3pon
 /OmcNEJ97FMU7gVgVGRkF6ZGaEhWDSFdkEskWZhZ95/+WVBfJmNZYE7+aMZIXmV93lCw
 /VF03OpALSyI/6U1pC41MysoyPDBT4hGxTOeyb4remdC7eFOwkv6WIsClEEfYrtqb3s2
 +yCw==
X-Gm-Message-State: APjAAAVRjN3oa8gF0kSyFfKlKiAIyLMqAfZI1mEF/vjAlqw60141pPH6
 013FzSVcnqQOPqJ8X8KPjFzJNA==
X-Google-Smtp-Source: APXvYqxyIr5owHGb0sZJEhjvLecVg8LKDTiPGu7p5bVH2HpkVR3QlpZmTlASQyrALHCcOiJnPn2BdQ==
X-Received: by 2002:a05:600c:20f:: with SMTP id
 15mr9373206wmi.128.1576753157565; 
 Thu, 19 Dec 2019 02:59:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v8sm6121247wrw.2.2019.12.19.02.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:59:15 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1C85A1FFA5;
 Thu, 19 Dec 2019 10:49:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 17/25] docker: gtester is no longer used
Date: Thu, 19 Dec 2019 10:49:26 +0000
Message-Id: <20191219104934.866-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

We are using tap-driver.pl, do not require anymore gtester to be installed
to run the testsuite in docker-based tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <1576632611-55032-1-git-send-email-pbonzini@redhat.com>

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 512202b0a19..02cd67a8c5e 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -53,12 +53,7 @@ check_qemu()
         INVOCATION="$@"
     fi
 
-    if command -v gtester > /dev/null 2>&1 && \
-           gtester --version > /dev/null 2>&1; then
-        make $MAKEFLAGS $INVOCATION
-    else
-        echo "No working gtester, skipping make $INVOCATION"
-    fi
+    make $MAKEFLAGS $INVOCATION
 }
 
 test_fail()
-- 
2.20.1


