Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EE6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67A8206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1Ec7Nwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67A8206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdv9-0003Cf-V9
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdpd-0000ne-CO
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:09:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21786
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdpc-00033S-0Z
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589562547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZX0QW9DXonbuBshkLSkBrNCbZ8d0l65fGU32CLsfp4=;
 b=E1Ec7NwfRQPdN6S3PcrFdumN0aN0NZjEePERDfRxPa6PNO3IgWa2nG1TMsHPAkQOHiMpkU
 gQW29bBHTW/+E2sob1Sopsx5+XGnwE5ny4ybKi3ILA8+hDslssqyGdbPFjwCzeq8Xx8Ysm
 L8jbma/xsnSMOiK5xBpiWI6xF9HrrYQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-HJUrm0PcNQukGhD6saKB1Q-1; Fri, 15 May 2020 13:09:05 -0400
X-MC-Unique: HJUrm0PcNQukGhD6saKB1Q-1
Received: by mail-wm1-f70.google.com with SMTP id n124so1266463wma.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1ZX0QW9DXonbuBshkLSkBrNCbZ8d0l65fGU32CLsfp4=;
 b=q0Ne7rbzFw1babQOcIlaz96/WNA89E+/IBiZcCPAzIRXW9umoEYZbJHeo0fbdaEbAo
 hKqFOHrOURqfcrMkvJNVrYbldywsJu5j6nTt1LD8za9iKKf0eveZ4H+vrBOIpUr+aG6o
 GVEGcCYz0rCOfW3uEYyUOgvhz0hS8VknVxS9lSFT4gvIFZz6PhYdZq6H/QA5lnDWU1h0
 M+21cxyhFOsx8lNbkq60ct0BnTxpn7loGLIM+6gtjS/5auYQrccfITziwpl+dfAGnqZl
 c3usGEJv9cwbJAP6dk85In4MjA+L+gyV+awnxB5yr1+RMnrBHycXLVVhycsLDsopqtHP
 gF8Q==
X-Gm-Message-State: AOAM5333bFab4VkrT1Tvp0DgV2HzgifiBiuKLl/rg2VvRJE6u5/IEV4O
 8NmZ5q3srRJrY9RqvUWvaESFv7NOrMA08yTIjSdZK4pI2cP0ReAmExhOmPS11gQ3QgHRKNGfddc
 QnuHtCH3Q0I1YFxI=
X-Received: by 2002:a1c:2502:: with SMTP id l2mr3758349wml.111.1589562544156; 
 Fri, 15 May 2020 10:09:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpNVZbQGG3qsOlZD6eLW7rackHHKqwy520Y9CFVeCGODSF13/8lWF5MSzbh8IfuztKS3HzUA==
X-Received: by 2002:a1c:2502:: with SMTP id l2mr3758311wml.111.1589562543904; 
 Fri, 15 May 2020 10:09:03 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 5sm4556980wmd.19.2020.05.15.10.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 10:09:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/10] hw/semihosting: Make the feature depend of TCG,
 and allow to disable it
Date: Fri, 15 May 2020 19:08:04 +0200
Message-Id: <20200515170804.5707-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515170804.5707-1-philmd@redhat.com>
References: <20200515170804.5707-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The semihosting feature is only meaningful when using TCG.

Do not enable it by default, and let the few targets requiring
it to manually select it.
The targets restricted to TCG that previously selected it
(see commit 16932bb761e52c2 'introduce CONFIG_SEMIHOSTING')
are left unmodified; however the selection is moved to the
target Kconfig.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 default-configs/arm-softmmu.mak         | 1 -
 default-configs/lm32-softmmu.mak        | 2 --
 default-configs/m68k-softmmu.mak        | 2 --
 default-configs/mips-softmmu-common.mak | 3 ---
 default-configs/nios2-softmmu.mak       | 2 --
 default-configs/xtensa-softmmu.mak      | 2 --
 hw/semihosting/Kconfig                  | 4 +++-
 target/arm/Kconfig                      | 2 ++
 target/lm32/Kconfig                     | 2 ++
 target/m68k/Kconfig                     | 2 ++
 target/mips/Kconfig                     | 2 ++
 target/nios2/Kconfig                    | 2 ++
 target/riscv/Kconfig                    | 2 ++
 target/xtensa/Kconfig                   | 2 ++
 14 files changed, 17 insertions(+), 13 deletions(-)
 create mode 100644 target/arm/Kconfig
 create mode 100644 target/lm32/Kconfig
 create mode 100644 target/m68k/Kconfig
 create mode 100644 target/mips/Kconfig
 create mode 100644 target/nios2/Kconfig
 create mode 100644 target/riscv/Kconfig
 create mode 100644 target/xtensa/Kconfig

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 8fc09a4a51..f6044f1121 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -40,6 +40,5 @@ CONFIG_MICROBIT=y
 CONFIG_FSL_IMX25=y
 CONFIG_FSL_IMX7=y
 CONFIG_FSL_IMX6UL=y
