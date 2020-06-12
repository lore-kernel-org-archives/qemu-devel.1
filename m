Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4084C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7031D20853
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LF8mekIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7031D20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjYnJ-0002cK-Ki
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 21:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Z97iXgMKCqwVWlSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--jkz.bounces.google.com>)
 id 1jjYm0-0000yt-FG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:24 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:49577)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Z97iXgMKCqwVWlSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--jkz.bounces.google.com>)
 id 1jjYly-0001V3-H0
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:24 -0400
Received: by mail-yb1-xb49.google.com with SMTP id o140so8738216yba.16
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 18:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=DK7j++nEwmx0IXJsl6/327fR/1xlRgvEHDAk8673aKE=;
 b=LF8mekIt78DHARO9lp2gqgy8Xomvq7GbJpzWLfpELWN/OOC8/kvZzUBesI9jwV2CX7
 Zbw2i5xlfBEt2pm9rUkZZCfKBnED6jKUOp/aQnK5hzbO5YIsyZjxn7l/s3OfMMFZbsXG
 eImFm2ZxFIZFN188f3uCNgwUw9doEkyt5wDxRkiLtw1J5f9Lm03qm4bw8QbcCaS5Du+R
 sc81WFtlVAET/gXNGnYeUe1Fq/2yAmgr6kFV4V96AdayTHLgCDjuEGnoct0Wgwpneas9
 Fjh0gbulpxyCCNT2xCayB6SbhlVGOkDGWZG4mkVnIil3H9oT7IGKb0ZrLI7BddbxZfBP
 dCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=DK7j++nEwmx0IXJsl6/327fR/1xlRgvEHDAk8673aKE=;
 b=gGJREPnl7PrTn9TSTY9s/EUtWCeEoi7Ac8G+d8RubMSa4w6Zo8mmRoT9+UVdkpRDIE
 TW29BznnzoMkOnsQivEJ7ljy4kQ9bXilq3scSVDYsUfTCKbi1xoWSY4Iy2vCEhx/m5uG
 V4/dCfLLYhmkKeRR9pu52UvOlgtzdc7HG7HP1KoYifsp6ALzEK3XzLpZO2azqMg+fgV1
 GpDouUhJMeJGqOYcfvTYVHP3YyjBaQaL/tdRUDzdBt2KP+eTaUie2PFQrVvgpDoOpP+5
 0zKRSjAgGZwoKp4Gt8kPV+sS5ZyqttILZiqPT5yJHE7q9GyRIqWVG+DBPhOVsDkWwWrn
 9e4Q==
X-Gm-Message-State: AOAM5328TwGSobXFQF1PLBwY5NfKigqzJVLfDtytIQnxULmiPcbIcPHm
 B6RTEO+NbNQG+JMKOh1x6ITu/KqbJDXUkKzwlHJcytr/4WKs3ZKnrvZ5RPDKAJ85HULvbqx4gFJ
 ey/4xrxnrD3CfytL3xKamgsUQ5vlv8bgklaKM84hBAgCdvo7/qVlI
X-Google-Smtp-Source: ABdhPJwEkT/xjV3Iu9ncqRphNSpQ+qOLGtX2ke72xAkTOx6Rp/bRLRcr9avVPGd4oQSr8BXgpHtRAks=
X-Received: by 2002:a25:ec0d:: with SMTP id j13mr17129494ybh.364.1591926375093; 
 Thu, 11 Jun 2020 18:46:15 -0700 (PDT)
Date: Thu, 11 Jun 2020 18:46:04 -0700
In-Reply-To: <20200612014606.147691-1-jkz@google.com>
Message-Id: <20200612014606.147691-4-jkz@google.com>
Mime-Version: 1.0
References: <20200612014606.147691-1-jkz@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 3/5] linux-user: Make sigact_table part of the task state.
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3Z97iXgMKCqwVWlSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--jkz.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

sigact_table stores the signal handlers for the given process. Once we
support CLONE_VM, two tasks using the same virtual memory may need
different signal handler tables (e.g., if CLONE_SIGHAND is not
provided). Here we make sigact_table part of the TaskState, so it can be
duplicated as needed when cloning children.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/qemu.h    |  8 ++++++++
 linux-user/signal.c  | 35 +++++++++++++++++++++++++++--------
 linux-user/syscall.c | 17 +++++++++++++++++
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 989e01ad8d..54bf4f47be 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -177,6 +177,12 @@ typedef struct TaskState {
      * the table itself should be guarded.
      */
     struct fd_trans_table *fd_trans_tbl;
+
+    /*
+     * A table containing signal actions for the target. It should have at
+     * least TARGET_NSIG entries
+     */
+    struct target_sigaction *sigact_tbl;
 } __attribute__((aligned(16))) TaskState;
 
 extern char *exec_path;
@@ -419,7 +425,9 @@ void print_syscall_ret(int num, abi_long arg1);
  */
 void print_taken_signal(int target_signum, const target_siginfo_t *tinfo);
 
+
 /* signal.c */
+struct target_sigaction *sigact_table_clone(struct target_sigaction *orig);
 void process_pending_signals(CPUArchState *cpu_env);
 void signal_init(void);
 int queue_signal(CPUArchState *env, int sig, int si_type,
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 8cf51ffecd..dc98def6d1 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -25,7 +25,13 @@
 #include "trace.h"
 #include "signal-common.h"
 
-static struct target_sigaction sigact_table[TARGET_NSIG];
+struct target_sigaltstack target_sigaltstack_used = {
+    .ss_sp = 0,
+    .ss_size = 0,
+    .ss_flags = TARGET_SS_DISABLE,
+};
+
+typedef struct target_sigaction sigact_table[TARGET_NSIG];
 
 static void host_signal_handler(int host_signum, siginfo_t *info,
                                 void *puc);
@@ -542,6 +548,11 @@ static void signal_table_init(void)
     }
 }
 
