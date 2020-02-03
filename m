Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9A0C3524A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE47720679
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 03:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4/4GjZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE47720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iySLn-00082z-2P
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 22:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iySKz-000792-P3
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iySKy-0006nb-2h
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:23:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45725
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iySKx-0006mY-Uw
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 22:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580700227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfUgKlR/8KIrFNbEyaLSZ2giQ7efZg8jwE2iQSoOOmc=;
 b=I4/4GjZk1WNPKQ6qiE71WuCWF74ZZFIY5oIngZEVld5cXJ9VpQyWfRgwcPhy/fbnZhRqmz
 PrmO1t+YSEtscnZWn1Si1DBuwitCK2a4y98cGgBAop503FJX/BeRVX7/OX0kGAdnwr0uVQ
 Cg+K5D43//YLEGMF5XNxCrY+vn9ZTro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-RfDZ_LAtNEitCobA7OZNug-1; Sun, 02 Feb 2020 22:23:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C3B186A075;
 Mon,  3 Feb 2020 03:23:31 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-247.rdu2.redhat.com
 [10.10.120.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 949BA86C4A;
 Mon,  3 Feb 2020 03:23:30 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
Date: Sun,  2 Feb 2020 22:23:28 -0500
Message-Id: <20200203032328.12051-2-crosa@redhat.com>
In-Reply-To: <20200203032328.12051-1-crosa@redhat.com>
References: <20200203032328.12051-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: RfDZ_LAtNEitCobA7OZNug-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a crude and straightforward mapping of Peter's
"remake-merge-builds" and "pull-buildtest" scripts.

Some characteristics were removed for simplicity sake (but eventually
will), including:
 * number of simultaneous make jobs
 * make's synchronous output, not needed because of previous point
 * out-of-tree builds

This covers the "x86-64 Linux with a variety of different build
configs"[1].  I've personally tested all of them, and only had
issues with the "notcg" job[2], but it seems to be a test specific
issue with the nested KVM I was using.

[1] - https://wiki.qemu.org/Requirements/GatingCI#Current_Tests
[2] - https://paste.centos.org/view/1dd43a1c

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .gitlab-ci.yml | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d2c7d2198e..eb4077e2ab 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -2,6 +2,8 @@ include:
   - local: '/.gitlab-ci-edk2.yml'
=20
 build-system1:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script: &before_scr_apt
  - apt-get update -qq
  - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev geniso=
image
@@ -17,6 +19,8 @@ build-system1:
  - make -j2 check
=20
 build-system2:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -31,6 +35,8 @@ build-system2:
  - make -j2 check
=20
 build-disabled:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -47,6 +53,8 @@ build-disabled:
  - make -j2 check-qtest SPEED=3Dslow
=20
 build-tcg-disabled:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -67,6 +75,8 @@ build-tcg-disabled:
             248 250 254 255 256
=20
 build-user:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -78,6 +88,8 @@ build-user:
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
=20
 build-clang:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -92,6 +104,8 @@ build-clang:
  - make -j2 check
=20
 build-tci:
+ rules:
+ - if: '$CI_COMMIT_REF_NAME !=3D "staging"'
  before_script:
   *before_scr_apt
  script:
@@ -111,3 +125,105 @@ build-tci:
  - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/qtest/p=
xe-test
  - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x"
    ./tests/qtest/pxe-test -m slow
+
+ubuntu-18.04.3-x86_64-notools:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n22
+ - ./configure --target-list=3Darm-softmmu --disable-tools --disable-libss=
h
+ # There is no make / make check in the "pull-buildtest" script for this.
+ # Question: should it at least be built? Or dropped?
+ - make
+
+ubuntu-18.04.3-x86_64-all-linux-static:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n25
+ - ./configure --enable-debug --static --disable-system --disable-glusterf=
s --disable-libssh
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n36
+ - make
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n45
+ - make check V=3D1
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n48
+ - make check-tcg V=3D1
+
+ubuntu-18.04.3-x86_64-all:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n26
+ - ./configure --disable-libssh
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n28
+ - make
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n37
+ - make check V=3D1
+
+ubuntu-18.04.3-x86_64-alldbg:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n27
+ - ./configure --disable-libssh
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n27
+ - make clean
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n29
+ - make
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n37
+ - make check V=3D1
+
+ubuntu-18.04.3-x86_64-clang:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n31
+ - ./configure --disable-libssh --cc=3Dclang --cxx=3Dclang++ --enable-gtk =
--extra-cflags=3D'-fsanitize=3Dundefined -fno-sanitize=3Dshift-base -Werror=
'
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n33
+ - make
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n39
+ - make check V=3D1
+
+ubuntu-18.04.3-x86_64-tci:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n33
+ - ./configure --disable-libssh --enable-debug --enable-tcg-interpreter
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n34
+ - make
+
+ubuntu-18.04.3-x86_64-notcg:
+ tags:
+ - ubuntu_18.04.3
+ - x86_64
+ rules:
+ - if: '$CI_COMMIT_REF_NAME =3D=3D "staging"'
+ script:
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/remak=
e-merge-builds#n35
+ - ./configure --disable-libssh --enable-debug --disable-tcg
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n35
+ - make
+ # https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/pull-=
buildtest#n39
+ # Question: check is disabled on the original script, because the machine
+ # is said to be running VirtualBox.  Should this be dropped or should the
+ # machine be tweaked or substituted?
+ - make check V=3D1
--=20
2.21.1


