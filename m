Received: from eggs.gnu.org ([2001:4830:134:3::10]:56043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dbp5K-000234-5R
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 10:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dbp5G-0002fz-1v
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 10:20:46 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:50676 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dbp5F-0002eM-53
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 10:20:41 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 30 Jul 2017 17:20:25 +0300
Message-Id: <150142442493.12995.12114706097163240518.stgit@frigg.lan>
In-Reply-To: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
References: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 3/5] hypertrace: [*-user] Add QEMU-side
 proxy to "guest_hypertrace" event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

QEMU detects when the guest uses 'mmap' on hypertrace's control channel
file, and then uses 'mprotect' to detect accesses to it, which are used
to trigger tracing event "guest_hypertrace".

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 Makefile.objs            |    4=20
 bsd-user/main.c          |   17 ++
 bsd-user/mmap.c          |   15 ++
 bsd-user/qemu.h          |    3=20
 bsd-user/syscall.c       |   34 ++--
 hypertrace/Makefile.objs |   21 ++
 hypertrace/common.c      |   55 ++++++
 hypertrace/common.h      |   25 +++
 hypertrace/user.c        |  415 ++++++++++++++++++++++++++++++++++++++++=
++++++
 hypertrace/user.h        |   71 ++++++++
 include/qom/cpu.h        |    4=20
 linux-user/main.c        |   19 ++
 linux-user/mmap.c        |   16 ++
 linux-user/qemu.h        |    3=20
 linux-user/signal.c      |   12 +
 linux-user/syscall.c     |   31 ++-
 16 files changed, 719 insertions(+), 26 deletions(-)
 create mode 100644 hypertrace/Makefile.objs
 create mode 100644 hypertrace/common.c
 create mode 100644 hypertrace/common.h
 create mode 100644 hypertrace/user.c
 create mode 100644 hypertrace/user.h

diff --git a/Makefile.objs b/Makefile.objs
index ce9a60137b..57479fa738 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -98,6 +98,10 @@ util-obj-y +=3D  trace/
 target-obj-y +=3D trace/
=20
 ######################################################################
+# hypertrace
+target-obj-y +=3D hypertrace/
+
+######################################################################
 # guest agent
=20
 # FIXME: a few definitions from qapi-types.o/qapi-visit.o are needed
diff --git a/bsd-user/main.c b/bsd-user/main.c
index fa9c012c9f..50df757209 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -30,9 +30,12 @@
 #include "tcg.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
+#include "qemu/error-report.h"
 #include "exec/log.h"
 #include "trace/control.h"
 #include "glib-compat.h"
+#include "hypertrace/user.h"
+
=20
 int singlestep;
 unsigned long mmap_min_addr;
@@ -675,6 +678,8 @@ static void usage(void)
            "-strace           log system calls\n"
            "-trace            [[enable=3D]<pattern>][,events=3D<file>][,=
file=3D<file>]\n"
            "                  specify tracing options\n"
+           "-hypertrace       [[base=3D]<path>][,max-clients=3D<uint>]\n=
"
+           "                  specify hypertrace options\n"
            "\n"
            "Environment variables:\n"
            "QEMU_STRACE       Print system calls and arguments similar t=
o the\n"
@@ -735,6 +740,8 @@ int main(int argc, char **argv)
     envlist_t *envlist =3D NULL;
     char *trace_file =3D NULL;
     bsd_type =3D target_openbsd;
+    char *hypertrace_base =3D NULL;
+    unsigned int hypertrace_max_clients =3D 0;
=20
     if (argc <=3D 1)
         usage();
@@ -753,6 +760,7 @@ int main(int argc, char **argv)
     cpu_model =3D NULL;
=20
     qemu_add_opts(&qemu_trace_opts);
+    qemu_add_opts(&qemu_hypertrace_opts);
=20
     optind =3D 1;
     for (;;) {
@@ -840,6 +848,10 @@ int main(int argc, char **argv)
         } else if (!strcmp(r, "trace")) {
             g_free(trace_file);
             trace_file =3D trace_opt_parse(optarg);
+        } else if (!strcmp(r, "hypertrace")) {
+            g_free(hypertrace_base);
+            hypertrace_opt_parse(optarg, &hypertrace_base,
+                                 &hypertrace_max_clients);
         } else {
             usage();
         }
@@ -974,6 +986,11 @@ int main(int argc, char **argv)
     target_set_brk(info->brk);
     syscall_init();
     signal_init();
