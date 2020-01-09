Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B21C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA7420656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rp7ewkOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA7420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipYhc-0005CI-My
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeR-00011p-Mo
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipYeQ-0005i0-L1
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:07 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipYeQ-0005dY-By
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:19:06 -0500
Received: by mail-wr1-x431.google.com with SMTP id c14so7559817wrn.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GqdtWUWeRXAcQ+LI4RjLPvjzKZrpMw/yfqPf+ltlCJw=;
 b=rp7ewkOrR3LWfintaRTrm9deDs3J+mKVD9mGg9Jc+wytz8lwOpGng6arUxWL+V3xBf
 TMoDBvrWxq2nVlyIiVuAgtMRMaLz6c7y3ATiwZA364KGOyPt4pLtuK6c+SW6BW0519Tg
 Dz9ml+Aj/5k7vYcRqGjxQTn6qzxTc/3DvfBk5R5FUX7Rpw0tsQbjR17PZ0WJAeClQuuF
 T7fDxmbzAQI9OPEqvO0T1oaaUi3qEJWghY6tkma44/nRs0Y+26Y3/3ZLKF9steru1vLS
 M2f3oboQjAOLjRtB2hgFtW4I4KEBlR5mOXoICM7bwCV9qsHGS7YqV+IOwKrJHunrRSrL
 Sdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GqdtWUWeRXAcQ+LI4RjLPvjzKZrpMw/yfqPf+ltlCJw=;
 b=YxmG9zMffHdpg+s4qXkQjMnLbBOYDKlNhYlIIRC8Dm9sT6nHESRNPKqkwqglZ8BbUb
 Qkj6ubvXQh2HkZ8BqPWdfdNa7FuT9FwWfIwilaCdG6v/ibneTXw3VrfiwNtmfWFmRBNX
 1J96C3ZIxOfudvXPWjM/Xj0//WpiVWGoDCP0SzcluaLJ+//yeIkWrB24xg9MPxZyQSni
 3PqTn9RIxVCTa5itq1VAOKuNGo5ydP12BdEpWGmx2Vg/J2yuZcv4/5jx0r0AlSxz25pM
 BwH7dtmW6gB0t9WaSWPJOD/g6UHIwo3BIP8lAy07ELL7FZP7fjflRCOa4QVaR16b78J9
 AtHQ==
X-Gm-Message-State: APjAAAWY4oxMjpmh3ieyBEXdHJZpcO/VOziSwqcu8oVEFFLVdqYiENXs
 HE0F2UezlOdB4+JE4tQLpZGKwg==
X-Google-Smtp-Source: APXvYqy8AAiODGNXANmni/6xr6FAoFmKQxSKFRpCVIkbqKU81NtXovT4kZEdEKp8rLXe4qSDR4Cqaw==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr11331391wrs.184.1578579544586; 
 Thu, 09 Jan 2020 06:19:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm8888304wrp.93.2020.01.09.06.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:18:59 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 365441FF90;
 Thu,  9 Jan 2020 14:18:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 03/14] freebsd: use python37
Date: Thu,  9 Jan 2020 14:18:47 +0000
Message-Id: <20200109141858.14376-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109141858.14376-1-alex.bennee@linaro.org>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
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
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
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


