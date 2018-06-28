Received: from eggs.gnu.org ([2001:4830:134:3::10]:38446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB8-0007qW-SC
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB7-0001Da-Gn
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:06 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdB7-0001BF-5B
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:05 -0400
Received: by mail-wr0-x231.google.com with SMTP id a12-v6so6696549wro.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:05:01 +0200
Message-Id: <1530216310-52873-52-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 51/60] kvm: support -overcommit cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

From: "Michael S. Tsirkin" <mst@redhat.com>

With this flag, kvm allows guest to control host CPU power state.  This
increases latency for other processes using same host CPU in an
unpredictable way, but if decreases idle entry/exit times for the
running VCPU, so to use it QEMU needs a hint about whether host CPU is
overcommitted, hence the flag name.

Follow-up patches will expose this capability to guest
(using mwait leaf).

Based on a patch by Wanpeng Li <kernellwp@gmail.com> .

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20180622192148.178309-2-mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/sysemu.h |  1 +
 qemu-options.hx         | 24 ++++++++++++++++++++++++
 target/i386/kvm.c       | 23 +++++++++++++++++++++++
 vl.c                    | 32 +++++++++++++++++++++++++++++++-
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index e893f72..b921c6f 100644
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
diff --git a/qemu-options.hx b/qemu-options.hx
index 3e45483..81b1e99 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3325,6 +3325,30 @@ mlocking qemu and guest memory can be enabled via @option{mlock=on}
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
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 2d174f3..dc991f6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1387,6 +1387,29 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
index 7c9f19a..ef6cfce 100644
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
@@ -3906,7 +3923,20 @@ int main(int argc, char **argv, char **envp)
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
-- 
1.8.3.1
