Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC62C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C0920735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDjEU/vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C0920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGbR-0005CT-8a
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUT-0005Xp-DY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUR-0008Vg-5E
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGUQ-0008OZ-QA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id f3so19944012wrw.7
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sOZl7N+p3d0MtLvUQi+HFwBRKeEwP2nCuZe7lsQ+1tk=;
 b=sDjEU/vC5XpYzrBk59Vs/9uz5vNuCsgw64KGFd2h3hHMlRdWqP9B7odldDBPszD08c
 pUzazi+IAioJXASXVJwNzGBhl4w7eOwzRQmO7QWcR9U0OjkkSyiMGQzpIbCHT3Clbl65
 O05qFmV08MWPF+9XRMX9QxFjB9RC4CvqsRgyxEdeoqRzzNivT5g7rAeQdn5EQeXDscMD
 bCTCYAMdFZrf0OA0i0XK0qA9pfTbNM9JOLCleoZSGx+QowIfQ+DjqG9d74lgWP+rOj9C
 ggwpaJawtE58MMjHtE8HOAGr6ZIzaJmAnjCB2fU9Qmk+HO86fvIfWlXQ7uwlT3ENZlcG
 o8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sOZl7N+p3d0MtLvUQi+HFwBRKeEwP2nCuZe7lsQ+1tk=;
 b=V3QCV2s6Das/i11MRCuLEUc4ERkQvIwtGX05iFjFEcLQXAFxZBy6YilGsewqqVHcOU
 jvEIpWyEnUd8+2wu1VrRbx3UTpDm7MqJ4QVNm40mtb5eqkD8YmxosurTICYQYNM0Oy8V
 nfn5jwF614i02Pv55ymBhyleeyHWxeAYD2yPGMqjmQnhdsC48AlJe2qpW9YXYpo3X6Lk
 NqaN6KAfT6FKvxt4jVTbEkJV6xEwQVnx3+JldYwp/F7zYj5ghZ/lztMt+p63FrMkU+zJ
 FLrcTAj0xW7OdUNeH4cM88Rb047dle34yblyMUScYk1cKhaXrVSF6MWYPMscn/i8aKNu
 LfuQ==
X-Gm-Message-State: ANhLgQ0GpWhDVzQb3sQGX1kOIqDOyoHCWpNZxNkhxAcwq2nLzqdntQZZ
 TiBAo1E0b4R50WFqWYKj7/36TOsQUM4=
X-Google-Smtp-Source: ADFU+vtZsfiSldtoUKh5bYcxeTK1QHVKSrHeBhpmRAR+r/8dvfitVVGObE6OPM/7rnpS8BPWxKMZJg==
X-Received: by 2002:adf:afdb:: with SMTP id y27mr216145wrd.208.1584467932107; 
 Tue, 17 Mar 2020 10:58:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a184sm203819wmf.29.2020.03.17.10.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:58:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 65DBB1FFAA;
 Tue, 17 Mar 2020 17:50:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 20/28] tests/tcg/aarch64: userspace system register test
