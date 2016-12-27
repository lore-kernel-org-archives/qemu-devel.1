Received: from eggs.gnu.org ([2001:4830:134:3::10]:43460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cLy8a-0003Qw-Lp
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cLy8X-0005WG-Ap
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:14:20 -0500
Received: from mta01.ornl.gov ([128.219.177.137]:39852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nutarojj@ornl.gov>) id 1cLy8W-0005U2-Vn
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:14:17 -0500
From: "James J. Nutaro" <nutarojj@ornl.gov>
Date: Tue, 27 Dec 2016 15:13:41 -0500
Message-Id: <1482869621-24808-1-git-send-email-nutarojj@ornl.gov>
Subject: [Qemu-devel] [PATCH v4] qqq: module for synchronizing with a
 simulation clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, nutarojj@ornl.gov

This patch adds an interface for pacing the execution of QEMU to match
an external simulation clock. Its aim is to permit QEMU to be used
as a module within a larger simulation system.

Signed-off-by: James J. Nutaro <nutarojj@ornl.gov>
---
 Makefile.objs            |   1 +
 Makefile.target          |   3 +
 cpus.c                   |   8 +++
 docs/simulation-sync.txt |  59 +++++++++++++++++++
 freezer.c                |  43 ++++++++++++++
 include/qemu/timer.h     |  36 ++++++++++--
 include/sysemu/cpus.h    |   1 +
 kvm-all.c                |  14 +++++
 qemu-options.hx          |  16 +++++
 qqq.c                    | 150 +++++++++++++++++++++++++++++++++++++++++++++++
 qqq.h                    |  37 ++++++++++++
 vl.c                     |  32 ++++++++++
 12 files changed, 394 insertions(+), 6 deletions(-)
 create mode 100644 docs/simulation-sync.txt
 create mode 100644 freezer.c
 create mode 100644 qqq.c
 create mode 100644 qqq.h

diff --git a/Makefile.objs b/Makefile.objs
index 51c36a4..31fa777 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -3,6 +3,7 @@
 stub-obj-y = stubs/ crypto/
 util-obj-y = util/ qobject/ qapi/
 util-obj-y += qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
+util-obj-y += freezer.o
 
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
diff --git a/Makefile.target b/Makefile.target
index 8ae82cb..0a08fd3 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -145,6 +145,9 @@ obj-y += dump.o
 obj-y += migration/ram.o migration/savevm.o
 LIBS := $(libs_softmmu) $(LIBS)
 
+# qqq support
+obj-y += qqq.o
+
 # xen support
 obj-$(CONFIG_XEN) += xen-common.o
 obj-$(CONFIG_XEN_I386) += xen-hvm.o xen-mapcache.o
diff --git a/cpus.c b/cpus.c
index 5213351..8a98d7f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1688,3 +1688,11 @@ void dump_drift_info(FILE *f, fprintf_function cpu_fprintf)
         cpu_fprintf(f, "Max guest advance   NA\n");
     }
 }
