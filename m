Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C441C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE49920409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3kpGCui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE49920409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPnE-0006Fd-14
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPje-0000yH-CC
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjd-0002Tn-AA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:30 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGPjd-0002TS-3t
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:29 -0400
Received: by mail-wr1-x42a.google.com with SMTP id 65so1131018wrl.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jwh2U1VHJxRVrhHOK85WLgBt5x8XbmkGGmHmSuT5roI=;
 b=s3kpGCuiiqF+o6I3pLEj+PjLWcOJx5I/r0/6uoRDmKSrF4xoDmEPzEYLQz8WsMHNwX
 2EvP2lko8O5G3eeFiKkTZsLvIdBQajdaZ6W6SEt924rVN4MiojiRotcw/OTG775mhpmJ
 +I64TXHT43D1x9a34IRgvLDX2qjhvUjE/bXbs2DKgBd54pQ9E/ur/CE6WXgewVF1bHaR
 YFjDOhs7EZWxyMw73AJPMRso/a1EaMM5H19seWhFo0aY0r/nz6fGpoj5pv44d5lq2Iwh
 U7o4Y0yqm90DcFD/4ZirPfbDIeuh2Jp106D0/USWXUWbbp48YppkbegI6wGB7l67pQKK
 t0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jwh2U1VHJxRVrhHOK85WLgBt5x8XbmkGGmHmSuT5roI=;
 b=pLZBvmGJ2b4rWhaNjX2gy9YhqbOuGhenHNCHofRzCX4DE+rj/bZR0fEoXSbD+G1G34
 yAQJtB/gVNek2WkYLgkBTSxJIe0VdV9ll55b0y3P0D3ktBN9K6wrcqkYCTZwyQA6H7I+
 qrbUbeeJDM/sPL+83XE6upapW4BoYc17G0MFBb8DEmAsw2s1bJFHhBPzigemdVOHngXH
 8rkKo0MIvt73JwI/XhswCkwtz2RLhMQB5+drHJQHdvbdmArrlulU+z2RX3y/5LVg2qSV
 TqhKgIbrXvnrjlVXGta1blXyK6rFfjjug1xHm4JXPCcz3GrdHvgyf9G0Ro+zZtB7UIkf
 u5Rg==
X-Gm-Message-State: ANhLgQ2a4NidGkiVyypbZFeRFQEE6CzwL66Bi1TjqmZvhqgT56X21l9X
 d+lbZwv/pzxOkq8mhv9qrAno8g==
X-Google-Smtp-Source: ADFU+vsDyDbFEqtYoa0j/GDxmk1jS3aGg/RQMo86MfsjghazcnF1esIRpUlHnAqHGw4zE41vxdjjQg==
X-Received: by 2002:adf:cd0c:: with SMTP id w12mr29686943wrm.234.1584980128185; 
 Mon, 23 Mar 2020 09:15:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q8sm25217706wrc.8.2020.03.23.09.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 09:15:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B0641FF98;
 Mon, 23 Mar 2020 16:15:16 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 09/11] tests/docker: Use Python3 PyYAML in the Fedora image
Date: Mon, 23 Mar 2020 16:15:12 +0000
Message-Id: <20200323161514.23952-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323161514.23952-1-alex.bennee@linaro.org>
References: <20200323161514.23952-1-alex.bennee@linaro.org>
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The Python2 PyYAML is now pointless, switch to the Python3 version.

Fixes: bcbf27947 (docker: move tests from python2 to python3)
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200322120104.21267-4-philmd@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 019eb12dcb1..174979c7af4 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -79,8 +79,8 @@ ENV PACKAGES \
     perl-Test-Harness \
     pixman-devel \
     python3 \
+    python3-PyYAML \
     python3-sphinx \
-    PyYAML \
     rdma-core-devel \
     SDL2-devel \
     snappy-devel \
-- 
2.20.1


