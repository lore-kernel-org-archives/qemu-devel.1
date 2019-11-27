Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81891C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383AC2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ7TCVAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383AC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia1iP-0003kr-QO
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Vv-0002Iw-I6
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Vs-0006nz-IP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:06 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ia1Vm-0006kR-SC
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id a15so27741964wrf.9
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QzkggShKJxMML3S9AoJpwH/jsYAJf69kpBa7w1DUyrA=;
 b=BJ7TCVAwqUlUZYyeManl3+KFG7EfSprimeAlJO389wqcRwtYfC7zk/Jsq52g8Y7xh7
 ldvgkH+5uRTcBpTB8uh9x/311gDszKKXy0ddZqeUtXpXOhtzwpkr6eRXXvl2Zq3xrCsM
 7m+e5AkyBBDFXfxotHQYKCVks5ur/orqEpqi/Gn5W3ymTidsU4oFyl0KRGfwZTxyVLqg
 Ub3yAPgKgCx9xrfXSFsIXRO5LHj5xsUqy0jYJloc2xKzrcDEXZH3yRDk74d+h+bbFQh6
 WTqrqvblzIlV4wW3RI294MHmvTIPldgyjU8NF2ky29/oEDWLAuwPV97z3QczWjcc3FNX
 YwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QzkggShKJxMML3S9AoJpwH/jsYAJf69kpBa7w1DUyrA=;
 b=FgLly9NrwpkR8x8jIgtZCBPiOGZNxHugEOP8rfO9Eydxu2myD1t6z6fBB52w32SNLU
 aShFh1QQMR3bMfAa7VaJt65Jvo73BVS6gqJ6lXwGY08+UO5k7TNvXAK6PY7Nr8pauqH4
 4mxC2IOpZO8aCHgJiDWocx2xLEbLekhLMsdIymYHICDSQgoq/HarBjd+dq6yspKV4ZZD
 jN94+XS7Bt7pLpr46avsiJQj6yBPkSJ4qUxWboT3AWnx/ghZ/nJr6zWYthn1QC88f+8t
 PnJMfyy4PkTau3IekjWrD4W5hq7ZkobFGh4A461L9XmT/Dx7zrTKPSZLKFtTYlD9pBou
 T6Rg==
X-Gm-Message-State: APjAAAUFiNH/0i6zRnBKbHdQWPcF5ilFuux1fKfzSHRJuiyvo4BoYM08
 wEnhjrsHWh7ukqTp8obL/AgA/xGi6roZeo32
X-Google-Smtp-Source: APXvYqy82WtsZwdr1XUa2SlvDg9URgwz7nbs/qWh8Y7Q5J2+yPF5ovpu0Fb/9JQCmwjhEG9D5bB7BA==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr42937466wrl.190.1574877236877; 
 Wed, 27 Nov 2019 09:53:56 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-2-87.red.bezeqint.net. [79.178.2.87])
 by smtp.gmail.com with ESMTPSA id b2sm20238295wrr.76.2019.11.27.09.53.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 27 Nov 2019 09:53:56 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v37 13/17] target/avr: Register AVR support with the rest of
 QEMU
Date: Wed, 27 Nov 2019 19:52:53 +0200
Message-Id: <20191127175257.23480-14-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191127175257.23480-1-mrolnik@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
 tests/machine-none-test.c  | 1 +
 5 files changed, 12 insertions(+), 1 deletion(-)

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
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 5953d31755..3e5c74e73e 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] = {
     /* tested targets list */
     { "arm", "cortex-a15" },
     { "aarch64", "cortex-a57" },
+    { "avr", "avr6-avr-cpu" },
     { "x86_64", "qemu64,apic-id=0" },
     { "i386", "qemu32,apic-id=0" },
     { "alpha", "ev67" },
-- 
2.17.2 (Apple Git-113)


