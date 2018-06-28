Received: from eggs.gnu.org ([2001:4830:134:3::10]:37934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAY-0007Be-8O
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAW-0000KZ-Qd
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:30 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:51455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAW-0000Id-IR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:28 -0400
Received: by mail-wm0-x241.google.com with SMTP id w137-v6so11045995wmw.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:23 +0200
Message-Id: <1530216310-52873-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/60] QemuMutex: support --enable-debug-mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

We have had some tracing tools for mutex but it's not easy to use them
for e.g. dead locks.  Let's provide "--enable-debug-mutex" parameter
when configure to allow QemuMutex to store the last owner that took
specific lock.  It will be easy to use this tool to debug deadlocks
since we can directly know who took the lock then as long as we can have
a debugger attached to the process.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180425025459.5258-4-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                   | 10 ++++++++++
 include/qemu/thread-posix.h |  4 ++++
 include/qemu/thread-win32.h |  4 ++++
 util/qemu-thread-common.h   | 12 ++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/configure b/configure
index 4d12cfb..3f53aa7 100755
--- a/configure
+++ b/configure
@@ -456,6 +456,7 @@ replication="yes"
 vxhs=""
 libxml2=""
 docker="no"
+debug_mutex="no"
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
 cross_cc_aarch64="aarch64-linux-gnu-gcc"
@@ -1411,6 +1412,10 @@ for opt do
   ;;
   --disable-git-update) git_update=no
   ;;
+  --enable-debug-mutex) debug_mutex=yes
+  ;;
+  --disable-debug-mutex) debug_mutex=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1685,6 +1690,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   crypto-afalg    Linux AF_ALG crypto backend driver
   vhost-user      vhost-user support
   capstone        capstone disassembler support
+  debug-mutex     mutex debugging support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -5951,6 +5957,7 @@ echo "seccomp support   $seccomp"
 echo "coroutine backend $coroutine"
 echo "coroutine pool    $coroutine_pool"
 echo "debug stack usage $debug_stack_usage"
+echo "mutex debugging   $debug_mutex"
 echo "crypto afalg      $crypto_afalg"
 echo "GlusterFS support $glusterfs"
 echo "gcov              $gcov_tool"
@@ -6704,6 +6711,9 @@ fi
 if test "$capstone" != "no" ; then
   echo "CONFIG_CAPSTONE=y" >> $config_host_mak
 fi
+if test "$debug_mutex" = "yes" ; then
+  echo "CONFIG_DEBUG_MUTEX=y" >> $config_host_mak
+fi
 
 # Hold two types of flag:
 #   CONFIG_THREAD_SETNAME_BYTHREAD  - we've got a way of setting the name on
diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index f3f47e4..fd27b34 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -12,6 +12,10 @@ typedef QemuMutex QemuRecMutex;
 
 struct QemuMutex {
     pthread_mutex_t lock;
+#ifdef CONFIG_DEBUG_MUTEX
+    const char *file;
+    int line;
+#endif
     bool initialized;
 };
 
diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index 3a05e3b..d668d78 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -5,6 +5,10 @@
 
 struct QemuMutex {
     SRWLOCK lock;
+#ifdef CONFIG_DEBUG_MUTEX
+    const char *file;
+    int line;
+#endif
     bool initialized;
 };
 
diff --git a/util/qemu-thread-common.h b/util/qemu-thread-common.h
index d329208..a0ea7c0 100644
--- a/util/qemu-thread-common.h
+++ b/util/qemu-thread-common.h
@@ -19,6 +19,10 @@
 
 static inline void qemu_mutex_post_init(QemuMutex *mutex)
 {
+#ifdef CONFIG_DEBUG_MUTEX
+    mutex->file = NULL;
+    mutex->line = 0;
+#endif
     mutex->initialized = true;
 }
 
@@ -31,12 +35,20 @@ static inline void qemu_mutex_pre_lock(QemuMutex *mutex,
 static inline void qemu_mutex_post_lock(QemuMutex *mutex,
                                         const char *file, int line)
 {
+#ifdef CONFIG_DEBUG_MUTEX
+    mutex->file = file;
+    mutex->line = line;
+#endif
     trace_qemu_mutex_locked(mutex, file, line);
 }
 
 static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
                                          const char *file, int line)
 {
+#ifdef CONFIG_DEBUG_MUTEX
+    mutex->file = NULL;
+    mutex->line = 0;
+#endif
     trace_qemu_mutex_unlock(mutex, file, line);
 }
 
-- 
1.8.3.1
