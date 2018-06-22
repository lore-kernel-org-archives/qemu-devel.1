Received: from eggs.gnu.org ([2001:4830:134:3::10]:41713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWRRO-0000pX-Fo
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWRRN-0007Gc-6e
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:09:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fWRRN-0007GV-0k
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:09:49 -0400
Date: Fri, 22 Jun 2018 22:09:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180622190936.177827-2-mst@redhat.com>
References: <20180622190936.177827-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622190936.177827-1-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v5 1/2] kvm: support -overcommit cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

With this flag, kvm allows guest to control host CPU power state.  This
increases latency for other processes using same host CPU in an
unpredictable way, but if decreases idle entry/exit times for the
running VCPU, so to use it QEMU needs a hint about whether host CPU is
overcommitted, hence the flag name.

Follow-up patches will expose this capability to guest
(using mwait leaf).

Based on a patch by Wanpeng Li <kernellwp@gmail.com> .

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/sysemu/sysemu.h |  1 +
 migration/migration.c   |  1 +
 target/i386/kvm.c       | 23 +++++++++++++++++++++++
 vl.c                    | 32 +++++++++++++++++++++++++++++++-
 qemu-options.hx         | 27 +++++++++++++++++++++++++--
 5 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index e893f72f3b..b921c6f3b7 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -128,6 +128,7 @@ extern bool boot_strict;
 extern uint8_t *boot_splash_filedata;
 extern size_t boot_splash_filedata_size;
 extern bool enable_mlock;
+extern bool enable_cpu_pm;
 extern uint8_t qemu_extra_params_fw[2];
 extern QEMUClockType rtc_clock;
 extern const char *mem_path;
diff --git a/migration/migration.c b/migration/migration.c
index 1e99ec9b7e..e468b50c4f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -45,6 +45,7 @@
 #include "migration/colo.h"
 #include "hw/boards.h"
 #include "monitor/monitor.h"
+#include "qemu/ptr_ring.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 44f70733e7..cf9107be4b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1357,6 +1357,29 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }
+
+    if (enable_cpu_pm) {
+        int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
+        int ret;
+
+/* Work around for kernel header with a typo. TODO: fix header and drop. */
+#if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)
+#define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL
+#endif
+        if (disable_exits) {
+            disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
+                              KVM_X86_DISABLE_EXITS_HLT |
+                              KVM_X86_DISABLE_EXITS_PAUSE);
+        }
+
+        ret = kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
+                                disable_exits);
+        if (ret < 0) {
+            error_report("kvm: guest stopping CPU not supported: %s",
+                         strerror(-ret));
+        }
+    }
+
     return 0;
 }
 
diff --git a/vl.c b/vl.c
index 06031715ac..c9530efed5 100644
--- a/vl.c
+++ b/vl.c
@@ -142,6 +142,7 @@ ram_addr_t ram_size;
 const char *mem_path = NULL;
 int mem_prealloc = 0; /* force preallocation of physical target memory */
 bool enable_mlock = false;
+bool enable_cpu_pm = false;
 int nb_nics;
 NICInfo nd_table[MAX_NICS];
 int autostart;
@@ -390,6 +391,22 @@ static QemuOptsList qemu_realtime_opts = {
     },
 };
 
+static QemuOptsList qemu_overcommit_opts = {
+    .name = "overcommit",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_overcommit_opts.head),
+    .desc = {
+        {
+            .name = "mem-lock",
+            .type = QEMU_OPT_BOOL,
+        },
+        {
+            .name = "cpu-pm",
+            .type = QEMU_OPT_BOOL,
+        },
+        { /* end of list */ }
+    },
+};
+
 static QemuOptsList qemu_msg_opts = {
     .name = "msg",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_msg_opts.head),
@@ -3903,7 +3920,20 @@ int main(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
-                enable_mlock = qemu_opt_get_bool(opts, "mlock", true);
+                /* Don't override the -overcommit option if set */
+                enable_mlock = enable_mlock ||
+                    qemu_opt_get_bool(opts, "mlock", true);
+                break;
+            case QEMU_OPTION_overcommit:
+                opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
+                                               optarg, false);
+                if (!opts) {
+                    exit(1);
+                }
+                /* Don't override the -realtime option if set */
+                enable_mlock = enable_mlock ||
+                    qemu_opt_get_bool(opts, "mem-lock", false);
+                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", false);
                 break;
             case QEMU_OPTION_msg:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("msg"), optarg,
diff --git a/qemu-options.hx b/qemu-options.hx
index c0d3951e9f..1bba3d258b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3328,8 +3328,7 @@ DEF("realtime", HAS_ARG, QEMU_OPTION_realtime,
     "-realtime [mlock=on|off]\n"
     "                run qemu with realtime features\n"
     "                mlock=on|off controls mlock support (default: on)\n",
-    QEMU_ARCH_ALL)
-STEXI
+    QEMU_ARCH_ALL) STEXI
 @item -realtime mlock=on|off
 @findex -realtime
 Run qemu with realtime features.
@@ -3337,6 +3336,30 @@ mlocking qemu and guest memory can be enabled via @option{mlock=on}
 (enabled by default).
 ETEXI
 
+DEF("overcommit", HAS_ARG, QEMU_OPTION_overcommit,
+    "--overcommit [mem-lock=on|off][cpu-pm=on|off]\n"
+    "                run qemu with overcommit hints\n"
+    "                mem-lock=on|off controls memory lock support (default: off)\n"
+    "                cpu-pm=on|off controls cpu power management (default: off)\n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -overcommit mem-lock=on|off
+@item -overcommit cpu-pm=on|off
+@findex -overcommit
+Run qemu with hints about host resource overcommit. The default is
+to assume that host overcommits all resources.
+
+Locking qemu and guest memory can be enabled via @option{mem-lock=on} (disabled
+by default).  This works when host memory is not overcommitted and reduces the
+worst-case latency for guest.  This is equivalent to @option{realtime}.
+
+Guest ability to manage power state of host cpus (increasing latency for other
+processes on the same host cpu, but decreasing latency for guest) can be
+enabled via @option{cpu-pm=on} (disabled by default).  This works best when
+host CPU is not overcommitted. When used, host estimates of CPU cycle and power
+utilization will be incorrect, not taking into account guest idle time.
+ETEXI
+
 DEF("gdb", HAS_ARG, QEMU_OPTION_gdb, \
     "-gdb dev        wait for gdb connection on 'dev'\n", QEMU_ARCH_ALL)
 STEXI
-- 
MST
