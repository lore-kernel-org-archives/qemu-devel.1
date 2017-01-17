Received: from eggs.gnu.org ([2001:4830:134:3::10]:40641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cTcDR-0005kz-MQ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cTcDO-000475-E2
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:26:57 -0500
Received: from mta02.ornl.gov ([128.219.177.136]:44546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nutarojj@ornl.gov>) id 1cTcDO-00043Z-1l
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:26:54 -0500
From: "James J. Nutaro" <nutarojj@ornl.gov>
Date: Tue, 17 Jan 2017 17:26:41 -0500
Message-Id: <1484692001-14835-1-git-send-email-nutarojj@ornl.gov>
Subject: [Qemu-devel] [PATCH v7] qqq: module for synchronizing with a
 simulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nutarojj@ornl.gov, pbonzini@redhat.com

This patch adds an interface for pacing the execution of QEMU to match an external
simulation clock. Its aim is to permit QEMU to be used as a module within a
larger simulation system.

v6 -> v7 Added a check for command line arguments that are consistent
with -qqq and print an error message if incompatible arguments are
provide. [Paolo]

Signed-off-by: James J. Nutaro <nutarojj@ornl.gov>
---
 Makefile.target          |   3 +
 cpus.c                   |   8 +++
 docs/simulation-sync.txt |  59 ++++++++++++++++
 include/sysemu/cpus.h    |   1 +
 kvm-all.c                |  10 +++
 qemu-options.hx          |  16 +++++
 qqq.c                    | 177 +++++++++++++++++++++++++++++++++++++++++++++++
 qqq.h                    |  37 ++++++++++
 vl.c                     |  36 ++++++++++
 9 files changed, 347 insertions(+)
 create mode 100644 docs/simulation-sync.txt
 create mode 100644 qqq.c
 create mode 100644 qqq.h

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
index 0000000..de4dd34
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
+  or
+-enable-kvm -rtc clock=vm
+
+The -qqq argument is used to supply a file descriptor
+for a Unix socket, which is used for synchronization.
+The procedure for launching QEMU in is synchronization
+mode has three steps:
+
+(1) Create a socket pair with the Linux socketpair function.
+    The code segment that does this might look like
+
+       int socks[2];
+       socketpair(AF_UNIX,SOCK_STREAM,0,socks);
+
+(2) Fork QEMU with the appropriate command line arguments.
+    The -qqq part of the argument will look something like
+
+       -qqq sock=socks[1]
+
+(3) After forking QEMU, close sock[1] and retain the
+    sock[0] for communicating with QEMU.
+
+The synchronization protocol is very simple. To start, the
+external simulator writes an integer to its socket with
+the amount of time in microseconds that QEMU is allowed to
+advance. The code segment that does this might look like:
+
+    uint32_t ta = htonl(1000); // Advance by 1 millisecond
+    write(sock[0],&ta,sizeof(uint32_t));
+
+The external simulator can then advance its clock by this
+same amount. During this time, QEMU and the external simulator
+will be executing in parallel. When the external simulator
+completes its time advance, it waits for QEMU by reading from
+its socket. The value read will be the actual number of
+virtual microseconds by which QEMU has advanced its virtual clock.
+This will be greater than or equal to the requested advance.
+The code that does this might look like:
+
+   uint32_t ta;
+   read(fd,&ta,sizeof(uint32_t));
+   ta = ntohl(ta);
+
+These steps are repeated until either (1) the external simulator
+closes its socket thereby causing QEMU to terminate or (2) QEMU
+stops executing (e.g., if the emulated computer is shutdown) and
+causes a read or write error on the simulator's socket.
+
+You can find an example of a simulator using this protocol in
+the adevs simulation package at http://sourceforge.net/projects/adevs/
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
index 330219e..b66b07f 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -18,6 +18,7 @@
 
 #include <linux/kvm.h>
 
+#include "qqq.h"
 #include "qemu-common.h"
 #include "qemu/atomic.h"
 #include "qemu/option.h"
@@ -1926,6 +1927,15 @@ int kvm_cpu_exec(CPUState *cpu)
             qemu_cpu_kick_self();
         }
 
+        if (qqq_enabled()) {
+            /* Pause here while qqq is synchronizing with a simulation clock.
+             * We do not want to execute instructions past the synchronization
+             * deadline, but its ok to update the states of other equipment
+             * like timers, i/o devices, etc.
+             */
+            qqq_sync();
+        }
+
         run_ret = kvm_vcpu_ioctl(cpu, KVM_RUN, 0);
 
         attrs = kvm_arch_post_run(cpu, run);
