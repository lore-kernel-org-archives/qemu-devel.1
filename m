Received: from eggs.gnu.org ([2001:4830:134:3::10]:49297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cIvCc-0005z8-4h
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cIvCa-0000Bn-3y
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:29:54 -0500
Received: from mail-wj0-x22e.google.com ([2a00:1450:400c:c01::22e]:34100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vpalatin@google.com>) id 1cIvCZ-0000BW-Q7
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:29:52 -0500
Received: by mail-wj0-x22e.google.com with SMTP id tg4so146679671wjb.1
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 02:29:51 -0800 (PST)
Sender: Vincent Palatin <vpalatin@google.com>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Mon, 19 Dec 2016 11:29:04 +0100
Message-Id: <e9d99bde4c4d2487cf2a02a48875ffd2dd9ff54a.1482143215.git.vpalatin@chromium.org>
In-Reply-To: <cover.1482143215.git.vpalatin@chromium.org>
References: <cover.1482143215.git.vpalatin@chromium.org>
In-Reply-To: <cover.1482143215.git.vpalatin@chromium.org>
References: <cover.1482143215.git.vpalatin@chromium.org>
Subject: [Qemu-devel] [PATCH v4 3/4] Plumb the HAXM-based hardware
 acceleration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Yu Ning <yu.ning@linux.intel.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

Use the Intel HAX is kernel-based hardware acceleration module for
Windows (similar to KVM on Linux).

Based on the "target-i386: Add Intel HAX to android emulator" patch
from David Chou <david.j.chou@intel.com>

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
---
 Makefile.target           |  1 +
 configure                 | 18 ++++++++++
 cpus.c                    | 87 ++++++++++++++++++++++++++++++++++++++++++++++-
 exec.c                    | 16 +++++++++
 hw/intc/apic_common.c     |  3 +-
 include/qom/cpu.h         |  5 +++
 include/sysemu/hw_accel.h |  9 +++++
 qemu-options.hx           | 11 ++++++
 target-i386/Makefile.objs |  4 +++
 vl.c                      | 15 ++++++--
 10 files changed, 164 insertions(+), 5 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 7a5080e..dab81e7 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -96,6 +96,7 @@ obj-y += target-$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-y += tcg-runtime.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
+obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 
 obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decContext.o
diff --git a/configure b/configure
index 3770d7c..ba32bea 100755
--- a/configure
+++ b/configure
@@ -230,6 +230,7 @@ vhost_net="no"
 vhost_scsi="no"
 vhost_vsock="no"
 kvm="no"
+hax="no"
 colo="yes"
 rdma=""
 gprof="no"
@@ -563,6 +564,7 @@ CYGWIN*)
 ;;
 MINGW32*)
   mingw32="yes"
+  hax="yes"
   audio_possible_drivers="dsound sdl"
   if check_include dsound.h; then
     audio_drv_list="dsound"
@@ -612,6 +614,7 @@ OpenBSD)
 Darwin)
   bsd="yes"
   darwin="yes"
+  hax="yes"
   LDFLAGS_SHARED="-bundle -undefined dynamic_lookup"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
@@ -921,6 +924,10 @@ for opt do
   ;;
   --enable-kvm) kvm="yes"
   ;;
+  --disable-hax) hax="no"
+  ;;
+  --enable-hax) hax="yes"
+  ;;
   --disable-colo) colo="no"
   ;;
   --enable-colo) colo="yes"
@@ -1373,6 +1380,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   fdt             fdt device tree
   bluez           bluez stack connectivity
   kvm             KVM acceleration support
+  hax             HAX acceleration support
   colo            COarse-grain LOck-stepping VM for Non-stop Service
   rdma            RDMA-based migration support
   vde             support for vde network
@@ -5051,6 +5059,7 @@ echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
 echo "COLO support      $colo"
+echo "HAX support       $hax"
 echo "RDMA support      $rdma"
 echo "TCG interpreter   $tcg_interpreter"
 echo "fdt support       $fdt"
@@ -6035,6 +6044,15 @@ case "$target_name" in
       fi
     fi
 esac
+if test "$hax" = "yes" ; then
+  if test "$target_softmmu" = "yes" ; then
+    case "$target_name" in
+    i386|x86_64)
+      echo "CONFIG_HAX=y" >> $config_target_mak
+    ;;
+    esac
+  fi
+fi
 if test "$target_bigendian" = "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
 fi
diff --git a/cpus.c b/cpus.c
index fc78502..0e01791 100644
--- a/cpus.c
+++ b/cpus.c
@@ -35,6 +35,7 @@
 #include "sysemu/dma.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
+#include "sysemu/hax.h"
 #include "qmp-commands.h"
 #include "exec/exec-all.h"
 
@@ -1221,6 +1222,39 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     return NULL;
 }
 
