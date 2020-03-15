Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B41C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10204205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3srgMj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10204205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTWd-0001oB-6l
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJn-0008Bo-1d
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJl-0003aj-By
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJl-0003UZ-3e
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id w16so1441714wrv.13
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cuBEOn9/Ic9jbWTmqCOXpfzjEXGYgqjGci1P70u9DHM=;
 b=j3srgMj4TLFCKDsxJknHIaMiPki1TfW/qbdRQ7FPkEeHHOWUAC8bnV/8q5fh2ELrUs
 ryunUTlq6QKXfr0XkW+MFXPmLPITs7ehjAWYJQYutTQ6gmfBaM3PAfdkSPbw2Hi1n5Z9
 GFPhEX1uTZoTtdsN7xqO2dQsI6heLZYjcQHbbrsnnfUWDBAWfTKmSWoymSn/NU6iMfsW
 fmmxRSxsVL9xHW/mQc+tG4ntwLrxceAnB4CYQwCB4NaF5kYpR+7UBcGnzd1ocu5b0Y0n
 EYm7hDK3Jz12U8br04eVhOVu4pONkJa+M+kitv1978Ed+0F9SXGXg8ZNDvKmQ8PmuwNa
 HfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cuBEOn9/Ic9jbWTmqCOXpfzjEXGYgqjGci1P70u9DHM=;
 b=eW/hY7L/Xk/nHeVgAiSqsjMIJ867Ied4O6y581+oLS5dZ4PIeHG9PzjdIFbnvY4dZk
 tnSRj/P+fSwQ4joEVEDBNetVm24hzPksH2n7xI3VfqtwABRJKzUW5fYWnTa89iIlSbJQ
 DQN4HdHDh9JCsBxS8KAyKlJK1L1hYFpm5CRM2Csh1MCGWShxMBFDwQ+5eJQkZLRkIjQa
 uggv8/n4eSMxJJoa2ErGyqXNjQ4gmQKqCYat8+Kdq/OGL+G+JnerCmOyAuQx2ZBocaFl
 /pfBZ1V9i0vY5tJQSSj5ZEAYQPLqzKg92izlviJsmWVWkwJQQOg+gYMxfhUbrGDK56Bj
 QMMg==
X-Gm-Message-State: ANhLgQ02KrtGUFVMgs0Wputq+/qxsVFKCQyNG3DnWFmyqbG3xh4VdV6i
 dABTNVUEC/qYblF1Aq/F+M1N2qlU
X-Google-Smtp-Source: ADFU+vt18n1IjhZ3wRtmU1WVDIhxsaXCRd/zDW0zCUlu/whWN0ED03jBy+yOE4wbIPNmuOWqKyqMUA==
X-Received: by 2002:adf:f74d:: with SMTP id z13mr7108945wrp.339.1584278915813; 
 Sun, 15 Mar 2020 06:28:35 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm87590503wrp.37.2020.03.15.06.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 06:28:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/13] Add rx-softmmu
Date: Sun, 15 Mar 2020 14:28:09 +0100
Message-Id: <20200315132810.7022-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315132810.7022-1-f4bug@amsat.org>
References: <20200315132810.7022-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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


