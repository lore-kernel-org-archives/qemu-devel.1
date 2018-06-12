Received: from eggs.gnu.org ([2001:4830:134:3::10]:59374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXu-0005KU-77
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSXXq-0007eT-Ss
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:26 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:39987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSXXq-0007dm-Gv
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:52:22 -0400
Received: by mail-pg0-x244.google.com with SMTP id l2-v6so10582471pgc.7
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:52:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Jun 2018 14:51:39 -1000
Message-Id: <20180612005145.3375-14-richard.henderson@linaro.org>
In-Reply-To: <20180612005145.3375-1-richard.henderson@linaro.org>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 13/19] linux-user: Split out close, open,
 openat, read, write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.h           |  51 ++++
 linux-user/strace.c            |  35 ---
 linux-user/syscall.c           | 402 +------------------------------
 linux-user/syscall_file.c      | 423 +++++++++++++++++++++++++++++++++
 linux-user/Makefile.objs       |   3 +-
 linux-user/gen_syscall_list.py |   5 +
 linux-user/strace.list         |  15 --
 7 files changed, 484 insertions(+), 450 deletions(-)
 create mode 100644 linux-user/syscall_file.c

diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 7eb078c3e5..e35b0a60f5 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -125,6 +125,57 @@ static inline int is_error(abi_ulong ret)
     return ret >= -4096;
 }
 
