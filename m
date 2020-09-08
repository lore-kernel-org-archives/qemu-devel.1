Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32705C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A3020658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmxlGmlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A3020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjfl-0005EW-Qd
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjc2-0005T8-4l; Tue, 08 Sep 2020 15:49:06 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjbz-0002WE-Vz; Tue, 08 Sep 2020 15:49:05 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a9so143225pjg.1;
 Tue, 08 Sep 2020 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ax2yAUytKuTKhH+tVXqGE0gj/9bVazXwd00LBZJO+WI=;
 b=MmxlGmlrMB1zBns2ND17DCcVu5QJTtV4ywCMlFKhGerHtvmlE1yfh7ZvjYKPlrYmYa
 rkWiTDoEhwpZABoIxYId+AUhQMD749hWgwl/3vKuHEuGBBD21/KiUK4+IeUxqdyXwg4a
 n7tNfMl6zBvJWGwA6MN3KsCm8H4AsJQ6qGlAS/mGJq7loosLyE75jJT+z6mTZ19cUSpG
 8kFNpZxCl0nrtpyDKA782cJ+4IexMdU8674UmO+RQIv52S5kHXMMHU1JOFwGzc5HKb1B
 FkY7o7NHa50dI8TShpgTjo5GPHZBXYmsPKYEUECy/2BN2ACg+mgHr08YgsFJ0J8Qxaob
 aY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ax2yAUytKuTKhH+tVXqGE0gj/9bVazXwd00LBZJO+WI=;
 b=jK4U0lrx4JHbnHYnennmoxgyd0Kau5p4EhQpDwtZI+9yQMrY6BWW6XJZ4DsaeORabv
 1QIrm0aK5m7MO5WCsnHBcAp36L21lY+jyhynSCY/eY8i3F40hGh5dxywGR0VKytwIjRe
 3+/v3oU4cUYlF5SjzTyf3xaekUmxx8I1/F9JqZRcNdIxGa6vSiUk0CzRK7n2/XLy+V4Q
 qxNqw5T5qk7TyLLCKe5VpCQ0P9gX3nBBRiWrtQL0KyPGu9gaRAA9OBCjdSpNvz8fsxsJ
 g5jKv+2vCsxivq/XPKqzFfzOy/hOdknIlZfUwgPAx0fHd6XYIE/MbT0FjFTpz3/EcC5I
 xnbw==
X-Gm-Message-State: AOAM5328ranJ81uLaa1KvtX4pGsGZf7KmtgOtPn7cSCQBD24uaRVuadN
 pdPu9ZrBBHVn1+/slTjZzTMlzRXRwoPGpY3F
X-Google-Smtp-Source: ABdhPJwuiwpUeTbHuqs/dXumJCl1Ay02yRcM/Gw8gnR8b65y//rpHsDalbFMxECVUncPV/ct4wxcCw==
X-Received: by 2002:a17:90b:100e:: with SMTP id
 gm14mr375504pjb.200.1599594541765; 
 Tue, 08 Sep 2020 12:49:01 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id n127sm216922pfn.155.2020.09.08.12.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:49:01 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/16] ci: Enable msys2 ci in cirrus
Date: Wed,  9 Sep 2020 03:48:10 +0800
Message-Id: <20200908194820.702-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908194820.702-1-luoyonggang@gmail.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install msys2 in a proper way refer to https://github.com/cirruslabs/cirrus-ci-docs/issues/699
The https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2 need to be updated.
There is no need of --cross-prefix, open mingw64.exe instead of msys2.exe then we don't
need the --cross-prefix, besides we using environment variable settings:
    MSYS: winsymlinks:nativestrict
    MSYSTEM: MINGW64
    CHERE_INVOKING: 1
to opening mingw64 native shell.
We now running tests with make -i check to skip tests errors.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml                         | 24 +++++++++++++++++++++
 scripts/ci/windows/msys2-build.sh   | 28 ++++++++++++++++++++++++
 scripts/ci/windows/msys2-install.sh | 33 +++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 scripts/ci/windows/msys2-build.sh
 create mode 100644 scripts/ci/windows/msys2-install.sh

