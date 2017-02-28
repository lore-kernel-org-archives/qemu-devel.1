Received: from eggs.gnu.org ([2001:4830:134:3::10]:43804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPl-0003I7-9S
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cilPi-0003hO-1e
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:17 -0500
Received: from clearmind.me ([178.32.49.9]:57881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cilPh-0003gM-Qj
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:18:13 -0500
From: Alessandro Di Federico <ale+qemu@clearmind.me>
Date: Tue, 28 Feb 2017 18:19:16 +0100
Message-Id: <20170228171921.21602-3-ale+qemu@clearmind.me>
In-Reply-To: <20170228171921.21602-1-ale+qemu@clearmind.me>
References: <20170228171921.21602-1-ale+qemu@clearmind.me>
Sender: ale@clearmind.me
Subject: [Qemu-devel] [PATCH 2/7] Factor out *-user/mmap.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This commit moves linux-user/mmap.c to the top level directory so that
it can be employed by bsd-user (when it will be back in a working shape)
and libtcg.
---
 Makefile.target             |  1 +
 include/qemu-user-common.h  | 17 +++++++++++++++++
 linux-user/Makefile.objs    |  2 +-
 linux-user/qemu.h           | 16 ----------------
 linux-user/mmap.c => mmap.c |  0
 5 files changed, 19 insertions(+), 17 deletions(-)
 rename linux-user/mmap.c => mmap.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 924304c9e6..cf8adc3ced 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -89,6 +89,7 @@ all: $(PROGS) stap
 #########################################################
 # cpu emulator library
 obj-y = exec.o translate-all.o cpu-exec.o
+obj-$(call land,$(CONFIG_USER_ONLY),$(call lnot,$(CONFIG_BSD_USER))) += mmap.o
 obj-y += translate-common.o
 obj-y += cpu-exec-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
diff --git a/include/qemu-user-common.h b/include/qemu-user-common.h
index 349dd72fff..e772f54c8f 100644
--- a/include/qemu-user-common.h
+++ b/include/qemu-user-common.h
@@ -177,4 +177,21 @@ static inline void *lock_user_string(abi_ulong guest_addr)
 #define unlock_user_struct(host_ptr, guest_addr, copy)		\
     unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
 
+/* mmap.c */
+extern unsigned long mmap_min_addr;
+
+int target_mprotect(abi_ulong start, abi_ulong len, int prot);
+abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
+                     int flags, int fd, abi_ulong offset);
+int target_munmap(abi_ulong start, abi_ulong len);
+abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
+                       abi_ulong new_size, unsigned long flags,
+                       abi_ulong new_addr);
+int target_msync(abi_ulong start, abi_ulong len, int flags);
+extern unsigned long last_brk;
+extern abi_ulong mmap_next_start;
+abi_ulong mmap_find_vma(abi_ulong, abi_ulong);
+void mmap_fork_start(void);
+void mmap_fork_end(int child);
+
 #endif /* QEMU_USER_COMMON_H */
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 8c93058100..1595f44d12 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y = main.o syscall.o strace.o mmap.o signal.o \
+obj-y = main.o syscall.o strace.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
 	safe-syscall.o
 
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 22b0ad7d30..5cfe68bd43 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -156,7 +156,6 @@ void init_task_state(TaskState *ts);
 void task_settid(TaskState *);
 void stop_all_tasks(void);
 extern const char *qemu_uname_release;
-extern unsigned long mmap_min_addr;
 
 /* ??? See if we can avoid exposing so much of the loader internals.  */
 
@@ -420,21 +419,6 @@ void sparc64_set_context(CPUSPARCState *env);
 void sparc64_get_context(CPUSPARCState *env);
 #endif
 
-/* mmap.c */
-int target_mprotect(abi_ulong start, abi_ulong len, int prot);
-abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
-                     int flags, int fd, abi_ulong offset);
-int target_munmap(abi_ulong start, abi_ulong len);
-abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
-                       abi_ulong new_size, unsigned long flags,
-                       abi_ulong new_addr);
-int target_msync(abi_ulong start, abi_ulong len, int flags);
-extern unsigned long last_brk;
-extern abi_ulong mmap_next_start;
-abi_ulong mmap_find_vma(abi_ulong, abi_ulong);
-void mmap_fork_start(void);
-void mmap_fork_end(int child);
-
 /* main.c */
 extern unsigned long guest_stack_size;
 
diff --git a/linux-user/mmap.c b/mmap.c
similarity index 100%
rename from linux-user/mmap.c
rename to mmap.c
-- 
2.11.1
