Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA05C33CAC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F2520CC7
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 02:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmY7TIqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F2520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyoOj-0006mt-34
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 21:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32807)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <389w4XgMKCogvwBs00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--jkz.bounces.google.com>)
 id 1iyoMR-0002ko-IN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <389w4XgMKCogvwBs00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--jkz.bounces.google.com>)
 id 1iyoMP-0003qj-Mb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:47 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549]:33847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <389w4XgMKCogvwBs00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--jkz.bounces.google.com>)
 id 1iyoMP-0003hb-EA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 21:54:45 -0500
Received: by mail-pg1-x549.google.com with SMTP id j72so3920050pgc.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 18:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=FPJJy/P7XFqib7no9Q/GBotl3a6RnN+hxGECC8rpzIA=;
 b=rmY7TIqZ3fn1/+Hic/DRNvm9CD3snCwxiK3VuoFdcXAHMap3WnVUsK2MYaeAkLbW8I
 Gw5r3H+Zkh11Lqkuvfz8c/LV056xzk2scmg/lHMe+QJIdTYgyKhvrvyt6nheSVYCeKjY
 HriaFx9OKgpR0ipm4Vx67eZk7O2muOhBYkEeCe32olQ/b6nUlp+m0V9Fsk4cFrtDiq7d
 yexRxLprSmEufPVI56HKkE9hO3BYuXUHl83cfvD4hRiRxDqKTyMd/QeWXzqJW2fmXLqG
 hrV7YH6tdZPc0zPsRQmHZYPW95MeILlhN8BgNzDOdBmxg0DC421l/IgClN+WDrGwZvrt
 MVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=FPJJy/P7XFqib7no9Q/GBotl3a6RnN+hxGECC8rpzIA=;
 b=MuJsZ1XGuIpKYXDT7wk1rkD9yezEUvhTgDjlzphuCvvYj6QYVJNLIxcXajsytFMsj5
 i1o47r83zBeXl7LI6XDZ5FVAP7VMIc9CeTXiV+bHVVCXLUMSzGqBnMWso3XuyluuwceH
 H0MSb945+x0GurYuJEPmS5ccXDuknQXrK/9XaI7dEJtv7HN4LTq+uUtaD+KXfTi7e3Mk
 LLjHOL8LNt/9e9iIQyj9RpVD3VXLXPi/AfBICy4HRk8X6sCAGbwrnNChjRaCX4Uz1r8c
 hB7mf5dyRXq67jX8HZP/32RDtf8F+WG/4YN+3QGpXkg1pmSnH6QxE8mU0BJZUZLCqHTx
 G+jg==
X-Gm-Message-State: APjAAAUlyRA5QL2M8Vur/kOoMaPB1S2R+nzdZI1wYEE92GmfbH9aTBKV
 zZBOcdiQQFxsghtllB3p3u77uOVh+elciAKIIC/+HFNQquEiBe1NpH93YuCJKKGN1kib6HbcFAo
 dpd/6/WjpJEsbs3ybbNS7g25+3CuFqCr0r/LcykwJjUFvLEiiFROu
X-Google-Smtp-Source: APXvYqy9GzUkUChz+JzTCqtmhCxHE+PNeAXC88j9tXZr2gXNQOeurGrCc1VqkcO38t5PB3R/Y++Yi/U=
X-Received: by 2002:a63:2701:: with SMTP id n1mr4167478pgn.332.1580784883716; 
 Mon, 03 Feb 2020 18:54:43 -0800 (PST)
Date: Mon,  3 Feb 2020 18:54:16 -0800
In-Reply-To: <20200204025416.111409-1-jkz@google.com>
Message-Id: <20200204025416.111409-5-jkz@google.com>
Mime-Version: 1.0
References: <20200204025416.111409-1-jkz@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3 4/4] bsd-user: Replace gemu_log with qemu_log
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 armbru@redhat.com, imp@bsdimp.com, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::549
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

gemu_log is an old logging mechanism used to implement strace logging in
the bsd-user tree. It logs directly to stderr and cannot easily be
redirected. This change instead causes strace to log via the qemu_log
subsystem which has fine-grained logging control, and a centralized
mechanism for log redirection. bsd-user does not currently implement any
logging redirection options, or log masking options, but this change
brings it more in line with the linux-user tree.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 bsd-user/main.c    | 29 +++++++++++++----------------
 bsd-user/qemu.h    |  2 --
 bsd-user/strace.c  | 32 +++++++++++++++-----------------
 bsd-user/syscall.c | 31 +++++++++++++++++++------------
 4 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 770c2b267a..d024ac067f 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -55,15 +55,6 @@ enum BSDType bsd_type;
    by remapping the process stack directly at the right place */
 unsigned long x86_stack_size = 512 * 1024;
 
