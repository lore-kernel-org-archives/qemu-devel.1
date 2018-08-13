Received: from eggs.gnu.org ([2001:4830:134:3::10]:42880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fp1B0-0002tH-RA
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fp1Ay-0006Fb-N7
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:57:42 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:47828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1fp1Ay-0006FJ-CR
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:57:40 -0400
From: Julian Brown <julian@codesourcery.com>
Date: Sun, 12 Aug 2018 17:57:14 -0700
Message-ID: <5028fef82b1b2015d93a21a9ed28b35ec910394d.1534121196.git.julian@codesourcery.com>
In-Reply-To: <cover.1534121196.git.julian@codesourcery.com>
References: <cover.1534121196.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 2/2] Add Nios II semihosting support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrew Jenner <Andrew_Jenner@mentor.com>, Sandra Loosemore <sandra@codesourcery.com>, Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>

This patch (by Sandra Loosemore, mildly rebased) adds support for
semihosting for Nios II bare-metal emulation.

Signed-off-by: Julian Brown <julian@codesourcery.com>
Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
---
 qemu-options.hx            |   8 +-
 target/nios2/Makefile.objs |   2 +-
 target/nios2/cpu.h         |   4 +-
 target/nios2/helper.c      |  11 ++
 target/nios2/nios2-semi.c  | 446 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 465 insertions(+), 6 deletions(-)
 create mode 100644 target/nios2/nios2-semi.c

diff --git a/qemu-options.hx b/qemu-options.hx
index b1bf0f4..b4e9ea9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3821,21 +3821,21 @@ ETEXI
 DEF("semihosting", 0, QEMU_OPTION_semihosting,
     "-semihosting    semihosting mode\n",
     QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32 |
-    QEMU_ARCH_MIPS)
+    QEMU_ARCH_MIPS | QEMU_ARCH_NIOS2)
 STEXI
 @item -semihosting
 @findex -semihosting
-Enable semihosting mode (ARM, M68K, Xtensa, MIPS only).
+Enable semihosting mode (ARM, M68K, Xtensa, MIPS, Nios II only).
 ETEXI
 DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
     "-semihosting-config [enable=on|off][,target=native|gdb|auto][,arg=str[,...]]\n" \
     "                semihosting configuration\n",
 QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA | QEMU_ARCH_LM32 |
-QEMU_ARCH_MIPS)
+QEMU_ARCH_MIPS | QEMU_ARCH_NIOS2)
 STEXI
 @item -semihosting-config [enable=on|off][,target=native|gdb|auto][,arg=str[,...]]
 @findex -semihosting-config
-Enable and configure semihosting (ARM, M68K, Xtensa, MIPS only).
+Enable and configure semihosting (ARM, M68K, Xtensa, MIPS, Nios II only).
 @table @option
 @item target=@code{native|gdb|auto}
 Defines where the semihosting calls will be addressed, to QEMU (@code{native})