+    if (atexit(hypertrace_fini) !=3D 0) {
+        error_report("error: atexit: %s", strerror(errno));
+        abort();
+    }
+    hypertrace_init(hypertrace_base, hypertrace_max_clients);
=20
     /* Now that we've loaded the binary, GUEST_BASE is fixed.  Delay
        generating the prologue until now so that the prologue can take
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 7f2018ede0..6a549a3553 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -21,6 +21,7 @@
 #include "qemu.h"
 #include "qemu-common.h"
 #include "bsd-mman.h"
+#include "hypertrace/user.h"
=20
 //#define DEBUG_MMAP
=20
@@ -240,10 +241,17 @@ static abi_ulong mmap_find_vma(abi_ulong start, abi=
_ulong size)
     return addr;
 }
=20
-/* NOTE: all the constants are the HOST ones */
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, abi_ulong offset)
 {
+    return target_mmap_cpu(start, len, prot, flags, fd, offset, NULL);
+}
+
+/* NOTE: all the constants are the HOST ones */
+abi_long target_mmap_cpu(abi_ulong start, abi_ulong len, int prot,
+                         int flags, int fd, abi_ulong offset,
+                         CPUState *cpu)
+{
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host=
_len;
     unsigned long host_start;
=20
@@ -285,6 +293,10 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,=
 int prot,
         goto the_end;
     real_start =3D start & qemu_host_page_mask;
=20
+    if (!hypertrace_guest_mmap_check(fd, len, offset)) {
+        goto fail;
+    }
+
     if (!(flags & MAP_FIXED)) {
         abi_ulong mmap_start;
         void *p;
@@ -396,6 +408,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int prot,
         }
     }
  the_end1:
+    hypertrace_guest_mmap_apply(fd, g2h(start), cpu);
     page_set_flags(start, start + len, prot | PAGE_VALID);
  the_end:
 #ifdef DEBUG_MMAP
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 19b2b8fecb..55421e9d89 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -205,6 +205,9 @@ abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong=
 uoss_addr, abi_ulong sp);
 int target_mprotect(abi_ulong start, abi_ulong len, int prot);
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, abi_ulong offset);
+abi_long target_mmap_cpu(abi_ulong start, abi_ulong len, int prot,
+                         int flags, int fd, abi_ulong offset,
+                         CPUState *cpu);
 int target_munmap(abi_ulong start, abi_ulong len);
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 66492aaf5d..f88f21876c 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -26,6 +26,7 @@
=20
 #include "qemu.h"
 #include "qemu-common.h"
+#include "hypertrace/user.h"
=20
 //#define DEBUG
