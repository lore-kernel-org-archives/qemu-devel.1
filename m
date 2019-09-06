Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5DDC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CC720693
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJBvtjaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CC720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HZE-0004OY-N2
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i6HYA-0003Us-Kz
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i6HY9-0000Vr-9a
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:57:30 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1i6HY9-0000V3-1D
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:57:29 -0400
Received: by mail-lj1-x243.google.com with SMTP id j16so6651938ljg.6
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=FYmI/nR+PsTPfRIZTkjXDdcmvOHgJsXzVpqJK8GNL6E=;
 b=dJBvtjazWaWquXJ4tJomp2dBzLbQFNy6QCbmhyAcG0JB6r8LYjoeutSxNIdCIpJggD
 hN8ZJkdnsurqGPhIJavJAS4YI9s5qu4qf8mswDzsMG4T1Rl4fpIX5/f+eqgbAFBN8rny
 lhp/fehoOUlhB/IKxJ1MuG1TblSoWpTxVvYCGGgiwgXy3l2Uo90gR76hUT++BX0pYKIy
 M+a0dwAKNb02w1zwhzCpQ5B6XqN47erpOPff8qH0InfVwT8oInImZaMkkDQdqvyUk+Fe
 aj+rVQUnIpZ5HDR/2apXM/yp9SxCB+vC42DyPhai0Gb8wC7CH/wiACbrBQTUUlHECKRG
 8sDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FYmI/nR+PsTPfRIZTkjXDdcmvOHgJsXzVpqJK8GNL6E=;
 b=Lz8expITUCy2mAlYuhilZU5tzVg7mFefg1+Qvj6h3y647aQ3Z37LwZf8RPieLio44K
 jMnD08ckiFR3Zpcyohpqvv9IH8YpL3uG5tJu3PSkMOn0ZdcuzugBj+kwmtA8NFbQ8hFz
 kHFyI5OWI1Lsjtc1hL9z7LeEtgu+huVVxq8aw3EvieWh6M2hmChDFh4GHGv2QCUhusMC
 mRF4BFUxHB7GrgOrriiDzy4P5VMC+xY5ecZ0pKyz0WNSxWNWquhd5gwsujiBq+HQNSWT
 TH3zaeppjdntRb/9lIAMVNC6bKSbaJbGlOKKHEKPG8xVAmrIOSBJDk2yHrO8E7yDPVhr
 Fcsw==
X-Gm-Message-State: APjAAAVR50b4zyP3NRvZui80mGvuME8vaj1rnSIIZ7j35GjXWkAfYPEn
 cO737FP3D4pmbT9DwPNUzke3X3iV
X-Google-Smtp-Source: APXvYqx9wnEByfylOtq5MrUibjHhzcjJKZ97EVETo9mfBa77hriK+50y3BhyHelMUK0h+01W5U637w==
X-Received: by 2002:a2e:884d:: with SMTP id z13mr6088602ljj.62.1567789046841; 
 Fri, 06 Sep 2019 09:57:26 -0700 (PDT)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id y26sm274949ljh.41.2019.09.06.09.57.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 09:57:26 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 09:57:13 -0700
Message-Id: <20190906165713.5558-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: [Qemu-devel] [PATCH v4] target/xtensa: linux-user: add call0 ABI
 support
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xtensa binaries built for call0 ABI don't rotate register window on
function calls and returns. Invocation of signal handlers from the
kernel is therefore different in windowed and call0 ABIs.
There's currently no way to determine xtensa ELF binary ABI from the
binary itself. Add handler for the -xtensa-abi-call0 command line
parameter/QEMU_XTENSA_ABI_CALL0 envitonment variable to the qemu-user
and record ABI choice. Use it to initialize PS.WOE in xtensa_cpu_reset.
Check PS.WOE in setup_rt_frame to determine how a signal should be
delivered.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/main.c          | 11 +++++++++++
 linux-user/xtensa/signal.c | 25 +++++++++++++++++--------
 target/xtensa/cpu.c        | 24 ++++++++++++++++++++----
 target/xtensa/cpu.h        |  3 +++
 4 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 47917bbb20fc..c9d97d2b1fc6 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -393,6 +393,13 @@ static void handle_arg_trace(const char *arg)
     trace_file = trace_opt_parse(arg);
 }
 
