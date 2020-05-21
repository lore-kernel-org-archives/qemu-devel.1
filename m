Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6912FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2741C207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrlHWxQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2741C207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrRO-0007m9-C1
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrMZ-0006cA-Nr
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:00:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37440
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbrMY-0008S9-Kk
 for qemu-devel@nongnu.org; Thu, 21 May 2020 16:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590091217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xv/yKL+Oc3sX8ayRlKIFZqZe7hdBRCnUDPQNbKc1oUo=;
 b=JrlHWxQvg1oMi8YyN+sbBRUea2xQPFzWLUzidmLbfqdJalaWwfPgzwr3gnqwrWNwE4iibs
 VvTSnE2T2I2iTFtNXX/CN6yDqt0KfAGahDgx6ZjKTdhaKWUnKt5RYHYCDDhaqeq6wyRHJ/
 i4o8HUNDzc5i25kdc9+9aLpLeuI/ZHk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-89BjSm0cPVyn6f7UShgUFA-1; Thu, 21 May 2020 16:00:15 -0400
X-MC-Unique: 89BjSm0cPVyn6f7UShgUFA-1
Received: by mail-wm1-f72.google.com with SMTP id f62so3087886wme.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 13:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xv/yKL+Oc3sX8ayRlKIFZqZe7hdBRCnUDPQNbKc1oUo=;
 b=IAb0OuLc0/KJuYuq8QO4Z8M5JGQaK4OWe7MadaII8aQj2klpyd2zQEA4VtEPmHU0Dm
 MoQFJf69kMAOJgf/KWlxg8HZ8bTR+3AXilW/tCHdrS+Kb/lwho9YJlqKfFzVpLt2iGnN
 WzZ7O6dWBZdbnz3JqWh1a5cuFS3iQufc1Iy0fimpLZu93B60VXUpAxxgaKkyEO7Fb3xz
 jw+ax2XYjvzCtHlTuVfclDIgPjuR9yowjN2Gn0Pojv9x/CjS+nCfGP0cxcdpcY77XD/l
 G+eiOSHOvthPSxDq27odA40VC/VaF6P8pKhx99WBDTbKocRZdzHht7/BIJHubF8KQ4OR
 ghTw==
X-Gm-Message-State: AOAM532j0jBig65/bqTFUdTzie7X29J2joK/3FrE6E3HhPSs1TAjjFTe
 CXvHsyIrGc/2+MgvhdHP5Bw3P/WiQ2SYhnfFn2IdZc/+SwrTkwUgHtfODLm2p0AMkE1WhmViYIH
 36AgiDo4H/lfxjDE=
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr211400wrm.43.1590091213849;
 Thu, 21 May 2020 13:00:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzni8j61EAPF6Yv+BpTSk0+bztX33UrFGderStA3d8ql5z6S2YfyJpI+RDlS7X3ThzoxoBy/w==
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr211378wrm.43.1590091213621;
 Thu, 21 May 2020 13:00:13 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z7sm7419304wrl.88.2020.05.21.13.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 13:00:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/11] hw/semihosting: Make the feature depend of TCG,
 and allow to disable it
Date: Thu, 21 May 2020 21:59:11 +0200
Message-Id: <20200521195911.19685-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200521195911.19685-1-philmd@redhat.com>
References: <20200521195911.19685-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
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
v3: Fixed odd hidden \xC2 UTF-8 chars:

Traceback (most recent call last):
  File "qemu/scripts/minikconf.py", line 355, in parse_file
    self.src = fp.read()
UnicodeDecodeError: 'ascii' codec can't decode byte 0xc2 in position 21: ordinal not in range(128)
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
index 0000000000..035592dd86
--- /dev/null
+++ b/target/arm/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y if TCG
diff --git a/target/lm32/Kconfig b/target/lm32/Kconfig
new file mode 100644
index 0000000000..68b946e79b
--- /dev/null
+++ b/target/lm32/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y
diff --git a/target/m68k/Kconfig b/target/m68k/Kconfig
new file mode 100644
index 0000000000..68b946e79b
--- /dev/null
+++ b/target/m68k/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y
diff --git a/target/mips/Kconfig b/target/mips/Kconfig
new file mode 100644
index 0000000000..035592dd86
--- /dev/null
+++ b/target/mips/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y if TCG
diff --git a/target/nios2/Kconfig b/target/nios2/Kconfig
new file mode 100644
index 0000000000..68b946e79b
--- /dev/null
+++ b/target/nios2/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y
diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
new file mode 100644
index 0000000000..035592dd86
--- /dev/null
+++ b/target/riscv/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y if TCG
diff --git a/target/xtensa/Kconfig b/target/xtensa/Kconfig
new file mode 100644
index 0000000000..68b946e79b
--- /dev/null
+++ b/target/xtensa/Kconfig
@@ -0,0 +1,2 @@
+config SEMIHOSTING
+    default y
-- 
2.21.3


