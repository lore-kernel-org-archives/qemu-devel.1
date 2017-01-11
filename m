Received: from eggs.gnu.org ([2001:4830:134:3::10]:45667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgv-0003dZ-PL
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgt-0003h0-Vn
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:13 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:33895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgt-0003fi-MY
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:11 -0500
Received: by mail-wj0-x242.google.com with SMTP id qs7so54429066wjc.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:36:11 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:25 +0100
Message-Id: <1484163327-111841-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/33] Plumb the HAXM-based hardware
 acceleration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vincent Palatin <vpalatin@chromium.org>

From: Vincent Palatin <vpalatin@chromium.org>

Use the Intel HAX is kernel-based hardware acceleration module for
Windows (similar to KVM on Linux).

Based on the "target/i386: Add Intel HAX to android emulator" patch
from David Chou <david.j.chou@intel.com>

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Message-Id: <7b9cae28a0c379ab459c7a8545c9a39762bd394f.1484045952.git.vpalatin@chromium.org>
[Drop hax_populate_ram stub. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target           |  1 +
 configure                 | 18 +++++++++++
 cpus.c                    | 78 ++++++++++++++++++++++++++++++++++++++++++++++-
 hax-stub.c                |  5 ---
 hw/intc/apic_common.c     |  3 +-
 include/qom/cpu.h         |  5 +++
 include/sysemu/hw_accel.h |  9 ++++++
 qemu-options.hx           | 11 +++++++
 target/i386/Makefile.objs |  4 +++
 util/qemu-thread-win32.c  |  4 +--
 vl.c                      | 15 +++++++--
 11 files changed, 141 insertions(+), 12 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 9e8edd9..fa2b151 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -97,6 +97,7 @@ obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-y += tcg-runtime.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
+obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 
 obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decContext.o
diff --git a/configure b/configure
index 9879c65..091ae05 100755
--- a/configure
+++ b/configure
@@ -228,6 +228,7 @@ vhost_net="no"
 vhost_scsi="no"
 vhost_vsock="no"
 kvm="no"
+hax="no"
 rdma=""
 gprof="no"
 debug_tcg="no"
@@ -561,6 +562,7 @@ CYGWIN*)
 ;;
 MINGW32*)
   mingw32="yes"
+  hax="yes"
   audio_possible_drivers="dsound sdl"
   if check_include dsound.h; then
     audio_drv_list="dsound"
@@ -610,6 +612,7 @@ OpenBSD)
 Darwin)
   bsd="yes"
   darwin="yes"
+  hax="yes"
   LDFLAGS_SHARED="-bundle -undefined dynamic_lookup"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
@@ -919,6 +922,10 @@ for opt do
   ;;
   --enable-kvm) kvm="yes"
   ;;
+  --disable-hax) hax="no"
+  ;;
+  --enable-hax) hax="yes"
+  ;;
   --disable-tcg-interpreter) tcg_interpreter="no"
   ;;
   --enable-tcg-interpreter) tcg_interpreter="yes"
@@ -1367,6 +1374,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   fdt             fdt device tree
   bluez           bluez stack connectivity
   kvm             KVM acceleration support
+  hax             HAX acceleration support
   rdma            RDMA-based migration support
   vde             support for vde network
   netmap          support for netmap network
@@ -5056,6 +5064,7 @@ echo "Linux AIO support $linux_aio"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
 echo "KVM support       $kvm"
+echo "HAX support       $hax"
 echo "RDMA support      $rdma"
 echo "TCG interpreter   $tcg_interpreter"
 echo "fdt support       $fdt"
@@ -6039,6 +6048,15 @@ case "$target_name" in
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
index fc78502..71a82e5 100644
--- a/cpus.c
+++ b/cpus.c
@@ -35,6 +35,7 @@
 #include "sysemu/dma.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
+#include "sysemu/hax.h"
 #include "qmp-commands.h"
 #include "exec/exec-all.h"
 
@@ -1221,6 +1222,46 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
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
+#ifdef _WIN32
+        SleepEx(0, TRUE);
+#endif
+        qemu_wait_io_event_common(cpu);
+    }
+    return NULL;
+}
+
+#ifdef _WIN32
+static void CALLBACK dummy_apc_func(ULONG_PTR unused)
+{
+}
+#endif
+
 static void qemu_cpu_kick_thread(CPUState *cpu)
 {
 #ifndef _WIN32
@@ -1236,7 +1277,13 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
         exit(1);
     }
 #else /* _WIN32 */
