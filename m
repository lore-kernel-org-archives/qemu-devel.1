Received: from eggs.gnu.org ([2001:4830:134:3::10]:48801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3wK-0003Kt-9B
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX3wI-0003VR-6E
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:32 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX3wH-0003VE-Tu
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:39:30 -0500
Received: by mail-wm0-x235.google.com with SMTP id r126so110943895wmr.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:39:29 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:39:02 +0000
Message-Id: <20170127103922.19658-6-alex.bennee@linaro.org>
In-Reply-To: <20170127103922.19658-1-alex.bennee@linaro.org>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 05/25] tcg: add options for enabling MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

From: KONRAD Frederic <fred.konrad@greensocs.com>

We know there will be cases where MTTCG won't work until additional work
is done in the front/back ends to support. It will however be useful to
be able to turn it on.

As a result MTTCG will default to off unless the combination is
supported. However the user can turn it on for the sake of testing.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
[AJB: move to -accel tcg,thread=multi|single, defaults]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
v1:
  - merge with add mttcg option.
  - update commit message
v2:
  - machine_init->opts_init
v3:
  - moved from -tcg to -accel tcg,thread=single|multi
  - fix checkpatch warnings
v4:
  - make mttcg_enabled extern, qemu_tcg_mttcg_enabled() now just macro
  - qemu_tcg_configure now propagates Error instead of exiting
  - better error checking of thread=foo
  - use CONFIG flags for default_mttcg_enabled()
  - disable mttcg with icount, error if both forced on
v7
  - explicitly disable MTTCG for TCG_OVERSIZED_GUEST
  - use check_tcg_memory_orders_compatible() instead of CONFIG_MTTCG_HOST
  - change CONFIG_MTTCG_TARGET to TARGET_SUPPORTS_MTTCG
v8
  - fix missing include tcg.h
  - change mismatched MOs to a warning instead of error
---
 cpus.c                | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/qom/cpu.h     |  9 +++++++
 include/sysemu/cpus.h |  2 ++
 qemu-options.hx       | 20 ++++++++++++++
 tcg/tcg.h             |  9 +++++++
 vl.c                  | 49 ++++++++++++++++++++++++++++++++++-
 6 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 71a82e5004..76b6e04332 100644
--- a/cpus.c
+++ b/cpus.c
@@ -25,6 +25,7 @@
 /* Needed early for CONFIG_BSD etc. */
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qemu/config-file.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "qapi/qmp/qerror.h"
@@ -45,6 +46,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/bitmap.h"
 #include "qemu/seqlock.h"
+#include "tcg.h"
 #include "qapi-event.h"
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
@@ -150,6 +152,76 @@ typedef struct TimersState {
 } TimersState;
 
 static TimersState timers_state;
