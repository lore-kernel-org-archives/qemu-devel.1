Received: from eggs.gnu.org ([2001:4830:134:3::10]:41945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbzA-0002Ez-7F
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbz6-0002yE-VN
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:35:08 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:50874 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLbz6-0002xs-6c
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 15:35:04 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 26 Dec 2016 21:34:54 +0100
Message-Id: <148278449426.8988.2219094135462471980.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 3/6] hypertrace: [*-user] Add QEMU-side
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
Cc: Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Riku Voipio <riku.voipio@iki.fi>

QEMU detects when the guest uses 'mmap' on hypertrace's control channel
file, and then uses 'mprotect' to detect accesses to it, which are used
to trigger tracing event "guest_hypertrace".

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 Makefile.objs            |    4 +
 bsd-user/main.c          |   17 ++
 bsd-user/mmap.c          |   15 ++
 bsd-user/syscall.c       |   34 +++--
 hypertrace/Makefile.objs |   18 ++
 hypertrace/common.c      |   26 ++++
 hypertrace/common.h      |   23 +++
 hypertrace/user.c        |  332 ++++++++++++++++++++++++++++++++++++++++=
++++++
 hypertrace/user.h        |   63 +++++++++
 include/qom/cpu.h        |    4 +
 linux-user/main.c        |   19 +++
 linux-user/mmap.c        |   17 ++
 linux-user/qemu.h        |    3=20
 linux-user/syscall.c     |   31 +++-
 14 files changed, 581 insertions(+), 25 deletions(-)
 create mode 100644 hypertrace/Makefile.objs
 create mode 100644 hypertrace/common.c
 create mode 100644 hypertrace/common.h
 create mode 100644 hypertrace/user.c
 create mode 100644 hypertrace/user.h

diff --git a/Makefile.objs b/Makefile.objs
index 5f0be2c3fb..5f3a68ca48 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -105,6 +105,10 @@ util-obj-y +=3D  trace/
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
index 714a692e6f..d42ded4fc8 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -31,9 +31,12 @@
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
@@ -676,6 +679,8 @@ static void usage(void)
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
@@ -736,6 +741,8 @@ int main(int argc, char **argv)
     envlist_t *envlist =3D NULL;
     char *trace_file =3D NULL;
     bsd_type =3D target_openbsd;
+    char *hypertrace_base =3D NULL;
+    unsigned int hypertrace_max_clients =3D 0;
=20
     if (argc <=3D 1)
         usage();
@@ -757,6 +764,7 @@ int main(int argc, char **argv)
     cpu_model =3D NULL;
=20
     qemu_add_opts(&qemu_trace_opts);
+    qemu_add_opts(&qemu_hypertrace_opts);
=20
     optind =3D 1;
     for (;;) {
@@ -847,6 +855,10 @@ int main(int argc, char **argv)
         } else if (!strcmp(r, "trace")) {
             g_free(trace_file);
             trace_file =3D trace_opt_parse(optarg);
+        } else if (!strcmp(r, "hypertrace")) {
+            g_free(hypertrace_file);
+            hypertrace_opt_parse(optarg, &hypertrace_base,
+                                 &hypertrace_max_clients);
         } else {
             usage();
         }
@@ -981,6 +993,11 @@ int main(int argc, char **argv)
     target_set_brk(info->brk);
     syscall_init();
     signal_init();
