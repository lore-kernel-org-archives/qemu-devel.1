Received: from eggs.gnu.org ([2001:4830:134:3::10]:33225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4Q-0001kf-2x
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4H-0006Q6-0j
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:46 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:33121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA48-0005zD-AQ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:38 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i134-v6so10056936wmf.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:54 +0200
Message-Id: <1534870966-9287-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/74] qsp: track BQL callers explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

The BQL is acquired via qemu_mutex_lock_iothread(), which makes
the profiler assign the associated wait time (i.e. most of
BQL wait time) entirely to that function. This loses the original
call site information, which does not help diagnose BQL contention.
Fix it by tracking the callers explicitly.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c                   | 10 ++++++++--
 include/qemu/main-loop.h |  4 +++-
 include/qemu/thread.h    |  1 +
 stubs/iothread-lock.c    |  2 +-
 util/qsp.c               |  6 ++++++
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index b5844b7..a5ea3ee 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1762,10 +1762,16 @@ bool qemu_mutex_iothread_locked(void)
     return iothread_locked;
 }
 
-void qemu_mutex_lock_iothread(void)
+/*
+ * The BQL is taken from so many places that it is worth profiling the
+ * callers directly, instead of funneling them all through a single function.
+ */
+void qemu_mutex_lock_iothread_impl(const char *file, int line)
 {
+    QemuMutexLockFunc bql_lock = atomic_read(&qemu_bql_mutex_lock_func);
+
     g_assert(!qemu_mutex_iothread_locked());
-    qemu_mutex_lock(&qemu_global_mutex);
+    bql_lock(&qemu_global_mutex, file, line);
     iothread_locked = true;
 }
 
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 721aa24..e59f9ae 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -276,7 +276,9 @@ bool qemu_mutex_iothread_locked(void);
  * NOTE: tools currently are single-threaded and qemu_mutex_lock_iothread
  * is a no-op there.
  */
-void qemu_mutex_lock_iothread(void);
+#define qemu_mutex_lock_iothread()                      \
+    qemu_mutex_lock_iothread_impl(__FILE__, __LINE__)
+void qemu_mutex_lock_iothread_impl(const char *file, int line);
 
 /**
  * qemu_mutex_unlock_iothread: Unlock the main loop mutex.
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index c90ea47..dacebcf 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -35,6 +35,7 @@ typedef int (*QemuRecMutexTrylockFunc)(QemuRecMutex *m, const char *f, int l);
 typedef void (*QemuCondWaitFunc)(QemuCond *c, QemuMutex *m, const char *f,
                                  int l);
 
+extern QemuMutexLockFunc qemu_bql_mutex_lock_func;
 extern QemuMutexLockFunc qemu_mutex_lock_func;
 extern QemuMutexTrylockFunc qemu_mutex_trylock_func;
 extern QemuRecMutexLockFunc qemu_rec_mutex_lock_func;
diff --git a/stubs/iothread-lock.c b/stubs/iothread-lock.c
index 9b6db2e..eb745d7 100644
--- a/stubs/iothread-lock.c
+++ b/stubs/iothread-lock.c
@@ -7,7 +7,7 @@ bool qemu_mutex_iothread_locked(void)
     return true;
 }
 
-void qemu_mutex_lock_iothread(void)
+void qemu_mutex_lock_iothread_impl(const char *file, int line)
 {
 }
 
diff --git a/util/qsp.c b/util/qsp.c
index 4dc851e..b0c2575 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -65,6 +65,7 @@
 
 enum QSPType {
     QSP_MUTEX,
+    QSP_BQL_MUTEX,
     QSP_REC_MUTEX,
     QSP_CONDVAR,
 };
@@ -123,10 +124,12 @@ static bool qsp_initialized, qsp_initializing;
 
 static const char * const qsp_typenames[] = {
     [QSP_MUTEX]     = "mutex",
+    [QSP_BQL_MUTEX] = "BQL mutex",
     [QSP_REC_MUTEX] = "rec_mutex",
     [QSP_CONDVAR]   = "condvar",
 };
 
+QemuMutexLockFunc qemu_bql_mutex_lock_func = qemu_mutex_lock_impl;
 QemuMutexLockFunc qemu_mutex_lock_func = qemu_mutex_lock_impl;
 QemuMutexTrylockFunc qemu_mutex_trylock_func = qemu_mutex_trylock_impl;
 QemuRecMutexLockFunc qemu_rec_mutex_lock_func = qemu_rec_mutex_lock_impl;
@@ -419,6 +422,7 @@ static inline void qsp_entry_record(QSPEntry *e, int64_t delta)
         return err;                                                     \
     }
 
+QSP_GEN_VOID(QemuMutex, QSP_BQL_MUTEX, qsp_bql_mutex_lock, qemu_mutex_lock_impl)
 QSP_GEN_VOID(QemuMutex, QSP_MUTEX, qsp_mutex_lock, qemu_mutex_lock_impl)
 QSP_GEN_RET1(QemuMutex, QSP_MUTEX, qsp_mutex_trylock, qemu_mutex_trylock_impl)
 
@@ -453,6 +457,7 @@ void qsp_enable(void)
 {
     atomic_set(&qemu_mutex_lock_func, qsp_mutex_lock);
     atomic_set(&qemu_mutex_trylock_func, qsp_mutex_trylock);
+    atomic_set(&qemu_bql_mutex_lock_func, qsp_bql_mutex_lock);
     atomic_set(&qemu_rec_mutex_lock_func, qsp_rec_mutex_lock);
     atomic_set(&qemu_rec_mutex_trylock_func, qsp_rec_mutex_trylock);
     atomic_set(&qemu_cond_wait_func, qsp_cond_wait);
@@ -462,6 +467,7 @@ void qsp_disable(void)
 {
     atomic_set(&qemu_mutex_lock_func, qemu_mutex_lock_impl);
     atomic_set(&qemu_mutex_trylock_func, qemu_mutex_trylock_impl);
+    atomic_set(&qemu_bql_mutex_lock_func, qemu_mutex_lock_impl);
     atomic_set(&qemu_rec_mutex_lock_func, qemu_rec_mutex_lock_impl);
     atomic_set(&qemu_rec_mutex_trylock_func, qemu_rec_mutex_trylock_impl);
     atomic_set(&qemu_cond_wait_func, qemu_cond_wait_impl);
-- 
1.8.3.1
