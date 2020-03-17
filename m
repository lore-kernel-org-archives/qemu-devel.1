Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA6FC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37C8020738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxE6A7i+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C8020738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37007 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFXa-0003O0-A1
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCp-00042x-CW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCn-0004F1-FN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:39 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jEFCn-00048f-5j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:36:37 -0400
Received: by mail-wm1-x344.google.com with SMTP id 6so22193236wmi.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DlkS/lJlVKWDegsd0LArtsnfUSESor37RBYt82J35Yw=;
 b=bxE6A7i+0ViPtVoiqCdCdDrujxlJBXwkn71i2LpXhhXLnuF8qCjH4Ff1qhsXKTieZE
 eFoo9hrDF/fmtWmH9APLaUXP+U7fYcTeR5dm3Xg2YQ+GEnidoaqh3sVRdvd99T7M23ZX
 /VnSnJp3Vwn1fnfhBn5Ax8hSBtwZ8EJ6BYwrwGLLwpQMTFvH8STF+l9IKKqKSRUhON2B
 f/dsNQjaYwcLNMXxwsHyV/cA93l/Y9IwlVNfwBIbWj0FWukWVNqyUxVqd4FF1CvvIXqb
 Ofx3GlHykva1hZrVV5VFTKIHFc5zvsq2AyQg011mzUFUiytEUVXzC2MZwctSieJQLsYf
 Gj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DlkS/lJlVKWDegsd0LArtsnfUSESor37RBYt82J35Yw=;
 b=TV0NDuN3d/DwbYuh+9O6505OlaaX2FkPUhncDaPG4NQByAzrfRasju54mpauGegaQP
 9/qeF3mvbCtIAG+OA1TxcbMhoTXLMbJv1IiBjV1XhNgiQVKOfUzP7Zj/4naLDTM1C3rt
 ZSPtxcN+RY55wWs1PnhaUOl4JAio9quIgdwLsILx4BB//pUFNfaovCtjcGaZMdKqjj1q
 +g6mTT25OL4kOTVAcmpyiDEKP6z/JBXq+BWAQbS5PDERKxHvgYhr0Gll44RR4Ufh684U
 2uqP3L7Qfsmwe77EgJv1c4Wjtuqa8ApbERRN9zFS6LfPO0DVkQid2s9/tNFC/4qS9k5w
 fbkg==
X-Gm-Message-State: ANhLgQ1rWtzw4PbdK3PkLbBG0JQQnKiuNtmJ+ORMFLcUAlV/6+4enfOn
 +Tg1j3XiqvNZpuMxmxBBuv+klY8t
X-Google-Smtp-Source: ADFU+vuX8EYPXndq3XvjHfi3dSsQu5SHQg1fkgyygrhIJOPHtax7m6Jll5YSku2AFT5NUNxWUP2qNw==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr170913wmc.38.1584462995783;
 Tue, 17 Mar 2020 09:36:35 -0700 (PDT)
Received: from x1w.redhat.com (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b202sm4618697wmd.15.2020.03.17.09.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 09:36:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/13] Add rx-softmmu
Date: Tue, 17 Mar 2020 17:36:16 +0100
Message-Id: <20200317163616.30027-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317163616.30027-1-f4bug@amsat.org>
References: <20200317163616.30027-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMD: Squashed patches from Richard Henderson modifying
      qapi/common.json and tests/machine-none-test.c]
Message-Id: <20200224141923.82118-21-ysato@users.sourceforge.jp>
[PMD: Added @since 5.0 tag in SysEmuTarget]
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure                       | 11 ++++++++++-
 default-configs/rx-softmmu.mak  |  2 ++
 qapi/machine.json               |  4 +++-
 include/exec/poison.h           |  1 +
 include/sysemu/arch_init.h      |  1 +
 arch_init.c                     |  2 ++
 tests/qtest/machine-none-test.c |  1 +
 7 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100644 default-configs/rx-softmmu.mak

diff --git a/configure b/configure
index eb49bb6680..f9586cbc34 100755
--- a/configure
+++ b/configure
@@ -4184,7 +4184,7 @@ fi
 fdt_required=no
 for target in $target_list; do
   case $target in
-    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu|riscv*-softmmu)
+    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu|riscv*-softmmu|rx-softmmu)
       fdt_required=yes
     ;;
   esac
@@ -7881,6 +7881,12 @@ case "$target_name" in
     mttcg=yes
     gdb_xml_files="riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
   ;;
+  rx)
+    TARGET_ARCH=rx
+    bflt="yes"
+    target_compiler=$cross_cc_rx
+    gdb_xml_files="rx-core.xml"
+  ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
     bflt="yes"
@@ -8062,6 +8068,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   riscv*)
     disas_config "RISCV"
   ;;
+  rx)
+    disas_config "RX"
+  ;;
   s390*)
     disas_config "S390"
   ;;
diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.mak
new file mode 100644
index 0000000000..7c4eb2c1a0
--- /dev/null
+++ b/default-configs/rx-softmmu.mak
@@ -0,0 +1,2 @@
+# Default configuration for rx-softmmu
+
diff --git a/qapi/machine.json b/qapi/machine.json
index 6c11e3cf3a..282d247097 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -16,6 +16,8 @@
 # individual target constants are not documented here, for the time
 # being.
 #
+# @rx: since 5.0
+#
 # Notes: The resulting QMP strings can be appended to the "qemu-system-"
 #        prefix to produce the corresponding QEMU executable name. This
 #        is true even for "qemu-system-x86_64".
@@ -26,7 +28,7 @@
   'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
              'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
-             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
+             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
              'x86_64', 'xtensa', 'xtensaeb' ] }
 
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 955eb863ab..7b9ac361dc 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -26,6 +26,7 @@
 #pragma GCC poison TARGET_PPC
 #pragma GCC poison TARGET_PPC64
 #pragma GCC poison TARGET_ABI32
+#pragma GCC poison TARGET_RX
 #pragma GCC poison TARGET_S390X
 #pragma GCC poison TARGET_SH4
 #pragma GCC poison TARGET_SPARC
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 01392dc945..71a7a285ee 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -24,6 +24,7 @@ enum {
     QEMU_ARCH_NIOS2 = (1 << 17),
     QEMU_ARCH_HPPA = (1 << 18),
     QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_RX = (1 << 20),
 
     QEMU_ARCH_NONE = (1 << 31),
 };
diff --git a/arch_init.c b/arch_init.c
index 705d0b94ad..d9eb0ec1dd 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -77,6 +77,8 @@ int graphic_depth = 32;
 #define QEMU_ARCH QEMU_ARCH_PPC
 #elif defined(TARGET_RISCV)
 #define QEMU_ARCH QEMU_ARCH_RISCV
+#elif defined(TARGET_RX)
+#define QEMU_ARCH QEMU_ARCH_RX
 #elif defined(TARGET_S390X)
 #define QEMU_ARCH QEMU_ARCH_S390X
 #elif defined(TARGET_SH4)
diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index 5953d31755..8bb54a6360 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -56,6 +56,7 @@ static struct arch2cpu cpus_map[] = {
     { "hppa", "hppa" },
     { "riscv64", "rv64gcsu-v1.10.0" },
     { "riscv32", "rv32gcsu-v1.9.1" },
+    { "rx", "rx62n" },
 };
 
 static const char *get_cpu_model_by_arch(const char *arch)
-- 
2.21.1