diff --git a/qemu-options.hx b/qemu-options.hx
index c534a2f..46f12e0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3389,6 +3389,22 @@ many timer interrupts were not processed by the Windows guest and will
 re-inject them.
 ETEXI
 
+DEF("qqq", HAS_ARG, QEMU_OPTION_qqq, \
+    "-qqq sock=fd\n" \
+    "                enable synchronization of the virtual clock \n" \
+    "                with an external simulation clock\n", QEMU_ARCH_ALL)
+STEXI
+@item -qqq sock=@var{fd0}
+@findex -qqq
+Qemu will use the supplied socket to synchronize its virtual clock with
+an external simulation clock. Qemu will wait until a time slice size in
+microseconds is supplied on the socket. Then it will execute for at
+least that number of virtual microseconds before writing the actual
+virtual time that has elapsed in microseconds to the socket. This
+cycle will repeat until a zero time advance is requested, which
+will cause qemu to exit.
+ETEXI
+
 DEF("icount", HAS_ARG, QEMU_OPTION_icount, \
     "-icount [shift=N|auto][,align=on|off][,sleep=on|off,rr=record|replay,rrfile=<filename>]\n" \
     "                enable virtual instruction counter with 2^N clock ticks per\n" \
diff --git a/qqq.c b/qqq.c
new file mode 100644
index 0000000..b186c37
--- /dev/null
+++ b/qqq.c
@@ -0,0 +1,177 @@
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "sysemu/kvm.h"
+#include "qqq.h"
+/* This is a Linux only feature */
+
+#ifndef _WIN32
+
+#include <arpa/inet.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <assert.h>
+
+static bool enabled = false, syncing = true;
+static unsigned elapsed; /* initialized to zero */
+static int time_advance = -1;
+static int fd = -1;
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
+    /* kvm-all.c will call this function before running
+     * instructions with kvm. Because syncing will be
+     * true while qqq is waiting for a new time advance
+     * from the simulation, no instructions will execute
+     * while the machine is supposed to be suspended in
+     * simulation time.
+     */
+    qemu_mutex_lock(&qqq_mutex);
+    while (syncing) {
+        qemu_cond_wait(&qqq_cond, &qqq_mutex);
+    }
+    qemu_mutex_unlock(&qqq_mutex);
+}
+
+static void cleanup_and_exit(void)
+{
+    /* Close the socket and quit */
+    close(fd);
+    exit(0);
+}
+
+static void start_emulator(void)
+{
+    if (kvm_enabled()) {
+        /* Setting syncing to false tells kvm-all that
+         * it can execute guest instructions.
+         */
+        qemu_mutex_lock(&qqq_mutex);
+        syncing = false;
+        qemu_mutex_unlock(&qqq_mutex);
+        qemu_cond_signal(&qqq_cond);
+        /* Restart the emulator clock */
+        cpu_enable_ticks();
+    }
+}
+
+static void stop_emulator(void)
+{
+    if (kvm_enabled()) {
+        /* Tell the emulator that it is not allowed to
+         * execute guest instructions.
+         */
+        qemu_mutex_lock(&qqq_mutex);
+        syncing = true;
+        qemu_mutex_unlock(&qqq_mutex);
+        /* Kick KVM off of the CPU and stop the emulator clock. */
+        cpu_disable_ticks();
+        kick_all_vcpus();
+    }
+}
+
+static void write_mem_value(unsigned val)
+{
+    uint32_t msg = htonl(val);
+    if (write(fd, &msg, sizeof(uint32_t)) != sizeof(uint32_t)) {
+        /* If the socket is no good, then assume this is an
+         * indication that we should exit.
+         */
+        cleanup_and_exit();
+    }
+}
+
+static unsigned read_mem_value(void)
+{
+    uint32_t msg;
+    if (read(fd, &msg, sizeof(uint32_t)) != sizeof(uint32_t)) {
+        /* If the socket is no good, then assume this is an
+         * indication that we should exit.
+         */
+        cleanup_and_exit();
+    }
+    return ntohl(msg);
+}
+
+static void schedule_next_event(void)
+{
+    /* If we got the time advance in fd_read, then don't do it
+     * again here. */
+    if (time_advance < 0) {
+        /* Otherwise read the value from the socket */
+        time_advance = read_mem_value();
+    }
+    assert(t == 0 ||
+        abs(t - qemu_clock_get_us(QEMU_CLOCK_VIRTUAL)) <= time_advance);
+    /* Schedule the next synchronization point */
+    timer_mod(sync_timer, t + time_advance);
+    /* Note that we need to read the time advance again on the next pass */
+    time_advance = -1;
+    /* Start advancing cpu ticks and the wall clock */
+    start_emulator();
+}
+
+static void sync_func(void *data)
+{
+    /* Stop advancing cpu ticks and the wall clock */
+    stop_emulator();
+    /* Report the actual elapsed time to the external simulator. */
+    int64_t tnow = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
+    elapsed = tnow - t;
+    write_mem_value(elapsed);
+    /* Update our time of last event */
+    t = tnow;
+    /* Schedule the next event */
+    schedule_next_event();
+}
+
+static void fd_read(void *opaque)
+{
+    /* Read the time advance if its becomes available
+     * before our timer expires */
+    time_advance = read_mem_value();
+}
+
+void setup_qqq(QemuOpts *opts)
+{
+    /* The module has been enabled */
+    enabled = true;
+    if (kvm_enabled()) {
+        qemu_mutex_init(&qqq_mutex);
+        qemu_cond_init(&qqq_cond);
+    }
+    /* Stop the clock while the simulation is initialized */
+    stop_emulator();
+    /* Initialize the simulation clock */
+    t = 0;
+    /* Get the communication socket */
+    fd = qemu_opt_get_number(opts, "sock", 0);
+    /* Start the timer to ensure time warps advance the clock */
+    sync_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, sync_func, NULL);
+    /* Get the time advance that is requested by the simulation */
+    schedule_next_event();
+    /* Register the file descriptor with qemu. This should ensure
+     * the emulator doesn't pause for lack of I/O and thereby
+     * cause the attached simulator to pause with it. */
+    qemu_set_fd_handler(fd, fd_read, NULL, NULL);
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
index c643d3f..e4aaf40 100644
--- a/vl.c
+++ b/vl.c
@@ -124,6 +124,8 @@ int main(int argc, char **argv)
 #include "qapi/qmp/qerror.h"
 #include "sysemu/iothread.h"
 
