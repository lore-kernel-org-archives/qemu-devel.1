Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12328C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A2720657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lt7KnZml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A2720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVlz-0001B1-0w
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZVkn-0007po-GF
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:31:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38486
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZVkk-0001Ca-O3
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589531493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUhl28kyM04kbZr48EV0Nb+K9BzUOF07Xrj8L3H0dtY=;
 b=Lt7KnZmlSckxKAAiJyJER6Dmqy6Zj/VURXLAu/djdWKoulH7V8WK7w4JriOwAeLct3iU5Y
 MKLxA996n4C7QGCMCd1F48x4sLpC+/DnHcMGsOs5I++05bRPfmngwu4AB9vaUbxqtrUen5
 aWkKGMKTp4ayQZ+JLu64p2SHAf/I+vA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-C7NwHea9OnWx1e6aPFxj0A-1; Fri, 15 May 2020 04:31:32 -0400
X-MC-Unique: C7NwHea9OnWx1e6aPFxj0A-1
Received: by mail-wm1-f71.google.com with SMTP id g10so834599wme.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 01:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VUhl28kyM04kbZr48EV0Nb+K9BzUOF07Xrj8L3H0dtY=;
 b=PDtNAEn/pE6DN11Q85CHPaIYO/Y2jT2//n7F68n0YwBD+JUR9rBOXIFu5tvSu7cBNW
 ER//6OGIKnlqY+QXBbQxVxUq6wpwkYHRZNPhDhXcbYo7Cw0rmbYs5Iu/400awpB3gnHE
 Pfy3dk7/C2vK2gNmIBu5QEzN9svLecrOdIXr60wgil+u0T2AvTcYOilt6RdWbAq9MlkQ
 Xt5HNhpftMdwc7jGB8YfuFfbXWRWtwBJfukFa/Jvwv2AU2elyFYBJR5Y+tThGC/n/kFu
 rX1/U1iyu6oviGdioeY0A3VX03Ryvb737Yh4A2Eiphb20k5MR+L/3zVXxsmeXobgZdtk
 Dsww==
X-Gm-Message-State: AOAM533do4oC2EYh+sXWAFEkbNVmAKITcbvWOcMqqazZq+Hz7ItU7CqW
 ezfAatm+B6h7Tutvarkpo58Jzzf1QpHY5wsAAu+yNPFpjjJQlLlSQ+10gA1Jft/xthi6/Gm/BSI
 9g/Lz3ajpTH80a8w=
X-Received: by 2002:adf:a35c:: with SMTP id d28mr2842207wrb.37.1589531491023; 
 Fri, 15 May 2020 01:31:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRU7dd51lKTnbbL+7aOlI17MpqBPJ2uDJaEvED7KxtwzYrYPdaGJ4YQPdnDl4o4T5n4C548A==
X-Received: by 2002:adf:a35c:: with SMTP id d28mr2842183wrb.37.1589531490769; 
 Fri, 15 May 2020 01:31:30 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g24sm2659755wrb.35.2020.05.15.01.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 01:31:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests/docker: Remove flex/bison packages
Date: Fri, 15 May 2020 10:31:23 +0200
Message-Id: <20200515083124.5536-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515083124.5536-1-philmd@redhat.com>
References: <20200515083124.5536-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does use flex/bison packages.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