+    if (atexit(hypertrace_fini) !=3D 0) {
+        fprintf(stderr, "error: atexit: %s\n", strerror(errno));
+        abort();
+    }
+    hypertrace_init(hypertrace_base, hypertrace_size);
=20
     /* Now that we've loaded the binary, GUEST_BASE is fixed.  Delay
        generating the prologue until now so that the prologue can take
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index ee5907330f..650b8203fa 100644
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
@@ -256,10 +257,17 @@ static abi_ulong mmap_find_vma(abi_ulong start, abi=
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
@@ -301,6 +309,10 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,=
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
@@ -412,6 +424,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int prot,
         }
     }
  the_end1:
+    hypertrace_guest_mmap_apply(fd, g2h(start), cpu);
     page_set_flags(start, start + len, prot | PAGE_VALID);
  the_end:
 #ifdef DEBUG_MMAP
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
index 0000000000..24e8fb4eea
--- /dev/null
+++ b/hypertrace/Makefile.objs
@@ -0,0 +1,18 @@
+# -*- mode: makefile -*-
+
+target-obj-$(CONFIG_USER_ONLY) +=3D user.o
+target-obj-y +=3D common.o
+
+$(obj)/user.o: $(obj)/emit.c
+
+$(obj)/emit.c: $(obj)/emit.c-timestamp $(BUILD_DIR)/config-host.mak
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+$(obj)/emit.c-timestamp: $(BUILD_DIR)/config-host.mak
+	@echo "static void hypertrace_emit(CPUState *cpu, uint64_t arg1, uint64=
_t *data)" >$@
+	@echo "{" >>$@
+	@echo -n "    trace_guest_hypertrace(cpu, arg1" >>$@
+	@for i in `seq $$(( $(CONFIG_HYPERTRACE_ARGS) - 1 ))`; do \
+	    echo -n ", data[$$i-1]" >>$@; \
+	done
+	@echo ");" >>$@
+	@echo "}" >>$@
diff --git a/hypertrace/common.c b/hypertrace/common.c
new file mode 100644
index 0000000000..baca098aa0
--- /dev/null
+++ b/hypertrace/common.c
@@ -0,0 +1,26 @@
+/*
+ * QEMU-side management of hypertrace in user-level emulation.
+ *
+ * Copyright (C) 2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hypertrace/common.h"
+#include "qemu/osdep.h"
+
+void hypertrace_init_config(struct hypertrace_config *config,
+                            unsigned int max_clients)
+{
+    config->max_clients =3D max_clients;
+    config->client_args =3D CONFIG_HYPERTRACE_ARGS;
+    config->client_data_size =3D config->client_args * sizeof(uint64_t);
+    config->control_size =3D QEMU_ALIGN_UP(
+        config->max_clients * sizeof(uint64_t), TARGET_PAGE_SIZE);
+    config->data_size =3D QEMU_ALIGN_UP(
+        config->max_clients * config->client_data_size, TARGET_PAGE_SIZE=
);
+}
diff --git a/hypertrace/common.h b/hypertrace/common.h
new file mode 100644
index 0000000000..6eabbd6551
--- /dev/null
+++ b/hypertrace/common.h
@@ -0,0 +1,23 @@
+/*
+ * QEMU-side management of hypertrace in user-level emulation.
+ *
+ * Copyright (C) 2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#if !defined(__KERNEL__)
+#include <stdint.h>
+#endif
+
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
diff --git a/hypertrace/user.c b/hypertrace/user.c
new file mode 100644
index 0000000000..5649c0369a
--- /dev/null
+++ b/hypertrace/user.c
@@ -0,0 +1,332 @@
+/*
+ * QEMU-side management of hypertrace in user-level emulation.
+ *
+ * Copyright (C) 2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
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
+struct sigaction segv_next;
+static void segv_handler(int signum, siginfo_t *siginfo, void *sigctxt);
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
+        *base =3D NULL;
+    }
+    max_clients =3D qemu_opt_get_number(opts, "pages", 1);
+    if (max_clients <=3D 0) {
+        error_report("Parameter 'max-clients' expects a positive number"=
);
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
+        abort();
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
+static void fini_handler(int signum, siginfo_t *siginfo, void *sigctxt)
+{
+    hypertrace_fini();
+}
+
+void hypertrace_init(const char *base, unsigned int max_clients)
+{
+    struct sigaction sigint;
+    struct hypertrace_config *pconfig;
+
+    if (base =3D=3D NULL) {
+        return;
+    }
+
+    memset(&sigint, 0, sizeof(sigint));
+    sigint.sa_sigaction =3D fini_handler;
+    sigint.sa_flags =3D SA_SIGINFO | SA_RESTART;
+    if (sigaction(SIGINT, &sigint, NULL) !=3D 0) {
+        error_report("error: sigaction(SIGINT): %s", strerror(errno));
+        abort();
+    }
+    if (sigaction(SIGABRT, &sigint, NULL) !=3D 0) {
+        error_report("error: sigaction(SIGABRT): %s", strerror(errno));
+        abort();
+    }
+
+    hypertrace_init_config(&config, max_clients);
+    /* We need twice the space for the double-fault protocol */
+    config.control_size *=3D 2;
+
+    init_channel(base, "-config", TARGET_PAGE_SIZE,
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
+    struct sigaction segv;
+    memset(&segv, 0, sizeof(segv));
+    segv.sa_sigaction =3D segv_handler;
+    segv.sa_flags =3D SA_SIGINFO | SA_RESTART;
+    sigemptyset(&segv.sa_mask);
+
+    if (sigaction(SIGSEGV, &segv, &segv_next) !=3D 0) {
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
+    if (sigaction(SIGSEGV, &segv_next, NULL) !=3D 0) {
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
+        return true;
+    }
+
+    if (s.st_dev !=3D control_fd_stat.st_dev ||
+        s.st_ino !=3D control_fd_stat.st_ino) {
+        return true;
+    }
+
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
+#include "hypertrace/emit.c"
+
+static void segv_handler(int signum, siginfo_t *siginfo, void *sigctxt)
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
+        assert(((unsigned long)siginfo->si_addr % sizeof(uint64_t)) =3D=3D=
 0);
+        swap_control(control_0, control_1);
+
+    } else if (control_1 <=3D siginfo->si_addr && siginfo->si_addr < con=
trol_2) {
+        size_t client =3D (siginfo->si_addr - control_1) / sizeof(uint64=
_t);
+        uint64_t vcontrol =3D ((uint64_t *)control_0)[client];
+        uint64_t *data_ptr =3D &qemu_data[client * config.client_data_si=
ze];
+
+        /* 2nd fault (invoke) */
+        assert(((unsigned long)siginfo->si_addr % sizeof(uint64_t)) =3D=3D=
 0);
+        hypertrace_emit(current_cpu, vcontrol, data_ptr);
+        swap_control(control_1, control_0);
+
+    } else {
+        /* proxy to next handler */
+        if (segv_next.sa_sigaction !=3D NULL) {
+            segv_next.sa_sigaction(signum, siginfo, sigctxt);
+        } else if (segv_next.sa_handler !=3D NULL) {
+            segv_next.sa_handler(signum);
+        }
+    }
+}
diff --git a/hypertrace/user.h b/hypertrace/user.h
new file mode 100644
index 0000000000..b2bc60d507
--- /dev/null
+++ b/hypertrace/user.h
@@ -0,0 +1,63 @@
+/*
+ * QEMU-side management of hypertrace in user-level emulation.
+ *
+ * Copyright (C) 2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
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
+ * Verify argument validity when mapping the control channel.
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
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 3f79a8e955..8e7b579083 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -296,6 +296,7 @@ struct qemu_work_item;
  * @work_mutex: Lock to prevent multiple access to queued_work_*.
  * @queued_work_first: First asynchronous work pending.
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask=
).
+ * @hypertrace_control: Per-vCPU address of the hypertrace control chann=
el.
  *
  * State of one CPU core or thread.
  */
