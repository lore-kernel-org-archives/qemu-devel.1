Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F80C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD374207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adiP0ZcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD374207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXz7-0004TO-I7
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioXOW-0004lY-UC
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioXOU-0003ES-Ik
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:46:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26563
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioXOU-0003EC-FL
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578336386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+x7G4JCLQje2QXs8EZmf9Rkm8tTIk53p9vFvwGwU7HI=;
 b=adiP0ZcTRmfJBjMjfS1rWJmbDin9i8Zg1laGqgrFgmszPR9qX9eiO9obzYB0x3O2p89c2w
 ai4i7/QwCQV/mWFas6wSuThPndAOsyqcPdtM4uzDwtTw9QLlHsREl+mt2OGN/s/2JCoscj
 kJL1eiDQXCb8W47W/ZqonAWjI0ZcDmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-QQTE08bBPZ21ibRs4Mq5tA-1; Mon, 06 Jan 2020 13:46:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C9FC100551A;
 Mon,  6 Jan 2020 18:46:21 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-53.brq.redhat.com [10.40.204.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAAA761076;
 Mon,  6 Jan 2020 18:46:16 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] gitlab-ci.yml: Add a job to build EDK2 firmware binaries
Date: Mon,  6 Jan 2020 19:46:00 +0100
Message-Id: <20200106184601.25453-3-philmd@redhat.com>
In-Reply-To: <20200106184601.25453-1-philmd@redhat.com>
References: <20200106184601.25453-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: QQTE08bBPZ21ibRs4Mq5tA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a GitLab job to build the EDK2 firmware binaries.
This job is only built when the roms/edk2/ submodule is updated,
when a git-ref starts with 'edk2' or when the last commit contains
'EDK2'.

GitLab CI generates an artifacts.zip file containing the firmware
binaries.

With edk2-stable201905, the job took 40 minutes 26 seconds,
the artifacts.zip takes 10MiB.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .gitlab-ci-edk2.yml | 37 +++++++++++++++++++++++++++++++++++++
 .gitlab-ci.yml      |  3 +++
 MAINTAINERS         |  3 ++-
 3 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 .gitlab-ci-edk2.yml

diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci-edk2.yml
new file mode 100644
index 0000000000..abfaf52874
--- /dev/null
+++ b/.gitlab-ci-edk2.yml
@@ -0,0 +1,37 @@
+build-edk2:
+ rules: # Only run this job when ...
+ - changes: # ... roms/edk2/ is modified (submodule updated)
+   - roms/edk2/*
+   when: always
+ - if: '$CI_COMMIT_REF_NAME =3D~ /^edk2/' # ... the branch/tag starts with=
 'edk2'
+   when: always
+ - if: '$CI_COMMIT_MESSAGE =3D~ /edk2/i' # last commit description contain=
s 'EDK2'
+   when: always
+ artifacts:
+   paths: # 'artifacts.zip' will contains the following files:
+   - pc-bios/edk2*bz2
+   - pc-bios/edk2-licenses.txt
+   - edk2-stdout.log
+   - edk2-stderr.log
+ image: ubuntu:16.04 # Use Ubuntu Xenial
+ before_script: # Install packages requiered to build EDK2
+ - apt-get update --quiet --quiet
+ - DEBIAN_FRONTEND=3Dnoninteractive
+   apt-get install --assume-yes --no-install-recommends --quiet --quiet
+     build-essential
+     ca-certificates
+     dos2unix
+     gcc-aarch64-linux-gnu
+     gcc-arm-linux-gnueabi
+     git
+     iasl
+     make
+     nasm
+     python
+     uuid-dev
+ script: # Clone the required submodules and build EDK2
+ - git submodule update --init roms/edk2
+ - git -C roms/edk2 submodule update --init
+ - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
+ - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
+ - make -j${JOBS} -C roms efi 1>edk2-stdout.log 2> >(tee -a edk2-stderr.lo=
g >&2)
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ebcef0ebe9..f799246047 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,3 +1,6 @@
+include:
+  - local: '/.gitlab-ci-edk2.yml'
+
 before_script:
  - apt-get update -qq
  - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev geniso=
image
diff --git a/MAINTAINERS b/MAINTAINERS
index 8571327881..22a1fd5824 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2346,6 +2346,7 @@ F: roms/edk2
 F: roms/edk2-*
 F: tests/data/uefi-boot-images/
 F: tests/uefi-test-tools/
+F: .gitlab-ci-edk2.yml
=20
 Usermode Emulation
 ------------------
@@ -2689,7 +2690,7 @@ W: https://cirrus-ci.com/github/qemu/qemu
 GitLab Continuous Integration
 M: Thomas Huth <thuth@redhat.com>
 S: Maintained
-F: .gitlab-ci.yml
+F: .gitlab-ci*.yml
=20
 Guest Test Compilation Support
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
--=20
2.21.1


