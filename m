Received: from eggs.gnu.org ([2001:4830:134:3::10]:51713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpGNe-0005Wi-UZ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpGNb-0006au-KR
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpGNb-0006aV-Cw
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 13:11:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 13:11:32 -0400
Message-Id: <20180813171132.21939-4-cota@braap.org>
In-Reply-To: <20180813171132.21939-1-cota@braap.org>
References: <20180813171132.21939-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/3] qsp: track BQL callers directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>

The BQL is acquired via qemu_mutex_lock_iothread(), which makes
the profiler assign the associated wait time (i.e. most of
BQL wait time) entirely to that function. This loses the original
call site information, which does not help diagnose BQL contention.
Fix it by tracking the callers directly when the lock profiler is
enabled. While at it, add a QSP type specific to it, so that the
BQL is reported as "BQL mutex".

- Before:
Type               Object  Call site          Wait Time (s)         Count  Average (us)
---------------------------------------------------------------------------------------
condvar    0x557ee3090e80  cpus.c:1084              1.69207          2916        580.27
condvar    0x557ee30ceb10  cpus.c:1084              1.43442          2404        596.68
mutex      0x557ee2503540  cpus.c:1583              0.30300        636558          0.48
condvar    0x557ee2534460  cpus-common.c:216        0.13549         15513          8.73
condvar    0x557ee2534420  cpus-common.c:186        0.08927         15747          5.67
mutex      0x557ee3090a40  tcg/tcg.c:378            0.00823        120034          0.07
mutex      0x557ee3090a00  tcg/tcg.c:378            0.00820        117890          0.07
mutex      0x557ee3090ac0  tcg/tcg.c:378            0.00764        115954          0.07
mutex      0x557ee3090a80  tcg/tcg.c:378            0.00762        116573          0.07
mutex      0x557ee3090b00  tcg/tcg.c:378            0.00560         82547          0.07
---------------------------------------------------------------------------------------

- After:
Type               Object  Call site                   Wait Time (s)         Count  Average (us)
------------------------------------------------------------------------------------------------
condvar    0x555d4b37bb10  cpus.c:1084                       1.82472          1245       1465.64
condvar    0x555d4b33de80  cpus.c:1084                       1.22456          3105        394.38
condvar    0x555d48ee3460  cpus-common.c:216                 0.15380         18510          8.31
condvar    0x555d48ee3420  cpus-common.c:186                 0.10400         18303          5.68
BQL mutex  0x555d48eb2540  cpus.c:1272                       0.06565         77751          0.84
BQL mutex  0x555d48eb2540  target/arm/op_helper.c:837        0.04077         28317          1.44
BQL mutex  0x555d48eb2540  accel/tcg/cpu-exec.c:502          0.03935        149975          0.26
BQL mutex  0x555d48eb2540  target/arm/op_helper.c:851        0.03917         85698          0.46
BQL mutex  0x555d48eb2540  util/rcu.c:257                    0.03059             9       3399.36
BQL mutex  0x555d48eb2540  cpus-common.c:352                 0.02717         29992          0.91
------------------------------------------------------------------------------------------------

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/main-loop.h | 10 +++++++++-
 include/qemu/qsp.h       |  2 ++
 cpus.c                   | 15 ++++++++++++++-
 stubs/iothread-lock.c    |  8 +++++++-
 util/qsp.c               |  4 ++++
 5 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 721aa2416a..dc64731009 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -276,7 +276,15 @@ bool qemu_mutex_iothread_locked(void);
  * NOTE: tools currently are single-threaded and qemu_mutex_lock_iothread
  * is a no-op there.
  */