=20
@@ -332,6 +333,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        hypertrace_fini();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret =3D 0; /* avoid warning */
@@ -369,10 +371,12 @@ abi_long do_freebsd_syscall(void *cpu_env, int num,=
 abi_long arg1,
         unlock_user(p, arg1, 0);
         break;
     case TARGET_FREEBSD_NR_mmap:
-        ret =3D get_errno(target_mmap(arg1, arg2, arg3,
-                                    target_to_host_bitmask(arg4, mmap_fl=
ags_tbl),
-                                    arg5,
-                                    arg6));
+        ret =3D get_errno(target_mmap_cpu(
+                            arg1, arg2, arg3,
+                            target_to_host_bitmask(arg4, mmap_flags_tbl)=
,
+                            arg5,
+                            arg6,
+                            cpu));
         break;
     case TARGET_FREEBSD_NR_mprotect:
         ret =3D get_errno(target_mprotect(arg1, arg2, arg3));
@@ -430,6 +434,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, ab=
i_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        hypertrace_fini();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret =3D 0; /* avoid warning */
@@ -455,10 +460,12 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, =
abi_long arg1,
         unlock_user(p, arg1, 0);
         break;
     case TARGET_NETBSD_NR_mmap:
-        ret =3D get_errno(target_mmap(arg1, arg2, arg3,
-                                    target_to_host_bitmask(arg4, mmap_fl=
ags_tbl),
-                                    arg5,
-                                    arg6));
+        ret =3D get_errno(target_mmap_cpu(
+                            arg1, arg2, arg3,
+                            target_to_host_bitmask(arg4, mmap_flags_tbl)=
,
+                            arg5,
+                            arg6,
+                            cpu));
         break;
     case TARGET_NETBSD_NR_mprotect:
         ret =3D get_errno(target_mprotect(arg1, arg2, arg3));
@@ -505,6 +512,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        hypertrace_fini();
         /* XXX: should free thread stack and CPU env */
         _exit(arg1);
         ret =3D 0; /* avoid warning */
@@ -530,10 +538,12 @@ abi_long do_openbsd_syscall(void *cpu_env, int num,=
 abi_long arg1,
         unlock_user(p, arg1, 0);
         break;
     case TARGET_OPENBSD_NR_mmap:
-        ret =3D get_errno(target_mmap(arg1, arg2, arg3,
-                                    target_to_host_bitmask(arg4, mmap_fl=
ags_tbl),
-                                    arg5,
-                                    arg6));
+        ret =3D get_errno(target_mmap_cpu(
+                            arg1, arg2, arg3,
+                            target_to_host_bitmask(arg4, mmap_flags_tbl)=
,
+                            arg5,
+                            arg6,
+                            cpu));
         break;
     case TARGET_OPENBSD_NR_mprotect:
         ret =3D get_errno(target_mprotect(arg1, arg2, arg3));
diff --git a/hypertrace/Makefile.objs b/hypertrace/Makefile.objs
new file mode 100644
index 0000000000..177230fe1d
--- /dev/null
+++ b/hypertrace/Makefile.objs
@@ -0,0 +1,21 @@
+# -*- mode: makefile -*-
+
+target-obj-$(CONFIG_USER_ONLY) +=3D user.o
+target-obj-y +=3D common.o
+
+$(obj)/user.o: $(obj)/emit.c
+$(obj)/common.o: $(obj)/emit.c
+
+$(obj)/emit.c: $(obj)/emit.c-timestamp $(BUILD_DIR)/config-host.mak
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+$(obj)/emit.c-timestamp: $(BUILD_DIR)/config-host.mak
+	@echo "static void do_hypertrace_emit(CPUState *cpu, uint64_t arg1, uin=
t64_t *data)" >$@
+	@echo "{" >>$@
+	@echo -n "    trace_guest_hypertrace(cpu, arg1" >>$@
+ifneq ($(CONFIG_HYPERTRACE_ARGS),1)
+	for i in `seq $(shell expr $(CONFIG_HYPERTRACE_ARGS) - 1)`; do \
+	    echo -n ", data[$$i-1]" >>$@; \
+	done
+endif
+	@echo ");" >>$@
+	@echo "}" >>$@
diff --git a/hypertrace/common.c b/hypertrace/common.c
new file mode 100644
index 0000000000..dfa8e4e4c9
--- /dev/null
+++ b/hypertrace/common.c
@@ -0,0 +1,55 @@
+/*
+ * QEMU-side management of hypertrace in user-level emulation.
+ *
+ * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/cpu-all.h"
+#include "hypertrace/common.h"
+#include "hypertrace/trace.h"
+
+
+void hypertrace_init_config(struct hypertrace_config *config,
+                            unsigned int max_clients)
+{
+    config->max_clients =3D max_clients;
+    config->client_args =3D CONFIG_HYPERTRACE_ARGS;
+    config->client_data_size =3D config->client_args * sizeof(uint64_t);
+
+    /* Align for both, since they can be used on softmmu and user mode *=
/
+    int page_size =3D 1;
+    page_size =3D QEMU_ALIGN_UP(page_size, getpagesize());
+    page_size =3D QEMU_ALIGN_UP(page_size, TARGET_PAGE_SIZE);
+
+#if defined(CONFIG_USER_ONLY)
+    /* Twice the number of clients (*in pages*) for the double-fault pro=
tocol */
+    config->control_size =3D QEMU_ALIGN_UP(
+        config->max_clients * TARGET_PAGE_SIZE * 2, page_size);
+#else
+    config->control_size =3D QEMU_ALIGN_UP(
+        config->max_clients * sizeof(uint64_t), page_size);
+#endif
+    config->data_size =3D QEMU_ALIGN_UP(
+        config->max_clients * config->client_data_size, page_size);
+}
+
+
+#include "hypertrace/emit.c"
+
+void hypertrace_emit(CPUState *cpu, uint64_t arg1, uint64_t *data)
+{
+    int i;
+    /* swap event arguments to host endianness */
+    arg1 =3D tswap64(arg1);
+    for (i =3D 0; i < CONFIG_HYPERTRACE_ARGS - 1; i++) {
+        data[i] =3D tswap64(data[i]);
+    }
+
+    /* emit event */
+    do_hypertrace_emit(cpu, arg1, data);
+}
diff --git a/hypertrace/common.h b/hypertrace/common.h
new file mode 100644
index 0000000000..cd295bdf76
--- /dev/null
+++ b/hypertrace/common.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU-side management of hypertrace in user-level emulation.
+ *
+ * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <stdint.h>
+#include "qemu/typedefs.h"
+
+/* NOTE: Linux's kernel headers must be synced with this */
+struct hypertrace_config {
+    uint64_t max_clients;
+    uint64_t client_args;
+    uint64_t client_data_size;
+    uint64_t control_size;
+    uint64_t data_size;
+};
+
+void hypertrace_init_config(struct hypertrace_config *config,
+                            unsigned int max_clients);
+
+void hypertrace_emit(struct CPUState *cpu, uint64_t arg1, uint64_t *data=
);
diff --git a/hypertrace/user.c b/hypertrace/user.c
new file mode 100644
index 0000000000..7ff6749f7d
--- /dev/null
+++ b/hypertrace/user.c
@@ -0,0 +1,415 @@
+/*
+ * QEMU-side management of hypertrace in user-level emulation.
+ *
+ * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * Implementation details
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ * There are 3 channels, each a regular file in the host system, and mma=
p'ed by
+ * the guest application.
+ *
+ * - Configuration channel: Exposes configuration parameters. Mapped onc=
e and
+ *   directly readable.
+ *
+ * - Data channel: Lets guests write argument values. Each guest thread =
should
+ *   use a different offset to avoid concurrency problems. Mapped once a=
nd
+ *   directly accessible.
+ *
+ * - Control channel: Triggers the hypertrace event on a write, providin=
g the
+ *   first argument. Offset in the control channel sets the offset in th=
e data
+ *   channel. Mapped once per thread, using two pages to reliably detect
+ *   accesses and their written value through a SEGV handler.
+ */
+
+#include <assert.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/mman.h>
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+#include "hypertrace/common.h"
+#include "hypertrace/user.h"
+#include "qemu/config-file.h"
+#include "qemu/error-report.h"
+#include "trace.h"
+
+
+static struct hypertrace_config config;
+static char *config_path;
+static int config_fd =3D -1;
+static uint64_t *qemu_config;
+
+static char *data_path;
+static int data_fd =3D -1;
+static uint64_t *qemu_data;
+
+static char *control_path;
+static int control_fd =3D -1;
+static uint64_t *qemu_control;
+static struct stat control_fd_stat;
+
+
+QemuOptsList qemu_hypertrace_opts =3D {
+    .name =3D "hypertrace",
+    .implied_opt_name =3D "path",
+    .head =3D QTAILQ_HEAD_INITIALIZER(qemu_hypertrace_opts.head),
+    .desc =3D {
+        {
+            .name =3D "path",
+            .type =3D QEMU_OPT_STRING,
+        },
+        {
+            .name =3D "max-clients",
+            .type =3D QEMU_OPT_NUMBER,
+            .def_value_str =3D "1",
+        },
+        { /* end of list */ }
+    },
+};
+
+void hypertrace_opt_parse(const char *optarg, char **base,
+                          unsigned int *max_clients_)
+{
+    int max_clients;
+    QemuOpts *opts =3D qemu_opts_parse_noisily(qemu_find_opts("hypertrac=
e"),
+                                             optarg, true);
+    if (!opts) {
+        exit(1);
+    }
+    if (qemu_opt_get(opts, "path")) {
+        *base =3D g_strdup(qemu_opt_get(opts, "path"));
+    } else {
+        error_report("error: -hypertrace path is mandatory");
+        exit(EXIT_FAILURE);
+    }
+    max_clients =3D qemu_opt_get_number(opts, "max-clients", 1);
+    if (max_clients <=3D 0) {
+        error_report("error:"
+                     " -hypertrace max-clients expects a positive number=
");
+        exit(EXIT_FAILURE);
+    }
+    *max_clients_ =3D max_clients;
+}
+
+static void init_channel(const char *base, const char *suffix, size_t si=
ze,
+                         char **path, int *fd, uint64_t **addr)
+{
+    *path =3D g_malloc(strlen(base) + strlen(suffix) + 1);
+    sprintf(*path, "%s%s", base, suffix);
+
+    *fd =3D open(*path, O_CREAT | O_EXCL | O_RDWR, S_IRUSR | S_IWUSR);
+    if (*fd =3D=3D -1) {
+        error_report("error: open(%s): %s", *path, strerror(errno));
+        exit(1);
+    }
+
+    off_t lres =3D lseek(*fd, size - 1, SEEK_SET);
+    if (lres =3D=3D (off_t)-1) {
+        error_report("error: lseek(%s): %s", *path, strerror(errno));
+        abort();
+    }
+
+    char tmp;
+    ssize_t wres =3D write(*fd, &tmp, 1);
+    if (wres =3D=3D -1) {
+        error_report("error: write(%s): %s", *path, strerror(errno));
+        abort();
+    }
+
+    if (addr) {
+        *addr =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, *=
fd, 0);
+        if (*addr =3D=3D MAP_FAILED) {
+            error_report("error: mmap(%s): %s", *path, strerror(errno));
+            abort();
+        }
+    }
+}
+
+/* Host SIGSEGV cannot be set bu user-mode guests */
+static struct sigaction sigsegv_ours;
+static struct sigaction sigsegv_next;
+static void sigsegv_handler(int signum, siginfo_t *siginfo, void *sigctx=
t);
+
+static struct sigaction sigint_ours;
+static struct sigaction sigint_next;
+bool sigint_user_set;
+struct sigaction sigint_user;
+
+static struct sigaction sigabrt_ours;
+static struct sigaction sigabrt_next;
+bool sigabrt_user_set;
+struct sigaction sigabrt_user;
+
+typedef void (*sigaction_t)(int, siginfo_t *, void *);
+
+static void reflect_handler(struct sigaction *ours, struct sigaction *ne=
xt,
+                            int signum, siginfo_t *siginfo, void *sigctx=
t)
+{
+    if (next->sa_flags & SA_SIGINFO) {
+        if (next->sa_sigaction !=3D NULL) {
+            next->sa_sigaction(signum, siginfo, sigctxt);
+        } else if (next->sa_sigaction =3D=3D (sigaction_t)SIG_IGN) {
+            /* ignore */
+        } else if (next->sa_sigaction =3D=3D (sigaction_t)SIG_DFL) {
+            if (signal(signum, SIG_DFL) =3D=3D SIG_ERR) {
+                error_report("error: signal: %s", strerror(errno));
+                abort();
+            }
+            if (raise(signum) !=3D 0) {
+                error_report("error: raise: %s", strerror(errno));
+                abort();
+            }
+            struct sigaction tmp;
+            memcpy(&tmp, ours, sizeof(tmp));
+            if (sigaction(signum, &tmp, NULL) !=3D 0) {
+                error_report("error: sigaction: %s", strerror(errno));
+                abort();
+            }
+        }
+    } else {
+        if (next->sa_handler !=3D NULL) {
+            next->sa_handler(signum);
+        } else if (next->sa_handler =3D=3D SIG_IGN) {
+            /* ignore */
+        } else if (next->sa_handler =3D=3D SIG_DFL) {
+            if (signal(signum, SIG_DFL) =3D=3D SIG_ERR) {
+                error_report("error: signal: %s", strerror(errno));
+                abort();
+            }
+            if (raise(signum) !=3D 0) {
+                error_report("error: raise: %s", strerror(errno));
+                abort();
+            }
+            struct sigaction tmp;
+            memcpy(&tmp, ours, sizeof(tmp));
+            if (sigaction(signum, &tmp, NULL) !=3D 0) {
+                error_report("error: sigaction: %s", strerror(errno));
+                abort();
+            }
+        }
+    }
+}
+
+static void sigint_handler(int signum, siginfo_t *siginfo, void *sigctxt=
)
+{
+    hypertrace_fini();
+    /* QEMU lets users override any signal handler */
+    if (sigint_user_set) {
+        reflect_handler(&sigint_ours, &sigint_user, signum, siginfo, sig=
ctxt);
+    } else {
+        reflect_handler(&sigint_ours, &sigint_next, signum, siginfo, sig=
ctxt);
+    }
+}
+
+static void sigabrt_handler(int signum, siginfo_t *siginfo, void *sigctx=
t)
+{
+    hypertrace_fini();
+    /* QEMU lets users override any signal handler */
+    if (sigabrt_user_set) {
+        reflect_handler(&sigabrt_ours, &sigabrt_user, signum, siginfo, s=
igctxt);
+    } else {
+        reflect_handler(&sigabrt_ours, &sigabrt_next, signum, siginfo, s=
igctxt);
+    }
+}
+
+void hypertrace_init(const char *base, unsigned int max_clients)
+{
+    struct hypertrace_config *pconfig;
+
+    if (base =3D=3D NULL) {
+        return;
+    }
+
+    sigint_user_set =3D false;
+    memset(&sigint_ours, 0, sizeof(sigint_ours));
+    sigint_ours.sa_sigaction =3D sigint_handler;
+    sigint_ours.sa_flags =3D SA_SIGINFO | SA_RESTART;
+    sigemptyset(&sigint_ours.sa_mask);
+    if (sigaction(SIGINT, &sigint_ours, &sigint_next) !=3D 0) {
+        error_report("error: sigaction(SIGINT): %s", strerror(errno));
+        abort();
+    }
+
+    sigabrt_user_set =3D false;
+    memset(&sigabrt_ours, 0, sizeof(sigabrt_ours));
+    sigabrt_ours.sa_sigaction =3D sigabrt_handler;
+    sigabrt_ours.sa_flags =3D SA_SIGINFO | SA_RESTART;
+    sigemptyset(&sigabrt_ours.sa_mask);
+    if (sigaction(SIGABRT, &sigabrt_ours, &sigabrt_next) !=3D 0) {
+        error_report("error: sigaction(SIGABRT): %s", strerror(errno));
+        abort();
+    }
+
+    hypertrace_init_config(&config, max_clients);
+
+    init_channel(base, "-config", getpagesize(),
+                 &config_path, &config_fd, &qemu_config);
+    pconfig =3D (struct hypertrace_config *)qemu_config;
+    pconfig->max_clients =3D tswap64(config.max_clients);
+    pconfig->client_args =3D tswap64(config.client_args);
+    pconfig->client_data_size =3D tswap64(config.client_data_size);
+    pconfig->control_size =3D tswap64(config.control_size);
+    pconfig->data_size =3D tswap64(config.data_size);
+
+    init_channel(base, "-data", config.data_size,
+                 &data_path, &data_fd, &qemu_data);
+    if (fstat(data_fd, &control_fd_stat) =3D=3D -1) {
+        error_report("error: fstat(hypertrace_control): %s", strerror(er=
rno));
+        abort();
+    }
+
+    init_channel(base, "-control", config.control_size,
+                 &control_path, &control_fd, &qemu_control);
+
+    if (fstat(control_fd, &control_fd_stat) =3D=3D -1) {
+        error_report("error: fstat(hypertrace_control): %s", strerror(er=
rno));
+        abort();
+    }
+
+    memset(&sigsegv_ours, 0, sizeof(sigsegv_ours));
+    sigsegv_ours.sa_sigaction =3D sigsegv_handler;
+    sigsegv_ours.sa_flags =3D SA_SIGINFO | SA_RESTART;
+    sigemptyset(&sigsegv_ours.sa_mask);
+    if (sigaction(SIGSEGV, &sigsegv_ours, &sigsegv_next) !=3D 0) {
+        error_report("error: sigaction(SIGSEGV): %s", strerror(errno));
+        abort();
+    }
+}
+
+
+static void fini_channel(int *fd, char **path)
+{
+    if (*fd !=3D -1) {
+        if (close(*fd) =3D=3D -1) {
+            error_report("error: close: %s", strerror(errno));
+            abort();
+        }
+        if (unlink(*path) =3D=3D -1) {
+            error_report("error: unlink(%s): %s", *path, strerror(errno)=
);
+            abort();
+        }
+        *fd =3D -1;
+    }
+    if (*path !=3D NULL) {
+        g_free(*path);
+        *path =3D  NULL;
+    }
+}
+
+void hypertrace_fini(void)
+{
+    static bool atexit_in;
+    if (atexit_in) {
+        return;
+    }
+    atexit_in =3D true;
+
+    if (sigaction(SIGSEGV, &sigsegv_next, NULL) !=3D 0) {
+        error_report("error: sigaction(SIGSEGV): %s", strerror(errno));
+        abort();
+    }
+    fini_channel(&config_fd, &config_path);
+    fini_channel(&data_fd, &data_path);
+    fini_channel(&control_fd, &control_path);
+}
+
+
+bool hypertrace_guest_mmap_check(int fd, unsigned long len,
+                                 unsigned long offset)
+{
+    struct stat s;
+    if (fstat(fd, &s) < 0) {
+        /* the control channel should never fail fstat() */
+        return true;
+    }
+
+    if (s.st_dev !=3D control_fd_stat.st_dev ||
+        s.st_ino !=3D control_fd_stat.st_ino) {
+        /* this is not the control channel */
+        return true;
+    }
+
+    /* check control channel is mapped correctly */
+    return len =3D=3D (config.control_size) && offset =3D=3D 0;
+}
+
+void hypertrace_guest_mmap_apply(int fd, void *qemu_addr, CPUState *vcpu=
)
+{
+    struct stat s;
+
+    if (vcpu =3D=3D NULL) {
+        return;
+    }
+
+    if (fstat(fd, &s) !=3D 0) {
+        return;
+    }
+
+    if (s.st_dev !=3D control_fd_stat.st_dev ||
+        s.st_ino !=3D control_fd_stat.st_ino) {
+        return;
+    }
+
+    /* it's an mmap of the control channel; split it in two and mprotect=
 it to
+     * detect writes (cmd is written once on each part)
+     */
+    vcpu->hypertrace_control =3D qemu_addr;
+    if (mprotect(qemu_addr, config.control_size / 2, PROT_READ) =3D=3D -=
1) {
+        error_report("error: mprotect(hypertrace_control): %s",
+                     strerror(errno));
+        abort();
+    }
+}
+
+static void swap_control(void *from, void *to)
+{
+    if (mprotect(from, config.control_size / 2, PROT_READ | PROT_WRITE) =
=3D=3D -1) {
+        error_report("error: mprotect(from): %s", strerror(errno));
+        abort();
+    }
+    if (mprotect(to, config.control_size / 2, PROT_READ) =3D=3D -1) {
+        error_report("error: mprotect(to): %s", strerror(errno));
+        abort();
+    }
+}
+
+static void sigsegv_handler(int signum, siginfo_t *siginfo, void *sigctx=
t)
+{
+    CPUState *vcpu =3D current_cpu;
+    void *control_0 =3D vcpu->hypertrace_control;
+    void *control_1 =3D vcpu->hypertrace_control + config.control_size /=
 2;
+    void *control_2 =3D control_1 + config.control_size / 2;
+
+    if (control_0 <=3D siginfo->si_addr && siginfo->si_addr < control_1)=
 {
+
+        /* 1st fault (guest will write cmd) */
+        assert(((uintptr_t)siginfo->si_addr % sizeof(TARGET_PAGE_SIZE)) =
=3D=3D 0);
+        swap_control(control_0, control_1);
+
+    } else if (control_1 <=3D siginfo->si_addr && siginfo->si_addr < con=
trol_2) {
+
+        /* 2nd fault (invoke) */
+        size_t client =3D (siginfo->si_addr - control_1) / sizeof(uint64=
_t);
+        uint64_t vcontrol =3D ((uint64_t *)control_0)[client];
+        uint64_t *data_ptr =3D &qemu_data[client * config.client_data_si=
ze];
+        assert(((uintptr_t)siginfo->si_addr % sizeof(uint64_t)) =3D=3D 0=
);
+        hypertrace_emit(current_cpu, vcontrol, data_ptr);
+        swap_control(control_1, control_0);
+
+    } else {
+
+        /* proxy to next handler */
+        reflect_handler(&sigsegv_ours, &sigsegv_next, signum, siginfo, s=
igctxt);
+
+    }
+}
diff --git a/hypertrace/user.h b/hypertrace/user.h
new file mode 100644
index 0000000000..e3f131c675
--- /dev/null
+++ b/hypertrace/user.h
@@ -0,0 +1,71 @@
+/*
+ * QEMU-side management of hypertrace in user-level emulation.
+ *
+ * Copyright (C) 2016-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <stdint.h>
+#include <sys/types.h>
+
+
+/**
+ * Definition of QEMU options describing hypertrace subsystem configurat=
ion
+ */
+extern QemuOptsList qemu_hypertrace_opts;
+
+/**
+ * hypertrace_opt_parse:
+ * @optarg: Input arguments.
+ * @base: Output base path for the hypertrace channel files.
+ * @max_clients: Output maximum number of concurrent clients.
+ *
+ * Parse the commandline arguments for hypertrace.
+ */
+void hypertrace_opt_parse(const char *optarg, char **base,
+                          unsigned int *max_clients);
+
+/**
+ * hypertrace_init:
+ * @base: Base path for the hypertrace channel files.
+ * @max_clients: Maximum number of concurrent clients.
+ *
+ * Initialize the backing files for the hypertrace channel.
+ */
+void hypertrace_init(const char *base, unsigned int max_clients);
+
+/**
+ * hypertrace_guest_mmap_check:
+ *
+ * Check whether the mapped file is *not* hypertrace's control channel; =
if it
+ * is, check it is mapped correctly.
+ *
+ * Precondition: defined(CONFIG_USER_ONLY)
+ */
+bool hypertrace_guest_mmap_check(int fd, unsigned long len,
+                                 unsigned long offset);
+
+/**
+ * hypertrace_guest_mmap_apply:
+ *
+ * Configure initial mprotect if mapping the control channel.
+ *
+ * Precondition: defined(CONFIG_USER_ONLY)
+ */
+void hypertrace_guest_mmap_apply(int fd, void *qemu_addr, CPUState *vcpu=
);
+
+/**
+ * hypertrace_fini:
+ *
+ * Remove the backing files for the hypertrace channel.
+ */
+void hypertrace_fini(void);
+
+
+/* Internal signal management */
+extern bool sigint_user_set;
+extern struct sigaction sigint_user;
+extern bool sigabrt_user_set;
+extern struct sigaction sigabrt_user;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 25eefea7ab..bb382a0e6a 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -305,6 +305,7 @@ struct qemu_work_item;
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all =
changes
  *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask=
).
+ * @hypertrace_control: Per-vCPU address of the hypertrace control chann=
el.
  *
  * State of one CPU core or thread.
  */
