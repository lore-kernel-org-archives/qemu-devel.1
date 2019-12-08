Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E8CC43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E823120663
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCIUlTI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E823120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie1td-0003fo-Vc
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 14:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1U2-0002PD-1S
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tz-0003Pb-2R
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1Tx-0003EF-2K
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:37 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so13536768wrh.5
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vDGhwbfTnuJcn5Li6bSzND/J3rq0aHhhNBlQDRUE6mI=;
 b=VCIUlTI0Slg4wQTLh3Qc+FHVQCSOiUZdLOGTu1ecpUgERy4kXpYoc0Hsl9P7QPqDVL
 aJQb0bt9cuTy95LBibAjcOZ2e4kdRGwpoPHa40vcNJSKahuQ2LBVlvQiM4NQk6gRgBud
 mFXzEkF4AUPnjPW2nZYQqmc0M9+Y5uBKyUN1AdYApQUZpN0JEl6T2FUY3bnT44OA2F6K
 E0Z653+A9Hd3QlhMmEEAerKdZ9FEskq7oXic078c/T+RslgBqieOvZmTVU/LQYHAB+rq
 75oPRDezpsdOkzLrsDUWeCsHGMLgbm3svWT0g1VtbRCZjrkPKxfIj53SJv2jsyuisqqS
 u0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vDGhwbfTnuJcn5Li6bSzND/J3rq0aHhhNBlQDRUE6mI=;
 b=oHyhRag2gI1tnH4XWGS2+SEPn2c7UldBnnBR5mIXySmy+QqWnOWAEn2jcT381TLuz4
 MI29jQi8PBj5544ZFb14i7rGmQvTfHLAUV+uCTTUHC+zzQZvnXa359FqIpp+v437it68
 xx5nNWIGeslry+DBkxayzhVhie4FQO9YKjrmpNNvQ3GDJh1gpmw5zblXQv/hkYbhfdiH
 RIoIrpn5SZ6TFeXGa3Z0WYq2Ik7r1yTGgShYZ5uBa+cDFnrirJ4SvF1zvDZEL6MMm1tW
 Bxq1K1Odtk8dFyJMpWTgCen3djjN1fb6LKk7j37nCGgph8eBfy8if71WMXVMg6S7gADy
 LbaA==
X-Gm-Message-State: APjAAAWJqIzAOwXlW1kWZ2U5+6muz0UeAVVsWkKGDiYiIeLPJnb3WEPj
 xDH2YyUOudsf8o65v5ZiKGruYhwG06/y5o0z
X-Google-Smtp-Source: APXvYqxsnD+Jo105mPjhGwNF3/oOb/8PyFejgZk9M81Cc4FnNDOAYho3pGcYIKY4Qx20/ylLIGGd5g==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr26343355wro.360.1575830423618; 
 Sun, 08 Dec 2019 10:40:23 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:23 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 17/22] target/avr: Register AVR support with the rest of
 QEMU
Date: Sun,  8 Dec 2019 20:39:17 +0200
Message-Id: <20191208183922.13757-18-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add AVR related definitions into QEMU

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 qapi/machine.json          | 3 ++-
 include/disas/dis-asm.h    | 6 ++++++
 include/sysemu/arch_init.h | 1 +
 arch_init.c                | 2 ++
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index ca26779f1a..8c6df54921 100644
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
index e9c7dd8eb4..8bedce17ac 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -211,6 +211,12 @@ enum bfd_architecture
 #define bfd_mach_m32r          0  /* backwards compatibility */
   bfd_arch_mn10200,    /* Matsushita MN10200 */
   bfd_arch_mn10300,    /* Matsushita MN10300 */
+  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
+#define bfd_mach_avr1          1
+#define bfd_mach_avr2          2
+#define bfd_mach_avr3          3
+#define bfd_mach_avr4          4
+#define bfd_mach_avr5          5
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
2.17.2 (Apple Git-113)


