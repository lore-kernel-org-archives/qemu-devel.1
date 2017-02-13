Received: from eggs.gnu.org ([2001:4830:134:3::10]:37596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cdCTa-0005X2-9N
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cdCTV-0006cY-B2
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:59:14 -0500
Received: from g2t2354.austin.hpe.com ([15.233.44.27]:21448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jitendra.kolhe@hpe.com>)
	id 1cdCTV-0006ac-1M
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:59:09 -0500
From: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Date: Mon, 13 Feb 2017 14:30:56 +0530
Message-Id: <1486976456-17657-1-git-send-email-jitendra.kolhe@hpe.com>
Subject: [Qemu-devel] [PATCH v2] mem-prealloc: reduce large guest start-up
 and migration time.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com
Cc: kwolf@redhat.com, peter.maydell@linaro.org, armbru@redhat.com, mohan_parthasarathy@hpe.com, renganathan.meenakshisundaram@hpe.com, jitendra.kolhe@hpe.com

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

Signed-off-by: Jitendra Kolhe <jitendra.kolhe@hpe.com>
---
 backends/hostmem.c   |  4 ++--
 exec.c               |  2 +-
 include/qemu/osdep.h |  3 ++-
 util/oslib-posix.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++-----
 util/oslib-win32.c   |  3 ++-
 5 files changed, 69 insertions(+), 11 deletions(-)

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
index 8b9ed73..53afcd2 100644
--- a/exec.c
+++ b/exec.c
@@ -1379,7 +1379,7 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 
     if (mem_prealloc) {
-        os_mem_prealloc(fd, area, memory, errp);
+        os_mem_prealloc(fd, area, memory, smp_cpus, errp);
         if (errp && *errp) {
             goto error;
         }
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 56c9e22..fb1d22b 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -401,7 +401,8 @@ unsigned long qemu_getauxval(unsigned long type);
 
 void qemu_set_tty_echo(int fd, bool echo);
 
-void os_mem_prealloc(int fd, char *area, size_t sz, Error **errp);
+void os_mem_prealloc(int fd, char *area, size_t sz, int smp_cpus,
+                     Error **errp);
 
 int qemu_read_password(char *buf, int buf_size);
 
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index f631464..17da029 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -55,6 +55,16 @@
 #include "qemu/error-report.h"
 #endif
 
+#define MAX_MEM_PREALLOC_THREAD_COUNT 16
+struct PageRange {
+    char *addr;
+    uint64_t numpages;
+    uint64_t hpagesize;
+};
+typedef struct PageRange PageRange;
+
+static PageRange *page_range;
+
 int qemu_get_thread_id(void)
 {
 #if defined(__linux__)
@@ -323,7 +333,56 @@ static void sigbus_handler(int signal)
     siglongjmp(sigjump, 1);
 }
 
-void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
+static void *do_touch_pages(void *arg)
+{
+    PageRange *range = (PageRange *)arg;
+    char *addr = range->addr;
+    uint64_t numpages = range->numpages;
+    uint64_t hpagesize = range->hpagesize;
+    int i = 0;
+
+    for (i = 0; i < numpages; i++) {
+        memset(addr, 0, 1);
+        addr += hpagesize;
+    }
+    return NULL;
+}
+
+static void touch_all_pages(char *area, size_t hpagesize, size_t numpages,
+                            int smp_cpus)
+{
+    QemuThread page_threads[MAX_MEM_PREALLOC_THREAD_COUNT];
+    uint64_t numpages_per_thread, size_per_thread;
+    char *addr = area;
+    int i = 0;
+    int num_threads = MIN(smp_cpus, MAX_MEM_PREALLOC_THREAD_COUNT);
+
+    page_range = g_new0(PageRange, num_threads);
+    numpages_per_thread = (numpages / num_threads);
+    size_per_thread = (hpagesize * numpages_per_thread);
+    for (i = 0; i < (num_threads - 1); i++) {
+        page_range[i].addr = addr;
+        page_range[i].numpages = numpages_per_thread;
+        page_range[i].hpagesize = hpagesize;
+        qemu_thread_create(page_threads + i, "touch_pages",
+                           do_touch_pages, (page_range + i),
+                           QEMU_THREAD_JOINABLE);
+        addr += size_per_thread;
+        numpages -= numpages_per_thread;
+    }
+    for (i = 0; i < numpages; i++) {
+        memset(addr, 0, 1);
+        addr += hpagesize;
+    }
+    for (i = 0; i < (num_threads - 1); i++) {
+        qemu_thread_join(page_threads + i);
+    }
+    g_free(page_range);
+    page_range = NULL;
+}
+
+void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
+                     Error **errp)
 {
     int ret;
     struct sigaction act, oldact;
@@ -349,14 +408,11 @@ void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
         error_setg(errp, "os_mem_prealloc: Insufficient free host memory "
             "pages available to allocate guest RAM\n");
     } else {
-        int i;
         size_t hpagesize = qemu_fd_getpagesize(fd);
         size_t numpages = DIV_ROUND_UP(memory, hpagesize);
 
-        /* MAP_POPULATE silently ignores failures */
-        for (i = 0; i < numpages; i++) {
-            memset(area + (hpagesize * i), 0, 1);
-        }
+        /* touch pages simultaneously */
+        touch_all_pages(area, hpagesize, numpages, smp_cpus);
     }
 
     ret = sigaction(SIGBUS, &oldact, NULL);
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
