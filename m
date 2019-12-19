Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAD6C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8D324650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZ/Zw7yO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8D324650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtR6-00044h-1g
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNP-0006ne-TV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNO-0000W6-5I
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:51 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNN-0000Qq-Pl
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:49 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so5127532wmb.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tQ2NW34S5Zq+7PW6zNueCL2QW+1AX6K9G7g3BN8KIko=;
 b=xZ/Zw7yO4Lp0lVJbtqEmg3+n5I4PSUdQn7YPjnTPCLRG139mI5qH2ya6oRi1kVzozA
 Tvxq+aqu5H30z37nmYv8TNlgml7eRLTA+i7T6v5iVLQ2Ko8Mm1mnctrvOZ5doIC8J6jT
 vXL6OJeB3tN01G9uHW5hHrFn/Wn7izQJK++2QoV5dvmbZ0zjEgX9RaCMOAYWn/zztjuq
 jwQln6XqmIYE1+tnbRVXvBpy9nDJeV64qx9I/hJaSQ396XY6m8NdACNJzkam/fRnsDW9
 6uhfWkHkjKEC+Fal5deegWM3rgqENxUVjdVr/0wxSdWKOl7N/+1gQOdjR/wiAjDAXu/9
 5CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tQ2NW34S5Zq+7PW6zNueCL2QW+1AX6K9G7g3BN8KIko=;
 b=iOGZJfy87v+x73ef5IlsM6O+c8SX/qx0JR8J92U5EuZD4ElcJtVjSdwZTDZOVbbGBu
 BEf4p+5h9qxTUgTQIw05VLVx8Md9z6QSHgVeOxjDDSExQAv0rRXti6DMXnfYCAdqoMEz
 /66dfAS9exLRD3grqnchfbVsc26xpjnzT4cOl9RozGHgpMRKcN+RIYf34s6hQPPr1cGj
 h49OOLTlSI6eZ6dnPFbB33Z2LuBtYs2hSXL7q0upn24D0/pB+aiOwe/NuLpoVISvComU
 jndBGudY56S/Y+KZvpenSEVrBpveJEeh0Kh3cHBpSPd9fWvjCtznGj0zUky2nlIqTEUC
 ZxSg==
X-Gm-Message-State: APjAAAVGiElXBDDntPvnpmurUbU0FkLyrskORXWIq+JMusvdv0Gwf8mV
 HXNJfGcxax8z0snqyD10GwNX2Q==
X-Google-Smtp-Source: APXvYqyWKS9MXTEWK/CWhBlsDiDzJNRyqjTS0niTLxhdr8lGdwfegz1aQYIRMJ6G1fMJLKuIb5Kt6g==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr9586505wmc.111.1576752588622; 
 Thu, 19 Dec 2019 02:49:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x11sm5790844wmg.46.2019.12.19.02.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:42 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5F6BF1FF9A;
 Thu, 19 Dec 2019 10:49:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/25] ci: build out-of-tree
Date: Thu, 19 Dec 2019 10:49:19 +0000
Message-Id: <20191219104934.866-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Most developers are using out-of-tree builds and it was discussed in the past
to only allow those.  To prepare for the transition, use out-of-tree builds
in all continuous integration jobs.

Based on a patch by Marc-André Lureau.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Li-Wen Hsu <lwhsu@freebsd.org>
Message-Id: <1576074829-56711-1-git-send-email-pbonzini@redhat.com>

diff --git a/configure b/configure
index e0c66ee9b68..93625811a05 100755
--- a/configure
+++ b/configure
@@ -6401,6 +6401,7 @@ else
 echo "local state directory   queried at runtime"
 echo "Windows SDK       $win_sdk"
 fi
+echo "Build directory   $(pwd)"
 echo "Source path       $source_path"
 echo "GIT binary        $git"
 echo "GIT submodules    $git_submodules"
diff --git a/.cirrus.yml b/.cirrus.yml
index 27efc48619b..90645fede6b 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -22,7 +22,9 @@ macos_task:
   install_script:
     - brew install pkg-config python gnu-sed glib pixman make sdl2
   script:
-    - ./configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
+    - mkdir build
+    - cd build
+    - ../configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check -j$(sysctl -n hw.ncpu)
 
@@ -33,6 +35,8 @@ macos_xcode_task:
   install_script:
     - brew install pkg-config gnu-sed glib pixman make sdl2
   script:
-    - ./configure --cc=clang || { cat config.log; exit 1; }
+    - mkdir build
+    - cd build
+    - ../configure --cc=clang || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check -j$(sysctl -n hw.ncpu)
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e3db1b847cc..ebcef0ebe9b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -6,7 +6,9 @@ build-system1:
  script:
  - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
       libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdeplug-dev