+
+void kick_all_vcpus(void)
+{
+    CPUState *cpu;
+    CPU_FOREACH(cpu) {
+        qemu_cpu_kick(cpu);
+    }
+}
diff --git a/docs/simulation-sync.txt b/docs/simulation-sync.txt
new file mode 100644
index 0000000..e59b731
--- /dev/null
+++ b/docs/simulation-sync.txt
@@ -0,0 +1,59 @@
+= Synchronizing the virtual clock with an external source =
+
+QEMU has a protocol for synchronizing its virtual clock
+with the clock of a simulator in which QEMU is embedded
+as a component. This options is enabled with the -qqq
+argument, and it should generally be accompanied by the
+following additional command line arguments:
+
+-icount 1,sleep=off -rtc clock=vm
+
+The -qqq argument is used to supply file descriptors
+for two Unix pipes. The read pipe is used by QEMU to
+receive synchronization data from the external simulator.
+The write pipe is used by QEMU to supply synchronization
+data to the external emulator. The typical procedure for
+launching QEMU in is synchronization mode has three steps:
+
+(1) Create two pairs of pipes with the Linux pipe function.
+    The code segment that does this might look like
+
+       int pipefd1[2];
+       int pipefd2[2];
+       pipe(pipefd1);
+       pipe(pipefd2);
+
+(2) Fork QEMU with the appropriate command line arguments.
+    The -qqq part of the argument will look something like
+
+       -qqq write=pipefd1[1],read=pipefd2[0]
+
+(3) After forking QEMU, close pipefd1[1] and pipefd2[0].
+    Retain the other pair of pipes for communicating with QEMU.
+
+The synchronization protocol is very simple. To start, the
+external simulator writes an integer to its write pipe with
+the amount of time in microseconds that QEMU is allowed to
+advance. The code segment that does this might look like:
+
+    int ta = 1000; // Advance by 1 millisecond
+    write(pipefd2[1],&ta,sizeof(int));
+
+The external simulator can then advance its clock by this
+same amount. During this time, QEMU and the external simulator
+will be executing in parallel. When the external simulator
+completes its time advance, it waits for QEMU by reading from
+its read pipe. The value read will be the actual number of
+virtual microseconds by which QEMU has advanced its virtual clock.
+This will be greater than or equal to the requested advance.
+The code that does this might look like:
+
+   read(pipefd1[0],&ta,sizeof(int));
+
+These steps are repeated until either (1) the external simulator
+closes its pipes thereby causing QEMU to terminate or (2) QEMU
+stops executing (e.g., if the emulated computer is shutdown) and
+causes SIGPIPE to be generated by the closing of its pipes.
+
+You can find an example of a simulator using this protocol in
+the adevs simulation package at http://sourceforge.net/projects/adevs/
diff --git a/freezer.c b/freezer.c
new file mode 100644
index 0000000..9e0c3f4
--- /dev/null
+++ b/freezer.c
@@ -0,0 +1,43 @@
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+
+/* These must all initialize to zero */
+static int64_t iced_ticks;
+static int64_t iced_ns;
+static int64_t winter_ticks;
+static int64_t winter_ns;
+
+void freeze_time(void)
+{
+    winter_ticks = cpu_get_host_ticks();
+    winter_ns = get_clock();
+}
+
+void thaw_time(void)
+{
+    int64_t ns = winter_ns;
+    int64_t ticks = winter_ticks;
+    winter_ns = winter_ticks = 0;
+    iced_ticks += (cpu_get_host_ticks() - ticks);
+    iced_ns += (get_clock() - ns);
+}
+
+int64_t ticks_is_frozen(void)
+{
+    return winter_ticks;
+}
+
+int64_t ns_is_frozen(void)
+{
+    return winter_ns;
+}
+
+int64_t get_iced_ticks(void)
+{
+    return iced_ticks;
+}
+
+int64_t get_iced_ns(void)
+{
+    return iced_ns;
+}
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9abed51..fc30c9d 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -795,13 +795,25 @@ static inline int64_t get_max_clock_jump(void)
  * Low level clock functions
  */
 
+/*
+ * Freeze time by subtracting frozen duration from real interval measurements.
+ */
+void freeze_time(void);
+void thaw_time(void);
+int64_t get_iced_ticks(void);
+int64_t get_iced_ns(void);
+int64_t ns_is_frozen(void);
+int64_t ticks_is_frozen(void);
+
 /* get host real time in nanosecond */
 static inline int64_t get_clock_realtime(void)
 {
     struct timeval tv;
-
+    if (ns_is_frozen() > 0) {
+        return ns_is_frozen();
+    }
     gettimeofday(&tv, NULL);
-    return tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000);
+    return ((tv.tv_sec * 1000000000LL + (tv.tv_usec * 1000))-get_iced_ns());
 }
 
 /* Warning: don't insert tracepoints into these functions, they are
@@ -826,8 +838,11 @@ static inline int64_t get_clock(void)
 #ifdef CLOCK_MONOTONIC
     if (use_rt_clock) {
         struct timespec ts;
+        if (ns_is_frozen() > 0) {
+            return ns_is_frozen();
+        }
         clock_gettime(CLOCK_MONOTONIC, &ts);
-        return ts.tv_sec * 1000000000LL + ts.tv_nsec;
+        return (ts.tv_sec * 1000000000LL + ts.tv_nsec)-get_iced_ns();
     } else
 #endif
     {
@@ -878,8 +893,11 @@ static inline int64_t cpu_get_host_ticks(void)
 static inline int64_t cpu_get_host_ticks(void)
 {
     int64_t val;
+    if (ticks_is_frozen() > 0) {
+         return ticks_is_frozen();
+    }
     asm volatile ("rdtsc" : "=A" (val));
-    return val;
+    return val-get_iced_ticks();
 }
 
 #elif defined(__x86_64__)
@@ -888,11 +906,14 @@ static inline int64_t cpu_get_host_ticks(void)
 {
     uint32_t low,high;
     int64_t val;
+    if (ticks_is_frozen() > 0) {
+         return ticks_is_frozen();
+    }
     asm volatile("rdtsc" : "=a" (low), "=d" (high));
     val = high;
     val <<= 32;
     val |= low;
-    return val;
+    return val-get_iced_ticks();
 }
 
 #elif defined(__hppa__)
@@ -909,8 +930,11 @@ static inline int64_t cpu_get_host_ticks(void)
 static inline int64_t cpu_get_host_ticks(void)
 {
     int64_t val;
+    if (ticks_is_frozen() > 0) {
+         return ticks_is_frozen();
+    }
     asm volatile ("mov %0 = ar.itc" : "=r"(val) :: "memory");
-    return val;
+    return val-get_iced_ticks();
 }
 
 #elif defined(__s390__)
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 3728a1e..bdf22c9 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -2,6 +2,7 @@
 #define QEMU_CPUS_H
 
 /* cpus.c */
