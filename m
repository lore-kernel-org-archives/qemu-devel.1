Received: from eggs.gnu.org ([2001:4830:134:3::10]:58961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSoK3-00077p-LO
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSoK1-0005KO-Lv
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:47:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fSoK1-0005K7-Fp
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:47:13 -0400
Date: Tue, 12 Jun 2018 21:47:11 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180612184616.90838-2-mst@redhat.com>
References: <20180612184616.90838-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612184616.90838-1-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] kvm: support -realtime cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org

With this flag, kvm allows guest to control host CPU power state.  This
increases latency for other processes using same host CPU in an
unpredictable way, but if decreases idle entry/exit times for the
running VCPU.

Follow-up patches will expose this capability to guest
(using mwait leaf).

Based on a patch by Wanpeng Li <kernellwp@gmail.com> .

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/sysemu/sysemu.h |  1 +
 target/i386/kvm.c       | 22 ++++++++++++++++++++++
 vl.c                    |  6 ++++++
 qemu-options.hx         |  9 +++++++--
 4 files changed, 36 insertions(+), 2 deletions(-)

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
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 44f70733e7..f093d55209 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1357,6 +1357,28 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
+            error_report("kvm: guest stopping CPU not supported: %s", strerror(-ret));
+        }
+    }
+
     return 0;
 }
 
diff --git a/vl.c b/vl.c
index 06031715ac..7bea9c2177 100644
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
@@ -386,6 +387,10 @@ static QemuOptsList qemu_realtime_opts = {
             .name = "mlock",
             .type = QEMU_OPT_BOOL,
         },
+        {
+            .name = "cpu-pm",
+            .type = QEMU_OPT_BOOL,
+        },
         { /* end of list */ }
     },
 };
@@ -3904,6 +3909,7 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 enable_mlock = qemu_opt_get_bool(opts, "mlock", true);
+                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", false);
                 break;
             case QEMU_OPTION_msg:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("msg"), optarg,
diff --git a/qemu-options.hx b/qemu-options.hx
index c0d3951e9f..e6f31071ce 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3325,16 +3325,21 @@ Do not start CPU at startup (you must type 'c' in the monitor).
 ETEXI
 
 DEF("realtime", HAS_ARG, QEMU_OPTION_realtime,
-    "-realtime [mlock=on|off]\n"
+    "-realtime [mlock=on|off][cpu-halt=on|off[\n"
     "                run qemu with realtime features\n"
-    "                mlock=on|off controls mlock support (default: on)\n",
+    "                mlock=on|off controls mlock support (default: on)\n"
+    "                cpu-pm=on|off controls cpu power management (default: off)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -realtime mlock=on|off
+@item -realtime cpu-pm=on|off
 @findex -realtime
 Run qemu with realtime features.
 mlocking qemu and guest memory can be enabled via @option{mlock=on}
 (enabled by default).
+guest ability to manage power state of host cpus (increasing latency for other
+processes on the same host cpu, but decreasing latency for guest)
+can be enabled via @option{cpu-pm=on} (disabled by default).
 ETEXI
 
 DEF("gdb", HAS_ARG, QEMU_OPTION_gdb, \
-- 
MST
