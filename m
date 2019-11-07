Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7993C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8067D207FA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fls26ad9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8067D207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSim0-0004zB-9A
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iSikC-0003KB-Cg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iSikA-0006nM-Hj
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:40 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iSikA-0006lN-AP
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:26:38 -0500
Received: by mail-pg1-x542.google.com with SMTP id w11so2227073pga.12
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VcKoyPsibYcE2C8KFqaYyzY+4kEltVkSUl6/VtW6chc=;
 b=fls26ad9zRE9q2luErviXVyspnViwRyNAEfNVZd93JG9E1YFT+y4d9RoxIazHbIlyF
 DrCI4LLnktyROCheHRo2xAX+vBT8I4lhFQUsePtD7i8p4jdIpuvPvVaUiE808GLzL5bV
 hSpklYzO/JSLDx5qSCLWKEUVxFsgrTIhUt+7VtuqV733UMpLDPI/bFAGyvD4NY4mu9qY
 AV762OdbIv+7V/xV6KAt0S1N+RqAFcZ385eNIzF+lIha/v348CyrzIG9oL8seI8629Q1
 JTZkYwHQAaINCnCwn6dMW86uwfaLtGRzAsYFQYlmA8+JruIdOwJVyDjBlpmJzJeKyXu3
 7BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VcKoyPsibYcE2C8KFqaYyzY+4kEltVkSUl6/VtW6chc=;
 b=g+ty8fQUhyqEKDOBO6YqMGZeLe7b4YdQcwYOpwc1qo2r/NEOaI30R0c4oS2TSp6XHN
 RBO66OjDmkVsajsdN7MLmFEeCijF2taOINXKtwjxZGQJTS459qYUFILqKsX8a1BCgnrm
 qkr/awTj0M3f3xBVnG7PyftReRL2pMk9dhn84bNKQZeNnPS0b58q8+MPZKRW9iYfB4Ft
 ycbqb07lbXAqJX+m8JEFYP8DwelxEkAQhCexWCXejBzdOw/vIIV2b8je2G5yu1i88ZEw
 OVOa25f1yTqeWARXn8Za/IFHWs5MqkMS+t/HoqJTaup00csc++CSy+sg3RM3b6mL8vMQ
 SebA==
X-Gm-Message-State: APjAAAWhGBKMKpmATt78WN4T9W/3DUttCUOiFPmvbpjDmDwLR0l1LO0V
 WsRXAjqj56PrmsqcdFXcngRtEqX5/MA=
X-Google-Smtp-Source: APXvYqzaTlkp9GL97NUPIrB0cvie+COVl0I8yAus8rVAIOm9WzRFFOFJCfKnw/OBaBVxbFJkG34gAQ==
X-Received: by 2002:a63:7b5c:: with SMTP id k28mr5037601pgn.442.1573136796566; 
 Thu, 07 Nov 2019 06:26:36 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id f8sm3375502pgd.64.2019.11.07.06.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 06:26:36 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] Add use of RCU for qemu_logfile.
Date: Thu,  7 Nov 2019 09:26:11 -0500
Message-Id: <20191107142613.2379-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107142613.2379-1-robert.foley@linaro.org>
References: <20191107142613.2379-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This now allows changing the logfile while logging is active,
and also solves the issue of a seg fault while changing the logfile.

Any read access to the qemu_logfile handle will use
the rcu_read_lock()/unlock() around the use of the handle.
To fetch the handle we will use atomic_rcu_read().
We also in many cases do a check for validity of the
logfile handle before using it to deal with the case where the
file is closed and set to NULL.

The cases where we write to the qemu_logfile will use atomic_rcu_set().
Writers will also use call_rcu() with a newly added qemu_logfile_free
function for freeing/closing when readers have finished.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/qemu/log.h | 47 ++++++++++++++++++++++++----
 util/log.c         | 78 ++++++++++++++++++++++++++++++++++------------
 include/exec/log.h | 33 +++++++++++++++++---
 tcg/tcg.c          | 12 +++++--
 4 files changed, 138 insertions(+), 32 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index a91105b2ad..975de18e23 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -3,9 +3,17 @@
 
 /* A small part of this API is split into its own header */
 #include "qemu/log-for-trace.h"
+#include "qemu/rcu.h"
+
+struct QemuLogFile {
+    struct rcu_head rcu;
+    FILE *fd;
+};
+typedef struct QemuLogFile QemuLogFile;
 
 /* Private global variable, don't use */
-extern FILE *qemu_logfile;
+extern QemuLogFile *qemu_logfile;
+
 
 /* 
  * The new API:
@@ -25,7 +33,17 @@ static inline bool qemu_log_enabled(void)
  */
 static inline bool qemu_log_separate(void)
 {
-    return qemu_logfile != NULL && qemu_logfile != stderr;
+    QemuLogFile *logfile;
+
+    if (qemu_log_enabled()) {
+        rcu_read_lock();
+        logfile = atomic_rcu_read(&qemu_logfile);
+        if (logfile && logfile->fd != stderr) {
+            return true;
+        }
+        rcu_read_unlock();
+    }
+    return false;
 }
 
 #define CPU_LOG_TB_OUT_ASM (1 << 0)