-void gemu_log(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
-    va_end(ap);
-}
-
 #if defined(TARGET_I386)
 int cpu_get_pic_interrupt(CPUX86State *env)
 {
@@ -731,6 +722,7 @@ int main(int argc, char **argv)
     const char *cpu_type;
     const char *log_file = NULL;
     const char *log_mask = NULL;
+    bool enable_strace = false;
     struct target_pt_regs regs1, *regs = &regs1;
     struct image_info info1, *info = &info1;
     TaskState ts1, *ts = &ts1;
@@ -845,7 +837,7 @@ int main(int argc, char **argv)
         } else if (!strcmp(r, "singlestep")) {
             singlestep = 1;
         } else if (!strcmp(r, "strace")) {
-            do_strace = 1;
+            enable_strace = true;
         } else if (!strcmp(r, "trace")) {
             g_free(trace_file);
             trace_file = trace_opt_parse(optarg);
@@ -854,17 +846,26 @@ int main(int argc, char **argv)
         }
     }
 
+    if (getenv("QEMU_STRACE")) {
+        enable_strace = true;
+    }
+
     /* init debug */
     qemu_log_needs_buffers();
     qemu_set_log_filename(log_file, &error_fatal);
-    if (log_mask) {
+    if (log_mask || enable_strace) {
         int mask;
 
         mask = qemu_str_to_log_mask(log_mask);
-        if (!mask) {
+        if (log_mask && !mask) {
             qemu_print_log_usage(stdout);
             exit(1);
         }
+
+        if (enable_strace) {
+            mask |= LOG_STRACE;
+        }
+
         qemu_set_log(mask);
     }
 
@@ -916,10 +917,6 @@ int main(int argc, char **argv)
 #endif
     thread_cpu = cpu;
 
-    if (getenv("QEMU_STRACE")) {
-        do_strace = 1;
-    }
-
     target_environ = envlist_to_environ(envlist, NULL);
     envlist_free(envlist);
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 09e8aed9c7..5762e3a6e5 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -152,7 +152,6 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
 abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
                             abi_long arg2, abi_long arg3, abi_long arg4,
                             abi_long arg5, abi_long arg6);
-void gemu_log(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 extern THREAD CPUState *thread_cpu;
 void cpu_loop(CPUArchState *env);
 char *target_strerror(int err);
@@ -188,7 +187,6 @@ print_openbsd_syscall(int num,
                       abi_long arg1, abi_long arg2, abi_long arg3,
                       abi_long arg4, abi_long arg5, abi_long arg6);
 void print_openbsd_syscall_ret(int num, abi_long ret);
-extern int do_strace;
 
 /* signal.c */
 void process_pending_signals(CPUArchState *cpu_env);
diff --git a/bsd-user/strace.c b/bsd-user/strace.c
index fa66fe1ee2..6ee1510555 100644
--- a/bsd-user/strace.c
+++ b/bsd-user/strace.c
@@ -23,8 +23,6 @@
 
 #include "qemu.h"
 
-int do_strace;
-
 /*
  * Utility functions
  */
@@ -36,17 +34,17 @@ static void print_sysctl(const struct syscallname *name, abi_long arg1,
     uint32_t i;
     int32_t *namep;
 
-    gemu_log("%s({ ", name->name);
+    qemu_log("%s({ ", name->name);
     namep = lock_user(VERIFY_READ, arg1, sizeof(int32_t) * arg2, 1);
     if (namep) {
         int32_t *p = namep;
 
         for (i = 0; i < (uint32_t)arg2; i++) {
-            gemu_log("%d ", tswap32(*p++));
+            qemu_log("%d ", tswap32(*p++));
         }
         unlock_user(namep, arg1, 0);
     }
-    gemu_log("}, %u, 0x" TARGET_ABI_FMT_lx ", 0x" TARGET_ABI_FMT_lx ", 0x"
+    qemu_log("}, %u, 0x" TARGET_ABI_FMT_lx ", 0x" TARGET_ABI_FMT_lx ", 0x"
         TARGET_ABI_FMT_lx ", 0x" TARGET_ABI_FMT_lx ")",
         (uint32_t)arg2, arg3, arg4, arg5, arg6);
 }
@@ -62,7 +60,7 @@ static void print_execve(const struct syscallname *name, abi_long arg1,
     if (s == NULL) {
         return;
     }
-    gemu_log("%s(\"%s\",{", name->name, s);
+    qemu_log("%s(\"%s\",{", name->name, s);
     unlock_user(s, arg1, 0);
 
     for (arg_ptr_addr = arg2; ; arg_ptr_addr += sizeof(abi_ulong)) {
@@ -78,11 +76,11 @@ static void print_execve(const struct syscallname *name, abi_long arg1,
             break;
         }
         if ((s = lock_user_string(arg_addr))) {
-            gemu_log("\"%s\",", s);
+            qemu_log("\"%s\",", s);
             unlock_user(s, arg_addr, 0);
         }
     }
-    gemu_log("NULL})");
+    qemu_log("NULL})");
 }
 
 static void print_ioctl(const struct syscallname *name,
@@ -90,7 +88,7 @@ static void print_ioctl(const struct syscallname *name,
         abi_long arg5, abi_long arg6)
 {
     /* Decode the ioctl request */
-    gemu_log("%s(%d, 0x%0lx { IO%s%s GRP:0x%x('%c') CMD:%d LEN:%d }, 0x"
+    qemu_log("%s(%d, 0x%0lx { IO%s%s GRP:0x%x('%c') CMD:%d LEN:%d }, 0x"
             TARGET_ABI_FMT_lx ", ...)",
             name->name,
             (int)arg1,
@@ -111,9 +109,9 @@ static void print_ioctl(const struct syscallname *name,
 static void print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
 {
     if (ret == -1) {
-        gemu_log(" = -1 errno=%d (%s)\n", errno, strerror(errno));
+        qemu_log(" = -1 errno=%d (%s)\n", errno, strerror(errno));
     } else {
-        gemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
+        qemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
     }
 }
 
@@ -121,7 +119,7 @@ static void print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
 static void
 print_syscall_ret_raw(struct syscallname *name, abi_long ret)
 {
-        gemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
+        qemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
 }
 #endif
 
@@ -148,7 +146,7 @@ static void print_syscall(int num, const struct syscallname *scnames,
         TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ","
         TARGET_ABI_FMT_ld ")";
 
-    gemu_log("%d ", getpid() );
+    qemu_log("%d ", getpid());
 
     for (i = 0; i < nscnames; i++) {
         if (scnames[i].nr == num) {
@@ -161,13 +159,13 @@ static void print_syscall(int num, const struct syscallname *scnames,
                 if (scnames[i].format != NULL) {
                     format = scnames[i].format;
                 }
-                gemu_log(format, scnames[i].name, arg1, arg2, arg3, arg4, arg5,
+                qemu_log(format, scnames[i].name, arg1, arg2, arg3, arg4, arg5,
                         arg6);
             }
             return;
         }
     }
-    gemu_log("Unknown syscall %d\n", num);
+    qemu_log("Unknown syscall %d\n", num);
 }
 
 static void print_syscall_ret(int num, abi_long ret,
@@ -181,10 +179,10 @@ static void print_syscall_ret(int num, abi_long ret,
                 scnames[i].result(&scnames[i], ret);
             } else {
                 if (ret < 0) {
-                    gemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n", -ret,
+                    qemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n", -ret,
                              strerror(-ret));
                 } else {
-                    gemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
+                    qemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
                 }
             }
             break;
diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 0d45b654bb..53635d183e 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -321,12 +321,13 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
     void *p;
 
 #ifdef DEBUG
-    gemu_log("freebsd syscall %d\n", num);
+    qemu_log("freebsd syscall %d\n", num);
 #endif
     record_syscall_start(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
 
-    if(do_strace)
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+    }
 
     switch(num) {
     case TARGET_FREEBSD_NR_exit:
@@ -401,10 +402,12 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
     }
  fail:
 #ifdef DEBUG
-    gemu_log(" = %ld\n", ret);
+    qemu_log(" = %ld\n", ret);
 #endif
-    if (do_strace)
+
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_freebsd_syscall_ret(num, ret);
+    }
 
     record_syscall_return(cpu, num, ret);
     return ret;
@@ -422,13 +425,14 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
     void *p;
 
 #ifdef DEBUG
-    gemu_log("netbsd syscall %d\n", num);
+    qemu_log("netbsd syscall %d\n", num);
 #endif
 
     record_syscall_start(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
 
-    if(do_strace)
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_netbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+    }
 
     switch(num) {
     case TARGET_NETBSD_NR_exit:
@@ -480,10 +484,11 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, abi_long arg1,
     }
  fail:
 #ifdef DEBUG
-    gemu_log(" = %ld\n", ret);
+    qemu_log(" = %ld\n", ret);
 #endif
-    if (do_strace)
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_netbsd_syscall_ret(num, ret);
+    }
 
     record_syscall_return(cpu, num, ret);
     return ret;
@@ -501,13 +506,14 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
     void *p;
 
 #ifdef DEBUG
-    gemu_log("openbsd syscall %d\n", num);
+    qemu_log("openbsd syscall %d\n", num);
 #endif
 
     record_syscall_start(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
 
-    if(do_strace)
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_openbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
+    }
 
     switch(num) {
     case TARGET_OPENBSD_NR_exit:
@@ -559,10 +565,11 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, abi_long arg1,
     }
  fail:
 #ifdef DEBUG
-    gemu_log(" = %ld\n", ret);
+    qemu_log(" = %ld\n", ret);
 #endif
-    if (do_strace)
+    if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_openbsd_syscall_ret(num, ret);
+    }
 
     record_syscall_return(cpu, num, ret);
     return ret;
-- 
2.25.0.341.g760bfbb309-goog