-    abort();
+    if (!qemu_cpu_is_self(cpu)) {
+        if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
+            fprintf(stderr, "%s: QueueUserAPC failed with error %lu\n",
+                    __func__, GetLastError());
+            exit(1);
+        }
+    }
 #endif
 }
 
@@ -1259,6 +1306,13 @@ void qemu_cpu_kick(CPUState *cpu)
     if (tcg_enabled()) {
         qemu_cpu_kick_no_halt();
     } else {
+        if (hax_enabled()) {
+            /*
+             * FIXME: race condition with the exit_request check in
+             * hax_vcpu_hax_exec
+             */
+            cpu->exit_request = 1;
+        }
         qemu_cpu_kick_thread(cpu);
     }
 }
@@ -1419,6 +1473,26 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
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
@@ -1469,6 +1543,8 @@ void qemu_init_vcpu(CPUState *cpu)
 
     if (kvm_enabled()) {
         qemu_kvm_start_vcpu(cpu);
+    } else if (hax_enabled()) {
+        qemu_hax_start_vcpu(cpu);
     } else if (tcg_enabled()) {
         qemu_tcg_init_vcpu(cpu);
     } else {
diff --git a/hax-stub.c b/hax-stub.c
index a532dba..c0e6f89 100644
--- a/hax-stub.c
+++ b/hax-stub.c
@@ -23,11 +23,6 @@ int hax_sync_vcpus(void)
     return 0;
 }
 
-int hax_populate_ram(uint64_t va, uint32_t size)
-{
-    return -ENOSYS;
-}
-
 int hax_init_vcpu(CPUState *cpu)
 {
     return -ENOSYS;
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
index b62d2d7..80df526 100644
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
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index b223d79..acbe7b0 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -5,3 +5,7 @@ obj-y += gdbstub.o
 obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o hyperv.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+# HAX support
+ifdef CONFIG_WIN32
+obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
+endif
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 728e76b..95d4ba4 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -497,8 +497,8 @@ HANDLE qemu_thread_get_handle(QemuThread *thread)
 
     EnterCriticalSection(&data->cs);
     if (!data->exited) {
-        handle = OpenThread(SYNCHRONIZE | THREAD_SUSPEND_RESUME, FALSE,
-                            thread->tid);
+        handle = OpenThread(SYNCHRONIZE | THREAD_SUSPEND_RESUME |
+                            THREAD_SET_CONTEXT, FALSE, thread->tid);
     } else {
         handle = NULL;
     }
diff --git a/vl.c b/vl.c
index 99f6e7f..b82f889 100644
--- a/vl.c
+++ b/vl.c
@@ -93,6 +93,7 @@ int main(int argc, char **argv)
 #include "sysemu/cpus.h"
 #include "migration/colo.h"
 #include "sysemu/kvm.h"
+#include "sysemu/hax.h"
 #include "qapi/qmp/qjson.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
@@ -1918,7 +1919,7 @@ static void main_loop(void)
     int64_t ti;
 #endif
     do {
-        nonblocking = !kvm_enabled() && !xen_enabled() && last_io > 0;
+        nonblocking = tcg_enabled() && last_io > 0;
 #ifdef CONFIG_PROFILER
         ti = profile_getclock();
 #endif
@@ -3684,6 +3685,10 @@ int main(int argc, char **argv, char **envp)
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
@@ -4378,8 +4383,8 @@ int main(int argc, char **argv, char **envp)
 
     cpu_ticks_init();
     if (icount_opts) {
-        if (kvm_enabled() || xen_enabled()) {
-            error_report("-icount is not allowed with kvm or xen");
+        if (!tcg_enabled()) {
+            error_report("-icount is not allowed with hardware virtualization");
             exit(1);
         }
         configure_icount(icount_opts, &error_abort);
@@ -4515,6 +4520,10 @@ int main(int argc, char **argv, char **envp)
 
     numa_post_machine_init();
 
+    if (hax_enabled()) {
+        hax_sync_vcpus();
+    }
+
     if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
                           parse_fw_cfg, fw_cfg_find(), NULL) != 0) {
         exit(1);
-- 
1.8.3.1
