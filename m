Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AACCC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628C524811
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="DHR8SsI+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="Gt3W7g9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628C524811
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqfd-0004pA-Cj
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kXqdi-0002vK-Hj; Wed, 28 Oct 2020 14:57:42 -0400
Received: from home.keithp.com ([63.227.221.253]:47566 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kXqdg-00054n-8R; Wed, 28 Oct 2020 14:57:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id C2B533F2DDAA;
 Wed, 28 Oct 2020 11:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603911456; bh=1uixw7i+7CXy1hvSM8zGfykkQvgeOdiPcWVeaxl+0Hs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DHR8SsI+VPlJbAcJiGSuVmTIIMQl/AWOvpNDG0uASYHsxTVk7zGA1xDBOAZ8KeBCS
 KUsvp8o4t9FQRxHk6vMKUEiOT6Xt0n/gRR8xv/LYRTnRe2FRc3Wf/G3F5sltX5bJ4+
 8qa4CtoESxuR1moYG2gyKVmFbgvI1zxRJhl51rykEEXzloqCzk1318YudP0b/rhWvr
 xtO0XaXd1srL5oXKg5/g1tLKd1H3v5eWI/7ADtVQjZ6QdAxzAB12RrXP9+FAKcBilO
 BPhx4Dqzluzp9W+bdaqBzR1+pm6L3QA0Kc+BMIm55s7J7fAsGxYPJWX8Mxfd8+vmRH
 TYgJPSiEnOK/A==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id RbsUgclB5IFN; Wed, 28 Oct 2020 11:57:36 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 6B2B43F2DDAE;
 Wed, 28 Oct 2020 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603911453; bh=1uixw7i+7CXy1hvSM8zGfykkQvgeOdiPcWVeaxl+0Hs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Gt3W7g9Vhg7RK6tpKUbl/9mll/GCUpjxw8y+ia7fYQlqu0P11kFPScfzFSSAUmth4
 Hmx8j8UBOFhXs+xf0mcN7sqY8dBUyiW3JZ7s9D+TEiNUb2cgNsZn03mBrDUhTS7vwT
 sFbr8AJ3cMWegtStWnFNvJM/ZQCC/+wbOHYHuvzr78jEfbeECO14M+t2wi6CqGDSnF
 fZj8es3samnLi35ah6cOyRQ2eJtQk5TbWdRXdgIprZ9RajQwyZdv4rB+PAMyDBeOjL
 TekRuIHQsZQ6uZvexgKGvgpkxk5W0BTEq3Y0u5VqxY+UZtvOgIlwzHiu9twqJEZrau
 OZcxbBZvV620A==
Received: by keithp.com (Postfix, from userid 1000)
 id 3248D1582211; Wed, 28 Oct 2020 11:57:33 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-riscv@nongnu.org,
 Keith Packard <keithp@keithp.com>
Subject: [PATCH 1/4] semihosting: Move ARM semihosting code to shared
 directories [v3]
Date: Wed, 28 Oct 2020 11:57:19 -0700
Message-Id: <20201028185722.2783532-2-keithp@keithp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028185722.2783532-1-keithp@keithp.com>
References: <20201028185722.2783532-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 14:57:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Keith Packard <keithp@keithp.com>
From: Keith Packard via <qemu-devel@nongnu.org>

This commit renames two files which provide ARM semihosting support so
that they can be shared by other architectures:

 1. target/arm/arm-semi.c     -> hw/semihosting/common-semi.c
 2. linux-user/arm/semihost.c -> linux-user/semihost.c

The build system was modified use a new config variable,
CONFIG_ARM_COMPATIBLE_SEMIHOSTING, which has been added to the ARM
softmmu and linux-user default configs. The contents of the source
files has not been changed in this patch.

Signed-off-by: Keith Packard <keithp@keithp.com>

----

v2
	Place common-semi.c name in arm_ss, just as arm-semi.c was

v3
	Create CONFIG_ARM_COMPATIBLE_SEMIHOSTING and assign in
	arm config files
---
 default-configs/devices/arm-softmmu.mak               | 1 +
 default-configs/targets/aarch64-linux-user.mak        | 1 +
 default-configs/targets/arm-linux-user.mak            | 1 +
 hw/semihosting/Kconfig                                | 3 +++
 target/arm/arm-semi.c => hw/semihosting/common-semi.c | 0
 hw/semihosting/meson.build                            | 3 +++
 linux-user/arm/meson.build                            | 3 ---
 linux-user/meson.build                                | 1 +
 linux-user/{arm => }/semihost.c                       | 0
 target/arm/meson.build                                | 2 --
 10 files changed, 10 insertions(+), 5 deletions(-)
 rename target/arm/arm-semi.c => hw/semihosting/common-semi.c (100%)
 rename linux-user/{arm => }/semihost.c (100%)

diff --git a/default-configs/devices/arm-softmmu.mak b/default-configs/devices/arm-softmmu.mak
index 08a32123b4..0500156a0c 100644
--- a/default-configs/devices/arm-softmmu.mak
+++ b/default-configs/devices/arm-softmmu.mak
@@ -42,4 +42,5 @@ CONFIG_FSL_IMX25=y
 CONFIG_FSL_IMX7=y
 CONFIG_FSL_IMX6UL=y
 CONFIG_SEMIHOSTING=y
+CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 CONFIG_ALLWINNER_H3=y
diff --git a/default-configs/targets/aarch64-linux-user.mak b/default-configs/targets/aarch64-linux-user.mak
index 163c9209f4..4713253709 100644
--- a/default-configs/targets/aarch64-linux-user.mak
+++ b/default-configs/targets/aarch64-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
 TARGET_HAS_BFLT=y
+CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/default-configs/targets/arm-linux-user.mak b/default-configs/targets/arm-linux-user.mak
index c7cd872e86..e741ffd4d3 100644
--- a/default-configs/targets/arm-linux-user.mak
+++ b/default-configs/targets/arm-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common,oabi
 TARGET_SYSTBL=syscall.tbl
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
 TARGET_HAS_BFLT=y
+CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/hw/semihosting/Kconfig b/hw/semihosting/Kconfig
index efe0a30734..4c30dc6b16 100644
--- a/hw/semihosting/Kconfig
+++ b/hw/semihosting/Kconfig
@@ -1,3 +1,6 @@
 
 config SEMIHOSTING
        bool
+
+config ARM_COMPATIBLE_SEMIHOSTING
+       bool
diff --git a/target/arm/arm-semi.c b/hw/semihosting/common-semi.c
similarity index 100%
rename from target/arm/arm-semi.c
rename to hw/semihosting/common-semi.c
diff --git a/hw/semihosting/meson.build b/hw/semihosting/meson.build
index f40ac574c4..5b4a170270 100644
--- a/hw/semihosting/meson.build
+++ b/hw/semihosting/meson.build
@@ -2,3 +2,6 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'config.c',
   'console.c',
 ))
