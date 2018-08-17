Received: from eggs.gnu.org ([2001:4830:134:3::10]:36282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA8-0000dB-On
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA5-0005Z1-FM
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59001)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqXA3-0005Vo-Dt
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:18:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 17 Aug 2018 01:18:49 -0400
Message-Id: <20180817051853.23792-6-cota@braap.org>
In-Reply-To: <20180817051853.23792-1-cota@braap.org>
References: <20180817051853.23792-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 5/9] qsp: track BQL callers explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Fam Zheng <famz@redhat.com>

The BQL is acquired via qemu_mutex_lock_iothread(), which makes
the profiler assign the associated wait time (i.e. most of
BQL wait time) entirely to that function. This loses the original
call site information, which does not help diagnose BQL contention.
Fix it by tracking the callers explicitly.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/main-loop.h |  4 +++-
 include/qemu/thread.h    |  1 +
 cpus.c                   | 10 ++++++++--
 stubs/iothread-lock.c    |  2 +-
 util/qsp.c               |  6 ++++++
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 721aa2416a..e59f9ae1e9 100644
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
index ab508df3cd..b41c0ae16a 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -35,6 +35,7 @@ typedef int (*QemuRecMutexTrylockFunc)(QemuRecMutex *m, const char *f, int l);
 typedef void (*QemuCondWaitFunc)(QemuCond *c, QemuMutex *m, const char *f,
                                  int l);
 
+extern QemuMutexLockFunc qemu_bql_mutex_lock_func;
 extern QemuMutexLockFunc qemu_mutex_lock_func;
 extern QemuMutexTrylockFunc qemu_mutex_trylock_func;
 extern QemuRecMutexLockFunc qemu_rec_mutex_lock_func;
diff --git a/cpus.c b/cpus.c
index b5844b7103..a5ea3eef80 100644
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
 
diff --git a/stubs/iothread-lock.c b/stubs/iothread-lock.c
index 9b6db2e740..eb745d7d6a 100644
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
index ea128d3748..65d9d8f0d6 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -65,6 +65,7 @@
 
 enum QSPType {
     QSP_MUTEX,
+    QSP_BQL_MUTEX,
     QSP_REC_MUTEX,
     QSP_CONDVAR,
 };
@@ -116,10 +117,12 @@ static bool qsp_initialized, qsp_initializing;
 
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
@@ -368,6 +371,7 @@ static QSPEntry *qsp_entry_get(const void *obj, const char *file, int line,
         return err;                                                     \
     }
 
+QSP_GEN_VOID(QemuMutex, QSP_BQL_MUTEX, qsp_bql_mutex_lock, qemu_mutex_lock_impl)
 QSP_GEN_VOID(QemuMutex, QSP_MUTEX, qsp_mutex_lock, qemu_mutex_lock_impl)
 QSP_GEN_RET1(QemuMutex, QSP_MUTEX, qsp_mutex_trylock, qemu_mutex_trylock_impl)
 
@@ -403,6 +407,7 @@ void qsp_enable(void)
 {
     atomic_set(&qemu_mutex_lock_func, qsp_mutex_lock);
     atomic_set(&qemu_mutex_trylock_func, qsp_mutex_trylock);
+    atomic_set(&qemu_bql_mutex_lock_func, qsp_bql_mutex_lock);
     atomic_set(&qemu_rec_mutex_lock_func, qsp_rec_mutex_lock);
     atomic_set(&qemu_rec_mutex_trylock_func, qsp_rec_mutex_trylock);
     atomic_set(&qemu_cond_wait_func, qsp_cond_wait);
@@ -412,6 +417,7 @@ void qsp_disable(void)
 {
     atomic_set(&qemu_mutex_lock_func, qemu_mutex_lock_impl);
     atomic_set(&qemu_mutex_trylock_func, qemu_mutex_trylock_impl);
+    atomic_set(&qemu_bql_mutex_lock_func, qemu_mutex_lock_impl);
     atomic_set(&qemu_rec_mutex_lock_func, qemu_rec_mutex_lock_impl);
     atomic_set(&qemu_rec_mutex_trylock_func, qemu_rec_mutex_trylock_impl);
     atomic_set(&qemu_cond_wait_func, qemu_cond_wait_impl);
-- 
2.17.1
