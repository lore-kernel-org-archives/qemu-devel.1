Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E04EC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01FE20767
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/3VrjJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01FE20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57963 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMz3-0006lc-2M
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 15:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFMy8-0005FO-8e
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFMy7-0000Q4-7c
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFMy7-0000Pr-3f
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584731166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64m8B2UB0OQtPH/xPaPLPPNVBYf+7O3z70ZNwLaWtY8=;
 b=D/3VrjJ+jm0OmTVa2bCCczdPJk+CDl3FzaMk4sTKFviiCzBbu4fFEi+rZEDAsMGjSN99TG
 6DayIxzUb+doFPtBK1l1JACPuC2yllfTnoY51Pdev3tBOykPHayZoT6ruHwNO/3BuszjUX
 CfAo20hRZM9Jxa8hUqurxHC2pSxkWA0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Xj-m3lwBNYOUaq3HHRQhvA-1; Fri, 20 Mar 2020 15:06:04 -0400
X-MC-Unique: Xj-m3lwBNYOUaq3HHRQhvA-1
Received: by mail-ed1-f69.google.com with SMTP id ce13so5856194edb.11
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 12:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fs7lcEzn6cPhH2KxpoF9rs1jMY7joUqJZjQQkVjATH4=;
 b=ZHL4JnV96kj6o8oiJSTWiDpVe8uaz7mh5yzrpIOVbtbSsXA/wvqoXgAULWNkHQpGAL
 IFzuVyRoPSD3qXuZIhicpQy14FB/HH5Nv8DcldFxY2OwtNxUnxfWAsLjiN78AzkT8qID
 pAW9gT15ncUiXU94ubsdHJC3uC/g2Tj83K/uU1keaJ1BcRU3bp6/IIFC0SvuN0IVJYYp
 WTcc05DD3avlL+KV76gArmr61v2l2EmdpEVdQYngAvRe/NS70ZY2SO3Gg9oWb0pXoICQ
 ORIGvXkUsHtt/lQQFczqaH56E1Ywh240WtiZocTxG/1VxzmvZwCKF7EeK6JPaVdXFWfp
 bd0Q==
X-Gm-Message-State: ANhLgQ2a+t8B9Oa55dPJStjaghWxE8qsstke8Krl8KG2jVE+RTGqmQRZ
 dcVNqc4kzXZFY+qzOXoGyx0jpOJAkEJZgjSqeb4f19djMWZn6i4PbaZ8ucI3iojOSuJvWdgBHBB
 Sy7XrZInRTO72E38=
X-Received: by 2002:a17:906:6b10:: with SMTP id
 q16mr9746882ejr.170.1584731163283; 
 Fri, 20 Mar 2020 12:06:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsf5mR/iNxr3WQpe0pmeMjOKKmZFYEkiFHY1qbDelB8tKFzx63r5hqDD06J6gZ5R5VEn925ww==
X-Received: by 2002:a17:906:6b10:: with SMTP id
 q16mr9746861ejr.170.1584731163020; 
 Fri, 20 Mar 2020 12:06:03 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id b7sm440503edy.74.2020.03.20.12.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 12:06:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] tests/docker: Keep package list sorted
Date: Fri, 20 Mar 2020 20:05:50 +0100
Message-Id: <20200320190553.9363-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320190553.9363-1-philmd@redhat.com>
References: <20200320190553.9363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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


