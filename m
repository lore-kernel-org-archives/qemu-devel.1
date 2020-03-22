Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC6FC4332E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72CE2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9upL+om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72CE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFzKv-0003EV-PV
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 08:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFzI7-0000V9-6h
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFzI6-0001QB-5d
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFzI6-0001Q5-2U
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584878477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64m8B2UB0OQtPH/xPaPLPPNVBYf+7O3z70ZNwLaWtY8=;
 b=g9upL+omL+j4/fMk1w4hPlqIxPYYjgHJCCnBEGNpSUtsYnPwajQ+C+YndnWHIy6YW7PRfC
 0NdbJvb/ZIjgdPpLMtV1ndANOefBImYamgxjPhKzafVpnmN3CyycRe3HxPDZENEntJBeU/
 3Yihd8oNg7Ugxj6OLzoDLWmjKveMGz4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-b8Mh4N9VNval4RYMWhjGAQ-1; Sun, 22 Mar 2020 08:01:13 -0400
X-MC-Unique: b8Mh4N9VNval4RYMWhjGAQ-1
Received: by mail-wr1-f71.google.com with SMTP id w11so5708372wrp.20
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 05:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fs7lcEzn6cPhH2KxpoF9rs1jMY7joUqJZjQQkVjATH4=;
 b=k3Dvm81T74OlxSIZYZKSiEjHAVy1k7VCUdGScSo9juTdPoRCZ14b7Me4BM69zGZ/7+
 whKp1cpVXO8vDOgr9Ag2u69MaVukpCN6ecMHBinq2ewFquLW3bv3fIfgQOe8G+no3CIj
 WYSiL6HmCDlbdiPyJTl/X3aC4gAIGGp/AQeQzVTSq50sWAOz4x1hc4FHhfZy2+kkrpiP
 18WSepv0IbJVYfegJttPhOft8sFxJdne8CUQJZaiViWizdKtiHC/JCtbHHyHi6ebcYxZ
 h58M3l98G1zMraqVUTTdtLgkSaZnQEh9/wvdptCe7DIOfr2cFon/TxvYykBAPjvxpI67
 5x+A==
X-Gm-Message-State: ANhLgQ3anodZwcaMjudC2ZiuYKD1/l2mn1P3BgxvJZr0CsatZl7aDKvL
 yshxUGmHZ3yP7YjjLjQhw/dWlbing9FWmMU4dtOgbA14YK0k6uykRa6b221wzf8clZw1y6Rn/nU
 vFTJXSe6YjU3+OH8=
X-Received: by 2002:a05:600c:286:: with SMTP id
 6mr21774706wmk.56.1584878472396; 
 Sun, 22 Mar 2020 05:01:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsoI+SEbtgLQD0x06tR8tKC6SLXumVTaig0LwrWcvwkgrUuJnZp1uj/xk6WsiEfTyyvi+4bLA==
X-Received: by 2002:a05:600c:286:: with SMTP id
 6mr21774693wmk.56.1584878472208; 
 Sun, 22 Mar 2020 05:01:12 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id b80sm17430663wme.24.2020.03.22.05.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 05:01:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 1/4] tests/docker: Keep package list sorted
Date: Sun, 22 Mar 2020 13:01:01 +0100
Message-Id: <20200322120104.21267-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200322120104.21267-1-philmd@redhat.com>
References: <20200322120104.21267-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

Keep package list sorted, this eases rebase/cherry-pick.

Fixes: 3a6784813
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/centos7.docker | 6 ++++--
 tests/docker/dockerfiles/fedora.docker  | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerf=
iles/centos7.docker
index cdd72de7eb..9a2a2e515d 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -2,6 +2,8 @@ FROM centos:7
 RUN yum install -y epel-release centos-release-xen-48
=20
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
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfi=
les/fedora.docker
index a6522228c0..019eb12dcb 100644
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
 ENV QEMU_CONFIGURE_OPTS --python=3D/usr/bin/python3
=20
 RUN dnf install -y $PACKAGES
--=20
2.21.1