+void kick_all_vcpus(void);
 bool qemu_in_vcpu_thread(void);
 void qemu_init_cpu_loop(void);
 void resume_all_vcpus(void);
diff --git a/kvm-all.c b/kvm-all.c
index 330219e..768da29 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -16,8 +16,11 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
+#include <sys/syscall.h>
+#include <time.h>
 #include <linux/kvm.h>
 
+#include "qqq.h"
 #include "qemu-common.h"
 #include "qemu/atomic.h"
 #include "qemu/option.h"
@@ -1926,6 +1929,17 @@ int kvm_cpu_exec(CPUState *cpu)
             qemu_cpu_kick_self();
         }
 
+        if (qqq_enabled()) {
+            /* Pause here while qqq is synchronizing with a simulation clock.
+             * We do not want to execute instructions past the synchronization
+             * deadline, but its ok to update the states of other equipment
+             * like timers, i/o devices, etc. Allowing this seems to avoid
+             * some timing problems. (Because it gives the HPET unit time to
+             * catch up with the VCPU while the VCPU is paused?)
+             */
+            qqq_sync();
+        }
+
         run_ret = kvm_vcpu_ioctl(cpu, KVM_RUN, 0);
 
         attrs = kvm_arch_post_run(cpu, run);
diff --git a/qemu-options.hx b/qemu-options.hx
index c534a2f..d556329 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3389,6 +3389,22 @@ many timer interrupts were not processed by the Windows guest and will
 re-inject them.
 ETEXI
 
