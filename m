Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773F3C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43120206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVRi1n1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43120206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9smS-0000fd-Qt
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCz-0006YF-Mn
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCx-0007Uv-D2
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sCw-0007UP-Tl
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id i1so38605971wro.4
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/9mBH+AAUSSLGhvpwHNCY+2vRoaPSjC+sHXPNN0R2GE=;
 b=vVRi1n1Fo7h1bTbe9nLJNBdtxVfAITHMCIjx+iHSNzlhZ5RL10SD/Acjv6yzQP1NOX
 BGuEX9Q0/pphMhxpYgU/7BuqttF0FsUDahOPsTrRxfwxMfTIWLj7/D5NF4/GKo217WxG
 ej3CCOYHw5LrhcdpmtcBkJgXWiUii1xWJ4TjfIpCsgj1vJtzKzUw9n73sSePPcG08KRh
 Y+PPGDKJbhlXJobyJWgk3tKd3LY68Ap1dHoW4GGfOuAMHlw8/OWCf8MhteIizAKRuKuZ
 3YJp9+7Q5TFqa5ecybbyW2CwFWYj4sBbuH+SVLmtAhV/K059rNR1k6FaxDwLG5+Ifzsv
 JZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=/9mBH+AAUSSLGhvpwHNCY+2vRoaPSjC+sHXPNN0R2GE=;
 b=nZmn6C47QFHG4/OkowReVCD47N6jcNWDavWjvyEhBjKiKbPclLFUyCzR1gqvBlz5Qg
 2T0YhoRqitcqwTSqGHZkuAr5kMHIuL1wng1T9PvKP3BF13m0v1Yqrnuz+L/BAHyJxiGN
 W2dpEXFi75oAhec2O4hXKKmHN32lVW8RLKbL4q58+4oWRlmVHXeXhmJS999/h2ujEBbK
 oOPC2D0RcVwLiZcMTjB6OSzqNOa+AycgWhsdkusPl/V+GJK+A2Wiw9CLqSL6dZ/l8c3x
 bTPyjRbXMGnltNc9qupHev84GlPumdOYG2ofVvTu1vOLxf0OsnH6mdcU3a4hos9bH9F5
 j84A==
X-Gm-Message-State: APjAAAU5yKEL6PhFhINsdbFpDxnhvQ9QglToQSRswXOMbAhL7Yaly1xp
 h6GkOWBd4jSMqQibFy0Bl4VX04or
X-Google-Smtp-Source: APXvYqzeBhoCUGIKG4O/kVauOIf5Z2URiXuE8eYG/fvDasKAZtTcJB6+icvc86JO5p3EIpFstsFEJA==
X-Received: by 2002:adf:b3c1:: with SMTP id x1mr109032wrd.33.1568644945435;
 Mon, 16 Sep 2019 07:42:25 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:53 +0200
Message-Id: <1568644929-9124-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 13/29] qemu-thread: Add qemu_cond_timedwait
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yury Kotov <yury-kotov@yandex-team.ru>

The new function is needed to implement conditional sleep for CPU
throttling. It's possible to reuse qemu_sem_timedwait, but it's more
difficult than just add qemu_cond_timedwait.

Also moved compute_abs_deadline function up the code to reuse it in
qemu_cond_timedwait_impl win32.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Message-Id: <20190909131335.16848-2-yury-kotov@yandex-team.ru>
---
 include/qemu/thread.h    | 19 +++++++++++++++++++
 util/qemu-thread-posix.c | 41 +++++++++++++++++++++++++++++------------
 util/qemu-thread-win32.c | 17 +++++++++++++++++
 util/qsp.c               | 20 ++++++++++++++++++++
 4 files changed, 85 insertions(+), 12 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 55d83a9..047db03 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -34,6 +34,8 @@ typedef void (*QemuRecMutexLockFunc)(QemuRecMutex *m, const char *f, int l);
 typedef int (*QemuRecMutexTrylockFunc)(QemuRecMutex *m, const char *f, int l);
 typedef void (*QemuCondWaitFunc)(QemuCond *c, QemuMutex *m, const char *f,
                                  int l);
+typedef bool (*QemuCondTimedWaitFunc)(QemuCond *c, QemuMutex *m, int ms,
+                                      const char *f, int l);
 
 extern QemuMutexLockFunc qemu_bql_mutex_lock_func;
 extern QemuMutexLockFunc qemu_mutex_lock_func;