Date: Tue, 17 Mar 2020 17:50:45 +0000
Message-Id: <20200317175053.5278-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests a bunch of registers that the kernel allows userspace to
read including the CPUID registers. We need a SVE aware compiler as we
are testing the id_aa64zfr0_el1 register in the set.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200316172155.971-21-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
new file mode 100644
index 00000000000..40cf8d2877e
--- /dev/null
+++ b/tests/tcg/aarch64/sysregs.c
@@ -0,0 +1,172 @@
+/*
+ * Check emulated system register access for linux-user mode.
+ *
+ * See: https://www.kernel.org/doc/Documentation/arm64/cpu-feature-registers.txt
+ *
+ * Copyright (c) 2019 Linaro
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/hwcap.h>
+#include <stdio.h>
+#include <sys/auxv.h>
+#include <signal.h>
+#include <string.h>
+#include <stdbool.h>
+
+#ifndef HWCAP_CPUID
+#define HWCAP_CPUID (1 << 11)
+#endif
+
+int failed_bit_count;
+
+/* Read and print system register `id' value */
+#define get_cpu_reg(id) ({                                      \
+            unsigned long __val = 0xdeadbeef;                   \
+            asm("mrs %0, "#id : "=r" (__val));                  \
+            printf("%-20s: 0x%016lx\n", #id, __val);            \
+            __val;                                               \
+        })
+
+/* As above but also check no bits outside of `mask' are set*/
+#define get_cpu_reg_check_mask(id, mask) ({                     \
+            unsigned long __cval = get_cpu_reg(id);             \
+            unsigned long __extra = __cval & ~mask;             \
+            if (__extra) {                                      \
+                printf("%-20s: 0x%016lx\n", "  !!extra bits!!", __extra);   \
+                failed_bit_count++;                            \
+            }                                                   \
+})
+
+/* As above but check RAZ */
+#define get_cpu_reg_check_zero(id) ({                           \
+            unsigned long __val = 0xdeadbeef;                   \
+            asm("mrs %0, "#id : "=r" (__val));                  \
+            if (__val) {                                        \
+                printf("%-20s: 0x%016lx (not RAZ!)\n", #id, __val);        \
+                failed_bit_count++;                            \
+            }                                                   \
+})
+
+/* Chunk up mask into 63:48, 47:32, 31:16, 15:0 to ease counting */
+#define _m(a, b, c, d) (0x ## a ## b ## c ## d ##ULL)
+
+bool should_fail;
+int should_fail_count;
+int should_not_fail_count;
+uintptr_t failed_pc[10];
+
+void sigill_handler(int signo, siginfo_t *si, void *data)
+{
+    ucontext_t *uc = (ucontext_t *)data;
+
+    if (should_fail) {
+        should_fail_count++;
+    } else {
+        uintptr_t pc = (uintptr_t) uc->uc_mcontext.pc;
+        failed_pc[should_not_fail_count++] =  pc;
+    }
+    uc->uc_mcontext.pc += 4;
+}
+
+int main(void)
+{
+    struct sigaction sa;
+
+    /* Hook in a SIGILL handler */
+    memset(&sa, 0, sizeof(struct sigaction));
+    sa.sa_flags = SA_SIGINFO;
+    sa.sa_sigaction = &sigill_handler;
+    sigemptyset(&sa.sa_mask);
+
+    if (sigaction(SIGILL, &sa, 0) != 0) {
+        perror("sigaction");
+        return 1;
+    }
+
+    /* Counter values have been exposed since Linux 4.12 */
+    printf("Checking Counter registers\n");
+
+    get_cpu_reg(ctr_el0);
+    get_cpu_reg(cntvct_el0);
+    get_cpu_reg(cntfrq_el0);
+
+    /* HWCAP_CPUID indicates we can read feature registers, since Linux 4.11 */
+    if (!(getauxval(AT_HWCAP) & HWCAP_CPUID)) {
+        printf("CPUID registers unavailable\n");
+        return 1;
+    } else {
+        printf("Checking CPUID registers\n");
+    }
+
+    /*
+     * Some registers only expose some bits to user-space. Anything
+     * that is IMPDEF is exported as 0 to user-space. The _mask checks
+     * assert no extra bits are set.
+     *
+     * This check is *not* comprehensive as some fields are set to
+     * minimum valid fields - for the purposes of this check allowed
+     * to have non-zero values.
+     */
+    get_cpu_reg_check_mask(id_aa64isar0_el1, _m(00ff,ffff,f0ff,fff0));
+    get_cpu_reg_check_mask(id_aa64isar1_el1, _m(0000,00f0,ffff,ffff));
+    /* TGran4 & TGran64 as pegged to -1 */
+    get_cpu_reg_check_mask(id_aa64mmfr0_el1, _m(0000,0000,ff00,0000));
+    get_cpu_reg_check_zero(id_aa64mmfr1_el1);
+    /* EL1/EL0 reported as AA64 only */
+    get_cpu_reg_check_mask(id_aa64pfr0_el1,  _m(000f,000f,00ff,0011));
+    get_cpu_reg_check_mask(id_aa64pfr1_el1,  _m(0000,0000,0000,00f0));
+    /* all hidden, DebugVer fixed to 0x6 (ARMv8 debug architecture) */
+    get_cpu_reg_check_mask(id_aa64dfr0_el1,  _m(0000,0000,0000,0006));
+    get_cpu_reg_check_zero(id_aa64dfr1_el1);
+    get_cpu_reg_check_zero(id_aa64zfr0_el1);
+
+    get_cpu_reg_check_zero(id_aa64afr0_el1);
+    get_cpu_reg_check_zero(id_aa64afr1_el1);
+
+    get_cpu_reg_check_mask(midr_el1,         _m(0000,0000,ffff,ffff));
+    /* mpidr sets bit 31, everything else hidden */
+    get_cpu_reg_check_mask(mpidr_el1,        _m(0000,0000,8000,0000));
+    /* REVIDR is all IMPDEF so should be all zeros to user-space */
+    get_cpu_reg_check_zero(revidr_el1);
+
+    /*
+     * There are a block of more registers that are RAZ in the rest of
+     * the Op0=3, Op1=0, CRn=0, CRm=0,4,5,6,7 space. However for
+     * brevity we don't check stuff that is currently un-allocated
+     * here. Feel free to add them ;-)
+     */
+
+    printf("Remaining registers should fail\n");
+    should_fail = true;
+
+    /* Unexposed register access causes SIGILL */
+    get_cpu_reg(id_mmfr0_el1);
+    get_cpu_reg(id_mmfr1_el1);
+    get_cpu_reg(id_mmfr2_el1);
+    get_cpu_reg(id_mmfr3_el1);
+
+    get_cpu_reg(mvfr0_el1);
+    get_cpu_reg(mvfr1_el1);
+
+    if (should_not_fail_count > 0) {
+        int i;
+        for (i = 0; i < should_not_fail_count; i++) {
+            uintptr_t pc = failed_pc[i];
+            uint32_t insn = *(uint32_t *) pc;
+            printf("insn %#x @ %#lx unexpected FAIL\n", insn, pc);
+        }
+        return 1;
+    }
+
+    if (failed_bit_count > 0) {
+        printf("Extra information leaked to user-space!\n");
+        return 1;
+    }
+
+    return should_fail_count == 6 ? 0 : 1;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 8ed477d0d51..a25afc071cc 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -42,4 +42,10 @@ run-semiconsole: semiconsole
 run-plugin-semiconsole-with-%:
 	$(call skip-test, $<, "MANUAL ONLY")
 
+ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
+# System Registers Tests
+AARCH64_TESTS += sysregs
+sysregs: CFLAGS+=-march=armv8.1-a+sve
+endif
+
 TESTS += $(AARCH64_TESTS)
-- 
2.20.1