+#if defined(TARGET_XTENSA)
+static void handle_arg_abi_call0(const char *arg)
+{
+    xtensa_set_abi_call0();
+}
+#endif
+
 struct qemu_argument {
     const char *argv;
     const char *env;
@@ -446,6 +453,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
+#if defined(TARGET_XTENSA)
+    {"xtensa-abi-call0", "QEMU_XTENSA_ABI_CALL0", false, handle_arg_abi_call0,
+     "",           "assume CALL0 Xtensa ABI"},
+#endif
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index 8d54ef3ae34b..590f0313ffe9 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -134,6 +134,8 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr;
     struct target_rt_sigframe *frame;
     uint32_t ra;
+    bool abi_call0;
+    unsigned base;
     int i;
 
     frame_addr = get_sigframe(ka, env, sizeof(*frame));
@@ -182,20 +184,27 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         __put_user(0x00, &frame->retcode[5]);
 #endif
     }
-    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGISTER)) {
-        env->sregs[PS] |= PS_WOE | (1 << PS_CALLINC_SHIFT);
-    }
     memset(env->regs, 0, sizeof(env->regs));
     env->pc = ka->_sa_handler;
     env->regs[1] = frame_addr;
     env->sregs[WINDOW_BASE] = 0;
     env->sregs[WINDOW_START] = 1;
 
-    env->regs[4] = (ra & 0x3fffffff) | 0x40000000;
-    env->regs[6] = sig;
-    env->regs[7] = frame_addr + offsetof(struct target_rt_sigframe, info);
-    env->regs[8] = frame_addr + offsetof(struct target_rt_sigframe, uc);
+    abi_call0 = (env->sregs[PS] & PS_WOE) == 0;
+    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
+
+    if (abi_call0) {
+        base = 0;
+        env->regs[base] = ra;
+    } else {
+        env->sregs[PS] |= PS_WOE | (1 << PS_CALLINC_SHIFT);
+        base = 4;
+        env->regs[base] = (ra & 0x3fffffff) | 0x40000000;
+    }
+    env->regs[base + 2] = sig;
+    env->regs[base + 3] = frame_addr + offsetof(struct target_rt_sigframe,
+                                                info);
+    env->regs[base + 4] = frame_addr + offsetof(struct target_rt_sigframe, uc);
     unlock_user_struct(frame, frame_addr, 1);
     return;
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 76db1741a796..c65dcf9dd782 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -53,6 +53,20 @@ static bool xtensa_cpu_has_work(CPUState *cs)
 #endif
 }
 
+#ifdef CONFIG_USER_ONLY
+static bool abi_call0;
+
+void xtensa_set_abi_call0(void)
+{
+    abi_call0 = true;
+}
+
+bool xtensa_abi_call0(void)
+{
+    return abi_call0;
+}
+#endif
+
 /* CPUClass::reset() */
 static void xtensa_cpu_reset(CPUState *s)
 {
@@ -70,10 +84,12 @@ static void xtensa_cpu_reset(CPUState *s)
             XTENSA_OPTION_INTERRUPT) ? 0x1f : 0x10;
     env->pending_irq_level = 0;
 #else
-    env->sregs[PS] =
-        (xtensa_option_enabled(env->config,
-                               XTENSA_OPTION_WINDOWED_REGISTER) ? PS_WOE : 0) |
-        PS_UM | (3 << PS_RING_SHIFT);
+    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
+    if (xtensa_option_enabled(env->config,
+                              XTENSA_OPTION_WINDOWED_REGISTER) &&
+        !xtensa_abi_call0()) {
+        env->sregs[PS] |= PS_WOE;
+    }
 #endif
     env->sregs[VECBASE] = env->config->vecbase;
     env->sregs[IBREAKENABLE] = 0;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 0459243e6bb1..b363ffcf1066 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -673,6 +673,9 @@ static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
 {
     return env->system_er;
 }
+#else
+void xtensa_set_abi_call0(void);
+bool xtensa_abi_call0(void);
 #endif
 
 static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
-- 
2.11.0


