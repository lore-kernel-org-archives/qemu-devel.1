Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ED6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4F9206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ol5/MPiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4F9206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdMG-0000jR-Va
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEQ-0007om-Of
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:30:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48395
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEP-0001eQ-Q0
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589560240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KpPC+Vo6fnESSZd4i6ZDfGBgCvA6w/Q0ACqohTEQXX8=;
 b=Ol5/MPiqRhJ68NaNyZHoLFBtTiLg6PTtoZNvOmxR9NE3ozVMqbAdh06zkHOFkgGH1luvxr
 bcrYaOGs5hkMpnTpM+wnzHM9ai40/6RmyV2UNLOiqN1YM6ZhikTOkEqzuLLUiRhC4+e+qQ
 DfBKufiqIJ14bP/gFX8zhoDaAc28LEM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-gJlQ1eTCNkmw1Jj-nD5OuQ-1; Fri, 15 May 2020 12:30:39 -0400
X-MC-Unique: gJlQ1eTCNkmw1Jj-nD5OuQ-1
Received: by mail-wr1-f71.google.com with SMTP id e14so1426632wrv.11
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 09:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KpPC+Vo6fnESSZd4i6ZDfGBgCvA6w/Q0ACqohTEQXX8=;
 b=UjLMDseUSD87ukqx0fGHJ2qZL9rG6iw5ekRzH4Rgn2r2qYazRQYrRk3didtDhSaidT
 lN0sxnepNm5lMkQCk3ai2shtt4Mo4hZZAEHMK46DQtw5YICQxLCpQSLfAVUCtTD8c+1s
 QnI2ooT2uDQir1oLmAgeNG0RojTEy36NHrYFBhppPZyFqLUY8icfnXEbKLAHLgG40V+9
 AOVYSGIjp9g/DobO1m7E24z2yrV6NrVqOmPii62TVt3ctApVjgCAoYi+Ppb4kZ1kJ3cA
 TDMpjhfs3jhPRHP6D5SB8nYjX8hPxH8NUSLBkheea4y6JsQ7r+D8wHkXwUpY/fGlRsJF
 yJcA==
X-Gm-Message-State: AOAM530CT1wRIt/yS1nh1TU3Q2exPJLFtrV512v6DaPjnhMiFBALrJSi
 gwgwi1nrgvPdJSEZ27M4EPT+1LdLIEMnCix/9HJSRczON3FBlOy/ALBLN3Ua9RvzzxLT/PWktln
 ruSwOtpcVmCuvJdk=
X-Received: by 2002:a1c:408:: with SMTP id 8mr4550383wme.147.1589560237546;
 Fri, 15 May 2020 09:30:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyBAbcoqYhOWUMc/ko8b87s6Y1pfq3eBFI582M0/ELSStxxm3XS62Ry1qDsnIrHQNIexd1Fg==
X-Received: by 2002:a1c:408:: with SMTP id 8mr4550359wme.147.1589560237324;
 Fri, 15 May 2020 09:30:37 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d9sm4345041wmd.10.2020.05.15.09.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 09:30:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] tests/docker: Remove flex/bison packages
Date: Fri, 15 May 2020 18:30:25 +0200
Message-Id: <20200515163029.12917-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515163029.12917-1-philmd@redhat.com>
References: <20200515163029.12917-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does not use flex/bison packages.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: use 'does not' (Claudio)
---
 tests/docker/dockerfiles/centos7.docker             | 2 --
 tests/docker/dockerfiles/centos8.docker             | 2 --
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 --
 tests/docker/dockerfiles/debian10.docker            | 2 --
 tests/docker/dockerfiles/debian9.docker             | 2 --
 tests/docker/dockerfiles/fedora.docker              | 2 --
 tests/docker/dockerfiles/ubuntu.docker              | 2 +-
 tests/docker/dockerfiles/ubuntu1804.docker          | 2 +-
 8 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index 9a2a2e515d..e197acdc3c 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -5,13 +5,11 @@ RUN yum -y update
 
 # Please keep this list sorted alphabetically
 ENV PACKAGES \
-    bison \
     bzip2 \
     bzip2-devel \
     ccache \
     csnappy-devel \
     dbus-daemon \
-    flex \
     gcc-c++ \
     gcc \
     gettext \
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index bfa0d33c9c..9852c5b9ee 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -3,11 +3,9 @@ FROM centos:8.1.1911
 RUN dnf -y update
 ENV PACKAGES \
     SDL-devel \
-    bison \
     bzip2 \
     bzip2-devel \
     dbus-daemon \
-    flex \
     gcc \
     gcc-c++ \
     gettext \
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index e6f93f65ee..beb73f46ba 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -11,11 +11,9 @@ RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        bison \
         build-essential \
         ca-certificates \
         curl \
-        flex \
         gettext \
         git \
         python3-minimal
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index 0769700a41..bcdff04ddf 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -18,12 +18,10 @@ RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         bc \
-        bison \
         build-essential \
         ca-certificates \
         clang \
         dbus \
-        flex \
         gdb-multiarch \
         gettext \
         git \
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index 08cc970feb..0f0ebe530a 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -18,11 +18,9 @@ RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         bc \
-        bison \
         build-essential \
         ca-certificates \
         clang \
-        flex \
         gdb-multiarch \
         gettext \
         git \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 179575ecaa..92b6e11c8a 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -3,7 +3,6 @@ FROM fedora:30
 # Please keep this list sorted alphabetically
 ENV PACKAGES \
     bc \
-    bison \
     brlapi-devel \
     bzip2 \
     bzip2-devel \
@@ -13,7 +12,6 @@ ENV PACKAGES \
     dbus-daemon \
     device-mapper-multipath-devel \
     findutils \
-    flex \
     gcc \
     gcc-c++ \
     gettext \
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index eeb3b22bf2..90ea6311c6 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -10,7 +10,7 @@
 #
 
 FROM ubuntu:19.04
-ENV PACKAGES flex bison \
+ENV PACKAGES \
     ccache \
     clang \
     dbus \
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index f66b06f4cf..a10ea2850b 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -1,5 +1,5 @@
 FROM ubuntu:18.04
-ENV PACKAGES flex bison \
+ENV PACKAGES \
     ccache \
     clang \
     gcc \
-- 
2.21.3


