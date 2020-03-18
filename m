Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0FFC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7459A20663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKY/t5oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7459A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43635 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEMWF-00014N-M9
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 20:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jEMRE-0004PV-Bm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jEMRD-0008QK-5f
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:20:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jEMRC-0008Nj-VN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584490798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GTfeyMlA9NY0+2uIEce259/4FRhvDkYKEV84F8mWe8=;
 b=BKY/t5oyLzhQpve1KkohiMqMtJ6zB2aOnv/vdaZJ1Rzl0DwKLKZbPwrS9jeTU9dLMwZTj7
 gLJ1EIdauXXoyNk2Lz2s3qMsZ7Dt3sXwVyiDNJA92NIhnOMUJt7rtAxqPt8SueDJaSHFVL
 vvv5dm1cmXkAr/q1Fc7UI2AsMYC6+J8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-O-ACXTFsOVGqdOCI7pPYPA-1; Tue, 17 Mar 2020 20:19:56 -0400
X-MC-Unique: O-ACXTFsOVGqdOCI7pPYPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22FCA800D50;
 Wed, 18 Mar 2020 00:19:55 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-2.rdu2.redhat.com
 [10.10.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA4C610016EB;
 Wed, 18 Mar 2020 00:19:52 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 5/6] tests/docker: add CentOS 8 Dockerfile
Date: Tue, 17 Mar 2020 20:19:31 -0400
Message-Id: <20200318001932.180617-6-crosa@redhat.com>
In-Reply-To: <20200318001932.180617-1-crosa@redhat.com>
References: <20200318001932.180617-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Which is currenly missing, and will be referenced later in the
contributed CI playbooks.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20200312193616.438922-2-crosa@redhat.com>
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
2.25.1


