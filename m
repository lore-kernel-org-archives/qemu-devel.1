Received: from eggs.gnu.org ([2001:4830:134:3::10]:51214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZTRd-0007vI-Ke
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZTMK-0006MT-3h
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:21:28 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZTMH-0006Jj-T6
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 23:21:23 -0500
Received: by mail-pf1-x444.google.com with SMTP id c123so9213988pfb.0
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 20:21:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 18 Dec 2018 20:21:07 -0800
Message-Id: <20181219042113.7364-3-richard.henderson@linaro.org>
In-Reply-To: <20181219042113.7364-1-richard.henderson@linaro.org>
References: <20181219042113.7364-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 2/8] linux-user: Split out some simple file
 syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

This includes close, open, openat, read, readlink, readlinkat, write.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     |  31 +++
 linux-user/syscall-file.inc.c | 433 ++++++++++++++++++++++++++++++++++
 linux-user/syscall.c          | 376 +----------------------------
 3 files changed, 468 insertions(+), 372 deletions(-)
 create mode 100644 linux-user/syscall-defs.h
 create mode 100644 linux-user/syscall-file.inc.c

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
new file mode 100644
index 0000000000..b031de1375
--- /dev/null
+++ b/linux-user/syscall-defs.h
@@ -0,0 +1,31 @@
+/*
+ *  Linux syscall definitions
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
+
+SYSCALL_DEF(close, ARG_DEC);
+#ifdef TARGET_NR_open
+SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+#endif
+SYSCALL_DEF(openat, ARG_ATDIRFD, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
+SYSCALL_DEF(read, ARG_DEC, ARG_PTR, ARG_DEC);
+#ifdef TARGET_NR_readlink
+SYSCALL_DEF(readlink, ARG_STR, ARG_PTR, ARG_DEC);
+#endif
+#ifdef TARGET_NR_readlinkat
+SYSCALL_DEF(readlinkat, ARG_ATDIRFD, ARG_STR, ARG_PTR, ARG_DEC);
+#endif
+SYSCALL_DEF(write, ARG_DEC, ARG_PTR, ARG_DEC);
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
new file mode 100644
index 0000000000..11e75044c1
--- /dev/null
+++ b/linux-user/syscall-file.inc.c
@@ -0,0 +1,433 @@
+/*
+ *  Linux file-related syscall implementations
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
+        fields = sscanf(line, "%" PRIx64 "-%" PRIx64 " %c%c%c%c %"
+                        PRIx64" %x:%x %d %512s",
+                        &min, &max, &flag_r, &flag_w, &flag_x,
+                        &flag_p, &offset, &dev_maj, &dev_min, &inode, path);
+
+        if ((fields < 10) || (fields > 11)) {
+            continue;
+        }
+        if (h2g_valid(min)) {
+            int flags = page_get_flags(h2g(min));
+            if (!h2g_valid(max - 1)) {
+                max = (uintptr_t)g2h(GUEST_ADDR_MAX) + 1;
+            }
+            if (page_check_range(h2g(min), max - min, flags) == -1) {
+                continue;
+            }
+            if (h2g(min) == ts->info->stack_limit) {
+                pstrcpy(path, sizeof(path), "      [stack]");
+            }
+            dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
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
+static int is_proc_myself(const char *filename, const char *entry)
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
+    abi_long ret;
+    size_t i;
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
+            if (fakes[i].fill(cpu_env, ret)) {
+                close(ret);
+                ret = -TARGET_ENOENT;
+                goto done;
+            }
+
+            lseek(ret, 0, SEEK_SET);
+            goto done;
+        }
+    }
+
+    ret = get_errno(safe_openat(dirfd, path(pathname), flags, mode));
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
+
+#ifdef TARGET_NR_open
+SYSCALL_IMPL(open)
+{
+    return do_openat(cpu_env, AT_FDCWD, arg1, arg2, arg3);
+}
+#endif
+
+SYSCALL_IMPL(openat)
+{
+    return do_openat(cpu_env, arg1, arg2, arg3, arg4);
+}
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
+
+static abi_long do_readlink_proc_exe(char *buf, abi_ulong bufsiz)
+{
+    char real[PATH_MAX];
+    char *temp = realpath(exec_path, real);
+    abi_long ret;
+
+    /* Return value is # of bytes that we wrote to the buffer. */
+    if (temp == NULL) {
+        return -host_to_target_errno(errno);
+    }
+    ret = MIN(strlen(real), bufsiz);
+    /* We cannot NUL terminate the string. */
+    memcpy(buf, real, ret);
+    return ret;
+}
+
+#ifdef TARGET_NR_readlink
+SYSCALL_IMPL(readlink)
+{
+    char *p = lock_user_string(arg1);
+    abi_ulong bufsiz = arg3;
+    void *buf = lock_user(VERIFY_WRITE, arg2, bufsiz, 0);
+    abi_long ret;
+
+    if (!p || !buf) {
+        ret = -TARGET_EFAULT;
+    } else if (!bufsiz) {
+        /* Short circuit this for the magic exe check. */
+        ret = -TARGET_EINVAL;
+    } else if (is_proc_myself(p, "exe")) {
+        ret = do_readlink_proc_exe(buf, bufsiz);
+    } else {
+        ret = get_errno(readlink(path(p), buf, bufsiz));
+    }
+    unlock_user(buf, arg2, ret);
+    unlock_user(p, arg1, 0);
+    return ret;
+}
+#endif
+
+#ifdef TARGET_NR_readlinkat
+SYSCALL_IMPL(readlinkat)
+{
+    char *p = lock_user_string(arg2);
+    abi_ulong bufsiz = arg4;
+    void *buf = lock_user(VERIFY_WRITE, arg3, bufsiz, 0);
+    abi_long ret;
+
+    if (!p || !buf) {
+        ret = -TARGET_EFAULT;
+    } else if (!bufsiz) {
+        /* Short circuit this for the magic exe check. */
+        ret = -TARGET_EINVAL;
+    } else if (is_proc_myself(p, "exe")) {
+        ret = do_readlink_proc_exe(buf, bufsiz);
+    } else {
+        ret = get_errno(readlinkat(arg1, path(p), buf, bufsiz));
+    }
+    unlock_user(buf, arg3, ret);
+    unlock_user(p, arg2, 0);
+    return ret;
+}
+#endif
+
+SYSCALL_IMPL(write)
+{
+    TargetFdDataFunc trans;
+    abi_long ret;
+    void *p;
+
+    if (arg2 == 0 && arg3 == 0) {
+        return get_errno(safe_write(arg1, 0, 0));
+    }
+    p = lock_user(VERIFY_READ, arg2, arg3, 1);
+    if (!p) {
+        return -TARGET_EFAULT;
+    }
+    trans = fd_trans_target_to_host_data(arg1);
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
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5d388ffd62..7118f07441 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6538,267 +6538,6 @@ int host_to_target_waitstatus(int status)
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
-            dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
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
 
@@ -6948,60 +6687,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         preexit_cleanup(cpu_env, arg1);
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
-        if (arg2 == 0 && arg3 == 0) {
-            return get_errno(safe_write(arg1, 0, 0));
-        }
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
@@ -7013,10 +6698,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -8292,59 +7973,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
-#ifdef TARGET_NR_readlink
-    case TARGET_NR_readlink:
-        {
-            void *p2;
-            p = lock_user_string(arg1);
-            p2 = lock_user(VERIFY_WRITE, arg2, arg3, 0);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else if (!arg3) {
-                /* Short circuit this for the magic exe check. */
-                ret = -TARGET_EINVAL;
-            } else if (is_proc_myself((const char *)p, "exe")) {
-                char real[PATH_MAX], *temp;
-                temp = realpath(exec_path, real);
-                /* Return value is # of bytes that we wrote to the buffer. */
-                if (temp == NULL) {
-                    ret = get_errno(-1);
-                } else {
-                    /* Don't worry about sign mismatch as earlier mapping
-                     * logic would have thrown a bad address error. */
-                    ret = MIN(strlen(real), arg3);
-                    /* We cannot NUL terminate the string. */
-                    memcpy(p2, real, ret);
-                }
-            } else {
-                ret = get_errno(readlink(path(p), p2, arg3));
-            }
-            unlock_user(p2, arg2, ret);
-            unlock_user(p, arg1, 0);
-        }
-        return ret;
-#endif
-#if defined(TARGET_NR_readlinkat)
-    case TARGET_NR_readlinkat:
-        {
-            void *p2;
-            p  = lock_user_string(arg2);
-            p2 = lock_user(VERIFY_WRITE, arg3, arg4, 0);
-            if (!p || !p2) {
-                ret = -TARGET_EFAULT;
-            } else if (is_proc_myself((const char *)p, "exe")) {
-                char real[PATH_MAX], *temp;
-                temp = realpath(exec_path, real);
-                ret = temp == NULL ? get_errno(-1) : strlen(real) ;
-                snprintf((char *)p2, arg4, "%s", real);
-            } else {
-                ret = get_errno(readlinkat(arg1, path(p), p2, arg4));
-            }
-            unlock_user(p2, arg3, ret);
-            unlock_user(p, arg2, 0);
-        }
-        return ret;
-#endif
 #ifdef TARGET_NR_swapon
     case TARGET_NR_swapon:
         if (!(p = lock_user_string(arg1)))
@@ -11492,6 +11120,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                                 int64_t arg2, int64_t arg3, int64_t arg4, \
                                 int64_t arg5, int64_t arg6)
 
+#include "syscall-file.inc.c"
 
 #undef SYSCALL_IMPL
 #undef SYSCALL_ARGS
@@ -11521,6 +11150,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #define SYSCALL_DEF_FULL(NAME, ...) \
     static const SyscallDef def_##NAME = { .name = #NAME, __VA_ARGS__ }
 
+#include "syscall-defs.h"
+
 #undef SYSCALL_DEF
 #undef SYSCALL_DEF_ARGS
 #undef SYSCALL_DEF_FULL
@@ -11532,6 +11163,7 @@ static const SyscallDef *syscall_table(int num)
 #define SYSCALL_DEF_FULL(NAME, ...)  SYSCALL_DEF(NAME)
 
     switch (num) {
+#include "syscall-defs.h"
     }
     return NULL;
 
-- 
2.17.2
