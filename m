Received: from eggs.gnu.org ([209.51.188.92]:35774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3Vsg-000064-94
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3VlZ-0007HT-Te
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:59:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h3VlZ-0007Gl-JM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:59:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Mar 2019 21:59:24 -0300
Message-Id: <20190312005930.9043-2-ehabkost@redhat.com>
In-Reply-To: <20190312005930.9043-1-ehabkost@redhat.com>
References: <20190312005930.9043-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] hostmem-file: reject invalid pmem file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, Zhang Yi <yi.z.zhang@linux.intel.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

Guests started with NVDIMMs larger than the underlying host file produce
confusing errors inside the guest.  This happens because the guest
accesses pages beyond the end of the file.

Check the pmem file size on startup and print a clear error message if
the size is invalid.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1669053
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190214031004.32522-3-stefanha@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qemu/osdep.h    | 13 ++++++++++
 backends/hostmem-file.c | 23 ++++++++++++++++++
 util/oslib-posix.c      | 53 +++++++++++++++++++++++++++++++++++++++++
 util/oslib-win32.c      |  5 ++++
 4 files changed, 94 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 840af09cb0..303d315c5d 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -570,6 +570,19 @@ void qemu_set_tty_echo(int fd, bool echo);
 void os_mem_prealloc(int fd, char *area, size_t sz, int smp_cpus,
                      Error **errp);
 
+/**
+ * qemu_get_pmem_size:
+ * @filename: path to a pmem file
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Determine the size of a persistent memory file.  Besides supporting files on
+ * DAX file systems, this function also supports Linux devdax character
+ * devices.
+ *
+ * Returns: the size or 0 on failure
+ */
+uint64_t qemu_get_pmem_size(const char *filename, Error **errp);
+
 /**
  * qemu_get_pid_name:
  * @pid: pid of a process
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index ce54788048..37ac6445d2 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -56,6 +56,29 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         error_setg(errp, "mem-path property not set");
         return;
     }
+
+    /*
+     * Verify pmem file size since starting a guest with an incorrect size
+     * leads to confusing failures inside the guest.
+     */
+    if (fb->is_pmem) {
+        Error *local_err = NULL;
+        uint64_t size;
+
+        size = qemu_get_pmem_size(fb->mem_path, &local_err);
+        if (!size) {
+            error_propagate(errp, local_err);
+            return;
+        }
+
+        if (backend->size > size) {
+            error_setg(errp, "size property %" PRIu64 " is larger than "
+                       "pmem file \"%s\" size %" PRIu64, backend->size,
+                       fb->mem_path, size);
+            return;
+        }
+    }
+
     backend->force_prealloc = mem_prealloc;
     name = host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 37c5854b9c..10d90d1783 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -500,6 +500,59 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
     }
 }
 
+uint64_t qemu_get_pmem_size(const char *filename, Error **errp)
+{
+    struct stat st;
+
+    if (stat(filename, &st) < 0) {
+        error_setg(errp, "unable to stat pmem file \"%s\"", filename);
+        return 0;
+    }
+
+#if defined(__linux__)
+    /* Special handling for devdax character devices */
+    if (S_ISCHR(st.st_mode)) {
+        char *subsystem_path = NULL;
+        char *subsystem = NULL;
+        char *size_path = NULL;
+        char *size_str = NULL;
+        uint64_t ret = 0;
+
+        subsystem_path = g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
+                                         major(st.st_rdev), minor(st.st_rdev));
+        subsystem = g_file_read_link(subsystem_path, NULL);
+        if (!subsystem) {
+            error_setg(errp, "unable to read subsystem for pmem file \"%s\"",
+                       filename);
+            goto devdax_err;
+        }
+
+        if (!g_str_has_suffix(subsystem, "/dax")) {
+            error_setg(errp, "pmem file \"%s\" is not a dax device", filename);
+            goto devdax_err;
+        }
+
+        size_path = g_strdup_printf("/sys/dev/char/%d:%d/size",
+                                    major(st.st_rdev), minor(st.st_rdev));
+        if (!g_file_get_contents(size_path, &size_str, NULL, NULL)) {
+            error_setg(errp, "unable to read size for pmem file \"%s\"",
+                       size_path);
+            goto devdax_err;
+        }
+
+        ret = g_ascii_strtoull(size_str, NULL, 0);
+
+devdax_err:
+        g_free(size_str);
+        g_free(size_path);
+        g_free(subsystem);
+        g_free(subsystem_path);
+        return ret;
+    }
+#endif /* defined(__linux__) */
+
+    return st.st_size;
+}
 
 char *qemu_get_pid_name(pid_t pid)
 {
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b4c17f5dfa..bd633afab6 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -560,6 +560,11 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
     }
 }
 
+uint64_t qemu_get_pmem_size(const char *filename, Error **errp)
+{
+    error_setg(errp, "pmem support not available");
+    return 0;
+}
 
 char *qemu_get_pid_name(pid_t pid)
 {
-- 
2.18.0.rc1.1.g3f1ff2140