@@ -377,6 +378,9 @@ struct CPUState {
     DECLARE_BITMAP(trace_dstate_delayed, CPU_TRACE_DSTATE_MAX_EVENTS);
     DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
=20
+    /* Only used when defined(CONFIG_USER_ONLY) */
+    void *hypertrace_control;
+
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index; /* used by alpha TCG */
     uint32_t halted; /* used by alpha, cris, ppc TCG */
diff --git a/linux-user/main.c b/linux-user/main.c
index ad03c9e8b2..b9e31e925b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -32,10 +32,12 @@
 #include "tcg.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
+#include "qemu/error-report.h"
 #include "elf.h"
 #include "exec/log.h"
 #include "trace/control.h"
 #include "glib-compat.h"
+#include "hypertrace/user.h"
=20
 char *exec_path;
=20
@@ -4014,6 +4016,14 @@ static void handle_arg_trace(const char *arg)
     trace_file =3D trace_opt_parse(arg);
 }
=20
+static char *hypertrace_base;
+static unsigned int hypertrace_max_clients;
+static void handle_arg_hypertrace(const char *arg)
+{
+    g_free(hypertrace_base);
+    hypertrace_opt_parse(arg, &hypertrace_base, &hypertrace_max_clients)=
;
+}
+
 struct qemu_argument {
     const char *argv;
     const char *env;
@@ -4063,6 +4073,8 @@ static const struct qemu_argument arg_table[] =3D {
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=3D]<pattern>][,events=3D<file>][,file=3D<fi=
le>]"},
+    {"hypertrace", "QEMU_HYPERTRACE",  true,  handle_arg_hypertrace,
+     "",           "[[base=3D]<path>][,max-clients=3D<uint>]"},
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
     {NULL, NULL, false, NULL, NULL, NULL}
