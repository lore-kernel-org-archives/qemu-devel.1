Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A796AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C6C2075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+7pIAYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C6C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5nV-0004bz-JL
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5ko-0007wZ-0w
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5kl-0005lG-8s
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:33 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5kk-0005iY-9e
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:31 -0500
Received: by mail-wr1-x431.google.com with SMTP id q10so3579080wrm.11
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rEefxeUNNS2j/aJvCCEEz4ubbk9y+0Pqz8JBjFY76jc=;
 b=h+7pIAYJlLuYKaAVcf20uMcHY1GL4Wfgml3KsKrMpUeRiOKbl/9KgArkBjE/g5pXBS
 h4IqepB3n8LGvleNK9CZ8j47Tt5Ax46ER/zJi6P43a0kP0J8nLXuPhJzPITZcsjHdKjJ
 5TrA/ucWVjsNiV7Bi1tGxvbuzzc15O7OzY2VAvg07d1kuUS5Zptni+OZon12Xmzeor9D
 F6aEt1eNK8fHalzrH+PnISEtRHDhFb5bT2rUlHhYSPtVUdfoVm3w45VxpEixcAm7Dll/
 F/7eCtn8kjXeTb4kigtL/daulW2XeT2opBw9NENOvzrbHVOAY/yLz1dYl1SY0YLgeNqV
 4Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rEefxeUNNS2j/aJvCCEEz4ubbk9y+0Pqz8JBjFY76jc=;
 b=HT0EIf0ZyIwCp670QJSZ+BA0Wuq6UP0U62/EqbnubrOf1auUiwkUtP2AbBCdhohYnd
 xXIR3vWUWREYjM8f+9QFNoZEz7gP98lQJr9G8XwV2uQlEoo35E/wJZ0rkpKOoQi/d81/
 aDDdSfNXS9ndYH8PLKxKM7BynbUIbfR405ZM06R1pbGVgsYddSFcZUEExp0GU6Kd/Wg7
 4K7QJXoYN30n7uZS0GUVg/uWhoggkKUbtRlnh6TLc758gBlOEkjxMl4mA7PCoTglxaFw
 5vV8bnAx2mgJSOORPKeMVhEyWsDywS7TwDIEgc2bg8+Cyqz7IB6YIr6g3m5Gavz1B5BM
 dnKg==
X-Gm-Message-State: APjAAAUF+Ll63kohB4wBWSOs4fH2QvZOFFUoKl9Pxp+07W5i29TdC6g2
 SzvyZ5yXcAiKTH0H5GC5u52Jgg==
X-Google-Smtp-Source: APXvYqzdZ2e73x9HvdZuWCLAlVjljhxjufGr1jMT6EbhGdAnBNK9v6fwly5pciBcL4CTNIbawalCRg==
X-Received: by 2002:adf:e683:: with SMTP id r3mr6684708wrm.38.1579898428753;
 Fri, 24 Jan 2020 12:40:28 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p15sm7751750wma.40.2020.01.24.12.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:27 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5E0041FF87;
 Fri, 24 Jan 2020 20:40:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 00/13] docker multiarch awareness
Date: Fri, 24 Jan 2020 20:40:13 +0000
Message-Id: <20200124204026.2107-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is a series I've had on the back-burner for awhile. The idea is
to make the docker build system fully multiarch aware. Much like the
check-tcg system this involves a bunch of included Makefile
fragments. It also tries to address the need to track docker
dependencies in the Makefile explicitly by allowing more automatic
resolution.

One area where I'd like advice is if we should bother to make the
build targets backwards compatible - or is it fair to ask developers
to go through the pain of retraining their brains for the more regular
naming:

  make docker-test-build@debian10-arm64-build-qemu J=30

I've included testing/next out of completeness.

Alex Bennée (11):
  tests/docker: move most cross compilers to buster base
  tests/docker: better handle symlinked libs
  .shippable: --disable-docs for cross-compile tests
  tests/docker: move all cross-compilers images into dockerfiles.cross
  tests/docker: move all multiarch containers into dockerfiles.multiarch
  tests/docker: search the tests/docker tree to inline parent dockerfile
  tests/docker: switch to multiarch aware container support
  tests/docker: add debian10-native-qemu-build
  tests/docker: rename the cross builds
  tests/docker: re-enable cross-compiling for x86_64 hosts
  tests/docker: enable cross-compilers for aarch64

Thomas Huth (1):
  gitlab-ci: Refresh the list of iotests

