Received: from eggs.gnu.org ([2001:4830:134:3::10]:38492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNi-00056K-O0
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fOWNh-0000lA-O2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:18 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fOWNh-0000ke-Hp
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:49:17 -0400
Received: by mail-pf0-x243.google.com with SMTP id e9-v6so11490070pfi.4
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 15:49:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 31 May 2018 15:49:07 -0700
Message-Id: <20180531224911.23725-3-richard.henderson@linaro.org>
In-Reply-To: <20180531224911.23725-1-richard.henderson@linaro.org>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/6] linux-user: Add host_fds and manipulators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org

This allows emulation of guest syscalls to reject
manipulations to fds used by the host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h | 30 ++++++++++++++++++++++++++++++
 linux-user/main.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index c55c8e294b..33dafbe0e4 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -155,6 +155,36 @@ void task_settid(TaskState *);
 void stop_all_tasks(void);
 extern const char *qemu_uname_release;
 extern unsigned long mmap_min_addr;
+extern fd_set host_fds;
+
+/**
+ * is_hostfd:
+ * @fd: file descriptor to check
+ *
+ * Return true if @fd is being used by the host and therefore any
+ * guest system call referencing @fd should return EBADF.
+ */
+static inline bool is_hostfd(int fd)
+{
+    return fd >= 0 && fd < FD_SETSIZE && FD_ISSET(fd, &host_fds);
+}
+
+/**
+ * contains_hostfd:
+ * @fds: fd_set of descriptors to check
+ *
+ * Return true if any descriptor in @fds are being used by the host
+ * and therefore the guest system call should return EBADF.
+ */
+bool contains_hostfd(const fd_set *fds);
+
+/**
+ * add_hostfd:
+ * @fd: file descriptor to reserve
+ *
+ * Add @fd to the set of file descriptors to reserve for the host.
+ */
+void add_hostfd(int fd);
 
 /* ??? See if we can avoid exposing so much of the loader internals.  */
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 78d6d3e7eb..ee3f323c08 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -49,6 +49,7 @@ static const char *cpu_type;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
 int have_guest_base;
+fd_set host_fds;
 
 /*
  * When running 32-on-64 we should make sure we can fit all of the possible
@@ -112,6 +113,23 @@ int cpu_get_pic_interrupt(CPUX86State *env)
 }
 #endif
 
+bool contains_hostfd(const fd_set *fds)
+{
+    int i;
+    for (i = 0; i < ARRAY_SIZE(__FDS_BITS(fds)); ++i) {
+        if (__FDS_BITS(fds)[i] & __FDS_BITS(&host_fds)[i]) {
+            return true;
+        }
+    }
+    return true;
+}
+
+void add_hostfd(int fd)
+{
+    g_assert(fd >= 0 && fd < FD_SETSIZE);
+    FD_SET(fd, &host_fds);
+}
+
 /***********************************************************/
 /* Helper routines for implementing atomic operations.  */
 
@@ -805,12 +823,19 @@ int main(int argc, char **argv, char **envp)
 
     target_cpu_copy_regs(env, regs);
 
+    /* Prevent the guest from closing the log file.  */
+    if (qemu_logfile && qemu_logfile != stderr) {
+        add_hostfd(fileno(qemu_logfile));
+    }
+
     if (gdbstub_port) {
-        if (gdbserver_start(gdbstub_port) < 0) {
+        int fd = gdbserver_start(gdbstub_port);
+        if (fd < 0) {
             fprintf(stderr, "qemu: could not open gdbserver on port %d\n",
                     gdbstub_port);
             exit(EXIT_FAILURE);
         }
+        add_hostfd(fd);
         gdb_handlesig(cpu, 0);
     }
     cpu_loop(env);
-- 
2.17.0
