Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8EAC35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFDA820719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwMqakNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDA820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOTDF-0003Ij-Ml
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 18:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT65-0002ng-OY
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:13 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT63-0007QF-Nn
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:13 -0400
Received: by mail-oi1-x243.google.com with SMTP id n2so2758170oij.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 15:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S4v0KO82Wzlx0JZkhGIkBUAKLry2EN5cCldjJF9G/o4=;
 b=LwMqakNC2QpnD9J255X+mbTTPKvXL9QSu/A20IPVh7SQzOAMWEwVzamj4SeE9MgwU8
 4OSWR+zBL4QscrJqidiP3RssFihuT5Ckfr3fH1/tXf3oe42SoIvXuCY+EIbIPq3u5vXc
 MXuyUJVwLj+DGfUcxbXC7O5q/kpaUzBC55jhnGsI6zYgeam8eGb2NHKBR1XkMc7OUnJK
 K5vME11cMvtUzJevkdaWMmzG+Rr6ilsWw0ArMYSTjtAFfQBwHIx1pJlRf4g8+T8gOY3O
 zwuuiHpIbKtwnFCCXqkGcJjeyWFDhvpPn7BNMpyiv53JWIvP7IFx/o0ntqmbyaFTFSjB
 SZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S4v0KO82Wzlx0JZkhGIkBUAKLry2EN5cCldjJF9G/o4=;
 b=KEbKl8TCHdMMbWytBXRghByUSaPvgwXMy6GAVsB78DQrnfU8IhPGXMYl+ql59OnGbN
 jeWKTpXhWpQ7J0ZNOxIGirvwS7QFLw9/2k7haSDfeCj8fGra/WYmnRobnGFAWiu/BxoQ
 dqROmQGFsl5g1Dq9Ytt9OeNpeikpofV95+0ym03RaeHMf4QefdgHtyXxCOvGFd3x7Xdp
 ETSv+/3KLtbqH1yMbNNrCb6kRqs49Aa+9lx0h6UVuOCy8IneQztjFUOHT2nuuwJyz0p6
 QFy6FmU4vJSTqk6xqsymcjLcYSEHQfhQYHar4gS+w59bhTikg674m5gPF4lJSxT+gAE2
 PmpA==
X-Gm-Message-State: AOAM533GBF/EvNoApgBa2Yn4vvgTWjCrrlFWbaOkuEjEcXcoRu7F4yXG
 iS8BcGMXGJhGHUSrZLLqsmop6hggwCbYNO3d
X-Google-Smtp-Source: ABdhPJyDg5AYgtto1TjYwk96iEDlmR2uWk2IWKxajQsAfXzMXEG+9UxteMc+BygUv2Cdy4Ra8y6XbA==
X-Received: by 2002:aca:5b09:: with SMTP id p9mr2381132oib.68.1601676010042;
 Fri, 02 Oct 2020 15:00:10 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id k10sm684268ots.60.2020.10.02.15.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 15:00:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 8/8] tests/tcg/aarch64: Add bti smoke test
Date: Fri,  2 Oct 2020 16:59:55 -0500
Message-Id: <20201002215955.254866-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002215955.254866-1-richard.henderson@linaro.org>
References: <20201002215955.254866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test requires gcc 10 for -mbranch-protection=standard.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v9: Expect and require gcc 10.
---
 tests/tcg/aarch64/bti-1.c         | 62 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   | 51 +++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  7 ++++
 tests/tcg/configure.sh            |  4 ++
 4 files changed, 124 insertions(+)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c