@@ -41,6 +43,7 @@ extern QemuMutexTrylockFunc qemu_mutex_trylock_func;
 extern QemuRecMutexLockFunc qemu_rec_mutex_lock_func;
 extern QemuRecMutexTrylockFunc qemu_rec_mutex_trylock_func;
 extern QemuCondWaitFunc qemu_cond_wait_func;
+extern QemuCondTimedWaitFunc qemu_cond_timedwait_func;
 
 /* convenience macros to bypass the profiler */
 #define qemu_mutex_lock__raw(m)                         \
@@ -63,6 +66,8 @@ extern QemuCondWaitFunc qemu_cond_wait_func;
             qemu_rec_mutex_trylock_impl(m, __FILE__, __LINE__);
 #define qemu_cond_wait(c, m)                                            \
             qemu_cond_wait_impl(c, m, __FILE__, __LINE__);
+#define qemu_cond_timedwait(c, m, ms)                                   \
+            qemu_cond_wait_impl(c, m, ms, __FILE__, __LINE__);
 #else
 #define qemu_mutex_lock(m) ({                                           \
             QemuMutexLockFunc _f = atomic_read(&qemu_mutex_lock_func);  \
@@ -89,6 +94,11 @@ extern QemuCondWaitFunc qemu_cond_wait_func;
             QemuCondWaitFunc _f = atomic_read(&qemu_cond_wait_func);    \
             _f(c, m, __FILE__, __LINE__);                               \
         })
+
+#define qemu_cond_timedwait(c, m, ms) ({                                       \
+            QemuCondTimedWaitFunc _f = atomic_read(&qemu_cond_timedwait_func); \
+            _f(c, m, ms, __FILE__, __LINE__);                                  \
+        })
 #endif
 
 #define qemu_mutex_unlock(mutex) \
@@ -134,12 +144,21 @@ void qemu_cond_signal(QemuCond *cond);
 void qemu_cond_broadcast(QemuCond *cond);
 void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex,
                          const char *file, const int line);
+bool qemu_cond_timedwait_impl(QemuCond *cond, QemuMutex *mutex, int ms,
+                              const char *file, const int line);
 
 static inline void (qemu_cond_wait)(QemuCond *cond, QemuMutex *mutex)
 {
     qemu_cond_wait(cond, mutex);
 }
 
+/* Returns true if timeout has not expired, and false otherwise */
+static inline bool (qemu_cond_timedwait)(QemuCond *cond, QemuMutex *mutex,
+                                         int ms)
+{
+    return qemu_cond_timedwait(cond, mutex, ms);
+}
+
 void qemu_sem_init(QemuSemaphore *sem, int init);
 void qemu_sem_post(QemuSemaphore *sem);
 void qemu_sem_wait(QemuSemaphore *sem);
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 1bf5e65..838980a 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -36,6 +36,18 @@ static void error_exit(int err, const char *msg)
     abort();
 }
 
+static void compute_abs_deadline(struct timespec *ts, int ms)
+{
+    struct timeval tv;
+    gettimeofday(&tv, NULL);
+    ts->tv_nsec = tv.tv_usec * 1000 + (ms % 1000) * 1000000;
+    ts->tv_sec = tv.tv_sec + ms / 1000;
+    if (ts->tv_nsec >= 1000000000) {
+        ts->tv_sec++;
+        ts->tv_nsec -= 1000000000;
+    }
+}
+
 void qemu_mutex_init(QemuMutex *mutex)
 {
     int err;
@@ -164,6 +176,23 @@ void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const char *file, con
         error_exit(err, __func__);
 }
 
+bool qemu_cond_timedwait_impl(QemuCond *cond, QemuMutex *mutex, int ms,
+                              const char *file, const int line)
+{
+    int err;
+    struct timespec ts;
+
+    assert(cond->initialized);
+    trace_qemu_mutex_unlock(mutex, file, line);
+    compute_abs_deadline(&ts, ms);
+    err = pthread_cond_timedwait(&cond->cond, &mutex->lock, &ts);
+    trace_qemu_mutex_locked(mutex, file, line);
+    if (err && err != ETIMEDOUT) {
+        error_exit(err, __func__);
+    }
+    return err != ETIMEDOUT;
+}
+
 void qemu_sem_init(QemuSemaphore *sem, int init)
 {
     int rc;
@@ -238,18 +267,6 @@ void qemu_sem_post(QemuSemaphore *sem)
 #endif
 }
 