+
+specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
+		if_true: files('common-semi.c'))
diff --git a/linux-user/arm/meson.build b/linux-user/arm/meson.build
index 432984b58e..5a93c925cf 100644
--- a/linux-user/arm/meson.build
+++ b/linux-user/arm/meson.build
@@ -1,6 +1,3 @@
-linux_user_ss.add(when: 'TARGET_AARCH64', if_true: files('semihost.c'))
-linux_user_ss.add(when: 'TARGET_ARM', if_true: files('semihost.c'))
-
 subdir('nwfpe')
 
 syscall_nr_generators += {
diff --git a/linux-user/meson.build b/linux-user/meson.build
index 2b94e4ba24..7fe28d659e 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -16,6 +16,7 @@ linux_user_ss.add(rt)
 
 linux_user_ss.add(when: 'TARGET_HAS_BFLT', if_true: files('flatload.c'))
 linux_user_ss.add(when: 'TARGET_I386', if_true: files('vm86.c'))
+linux_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING', if_true: files('semihost.c'))
 
 
 syscall_nr_generators = {}
diff --git a/linux-user/arm/semihost.c b/linux-user/semihost.c
similarity index 100%
rename from linux-user/arm/semihost.c
rename to linux-user/semihost.c
diff --git a/target/arm/meson.build b/target/arm/meson.build
index f5de2a77b8..15b936c101 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -32,8 +32,6 @@ arm_ss.add(files(
 ))
 arm_ss.add(zlib)
 
-arm_ss.add(when: 'CONFIG_TCG', if_true: files('arm-semi.c'))
-
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c', 'kvm64.c'), if_false: files('kvm-stub.c'))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-- 
2.28.0


