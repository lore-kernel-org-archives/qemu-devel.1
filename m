Received: from eggs.gnu.org ([2001:4830:134:3::10]:49180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cz16i-0007Rx-Sm
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 09:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cz16f-0008ET-S7
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 09:17:48 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:24106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cz16f-0008DO-MK
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 09:17:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OOE00IO7I9IUO00@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 14 Apr 2017 14:17:42 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 14 Apr 2017 16:17:20 +0300
Message-id: <1492175840-5021-7-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
References: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170414131741eucas1p2f34e11e4292fef1c50ef63bd3522ad04@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH 6/6] migration: detailed traces for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, qemu-devel@nongnu.org
Cc: a.perevalov@samsung.com, i.maximets@samsung.com

It could help to track down vCPU state during page fault and
page fault sources.

This patch showes proc's status/stack/syscall file at the moment of pagefault,
it's very interesting to know who was page fault initiator.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events   |  6 +++
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 42330fd..513633c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -412,7 +412,91 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
     return 0;
 }
 
-static int get_mem_fault_cpu_index(uint32_t pid)
+#define PROC_LEN 1024
+#define DEBUG_FAULT_PROCESS_STATUS 1
+
+#ifdef DEBUG_FAULT_PROCESS_STATUS
+
+static FILE *get_proc_file(const gchar *frmt, pid_t thread_id)
+{
+    FILE *f = NULL;
+    gchar *file_path = g_strdup_printf(frmt, thread_id);
+    if (file_path == NULL) {
+        error_report("Couldn't allocate path for %u", thread_id);
+        return NULL;
+    }
+    f = fopen(file_path, "r");
+    if (!f) {
+        error_report("can't open %s", file_path);
+    }
+
+    trace_get_proc_file(file_path);
+    g_free(file_path);
+    return f;
+}
+
+typedef void(*proc_line_handler)(const char *line);
+
+static void proc_line_cb(const char *line)
+{
+    /* trace_ functions are inline */
+    trace_proc_line_cb(line);
+}
+
+static void foreach_line_in_file(FILE *f, proc_line_handler cb)
+{
+    char *line = NULL;
+    ssize_t read;
+    size_t len;
+
+    while ((read = getline(&line, &len, f)) != -1) {
+        /* workaround, trace_ infrastructure already insert \n
+         * and getline includes it */
+        ssize_t str_len = strlen(line) - 1;
+        if (str_len <= 0)
+            continue;
+        line[str_len] = '\0';
+        cb(line);
+    }
+    free(line);
+}
+
+static void observe_thread_proc(const gchar *path_frmt, pid_t thread_id)
+{
+    FILE *f = get_proc_file(path_frmt, thread_id);
+    if (!f) {
+        error_report("can't read thread's proc");
+        return;
+    }
+
+    foreach_line_in_file(f, proc_line_cb);
+    fclose(f);
+}
+
+/*
+ * for convinience tracing need to trace
+ * observe_thread_begin
+ * get_proc_file
+ * proc_line_cb
+ * observe_thread_end
+ */
+static void observe_thread(const char *msg, pid_t thread_id)
+{
+    trace_observe_thread_begin(msg);
+    observe_thread_proc("/proc/%d/status", thread_id);
+    observe_thread_proc("/proc/%d/syscall", thread_id);
+    observe_thread_proc("/proc/%d/stack", thread_id);
+    trace_observe_thread_end(msg);
+}
+
+#else
+static void observe_thread(const char *msg, pid_t thread_id)
+{
+}
+
+#endif /* DEBUG_FAULT_PROCESS_STATUS */
+
+static int get_mem_fault_cpu_index(pid_t pid)
 {
     CPUState *cpu_iter;
 
@@ -421,9 +505,20 @@ static int get_mem_fault_cpu_index(uint32_t pid)
            return cpu_iter->cpu_index;
     }
     trace_get_mem_fault_cpu_index(pid);
+    observe_thread("not a vCPU", pid);
+
     return -1;
 }
 
+static void observe_vcpu_state(void)
+{
+    CPUState *cpu_iter;
+    CPU_FOREACH(cpu_iter) {
+        observe_thread("vCPU", cpu_iter->thread_id);
+        trace_vcpu_state(cpu_iter->running, cpu_iter->cpu_index);
+    }
+}
+
 /*
  * Handle faults detected by the USERFAULT markings
  */
@@ -465,6 +560,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
         }
 
         ret = read(mis->userfault_fd, &msg, sizeof(msg));
+        observe_vcpu_state();
         if (ret != sizeof(msg)) {
             if (errno == EAGAIN) {
                 /*
diff --git a/migration/trace-events b/migration/trace-events
index ab2e1e4..3a74f91 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -202,6 +202,12 @@ save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
 ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
 get_mem_fault_cpu_index(uint32_t pid) "pid %u is not vCPU"
+observe_thread_status(int ptid, char *name, char *status) "host_tid %d %s %s"
+vcpu_state(int cpu_index, int is_running) "cpu %d running %d"
+proc_line_cb(const char *str) "%s"
+get_proc_file(const char *str) "opened %s"
+observe_thread_begin(const char *str) "%s"
+observe_thread_end(const char *str) "%s"
 
 # migration/exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
1.8.3.1