+DEF("qqq", HAS_ARG, QEMU_OPTION_qqq, \
+    "-qqq read=fd,write=fd\n" \
+    "                enable synchronization of the virtual clock \n" \
+    "                with an external simulation clock\n", QEMU_ARCH_ALL)
+STEXI
+@item -qqq read=@var{fd0},write=@var{fd1}
+@findex -qqq
+Qemu will use the supplied pipes to synchronize its virtual clock with
+an external simulation clock. Qemu will wait until a time slice size in
+microseconds is supplied on the read pipe. Then it will execute for at
+least that number of virtual microseconds before writing the actual
+virtual time that has elapsed in microseconds to the write pipe. This
+cycle will repeat until a zero is elaspsed time is requested, which
+will cause qemu to exit.
+ETEXI
+
 DEF("icount", HAS_ARG, QEMU_OPTION_icount, \
     "-icount [shift=N|auto][,align=on|off][,sleep=on|off,rr=record|replay,rrfile=<filename>]\n" \
     "                enable virtual instruction counter with 2^N clock ticks per\n" \
diff --git a/qqq.c b/qqq.c
new file mode 100644
index 0000000..adcfc67
--- /dev/null
+++ b/qqq.c
@@ -0,0 +1,150 @@
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "sysemu/kvm.h"
+#include "qqq.h"
+
+/* This is a Linux only feature */
+
+#ifndef _WIN32
+
+#include <unistd.h>
+#include <assert.h>
+
+static bool enabled = false, syncing = false;
+static int elapsed; // This must be zero on initialization
+static int time_advance = -1;
+static int read_fd = -1, write_fd = -1;
+static int64_t t;
+static QEMUTimer *sync_timer;
+static QemuMutex qqq_mutex;
+static QemuCond qqq_cond;
+
+bool qqq_enabled(void)
+{
+    return enabled;
+}
+
+void qqq_sync(void)
+{
+    qemu_mutex_lock(&qqq_mutex);
+    while (syncing) {
+        qemu_cond_wait(&qqq_cond, &qqq_mutex);
+    }
+    qemu_mutex_unlock(&qqq_mutex);
+}
+
+static void cleanup_and_exit(void)
+{
+    close(read_fd);
+    close(write_fd);
+    exit(0);
+}
+
+static void write_mem_value(int val)
+{
+    if (write(write_fd, &val, sizeof(int)) != sizeof(int)) {
+        /* If the pipe is no good, then assume this is an
+         * indication that we should exit.
+         */
+        cleanup_and_exit();
+    }
+}
+
+static int read_mem_value(void)
+{
+    int tmp;
+    if (read(read_fd, &tmp, sizeof(int)) != sizeof(int)) {
+        /* If the pipe is no good, then assume this is an
+         * indication that we should exit.
+         */
+        cleanup_and_exit();
+    }
+    return tmp;
+}
+
+static void schedule_next_event(bool is_init)
+{
+    /* If we got the time advance in fd_read, then don't do it
+     * again here. */
+    if (time_advance < 0) 
+        /* Otherwise read the value from the pipe */
+        time_advance = read_mem_value();
+    /* Release kvm to go forward in time to the next synchronization point */
+    if (!is_init && kvm_enabled()) {
+        qemu_mutex_lock(&qqq_mutex);
+        syncing = false;
+        qemu_mutex_unlock(&qqq_mutex);
+        qemu_cond_signal(&qqq_cond);
+        thaw_time();
+    }
+    /* Schedule the next synchronization point */
+    timer_mod(sync_timer, t + time_advance);
+    /* Note that we need to read the time advance again on the next pass */
+    time_advance = -1;
+}
+
+static void sync_func(void *data)
+{
+    if (kvm_enabled()) {
+        /* Set the sync flag that will cause the vcpu to wait for synchronization
+         * to finish before it begins executing instructions again */
+        qemu_mutex_lock(&qqq_mutex);
+        syncing = true;
+        qemu_mutex_unlock(&qqq_mutex);
+        /* Kick KVM off of the processor and keep it off while we synchronize */
+        kick_all_vcpus();
+        /* Stop advancing cpu ticks and the wall clock */
+        freeze_time();
+    }
+    /* Report the actual elapsed time to the external simulator. */
+    int64_t tnow = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
+    elapsed = tnow - t;
+    write_mem_value(elapsed);
+    /* Update our time of last event */
+    t = tnow;
+    /* Schedule the next event */
+    schedule_next_event(false);
+}
+
+static void fd_read(void *opaque)
+{
+    /* Read the time advance if its becomes available
+     * before our timer expires */
+       time_advance = read_mem_value();
+}
+
+void setup_qqq(QemuOpts *opts)
+{
+    /* Stop the clock while the simulation is initialized */
+    if (kvm_enabled()) {
+        qemu_mutex_init(&qqq_mutex);
+        qemu_cond_init(&qqq_cond);
+    }
+    /* Initialize the simulation clock */
+    t = 0;
+    /* Get the communication pipes */
+    read_fd = qemu_opt_get_number(opts, "read", 0);
+    write_fd = qemu_opt_get_number(opts, "write", 0);
+    /* Start the timer to ensure time warps advance the clock */
+    sync_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, sync_func, NULL);
+    /* Get the time advance that is requested by the simulation */
+    schedule_next_event(true);
+    /* Register the file descriptor with qemu. This should ensure
+     * the emulator doesn't pause for lack of I/O and thereby
+     * cause the attached simulator to pause with it. */
+    qemu_set_fd_handler(read_fd, fd_read, NULL, NULL);
+    /* The module has been enabled */
+    enabled = true;
+}
+
+#else
+
+void setup_qqq(QemuOpts *opts)
+{
+    fprintf(stderr, "-qqq is not supported on Windows, exiting\n");
+    exit(0);
+}
+
+#endif
diff --git a/qqq.h b/qqq.h
new file mode 100644
index 0000000..e106d3c
--- /dev/null
+++ b/qqq.h
@@ -0,0 +1,37 @@
+/*
+ * This work is licensed under the terms of the GNU GPL
+ * version 2. Seethe COPYING file in the top-level directory.
+ *
+ * A module for pacing the rate of advance of the computer
+ * clock in reference to an external simulation clock. The
+ * basic approach used here is adapted from QBox from Green
+ * Socs. The mode of operation is as follows:
+ *
+ * The simulator uses pipes to exchange time advance data.
+ * The external simulator starts the exchange by forking a
+ * QEMU process and passing is descriptors for a read and
+ * write pipe. Then the external simulator writes an integer
+ * (native endian) to the pipe to indicate the number of
+ * microseconds that QEMU should advance. QEMU advances its
+ * virtual clock by this amount and writes to its write pipe
+ * the actual number of microseconds that have advanced.
+ * This process continues until a pipe on either side is
+ * closed, which will either cause QEMU to exit (if the
+ * external simulator closes a pipe) or raise SIGPIPE in the
+ * external simulator (if QEMU closes a pipe).
+ *
+ * Authors:
+ *   James Nutaro <nutaro@gmail.com>
+ *
+ */
+#ifndef QQQ_H
+#define QQQ_H
+
+#include "qemu/osdep.h"
+#include "qemu-options.h"
+
+void qqq_sync(void);
+bool qqq_enabled(void);
+void setup_qqq(QemuOpts *opts);
+
+#endif
diff --git a/vl.c b/vl.c
index d77dd86..2766186 100644
--- a/vl.c
+++ b/vl.c
@@ -124,6 +124,8 @@ int main(int argc, char **argv)
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
 