+static void *qemu_hax_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+    int r;
+    qemu_thread_get_self(cpu->thread);
+    qemu_mutex_lock(&qemu_global_mutex);
+
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->created = true;
+    cpu->halted = 0;
+    current_cpu = cpu;
+
+    hax_init_vcpu(cpu);
+    qemu_cond_signal(&qemu_cpu_cond);
+
+    while (1) {
+        if (cpu_can_run(cpu)) {
+            r = hax_smp_cpu_exec(cpu);
+            if (r == EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+
+        while (cpu_thread_is_idle(cpu)) {
+            qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        }
+
+        qemu_wait_io_event_common(cpu);
+    }
+    return NULL;
+}
+
+
 static void qemu_cpu_kick_thread(CPUState *cpu)
 {
 #ifndef _WIN32
@@ -1236,7 +1270,33 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
         exit(1);
     }
 #else /* _WIN32 */
-    abort();
+    if (!qemu_cpu_is_self(cpu)) {
+        CONTEXT context;
+
+        if (SuspendThread(cpu->hThread) == (DWORD)(-1)) {
+            fprintf(stderr, "qemu:%s: GetLastError:%lu\n", __func__,
+                    GetLastError());
+            exit(1);
+        }
+
+        /* On multi-core systems, we are not sure that the thread is actually
+         * suspended until we can get the context.
+         */
+        context.ContextFlags = CONTEXT_CONTROL;
+        while (GetThreadContext(cpu->hThread, &context) != 0) {
+            continue;
+        }
+
+        if (hax_enabled()) {
+            cpu->exit_request = 1;
+        }
+
+        if (ResumeThread(cpu->hThread) == (DWORD)(-1)) {
+            fprintf(stderr, "qemu:%s: GetLastError:%lu\n", __func__,
+                    GetLastError());
+            exit(1);
+        }
+    }
 #endif
 }
 
@@ -1396,6 +1456,9 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     static QemuCond *tcg_halt_cond;
     static QemuThread *tcg_cpu_thread;
 
+    if (hax_enabled())
+        hax_init_vcpu(cpu);
+
     /* share a single thread for all cpus with TCG */
     if (!tcg_cpu_thread) {
         cpu->thread = g_malloc0(sizeof(QemuThread));
@@ -1419,6 +1482,26 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     }
 }
 
+static void qemu_hax_start_vcpu(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+#ifdef _WIN32
+    cpu->hThread = qemu_thread_get_handle(cpu->thread);
+#endif
+    while (!cpu->created) {
+        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+    }
+}
+
 static void qemu_kvm_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -1469,6 +1552,8 @@ void qemu_init_vcpu(CPUState *cpu)
 
     if (kvm_enabled()) {
         qemu_kvm_start_vcpu(cpu);
+    } else if (hax_enabled()) {
+        qemu_hax_start_vcpu(cpu);
     } else if (tcg_enabled()) {
         qemu_tcg_init_vcpu(cpu);
     } else {
diff --git a/exec.c b/exec.c
index 08c558e..25e393d 100644
--- a/exec.c
+++ b/exec.c
@@ -31,6 +31,7 @@
 #include "hw/xen/xen.h"
 #endif
 #include "sysemu/kvm.h"
+#include "sysemu/hax.h"
 #include "sysemu/sysemu.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
@@ -1611,6 +1612,21 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                 qemu_mutex_unlock_ramlist();
                 return;
             }
+            /*
+             * In Hax, the qemu allocate the virtual address, and HAX kernel
+             * populate the memory with physical memory. Currently we have no
+             * paging, so user should make sure enough free memory in advance
+             */
+            if (hax_enabled()) {
+                int ret;
+                ret = hax_populate_ram((uint64_t)(uintptr_t)new_block->host,
+                                       new_block->max_length);
+                if (ret < 0) {
+                    error_setg(errp, "Hax failed to populate ram");
+                    return;
+                }
+            }
+
             memory_try_enable_merging(new_block->host, new_block->max_length);
         }
     }
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index d78c885..3945dfd 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -26,6 +26,7 @@
 #include "hw/i386/apic.h"
 #include "hw/i386/apic_internal.h"
 #include "trace.h"
+#include "sysemu/hax.h"
 #include "sysemu/kvm.h"
 #include "hw/qdev.h"
 #include "hw/sysbus.h"