+struct target_sigaction *sigact_table_clone(struct target_sigaction *orig)
+{
+    return memcpy(g_new(sigact_table, 1), orig, sizeof(sigact_table));
+}
+
 void signal_init(void)
 {
     TaskState *ts = (TaskState *)thread_cpu->opaque;
@@ -556,6 +567,12 @@ void signal_init(void)
     /* Set the signal mask from the host mask. */
     sigprocmask(0, 0, &ts->signal_mask);
 
+    /*
+     * Set all host signal handlers. ALL signals are blocked during
+     * the handlers to serialize them.
+     */
+    ts->sigact_tbl = (struct target_sigaction *) g_new0(sigact_table, 1);
+
     sigfillset(&act.sa_mask);
     act.sa_flags = SA_SIGINFO;
     act.sa_sigaction = host_signal_handler;
@@ -568,9 +585,9 @@ void signal_init(void)
         host_sig = target_to_host_signal(i);
         sigaction(host_sig, NULL, &oact);
         if (oact.sa_sigaction == (void *)SIG_IGN) {
-            sigact_table[i - 1]._sa_handler = TARGET_SIG_IGN;
+            ts->sigact_tbl[i - 1]._sa_handler = TARGET_SIG_IGN;
         } else if (oact.sa_sigaction == (void *)SIG_DFL) {
-            sigact_table[i - 1]._sa_handler = TARGET_SIG_DFL;
+            ts->sigact_tbl[i - 1]._sa_handler = TARGET_SIG_DFL;
         }
         /* If there's already a handler installed then something has
            gone horribly wrong, so don't even try to handle that case.  */
@@ -608,11 +625,12 @@ void force_sig(int sig)
 #if !defined(TARGET_RISCV)
 void force_sigsegv(int oldsig)
 {
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
     if (oldsig == SIGSEGV) {
         /* Make sure we don't try to deliver the signal again; this will
          * end up with handle_pending_signal() calling dump_core_and_abort().
          */
-        sigact_table[oldsig - 1]._sa_handler = TARGET_SIG_DFL;
+        ts->sigact_tbl[oldsig - 1]._sa_handler = TARGET_SIG_DFL;
     }
     force_sig(TARGET_SIGSEGV);
 }
@@ -837,6 +855,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     struct sigaction act1;
     int host_sig;
     int ret = 0;
+    TaskState* ts = (TaskState *)thread_cpu->opaque;
 
     trace_signal_do_sigaction_guest(sig, TARGET_NSIG);
 
@@ -848,7 +867,7 @@ int do_sigaction(int sig, const struct target_sigaction *act,
         return -TARGET_ERESTARTSYS;
     }
 
-    k = &sigact_table[sig - 1];
+    k = &ts->sigact_tbl[sig - 1];
     if (oact) {
         __put_user(k->_sa_handler, &oact->_sa_handler);
         __put_user(k->sa_flags, &oact->sa_flags);
@@ -930,7 +949,7 @@ static void handle_pending_signal(CPUArchState *cpu_env, int sig,
         sa = NULL;
         handler = TARGET_SIG_IGN;
     } else {
-        sa = &sigact_table[sig - 1];
+        sa = &ts->sigact_tbl[sig - 1];
         handler = sa->_sa_handler;
     }
 
@@ -1022,9 +1041,9 @@ void process_pending_signals(CPUArchState *cpu_env)
              * looping round and round indefinitely.
              */
             if (sigismember(&ts->signal_mask, target_to_host_signal_table[sig])
-                || sigact_table[sig - 1]._sa_handler == TARGET_SIG_IGN) {
+                || ts->sigact_tbl[sig - 1]._sa_handler == TARGET_SIG_IGN) {
                 sigdelset(&ts->signal_mask, target_to_host_signal_table[sig]);
-                sigact_table[sig - 1]._sa_handler = TARGET_SIG_DFL;
+                ts->sigact_tbl[sig - 1]._sa_handler = TARGET_SIG_DFL;
             }
 
             handle_pending_signal(cpu_env, sig, &ts->sync_signal);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ff1d07871f..838caf9c98 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5989,6 +5989,17 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         return -TARGET_EINVAL;
     }
 
+    if ((flags & CLONE_SIGHAND) && !(flags & CLONE_VM)) {
+        /*
+         * Like CLONE_FILES, this flag combination is unsupported. If
+         * CLONE_SIGHAND is specified without CLONE_VM, then we need to keep
+         * the sigact table in-sync across virtual memory boundaries, which is
+         * substantially more complicated.
+         */
+        qemu_log_mask(LOG_UNIMP, "CLONE_SIGHAND only supported with CLONE_VM");
+        return -TARGET_EINVAL;
+    }
+
     pthread_mutex_init(&info.mutex, NULL);
     pthread_mutex_lock(&info.mutex);
     pthread_cond_init(&info.cond, NULL);
@@ -6025,6 +6036,12 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ts->fd_trans_tbl = fd_trans_table_clone(parent_ts->fd_trans_tbl);
     }
 
+    if (flags & CLONE_SIGHAND) {
+        ts->sigact_tbl = parent_ts->sigact_tbl;
+    } else {
+        ts->sigact_tbl = sigact_table_clone(parent_ts->sigact_tbl);
+    }
+
     if (flags & CLONE_CHILD_CLEARTID) {
         ts->child_tidptr = child_tidptr;
     }
-- 
2.27.0.290.gba653c62da-goog


