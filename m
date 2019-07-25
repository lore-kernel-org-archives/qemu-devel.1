Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33816C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D062238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 13:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOoZUSkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D062238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqdcG-0006Cw-74
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 09:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46257)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqdc3-0005oI-Q3
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqdc2-0000m8-8G
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:16:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqdc2-0000lw-0w
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 09:16:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id u25so34362139wmc.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 06:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=awbVXWJ0H/ID3VyhdnpYTxFXtlPEQgwVdKk0JkyiGr0=;
 b=jOoZUSkMmj/j/ogJ+DXzuExrj5flQkoMEBUUMI/CUrVc/GUPlgv/xUxNnnwLJcntKa
 b3D0UrRetimHCtlB8G5EYJbgESo2lE2Q1O9XdeIT0d+8AL7PXcTHNcRtxoLmnjb/0AoY
 COmuDDWv8D88hJ6KqtvsDTcGlfemxzykO1Cetj+lsgxbeKv9iksZbEusgNlDnoDY2G8Y
 WrtF8PW9NReTBdbiWIdkbvBaeJky2Km51YC4KkbP2wrBHTAIEn2QmrO4Awyh+aeEeug7
 hFss4GkCrT27aQrsE6GlO8Oh9STM5Z/cD4oOd2aCRr155q+X2PY5rUs29UIElrpLpv/U
 V4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=awbVXWJ0H/ID3VyhdnpYTxFXtlPEQgwVdKk0JkyiGr0=;
 b=PWjRzJjvz9TN+Rm/N8a7l79NgXvr6FjF3vjbJIDsaBtdtAkt5SZ7QSQPOXGRz7Bm6q
 O7ewYP5Oq+0ZIVt9SXnO/cUoDjUi1FVpvdDCMtSE67SbR8t0l0kB66Gsm3edEIPimMD0
 GqX29M908PRqPN9vLTJLS/+JnkHsoLly5OKTMM+7FOqB+hsUWu3wDhHY1Gk1uNUgyNfq
 AXb26lwpd5+xOF1SayduAOcaB8FyphkjpoXp6HITtG6cDplUI96npnxG1SS8KNLcEFxr
 UOMoRCCJcECrVIQegaDXms5BhiYVIw99YclRmLSL/RorE3kC/dUCrsmeywagBkBNjLtt
 Milg==
X-Gm-Message-State: APjAAAWg5+XBo8q1Tp82/Q/CvOX45ojGzpPmgoBaQGBRb9QjiYPux7T/
 hzz1qoLml8tNJzdmjjoGrvyGx+DPrtHctg==
X-Google-Smtp-Source: APXvYqxxMId0LL7ZwUHEf25SkHDjH9pwlWEmWCExQfn6ZZ66hbpZrnbkLcunjYx71yn8EtLjG0R46w==
X-Received: by 2002:a1c:ab06:: with SMTP id u6mr78455815wme.125.1564060608558; 
 Thu, 25 Jul 2019 06:16:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x185sm38771751wmg.46.2019.07.25.06.16.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 06:16:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 14:16:45 +0100
Message-Id: <20190725131645.19501-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH for-4.1] linux-user: Make sigaltstack stacks
 per-thread
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 patches@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The alternate signal stack set up by the sigaltstack syscall is
supposed to be per-thread.  We were incorrectly implementing it as
process-wide.  This causes problems for guest binaries that rely on
this.  Notably the Go runtime does, and so we were seeing crashes
caused by races where two guest threads might incorrectly both
execute on the same stack simultaneously.

Replace the global target_sigaltstack_used with a field
sigaltstack_used in the TaskState, and make all the references to the
old global instead get a pointer to the TaskState and use the field.

Fixes: https://bugs.launchpad.net/qemu/+bug/1696773
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I've marked this as "for-4.1" but it is quite late in the release
cycle and I think this could use more testing than I have given it...

Thanks are due to:
 * the original bug reporter, for providing a nice simple test case
 * rr, for allowing me to capture and forensically examine a single
   example of the failure
 * the Go project for having a good clear HACKING.md that explained
   their stack usage and mentioned specifically that signal stacks
   are per-thread (per-M, in their terms)
 * a colleague, for prodding me into actually spending the necessary
   two days grovelling through gdb sessions and logs to figure out
   what was actually going wrong
---
 linux-user/qemu.h          |  2 ++
 linux-user/signal-common.h |  1 -
 linux-user/hppa/signal.c   |  3 ++-
 linux-user/main.c          |  5 +++++
 linux-user/signal.c        | 35 +++++++++++++++++++----------------
 5 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4258e4162d2..aac03346270 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -151,6 +151,8 @@ typedef struct TaskState {
      */
     int signal_pending;
 
+    /* This thread's sigaltstack, if it has one */
+    struct target_sigaltstack sigaltstack_used;
 } __attribute__((aligned(16))) TaskState;
 
 extern char *exec_path;
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 51030a93069..1df1068552f 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -19,7 +19,6 @@
 
 #ifndef SIGNAL_COMMON_H
 #define SIGNAL_COMMON_H
