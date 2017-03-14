Received: from eggs.gnu.org ([2001:4830:134:3::10]:36593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9a-0003PQ-VD
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9Z-0006YC-Dj
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:30 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9Z-0006XZ-2u
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:29 -0400
Received: by mail-wr0-x244.google.com with SMTP id l37so24466485wrc.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:05 +0100
Message-Id: <1489508300-48184-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/18] mem-prealloc: reduce large guest start-up
 and migration time.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jitendra Kolhe <jitendra.kolhe@hpe.com>

From: Jitendra Kolhe <jitendra.kolhe@hpe.com>

Using "-mem-prealloc" option for a large guest leads to higher guest
start-up and migration time. This is because with "-mem-prealloc" option
qemu tries to map every guest page (create address translations), and
make sure the pages are available during runtime. virsh/libvirt by
default, seems to use "-mem-prealloc" option in case the guest is
configured to use huge pages. The patch tries to map all guest pages
simultaneously by spawning multiple threads. Currently limiting the
change to QEMU library functions on POSIX compliant host only, as we are
not sure if the problem exists on win32. Below are some stats with
"-mem-prealloc" option for guest configured to use huge pages.

------------------------------------------------------------------------
Idle Guest      | Start-up time | Migration time
------------------------------------------------------------------------
Guest stats with 2M HugePage usage - single threaded (existing code)
------------------------------------------------------------------------
64 Core - 4TB   | 54m11.796s    | 75m43.843s
64 Core - 1TB   | 8m56.576s     | 14m29.049s
64 Core - 256GB | 2m11.245s     | 3m26.598s
------------------------------------------------------------------------
Guest stats with 2M HugePage usage - map guest pages using 8 threads
------------------------------------------------------------------------
64 Core - 4TB   | 5m1.027s      | 34m10.565s
64 Core - 1TB   | 1m10.366s     | 8m28.188s
64 Core - 256GB | 0m19.040s     | 2m10.148s
-----------------------------------------------------------------------
Guest stats with 2M HugePage usage - map guest pages using 16 threads
-----------------------------------------------------------------------
64 Core - 4TB   | 1m58.970s     | 31m43.400s
64 Core - 1TB   | 0m39.885s     | 7m55.289s
64 Core - 256GB | 0m11.960s     | 2m0.135s
-----------------------------------------------------------------------

Changed in v2:
 - modify number of memset threads spawned to min(smp_cpus, 16).
 - removed 64GB memory restriction for spawning memset threads.

Changed in v3:
 - limit number of threads spawned based on
   min(sysconf(_SC_NPROCESSORS_ONLN), 16, smp_cpus)
 - implement memset thread specific siglongjmp in SIGBUS signal_handler.

Changed in v4
 - remove sigsetjmp/siglongjmp and SIGBUS unblock/block for main thread
   as main thread no longer touches any pages.
 - simplify code my returning memset_thread_failed status from
   touch_all_pages.

Signed-off-by: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Message-Id: <1487907103-32350-1-git-send-email-jitendra.kolhe@hpe.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/hostmem.c   |   4 +-
 exec.c               |   2 +-
 include/qemu/osdep.h |   3 +-
 util/oslib-posix.c   | 108 +++++++++++++++++++++++++++++++++++++++++----------
 util/oslib-win32.c   |   3 +-
 5 files changed, 94 insertions(+), 26 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 7f5de70..162c218 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -224,7 +224,7 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
         void *ptr = memory_region_get_ram_ptr(&backend->mr);
         uint64_t sz = memory_region_size(&backend->mr);
 
