Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3EDC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF4B24650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0oEgvRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF4B24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtdC-0003i4-U0
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNX-00070T-GF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNV-0001BP-Kq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:59 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNV-00015q-9o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:57 -0500
Received: by mail-wm1-x342.google.com with SMTP id f4so6733804wmj.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U1KU4Z1KzUFCaz+vloc4RAfkLAiGkUKbiKWVD5DUYbQ=;
 b=W0oEgvRqbu34lh3gKeR6jZzBU2a2OL4MEQPJEYdD4BgECYYJQrqGyPIw2QkkgEypJ5
 +GcYAwl28oTj26LSWMuWvjhuPVvZ12E0lZgzSe37VQOGyz1s4c+4XergueKZVlZvvIsp
 lYEt1NwspISAfhxRjq+pAR80SF0oYmmhrXN+XzRklAYC4fqlCj6LDECZzpCQxYv32ZNZ
 UTviwKCTm4fMkkBcRnSKfjYVIdrbMDEJJxp14AUuIhtWYvAFQCrDTGFf1rPv55JrFEr3
 XBMvs5aiNtmbbF/pAWWMs7qJc3X1Z9OHyaTUzJeQPeCivfpI8mbxnG2lWnQglD6YRN7x
 JO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U1KU4Z1KzUFCaz+vloc4RAfkLAiGkUKbiKWVD5DUYbQ=;
 b=Vk6AP9GsefoVdFjra3ZSM5Nz0TretwaioYOWXC9+VmncXfvVWSu1vKI9x3tCAeSupj
 3embhhnALAENUemO8s3EdlZYbkaLWpx3GYs+Ifr6tMvcNKgQy2foXYwGuCKU3gQNmajD
 gqRD2G02yKcavxF4UhsJ1w8RD1DnGUdZj/shuHb7pDcn42pIvoNc0AyVNiqhl2OBdquN
 59X9Ap0tZmygFIvZraGFDFzlgFxacU49XAV1jR0y4RQpHrxudPDnNdaqflGS9KiR5mol
 3iHoGUO+bpijti68RpREFhWaZL6JqQd1hHpCdYrbHYRP0F4NfSXQeH0JNumSE7SKis8A
 QMdQ==
X-Gm-Message-State: APjAAAVsSZHbfJEaPckHeXvR0mnqQLWt6q7Ex9rCpRYrNQ0Y2MKkUU9S
 92+dzp7ow+CcVm/sqVgiB92UBQ==
X-Google-Smtp-Source: APXvYqwqZVzItVau5DaoiMjVucmjZths37O96nyUrF14HJcTEmLrWZUmSgBYiBTSr+MgwqjaQBoVNA==
X-Received: by 2002:a1c:62c1:: with SMTP id w184mr9535862wmb.150.1576752596010; 
 Thu, 19 Dec 2019 02:49:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z6sm6093821wrw.36.2019.12.19.02.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:51 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E67E31FF9F;
 Thu, 19 Dec 2019 10:49:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 15/25] Add use of RCU for qemu_logfile.
Date: Thu, 19 Dec 2019 10:49:24 +0000
Message-Id: <20191219104934.866-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191118211528.3221-6-robert.foley@linaro.org>

diff --git a/include/exec/log.h b/include/exec/log.h
index e2cfd436e61..9bd1e4aa20b 100644
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
diff --git a/include/qemu/log.h b/include/qemu/log.h
index a7c5b01571f..e0f4e406283 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -3,9 +3,16 @@
 
 /* A small part of this API is split into its own header */
 #include "qemu/log-for-trace.h"
+#include "qemu/rcu.h"
+
+typedef struct QemuLogFile {
+    struct rcu_head rcu;
+    FILE *fd;
+} QemuLogFile;
 
 /* Private global variable, don't use */
-extern FILE *qemu_logfile;
+extern QemuLogFile *qemu_logfile;
+
 
 /* 
  * The new API:
@@ -25,7 +32,16 @@ static inline bool qemu_log_enabled(void)
  */
 static inline bool qemu_log_separate(void)
 {
-    return qemu_logfile != NULL && qemu_logfile != stderr;
+    QemuLogFile *logfile;
+    bool res = false;
+
+    rcu_read_lock();
+    logfile = atomic_rcu_read(&qemu_logfile);
+    if (logfile && logfile->fd != stderr) {
+        res = true;
+    }
+    rcu_read_unlock();
+    return res;
 }
 
 #define CPU_LOG_TB_OUT_ASM (1 << 0)