@@ -55,12 +73,23 @@ static inline bool qemu_log_separate(void)
 
 static inline void qemu_log_lock(void)
 {
-    qemu_flockfile(qemu_logfile);
+    QemuLogFile *logfile;
+    rcu_read_lock();
+    logfile = atomic_rcu_read(&qemu_logfile);
+    if (logfile) {
+        qemu_flockfile(logfile->fd);
+    }
+    rcu_read_unlock();
 }
 
 static inline void qemu_log_unlock(void)
 {
-    qemu_funlockfile(qemu_logfile);
+    QemuLogFile *logfile;
+    logfile = atomic_rcu_read(&qemu_logfile);
+    if (logfile) {
+        qemu_funlockfile(logfile->fd);
+    }
+    rcu_read_unlock();
 }
 
 /* Logging functions: */
@@ -70,9 +99,14 @@ static inline void qemu_log_unlock(void)
 static inline void GCC_FMT_ATTR(1, 0)
 qemu_log_vprintf(const char *fmt, va_list va)
 {
-    if (qemu_logfile) {
-        vfprintf(qemu_logfile, fmt, va);
+    QemuLogFile *logfile;
+
+    rcu_read_lock();
+    logfile = atomic_rcu_read(&qemu_logfile);
+    if (logfile) {
+        vfprintf(logfile->fd, fmt, va);
     }
+    rcu_read_unlock();
 }
 
 /* log only if a bit is set on the current loglevel mask:
@@ -129,5 +163,6 @@ void qemu_print_log_usage(FILE *f);
 void qemu_log_flush(void);
 /* Close the log file */
 void qemu_log_close(void);
+void qemu_logfile_free(QemuLogFile *logfile);
 
 #endif
diff --git a/util/log.c b/util/log.c
index dff2f98c8c..d409532b8f 100644
--- a/util/log.c
+++ b/util/log.c
@@ -29,7 +29,7 @@
 static char *logfilename;
 static bool qemu_logfile_initialized;
 static QemuMutex qemu_logfile_mutex;
-FILE *qemu_logfile;
+QemuLogFile *qemu_logfile;
 int qemu_loglevel;
 static int log_append = 0;
 static GArray *debug_regions;
@@ -38,10 +38,14 @@ static GArray *debug_regions;
 int qemu_log(const char *fmt, ...)
 {
     int ret = 0;
-    if (qemu_logfile) {
+    QemuLogFile *logfile;
+
+    rcu_read_lock();
+    logfile = atomic_rcu_read(&qemu_logfile);
+    if (logfile) {
         va_list ap;
         va_start(ap, fmt);
-        ret = vfprintf(qemu_logfile, fmt, ap);
+        ret = vfprintf(logfile->fd, fmt, ap);
         va_end(ap);
 
         /* Don't pass back error results.  */
@@ -49,6 +53,7 @@ int qemu_log(const char *fmt, ...)
             ret = 0;
         }
     }
+    rcu_read_unlock();
     return ret;
 }
 
@@ -65,6 +70,8 @@ static bool log_uses_own_buffers;
 /* enable or disable low levels log */
 void qemu_set_log(int log_flags)
 {
+    QemuLogFile *logfile;
+
     qemu_loglevel = log_flags;
 #ifdef CONFIG_TRACE_LOG
     qemu_loglevel |= LOG_TRACE;
@@ -77,43 +84,51 @@ void qemu_set_log(int log_flags)
     qemu_mutex_lock(&qemu_logfile_mutex);
     if (!qemu_logfile &&
         (is_daemonized() ? logfilename != NULL : qemu_loglevel)) {
+        logfile = g_new0(QemuLogFile, 1);
         if (logfilename) {
-            qemu_logfile = fopen(logfilename, log_append ? "a" : "w");
-            if (!qemu_logfile) {
+            logfile->fd = fopen(logfilename, log_append ? "a" : "w");
+            if (!logfile->fd) {
+                g_free(logfile);
                 perror(logfilename);
                 _exit(1);
             }
             /* In case we are a daemon redirect stderr to logfile */
             if (is_daemonized()) {
-                dup2(fileno(qemu_logfile), STDERR_FILENO);
-                fclose(qemu_logfile);
+                dup2(fileno(logfile->fd), STDERR_FILENO);
+                fclose(logfile->fd);
                 /* This will skip closing logfile in qemu_log_close() */
-                qemu_logfile = stderr;
+                logfile->fd = stderr;
             }
         } else {
             /* Default to stderr if no log file specified */
             assert(!is_daemonized());
-            qemu_logfile = stderr;
+            logfile->fd = stderr;
         }
         /* must avoid mmap() usage of glibc by setting a buffer "by hand" */
         if (log_uses_own_buffers) {
             static char logfile_buf[4096];
 
-            setvbuf(qemu_logfile, logfile_buf, _IOLBF, sizeof(logfile_buf));
+            setvbuf(logfile->fd, logfile_buf, _IOLBF, sizeof(logfile_buf));
         } else {
 #if defined(_WIN32)
             /* Win32 doesn't support line-buffering, so use unbuffered output. */
-            setvbuf(qemu_logfile, NULL, _IONBF, 0);
+            setvbuf(logfile->fd, NULL, _IONBF, 0);
 #else
-            setvbuf(qemu_logfile, NULL, _IOLBF, 0);
+            setvbuf(logfile->fd, NULL, _IOLBF, 0);
 #endif
             log_append = 1;
         }
+        atomic_rcu_set(&qemu_logfile, logfile);
     }
-    qemu_mutex_unlock(&qemu_logfile_mutex);
+    logfile = qemu_logfile;
+
     if (qemu_logfile &&
         (is_daemonized() ? logfilename == NULL : !qemu_loglevel)) {
-        qemu_log_close();
+        atomic_rcu_set(&qemu_logfile, NULL);
+        qemu_mutex_unlock(&qemu_logfile_mutex);
+        call_rcu(logfile, qemu_logfile_free, rcu);
+    } else {
+        qemu_mutex_unlock(&qemu_logfile_mutex);
     }
 }
 
@@ -247,17 +262,40 @@ out:
 /* fflush() the log file */
 void qemu_log_flush(void)
 {
-    fflush(qemu_logfile);
+    QemuLogFile *logfile;
+
+    rcu_read_lock();
+    logfile = atomic_rcu_read(&qemu_logfile);
+    if (logfile) {
+        fflush(logfile->fd);
+    }
+    rcu_read_unlock();
+}
+
+void qemu_logfile_free(QemuLogFile *logfile)
+{
+    if (logfile) {
+        if (logfile->fd != stderr) {
+            fclose(logfile->fd);
+        }
+        g_free(logfile);
+    }
 }
 
 /* Close the log file */
 void qemu_log_close(void)
 {
-    if (qemu_logfile) {
-        if (qemu_logfile != stderr) {
-            fclose(qemu_logfile);
-        }
-        qemu_logfile = NULL;
+    QemuLogFile *logfile;
+
+    qemu_mutex_lock(&qemu_logfile_mutex);
+    logfile = qemu_logfile;
+
+    if (logfile) {
+        atomic_rcu_set(&qemu_logfile, NULL);
+        qemu_mutex_unlock(&qemu_logfile_mutex);
+        call_rcu(logfile, qemu_logfile_free, rcu);
+    } else {
+        qemu_mutex_unlock(&qemu_logfile_mutex);
     }
 }

diff --git a/include/exec/log.h b/include/exec/log.h
index e2cfd436e6..9bd1e4aa20 100644
--- a/include/exec/log.h
+++ b/include/exec/log.h
@@ -15,8 +15,15 @@
  */
 static inline void log_cpu_state(CPUState *cpu, int flags)
 {
+    QemuLogFile *logfile;
+
     if (qemu_log_enabled()) {
-        cpu_dump_state(cpu, qemu_logfile, flags);
+        rcu_read_lock();
+        logfile = atomic_rcu_read(&qemu_logfile);
+        if (logfile) {
+            cpu_dump_state(cpu, logfile->fd, flags);
+        }
+        rcu_read_unlock();
     }
 }
 
@@ -40,19 +47,37 @@ static inline void log_cpu_state_mask(int mask, CPUState *cpu, int flags)
 static inline void log_target_disas(CPUState *cpu, target_ulong start,
                                     target_ulong len)
 {
-    target_disas(qemu_logfile, cpu, start, len);
+    QemuLogFile *logfile;
+    rcu_read_lock();
+    logfile = atomic_rcu_read(&qemu_logfile);
+    if (logfile) {
+        target_disas(logfile->fd, cpu, start, len);
+    }
+    rcu_read_unlock();
 }
 
 static inline void log_disas(void *code, unsigned long size)
 {
-    disas(qemu_logfile, code, size);
+    QemuLogFile *logfile;
+    rcu_read_lock();
+    logfile = atomic_rcu_read(&qemu_logfile);
+    if (logfile) {
+        disas(logfile->fd, code, size);
+    }
+    rcu_read_unlock();
 }
 
 #if defined(CONFIG_USER_ONLY)
 /* page_dump() output to the log file: */
 static inline void log_page_dump(void)
 {
-    page_dump(qemu_logfile);
+    QemuLogFile *logfile;
+    rcu_read_lock();
+    logfile = atomic_rcu_read(&qemu_logfile);
+    if (logfile) {
+        page_dump(logfile->fd);
+    }
+    rcu_read_unlock();
 }
 #endif
 #endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5475d49ed1..220eaac7c7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2114,9 +2114,17 @@ static void tcg_dump_ops(TCGContext *s, bool have_prefs)
         }
 
         if (have_prefs || op->life) {
-            for (; col < 40; ++col) {
-                putc(' ', qemu_logfile);
+
+            QemuLogFile *logfile;
+
+            rcu_read_lock();
+            logfile = atomic_rcu_read(&qemu_logfile);
+            if (logfile) {
+                for (; col < 40; ++col) {
+                    putc(' ', logfile->fd);
+                }
             }
+            rcu_read_unlock();
         }
 
         if (op->life) {

-- 
2.17.1