-extern struct target_sigaltstack target_sigaltstack_used;
 
 int on_sig_stack(unsigned long sp);
 int sas_ss_flags(unsigned long sp);
diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index b6927ee6735..d1a58feeb36 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -111,10 +111,11 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr, sp, haddr;
     struct target_rt_sigframe *frame;
     int i;
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
 
     sp = get_sp_from_cpustate(env);
     if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
-        sp = (target_sigaltstack_used.ss_sp + 0x7f) & ~0x3f;
+        sp = (ts->sigaltstack_used.ss_sp + 0x7f) & ~0x3f;
     }
     frame_addr = QEMU_ALIGN_UP(sp, 64);
     sp = frame_addr + PARISC_RT_SIGFRAME_SIZE32;
diff --git a/linux-user/main.c b/linux-user/main.c
index a59ae9439de..8ffc5251955 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -180,6 +180,11 @@ void stop_all_tasks(void)
 void init_task_state(TaskState *ts)
 {
     ts->used = 1;
+    ts->sigaltstack_used = (struct target_sigaltstack) {
+        .ss_sp = 0,
+        .ss_size = 0,
+        .ss_flags = TARGET_SS_DISABLE,
+    };
 }
 
 CPUArchState *cpu_copy(CPUArchState *env)
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5cd237834d9..5ca6d62b15d 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -25,12 +25,6 @@
 #include "trace.h"
 #include "signal-common.h"
 
-struct target_sigaltstack target_sigaltstack_used = {
-    .ss_sp = 0,
-    .ss_size = 0,
-    .ss_flags = TARGET_SS_DISABLE,
-};
-
 static struct target_sigaction sigact_table[TARGET_NSIG];
 
 static void host_signal_handler(int host_signum, siginfo_t *info,
@@ -251,13 +245,17 @@ void set_sigmask(const sigset_t *set)
 
 int on_sig_stack(unsigned long sp)
 {
-    return (sp - target_sigaltstack_used.ss_sp
-            < target_sigaltstack_used.ss_size);
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+
+    return (sp - ts->sigaltstack_used.ss_sp
+            < ts->sigaltstack_used.ss_size);
 }
 
 int sas_ss_flags(unsigned long sp)
 {
-    return (target_sigaltstack_used.ss_size == 0 ? SS_DISABLE
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+
+    return (ts->sigaltstack_used.ss_size == 0 ? SS_DISABLE
             : on_sig_stack(sp) ? SS_ONSTACK : 0);
 }
 
@@ -266,17 +264,21 @@ abi_ulong target_sigsp(abi_ulong sp, struct target_sigaction *ka)
     /*
      * This is the X/Open sanctioned signal stack switching.
      */
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+
     if ((ka->sa_flags & TARGET_SA_ONSTACK) && !sas_ss_flags(sp)) {
-        return target_sigaltstack_used.ss_sp + target_sigaltstack_used.ss_size;
+        return ts->sigaltstack_used.ss_sp + ts->sigaltstack_used.ss_size;
     }
     return sp;
 }
 
 void target_save_altstack(target_stack_t *uss, CPUArchState *env)
 {
-    __put_user(target_sigaltstack_used.ss_sp, &uss->ss_sp);
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+
+    __put_user(ts->sigaltstack_used.ss_sp, &uss->ss_sp);
     __put_user(sas_ss_flags(get_sp_from_cpustate(env)), &uss->ss_flags);
-    __put_user(target_sigaltstack_used.ss_size, &uss->ss_size);
+    __put_user(ts->sigaltstack_used.ss_size, &uss->ss_size);
 }
 
 /* siginfo conversion */
@@ -708,12 +710,13 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
 {
     int ret;
     struct target_sigaltstack oss;
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
 
     /* XXX: test errors */
     if(uoss_addr)
     {
-        __put_user(target_sigaltstack_used.ss_sp, &oss.ss_sp);
-        __put_user(target_sigaltstack_used.ss_size, &oss.ss_size);
+        __put_user(ts->sigaltstack_used.ss_sp, &oss.ss_sp);
+        __put_user(ts->sigaltstack_used.ss_size, &oss.ss_size);
         __put_user(sas_ss_flags(sp), &oss.ss_flags);
     }
 
@@ -760,8 +763,8 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp)
             }
         }
 
-        target_sigaltstack_used.ss_sp = ss.ss_sp;
-        target_sigaltstack_used.ss_size = ss.ss_size;
+        ts->sigaltstack_used.ss_sp = ss.ss_sp;
+        ts->sigaltstack_used.ss_size = ss.ss_size;
     }
 
     if (uoss_addr) {
-- 
2.20.1