+bool mttcg_enabled;
+
+/*
+ * We default to false if we know other options have been enabled
+ * which are currently incompatible with MTTCG. Otherwise when each
+ * guest (target) has been updated to support:
+ *   - atomic instructions
+ *   - memory ordering primitives (barriers)
+ * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
+ *
+ * Once a guest architecture has been converted to the new primitives
+ * there are two remaining limitations to check.
+ *
+ * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
+ * - The host must have a stronger memory order than the guest
+ *
+ * It may be possible in future to support strong guests on weak hosts
+ * but that will require tagging all load/stores in a guest with their
+ * implicit memory order requirements which would likely slow things
+ * down a lot.
+ */
+
+static bool check_tcg_memory_orders_compatible(void)
+{
+#if defined(TCG_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
+    return (TCG_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) == 0;
+#else
+    return false;
+#endif
+}
+
+static bool default_mttcg_enabled(void)
+{
+    QemuOpts *icount_opts = qemu_find_opts_singleton("icount");
+    const char *rr = qemu_opt_get(icount_opts, "rr");
+
+    if (rr || TCG_OVERSIZED_GUEST) {
+        return false;
+    } else {
+#ifdef TARGET_SUPPORTS_MTTCG
+        return check_tcg_memory_orders_compatible();
+#else
+        return false;
+#endif
+    }
+}
+
+void qemu_tcg_configure(QemuOpts *opts, Error **errp)
+{
+    const char *t = qemu_opt_get(opts, "thread");
+    if (t) {
+        if (strcmp(t, "multi") == 0) {
+            if (TCG_OVERSIZED_GUEST) {
+                error_setg(errp, "No MTTCG when guest word size > hosts");
+            } else {
+                if (!check_tcg_memory_orders_compatible()) {
+                    error_report("Guest requires stronger MO that host");
+                    error_printf("Results will likely be unpredictable");
+                }
+                mttcg_enabled = true;
+            }
+        } else if (strcmp(t, "single") == 0) {
+            mttcg_enabled = false;
+        } else {
+            error_setg(errp, "Invalid 'thread' setting %s", t);
+        }
+    } else {
+        mttcg_enabled = default_mttcg_enabled();
+    }
+}
 
 int64_t cpu_get_icount_raw(void)
 {
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index ca4d0fb1b4..11db2015a4 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -412,6 +412,15 @@ extern struct CPUTailQ cpus;
 extern __thread CPUState *current_cpu;
 
 /**
+ * qemu_tcg_mttcg_enabled:
+ * Check whether we are running MultiThread TCG or not.
+ *
+ * Returns: %true if we are in MTTCG mode %false otherwise.
+ */
+extern bool mttcg_enabled;
+#define qemu_tcg_mttcg_enabled() (mttcg_enabled)
+
+/**
  * cpu_paging_enabled:
  * @cpu: The CPU whose state is to be inspected.
  *
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 3728a1ea7e..a73b5d4bce 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -36,4 +36,6 @@ extern int smp_threads;
 
 void list_cpus(FILE *f, fprintf_function cpu_fprintf, const char *optarg);
 
+void qemu_tcg_configure(QemuOpts *opts, Error **errp);
+
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 588e5beab3..47ac537285 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -95,6 +95,26 @@ STEXI
 Select CPU model (@code{-cpu help} for list and additional feature selection)
 ETEXI
 
+DEF("accel", HAS_ARG, QEMU_OPTION_accel,
+    "-accel [accel=]accelerator[,thread=single|multi]\n"
+    "               select accelerator ('-accel help for list')\n"
+    "               thread=single|multi (enable multi-threaded TCG)", QEMU_ARCH_ALL)
+STEXI
+@item -accel @var{name}[,prop=@var{value}[,...]]
+@findex -accel
+This is used to enable an accelerator. Depending on the target architecture,
+kvm, xen, or tcg can be available. By default, tcg is used. If there is more
+than one accelerator specified, the next one is used if the previous one fails
+to initialize.
+@table @option
+@item thread=single|multi
+Controls number of TCG threads. When the TCG is multi-threaded there will be one
+thread per vCPU therefor taking advantage of additional host cores. The default
+is to enable multi-threading where both the back-end and front-ends support it and
+no incompatible TCG features have been enabled (e.g. icount/replay).
+@end table
+ETEXI
+
 DEF("smp", HAS_ARG, QEMU_OPTION_smp,
     "-smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,sockets=sockets]\n"
     "                set the number of CPUs to 'n' [default=1]\n"
diff --git a/tcg/tcg.h b/tcg/tcg.h
index f946452049..4c7f258220 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -80,6 +80,15 @@ typedef uint64_t tcg_target_ulong;
 #error unsupported
 #endif
 
+/* Oversized TCG guests make things like MTTCG hard
+ * as we can't use atomics for cputlb updates.
+ */
+#if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
+#define TCG_OVERSIZED_GUEST 1
+#else
+#define TCG_OVERSIZED_GUEST 0
+#endif
+
 #if TCG_TARGET_NB_REGS <= 32
 typedef uint32_t TCGRegSet;
 #elif TCG_TARGET_NB_REGS <= 64
diff --git a/vl.c b/vl.c
index 68e8c003d1..eabd7e04f8 100644
--- a/vl.c
+++ b/vl.c
@@ -299,6 +299,26 @@ static QemuOptsList qemu_machine_opts = {
     },
 };
 