@@ -4252,6 +4264,7 @@ int main(int argc, char **argv, char **envp)
     srand(time(NULL));
=20
     qemu_add_opts(&qemu_trace_opts);
+    qemu_add_opts(&qemu_hypertrace_opts);
=20
     optind =3D parse_args(argc, argv);
=20
@@ -4453,6 +4466,12 @@ int main(int argc, char **argv, char **envp)
     syscall_init();
     signal_init();
=20
+    if (atexit(hypertrace_fini)) {
+        error_report("error: atexit: %s", strerror(errno));
+        abort();
+    }
+    hypertrace_init(hypertrace_base, hypertrace_max_clients);
+
     /* Now that we've loaded the binary, GUEST_BASE is fixed.  Delay
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4888f53139..ade8759af9 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -21,6 +21,7 @@
 #include "qemu.h"
 #include "qemu-common.h"
 #include "translate-all.h"
+#include "hypertrace/user.h"
=20
 //#define DEBUG_MMAP
=20
@@ -357,10 +358,18 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong =
size)
     }
 }
=20
-/* NOTE: all the constants are the HOST ones */
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, abi_ulong offset)
 {
+    return target_mmap_cpu(start, len, prot, flags, fd, offset, NULL);
+}
+
+
+/* NOTE: all the constants are the HOST ones */
+abi_long target_mmap_cpu(abi_ulong start, abi_ulong len, int prot,
+                         int flags, int fd, abi_ulong offset,
+                         CPUState *cpu)
+{
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host=
_len;
=20
     mmap_lock();
@@ -442,6 +451,10 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,=
 int prot,
        }
     }