diff --git a/target/nios2/Makefile.objs b/target/nios2/Makefile.objs
index 2a11c5c..010de0e 100644
--- a/target/nios2/Makefile.objs
+++ b/target/nios2/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += translate.o op_helper.o helper.o cpu.o mmu.o
+obj-y += translate.o op_helper.o helper.o cpu.o mmu.o nios2-semi.o
 obj-$(CONFIG_SOFTMMU) += monitor.o
 
 $(obj)/op_helper.o: QEMU_CFLAGS += $(HELPER_CFLAGS)
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 047f376..afd30d5 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -141,7 +141,7 @@ typedef struct Nios2CPUClass {
 #define R_PC         64
 
 /* Exceptions */
-#define EXCP_BREAK    -1
+#define EXCP_BREAK    0x1000
 #define EXCP_RESET    0
 #define EXCP_PRESET   1
 #define EXCP_IRQ      2
@@ -223,6 +223,8 @@ void nios2_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 qemu_irq *nios2_cpu_pic_init(Nios2CPU *cpu);
 void nios2_check_interrupts(CPUNios2State *env);
 
+void do_nios2_semihosting(CPUNios2State *env);
+
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #ifdef CONFIG_USER_ONLY
 # define TARGET_VIRT_ADDR_SPACE_BITS 31
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index a8b8ec6..ca3b087 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -25,6 +25,7 @@
 #include "exec/exec-all.h"
 #include "exec/log.h"
 #include "exec/helper-proto.h"
+#include "exec/semihost.h"
 
 #if defined(CONFIG_USER_ONLY)
 
@@ -169,6 +170,16 @@ void nios2_cpu_do_interrupt(CPUState *cs)
         break;
 
     case EXCP_BREAK:
+        qemu_log_mask(CPU_LOG_INT, "BREAK exception at pc=%x\n",
+                      env->regs[R_PC]);
+
+        if (semihosting_enabled()) {
+            qemu_log_mask(CPU_LOG_INT, "Entering semihosting\n");
+            env->regs[R_PC] += 4;
+            do_nios2_semihosting(env);
+            break;
+        }
+
         if ((env->regs[CR_STATUS] & CR_STATUS_EH) == 0) {
             env->regs[CR_BSTATUS] = env->regs[CR_STATUS];
             env->regs[R_BA] = env->regs[R_PC] + 4;
diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
new file mode 100644
index 0000000..df6d6fd
--- /dev/null
+++ b/target/nios2/nios2-semi.c
@@ -0,0 +1,446 @@
+/*
+ *  Nios II Semihosting syscall interface.
+ *  This code is derived from m68k-semi.c.
+ *
+ *  Copyright (c) 2017 Mentor Graphics
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
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#if defined(CONFIG_USER_ONLY)
+#include "qemu.h"
+#else
+#include "qemu-common.h"
+#include "exec/gdbstub.h"
+#include "exec/softmmu-semi.h"
+#endif
+#include "qemu/log.h"
+#include "sysemu/sysemu.h"
+
+#define HOSTED_EXIT  0
+#define HOSTED_INIT_SIM 1
+#define HOSTED_OPEN 2
+#define HOSTED_CLOSE 3
+#define HOSTED_READ 4
+#define HOSTED_WRITE 5
+#define HOSTED_LSEEK 6
+#define HOSTED_RENAME 7
+#define HOSTED_UNLINK 8
+#define HOSTED_STAT 9
+#define HOSTED_FSTAT 10
+#define HOSTED_GETTIMEOFDAY 11
+#define HOSTED_ISATTY 12
+#define HOSTED_SYSTEM 13
+
+typedef uint32_t gdb_mode_t;
+typedef uint32_t gdb_time_t;
+
+struct nios2_gdb_stat {
+  uint32_t    gdb_st_dev;     /* device */
+  uint32_t    gdb_st_ino;     /* inode */
+  gdb_mode_t  gdb_st_mode;    /* protection */
+  uint32_t    gdb_st_nlink;   /* number of hard links */
+  uint32_t    gdb_st_uid;     /* user ID of owner */
+  uint32_t    gdb_st_gid;     /* group ID of owner */
+  uint32_t    gdb_st_rdev;    /* device type (if inode device) */
+  uint64_t    gdb_st_size;    /* total size, in bytes */
+  uint64_t    gdb_st_blksize; /* blocksize for filesystem I/O */
+  uint64_t    gdb_st_blocks;  /* number of blocks allocated */
+  gdb_time_t  gdb_st_atime;   /* time of last access */
+  gdb_time_t  gdb_st_mtime;   /* time of last modification */
+  gdb_time_t  gdb_st_ctime;   /* time of last change */
+} QEMU_PACKED;
+
+struct gdb_timeval {
+  gdb_time_t tv_sec;  /* second */
+  uint64_t tv_usec;   /* microsecond */
+} QEMU_PACKED;
+
+#define GDB_O_RDONLY   0x0
+#define GDB_O_WRONLY   0x1
+#define GDB_O_RDWR     0x2
+#define GDB_O_APPEND   0x8
+#define GDB_O_CREAT  0x200
+#define GDB_O_TRUNC  0x400
+#define GDB_O_EXCL   0x800
+
+static int translate_openflags(int flags)
+{
+    int hf;
+
+    if (flags & GDB_O_WRONLY) {
+        hf = O_WRONLY;
+    } else if (flags & GDB_O_RDWR) {
+        hf = O_RDWR;
+    } else {
+        hf = O_RDONLY;
+    }
+
+    if (flags & GDB_O_APPEND) {
+        hf |= O_APPEND;
+    }
+    if (flags & GDB_O_CREAT) {
+        hf |= O_CREAT;
+    }
+    if (flags & GDB_O_TRUNC) {
+        hf |= O_TRUNC;
+    }
+    if (flags & GDB_O_EXCL) {
+        hf |= O_EXCL;
+    }
+
+    return hf;
+}
+
+static void translate_stat(CPUNios2State *env, target_ulong addr,
+                           struct stat *s)
+{
+    struct nios2_gdb_stat *p;
+
+    p = lock_user(VERIFY_WRITE, addr, sizeof(struct nios2_gdb_stat), 0);
+
+    if (!p) {
+        /* FIXME - should this return an error code? */
+        return;
+    }
+    p->gdb_st_dev = cpu_to_be32(s->st_dev);
+    p->gdb_st_ino = cpu_to_be32(s->st_ino);
+    p->gdb_st_mode = cpu_to_be32(s->st_mode);
+    p->gdb_st_nlink = cpu_to_be32(s->st_nlink);
+    p->gdb_st_uid = cpu_to_be32(s->st_uid);
+    p->gdb_st_gid = cpu_to_be32(s->st_gid);
+    p->gdb_st_rdev = cpu_to_be32(s->st_rdev);
+    p->gdb_st_size = cpu_to_be64(s->st_size);
+#ifdef _WIN32
+    /* Windows stat is missing some fields.  */
+    p->gdb_st_blksize = 0;
+    p->gdb_st_blocks = 0;
+#else
+    p->gdb_st_blksize = cpu_to_be64(s->st_blksize);
+    p->gdb_st_blocks = cpu_to_be64(s->st_blocks);
+#endif
+    p->gdb_st_atime = cpu_to_be32(s->st_atime);
+    p->gdb_st_mtime = cpu_to_be32(s->st_mtime);
+    p->gdb_st_ctime = cpu_to_be32(s->st_ctime);
+    unlock_user(p, addr, sizeof(struct nios2_gdb_stat));
+}
+
+static void nios2_semi_return_u32(CPUNios2State *env, uint32_t ret,
+                                  uint32_t err)
+{
+    target_ulong args = env->regs[R_ARG1];
+    if (put_user_u32(ret, args) ||
+        put_user_u32(err, args + 4)) {
+        /* The nios2 semihosting ABI does not provide any way to report this
+         * error to the guest, so the best we can do is log it in qemu.
+         * It is always a guest error not to pass us a valid argument block.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR, "nios2-semihosting: return value "
+                      "discarded because argument block not writable\n");
+    }
+}
+
+static void nios2_semi_return_u64(CPUNios2State *env, uint64_t ret,
+                                  uint32_t err)
+{
+    target_ulong args = env->regs[R_ARG1];
+    if (put_user_u32(ret >> 32, args) ||
+        put_user_u32(ret, args + 4) ||
+        put_user_u32(err, args + 8)) {
+        /* No way to report this via nios2 semihosting ABI; just log it */
+        qemu_log_mask(LOG_GUEST_ERROR, "nios2-semihosting: return value "
+                      "discarded because argument block not writable\n");
+    }
+}
+
+static int nios2_semi_is_fseek;
+
+static void nios2_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
+{
+    Nios2CPU *cpu = NIOS2_CPU(cs);
+    CPUNios2State *env = &cpu->env;
+
+    if (nios2_semi_is_fseek) {
+        /* FIXME: We've already lost the high bits of the fseek
+           return value.  */
+        nios2_semi_return_u64(env, ret, err);
+        nios2_semi_is_fseek = 0;
+    } else {
+        nios2_semi_return_u32(env, ret, err);
+    }
+}
+
+/* Read the input value from the argument block; fail the semihosting
+ * call if the memory read fails.
+ */
+#define GET_ARG(n) do {                                 \
+    if (get_user_ual(arg ## n, args + (n) * 4)) {       \
+        result = -1;                                    \
+        errno = EFAULT;                                 \
+        goto failed;                                    \
+    }                                                   \
+} while (0)
+
+void do_nios2_semihosting(CPUNios2State *env)
+{
+    int nr;
+    uint32_t args;
+    target_ulong arg0, arg1, arg2, arg3;
+    void *p;
+    void *q;
+    uint32_t len;
+    uint32_t result;
+
+    nr = env->regs[R_ARG0];
+    args = env->regs[R_ARG1];
+    switch (nr) {
+    case HOSTED_EXIT:
+        gdb_exit(env, env->regs[R_ARG0]);
+        exit(env->regs[R_ARG0]);
+    case HOSTED_OPEN:
+        GET_ARG(0);
+        GET_ARG(1);
+        GET_ARG(2);
+        GET_ARG(3);
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(nios2_semi_cb, "open,%s,%x,%x", arg0, (int)arg1,
+                           arg2, arg3);
+            return;
+        } else {
+            p = lock_user_string(arg0);
+            if (!p) {
+                /* FIXME - check error code? */
+                result = -1;
+            } else {
+                result = open(p, translate_openflags(arg2), arg3);
+                unlock_user(p, arg0, 0);
+            }
+        }
+        break;
+    case HOSTED_CLOSE:
+        {
+            /* Ignore attempts to close stdin/out/err.  */
+            GET_ARG(0);
+            int fd = arg0;
+            if (fd > 2) {
+                if (use_gdb_syscalls()) {
+                    gdb_do_syscall(nios2_semi_cb, "close,%x", arg0);
+                    return;
+                } else {
+                    result = close(fd);
+                }
+            } else {
+                result = 0;
+            }
+            break;
+        }
+    case HOSTED_READ:
+        GET_ARG(0);
+        GET_ARG(1);
+        GET_ARG(2);
+        len = arg2;
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(nios2_semi_cb, "read,%x,%x,%x",
+                           arg0, arg1, len);
+            return;
+        } else {
+            p = lock_user(VERIFY_WRITE, arg1, len, 0);
+            if (!p) {
+                /* FIXME - check error code? */
+                result = -1;
+            } else {
+                result = read(arg0, p, len);
+                unlock_user(p, arg1, len);
+            }
+        }
+        break;
+    case HOSTED_WRITE:
+        GET_ARG(0);
+        GET_ARG(1);
+        GET_ARG(2);
+        len = arg2;
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(nios2_semi_cb, "write,%x,%x,%x",
+                           arg0, arg1, len);
+            return;
+        } else {
+            p = lock_user(VERIFY_READ, arg1, len, 1);
+            if (!p) {
+                /* FIXME - check error code? */
+                result = -1;
+            } else {
+                result = write(arg0, p, len);
+                unlock_user(p, arg0, 0);
+            }
+        }
+        break;
+    case HOSTED_LSEEK:
+        {
+            uint64_t off;
+            GET_ARG(0);
+            GET_ARG(1);
+            GET_ARG(2);
+            GET_ARG(3);
+            off = (uint32_t)arg2 | ((uint64_t)arg1 << 32);
+            if (use_gdb_syscalls()) {
+                nios2_semi_is_fseek = 1;
+                gdb_do_syscall(nios2_semi_cb, "fseek,%x,%lx,%x",
+                               arg0, off, arg3);
+            } else {
+                off = lseek(arg0, off, arg3);
+                nios2_semi_return_u64(env, off, errno);
+            }
+            return;
+        }
+    case HOSTED_RENAME:
+        GET_ARG(0);
+        GET_ARG(1);
+        GET_ARG(2);
+        GET_ARG(3);
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(nios2_semi_cb, "rename,%s,%s",
+                           arg0, (int)arg1, arg2, (int)arg3);
+            return;
+        } else {
+            p = lock_user_string(arg0);
+            q = lock_user_string(arg2);
+            if (!p || !q) {
+                /* FIXME - check error code? */
+                result = -1;
+            } else {
+                result = rename(p, q);
+            }
+            unlock_user(p, arg0, 0);
+            unlock_user(q, arg2, 0);
+        }
+        break;
+    case HOSTED_UNLINK:
+        GET_ARG(0);
+        GET_ARG(1);
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(nios2_semi_cb, "unlink,%s",
+                           arg0, (int)arg1);
+            return;
+        } else {
+            p = lock_user_string(arg0);
+            if (!p) {
+                /* FIXME - check error code? */
+                result = -1;
+            } else {
+                result = unlink(p);
+                unlock_user(p, arg0, 0);
+            }
+        }
+        break;
+    case HOSTED_STAT:
+        GET_ARG(0);
+        GET_ARG(1);
+        GET_ARG(2);
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(nios2_semi_cb, "stat,%s,%x",
+                           arg0, (int)arg1, arg2);
+            return;
+        } else {
+            struct stat s;
+            p = lock_user_string(arg0);
+            if (!p) {
+                /* FIXME - check error code? */
+                result = -1;
+            } else {
+                result = stat(p, &s);
+                unlock_user(p, arg0, 0);
+            }
+            if (result == 0) {
+                translate_stat(env, arg2, &s);
+            }
+        }
+        break;
+    case HOSTED_FSTAT:
+        GET_ARG(0);
+        GET_ARG(1);
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(nios2_semi_cb, "fstat,%x,%x",
+                           arg0, arg1);
+            return;
+        } else {
+            struct stat s;
+            result = fstat(arg0, &s);
+            if (result == 0) {
+                translate_stat(env, arg1, &s);
+            }
+        }
+        break;
+    case HOSTED_GETTIMEOFDAY:
+        GET_ARG(0);
+        GET_ARG(1);
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(nios2_semi_cb, "gettimeofday,%x,%x",
+                           arg0, arg1);
+            return;
+        } else {
+            qemu_timeval tv;
+            struct gdb_timeval *p;
+            result = qemu_gettimeofday(&tv);
+            if (result != 0) {
+                p = lock_user(VERIFY_WRITE, arg0, sizeof(struct gdb_timeval),
+                              0);
+                if (!p) {
+                    /* FIXME - check error code? */
+                    result = -1;
+                } else {
+                    p->tv_sec = cpu_to_be32(tv.tv_sec);
+                    p->tv_usec = cpu_to_be64(tv.tv_usec);
+                    unlock_user(p, arg0, sizeof(struct gdb_timeval));
+                }
+            }
+        }
+        break;
+    case HOSTED_ISATTY:
+        GET_ARG(0);
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(nios2_semi_cb, "isatty,%x", arg0);
+            return;
+        } else {
+            result = isatty(arg0);
+        }
+        break;
+    case HOSTED_SYSTEM:
+        GET_ARG(0);
+        GET_ARG(1);
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(nios2_semi_cb, "system,%s",
+                           arg0, (int)arg1);
+            return;
+        } else {
+            p = lock_user_string(arg0);
+            if (!p) {
+                /* FIXME - check error code? */
+                result = -1;
+            } else {
+                result = system(p);
+                unlock_user(p, arg0, 0);
+            }
+        }
+        break;
+    default:
+        cpu_abort(CPU(nios2_env_get_cpu(env)),
+                  "Unsupported semihosting syscall %d\n", nr);
+        result = 0;
+    }
+failed:
+    nios2_semi_return_u32(env, result, errno);
+}
-- 
2.8.1
