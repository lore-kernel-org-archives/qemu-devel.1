Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9679FC433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 21:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461C621726
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 21:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXt7I3zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461C621726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hu1Ja-0007TV-Kt
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 17:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52056)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hu1GL-00017B-Pw
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hu1GK-0005TV-1B
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:25 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hu1GJ-0005O2-Q4
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 17:08:23 -0400
Received: by mail-pg1-x544.google.com with SMTP id w3so546512pgt.13
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hqDSppWw6vFGW1wxYzaEvtXw5fh6OAkiiQRpVHdER/Q=;
 b=wXt7I3zB3wMa4+YLho9mQUxPzGQBbZhOb362mB0lupmEWE5Ts5RvEoLDu8UMmPJ16A
 SsoSkjCXr6uWvF0RInoU3J/L5jkRaBe1XYxZ+aLOYjfq61vjnWvOjz6MsAIJ+KGps+dP
 Z6CJXwPSprvhq9I9y74vl96j3jmzv03HxjdCYgvAPcXky2VC/Bx8fnzlk9EblFtwRb+J
 m5OWJrUu4nILp0jOk5n6kdsSSIeD/eZGSdqtTSD7wkMp79ulM1J446NIGP8yF9ZLQCb+
 MW8a3DtPA1epzLqQYc9cx9tv2xfmO/EyAHjtGFlLO34AJq3UjLE+s5fmwLrl9NWMCVA0
 r5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hqDSppWw6vFGW1wxYzaEvtXw5fh6OAkiiQRpVHdER/Q=;
 b=UQB1y117WglQh7GqxJeaD/zHHE7aiRTWNjedb/lxbeHWeUGB2Se22QcJkP+bxWf7ui
 2Jbk06kiPkFTTVxrX9ECJRDiKkugg6CFeaKS93h0RmDzKhI3ONso8wfBpb7lrHu7Yyiz
 l4uZX57727IU0uqei42J5Pspt1nNj8r6+rWpCoITNB85wVkw3mu7FgDamxpVdJZxPaZH
 1jV4OjtOE4sDd8OhFh+xqKd78aS10TZV+miXK92C0m5PulEsUOTdElGo5Gay0AUaZncp
 dPMxuYGN9IsFJG5W07Q6rVPFlLHaZ1CorzfRqirKhhBQwQE1YOChfUwbEAW00r5hbR5z
 y0mQ==
X-Gm-Message-State: APjAAAWTV3Hrf4QtK6Fvjd00bAxIq1jTrZWXZyB7gnM19GpYArKmoRFH
 USWwRvZExqBEXcfwb1GZuCygfhZqMzQ=
X-Google-Smtp-Source: APXvYqwZEeskjI8RRA9mcN66+3I83TnEbWS/spXp0EmaAZHS7uSYx4Pljs5hUjxTeqbiZSETogAfsQ==
X-Received: by 2002:a63:3006:: with SMTP id w6mr8164127pgw.440.1564866494221; 
 Sat, 03 Aug 2019 14:08:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id x25sm110129644pfa.90.2019.08.03.14.08.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 14:08:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 14:08:03 -0700
Message-Id: <20190803210803.5701-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803210803.5701-1-richard.henderson@linaro.org>
References: <20190803210803.5701-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v7 6/6] tests/tcg/aarch64: Add bti smoke test
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
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will build with older toolchains, without the upstream support
for -mbranch-protection.  Such a toolchain will produce a warning
in such cases,

ld: warning: /tmp/ccyZt0kq.o: unsupported GNU_PROPERTY_TYPE (5) \
type: 0xc0000000

but the still places the note at the correct location in the binary
for processing by the runtime loader.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/bti-1.c         | 77 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/bti-crt.inc.c   | 69 +++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  3 ++
 tests/tcg/aarch64/bti.ld          | 15 ++++++
 4 files changed, 164 insertions(+)
 create mode 100644 tests/tcg/aarch64/bti-1.c
 create mode 100644 tests/tcg/aarch64/bti-crt.inc.c
 create mode 100644 tests/tcg/aarch64/bti.ld

diff --git a/tests/tcg/aarch64/bti-1.c b/tests/tcg/aarch64/bti-1.c
new file mode 100644
index 0000000000..2aee57ea7a
--- /dev/null
+++ b/tests/tcg/aarch64/bti-1.c
@@ -0,0 +1,77 @@
+/*
+ * Branch target identification, basic notskip cases.
+ */
+
+#include "bti-crt.inc.c"
+
+/*
+ * Work around lack of -mbranch-protection=standard in older toolchains.
+ * The signal handler is invoked by the kernel with PSTATE.BTYPE=2, which
+ * means that the handler must begin with a marker like BTI_C.
+ */
+asm("skip2_sigill1:\n\
+	hint	#34\n\
+	b	skip2_sigill2\n\
+.type skip2_sigill1,%function\n\
+.size skip2_sigill1,8");
+
+extern void skip2_sigill1(int sig, siginfo_t *info, ucontext_t *uc)
+    __attribute__((visibility("hidden")));
+
+static void __attribute__((used))
+skip2_sigill2(int sig, siginfo_t *info, ucontext_t *uc)
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
+    signal_info(SIGILL, skip2_sigill1);
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
index 0000000000..bb363853de
--- /dev/null
+++ b/tests/tcg/aarch64/bti-crt.inc.c
@@ -0,0 +1,69 @@
+/*
+ * Minimal user-environment for testing BTI.
+ *
+ * Normal libc is not built with BTI support enabled, and so could
+ * generate a BTI TRAP before ever reaching main.
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
+
+/*
+ * Create the PT_NOTE that will enable BTI in the page tables.
+ * This will be created by the compiler with -mbranch-protection=standard,
+ * but as of 2019-03-29, this is has not been committed to gcc mainline.
+ * This will probably be in GCC10.
+ */
+asm(".section .note.gnu.property,\"a\"\n\
+	.align	3\n\
+	.long	4\n\
+        .long	16\n\
+        .long	5\n\
+        .string	\"GNU\"\n\
+	.long	0xc0000000\n\
+	.long	4\n\
+	.long	1\n\
+        .align  3\n\
+	.previous");
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 31ba9cfcaa..68135c6ee8 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -18,4 +18,7 @@ run-fcvt: fcvt
 AARCH64_TESTS += pauth-1 pauth-2
 run-pauth-%: QEMU += -cpu max
 
+AARCH64_TESTS += bti-1
+bti-1: LDFLAGS += -nostdlib -Wl,-T,$(AARCH64_SRC)/bti.ld
+
 TESTS:=$(AARCH64_TESTS)
diff --git a/tests/tcg/aarch64/bti.ld b/tests/tcg/aarch64/bti.ld
new file mode 100644
index 0000000000..a5ef98f8a2
--- /dev/null
+++ b/tests/tcg/aarch64/bti.ld
@@ -0,0 +1,15 @@
+ENTRY(_start)
+
+PHDRS
+{
+  text PT_LOAD FILEHDR PHDRS;
+  prop 0x6474e553 ;  /* PT_GNU_PROPERTY */
+}
+
+SECTIONS
+{
+  . = 1M + SIZEOF_HEADERS;
+  .note.gnu.property : { *(.note.gnu.property) } :text :prop
+  .text : { *(.text) *(.rodata) } :text
+  /DISCARD/ : { *(.note.gnu.build-id) }
+}
-- 
2.17.1


