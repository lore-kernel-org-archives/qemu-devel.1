Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96224C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A168206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYhCvq4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A168206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTeI-0000dY-G7
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jCTdP-0005zw-5j
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jCTdO-0007mk-5j
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:36:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35037
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jCTdO-0007mX-2B
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584041805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2qBNted8CFpYRl2d21kOkpTYOKH+hXz5AA/g+4M5bAw=;
 b=EYhCvq4IkGBMewq5lDGFZnP0pWCgP1rHoFjW7URBtaic8fqCQf3f+EgCOGHpwEi0VloRjs
 r0Dl0e5bUu5EePHafE57i6+zHzOjrTRbvP9Mi6uyHZM6unOaxlWZVg8lN8QiVPQ92knY9x
 04Cwy4gAILYKQRLd1OcwPHE3lROs6VI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-eZVfrXAzMs6WquwmRMVJvQ-1; Thu, 12 Mar 2020 15:36:41 -0400
X-MC-Unique: eZVfrXAzMs6WquwmRMVJvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD24A14E6;
 Thu, 12 Mar 2020 19:36:40 +0000 (UTC)
Received: from dhcp-17-173.bos.redhat.com (dhcp-17-173.bos.redhat.com
 [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF76563769;
 Thu, 12 Mar 2020 19:36:31 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH 1/5] tests/docker: add CentOS 8 Dockerfile
Date: Thu, 12 Mar 2020 15:36:12 -0400
Message-Id: <20200312193616.438922-2-crosa@redhat.com>
In-Reply-To: <20200312193616.438922-1-crosa@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Which is currenly missing, and will be referenced later in the
contributed CI playbooks.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/docker/dockerfiles/centos8.docker | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tests/docker/dockerfiles/centos8.docker

diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerf=
iles/centos8.docker
new file mode 100644
index 0000000000..bfa0d33c9c
--- /dev/null
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -0,0 +1,32 @@
+FROM centos:8.1.1911
+
+RUN dnf -y update
+ENV PACKAGES \
+    SDL-devel \
+    bison \
+    bzip2 \
+    bzip2-devel \
+    dbus-daemon \
+    flex \
+    gcc \
+    gcc-c++ \
+    gettext \
+    git \
+    glib2-devel \
+    libaio-devel \
+    libepoxy-devel \
+    lzo-devel \
+    make \
+    mesa-libEGL-devel \
+    nettle-devel \
+    perl-Test-Harness \
+    pixman-devel \
+    python36 \
+    rdma-core-devel \
+    spice-glib-devel \
+    spice-server \
+    tar \
+    zlib-devel
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
--=20
2.24.1


