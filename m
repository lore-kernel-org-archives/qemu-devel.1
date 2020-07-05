Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F7C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80CF220724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CF220724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5OF-0007wq-Q2
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FD-0007f2-VA
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:47 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:42813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5FB-0008Kj-MO
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:47 -0400
Received: by mail-ed1-f41.google.com with SMTP id z17so32270124edr.9
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c+fnEmu1v+29FBdjRMbDR6vV1TPbEyjZMJCpBoQXt+4=;
 b=VKmbJRCmdNRk4c5yADQ1tB+e6IJqDeEpRPYRw/g8mc/mvmOS7PRMVmJ6gVlhA7YwvW
 bAZXZBTfDT8IsA1hnzSbFseErHCWGt/FlXuEO/jZwc9pgxuXpYNWiaeHQ0LES2U5ueKR
 jE658isg2b8iSMUKW+XrhdbRbmEQtl5cEb73BY45Kq6GaK2O8JIJo13Ku/2gWVyRX1Vw
 HeI5UrJsxoL+LvyyHnYuyRRiX/GhQmU2RAe2kBxzw/DfeqMAJXC4FwX+I/R3I4o0phzp
 5yAeAwaKspDOsD0NTk9nB01YJn8mN1yQmjTPfP0EoyulDqWK7mdfV0BZqjMzbjqkG/+a
 HxFw==
X-Gm-Message-State: AOAM532y3BiDH02voWDJAYMTEJbu+x+tV4/GhxVs3V8pVgo2794emgaw
 9sMlvvG36AUvG/ZADHLKpdKJcyh6
X-Google-Smtp-Source: ABdhPJz1bEkMc+4tW3c53HN095SWoTRlcRm2Fgthdv6l+IZCeXM5n8Ah4qU54EHem68DN4EMpAlufg==
X-Received: by 2002:a50:8adb:: with SMTP id k27mr49253419edk.267.1593957824203; 
 Sun, 05 Jul 2020 07:03:44 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:43 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 22/30] target/avr: Register AVR support with the rest of
 QEMU
Date: Sun,  5 Jul 2020 16:03:07 +0200
Message-Id: <20200705140315.260514-23-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.41; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f41.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Add AVR related definitions into QEMU.

[AM: Remove word 'Atmel' from filenames and all elements of code]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 arch_init.c                |  2 ++
 include/disas/dis-asm.h    | 19 +++++++++++++++++++
 include/sysemu/arch_init.h |  1 +
 qapi/machine.json          |  2 +-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch_init.c b/arch_init.c
index 8afea4748b..7fd5c09b2b 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -90,6 +90,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_UNICORE32
 #elif defined(TARGET_XTENSA)
 #define QEMU_ARCH QEMU_ARCH_XTENSA
+#elif defined(TARGET_AVR)
+#define QEMU_ARCH QEMU_ARCH_AVR
 #endif
 
 const uint32_t arch_type = QEMU_ARCH;
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index c5f9fa08ab..9856bf7921 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -211,6 +211,25 @@ enum bfd_architecture
 #define bfd_mach_m32r          0  /* backwards compatibility */
   bfd_arch_mn10200,    /* Matsushita MN10200 */
   bfd_arch_mn10300,    /* Matsushita MN10300 */
+  bfd_arch_avr,        /* AVR microcontrollers */
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
index 71a7a285ee..54f069d491 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -25,6 +25,7 @@ enum {
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
     QEMU_ARCH_RX = (1 << 20),
+    QEMU_ARCH_AVR = (1 << 21),
 
     QEMU_ARCH_NONE = (1 << 31),
 };
diff --git a/qapi/machine.json b/qapi/machine.json
index ff7b5032e3..39b6b6d089 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -25,7 +25,7 @@
 # Since: 3.0
 ##
 { 'enum' : 'SysEmuTarget',
-  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
+  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386', 'lm32',
              'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
-- 
2.26.2


