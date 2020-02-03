Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C07C3524A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B1C20679
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvsMFnAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B1C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iySLb-0007kD-RS
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 22:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iySKq-0006wE-IN
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iySKn-0006bX-O5
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:23:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24668
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iySKn-0006ZE-CM
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580700215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xSfVzIY2Eh/M2qcokLoz7G/taN1bzWjWGQ7jvg3vPb4=;
 b=TvsMFnAK7zBDplXHKQYS7zF3DR+hQeB/qg5qYQ3CpTQcUy5VvHZpFgPRXbB426SpxLwZyc
 ehwuMi+THnvkLi7FPbeDAxsORgeuuMBHWpEdAKdp8mb9rrphYqo5tB/0wFUP2EQNYLk5k0
 ETpruZHj4c1NwLLtbDpU/rspSb+hvKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-Px9fIAG-PIifkpwDKOMwaA-1; Sun, 02 Feb 2020 22:23:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F31C1005510;
 Mon,  3 Feb 2020 03:23:30 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-247.rdu2.redhat.com
 [10.10.120.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D38F786C4A;
 Mon,  3 Feb 2020 03:23:29 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/2] GitLab CI: avoid calling before_scripts on unintended
 jobs
Date: Sun,  2 Feb 2020 22:23:27 -0500
Message-Id: <20200203032328.12051-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Px9fIAG-PIifkpwDKOMwaA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At this point it seems that all jobs depend on those steps, with
maybe the EDK2 jobs as exceptions.

The jobs that will be added will not want those scripts to be
run, so let's move these steps to the appropriate jobs, while
still trying to avoid repetition.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .gitlab-ci.yml | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 228783993e..d2c7d2198e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,11 +1,10 @@
 include:
   - local: '/.gitlab-ci-edk2.yml'
=20
-before_script:
+build-system1:
+ before_script: &before_scr_apt
  - apt-get update -qq
  - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev geniso=
image
-
-build-system1:
  script:
  - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
       libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdepl=
ug-dev
@@ -18,6 +17,8 @@ build-system1:
  - make -j2 check
=20
 build-system2:
+ before_script:
+  *before_scr_apt
  script:
  - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio-d=
ev
       libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
@@ -30,6 +31,8 @@ build-system2:
  - make -j2 check
=20
 build-disabled:
+ before_script:
+  *before_scr_apt
  script:
  - mkdir build
  - cd build
@@ -44,6 +47,8 @@ build-disabled:
  - make -j2 check-qtest SPEED=3Dslow
=20
 build-tcg-disabled:
+ before_script:
+  *before_scr_apt
  script:
  - apt-get install -y -qq clang libgtk-3-dev libusb-dev
  - mkdir build
@@ -62,6 +67,8 @@ build-tcg-disabled:
             248 250 254 255 256
=20
 build-user:
+ before_script:
+  *before_scr_apt
  script:
  - mkdir build
  - cd build
@@ -71,6 +78,8 @@ build-user:
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
=20
 build-clang:
+ before_script:
+  *before_scr_apt
  script:
  - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-ng-dev
       xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev librbd=
-dev
@@ -83,6 +92,8 @@ build-clang:
  - make -j2 check
=20
 build-tci:
+ before_script:
+  *before_scr_apt
  script:
  - TARGETS=3D"aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86=
_64"
  - mkdir build
--=20
2.21.1


