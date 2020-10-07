Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54241C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3105208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJB5ij0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3105208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ0WF-0004Q6-Ml
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 23:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ0V2-00038H-Vc; Tue, 06 Oct 2020 23:52:20 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:54334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ0V0-0001yv-Qc; Tue, 06 Oct 2020 23:52:20 -0400
Received: by mail-pj1-x1036.google.com with SMTP id az3so371101pjb.4;
 Tue, 06 Oct 2020 20:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dVr/fSApCdp1cCYQvU4K71KzhrNEn4Cfm+TTpJ7qcHg=;
 b=fJB5ij0hapfLZArCRGPhnMn/8OcTgpTPlFjJ7wTEg3jlJ/2fD0kdnu+i5oEvXqhSow
 WeNYV5Cz97gJQ4lFqfZxAaUYoVOhZZAe259/0ElNSzEpQpSvyNRPnDCrl+hLl5lfRQ/z
 GTk+UBV2WUFWz9TiU1ckAwNJ0Zk2maLXowjFbtcbhNMpvaYPZDq1NSS5q5sHnDUNz7in
 11hxOpVG7tjUHaipN827twd44+zO6LAO47A4sWaj9H1n/aSwV0ty3zSgjxaoRiQKjSDN
 oiTGn+Io9Ls4yMoHUhB0XpPPbskrQsbeaRJ2sHMAxEYAQPnXd59pWF2Fo80sZAJQTTvt
 XV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dVr/fSApCdp1cCYQvU4K71KzhrNEn4Cfm+TTpJ7qcHg=;
 b=nUdq+3+wh4a/RDOjkCjHPugFs4vc9+H0jx9wFv+YTgEg+J+SP9PtTW4zPQM33m3276
 EWtTbNKnfmPFnsVXWh2V4vh/17PVfhR2VpDc47KJxkDigs9jBIhCLts4ir/SE4F4fXsY
 2uFt9/ynzVYqqBSHFMzCQmItFOKLIn8jlWLUDD4poALyk+05Rk2yqsOx8EDYarRo4QAN
 8PGNKrC2D25XXxccr0iYC6Aari4+bMgn6ZD2PHtgf+7RN3+iGgLZznMhpS0RZkI7UNez
 8LUh2McVpyzQEhragk/u4jv5tNvg+SbqJ7GqlyP79ZXKhsV9dPQITyP9pWSK/M9W4EX2
 ZpaQ==
X-Gm-Message-State: AOAM530EsgNGPfb2k5YFHU3jhdtRlbkHyR5Og3lBzyKwsZCbZj018V8n
 U5CwqxLSEDlX1p0B+Gwljd/4sAAcPPPuDw==
X-Google-Smtp-Source: ABdhPJyDc7SEb039qIkDauefVYik/uaKIyNF8a5sE1jSSBqehEGOmJ3ftjIeBzfWAMKt9AhDPKR2+w==
X-Received: by 2002:a17:902:fe0e:b029:d3:d7fe:88eb with SMTP id
 g14-20020a170902fe0eb02900d3d7fe88ebmr1058781plj.58.1602042736342; 
 Tue, 06 Oct 2020 20:52:16 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id v10sm497031pjf.34.2020.10.06.20.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 20:52:15 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] docker: Add win32/msys2/mingw64 docker
Date: Wed,  7 Oct 2020 11:51:52 +0800
Message-Id: <20201007035154.109-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201007035154.109-1-luoyonggang@gmail.com>
References: <20201007035154.109-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1036.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This docker is used to preparing a msys2/mingw with basic software installed.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/docker/dockerfiles/msys2.docker | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 tests/docker/dockerfiles/msys2.docker

diff --git a/tests/docker/dockerfiles/msys2.docker b/tests/docker/dockerfiles/msys2.docker
new file mode 100644
index 0000000000..ce1404cbb8
--- /dev/null
+++ b/tests/docker/dockerfiles/msys2.docker
@@ -0,0 +1,57 @@
+FROM mcr.microsoft.com/windows/servercore:2004
+RUN cmd /S /C powershell -NoLogo -NoProfile -Command netsh interface ipv4 show interfaces ; netsh interface ipv4 set subinterface 18 mtu=1460 store=persistent ; netsh interface ipv4 show interfaces ; Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) ;
+RUN choco install -y --no-progress git 7zip
+RUN cmd /S /C powershell -NoLogo -NoProfile -Command Remove-Item C:\ProgramData\chocolatey\logs -Force -Recurse ; Remove-Item C:\Users\ContainerAdministrator\AppData\Local\Temp -Force -Recurse
+RUN mkdir C:\tools
+RUN bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND https://github.com/msys2/msys2-installer/releases/download/2020-09-03/msys2-base-x86_64-20200903.sfx.exe C:\tools\base.exe
+RUN cd /d C:\tools && base.exe -y
+RUN cmd /S /C powershell -NoLogo -NoProfile -Command "((Get-Content -path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post"
+RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
+RUN C:\tools\msys64\usr\bin\bash.exe -lc "echo $MSYSTEM" >nul 2>&1
+# RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/Server = http:\/\/repo.msys2.org\/msys\/.arch\///g' /etc/pacman.d/mirrorlist.msys"
+# RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/Server = http:\/\/repo.msys2.org\/mingw\/i686\///g' /etc/pacman.d/mirrorlist.mingw32"
+# RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/Server = http:\/\/repo.msys2.org\/mingw\/x86_64\///g' /etc/pacman.d/mirrorlist.mingw64"
+RUN C:\tools\msys64\usr\bin\bash.exe -lc "grep -rl 'repo.msys2.org/' /etc/pacman.d/mirrorlist.* | xargs sed -i 's/repo.msys2.org\//mirrors.tuna.tsinghua.edu.cn\/msys2\//g'"
+RUN C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy
+RUN echo Y | C:\tools\msys64\usr\bin\pacman.exe -Suu --noconfirm --needed
+RUN taskkill /F /FI "MODULES eq msys-2.0.dll"
+RUN tasklist
+RUN C:\tools\msys64\usr\bin\bash.exe -lc "pacman.exe --noconfirm -S --needed \
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
+mingw-w64-x86_64-libpng \
+mingw-w64-x86_64-libssh \
+mingw-w64-x86_64-libxml2 \
+mingw-w64-x86_64-snappy \
+mingw-w64-x86_64-libusb \
+mingw-w64-x86_64-usbredir \
+mingw-w64-x86_64-libtasn1 \
+mingw-w64-x86_64-nettle \
+mingw-w64-x86_64-cyrus-sasl \
+mingw-w64-x86_64-curl \
+mingw-w64-x86_64-gnutls \
+mingw-w64-x86_64-zstd"
+
+RUN C:\tools\msys64\usr\bin\bash.exe -lc "rm -rf /var/cache/pacman/pkg/*"
+RUN del C:\tools\base.exe
+RUN cd C:\tools\msys64 && cmd /C "7z a -ttar . -so | 7z a -txz -simsys2-x86_64.tar C:\tools\msys2-x86_64.tar.xz"
+# docker build --tag lygstate/windowsservercore:msys2 -f "msys2.docker" .
+# docker run -it --rm -v c:/work:c:/work lygstate/windowsservercore:msys2 cmd
+# docker push lygstate/windowsservercore:msys2
+# no cache
+# docker build --no-cache --tag lygstate/windowsservercore:msys2 -f "msys2.docker" .
-- 
2.28.0.windows.1