-static void compute_abs_deadline(struct timespec *ts, int ms)
-{
-    struct timeval tv;
-    gettimeofday(&tv, NULL);
-    ts->tv_nsec = tv.tv_usec * 1000 + (ms % 1000) * 1000000;
-    ts->tv_sec = tv.tv_sec + ms / 1000;
-    if (ts->tv_nsec >= 1000000000) {
-        ts->tv_sec++;
-        ts->tv_nsec -= 1000000000;
-    }
-}
-
 int qemu_sem_timedwait(QemuSemaphore *sem, int ms)
 {
     int rc;
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 572f885..56a8333 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -145,6 +145,23 @@ void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const char *file, con
     qemu_mutex_post_lock(mutex, file, line);
 }
 
+bool qemu_cond_timedwait_impl(QemuCond *cond, QemuMutex *mutex, int ms,
+                              const char *file, const int line)
+{
+    int rc = 0;
+
+    assert(cond->initialized);
+    trace_qemu_mutex_unlock(mutex, file, line);
+    if (!SleepConditionVariableSRW(&cond->var, &mutex->lock, ms, 0)) {
+        rc = GetLastError();
+    }
+    trace_qemu_mutex_locked(mutex, file, line);
+    if (rc && rc != ERROR_TIMEOUT) {
+        error_exit(rc, __func__);
+    }
+    return rc != ERROR_TIMEOUT;
+}
+
 void qemu_sem_init(QemuSemaphore *sem, int init)
 {
     /* Manual reset.  */
diff --git a/util/qsp.c b/util/qsp.c
index 5264c97..6226541 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -131,6 +131,7 @@ QemuRecMutexLockFunc qemu_rec_mutex_lock_func = qemu_rec_mutex_lock_impl;
 QemuRecMutexTrylockFunc qemu_rec_mutex_trylock_func =
     qemu_rec_mutex_trylock_impl;
 QemuCondWaitFunc qemu_cond_wait_func = qemu_cond_wait_impl;
+QemuCondTimedWaitFunc qemu_cond_timedwait_func = qemu_cond_timedwait_impl;
 
 /*
  * It pays off to _not_ hash callsite->file; hashing a string is slow, and
@@ -412,6 +413,23 @@ qsp_cond_wait(QemuCond *cond, QemuMutex *mutex, const char *file, int line)
     qsp_entry_record(e, t1 - t0);
 }
 
+static bool
+qsp_cond_timedwait(QemuCond *cond, QemuMutex *mutex, int ms,
+                   const char *file, int line)
+{
+    QSPEntry *e;
+    int64_t t0, t1;
+    bool ret;
+
+    t0 = get_clock();
+    ret = qemu_cond_timedwait_impl(cond, mutex, ms, file, line);
+    t1 = get_clock();
+
+    e = qsp_entry_get(cond, file, line, QSP_CONDVAR);
+    qsp_entry_record(e, t1 - t0);
+    return ret;
+}
+
 bool qsp_is_enabled(void)
 {
     return atomic_read(&qemu_mutex_lock_func) == qsp_mutex_lock;
@@ -425,6 +443,7 @@ void qsp_enable(void)
     atomic_set(&qemu_rec_mutex_lock_func, qsp_rec_mutex_lock);
     atomic_set(&qemu_rec_mutex_trylock_func, qsp_rec_mutex_trylock);
     atomic_set(&qemu_cond_wait_func, qsp_cond_wait);
+    atomic_set(&qemu_cond_timedwait_func, qsp_cond_timedwait);
 }
 
 void qsp_disable(void)
@@ -435,6 +454,7 @@ void qsp_disable(void)
     atomic_set(&qemu_rec_mutex_lock_func, qemu_rec_mutex_lock_impl);
     atomic_set(&qemu_rec_mutex_trylock_func, qemu_rec_mutex_trylock_impl);
     atomic_set(&qemu_cond_wait_func, qemu_cond_wait_impl);
+    atomic_set(&qemu_cond_timedwait_func, qemu_cond_timedwait_impl);
 }
 
 static gint qsp_tree_cmp(gconstpointer ap, gconstpointer bp, gpointer up)
-- 
1.8.3.1



