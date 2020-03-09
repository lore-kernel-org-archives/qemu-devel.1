Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C86C18E5A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76296208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="otYy7aEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76296208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKmI-0005B3-MI
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKa8-0002Yw-3S
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKa5-0001dm-Vb
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:39 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:38211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKa5-0001cu-PE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id t11so11833753wrw.5
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RXakKGJYlD5Zmh6y1LTMLfkcNLUz/wF1gxWzZbqUBNA=;
 b=otYy7aEpmcxrRr0o4Scr9n6HF2Twn7NHHLbhUIwbx0q1jYIULomKRBzi4d0EZHK8Jb
 WEAsXzXA4c/jy30PGkeSH/T2DabRjilp5jSg13ZPB7llpiemEHcjlbUHJD3WHOcoRp0k
 SD1v3k3Lj0ZJhVQTGJuXwsX8PkcQm6E3jB+1ulpvIkGhiHXL4day8EdauvQCBo5ETiwa
 8SCstrFDBGpFgfK39MQKrM1aKtaAA3PDNrqYwxgrRn+DyVU7SOYYU/eFpoRGbaDl/77T
 n6TSDXwxgltCMYUsP9cwBFZGVyKEYnAmKE7Drl6bWiv1Ekb5KFNJvchVgZvROcueJDU9
 S1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RXakKGJYlD5Zmh6y1LTMLfkcNLUz/wF1gxWzZbqUBNA=;
 b=cXTtXOG4KfuEur8tpqPDWqpiKkD6bSyhfSjld0AzdV89jV4vVFVX6HDHTJTieF4krN
 7OLicWZJ153bDoho9sTdoda0jQxA6jX/0kNNuhjNZOUJeEFBQQXzURxtwxPQidZp9TRM
 lDCRIWeLQ3tgjc8jqhfV8M0+szp5bwawuiM0+QGrvO8gSYaRk6lWfza0iYIOz0rVwHOu
 /r4K0qrxgbf7E6mG58Dvz7JWUCaxID7/gL8rxUXdBFFKG+KfMW6PVx+YFcBQeOqbLROu
 dUupU3XQzufE2kGdDbGuISLMY3IuDHz17B2/UYrwCdJhZS9/0kg9UbBWjyzJoJztowf6
 xfJg==
X-Gm-Message-State: ANhLgQ0/HLJXDctAWIdo9Igf5nP26HkexhgO864O8vg6g6dc94ds7hd1
 k/oe30bZ/9aq2OD4zDvxf7/E48uWAynJZA==
X-Google-Smtp-Source: ADFU+vvoRkeygxkFNjKVMvHhxJivHz2FCCZWZMwjQKXICghLrWUWx1bDp87/zqTpeqccwdSoDYm36g==
X-Received: by 2002:adf:e9c4:: with SMTP id l4mr9748038wrn.421.1583768676506; 
 Mon, 09 Mar 2020 08:44:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 18/18] Remove texinfo dependency from docker and CI configs
Date: Mon,  9 Mar 2020 15:44:05 +0000
Message-Id: <20200309154405.13548-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need texinfo to build the docs any more, so we can
drop that dependency from our docker and other CI configs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .travis.yml                                | 1 -
 tests/docker/dockerfiles/debian10.docker   | 1 -
 tests/docker/dockerfiles/debian9.docker    | 1 -
 tests/docker/dockerfiles/fedora.docker     | 1 -
 tests/docker/dockerfiles/ubuntu.docker     | 1 -
 tests/docker/dockerfiles/ubuntu1804.docker | 1 -
 6 files changed, 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index b92798ac3b9..71bee8d631c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -197,7 +197,6 @@ jobs:
         apt:
           packages:
             - python3-sphinx
-            - texinfo
             - perl
 
 
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index 5de79ae5527..f2744e18e5a 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -29,5 +29,4 @@ RUN apt update && \
         psmisc \
         python3 \
         python3-sphinx \
-        texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index 8cbd742bb5f..f08442a436a 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -28,5 +28,4 @@ RUN apt update && \
         psmisc \
         python3 \
         python3-sphinx \
-        texinfo \
         $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index a6522228c02..db38d5e4c4a 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -86,7 +86,6 @@ ENV PACKAGES \
     systemd-devel \
     systemtap-sdt-devel \
     tar \
-    texinfo \
     usbredir-devel \
     virglrenderer-devel \
     vte291-devel \
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index b6c7b41dddd..cfc55ed01c0 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -63,7 +63,6 @@ ENV PACKAGES flex bison \
     python3-yaml \
     python3-sphinx \
     sparse \
-    texinfo \
     xfslibs-dev
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index 1efedeef995..c265a952530 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -49,7 +49,6 @@ ENV PACKAGES flex bison \
     python3-yaml \
     python3-sphinx \
     sparse \
-    texinfo \
     xfslibs-dev
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
-- 
2.20.1