@@ -372,6 +373,9 @@ struct CPUState {
      */
     unsigned long *trace_dstate;
=20
+    /* Only used when defined(CONFIG_USER_ONLY) */
+    void *hypertrace_control;
+
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index; /* used by alpha TCG */
     uint32_t halted; /* used by alpha, cris, ppc TCG */
diff --git a/linux-user/main.c b/linux-user/main.c
index 75b199f274..8006abb102 100644
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
@@ -3748,6 +3750,14 @@ static void handle_arg_trace(const char *arg)
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
@@ -3797,6 +3807,8 @@ static const struct qemu_argument arg_table[] =3D {
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=3D]<pattern>][,events=3D<file>][,file=3D<fi=
le>]"},
+    {"hypertrace", "QEMU_HYPERTRACE",  true,  handle_arg_hypertrace,
+     "",           "[[base=3D]<path>][,max-clients=3D<uint>]"},
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
     {NULL, NULL, false, NULL, NULL, NULL}
@@ -3989,6 +4001,7 @@ int main(int argc, char **argv, char **envp)
     srand(time(NULL));
=20
     qemu_add_opts(&qemu_trace_opts);
+    qemu_add_opts(&qemu_hypertrace_opts);
=20
     optind =3D parse_args(argc, argv);
=20
@@ -4187,6 +4200,12 @@ int main(int argc, char **argv, char **envp)
     syscall_init();
     signal_init();
=20
+    if (atexit(hypertrace_fini)) {
+        fprintf(stderr, "error: atexit: %s\n", strerror(errno));
+        abort();
+    }
+    hypertrace_init(hypertrace_base, hypertrace_max_clients);
+
     /* Now that we've loaded the binary, GUEST_BASE is fixed.  Delay
        generating the prologue until now so that the prologue can take
        the real value of GUEST_BASE into account.  */
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 61685bf79e..52f1a54281 100644
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
@@ -360,10 +361,18 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong =
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
@@ -445,6 +454,10 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,=
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
@@ -556,6 +569,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, =
int prot,
         }
     }
  the_end1:
+    printf("mmap "TARGET_ABI_FMT_lx" "TARGET_ABI_FMT_lu"\n", start, len)=
;
+    hypertrace_guest_mmap_apply(fd, g2h(start), cpu);
     page_set_flags(start, start + len, prot | PAGE_VALID);
  the_end:
 #ifdef DEBUG_MMAP
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index da73a01106..da10920907 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -422,6 +422,9 @@ void sparc64_get_context(CPUSPARCState *env);
 int target_mprotect(abi_ulong start, abi_ulong len, int prot);
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, abi_ulong offset);
+abi_long target_mmap_cpu(abi_ulong start, abi_ulong len, int prot,
+                         int flags, int fd, abi_ulong offset,
+                         CPUState *cpu);
 int target_munmap(abi_ulong start, abi_ulong len);
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7b77503f94..0432001cda 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -113,6 +113,7 @@ int __clone2(int (*fn)(void *), void *child_stack_bas=
e,
 #include "uname.h"
=20
 #include "qemu.h"
+#include "hypertrace/user.h"
=20
 #ifndef CLONE_IO
 #define CLONE_IO                0x80000000      /* Clone io context */
@@ -7603,6 +7604,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        hypertrace_fini();
         _exit(arg1);
         ret =3D 0; /* avoid warning */
         break;
@@ -9051,15 +9053,19 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
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
@@ -9068,10 +9074,12 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
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
@@ -9642,6 +9650,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
         _mcleanup();
 #endif
         gdb_exit(cpu_env, arg1);
+        hypertrace_fini();
         ret =3D get_errno(exit_group(arg1));
         break;
 #endif