-CONFIG_SEMIHOSTING=y
 CONFIG_ALLWINNER_H3=y
 CONFIG_ACPI_APEI=y
diff --git a/default-configs/lm32-softmmu.mak b/default-configs/lm32-softmmu.mak
index 115b3e34c9..6d259665d6 100644
--- a/default-configs/lm32-softmmu.mak
+++ b/default-configs/lm32-softmmu.mak
@@ -4,8 +4,6 @@
 #
 #CONFIG_MILKYMIST_TMU2=n        # disabling it actually causes compile-time failures
 
-CONFIG_SEMIHOSTING=y
-
 # Boards:
 #
 CONFIG_LM32=y
diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index 6629fd2aa3..4fef4bd731 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -1,7 +1,5 @@
 # Default configuration for m68k-softmmu
 
-CONFIG_SEMIHOSTING=y
-
 # Boards:
 #
 CONFIG_AN5206=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index da29c6c0b2..6c0904b200 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -1,8 +1,5 @@
 # Common mips*-softmmu CONFIG defines
 
-# CONFIG_SEMIHOSTING is always required on this architecture
-CONFIG_SEMIHOSTING=y
-
 CONFIG_ISA_BUS=y
 CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
index 1bc4082ea9..e130d024e6 100644
--- a/default-configs/nios2-softmmu.mak
+++ b/default-configs/nios2-softmmu.mak
@@ -1,7 +1,5 @@
 # Default configuration for nios2-softmmu
 
-CONFIG_SEMIHOSTING=y
-
 # Boards:
 #
 CONFIG_NIOS2_10M50=y
diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/xtensa-softmmu.mak
index 4fe1bf00c9..49e4c9da88 100644
--- a/default-configs/xtensa-softmmu.mak
+++ b/default-configs/xtensa-softmmu.mak
@@ -1,7 +1,5 @@
 # Default configuration for Xtensa
 
-CONFIG_SEMIHOSTING=y
-
 # Boards:
 #
 CONFIG_XTENSA_SIM=y
diff --git a/hw/semihosting/Kconfig b/hw/semihosting/Kconfig
index efe0a30734..30befcdd21 100644
--- a/hw/semihosting/Kconfig
+++ b/hw/semihosting/Kconfig
@@ -1,3 +1,5 @@
 
+# default is 'n'
 config SEMIHOSTING
-       bool
+    bool
+    depends on TCG
diff --git a/target/arm/Kconfig b/target/arm/Kconfig
new file mode 100644
index 0000000000..3224cac4ad
--- /dev/null
+++ b/target/arm/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y if TCG
diff --git a/target/lm32/Kconfig b/target/lm32/Kconfig
new file mode 100644
index 0000000000..c0a9a9e799
--- /dev/null
+++ b/target/lm32/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y
diff --git a/target/m68k/Kconfig b/target/m68k/Kconfig
new file mode 100644
index 0000000000..c0a9a9e799
--- /dev/null
+++ b/target/m68k/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y
diff --git a/target/mips/Kconfig b/target/mips/Kconfig
new file mode 100644
index 0000000000..3224cac4ad
--- /dev/null
+++ b/target/mips/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y if TCG
diff --git a/target/nios2/Kconfig b/target/nios2/Kconfig
new file mode 100644
index 0000000000..c0a9a9e799
--- /dev/null
+++ b/target/nios2/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y
diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
new file mode 100644
index 0000000000..3224cac4ad
--- /dev/null
+++ b/target/riscv/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y if TCG
diff --git a/target/xtensa/Kconfig b/target/xtensa/Kconfig
new file mode 100644
index 0000000000..c0a9a9e799
--- /dev/null
+++ b/target/xtensa/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y
-- 
2.21.3