+#include "qqq.h"
+
 #define MAX_VIRTIO_CONSOLES 1
 #define MAX_SCLP_CONSOLES 1
 
@@ -234,6 +236,20 @@ static struct {
     { .driver = "virtio-vga",           .flag = &default_vga       },
 };
 
+static QemuOptsList qemu_qqq_opts = {
+    .name = "qqq",
+    .implied_opt_name = "",
+    .merge_lists = true,
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_qqq_opts.head),
+    .desc = {
+        {
+            .name = "sock",
+            .type = QEMU_OPT_NUMBER,
+        },
+        { /* end of list */ }
+    },
+};
+
 static QemuOptsList qemu_rtc_opts = {
     .name = "rtc",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_rtc_opts.head),
@@ -3001,6 +3017,7 @@ int main(int argc, char **argv, char **envp)
     DisplayState *ds;
     int cyls, heads, secs, translation;
     QemuOpts *hda_opts = NULL, *opts, *machine_opts, *icount_opts = NULL;
+    QemuOpts *qqq_opts = NULL;
     QemuOptsList *olist;
     int optind;
     const char *optarg;
@@ -3040,6 +3057,7 @@ int main(int argc, char **argv, char **envp)
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_QAPI);
 
+    qemu_add_opts(&qemu_qqq_opts);
     qemu_add_opts(&qemu_drive_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
     qemu_add_drive_opts(&qemu_common_drive_opts);
@@ -3904,6 +3922,13 @@ int main(int argc, char **argv, char **envp)
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
@@ -4412,6 +4437,17 @@ int main(int argc, char **argv, char **envp)
     /* spice needs the timers to be initialized by this point */
     qemu_spice_init();
 
+    if (qqq_opts) {
+        if (!(rtc_clock == QEMU_CLOCK_VIRTUAL && (
+              (icount_opts && !qemu_opt_get_bool(icount_opts, "sleep", true)) ||
+              kvm_enabled()))) {
+            error_report("-qqq requires options -rtc clock=vm and either "
+                "icount -1,sleep=off or -enable-kvm");
+            exit(1);
+        }
+        setup_qqq(qqq_opts);
+    }
+
     cpu_ticks_init();
     if (icount_opts) {
         if (kvm_enabled() || xen_enabled()) {
-- 
2.7.4