=20
+    if (!hypertrace_guest_mmap_check(fd, len, offset)) {
+        goto fail;
+    }
+
     if (!(flags & MAP_FIXED)) {
         unsigned long host_start;
         void *p;
@@ -553,6 +566,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int prot,
         }
     }
  the_end1:
+    hypertrace_guest_mmap_apply(fd, g2h(start), cpu);
     page_set_flags(start, start + len, prot | PAGE_VALID);
  the_end:
 #ifdef DEBUG_MMAP
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4edd7d0c08..67cf051d27 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -425,6 +425,9 @@ void sparc64_get_context(CPUSPARCState *env);
 int target_mprotect(abi_ulong start, abi_ulong len, int prot);
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, abi_ulong offset);
+abi_long target_mmap_cpu(abi_ulong start, abi_ulong len, int prot,
+                         int flags, int fd, abi_ulong offset,
+                         CPUState *cpu);
 int target_munmap(abi_ulong start, abi_ulong len);
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 3d18d1b3ee..9a21302331 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -23,6 +23,7 @@
=20
 #include "qemu.h"
 #include "qemu-common.h"
+#include "hypertrace/user.h"
 #include "target_signal.h"
 #include "trace.h"
=20
@@ -813,7 +814,16 @@ int do_sigaction(int sig, const struct target_sigact=
ion *act,
             } else {
                 act1.sa_sigaction =3D host_signal_handler;
             }