Wainer dos Santos Moschetta (1):
  travis.yml: Install genisoimage package

 .gitlab-ci.yml                                |  12 +-
 .shippable.yml                                |   2 +-
 .travis.yml                                   |   8 ++
 tests/docker/Makefile.include                 | 126 +++++++-----------
 tests/docker/docker.py                        |  12 +-
 .../dockerfiles.aarch64/Makefile.include      |  24 ++++
 .../debian10-aarch64-qemu-build.docker        |   1 +
 .../debian10-alpha-test-build.docker          |   1 +
 .../debian10-x86_64-qemu-build.docker         |   1 +
 .../debian9-armel-qemu-build.docker           |   1 +
 .../debian10-alpha-build-tests.docker}        |   0
 .../debian10-amd64-build-qemu.docker}         |   0
 .../debian10-arm64-build-qemu.docker}         |   0
 .../debian10-armel-build-qemu.docker}         |   2 +-
 .../debian10-armhf-build-qemu.docker}         |   2 +-
 .../debian10-hppa-build-tests.docker}         |   0
 .../debian10-m68k-build-tests.docker}         |   0
 .../debian10-mips-build-qemu.docker}          |   0
 .../debian10-mips64-build-tests.docker}       |   0
 .../debian10-mips64el-build-qemu.docker}      |   2 +-
 .../debian10-mipsel-build-qemu.docker}        |   2 +-
 .../debian10-powerpc-build-tests.docker}      |   0
 .../debian10-ppc64-build-tests.docker}        |   0
 .../debian10-ppc64el-build-qemu.docker}       |   2 +-
 .../debian10-riscv64-build-tests.docker}      |   0
 .../debian10-s390x-build-qemu.docker}         |   2 +-
 .../debian10-sh4-build-tests.docker}          |   0
 .../debian10-sparc64-build-tests.docker}      |   0
 .../debian9-tricore-build-tests.docker}       |   0
 .../debian9-xtensa-build-tests.docker}        |   0
 .../fedora-cris-build-tests.docker}           |   0
 .../fedora-i386-build-qemu.docker}            |   0
 .../dockerfiles.multiarch/Makefile.include    |  17 +++
 .../debian10.docker                           |   0
 .../debian9.docker                            |   0
 .../dockerfiles.x86_64/Makefile.include       |  26 ++++
 .../debain10-x86_64-qemu-build.docker         |   1 +
 .../debian10-alpha-build-tests.docker         |   1 +
 .../debian10-amd64-build-qemu.docker          |   1 +
 .../debian10-arm64-build-qemu.docker          |   1 +
 .../debian10-armel-build-qemu.docker          |   1 +
 .../debian10-armhf-build-qemu.docker          |   1 +
 .../debian10-hppa-build-tests.docker          |   1 +
 .../debian10-m68k-build-tests.docker          |   1 +
 .../debian10-mips-build-qemu.docker           |   1 +
 .../debian10-mips64-build-tests.docker        |   1 +
 .../debian10-mips64el-build-qemu.docker       |   1 +
 .../debian10-mipsel-build-qemu.docker         |   1 +
 .../debian10-native-qemu-build.docker         |   1 +
 .../debian10-powerpc-build-tests.docker       |   1 +
 .../debian10-ppc64-build-tests.docker         |   1 +
 .../debian10-ppc64el-build-qemu.docker        |   1 +
 .../debian10-riscv64-build-tests.docker       |   1 +
 .../debian10-s390x-build-qemu.docker          |   1 +
 .../debian10-sh4-build-tests.docker           |   1 +
 .../debian10-sparc64-build-tests.docker       |   1 +
 .../debian9-mxe-win32-build-qemu.docker}      |   0
 .../debian9-mxe-win64-build-qemu.docker}      |   0
 .../debian9-mxe.docker                        |   0
 .../debian9-tricore-build-tests.docker        |   1 +
 .../debian9-xtensa-build-tests.docker         |   1 +
 .../fedora-cris-build-tests.docker            |   1 +
 .../fedora-i386-build-tests.docker            |   1 +
 .../travis.docker                             |   0
 tests/docker/dockerfiles/debian-amd64.docker  |   2 +-
 .../debian10-native-qemu-build.docker         |  15 +++
 tests/tcg/configure.sh                        |  38 +++---
 67 files changed, 204 insertions(+), 118 deletions(-)
 create mode 100644 tests/docker/dockerfiles.aarch64/Makefile.include
 create mode 120000 tests/docker/dockerfiles.aarch64/debian10-aarch64-qemu-build.docker
 create mode 120000 tests/docker/dockerfiles.aarch64/debian10-alpha-test-build.docker
 create mode 120000 tests/docker/dockerfiles.aarch64/debian10-x86_64-qemu-build.docker
 create mode 120000 tests/docker/dockerfiles.aarch64/debian9-armel-qemu-build.docker
 rename tests/docker/{dockerfiles/debian-alpha-cross.docker => dockerfiles.cross/debian10-alpha-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/debian-amd64-cross.docker => dockerfiles.cross/debian10-amd64-build-qemu.docker} (100%)
 rename tests/docker/{dockerfiles/debian-arm64-cross.docker => dockerfiles.cross/debian10-arm64-build-qemu.docker} (100%)
 rename tests/docker/{dockerfiles/debian-armel-cross.docker => dockerfiles.cross/debian10-armel-build-qemu.docker} (97%)
 rename tests/docker/{dockerfiles/debian-armhf-cross.docker => dockerfiles.cross/debian10-armhf-build-qemu.docker} (97%)
 rename tests/docker/{dockerfiles/debian-hppa-cross.docker => dockerfiles.cross/debian10-hppa-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/debian-m68k-cross.docker => dockerfiles.cross/debian10-m68k-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/debian-mips-cross.docker => dockerfiles.cross/debian10-mips-build-qemu.docker} (100%)
 rename tests/docker/{dockerfiles/debian-mips64-cross.docker => dockerfiles.cross/debian10-mips64-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/debian-mips64el-cross.docker => dockerfiles.cross/debian10-mips64el-build-qemu.docker} (98%)
 rename tests/docker/{dockerfiles/debian-mipsel-cross.docker => dockerfiles.cross/debian10-mipsel-build-qemu.docker} (97%)
 rename tests/docker/{dockerfiles/debian-powerpc-cross.docker => dockerfiles.cross/debian10-powerpc-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/debian-ppc64-cross.docker => dockerfiles.cross/debian10-ppc64-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/debian-ppc64el-cross.docker => dockerfiles.cross/debian10-ppc64el-build-qemu.docker} (97%)
 rename tests/docker/{dockerfiles/debian-riscv64-cross.docker => dockerfiles.cross/debian10-riscv64-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/debian-s390x-cross.docker => dockerfiles.cross/debian10-s390x-build-qemu.docker} (98%)
 rename tests/docker/{dockerfiles/debian-sh4-cross.docker => dockerfiles.cross/debian10-sh4-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/debian-sparc64-cross.docker => dockerfiles.cross/debian10-sparc64-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/debian-tricore-cross.docker => dockerfiles.cross/debian9-tricore-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/debian-xtensa-cross.docker => dockerfiles.cross/debian9-xtensa-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/fedora-cris-cross.docker => dockerfiles.cross/fedora-cris-build-tests.docker} (100%)
 rename tests/docker/{dockerfiles/fedora-i386-cross.docker => dockerfiles.cross/fedora-i386-build-qemu.docker} (100%)
 create mode 100644 tests/docker/dockerfiles.multiarch/Makefile.include
 rename tests/docker/{dockerfiles => dockerfiles.multiarch}/debian10.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.multiarch}/debian9.docker (100%)
 create mode 100644 tests/docker/dockerfiles.x86_64/Makefile.include
 create mode 120000 tests/docker/dockerfiles.x86_64/debain10-x86_64-qemu-build.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-alpha-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-amd64-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-arm64-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-armel-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-armhf-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-hppa-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-m68k-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips64-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mips64el-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-mipsel-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-native-qemu-build.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-powerpc-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-ppc64-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-ppc64el-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-riscv64-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-s390x-build-qemu.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-sh4-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian10-sparc64-build-tests.docker
 rename tests/docker/{dockerfiles/debian-win32-cross.docker => dockerfiles.x86_64/debian9-mxe-win32-build-qemu.docker} (100%)
 rename tests/docker/{dockerfiles/debian-win64-cross.docker => dockerfiles.x86_64/debian9-mxe-win64-build-qemu.docker} (100%)
 rename tests/docker/{dockerfiles => dockerfiles.x86_64}/debian9-mxe.docker (100%)
 create mode 120000 tests/docker/dockerfiles.x86_64/debian9-tricore-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/debian9-xtensa-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/fedora-cris-build-tests.docker
 create mode 120000 tests/docker/dockerfiles.x86_64/fedora-i386-build-tests.docker
 rename tests/docker/{dockerfiles => dockerfiles.x86_64}/travis.docker (100%)
 create mode 100644 tests/docker/dockerfiles/debian10-native-qemu-build.docker

-- 
2.20.1


