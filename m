Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A24BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A528208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcAYjjhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A528208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEpF-0008Ni-7F
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXW-00011a-BT; Tue, 15 Sep 2020 13:14:46 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEXS-0002qP-ES; Tue, 15 Sep 2020 13:14:46 -0400
Received: by mail-pl1-x641.google.com with SMTP id bh1so1683074plb.12;
 Tue, 15 Sep 2020 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MjaV6Qfqa3fMJy/CTHAt8oPfW2z8Zpip23pYr1VEBfU=;
 b=KcAYjjhIX119vK+7GccUi3s092U+W19If/MrM4MYRvxzJY/ZG9778KuD9JoqcW2H/7
 RZlbinw8WTaVuzhi2xdvjYtYeBiiAKaHcwbz6RxvpC9FKBO+UL9NnPuqN97QHGsJJwQl
 TJ70tXQoORNzrF39/jRTfFHgxUA5ypLGmyoCvcxRJoTv6cqsRPeiwrPDt36qZHDqZc7Z
 ajf+T05xp2nnAawqH3wksr6YhntdVqlooO9eQj+5AHwAtz250L/6MmmTbCS2e71N2ozw
 xL3QNAFfuffVW0qYqDl416UXhNGzSufa1R36AaeKUpiwP2aKs+pbxG40WnvIkzXUs9EG
 hdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MjaV6Qfqa3fMJy/CTHAt8oPfW2z8Zpip23pYr1VEBfU=;
 b=A1amI7TgR/sW0OwWfu9rEZh5Sxqrdlai/I4yvjJ4hn95iNnVG4hKijpas/RmriGiZE
 PJ2OjDJypd/SPHsuSreq4H5/FKCO+3GCvCJpnzOPwCkPb10f2vypsNOKKgj7WceAAoKb
 jOC1I3r78S3uHYyq19mYkyjerJJ/Z7O4qFwFUndurcDfagJZq5MQXgyGh5rdyFn3ZYkn
 RLcE4viwj4SE/EZgVuT1XaL7h2DM+qFzmteIlEmN1OsFQjpvmfJA7cDZ+dqfSUqOXddi
 2wud58II2kAGgHrKq41Y4VuUOFtTcHJKH7T/T4uN/YWg2VmQqxgfePVQzctJvoP8/hfa
 eJag==
X-Gm-Message-State: AOAM531xFLDqdHrVW4re9ob8q5n9utwnzD1+xPKiXCtriW4WZBULNZFX
 /yJfpQHk2BMLVvURk82MhkZ7M+6wLpEsmKSSEqY=
X-Google-Smtp-Source: ABdhPJxCYq6keEX7zgAWFATZjcCp2/qz1BDYcugr5QlHc8nG7/0gfoCcvXKxF6xVV+qimA51SMbeEQ==
X-Received: by 2002:a17:902:b20c:b029:d1:e5e7:be0c with SMTP id
 t12-20020a170902b20cb02900d1e5e7be0cmr2600073plr.63.1600190080208; 
 Tue, 15 Sep 2020 10:14:40 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:14:39 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 24/26] ci: Enable msys2 ci in cirrus
Date: Wed, 16 Sep 2020 01:12:32 +0800
Message-Id: <20200915171234.236-25-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x641.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
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
Now all enabled msys2/tests are passed

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .cirrus.yml | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index 25fb4add9b..90ed891865 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -44,3 +44,64 @@ macos_xcode_task:
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
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
+        curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
+        curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
+        pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Sy"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
+        bash pacman pacman-mirrors msys2-runtime"
+    - taskkill /F /IM gpg-agent.exe
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
+        base-devel
+        git
+        mingw-w64-x86_64-python
+        mingw-w64-x86_64-python-setuptools
+        mingw-w64-x86_64-toolchain
+        mingw-w64-x86_64-SDL2
+        mingw-w64-x86_64-SDL2_image
+        mingw-w64-x86_64-gtk3
+        mingw-w64-x86_64-glib2
+        mingw-w64-x86_64-ninja
+        mingw-w64-x86_64-make
+        mingw-w64-x86_64-lzo2
+        mingw-w64-x86_64-zstd
+        mingw-w64-x86_64-libjpeg-turbo
+        mingw-w64-x86_64-pixman
+        mingw-w64-x86_64-libgcrypt
+        mingw-w64-x86_64-libpng
+        mingw-w64-x86_64-libssh
+        mingw-w64-x86_64-libxml2
+        mingw-w64-x86_64-snappy
+        mingw-w64-x86_64-libusb
+        mingw-w64-x86_64-usbredir
+        mingw-w64-x86_64-libtasn1
+        mingw-w64-x86_64-nettle
+        mingw-w64-x86_64-cyrus-sasl
+        mingw-w64-x86_64-curl
+        mingw-w64-x86_64-gnutls
+        mingw-w64-x86_64-zstd"
+  script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure --python=python3"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
+  test_script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
+
-- 
2.28.0.windows.1


