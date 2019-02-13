Received: from eggs.gnu.org ([209.51.188.92]:53252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gtqJL-0005Qq-Kh
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gtqJG-0000rO-Df
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:54:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:56637)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1gtqJE-0000m5-Jq
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:54:25 -0500
Date: Wed, 13 Feb 2019 16:53:54 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190213085354.GA4262@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190213071401.11544-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213071401.11544-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hostmem-file: reject invalid pmem file
 sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Zhang Yi <yi.z.zhang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, Feb 13, 2019 at 03:14:01PM +0800, Stefan Hajnoczi wrote:
>Guests started with NVDIMMs larger than the underlying host file produce
>confusing errors inside the guest.  This happens because the guest
>accesses pages beyond the end of the file.
>
>Check the pmem file size on startup and print a clear error message if
>the size is invalid.
>
>Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1669053
>Cc: Haozhong Zhang <haozhong.zhang@intel.com>
>Cc: Zhang Yi <yi.z.zhang@linux.intel.com>
>Cc: Eduardo Habkost <ehabkost@redhat.com>
>Cc: Igor Mammedov <imammedo@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
>v2:
> * Propagate qemu_get_pmem_size() errors [Igor]
>
> include/qemu/osdep.h    | 13 ++++++++++
> backends/hostmem-file.c | 22 +++++++++++++++++
> util/oslib-posix.c      | 53 +++++++++++++++++++++++++++++++++++++++++
> util/oslib-win32.c      |  5 ++++
> 4 files changed, 93 insertions(+)
>
>diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>index 840af09cb0..303d315c5d 100644
>--- a/include/qemu/osdep.h
>+++ b/include/qemu/osdep.h
>@@ -570,6 +570,19 @@ void qemu_set_tty_echo(int fd, bool echo);
> void os_mem_prealloc(int fd, char *area, size_t sz, int smp_cpus,
>                      Error **errp);
> 
>+/**
>+ * qemu_get_pmem_size:
>+ * @filename: path to a pmem file
>+ * @errp: pointer to a NULL-initialized error object
>+ *
>+ * Determine the size of a persistent memory file.  Besides supporting files on
>+ * DAX file systems, this function also supports Linux devdax character
>+ * devices.
>+ *
>+ * Returns: the size or 0 on failure
>+ */
>+uint64_t qemu_get_pmem_size(const char *filename, Error **errp);
>+
> /**
>  * qemu_get_pid_name:
>  * @pid: pid of a process
>diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
>index ba601ce940..d62689179b 100644
>--- a/backends/hostmem-file.c
>+++ b/backends/hostmem-file.c
>@@ -46,6 +46,28 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>     gchar *name;
> #endif
> 
>+    /*
>+     * Verify pmem file size since starting a guest with an incorrect size
>+     * leads to confusing failures inside the guest.
>+     */
>+    if (fb->is_pmem && fb->mem_path) {
>+        Error *local_err = NULL;
>+        uint64_t size;
>+
>+        size = qemu_get_pmem_size(fb->mem_path, &local_err);
>+        if (!size) {
>+            error_propagate(errp, local_err);
>+            return;
>+        }
>+
>+        if (backend->size > size) {
>+            error_setg(errp, "size property %" PRIu64 " is larger than "
>+                       "pmem file \"%s\" size %" PRIu64, backend->size,
>+                       fb->mem_path, size);
>+            return;
>+        }
>+    }
>+

-mem-path is only supported on POSIX host.

So how about put this in the last code block before doing the real memory
region init?

BTW, I suggest to cleanup file_backend_memory_alloc() to make POSIX/non-POSIX
situation clear to understand.

>     if (!backend->size) {
>         error_setg(errp, "can't create backend with size 0");
>         return;
>diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>index 37c5854b9c..10d90d1783 100644
>--- a/util/oslib-posix.c
>+++ b/util/oslib-posix.c
>@@ -500,6 +500,59 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
>     }
> }
> 
>+uint64_t qemu_get_pmem_size(const char *filename, Error **errp)
>+{
>+    struct stat st;
>+
>+    if (stat(filename, &st) < 0) {
>+        error_setg(errp, "unable to stat pmem file \"%s\"", filename);
>+        return 0;
>+    }
>+
>+#if defined(__linux__)
>+    /* Special handling for devdax character devices */
>+    if (S_ISCHR(st.st_mode)) {
>+        char *subsystem_path = NULL;
>+        char *subsystem = NULL;
>+        char *size_path = NULL;
>+        char *size_str = NULL;
>+        uint64_t ret = 0;
>+
>+        subsystem_path = g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
>+                                         major(st.st_rdev), minor(st.st_rdev));
>+        subsystem = g_file_read_link(subsystem_path, NULL);
>+        if (!subsystem) {
>+            error_setg(errp, "unable to read subsystem for pmem file \"%s\"",
>+                       filename);
>+            goto devdax_err;
>+        }
>+
>+        if (!g_str_has_suffix(subsystem, "/dax")) {
>+            error_setg(errp, "pmem file \"%s\" is not a dax device", filename);
>+            goto devdax_err;
>+        }
>+
>+        size_path = g_strdup_printf("/sys/dev/char/%d:%d/size",
>+                                    major(st.st_rdev), minor(st.st_rdev));
>+        if (!g_file_get_contents(size_path, &size_str, NULL, NULL)) {
>+            error_setg(errp, "unable to read size for pmem file \"%s\"",
>+                       size_path);
>+            goto devdax_err;
>+        }
>+
>+        ret = g_ascii_strtoull(size_str, NULL, 0);
>+
>+devdax_err:
>+        g_free(size_str);
>+        g_free(size_path);
>+        g_free(subsystem);
>+        g_free(subsystem_path);
>+        return ret;
>+    }
>+#endif /* defined(__linux__) */
>+
>+    return st.st_size;
>+}
> 
> char *qemu_get_pid_name(pid_t pid)
> {
>diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>index b4c17f5dfa..bd633afab6 100644
>--- a/util/oslib-win32.c
>+++ b/util/oslib-win32.c
>@@ -560,6 +560,11 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
>     }
> }
> 
>+uint64_t qemu_get_pmem_size(const char *filename, Error **errp)
>+{
>+    error_setg(errp, "pmem support not available");
>+    return 0;
>+}
> 
> char *qemu_get_pid_name(pid_t pid)
> {
>-- 
>2.20.1
>

-- 
Wei Yang
Help you, Help me
