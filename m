Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B7EC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF59E206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5RQ/S2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF59E206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCTfV-0004Lh-VV
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 15:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jCTdc-0006zo-My
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jCTdb-0007s1-I3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:37:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jCTdb-0007ro-EN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584041819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVtqhaDz31hPkY62S3ERAd5gLcsSXZwSZmNt1nLa3ww=;
 b=Z5RQ/S2ydCwA9JaaZhKayx0hhIxRuSIGtpEQncLVIW/ZpuRvrNxAHqXQkQWxjIK/o5nzI5
 TgAZDo91FnCMjN3oYviVbc8TMZjK2vJcQLeLr/qL//aWjFB4cZ5a6Awswy3CPhVWN5QaGv
 yBFHIEkOXtfW0I/xCgmB41SzH1bO+OA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-pFxr24iPMYCpeOHrYcnXPw-1; Thu, 12 Mar 2020 15:36:55 -0400
X-MC-Unique: pFxr24iPMYCpeOHrYcnXPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA943801F88;
 Thu, 12 Mar 2020 19:36:53 +0000 (UTC)
Received: from dhcp-17-173.bos.redhat.com (dhcp-17-173.bos.redhat.com
 [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F34065C1B5;
 Thu, 12 Mar 2020 19:36:51 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH 3/5] GitLab CI: avoid calling before_scripts on unintended jobs
Date: Thu, 12 Mar 2020 15:36:14 -0400
Message-Id: <20200312193616.438922-4-crosa@redhat.com>
In-Reply-To: <20200312193616.438922-1-crosa@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

At this point it seems that all jobs depend on those steps, with
maybe the EDK2 jobs as exceptions.

The jobs that will be added will not want those scripts to be
run, so let's move these steps to the appropriate jobs, while
still trying to avoid repetition.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 72f8b8aa51..3ef1551273 100644
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
@@ -31,6 +32,8 @@ build-system2:
  - make -j2 check
=20
 build-disabled:
+ before_script:
+  *before_scr_apt
  script:
  - mkdir build
  - cd build
@@ -45,6 +48,8 @@ build-disabled:
  - make -j2 check-qtest SPEED=3Dslow
=20
 build-tcg-disabled:
+ before_script:
+  *before_scr_apt
  script:
  - apt-get install -y -qq clang libgtk-3-dev libusb-dev
  - mkdir build
@@ -63,6 +68,8 @@ build-tcg-disabled:
             260 261 262 263 264 270 272 273 277 279
=20
 build-user:
+ before_script:
+  *before_scr_apt
  script:
  - mkdir build
  - cd build
@@ -72,6 +79,8 @@ build-user:
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
=20
 build-clang:
+ before_script:
+  *before_scr_apt
  script:
  - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-ng-dev
       xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev librbd=
-dev
@@ -84,6 +93,8 @@ build-clang:
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
2.24.1