- - ./configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
+ - mkdir build
+ - cd build
+ - ../configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
       cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
       mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-softmmu"
  - make -j2
@@ -16,7 +18,9 @@ build-system2:
  script:
  - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio-dev
       libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
- - ./configure --enable-werror --target-list="tricore-softmmu unicore32-softmmu
+ - mkdir build
+ - cd build
+ - ../configure --enable-werror --target-list="tricore-softmmu unicore32-softmmu
       microblaze-softmmu mips-softmmu riscv32-softmmu s390x-softmmu sh4-softmmu
       sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k-softmmu"
  - make -j2
@@ -24,7 +28,9 @@ build-system2:
 
 build-disabled:
  script:
- - ./configure --enable-werror --disable-rdma --disable-slirp --disable-curl
+ - mkdir build
+ - cd build
+ - ../configure --enable-werror --disable-rdma --disable-slirp --disable-curl
       --disable-capstone --disable-live-block-migration --disable-glusterfs
       --disable-replication --disable-coroutine-pool --disable-smartcard
       --disable-guest-agent --disable-curses --disable-libxml2 --disable-tpm
@@ -37,7 +43,9 @@ build-disabled:
 build-tcg-disabled:
  script:
  - apt-get install -y -qq clang libgtk-3-dev libusb-dev
- - ./configure --cc=clang --enable-werror --disable-tcg --audio-drv-list=""
+ - mkdir build
+ - cd build
+ - ../configure --cc=clang --enable-werror --disable-tcg --audio-drv-list=""
  - make -j2
  - make check-unit
  - make check-qapi-schema
@@ -52,7 +60,9 @@ build-tcg-disabled:
 
 build-user:
  script:
- - ./configure --enable-werror --disable-system --disable-guest-agent
+ - mkdir build
+ - cd build
+ - ../configure --enable-werror --disable-system --disable-guest-agent
                --disable-capstone --disable-slirp --disable-fdt
  - make -j2
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
@@ -61,7 +71,9 @@ build-clang:
  script:
  - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-ng-dev
       xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev librbd-dev
- - ./configure --cc=clang --cxx=clang++ --enable-werror
+ - mkdir build
+ - cd build
+ - ../configure --cc=clang --cxx=clang++ --enable-werror
       --target-list="alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu
                      ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-user"
  - make -j2
@@ -70,7 +82,9 @@ build-clang:
 build-tci:
  script:
  - TARGETS="aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86_64"
- - ./configure --enable-tcg-interpreter
+ - mkdir build
+ - cd build
+ - ../configure --enable-tcg-interpreter
       --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
  - make -j2
  - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
diff --git a/.shippable.yml b/.shippable.yml
index f74a3de3ffd..83aae08bb4c 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -35,5 +35,7 @@ build:
     options: "-e HOME=/root"
   ci:
     - unset CC
-    - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
+    - mkdir build
+    - cd build
+    - ../configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
     - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))
diff --git a/.travis.yml b/.travis.yml
index b68566b1fe9..d673ee219e7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -73,8 +73,8 @@ notifications:
 
 env:
   global:
-    - SRC_DIR="."
-    - BUILD_DIR="."
+    - SRC_DIR=".."
+    - BUILD_DIR="build"
     - BASE_CONFIG="--disable-docs --disable-tools"
     - TEST_CMD="make check V=1"
     # This is broadly a list of "mainline" softmmu targets which have support across the major distros
@@ -191,7 +191,8 @@ matrix:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-sanitize"
       compiler: clang
       before_script:
-        - ./configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
+        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
+        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
 
 
     - env:
@@ -323,7 +324,8 @@ matrix:
         - CONFIG="--cc=gcc-9 --cxx=g++-9 --disable-pie --disable-linux-user"
         - TEST_CMD=""
       before_script:
-        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -Wno-error=stringop-truncation -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
+        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
+        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-g3 -O0 -Wno-error=stringop-truncation -fsanitize=thread -fuse-ld=gold" || { cat config.log && exit 1; }
 
 
     # Run check-tcg against linux-user
@@ -460,5 +462,6 @@ matrix:
         - make -C ${SRC_DIR} qemu-${QEMU_VERSION}.tar.bz2
         - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
         - tar -xf ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2 && cd qemu-${QEMU_VERSION}
-        - ./configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
+        - mkdir -p release-build && cd release-build
+        - ../configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
         - make install
-- 
2.20.1


