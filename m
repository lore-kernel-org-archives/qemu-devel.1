Received: from eggs.gnu.org ([2001:4830:134:3::10]:36073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1g0V1D-0001nf-Ge
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1g0V1A-000213-At
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:03:03 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:60415
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1g0V19-00020J-Ug
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:03:00 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <5aae1837-f6b9-a48b-7401-3aa623a084b2@adacore.com>
Date: Thu, 13 Sep 2018 19:02:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] crashes with win2008 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ashedel@microsoft.com
Cc: Andrew.Baumann@microsoft.com, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Andrey,

I've strange crashes since this commit: (yes its old)

commit 12f8def0e02232d7c6416ad9b66640f973c531d1
Author: Andrey Shedel <ashedel@microsoft.com>
Date:   Fri Mar 24 15:01:41 2017 -0700

     win32: replace custom mutex and condition variable with
            native primitives

Basically it just crashes.. (exception 0xc0000135) like this:

(gdb) run
Starting program: C:\home\konrad\temp\qemu-system-sparc --version
[New Thread 5324.0xdf8]
gdb: unknown target exception 0xc0000135 at 0x77636698
gdb: unknown target exception 0xc0000135 at 0x77636698

Program received signal ?, Unknown signal.
0x0000000077636698 in ntdll!RtlRaiseStatus ()
    from C:\Windows\system32\ntdll.dll
(gdb) bt
#0  0x0000000077636698 in ntdll!RtlRaiseStatus ()
    from C:\Windows\system32\ntdll.dll
#1  0x00000000775dcbf7 in ntdll!LdrGetProcedureAddress ()
    from C:\Windows\system32\ntdll.dll
#2  0x00000000775a536e in ntdll!LdrInitializeThunk ()
    from C:\Windows\system32\ntdll.dll
#3  0x0000000000000000 in ?? ()
Backtrace stopped: previous frame inner to this frame (corrupt 
stack?)
(gdb)

Sorry the backtrace is not really helpful..

I can reproduce the same behavior with v3.0.0.. and only with
the Windows 2008 server host..

If I partially revert the patch, eg: using CriticalSection
instead of SRWL it seems to work.. But I don't understand why
because SRWL should be supported on 2008 Server..

Here is the change I did (which is wrongly making qemu_mutex
recursive for now):

diff --git a/include/qemu/thread-win32.h 
b/include/qemu/thread-win32.h
index d668d789b4..b335687604 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -4,7 +4,8 @@
  #include <windows.h>

  struct QemuMutex {
-    SRWLOCK lock;
+    CRITICAL_SECTION lock;
+    LONG owner;
  #ifdef CONFIG_DEBUG_MUTEX
      const char *file;
      int line;
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index b303188a36..09ce4fd957 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -45,7 +45,7 @@ static void error_exit(int err, const char *msg)

  void qemu_mutex_init(QemuMutex *mutex)
  {
-    InitializeSRWLock(&mutex->lock);
+    InitializeCriticalSection(&mutex->lock);
      qemu_mutex_post_init(mutex);
  }

@@ -53,14 +53,14 @@ void qemu_mutex_destroy(QemuMutex *mutex)
  {
      assert(mutex->initialized);
      mutex->initialized = false;
-    InitializeSRWLock(&mutex->lock);
+    DeleteCriticalSection(&mutex->lock);
  }

  void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, 
const int line)
  {
      assert(mutex->initialized);
      qemu_mutex_pre_lock(mutex, file, line);
-    AcquireSRWLockExclusive(&mutex->lock);
+    EnterCriticalSection(&mutex->lock);
      qemu_mutex_post_lock(mutex, file, line);
  }

@@ -69,7 +69,7 @@ int qemu_mutex_trylock_impl(QemuMutex *mutex, 
const char *file, const int line)
      int owned;

      assert(mutex->initialized);
-    owned = TryAcquireSRWLockExclusive(&mutex->lock);
+    owned = TryEnterCriticalSection(&mutex->lock);there
      if (owned) {
          qemu_mutex_post_lock(mutex, file, line);
          return 0;
@@ -81,7 +81,7 @@ void qemu_mutex_unlock_impl(QemuMutex *mutex, 
const char *file, const int line)
  {
      assert(mutex->initialized);
      qemu_mutex_pre_unlock(mutex, file, line);
-    ReleaseSRWLockExclusive(&mutex->lock);
+    LeaveCriticalSection(&mutex->lock);
  }

  void qemu_rec_mutex_init(QemuRecMutex *mutex)
@@ -141,11 +141,12 @@ void qemu_cond_broadcast(QemuCond *cond)
      WakeAllConditionVariable(&cond->var);
  }

-void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const 
char *file, const int line)
+void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *mutex, const 
char *file,
+                         const int line)
  {
      assert(cond->initialized);
      qemu_mutex_pre_unlock(mutex, file, line);
-    SleepConditionVariableSRW(&cond->var, &mutex->lock, 
INFINITE, 0);
+    SleepConditionVariableCS(&cond->var, &mutex->lock, INFINITE);
      qemu_mutex_post_lock(mutex, file, line);
  }

-- 
2.16.2

Do you have any idea of what's happening?

Regards,
Fred