@@ -316,7 +317,7 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
 
     /* Note: We need at least 1M to map the VAPIC option ROM */
     if (!vapic && s->vapic_control & VAPIC_ENABLE_MASK &&
-        ram_size >= 1024 * 1024) {
+        !hax_enabled() && ram_size >= 1024 * 1024) {
         vapic = sysbus_create_simple("kvmvapic", -1, NULL);
     }
     s->vapic = vapic;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 3f79a8e..ca4d0fb 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -227,6 +227,8 @@ struct CPUWatchpoint {
 struct KVMState;
 struct kvm_run;
 
+struct hax_vcpu_state;
+
 #define TB_JMP_CACHE_BITS 12
 #define TB_JMP_CACHE_SIZE (1 << TB_JMP_CACHE_BITS)
 
@@ -392,6 +394,9 @@ struct CPUState {
        (absolute value) offset as small as possible.  This reduces code
        size, especially for hosts without large memory offsets.  */
     uint32_t tcg_exit_req;
+
+    bool hax_vcpu_dirty;
+    struct hax_vcpu_state *hax_vcpu;
 };
 
 QTAILQ_HEAD(CPUTailQ, CPUState);
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index 03812cf..c9b3105 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -20,6 +20,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
     if (kvm_enabled()) {
         kvm_cpu_synchronize_state(cpu);
     }
+    if (hax_enabled()) {
+        hax_cpu_synchronize_state(cpu);
+    }
 }
 
 static inline void cpu_synchronize_post_reset(CPUState *cpu)
@@ -27,6 +30,9 @@ static inline void cpu_synchronize_post_reset(CPUState *cpu)
     if (kvm_enabled()) {
         kvm_cpu_synchronize_post_reset(cpu);
     }
+    if (hax_enabled()) {
+        hax_cpu_synchronize_post_reset(cpu);
+    }
 }
 
 static inline void cpu_synchronize_post_init(CPUState *cpu)
@@ -34,6 +40,9 @@ static inline void cpu_synchronize_post_init(CPUState *cpu)
     if (kvm_enabled()) {
         kvm_cpu_synchronize_post_init(cpu);
     }
+    if (hax_enabled()) {
+        hax_cpu_synchronize_post_init(cpu);
+    }
 }
 
 #endif /* QEMU_HW_ACCEL_H */
diff --git a/qemu-options.hx b/qemu-options.hx
index c534a2f..7fc2807 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3280,6 +3280,17 @@ Enable KVM full virtualization support. This option is only available
 if KVM support is enabled when compiling.
 ETEXI
 
+DEF("enable-hax", 0, QEMU_OPTION_enable_hax, \
+    "-enable-hax     enable HAX virtualization support\n", QEMU_ARCH_I386)
+STEXI
+@item -enable-hax
+@findex -enable-hax
+Enable HAX (Hardware-based Acceleration eXecution) support. This option
+is only available if HAX support is enabled when compiling. HAX is only
+applicable to MAC and Windows platform, and thus does not conflict with
+KVM.
+ETEXI
+
 DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
     "-xen-domid id   specify xen guest domain id\n", QEMU_ARCH_ALL)
 DEF("xen-create", 0, QEMU_OPTION_xen_create,
diff --git a/target-i386/Makefile.objs b/target-i386/Makefile.objs
index b223d79..acbe7b0 100644
--- a/target-i386/Makefile.objs
+++ b/target-i386/Makefile.objs
@@ -5,3 +5,7 @@ obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o hyperv.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+# HAX support
+ifdef CONFIG_WIN32
+obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
+endif
diff --git a/vl.c b/vl.c
index d77dd86..47bbfe7 100644
--- a/vl.c
+++ b/vl.c
@@ -92,6 +92,7 @@ int main(int argc, char **argv)
 #include "sysemu/cpus.h"
 #include "migration/colo.h"
 #include "sysemu/kvm.h"
+#include "sysemu/hax.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
@@ -1959,7 +1960,7 @@ static void main_loop(void)
     int64_t ti;
 #endif
     do {
-        nonblocking = !kvm_enabled() && !xen_enabled() && last_io > 0;
+        nonblocking = tcg_enabled() && last_io > 0;
 #ifdef CONFIG_PROFILER
         ti = profile_getclock();
 #endif
@@ -3724,6 +3725,10 @@ int main(int argc, char **argv, char **envp)
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=kvm", false);
                 break;
+            case QEMU_OPTION_enable_hax:
+                olist = qemu_find_opts("machine");
+                qemu_opts_parse_noisily(olist, "accel=hax", false);
+                break;
             case QEMU_OPTION_M:
             case QEMU_OPTION_machine:
                 olist = qemu_find_opts("machine");
@@ -4418,8 +4423,8 @@ int main(int argc, char **argv, char **envp)
 
     cpu_ticks_init();
     if (icount_opts) {
-        if (kvm_enabled() || xen_enabled()) {
-            error_report("-icount is not allowed with kvm or xen");
+        if (!tcg_enabled()) {
+            error_report("-icount is not allowed with hardware virtualization");
             exit(1);
         }
         configure_icount(icount_opts, &error_abort);
@@ -4555,6 +4560,10 @@ int main(int argc, char **argv, char **envp)
 
     numa_post_machine_init();
 
+    if (hax_enabled()) {
+        hax_sync_vcpus();
+    }
+
     if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
                           parse_fw_cfg, fw_cfg_find(), NULL) != 0) {
         exit(1);
-- 
2.8.0.rc3.226.g39d4020