-void qemu_mutex_lock_iothread(void);
+#ifdef CONFIG_SYNC_PROFILER
+void do_qemu_mutex_lock_iothread(const char *file, int line);
+#define qemu_mutex_lock_iothread()                      \
+    do_qemu_mutex_lock_iothread(__FILE__, __LINE__)
+#else
+void do_qemu_mutex_lock_iothread(void);
+#define qemu_mutex_lock_iothread()              \
+    do_qemu_mutex_lock_iothread()
+#endif
 
 /**
  * qemu_mutex_unlock_iothread: Unlock the main loop mutex.
diff --git a/include/qemu/qsp.h b/include/qemu/qsp.h
index e36f94ab1d..96a1fff1bb 100644
--- a/include/qemu/qsp.h
+++ b/include/qemu/qsp.h
@@ -18,6 +18,8 @@
 void qsp_mutex_lock(QemuMutex *mutex, const char *file, unsigned line);
 int qsp_mutex_trylock(QemuMutex *mutex, const char *file, unsigned line);
 
+void qsp_bql_mutex_lock(QemuMutex *mutex, const char *file, unsigned line);
+
 void qsp_rec_mutex_lock(QemuRecMutex *mutex, const char *file, unsigned line);
 int qsp_rec_mutex_trylock(QemuRecMutex *mutex, const char *file, unsigned line);
 
diff --git a/cpus.c b/cpus.c
index b5844b7103..8ec034954b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1762,12 +1762,25 @@ bool qemu_mutex_iothread_locked(void)
     return iothread_locked;
 }
 
-void qemu_mutex_lock_iothread(void)
+/*
+ * The BQL is taken from so many places that it is worth tracking the
+ * callers directly, instead of funneling them all through a single function.
+ */
+#ifdef CONFIG_SYNC_PROFILER
+void do_qemu_mutex_lock_iothread(const char *file, int line)
+{
+    g_assert(!qemu_mutex_iothread_locked());
+    qsp_bql_mutex_lock(&qemu_global_mutex, file, line);
+    iothread_locked = true;
+}
+#else
+void do_qemu_mutex_lock_iothread(void)
 {
     g_assert(!qemu_mutex_iothread_locked());
     qemu_mutex_lock(&qemu_global_mutex);
     iothread_locked = true;
 }
+#endif /* CONFIG_SYNC_PROFILER */
 
 void qemu_mutex_unlock_iothread(void)
 {
diff --git a/stubs/iothread-lock.c b/stubs/iothread-lock.c
index 9b6db2e740..3d129f367c 100644
--- a/stubs/iothread-lock.c
+++ b/stubs/iothread-lock.c
@@ -7,9 +7,15 @@ bool qemu_mutex_iothread_locked(void)
     return true;
 }
 
-void qemu_mutex_lock_iothread(void)
+#ifdef CONFIG_SYNC_PROFILER
+void do_qemu_mutex_lock_iothread(const char *file, int line)
 {
 }
+#else
+void do_qemu_mutex_lock_iothread(void)
+{
+}
+#endif
 
 void qemu_mutex_unlock_iothread(void)
 {
diff --git a/util/qsp.c b/util/qsp.c
index 908e99cccf..9f12762d36 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -61,6 +61,7 @@
 
 enum qsp_type {
     QSP_MUTEX,
+    QSP_BQL_MUTEX,
     QSP_REC_MUTEX,
     QSP_CONDVAR,
 };
@@ -102,6 +103,7 @@ static bool qsp_initialized, qsp_initializing;
 
 static const char * const qsp_typenames[] = {
     [QSP_MUTEX]     = "mutex",
+    [QSP_BQL_MUTEX] = "BQL mutex",
     [QSP_REC_MUTEX] = "rec_mutex",
     [QSP_CONDVAR]   = "condvar",
 };
@@ -316,6 +318,8 @@ static struct qsp_entry *qsp_entry_get(const void *obj, const char *file,
 QSP_GEN_VOID(QemuMutex, QSP_MUTEX, qsp_mutex_lock, qemu_mutex_lock_impl)
 QSP_GEN_RET1(QemuMutex, QSP_MUTEX, qsp_mutex_trylock, qemu_mutex_trylock_impl)
 
+QSP_GEN_VOID(QemuMutex, QSP_BQL_MUTEX, qsp_bql_mutex_lock, qemu_mutex_lock_impl)
+
 QSP_GEN_VOID(QemuRecMutex, QSP_REC_MUTEX, qsp_rec_mutex_lock,
              qemu_rec_mutex_lock_impl)
 QSP_GEN_RET1(QemuRecMutex, QSP_REC_MUTEX, qsp_rec_mutex_trylock,
-- 
2.17.1
