Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72553C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4873720659
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4873720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVcp-0001BA-Ow
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHVVV-0001kA-0n
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHVVO-0006ZY-IA
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:05:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHVVO-0006Yp-83
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:05:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 54EFC300501F;
 Mon,  7 Oct 2019 16:05:01 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D5BA1001B11;
 Mon,  7 Oct 2019 16:04:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] .travis.yml: Test the release tarball
Date: Mon,  7 Oct 2019 18:04:49 +0200
Message-Id: <20191007160450.3619-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 07 Oct 2019 16:05:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Bruce Rogers <brogers@suse.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a job to generate the release tarball and build/install few
QEMU targets from it.

Ideally we should build the 'efi' target from the 'roms' directory,
but it is too time consuming.

This job is only triggered when a tag starting with 'v' is pushed,
which is the case with release candidate tags.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: addressed mdroth comments

This job is quick enough: Ran for 16 min 33 sec
https://travis-ci.org/philmd/qemu/jobs/594565293

Based-on: <20191007133540.30623-1-philmd@redhat.com>
pull request including "Fix tarball builds of UEFI/EDK2 firmware"
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg02734.html
---
 .travis.yml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index d0b9e099b9..d881ea0849 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -339,3 +339,26 @@ matrix:
         - CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch64-s=
oftmmu,alpha-softmmu"
         - TEST_CMD=3D"make -j3 check-tcg V=3D1"
         - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
+
+
+    # Release builds
+    # The make-release script expect a QEMU version, so our tag must sta=
rt with a 'v'.
+    # This is the case when release candidate tags are created.
+    - if: tag IS present AND tag =3D~ /^v\d+\.\d+(\.\d+)?(-\S*)?$/
+      env:
+        # We want to build from the release tarball
+        - BUILD_DIR=3D"release/build/dir" SRC_DIR=3D"../../.."
+        - BASE_CONFIG=3D"--prefix=3D$PWD/dist"
+        - CONFIG=3D"--target-list=3Dx86_64-softmmu,aarch64-softmmu,armeb=
-linux-user,ppc-linux-user"
+        - TEST_CMD=3D"make install -j3"
+        - QEMU_VERSION=3D"${TRAVIS_TAG:1}"
+        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
+      before_script:
+        - command -v ccache && ccache --zero-stats
+        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
+      script:
+        - make -C ${SRC_DIR} qemu-${QEMU_VERSION}.tar.bz2
+        - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
+        - tar -xf ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2 && cd qemu-${Q=
EMU_VERSION}
+        - ./configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && ex=
it 1; }
+        - make install
--=20
2.21.0


