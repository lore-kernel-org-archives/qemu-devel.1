Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755B6C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B24C24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WG27qCDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B24C24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQEe-0002vs-6f
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzY-0002Et-TA
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzP-0002FH-WA
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:59 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:40055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPzO-0002CM-2j
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:50 -0500
Received: by mail-pl1-f172.google.com with SMTP id s21so516727plr.7
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a+ohCuWxChJ09Cd0wwMggUAUlrmcUhoiEbuSt9zP5do=;
 b=WG27qCDA3EFixmDjA6MQ0YHNDMLOxOLLaImMYYB+j6djNP/U+CGbLKPvp9nmNDgUG+
 NHVrNvWJ7mIhXcE0zmQo8hGsa4GVDGUEq/y2lmo2rSddv8zVbqJzDRWDeWUOrdBSfbbV
 0rWCW7hWlRap+9Cy7U5zAM5cCOtH7CFxG90YYcTgg6IsAWibCxW9uAzWXNHr/ERfZpZa
 8rmCd4FemgveG5X2zu3SKM90jWMX6M7+ldmxO4C+SjrIHwBrN5lokEx9oENwdKYQ3MlB
 Os6/A5g48twz1dEnWyEt+lNbG/nyeHC/0/3jleGi/M0egzPi5zf5ApZckGUvJbobNuVT
 VKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a+ohCuWxChJ09Cd0wwMggUAUlrmcUhoiEbuSt9zP5do=;
 b=unILoIOvLAz8L0TPM6WUXLGXK949OAbqYZARTMiHgTmk0prV8y4W3pWC24lsnzvhcd
 3JytaXF7oaBSK1HM9hlX4KslCTtyub0yhJCDjrOWb49JSerXnxB0s20Hjpu2AkykRFAT
 kN837YjYz67F/hYWAD0LuEuHTo4QQtwpg6agrTMVU4QLmdWBuvnvGxvT6GAY76K4e/32
 U0WSTN5Kp+fJmAUa6O2bVI2A11FEKtoJ2+TCrIkqnHiv5WvXMMAnAMA080WD3FD9LPY/
 8EI9pa2ZW4v3++pAwcwjeebo2ZLX7MYWYlvcKeiAM1ffrK45GG1gLQJ0T3MzqQNVQmry
 G9pg==
X-Gm-Message-State: APjAAAWhjKN7dpdsJcBppLQ3Vf188RWi19lx5TGoB6HikbFlz+bk2oj6
 hFX0tBwcNOwV3MCo1ztrH+4x0lctbC4=
X-Google-Smtp-Source: APXvYqx7Vlamp/acI4jmw2OsVIMgWyd+Q1R59i4M78UWsAMi1hizzeSv888DYL7WsPAyPq7sKgelYA==
X-Received: by 2002:a17:902:758c:: with SMTP id
 j12mr6986004pll.33.1579737826764; 
 Wed, 22 Jan 2020 16:03:46 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 15/24] target/avr: Register AVR support with the rest of
 QEMU
Date: Wed, 22 Jan 2020 14:02:58 -1000
Message-Id: <20200123000307.11541-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.172
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 dovgaluk@ispras.ru, Aleksandar Markovic <amarkovic@wavecomp.com>,
 imammedo@redhat.com, mrolnik@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Add AVR related definitions into QEMU

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20200118191416.19934-17-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 qapi/machine.json          |  3 ++-
 include/disas/dis-asm.h    | 19 +++++++++++++++++++
 include/sysemu/arch_init.h |  1 +
 arch_init.c                |  2 ++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index b3d30bc816..f2dc385167 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -21,11 +21,12 @@
 #        is true even for "qemu-system-x86_64".
 #
 # ppcemb: dropped in 3.1
+# avr: since 5.0
 #
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386', 'lm32',
              'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index e9c7dd8eb4..79bbc8b498 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -211,6 +211,25 @@ enum bfd_architecture
 #define bfd_mach_m32r          0  /* backwards compatibility */
   bfd_arch_mn10200,    /* Matsushita MN10200 */
   bfd_arch_mn10300,    /* Matsushita MN10300 */
+  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
+#define bfd_mach_avr1       1
+#define bfd_mach_avr2       2
+#define bfd_mach_avr25      25
+#define bfd_mach_avr3       3
+#define bfd_mach_avr31      31
+#define bfd_mach_avr35      35
+#define bfd_mach_avr4       4
+#define bfd_mach_avr5       5
+#define bfd_mach_avr51      51
+#define bfd_mach_avr6       6
+#define bfd_mach_avrtiny    100
+#define bfd_mach_avrxmega1  101
+#define bfd_mach_avrxmega2  102
+#define bfd_mach_avrxmega3  103
+#define bfd_mach_avrxmega4  104
+#define bfd_mach_avrxmega5  105
+#define bfd_mach_avrxmega6  106
+#define bfd_mach_avrxmega7  107
   bfd_arch_cris,       /* Axis CRIS */
 #define bfd_mach_cris_v0_v10   255
 #define bfd_mach_cris_v32      32
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 62c6fe4cf1..893df26ce2 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,7 @@ enum {
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_AVR = (1 << 20),
 };
 
 extern const uint32_t arch_type;
diff --git a/arch_init.c b/arch_init.c
index 705d0b94ad..6a741165b2 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -89,6 +89,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_UNICORE32
 #elif defined(TARGET_XTENSA)
 #define QEMU_ARCH QEMU_ARCH_XTENSA
+#elif defined(TARGET_AVR)
+#define QEMU_ARCH QEMU_ARCH_AVR
 #endif
 
 const uint32_t arch_type = QEMU_ARCH;
-- 
2.20.1