+#include "qqq.h"
+
 #define MAX_VIRTIO_CONSOLES 1
 #define MAX_SCLP_CONSOLES 1
 
@@ -234,6 +236,23 @@ static struct {
     { .driver = "virtio-vga",           .flag = &default_vga       },
 };
 
+static QemuOptsList qemu_qqq_opts = {
+    .name = "qqq",
+    .implied_opt_name = "",
+    .merge_lists = true,
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_qqq_opts.head),
+    .desc = {
+        {
+            .name = "read",
+            .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "write",
+            .type = QEMU_OPT_NUMBER,
+        },
+        { /* end of list */ }
+    },
+};
+
 static QemuOptsList qemu_rtc_opts = {
     .name = "rtc",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_rtc_opts.head),
@@ -3005,6 +3024,7 @@ int main(int argc, char **argv, char **envp)
     DisplayState *ds;
     int cyls, heads, secs, translation;
     QemuOpts *hda_opts = NULL, *opts, *machine_opts, *icount_opts = NULL;
+    QemuOpts *qqq_opts = NULL;
     QemuOptsList *olist;
     int optind;
     const char *optarg;
@@ -3044,6 +3064,7 @@ int main(int argc, char **argv, char **envp)
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_QAPI);
 
+    qemu_add_opts(&qemu_qqq_opts);
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
     qemu_add_drive_opts(&qemu_common_drive_opts);
@@ -3908,6 +3929,13 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_qqq:
+                qqq_opts = qemu_opts_parse_noisily(qemu_find_opts("qqq"),
+                                                      optarg, true);
+                if (!qqq_opts) {
+                    exit(1);
+                }
+                break;
             case QEMU_OPTION_incoming:
                 if (!incoming) {
                     runstate_set(RUN_STATE_INMIGRATE);
@@ -4416,6 +4444,10 @@ int main(int argc, char **argv, char **envp)
     /* spice needs the timers to be initialized by this point */
     qemu_spice_init();
 
+    if (qqq_opts) {
+        setup_qqq(qqq_opts);
+    }
+
     cpu_ticks_init();
     if (icount_opts) {
         if (kvm_enabled() || xen_enabled()) {
-- 
2.7.4