+typedef abi_long (*TargetFdDataFunc)(void *, size_t);
+typedef abi_long (*TargetFdAddrFunc)(void *, abi_ulong, socklen_t);
+typedef struct TargetFdTrans {
+    TargetFdDataFunc host_to_target_data;
+    TargetFdDataFunc target_to_host_data;
+    TargetFdAddrFunc target_to_host_addr;
+} TargetFdTrans;
+
+extern TargetFdTrans **target_fd_trans;
+extern unsigned int target_fd_max;
+
+static inline TargetFdDataFunc fd_trans_target_to_host_data(int fd)
+{
+    if (fd >= 0 && fd < target_fd_max && target_fd_trans[fd]) {
+        return target_fd_trans[fd]->target_to_host_data;
+    }
+    return NULL;
+}
+
+static inline TargetFdDataFunc fd_trans_host_to_target_data(int fd)
+{
+    if (fd >= 0 && fd < target_fd_max && target_fd_trans[fd]) {
+        return target_fd_trans[fd]->host_to_target_data;
+    }
+    return NULL;
+}
+
+static inline TargetFdAddrFunc fd_trans_target_to_host_addr(int fd)
+{
+    if (fd >= 0 && fd < target_fd_max && target_fd_trans[fd]) {
+        return target_fd_trans[fd]->target_to_host_addr;
+    }
+    return NULL;
+}
+
+void fd_trans_register(int fd, TargetFdTrans *trans);
+
+static inline void fd_trans_unregister(int fd)
+{
+    if (fd >= 0 && fd < target_fd_max) {
+        target_fd_trans[fd] = NULL;
+    }
+}
+
+/* Temporary declarations from syscall_foo.c back to main syscall.c.
+ * These indicate incomplete conversion.
+ */
+
+int is_proc_myself(const char *filename, const char *entry);
+extern bitmask_transtbl const fcntl_flags_tbl[];
+
 /* Declarators for interruptable system calls.  */
 
 #define safe_syscall0(type, name) \
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 6375feb747..1ae0057365 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -2213,41 +2213,6 @@ print_mq_open(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_open
-static void
-print_open(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    int is_creat = (arg1 & TARGET_O_CREAT);
-
-    print_syscall_prologue(name);
-    print_string(arg0, 0);
-    print_open_flags(arg1, (is_creat == 0));
-    if (is_creat)
-        print_file_mode(arg2, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
-#ifdef TARGET_NR_openat
-static void
-print_openat(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    int is_creat = (arg2 & TARGET_O_CREAT);
-
-    print_syscall_prologue(name);
-    print_at_dirfd(arg0, 0);
-    print_string(arg1, 0);
-    print_open_flags(arg2, (is_creat == 0));
-    if (is_creat)
-        print_file_mode(arg3, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_mq_unlink
 static void
 print_mq_unlink(const struct syscallname *name,
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a96bbf9093..c47e73de5f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -325,42 +325,6 @@ _syscall5(int, kcmp, pid_t, pid1, pid_t, pid2, int, type,
           unsigned long, idx1, unsigned long, idx2)
 #endif
 
-static bitmask_transtbl fcntl_flags_tbl[] = {
-  { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
-  { TARGET_O_ACCMODE,   TARGET_O_RDWR,      O_ACCMODE,   O_RDWR,      },
-  { TARGET_O_CREAT,     TARGET_O_CREAT,     O_CREAT,     O_CREAT,     },
-  { TARGET_O_EXCL,      TARGET_O_EXCL,      O_EXCL,      O_EXCL,      },
-  { TARGET_O_NOCTTY,    TARGET_O_NOCTTY,    O_NOCTTY,    O_NOCTTY,    },
-  { TARGET_O_TRUNC,     TARGET_O_TRUNC,     O_TRUNC,     O_TRUNC,     },
-  { TARGET_O_APPEND,    TARGET_O_APPEND,    O_APPEND,    O_APPEND,    },
-  { TARGET_O_NONBLOCK,  TARGET_O_NONBLOCK,  O_NONBLOCK,  O_NONBLOCK,  },
-  { TARGET_O_SYNC,      TARGET_O_DSYNC,     O_SYNC,      O_DSYNC,     },
-  { TARGET_O_SYNC,      TARGET_O_SYNC,      O_SYNC,      O_SYNC,      },
-  { TARGET_FASYNC,      TARGET_FASYNC,      FASYNC,      FASYNC,      },
-  { TARGET_O_DIRECTORY, TARGET_O_DIRECTORY, O_DIRECTORY, O_DIRECTORY, },
-  { TARGET_O_NOFOLLOW,  TARGET_O_NOFOLLOW,  O_NOFOLLOW,  O_NOFOLLOW,  },
-#if defined(O_DIRECT)
-  { TARGET_O_DIRECT,    TARGET_O_DIRECT,    O_DIRECT,    O_DIRECT,    },
-#endif
-#if defined(O_NOATIME)
-  { TARGET_O_NOATIME,   TARGET_O_NOATIME,   O_NOATIME,   O_NOATIME    },
-#endif
-#if defined(O_CLOEXEC)
-  { TARGET_O_CLOEXEC,   TARGET_O_CLOEXEC,   O_CLOEXEC,   O_CLOEXEC    },
-#endif
-#if defined(O_PATH)
-  { TARGET_O_PATH,      TARGET_O_PATH,      O_PATH,      O_PATH       },
-#endif
-#if defined(O_TMPFILE)
-  { TARGET_O_TMPFILE,   TARGET_O_TMPFILE,   O_TMPFILE,   O_TMPFILE    },
-#endif
-  /* Don't terminate the list prematurely on 64-bit host+guest.  */
-#if TARGET_O_LARGEFILE != 0 || O_LARGEFILE != 0
-  { TARGET_O_LARGEFILE, TARGET_O_LARGEFILE, O_LARGEFILE, O_LARGEFILE, },
-#endif
-  { 0, 0, 0, 0 }
-};
-
 enum {
     QEMU_IFLA_BR_UNSPEC,
     QEMU_IFLA_BR_FORWARD_DELAY,
@@ -539,43 +503,10 @@ enum {
     QEMU___IFLA_XDP_MAX,
 };
 
-typedef abi_long (*TargetFdDataFunc)(void *, size_t);
-typedef abi_long (*TargetFdAddrFunc)(void *, abi_ulong, socklen_t);
-typedef struct TargetFdTrans {
-    TargetFdDataFunc host_to_target_data;
-    TargetFdDataFunc target_to_host_data;
-    TargetFdAddrFunc target_to_host_addr;
-} TargetFdTrans;
+TargetFdTrans **target_fd_trans;
+unsigned int target_fd_max;
 
-static TargetFdTrans **target_fd_trans;
-
-static unsigned int target_fd_max;
-
-static TargetFdDataFunc fd_trans_target_to_host_data(int fd)
-{
-    if (fd >= 0 && fd < target_fd_max && target_fd_trans[fd]) {
-        return target_fd_trans[fd]->target_to_host_data;
-    }
-    return NULL;
-}
-
-static TargetFdDataFunc fd_trans_host_to_target_data(int fd)
-{
-    if (fd >= 0 && fd < target_fd_max && target_fd_trans[fd]) {
-        return target_fd_trans[fd]->host_to_target_data;
-    }
-    return NULL;
-}
-
-static TargetFdAddrFunc fd_trans_target_to_host_addr(int fd)
-{
-    if (fd >= 0 && fd < target_fd_max && target_fd_trans[fd]) {
-        return target_fd_trans[fd]->target_to_host_addr;
-    }
-    return NULL;
-}
-
-static void fd_trans_register(int fd, TargetFdTrans *trans)
+void fd_trans_register(int fd, TargetFdTrans *trans)
 {
     unsigned int oldmax;
 
@@ -590,13 +521,6 @@ static void fd_trans_register(int fd, TargetFdTrans *trans)
     target_fd_trans[fd] = trans;
 }
 
-static void fd_trans_unregister(int fd)
-{
-    if (fd >= 0 && fd < target_fd_max) {
-        target_fd_trans[fd] = NULL;
-    }
-}
-
 static void fd_trans_dup(int oldfd, int newfd)
 {
     fd_trans_unregister(newfd);
@@ -913,10 +837,6 @@ const char *target_strerror(int err)
     return strerror(target_to_host_errno(err));
 }
 
-safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
-safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
-safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
-              int, flags, mode_t, mode)
 safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
 safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
@@ -7490,267 +7410,6 @@ int host_to_target_waitstatus(int status)
     return status;
 }
 
-static int open_self_cmdline(void *cpu_env, int fd)
-{
-    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
-    struct linux_binprm *bprm = ((TaskState *)cpu->opaque)->bprm;
-    int i;
-
-    for (i = 0; i < bprm->argc; i++) {
-        size_t len = strlen(bprm->argv[i]) + 1;
-
-        if (write(fd, bprm->argv[i], len) != len) {
-            return -1;
-        }
-    }
-
-    return 0;
-}
-
-static int open_self_maps(void *cpu_env, int fd)
-{
-    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
-    TaskState *ts = cpu->opaque;
-    FILE *fp;
-    char *line = NULL;
-    size_t len = 0;
-    ssize_t read;
-
-    fp = fopen("/proc/self/maps", "r");
-    if (fp == NULL) {
-        return -1;
-    }
-
-    while ((read = getline(&line, &len, fp)) != -1) {
-        int fields, dev_maj, dev_min, inode;
-        uint64_t min, max, offset;
-        char flag_r, flag_w, flag_x, flag_p;
-        char path[512] = "";
-        fields = sscanf(line, "%"PRIx64"-%"PRIx64" %c%c%c%c %"PRIx64" %x:%x %d"
-                        " %512s", &min, &max, &flag_r, &flag_w, &flag_x,
-                        &flag_p, &offset, &dev_maj, &dev_min, &inode, path);
-
-        if ((fields < 10) || (fields > 11)) {
-            continue;
-        }
-        if (h2g_valid(min)) {
-            int flags = page_get_flags(h2g(min));
-            max = h2g_valid(max - 1) ? max : (uintptr_t)g2h(GUEST_ADDR_MAX) + 1;
-            if (page_check_range(h2g(min), max - min, flags) == -1) {
-                continue;
-            }
-            if (h2g(min) == ts->info->stack_limit) {
-                pstrcpy(path, sizeof(path), "      [stack]");
-            }
-            dprintf(fd, TARGET_ABI_FMT_lx "-" TARGET_ABI_FMT_lx
-                    " %c%c%c%c %08" PRIx64 " %02x:%02x %d %s%s\n",
-                    h2g(min), h2g(max - 1) + 1, flag_r, flag_w,
-                    flag_x, flag_p, offset, dev_maj, dev_min, inode,
-                    path[0] ? "         " : "", path);
-        }
-    }
-
-    free(line);
-    fclose(fp);
-
-    return 0;
-}
-
-static int open_self_stat(void *cpu_env, int fd)
-{
-    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
-    TaskState *ts = cpu->opaque;
-    abi_ulong start_stack = ts->info->start_stack;
-    int i;
-
-    for (i = 0; i < 44; i++) {
-      char buf[128];
-      int len;
-      uint64_t val = 0;
-
-      if (i == 0) {
-        /* pid */
-        val = getpid();
-        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
-      } else if (i == 1) {
-        /* app name */
-        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
-      } else if (i == 27) {
-        /* stack bottom */
-        val = start_stack;
-        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
-      } else {
-        /* for the rest, there is MasterCard */
-        snprintf(buf, sizeof(buf), "0%c", i == 43 ? '\n' : ' ');
-      }
-
-      len = strlen(buf);
-      if (write(fd, buf, len) != len) {
-          return -1;
-      }
-    }
-
-    return 0;
-}
-
-static int open_self_auxv(void *cpu_env, int fd)
-{
-    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
-    TaskState *ts = cpu->opaque;
-    abi_ulong auxv = ts->info->saved_auxv;
-    abi_ulong len = ts->info->auxv_len;
-    char *ptr;
-
-    /*
-     * Auxiliary vector is stored in target process stack.
-     * read in whole auxv vector and copy it to file
-     */
-    ptr = lock_user(VERIFY_READ, auxv, len, 0);
-    if (ptr != NULL) {
-        while (len > 0) {
-            ssize_t r;
-            r = write(fd, ptr, len);
-            if (r <= 0) {
-                break;
-            }
-            len -= r;
-            ptr += r;
-        }
-        lseek(fd, 0, SEEK_SET);
-        unlock_user(ptr, auxv, len);
-    }
-
-    return 0;
-}
-
-static int is_proc_myself(const char *filename, const char *entry)
-{
-    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
-        filename += strlen("/proc/");
-        if (!strncmp(filename, "self/", strlen("self/"))) {
-            filename += strlen("self/");
-        } else if (*filename >= '1' && *filename <= '9') {
-            char myself[80];
-            snprintf(myself, sizeof(myself), "%d/", getpid());
-            if (!strncmp(filename, myself, strlen(myself))) {
-                filename += strlen(myself);
-            } else {
-                return 0;
-            }
-        } else {
-            return 0;
-        }
-        if (!strcmp(filename, entry)) {
-            return 1;
-        }
-    }
-    return 0;
-}
-
-#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
-static int is_proc(const char *filename, const char *entry)
-{
-    return strcmp(filename, entry) == 0;
-}
-
-static int open_net_route(void *cpu_env, int fd)
-{
-    FILE *fp;
-    char *line = NULL;
-    size_t len = 0;
-    ssize_t read;
-
-    fp = fopen("/proc/net/route", "r");
-    if (fp == NULL) {
-        return -1;
-    }
-
-    /* read header */
-
-    read = getline(&line, &len, fp);
-    dprintf(fd, "%s", line);
-
-    /* read routes */
-
-    while ((read = getline(&line, &len, fp)) != -1) {
-        char iface[16];
-        uint32_t dest, gw, mask;
-        unsigned int flags, refcnt, use, metric, mtu, window, irtt;
-        sscanf(line, "%s\t%08x\t%08x\t%04x\t%d\t%d\t%d\t%08x\t%d\t%u\t%u\n",
-                     iface, &dest, &gw, &flags, &refcnt, &use, &metric,
-                     &mask, &mtu, &window, &irtt);
-        dprintf(fd, "%s\t%08x\t%08x\t%04x\t%d\t%d\t%d\t%08x\t%d\t%u\t%u\n",
-                iface, tswap32(dest), tswap32(gw), flags, refcnt, use,
-                metric, tswap32(mask), mtu, window, irtt);
-    }
-
-    free(line);
-    fclose(fp);
-
-    return 0;
-}
-#endif
-
-static int do_openat(void *cpu_env, int dirfd, const char *pathname, int flags, mode_t mode)
-{
-    struct fake_open {
-        const char *filename;
-        int (*fill)(void *cpu_env, int fd);
-        int (*cmp)(const char *s1, const char *s2);
-    };
-    const struct fake_open *fake_open;
-    static const struct fake_open fakes[] = {
-        { "maps", open_self_maps, is_proc_myself },
-        { "stat", open_self_stat, is_proc_myself },
-        { "auxv", open_self_auxv, is_proc_myself },
-        { "cmdline", open_self_cmdline, is_proc_myself },
-#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
-        { "/proc/net/route", open_net_route, is_proc },
-#endif
-        { NULL, NULL, NULL }
-    };
-
-    if (is_proc_myself(pathname, "exe")) {
-        int execfd = qemu_getauxval(AT_EXECFD);
-        return execfd ? execfd : safe_openat(dirfd, exec_path, flags, mode);
-    }
-
-    for (fake_open = fakes; fake_open->filename; fake_open++) {
-        if (fake_open->cmp(pathname, fake_open->filename)) {
-            break;
-        }
-    }
-
-    if (fake_open->filename) {
-        const char *tmpdir;
-        char filename[PATH_MAX];
-        int fd, r;
-
-        /* create temporary file to map stat to */
-        tmpdir = getenv("TMPDIR");
-        if (!tmpdir)
-            tmpdir = "/tmp";
-        snprintf(filename, sizeof(filename), "%s/qemu-open.XXXXXX", tmpdir);
-        fd = mkstemp(filename);
-        if (fd < 0) {
-            return fd;
-        }
-        unlink(filename);
-
-        if ((r = fake_open->fill(cpu_env, fd))) {
-            int e = errno;
-            close(fd);
-            errno = e;
-            return r;
-        }
-        lseek(fd, 0, SEEK_SET);
-
-        return fd;
-    }
-
-    return safe_openat(dirfd, path(pathname), flags, mode);
-}
-
 #define TIMER_MAGIC 0x0caf0000
 #define TIMER_MAGIC_MASK 0xffff0000
 
@@ -7945,57 +7604,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         gdb_exit(cpu_env, arg1);
         _exit(arg1);
         return 0; /* avoid warning */
-    case TARGET_NR_read:
-        if (arg3 == 0) {
-            return 0;
-        } else {
-            if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-                return -TARGET_EFAULT;
-            ret = get_errno(safe_read(arg1, p, arg3));
-            if (ret >= 0 &&
-                fd_trans_host_to_target_data(arg1)) {
-                ret = fd_trans_host_to_target_data(arg1)(p, ret);
-            }
-            unlock_user(p, arg2, ret);
-        }
-        return ret;
-    case TARGET_NR_write:
-        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-            return -TARGET_EFAULT;
-        if (fd_trans_target_to_host_data(arg1)) {
-            void *copy = g_malloc(arg3);
-            memcpy(copy, p, arg3);
-            ret = fd_trans_target_to_host_data(arg1)(copy, arg3);
-            if (ret >= 0) {
-                ret = get_errno(safe_write(arg1, copy, ret));
-            }
-            g_free(copy);
-        } else {
-            ret = get_errno(safe_write(arg1, p, arg3));
-        }
-        unlock_user(p, arg2, 0);
-        return ret;
-
-#ifdef TARGET_NR_open
-    case TARGET_NR_open:
-        if (!(p = lock_user_string(arg1)))
-            return -TARGET_EFAULT;
-        ret = get_errno(do_openat(cpu_env, AT_FDCWD, p,
-                                  target_to_host_bitmask(arg2, fcntl_flags_tbl),
-                                  arg3));
-        fd_trans_unregister(ret);
-        unlock_user(p, arg1, 0);
-        return ret;
-#endif
-    case TARGET_NR_openat:
-        if (!(p = lock_user_string(arg2)))
-            return -TARGET_EFAULT;
-        ret = get_errno(do_openat(cpu_env, arg1, p,
-                                  target_to_host_bitmask(arg3, fcntl_flags_tbl),
-                                  arg4));
-        fd_trans_unregister(ret);
-        unlock_user(p, arg2, 0);
-        return ret;
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
@@ -8007,10 +7615,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         fd_trans_unregister(ret);
         return ret;
 #endif
-    case TARGET_NR_close:
-        fd_trans_unregister(arg1);
-        return get_errno(close(arg1));
-
     case TARGET_NR_brk:
         return do_brk(arg1);
 #ifdef TARGET_NR_fork
diff --git a/linux-user/syscall_file.c b/linux-user/syscall_file.c
new file mode 100644
index 0000000000..d11128787f
--- /dev/null
+++ b/linux-user/syscall_file.c
@@ -0,0 +1,423 @@
+/*
+ *  Linux file-related syscalls
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/path.h"
+#include "qemu.h"
+#include "syscall.h"
+#include <elf.h>
+#include <linux/unistd.h>
+
+
+safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
+              int, flags, mode_t, mode)
+safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
+safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
+
+bitmask_transtbl const fcntl_flags_tbl[] = {
+  { TARGET_O_ACCMODE,   TARGET_O_WRONLY,    O_ACCMODE,   O_WRONLY,    },
+  { TARGET_O_ACCMODE,   TARGET_O_RDWR,      O_ACCMODE,   O_RDWR,      },
+  { TARGET_O_CREAT,     TARGET_O_CREAT,     O_CREAT,     O_CREAT,     },
+  { TARGET_O_EXCL,      TARGET_O_EXCL,      O_EXCL,      O_EXCL,      },
+  { TARGET_O_NOCTTY,    TARGET_O_NOCTTY,    O_NOCTTY,    O_NOCTTY,    },
+  { TARGET_O_TRUNC,     TARGET_O_TRUNC,     O_TRUNC,     O_TRUNC,     },
+  { TARGET_O_APPEND,    TARGET_O_APPEND,    O_APPEND,    O_APPEND,    },
+  { TARGET_O_NONBLOCK,  TARGET_O_NONBLOCK,  O_NONBLOCK,  O_NONBLOCK,  },
+  { TARGET_O_SYNC,      TARGET_O_DSYNC,     O_SYNC,      O_DSYNC,     },
+  { TARGET_O_SYNC,      TARGET_O_SYNC,      O_SYNC,      O_SYNC,      },
+  { TARGET_FASYNC,      TARGET_FASYNC,      FASYNC,      FASYNC,      },
+  { TARGET_O_DIRECTORY, TARGET_O_DIRECTORY, O_DIRECTORY, O_DIRECTORY, },
+  { TARGET_O_NOFOLLOW,  TARGET_O_NOFOLLOW,  O_NOFOLLOW,  O_NOFOLLOW,  },
+#if defined(O_DIRECT)
+  { TARGET_O_DIRECT,    TARGET_O_DIRECT,    O_DIRECT,    O_DIRECT,    },
+#endif
+#if defined(O_NOATIME)
+  { TARGET_O_NOATIME,   TARGET_O_NOATIME,   O_NOATIME,   O_NOATIME    },
+#endif
+#if defined(O_CLOEXEC)
+  { TARGET_O_CLOEXEC,   TARGET_O_CLOEXEC,   O_CLOEXEC,   O_CLOEXEC    },
+#endif
+#if defined(O_PATH)
+  { TARGET_O_PATH,      TARGET_O_PATH,      O_PATH,      O_PATH       },
+#endif
+#if defined(O_TMPFILE)
+  { TARGET_O_TMPFILE,   TARGET_O_TMPFILE,   O_TMPFILE,   O_TMPFILE    },
+#endif
+  /* Don't terminate the list prematurely on 64-bit host+guest.  */
+#if TARGET_O_LARGEFILE != 0 || O_LARGEFILE != 0
+  { TARGET_O_LARGEFILE, TARGET_O_LARGEFILE, O_LARGEFILE, O_LARGEFILE, },
+#endif
+  { 0, 0, 0, 0 }
+};
+
+
+/*
+ * Helpers for do_openat, manipulating /proc/self/foo.
+ */
+
+static int open_self_cmdline(void *cpu_env, int fd)
+{
+    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
+    struct linux_binprm *bprm = ((TaskState *)cpu->opaque)->bprm;
+    int i;
+
+    for (i = 0; i < bprm->argc; i++) {
+        size_t len = strlen(bprm->argv[i]) + 1;
+
+        if (write(fd, bprm->argv[i], len) != len) {
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+static int open_self_maps(void *cpu_env, int fd)
+{
+    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
+    TaskState *ts = cpu->opaque;
+    FILE *fp;
+    char *line = NULL;
+    size_t len = 0;
+    ssize_t read;
+
+    fp = fopen("/proc/self/maps", "r");
+    if (fp == NULL) {
+        return -1;
+    }
+
+    while ((read = getline(&line, &len, fp)) != -1) {
+        int fields, dev_maj, dev_min, inode;
+        uint64_t min, max, offset;
+        char flag_r, flag_w, flag_x, flag_p;
+        char path[512] = "";
+
+        fields = sscanf(line, "%"PRIx64"-%"PRIx64" %c%c%c%c %"
+                        PRIx64" %x:%x %d %512s",
+                        &min, &max, &flag_r, &flag_w, &flag_x,
+                        &flag_p, &offset, &dev_maj, &dev_min, &inode, path);
+
+        if ((fields < 10) || (fields > 11)) {
+            continue;
+        }
+        if (h2g_valid(min)) {
+            int flags = page_get_flags(h2g(min));
+
+            if (!h2g_valid(max - 1)) {
+                max = (uintptr_t)g2h(GUEST_ADDR_MAX) + 1;
+            }
+            if (page_check_range(h2g(min), max - min, flags) == -1) {
+                continue;
+            }
+            if (h2g(min) == ts->info->stack_limit) {
+                pstrcpy(path, sizeof(path), "      [stack]");
+            }
+            dprintf(fd, TARGET_ABI_FMT_lx "-" TARGET_ABI_FMT_lx
+                    " %c%c%c%c %08" PRIx64 " %02x:%02x %d %s%s\n",
+                    h2g(min), h2g(max - 1) + 1, flag_r, flag_w,
+                    flag_x, flag_p, offset, dev_maj, dev_min, inode,
+                    path[0] ? "         " : "", path);
+        }
+    }
+
+    free(line);
+    fclose(fp);
+
+    return 0;
+}
+
+static int open_self_stat(void *cpu_env, int fd)
+{
+    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
+    TaskState *ts = cpu->opaque;
+    abi_ulong start_stack = ts->info->start_stack;
+    int i;
+
+    for (i = 0; i < 44; i++) {
+        char buf[128];
+        int len;
+        uint64_t val = 0;
+
+        if (i == 0) {
+            /* pid */
+            val = getpid();
+            snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
+        } else if (i == 1) {
+            /* app name */
+            snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
+        } else if (i == 27) {
+            /* stack bottom */
+            val = start_stack;
+            snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
+        } else {
+            /* for the rest, there is MasterCard */
+            snprintf(buf, sizeof(buf), "0%c", i == 43 ? '\n' : ' ');
+        }
+
+        len = strlen(buf);
+        if (write(fd, buf, len) != len) {
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+static int open_self_auxv(void *cpu_env, int fd)
+{
+    CPUState *cpu = ENV_GET_CPU((CPUArchState *)cpu_env);
+    TaskState *ts = cpu->opaque;
+    abi_ulong auxv = ts->info->saved_auxv;
+    abi_ulong len = ts->info->auxv_len;
+    char *ptr;
+
+    /*
+     * Auxiliary vector is stored in target process stack.
+     * read in whole auxv vector and copy it to file
+     */
+    ptr = lock_user(VERIFY_READ, auxv, len, 0);
+    if (ptr != NULL) {
+        while (len > 0) {
+            ssize_t r;
+            r = write(fd, ptr, len);
+            if (r <= 0) {
+                break;
+            }
+            len -= r;
+            ptr += r;
+        }
+        lseek(fd, 0, SEEK_SET);
+        unlock_user(ptr, auxv, len);
+    }
+
+    return 0;
+}
+
+int is_proc_myself(const char *filename, const char *entry)
+{
+    if (!strncmp(filename, "/proc/", strlen("/proc/"))) {
+        filename += strlen("/proc/");
+        if (!strncmp(filename, "self/", strlen("self/"))) {
+            filename += strlen("self/");
+        } else if (*filename >= '1' && *filename <= '9') {
+            char myself[80];
+            snprintf(myself, sizeof(myself), "%d/", getpid());
+            if (!strncmp(filename, myself, strlen(myself))) {
+                filename += strlen(myself);
+            } else {
+                return 0;
+            }
+        } else {
+            return 0;
+        }
+        if (!strcmp(filename, entry)) {
+            return 1;
+        }
+    }
+    return 0;
+}
+
+#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
+static int is_proc(const char *filename, const char *entry)
+{
+    return strcmp(filename, entry) == 0;
+}
+
+static int open_net_route(void *cpu_env, int fd)
+{
+    FILE *fp;
+    char *line = NULL;
+    size_t len = 0;
+    ssize_t read;
+
+    fp = fopen("/proc/net/route", "r");
+    if (fp == NULL) {
+        return -1;
+    }
+
+    /* read header */
+
+    read = getline(&line, &len, fp);
+    dprintf(fd, "%s", line);
+
+    /* read routes */
+
+    while ((read = getline(&line, &len, fp)) != -1) {
+        char iface[16];
+        uint32_t dest, gw, mask;
+        unsigned int flags, refcnt, use, metric, mtu, window, irtt;
+        sscanf(line, "%s\t%08x\t%08x\t%04x\t%d\t%d\t%d\t%08x\t%d\t%u\t%u\n",
+               iface, &dest, &gw, &flags, &refcnt, &use, &metric,
+               &mask, &mtu, &window, &irtt);
+        dprintf(fd, "%s\t%08x\t%08x\t%04x\t%d\t%d\t%d\t%08x\t%d\t%u\t%u\n",
+                iface, tswap32(dest), tswap32(gw), flags, refcnt, use,
+                metric, tswap32(mask), mtu, window, irtt);
+    }
+
+    free(line);
+    fclose(fp);
+
+    return 0;
+}
+#endif
+
+static abi_long do_openat(void *cpu_env, int dirfd, abi_ulong target_path,
+                          int target_flags, int mode)
+{
+    struct fake_open {
+        const char *filename;
+        int (*fill)(void *cpu_env, int fd);
+        int (*cmp)(const char *s1, const char *s2);
+    };
+    static const struct fake_open fakes[] = {
+        { "maps", open_self_maps, is_proc_myself },
+        { "stat", open_self_stat, is_proc_myself },
+        { "auxv", open_self_auxv, is_proc_myself },
+        { "cmdline", open_self_cmdline, is_proc_myself },
+#if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
+        { "/proc/net/route", open_net_route, is_proc },
+#endif
+    };
+
+    char *pathname = lock_user_string(target_path);
+    int flags = target_to_host_bitmask(target_flags, fcntl_flags_tbl);
+    int i, ret;
+
+    if (!pathname) {
+        return -TARGET_EFAULT;
+    }
+
+    if (is_proc_myself(pathname, "exe")) {
+        ret = qemu_getauxval(AT_EXECFD);
+        if (ret == 0) {
+            ret = get_errno(safe_openat(dirfd, exec_path, flags, mode));
+        }
+        goto done;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(fakes); ++i) {
+        if (fakes[i].cmp(pathname, fakes[i].filename)) {
+            const char *tmpdir;
+            char filename[PATH_MAX];
+            int r;
+
+            /* Create temporary file.  */
+            tmpdir = getenv("TMPDIR");
+            if (!tmpdir) {
+                tmpdir = "/tmp";
+            }
+            snprintf(filename, sizeof(filename),
+                     "%s/qemu-open.XXXXXX", tmpdir);
+            ret = mkstemp(filename);
+            if (ret < 0) {
+                ret = -TARGET_ENOENT;
+                goto done;
+            }
+            unlink(filename);
+
+            /* Add contents to the temporary file.  */
+            r = fakes[i].fill(cpu_env, ret);
+            if (r) {
+                close(ret);
+                ret = -TARGET_ENOENT;
+                goto done;
+            }
+
+            /* Reset pointer to the beginning.  */
+            lseek(ret, 0, SEEK_SET);
+            goto done;
+        }
+    }
+    ret = get_errno(safe_openat(dirfd, path(pathname), flags, mode));
+
+ done:
+    fd_trans_unregister(ret);
+    unlock_user(pathname, target_path, 0);
+    return ret;
+}
+
+SYSCALL_IMPL(close)
+{
+    fd_trans_unregister(arg1);
+    return get_errno(close(arg1));
+}
+SYSCALL_DEF(close, ARG_DEC);
+
+#ifdef TARGET_NR_open
+SYSCALL_IMPL(open)
+{
+    return do_openat(cpu_env, AT_FDCWD, arg1, arg2, arg3);
+}
+SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+#endif
+
+SYSCALL_IMPL(openat)
+{
+    return do_openat(cpu_env, arg1, arg2, arg3, arg4);
+}
+SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+
+SYSCALL_IMPL(read)
+{
+    abi_long ret;
+    void *p;
+
+    if (arg3 == 0) {
+        return 0;
+    }
+    p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(safe_read(arg1, p, arg3));
+
+    if (!is_error(ret)) {
+        TargetFdDataFunc trans = fd_trans_host_to_target_data(arg1);
+        if (trans) {
+            ret = trans(p, ret);
+        }
+    }
+    unlock_user(p, arg2, ret);
+    return ret;
+}
+SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
+
+SYSCALL_IMPL(write)
+{
+    TargetFdDataFunc trans = fd_trans_target_to_host_data(arg1);
+    void *p = lock_user(VERIFY_READ, arg2, arg3, 1);
+    abi_long ret;
+
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    if (trans) {
+        void *copy = g_malloc(arg3);
+        memcpy(copy, p, arg3);
+        ret = trans(copy, arg3);
+        if (ret >= 0) {
+            ret = get_errno(safe_write(arg1, copy, ret));
+        }
+        g_free(copy);
+    } else {
+        ret = get_errno(safe_write(arg1, p, arg3));
+    }
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index afa69ed6d2..63b81f50e8 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y = main.o syscall.o strace.o mmap.o signal.o \
+obj-y = main.o syscall.o syscall_file.o strace.o mmap.o signal.o \
 	elfload.o linuxload.o uaccess.o uname.o \
 	safe-syscall.o $(TARGET_ABI_DIR)/signal.o \
         $(TARGET_ABI_DIR)/cpu_loop.o
@@ -16,4 +16,5 @@ $(SYSCALL_LIST): $(GEN_SYSCALL_LIST)
 	  $(PYTHON) $(GEN_SYSCALL_LIST) $@, "GEN", $(TARGET_DIR)$@)
 
 linux-user/syscall.o \
+linux-user/syscall_file.o \
 linux-user/strace.o: $(SYSCALL_LIST)
diff --git a/linux-user/gen_syscall_list.py b/linux-user/gen_syscall_list.py
index 2e0fc39100..3d223e3468 100644
--- a/linux-user/gen_syscall_list.py
+++ b/linux-user/gen_syscall_list.py
@@ -25,10 +25,15 @@ import sys
 # These syscalls are supported by all targets.
 # Avoiding ifdefs for these can diagnose typos in $cpu/syscall_nr.h
 unconditional_syscalls = [
+    "close",
+    "openat",
+    "read",
+    "write",
 ]
 
 # These syscalls are only supported by some target or abis.
 conditional_syscalls = [
+    "open",
 ]
 
 
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 2bc5ba04d4..baafa28370 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -97,9 +97,6 @@
 #ifdef TARGET_NR_clone
 { TARGET_NR_clone, "clone" , NULL, print_clone, NULL },
 #endif
-#ifdef TARGET_NR_close
-{ TARGET_NR_close, "close" , "%s(%d)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_connect
 { TARGET_NR_connect, "connect" , "%s(%d,%#x,%d)", NULL, NULL },
 #endif
@@ -677,12 +674,6 @@
 #ifdef TARGET_NR_olduname
 { TARGET_NR_olduname, "olduname" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_open
-{ TARGET_NR_open, "open" , NULL, print_open, NULL },
-#endif
-#ifdef TARGET_NR_openat
-{ TARGET_NR_openat, "openat" , NULL, print_openat, NULL },
-#endif
 #ifdef TARGET_NR_osf_adjtime
 { TARGET_NR_osf_adjtime, "osf_adjtime" , NULL, NULL, NULL },
 #endif
@@ -1076,9 +1067,6 @@
 #ifdef TARGET_NR_quotactl
 { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_read
-{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_readahead
 { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
 #endif
@@ -1626,9 +1614,6 @@
 #ifdef TARGET_NR_waitpid
 { TARGET_NR_waitpid, "waitpid" , "%s(%d,%p,%#x)", NULL, NULL },
 #endif
-#ifdef TARGET_NR_write
-{ TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_writev
 { TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
 #endif
-- 
2.17.1