-        os_mem_prealloc(fd, ptr, sz, &local_err);
+        os_mem_prealloc(fd, ptr, sz, smp_cpus, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
@@ -328,7 +328,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
          */
         if (backend->prealloc) {
             os_mem_prealloc(memory_region_get_fd(&backend->mr), ptr, sz,
-                            &local_err);
+                            smp_cpus, &local_err);
             if (local_err) {
                 goto out;
             }
diff --git a/exec.c b/exec.c
index aabb035..68135a9 100644
--- a/exec.c
+++ b/exec.c
@@ -1467,7 +1467,7 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 
     if (mem_prealloc) {
-        os_mem_prealloc(fd, area, memory, errp);
+        os_mem_prealloc(fd, area, memory, smp_cpus, errp);
         if (errp && *errp) {
             goto error;
         }
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index af37195..122ff06 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -438,7 +438,8 @@ unsigned long qemu_getauxval(unsigned long type);
 
 void qemu_set_tty_echo(int fd, bool echo);
 
-void os_mem_prealloc(int fd, char *area, size_t sz, Error **errp);
+void os_mem_prealloc(int fd, char *area, size_t sz, int smp_cpus,
+                     Error **errp);
 
 int qemu_read_password(char *buf, int buf_size);
 
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index cd686aa..956f66a 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -55,6 +55,21 @@
 #include "qemu/error-report.h"
 #endif
 
+#define MAX_MEM_PREALLOC_THREAD_COUNT (MIN(sysconf(_SC_NPROCESSORS_ONLN), 16))
+
+struct MemsetThread {
+    char *addr;
+    uint64_t numpages;
+    uint64_t hpagesize;
+    QemuThread pgthread;
+    sigjmp_buf env;
+};
+typedef struct MemsetThread MemsetThread;
+
+static MemsetThread *memset_thread;
+static int memset_num_threads;
+static bool memset_thread_failed;
+
 int qemu_get_thread_id(void)
 {
 #if defined(__linux__)
@@ -316,18 +331,83 @@ char *qemu_get_exec_dir(void)
     return g_strdup(exec_dir);
 }
 
-static sigjmp_buf sigjump;
-
 static void sigbus_handler(int signal)
 {
-    siglongjmp(sigjump, 1);
+    int i;
+    if (memset_thread) {
+        for (i = 0; i < memset_num_threads; i++) {
+            if (qemu_thread_is_self(&memset_thread[i].pgthread)) {
+                siglongjmp(memset_thread[i].env, 1);
+            }
+        }
+    }
+}
+
+static void *do_touch_pages(void *arg)
+{
+    MemsetThread *memset_args = (MemsetThread *)arg;
+    char *addr = memset_args->addr;
+    uint64_t numpages = memset_args->numpages;
+    uint64_t hpagesize = memset_args->hpagesize;
+    sigset_t set, oldset;
+    int i = 0;
+
+    /* unblock SIGBUS */
+    sigemptyset(&set);
+    sigaddset(&set, SIGBUS);
+    pthread_sigmask(SIG_UNBLOCK, &set, &oldset);
+
+    if (sigsetjmp(memset_args->env, 1)) {
+        memset_thread_failed = true;
+    } else {
+        for (i = 0; i < numpages; i++) {
+            memset(addr, 0, 1);
+            addr += hpagesize;
+        }
+    }
+    pthread_sigmask(SIG_SETMASK, &oldset, NULL);
+    return NULL;
+}
+
+static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
+                            int smp_cpus)
+{
+    uint64_t numpages_per_thread, size_per_thread;
+    char *addr = area;
+    int i = 0;
+
+    memset_thread_failed = false;
+    memset_num_threads = MIN(smp_cpus, MAX_MEM_PREALLOC_THREAD_COUNT);
+    memset_thread = g_new0(MemsetThread, memset_num_threads);
+    numpages_per_thread = (numpages / memset_num_threads);
+    size_per_thread = (hpagesize * numpages_per_thread);
+    for (i = 0; i < memset_num_threads; i++) {
+        memset_thread[i].addr = addr;
+        memset_thread[i].numpages = (i == (memset_num_threads - 1)) ?
+                                    numpages : numpages_per_thread;
+        memset_thread[i].hpagesize = hpagesize;
+        qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
+                           do_touch_pages, &memset_thread[i],
+                           QEMU_THREAD_JOINABLE);
+        addr += size_per_thread;
+        numpages -= numpages_per_thread;
+    }
+    for (i = 0; i < memset_num_threads; i++) {
+        qemu_thread_join(&memset_thread[i].pgthread);
+    }
+    g_free(memset_thread);
+    memset_thread = NULL;
+
+    return memset_thread_failed;
 }
 
-void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
+void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
+                     Error **errp)
 {
     int ret;
     struct sigaction act, oldact;
-    sigset_t set, oldset;
+    size_t hpagesize = qemu_fd_getpagesize(fd);
+    size_t numpages = DIV_ROUND_UP(memory, hpagesize);
 
     memset(&act, 0, sizeof(act));
     act.sa_handler = &sigbus_handler;
@@ -340,23 +420,10 @@ void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
         return;
     }
 
-    /* unblock SIGBUS */
-    sigemptyset(&set);
-    sigaddset(&set, SIGBUS);
-    pthread_sigmask(SIG_UNBLOCK, &set, &oldset);
-
-    if (sigsetjmp(sigjump, 1)) {
+    /* touch pages simultaneously */
+    if (touch_all_pages(area, hpagesize, numpages, smp_cpus)) {
         error_setg(errp, "os_mem_prealloc: Insufficient free host memory "
             "pages available to allocate guest RAM\n");
-    } else {
-        int i;
-        size_t hpagesize = qemu_fd_getpagesize(fd);
-        size_t numpages = DIV_ROUND_UP(memory, hpagesize);
-
-        /* MAP_POPULATE silently ignores failures */
-        for (i = 0; i < numpages; i++) {
-            memset(area + (hpagesize * i), 0, 1);
-        }
     }
 
     ret = sigaction(SIGBUS, &oldact, NULL);
@@ -365,7 +432,6 @@ void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
         perror("os_mem_prealloc: failed to reinstall signal handler");
         exit(1);
     }
-    pthread_sigmask(SIG_SETMASK, &oldset, NULL);
 }
 
 
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 0b1890f..80e4668 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -541,7 +541,8 @@ int getpagesize(void)
     return system_info.dwPageSize;
 }
 
-void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
+void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
+                     Error **errp)
 {
     int i;
     size_t pagesize = getpagesize();
-- 
1.8.3.1