-            ret =3D sigaction(host_sig, &act1, NULL);
+
+            if (host_sig =3D=3D SIGINT) {
+                memcpy(&sigint_user, &act1, sizeof(act1));
+                sigint_user_set =3D true;
+            } else if (host_sig =3D=3D SIGABRT) {
+                memcpy(&sigabrt_user, &act1, sizeof(act1));
+                sigabrt_user_set =3D true;
+            } else {
+                ret =3D sigaction(host_sig, &act1, NULL);
+            }
         }
     }
     return ret;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 003943b736..17d76f5d39 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -115,6 +115,7 @@ int __clone2(int (*fn)(void *), void *child_stack_bas=
e,
 #include "uname.h"
=20
 #include "qemu.h"
+#include "hypertrace/user.h"
=20
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -7765,6 +7766,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        hypertrace_fini();
         _exit(arg1);
         ret =3D 0; /* avoid warning */
         break;
@@ -9231,15 +9233,19 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
             v5 =3D tswapal(v[4]);
             v6 =3D tswapal(v[5]);
             unlock_user(v, arg1, 0);
-            ret =3D get_errno(target_mmap(v1, v2, v3,
-                                        target_to_host_bitmask(v4, mmap_=
flags_tbl),
-                                        v5, v6));
+            ret =3D get_errno(target_mmap_cpu(
+                                v1, v2, v3,
+                                target_to_host_bitmask(v4, mmap_flags_tb=
l),
+                                v5, v6,
+                                cpu));
         }
 #else