+static QemuOptsList qemu_accel_opts = {
+    .name = "accel",
+    .implied_opt_name = "accel",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_accel_opts.head),
+    .merge_lists = true,
+    .desc = {
+        {
+            .name = "accel",
+            .type = QEMU_OPT_STRING,
+            .help = "Select the type of accelerator",
+        },
+        {
+            .name = "thread",
+            .type = QEMU_OPT_STRING,
+            .help = "Enable/disable multi-threaded TCG",
+        },
+        { /* end of list */ }
+    },
+};
+
 static QemuOptsList qemu_boot_opts = {
     .name = "boot-opts",
     .implied_opt_name = "order",
@@ -2973,7 +2993,8 @@ int main(int argc, char **argv, char **envp)
     const char *boot_once = NULL;
     DisplayState *ds;
     int cyls, heads, secs, translation;
-    QemuOpts *hda_opts = NULL, *opts, *machine_opts, *icount_opts = NULL;
+    QemuOpts *opts, *machine_opts;
+    QemuOpts *hda_opts = NULL, *icount_opts = NULL, *accel_opts = NULL;
     QemuOptsList *olist;
     int optind;
     const char *optarg;
@@ -3028,6 +3049,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_trace_opts);
     qemu_add_opts(&qemu_option_rom_opts);
     qemu_add_opts(&qemu_machine_opts);
+    qemu_add_opts(&qemu_accel_opts);
     qemu_add_opts(&qemu_mem_opts);
     qemu_add_opts(&qemu_smp_opts);
     qemu_add_opts(&qemu_boot_opts);
@@ -3723,6 +3745,26 @@ int main(int argc, char **argv, char **envp)
                 qdev_prop_register_global(&kvm_pit_lost_tick_policy);
                 break;
             }
+            case QEMU_OPTION_accel:
+                accel_opts = qemu_opts_parse_noisily(qemu_find_opts("accel"),
+                                                     optarg, true);
+                optarg = qemu_opt_get(accel_opts, "accel");
+
+                olist = qemu_find_opts("machine");
+                if (strcmp("kvm", optarg) == 0) {
+                    qemu_opts_parse_noisily(olist, "accel=kvm", false);
+                } else if (strcmp("xen", optarg) == 0) {
+                    qemu_opts_parse_noisily(olist, "accel=xen", false);
+                } else if (strcmp("tcg", optarg) == 0) {
+                    qemu_opts_parse_noisily(olist, "accel=tcg", false);
+                } else {
+                    if (!is_help_option(optarg)) {
+                        error_printf("Unknown accelerator: %s", optarg);
+                    }
+                    error_printf("Supported accelerators: kvm, xen, tcg\n");
+                    exit(1);
+                }
+                break;
             case QEMU_OPTION_usb:
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "usb=on", false);
@@ -4031,6 +4073,8 @@ int main(int argc, char **argv, char **envp)
 
     replay_configure(icount_opts);
 
+    qemu_tcg_configure(accel_opts, &error_fatal);
+
     machine_class = select_machine();
 
     set_memory_options(&ram_slots, &maxram_size, machine_class);
@@ -4395,6 +4439,9 @@ int main(int argc, char **argv, char **envp)
         if (!tcg_enabled()) {
             error_report("-icount is not allowed with hardware virtualization");
             exit(1);
+        } else if (qemu_tcg_mttcg_enabled()) {
+            error_report("-icount does not currently work with MTTCG");
+            exit(1);
         }
         configure_icount(icount_opts, &error_abort);
         qemu_opts_del(icount_opts);
-- 
2.11.0