@@ -55,8 +71,15 @@ static inline bool qemu_log_separate(void)
 
 static inline FILE *qemu_log_lock(void)
 {
-    qemu_flockfile(qemu_logfile);
-    return logfile->fd;
+    QemuLogFile *logfile;
+    rcu_read_lock();
+    logfile = atomic_rcu_read(&qemu_logfile);
+    if (logfile) {
+        qemu_flockfile(logfile->fd);
+        return logfile->fd;
+    } else {
+        return NULL;
+    }
 }
 
 static inline void qemu_log_unlock(FILE *fd)
@@ -64,6 +87,7 @@ static inline void qemu_log_unlock(FILE *fd)
     if (fd) {
         qemu_funlockfile(fd);
     }
+    rcu_read_unlock();
 }
 
 /* Logging functions: */
@@ -73,9 +97,14 @@ static inline void qemu_log_unlock(FILE *fd)
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
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0511266d85d..4f616ba38bf 100644
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
diff --git a/util/log.c b/util/log.c
index 953a66b5a8d..867264da8d0 100644
--- a/util/log.c
+++ b/util/log.c
@@ -28,7 +28,7 @@
 
 static char *logfilename;
 static QemuMutex qemu_logfile_mutex;
-FILE *qemu_logfile;
+QemuLogFile *qemu_logfile;
 int qemu_loglevel;
 static int log_append = 0;
 static GArray *debug_regions;
@@ -37,10 +37,14 @@ static GArray *debug_regions;
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
@@ -48,6 +52,7 @@ int qemu_log(const char *fmt, ...)
             ret = 0;
         }
     }
+    rcu_read_unlock();
     return ret;
 }
 
@@ -56,12 +61,24 @@ static void __attribute__((__constructor__)) qemu_logfile_init(void)
     qemu_mutex_init(&qemu_logfile_mutex);
 }
 
+static void qemu_logfile_free(QemuLogFile *logfile)
+{
+    g_assert(logfile);
+
+    if (logfile->fd != stderr) {
+        fclose(logfile->fd);
+    }
+    g_free(logfile);
+}
+
 static bool log_uses_own_buffers;
 
 /* enable or disable low levels log */
 void qemu_set_log(int log_flags)
 {
     bool need_to_open_file = false;
+    QemuLogFile *logfile;
+
     qemu_loglevel = log_flags;
 #ifdef CONFIG_TRACE_LOG
     qemu_loglevel |= LOG_TRACE;
@@ -79,43 +96,47 @@ void qemu_set_log(int log_flags)
     }
     qemu_mutex_lock(&qemu_logfile_mutex);
     if (qemu_logfile && !need_to_open_file) {
-        qemu_mutex_unlock(&qemu_logfile_mutex);
-        qemu_log_close();
+        logfile = qemu_logfile;
+        atomic_rcu_set(&qemu_logfile, NULL);
+        call_rcu(logfile, qemu_logfile_free, rcu);
     } else if (!qemu_logfile && need_to_open_file) {
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
-        qemu_mutex_unlock(&qemu_logfile_mutex);
+        atomic_rcu_set(&qemu_logfile, logfile);
     }
+    qemu_mutex_unlock(&qemu_logfile_mutex);
 }
 
 void qemu_log_needs_buffers(void)
@@ -244,18 +265,27 @@ out:
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
 }
 
 /* Close the log file */
 void qemu_log_close(void)
 {
+    QemuLogFile *logfile;
+
     qemu_mutex_lock(&qemu_logfile_mutex);
-    if (qemu_logfile) {
-        if (qemu_logfile != stderr) {
-            fclose(qemu_logfile);
-        }
-        qemu_logfile = NULL;
+    logfile = qemu_logfile;
+
+    if (logfile) {
+        atomic_rcu_set(&qemu_logfile, NULL);
+        call_rcu(logfile, qemu_logfile_free, rcu);
     }
     qemu_mutex_unlock(&qemu_logfile_mutex);
 }
-- 
2.20.1


