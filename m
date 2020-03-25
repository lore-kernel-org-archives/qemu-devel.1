Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD19C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A52B20772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ap3g89TW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A52B20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7pp-0003cV-GG
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7lD-0003tD-03
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7l8-00084S-0W
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:16:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:34182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jH7l7-00082u-QQ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id 26so5175977wmk.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fDYf/1zmgKNKjKhgfcohx9pQW+K3uRqOoa+dvB2+KwU=;
 b=ap3g89TW5oitenk2RhM1bRY3+t+rXXQJ78jp01F0wjpcIrJSMgDTHlE01xr7rAMv+s
 0xs/tgYhtosn4JdgSikpVAWwslr7DaENMfN6CSus5iuIhs7PIqYwXuIr3DSZeft65me4
 u0uN28dxwn1cKZVawx2UTPqz/4FuGTq3jHDq7n61tcbO4y6vGWnCkDzWCUN+g33os+wN
 +aAWsU5DW56i9bMuJEc+UK0X8MuLm+3Smabypmi4Umu2SsTWE6Z5rcSbH/3JPJZijWZR
 GcnuC1wGK8aI2DI1TvFEiJtLSMylJyvkNTjWEBkdYgBdTy4yS2gnSPo8XiD+CHeaiHZS
 PfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fDYf/1zmgKNKjKhgfcohx9pQW+K3uRqOoa+dvB2+KwU=;
 b=na52ryuIViZ4XxFs5W+ywOjGeU05UEOMssrZURT4gk7lrgvjyPFGR0Ah51Z3iZYARN
 6CaFP6+kI+zYg1TD96vSlBdRhEEs+UPoyZIVuJOc7UKM1XrhCu3TKDivUz3XSLsXAENZ
 yoFBVQ8Wygmzy0HT4//nZxmLqnds0aigkXS1XdrILNPcc0qepOhlwUxCDyu4ezUYLxt+
 OkJaR2s0OvEFP7Scw64FIkqEcFfLqpSccqCKCH4TFEQMmqV455LyC0KFLP8IVpdhCYUv
 zoATmtd7/HkPScw31I0lzxoXuWAz0dRXb89FVO2Z0CxtZ6OSKlywhNCKaPsSCqkhra0E
 uxwg==
X-Gm-Message-State: ANhLgQ0Eo0zRVxqW4Q/80H4gF50ja8s8TA4lna+W+5ySSLLD9zqrgaeh
 xbSf3BqipvpV0JErFSbb4PHIzERj+HE=
X-Google-Smtp-Source: ADFU+vvJBgBPy6+k3/trpphC+S+pW0YaDTDXuebM8qL2yxmqRooXhejq0UFz8/QbkLZQ5nVUKLgcLQ==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr3910303wmf.107.1585149356801; 
 Wed, 25 Mar 2020 08:15:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u16sm34744270wro.23.2020.03.25.08.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:15:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E03241FF93;
 Wed, 25 Mar 2020 15:15:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 07/11] tests/docker: Keep package list sorted
Date: Wed, 25 Mar 2020 15:15:39 +0000
Message-Id: <20200325151543.32478-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325151543.32478-1-alex.bennee@linaro.org>
References: <20200325151543.32478-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Keep package list sorted, this eases rebase/cherry-pick.

Fixes: 3a6784813
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200322120104.21267-2-philmd@redhat.com>
Message-Id: <20200323161514.23952-8-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index cdd72de7ebf..9a2a2e515d7 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -2,6 +2,8 @@ FROM centos:7
 RUN yum install -y epel-release centos-release-xen-48
 
 RUN yum -y update
+
+# Please keep this list sorted alphabetically
 ENV PACKAGES \
     bison \
     bzip2 \
@@ -19,6 +21,7 @@ ENV PACKAGES \
     libepoxy-devel \
     libfdt-devel \
     librdmacm-devel \
+    libzstd-devel \
     lzo-devel \
     make \
     mesa-libEGL-devel \
@@ -33,7 +36,6 @@ ENV PACKAGES \
     tar \
     vte-devel \
     xen-devel \
-    zlib-devel \
-    libzstd-devel
+    zlib-devel
 RUN yum install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index a6522228c02..019eb12dcb1 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,6 @@
 FROM fedora:30
+
+# Please keep this list sorted alphabetically
 ENV PACKAGES \
     bc \
     bison \
@@ -38,6 +40,7 @@ ENV PACKAGES \
     libubsan \
     libusbx-devel \
     libxml2-devel \
+    libzstd-devel \
     llvm \
     lzo-devel \
     make \
@@ -92,8 +95,7 @@ ENV PACKAGES \
     vte291-devel \
     which \
     xen-devel \
-    zlib-devel \
-    libzstd-devel
+    zlib-devel
 ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
 
 RUN dnf install -y $PACKAGES
-- 
2.20.1