-        ret =3D get_errno(target_mmap(arg1, arg2, arg3,
-                                    target_to_host_bitmask(arg4, mmap_fl=
ags_tbl),
-                                    arg5,
-                                    arg6));
+        ret =3D get_errno(target_mmap_cpu(
+                            arg1, arg2, arg3,
+                            target_to_host_bitmask(arg4, mmap_flags_tbl)=
,
+                            arg5,
+                            arg6,
+                            cpu));
 #endif
         break;
 #endif
@@ -9248,10 +9254,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
 #ifndef MMAP_SHIFT
 #define MMAP_SHIFT 12
 #endif
-        ret =3D get_errno(target_mmap(arg1, arg2, arg3,
-                                    target_to_host_bitmask(arg4, mmap_fl=
ags_tbl),
-                                    arg5,
-                                    arg6 << MMAP_SHIFT));
+        ret =3D get_errno(target_mmap_cpu(
+                            arg1, arg2, arg3,
+                            target_to_host_bitmask(arg4, mmap_flags_tbl)=
,
+                            arg5,
+                            arg6 << MMAP_SHIFT,
+                            cpu));
         break;
 #endif
     case TARGET_NR_munmap:
@@ -9821,6 +9829,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        hypertrace_fini();
         ret =3D get_errno(exit_group(arg1));
         break;
 #endif
