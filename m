Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B96C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00B721850
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvfzGaZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00B721850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXM43-0004pV-Ri
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXM0r-0000g9-FI
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXM0q-0003p0-0H
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:11:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32366
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXM0p-0003oR-PW
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574241059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f85FTNN9sITlVPII4AJxGY/EU9pXznh3IJDKH4G7MEk=;
 b=bvfzGaZoBJRWHHEBqfYKyxGt9p/EynWua9csIuC68bZSczShRExla21KMTAjh8WJ/ooG6E
 9wbLtV99Ts7No6m8CPPRx7RQv+gJFCBSnW1wS3NpBIvNzf84K1yMrADrc1sFYefwmTD8Zr
 zrpmEBs7geLtAqKAVZiQ4ULNvZWnowg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-yI5TY9YdOGOTyZrWX6S8zw-1; Wed, 20 Nov 2019 04:10:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F8AE80268C;
 Wed, 20 Nov 2019 09:10:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8087260BAA;
 Wed, 20 Nov 2019 09:10:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH for-5.0 4/4] Remove libbluetooth / bluez from the CI tests
Date: Wed, 20 Nov 2019 10:10:14 +0100
Message-Id: <20191120091014.16883-5-thuth@redhat.com>
In-Reply-To: <20191120091014.16883-1-thuth@redhat.com>
References: <20191120091014.16883-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: yI5TY9YdOGOTyZrWX6S8zw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: libvir-list@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the bluetooth code has been removed, we don't need to test
with this library anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml                             | 2 +-
 tests/docker/dockerfiles/fedora.docker     | 1 -
 tests/docker/dockerfiles/ubuntu.docker     | 1 -
 tests/docker/dockerfiles/ubuntu1804.docker | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index be57c6a454..a28e389794 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -36,7 +36,7 @@ build-disabled:
=20
 build-tcg-disabled:
  script:
- - apt-get install -y -qq clang libgtk-3-dev libbluetooth-dev libusb-dev
+ - apt-get install -y -qq clang libgtk-3-dev libusb-dev
  - ./configure --cc=3Dclang --enable-werror --disable-tcg --audio-drv-list=
=3D""
  - make -j2
  - make check-unit
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfi=
les/fedora.docker
index 4ddc7dd112..f143b26cf3 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -2,7 +2,6 @@ FROM fedora:30
 ENV PACKAGES \
     bc \
     bison \
-    bluez-libs-devel \
     brlapi-devel \
     bzip2 \
     bzip2-devel \
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfi=
les/ubuntu.docker
index f486492224..1b3b2693d2 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -19,7 +19,6 @@ ENV PACKAGES flex bison \
     glusterfs-common \
     libaio-dev \
     libattr1-dev \
-    libbluetooth-dev \
     libbrlapi-dev \
     libbz2-dev \
     libcacard-dev \
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dock=
erfiles/ubuntu1804.docker
index 3cc4f492c4..21a5f2c45c 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -8,7 +8,6 @@ ENV PACKAGES flex bison \
     glusterfs-common \
     libaio-dev \
     libattr1-dev \
-    libbluetooth-dev \
     libbrlapi-dev \
     libbz2-dev \
     libcacard-dev \
--=20
2.23.0