diff --git a/tests/tcg/aarch64/bti-1.c b/tests/tcg/aarch64/bti-1.c
new file mode 100644
index 0000000000..61924f0d7a
--- /dev/null
+++ b/tests/tcg/aarch64/bti-1.c
@@ -0,0 +1,62 @@
+/*
+ * Branch target identification, basic notskip cases.
+ */
+
+#include "bti-crt.inc.c"
+
+static void skip2_sigill(int sig, siginfo_t *info, ucontext_t *uc)
+{
+    uc->uc_mcontext.pc += 8;
+    uc->uc_mcontext.pstate = 1;
+}
+
+#define NOP       "nop"
+#define BTI_N     "hint #32"
+#define BTI_C     "hint #34"
+#define BTI_J     "hint #36"
+#define BTI_JC    "hint #38"
+
+#define BTYPE_1(DEST) \
+    asm("mov %0,#1; adr x16, 1f; br x16; 1: " DEST "; mov %0,#0" \
+        : "=r"(skipped) : : "x16")
+
+#define BTYPE_2(DEST) \
+    asm("mov %0,#1; adr x16, 1f; blr x16; 1: " DEST "; mov %0,#0" \
+        : "=r"(skipped) : : "x16", "x30")
+
+#define BTYPE_3(DEST) \
+    asm("mov %0,#1; adr x15, 1f; br x15; 1: " DEST "; mov %0,#0" \
+        : "=r"(skipped) : : "x15")
+
+#define TEST(WHICH, DEST, EXPECT) \
+    do { WHICH(DEST); fail += skipped ^ EXPECT; } while (0)
+
+
+int main()
+{
+    int fail = 0;
+    int skipped;
+
+    /* Signal-like with SA_SIGINFO.  */
+    signal_info(SIGILL, skip2_sigill);
+
+    TEST(BTYPE_1, NOP, 1);
+    TEST(BTYPE_1, BTI_N, 1);
+    TEST(BTYPE_1, BTI_C, 0);
+    TEST(BTYPE_1, BTI_J, 0);
+    TEST(BTYPE_1, BTI_JC, 0);
+
+    TEST(BTYPE_2, NOP, 1);
+    TEST(BTYPE_2, BTI_N, 1);
+    TEST(BTYPE_2, BTI_C, 0);
+    TEST(BTYPE_2, BTI_J, 1);
+    TEST(BTYPE_2, BTI_JC, 0);
+
+    TEST(BTYPE_3, NOP, 1);
+    TEST(BTYPE_3, BTI_N, 1);
+    TEST(BTYPE_3, BTI_C, 1);
+    TEST(BTYPE_3, BTI_J, 0);
+    TEST(BTYPE_3, BTI_JC, 0);
+
+    return fail;
+}
diff --git a/tests/tcg/aarch64/bti-crt.inc.c b/tests/tcg/aarch64/bti-crt.inc.c
new file mode 100644
index 0000000000..47805f4e35
--- /dev/null
+++ b/tests/tcg/aarch64/bti-crt.inc.c
@@ -0,0 +1,51 @@
+/*
+ * Minimal user-environment for testing BTI.
+ *
+ * Normal libc is not (yet) built with BTI support enabled,
+ * and so could generate a BTI TRAP before ever reaching main.
+ */
+
+#include <stdlib.h>
+#include <signal.h>
+#include <ucontext.h>
+#include <asm/unistd.h>
+
+int main(void);
+
+void _start(void)
+{
+    exit(main());
+}
+
+void exit(int ret)
+{
+    register int x0 __asm__("x0") = ret;
+    register int x8 __asm__("x8") = __NR_exit;
+
+    asm volatile("svc #0" : : "r"(x0), "r"(x8));
+    __builtin_unreachable();
+}
+
+/*
+ * Irritatingly, the user API struct sigaction does not match the
+ * kernel API struct sigaction.  So for simplicity, isolate the
+ * kernel ABI here, and make this act like signal.
+ */
+void signal_info(int sig, void (*fn)(int, siginfo_t *, ucontext_t *))
+{
+    struct kernel_sigaction {
+        void (*handler)(int, siginfo_t *, ucontext_t *);
+        unsigned long flags;
+        unsigned long restorer;
+        unsigned long mask;
+    } sa = { fn, SA_SIGINFO, 0, 0 };
+
+    register int x0 __asm__("x0") = sig;
+    register void *x1 __asm__("x1") = &sa;
+    register void *x2 __asm__("x2") = 0;
+    register int x3 __asm__("x3") = sizeof(unsigned long);
+    register int x8 __asm__("x8") = __NR_rt_sigaction;
+
+    asm volatile("svc #0"
+                 : : "r"(x0), "r"(x1), "r"(x2), "r"(x3), "r"(x8) : "memory");
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index e7249915e7..491683e91d 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -25,6 +25,13 @@ run-pauth-%: QEMU_OPTS += -cpu max
 run-plugin-pauth-%: QEMU_OPTS += -cpu max
 endif
 
+# BTI Tests
+ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_BTI),)
+AARCH64_TESTS += bti-1
+bti-%: CFLAGS += -mbranch-protection=standard
+bti-%: LDFLAGS += -nostdlib
+endif
+
 # Semihosting smoke test for linux-user
 AARCH64_TESTS += semihosting
 run-semihosting: semihosting
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index be51bdb5a4..e1b70e25f2 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -240,6 +240,10 @@ for target in $target_list; do
                -march=armv8.3-a -o $TMPE $TMPC; then
                 echo "CROSS_CC_HAS_ARMV8_3=y" >> $config_target_mak
             fi
+            if do_compiler "$target_compiler" $target_compiler_cflags \
+               -mbranch-protection=standard -o $TMPE $TMPC; then
+                echo "CROSS_CC_HAS_ARMV8_BTI=y" >> $config_target_mak
+            fi
         ;;
     esac
 
-- 
2.25.1