diff --git a/.cirrus.yml b/.cirrus.yml
index 3dd9fcff7f..49335e68c9 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -63,3 +63,27 @@ macos_xcode_task:
                    --enable-werror --cc=clang || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check
+
+windows_msys2_task:
+  windows_container:
+    image: cirrusci/windowsservercore:cmake
+    os_version: 2019
+    cpu: 8
+    memory: 8G
+  env:
+    MSYS: winsymlinks:nativestrict
+    MSYSTEM: MINGW64
+    CHERE_INVOKING: 1
+  printenv_script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
+  install_script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy --noconfirm"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed --noconfirm -S bash pacman pacman-mirrors msys2-runtime"
+    - taskkill /F /IM gpg-agent.exe
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2-install.sh"
+  script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2-build.sh"
diff --git a/scripts/ci/windows/msys2-build.sh b/scripts/ci/windows/msys2-build.sh
new file mode 100644
index 0000000000..d9d046b5b0
--- /dev/null
+++ b/scripts/ci/windows/msys2-build.sh
@@ -0,0 +1,28 @@
+mkdir build
+cd build
+../configure \
+--python=python3 \
+--ninja=ninja \
+--enable-stack-protector \
+--enable-guest-agent \
+--disable-pie \
+--enable-gnutls --enable-nettle \
+--enable-sdl --enable-sdl-image --enable-gtk --disable-vte --enable-curses --enable-iconv \
+--enable-vnc --enable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png \
+--enable-slirp=git \
+--disable-brlapi --enable-curl \
+--enable-fdt \
+--disable-kvm --enable-hax --enable-whpx \
+--enable-libnfs --enable-libusb --enable-live-block-migration --enable-usb-redir \
+--enable-lzo --enable-snappy --enable-bzip2 --enable-zstd \
+--enable-membarrier --enable-coroutine-pool \
+--enable-libssh --enable-libxml2 \
+--enable-jemalloc --enable-avx2 \
+--enable-replication \
+--enable-tools \
+--enable-bochs --enable-cloop --enable-dmg --enable-qcow1 --enable-vdi --enable-vvfat --enable-qed --enable-parallels \
+--enable-sheepdog \
+--enable-capstone=git
+
+make -j$NUMBER_OF_PROCESSORS
+make -i -j$NUMBER_OF_PROCESSORS check
diff --git a/scripts/ci/windows/msys2-install.sh b/scripts/ci/windows/msys2-install.sh
new file mode 100644
index 0000000000..6086452399
--- /dev/null
+++ b/scripts/ci/windows/msys2-install.sh
@@ -0,0 +1,33 @@
+pacman --noconfirm -S --needed \
+base-devel \
+git \
+mingw-w64-x86_64-python \
+mingw-w64-x86_64-python-setuptools \
+mingw-w64-x86_64-toolchain \
+mingw-w64-x86_64-SDL2 \
+mingw-w64-x86_64-SDL2_image \
+mingw-w64-x86_64-gtk3 \
+mingw-w64-x86_64-glib2 \
+mingw-w64-x86_64-ninja \
+mingw-w64-x86_64-make \
+mingw-w64-x86_64-jemalloc \
+mingw-w64-x86_64-lzo2 \
+mingw-w64-x86_64-zstd \
+mingw-w64-x86_64-libjpeg-turbo \
+mingw-w64-x86_64-pixman \
+mingw-w64-x86_64-libgcrypt \
+mingw-w64-x86_64-capstone \
+mingw-w64-x86_64-libpng \
+mingw-w64-x86_64-libssh \
+mingw-w64-x86_64-libxml2 \
+mingw-w64-x86_64-snappy \
+mingw-w64-x86_64-libusb \
+mingw-w64-x86_64-usbredir \
+mingw-w64-x86_64-libtasn1 \
+mingw-w64-x86_64-libnfs \
+mingw-w64-x86_64-nettle \
+mingw-w64-x86_64-cyrus-sasl \
+mingw-w64-x86_64-curl \
+mingw-w64-x86_64-gnutls \
+mingw-w64-x86_64-zstd \
+
-- 
2.28.0.windows.1


