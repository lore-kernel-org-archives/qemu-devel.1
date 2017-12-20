Received: from eggs.gnu.org ([2001:4830:134:3::10]:48181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijW-0004ph-53
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRiiw-0002PL-1n
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRiiu-0002Nv-Vw
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:09 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:41 +0100
Message-Id: <20171220180358.29316-3-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/19] i386: hvf: add code base from Google's
 QEMU repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

This file begins tracking the files that will be the code base for HVF
support in QEMU. This code base is part of Google's QEMU version of
their Android emulator, and can be found at
https://android.googlesource.com/platform/external/qemu/+/emu-master-dev

This code is based on Veertu Inc's vdhh (Veertu Desktop Hosted
Hypervisor), found at https://github.com/veertuinc/vdhh. Everything is
appropriately licensed under GPL v2-or-later, except for the code inside
x86_task.c and x86_task.h, which, deriving from KVM (the Linux kernel),
is licensed GPL v2-only.

This code base already implements a very great deal of functionality,
although Google's version removed from Vertuu's the support for APIC
page and hyperv-related stuff. According to the Android Emulator Release
Notes, Revision 26.1.3 (August 2017), "Hypervisor.framework is now
enabled by default on macOS for 32-bit x86 images to improve performance
and macOS compatibility", although we better use with caution for, as the
same Revision warns us, "If you experience issues with it specifically,
please file a bug report...". The code hasn't seen much update in the
last 5 months, so I think that we can further develop the code with
occasional visiting Google's repository to see if there has been any
update.

On top of Google's code, the following changes were made:

- add code to the configure script to support the --enable-hvf argument.
If the OS is Darwin, it checks for presence of HVF in the system. The
patch also adds strings related to HVF in the file qemu-options.hx.
QEMU will only support the modern syntax style '-M accel=hvf' no enable
hvf; the legacy '-enable-hvf' will not be supported.

- fix styling issues

- add glue code to cpus.c

- move HVFX86EmulatorState field to CPUX86State, changing the
the emulation functions to have a parameter with signature 'CPUX86State *'
instead of 'CPUState *' so we don't have to get the 'env'.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
Message-Id: <20170913090522.4022-2-Sergio.G.DelReal@gmail.com>
Message-Id: <20170913090522.4022-3-Sergio.G.DelReal@gmail.com>
Message-Id: <20170913090522.4022-5-Sergio.G.DelReal@gmail.com>
Message-Id: <20170913090522.4022-6-Sergio.G.DelReal@gmail.com>
Message-Id: <20170905035457.3753-7-Sergio.G.DelReal@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                           |   38 +
 cpus.c                              |   89 ++
 include/qemu/typedefs.h             |    1 +
 include/qom/cpu.h                   |    2 +
 include/sysemu/hvf.h                |  102 ++
 qemu-options.hx                     |   10 +-
 target/i386/Makefile.objs           |    1 +
 target/i386/cpu.h                   |   39 +-
 target/i386/hvf-all.c               | 1004 ++++++++++++++++
 target/i386/hvf-i386.h              |   48 +
 target/i386/hvf-utils/Makefile.objs |    1 +
 target/i386/hvf-utils/README.md     |    7 +
 target/i386/hvf-utils/vmcs.h        |  368 ++++++
 target/i386/hvf-utils/vmx.h         |  214 ++++
 target/i386/hvf-utils/x86.c         |  184 +++
 target/i386/hvf-utils/x86.h         |  476 ++++++++
 target/i386/hvf-utils/x86_decode.c  | 2186 +++++++++++++++++++++++++++++++++++
 target/i386/hvf-utils/x86_decode.h  |  325 ++++++
 target/i386/hvf-utils/x86_descr.c   |  124 ++
 target/i386/hvf-utils/x86_descr.h   |   55 +
 target/i386/hvf-utils/x86_emu.c     | 1537 ++++++++++++++++++++++++
 target/i386/hvf-utils/x86_emu.h     |   49 +
 target/i386/hvf-utils/x86_flags.c   |  333 ++++++
 target/i386/hvf-utils/x86_flags.h   |  243 ++++
 target/i386/hvf-utils/x86_gen.h     |   53 +
 target/i386/hvf-utils/x86_mmu.c     |  273 +++++
 target/i386/hvf-utils/x86_mmu.h     |   45 +
 target/i386/hvf-utils/x86hvf.c      |  513 ++++++++
 target/i386/hvf-utils/x86hvf.h      |   39 +
 29 files changed, 8348 insertions(+), 11 deletions(-)
 create mode 100644 include/sysemu/hvf.h
 create mode 100644 target/i386/hvf-all.c
 create mode 100644 target/i386/hvf-i386.h
 create mode 100644 target/i386/hvf-utils/Makefile.objs
 create mode 100644 target/i386/hvf-utils/README.md
 create mode 100644 target/i386/hvf-utils/vmcs.h
 create mode 100644 target/i386/hvf-utils/vmx.h
 create mode 100644 target/i386/hvf-utils/x86.c
 create mode 100644 target/i386/hvf-utils/x86.h
 create mode 100644 target/i386/hvf-utils/x86_decode.c
 create mode 100644 target/i386/hvf-utils/x86_decode.h
 create mode 100644 target/i386/hvf-utils/x86_descr.c
 create mode 100644 target/i386/hvf-utils/x86_descr.h
 create mode 100644 target/i386/hvf-utils/x86_emu.c
 create mode 100644 target/i386/hvf-utils/x86_emu.h
 create mode 100644 target/i386/hvf-utils/x86_flags.c
 create mode 100644 target/i386/hvf-utils/x86_flags.h
 create mode 100644 target/i386/hvf-utils/x86_gen.h
 create mode 100644 target/i386/hvf-utils/x86_mmu.c
 create mode 100644 target/i386/hvf-utils/x86_mmu.h
 create mode 100644 target/i386/hvf-utils/x86hvf.c
 create mode 100644 target/i386/hvf-utils/x86hvf.h

diff --git a/configure b/configure
index 9c8aa5a98b..0b48475500 100755
--- a/configure
+++ b/configure
@@ -211,6 +211,17 @@ supported_xen_target() {
     return 1
 }
 
+supported_hvf_target() {
+    test "$hvf" = "yes" || return 1
+    glob "$1" "*-softmmu" || return 1
+    case "${1%-softmmu}" in
+        x86_64)
+            return 0
+        ;;
+    esac
+    return 1
+}
+
 supported_target() {
     case "$1" in
         *-softmmu)
@@ -236,6 +247,7 @@ supported_target() {
     supported_kvm_target "$1" && return 0
     supported_xen_target "$1" && return 0
     supported_hax_target "$1" && return 0
+    supported_hvf_target "$1" && return 0
     print_error "TCG disabled, but hardware accelerator not available for '$target'"
     return 1
 }
@@ -325,6 +337,7 @@ vhost_vsock="no"
 vhost_user=""
 kvm="no"
 hax="no"
+hvf="no"
 rdma=""
 gprof="no"
 debug_tcg="no"
@@ -740,6 +753,7 @@ Darwin)
   bsd="yes"
   darwin="yes"
   hax="yes"
+  hvf="yes"
   LDFLAGS_SHARED="-bundle -undefined dynamic_lookup"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
@@ -1035,6 +1049,10 @@ for opt do
   ;;
   --enable-hax) hax="yes"
   ;;
+  --disable-hvf) hvf="no"
+  ;;
+  --enable-hvf) hvf="yes"
+  ;;
   --disable-tcg-interpreter) tcg_interpreter="no"
   ;;
   --enable-tcg-interpreter) tcg_interpreter="yes"
@@ -1523,6 +1541,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   bluez           bluez stack connectivity
   kvm             KVM acceleration support
   hax             HAX acceleration support
+  hvf             Hypervisor.framework acceleration support
   rdma            RDMA-based migration support
   vde             support for vde network
   netmap          support for netmap network
@@ -5025,6 +5044,21 @@ then
 fi
 
 
+#################################################
+# Check to see if we have the Hypervisor framework
+if [ "$darwin" == "yes" ] ; then
+  cat > $TMPC << EOF
+#include <Hypervisor/hv.h>
+int main() { return 0;}
+EOF
+  if ! compile_object ""; then
+    hvf='no'
+  else
+    hvf='yes'
+    LDFLAGS="-framework Hypervisor $LDFLAGS"
+  fi
+fi
+
 #################################################
 # Sparc implicitly links with --relax, which is
 # incompatible with -r, so --no-relax should be
@@ -5505,6 +5539,7 @@ if test "$tcg" = "yes" ; then
     echo "TCG debug enabled $debug_tcg"
     echo "TCG interpreter   $tcg_interpreter"
 fi
+echo "HVF support       $hvf"
 echo "RDMA support      $rdma"
 echo "fdt support       $fdt"
 echo "preadv support    $preadv"
@@ -6567,6 +6602,9 @@ fi
 if supported_hax_target $target; then
     echo "CONFIG_HAX=y" >> $config_target_mak
 fi
+if supported_hvf_target $target; then
+    echo "CONFIG_HVF=y" >> $config_target_mak
+fi
 if test "$target_bigendian" = "yes" ; then
   echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
 fi
diff --git a/cpus.c b/cpus.c
index 114c29b6a0..f4a59c27f3 100644
--- a/cpus.c
+++ b/cpus.c
@@ -37,6 +37,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
+#include "sysemu/hvf.h"
 #include "qmp-commands.h"
 #include "exec/exec-all.h"
 
@@ -900,6 +901,10 @@ void cpu_synchronize_all_states(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_state(cpu);
+        /* TODO: move to cpu_synchronize_state() */
+        if (hvf_enabled()) {
+            hvf_cpu_synchronize_state(cpu);
+        }
     }
 }
 
@@ -909,6 +914,10 @@ void cpu_synchronize_all_post_reset(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_post_reset(cpu);
+        /* TODO: move to cpu_synchronize_post_reset() */
+        if (hvf_enabled()) {
+            hvf_cpu_synchronize_post_reset(cpu);
+        }
     }
 }
 
@@ -918,6 +927,10 @@ void cpu_synchronize_all_post_init(void)
 
     CPU_FOREACH(cpu) {
         cpu_synchronize_post_init(cpu);
+        /* TODO: move to cpu_synchronize_post_init() */
+        if (hvf_enabled()) {
+            hvf_cpu_synchronize_post_init(cpu);
+        }
     }
 }
 
@@ -1098,6 +1111,14 @@ static void qemu_kvm_wait_io_event(CPUState *cpu)
     qemu_wait_io_event_common(cpu);
 }
 
+static void qemu_hvf_wait_io_event(CPUState *cpu)
+{
+    while (cpu_thread_is_idle(cpu)) {
+        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+    }
+    qemu_wait_io_event_common(cpu);
+}
+
 static void *qemu_kvm_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
@@ -1435,6 +1456,48 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     return NULL;
 }
 
+/* The HVF-specific vCPU thread function. This one should only run when the host
+ * CPU supports the VMX "unrestricted guest" feature. */
+static void *qemu_hvf_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+
+    int r;
+
+    assert(hvf_enabled());
+
+    rcu_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->can_do_io = 1;
+    current_cpu = cpu;
+
+    hvf_init_vcpu(cpu);
+
+    /* signal CPU creation */
+    cpu->created = true;
+    qemu_cond_signal(&qemu_cpu_cond);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            r = hvf_vcpu_exec(cpu);
+            if (r == EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+        qemu_hvf_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    hvf_vcpu_destroy(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_mutex_unlock_iothread();
+    return NULL;
+}
+
 #ifdef _WIN32
 static void CALLBACK dummy_apc_func(ULONG_PTR unused)
 {
@@ -1524,6 +1587,9 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
         fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
         exit(1);
     }
+    if (hvf_enabled()) {
+        cpu_exit(cpu);
+    }
 #else /* _WIN32 */
     if (!qemu_cpu_is_self(cpu)) {
         if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
@@ -1752,6 +1818,27 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
     }
 }
 
+static void qemu_hvf_start_vcpu(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    /* HVF currently does not support TCG, and only runs in
+     * unrestricted-guest mode. */
+    assert(hvf_enabled());
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+    while (!cpu->created) {
+        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+    }
+}
+
 static void qemu_dummy_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -1789,6 +1876,8 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_kvm_start_vcpu(cpu);
     } else if (hax_enabled()) {
         qemu_hax_start_vcpu(cpu);
+    } else if (hvf_enabled()) {
+        qemu_hvf_start_vcpu(cpu);
     } else if (tcg_enabled()) {
         qemu_tcg_init_vcpu(cpu);
     } else {
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3dbc69b1e9..9bd7a834ba 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -36,6 +36,7 @@ typedef struct FWCfgIoState FWCfgIoState;
 typedef struct FWCfgMemState FWCfgMemState;
 typedef struct FWCfgState FWCfgState;
 typedef struct HCIInfo HCIInfo;
+typedef struct HVFX86EmulatorState HVFX86EmulatorState;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
 typedef struct ISABus ISABus;
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index c2fa151228..93bd546879 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -423,6 +423,8 @@ struct CPUState {
      * unnecessary flushes.
      */
     uint16_t pending_tlb_flush;
+
+    int hvf_fd;
 };
 
 QTAILQ_HEAD(CPUTailQ, CPUState);
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
new file mode 100644
index 0000000000..614a2d203b
--- /dev/null
+++ b/include/sysemu/hvf.h
@@ -0,0 +1,102 @@
+/*
+ * QEMU Hypervisor.framework (HVF) support
+ *
+ * Copyright Google Inc., 2017
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+/* header to be included in non-HVF-specific code */
+#ifndef _HVF_H
+#define _HVF_H
+
+#include "config-host.h"
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/bitops.h"
+#include "exec/memory.h"
+#include "sysemu/accel.h"
+
+extern int hvf_disabled;
+#ifdef CONFIG_HVF
+#include <Hypervisor/hv.h>
+#include <Hypervisor/hv_vmx.h>
+#include <Hypervisor/hv_error.h>
+#include "target/i386/cpu.h"
+#include "hw/hw.h"
+uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
+                                 int reg);
+#define hvf_enabled() !hvf_disabled
+#else
+#define hvf_enabled() 0
+#define hvf_get_supported_cpuid(func, idx, reg) 0
+#endif
+
+typedef struct hvf_slot {
+    uint64_t start;
+    uint64_t size;
+    uint8_t *mem;
+    int slot_id;
+} hvf_slot;
+
+typedef struct hvf_vcpu_caps {
+    uint64_t vmx_cap_pinbased;
+    uint64_t vmx_cap_procbased;
+    uint64_t vmx_cap_procbased2;
+    uint64_t vmx_cap_entry;
+    uint64_t vmx_cap_exit;
+    uint64_t vmx_cap_preemption_timer;
+} hvf_vcpu_caps;
+
+typedef struct HVFState {
+    AccelState parent;
+    hvf_slot slots[32];
+    int num_slots;
+
+    hvf_vcpu_caps *hvf_caps;
+} HVFState;
+extern HVFState *hvf_state;
+
+void hvf_set_phys_mem(MemoryRegionSection *, bool);
+void hvf_handle_io(CPUArchState *, uint16_t, void *,
+                  int, int, int);
+hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
+
+/* Disable HVF if |disable| is 1, otherwise, enable it iff it is supported by
+ * the host CPU. Use hvf_enabled() after this to get the result. */
+void hvf_disable(int disable);
+
+/* Returns non-0 if the host CPU supports the VMX "unrestricted guest" feature
+ * which allows the virtual CPU to directly run in "real mode". If true, this
+ * allows QEMU to run several vCPU threads in parallel (see cpus.c). Otherwise,
+ * only a a single TCG thread can run, and it will call HVF to run the current
+ * instructions, except in case of "real mode" (paging disabled, typically at
+ * boot time), or MMIO operations. */
+
+int hvf_sync_vcpus(void);
+
+int hvf_init_vcpu(CPUState *);
+int hvf_vcpu_exec(CPUState *);
+int hvf_smp_cpu_exec(CPUState *);
+void hvf_cpu_synchronize_state(CPUState *);
+void hvf_cpu_synchronize_post_reset(CPUState *);
+void hvf_cpu_synchronize_post_init(CPUState *);
+void _hvf_cpu_synchronize_post_init(CPUState *, run_on_cpu_data);
+
+void hvf_vcpu_destroy(CPUState *);
+void hvf_raise_event(CPUState *);
+/* void hvf_reset_vcpu_state(void *opaque); */
+void hvf_reset_vcpu(CPUState *);
+void vmx_update_tpr(CPUState *);
+void update_apic_tpr(CPUState *);
+int hvf_put_registers(CPUState *);
+void vmx_clear_int_window_exiting(CPUState *cpu);
+
+#define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
+
+#define HVF_STATE(obj) \
+    OBJECT_CHECK(HVFState, (obj), TYPE_HVF_ACCEL)
+
+#endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 32d9378172..1d9c39b652 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -31,7 +31,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "-machine [type=]name[,prop[=value][,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
-    "                supported accelerators are kvm, xen, hax or tcg (default: tcg)\n"
+    "                supported accelerators are kvm, xen, hax, hvf or tcg (default: tcg)\n"
     "                kernel_irqchip=on|off|split controls accelerated irqchip support (default=off)\n"
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                kvm_shadow_mem=size of KVM shadow MMU in bytes\n"
@@ -66,7 +66,7 @@ Supported machine properties are:
 @table @option
 @item accel=@var{accels1}[:@var{accels2}[:...]]
 This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, hax or tcg can be available. By default, tcg is used. If there is
+kvm, xen, hax, hvf or tcg can be available. By default, tcg is used. If there is
 more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
 @item kernel_irqchip=on|off
@@ -126,13 +126,13 @@ ETEXI
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,thread=single|multi]\n"
-    "                select accelerator (kvm, xen, hax or tcg; use 'help' for a list)\n"
-    "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
+    "                select accelerator (kvm, xen, hax, hvf or tcg; use 'help' for a list)\n"
+    "                thread=single|multi (enable multi-threaded TCG)", QEMU_ARCH_ALL)
 STEXI
 @item -accel @var{name}[,prop=@var{value}[,...]]
 @findex -accel
 This is used to enable an accelerator. Depending on the target architecture,
-kvm, xen, hax or tcg can be available. By default, tcg is used. If there is
+kvm, xen, hax, hvf or tcg can be available. By default, tcg is used. If there is
 more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
 @table @option
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 6a26e9d9f0..0bef89c099 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -12,4 +12,5 @@ obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
 endif
 ifdef CONFIG_DARWIN
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
+obj-$(CONFIG_HVF) += hvf-utils/ hvf-all.o
 endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b086b1528b..9d33186d81 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -30,6 +30,8 @@
 #define TARGET_LONG_BITS 32
 #endif
 
+#include "exec/cpu-defs.h"
+
 /* The x86 has a strong memory model with some store-after-load re-ordering */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
@@ -50,8 +52,6 @@
 
 #define CPUArchState struct CPUX86State
 
-#include "exec/cpu-defs.h"
-
 #ifdef CONFIG_TCG
 #include "fpu/softfloat.h"
 #endif
@@ -82,16 +82,20 @@
 #define R_GS 5
 
 /* segment descriptor fields */
-#define DESC_G_MASK     (1 << 23)
+#define DESC_G_SHIFT    23
+#define DESC_G_MASK     (1 << DESC_G_SHIFT)
 #define DESC_B_SHIFT    22
 #define DESC_B_MASK     (1 << DESC_B_SHIFT)
 #define DESC_L_SHIFT    21 /* x86_64 only : 64 bit code segment */
 #define DESC_L_MASK     (1 << DESC_L_SHIFT)
-#define DESC_AVL_MASK   (1 << 20)
-#define DESC_P_MASK     (1 << 15)
+#define DESC_AVL_SHIFT  20
+#define DESC_AVL_MASK   (1 << DESC_AVL_SHIFT)
+#define DESC_P_SHIFT    15
+#define DESC_P_MASK     (1 << DESC_P_SHIFT)
 #define DESC_DPL_SHIFT  13
 #define DESC_DPL_MASK   (3 << DESC_DPL_SHIFT)
-#define DESC_S_MASK     (1 << 12)
+#define DESC_S_SHIFT    12
+#define DESC_S_MASK     (1 << DESC_S_SHIFT)
 #define DESC_TYPE_SHIFT 8
 #define DESC_TYPE_MASK  (15 << DESC_TYPE_SHIFT)
 #define DESC_A_MASK     (1 << 8)
@@ -631,6 +635,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EBX_AVX512BW (1U << 30) /* AVX-512 Byte and Word Instructions */
 #define CPUID_7_0_EBX_AVX512VL (1U << 31) /* AVX-512 Vector Length Extensions */
 
+#define CPUID_7_0_ECX_AVX512BMI (1U << 1)
 #define CPUID_7_0_ECX_VBMI     (1U << 1)  /* AVX-512 Vector Byte Manipulation Instrs */
 #define CPUID_7_0_ECX_UMIP     (1U << 2)
 #define CPUID_7_0_ECX_PKU      (1U << 3)
@@ -806,6 +811,20 @@ typedef struct SegmentCache {
         float64  _d_##n[(bits)/64]; \
     }
 
+typedef union {
+    uint8_t _b[16];
+    uint16_t _w[8];
+    uint32_t _l[4];
+    uint64_t _q[2];
+} XMMReg;
+
+typedef union {
+    uint8_t _b[32];
+    uint16_t _w[16];
+    uint32_t _l[8];
+    uint64_t _q[4];
+} YMMReg;
+
 typedef MMREG_UNION(ZMMReg, 512) ZMMReg;
 typedef MMREG_UNION(MMXReg, 64)  MMXReg;
 
@@ -1041,7 +1060,11 @@ typedef struct CPUX86State {
     ZMMReg xmm_t0;
     MMXReg mmx_t0;
 
+    XMMReg ymmh_regs[CPU_NB_REGS];
+
     uint64_t opmask_regs[NB_OPMASK_REGS];
+    YMMReg zmmh_regs[CPU_NB_REGS];
+    ZMMReg hi16_zmm_regs[CPU_NB_REGS];
 
     /* sysenter registers */
     uint32_t sysenter_cs;
@@ -1164,11 +1187,15 @@ typedef struct CPUX86State {
     int32_t interrupt_injected;
     uint8_t soft_interrupt;
     uint8_t has_error_code;
+    uint32_t ins_len;
     uint32_t sipi_vector;
     bool tsc_valid;
     int64_t tsc_khz;
     int64_t user_tsc_khz; /* for sanity check only */
     void *kvm_xsave_buf;
+#if defined(CONFIG_HVF)
+    HVFX86EmulatorState *hvf_emul;
+#endif
 
     uint64_t mcg_cap;
     uint64_t mcg_ctl;
diff --git a/target/i386/hvf-all.c b/target/i386/hvf-all.c
new file mode 100644
index 0000000000..b90a9e4254
--- /dev/null
+++ b/target/i386/hvf-all.c
@@ -0,0 +1,1004 @@
+/* Copyright 2008 IBM Corporation
+ *           2008 Red Hat, Inc.
+ * Copyright 2011 Intel Corporation
+ * Copyright 2016 Veertu, Inc.
+ * Copyright 2017 The Android Open Source Project
+ *
+ * QEMU Hypervisor.framework support
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+
+#include "sysemu/hvf.h"
+#include "hvf-i386.h"
+#include "hvf-utils/vmcs.h"
+#include "hvf-utils/vmx.h"
+#include "hvf-utils/x86.h"
+#include "hvf-utils/x86_descr.h"
+#include "hvf-utils/x86_mmu.h"
+#include "hvf-utils/x86_decode.h"
+#include "hvf-utils/x86_emu.h"
+#include "hvf-utils/x86hvf.h"
+
+#include <Hypervisor/hv.h>
+#include <Hypervisor/hv_vmx.h>
+
+#include "exec/address-spaces.h"
+#include "exec/exec-all.h"
+#include "exec/ioport.h"
+#include "hw/i386/apic_internal.h"
+#include "hw/boards.h"
+#include "qemu/main-loop.h"
+#include "strings.h"
+#include "trace.h"
+#include "sysemu/accel.h"
+#include "sysemu/sysemu.h"
+#include "target/i386/cpu.h"
+
+pthread_rwlock_t mem_lock = PTHREAD_RWLOCK_INITIALIZER;
+HVFState *hvf_state;
+int hvf_disabled = 1;
+
+static void assert_hvf_ok(hv_return_t ret)
+{
+    if (ret == HV_SUCCESS) {
+        return;
+    }
+
+    switch (ret) {
+    case HV_ERROR:
+        error_report("Error: HV_ERROR\n");
+        break;
+    case HV_BUSY:
+        error_report("Error: HV_BUSY\n");
+        break;
+    case HV_BAD_ARGUMENT:
+        error_report("Error: HV_BAD_ARGUMENT\n");
+        break;
+    case HV_NO_RESOURCES:
+        error_report("Error: HV_NO_RESOURCES\n");
+        break;
+    case HV_NO_DEVICE:
+        error_report("Error: HV_NO_DEVICE\n");
+        break;
+    case HV_UNSUPPORTED:
+        error_report("Error: HV_UNSUPPORTED\n");
+        break;
+    default:
+        error_report("Unknown Error\n");
+    }
+
+    abort();
+}
+
+/* Memory slots */
+hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t end)
+{
+    hvf_slot *slot;
+    int x;
+    for (x = 0; x < hvf_state->num_slots; ++x) {
+        slot = &hvf_state->slots[x];
+        if (slot->size && start < (slot->start + slot->size) &&
+            end > slot->start) {
+            return slot;
+        }
+    }
+    return NULL;
+}
+
+struct mac_slot {
+    int present;
+    uint64_t size;
+    uint64_t gpa_start;
+    uint64_t gva;
+};
+
+struct mac_slot mac_slots[32];
+#define ALIGN(x, y)  (((x) + (y) - 1) & ~((y) - 1))
+
+static int do_hvf_set_memory(hvf_slot *slot)
+{
+    struct mac_slot *macslot;
+    hv_memory_flags_t flags;
+    hv_return_t ret;
+
+    macslot = &mac_slots[slot->slot_id];
+
+    if (macslot->present) {
+        if (macslot->size != slot->size) {
+            macslot->present = 0;
+            ret = hv_vm_unmap(macslot->gpa_start, macslot->size);
+            assert_hvf_ok(ret);
+        }
+    }
+
+    if (!slot->size) {
+        return 0;
+    }
+
+    flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
+
+    macslot->present = 1;
+    macslot->gpa_start = slot->start;
+    macslot->size = slot->size;
+    ret = hv_vm_map((hv_uvaddr_t)slot->mem, slot->start, slot->size, flags);
+    assert_hvf_ok(ret);
+    return 0;
+}
+
+void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
+{
+    hvf_slot *mem;
+    MemoryRegion *area = section->mr;
+
+    if (!memory_region_is_ram(area)) {
+        return;
+    }
+
+    mem = hvf_find_overlap_slot(
+            section->offset_within_address_space,
+            section->offset_within_address_space + int128_get64(section->size));
+
+    if (mem && add) {
+        if (mem->size == int128_get64(section->size) &&
+            mem->start == section->offset_within_address_space &&
+            mem->mem == (memory_region_get_ram_ptr(area) +
+            section->offset_within_region)) {
+            return; /* Same region was attempted to register, go away. */
+        }
+    }
+
+    /* Region needs to be reset. set the size to 0 and remap it. */
+    if (mem) {
+        mem->size = 0;
+        if (do_hvf_set_memory(mem)) {
+            error_report("Failed to reset overlapping slot\n");
+            abort();
+        }
+    }
+
+    if (!add) {
+        return;
+    }
+
+    /* Now make a new slot. */
+    int x;
+
+    for (x = 0; x < hvf_state->num_slots; ++x) {
+        mem = &hvf_state->slots[x];
+        if (!mem->size) {
+            break;
+        }
+    }
+
+    if (x == hvf_state->num_slots) {
+        error_report("No free slots\n");
+        abort();
+    }
+
+    mem->size = int128_get64(section->size);
+    mem->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
+    mem->start = section->offset_within_address_space;
+
+    if (do_hvf_set_memory(mem)) {
+        error_report("Error registering new memory slot\n");
+        abort();
+    }
+}
+
+void vmx_update_tpr(CPUState *cpu)
+{
+    /* TODO: need integrate APIC handling */
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    int tpr = cpu_get_apic_tpr(x86_cpu->apic_state) << 4;
+    int irr = apic_get_highest_priority_irr(x86_cpu->apic_state);
+
+    wreg(cpu->hvf_fd, HV_X86_TPR, tpr);
+    if (irr == -1) {
+        wvmcs(cpu->hvf_fd, VMCS_TPR_THRESHOLD, 0);
+    } else {
+        wvmcs(cpu->hvf_fd, VMCS_TPR_THRESHOLD, (irr > tpr) ? tpr >> 4 :
+              irr >> 4);
+    }
+}
+
+void update_apic_tpr(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    int tpr = rreg(cpu->hvf_fd, HV_X86_TPR) >> 4;
+    cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
+}
+
+#define VECTORING_INFO_VECTOR_MASK     0xff
+
+// TODO: taskswitch handling
+static void save_state_to_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
+{
+    /* CR3 and ldt selector are not saved intentionally */
+    tss->eip = EIP(cpu);
+    tss->eflags = EFLAGS(cpu);
+    tss->eax = EAX(cpu);
+    tss->ecx = ECX(cpu);
+    tss->edx = EDX(cpu);
+    tss->ebx = EBX(cpu);
+    tss->esp = ESP(cpu);
+    tss->ebp = EBP(cpu);
+    tss->esi = ESI(cpu);
+    tss->edi = EDI(cpu);
+
+    tss->es = vmx_read_segment_selector(cpu, REG_SEG_ES).sel;
+    tss->cs = vmx_read_segment_selector(cpu, REG_SEG_CS).sel;
+    tss->ss = vmx_read_segment_selector(cpu, REG_SEG_SS).sel;
+    tss->ds = vmx_read_segment_selector(cpu, REG_SEG_DS).sel;
+    tss->fs = vmx_read_segment_selector(cpu, REG_SEG_FS).sel;
+    tss->gs = vmx_read_segment_selector(cpu, REG_SEG_GS).sel;
+}
+
+static void load_state_from_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
+{
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_CR3, tss->cr3);
+
+    RIP(cpu) = tss->eip;
+    EFLAGS(cpu) = tss->eflags | 2;
+
+    /* General purpose registers */
+    RAX(cpu) = tss->eax;
+    RCX(cpu) = tss->ecx;
+    RDX(cpu) = tss->edx;
+    RBX(cpu) = tss->ebx;
+    RSP(cpu) = tss->esp;
+    RBP(cpu) = tss->ebp;
+    RSI(cpu) = tss->esi;
+    RDI(cpu) = tss->edi;
+
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ldt}}, REG_SEG_LDTR);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->es}}, REG_SEG_ES);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->cs}}, REG_SEG_CS);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ss}}, REG_SEG_SS);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->ds}}, REG_SEG_DS);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->fs}}, REG_SEG_FS);
+    vmx_write_segment_selector(cpu, (x68_segment_selector){{tss->gs}}, REG_SEG_GS);
+
+#if 0
+    load_segment(cpu, REG_SEG_LDTR, tss->ldt);
+    load_segment(cpu, REG_SEG_ES, tss->es);
+    load_segment(cpu, REG_SEG_CS, tss->cs);
+    load_segment(cpu, REG_SEG_SS, tss->ss);
+    load_segment(cpu, REG_SEG_DS, tss->ds);
+    load_segment(cpu, REG_SEG_FS, tss->fs);
+    load_segment(cpu, REG_SEG_GS, tss->gs);
+#endif
+}
+
+static int task_switch_32(CPUState *cpu, x68_segment_selector tss_sel, x68_segment_selector old_tss_sel,
+                          uint64_t old_tss_base, struct x86_segment_descriptor *new_desc)
+{
+    struct x86_tss_segment32 tss_seg;
+    uint32_t new_tss_base = x86_segment_base(new_desc);
+    uint32_t eip_offset = offsetof(struct x86_tss_segment32, eip);
+    uint32_t ldt_sel_offset = offsetof(struct x86_tss_segment32, ldt);
+
+    vmx_read_mem(cpu, &tss_seg, old_tss_base, sizeof(tss_seg));
+    save_state_to_tss32(cpu, &tss_seg);
+
+    vmx_write_mem(cpu, old_tss_base + eip_offset, &tss_seg.eip, ldt_sel_offset - eip_offset);
+    vmx_read_mem(cpu, &tss_seg, new_tss_base, sizeof(tss_seg));
+
+    if (old_tss_sel.sel != 0xffff) {
+        tss_seg.prev_tss = old_tss_sel.sel;
+
+        vmx_write_mem(cpu, new_tss_base, &tss_seg.prev_tss, sizeof(tss_seg.prev_tss));
+    }
+    load_state_from_tss32(cpu, &tss_seg);
+    return 0;
+}
+
+static void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int reason, bool gate_valid, uint8_t gate, uint64_t gate_type)
+{
+    uint64_t rip = rreg(cpu->hvf_fd, HV_X86_RIP);
+    if (!gate_valid || (gate_type != VMCS_INTR_T_HWEXCEPTION &&
+                        gate_type != VMCS_INTR_T_HWINTR &&
+                        gate_type != VMCS_INTR_T_NMI)) {
+        int ins_len = rvmcs(cpu->hvf_fd, VMCS_EXIT_INSTRUCTION_LENGTH);
+        macvm_set_rip(cpu, rip + ins_len);
+        return;
+    }
+
+    load_regs(cpu);
+
+    struct x86_segment_descriptor curr_tss_desc, next_tss_desc;
+    int ret;
+    x68_segment_selector old_tss_sel = vmx_read_segment_selector(cpu, REG_SEG_TR);
+    uint64_t old_tss_base = vmx_read_segment_base(cpu, REG_SEG_TR);
+    uint32_t desc_limit;
+    struct x86_call_gate task_gate_desc;
+    struct vmx_segment vmx_seg;
+
+    x86_read_segment_descriptor(cpu, &next_tss_desc, tss_sel);
+    x86_read_segment_descriptor(cpu, &curr_tss_desc, old_tss_sel);
+
+    if (reason == TSR_IDT_GATE && gate_valid) {
+        int dpl;
+
+        ret = x86_read_call_gate(cpu, &task_gate_desc, gate);
+
+        dpl = task_gate_desc.dpl;
+        x68_segment_selector cs = vmx_read_segment_selector(cpu, REG_SEG_CS);
+        if (tss_sel.rpl > dpl || cs.rpl > dpl)
+            ;//DPRINTF("emulate_gp");
+    }
+
+    desc_limit = x86_segment_limit(&next_tss_desc);
+    if (!next_tss_desc.p || ((desc_limit < 0x67 && (next_tss_desc.type & 8)) || desc_limit < 0x2b)) {
+        VM_PANIC("emulate_ts");
+    }
+
+    if (reason == TSR_IRET || reason == TSR_JMP) {
+        curr_tss_desc.type &= ~(1 << 1); /* clear busy flag */
+        x86_write_segment_descriptor(cpu, &curr_tss_desc, old_tss_sel);
+    }
+
+    if (reason == TSR_IRET)
+        EFLAGS(cpu) &= ~RFLAGS_NT;
+
+    if (reason != TSR_CALL && reason != TSR_IDT_GATE)
+        old_tss_sel.sel = 0xffff;
+
+    if (reason != TSR_IRET) {
+        next_tss_desc.type |= (1 << 1); /* set busy flag */
+        x86_write_segment_descriptor(cpu, &next_tss_desc, tss_sel);
+    }
+
+    if (next_tss_desc.type & 8)
+        ret = task_switch_32(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
+    else
+        //ret = task_switch_16(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
+        VM_PANIC("task_switch_16");
+
+    macvm_set_cr0(cpu->hvf_fd, rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0) | CR0_TS);
+    x86_segment_descriptor_to_vmx(cpu, tss_sel, &next_tss_desc, &vmx_seg);
+    vmx_write_segment_descriptor(cpu, &vmx_seg, REG_SEG_TR);
+
+    store_regs(cpu);
+
+    hv_vcpu_invalidate_tlb(cpu->hvf_fd);
+    hv_vcpu_flush(cpu->hvf_fd);
+}
+
+static void hvf_handle_interrupt(CPUState * cpu, int mask)
+{
+    cpu->interrupt_request |= mask;
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    }
+}
+
+void hvf_handle_io(CPUArchState *env, uint16_t port, void *buffer,
+                  int direction, int size, int count)
+{
+    int i;
+    uint8_t *ptr = buffer;
+
+    for (i = 0; i < count; i++) {
+        address_space_rw(&address_space_io, port, MEMTXATTRS_UNSPECIFIED,
+                         ptr, size,
+                         direction);
+        ptr += size;
+    }
+}
+
+/* TODO: synchronize vcpu state */
+static void do_hvf_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
+{
+    CPUState *cpu_state = cpu;
+    if (cpu_state->vcpu_dirty == 0) {
+        hvf_get_registers(cpu_state);
+    }
+
+    cpu_state->vcpu_dirty = 1;
+}
+
+void hvf_cpu_synchronize_state(CPUState *cpu_state)
+{
+    if (cpu_state->vcpu_dirty == 0) {
+        run_on_cpu(cpu_state, do_hvf_cpu_synchronize_state, RUN_ON_CPU_NULL);
+    }
+}
+
+static void do_hvf_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
+{
+    CPUState *cpu_state = cpu;
+    hvf_put_registers(cpu_state);
+    cpu_state->vcpu_dirty = false;
+}
+
+void hvf_cpu_synchronize_post_reset(CPUState *cpu_state)
+{
+    run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
+}
+
+void _hvf_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
+{
+    CPUState *cpu_state = cpu;
+    hvf_put_registers(cpu_state);
+    cpu_state->vcpu_dirty = false;
+}
+
+void hvf_cpu_synchronize_post_init(CPUState *cpu_state)
+{
+    run_on_cpu(cpu_state, _hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
+}
+
+/* TODO: ept fault handlig */
+static bool ept_emulation_fault(uint64_t ept_qual)
+{
+    int read, write;
+
+    /* EPT fault on an instruction fetch doesn't make sense here */
+    if (ept_qual & EPT_VIOLATION_INST_FETCH) {
+        return false;
+    }
+
+    /* EPT fault must be a read fault or a write fault */
+    read = ept_qual & EPT_VIOLATION_DATA_READ ? 1 : 0;
+    write = ept_qual & EPT_VIOLATION_DATA_WRITE ? 1 : 0;
+    if ((read | write) == 0) {
+        return false;
+    }
+
+    /*
+     * The EPT violation must have been caused by accessing a
+     * guest-physical address that is a translation of a guest-linear
+     * address.
+     */
+    if ((ept_qual & EPT_VIOLATION_GLA_VALID) == 0 ||
+        (ept_qual & EPT_VIOLATION_XLAT_VALID) == 0) {
+        return false;
+    }
+
+    return true;
+}
+
+static void hvf_region_add(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    hvf_set_phys_mem(section, true);
+}
+
+static void hvf_region_del(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    hvf_set_phys_mem(section, false);
+}
+
+static MemoryListener hvf_memory_listener = {
+    .priority = 10,
+    .region_add = hvf_region_add,
+    .region_del = hvf_region_del,
+};
+
+void hvf_reset_vcpu(CPUState *cpu) {
+
+    /* TODO: this shouldn't be needed; there is already a call to
+     * cpu_synchronize_all_post_reset in vl.c
+     */
+    wvmcs(cpu->hvf_fd, VMCS_ENTRY_CTLS, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER, 0);
+    macvm_set_cr0(cpu->hvf_fd, 0x60000010);
+
+    wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK);
+    wvmcs(cpu->hvf_fd, VMCS_CR4_SHADOW, 0x0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_CR4, CR4_VMXE_MASK);
+
+    /* set VMCS guest state fields */
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_CS_SELECTOR, 0xf000);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_CS_LIMIT, 0xffff);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_CS_ACCESS_RIGHTS, 0x9b);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_CS_BASE, 0xffff0000);
+
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_DS_SELECTOR, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_DS_LIMIT, 0xffff);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_DS_ACCESS_RIGHTS, 0x93);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_DS_BASE, 0);
+
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_ES_SELECTOR, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_ES_LIMIT, 0xffff);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_ES_ACCESS_RIGHTS, 0x93);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_ES_BASE, 0);
+
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_FS_SELECTOR, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_FS_LIMIT, 0xffff);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_FS_ACCESS_RIGHTS, 0x93);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_FS_BASE, 0);
+
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_GS_SELECTOR, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_GS_LIMIT, 0xffff);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_GS_ACCESS_RIGHTS, 0x93);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_GS_BASE, 0);
+
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_SS_SELECTOR, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_SS_LIMIT, 0xffff);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_SS_ACCESS_RIGHTS, 0x93);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_SS_BASE, 0);
+
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_SELECTOR, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_LIMIT, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_ACCESS_RIGHTS, 0x10000);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_BASE, 0);
+
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_TR_SELECTOR, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_TR_LIMIT, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_TR_ACCESS_RIGHTS, 0x83);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_TR_BASE, 0);
+
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_GDTR_LIMIT, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_GDTR_BASE, 0);
+
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_IDTR_LIMIT, 0);
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_IDTR_BASE, 0);
+
+    /*wvmcs(cpu->hvf_fd, VMCS_GUEST_CR2, 0x0);*/
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_CR3, 0x0);
+
+    wreg(cpu->hvf_fd, HV_X86_RIP, 0xfff0);
+    wreg(cpu->hvf_fd, HV_X86_RDX, 0x623);
+    wreg(cpu->hvf_fd, HV_X86_RFLAGS, 0x2);
+    wreg(cpu->hvf_fd, HV_X86_RSP, 0x0);
+    wreg(cpu->hvf_fd, HV_X86_RAX, 0x0);
+    wreg(cpu->hvf_fd, HV_X86_RBX, 0x0);
+    wreg(cpu->hvf_fd, HV_X86_RCX, 0x0);
+    wreg(cpu->hvf_fd, HV_X86_RSI, 0x0);
+    wreg(cpu->hvf_fd, HV_X86_RDI, 0x0);
+    wreg(cpu->hvf_fd, HV_X86_RBP, 0x0);
+
+    for (int i = 0; i < 8; i++) {
+        wreg(cpu->hvf_fd, HV_X86_R8 + i, 0x0);
+    }
+
+    hv_vm_sync_tsc(0);
+    cpu->halted = 0;
+    hv_vcpu_invalidate_tlb(cpu->hvf_fd);
+    hv_vcpu_flush(cpu->hvf_fd);
+}
+
+void hvf_vcpu_destroy(CPUState *cpu)
+{
+    hv_return_t ret = hv_vcpu_destroy((hv_vcpuid_t)cpu->hvf_fd);
+    assert_hvf_ok(ret);
+}
+
+static void dummy_signal(int sig)
+{
+}
+
+int hvf_init_vcpu(CPUState *cpu)
+{
+
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int r;
+
+    /* init cpu signals */
+    sigset_t set;
+    struct sigaction sigact;
+
+    memset(&sigact, 0, sizeof(sigact));
+    sigact.sa_handler = dummy_signal;
+    sigaction(SIG_IPI, &sigact, NULL);
+
+    pthread_sigmask(SIG_BLOCK, NULL, &set);
+    sigdelset(&set, SIG_IPI);
+
+    init_emu();
+    init_decoder();
+
+    hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
+    env->hvf_emul = g_new0(HVFX86EmulatorState, 1);
+
+    r = hv_vcpu_create((hv_vcpuid_t *)&cpu->hvf_fd, HV_VCPU_DEFAULT);
+    cpu->vcpu_dirty = 1;
+    assert_hvf_ok(r);
+
+    if (hv_vmx_read_capability(HV_VMX_CAP_PINBASED,
+        &hvf_state->hvf_caps->vmx_cap_pinbased)) {
+        abort();
+    }
+    if (hv_vmx_read_capability(HV_VMX_CAP_PROCBASED,
+        &hvf_state->hvf_caps->vmx_cap_procbased)) {
+        abort();
+    }
+    if (hv_vmx_read_capability(HV_VMX_CAP_PROCBASED2,
+        &hvf_state->hvf_caps->vmx_cap_procbased2)) {
+        abort();
+    }
+    if (hv_vmx_read_capability(HV_VMX_CAP_ENTRY,
+        &hvf_state->hvf_caps->vmx_cap_entry)) {
+        abort();
+    }
+
+    /* set VMCS control fields */
+    wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
+          cap2ctrl(hvf_state->hvf_caps->vmx_cap_pinbased, 0));
+    wvmcs(cpu->hvf_fd, VMCS_PRI_PROC_BASED_CTLS,
+          cap2ctrl(hvf_state->hvf_caps->vmx_cap_procbased,
+          VMCS_PRI_PROC_BASED_CTLS_HLT |
+          VMCS_PRI_PROC_BASED_CTLS_MWAIT |
+          VMCS_PRI_PROC_BASED_CTLS_TSC_OFFSET |
+          VMCS_PRI_PROC_BASED_CTLS_TPR_SHADOW) |
+          VMCS_PRI_PROC_BASED_CTLS_SEC_CONTROL);
+    wvmcs(cpu->hvf_fd, VMCS_SEC_PROC_BASED_CTLS,
+          cap2ctrl(hvf_state->hvf_caps->vmx_cap_procbased2,
+                   VMCS_PRI_PROC_BASED2_CTLS_APIC_ACCESSES));
+
+    wvmcs(cpu->hvf_fd, VMCS_ENTRY_CTLS, cap2ctrl(hvf_state->hvf_caps->vmx_cap_entry,
+          0));
+    wvmcs(cpu->hvf_fd, VMCS_EXCEPTION_BITMAP, 0); /* Double fault */
+
+    wvmcs(cpu->hvf_fd, VMCS_TPR_THRESHOLD, 0);
+
+    hvf_reset_vcpu(cpu);
+
+    x86cpu = X86_CPU(cpu);
+    x86cpu->env.kvm_xsave_buf = qemu_memalign(4096,
+                                 sizeof(struct hvf_xsave_buf));
+
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_STAR, 1);
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_LSTAR, 1);
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_CSTAR, 1);
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_FMASK, 1);
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_FSBASE, 1);
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_GSBASE, 1);
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_KERNELGSBASE, 1);
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_TSC_AUX, 1);
+    /*hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_TSC, 1);*/
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_SYSENTER_CS, 1);
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_SYSENTER_EIP, 1);
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_SYSENTER_ESP, 1);
+
+    return 0;
+}
+
+void hvf_disable(int shouldDisable)
+{
+    hvf_disabled = shouldDisable;
+}
+
+int hvf_vcpu_exec(CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    int ret = 0;
+    uint64_t rip = 0;
+
+    cpu->halted = 0;
+
+    if (hvf_process_events(cpu)) {
+        return EXCP_HLT;
+    }
+
+    do {
+        if (cpu->vcpu_dirty) {
+            hvf_put_registers(cpu);
+            cpu->vcpu_dirty = false;
+        }
+
+        env->hvf_emul->interruptable =
+            !(rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY) &
+             (VMCS_INTERRUPTIBILITY_STI_BLOCKING |
+             VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING));
+
+        hvf_inject_interrupts(cpu);
+        vmx_update_tpr(cpu);
+
+
+        qemu_mutex_unlock_iothread();
+        if (!cpu_is_bsp(X86_CPU(cpu)) && cpu->halted) {
+            qemu_mutex_lock_iothread();
+            return EXCP_HLT;
+        }
+
+        hv_return_t r  = hv_vcpu_run(cpu->hvf_fd);
+        assert_hvf_ok(r);
+
+        /* handle VMEXIT */
+        uint64_t exit_reason = rvmcs(cpu->hvf_fd, VMCS_EXIT_REASON);
+        uint64_t exit_qual = rvmcs(cpu->hvf_fd, VMCS_EXIT_QUALIFICATION);
+        uint32_t ins_len = (uint32_t)rvmcs(cpu->hvf_fd,
+                                           VMCS_EXIT_INSTRUCTION_LENGTH);
+        uint64_t idtvec_info = rvmcs(cpu->hvf_fd, VMCS_IDT_VECTORING_INFO);
+        rip = rreg(cpu->hvf_fd, HV_X86_RIP);
+        RFLAGS(env) = rreg(cpu->hvf_fd, HV_X86_RFLAGS);
+        env->eflags = RFLAGS(env);
+
+        qemu_mutex_lock_iothread();
+
+        update_apic_tpr(cpu);
+        current_cpu = cpu;
+
+        ret = 0;
+        switch (exit_reason) {
+        case EXIT_REASON_HLT: {
+            macvm_set_rip(cpu, rip + ins_len);
+            if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+                (EFLAGS(env) & IF_MASK))
+                && !(cpu->interrupt_request & CPU_INTERRUPT_NMI) &&
+                !(idtvec_info & VMCS_IDT_VEC_VALID)) {
+                cpu->halted = 1;
+                ret = EXCP_HLT;
+            }
+            ret = EXCP_INTERRUPT;
+            break;
+        }
+        case EXIT_REASON_MWAIT: {
+            ret = EXCP_INTERRUPT;
+            break;
+        }
+            /* Need to check if MMIO or unmmaped fault */
+        case EXIT_REASON_EPT_FAULT:
+        {
+            hvf_slot *slot;
+            addr_t gpa = rvmcs(cpu->hvf_fd, VMCS_GUEST_PHYSICAL_ADDRESS);
+
+            if (((idtvec_info & VMCS_IDT_VEC_VALID) == 0) &&
+                ((exit_qual & EXIT_QUAL_NMIUDTI) != 0)) {
+                vmx_set_nmi_blocking(cpu);
+            }
+
+            slot = hvf_find_overlap_slot(gpa, gpa);
+            /* mmio */
+            if (ept_emulation_fault(exit_qual) && !slot) {
+                struct x86_decode decode;
+
+                load_regs(cpu);
+                env->hvf_emul->fetch_rip = rip;
+
+                decode_instruction(env, &decode);
+                exec_instruction(env, &decode);
+                store_regs(cpu);
+                break;
+            }
+#ifdef DIRTY_VGA_TRACKING
+            /* TODO: handle dirty page tracking */
+#endif
+            break;
+        }
+        case EXIT_REASON_INOUT:
+        {
+            uint32_t in = (exit_qual & 8) != 0;
+            uint32_t size =  (exit_qual & 7) + 1;
+            uint32_t string =  (exit_qual & 16) != 0;
+            uint32_t port =  exit_qual >> 16;
+            /*uint32_t rep = (exit_qual & 0x20) != 0;*/
+
+#if 1
+            if (!string && in) {
+                uint64_t val = 0;
+                load_regs(cpu);
+                hvf_handle_io(env, port, &val, 0, size, 1);
+                if (size == 1) {
+                    AL(env) = val;
+                } else if (size == 2) {
+                    AX(env) = val;
+                } else if (size == 4) {
+                    RAX(env) = (uint32_t)val;
+                } else {
+                    VM_PANIC("size");
+                }
+                RIP(env) += ins_len;
+                store_regs(cpu);
+                break;
+            } else if (!string && !in) {
+                RAX(env) = rreg(cpu->hvf_fd, HV_X86_RAX);
+                hvf_handle_io(env, port, &RAX(env), 1, size, 1);
+                macvm_set_rip(cpu, rip + ins_len);
+                break;
+            }
+#endif
+            struct x86_decode decode;
+
+            load_regs(cpu);
+            env->hvf_emul->fetch_rip = rip;
+
+            decode_instruction(env, &decode);
+            VM_PANIC_ON(ins_len != decode.len);
+            exec_instruction(env, &decode);
+            store_regs(cpu);
+
+            break;
+        }
+        case EXIT_REASON_CPUID: {
+            uint32_t rax = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RAX);
+            uint32_t rbx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RBX);
+            uint32_t rcx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RCX);
+            uint32_t rdx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RDX);
+
+            cpu_x86_cpuid(env, rax, rcx, &rax, &rbx, &rcx, &rdx);
+
+            wreg(cpu->hvf_fd, HV_X86_RAX, rax);
+            wreg(cpu->hvf_fd, HV_X86_RBX, rbx);
+            wreg(cpu->hvf_fd, HV_X86_RCX, rcx);
+            wreg(cpu->hvf_fd, HV_X86_RDX, rdx);
+
+            macvm_set_rip(cpu, rip + ins_len);
+            break;
+        }
+        case EXIT_REASON_XSETBV: {
+            X86CPU *x86_cpu = X86_CPU(cpu);
+            CPUX86State *env = &x86_cpu->env;
+            uint32_t eax = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RAX);
+            uint32_t ecx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RCX);
+            uint32_t edx = (uint32_t)rreg(cpu->hvf_fd, HV_X86_RDX);
+
+            if (ecx) {
+                macvm_set_rip(cpu, rip + ins_len);
+                break;
+            }
+            env->xcr0 = ((uint64_t)edx << 32) | eax;
+            wreg(cpu->hvf_fd, HV_X86_XCR0, env->xcr0 | 1);
+            macvm_set_rip(cpu, rip + ins_len);
+            break;
+        }
+        case EXIT_REASON_INTR_WINDOW:
+            vmx_clear_int_window_exiting(cpu);
+            ret = EXCP_INTERRUPT;
+            break;
+        case EXIT_REASON_NMI_WINDOW:
+            vmx_clear_nmi_window_exiting(cpu);
+            ret = EXCP_INTERRUPT;
+            break;
+        case EXIT_REASON_EXT_INTR:
+            /* force exit and allow io handling */
+            ret = EXCP_INTERRUPT;
+            break;
+        case EXIT_REASON_RDMSR:
+        case EXIT_REASON_WRMSR:
+        {
+            load_regs(cpu);
+            if (exit_reason == EXIT_REASON_RDMSR) {
+                simulate_rdmsr(cpu);
+            } else {
+                simulate_wrmsr(cpu);
+            }
+            RIP(env) += rvmcs(cpu->hvf_fd, VMCS_EXIT_INSTRUCTION_LENGTH);
+            store_regs(cpu);
+            break;
+        }
+        case EXIT_REASON_CR_ACCESS: {
+            int cr;
+            int reg;
+
+            load_regs(cpu);
+            cr = exit_qual & 15;
+            reg = (exit_qual >> 8) & 15;
+
+            switch (cr) {
+            case 0x0: {
+                macvm_set_cr0(cpu->hvf_fd, RRX(env, reg));
+                break;
+            }
+            case 4: {
+                macvm_set_cr4(cpu->hvf_fd, RRX(env, reg));
+                break;
+            }
+            case 8: {
+                X86CPU *x86_cpu = X86_CPU(cpu);
+                if (exit_qual & 0x10) {
+                    RRX(env, reg) = cpu_get_apic_tpr(x86_cpu->apic_state);
+                } else {
+                    int tpr = RRX(env, reg);
+                    cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
+                    ret = EXCP_INTERRUPT;
+                }
+                break;
+            }
+            default:
+                error_report("Unrecognized CR %d\n", cr);
+                abort();
+            }
+            RIP(env) += ins_len;
+            store_regs(cpu);
+            break;
+        }
+        case EXIT_REASON_APIC_ACCESS: { /* TODO */
+            struct x86_decode decode;
+
+            load_regs(cpu);
+            env->hvf_emul->fetch_rip = rip;
+
+            decode_instruction(env, &decode);
+            exec_instruction(env, &decode);
+            store_regs(cpu);
+            break;
+        }
+        case EXIT_REASON_TPR: {
+            ret = 1;
+            break;
+        }
+        case EXIT_REASON_TASK_SWITCH: {
+            uint64_t vinfo = rvmcs(cpu->hvf_fd, VMCS_IDT_VECTORING_INFO);
+            x68_segment_selector sel = {.sel = exit_qual & 0xffff};
+            vmx_handle_task_switch(cpu, sel, (exit_qual >> 30) & 0x3,
+             vinfo & VMCS_INTR_VALID, vinfo & VECTORING_INFO_VECTOR_MASK, vinfo
+             & VMCS_INTR_T_MASK);
+            break;
+        }
+        case EXIT_REASON_TRIPLE_FAULT: {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            ret = EXCP_INTERRUPT;
+            break;
+        }
+        case EXIT_REASON_RDPMC:
+            wreg(cpu->hvf_fd, HV_X86_RAX, 0);
+            wreg(cpu->hvf_fd, HV_X86_RDX, 0);
+            macvm_set_rip(cpu, rip + ins_len);
+            break;
+        case VMX_REASON_VMCALL:
+            /* TODO: inject #GP fault */
+            break;
+        default:
+            error_report("%llx: unhandled exit %llx\n", rip, exit_reason);
+        }
+    } while (ret == 0);
+
+    return ret;
+}
+
+static bool hvf_allowed;
+
+static int hvf_accel_init(MachineState *ms)
+{
+    int x;
+    hv_return_t ret;
+    HVFState *s;
+
+    hvf_disable(0);
+    ret = hv_vm_create(HV_VM_DEFAULT);
+    assert_hvf_ok(ret);
+
+    s = g_new0(HVFState, 1);
+ 
+    s->num_slots = 32;
+    for (x = 0; x < s->num_slots; ++x) {
+        s->slots[x].size = 0;
+        s->slots[x].slot_id = x;
+    }
+  
+    hvf_state = s;
+    cpu_interrupt_handler = hvf_handle_interrupt;
+    memory_listener_register(&hvf_memory_listener, &address_space_memory);
+    return 0;
+}
+
+static void hvf_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+    ac->name = "HVF";
+    ac->init_machine = hvf_accel_init;
+    ac->allowed = &hvf_allowed;
+}
+
+static const TypeInfo hvf_accel_type = {
+    .name = TYPE_HVF_ACCEL,
+    .parent = TYPE_ACCEL,
+    .class_init = hvf_accel_class_init,
+};
+
+static void hvf_type_init(void)
+{
+    type_register_static(&hvf_accel_type);
+}
+
+type_init(hvf_type_init);
diff --git a/target/i386/hvf-i386.h b/target/i386/hvf-i386.h
new file mode 100644
index 0000000000..797718ce34
--- /dev/null
+++ b/target/i386/hvf-i386.h
@@ -0,0 +1,48 @@
+/*
+ * QEMU Hypervisor.framework (HVF) support
+ *
+ * Copyright 2017 Google Inc
+ *
+ * Adapted from target-i386/hax-i386.h:
+ * Copyright (c) 2011 Intel Corporation
+ *  Written by:
+ *  Jiang Yunhong<yunhong.jiang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef _HVF_I386_H
+#define _HVF_I386_H
+
+#include "sysemu/hvf.h"
+#include "cpu.h"
+#include "hvf-utils/x86.h"
+
+#define HVF_MAX_VCPU 0x10
+#define MAX_VM_ID 0x40
+#define MAX_VCPU_ID 0x40
+
+extern struct hvf_state hvf_global;
+
+struct hvf_vm {
+    int id;
+    struct hvf_vcpu_state *vcpus[HVF_MAX_VCPU];
+};
+
+struct hvf_state {
+    uint32_t version;
+    struct hvf_vm *vm;
+    uint64_t mem_quota;
+};
+
+#ifdef NEED_CPU_H
+/* Functions exported to host specific mode */
+
+/* Host specific functions */
+int hvf_inject_interrupt(CPUArchState *env, int vector);
+int hvf_vcpu_run(struct hvf_vcpu_state *vcpu);
+#endif
+
+#endif
diff --git a/target/i386/hvf-utils/Makefile.objs b/target/i386/hvf-utils/Makefile.objs
new file mode 100644
index 0000000000..7df219ad9c
--- /dev/null
+++ b/target/i386/hvf-utils/Makefile.objs
@@ -0,0 +1 @@
+obj-y += x86.o x86_cpuid.o x86_decode.o x86_descr.o x86_emu.o x86_flags.o x86_mmu.o x86hvf.o
diff --git a/target/i386/hvf-utils/README.md b/target/i386/hvf-utils/README.md
new file mode 100644
index 0000000000..0d27a0d52b
--- /dev/null
+++ b/target/i386/hvf-utils/README.md
@@ -0,0 +1,7 @@
+# OS X Hypervisor.framework support in QEMU
+
+These sources (and ../hvf-all.c) are adapted from Veertu Inc's vdhh (Veertu Desktop Hosted Hypervisor) (last known location: https://github.com/veertuinc/vdhh) with some minor changes, the most significant of which were:
+
+1. Adapt to our current QEMU's `CPUState` structure and `address_space_rw` API; many struct members have been moved around (emulated x86 state, kvm_xsave_buf) due to historical differences + QEMU needing to handle more emulation targets.
+2. Removal of `apic_page` and hyperv-related functionality.
+3. More relaxed use of `qemu_mutex_lock_iothread`.
diff --git a/target/i386/hvf-utils/vmcs.h b/target/i386/hvf-utils/vmcs.h
new file mode 100644
index 0000000000..c410dcfaaa
--- /dev/null
+++ b/target/i386/hvf-utils/vmcs.h
@@ -0,0 +1,368 @@
+/*-
+ * Copyright (c) 2011 NetApp, Inc.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY NETAPP, INC ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL NETAPP, INC OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ * $FreeBSD$
+ */
+
+#ifndef _VMCS_H_
+#define _VMCS_H_
+
+#include <Hypervisor/hv.h>
+#include <Hypervisor/hv_vmx.h>
+
+#define VMCS_INITIAL 0xffffffffffffffff
+
+#define VMCS_IDENT(encoding) ((encoding) | 0x80000000)
+/*
+ * VMCS field encodings from Appendix H, Intel Architecture Manual Vol3B.
+ */
+#define VMCS_INVALID_ENCODING 0xffffffff
+
+/* 16-bit control fields */
+#define VMCS_VPID 0x00000000
+#define VMCS_PIR_VECTOR 0x00000002
+
+/* 16-bit guest-state fields */
+#define VMCS_GUEST_ES_SELECTOR 0x00000800
+#define VMCS_GUEST_CS_SELECTOR 0x00000802
+#define VMCS_GUEST_SS_SELECTOR 0x00000804
+#define VMCS_GUEST_DS_SELECTOR 0x00000806
+#define VMCS_GUEST_FS_SELECTOR 0x00000808
+#define VMCS_GUEST_GS_SELECTOR 0x0000080A
+#define VMCS_GUEST_LDTR_SELECTOR 0x0000080C
+#define VMCS_GUEST_TR_SELECTOR 0x0000080E
+#define VMCS_GUEST_INTR_STATUS 0x00000810
+
+/* 16-bit host-state fields */
+#define VMCS_HOST_ES_SELECTOR 0x00000C00
+#define VMCS_HOST_CS_SELECTOR 0x00000C02
+#define VMCS_HOST_SS_SELECTOR 0x00000C04
+#define VMCS_HOST_DS_SELECTOR 0x00000C06
+#define VMCS_HOST_FS_SELECTOR 0x00000C08
+#define VMCS_HOST_GS_SELECTOR 0x00000C0A
+#define VMCS_HOST_TR_SELECTOR 0x00000C0C
+
+/* 64-bit control fields */
+#define VMCS_IO_BITMAP_A 0x00002000
+#define VMCS_IO_BITMAP_B 0x00002002
+#define VMCS_MSR_BITMAP 0x00002004
+#define VMCS_EXIT_MSR_STORE 0x00002006
+#define VMCS_EXIT_MSR_LOAD 0x00002008
+#define VMCS_ENTRY_MSR_LOAD 0x0000200A
+#define VMCS_EXECUTIVE_VMCS 0x0000200C
+#define VMCS_TSC_OFFSET 0x00002010
+#define VMCS_VIRTUAL_APIC 0x00002012
+#define VMCS_APIC_ACCESS 0x00002014
+#define VMCS_PIR_DESC 0x00002016
+#define VMCS_EPTP 0x0000201A
+#define VMCS_EOI_EXIT0 0x0000201C
+#define VMCS_EOI_EXIT1 0x0000201E
+#define VMCS_EOI_EXIT2 0x00002020
+#define VMCS_EOI_EXIT3 0x00002022
+#define VMCS_EOI_EXIT(vector) (VMCS_EOI_EXIT0 + ((vector) / 64) * 2)
+
+/* 64-bit read-only fields */
+#define VMCS_GUEST_PHYSICAL_ADDRESS 0x00002400
+
+/* 64-bit guest-state fields */
+#define VMCS_LINK_POINTER 0x00002800
+#define VMCS_GUEST_IA32_DEBUGCTL 0x00002802
+#define VMCS_GUEST_IA32_PAT 0x00002804
+#define VMCS_GUEST_IA32_EFER 0x00002806
+#define VMCS_GUEST_IA32_PERF_GLOBAL_CTRL 0x00002808
+#define VMCS_GUEST_PDPTE0 0x0000280A
+#define VMCS_GUEST_PDPTE1 0x0000280C
+#define VMCS_GUEST_PDPTE2 0x0000280E
+#define VMCS_GUEST_PDPTE3 0x00002810
+
+/* 64-bit host-state fields */
+#define VMCS_HOST_IA32_PAT 0x00002C00
+#define VMCS_HOST_IA32_EFER 0x00002C02
+#define VMCS_HOST_IA32_PERF_GLOBAL_CTRL 0x00002C04
+
+/* 32-bit control fields */
+#define VMCS_PIN_BASED_CTLS 0x00004000
+#define VMCS_PRI_PROC_BASED_CTLS 0x00004002
+#define VMCS_EXCEPTION_BITMAP 0x00004004
+#define VMCS_PF_ERROR_MASK 0x00004006
+#define VMCS_PF_ERROR_MATCH 0x00004008
+#define VMCS_CR3_TARGET_COUNT 0x0000400A
+#define VMCS_EXIT_CTLS 0x0000400C
+#define VMCS_EXIT_MSR_STORE_COUNT 0x0000400E
+#define VMCS_EXIT_MSR_LOAD_COUNT 0x00004010
+#define VMCS_ENTRY_CTLS 0x00004012
+#define VMCS_ENTRY_MSR_LOAD_COUNT 0x00004014
+#define VMCS_ENTRY_INTR_INFO 0x00004016
+#define VMCS_ENTRY_EXCEPTION_ERROR 0x00004018
+#define VMCS_ENTRY_INST_LENGTH 0x0000401A
+#define VMCS_TPR_THRESHOLD 0x0000401C
+#define VMCS_SEC_PROC_BASED_CTLS 0x0000401E
+#define VMCS_PLE_GAP 0x00004020
+#define VMCS_PLE_WINDOW 0x00004022
+
+/* 32-bit read-only data fields */
+#define VMCS_INSTRUCTION_ERROR 0x00004400
+#define VMCS_EXIT_REASON 0x00004402
+#define VMCS_EXIT_INTR_INFO 0x00004404
+#define VMCS_EXIT_INTR_ERRCODE 0x00004406
+#define VMCS_IDT_VECTORING_INFO 0x00004408
+#define VMCS_IDT_VECTORING_ERROR 0x0000440A
+#define VMCS_EXIT_INSTRUCTION_LENGTH 0x0000440C
+#define VMCS_EXIT_INSTRUCTION_INFO 0x0000440E
+
+/* 32-bit guest-state fields */
+#define VMCS_GUEST_ES_LIMIT 0x00004800
+#define VMCS_GUEST_CS_LIMIT 0x00004802
+#define VMCS_GUEST_SS_LIMIT 0x00004804
+#define VMCS_GUEST_DS_LIMIT 0x00004806
+#define VMCS_GUEST_FS_LIMIT 0x00004808
+#define VMCS_GUEST_GS_LIMIT 0x0000480A
+#define VMCS_GUEST_LDTR_LIMIT 0x0000480C
+#define VMCS_GUEST_TR_LIMIT 0x0000480E
+#define VMCS_GUEST_GDTR_LIMIT 0x00004810
+#define VMCS_GUEST_IDTR_LIMIT 0x00004812
+#define VMCS_GUEST_ES_ACCESS_RIGHTS 0x00004814
+#define VMCS_GUEST_CS_ACCESS_RIGHTS 0x00004816
+#define VMCS_GUEST_SS_ACCESS_RIGHTS 0x00004818
+#define VMCS_GUEST_DS_ACCESS_RIGHTS 0x0000481A
+#define VMCS_GUEST_FS_ACCESS_RIGHTS 0x0000481C
+#define VMCS_GUEST_GS_ACCESS_RIGHTS 0x0000481E
+#define VMCS_GUEST_LDTR_ACCESS_RIGHTS 0x00004820
+#define VMCS_GUEST_TR_ACCESS_RIGHTS 0x00004822
+#define VMCS_GUEST_INTERRUPTIBILITY 0x00004824
+#define VMCS_GUEST_ACTIVITY 0x00004826
+#define VMCS_GUEST_SMBASE 0x00004828
+#define VMCS_GUEST_IA32_SYSENTER_CS 0x0000482A
+#define VMCS_PREEMPTION_TIMER_VALUE 0x0000482E
+
+/* 32-bit host state fields */
+#define VMCS_HOST_IA32_SYSENTER_CS 0x00004C00
+
+/* Natural Width control fields */
+#define VMCS_CR0_MASK 0x00006000
+#define VMCS_CR4_MASK 0x00006002
+#define VMCS_CR0_SHADOW 0x00006004
+#define VMCS_CR4_SHADOW 0x00006006
+#define VMCS_CR3_TARGET0 0x00006008
+#define VMCS_CR3_TARGET1 0x0000600A
+#define VMCS_CR3_TARGET2 0x0000600C
+#define VMCS_CR3_TARGET3 0x0000600E
+
+/* Natural Width read-only fields */
+#define VMCS_EXIT_QUALIFICATION 0x00006400
+#define VMCS_IO_RCX 0x00006402
+#define VMCS_IO_RSI 0x00006404
+#define VMCS_IO_RDI 0x00006406
+#define VMCS_IO_RIP 0x00006408
+#define VMCS_GUEST_LINEAR_ADDRESS 0x0000640A
+
+/* Natural Width guest-state fields */
+#define VMCS_GUEST_CR0 0x00006800
+#define VMCS_GUEST_CR3 0x00006802
+#define VMCS_GUEST_CR4 0x00006804
+#define VMCS_GUEST_ES_BASE 0x00006806
+#define VMCS_GUEST_CS_BASE 0x00006808
+#define VMCS_GUEST_SS_BASE 0x0000680A
+#define VMCS_GUEST_DS_BASE 0x0000680C
+#define VMCS_GUEST_FS_BASE 0x0000680E
+#define VMCS_GUEST_GS_BASE 0x00006810
+#define VMCS_GUEST_LDTR_BASE 0x00006812
+#define VMCS_GUEST_TR_BASE 0x00006814
+#define VMCS_GUEST_GDTR_BASE 0x00006816
+#define VMCS_GUEST_IDTR_BASE 0x00006818
+#define VMCS_GUEST_DR7 0x0000681A
+#define VMCS_GUEST_RSP 0x0000681C
+#define VMCS_GUEST_RIP 0x0000681E
+#define VMCS_GUEST_RFLAGS 0x00006820
+#define VMCS_GUEST_PENDING_DBG_EXCEPTIONS 0x00006822
+#define VMCS_GUEST_IA32_SYSENTER_ESP 0x00006824
+#define VMCS_GUEST_IA32_SYSENTER_EIP 0x00006826
+
+/* Natural Width host-state fields */
+#define VMCS_HOST_CR0 0x00006C00
+#define VMCS_HOST_CR3 0x00006C02
+#define VMCS_HOST_CR4 0x00006C04
+#define VMCS_HOST_FS_BASE 0x00006C06
+#define VMCS_HOST_GS_BASE 0x00006C08
+#define VMCS_HOST_TR_BASE 0x00006C0A
+#define VMCS_HOST_GDTR_BASE 0x00006C0C
+#define VMCS_HOST_IDTR_BASE 0x00006C0E
+#define VMCS_HOST_IA32_SYSENTER_ESP 0x00006C10
+#define VMCS_HOST_IA32_SYSENTER_EIP 0x00006C12
+#define VMCS_HOST_RSP 0x00006C14
+#define VMCS_HOST_RIP 0x00006c16
+
+/*
+ * VM instruction error numbers
+ */
+#define VMRESUME_WITH_NON_LAUNCHED_VMCS 5
+
+/*
+ * VMCS exit reasons
+ */
+#define EXIT_REASON_EXCEPTION 0
+#define EXIT_REASON_EXT_INTR 1
+#define EXIT_REASON_TRIPLE_FAULT 2
+#define EXIT_REASON_INIT 3
+#define EXIT_REASON_SIPI 4
+#define EXIT_REASON_IO_SMI 5
+#define EXIT_REASON_SMI 6
+#define EXIT_REASON_INTR_WINDOW 7
+#define EXIT_REASON_NMI_WINDOW 8
+#define EXIT_REASON_TASK_SWITCH 9
+#define EXIT_REASON_CPUID 10
+#define EXIT_REASON_GETSEC 11
+#define EXIT_REASON_HLT 12
+#define EXIT_REASON_INVD 13
+#define EXIT_REASON_INVLPG 14
+#define EXIT_REASON_RDPMC 15
+#define EXIT_REASON_RDTSC 16
+#define EXIT_REASON_RSM 17
+#define EXIT_REASON_VMCALL 18
+#define EXIT_REASON_VMCLEAR 19
+#define EXIT_REASON_VMLAUNCH 20
+#define EXIT_REASON_VMPTRLD 21
+#define EXIT_REASON_VMPTRST 22
+#define EXIT_REASON_VMREAD 23
+#define EXIT_REASON_VMRESUME 24
+#define EXIT_REASON_VMWRITE 25
+#define EXIT_REASON_VMXOFF 26
+#define EXIT_REASON_VMXON 27
+#define EXIT_REASON_CR_ACCESS 28
+#define EXIT_REASON_DR_ACCESS 29
+#define EXIT_REASON_INOUT 30
+#define EXIT_REASON_RDMSR 31
+#define EXIT_REASON_WRMSR 32
+#define EXIT_REASON_INVAL_VMCS 33
+#define EXIT_REASON_INVAL_MSR 34
+#define EXIT_REASON_MWAIT 36
+#define EXIT_REASON_MTF 37
+#define EXIT_REASON_MONITOR 39
+#define EXIT_REASON_PAUSE 40
+#define EXIT_REASON_MCE_DURING_ENTR 41
+#define EXIT_REASON_TPR 43
+#define EXIT_REASON_APIC_ACCESS 44
+#define EXIT_REASON_VIRTUALIZED_EOI 45
+#define EXIT_REASON_GDTR_IDTR 46
+#define EXIT_REASON_LDTR_TR 47
+#define EXIT_REASON_EPT_FAULT 48
+#define EXIT_REASON_EPT_MISCONFIG 49
+#define EXIT_REASON_INVEPT 50
+#define EXIT_REASON_RDTSCP 51
+#define EXIT_REASON_VMX_PREEMPT 52
+#define EXIT_REASON_INVVPID 53
+#define EXIT_REASON_WBINVD 54
+#define EXIT_REASON_XSETBV 55
+#define EXIT_REASON_APIC_WRITE 56
+
+/*
+ * NMI unblocking due to IRET.
+ *
+ * Applies to VM-exits due to hardware exception or EPT fault.
+ */
+#define EXIT_QUAL_NMIUDTI (1 << 12)
+/*
+ * VMCS interrupt information fields
+ */
+#define VMCS_INTR_VALID (1U << 31)
+#define VMCS_INTR_T_MASK 0x700 /* Interruption-info type */
+#define VMCS_INTR_T_HWINTR (0 << 8)
+#define VMCS_INTR_T_NMI (2 << 8)
+#define VMCS_INTR_T_HWEXCEPTION (3 << 8)
+#define VMCS_INTR_T_SWINTR (4 << 8)
+#define VMCS_INTR_T_PRIV_SWEXCEPTION (5 << 8)
+#define VMCS_INTR_T_SWEXCEPTION (6 << 8)
+#define VMCS_INTR_DEL_ERRCODE (1 << 11)
+
+/*
+ * VMCS IDT-Vectoring information fields
+ */
+#define VMCS_IDT_VEC_VALID (1U << 31)
+#define VMCS_IDT_VEC_TYPE 0x700
+#define VMCS_IDT_VEC_ERRCODE_VALID (1U << 11)
+#define VMCS_IDT_VEC_HWINTR (0 << 8)
+#define VMCS_IDT_VEC_NMI (2 << 8)
+#define VMCS_IDT_VEC_HWEXCEPTION (3 << 8)
+#define VMCS_IDT_VEC_SWINTR (4 << 8)
+
+/*
+ * VMCS Guest interruptibility field
+ */
+#define VMCS_INTERRUPTIBILITY_STI_BLOCKING (1 << 0)
+#define VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING (1 << 1)
+#define VMCS_INTERRUPTIBILITY_SMI_BLOCKING (1 << 2)
+#define VMCS_INTERRUPTIBILITY_NMI_BLOCKING (1 << 3)
+
+/*
+ * Exit qualification for EXIT_REASON_INVAL_VMCS
+ */
+#define EXIT_QUAL_NMI_WHILE_STI_BLOCKING 3
+
+/*
+ * Exit qualification for EPT violation
+ */
+#define EPT_VIOLATION_DATA_READ (1UL << 0)
+#define EPT_VIOLATION_DATA_WRITE (1UL << 1)
+#define EPT_VIOLATION_INST_FETCH (1UL << 2)
+#define EPT_VIOLATION_GPA_READABLE (1UL << 3)
+#define EPT_VIOLATION_GPA_WRITEABLE (1UL << 4)
+#define EPT_VIOLATION_GPA_EXECUTABLE (1UL << 5)
+#define EPT_VIOLATION_GLA_VALID (1UL << 7)
+#define EPT_VIOLATION_XLAT_VALID (1UL << 8)
+
+/*
+ * Exit qualification for APIC-access VM exit
+ */
+#define APIC_ACCESS_OFFSET(qual) ((qual) & 0xFFF)
+#define APIC_ACCESS_TYPE(qual) (((qual) >> 12) & 0xF)
+
+/*
+ * Exit qualification for APIC-write VM exit
+ */
+#define APIC_WRITE_OFFSET(qual) ((qual) & 0xFFF)
+
+
+#define VMCS_PRI_PROC_BASED_CTLS_INT_WINDOW_EXITING (1 << 2)
+#define VMCS_PRI_PROC_BASED_CTLS_TSC_OFFSET (1 << 3)
+#define VMCS_PRI_PROC_BASED_CTLS_HLT (1 << 7)
+#define VMCS_PRI_PROC_BASED_CTLS_MWAIT         (1 << 10)
+#define VMCS_PRI_PROC_BASED_CTLS_TSC           (1 << 12)
+#define VMCS_PRI_PROC_BASED_CTLS_CR8_LOAD      (1 << 19)
+#define VMCS_PRI_PROC_BASED_CTLS_CR8_STORE     (1 << 20)
+#define VMCS_PRI_PROC_BASED_CTLS_TPR_SHADOW    (1 << 21)
+#define VMCS_PRI_PROC_BASED_CTLS_NMI_WINDOW_EXITING    (1 << 22)
+#define VMCS_PRI_PROC_BASED_CTLS_SEC_CONTROL   (1 << 31)
+
+#define VMCS_PRI_PROC_BASED2_CTLS_APIC_ACCESSES (1 << 0)
+#define VMCS_PRI_PROC_BASED2_CTLS_X2APIC        (1 << 4)
+
+enum task_switch_reason {
+    TSR_CALL,
+    TSR_IRET,
+    TSR_JMP,
+    TSR_IDT_GATE, /* task gate in IDT */
+};
+
+#endif
diff --git a/target/i386/hvf-utils/vmx.h b/target/i386/hvf-utils/vmx.h
new file mode 100644
index 0000000000..d086c8d253
--- /dev/null
+++ b/target/i386/hvf-utils/vmx.h
@@ -0,0 +1,214 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ * Based on Veertu vddh/vmm/vmx.h
+ *
+ * Interfaces to Hypervisor.framework to read/write X86 registers and VMCS.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef VMX_H
+#define VMX_H
+
+#include <stdint.h>
+#include <Hypervisor/hv.h>
+#include <Hypervisor/hv_vmx.h>
+#include "vmcs.h"
+#include "cpu.h"
+#include "x86.h"
+
+#include "exec/address-spaces.h"
+
+static inline uint64_t rreg(hv_vcpuid_t vcpu, hv_x86_reg_t reg)
+{
+    uint64_t v;
+
+    if (hv_vcpu_read_register(vcpu, reg, &v)) {
+        abort();
+    }
+
+    return v;
+}
+
+/* write GPR */
+static inline void wreg(hv_vcpuid_t vcpu, hv_x86_reg_t reg, uint64_t v)
+{
+    if (hv_vcpu_write_register(vcpu, reg, v)) {
+        abort();
+    }
+}
+
+/* read VMCS field */
+static inline uint64_t rvmcs(hv_vcpuid_t vcpu, uint32_t field)
+{
+    uint64_t v;
+
+    hv_vmx_vcpu_read_vmcs(vcpu, field, &v);
+
+    return v;
+}
+
+/* write VMCS field */
+static inline void wvmcs(hv_vcpuid_t vcpu, uint32_t field, uint64_t v)
+{
+    hv_vmx_vcpu_write_vmcs(vcpu, field, v);
+}
+
+/* desired control word constrained by hardware/hypervisor capabilities */
+static inline uint64_t cap2ctrl(uint64_t cap, uint64_t ctrl)
+{
+    return (ctrl | (cap & 0xffffffff)) & (cap >> 32);
+}
+
+#define VM_ENTRY_GUEST_LMA (1LL << 9)
+
+#define AR_TYPE_ACCESSES_MASK 1
+#define AR_TYPE_READABLE_MASK (1 << 1)
+#define AR_TYPE_WRITEABLE_MASK (1 << 2)
+#define AR_TYPE_CODE_MASK (1 << 3)
+#define AR_TYPE_MASK 0x0f
+#define AR_TYPE_BUSY_64_TSS 11
+#define AR_TYPE_BUSY_32_TSS 11
+#define AR_TYPE_BUSY_16_TSS 3
+#define AR_TYPE_LDT 2
+
+static void enter_long_mode(hv_vcpuid_t vcpu, uint64_t cr0, uint64_t efer)
+{
+    uint64_t entry_ctls;
+
+    efer |= EFER_LMA;
+    wvmcs(vcpu, VMCS_GUEST_IA32_EFER, efer);
+    entry_ctls = rvmcs(vcpu, VMCS_ENTRY_CTLS);
+    wvmcs(vcpu, VMCS_ENTRY_CTLS, rvmcs(vcpu, VMCS_ENTRY_CTLS) |
+          VM_ENTRY_GUEST_LMA);
+
+    uint64_t guest_tr_ar = rvmcs(vcpu, VMCS_GUEST_TR_ACCESS_RIGHTS);
+    if ((efer & EFER_LME) &&
+        (guest_tr_ar & AR_TYPE_MASK) != AR_TYPE_BUSY_64_TSS) {
+        wvmcs(vcpu, VMCS_GUEST_TR_ACCESS_RIGHTS,
+              (guest_tr_ar & ~AR_TYPE_MASK) | AR_TYPE_BUSY_64_TSS);
+    }
+}
+
+static void exit_long_mode(hv_vcpuid_t vcpu, uint64_t cr0, uint64_t efer)
+{
+    uint64_t entry_ctls;
+
+    entry_ctls = rvmcs(vcpu, VMCS_ENTRY_CTLS);
+    wvmcs(vcpu, VMCS_ENTRY_CTLS, entry_ctls & ~VM_ENTRY_GUEST_LMA);
+
+    efer &= ~EFER_LMA;
+    wvmcs(vcpu, VMCS_GUEST_IA32_EFER, efer);
+}
+
+static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
+{
+    int i;
+    uint64_t pdpte[4] = {0, 0, 0, 0};
+    uint64_t efer = rvmcs(vcpu, VMCS_GUEST_IA32_EFER);
+    uint64_t old_cr0 = rvmcs(vcpu, VMCS_GUEST_CR0);
+
+    if ((cr0 & CR0_PG) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE) &&
+        !(efer & EFER_LME)) {
+        address_space_rw(&address_space_memory,
+                         rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
+                         MEMTXATTRS_UNSPECIFIED,
+                         (uint8_t *)pdpte, 32, 0);
+    }
+
+    for (i = 0; i < 4; i++) {
+        wvmcs(vcpu, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
+    }
+
+    wvmcs(vcpu, VMCS_CR0_MASK, CR0_CD | CR0_NE | CR0_PG);
+    wvmcs(vcpu, VMCS_CR0_SHADOW, cr0);
+
+    cr0 &= ~CR0_CD;
+    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE | CR0_ET);
+
+    if (efer & EFER_LME) {
+        if (!(old_cr0 & CR0_PG) && (cr0 & CR0_PG)) {
+            enter_long_mode(vcpu, cr0, efer);
+        }
+        if (/*(old_cr0 & CR0_PG) &&*/ !(cr0 & CR0_PG)) {
+            exit_long_mode(vcpu, cr0, efer);
+        }
+    }
+
+    hv_vcpu_invalidate_tlb(vcpu);
+    hv_vcpu_flush(vcpu);
+}
+
+static inline void macvm_set_cr4(hv_vcpuid_t vcpu, uint64_t cr4)
+{
+    uint64_t guest_cr4 = cr4 | CR4_VMXE;
+
+    wvmcs(vcpu, VMCS_GUEST_CR4, guest_cr4);
+    wvmcs(vcpu, VMCS_CR4_SHADOW, cr4);
+
+    hv_vcpu_invalidate_tlb(vcpu);
+    hv_vcpu_flush(vcpu);
+}
+
+static inline void macvm_set_rip(CPUState *cpu, uint64_t rip)
+{
+    uint64_t val;
+
+    /* BUG, should take considering overlap.. */
+    wreg(cpu->hvf_fd, HV_X86_RIP, rip);
+
+    /* after moving forward in rip, we need to clean INTERRUPTABILITY */
+   val = rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY);
+   if (val & (VMCS_INTERRUPTIBILITY_STI_BLOCKING |
+               VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING)) {
+        wvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY,
+               val & ~(VMCS_INTERRUPTIBILITY_STI_BLOCKING |
+               VMCS_INTERRUPTIBILITY_MOVSS_BLOCKING));
+   }
+}
+
+static inline void vmx_clear_nmi_blocking(CPUState *cpu)
+{
+    uint32_t gi = (uint32_t) rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY);
+    gi &= ~VMCS_INTERRUPTIBILITY_NMI_BLOCKING;
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY, gi);
+}
+
+static inline void vmx_set_nmi_blocking(CPUState *cpu)
+{
+    uint32_t gi = (uint32_t)rvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY);
+    gi |= VMCS_INTERRUPTIBILITY_NMI_BLOCKING;
+    wvmcs(cpu->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY, gi);
+}
+
+static inline void vmx_set_nmi_window_exiting(CPUState *cpu)
+{
+    uint64_t val;
+    val = rvmcs(cpu->hvf_fd, VMCS_PRI_PROC_BASED_CTLS);
+    wvmcs(cpu->hvf_fd, VMCS_PRI_PROC_BASED_CTLS, val |
+          VMCS_PRI_PROC_BASED_CTLS_NMI_WINDOW_EXITING);
+
+}
+
+static inline void vmx_clear_nmi_window_exiting(CPUState *cpu)
+{
+
+    uint64_t val;
+    val = rvmcs(cpu->hvf_fd, VMCS_PRI_PROC_BASED_CTLS);
+    wvmcs(cpu->hvf_fd, VMCS_PRI_PROC_BASED_CTLS, val &
+          ~VMCS_PRI_PROC_BASED_CTLS_NMI_WINDOW_EXITING);
+}
+
+#endif
diff --git a/target/i386/hvf-utils/x86.c b/target/i386/hvf-utils/x86.c
new file mode 100644
index 0000000000..587efd54fd
--- /dev/null
+++ b/target/i386/hvf-utils/x86.c
@@ -0,0 +1,184 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu-common.h"
+#include "x86_decode.h"
+#include "x86_emu.h"
+#include "vmcs.h"
+#include "vmx.h"
+#include "x86_mmu.h"
+#include "x86_descr.h"
+
+/* static uint32_t x86_segment_access_rights(struct x86_segment_descriptor *var)
+{
+   uint32_t ar;
+
+   if (!var->p) {
+       ar = 1 << 16;
+       return ar;
+   }
+
+   ar = var->type & 15;
+   ar |= (var->s & 1) << 4;
+   ar |= (var->dpl & 3) << 5;
+   ar |= (var->p & 1) << 7;
+   ar |= (var->avl & 1) << 12;
+   ar |= (var->l & 1) << 13;
+   ar |= (var->db & 1) << 14;
+   ar |= (var->g & 1) << 15;
+   return ar;
+}*/
+
+bool x86_read_segment_descriptor(struct CPUState *cpu,
+                                 struct x86_segment_descriptor *desc,
+                                 x68_segment_selector sel)
+{
+    addr_t base;
+    uint32_t limit;
+
+    ZERO_INIT(*desc);
+    /* valid gdt descriptors start from index 1 */
+    if (!sel.index && GDT_SEL == sel.ti) {
+        return false;
+    }
+
+    if (GDT_SEL == sel.ti) {
+        base  = rvmcs(cpu->hvf_fd, VMCS_GUEST_GDTR_BASE);
+        limit = rvmcs(cpu->hvf_fd, VMCS_GUEST_GDTR_LIMIT);
+    } else {
+        base  = rvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_BASE);
+        limit = rvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_LIMIT);
+    }
+
+    if (sel.index * 8 >= limit) {
+        return false;
+    }
+
+    vmx_read_mem(cpu, desc, base + sel.index * 8, sizeof(*desc));
+    return true;
+}
+
+bool x86_write_segment_descriptor(struct CPUState *cpu,
+                                  struct x86_segment_descriptor *desc,
+                                  x68_segment_selector sel)
+{
+    addr_t base;
+    uint32_t limit;
+    
+    if (GDT_SEL == sel.ti) {
+        base  = rvmcs(cpu->hvf_fd, VMCS_GUEST_GDTR_BASE);
+        limit = rvmcs(cpu->hvf_fd, VMCS_GUEST_GDTR_LIMIT);
+    } else {
+        base  = rvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_BASE);
+        limit = rvmcs(cpu->hvf_fd, VMCS_GUEST_LDTR_LIMIT);
+    }
+    
+    if (sel.index * 8 >= limit) {
+        printf("%s: gdt limit\n", __func__);
+        return false;
+    }
+    vmx_write_mem(cpu, base + sel.index * 8, desc, sizeof(*desc));
+    return true;
+}
+
+bool x86_read_call_gate(struct CPUState *cpu, struct x86_call_gate *idt_desc,
+                        int gate)
+{
+    addr_t base  = rvmcs(cpu->hvf_fd, VMCS_GUEST_IDTR_BASE);
+    uint32_t limit = rvmcs(cpu->hvf_fd, VMCS_GUEST_IDTR_LIMIT);
+
+    ZERO_INIT(*idt_desc);
+    if (gate * 8 >= limit) {
+        printf("%s: idt limit\n", __func__);
+        return false;
+    }
+
+    vmx_read_mem(cpu, idt_desc, base + gate * 8, sizeof(*idt_desc));
+    return true;
+}
+
+bool x86_is_protected(struct CPUState *cpu)
+{
+    uint64_t cr0 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0);
+    return cr0 & CR0_PE;
+}
+
+bool x86_is_real(struct CPUState *cpu)
+{
+    return !x86_is_protected(cpu);
+}
+
+bool x86_is_v8086(struct CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    return x86_is_protected(cpu) && (RFLAGS(env) & RFLAGS_VM);
+}
+
+bool x86_is_long_mode(struct CPUState *cpu)
+{
+    return rvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER) & EFER_LMA;
+}
+
+bool x86_is_long64_mode(struct CPUState *cpu)
+{
+    struct vmx_segment desc;
+    vmx_read_segment_descriptor(cpu, &desc, REG_SEG_CS);
+
+    return x86_is_long_mode(cpu) && ((desc.ar >> 13) & 1);
+}
+
+bool x86_is_paging_mode(struct CPUState *cpu)
+{
+    uint64_t cr0 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0);
+    return cr0 & CR0_PG;
+}
+
+bool x86_is_pae_enabled(struct CPUState *cpu)
+{
+    uint64_t cr4 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR4);
+    return cr4 & CR4_PAE;
+}
+
+addr_t linear_addr(struct CPUState *cpu, addr_t addr, x86_reg_segment seg)
+{
+    return vmx_read_segment_base(cpu, seg) + addr;
+}
+
+addr_t linear_addr_size(struct CPUState *cpu, addr_t addr, int size,
+                        x86_reg_segment seg)
+{
+    switch (size) {
+    case 2:
+        addr = (uint16_t)addr;
+        break;
+    case 4:
+        addr = (uint32_t)addr;
+        break;
+    default:
+        break;
+    }
+    return linear_addr(cpu, addr, seg);
+}
+
+addr_t linear_rip(struct CPUState *cpu, addr_t rip)
+{
+    return linear_addr(cpu, rip, REG_SEG_CS);
+}
diff --git a/target/i386/hvf-utils/x86.h b/target/i386/hvf-utils/x86.h
new file mode 100644
index 0000000000..d32e13d648
--- /dev/null
+++ b/target/i386/hvf-utils/x86.h
@@ -0,0 +1,476 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Veertu Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#pragma once
+
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <stdarg.h>
+#include "qemu-common.h"
+#include "x86_gen.h"
+
+/* exceptions */
+typedef enum x86_exception {
+    EXCEPTION_DE,           /* divide error */
+    EXCEPTION_DB,           /* debug fault */
+    EXCEPTION_NMI,          /* non-maskable interrupt */
+    EXCEPTION_BP,           /* breakpoint trap */
+    EXCEPTION_OF,           /* overflow trap */
+    EXCEPTION_BR,           /* boundary range exceeded fault */
+    EXCEPTION_UD,           /* undefined opcode */
+    EXCEPTION_NM,           /* device not available */
+    EXCEPTION_DF,           /* double fault */
+    EXCEPTION_RSVD,         /* not defined */
+    EXCEPTION_TS,           /* invalid TSS fault */
+    EXCEPTION_NP,           /* not present fault */
+    EXCEPTION_GP,           /* general protection fault */
+    EXCEPTION_PF,           /* page fault */
+    EXCEPTION_RSVD2,        /* not defined */
+} x86_exception;
+
+/* general purpose regs */
+typedef enum x86_reg_name {
+    REG_RAX = 0,
+    REG_RCX = 1,
+    REG_RDX = 2,
+    REG_RBX = 3,
+    REG_RSP = 4,
+    REG_RBP = 5,
+    REG_RSI = 6,
+    REG_RDI = 7,
+    REG_R8 = 8,
+    REG_R9 = 9,
+    REG_R10 = 10,
+    REG_R11 = 11,
+    REG_R12 = 12,
+    REG_R13 = 13,
+    REG_R14 = 14,
+    REG_R15 = 15,
+} x86_reg_name;
+
+/* segment regs */
+typedef enum x86_reg_segment {
+    REG_SEG_ES = 0,
+    REG_SEG_CS = 1,
+    REG_SEG_SS = 2,
+    REG_SEG_DS = 3,
+    REG_SEG_FS = 4,
+    REG_SEG_GS = 5,
+    REG_SEG_LDTR = 6,
+    REG_SEG_TR = 7,
+} x86_reg_segment;
+
+typedef struct x86_register {
+    union {
+        struct {
+            uint64_t rrx;               /* full 64 bit */
+        };
+        struct {
+            uint32_t erx;               /* low 32 bit part */
+            uint32_t hi32_unused1;
+        };
+        struct {
+            uint16_t rx;                /* low 16 bit part */
+            uint16_t hi16_unused1;
+            uint32_t hi32_unused2;
+        };
+        struct {
+            uint8_t lx;                 /* low 8 bit part */
+            uint8_t hx;                 /* high 8 bit */
+            uint16_t hi16_unused2;
+            uint32_t hi32_unused3;
+        };
+    };
+} __attribute__ ((__packed__)) x86_register;
+
+typedef enum x86_rflags {
+    RFLAGS_CF       = (1L << 0),
+    RFLAGS_PF       = (1L << 2),
+    RFLAGS_AF       = (1L << 4),
+    RFLAGS_ZF       = (1L << 6),
+    RFLAGS_SF       = (1L << 7),
+    RFLAGS_TF       = (1L << 8),
+    RFLAGS_IF       = (1L << 9),
+    RFLAGS_DF       = (1L << 10),
+    RFLAGS_OF       = (1L << 11),
+    RFLAGS_IOPL     = (3L << 12),
+    RFLAGS_NT       = (1L << 14),
+    RFLAGS_RF       = (1L << 16),
+    RFLAGS_VM       = (1L << 17),
+    RFLAGS_AC       = (1L << 18),
+    RFLAGS_VIF      = (1L << 19),
+    RFLAGS_VIP      = (1L << 20),
+    RFLAGS_ID       = (1L << 21),
+} x86_rflags;
+
+/* rflags register */
+typedef struct x86_reg_flags {
+    union {
+        struct {
+            uint64_t rflags;
+        };
+        struct {
+            uint32_t eflags;
+            uint32_t hi32_unused1;
+        };
+        struct {
+            uint32_t cf:1;
+            uint32_t unused1:1;
+            uint32_t pf:1;
+            uint32_t unused2:1;
+            uint32_t af:1;
+            uint32_t unused3:1;
+            uint32_t zf:1;
+            uint32_t sf:1;
+            uint32_t tf:1;
+            uint32_t ief:1;
+            uint32_t df:1;
+            uint32_t of:1;
+            uint32_t iopl:2;
+            uint32_t nt:1;
+            uint32_t unused4:1;
+            uint32_t rf:1;
+            uint32_t vm:1;
+            uint32_t ac:1;
+            uint32_t vif:1;
+            uint32_t vip:1;
+            uint32_t id:1;
+            uint32_t unused5:10;
+            uint32_t hi32_unused2;
+        };
+    };
+} __attribute__ ((__packed__)) x86_reg_flags;
+
+typedef enum x86_reg_efer {
+    EFER_SCE =          (1L << 0),
+    EFER_LME =          (1L << 8),
+    EFER_LMA =          (1L << 10),
+    EFER_NXE =          (1L << 11),
+    EFER_SVME =         (1L << 12),
+    EFER_FXSR =         (1L << 14),
+} x86_reg_efer;
+
+typedef struct x86_efer {
+    uint64_t efer;
+} __attribute__ ((__packed__)) x86_efer;
+
+typedef enum x86_reg_cr0 {
+    CR0_PE =            (1L << 0),
+    CR0_MP =            (1L << 1),
+    CR0_EM =            (1L << 2),
+    CR0_TS =            (1L << 3),
+    CR0_ET =            (1L << 4),
+    CR0_NE =            (1L << 5),
+    CR0_WP =            (1L << 16),
+    CR0_AM =            (1L << 18),
+    CR0_NW =            (1L << 29),
+    CR0_CD =            (1L << 30),
+    CR0_PG =            (1L << 31),
+} x86_reg_cr0;
+
+typedef enum x86_reg_cr4 {
+    CR4_VME =            (1L << 0),
+    CR4_PVI =            (1L << 1),
+    CR4_TSD =            (1L << 2),
+    CR4_DE  =            (1L << 3),
+    CR4_PSE =            (1L << 4),
+    CR4_PAE =            (1L << 5),
+    CR4_MSE =            (1L << 6),
+    CR4_PGE =            (1L << 7),
+    CR4_PCE =            (1L << 8),
+    CR4_OSFXSR =         (1L << 9),
+    CR4_OSXMMEXCPT =     (1L << 10),
+    CR4_VMXE =           (1L << 13),
+    CR4_SMXE =           (1L << 14),
+    CR4_FSGSBASE =       (1L << 16),
+    CR4_PCIDE =          (1L << 17),
+    CR4_OSXSAVE =        (1L << 18),
+    CR4_SMEP =           (1L << 20),
+} x86_reg_cr4;
+
+/* 16 bit Task State Segment */
+typedef struct x86_tss_segment16 {
+    uint16_t link;
+    uint16_t sp0;
+    uint16_t ss0;
+    uint32_t sp1;
+    uint16_t ss1;
+    uint32_t sp2;
+    uint16_t ss2;
+    uint16_t ip;
+    uint16_t flags;
+    uint16_t ax;
+    uint16_t cx;
+    uint16_t dx;
+    uint16_t bx;
+    uint16_t sp;
+    uint16_t bp;
+    uint16_t si;
+    uint16_t di;
+    uint16_t es;
+    uint16_t cs;
+    uint16_t ss;
+    uint16_t ds;
+    uint16_t ldtr;
+} __attribute__((packed)) x86_tss_segment16;
+
+/* 32 bit Task State Segment */
+typedef struct x86_tss_segment32 {
+    uint32_t prev_tss;
+    uint32_t esp0;
+    uint32_t ss0;
+    uint32_t esp1;
+    uint32_t ss1;
+    uint32_t esp2;
+    uint32_t ss2;
+    uint32_t cr3;
+    uint32_t eip;
+    uint32_t eflags;
+    uint32_t eax;
+    uint32_t ecx;
+    uint32_t edx;
+    uint32_t ebx;
+    uint32_t esp;
+    uint32_t ebp;
+    uint32_t esi;
+    uint32_t edi;
+    uint32_t es;
+    uint32_t cs;
+    uint32_t ss;
+    uint32_t ds;
+    uint32_t fs;
+    uint32_t gs;
+    uint32_t ldt;
+    uint16_t trap;
+    uint16_t iomap_base;
+} __attribute__ ((__packed__)) x86_tss_segment32;
+
+/* 64 bit Task State Segment */
+typedef struct x86_tss_segment64 {
+    uint32_t unused;
+    uint64_t rsp0;
+    uint64_t rsp1;
+    uint64_t rsp2;
+    uint64_t unused1;
+    uint64_t ist1;
+    uint64_t ist2;
+    uint64_t ist3;
+    uint64_t ist4;
+    uint64_t ist5;
+    uint64_t ist6;
+    uint64_t ist7;
+    uint64_t unused2;
+    uint16_t unused3;
+    uint16_t iomap_base;
+} __attribute__ ((__packed__)) x86_tss_segment64;
+
+/* segment descriptors */
+typedef struct x86_segment_descriptor {
+    uint64_t    limit0:16;
+    uint64_t    base0:16;
+    uint64_t    base1:8;
+    uint64_t    type:4;
+    uint64_t    s:1;
+    uint64_t    dpl:2;
+    uint64_t    p:1;
+    uint64_t    limit1:4;
+    uint64_t    avl:1;
+    uint64_t    l:1;
+    uint64_t    db:1;
+    uint64_t    g:1;
+    uint64_t    base2:8;
+} __attribute__ ((__packed__)) x86_segment_descriptor;
+
+static inline uint32_t x86_segment_base(x86_segment_descriptor *desc)
+{
+    return (uint32_t)((desc->base2 << 24) | (desc->base1 << 16) | desc->base0);
+}
+
+static inline void x86_set_segment_base(x86_segment_descriptor *desc,
+                                        uint32_t base)
+{
+    desc->base2 = base >> 24;
+    desc->base1 = (base >> 16) & 0xff;
+    desc->base0 = base & 0xffff;
+}
+
+static inline uint32_t x86_segment_limit(x86_segment_descriptor *desc)
+{
+    uint32_t limit = (uint32_t)((desc->limit1 << 16) | desc->limit0);
+    if (desc->g) {
+        return (limit << 12) | 0xfff;
+    }
+    return limit;
+}
+
+static inline void x86_set_segment_limit(x86_segment_descriptor *desc,
+                                         uint32_t limit)
+{
+    desc->limit0 = limit & 0xffff;
+    desc->limit1 = limit >> 16;
+}
+
+typedef struct x86_call_gate {
+    uint64_t offset0:16;
+    uint64_t selector:16;
+    uint64_t param_count:4;
+    uint64_t reserved:3;
+    uint64_t type:4;
+    uint64_t dpl:1;
+    uint64_t p:1;
+    uint64_t offset1:16;
+} __attribute__ ((__packed__)) x86_call_gate;
+
+static inline uint32_t x86_call_gate_offset(x86_call_gate *gate)
+{
+    return (uint32_t)((gate->offset1 << 16) | gate->offset0);
+}
+
+#define LDT_SEL     0
+#define GDT_SEL     1
+
+typedef struct x68_segment_selector {
+    union {
+        uint16_t sel;
+        struct {
+            uint16_t rpl:3;
+            uint16_t ti:1;
+            uint16_t index:12;
+        };
+    };
+} __attribute__ ((__packed__)) x68_segment_selector;
+
+typedef struct lazy_flags {
+    addr_t result;
+    addr_t auxbits;
+} lazy_flags;
+
+/* Definition of hvf_x86_state is here */
+struct HVFX86EmulatorState {
+    int interruptable;
+    uint64_t fetch_rip;
+    uint64_t rip;
+    struct x86_register regs[16];
+    struct x86_reg_flags   rflags;
+    struct lazy_flags   lflags;
+    struct x86_efer efer;
+    uint8_t mmio_buf[4096];
+};
+
+/*
+* hvf xsave area
+*/
+struct hvf_xsave_buf {
+    uint32_t data[1024];
+};
+
+/* useful register access  macros */
+#define RIP(cpu)    (cpu->hvf_emul->rip)
+#define EIP(cpu)    ((uint32_t)cpu->hvf_emul->rip)
+#define RFLAGS(cpu) (cpu->hvf_emul->rflags.rflags)
+#define EFLAGS(cpu) (cpu->hvf_emul->rflags.eflags)
+
+#define RRX(cpu, reg) (cpu->hvf_emul->regs[reg].rrx)
+#define RAX(cpu)        RRX(cpu, REG_RAX)
+#define RCX(cpu)        RRX(cpu, REG_RCX)
+#define RDX(cpu)        RRX(cpu, REG_RDX)
+#define RBX(cpu)        RRX(cpu, REG_RBX)
+#define RSP(cpu)        RRX(cpu, REG_RSP)
+#define RBP(cpu)        RRX(cpu, REG_RBP)
+#define RSI(cpu)        RRX(cpu, REG_RSI)
+#define RDI(cpu)        RRX(cpu, REG_RDI)
+#define R8(cpu)         RRX(cpu, REG_R8)
+#define R9(cpu)         RRX(cpu, REG_R9)
+#define R10(cpu)        RRX(cpu, REG_R10)
+#define R11(cpu)        RRX(cpu, REG_R11)
+#define R12(cpu)        RRX(cpu, REG_R12)
+#define R13(cpu)        RRX(cpu, REG_R13)
+#define R14(cpu)        RRX(cpu, REG_R14)
+#define R15(cpu)        RRX(cpu, REG_R15)
+
+#define ERX(cpu, reg)   (cpu->hvf_emul->regs[reg].erx)
+#define EAX(cpu)        ERX(cpu, REG_RAX)
+#define ECX(cpu)        ERX(cpu, REG_RCX)
+#define EDX(cpu)        ERX(cpu, REG_RDX)
+#define EBX(cpu)        ERX(cpu, REG_RBX)
+#define ESP(cpu)        ERX(cpu, REG_RSP)
+#define EBP(cpu)        ERX(cpu, REG_RBP)
+#define ESI(cpu)        ERX(cpu, REG_RSI)
+#define EDI(cpu)        ERX(cpu, REG_RDI)
+
+#define RX(cpu, reg)   (cpu->hvf_emul->regs[reg].rx)
+#define AX(cpu)        RX(cpu, REG_RAX)
+#define CX(cpu)        RX(cpu, REG_RCX)
+#define DX(cpu)        RX(cpu, REG_RDX)
+#define BP(cpu)        RX(cpu, REG_RBP)
+#define SP(cpu)        RX(cpu, REG_RSP)
+#define BX(cpu)        RX(cpu, REG_RBX)
+#define SI(cpu)        RX(cpu, REG_RSI)
+#define DI(cpu)        RX(cpu, REG_RDI)
+
+#define RL(cpu, reg)   (cpu->hvf_emul->regs[reg].lx)
+#define AL(cpu)        RL(cpu, REG_RAX)
+#define CL(cpu)        RL(cpu, REG_RCX)
+#define DL(cpu)        RL(cpu, REG_RDX)
+#define BL(cpu)        RL(cpu, REG_RBX)
+
+#define RH(cpu, reg)   (cpu->hvf_emul->regs[reg].hx)
+#define AH(cpu)        RH(cpu, REG_RAX)
+#define CH(cpu)        RH(cpu, REG_RCX)
+#define DH(cpu)        RH(cpu, REG_RDX)
+#define BH(cpu)        RH(cpu, REG_RBX)
+
+/* deal with GDT/LDT descriptors in memory */
+bool x86_read_segment_descriptor(struct CPUState *cpu,
+                                 struct x86_segment_descriptor *desc,
+                                 x68_segment_selector sel);
+bool x86_write_segment_descriptor(struct CPUState *cpu,
+                                  struct x86_segment_descriptor *desc,
+                                  x68_segment_selector sel);
+
+bool x86_read_call_gate(struct CPUState *cpu, struct x86_call_gate *idt_desc,
+                        int gate);
+
+/* helpers */
+bool x86_is_protected(struct CPUState *cpu);
+bool x86_is_real(struct CPUState *cpu);
+bool x86_is_v8086(struct CPUState *cpu);
+bool x86_is_long_mode(struct CPUState *cpu);
+bool x86_is_long64_mode(struct CPUState *cpu);
+bool x86_is_paging_mode(struct CPUState *cpu);
+bool x86_is_pae_enabled(struct CPUState *cpu);
+
+addr_t linear_addr(struct CPUState *cpu, addr_t addr, x86_reg_segment seg);
+addr_t linear_addr_size(struct CPUState *cpu, addr_t addr, int size,
+                        x86_reg_segment seg);
+addr_t linear_rip(struct CPUState *cpu, addr_t rip);
+
+static inline uint64_t rdtscp(void)
+{
+    uint64_t tsc;
+    __asm__ __volatile__("rdtscp; "         /* serializing read of tsc */
+                         "shl $32,%%rdx; "  /* shift higher 32 bits stored in rdx up */
+                         "or %%rdx,%%rax"   /* and or onto rax */
+                         : "=a"(tsc)        /* output to tsc variable */
+                         :
+                         : "%rcx", "%rdx"); /* rcx and rdx are clobbered */
+
+    return tsc;
+}
+
diff --git a/target/i386/hvf-utils/x86_decode.c b/target/i386/hvf-utils/x86_decode.c
new file mode 100644
index 0000000000..13022f2851
--- /dev/null
+++ b/target/i386/hvf-utils/x86_decode.c
@@ -0,0 +1,2186 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+
+#include "x86_decode.h"
+#include "string.h"
+#include "vmx.h"
+#include "x86_gen.h"
+#include "x86_mmu.h"
+#include "x86_descr.h"
+
+#define OPCODE_ESCAPE   0xf
+
+static void decode_invalid(CPUX86State *env, struct x86_decode *decode)
+{
+    printf("%llx: failed to decode instruction ", env->hvf_emul->fetch_rip -
+           decode->len);
+    for (int i = 0; i < decode->opcode_len; i++) {
+        printf("%x ", decode->opcode[i]);
+    }
+    printf("\n");
+    VM_PANIC("decoder failed\n");
+}
+
+uint64_t sign(uint64_t val, int size)
+{
+    switch (size) {
+    case 1:
+        val = (int8_t)val;
+        break;
+    case 2:
+        val = (int16_t)val;
+        break;
+    case 4:
+        val = (int32_t)val;
+        break;
+    case 8:
+        val = (int64_t)val;
+        break;
+    default:
+        VM_PANIC_EX("%s invalid size %d\n", __func__, size);
+        break;
+    }
+    return val;
+}
+
+static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
+                                    int size)
+{
+    addr_t val = 0;
+    
+    switch (size) {
+    case 1:
+    case 2:
+    case 4:
+    case 8:
+        break;
+    default:
+        VM_PANIC_EX("%s invalid size %d\n", __func__, size);
+        break;
+    }
+    addr_t va  = linear_rip(ENV_GET_CPU(env), RIP(env)) + decode->len;
+    vmx_read_mem(ENV_GET_CPU(env), &val, va, size);
+    decode->len += size;
+    
+    return val;
+}
+
+static inline uint8_t decode_byte(CPUX86State *env, struct x86_decode *decode)
+{
+    return (uint8_t)decode_bytes(env, decode, 1);
+}
+
+static inline uint16_t decode_word(CPUX86State *env, struct x86_decode *decode)
+{
+    return (uint16_t)decode_bytes(env, decode, 2);
+}
+
+static inline uint32_t decode_dword(CPUX86State *env, struct x86_decode *decode)
+{
+    return (uint32_t)decode_bytes(env, decode, 4);
+}
+
+static inline uint64_t decode_qword(CPUX86State *env, struct x86_decode *decode)
+{
+    return decode_bytes(env, decode, 8);
+}
+
+static void decode_modrm_rm(CPUX86State *env, struct x86_decode *decode,
+                            struct x86_decode_op *op)
+{
+    op->type = X86_VAR_RM;
+}
+
+static void decode_modrm_reg(CPUX86State *env, struct x86_decode *decode,
+                             struct x86_decode_op *op)
+{
+    op->type = X86_VAR_REG;
+    op->reg = decode->modrm.reg;
+    op->ptr = get_reg_ref(env, op->reg, decode->rex.r, decode->operand_size);
+}
+
+static void decode_rax(CPUX86State *env, struct x86_decode *decode,
+                       struct x86_decode_op *op)
+{
+    op->type = X86_VAR_REG;
+    op->reg = REG_RAX;
+    op->ptr = get_reg_ref(env, op->reg, 0, decode->operand_size);
+}
+
+static inline void decode_immediate(CPUX86State *env, struct x86_decode *decode,
+                                    struct x86_decode_op *var, int size)
+{
+    var->type = X86_VAR_IMMEDIATE;
+    var->size = size;
+    switch (size) {
+    case 1:
+        var->val = decode_byte(env, decode);
+        break;
+    case 2:
+        var->val = decode_word(env, decode);
+        break;
+    case 4:
+        var->val = decode_dword(env, decode);
+        break;
+    case 8:
+        var->val = decode_qword(env, decode);
+        break;
+    default:
+        VM_PANIC_EX("bad size %d\n", size);
+    }
+}
+
+static void decode_imm8(CPUX86State *env, struct x86_decode *decode,
+                        struct x86_decode_op *op)
+{
+    decode_immediate(env, decode, op, 1);
+    op->type = X86_VAR_IMMEDIATE;
+}
+
+static void decode_imm8_signed(CPUX86State *env, struct x86_decode *decode,
+                               struct x86_decode_op *op)
+{
+    decode_immediate(env, decode, op, 1);
+    op->val = sign(op->val, 1);
+    op->type = X86_VAR_IMMEDIATE;
+}
+
+static void decode_imm16(CPUX86State *env, struct x86_decode *decode,
+                         struct x86_decode_op *op)
+{
+    decode_immediate(env, decode, op, 2);
+    op->type = X86_VAR_IMMEDIATE;
+}
+
+
+static void decode_imm(CPUX86State *env, struct x86_decode *decode,
+                       struct x86_decode_op *op)
+{
+    if (8 == decode->operand_size) {
+        decode_immediate(env, decode, op, 4);
+        op->val = sign(op->val, decode->operand_size);
+    } else {
+        decode_immediate(env, decode, op, decode->operand_size);
+    }
+    op->type = X86_VAR_IMMEDIATE;
+}
+
+static void decode_imm_signed(CPUX86State *env, struct x86_decode *decode,
+                              struct x86_decode_op *op)
+{
+    decode_immediate(env, decode, op, decode->operand_size);
+    op->val = sign(op->val, decode->operand_size);
+    op->type = X86_VAR_IMMEDIATE;
+}
+
+static void decode_imm_1(CPUX86State *env, struct x86_decode *decode,
+                         struct x86_decode_op *op)
+{
+    op->type = X86_VAR_IMMEDIATE;
+    op->val = 1;
+}
+
+static void decode_imm_0(CPUX86State *env, struct x86_decode *decode,
+                         struct x86_decode_op *op)
+{
+    op->type = X86_VAR_IMMEDIATE;
+    op->val = 0;
+}
+
+
+static void decode_pushseg(CPUX86State *env, struct x86_decode *decode)
+{
+    uint8_t op = (decode->opcode_len > 1) ? decode->opcode[1] : decode->opcode[0];
+    
+    decode->op[0].type = X86_VAR_REG;
+    switch (op) {
+    case 0xe:
+        decode->op[0].reg = REG_SEG_CS;
+        break;
+    case 0x16:
+        decode->op[0].reg = REG_SEG_SS;
+        break;
+    case 0x1e:
+        decode->op[0].reg = REG_SEG_DS;
+        break;
+    case 0x06:
+        decode->op[0].reg = REG_SEG_ES;
+        break;
+    case 0xa0:
+        decode->op[0].reg = REG_SEG_FS;
+        break;
+    case 0xa8:
+        decode->op[0].reg = REG_SEG_GS;
+        break;
+    }
+}
+
+static void decode_popseg(CPUX86State *env, struct x86_decode *decode)
+{
+    uint8_t op = (decode->opcode_len > 1) ? decode->opcode[1] : decode->opcode[0];
+    
+    decode->op[0].type = X86_VAR_REG;
+    switch (op) {
+    case 0xf:
+        decode->op[0].reg = REG_SEG_CS;
+        break;
+    case 0x17:
+        decode->op[0].reg = REG_SEG_SS;
+        break;
+    case 0x1f:
+        decode->op[0].reg = REG_SEG_DS;
+        break;
+    case 0x07:
+        decode->op[0].reg = REG_SEG_ES;
+        break;
+    case 0xa1:
+        decode->op[0].reg = REG_SEG_FS;
+        break;
+    case 0xa9:
+        decode->op[0].reg = REG_SEG_GS;
+        break;
+    }
+}
+
+static void decode_incgroup(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[0].type = X86_VAR_REG;
+    decode->op[0].reg = decode->opcode[0] - 0x40;
+    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
+                                    decode->operand_size);
+}
+
+static void decode_decgroup(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[0].type = X86_VAR_REG;
+    decode->op[0].reg = decode->opcode[0] - 0x48;
+    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
+                                    decode->operand_size);
+}
+
+static void decode_incgroup2(CPUX86State *env, struct x86_decode *decode)
+{
+    if (!decode->modrm.reg) {
+        decode->cmd = X86_DECODE_CMD_INC;
+    } else if (1 == decode->modrm.reg) {
+        decode->cmd = X86_DECODE_CMD_DEC;
+    }
+}
+
+static void decode_pushgroup(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[0].type = X86_VAR_REG;
+    decode->op[0].reg = decode->opcode[0] - 0x50;
+    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
+                                    decode->operand_size);
+}
+
+static void decode_popgroup(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[0].type = X86_VAR_REG;
+    decode->op[0].reg = decode->opcode[0] - 0x58;
+    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
+                                    decode->operand_size);
+}
+
+static void decode_jxx(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->displacement = decode_bytes(env, decode, decode->operand_size);
+    decode->displacement_size = decode->operand_size;
+}
+
+static void decode_farjmp(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[0].type = X86_VAR_IMMEDIATE;
+    decode->op[0].val = decode_bytes(env, decode, decode->operand_size);
+    decode->displacement = decode_word(env, decode);
+}
+
+static void decode_addgroup(CPUX86State *env, struct x86_decode *decode)
+{
+    enum x86_decode_cmd group[] = {
+        X86_DECODE_CMD_ADD,
+        X86_DECODE_CMD_OR,
+        X86_DECODE_CMD_ADC,
+        X86_DECODE_CMD_SBB,
+        X86_DECODE_CMD_AND,
+        X86_DECODE_CMD_SUB,
+        X86_DECODE_CMD_XOR,
+        X86_DECODE_CMD_CMP
+    };
+    decode->cmd = group[decode->modrm.reg];
+}
+
+static void decode_rotgroup(CPUX86State *env, struct x86_decode *decode)
+{
+    enum x86_decode_cmd group[] = {
+        X86_DECODE_CMD_ROL,
+        X86_DECODE_CMD_ROR,
+        X86_DECODE_CMD_RCL,
+        X86_DECODE_CMD_RCR,
+        X86_DECODE_CMD_SHL,
+        X86_DECODE_CMD_SHR,
+        X86_DECODE_CMD_SHL,
+        X86_DECODE_CMD_SAR
+    };
+    decode->cmd = group[decode->modrm.reg];
+}
+
+static void decode_f7group(CPUX86State *env, struct x86_decode *decode)
+{
+    enum x86_decode_cmd group[] = {
+        X86_DECODE_CMD_TST,
+        X86_DECODE_CMD_TST,
+        X86_DECODE_CMD_NOT,
+        X86_DECODE_CMD_NEG,
+        X86_DECODE_CMD_MUL,
+        X86_DECODE_CMD_IMUL_1,
+        X86_DECODE_CMD_DIV,
+        X86_DECODE_CMD_IDIV
+    };
+    decode->cmd = group[decode->modrm.reg];
+    decode_modrm_rm(env, decode, &decode->op[0]);
+
+    switch (decode->modrm.reg) {
+    case 0:
+    case 1:
+        decode_imm(env, decode, &decode->op[1]);
+        break;
+    case 2:
+        break;
+    case 3:
+        decode->op[1].type = X86_VAR_IMMEDIATE;
+        decode->op[1].val = 0;
+        break;
+    default:
+        break;
+    }
+}
+
+static void decode_xchgroup(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[0].type = X86_VAR_REG;
+    decode->op[0].reg = decode->opcode[0] - 0x90;
+    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
+                                    decode->operand_size);
+}
+
+static void decode_movgroup(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[0].type = X86_VAR_REG;
+    decode->op[0].reg = decode->opcode[0] - 0xb8;
+    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
+                                    decode->operand_size);
+    decode_immediate(env, decode, &decode->op[1], decode->operand_size);
+}
+
+static void fetch_moffs(CPUX86State *env, struct x86_decode *decode,
+                        struct x86_decode_op *op)
+{
+    op->type = X86_VAR_OFFSET;
+    op->ptr = decode_bytes(env, decode, decode->addressing_size);
+}
+
+static void decode_movgroup8(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[0].type = X86_VAR_REG;
+    decode->op[0].reg = decode->opcode[0] - 0xb0;
+    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
+                                    decode->operand_size);
+    decode_immediate(env, decode, &decode->op[1], decode->operand_size);
+}
+
+static void decode_rcx(CPUX86State *env, struct x86_decode *decode,
+                       struct x86_decode_op *op)
+{
+    op->type = X86_VAR_REG;
+    op->reg = REG_RCX;
+    op->ptr = get_reg_ref(env, op->reg, decode->rex.b, decode->operand_size);
+}
+
+struct decode_tbl {
+    uint8_t opcode;
+    enum x86_decode_cmd cmd;
+    uint8_t operand_size;
+    bool is_modrm;
+    void (*decode_op1)(CPUX86State *env, struct x86_decode *decode,
+                       struct x86_decode_op *op1);
+    void (*decode_op2)(CPUX86State *env, struct x86_decode *decode,
+                       struct x86_decode_op *op2);
+    void (*decode_op3)(CPUX86State *env, struct x86_decode *decode,
+                       struct x86_decode_op *op3);
+    void (*decode_op4)(CPUX86State *env, struct x86_decode *decode,
+                       struct x86_decode_op *op4);
+    void (*decode_postfix)(CPUX86State *env, struct x86_decode *decode);
+    addr_t flags_mask;
+};
+
+struct decode_x87_tbl {
+    uint8_t opcode;
+    uint8_t modrm_reg;
+    uint8_t modrm_mod;
+    enum x86_decode_cmd cmd;
+    uint8_t operand_size;
+    bool rev;
+    bool pop;
+    void (*decode_op1)(CPUX86State *env, struct x86_decode *decode,
+                       struct x86_decode_op *op1);
+    void (*decode_op2)(CPUX86State *env, struct x86_decode *decode,
+                       struct x86_decode_op *op2);
+    void (*decode_postfix)(CPUX86State *env, struct x86_decode *decode);
+    addr_t flags_mask;
+};
+
+struct decode_tbl invl_inst = {0x0, 0, 0, false, NULL, NULL, NULL, NULL,
+                               decode_invalid};
+
+struct decode_tbl _decode_tbl1[255];
+struct decode_tbl _decode_tbl2[255];
+struct decode_x87_tbl _decode_tbl3[255];
+
+static void decode_x87_ins(CPUX86State *env, struct x86_decode *decode)
+{
+    struct decode_x87_tbl *decoder;
+    
+    decode->is_fpu = true;
+    int mode = decode->modrm.mod == 3 ? 1 : 0;
+    int index = ((decode->opcode[0] & 0xf) << 4) | (mode << 3) |
+                 decode->modrm.reg;
+
+    decoder = &_decode_tbl3[index];
+    
+    decode->cmd = decoder->cmd;
+    if (decoder->operand_size) {
+        decode->operand_size = decoder->operand_size;
+    }
+    decode->flags_mask = decoder->flags_mask;
+    decode->fpop_stack = decoder->pop;
+    decode->frev = decoder->rev;
+    
+    if (decoder->decode_op1) {
+        decoder->decode_op1(env, decode, &decode->op[0]);
+    }
+    if (decoder->decode_op2) {
+        decoder->decode_op2(env, decode, &decode->op[1]);
+    }
+    if (decoder->decode_postfix) {
+        decoder->decode_postfix(env, decode);
+    }
+
+    VM_PANIC_ON_EX(!decode->cmd, "x87 opcode %x %x (%x %x) not decoded\n",
+                   decode->opcode[0], decode->modrm.modrm, decoder->modrm_reg,
+                   decoder->modrm_mod);
+}
+
+static void decode_ffgroup(CPUX86State *env, struct x86_decode *decode)
+{
+    enum x86_decode_cmd group[] = {
+        X86_DECODE_CMD_INC,
+        X86_DECODE_CMD_DEC,
+        X86_DECODE_CMD_CALL_NEAR_ABS_INDIRECT,
+        X86_DECODE_CMD_CALL_FAR_ABS_INDIRECT,
+        X86_DECODE_CMD_JMP_NEAR_ABS_INDIRECT,
+        X86_DECODE_CMD_JMP_FAR_ABS_INDIRECT,
+        X86_DECODE_CMD_PUSH,
+        X86_DECODE_CMD_INVL,
+        X86_DECODE_CMD_INVL
+    };
+    decode->cmd = group[decode->modrm.reg];
+    if (decode->modrm.reg > 2) {
+        decode->flags_mask = 0;
+    }
+}
+
+static void decode_sldtgroup(CPUX86State *env, struct x86_decode *decode)
+{
+
+    enum x86_decode_cmd group[] = {
+        X86_DECODE_CMD_SLDT,
+        X86_DECODE_CMD_STR,
+        X86_DECODE_CMD_LLDT,
+        X86_DECODE_CMD_LTR,
+        X86_DECODE_CMD_VERR,
+        X86_DECODE_CMD_VERW,
+        X86_DECODE_CMD_INVL,
+        X86_DECODE_CMD_INVL
+    };
+    decode->cmd = group[decode->modrm.reg];
+    printf("%llx: decode_sldtgroup: %d\n", env->hvf_emul->fetch_rip,
+            decode->modrm.reg);
+}
+
+static void decode_lidtgroup(CPUX86State *env, struct x86_decode *decode)
+{
+    enum x86_decode_cmd group[] = {
+        X86_DECODE_CMD_SGDT,
+        X86_DECODE_CMD_SIDT,
+        X86_DECODE_CMD_LGDT,
+        X86_DECODE_CMD_LIDT,
+        X86_DECODE_CMD_SMSW,
+        X86_DECODE_CMD_LMSW,
+        X86_DECODE_CMD_LMSW,
+        X86_DECODE_CMD_INVLPG
+    };
+    decode->cmd = group[decode->modrm.reg];
+    if (0xf9 == decode->modrm.modrm) {
+        decode->opcode[decode->len++] = decode->modrm.modrm;
+        decode->cmd = X86_DECODE_CMD_RDTSCP;
+    }
+}
+
+static void decode_btgroup(CPUX86State *env, struct x86_decode *decode)
+{
+    enum x86_decode_cmd group[] = {
+        X86_DECODE_CMD_INVL,
+        X86_DECODE_CMD_INVL,
+        X86_DECODE_CMD_INVL,
+        X86_DECODE_CMD_INVL,
+        X86_DECODE_CMD_BT,
+        X86_DECODE_CMD_BTS,
+        X86_DECODE_CMD_BTR,
+        X86_DECODE_CMD_BTC
+    };
+    decode->cmd = group[decode->modrm.reg];
+}
+
+static void decode_x87_general(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->is_fpu = true;
+}
+
+static void decode_x87_modrm_floatp(CPUX86State *env, struct x86_decode *decode,
+                                    struct x86_decode_op *op)
+{
+    op->type = X87_VAR_FLOATP;
+}
+
+static void decode_x87_modrm_intp(CPUX86State *env, struct x86_decode *decode,
+                                  struct x86_decode_op *op)
+{
+    op->type = X87_VAR_INTP;
+}
+
+static void decode_x87_modrm_bytep(CPUX86State *env, struct x86_decode *decode,
+                                   struct x86_decode_op *op)
+{
+    op->type = X87_VAR_BYTEP;
+}
+
+static void decode_x87_modrm_st0(CPUX86State *env, struct x86_decode *decode,
+                                 struct x86_decode_op *op)
+{
+    op->type = X87_VAR_REG;
+    op->reg = 0;
+}
+
+static void decode_decode_x87_modrm_st0(CPUX86State *env,
+                                        struct x86_decode *decode,
+                                        struct x86_decode_op *op)
+{
+    op->type = X87_VAR_REG;
+    op->reg = decode->modrm.modrm & 7;
+}
+
+
+static void decode_aegroup(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->is_fpu = true;
+    switch (decode->modrm.reg) {
+    case 0:
+        decode->cmd = X86_DECODE_CMD_FXSAVE;
+        decode_x87_modrm_bytep(env, decode, &decode->op[0]);
+        break;
+    case 1:
+        decode_x87_modrm_bytep(env, decode, &decode->op[0]);
+        decode->cmd = X86_DECODE_CMD_FXRSTOR;
+        break;
+    case 5:
+        if (decode->modrm.modrm == 0xe8) {
+            decode->cmd = X86_DECODE_CMD_LFENCE;
+        } else {
+            VM_PANIC("xrstor");
+        }
+        break;
+    case 6:
+        VM_PANIC_ON(decode->modrm.modrm != 0xf0);
+        decode->cmd = X86_DECODE_CMD_MFENCE;
+        break;
+    case 7:
+        if (decode->modrm.modrm == 0xf8) {
+            decode->cmd = X86_DECODE_CMD_SFENCE;
+        } else {
+            decode->cmd = X86_DECODE_CMD_CLFLUSH;
+        }
+        break;
+    default:
+        VM_PANIC_ON_EX(1, "0xae: reg %d\n", decode->modrm.reg);
+        break;
+    }
+}
+
+static void decode_bswap(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[0].type = X86_VAR_REG;
+    decode->op[0].reg = decode->opcode[1] - 0xc8;
+    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
+                                    decode->operand_size);
+}
+
+static void decode_d9_4(CPUX86State *env, struct x86_decode *decode)
+{
+    switch (decode->modrm.modrm) {
+    case 0xe0:
+        /* FCHS */
+        decode->cmd = X86_DECODE_CMD_FCHS;
+        break;
+    case 0xe1:
+        decode->cmd = X86_DECODE_CMD_FABS;
+        break;
+    case 0xe4:
+        VM_PANIC_ON_EX(1, "FTST");
+        break;
+    case 0xe5:
+        /* FXAM */
+        decode->cmd = X86_DECODE_CMD_FXAM;
+        break;
+    default:
+        VM_PANIC_ON_EX(1, "FLDENV");
+        break;
+    }
+}
+
+static void decode_db_4(CPUX86State *env, struct x86_decode *decode)
+{
+    switch (decode->modrm.modrm) {
+    case 0xe0:
+        VM_PANIC_ON_EX(1, "unhandled FNENI: %x %x\n", decode->opcode[0],
+                       decode->modrm.modrm);
+        break;
+    case 0xe1:
+        VM_PANIC_ON_EX(1, "unhandled FNDISI: %x %x\n", decode->opcode[0],
+                       decode->modrm.modrm);
+        break;
+    case 0xe2:
+        VM_PANIC_ON_EX(1, "unhandled FCLEX: %x %x\n", decode->opcode[0],
+                       decode->modrm.modrm);
+        break;
+    case 0xe3:
+        decode->cmd = X86_DECODE_CMD_FNINIT;
+        break;
+    case 0xe4:
+        decode->cmd = X86_DECODE_CMD_FNSETPM;
+        break;
+    default:
+        VM_PANIC_ON_EX(1, "unhandled fpu opcode: %x %x\n", decode->opcode[0],
+                       decode->modrm.modrm);
+        break;
+    }
+}
+
+
+#define RFLAGS_MASK_NONE    0
+#define RFLAGS_MASK_OSZAPC  (RFLAGS_OF | RFLAGS_SF | RFLAGS_ZF | RFLAGS_AF | \
+                             RFLAGS_PF | RFLAGS_CF)
+#define RFLAGS_MASK_LAHF    (RFLAGS_SF | RFLAGS_ZF | RFLAGS_AF | RFLAGS_PF | \
+                             RFLAGS_CF)
+#define RFLAGS_MASK_CF      (RFLAGS_CF)
+#define RFLAGS_MASK_IF      (RFLAGS_IF)
+#define RFLAGS_MASK_TF      (RFLAGS_TF)
+#define RFLAGS_MASK_DF      (RFLAGS_DF)
+#define RFLAGS_MASK_ZF      (RFLAGS_ZF)
+
+struct decode_tbl _1op_inst[] = {
+    {0x0, X86_DECODE_CMD_ADD, 1, true, decode_modrm_rm, decode_modrm_reg, NULL,
+     NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x1, X86_DECODE_CMD_ADD, 0, true, decode_modrm_rm, decode_modrm_reg, NULL,
+     NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x2, X86_DECODE_CMD_ADD, 1, true, decode_modrm_reg, decode_modrm_rm, NULL,
+     NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x3, X86_DECODE_CMD_ADD, 0, true, decode_modrm_reg, decode_modrm_rm, NULL,
+     NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x4, X86_DECODE_CMD_ADD, 1, false, decode_rax, decode_imm8, NULL, NULL,
+     NULL, RFLAGS_MASK_OSZAPC},
+    {0x5, X86_DECODE_CMD_ADD, 0, false, decode_rax, decode_imm, NULL, NULL,
+     NULL, RFLAGS_MASK_OSZAPC},
+    {0x6, X86_DECODE_CMD_PUSH_SEG, 0, false, false, NULL, NULL, NULL,
+     decode_pushseg, RFLAGS_MASK_NONE},
+    {0x7, X86_DECODE_CMD_POP_SEG, 0, false, false, NULL, NULL, NULL,
+     decode_popseg, RFLAGS_MASK_NONE},
+    {0x8, X86_DECODE_CMD_OR, 1, true, decode_modrm_rm, decode_modrm_reg, NULL,
+     NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x9, X86_DECODE_CMD_OR, 0, true, decode_modrm_rm, decode_modrm_reg, NULL,
+     NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xa, X86_DECODE_CMD_OR, 1, true, decode_modrm_reg, decode_modrm_rm, NULL,
+     NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xb, X86_DECODE_CMD_OR, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xc, X86_DECODE_CMD_OR, 1, false, decode_rax, decode_imm8,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xd, X86_DECODE_CMD_OR, 0, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0xe, X86_DECODE_CMD_PUSH_SEG, 0, false, false,
+     NULL, NULL, NULL, decode_pushseg, RFLAGS_MASK_NONE},
+    {0xf, X86_DECODE_CMD_POP_SEG, 0, false, false,
+     NULL, NULL, NULL, decode_popseg, RFLAGS_MASK_NONE},
+
+    {0x10, X86_DECODE_CMD_ADC, 1, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x11, X86_DECODE_CMD_ADC, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x12, X86_DECODE_CMD_ADC, 1, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x13, X86_DECODE_CMD_ADC, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x14, X86_DECODE_CMD_ADC, 1, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x15, X86_DECODE_CMD_ADC, 0, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0x16, X86_DECODE_CMD_PUSH_SEG, 0, false, false,
+     NULL, NULL, NULL, decode_pushseg, RFLAGS_MASK_NONE},
+    {0x17, X86_DECODE_CMD_POP_SEG, 0, false, false,
+     NULL, NULL, NULL, decode_popseg, RFLAGS_MASK_NONE},
+
+    {0x18, X86_DECODE_CMD_SBB, 1, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x19, X86_DECODE_CMD_SBB, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x1a, X86_DECODE_CMD_SBB, 1, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x1b, X86_DECODE_CMD_SBB, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x1c, X86_DECODE_CMD_SBB, 1, false, decode_rax, decode_imm8,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x1d, X86_DECODE_CMD_SBB, 0, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0x1e, X86_DECODE_CMD_PUSH_SEG, 0, false, false,
+     NULL, NULL, NULL, decode_pushseg, RFLAGS_MASK_NONE},
+    {0x1f, X86_DECODE_CMD_POP_SEG, 0, false, false,
+     NULL, NULL, NULL, decode_popseg, RFLAGS_MASK_NONE},
+
+    {0x20, X86_DECODE_CMD_AND, 1, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x21, X86_DECODE_CMD_AND, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x22, X86_DECODE_CMD_AND, 1, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x23, X86_DECODE_CMD_AND, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x24, X86_DECODE_CMD_AND, 1, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x25, X86_DECODE_CMD_AND, 0, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x28, X86_DECODE_CMD_SUB, 1, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x29, X86_DECODE_CMD_SUB, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x2a, X86_DECODE_CMD_SUB, 1, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x2b, X86_DECODE_CMD_SUB, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x2c, X86_DECODE_CMD_SUB, 1, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x2d, X86_DECODE_CMD_SUB, 0, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x2f, X86_DECODE_CMD_DAS, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x30, X86_DECODE_CMD_XOR, 1, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x31, X86_DECODE_CMD_XOR, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x32, X86_DECODE_CMD_XOR, 1, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x33, X86_DECODE_CMD_XOR, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x34, X86_DECODE_CMD_XOR, 1, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x35, X86_DECODE_CMD_XOR, 0, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0x38, X86_DECODE_CMD_CMP, 1, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x39, X86_DECODE_CMD_CMP, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x3a, X86_DECODE_CMD_CMP, 1, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x3b, X86_DECODE_CMD_CMP, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x3c, X86_DECODE_CMD_CMP, 1, false, decode_rax, decode_imm8,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x3d, X86_DECODE_CMD_CMP, 0, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0x3f, X86_DECODE_CMD_AAS, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0x40, X86_DECODE_CMD_INC, 0, false,
+     NULL, NULL, NULL, NULL, decode_incgroup, RFLAGS_MASK_OSZAPC},
+    {0x41, X86_DECODE_CMD_INC, 0, false,
+     NULL, NULL, NULL, NULL, decode_incgroup, RFLAGS_MASK_OSZAPC},
+    {0x42, X86_DECODE_CMD_INC, 0, false,
+     NULL, NULL, NULL, NULL, decode_incgroup, RFLAGS_MASK_OSZAPC},
+    {0x43, X86_DECODE_CMD_INC, 0, false,
+     NULL, NULL, NULL, NULL, decode_incgroup, RFLAGS_MASK_OSZAPC},
+    {0x44, X86_DECODE_CMD_INC, 0, false,
+     NULL, NULL, NULL, NULL, decode_incgroup, RFLAGS_MASK_OSZAPC},
+    {0x45, X86_DECODE_CMD_INC, 0, false,
+     NULL, NULL, NULL, NULL, decode_incgroup, RFLAGS_MASK_OSZAPC},
+    {0x46, X86_DECODE_CMD_INC, 0, false,
+     NULL, NULL, NULL, NULL, decode_incgroup, RFLAGS_MASK_OSZAPC},
+    {0x47, X86_DECODE_CMD_INC, 0, false,
+     NULL, NULL, NULL, NULL, decode_incgroup, RFLAGS_MASK_OSZAPC},
+
+    {0x48, X86_DECODE_CMD_DEC, 0, false,
+     NULL, NULL, NULL, NULL, decode_decgroup, RFLAGS_MASK_OSZAPC},
+    {0x49, X86_DECODE_CMD_DEC, 0, false,
+     NULL, NULL, NULL, NULL, decode_decgroup, RFLAGS_MASK_OSZAPC},
+    {0x4a, X86_DECODE_CMD_DEC, 0, false,
+     NULL, NULL, NULL, NULL, decode_decgroup, RFLAGS_MASK_OSZAPC},
+    {0x4b, X86_DECODE_CMD_DEC, 0, false,
+     NULL, NULL, NULL, NULL, decode_decgroup, RFLAGS_MASK_OSZAPC},
+    {0x4c, X86_DECODE_CMD_DEC, 0, false,
+     NULL, NULL, NULL, NULL, decode_decgroup, RFLAGS_MASK_OSZAPC},
+    {0x4d, X86_DECODE_CMD_DEC, 0, false,
+     NULL, NULL, NULL, NULL, decode_decgroup, RFLAGS_MASK_OSZAPC},
+    {0x4e, X86_DECODE_CMD_DEC, 0, false,
+     NULL, NULL, NULL, NULL, decode_decgroup, RFLAGS_MASK_OSZAPC},
+    {0x4f, X86_DECODE_CMD_DEC, 0, false,
+     NULL, NULL, NULL, NULL, decode_decgroup, RFLAGS_MASK_OSZAPC},
+
+    {0x50, X86_DECODE_CMD_PUSH, 0, false,
+     NULL, NULL, NULL, NULL, decode_pushgroup, RFLAGS_MASK_NONE},
+    {0x51, X86_DECODE_CMD_PUSH, 0, false,
+     NULL, NULL, NULL, NULL, decode_pushgroup, RFLAGS_MASK_NONE},
+    {0x52, X86_DECODE_CMD_PUSH, 0, false,
+     NULL, NULL, NULL, NULL, decode_pushgroup, RFLAGS_MASK_NONE},
+    {0x53, X86_DECODE_CMD_PUSH, 0, false,
+     NULL, NULL, NULL, NULL, decode_pushgroup, RFLAGS_MASK_NONE},
+    {0x54, X86_DECODE_CMD_PUSH, 0, false,
+     NULL, NULL, NULL, NULL, decode_pushgroup, RFLAGS_MASK_NONE},
+    {0x55, X86_DECODE_CMD_PUSH, 0, false,
+     NULL, NULL, NULL, NULL, decode_pushgroup, RFLAGS_MASK_NONE},
+    {0x56, X86_DECODE_CMD_PUSH, 0, false,
+     NULL, NULL, NULL, NULL, decode_pushgroup, RFLAGS_MASK_NONE},
+    {0x57, X86_DECODE_CMD_PUSH, 0, false,
+     NULL, NULL, NULL, NULL, decode_pushgroup, RFLAGS_MASK_NONE},
+
+    {0x58, X86_DECODE_CMD_POP, 0, false,
+     NULL, NULL, NULL, NULL, decode_popgroup, RFLAGS_MASK_NONE},
+    {0x59, X86_DECODE_CMD_POP, 0, false,
+     NULL, NULL, NULL, NULL, decode_popgroup, RFLAGS_MASK_NONE},
+    {0x5a, X86_DECODE_CMD_POP, 0, false,
+     NULL, NULL, NULL, NULL, decode_popgroup, RFLAGS_MASK_NONE},
+    {0x5b, X86_DECODE_CMD_POP, 0, false,
+     NULL, NULL, NULL, NULL, decode_popgroup, RFLAGS_MASK_NONE},
+    {0x5c, X86_DECODE_CMD_POP, 0, false,
+     NULL, NULL, NULL, NULL, decode_popgroup, RFLAGS_MASK_NONE},
+    {0x5d, X86_DECODE_CMD_POP, 0, false,
+     NULL, NULL, NULL, NULL, decode_popgroup, RFLAGS_MASK_NONE},
+    {0x5e, X86_DECODE_CMD_POP, 0, false,
+     NULL, NULL, NULL, NULL, decode_popgroup, RFLAGS_MASK_NONE},
+    {0x5f, X86_DECODE_CMD_POP, 0, false,
+     NULL, NULL, NULL, NULL, decode_popgroup, RFLAGS_MASK_NONE},
+
+    {0x60, X86_DECODE_CMD_PUSHA, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x61, X86_DECODE_CMD_POPA, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0x68, X86_DECODE_CMD_PUSH, 0, false, decode_imm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x6a, X86_DECODE_CMD_PUSH, 0, false, decode_imm8_signed,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x69, X86_DECODE_CMD_IMUL_3, 0, true, decode_modrm_reg,
+     decode_modrm_rm, decode_imm, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x6b, X86_DECODE_CMD_IMUL_3, 0, true, decode_modrm_reg, decode_modrm_rm,
+     decode_imm8_signed, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0x6c, X86_DECODE_CMD_INS, 1, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x6d, X86_DECODE_CMD_INS, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x6e, X86_DECODE_CMD_OUTS, 1, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x6f, X86_DECODE_CMD_OUTS, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0x70, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x71, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x72, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x73, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x74, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x75, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x76, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x77, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x78, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x79, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x7a, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x7b, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x7c, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x7d, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x7e, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x7f, X86_DECODE_CMD_JXX, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+
+    {0x80, X86_DECODE_CMD_INVL, 1, true, decode_modrm_rm, decode_imm8,
+     NULL, NULL, decode_addgroup, RFLAGS_MASK_OSZAPC},
+    {0x81, X86_DECODE_CMD_INVL, 0, true, decode_modrm_rm, decode_imm,
+     NULL, NULL, decode_addgroup, RFLAGS_MASK_OSZAPC},
+    {0x82, X86_DECODE_CMD_INVL, 1, true, decode_modrm_rm, decode_imm8,
+     NULL, NULL, decode_addgroup, RFLAGS_MASK_OSZAPC},
+    {0x83, X86_DECODE_CMD_INVL, 0, true, decode_modrm_rm, decode_imm8_signed,
+     NULL, NULL, decode_addgroup, RFLAGS_MASK_OSZAPC},
+    {0x84, X86_DECODE_CMD_TST, 1, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x85, X86_DECODE_CMD_TST, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0x86, X86_DECODE_CMD_XCHG, 1, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x87, X86_DECODE_CMD_XCHG, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x88, X86_DECODE_CMD_MOV, 1, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x89, X86_DECODE_CMD_MOV, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x8a, X86_DECODE_CMD_MOV, 1, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x8b, X86_DECODE_CMD_MOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x8c, X86_DECODE_CMD_MOV_FROM_SEG, 0, true, decode_modrm_rm,
+     decode_modrm_reg, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x8d, X86_DECODE_CMD_LEA, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x8e, X86_DECODE_CMD_MOV_TO_SEG, 0, true, decode_modrm_reg,
+     decode_modrm_rm, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x8f, X86_DECODE_CMD_POP, 0, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0x90, X86_DECODE_CMD_NOP, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x91, X86_DECODE_CMD_XCHG, 0, false, NULL, decode_rax,
+     NULL, NULL, decode_xchgroup, RFLAGS_MASK_NONE},
+    {0x92, X86_DECODE_CMD_XCHG, 0, false, NULL, decode_rax,
+     NULL, NULL, decode_xchgroup, RFLAGS_MASK_NONE},
+    {0x93, X86_DECODE_CMD_XCHG, 0, false, NULL, decode_rax,
+     NULL, NULL, decode_xchgroup, RFLAGS_MASK_NONE},
+    {0x94, X86_DECODE_CMD_XCHG, 0, false, NULL, decode_rax,
+     NULL, NULL, decode_xchgroup, RFLAGS_MASK_NONE},
+    {0x95, X86_DECODE_CMD_XCHG, 0, false, NULL, decode_rax,
+     NULL, NULL, decode_xchgroup, RFLAGS_MASK_NONE},
+    {0x96, X86_DECODE_CMD_XCHG, 0, false, NULL, decode_rax,
+     NULL, NULL, decode_xchgroup, RFLAGS_MASK_NONE},
+    {0x97, X86_DECODE_CMD_XCHG, 0, false, NULL, decode_rax,
+     NULL, NULL, decode_xchgroup, RFLAGS_MASK_NONE},
+
+    {0x98, X86_DECODE_CMD_CBW, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x99, X86_DECODE_CMD_CWD, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0x9a, X86_DECODE_CMD_CALL_FAR, 0, false, NULL,
+     NULL, NULL, NULL, decode_farjmp, RFLAGS_MASK_NONE},
+
+    {0x9c, X86_DECODE_CMD_PUSHF, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    /*{0x9d, X86_DECODE_CMD_POPF, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_POPF},*/
+    {0x9e, X86_DECODE_CMD_SAHF, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x9f, X86_DECODE_CMD_LAHF, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_LAHF},
+
+    {0xa0, X86_DECODE_CMD_MOV, 1, false, decode_rax, fetch_moffs,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xa1, X86_DECODE_CMD_MOV, 0, false, decode_rax, fetch_moffs,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xa2, X86_DECODE_CMD_MOV, 1, false, fetch_moffs, decode_rax,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xa3, X86_DECODE_CMD_MOV, 0, false, fetch_moffs, decode_rax,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xa4, X86_DECODE_CMD_MOVS, 1, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xa5, X86_DECODE_CMD_MOVS, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xa6, X86_DECODE_CMD_CMPS, 1, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xa7, X86_DECODE_CMD_CMPS, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xaa, X86_DECODE_CMD_STOS, 1, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xab, X86_DECODE_CMD_STOS, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xac, X86_DECODE_CMD_LODS, 1, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xad, X86_DECODE_CMD_LODS, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xae, X86_DECODE_CMD_SCAS, 1, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xaf, X86_DECODE_CMD_SCAS, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0xa8, X86_DECODE_CMD_TST, 1, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xa9, X86_DECODE_CMD_TST, 0, false, decode_rax, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0xb0, X86_DECODE_CMD_MOV, 1, false, NULL,
+     NULL, NULL, NULL, decode_movgroup8, RFLAGS_MASK_NONE},
+    {0xb1, X86_DECODE_CMD_MOV, 1, false, NULL,
+     NULL, NULL, NULL, decode_movgroup8, RFLAGS_MASK_NONE},
+    {0xb2, X86_DECODE_CMD_MOV, 1, false, NULL,
+     NULL, NULL, NULL, decode_movgroup8, RFLAGS_MASK_NONE},
+    {0xb3, X86_DECODE_CMD_MOV, 1, false, NULL,
+     NULL, NULL, NULL, decode_movgroup8, RFLAGS_MASK_NONE},
+    {0xb4, X86_DECODE_CMD_MOV, 1, false, NULL,
+     NULL, NULL, NULL, decode_movgroup8, RFLAGS_MASK_NONE},
+    {0xb5, X86_DECODE_CMD_MOV, 1, false, NULL,
+     NULL, NULL, NULL, decode_movgroup8, RFLAGS_MASK_NONE},
+    {0xb6, X86_DECODE_CMD_MOV, 1, false, NULL,
+     NULL, NULL, NULL, decode_movgroup8, RFLAGS_MASK_NONE},
+    {0xb7, X86_DECODE_CMD_MOV, 1, false, NULL,
+     NULL, NULL, NULL, decode_movgroup8, RFLAGS_MASK_NONE},
+
+    {0xb8, X86_DECODE_CMD_MOV, 0, false, NULL,
+     NULL, NULL, NULL, decode_movgroup, RFLAGS_MASK_NONE},
+    {0xb9, X86_DECODE_CMD_MOV, 0, false, NULL,
+     NULL, NULL, NULL, decode_movgroup, RFLAGS_MASK_NONE},
+    {0xba, X86_DECODE_CMD_MOV, 0, false, NULL,
+     NULL, NULL, NULL, decode_movgroup, RFLAGS_MASK_NONE},
+    {0xbb, X86_DECODE_CMD_MOV, 0, false, NULL,
+     NULL, NULL, NULL, decode_movgroup, RFLAGS_MASK_NONE},
+    {0xbc, X86_DECODE_CMD_MOV, 0, false, NULL,
+     NULL, NULL, NULL, decode_movgroup, RFLAGS_MASK_NONE},
+    {0xbd, X86_DECODE_CMD_MOV, 0, false, NULL,
+     NULL, NULL, NULL, decode_movgroup, RFLAGS_MASK_NONE},
+    {0xbe, X86_DECODE_CMD_MOV, 0, false, NULL,
+     NULL, NULL, NULL, decode_movgroup, RFLAGS_MASK_NONE},
+    {0xbf, X86_DECODE_CMD_MOV, 0, false, NULL,
+     NULL, NULL, NULL, decode_movgroup, RFLAGS_MASK_NONE},
+
+    {0xc0, X86_DECODE_CMD_INVL, 1, true, decode_modrm_rm, decode_imm8,
+     NULL, NULL, decode_rotgroup, RFLAGS_MASK_OSZAPC},
+    {0xc1, X86_DECODE_CMD_INVL, 0, true, decode_modrm_rm, decode_imm8,
+     NULL, NULL, decode_rotgroup, RFLAGS_MASK_OSZAPC},
+
+    {0xc2, X86_DECODE_RET_NEAR, 0, false, decode_imm16,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xc3, X86_DECODE_RET_NEAR, 0, false, NULL,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xc4, X86_DECODE_CMD_LES, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xc5, X86_DECODE_CMD_LDS, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xc6, X86_DECODE_CMD_MOV, 1, true, decode_modrm_rm, decode_imm8,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xc7, X86_DECODE_CMD_MOV, 0, true, decode_modrm_rm, decode_imm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xc8, X86_DECODE_CMD_ENTER, 0, false, decode_imm16, decode_imm8,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xc9, X86_DECODE_CMD_LEAVE, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xca, X86_DECODE_RET_FAR, 0, false, decode_imm16, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xcb, X86_DECODE_RET_FAR, 0, false, decode_imm_0, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xcd, X86_DECODE_CMD_INT, 0, false, decode_imm8, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    /*{0xcf, X86_DECODE_CMD_IRET, 0, false, NULL, NULL,
+     NULL, NULL, NULL, RFLAGS_MASK_IRET},*/
+
+    {0xd0, X86_DECODE_CMD_INVL, 1, true, decode_modrm_rm, decode_imm_1,
+     NULL, NULL, decode_rotgroup, RFLAGS_MASK_OSZAPC},
+    {0xd1, X86_DECODE_CMD_INVL, 0, true, decode_modrm_rm, decode_imm_1,
+     NULL, NULL, decode_rotgroup, RFLAGS_MASK_OSZAPC},
+    {0xd2, X86_DECODE_CMD_INVL, 1, true, decode_modrm_rm, decode_rcx,
+     NULL, NULL, decode_rotgroup, RFLAGS_MASK_OSZAPC},
+    {0xd3, X86_DECODE_CMD_INVL, 0, true, decode_modrm_rm, decode_rcx,
+     NULL, NULL, decode_rotgroup, RFLAGS_MASK_OSZAPC},
+
+    {0xd4, X86_DECODE_CMD_AAM, 0, false, decode_imm8,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xd5, X86_DECODE_CMD_AAD, 0, false, decode_imm8,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0xd7, X86_DECODE_CMD_XLAT, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xd8, X86_DECODE_CMD_INVL, 0, true, NULL,
+     NULL, NULL, NULL, decode_x87_ins, RFLAGS_MASK_NONE},
+    {0xd9, X86_DECODE_CMD_INVL, 0, true, NULL,
+     NULL, NULL, NULL, decode_x87_ins, RFLAGS_MASK_NONE},
+    {0xda, X86_DECODE_CMD_INVL, 0, true, NULL,
+     NULL, NULL, NULL, decode_x87_ins, RFLAGS_MASK_NONE},
+    {0xdb, X86_DECODE_CMD_INVL, 0, true, NULL,
+     NULL, NULL, NULL, decode_x87_ins, RFLAGS_MASK_NONE},
+    {0xdc, X86_DECODE_CMD_INVL, 0, true, NULL,
+     NULL, NULL, NULL, decode_x87_ins, RFLAGS_MASK_NONE},
+    {0xdd, X86_DECODE_CMD_INVL, 0, true, NULL,
+     NULL, NULL, NULL, decode_x87_ins, RFLAGS_MASK_NONE},
+    {0xde, X86_DECODE_CMD_INVL, 0, true, NULL,
+     NULL, NULL, NULL, decode_x87_ins, RFLAGS_MASK_NONE},
+    {0xdf, X86_DECODE_CMD_INVL, 0, true, NULL,
+     NULL, NULL, NULL, decode_x87_ins, RFLAGS_MASK_NONE},
+
+    {0xe0, X86_DECODE_CMD_LOOP, 0, false, decode_imm8_signed,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xe1, X86_DECODE_CMD_LOOP, 0, false, decode_imm8_signed,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xe2, X86_DECODE_CMD_LOOP, 0, false, decode_imm8_signed,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xe3, X86_DECODE_CMD_JCXZ, 1, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+
+    {0xe4, X86_DECODE_CMD_IN, 1, false, decode_imm8,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xe5, X86_DECODE_CMD_IN, 0, false, decode_imm8,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xe6, X86_DECODE_CMD_OUT, 1, false, decode_imm8,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xe7, X86_DECODE_CMD_OUT, 0, false, decode_imm8,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xe8, X86_DECODE_CMD_CALL_NEAR, 0, false, decode_imm_signed,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xe9, X86_DECODE_CMD_JMP_NEAR, 0, false, decode_imm_signed,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xea, X86_DECODE_CMD_JMP_FAR, 0, false,
+     NULL, NULL, NULL, NULL, decode_farjmp, RFLAGS_MASK_NONE},
+    {0xeb, X86_DECODE_CMD_JMP_NEAR, 1, false, decode_imm8_signed,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xec, X86_DECODE_CMD_IN, 1, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xed, X86_DECODE_CMD_IN, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xee, X86_DECODE_CMD_OUT, 1, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xef, X86_DECODE_CMD_OUT, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xf4, X86_DECODE_CMD_HLT, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xf5, X86_DECODE_CMD_CMC, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_CF},
+
+    {0xf6, X86_DECODE_CMD_INVL, 1, true,
+     NULL, NULL, NULL, NULL, decode_f7group, RFLAGS_MASK_OSZAPC},
+    {0xf7, X86_DECODE_CMD_INVL, 0, true,
+     NULL, NULL, NULL, NULL, decode_f7group, RFLAGS_MASK_OSZAPC},
+
+    {0xf8, X86_DECODE_CMD_CLC, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_CF},
+    {0xf9, X86_DECODE_CMD_STC, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_CF},
+
+    {0xfa, X86_DECODE_CMD_CLI, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_IF},
+    {0xfb, X86_DECODE_CMD_STI, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_IF},
+    {0xfc, X86_DECODE_CMD_CLD, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_DF},
+    {0xfd, X86_DECODE_CMD_STD, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_DF},
+    {0xfe, X86_DECODE_CMD_INVL, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, decode_incgroup2, RFLAGS_MASK_OSZAPC},
+    {0xff, X86_DECODE_CMD_INVL, 0, true, decode_modrm_rm,
+     NULL, NULL, NULL, decode_ffgroup, RFLAGS_MASK_OSZAPC},
+};
+
+struct decode_tbl _2op_inst[] = {
+    {0x0, X86_DECODE_CMD_INVL, 0, true, decode_modrm_rm,
+     NULL, NULL, NULL, decode_sldtgroup, RFLAGS_MASK_NONE},
+    {0x1, X86_DECODE_CMD_INVL, 0, true, decode_modrm_rm,
+     NULL, NULL, NULL, decode_lidtgroup, RFLAGS_MASK_NONE},
+    {0x6, X86_DECODE_CMD_CLTS, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_TF},
+    {0x9, X86_DECODE_CMD_WBINVD, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x18, X86_DECODE_CMD_PREFETCH, 0, true,
+     NULL, NULL, NULL, NULL, decode_x87_general, RFLAGS_MASK_NONE},
+    {0x1f, X86_DECODE_CMD_NOP, 0, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x20, X86_DECODE_CMD_MOV_FROM_CR, 0, true, decode_modrm_rm,
+     decode_modrm_reg, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x21, X86_DECODE_CMD_MOV_FROM_DR, 0, true, decode_modrm_rm,
+     decode_modrm_reg, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x22, X86_DECODE_CMD_MOV_TO_CR, 0, true, decode_modrm_reg,
+     decode_modrm_rm, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x23, X86_DECODE_CMD_MOV_TO_DR, 0, true, decode_modrm_reg,
+     decode_modrm_rm, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x30, X86_DECODE_CMD_WRMSR, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x31, X86_DECODE_CMD_RDTSC, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x32, X86_DECODE_CMD_RDMSR, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x40, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x41, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x42, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x43, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x44, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x45, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x46, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x47, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x48, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x49, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x4a, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x4b, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x4c, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x4d, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x4e, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x4f, X86_DECODE_CMD_CMOV, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x77, X86_DECODE_CMD_EMMS, 0, false,
+     NULL, NULL, NULL, NULL, decode_x87_general, RFLAGS_MASK_NONE},
+    {0x82, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x83, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x84, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x85, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x86, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x87, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x88, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x89, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x8a, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x8b, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x8c, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x8d, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x8e, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x8f, X86_DECODE_CMD_JXX, 0, false,
+     NULL, NULL, NULL, NULL, decode_jxx, RFLAGS_MASK_NONE},
+    {0x90, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x91, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x92, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x93, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x94, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x95, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x96, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x97, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x98, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x99, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x9a, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x9b, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x9c, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x9d, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x9e, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0x9f, X86_DECODE_CMD_SETXX, 1, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xb0, X86_DECODE_CMD_CMPXCHG, 1, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xb1, X86_DECODE_CMD_CMPXCHG, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xb6, X86_DECODE_CMD_MOVZX, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xb7, X86_DECODE_CMD_MOVZX, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xb8, X86_DECODE_CMD_POPCNT, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xbe, X86_DECODE_CMD_MOVSX, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xbf, X86_DECODE_CMD_MOVSX, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xa0, X86_DECODE_CMD_PUSH_SEG, 0, false, false,
+     NULL, NULL, NULL, decode_pushseg, RFLAGS_MASK_NONE},
+    {0xa1, X86_DECODE_CMD_POP_SEG, 0, false, false,
+     NULL, NULL, NULL, decode_popseg, RFLAGS_MASK_NONE},
+    {0xa2, X86_DECODE_CMD_CPUID, 0, false,
+     NULL, NULL, NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xa3, X86_DECODE_CMD_BT, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_CF},
+    {0xa4, X86_DECODE_CMD_SHLD, 0, true, decode_modrm_rm, decode_modrm_reg,
+     decode_imm8, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xa5, X86_DECODE_CMD_SHLD, 0, true, decode_modrm_rm, decode_modrm_reg,
+     decode_rcx, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xa8, X86_DECODE_CMD_PUSH_SEG, 0, false, false,
+     NULL, NULL, NULL, decode_pushseg, RFLAGS_MASK_NONE},
+    {0xa9, X86_DECODE_CMD_POP_SEG, 0, false, false,
+     NULL, NULL, NULL, decode_popseg, RFLAGS_MASK_NONE},
+    {0xab, X86_DECODE_CMD_BTS, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_CF},
+    {0xac, X86_DECODE_CMD_SHRD, 0, true, decode_modrm_rm, decode_modrm_reg,
+     decode_imm8, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xad, X86_DECODE_CMD_SHRD, 0, true, decode_modrm_rm, decode_modrm_reg,
+     decode_rcx, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0xae, X86_DECODE_CMD_INVL, 0, true, decode_modrm_rm,
+     NULL, NULL, NULL, decode_aegroup, RFLAGS_MASK_NONE},
+
+    {0xaf, X86_DECODE_CMD_IMUL_2, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xb2, X86_DECODE_CMD_LSS, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xb3, X86_DECODE_CMD_BTR, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xba, X86_DECODE_CMD_INVL, 0, true, decode_modrm_rm, decode_imm8,
+     NULL, NULL, decode_btgroup, RFLAGS_MASK_OSZAPC},
+    {0xbb, X86_DECODE_CMD_BTC, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xbc, X86_DECODE_CMD_BSF, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+    {0xbd, X86_DECODE_CMD_BSR, 0, true, decode_modrm_reg, decode_modrm_rm,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0xc1, X86_DECODE_CMD_XADD, 0, true, decode_modrm_rm, decode_modrm_reg,
+     NULL, NULL, NULL, RFLAGS_MASK_OSZAPC},
+
+    {0xc7, X86_DECODE_CMD_CMPXCHG8B, 0, true, decode_modrm_rm,
+     NULL, NULL, NULL, NULL, RFLAGS_MASK_ZF},
+
+    {0xc8, X86_DECODE_CMD_BSWAP, 0, false,
+     NULL, NULL, NULL, NULL, decode_bswap, RFLAGS_MASK_NONE},
+    {0xc9, X86_DECODE_CMD_BSWAP, 0, false,
+     NULL, NULL, NULL, NULL, decode_bswap, RFLAGS_MASK_NONE},
+    {0xca, X86_DECODE_CMD_BSWAP, 0, false,
+     NULL, NULL, NULL, NULL, decode_bswap, RFLAGS_MASK_NONE},
+    {0xcb, X86_DECODE_CMD_BSWAP, 0, false,
+     NULL, NULL, NULL, NULL, decode_bswap, RFLAGS_MASK_NONE},
+    {0xcc, X86_DECODE_CMD_BSWAP, 0, false,
+     NULL, NULL, NULL, NULL, decode_bswap, RFLAGS_MASK_NONE},
+    {0xcd, X86_DECODE_CMD_BSWAP, 0, false,
+     NULL, NULL, NULL, NULL, decode_bswap, RFLAGS_MASK_NONE},
+    {0xce, X86_DECODE_CMD_BSWAP, 0, false,
+     NULL, NULL, NULL, NULL, decode_bswap, RFLAGS_MASK_NONE},
+    {0xcf, X86_DECODE_CMD_BSWAP, 0, false,
+     NULL, NULL, NULL, NULL, decode_bswap, RFLAGS_MASK_NONE},
+};
+
+struct decode_x87_tbl invl_inst_x87 = {0x0, 0, 0, 0, 0, false, false, NULL,
+                                       NULL, decode_invalid, 0};
+
+struct decode_x87_tbl _x87_inst[] = {
+    {0xd8, 0, 3, X86_DECODE_CMD_FADD, 10, false, false,
+     decode_x87_modrm_st0, decode_decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xd8, 0, 0, X86_DECODE_CMD_FADD, 4, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+    {0xd8, 1, 3, X86_DECODE_CMD_FMUL, 10, false, false, decode_x87_modrm_st0,
+     decode_decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xd8, 1, 0, X86_DECODE_CMD_FMUL, 4, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+    {0xd8, 4, 3, X86_DECODE_CMD_FSUB, 10, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xd8, 4, 0, X86_DECODE_CMD_FSUB, 4, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+    {0xd8, 5, 3, X86_DECODE_CMD_FSUB, 10, true, false, decode_x87_modrm_st0,
+     decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xd8, 5, 0, X86_DECODE_CMD_FSUB, 4, true, false, decode_x87_modrm_st0,
+     decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+    {0xd8, 6, 3, X86_DECODE_CMD_FDIV, 10, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xd8, 6, 0, X86_DECODE_CMD_FDIV, 4, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+    {0xd8, 7, 3, X86_DECODE_CMD_FDIV, 10, true, false, decode_x87_modrm_st0,
+     decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xd8, 7, 0, X86_DECODE_CMD_FDIV, 4, true, false, decode_x87_modrm_st0,
+     decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+
+    {0xd9, 0, 3, X86_DECODE_CMD_FLD, 10, false, false,
+     decode_x87_modrm_st0, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xd9, 0, 0, X86_DECODE_CMD_FLD, 4, false, false,
+     decode_x87_modrm_floatp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xd9, 1, 3, X86_DECODE_CMD_FXCH, 10, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xd9, 1, 0, X86_DECODE_CMD_INVL, 10, false, false,
+     decode_x87_modrm_st0, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xd9, 2, 3, X86_DECODE_CMD_INVL, 10, false, false,
+     decode_x87_modrm_st0, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xd9, 2, 0, X86_DECODE_CMD_FST, 4, false, false,
+     decode_x87_modrm_floatp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xd9, 3, 3, X86_DECODE_CMD_INVL, 10, false, false,
+     decode_x87_modrm_st0, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xd9, 3, 0, X86_DECODE_CMD_FST, 4, false, true,
+     decode_x87_modrm_floatp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xd9, 4, 3, X86_DECODE_CMD_INVL, 10, false, false,
+     decode_x87_modrm_st0, NULL, decode_d9_4, RFLAGS_MASK_NONE},
+    {0xd9, 4, 0, X86_DECODE_CMD_INVL, 4, false, false,
+     decode_x87_modrm_bytep, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL, NULL,
+     RFLAGS_MASK_NONE},
+    {0xd9, 5, 0, X86_DECODE_CMD_FLDCW, 2, false, false,
+     decode_x87_modrm_bytep, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xd9, 7, 3, X86_DECODE_CMD_FNSTCW, 2, false, false,
+     decode_x87_modrm_bytep, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xd9, 7, 0, X86_DECODE_CMD_FNSTCW, 2, false, false,
+     decode_x87_modrm_bytep, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xda, 0, 3, X86_DECODE_CMD_FCMOV, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xda, 0, 0, X86_DECODE_CMD_FADD, 4, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+    {0xda, 1, 3, X86_DECODE_CMD_FCMOV, 10, false, false, decode_x87_modrm_st0,
+     decode_decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xda, 1, 0, X86_DECODE_CMD_FMUL, 4, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+    {0xda, 2, 3, X86_DECODE_CMD_FCMOV, 10, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xda, 3, 3, X86_DECODE_CMD_FCMOV, 10, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
+     RFLAGS_MASK_NONE},
+    {0xda, 4, 0, X86_DECODE_CMD_FSUB, 4, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+    {0xda, 5, 3, X86_DECODE_CMD_FUCOM, 10, false, true, decode_x87_modrm_st0,
+     decode_decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xda, 5, 0, X86_DECODE_CMD_FSUB, 4, true, false, decode_x87_modrm_st0,
+     decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
+     RFLAGS_MASK_NONE},
+    {0xda, 6, 0, X86_DECODE_CMD_FDIV, 4, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
+     RFLAGS_MASK_NONE},
+    {0xda, 7, 0, X86_DECODE_CMD_FDIV, 4, true, false, decode_x87_modrm_st0,
+     decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+
+    {0xdb, 0, 3, X86_DECODE_CMD_FCMOV, 10, false, false, decode_x87_modrm_st0,
+     decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdb, 0, 0, X86_DECODE_CMD_FLD, 4, false, false,
+     decode_x87_modrm_intp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdb, 1, 3, X86_DECODE_CMD_FCMOV, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdb, 2, 3, X86_DECODE_CMD_FCMOV, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdb, 2, 0, X86_DECODE_CMD_FST, 4, false, false,
+     decode_x87_modrm_intp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdb, 3, 3, X86_DECODE_CMD_FCMOV, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdb, 3, 0, X86_DECODE_CMD_FST, 4, false, true,
+     decode_x87_modrm_intp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdb, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
+     decode_db_4, RFLAGS_MASK_NONE},
+    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
+     RFLAGS_MASK_NONE},
+    {0xdb, 5, 3, X86_DECODE_CMD_FUCOMI, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdb, 5, 0, X86_DECODE_CMD_FLD, 10, false, false,
+     decode_x87_modrm_floatp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdb, 7, 0, X86_DECODE_CMD_FST, 10, false, true,
+     decode_x87_modrm_floatp, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xdc, 0, 3, X86_DECODE_CMD_FADD, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdc, 0, 0, X86_DECODE_CMD_FADD, 8, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+    {0xdc, 1, 3, X86_DECODE_CMD_FMUL, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdc, 1, 0, X86_DECODE_CMD_FMUL, 8, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+    {0xdc, 4, 3, X86_DECODE_CMD_FSUB, 10, true, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdc, 4, 0, X86_DECODE_CMD_FSUB, 8, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+    {0xdc, 5, 3, X86_DECODE_CMD_FSUB, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdc, 5, 0, X86_DECODE_CMD_FSUB, 8, true, false,
+     decode_x87_modrm_st0, decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+    {0xdc, 6, 3, X86_DECODE_CMD_FDIV, 10, true, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdc, 6, 0, X86_DECODE_CMD_FDIV, 8, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+    {0xdc, 7, 3, X86_DECODE_CMD_FDIV, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdc, 7, 0, X86_DECODE_CMD_FDIV, 8, true, false,
+     decode_x87_modrm_st0, decode_x87_modrm_floatp, NULL, RFLAGS_MASK_NONE},
+
+    {0xdd, 0, 0, X86_DECODE_CMD_FLD, 8, false, false,
+     decode_x87_modrm_floatp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdd, 1, 3, X86_DECODE_CMD_FXCH, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdd, 2, 3, X86_DECODE_CMD_FST, 10, false, false,
+     decode_x87_modrm_st0, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdd, 2, 0, X86_DECODE_CMD_FST, 8, false, false,
+     decode_x87_modrm_floatp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdd, 3, 3, X86_DECODE_CMD_FST, 10, false, true,
+     decode_x87_modrm_st0, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdd, 3, 0, X86_DECODE_CMD_FST, 8, false, true,
+     decode_x87_modrm_floatp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdd, 4, 3, X86_DECODE_CMD_FUCOM, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdd, 4, 0, X86_DECODE_CMD_FRSTOR, 8, false, false,
+     decode_x87_modrm_bytep, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdd, 5, 3, X86_DECODE_CMD_FUCOM, 10, false, true,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdd, 7, 0, X86_DECODE_CMD_FNSTSW, 0, false, false,
+     decode_x87_modrm_bytep, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdd, 7, 3, X86_DECODE_CMD_FNSTSW, 0, false, false,
+     decode_x87_modrm_bytep, NULL, NULL, RFLAGS_MASK_NONE},
+
+    {0xde, 0, 3, X86_DECODE_CMD_FADD, 10, false, true,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xde, 0, 0, X86_DECODE_CMD_FADD, 2, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+    {0xde, 1, 3, X86_DECODE_CMD_FMUL, 10, false, true,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xde, 1, 0, X86_DECODE_CMD_FMUL, 2, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+    {0xde, 4, 3, X86_DECODE_CMD_FSUB, 10, true, true,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xde, 4, 0, X86_DECODE_CMD_FSUB, 2, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+    {0xde, 5, 3, X86_DECODE_CMD_FSUB, 10, false, true,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xde, 5, 0, X86_DECODE_CMD_FSUB, 2, true, false,
+     decode_x87_modrm_st0, decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+    {0xde, 6, 3, X86_DECODE_CMD_FDIV, 10, true, true,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xde, 6, 0, X86_DECODE_CMD_FDIV, 2, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+    {0xde, 7, 3, X86_DECODE_CMD_FDIV, 10, false, true,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xde, 7, 0, X86_DECODE_CMD_FDIV, 2, true, false,
+     decode_x87_modrm_st0, decode_x87_modrm_intp, NULL, RFLAGS_MASK_NONE},
+
+    {0xdf, 0, 0, X86_DECODE_CMD_FLD, 2, false, false,
+     decode_x87_modrm_intp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdf, 1, 3, X86_DECODE_CMD_FXCH, 10, false, false,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdf, 2, 3, X86_DECODE_CMD_FST, 10, false, true,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdf, 2, 0, X86_DECODE_CMD_FST, 2, false, false,
+     decode_x87_modrm_intp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdf, 3, 3, X86_DECODE_CMD_FST, 10, false, true,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdf, 3, 0, X86_DECODE_CMD_FST, 2, false, true,
+     decode_x87_modrm_intp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdf, 4, 3, X86_DECODE_CMD_FNSTSW, 2, false, true,
+     decode_x87_modrm_bytep, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdf, 5, 3, X86_DECODE_CMD_FUCOMI, 10, false, true,
+     decode_x87_modrm_st0, decode_x87_modrm_st0, NULL, RFLAGS_MASK_NONE},
+    {0xdf, 5, 0, X86_DECODE_CMD_FLD, 8, false, false,
+     decode_x87_modrm_intp, NULL, NULL, RFLAGS_MASK_NONE},
+    {0xdf, 7, 0, X86_DECODE_CMD_FST, 8, false, true,
+     decode_x87_modrm_intp, NULL, NULL, RFLAGS_MASK_NONE},
+};
+
+void calc_modrm_operand16(CPUX86State *env, struct x86_decode *decode,
+                          struct x86_decode_op *op)
+{
+    addr_t ptr = 0;
+    x86_reg_segment seg = REG_SEG_DS;
+
+    if (!decode->modrm.mod && 6 == decode->modrm.rm) {
+        op->ptr = (uint16_t)decode->displacement;
+        goto calc_addr;
+    }
+
+    if (decode->displacement_size) {
+        ptr = sign(decode->displacement, decode->displacement_size);
+    }
+
+    switch (decode->modrm.rm) {
+    case 0:
+        ptr += BX(env) + SI(env);
+        break;
+    case 1:
+        ptr += BX(env) + DI(env);
+        break;
+    case 2:
+        ptr += BP(env) + SI(env);
+        seg = REG_SEG_SS;
+        break;
+    case 3:
+        ptr += BP(env) + DI(env);
+        seg = REG_SEG_SS;
+        break;
+    case 4:
+        ptr += SI(env);
+        break;
+    case 5:
+        ptr += DI(env);
+        break;
+    case 6:
+        ptr += BP(env);
+        seg = REG_SEG_SS;
+        break;
+    case 7:
+        ptr += BX(env);
+        break;
+    }
+calc_addr:
+    if (X86_DECODE_CMD_LEA == decode->cmd) {
+        op->ptr = (uint16_t)ptr;
+    } else {
+        op->ptr = decode_linear_addr(env, decode, (uint16_t)ptr, seg);
+    }
+}
+
+addr_t get_reg_ref(CPUX86State *env, int reg, int is_extended, int size)
+{
+    addr_t ptr = 0;
+    int which = 0;
+
+    if (is_extended) {
+        reg |= REG_R8;
+    }
+
+
+    switch (size) {
+    case 1:
+        if (is_extended || reg < 4) {
+            which = 1;
+            ptr = (addr_t)&RL(env, reg);
+        } else {
+            which = 2;
+            ptr = (addr_t)&RH(env, reg - 4);
+        }
+        break;
+    default:
+        which = 3;
+        ptr = (addr_t)&RRX(env, reg);
+        break;
+    }
+    return ptr;
+}
+
+addr_t get_reg_val(CPUX86State *env, int reg, int is_extended, int size)
+{
+    addr_t val = 0;
+    memcpy(&val, (void *)get_reg_ref(env, reg, is_extended, size), size);
+    return val;
+}
+
+static addr_t get_sib_val(CPUX86State *env, struct x86_decode *decode,
+                          x86_reg_segment *sel)
+{
+    addr_t base = 0;
+    addr_t scaled_index = 0;
+    int addr_size = decode->addressing_size;
+    int base_reg = decode->sib.base;
+    int index_reg = decode->sib.index;
+
+    *sel = REG_SEG_DS;
+
+    if (decode->modrm.mod || base_reg != REG_RBP) {
+        if (decode->rex.b) {
+            base_reg |= REG_R8;
+        }
+        if (REG_RSP == base_reg || REG_RBP == base_reg) {
+            *sel = REG_SEG_SS;
+        }
+        base = get_reg_val(env, decode->sib.base, decode->rex.b, addr_size);
+    }
+
+    if (decode->rex.x) {
+        index_reg |= REG_R8;
+    }
+
+    if (index_reg != REG_RSP) {
+        scaled_index = get_reg_val(env, index_reg, decode->rex.x, addr_size) <<
+                                   decode->sib.scale;
+    }
+    return base + scaled_index;
+}
+
+void calc_modrm_operand32(CPUX86State *env, struct x86_decode *decode,
+                          struct x86_decode_op *op)
+{
+    x86_reg_segment seg = REG_SEG_DS;
+    addr_t ptr = 0;
+    int addr_size = decode->addressing_size;
+
+    if (decode->displacement_size) {
+        ptr = sign(decode->displacement, decode->displacement_size);
+    }
+
+    if (4 == decode->modrm.rm) {
+        ptr += get_sib_val(env, decode, &seg);
+    } else if (!decode->modrm.mod && 5 == decode->modrm.rm) {
+        if (x86_is_long_mode(ENV_GET_CPU(env))) {
+            ptr += RIP(env) + decode->len;
+        } else {
+            ptr = decode->displacement;
+        }
+    } else {
+        if (REG_RBP == decode->modrm.rm || REG_RSP == decode->modrm.rm) {
+            seg = REG_SEG_SS;
+        }
+        ptr += get_reg_val(env, decode->modrm.rm, decode->rex.b, addr_size);
+    }
+
+    if (X86_DECODE_CMD_LEA == decode->cmd) {
+        op->ptr = (uint32_t)ptr;
+    } else {
+        op->ptr = decode_linear_addr(env, decode, (uint32_t)ptr, seg);
+    }
+}
+
+void calc_modrm_operand64(CPUX86State *env, struct x86_decode *decode,
+                          struct x86_decode_op *op)
+{
+    x86_reg_segment seg = REG_SEG_DS;
+    int32_t offset = 0;
+    int mod = decode->modrm.mod;
+    int rm = decode->modrm.rm;
+    addr_t ptr;
+    int src = decode->modrm.rm;
+
+    if (decode->displacement_size) {
+        offset = sign(decode->displacement, decode->displacement_size);
+    }
+
+    if (4 == rm) {
+        ptr = get_sib_val(env, decode, &seg) + offset;
+    } else if (0 == mod && 5 == rm) {
+        ptr = RIP(env) + decode->len + (int32_t) offset;
+    } else {
+        ptr = get_reg_val(env, src, decode->rex.b, 8) + (int64_t) offset;
+    }
+
+    if (X86_DECODE_CMD_LEA == decode->cmd) {
+        op->ptr = ptr;
+    } else {
+        op->ptr = decode_linear_addr(env, decode, ptr, seg);
+    }
+}
+
+
+void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
+                        struct x86_decode_op *op)
+{
+    if (3 == decode->modrm.mod) {
+        op->reg = decode->modrm.reg;
+        op->type = X86_VAR_REG;
+        op->ptr = get_reg_ref(env, decode->modrm.rm, decode->rex.b,
+                              decode->operand_size);
+        return;
+    }
+
+    switch (decode->addressing_size) {
+    case 2:
+        calc_modrm_operand16(env, decode, op);
+        break;
+    case 4:
+        calc_modrm_operand32(env, decode, op);
+        break;
+    case 8:
+        calc_modrm_operand64(env, decode, op);
+        break;
+    default:
+        VM_PANIC_EX("unsupported address size %d\n", decode->addressing_size);
+        break;
+    }
+}
+
+static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
+{
+    while (1) {
+        uint8_t byte = decode_byte(env, decode);
+        switch (byte) {
+        case PREFIX_LOCK:
+            decode->lock = byte;
+            break;
+        case PREFIX_REPN:
+        case PREFIX_REP:
+            decode->rep = byte;
+            break;
+        case PREFIX_CS_SEG_OVEERIDE:
+        case PREFIX_SS_SEG_OVEERIDE:
+        case PREFIX_DS_SEG_OVEERIDE:
+        case PREFIX_ES_SEG_OVEERIDE:
+        case PREFIX_FS_SEG_OVEERIDE:
+        case PREFIX_GS_SEG_OVEERIDE:
+            decode->segment_override = byte;
+            break;
+        case PREFIX_OP_SIZE_OVERRIDE:
+            decode->op_size_override = byte;
+            break;
+        case PREFIX_ADDR_SIZE_OVERRIDE:
+            decode->addr_size_override = byte;
+            break;
+        case PREFIX_REX ... (PREFIX_REX + 0xf):
+            if (x86_is_long_mode(ENV_GET_CPU(env))) {
+                decode->rex.rex = byte;
+                break;
+            }
+            /* fall through when not in long mode */
+        default:
+            decode->len--;
+            return;
+        }
+    }
+}
+
+void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->addressing_size = -1;
+    if (x86_is_real(ENV_GET_CPU(env)) || x86_is_v8086(ENV_GET_CPU(env))) {
+        if (decode->addr_size_override) {
+            decode->addressing_size = 4;
+        } else {
+            decode->addressing_size = 2;
+        }
+    } else if (!x86_is_long_mode(ENV_GET_CPU(env))) {
+        /* protected */
+        struct vmx_segment cs;
+        vmx_read_segment_descriptor(ENV_GET_CPU(env), &cs, REG_SEG_CS);
+        /* check db */
+        if ((cs.ar >> 14) & 1) {
+            if (decode->addr_size_override) {
+                decode->addressing_size = 2;
+            } else {
+                decode->addressing_size = 4;
+            }
+        } else {
+            if (decode->addr_size_override) {
+                decode->addressing_size = 4;
+            } else {
+                decode->addressing_size = 2;
+            }
+        }
+    } else {
+        /* long */
+        if (decode->addr_size_override) {
+            decode->addressing_size = 4;
+        } else {
+            decode->addressing_size = 8;
+        }
+    }
+}
+
+void set_operand_size(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->operand_size = -1;
+    if (x86_is_real(ENV_GET_CPU(env)) || x86_is_v8086(ENV_GET_CPU(env))) {
+        if (decode->op_size_override) {
+            decode->operand_size = 4;
+        } else {
+            decode->operand_size = 2;
+        }
+    } else if (!x86_is_long_mode(ENV_GET_CPU(env))) {
+        /* protected */
+        struct vmx_segment cs;
+        vmx_read_segment_descriptor(ENV_GET_CPU(env), &cs, REG_SEG_CS);
+        /* check db */
+        if ((cs.ar >> 14) & 1) {
+            if (decode->op_size_override) {
+                decode->operand_size = 2;
+            } else{
+                decode->operand_size = 4;
+            }
+        } else {
+            if (decode->op_size_override) {
+                decode->operand_size = 4;
+            } else {
+                decode->operand_size = 2;
+            }
+        }
+    } else {
+        /* long */
+        if (decode->op_size_override) {
+            decode->operand_size = 2;
+        } else {
+            decode->operand_size = 4;
+        }
+
+        if (decode->rex.w) {
+            decode->operand_size = 8;
+        }
+    }
+}
+
+static void decode_sib(CPUX86State *env, struct x86_decode *decode)
+{
+    if ((decode->modrm.mod != 3) && (4 == decode->modrm.rm) &&
+        (decode->addressing_size != 2)) {
+        decode->sib.sib = decode_byte(env, decode);
+        decode->sib_present = true;
+    }
+}
+
+/* 16 bit modrm */
+int disp16_tbl[4][8] = {
+    {0, 0, 0, 0, 0, 0, 2, 0},
+    {1, 1, 1, 1, 1, 1, 1, 1},
+    {2, 2, 2, 2, 2, 2, 2, 2},
+    {0, 0, 0, 0, 0, 0, 0, 0}
+};
+
+/* 32/64-bit modrm */
+int disp32_tbl[4][8] = {
+    {0, 0, 0, 0, -1, 4, 0, 0},
+    {1, 1, 1, 1, 1, 1, 1, 1},
+    {4, 4, 4, 4, 4, 4, 4, 4},
+    {0, 0, 0, 0, 0, 0, 0, 0}
+};
+
+static inline void decode_displacement(CPUX86State *env, struct x86_decode *decode)
+{
+    int addressing_size = decode->addressing_size;
+    int mod = decode->modrm.mod;
+    int rm = decode->modrm.rm;
+    
+    decode->displacement_size = 0;
+    switch (addressing_size) {
+    case 2:
+        decode->displacement_size = disp16_tbl[mod][rm];
+        if (decode->displacement_size) {
+            decode->displacement = (uint16_t)decode_bytes(env, decode,
+                                    decode->displacement_size);
+        }
+        break;
+    case 4:
+    case 8:
+        if (-1 == disp32_tbl[mod][rm]) {
+            if (5 == decode->sib.base) {
+                decode->displacement_size = 4;
+            }
+        } else {
+            decode->displacement_size = disp32_tbl[mod][rm];
+        }
+
+        if (decode->displacement_size) {
+            decode->displacement = (uint32_t)decode_bytes(env, decode,
+                                                decode->displacement_size);
+        }
+        break;
+    }
+}
+
+static inline void decode_modrm(CPUX86State *env, struct x86_decode *decode)
+{
+    decode->modrm.modrm = decode_byte(env, decode);
+    decode->is_modrm = true;
+
+    decode_sib(env, decode);
+    decode_displacement(env, decode);
+}
+
+static inline void decode_opcode_general(CPUX86State *env,
+                                         struct x86_decode *decode,
+                                         uint8_t opcode,
+                                         struct decode_tbl *inst_decoder)
+{
+    decode->cmd = inst_decoder->cmd;
+    if (inst_decoder->operand_size) {
+        decode->operand_size = inst_decoder->operand_size;
+    }
+    decode->flags_mask = inst_decoder->flags_mask;
+
+    if (inst_decoder->is_modrm) {
+        decode_modrm(env, decode);
+    }
+    if (inst_decoder->decode_op1) {
+        inst_decoder->decode_op1(env, decode, &decode->op[0]);
+    }
+    if (inst_decoder->decode_op2) {
+        inst_decoder->decode_op2(env, decode, &decode->op[1]);
+    }
+    if (inst_decoder->decode_op3) {
+        inst_decoder->decode_op3(env, decode, &decode->op[2]);
+    }
+    if (inst_decoder->decode_op4) {
+        inst_decoder->decode_op4(env, decode, &decode->op[3]);
+    }
+    if (inst_decoder->decode_postfix) {
+        inst_decoder->decode_postfix(env, decode);
+    }
+}
+
+static inline void decode_opcode_1(CPUX86State *env, struct x86_decode *decode,
+                                   uint8_t opcode)
+{
+    struct decode_tbl *inst_decoder = &_decode_tbl1[opcode];
+    decode_opcode_general(env, decode, opcode, inst_decoder);
+}
+
+
+static inline void decode_opcode_2(CPUX86State *env, struct x86_decode *decode,
+                                   uint8_t opcode)
+{
+    struct decode_tbl *inst_decoder = &_decode_tbl2[opcode];
+    decode_opcode_general(env, decode, opcode, inst_decoder);
+}
+
+static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
+{
+    uint8_t opcode;
+
+    opcode = decode_byte(env, decode);
+    decode->opcode[decode->opcode_len++] = opcode;
+    if (opcode != OPCODE_ESCAPE) {
+        decode_opcode_1(env, decode, opcode);
+    } else {
+        opcode = decode_byte(env, decode);
+        decode->opcode[decode->opcode_len++] = opcode;
+        decode_opcode_2(env, decode, opcode);
+    }
+}
+
+uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
+{
+    ZERO_INIT(*decode);
+
+    decode_prefix(env, decode);
+    set_addressing_size(env, decode);
+    set_operand_size(env, decode);
+
+    decode_opcodes(env, decode);
+
+    return decode->len;
+}
+
+void init_decoder()
+{
+    int i;
+    
+    for (i = 0; i < ARRAY_SIZE(_decode_tbl2); i++) {
+        memcpy(_decode_tbl1, &invl_inst, sizeof(invl_inst));
+    }
+    for (i = 0; i < ARRAY_SIZE(_decode_tbl2); i++) {
+        memcpy(_decode_tbl2, &invl_inst, sizeof(invl_inst));
+    }
+    for (i = 0; i < ARRAY_SIZE(_decode_tbl3); i++) {
+        memcpy(_decode_tbl3, &invl_inst, sizeof(invl_inst_x87));
+    
+    }
+    for (i = 0; i < ARRAY_SIZE(_1op_inst); i++) {
+        _decode_tbl1[_1op_inst[i].opcode] = _1op_inst[i];
+    }
+    for (i = 0; i < ARRAY_SIZE(_2op_inst); i++) {
+        _decode_tbl2[_2op_inst[i].opcode] = _2op_inst[i];
+    }
+    for (i = 0; i < ARRAY_SIZE(_x87_inst); i++) {
+        int index = ((_x87_inst[i].opcode & 0xf) << 4) |
+                    ((_x87_inst[i].modrm_mod & 1) << 3) |
+                    _x87_inst[i].modrm_reg;
+        _decode_tbl3[index] = _x87_inst[i];
+    }
+}
+
+
+const char *decode_cmd_to_string(enum x86_decode_cmd cmd)
+{
+    static const char *cmds[] = {"INVL", "PUSH", "PUSH_SEG", "POP", "POP_SEG",
+        "MOV", "MOVSX", "MOVZX", "CALL_NEAR", "CALL_NEAR_ABS_INDIRECT",
+        "CALL_FAR_ABS_INDIRECT", "CMD_CALL_FAR", "RET_NEAR", "RET_FAR", "ADD",
+        "OR", "ADC", "SBB", "AND", "SUB", "XOR", "CMP", "INC", "DEC", "TST",
+        "NOT", "NEG", "JMP_NEAR", "JMP_NEAR_ABS_INDIRECT", "JMP_FAR",
+        "JMP_FAR_ABS_INDIRECT", "LEA", "JXX", "JCXZ", "SETXX", "MOV_TO_SEG",
+        "MOV_FROM_SEG", "CLI", "STI", "CLD", "STD", "STC", "CLC", "OUT", "IN",
+        "INS", "OUTS", "LIDT", "SIDT", "LGDT", "SGDT", "SMSW", "LMSW",
+        "RDTSCP", "INVLPG", "MOV_TO_CR", "MOV_FROM_CR", "MOV_TO_DR",
+        "MOV_FROM_DR", "PUSHF", "POPF", "CPUID", "ROL", "ROR", "RCL", "RCR",
+        "SHL", "SAL", "SHR", "SHRD", "SHLD", "SAR", "DIV", "IDIV", "MUL",
+        "IMUL_3", "IMUL_2", "IMUL_1", "MOVS", "CMPS", "SCAS", "LODS", "STOS",
+        "BSWAP", "XCHG", "RDTSC", "RDMSR", "WRMSR", "ENTER", "LEAVE", "BT",
+        "BTS", "BTC", "BTR", "BSF", "BSR", "IRET", "INT", "POPA", "PUSHA",
+        "CWD", "CBW", "DAS", "AAD", "AAM", "AAS", "LOOP", "SLDT", "STR", "LLDT",
+        "LTR", "VERR", "VERW", "SAHF", "LAHF", "WBINVD", "LDS", "LSS", "LES",
+        "LGS", "LFS", "CMC", "XLAT", "NOP", "CMOV", "CLTS", "XADD", "HLT",
+        "CMPXCHG8B", "CMPXCHG", "POPCNT", "FNINIT", "FLD", "FLDxx", "FNSTCW",
+        "FNSTSW", "FNSETPM", "FSAVE", "FRSTOR", "FXSAVE", "FXRSTOR", "FDIV",
+        "FMUL", "FSUB", "FADD", "EMMS", "MFENCE", "SFENCE", "LFENCE",
+        "PREFETCH", "FST", "FABS", "FUCOM", "FUCOMI", "FLDCW",
+        "FXCH", "FCHS", "FCMOV", "FRNDINT", "FXAM", "LAST"};
+    return cmds[cmd];
+}
+
+addr_t decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
+                          addr_t addr, x86_reg_segment seg)
+{
+    switch (decode->segment_override) {
+    case PREFIX_CS_SEG_OVEERIDE:
+        seg = REG_SEG_CS;
+        break;
+    case PREFIX_SS_SEG_OVEERIDE:
+        seg = REG_SEG_SS;
+        break;
+    case PREFIX_DS_SEG_OVEERIDE:
+        seg = REG_SEG_DS;
+        break;
+    case PREFIX_ES_SEG_OVEERIDE:
+        seg = REG_SEG_ES;
+        break;
+    case PREFIX_FS_SEG_OVEERIDE:
+        seg = REG_SEG_FS;
+        break;
+    case PREFIX_GS_SEG_OVEERIDE:
+        seg = REG_SEG_GS;
+        break;
+    default:
+        break;
+    }
+    return linear_addr_size(ENV_GET_CPU(env), addr, decode->addressing_size, seg);
+}
diff --git a/target/i386/hvf-utils/x86_decode.h b/target/i386/hvf-utils/x86_decode.h
new file mode 100644
index 0000000000..540e95d17d
--- /dev/null
+++ b/target/i386/hvf-utils/x86_decode.h
@@ -0,0 +1,325 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#pragma once
+
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <stdarg.h>
+#include "qemu-common.h"
+#include "x86.h"
+#include "cpu.h"
+
+typedef enum x86_prefix {
+    /* group 1 */
+    PREFIX_LOCK =                  0xf0,
+    PREFIX_REPN =                  0xf2,
+    PREFIX_REP =                   0xf3,
+    /* group 2 */
+    PREFIX_CS_SEG_OVEERIDE =       0x2e,
+    PREFIX_SS_SEG_OVEERIDE =       0x36,
+    PREFIX_DS_SEG_OVEERIDE =       0x3e,
+    PREFIX_ES_SEG_OVEERIDE =       0x26,
+    PREFIX_FS_SEG_OVEERIDE =       0x64,
+    PREFIX_GS_SEG_OVEERIDE =       0x65,
+    /* group 3 */
+    PREFIX_OP_SIZE_OVERRIDE =      0x66,
+    /* group 4 */
+    PREFIX_ADDR_SIZE_OVERRIDE =    0x67,
+
+    PREFIX_REX                   = 0x40,
+} x86_prefix;
+
+enum x86_decode_cmd {
+    X86_DECODE_CMD_INVL = 0,
+    
+    X86_DECODE_CMD_PUSH,
+    X86_DECODE_CMD_PUSH_SEG,
+    X86_DECODE_CMD_POP,
+    X86_DECODE_CMD_POP_SEG,
+    X86_DECODE_CMD_MOV,
+    X86_DECODE_CMD_MOVSX,
+    X86_DECODE_CMD_MOVZX,
+    X86_DECODE_CMD_CALL_NEAR,
+    X86_DECODE_CMD_CALL_NEAR_ABS_INDIRECT,
+    X86_DECODE_CMD_CALL_FAR_ABS_INDIRECT,
+    X86_DECODE_CMD_CALL_FAR,
+    X86_DECODE_RET_NEAR,
+    X86_DECODE_RET_FAR,
+    X86_DECODE_CMD_ADD,
+    X86_DECODE_CMD_OR,
+    X86_DECODE_CMD_ADC,
+    X86_DECODE_CMD_SBB,
+    X86_DECODE_CMD_AND,
+    X86_DECODE_CMD_SUB,
+    X86_DECODE_CMD_XOR,
+    X86_DECODE_CMD_CMP,
+    X86_DECODE_CMD_INC,
+    X86_DECODE_CMD_DEC,
+    X86_DECODE_CMD_TST,
+    X86_DECODE_CMD_NOT,
+    X86_DECODE_CMD_NEG,
+    X86_DECODE_CMD_JMP_NEAR,
+    X86_DECODE_CMD_JMP_NEAR_ABS_INDIRECT,
+    X86_DECODE_CMD_JMP_FAR,
+    X86_DECODE_CMD_JMP_FAR_ABS_INDIRECT,
+    X86_DECODE_CMD_LEA,
+    X86_DECODE_CMD_JXX,
+    X86_DECODE_CMD_JCXZ,
+    X86_DECODE_CMD_SETXX,
+    X86_DECODE_CMD_MOV_TO_SEG,
+    X86_DECODE_CMD_MOV_FROM_SEG,
+    X86_DECODE_CMD_CLI,
+    X86_DECODE_CMD_STI,
+    X86_DECODE_CMD_CLD,
+    X86_DECODE_CMD_STD,
+    X86_DECODE_CMD_STC,
+    X86_DECODE_CMD_CLC,
+    X86_DECODE_CMD_OUT,
+    X86_DECODE_CMD_IN,
+    X86_DECODE_CMD_INS,
+    X86_DECODE_CMD_OUTS,
+    X86_DECODE_CMD_LIDT,
+    X86_DECODE_CMD_SIDT,
+    X86_DECODE_CMD_LGDT,
+    X86_DECODE_CMD_SGDT,
+    X86_DECODE_CMD_SMSW,
+    X86_DECODE_CMD_LMSW,
+    X86_DECODE_CMD_RDTSCP,
+    X86_DECODE_CMD_INVLPG,
+    X86_DECODE_CMD_MOV_TO_CR,
+    X86_DECODE_CMD_MOV_FROM_CR,
+    X86_DECODE_CMD_MOV_TO_DR,
+    X86_DECODE_CMD_MOV_FROM_DR,
+    X86_DECODE_CMD_PUSHF,
+    X86_DECODE_CMD_POPF,
+    X86_DECODE_CMD_CPUID,
+    X86_DECODE_CMD_ROL,
+    X86_DECODE_CMD_ROR,
+    X86_DECODE_CMD_RCL,
+    X86_DECODE_CMD_RCR,
+    X86_DECODE_CMD_SHL,
+    X86_DECODE_CMD_SAL,
+    X86_DECODE_CMD_SHR,
+    X86_DECODE_CMD_SHRD,
+    X86_DECODE_CMD_SHLD,
+    X86_DECODE_CMD_SAR,
+    X86_DECODE_CMD_DIV,
+    X86_DECODE_CMD_IDIV,
+    X86_DECODE_CMD_MUL,
+    X86_DECODE_CMD_IMUL_3,
+    X86_DECODE_CMD_IMUL_2,
+    X86_DECODE_CMD_IMUL_1,
+    X86_DECODE_CMD_MOVS,
+    X86_DECODE_CMD_CMPS,
+    X86_DECODE_CMD_SCAS,
+    X86_DECODE_CMD_LODS,
+    X86_DECODE_CMD_STOS,
+    X86_DECODE_CMD_BSWAP,
+    X86_DECODE_CMD_XCHG,
+    X86_DECODE_CMD_RDTSC,
+    X86_DECODE_CMD_RDMSR,
+    X86_DECODE_CMD_WRMSR,
+    X86_DECODE_CMD_ENTER,
+    X86_DECODE_CMD_LEAVE,
+    X86_DECODE_CMD_BT,
+    X86_DECODE_CMD_BTS,
+    X86_DECODE_CMD_BTC,
+    X86_DECODE_CMD_BTR,
+    X86_DECODE_CMD_BSF,
+    X86_DECODE_CMD_BSR,
+    X86_DECODE_CMD_IRET,
+    X86_DECODE_CMD_INT,
+    X86_DECODE_CMD_POPA,
+    X86_DECODE_CMD_PUSHA,
+    X86_DECODE_CMD_CWD,
+    X86_DECODE_CMD_CBW,
+    X86_DECODE_CMD_DAS,
+    X86_DECODE_CMD_AAD,
+    X86_DECODE_CMD_AAM,
+    X86_DECODE_CMD_AAS,
+    X86_DECODE_CMD_LOOP,
+    X86_DECODE_CMD_SLDT,
+    X86_DECODE_CMD_STR,
+    X86_DECODE_CMD_LLDT,
+    X86_DECODE_CMD_LTR,
+    X86_DECODE_CMD_VERR,
+    X86_DECODE_CMD_VERW,
+    X86_DECODE_CMD_SAHF,
+    X86_DECODE_CMD_LAHF,
+    X86_DECODE_CMD_WBINVD,
+    X86_DECODE_CMD_LDS,
+    X86_DECODE_CMD_LSS,
+    X86_DECODE_CMD_LES,
+    X86_DECODE_XMD_LGS,
+    X86_DECODE_CMD_LFS,
+    X86_DECODE_CMD_CMC,
+    X86_DECODE_CMD_XLAT,
+    X86_DECODE_CMD_NOP,
+    X86_DECODE_CMD_CMOV,
+    X86_DECODE_CMD_CLTS,
+    X86_DECODE_CMD_XADD,
+    X86_DECODE_CMD_HLT,
+    X86_DECODE_CMD_CMPXCHG8B,
+    X86_DECODE_CMD_CMPXCHG,
+    X86_DECODE_CMD_POPCNT,
+    
+    X86_DECODE_CMD_FNINIT,
+    X86_DECODE_CMD_FLD,
+    X86_DECODE_CMD_FLDxx,
+    X86_DECODE_CMD_FNSTCW,
+    X86_DECODE_CMD_FNSTSW,
+    X86_DECODE_CMD_FNSETPM,
+    X86_DECODE_CMD_FSAVE,
+    X86_DECODE_CMD_FRSTOR,
+    X86_DECODE_CMD_FXSAVE,
+    X86_DECODE_CMD_FXRSTOR,
+    X86_DECODE_CMD_FDIV,
+    X86_DECODE_CMD_FMUL,
+    X86_DECODE_CMD_FSUB,
+    X86_DECODE_CMD_FADD,
+    X86_DECODE_CMD_EMMS,
+    X86_DECODE_CMD_MFENCE,
+    X86_DECODE_CMD_SFENCE,
+    X86_DECODE_CMD_LFENCE,
+    X86_DECODE_CMD_PREFETCH,
+    X86_DECODE_CMD_CLFLUSH,
+    X86_DECODE_CMD_FST,
+    X86_DECODE_CMD_FABS,
+    X86_DECODE_CMD_FUCOM,
+    X86_DECODE_CMD_FUCOMI,
+    X86_DECODE_CMD_FLDCW,
+    X86_DECODE_CMD_FXCH,
+    X86_DECODE_CMD_FCHS,
+    X86_DECODE_CMD_FCMOV,
+    X86_DECODE_CMD_FRNDINT,
+    X86_DECODE_CMD_FXAM,
+
+    X86_DECODE_CMD_LAST,
+};
+
+const char *decode_cmd_to_string(enum x86_decode_cmd cmd);
+
+typedef struct x86_modrm {
+    union {
+        uint8_t modrm;
+        struct {
+            uint8_t rm:3;
+            uint8_t reg:3;
+            uint8_t mod:2;
+        };
+    };
+} __attribute__ ((__packed__)) x86_modrm;
+
+typedef struct x86_sib {
+    union {
+        uint8_t sib;
+        struct {
+            uint8_t base:3;
+            uint8_t index:3;
+            uint8_t scale:2;
+        };
+    };
+} __attribute__ ((__packed__)) x86_sib;
+
+typedef struct x86_rex {
+    union {
+        uint8_t rex;
+        struct {
+            uint8_t b:1;
+            uint8_t x:1;
+            uint8_t r:1;
+            uint8_t w:1;
+            uint8_t unused:4;
+        };
+    };
+} __attribute__ ((__packed__)) x86_rex;
+
+typedef enum x86_var_type {
+    X86_VAR_IMMEDIATE,
+    X86_VAR_OFFSET,
+    X86_VAR_REG,
+    X86_VAR_RM,
+
+    /* for floating point computations */
+    X87_VAR_REG,
+    X87_VAR_FLOATP,
+    X87_VAR_INTP,
+    X87_VAR_BYTEP,
+} x86_var_type;
+
+typedef struct x86_decode_op {
+    enum x86_var_type type;
+    int size;
+
+    int reg;
+    addr_t val;
+
+    addr_t ptr;
+} x86_decode_op;
+
+typedef struct x86_decode {
+    int len;
+    uint8_t opcode[4];
+    uint8_t opcode_len;
+    enum x86_decode_cmd cmd;
+    int addressing_size;
+    int operand_size;
+    int lock;
+    int rep;
+    int op_size_override;
+    int addr_size_override;
+    int segment_override;
+    int control_change_inst;
+    bool fwait;
+    bool fpop_stack;
+    bool frev;
+
+    uint32_t displacement;
+    uint8_t displacement_size;
+    struct x86_rex rex;
+    bool is_modrm;
+    bool sib_present;
+    struct x86_sib sib;
+    struct x86_modrm modrm;
+    struct x86_decode_op op[4];
+    bool is_fpu;
+    addr_t flags_mask;
+
+} x86_decode;
+
+uint64_t sign(uint64_t val, int size);
+
+uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
+
+addr_t get_reg_ref(CPUX86State *env, int reg, int is_extended, int size);
+addr_t get_reg_val(CPUX86State *env, int reg, int is_extended, int size);
+void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
+                        struct x86_decode_op *op);
+addr_t decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
+                          addr_t addr, x86_reg_segment seg);
+
+void init_decoder(void);
+void calc_modrm_operand16(CPUX86State *env, struct x86_decode *decode,
+                          struct x86_decode_op *op);
+void calc_modrm_operand32(CPUX86State *env, struct x86_decode *decode,
+                          struct x86_decode_op *op);
+void calc_modrm_operand64(CPUX86State *env, struct x86_decode *decode,
+                          struct x86_decode_op *op);
+void set_addressing_size(CPUX86State *env, struct x86_decode *decode);
+void set_operand_size(CPUX86State *env, struct x86_decode *decode);
diff --git a/target/i386/hvf-utils/x86_descr.c b/target/i386/hvf-utils/x86_descr.c
new file mode 100644
index 0000000000..c3b089aaa8
--- /dev/null
+++ b/target/i386/hvf-utils/x86_descr.c
@@ -0,0 +1,124 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+
+#include "vmx.h"
+#include "x86_descr.h"
+
+#define VMX_SEGMENT_FIELD(seg)                      \
+    [REG_SEG_##seg] = {                           \
+        .selector = VMCS_GUEST_##seg##_SELECTOR,             \
+        .base = VMCS_GUEST_##seg##_BASE,                     \
+        .limit = VMCS_GUEST_##seg##_LIMIT,                   \
+        .ar_bytes = VMCS_GUEST_##seg##_ACCESS_RIGHTS,             \
+}
+
+static const struct vmx_segment_field {
+    int selector;
+    int base;
+    int limit;
+    int ar_bytes;
+} vmx_segment_fields[] = {
+    VMX_SEGMENT_FIELD(ES),
+    VMX_SEGMENT_FIELD(CS),
+    VMX_SEGMENT_FIELD(SS),
+    VMX_SEGMENT_FIELD(DS),
+    VMX_SEGMENT_FIELD(FS),
+    VMX_SEGMENT_FIELD(GS),
+    VMX_SEGMENT_FIELD(LDTR),
+    VMX_SEGMENT_FIELD(TR),
+};
+
+uint32_t vmx_read_segment_limit(CPUState *cpu, x86_reg_segment seg)
+{
+    return (uint32_t)rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].limit);
+}
+
+uint32_t vmx_read_segment_ar(CPUState *cpu, x86_reg_segment seg)
+{
+    return (uint32_t)rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].ar_bytes);
+}
+
+uint64_t vmx_read_segment_base(CPUState *cpu, x86_reg_segment seg)
+{
+    return rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].base);
+}
+
+x68_segment_selector vmx_read_segment_selector(CPUState *cpu, x86_reg_segment seg)
+{
+    x68_segment_selector sel;
+    sel.sel = rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].selector);
+    return sel;
+}
+
+void vmx_write_segment_selector(struct CPUState *cpu, x68_segment_selector selector, x86_reg_segment seg)
+{
+    wvmcs(cpu->hvf_fd, vmx_segment_fields[seg].selector, selector.sel);
+}
+
+void vmx_read_segment_descriptor(struct CPUState *cpu, struct vmx_segment *desc, x86_reg_segment seg)
+{
+    desc->sel = rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].selector);
+    desc->base = rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].base);
+    desc->limit = rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].limit);
+    desc->ar = rvmcs(cpu->hvf_fd, vmx_segment_fields[seg].ar_bytes);
+}
+
+void vmx_write_segment_descriptor(CPUState *cpu, struct vmx_segment *desc, x86_reg_segment seg)
+{
+    const struct vmx_segment_field *sf = &vmx_segment_fields[seg];
+
+    wvmcs(cpu->hvf_fd, sf->base, desc->base);
+    wvmcs(cpu->hvf_fd, sf->limit, desc->limit);
+    wvmcs(cpu->hvf_fd, sf->selector, desc->sel);
+    wvmcs(cpu->hvf_fd, sf->ar_bytes, desc->ar);
+}
+
+void x86_segment_descriptor_to_vmx(struct CPUState *cpu, x68_segment_selector selector, struct x86_segment_descriptor *desc, struct vmx_segment *vmx_desc)
+{
+    vmx_desc->sel = selector.sel;
+    vmx_desc->base = x86_segment_base(desc);
+    vmx_desc->limit = x86_segment_limit(desc);
+
+    vmx_desc->ar = (selector.sel ? 0 : 1) << 16 |
+                    desc->g << 15 |
+                    desc->db << 14 |
+                    desc->l << 13 |
+                    desc->avl << 12 |
+                    desc->p << 7 |
+                    desc->dpl << 5 |
+                    desc->s << 4 |
+                    desc->type;
+}
+
+void vmx_segment_to_x86_descriptor(struct CPUState *cpu, struct vmx_segment *vmx_desc, struct x86_segment_descriptor *desc)
+{
+    x86_set_segment_limit(desc, vmx_desc->limit);
+    x86_set_segment_base(desc, vmx_desc->base);
+    
+    desc->type = vmx_desc->ar & 15;
+    desc->s = (vmx_desc->ar >> 4) & 1;
+    desc->dpl = (vmx_desc->ar >> 5) & 3;
+    desc->p = (vmx_desc->ar >> 7) & 1;
+    desc->avl = (vmx_desc->ar >> 12) & 1;
+    desc->l = (vmx_desc->ar >> 13) & 1;
+    desc->db = (vmx_desc->ar >> 14) & 1;
+    desc->g = (vmx_desc->ar >> 15) & 1;
+}
+
diff --git a/target/i386/hvf-utils/x86_descr.h b/target/i386/hvf-utils/x86_descr.h
new file mode 100644
index 0000000000..f5e247782b
--- /dev/null
+++ b/target/i386/hvf-utils/x86_descr.h
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#pragma once
+
+#include "x86.h"
+
+typedef struct vmx_segment {
+    uint16_t sel;
+    uint64_t base;
+    uint64_t limit;
+    uint64_t ar;
+} vmx_segment;
+
+/* deal with vmstate descriptors */
+void vmx_read_segment_descriptor(struct CPUState *cpu,
+                                 struct vmx_segment *desc, x86_reg_segment seg);
+void vmx_write_segment_descriptor(CPUState *cpu, struct vmx_segment *desc,
+                                  x86_reg_segment seg);
+
+x68_segment_selector vmx_read_segment_selector(struct CPUState *cpu,
+                                               x86_reg_segment seg);
+void vmx_write_segment_selector(struct CPUState *cpu,
+                                x68_segment_selector selector,
+                                x86_reg_segment seg);
+
+uint64_t vmx_read_segment_base(struct CPUState *cpu, x86_reg_segment seg);
+void vmx_write_segment_base(struct CPUState *cpu, x86_reg_segment seg,
+                            uint64_t base);
+
+void x86_segment_descriptor_to_vmx(struct CPUState *cpu,
+                                   x68_segment_selector selector,
+                                   struct x86_segment_descriptor *desc,
+                                   struct vmx_segment *vmx_desc);
+
+uint32_t vmx_read_segment_limit(CPUState *cpu, x86_reg_segment seg);
+uint32_t vmx_read_segment_ar(CPUState *cpu, x86_reg_segment seg);
+void vmx_segment_to_x86_descriptor(struct CPUState *cpu,
+                                   struct vmx_segment *vmx_desc,
+                                   struct x86_segment_descriptor *desc);
diff --git a/target/i386/hvf-utils/x86_emu.c b/target/i386/hvf-utils/x86_emu.c
new file mode 100644
index 0000000000..eb09e38a77
--- /dev/null
+++ b/target/i386/hvf-utils/x86_emu.c
@@ -0,0 +1,1537 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/////////////////////////////////////////////////////////////////////////
+//
+//  Copyright (C) 2001-2012  The Bochs Project
+//
+//  This library is free software; you can redistribute it and/or
+//  modify it under the terms of the GNU Lesser General Public
+//  License as published by the Free Software Foundation; either
+//  version 2 of the License, or (at your option) any later version.
+//
+//  This library is distributed in the hope that it will be useful,
+//  but WITHOUT ANY WARRANTY; without even the implied warranty of
+//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+//  Lesser General Public License for more details.
+//
+//  You should have received a copy of the GNU Lesser General Public
+//  License along with this library; if not, write to the Free Software
+//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+/////////////////////////////////////////////////////////////////////////
+
+#include "qemu/osdep.h"
+
+#include "qemu-common.h"
+#include "x86_decode.h"
+#include "x86.h"
+#include "x86_emu.h"
+#include "x86_mmu.h"
+#include "x86_flags.h"
+#include "vmcs.h"
+#include "vmx.h"
+
+void hvf_handle_io(struct CPUState *cpu, uint16_t port, void *data,
+                   int direction, int size, uint32_t count);
+
+#define EXEC_2OP_LOGIC_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
+{                                                       \
+    fetch_operands(env, decode, 2, true, true, false);  \
+    switch (decode->operand_size) {                     \
+    case 1:                                         \
+    {                                               \
+        uint8_t v1 = (uint8_t)decode->op[0].val;    \
+        uint8_t v2 = (uint8_t)decode->op[1].val;    \
+        uint8_t diff = v1 cmd v2;                   \
+        if (save_res) {                              \
+            write_val_ext(env, decode->op[0].ptr, diff, 1);  \
+        } \
+        FLAGS_FUNC##_8(diff);                       \
+        break;                                      \
+    }                                               \
+    case 2:                                        \
+    {                                               \
+        uint16_t v1 = (uint16_t)decode->op[0].val;  \
+        uint16_t v2 = (uint16_t)decode->op[1].val;  \
+        uint16_t diff = v1 cmd v2;                  \
+        if (save_res) {                              \
+            write_val_ext(env, decode->op[0].ptr, diff, 2); \
+        } \
+        FLAGS_FUNC##_16(diff);                      \
+        break;                                      \
+    }                                               \
+    case 4:                                        \
+    {                                               \
+        uint32_t v1 = (uint32_t)decode->op[0].val;  \
+        uint32_t v2 = (uint32_t)decode->op[1].val;  \
+        uint32_t diff = v1 cmd v2;                  \
+        if (save_res) {                              \
+            write_val_ext(env, decode->op[0].ptr, diff, 4); \
+        } \
+        FLAGS_FUNC##_32(diff);                      \
+        break;                                      \
+    }                                               \
+    default:                                        \
+        VM_PANIC("bad size\n");                    \
+    }                                                   \
+}                                                       \
+
+
+#define EXEC_2OP_ARITH_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
+{                                                       \
+    fetch_operands(env, decode, 2, true, true, false);  \
+    switch (decode->operand_size) {                     \
+    case 1:                                         \
+    {                                               \
+        uint8_t v1 = (uint8_t)decode->op[0].val;    \
+        uint8_t v2 = (uint8_t)decode->op[1].val;    \
+        uint8_t diff = v1 cmd v2;                   \
+        if (save_res) {                              \
+            write_val_ext(env, decode->op[0].ptr, diff, 1);  \
+        } \
+        FLAGS_FUNC##_8(v1, v2, diff);               \
+        break;                                      \
+    }                                               \
+    case 2:                                        \
+    {                                               \
+        uint16_t v1 = (uint16_t)decode->op[0].val;  \
+        uint16_t v2 = (uint16_t)decode->op[1].val;  \
+        uint16_t diff = v1 cmd v2;                  \
+        if (save_res) {                              \
+            write_val_ext(env, decode->op[0].ptr, diff, 2); \
+        } \
+        FLAGS_FUNC##_16(v1, v2, diff);              \
+        break;                                      \
+    }                                               \
+    case 4:                                        \
+    {                                               \
+        uint32_t v1 = (uint32_t)decode->op[0].val;  \
+        uint32_t v2 = (uint32_t)decode->op[1].val;  \
+        uint32_t diff = v1 cmd v2;                  \
+        if (save_res) {                              \
+            write_val_ext(env, decode->op[0].ptr, diff, 4); \
+        } \
+        FLAGS_FUNC##_32(v1, v2, diff);              \
+        break;                                      \
+    }                                               \
+    default:                                        \
+        VM_PANIC("bad size\n");                    \
+    }                                                   \
+}
+
+addr_t read_reg(CPUX86State *env, int reg, int size)
+{
+    switch (size) {
+    case 1:
+        return env->hvf_emul->regs[reg].lx;
+    case 2:
+        return env->hvf_emul->regs[reg].rx;
+    case 4:
+        return env->hvf_emul->regs[reg].erx;
+    case 8:
+        return env->hvf_emul->regs[reg].rrx;
+    default:
+        VM_PANIC_ON("read_reg size");
+    }
+    return 0;
+}
+
+void write_reg(CPUX86State *env, int reg, addr_t val, int size)
+{
+    switch (size) {
+    case 1:
+        env->hvf_emul->regs[reg].lx = val;
+        break;
+    case 2:
+        env->hvf_emul->regs[reg].rx = val;
+        break;
+    case 4:
+        env->hvf_emul->regs[reg].rrx = (uint32_t)val;
+        break;
+    case 8:
+        env->hvf_emul->regs[reg].rrx = val;
+        break;
+    default:
+        VM_PANIC_ON("write_reg size");
+    }
+}
+
+addr_t read_val_from_reg(addr_t reg_ptr, int size)
+{
+    addr_t val;
+    
+    switch (size) {
+    case 1:
+        val = *(uint8_t *)reg_ptr;
+        break;
+    case 2:
+        val = *(uint16_t *)reg_ptr;
+        break;
+    case 4:
+        val = *(uint32_t *)reg_ptr;
+        break;
+    case 8:
+        val = *(uint64_t *)reg_ptr;
+        break;
+    default:
+        VM_PANIC_ON_EX(1, "read_val: Unknown size %d\n", size);
+        break;
+    }
+    return val;
+}
+
+void write_val_to_reg(addr_t reg_ptr, addr_t val, int size)
+{
+    switch (size) {
+    case 1:
+        *(uint8_t *)reg_ptr = val;
+        break;
+    case 2:
+        *(uint16_t *)reg_ptr = val;
+        break;
+    case 4:
+        *(uint64_t *)reg_ptr = (uint32_t)val;
+        break;
+    case 8:
+        *(uint64_t *)reg_ptr = val;
+        break;
+    default:
+        VM_PANIC("write_val: Unknown size\n");
+        break;
+    }
+}
+
+static bool is_host_reg(struct CPUX86State *env, addr_t ptr)
+{
+    return (ptr - (addr_t)&env->hvf_emul->regs[0]) < sizeof(env->hvf_emul->regs);
+}
+
+void write_val_ext(struct CPUX86State *env, addr_t ptr, addr_t val, int size)
+{
+    if (is_host_reg(env, ptr)) {
+        write_val_to_reg(ptr, val, size);
+        return;
+    }
+    vmx_write_mem(ENV_GET_CPU(env), ptr, &val, size);
+}
+
+uint8_t *read_mmio(struct CPUX86State *env, addr_t ptr, int bytes)
+{
+    vmx_read_mem(ENV_GET_CPU(env), env->hvf_emul->mmio_buf, ptr, bytes);
+    return env->hvf_emul->mmio_buf;
+}
+
+
+addr_t read_val_ext(struct CPUX86State *env, addr_t ptr, int size)
+{
+    addr_t val;
+    uint8_t *mmio_ptr;
+
+    if (is_host_reg(env, ptr)) {
+        return read_val_from_reg(ptr, size);
+    }
+
+    mmio_ptr = read_mmio(env, ptr, size);
+    switch (size) {
+    case 1:
+        val = *(uint8_t *)mmio_ptr;
+        break;
+    case 2:
+        val = *(uint16_t *)mmio_ptr;
+        break;
+    case 4:
+        val = *(uint32_t *)mmio_ptr;
+        break;
+    case 8:
+        val = *(uint64_t *)mmio_ptr;
+        break;
+    default:
+        VM_PANIC("bad size\n");
+        break;
+    }
+    return val;
+}
+
+static void fetch_operands(struct CPUX86State *env, struct x86_decode *decode,
+                           int n, bool val_op0, bool val_op1, bool val_op2)
+{
+    int i;
+    bool calc_val[3] = {val_op0, val_op1, val_op2};
+
+    for (i = 0; i < n; i++) {
+        switch (decode->op[i].type) {
+        case X86_VAR_IMMEDIATE:
+            break;
+        case X86_VAR_REG:
+            VM_PANIC_ON(!decode->op[i].ptr);
+            if (calc_val[i]) {
+                decode->op[i].val = read_val_from_reg(decode->op[i].ptr,
+                                                      decode->operand_size);
+            }
+            break;
+        case X86_VAR_RM:
+            calc_modrm_operand(env, decode, &decode->op[i]);
+            if (calc_val[i]) {
+                decode->op[i].val = read_val_ext(env, decode->op[i].ptr,
+                                                 decode->operand_size);
+            }
+            break;
+        case X86_VAR_OFFSET:
+            decode->op[i].ptr = decode_linear_addr(env, decode,
+                                                   decode->op[i].ptr,
+                                                   REG_SEG_DS);
+            if (calc_val[i]) {
+                decode->op[i].val = read_val_ext(env, decode->op[i].ptr,
+                                                 decode->operand_size);
+            }
+            break;
+        default:
+            break;
+        }
+    }
+}
+
+static void exec_mov(struct CPUX86State *env, struct x86_decode *decode)
+{
+    fetch_operands(env, decode, 2, false, true, false);
+    write_val_ext(env, decode->op[0].ptr, decode->op[1].val,
+                  decode->operand_size);
+
+    RIP(env) += decode->len;
+}
+
+static void exec_add(struct CPUX86State *env, struct x86_decode *decode)
+{
+    EXEC_2OP_ARITH_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
+    RIP(env) += decode->len;
+}
+
+static void exec_or(struct CPUX86State *env, struct x86_decode *decode)
+{
+    EXEC_2OP_LOGIC_CMD(env, decode, |, SET_FLAGS_OSZAPC_LOGIC, true);
+    RIP(env) += decode->len;
+}
+
+static void exec_adc(struct CPUX86State *env, struct x86_decode *decode)
+{
+    EXEC_2OP_ARITH_CMD(env, decode, +get_CF(env)+, SET_FLAGS_OSZAPC_ADD, true);
+    RIP(env) += decode->len;
+}
+
+static void exec_sbb(struct CPUX86State *env, struct x86_decode *decode)
+{
+    EXEC_2OP_ARITH_CMD(env, decode, -get_CF(env)-, SET_FLAGS_OSZAPC_SUB, true);
+    RIP(env) += decode->len;
+}
+
+static void exec_and(struct CPUX86State *env, struct x86_decode *decode)
+{
+    EXEC_2OP_LOGIC_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, true);
+    RIP(env) += decode->len;
+}
+
+static void exec_sub(struct CPUX86State *env, struct x86_decode *decode)
+{
+    EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, true);
+    RIP(env) += decode->len;
+}
+
+static void exec_xor(struct CPUX86State *env, struct x86_decode *decode)
+{
+    EXEC_2OP_LOGIC_CMD(env, decode, ^, SET_FLAGS_OSZAPC_LOGIC, true);
+    RIP(env) += decode->len;
+}
+
+static void exec_neg(struct CPUX86State *env, struct x86_decode *decode)
+{
+    /*EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);*/
+    int32_t val;
+    fetch_operands(env, decode, 2, true, true, false);
+
+    val = 0 - sign(decode->op[1].val, decode->operand_size);
+    write_val_ext(env, decode->op[1].ptr, val, decode->operand_size);
+
+    if (4 == decode->operand_size) {
+        SET_FLAGS_OSZAPC_SUB_32(0, 0 - val, val);
+    } else if (2 == decode->operand_size) {
+        SET_FLAGS_OSZAPC_SUB_16(0, 0 - val, val);
+    } else if (1 == decode->operand_size) {
+        SET_FLAGS_OSZAPC_SUB_8(0, 0 - val, val);
+    } else {
+        VM_PANIC("bad op size\n");
+    }
+
+    /*lflags_to_rflags(env);*/
+    RIP(env) += decode->len;
+}
+
+static void exec_cmp(struct CPUX86State *env, struct x86_decode *decode)
+{
+    EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
+    RIP(env) += decode->len;
+}
+
+static void exec_inc(struct CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[1].type = X86_VAR_IMMEDIATE;
+    decode->op[1].val = 0;
+
+    EXEC_2OP_ARITH_CMD(env, decode, +1+, SET_FLAGS_OSZAP_ADD, true);
+
+    RIP(env) += decode->len;
+}
+
+static void exec_dec(struct CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[1].type = X86_VAR_IMMEDIATE;
+    decode->op[1].val = 0;
+
+    EXEC_2OP_ARITH_CMD(env, decode, -1-, SET_FLAGS_OSZAP_SUB, true);
+    RIP(env) += decode->len;
+}
+
+static void exec_tst(struct CPUX86State *env, struct x86_decode *decode)
+{
+    EXEC_2OP_LOGIC_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, false);
+    RIP(env) += decode->len;
+}
+
+static void exec_not(struct CPUX86State *env, struct x86_decode *decode)
+{
+    fetch_operands(env, decode, 1, true, false, false);
+
+    write_val_ext(env, decode->op[0].ptr, ~decode->op[0].val,
+                  decode->operand_size);
+    RIP(env) += decode->len;
+}
+
+void exec_movzx(struct CPUX86State *env, struct x86_decode *decode)
+{
+    int src_op_size;
+    int op_size = decode->operand_size;
+
+    fetch_operands(env, decode, 1, false, false, false);
+
+    if (0xb6 == decode->opcode[1]) {
+        src_op_size = 1;
+    } else {
+        src_op_size = 2;
+    }
+    decode->operand_size = src_op_size;
+    calc_modrm_operand(env, decode, &decode->op[1]);
+    decode->op[1].val = read_val_ext(env, decode->op[1].ptr, src_op_size);
+    write_val_ext(env, decode->op[0].ptr, decode->op[1].val, op_size);
+
+    RIP(env) += decode->len;
+}
+
+static void exec_out(struct CPUX86State *env, struct x86_decode *decode)
+{
+    switch (decode->opcode[0]) {
+    case 0xe6:
+        hvf_handle_io(ENV_GET_CPU(env), decode->op[0].val, &AL(env), 1, 1, 1);
+        break;
+    case 0xe7:
+        hvf_handle_io(ENV_GET_CPU(env), decode->op[0].val, &RAX(env), 1,
+                      decode->operand_size, 1);
+        break;
+    case 0xee:
+        hvf_handle_io(ENV_GET_CPU(env), DX(env), &AL(env), 1, 1, 1);
+        break;
+    case 0xef:
+        hvf_handle_io(ENV_GET_CPU(env), DX(env), &RAX(env), 1, decode->operand_size, 1);
+        break;
+    default:
+        VM_PANIC("Bad out opcode\n");
+        break;
+    }
+    RIP(env) += decode->len;
+}
+
+static void exec_in(struct CPUX86State *env, struct x86_decode *decode)
+{
+    addr_t val = 0;
+    switch (decode->opcode[0]) {
+    case 0xe4:
+        hvf_handle_io(ENV_GET_CPU(env), decode->op[0].val, &AL(env), 0, 1, 1);
+        break;
+    case 0xe5:
+        hvf_handle_io(ENV_GET_CPU(env), decode->op[0].val, &val, 0, decode->operand_size, 1);
+        if (decode->operand_size == 2) {
+            AX(env) = val;
+        } else {
+            RAX(env) = (uint32_t)val;
+        }
+        break;
+    case 0xec:
+        hvf_handle_io(ENV_GET_CPU(env), DX(env), &AL(env), 0, 1, 1);
+        break;
+    case 0xed:
+        hvf_handle_io(ENV_GET_CPU(env), DX(env), &val, 0, decode->operand_size, 1);
+        if (decode->operand_size == 2) {
+            AX(env) = val;
+        } else {
+            RAX(env) = (uint32_t)val;
+        }
+
+        break;
+    default:
+        VM_PANIC("Bad in opcode\n");
+        break;
+    }
+
+    RIP(env) += decode->len;
+}
+
+static inline void string_increment_reg(struct CPUX86State *env, int reg,
+                                        struct x86_decode *decode)
+{
+    addr_t val = read_reg(env, reg, decode->addressing_size);
+    if (env->hvf_emul->rflags.df) {
+        val -= decode->operand_size;
+    } else {
+        val += decode->operand_size;
+    }
+    write_reg(env, reg, val, decode->addressing_size);
+}
+
+static inline void string_rep(struct CPUX86State *env, struct x86_decode *decode,
+                              void (*func)(struct CPUX86State *env,
+                                           struct x86_decode *ins), int rep)
+{
+    addr_t rcx = read_reg(env, REG_RCX, decode->addressing_size);
+    while (rcx--) {
+        func(env, decode);
+        write_reg(env, REG_RCX, rcx, decode->addressing_size);
+        if ((PREFIX_REP == rep) && !get_ZF(env)) {
+            break;
+        }
+        if ((PREFIX_REPN == rep) && get_ZF(env)) {
+            break;
+        }
+    }
+}
+
+static void exec_ins_single(struct CPUX86State *env, struct x86_decode *decode)
+{
+    addr_t addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
+                                   REG_SEG_ES);
+
+    hvf_handle_io(ENV_GET_CPU(env), DX(env), env->hvf_emul->mmio_buf, 0,
+                  decode->operand_size, 1);
+    vmx_write_mem(ENV_GET_CPU(env), addr, env->hvf_emul->mmio_buf, decode->operand_size);
+
+    string_increment_reg(env, REG_RDI, decode);
+}
+
+static void exec_ins(struct CPUX86State *env, struct x86_decode *decode)
+{
+    if (decode->rep) {
+        string_rep(env, decode, exec_ins_single, 0);
+    } else {
+        exec_ins_single(env, decode);
+    }
+
+    RIP(env) += decode->len;
+}
+
+static void exec_outs_single(struct CPUX86State *env, struct x86_decode *decode)
+{
+    addr_t addr = decode_linear_addr(env, decode, RSI(env), REG_SEG_DS);
+
+    vmx_read_mem(ENV_GET_CPU(env), env->hvf_emul->mmio_buf, addr, decode->operand_size);
+    hvf_handle_io(ENV_GET_CPU(env), DX(env), env->hvf_emul->mmio_buf, 1,
+                  decode->operand_size, 1);
+
+    string_increment_reg(env, REG_RSI, decode);
+}
+
+static void exec_outs(struct CPUX86State *env, struct x86_decode *decode)
+{
+    if (decode->rep) {
+        string_rep(env, decode, exec_outs_single, 0);
+    } else {
+        exec_outs_single(env, decode);
+    }
+
+    RIP(env) += decode->len;
+}
+
+static void exec_movs_single(struct CPUX86State *env, struct x86_decode *decode)
+{
+    addr_t src_addr;
+    addr_t dst_addr;
+    addr_t val;
+
+    src_addr = decode_linear_addr(env, decode, RSI(env), REG_SEG_DS);
+    dst_addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
+                                REG_SEG_ES);
+
+    val = read_val_ext(env, src_addr, decode->operand_size);
+    write_val_ext(env, dst_addr, val, decode->operand_size);
+
+    string_increment_reg(env, REG_RSI, decode);
+    string_increment_reg(env, REG_RDI, decode);
+}
+
+static void exec_movs(struct CPUX86State *env, struct x86_decode *decode)
+{
+    if (decode->rep) {
+        string_rep(env, decode, exec_movs_single, 0);
+    } else {
+        exec_movs_single(env, decode);
+    }
+
+    RIP(env) += decode->len;
+}
+
+static void exec_cmps_single(struct CPUX86State *env, struct x86_decode *decode)
+{
+    addr_t src_addr;
+    addr_t dst_addr;
+
+    src_addr = decode_linear_addr(env, decode, RSI(env), REG_SEG_DS);
+    dst_addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size,
+                                REG_SEG_ES);
+
+    decode->op[0].type = X86_VAR_IMMEDIATE;
+    decode->op[0].val = read_val_ext(env, src_addr, decode->operand_size);
+    decode->op[1].type = X86_VAR_IMMEDIATE;
+    decode->op[1].val = read_val_ext(env, dst_addr, decode->operand_size);
+
+    EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
+
+    string_increment_reg(env, REG_RSI, decode);
+    string_increment_reg(env, REG_RDI, decode);
+}
+
+static void exec_cmps(struct CPUX86State *env, struct x86_decode *decode)
+{
+    if (decode->rep) {
+        string_rep(env, decode, exec_cmps_single, decode->rep);
+    } else {
+        exec_cmps_single(env, decode);
+    }
+    RIP(env) += decode->len;
+}
+
+
+static void exec_stos_single(struct CPUX86State *env, struct x86_decode *decode)
+{
+    addr_t addr;
+    addr_t val;
+
+    addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size, REG_SEG_ES);
+    val = read_reg(env, REG_RAX, decode->operand_size);
+    vmx_write_mem(ENV_GET_CPU(env), addr, &val, decode->operand_size);
+
+    string_increment_reg(env, REG_RDI, decode);
+}
+
+
+static void exec_stos(struct CPUX86State *env, struct x86_decode *decode)
+{
+    if (decode->rep) {
+        string_rep(env, decode, exec_stos_single, 0);
+    } else {
+        exec_stos_single(env, decode);
+    }
+
+    RIP(env) += decode->len;
+}
+
+static void exec_scas_single(struct CPUX86State *env, struct x86_decode *decode)
+{
+    addr_t addr;
+
+    addr = linear_addr_size(ENV_GET_CPU(env), RDI(env), decode->addressing_size, REG_SEG_ES);
+    decode->op[1].type = X86_VAR_IMMEDIATE;
+    vmx_read_mem(ENV_GET_CPU(env), &decode->op[1].val, addr, decode->operand_size);
+
+    EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
+    string_increment_reg(env, REG_RDI, decode);
+}
+
+static void exec_scas(struct CPUX86State *env, struct x86_decode *decode)
+{
+    decode->op[0].type = X86_VAR_REG;
+    decode->op[0].reg = REG_RAX;
+    if (decode->rep) {
+        string_rep(env, decode, exec_scas_single, decode->rep);
+    } else {
+        exec_scas_single(env, decode);
+    }
+
+    RIP(env) += decode->len;
+}
+
+static void exec_lods_single(struct CPUX86State *env, struct x86_decode *decode)
+{
+    addr_t addr;
+    addr_t val = 0;
+
+    addr = decode_linear_addr(env, decode, RSI(env), REG_SEG_DS);
+    vmx_read_mem(ENV_GET_CPU(env), &val, addr,  decode->operand_size);
+    write_reg(env, REG_RAX, val, decode->operand_size);
+
+    string_increment_reg(env, REG_RSI, decode);
+}
+
+static void exec_lods(struct CPUX86State *env, struct x86_decode *decode)
+{
+    if (decode->rep) {
+        string_rep(env, decode, exec_lods_single, 0);
+    } else {
+        exec_lods_single(env, decode);
+    }
+
+    RIP(env) += decode->len;
+}
+
+#define MSR_IA32_UCODE_REV 0x00000017
+
+void simulate_rdmsr(struct CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint32_t msr = ECX(env);
+    uint64_t val = 0;
+
+    switch (msr) {
+    case MSR_IA32_TSC:
+        val = rdtscp() + rvmcs(cpu->hvf_fd, VMCS_TSC_OFFSET);
+        break;
+    case MSR_IA32_APICBASE:
+        val = cpu_get_apic_base(X86_CPU(cpu)->apic_state);
+        break;
+    case MSR_IA32_UCODE_REV:
+        val = (0x100000000ULL << 32) | 0x100000000ULL;
+        break;
+    case MSR_EFER:
+        val = rvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER);
+        break;
+    case MSR_FSBASE:
+        val = rvmcs(cpu->hvf_fd, VMCS_GUEST_FS_BASE);
+        break;
+    case MSR_GSBASE:
+        val = rvmcs(cpu->hvf_fd, VMCS_GUEST_GS_BASE);
+        break;
+    case MSR_KERNELGSBASE:
+        val = rvmcs(cpu->hvf_fd, VMCS_HOST_FS_BASE);
+        break;
+    case MSR_STAR:
+        abort();
+        break;
+    case MSR_LSTAR:
+        abort();
+        break;
+    case MSR_CSTAR:
+        abort();
+        break;
+    case MSR_IA32_MISC_ENABLE:
+        val = env->msr_ia32_misc_enable;
+        break;
+    case MSR_MTRRphysBase(0):
+    case MSR_MTRRphysBase(1):
+    case MSR_MTRRphysBase(2):
+    case MSR_MTRRphysBase(3):
+    case MSR_MTRRphysBase(4):
+    case MSR_MTRRphysBase(5):
+    case MSR_MTRRphysBase(6):
+    case MSR_MTRRphysBase(7):
+        val = env->mtrr_var[(ECX(env) - MSR_MTRRphysBase(0)) / 2].base;
+        break;
+    case MSR_MTRRphysMask(0):
+    case MSR_MTRRphysMask(1):
+    case MSR_MTRRphysMask(2):
+    case MSR_MTRRphysMask(3):
+    case MSR_MTRRphysMask(4):
+    case MSR_MTRRphysMask(5):
+    case MSR_MTRRphysMask(6):
+    case MSR_MTRRphysMask(7):
+        val = env->mtrr_var[(ECX(env) - MSR_MTRRphysMask(0)) / 2].mask;
+        break;
+    case MSR_MTRRfix64K_00000:
+        val = env->mtrr_fixed[0];
+        break;
+    case MSR_MTRRfix16K_80000:
+    case MSR_MTRRfix16K_A0000:
+        val = env->mtrr_fixed[ECX(env) - MSR_MTRRfix16K_80000 + 1];
+        break;
+    case MSR_MTRRfix4K_C0000:
+    case MSR_MTRRfix4K_C8000:
+    case MSR_MTRRfix4K_D0000:
+    case MSR_MTRRfix4K_D8000:
+    case MSR_MTRRfix4K_E0000:
+    case MSR_MTRRfix4K_E8000:
+    case MSR_MTRRfix4K_F0000:
+    case MSR_MTRRfix4K_F8000:
+        val = env->mtrr_fixed[ECX(env) - MSR_MTRRfix4K_C0000 + 3];
+        break;
+    case MSR_MTRRdefType:
+        val = env->mtrr_deftype;
+        break;
+    default:
+        /* fprintf(stderr, "%s: unknown msr 0x%x\n", __func__, msr); */
+        val = 0;
+        break;
+    }
+
+    RAX(env) = (uint32_t)val;
+    RDX(env) = (uint32_t)(val >> 32);
+}
+
+static void exec_rdmsr(struct CPUX86State *env, struct x86_decode *decode)
+{
+    simulate_rdmsr(ENV_GET_CPU(env));
+    RIP(env) += decode->len;
+}
+
+void simulate_wrmsr(struct CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint32_t msr = ECX(env);
+    uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
+
+    switch (msr) {
+    case MSR_IA32_TSC:
+        /* if (!osx_is_sierra())
+             wvmcs(cpu->hvf_fd, VMCS_TSC_OFFSET, data - rdtscp());
+        hv_vm_sync_tsc(data);*/
+        break;
+    case MSR_IA32_APICBASE:
+        cpu_set_apic_base(X86_CPU(cpu)->apic_state, data);
+        break;
+    case MSR_FSBASE:
+        wvmcs(cpu->hvf_fd, VMCS_GUEST_FS_BASE, data);
+        break;
+    case MSR_GSBASE:
+        wvmcs(cpu->hvf_fd, VMCS_GUEST_GS_BASE, data);
+        break;
+    case MSR_KERNELGSBASE:
+        wvmcs(cpu->hvf_fd, VMCS_HOST_FS_BASE, data);
+        break;
+    case MSR_STAR:
+        abort();
+        break;
+    case MSR_LSTAR:
+        abort();
+        break;
+    case MSR_CSTAR:
+        abort();
+        break;
+    case MSR_EFER:
+        env->hvf_emul->efer.efer = data;
+        /*printf("new efer %llx\n", EFER(cpu));*/
+        wvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER, data);
+        if (data & EFER_NXE) {
+            hv_vcpu_invalidate_tlb(cpu->hvf_fd);
+        }
+        break;
+    case MSR_MTRRphysBase(0):
+    case MSR_MTRRphysBase(1):
+    case MSR_MTRRphysBase(2):
+    case MSR_MTRRphysBase(3):
+    case MSR_MTRRphysBase(4):
+    case MSR_MTRRphysBase(5):
+    case MSR_MTRRphysBase(6):
+    case MSR_MTRRphysBase(7):
+        env->mtrr_var[(ECX(env) - MSR_MTRRphysBase(0)) / 2].base = data;
+        break;
+    case MSR_MTRRphysMask(0):
+    case MSR_MTRRphysMask(1):
+    case MSR_MTRRphysMask(2):
+    case MSR_MTRRphysMask(3):
+    case MSR_MTRRphysMask(4):
+    case MSR_MTRRphysMask(5):
+    case MSR_MTRRphysMask(6):
+    case MSR_MTRRphysMask(7):
+        env->mtrr_var[(ECX(env) - MSR_MTRRphysMask(0)) / 2].mask = data;
+        break;
+    case MSR_MTRRfix64K_00000:
+        env->mtrr_fixed[ECX(env) - MSR_MTRRfix64K_00000] = data;
+        break;
+    case MSR_MTRRfix16K_80000:
+    case MSR_MTRRfix16K_A0000:
+        env->mtrr_fixed[ECX(env) - MSR_MTRRfix16K_80000 + 1] = data;
+        break;
+    case MSR_MTRRfix4K_C0000:
+    case MSR_MTRRfix4K_C8000:
+    case MSR_MTRRfix4K_D0000:
+    case MSR_MTRRfix4K_D8000:
+    case MSR_MTRRfix4K_E0000:
+    case MSR_MTRRfix4K_E8000:
+    case MSR_MTRRfix4K_F0000:
+    case MSR_MTRRfix4K_F8000:
+        env->mtrr_fixed[ECX(env) - MSR_MTRRfix4K_C0000 + 3] = data;
+        break;
+    case MSR_MTRRdefType:
+        env->mtrr_deftype = data;
+        break;
+    default:
+        break;
+    }
+
+    /* Related to support known hypervisor interface */
+    /* if (g_hypervisor_iface)
+         g_hypervisor_iface->wrmsr_handler(cpu, msr, data);
+
+    printf("write msr %llx\n", RCX(cpu));*/
+}
+
+static void exec_wrmsr(struct CPUX86State *env, struct x86_decode *decode)
+{
+    simulate_wrmsr(ENV_GET_CPU(env));
+    RIP(env) += decode->len;
+}
+
+/*
+ * flag:
+ * 0 - bt, 1 - btc, 2 - bts, 3 - btr
+ */
+static void do_bt(struct CPUX86State *env, struct x86_decode *decode, int flag)
+{
+    int32_t displacement;
+    uint8_t index;
+    bool cf;
+    int mask = (4 == decode->operand_size) ? 0x1f : 0xf;
+
+    VM_PANIC_ON(decode->rex.rex);
+
+    fetch_operands(env, decode, 2, false, true, false);
+    index = decode->op[1].val & mask;
+
+    if (decode->op[0].type != X86_VAR_REG) {
+        if (4 == decode->operand_size) {
+            displacement = ((int32_t) (decode->op[1].val & 0xffffffe0)) / 32;
+            decode->op[0].ptr += 4 * displacement;
+        } else if (2 == decode->operand_size) {
+            displacement = ((int16_t) (decode->op[1].val & 0xfff0)) / 16;
+            decode->op[0].ptr += 2 * displacement;
+        } else {
+            VM_PANIC("bt 64bit\n");
+        }
+    }
+    decode->op[0].val = read_val_ext(env, decode->op[0].ptr,
+                                     decode->operand_size);
+    cf = (decode->op[0].val >> index) & 0x01;
+
+    switch (flag) {
+    case 0:
+        set_CF(env, cf);
+        return;
+    case 1:
+        decode->op[0].val ^= (1u << index);
+        break;
+    case 2:
+        decode->op[0].val |= (1u << index);
+        break;
+    case 3:
+        decode->op[0].val &= ~(1u << index);
+        break;
+    }
+    write_val_ext(env, decode->op[0].ptr, decode->op[0].val,
+                  decode->operand_size);
+    set_CF(env, cf);
+}
+
+static void exec_bt(struct CPUX86State *env, struct x86_decode *decode)
+{
+    do_bt(env, decode, 0);
+    RIP(env) += decode->len;
+}
+
+static void exec_btc(struct CPUX86State *env, struct x86_decode *decode)
+{
+    do_bt(env, decode, 1);
+    RIP(env) += decode->len;
+}
+
+static void exec_btr(struct CPUX86State *env, struct x86_decode *decode)
+{
+    do_bt(env, decode, 3);
+    RIP(env) += decode->len;
+}
+
+static void exec_bts(struct CPUX86State *env, struct x86_decode *decode)
+{
+    do_bt(env, decode, 2);
+    RIP(env) += decode->len;
+}
+
+void exec_shl(struct CPUX86State *env, struct x86_decode *decode)
+{
+    uint8_t count;
+    int of = 0, cf = 0;
+
+    fetch_operands(env, decode, 2, true, true, false);
+
+    count = decode->op[1].val;
+    count &= 0x1f;      /* count is masked to 5 bits*/
+    if (!count) {
+        goto exit;
+    }
+
+    switch (decode->operand_size) {
+    case 1:
+    {
+        uint8_t res = 0;
+        if (count <= 8) {
+            res = (decode->op[0].val << count);
+            cf = (decode->op[0].val >> (8 - count)) & 0x1;
+            of = cf ^ (res >> 7);
+        }
+
+        write_val_ext(env, decode->op[0].ptr, res, 1);
+        SET_FLAGS_OSZAPC_LOGIC_8(res);
+        SET_FLAGS_OxxxxC(env, of, cf);
+        break;
+    }
+    case 2:
+    {
+        uint16_t res = 0;
+
+        /* from bochs */
+        if (count <= 16) {
+            res = (decode->op[0].val << count);
+            cf = (decode->op[0].val >> (16 - count)) & 0x1;
+            of = cf ^ (res >> 15); /* of = cf ^ result15 */
+        }
+
+        write_val_ext(env, decode->op[0].ptr, res, 2);
+        SET_FLAGS_OSZAPC_LOGIC_16(res);
+        SET_FLAGS_OxxxxC(env, of, cf);
+        break;
+    }
+    case 4:
+    {
+        uint32_t res = decode->op[0].val << count;
+
+        write_val_ext(env, decode->op[0].ptr, res, 4);
+        SET_FLAGS_OSZAPC_LOGIC_32(res);
+        cf = (decode->op[0].val >> (32 - count)) & 0x1;
+        of = cf ^ (res >> 31); /* of = cf ^ result31 */
+        SET_FLAGS_OxxxxC(env, of, cf);
+        break;
+    }
+    default:
+        abort();
+    }
+
+exit:
+    /* lflags_to_rflags(env); */
+    RIP(env) += decode->len;
+}
+
+void exec_movsx(CPUX86State *env, struct x86_decode *decode)
+{
+    int src_op_size;
+    int op_size = decode->operand_size;
+
+    fetch_operands(env, decode, 2, false, false, false);
+
+    if (0xbe == decode->opcode[1]) {
+        src_op_size = 1;
+    } else {
+        src_op_size = 2;
+    }
+
+    decode->operand_size = src_op_size;
+    calc_modrm_operand(env, decode, &decode->op[1]);
+    decode->op[1].val = sign(read_val_ext(env, decode->op[1].ptr, src_op_size),
+                             src_op_size);
+
+    write_val_ext(env, decode->op[0].ptr, decode->op[1].val, op_size);
+
+    RIP(env) += decode->len;
+}
+
+void exec_ror(struct CPUX86State *env, struct x86_decode *decode)
+{
+    uint8_t count;
+
+    fetch_operands(env, decode, 2, true, true, false);
+    count = decode->op[1].val;
+
+    switch (decode->operand_size) {
+    case 1:
+    {
+        uint32_t bit6, bit7;
+        uint8_t res;
+
+        if ((count & 0x07) == 0) {
+            if (count & 0x18) {
+                bit6 = ((uint8_t)decode->op[0].val >> 6) & 1;
+                bit7 = ((uint8_t)decode->op[0].val >> 7) & 1;
+                SET_FLAGS_OxxxxC(env, bit6 ^ bit7, bit7);
+             }
+        } else {
+            count &= 0x7; /* use only bottom 3 bits */
+            res = ((uint8_t)decode->op[0].val >> count) |
+                   ((uint8_t)decode->op[0].val << (8 - count));
+            write_val_ext(env, decode->op[0].ptr, res, 1);
+            bit6 = (res >> 6) & 1;
+            bit7 = (res >> 7) & 1;
+            /* set eflags: ROR count affects the following flags: C, O */
+            SET_FLAGS_OxxxxC(env, bit6 ^ bit7, bit7);
+        }
+        break;
+    }
+    case 2:
+    {
+        uint32_t bit14, bit15;
+        uint16_t res;
+
+        if ((count & 0x0f) == 0) {
+            if (count & 0x10) {
+                bit14 = ((uint16_t)decode->op[0].val >> 14) & 1;
+                bit15 = ((uint16_t)decode->op[0].val >> 15) & 1;
+                /* of = result14 ^ result15 */
+                SET_FLAGS_OxxxxC(env, bit14 ^ bit15, bit15);
+            }
+        } else {
+            count &= 0x0f;  /* use only 4 LSB's */
+            res = ((uint16_t)decode->op[0].val >> count) |
+                   ((uint16_t)decode->op[0].val << (16 - count));
+            write_val_ext(env, decode->op[0].ptr, res, 2);
+
+            bit14 = (res >> 14) & 1;
+            bit15 = (res >> 15) & 1;
+            /* of = result14 ^ result15 */
+            SET_FLAGS_OxxxxC(env, bit14 ^ bit15, bit15);
+        }
+        break;
+    }
+    case 4:
+    {
+        uint32_t bit31, bit30;
+        uint32_t res;
+
+        count &= 0x1f;
+        if (count) {
+            res = ((uint32_t)decode->op[0].val >> count) |
+                   ((uint32_t)decode->op[0].val << (32 - count));
+            write_val_ext(env, decode->op[0].ptr, res, 4);
+
+            bit31 = (res >> 31) & 1;
+            bit30 = (res >> 30) & 1;
+            /* of = result30 ^ result31 */
+            SET_FLAGS_OxxxxC(env, bit30 ^ bit31, bit31);
+        }
+        break;
+        }
+    }
+    RIP(env) += decode->len;
+}
+
+void exec_rol(struct CPUX86State *env, struct x86_decode *decode)
+{
+    uint8_t count;
+
+    fetch_operands(env, decode, 2, true, true, false);
+    count = decode->op[1].val;
+
+    switch (decode->operand_size) {
+    case 1:
+    {
+        uint32_t bit0, bit7;
+        uint8_t res;
+
+        if ((count & 0x07) == 0) {
+            if (count & 0x18) {
+                bit0 = ((uint8_t)decode->op[0].val & 1);
+                bit7 = ((uint8_t)decode->op[0].val >> 7);
+                SET_FLAGS_OxxxxC(env, bit0 ^ bit7, bit0);
+            }
+        }  else {
+            count &= 0x7; /* use only lowest 3 bits */
+            res = ((uint8_t)decode->op[0].val << count) |
+                   ((uint8_t)decode->op[0].val >> (8 - count));
+
+            write_val_ext(env, decode->op[0].ptr, res, 1);
+            /* set eflags:
+             * ROL count affects the following flags: C, O
+             */
+            bit0 = (res &  1);
+            bit7 = (res >> 7);
+            SET_FLAGS_OxxxxC(env, bit0 ^ bit7, bit0);
+        }
+        break;
+    }
+    case 2:
+    {
+        uint32_t bit0, bit15;
+        uint16_t res;
+
+        if ((count & 0x0f) == 0) {
+            if (count & 0x10) {
+                bit0  = ((uint16_t)decode->op[0].val & 0x1);
+                bit15 = ((uint16_t)decode->op[0].val >> 15);
+                /* of = cf ^ result15 */
+                SET_FLAGS_OxxxxC(env, bit0 ^ bit15, bit0);
+            }
+        } else {
+            count &= 0x0f; /* only use bottom 4 bits */
+            res = ((uint16_t)decode->op[0].val << count) |
+                   ((uint16_t)decode->op[0].val >> (16 - count));
+
+            write_val_ext(env, decode->op[0].ptr, res, 2);
+            bit0  = (res & 0x1);
+            bit15 = (res >> 15);
+            /* of = cf ^ result15 */
+            SET_FLAGS_OxxxxC(env, bit0 ^ bit15, bit0);
+        }
+        break;
+    }
+    case 4:
+    {
+        uint32_t bit0, bit31;
+        uint32_t res;
+
+        count &= 0x1f;
+        if (count) {
+            res = ((uint32_t)decode->op[0].val << count) |
+                   ((uint32_t)decode->op[0].val >> (32 - count));
+
+            write_val_ext(env, decode->op[0].ptr, res, 4);
+            bit0  = (res & 0x1);
+            bit31 = (res >> 31);
+            /* of = cf ^ result31 */
+            SET_FLAGS_OxxxxC(env, bit0 ^ bit31, bit0);
+        }
+        break;
+        }
+    }
+    RIP(env) += decode->len;
+}
+
+
+void exec_rcl(struct CPUX86State *env, struct x86_decode *decode)
+{
+    uint8_t count;
+    int of = 0, cf = 0;
+
+    fetch_operands(env, decode, 2, true, true, false);
+    count = decode->op[1].val & 0x1f;
+
+    switch (decode->operand_size) {
+    case 1:
+    {
+        uint8_t op1_8 = decode->op[0].val;
+        uint8_t res;
+        count %= 9;
+        if (!count) {
+            break;
+        }
+
+        if (1 == count) {
+            res = (op1_8 << 1) | get_CF(env);
+        } else {
+            res = (op1_8 << count) | (get_CF(env) << (count - 1)) |
+                   (op1_8 >> (9 - count));
+        }
+
+        write_val_ext(env, decode->op[0].ptr, res, 1);
+
+        cf = (op1_8 >> (8 - count)) & 0x01;
+        of = cf ^ (res >> 7); /* of = cf ^ result7 */
+        SET_FLAGS_OxxxxC(env, of, cf);
+        break;
+    }
+    case 2:
+    {
+        uint16_t res;
+        uint16_t op1_16 = decode->op[0].val;
+
+        count %= 17;
+        if (!count) {
+            break;
+        }
+
+        if (1 == count) {
+            res = (op1_16 << 1) | get_CF(env);
+        } else if (count == 16) {
+            res = (get_CF(env) << 15) | (op1_16 >> 1);
+        } else { /* 2..15 */
+            res = (op1_16 << count) | (get_CF(env) << (count - 1)) |
+                   (op1_16 >> (17 - count));
+        }
+
+        write_val_ext(env, decode->op[0].ptr, res, 2);
+
+        cf = (op1_16 >> (16 - count)) & 0x1;
+        of = cf ^ (res >> 15); /* of = cf ^ result15 */
+        SET_FLAGS_OxxxxC(env, of, cf);
+        break;
+    }
+    case 4:
+    {
+        uint32_t res;
+        uint32_t op1_32 = decode->op[0].val;
+
+        if (!count) {
+            break;
+        }
+
+        if (1 == count) {
+            res = (op1_32 << 1) | get_CF(env);
+        } else {
+            res = (op1_32 << count) | (get_CF(env) << (count - 1)) |
+                   (op1_32 >> (33 - count));
+        }
+
+        write_val_ext(env, decode->op[0].ptr, res, 4);
+
+        cf = (op1_32 >> (32 - count)) & 0x1;
+        of = cf ^ (res >> 31); /* of = cf ^ result31 */
+        SET_FLAGS_OxxxxC(env, of, cf);
+        break;
+        }
+    }
+    RIP(env) += decode->len;
+}
+
+void exec_rcr(struct CPUX86State *env, struct x86_decode *decode)
+{
+    uint8_t count;
+    int of = 0, cf = 0;
+
+    fetch_operands(env, decode, 2, true, true, false);
+    count = decode->op[1].val & 0x1f;
+
+    switch (decode->operand_size) {
+    case 1:
+    {
+        uint8_t op1_8 = decode->op[0].val;
+        uint8_t res;
+
+        count %= 9;
+        if (!count) {
+            break;
+        }
+        res = (op1_8 >> count) | (get_CF(env) << (8 - count)) |
+               (op1_8 << (9 - count));
+
+        write_val_ext(env, decode->op[0].ptr, res, 1);
+
+        cf = (op1_8 >> (count - 1)) & 0x1;
+        of = (((res << 1) ^ res) >> 7) & 0x1; /* of = result6 ^ result7 */
+        SET_FLAGS_OxxxxC(env, of, cf);
+        break;
+    }
+    case 2:
+    {
+        uint16_t op1_16 = decode->op[0].val;
+        uint16_t res;
+
+        count %= 17;
+        if (!count) {
+            break;
+        }
+        res = (op1_16 >> count) | (get_CF(env) << (16 - count)) |
+               (op1_16 << (17 - count));
+
+        write_val_ext(env, decode->op[0].ptr, res, 2);
+
+        cf = (op1_16 >> (count - 1)) & 0x1;
+        of = ((uint16_t)((res << 1) ^ res) >> 15) & 0x1; /* of = result15 ^
+                                                            result14 */
+        SET_FLAGS_OxxxxC(env, of, cf);
+        break;
+    }
+    case 4:
+    {
+        uint32_t res;
+        uint32_t op1_32 = decode->op[0].val;
+
+        if (!count) {
+            break;
+        }
+
+        if (1 == count) {
+            res = (op1_32 >> 1) | (get_CF(env) << 31);
+        } else {
+            res = (op1_32 >> count) | (get_CF(env) << (32 - count)) |
+                   (op1_32 << (33 - count));
+        }
+
+        write_val_ext(env, decode->op[0].ptr, res, 4);
+
+        cf = (op1_32 >> (count - 1)) & 0x1;
+        of = ((res << 1) ^ res) >> 31; /* of = result30 ^ result31 */
+        SET_FLAGS_OxxxxC(env, of, cf);
+        break;
+        }
+    }
+    RIP(env) += decode->len;
+}
+
+static void exec_xchg(struct CPUX86State *env, struct x86_decode *decode)
+{
+    fetch_operands(env, decode, 2, true, true, false);
+
+    write_val_ext(env, decode->op[0].ptr, decode->op[1].val,
+                  decode->operand_size);
+    write_val_ext(env, decode->op[1].ptr, decode->op[0].val,
+                  decode->operand_size);
+
+    RIP(env) += decode->len;
+}
+
+static void exec_xadd(struct CPUX86State *env, struct x86_decode *decode)
+{
+    EXEC_2OP_ARITH_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
+    write_val_ext(env, decode->op[1].ptr, decode->op[0].val,
+                  decode->operand_size);
+
+    RIP(env) += decode->len;
+}
+
+static struct cmd_handler {
+    enum x86_decode_cmd cmd;
+    void (*handler)(struct CPUX86State *env, struct x86_decode *ins);
+} handlers[] = {
+    {X86_DECODE_CMD_INVL, NULL,},
+    {X86_DECODE_CMD_MOV, exec_mov},
+    {X86_DECODE_CMD_ADD, exec_add},
+    {X86_DECODE_CMD_OR, exec_or},
+    {X86_DECODE_CMD_ADC, exec_adc},
+    {X86_DECODE_CMD_SBB, exec_sbb},
+    {X86_DECODE_CMD_AND, exec_and},
+    {X86_DECODE_CMD_SUB, exec_sub},
+    {X86_DECODE_CMD_NEG, exec_neg},
+    {X86_DECODE_CMD_XOR, exec_xor},
+    {X86_DECODE_CMD_CMP, exec_cmp},
+    {X86_DECODE_CMD_INC, exec_inc},
+    {X86_DECODE_CMD_DEC, exec_dec},
+    {X86_DECODE_CMD_TST, exec_tst},
+    {X86_DECODE_CMD_NOT, exec_not},
+    {X86_DECODE_CMD_MOVZX, exec_movzx},
+    {X86_DECODE_CMD_OUT, exec_out},
+    {X86_DECODE_CMD_IN, exec_in},
+    {X86_DECODE_CMD_INS, exec_ins},
+    {X86_DECODE_CMD_OUTS, exec_outs},
+    {X86_DECODE_CMD_RDMSR, exec_rdmsr},
+    {X86_DECODE_CMD_WRMSR, exec_wrmsr},
+    {X86_DECODE_CMD_BT, exec_bt},
+    {X86_DECODE_CMD_BTR, exec_btr},
+    {X86_DECODE_CMD_BTC, exec_btc},
+    {X86_DECODE_CMD_BTS, exec_bts},
+    {X86_DECODE_CMD_SHL, exec_shl},
+    {X86_DECODE_CMD_ROL, exec_rol},
+    {X86_DECODE_CMD_ROR, exec_ror},
+    {X86_DECODE_CMD_RCR, exec_rcr},
+    {X86_DECODE_CMD_RCL, exec_rcl},
+    /*{X86_DECODE_CMD_CPUID, exec_cpuid},*/
+    {X86_DECODE_CMD_MOVS, exec_movs},
+    {X86_DECODE_CMD_CMPS, exec_cmps},
+    {X86_DECODE_CMD_STOS, exec_stos},
+    {X86_DECODE_CMD_SCAS, exec_scas},
+    {X86_DECODE_CMD_LODS, exec_lods},
+    {X86_DECODE_CMD_MOVSX, exec_movsx},
+    {X86_DECODE_CMD_XCHG, exec_xchg},
+    {X86_DECODE_CMD_XADD, exec_xadd},
+};
+
+static struct cmd_handler _cmd_handler[X86_DECODE_CMD_LAST];
+
+static void init_cmd_handler()
+{
+    int i;
+    for (i = 0; i < ARRAY_SIZE(handlers); i++) {
+        _cmd_handler[handlers[i].cmd] = handlers[i];
+    }
+}
+
+void load_regs(struct CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    int i = 0;
+    RRX(env, REG_RAX) = rreg(cpu->hvf_fd, HV_X86_RAX);
+    RRX(env, REG_RBX) = rreg(cpu->hvf_fd, HV_X86_RBX);
+    RRX(env, REG_RCX) = rreg(cpu->hvf_fd, HV_X86_RCX);
+    RRX(env, REG_RDX) = rreg(cpu->hvf_fd, HV_X86_RDX);
+    RRX(env, REG_RSI) = rreg(cpu->hvf_fd, HV_X86_RSI);
+    RRX(env, REG_RDI) = rreg(cpu->hvf_fd, HV_X86_RDI);
+    RRX(env, REG_RSP) = rreg(cpu->hvf_fd, HV_X86_RSP);
+    RRX(env, REG_RBP) = rreg(cpu->hvf_fd, HV_X86_RBP);
+    for (i = 8; i < 16; i++) {
+        RRX(env, i) = rreg(cpu->hvf_fd, HV_X86_RAX + i);
+    }
+
+    RFLAGS(env) = rreg(cpu->hvf_fd, HV_X86_RFLAGS);
+    rflags_to_lflags(env);
+    RIP(env) = rreg(cpu->hvf_fd, HV_X86_RIP);
+}
+
+void store_regs(struct CPUState *cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    int i = 0;
+    wreg(cpu->hvf_fd, HV_X86_RAX, RAX(env));
+    wreg(cpu->hvf_fd, HV_X86_RBX, RBX(env));
+    wreg(cpu->hvf_fd, HV_X86_RCX, RCX(env));
+    wreg(cpu->hvf_fd, HV_X86_RDX, RDX(env));
+    wreg(cpu->hvf_fd, HV_X86_RSI, RSI(env));
+    wreg(cpu->hvf_fd, HV_X86_RDI, RDI(env));
+    wreg(cpu->hvf_fd, HV_X86_RBP, RBP(env));
+    wreg(cpu->hvf_fd, HV_X86_RSP, RSP(env));
+    for (i = 8; i < 16; i++) {
+        wreg(cpu->hvf_fd, HV_X86_RAX + i, RRX(env, i));
+    }
+
+    lflags_to_rflags(env);
+    wreg(cpu->hvf_fd, HV_X86_RFLAGS, RFLAGS(env));
+    macvm_set_rip(cpu, RIP(env));
+}
+
+bool exec_instruction(struct CPUX86State *env, struct x86_decode *ins)
+{
+    /*if (hvf_vcpu_id(cpu))
+    printf("%d, %llx: exec_instruction %s\n", hvf_vcpu_id(cpu),  RIP(cpu),
+          decode_cmd_to_string(ins->cmd));*/
+
+    if (0 && ins->is_fpu) {
+        VM_PANIC("emulate fpu\n");
+    } else {
+        if (!_cmd_handler[ins->cmd].handler) {
+            printf("Unimplemented handler (%llx) for %d (%x %x) \n", RIP(env),
+                    ins->cmd, ins->opcode[0],
+                    ins->opcode_len > 1 ? ins->opcode[1] : 0);
+            RIP(env) += ins->len;
+            return true;
+        }
+
+        VM_PANIC_ON_EX(!_cmd_handler[ins->cmd].handler,
+                "Unimplemented handler (%llx) for %d (%x %x) \n", RIP(env),
+                 ins->cmd, ins->opcode[0],
+                 ins->opcode_len > 1 ? ins->opcode[1] : 0);
+        _cmd_handler[ins->cmd].handler(env, ins);
+    }
+    return true;
+}
+
+void init_emu()
+{
+    init_cmd_handler();
+}
diff --git a/target/i386/hvf-utils/x86_emu.h b/target/i386/hvf-utils/x86_emu.h
new file mode 100644
index 0000000000..e1491a0935
--- /dev/null
+++ b/target/i386/hvf-utils/x86_emu.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __X86_EMU_H__
+#define __X86_EMU_H__
+
+#include "x86.h"
+#include "x86_decode.h"
+#include "cpu.h"
+
+void init_emu(void);
+bool exec_instruction(struct CPUX86State *env, struct x86_decode *ins);
+
+void load_regs(struct CPUState *cpu);
+void store_regs(struct CPUState *cpu);
+
+void simulate_rdmsr(struct CPUState *cpu);
+void simulate_wrmsr(struct CPUState *cpu);
+
+addr_t read_reg(CPUX86State *env, int reg, int size);
+void write_reg(CPUX86State *env, int reg, addr_t val, int size);
+addr_t read_val_from_reg(addr_t reg_ptr, int size);
+void write_val_to_reg(addr_t reg_ptr, addr_t val, int size);
+void write_val_ext(struct CPUX86State *env, addr_t ptr, addr_t val, int size);
+uint8_t *read_mmio(struct CPUX86State *env, addr_t ptr, int bytes);
+addr_t read_val_ext(struct CPUX86State *env, addr_t ptr, int size);
+
+void exec_movzx(struct CPUX86State *env, struct x86_decode *decode);
+void exec_shl(struct CPUX86State *env, struct x86_decode *decode);
+void exec_movsx(struct CPUX86State *env, struct x86_decode *decode);
+void exec_ror(struct CPUX86State *env, struct x86_decode *decode);
+void exec_rol(struct CPUX86State *env, struct x86_decode *decode);
+void exec_rcl(struct CPUX86State *env, struct x86_decode *decode);
+void exec_rcr(struct CPUX86State *env, struct x86_decode *decode);
+#endif
diff --git a/target/i386/hvf-utils/x86_flags.c b/target/i386/hvf-utils/x86_flags.c
new file mode 100644
index 0000000000..c833774485
--- /dev/null
+++ b/target/i386/hvf-utils/x86_flags.c
@@ -0,0 +1,333 @@
+/////////////////////////////////////////////////////////////////////////
+//
+//  Copyright (C) 2001-2012  The Bochs Project
+//  Copyright (C) 2017 Google Inc.
+//
+//  This library is free software; you can redistribute it and/or
+//  modify it under the terms of the GNU Lesser General Public
+//  License as published by the Free Software Foundation; either
+//  version 2 of the License, or (at your option) any later version.
+//
+//  This library is distributed in the hope that it will be useful,
+//  but WITHOUT ANY WARRANTY; without even the implied warranty of
+//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+//  Lesser General Public License for more details.
+//
+//  You should have received a copy of the GNU Lesser General Public
+//  License along with this library; if not, write to the Free Software
+//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+/////////////////////////////////////////////////////////////////////////
+/*
+ * flags functions
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "cpu.h"
+#include "x86_flags.h"
+#include "x86.h"
+
+void SET_FLAGS_OxxxxC(CPUX86State *env, uint32_t new_of, uint32_t new_cf)
+{
+    uint32_t temp_po = new_of ^ new_cf;
+    env->hvf_emul->lflags.auxbits &= ~(LF_MASK_PO | LF_MASK_CF);
+    env->hvf_emul->lflags.auxbits |= (temp_po << LF_BIT_PO) |
+                                     (new_cf << LF_BIT_CF);
+}
+
+void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
+                            uint32_t diff)
+{
+    SET_FLAGS_OSZAPC_SUB_32(v1, v2, diff);
+}
+
+void SET_FLAGS_OSZAPC_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
+                            uint16_t diff)
+{
+    SET_FLAGS_OSZAPC_SUB_16(v1, v2, diff);
+}
+
+void SET_FLAGS_OSZAPC_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
+                            uint8_t diff)
+{
+    SET_FLAGS_OSZAPC_SUB_8(v1, v2, diff);
+}
+
+void SET_FLAGS_OSZAPC_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
+                            uint32_t diff)
+{
+    SET_FLAGS_OSZAPC_ADD_32(v1, v2, diff);
+}
+
+void SET_FLAGS_OSZAPC_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
+                            uint16_t diff)
+{
+    SET_FLAGS_OSZAPC_ADD_16(v1, v2, diff);
+}
+
+void SET_FLAGS_OSZAPC_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
+                            uint8_t diff)
+{
+    SET_FLAGS_OSZAPC_ADD_8(v1, v2, diff);
+}
+
+void SET_FLAGS_OSZAP_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
+                            uint32_t diff)
+{
+    SET_FLAGS_OSZAP_SUB_32(v1, v2, diff);
+}
+
+void SET_FLAGS_OSZAP_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
+                            uint16_t diff)
+{
+    SET_FLAGS_OSZAP_SUB_16(v1, v2, diff);
+}
+
+void SET_FLAGS_OSZAP_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
+                            uint8_t diff)
+{
+    SET_FLAGS_OSZAP_SUB_8(v1, v2, diff);
+}
+
+void SET_FLAGS_OSZAP_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
+                            uint32_t diff)
+{
+    SET_FLAGS_OSZAP_ADD_32(v1, v2, diff);
+}
+
+void SET_FLAGS_OSZAP_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
+                            uint16_t diff)
+{
+    SET_FLAGS_OSZAP_ADD_16(v1, v2, diff);
+}
+
+void SET_FLAGS_OSZAP_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
+                            uint8_t diff)
+{
+    SET_FLAGS_OSZAP_ADD_8(v1, v2, diff);
+}
+
+
+void SET_FLAGS_OSZAPC_LOGIC32(CPUX86State *env, uint32_t diff)
+{
+    SET_FLAGS_OSZAPC_LOGIC_32(diff);
+}
+
+void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_t diff)
+{
+    SET_FLAGS_OSZAPC_LOGIC_16(diff);
+}
+
+void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t diff)
+{
+    SET_FLAGS_OSZAPC_LOGIC_8(diff);
+}
+
+void SET_FLAGS_SHR32(CPUX86State *env, uint32_t v, int count, uint32_t res)
+{
+    int cf = (v >> (count - 1)) & 0x1;
+    int of = (((res << 1) ^ res) >> 31);
+
+    SET_FLAGS_OSZAPC_LOGIC_32(res);
+    SET_FLAGS_OxxxxC(env, of, cf);
+}
+
+void SET_FLAGS_SHR16(CPUX86State *env, uint16_t v, int count, uint16_t res)
+{
+    int cf = (v >> (count - 1)) & 0x1;
+    int of = (((res << 1) ^ res) >> 15);
+
+    SET_FLAGS_OSZAPC_LOGIC_16(res);
+    SET_FLAGS_OxxxxC(env, of, cf);
+}
+
+void SET_FLAGS_SHR8(CPUX86State *env, uint8_t v, int count, uint8_t res)
+{
+    int cf = (v >> (count - 1)) & 0x1;
+    int of = (((res << 1) ^ res) >> 7);
+
+    SET_FLAGS_OSZAPC_LOGIC_8(res);
+    SET_FLAGS_OxxxxC(env, of, cf);
+}
+
+void SET_FLAGS_SAR32(CPUX86State *env, int32_t v, int count, uint32_t res)
+{
+    int cf = (v >> (count - 1)) & 0x1;
+
+    SET_FLAGS_OSZAPC_LOGIC_32(res);
+    SET_FLAGS_OxxxxC(env, 0, cf);
+}
+
+void SET_FLAGS_SAR16(CPUX86State *env, int16_t v, int count, uint16_t res)
+{
+    int cf = (v >> (count - 1)) & 0x1;
+
+    SET_FLAGS_OSZAPC_LOGIC_16(res);
+    SET_FLAGS_OxxxxC(env, 0, cf);
+}
+
+void SET_FLAGS_SAR8(CPUX86State *env, int8_t v, int count, uint8_t res)
+{
+    int cf = (v >> (count - 1)) & 0x1;
+
+    SET_FLAGS_OSZAPC_LOGIC_8(res);
+    SET_FLAGS_OxxxxC(env, 0, cf);
+}
+
+
+void SET_FLAGS_SHL32(CPUX86State *env, uint32_t v, int count, uint32_t res)
+{
+    int of, cf;
+
+    cf = (v >> (32 - count)) & 0x1;
+    of = cf ^ (res >> 31);
+
+    SET_FLAGS_OSZAPC_LOGIC_32(res);
+    SET_FLAGS_OxxxxC(env, of, cf);
+}
+
+void SET_FLAGS_SHL16(CPUX86State *env, uint16_t v, int count, uint16_t res)
+{
+    int of = 0, cf = 0;
+
+    if (count <= 16) {
+        cf = (v >> (16 - count)) & 0x1;
+        of = cf ^ (res >> 15);
+    }
+
+    SET_FLAGS_OSZAPC_LOGIC_16(res);
+    SET_FLAGS_OxxxxC(env, of, cf);
+}
+
+void SET_FLAGS_SHL8(CPUX86State *env, uint8_t v, int count, uint8_t res)
+{
+    int of = 0, cf = 0;
+
+    if (count <= 8) {
+        cf = (v >> (8 - count)) & 0x1;
+        of = cf ^ (res >> 7);
+    }
+
+    SET_FLAGS_OSZAPC_LOGIC_8(res);
+    SET_FLAGS_OxxxxC(env, of, cf);
+}
+
+bool get_PF(CPUX86State *env)
+{
+    uint32_t temp = (255 & env->hvf_emul->lflags.result);
+    temp = temp ^ (255 & (env->hvf_emul->lflags.auxbits >> LF_BIT_PDB));
+    temp = (temp ^ (temp >> 4)) & 0x0F;
+    return (0x9669U >> temp) & 1;
+}
+
+void set_PF(CPUX86State *env, bool val)
+{
+    uint32_t temp = (255 & env->hvf_emul->lflags.result) ^ (!val);
+    env->hvf_emul->lflags.auxbits &= ~(LF_MASK_PDB);
+    env->hvf_emul->lflags.auxbits |= (temp << LF_BIT_PDB);
+}
+
+bool _get_OF(CPUX86State *env)
+{
+    return ((env->hvf_emul->lflags.auxbits + (1U << LF_BIT_PO)) >> LF_BIT_CF) & 1;
+}
+
+bool get_OF(CPUX86State *env)
+{
+    return _get_OF(env);
+}
+
+bool _get_CF(CPUX86State *env)
+{
+    return (env->hvf_emul->lflags.auxbits >> LF_BIT_CF) & 1;
+}
+
+bool get_CF(CPUX86State *env)
+{
+    return _get_CF(env);
+}
+
+void set_OF(CPUX86State *env, bool val)
+{
+    SET_FLAGS_OxxxxC(env, val, _get_CF(env));
+}
+
+void set_CF(CPUX86State *env, bool val)
+{
+    SET_FLAGS_OxxxxC(env, _get_OF(env), (val));
+}
+
+bool get_AF(CPUX86State *env)
+{
+    return (env->hvf_emul->lflags.auxbits >> LF_BIT_AF) & 1;
+}
+
+void set_AF(CPUX86State *env, bool val)
+{
+    env->hvf_emul->lflags.auxbits &= ~(LF_MASK_AF);
+    env->hvf_emul->lflags.auxbits |= (val) << LF_BIT_AF;
+}
+
+bool get_ZF(CPUX86State *env)
+{
+    return !env->hvf_emul->lflags.result;
+}
+
+void set_ZF(CPUX86State *env, bool val)
+{
+    if (val) {
+        env->hvf_emul->lflags.auxbits ^=
+         (((env->hvf_emul->lflags.result >> LF_SIGN_BIT) & 1) << LF_BIT_SD);
+        /* merge the parity bits into the Parity Delta Byte */
+        uint32_t temp_pdb = (255 & env->hvf_emul->lflags.result);
+        env->hvf_emul->lflags.auxbits ^= (temp_pdb << LF_BIT_PDB);
+        /* now zero the .result value */
+        env->hvf_emul->lflags.result = 0;
+    } else {
+        env->hvf_emul->lflags.result |= (1 << 8);
+    }
+}
+
+bool get_SF(CPUX86State *env)
+{
+    return ((env->hvf_emul->lflags.result >> LF_SIGN_BIT) ^
+            (env->hvf_emul->lflags.auxbits >> LF_BIT_SD)) & 1;
+}
+
+void set_SF(CPUX86State *env, bool val)
+{
+    bool temp_sf = get_SF(env);
+    env->hvf_emul->lflags.auxbits ^= (temp_sf ^ val) << LF_BIT_SD;
+}
+
+void set_OSZAPC(CPUX86State *env, uint32_t flags32)
+{
+    set_OF(env, env->hvf_emul->rflags.of);
+    set_SF(env, env->hvf_emul->rflags.sf);
+    set_ZF(env, env->hvf_emul->rflags.zf);
+    set_AF(env, env->hvf_emul->rflags.af);
+    set_PF(env, env->hvf_emul->rflags.pf);
+    set_CF(env, env->hvf_emul->rflags.cf);
+}
+
+void lflags_to_rflags(CPUX86State *env)
+{
+    env->hvf_emul->rflags.cf = get_CF(env);
+    env->hvf_emul->rflags.pf = get_PF(env);
+    env->hvf_emul->rflags.af = get_AF(env);
+    env->hvf_emul->rflags.zf = get_ZF(env);
+    env->hvf_emul->rflags.sf = get_SF(env);
+    env->hvf_emul->rflags.of = get_OF(env);
+}
+
+void rflags_to_lflags(CPUX86State *env)
+{
+    env->hvf_emul->lflags.auxbits = env->hvf_emul->lflags.result = 0;
+    set_OF(env, env->hvf_emul->rflags.of);
+    set_SF(env, env->hvf_emul->rflags.sf);
+    set_ZF(env, env->hvf_emul->rflags.zf);
+    set_AF(env, env->hvf_emul->rflags.af);
+    set_PF(env, env->hvf_emul->rflags.pf);
+    set_CF(env, env->hvf_emul->rflags.cf);
+}
diff --git a/target/i386/hvf-utils/x86_flags.h b/target/i386/hvf-utils/x86_flags.h
new file mode 100644
index 0000000000..57a524240c
--- /dev/null
+++ b/target/i386/hvf-utils/x86_flags.h
@@ -0,0 +1,243 @@
+/////////////////////////////////////////////////////////////////////////
+//
+//  Copyright (C) 2001-2012  The Bochs Project
+//  Copyright (C) 2017 Google Inc.
+//
+//  This library is free software; you can redistribute it and/or
+//  modify it under the terms of the GNU Lesser General Public
+//  License as published by the Free Software Foundation; either
+//  version 2 of the License, or (at your option) any later version.
+//
+//  This library is distributed in the hope that it will be useful,
+//  but WITHOUT ANY WARRANTY; without even the implied warranty of
+//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+//  Lesser General Public License for more details.
+//
+//  You should have received a copy of the GNU Lesser General Public
+//  License along with this library; if not, write to the Free Software
+//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+/////////////////////////////////////////////////////////////////////////
+/*
+ * x86 eflags functions
+ */
+#ifndef __X86_FLAGS_H__
+#define __X86_FLAGS_H__
+
+#include "x86_gen.h"
+#include "cpu.h"
+
+/* this is basically bocsh code */
+
+#define LF_SIGN_BIT     31
+
+#define LF_BIT_SD      (0)          /* lazy Sign Flag Delta            */
+#define LF_BIT_AF      (3)          /* lazy Adjust flag                */
+#define LF_BIT_PDB     (8)          /* lazy Parity Delta Byte (8 bits) */
+#define LF_BIT_CF      (31)         /* lazy Carry Flag                 */
+#define LF_BIT_PO      (30)         /* lazy Partial Overflow = CF ^ OF */
+
+#define LF_MASK_SD     (0x01 << LF_BIT_SD)
+#define LF_MASK_AF     (0x01 << LF_BIT_AF)
+#define LF_MASK_PDB    (0xFF << LF_BIT_PDB)
+#define LF_MASK_CF     (0x01 << LF_BIT_CF)
+#define LF_MASK_PO     (0x01 << LF_BIT_PO)
+
+#define ADD_COUT_VEC(op1, op2, result) \
+   (((op1) & (op2)) | (((op1) | (op2)) & (~(result))))
+
+#define SUB_COUT_VEC(op1, op2, result) \
+   (((~(op1)) & (op2)) | (((~(op1)) ^ (op2)) & (result)))
+
+#define GET_ADD_OVERFLOW(op1, op2, result, mask) \
+   ((((op1) ^ (result)) & ((op2) ^ (result))) & (mask))
+
+/* ******************* */
+/* OSZAPC */
+/* ******************* */
+
+/* size, carries, result */
+#define SET_FLAGS_OSZAPC_SIZE(size, lf_carries, lf_result) { \
+    addr_t temp = ((lf_carries) & (LF_MASK_AF)) | \
+    (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
+    env->hvf_emul->lflags.result = (addr_t)(int##size##_t)(lf_result); \
+    if ((size) == 32) { \
+        temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
+    } else if ((size) == 16) { \
+        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 16); \
+    } else if ((size) == 8)  { \
+        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 24); \
+    } else { \
+        VM_PANIC("unimplemented");  \
+    } \
+    env->hvf_emul->lflags.auxbits = (addr_t)(uint32_t)temp; \
+}
+
+/* carries, result */
+#define SET_FLAGS_OSZAPC_8(carries, result) \
+    SET_FLAGS_OSZAPC_SIZE(8, carries, result)
+#define SET_FLAGS_OSZAPC_16(carries, result) \
+    SET_FLAGS_OSZAPC_SIZE(16, carries, result)
+#define SET_FLAGS_OSZAPC_32(carries, result) \
+    SET_FLAGS_OSZAPC_SIZE(32, carries, result)
+
+/* result */
+#define SET_FLAGS_OSZAPC_LOGIC_8(result_8) \
+    SET_FLAGS_OSZAPC_8(0, (result_8))
+#define SET_FLAGS_OSZAPC_LOGIC_16(result_16) \
+    SET_FLAGS_OSZAPC_16(0, (result_16))
+#define SET_FLAGS_OSZAPC_LOGIC_32(result_32) \
+    SET_FLAGS_OSZAPC_32(0, (result_32))
+#define SET_FLAGS_OSZAPC_LOGIC_SIZE(size, result) {             \
+    if (32 == size) { \
+        SET_FLAGS_OSZAPC_LOGIC_32(result); \
+    } else if (16 == size) { \
+        SET_FLAGS_OSZAPC_LOGIC_16(result); \
+    } else if (8 == size) { \
+        SET_FLAGS_OSZAPC_LOGIC_8(result); \
+    } else { \
+        VM_PANIC("unimplemented");                            \
+    } \
+}
+
+/* op1, op2, result */
+#define SET_FLAGS_OSZAPC_ADD_8(op1_8, op2_8, sum_8) \
+    SET_FLAGS_OSZAPC_8(ADD_COUT_VEC((op1_8), (op2_8), (sum_8)), (sum_8))
+#define SET_FLAGS_OSZAPC_ADD_16(op1_16, op2_16, sum_16) \
+    SET_FLAGS_OSZAPC_16(ADD_COUT_VEC((op1_16), (op2_16), (sum_16)), (sum_16))
+#define SET_FLAGS_OSZAPC_ADD_32(op1_32, op2_32, sum_32) \
+    SET_FLAGS_OSZAPC_32(ADD_COUT_VEC((op1_32), (op2_32), (sum_32)), (sum_32))
+
+/* op1, op2, result */
+#define SET_FLAGS_OSZAPC_SUB_8(op1_8, op2_8, diff_8) \
+    SET_FLAGS_OSZAPC_8(SUB_COUT_VEC((op1_8), (op2_8), (diff_8)), (diff_8))
+#define SET_FLAGS_OSZAPC_SUB_16(op1_16, op2_16, diff_16) \
+    SET_FLAGS_OSZAPC_16(SUB_COUT_VEC((op1_16), (op2_16), (diff_16)), (diff_16))
+#define SET_FLAGS_OSZAPC_SUB_32(op1_32, op2_32, diff_32) \
+    SET_FLAGS_OSZAPC_32(SUB_COUT_VEC((op1_32), (op2_32), (diff_32)), (diff_32))
+
+/* ******************* */
+/* OSZAP */
+/* ******************* */
+/* size, carries, result */
+#define SET_FLAGS_OSZAP_SIZE(size, lf_carries, lf_result) { \
+    addr_t temp = ((lf_carries) & (LF_MASK_AF)) | \
+    (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
+    if ((size) == 32) { \
+        temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
+    } else if ((size) == 16) { \
+        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 16); \
+    } else if ((size) == 8) { \
+        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 24); \
+    } else { \
+        VM_PANIC("unimplemented");      \
+    } \
+    env->hvf_emul->lflags.result = (addr_t)(int##size##_t)(lf_result); \
+    addr_t delta_c = (env->hvf_emul->lflags.auxbits ^ temp) & LF_MASK_CF; \
+    delta_c ^= (delta_c >> 1); \
+    env->hvf_emul->lflags.auxbits = (addr_t)(uint32_t)(temp ^ delta_c); \
+}
+
+/* carries, result */
+#define SET_FLAGS_OSZAP_8(carries, result) \
+    SET_FLAGS_OSZAP_SIZE(8, carries, result)
+#define SET_FLAGS_OSZAP_16(carries, result) \
+    SET_FLAGS_OSZAP_SIZE(16, carries, result)
+#define SET_FLAGS_OSZAP_32(carries, result) \
+    SET_FLAGS_OSZAP_SIZE(32, carries, result)
+
+/* op1, op2, result */
+#define SET_FLAGS_OSZAP_ADD_8(op1_8, op2_8, sum_8) \
+    SET_FLAGS_OSZAP_8(ADD_COUT_VEC((op1_8), (op2_8), (sum_8)), (sum_8))
+#define SET_FLAGS_OSZAP_ADD_16(op1_16, op2_16, sum_16) \
+    SET_FLAGS_OSZAP_16(ADD_COUT_VEC((op1_16), (op2_16), (sum_16)), (sum_16))
+#define SET_FLAGS_OSZAP_ADD_32(op1_32, op2_32, sum_32) \
+    SET_FLAGS_OSZAP_32(ADD_COUT_VEC((op1_32), (op2_32), (sum_32)), (sum_32))
+
+/* op1, op2, result */
+#define SET_FLAGS_OSZAP_SUB_8(op1_8, op2_8, diff_8) \
+    SET_FLAGS_OSZAP_8(SUB_COUT_VEC((op1_8), (op2_8), (diff_8)), (diff_8))
+#define SET_FLAGS_OSZAP_SUB_16(op1_16, op2_16, diff_16) \
+    SET_FLAGS_OSZAP_16(SUB_COUT_VEC((op1_16), (op2_16), (diff_16)), (diff_16))
+#define SET_FLAGS_OSZAP_SUB_32(op1_32, op2_32, diff_32) \
+    SET_FLAGS_OSZAP_32(SUB_COUT_VEC((op1_32), (op2_32), (diff_32)), (diff_32))
+
+/* ******************* */
+/* OSZAxC */
+/* ******************* */
+/* size, carries, result */
+#define SET_FLAGS_OSZAxC_LOGIC_SIZE(size, lf_result) { \
+    bool saved_PF = getB_PF(); \
+    SET_FLAGS_OSZAPC_SIZE(size, (int##size##_t)(0), lf_result); \
+    set_PF(saved_PF); \
+}
+
+/* result */
+#define SET_FLAGS_OSZAxC_LOGIC_32(result_32) \
+    SET_FLAGS_OSZAxC_LOGIC_SIZE(32, (result_32))
+
+void lflags_to_rflags(CPUX86State *env);
+void rflags_to_lflags(CPUX86State *env);
+
+bool get_PF(CPUX86State *env);
+void set_PF(CPUX86State *env, bool val);
+bool get_CF(CPUX86State *env);
+void set_CF(CPUX86State *env, bool val);
+bool get_AF(CPUX86State *env);
+void set_AF(CPUX86State *env, bool val);
+bool get_ZF(CPUX86State *env);
+void set_ZF(CPUX86State *env, bool val);
+bool get_SF(CPUX86State *env);
+void set_SF(CPUX86State *env, bool val);
+bool get_OF(CPUX86State *env);
+void set_OF(CPUX86State *env, bool val);
+void set_OSZAPC(CPUX86State *env, uint32_t flags32);
+
+void SET_FLAGS_OxxxxC(CPUX86State *env, uint32_t new_of, uint32_t new_cf);
+
+void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
+                            uint32_t diff);
+void SET_FLAGS_OSZAPC_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
+                            uint16_t diff);
+void SET_FLAGS_OSZAPC_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
+                           uint8_t diff);
+
+void SET_FLAGS_OSZAPC_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
+                            uint32_t diff);
+void SET_FLAGS_OSZAPC_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
+                            uint16_t diff);
+void SET_FLAGS_OSZAPC_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
+                           uint8_t diff);
+
+void SET_FLAGS_OSZAP_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
+                           uint32_t diff);
+void SET_FLAGS_OSZAP_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
+                           uint16_t diff);
+void SET_FLAGS_OSZAP_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
+                          uint8_t diff);
+
+void SET_FLAGS_OSZAP_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
+                           uint32_t diff);
+void SET_FLAGS_OSZAP_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
+                           uint16_t diff);
+void SET_FLAGS_OSZAP_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
+                          uint8_t diff);
+
+void SET_FLAGS_OSZAPC_LOGIC32(CPUX86State *env, uint32_t diff);
+void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_t diff);
+void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t diff);
+
+void SET_FLAGS_SHR32(CPUX86State *env, uint32_t v, int count, uint32_t res);
+void SET_FLAGS_SHR16(CPUX86State *env, uint16_t v, int count, uint16_t res);
+void SET_FLAGS_SHR8(CPUX86State *env, uint8_t v, int count, uint8_t res);
+
+void SET_FLAGS_SAR32(CPUX86State *env, int32_t v, int count, uint32_t res);
+void SET_FLAGS_SAR16(CPUX86State *env, int16_t v, int count, uint16_t res);
+void SET_FLAGS_SAR8(CPUX86State *env, int8_t v, int count, uint8_t res);
+
+void SET_FLAGS_SHL32(CPUX86State *env, uint32_t v, int count, uint32_t res);
+void SET_FLAGS_SHL16(CPUX86State *env, uint16_t v, int count, uint16_t res);
+void SET_FLAGS_SHL8(CPUX86State *env, uint8_t v, int count, uint8_t res);
+
+bool _get_OF(CPUX86State *env);
+bool _get_CF(CPUX86State *env);
+#endif /* __X86_FLAGS_H__ */
diff --git a/target/i386/hvf-utils/x86_gen.h b/target/i386/hvf-utils/x86_gen.h
new file mode 100644
index 0000000000..e4340fa244
--- /dev/null
+++ b/target/i386/hvf-utils/x86_gen.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __X86_GEN_H__
+#define __X86_GEN_H__
+
+#include <stdlib.h>
+#include <stdio.h>
+#include "qemu-common.h"
+
+typedef uint64_t addr_t;
+
+#define VM_PANIC(x) {\
+    printf("%s\n", x); \
+    abort(); \
+}
+
+#define VM_PANIC_ON(x) {\
+    if (x) { \
+        printf("%s\n", #x); \
+        abort(); \
+    } \
+}
+
+#define VM_PANIC_EX(...) {\
+    printf(__VA_ARGS__); \
+    abort(); \
+}
+
+#define VM_PANIC_ON_EX(x, ...) {\
+    if (x) { \
+        printf(__VA_ARGS__); \
+        abort(); \
+    } \
+}
+
+#define ZERO_INIT(obj) memset((void *) &obj, 0, sizeof(obj))
+
+#endif
diff --git a/target/i386/hvf-utils/x86_mmu.c b/target/i386/hvf-utils/x86_mmu.c
new file mode 100644
index 0000000000..4bb1664104
--- /dev/null
+++ b/target/i386/hvf-utils/x86_mmu.c
@@ -0,0 +1,273 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+
+#include "qemu-common.h"
+#include "x86.h"
+#include "x86_mmu.h"
+#include "string.h"
+#include "vmcs.h"
+#include "vmx.h"
+
+#include "memory.h"
+#include "exec/address-spaces.h"
+
+#define pte_present(pte) (pte & PT_PRESENT)
+#define pte_write_access(pte) (pte & PT_WRITE)
+#define pte_user_access(pte) (pte & PT_USER)
+#define pte_exec_access(pte) (!(pte & PT_NX))
+
+#define pte_large_page(pte) (pte & PT_PS)
+#define pte_global_access(pte) (pte & PT_GLOBAL)
+
+#define PAE_CR3_MASK                (~0x1fllu)
+#define LEGACY_CR3_MASK             (0xffffffff)
+
+#define LEGACY_PTE_PAGE_MASK        (0xffffffffllu << 12)
+#define PAE_PTE_PAGE_MASK           ((-1llu << 12) & ((1llu << 52) - 1))
+#define PAE_PTE_LARGE_PAGE_MASK     ((-1llu << (21)) & ((1llu << 52) - 1))
+
+struct gpt_translation {
+    addr_t  gva;
+    addr_t gpa;
+    int    err_code;
+    uint64_t pte[5];
+    bool write_access;
+    bool user_access;
+    bool exec_access;
+};
+
+static int gpt_top_level(struct CPUState *cpu, bool pae)
+{
+    if (!pae) {
+        return 2;
+    }
+    if (x86_is_long_mode(cpu)) {
+        return 4;
+    }
+
+    return 3;
+}
+
+static inline int gpt_entry(addr_t addr, int level, bool pae)
+{
+    int level_shift = pae ? 9 : 10;
+    return (addr >> (level_shift * (level - 1) + 12)) & ((1 << level_shift) - 1);
+}
+
+static inline int pte_size(bool pae)
+{
+    return pae ? 8 : 4;
+}
+
+
+static bool get_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
+                         int level, bool pae)
+{
+    int index;
+    uint64_t pte = 0;
+    addr_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
+    addr_t gpa = pt->pte[level] & page_mask;
+
+    if (level == 3 && !x86_is_long_mode(cpu)) {
+        gpa = pt->pte[level];
+    }
+
+    index = gpt_entry(pt->gva, level, pae);
+    address_space_rw(&address_space_memory, gpa + index * pte_size(pae),
+                     MEMTXATTRS_UNSPECIFIED, (uint8_t *)&pte, pte_size(pae), 0);
+
+    pt->pte[level - 1] = pte;
+
+    return true;
+}
+
+/* test page table entry */
+static bool test_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
+                          int level, bool *is_large, bool pae)
+{
+    uint64_t pte = pt->pte[level];
+
+    if (pt->write_access) {
+        pt->err_code |= MMU_PAGE_WT;
+    }
+    if (pt->user_access) {
+        pt->err_code |= MMU_PAGE_US;
+    }
+    if (pt->exec_access) {
+        pt->err_code |= MMU_PAGE_NX;
+    }
+
+    if (!pte_present(pte)) {
+        /* addr_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK; */
+        return false;
+    }
+
+    if (pae && !x86_is_long_mode(cpu) && 2 == level) {
+        goto exit;
+    }
+
+    if (1 == level && pte_large_page(pte)) {
+        pt->err_code |= MMU_PAGE_PT;
+        *is_large = true;
+    }
+    if (!level) {
+        pt->err_code |= MMU_PAGE_PT;
+    }
+
+    addr_t cr0 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR0);
+    /* check protection */
+    if (cr0 & CR0_WP) {
+        if (pt->write_access && !pte_write_access(pte)) {
+            return false;
+        }
+    }
+
+    if (pt->user_access && !pte_user_access(pte)) {
+        return false;
+    }
+
+    if (pae && pt->exec_access && !pte_exec_access(pte)) {
+        return false;
+    }
+    
+exit:
+    /* TODO: check reserved bits */
+    return true;
+}
+
+static inline uint64_t pse_pte_to_page(uint64_t pte)
+{
+    return ((pte & 0x1fe000) << 19) | (pte & 0xffc00000);
+}
+
+static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae)
+{
+    VM_PANIC_ON(!pte_large_page(pt->pte[1]))
+    /* 2Mb large page  */
+    if (pae) {
+        return (pt->pte[1] & PAE_PTE_LARGE_PAGE_MASK) | (pt->gva & 0x1fffff);
+    }
+
+    /* 4Mb large page */
+    return pse_pte_to_page(pt->pte[1]) | (pt->gva & 0x3fffff);
+}
+
+
+
+static bool walk_gpt(struct CPUState *cpu, addr_t addr, int err_code,
+                     struct gpt_translation *pt, bool pae)
+{
+    int top_level, level;
+    bool is_large = false;
+    addr_t cr3 = rvmcs(cpu->hvf_fd, VMCS_GUEST_CR3);
+    addr_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
+    
+    memset(pt, 0, sizeof(*pt));
+    top_level = gpt_top_level(cpu, pae);
+
+    pt->pte[top_level] = pae ? (cr3 & PAE_CR3_MASK) : (cr3 & LEGACY_CR3_MASK);
+    pt->gva = addr;
+    pt->user_access = (err_code & MMU_PAGE_US);
+    pt->write_access = (err_code & MMU_PAGE_WT);
+    pt->exec_access = (err_code & MMU_PAGE_NX);
+    
+    for (level = top_level; level > 0; level--) {
+        get_pt_entry(cpu, pt, level, pae);
+
+        if (!test_pt_entry(cpu, pt, level - 1, &is_large, pae)) {
+            return false;
+        }
+
+        if (is_large) {
+            break;
+        }
+    }
+
+    if (!is_large) {
+        pt->gpa = (pt->pte[0] & page_mask) | (pt->gva & 0xfff);
+    } else {
+        pt->gpa = large_page_gpa(pt, pae);
+    }
+
+    return true;
+}
+
+
+bool mmu_gva_to_gpa(struct CPUState *cpu, addr_t gva, addr_t *gpa)
+{
+    bool res;
+    struct gpt_translation pt;
+    int err_code = 0;
+
+    if (!x86_is_paging_mode(cpu)) {
+        *gpa = gva;
+        return true;
+    }
+
+    res = walk_gpt(cpu, gva, err_code, &pt, x86_is_pae_enabled(cpu));
+    if (res) {
+        *gpa = pt.gpa;
+        return true;
+    }
+
+    return false;
+}
+
+void vmx_write_mem(struct CPUState *cpu, addr_t gva, void *data, int bytes)
+{
+    addr_t gpa;
+
+    while (bytes > 0) {
+        /* copy page */
+        int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
+
+        if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
+            VM_PANIC_ON_EX(1, "%s: mmu_gva_to_gpa %llx failed\n", __func__,
+                           gva);
+        } else {
+            address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
+                             data, copy, 1);
+        }
+
+        bytes -= copy;
+        gva += copy;
+        data += copy;
+    }
+}
+
+void vmx_read_mem(struct CPUState *cpu, void *data, addr_t gva, int bytes)
+{
+    addr_t gpa;
+
+    while (bytes > 0) {
+        /* copy page */
+        int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
+
+        if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
+            VM_PANIC_ON_EX(1, "%s: mmu_gva_to_gpa %llx failed\n", __func__,
+                           gva);
+        }
+        address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
+                         data, copy, 0);
+
+        bytes -= copy;
+        gva += copy;
+        data += copy;
+    }
+}
diff --git a/target/i386/hvf-utils/x86_mmu.h b/target/i386/hvf-utils/x86_mmu.h
new file mode 100644
index 0000000000..4fce48c18f
--- /dev/null
+++ b/target/i386/hvf-utils/x86_mmu.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __X86_MMU_H__
+#define __X86_MMU_H__
+
+#include "x86_gen.h"
+
+#define PT_PRESENT      (1 << 0)
+#define PT_WRITE        (1 << 1)
+#define PT_USER         (1 << 2)
+#define PT_WT           (1 << 3)
+#define PT_CD           (1 << 4)
+#define PT_ACCESSED     (1 << 5)
+#define PT_DIRTY        (1 << 6)
+#define PT_PS           (1 << 7)
+#define PT_GLOBAL       (1 << 8)
+#define PT_NX           (1llu << 63)
+
+/* error codes */
+#define MMU_PAGE_PT             (1 << 0)
+#define MMU_PAGE_WT             (1 << 1)
+#define MMU_PAGE_US             (1 << 2)
+#define MMU_PAGE_NX             (1 << 3)
+
+bool mmu_gva_to_gpa(struct CPUState *cpu, addr_t gva, addr_t *gpa);
+
+void vmx_write_mem(struct CPUState *cpu, addr_t gva, void *data, int bytes);
+void vmx_read_mem(struct CPUState *cpu, void *data, addr_t gva, int bytes);
+
+#endif /* __X86_MMU_H__ */
diff --git a/target/i386/hvf-utils/x86hvf.c b/target/i386/hvf-utils/x86hvf.c
new file mode 100644
index 0000000000..e405910a6f
--- /dev/null
+++ b/target/i386/hvf-utils/x86hvf.c
@@ -0,0 +1,513 @@
+/*
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "x86hvf.h"
+#include "vmx.h"
+#include "vmcs.h"
+#include "cpu.h"
+#include "x86_descr.h"
+#include "x86_decode.h"
+
+#include "hw/i386/apic_internal.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <Hypervisor/hv.h>
+#include <Hypervisor/hv_vmx.h>
+#include <stdint.h>
+
+void hvf_set_segment(struct CPUState *cpu, struct vmx_segment *vmx_seg,
+                     SegmentCache *qseg, bool is_tr)
+{
+    vmx_seg->sel = qseg->selector;
+    vmx_seg->base = qseg->base;
+    vmx_seg->limit = qseg->limit;
+
+    if (!qseg->selector && !x86_is_real(cpu) && !is_tr) {
+        /* the TR register is usable after processor reset despite
+         * having a null selector */
+        vmx_seg->ar = 1 << 16;
+        return;
+    }
+    vmx_seg->ar = (qseg->flags >> DESC_TYPE_SHIFT) & 0xf;
+    vmx_seg->ar |= ((qseg->flags >> DESC_G_SHIFT) & 1) << 15;
+    vmx_seg->ar |= ((qseg->flags >> DESC_B_SHIFT) & 1) << 14;
+    vmx_seg->ar |= ((qseg->flags >> DESC_L_SHIFT) & 1) << 13;
+    vmx_seg->ar |= ((qseg->flags >> DESC_AVL_SHIFT) & 1) << 12;
+    vmx_seg->ar |= ((qseg->flags >> DESC_P_SHIFT) & 1) << 7;
+    vmx_seg->ar |= ((qseg->flags >> DESC_DPL_SHIFT) & 3) << 5;
+    vmx_seg->ar |= ((qseg->flags >> DESC_S_SHIFT) & 1) << 4;
+}
+
+void hvf_get_segment(SegmentCache *qseg, struct vmx_segment *vmx_seg)
+{
+    qseg->limit = vmx_seg->limit;
+    qseg->base = vmx_seg->base;
+    qseg->selector = vmx_seg->sel;
+    qseg->flags = ((vmx_seg->ar & 0xf) << DESC_TYPE_SHIFT) |
+                  (((vmx_seg->ar >> 4) & 1) << DESC_S_SHIFT) |
+                  (((vmx_seg->ar >> 5) & 3) << DESC_DPL_SHIFT) |
+                  (((vmx_seg->ar >> 7) & 1) << DESC_P_SHIFT) |
+                  (((vmx_seg->ar >> 12) & 1) << DESC_AVL_SHIFT) |
+                  (((vmx_seg->ar >> 13) & 1) << DESC_L_SHIFT) |
+                  (((vmx_seg->ar >> 14) & 1) << DESC_B_SHIFT) |
+                  (((vmx_seg->ar >> 15) & 1) << DESC_G_SHIFT);
+}
+
+void hvf_put_xsave(CPUState *cpu_state)
+{
+
+    int x;
+    struct hvf_xsave_buf *xsave;
+    
+    xsave = X86_CPU(cpu_state)->env.kvm_xsave_buf;
+    memset(xsave, 0, sizeof(*xsave)); 
+    
+    memcpy(&xsave->data[4], &X86_CPU(cpu_state)->env.fpdp, sizeof(X86_CPU(cpu_state)->env.fpdp));
+    memcpy(&xsave->data[2], &X86_CPU(cpu_state)->env.fpip, sizeof(X86_CPU(cpu_state)->env.fpip));
+    memcpy(&xsave->data[8], &X86_CPU(cpu_state)->env.fpregs, sizeof(X86_CPU(cpu_state)->env.fpregs));
+    memcpy(&xsave->data[144], &X86_CPU(cpu_state)->env.ymmh_regs, sizeof(X86_CPU(cpu_state)->env.ymmh_regs));
+    memcpy(&xsave->data[288], &X86_CPU(cpu_state)->env.zmmh_regs, sizeof(X86_CPU(cpu_state)->env.zmmh_regs));
+    memcpy(&xsave->data[272], &X86_CPU(cpu_state)->env.opmask_regs, sizeof(X86_CPU(cpu_state)->env.opmask_regs));
+    memcpy(&xsave->data[240], &X86_CPU(cpu_state)->env.bnd_regs, sizeof(X86_CPU(cpu_state)->env.bnd_regs));
+    memcpy(&xsave->data[256], &X86_CPU(cpu_state)->env.bndcs_regs, sizeof(X86_CPU(cpu_state)->env.bndcs_regs));
+    memcpy(&xsave->data[416], &X86_CPU(cpu_state)->env.hi16_zmm_regs, sizeof(X86_CPU(cpu_state)->env.hi16_zmm_regs));
+    
+    xsave->data[0] = (uint16_t)X86_CPU(cpu_state)->env.fpuc;
+    xsave->data[0] |= (X86_CPU(cpu_state)->env.fpus << 16);
+    xsave->data[0] |= (X86_CPU(cpu_state)->env.fpstt & 7) << 11;
+    
+    for (x = 0; x < 8; ++x)
+        xsave->data[1] |= ((!X86_CPU(cpu_state)->env.fptags[x]) << x);
+    xsave->data[1] |= (uint32_t)(X86_CPU(cpu_state)->env.fpop << 16);
+    
+    memcpy(&xsave->data[40], &X86_CPU(cpu_state)->env.xmm_regs, sizeof(X86_CPU(cpu_state)->env.xmm_regs));
+    
+    xsave->data[6] = X86_CPU(cpu_state)->env.mxcsr;
+    *(uint64_t *)&xsave->data[128] = X86_CPU(cpu_state)->env.xstate_bv;
+    
+    if (hv_vcpu_write_fpstate(cpu_state->hvf_fd, xsave->data, 4096)){
+        abort();
+    }
+}
+
+void hvf_put_segments(CPUState *cpu_state)
+{
+    CPUX86State *env = &X86_CPU(cpu_state)->env;
+    struct vmx_segment seg;
+    
+    wvmcs(cpu_state->hvf_fd, VMCS_GUEST_IDTR_LIMIT, env->idt.limit);
+    wvmcs(cpu_state->hvf_fd, VMCS_GUEST_IDTR_BASE, env->idt.base);
+
+    wvmcs(cpu_state->hvf_fd, VMCS_GUEST_GDTR_LIMIT, env->gdt.limit);
+    wvmcs(cpu_state->hvf_fd, VMCS_GUEST_GDTR_BASE, env->gdt.base);
+
+    /* wvmcs(cpu_state->hvf_fd, VMCS_GUEST_CR2, env->cr[2]); */
+    wvmcs(cpu_state->hvf_fd, VMCS_GUEST_CR3, env->cr[3]);
+    vmx_update_tpr(cpu_state);
+    wvmcs(cpu_state->hvf_fd, VMCS_GUEST_IA32_EFER, env->efer);
+
+    macvm_set_cr4(cpu_state->hvf_fd, env->cr[4]);
+    macvm_set_cr0(cpu_state->hvf_fd, env->cr[0]);
+
+    hvf_set_segment(cpu_state, &seg, &env->segs[R_CS], false);
+    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_CS);
+    
+    hvf_set_segment(cpu_state, &seg, &env->segs[R_DS], false);
+    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_DS);
+
+    hvf_set_segment(cpu_state, &seg, &env->segs[R_ES], false);
+    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_ES);
+
+    hvf_set_segment(cpu_state, &seg, &env->segs[R_SS], false);
+    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_SS);
+
+    hvf_set_segment(cpu_state, &seg, &env->segs[R_FS], false);
+    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_FS);
+
+    hvf_set_segment(cpu_state, &seg, &env->segs[R_GS], false);
+    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_GS);
+
+    hvf_set_segment(cpu_state, &seg, &env->tr, true);
+    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_TR);
+
+    hvf_set_segment(cpu_state, &seg, &env->ldt, false);
+    vmx_write_segment_descriptor(cpu_state, &seg, REG_SEG_LDTR);
+    
+    hv_vcpu_flush(cpu_state->hvf_fd);
+}
+    
+void hvf_put_msrs(CPUState *cpu_state)
+{
+    CPUX86State *env = &X86_CPU(cpu_state)->env;
+
+    hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_IA32_SYSENTER_CS,
+                      env->sysenter_cs);
+    hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_IA32_SYSENTER_ESP,
+                      env->sysenter_esp);
+    hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_IA32_SYSENTER_EIP,
+                      env->sysenter_eip);
+
+    hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_STAR, env->star);
+
+#ifdef TARGET_X86_64
+    hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_CSTAR, env->cstar);
+    hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_KERNELGSBASE, env->kernelgsbase);
+    hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_FMASK, env->fmask);
+    hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_LSTAR, env->lstar);
+#endif
+
+    hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_GSBASE, env->segs[R_GS].base);
+    hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_FSBASE, env->segs[R_FS].base);
+
+    /* if (!osx_is_sierra())
+         wvmcs(cpu_state->hvf_fd, VMCS_TSC_OFFSET, env->tsc - rdtscp());*/
+    hv_vm_sync_tsc(env->tsc);
+}
+
+
+void hvf_get_xsave(CPUState *cpu_state)
+{
+    int x;
+    struct hvf_xsave_buf *xsave;
+    
+    xsave = X86_CPU(cpu_state)->env.kvm_xsave_buf;
+    
+    if (hv_vcpu_read_fpstate(cpu_state->hvf_fd, xsave->data, 4096)) {
+        abort();
+    }
+
+    memcpy(&X86_CPU(cpu_state)->env.fpdp, &xsave->data[4], sizeof(X86_CPU(cpu_state)->env.fpdp));
+    memcpy(&X86_CPU(cpu_state)->env.fpip, &xsave->data[2], sizeof(X86_CPU(cpu_state)->env.fpip));
+    memcpy(&X86_CPU(cpu_state)->env.fpregs, &xsave->data[8], sizeof(X86_CPU(cpu_state)->env.fpregs));
+    memcpy(&X86_CPU(cpu_state)->env.ymmh_regs, &xsave->data[144], sizeof(X86_CPU(cpu_state)->env.ymmh_regs));
+    memcpy(&X86_CPU(cpu_state)->env.zmmh_regs, &xsave->data[288], sizeof(X86_CPU(cpu_state)->env.zmmh_regs));
+    memcpy(&X86_CPU(cpu_state)->env.opmask_regs, &xsave->data[272], sizeof(X86_CPU(cpu_state)->env.opmask_regs));
+    memcpy(&X86_CPU(cpu_state)->env.bnd_regs, &xsave->data[240], sizeof(X86_CPU(cpu_state)->env.bnd_regs));
+    memcpy(&X86_CPU(cpu_state)->env.bndcs_regs, &xsave->data[256], sizeof(X86_CPU(cpu_state)->env.bndcs_regs));
+    memcpy(&X86_CPU(cpu_state)->env.hi16_zmm_regs, &xsave->data[416], sizeof(X86_CPU(cpu_state)->env.hi16_zmm_regs));
+    
+    
+    X86_CPU(cpu_state)->env.fpuc = (uint16_t)xsave->data[0];
+    X86_CPU(cpu_state)->env.fpus = (uint16_t)(xsave->data[0] >> 16);
+    X86_CPU(cpu_state)->env.fpstt = (X86_CPU(cpu_state)->env.fpus >> 11) & 7;
+    X86_CPU(cpu_state)->env.fpop = (uint16_t)(xsave->data[1] >> 16);
+    
+    for (x = 0; x < 8; ++x)
+       X86_CPU(cpu_state)->env.fptags[x] =
+        ((((uint16_t)xsave->data[1] >> x) & 1) == 0);
+    
+    memcpy(&X86_CPU(cpu_state)->env.xmm_regs, &xsave->data[40], sizeof(X86_CPU(cpu_state)->env.xmm_regs));
+
+    X86_CPU(cpu_state)->env.mxcsr = xsave->data[6];
+    X86_CPU(cpu_state)->env.xstate_bv = *(uint64_t *)&xsave->data[128];
+}
+
+void hvf_get_segments(CPUState *cpu_state)
+{
+    CPUX86State *env = &X86_CPU(cpu_state)->env;
+
+    struct vmx_segment seg;
+
+    env->interrupt_injected = -1;
+
+    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_CS);
+    hvf_get_segment(&env->segs[R_CS], &seg);
+    
+    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_DS);
+    hvf_get_segment(&env->segs[R_DS], &seg);
+
+    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_ES);
+    hvf_get_segment(&env->segs[R_ES], &seg);
+
+    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_FS);
+    hvf_get_segment(&env->segs[R_FS], &seg);
+
+    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_GS);
+    hvf_get_segment(&env->segs[R_GS], &seg);
+
+    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_SS);
+    hvf_get_segment(&env->segs[R_SS], &seg);
+
+    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_TR);
+    hvf_get_segment(&env->tr, &seg);
+
+    vmx_read_segment_descriptor(cpu_state, &seg, REG_SEG_LDTR);
+    hvf_get_segment(&env->ldt, &seg);
+
+    env->idt.limit = rvmcs(cpu_state->hvf_fd, VMCS_GUEST_IDTR_LIMIT);
+    env->idt.base = rvmcs(cpu_state->hvf_fd, VMCS_GUEST_IDTR_BASE);
+    env->gdt.limit = rvmcs(cpu_state->hvf_fd, VMCS_GUEST_GDTR_LIMIT);
+    env->gdt.base = rvmcs(cpu_state->hvf_fd, VMCS_GUEST_GDTR_BASE);
+
+    env->cr[0] = rvmcs(cpu_state->hvf_fd, VMCS_GUEST_CR0);
+    env->cr[2] = 0;
+    env->cr[3] = rvmcs(cpu_state->hvf_fd, VMCS_GUEST_CR3);
+    env->cr[4] = rvmcs(cpu_state->hvf_fd, VMCS_GUEST_CR4);
+    
+    env->efer = rvmcs(cpu_state->hvf_fd, VMCS_GUEST_IA32_EFER);
+}
+
+void hvf_get_msrs(CPUState *cpu_state)
+{
+    CPUX86State *env = &X86_CPU(cpu_state)->env;
+    uint64_t tmp;
+    
+    hv_vcpu_read_msr(cpu_state->hvf_fd, MSR_IA32_SYSENTER_CS, &tmp);
+    env->sysenter_cs = tmp;
+    
+    hv_vcpu_read_msr(cpu_state->hvf_fd, MSR_IA32_SYSENTER_ESP, &tmp);
+    env->sysenter_esp = tmp;
+
+    hv_vcpu_read_msr(cpu_state->hvf_fd, MSR_IA32_SYSENTER_EIP, &tmp);
+    env->sysenter_eip = tmp;
+
+    hv_vcpu_read_msr(cpu_state->hvf_fd, MSR_STAR, &env->star);
+
+#ifdef TARGET_X86_64
+    hv_vcpu_read_msr(cpu_state->hvf_fd, MSR_CSTAR, &env->cstar);
+    hv_vcpu_read_msr(cpu_state->hvf_fd, MSR_KERNELGSBASE, &env->kernelgsbase);
+    hv_vcpu_read_msr(cpu_state->hvf_fd, MSR_FMASK, &env->fmask);
+    hv_vcpu_read_msr(cpu_state->hvf_fd, MSR_LSTAR, &env->lstar);
+#endif
+
+    hv_vcpu_read_msr(cpu_state->hvf_fd, MSR_IA32_APICBASE, &tmp);
+    
+    env->tsc = rdtscp() + rvmcs(cpu_state->hvf_fd, VMCS_TSC_OFFSET);
+}
+
+int hvf_put_registers(CPUState *cpu_state)
+{
+    X86CPU *x86cpu = X86_CPU(cpu_state);
+    CPUX86State *env = &x86cpu->env;
+
+    wreg(cpu_state->hvf_fd, HV_X86_RAX, env->regs[R_EAX]);
+    wreg(cpu_state->hvf_fd, HV_X86_RBX, env->regs[R_EBX]);
+    wreg(cpu_state->hvf_fd, HV_X86_RCX, env->regs[R_ECX]);
+    wreg(cpu_state->hvf_fd, HV_X86_RDX, env->regs[R_EDX]);
+    wreg(cpu_state->hvf_fd, HV_X86_RBP, env->regs[R_EBP]);
+    wreg(cpu_state->hvf_fd, HV_X86_RSP, env->regs[R_ESP]);
+    wreg(cpu_state->hvf_fd, HV_X86_RSI, env->regs[R_ESI]);
+    wreg(cpu_state->hvf_fd, HV_X86_RDI, env->regs[R_EDI]);
+    wreg(cpu_state->hvf_fd, HV_X86_R8, env->regs[8]);
+    wreg(cpu_state->hvf_fd, HV_X86_R9, env->regs[9]);
+    wreg(cpu_state->hvf_fd, HV_X86_R10, env->regs[10]);
+    wreg(cpu_state->hvf_fd, HV_X86_R11, env->regs[11]);
+    wreg(cpu_state->hvf_fd, HV_X86_R12, env->regs[12]);
+    wreg(cpu_state->hvf_fd, HV_X86_R13, env->regs[13]);
+    wreg(cpu_state->hvf_fd, HV_X86_R14, env->regs[14]);
+    wreg(cpu_state->hvf_fd, HV_X86_R15, env->regs[15]);
+    wreg(cpu_state->hvf_fd, HV_X86_RFLAGS, env->eflags);
+    wreg(cpu_state->hvf_fd, HV_X86_RIP, env->eip);
+   
+    wreg(cpu_state->hvf_fd, HV_X86_XCR0, env->xcr0);
+    
+    hvf_put_xsave(cpu_state);
+    
+    hvf_put_segments(cpu_state);
+    
+    hvf_put_msrs(cpu_state);
+    
+    wreg(cpu_state->hvf_fd, HV_X86_DR0, env->dr[0]);
+    wreg(cpu_state->hvf_fd, HV_X86_DR1, env->dr[1]);
+    wreg(cpu_state->hvf_fd, HV_X86_DR2, env->dr[2]);
+    wreg(cpu_state->hvf_fd, HV_X86_DR3, env->dr[3]);
+    wreg(cpu_state->hvf_fd, HV_X86_DR4, env->dr[4]);
+    wreg(cpu_state->hvf_fd, HV_X86_DR5, env->dr[5]);
+    wreg(cpu_state->hvf_fd, HV_X86_DR6, env->dr[6]);
+    wreg(cpu_state->hvf_fd, HV_X86_DR7, env->dr[7]);
+    
+    return 0;
+}
+
+int hvf_get_registers(CPUState *cpu_state)
+{
+    X86CPU *x86cpu = X86_CPU(cpu_state);
+    CPUX86State *env = &x86cpu->env;
+
+
+    env->regs[R_EAX] = rreg(cpu_state->hvf_fd, HV_X86_RAX);
+    env->regs[R_EBX] = rreg(cpu_state->hvf_fd, HV_X86_RBX);
+    env->regs[R_ECX] = rreg(cpu_state->hvf_fd, HV_X86_RCX);
+    env->regs[R_EDX] = rreg(cpu_state->hvf_fd, HV_X86_RDX);
+    env->regs[R_EBP] = rreg(cpu_state->hvf_fd, HV_X86_RBP);
+    env->regs[R_ESP] = rreg(cpu_state->hvf_fd, HV_X86_RSP);
+    env->regs[R_ESI] = rreg(cpu_state->hvf_fd, HV_X86_RSI);
+    env->regs[R_EDI] = rreg(cpu_state->hvf_fd, HV_X86_RDI);
+    env->regs[8] = rreg(cpu_state->hvf_fd, HV_X86_R8);
+    env->regs[9] = rreg(cpu_state->hvf_fd, HV_X86_R9);
+    env->regs[10] = rreg(cpu_state->hvf_fd, HV_X86_R10);
+    env->regs[11] = rreg(cpu_state->hvf_fd, HV_X86_R11);
+    env->regs[12] = rreg(cpu_state->hvf_fd, HV_X86_R12);
+    env->regs[13] = rreg(cpu_state->hvf_fd, HV_X86_R13);
+    env->regs[14] = rreg(cpu_state->hvf_fd, HV_X86_R14);
+    env->regs[15] = rreg(cpu_state->hvf_fd, HV_X86_R15);
+    
+    env->eflags = rreg(cpu_state->hvf_fd, HV_X86_RFLAGS);
+    env->eip = rreg(cpu_state->hvf_fd, HV_X86_RIP);
+   
+    hvf_get_xsave(cpu_state);
+    env->xcr0 = rreg(cpu_state->hvf_fd, HV_X86_XCR0);
+    
+    hvf_get_segments(cpu_state);
+    hvf_get_msrs(cpu_state);
+    
+    env->dr[0] = rreg(cpu_state->hvf_fd, HV_X86_DR0);
+    env->dr[1] = rreg(cpu_state->hvf_fd, HV_X86_DR1);
+    env->dr[2] = rreg(cpu_state->hvf_fd, HV_X86_DR2);
+    env->dr[3] = rreg(cpu_state->hvf_fd, HV_X86_DR3);
+    env->dr[4] = rreg(cpu_state->hvf_fd, HV_X86_DR4);
+    env->dr[5] = rreg(cpu_state->hvf_fd, HV_X86_DR5);
+    env->dr[6] = rreg(cpu_state->hvf_fd, HV_X86_DR6);
+    env->dr[7] = rreg(cpu_state->hvf_fd, HV_X86_DR7);
+    
+    return 0;
+}
+
+static void vmx_set_int_window_exiting(CPUState *cpu)
+{
+     uint64_t val;
+     val = rvmcs(cpu->hvf_fd, VMCS_PRI_PROC_BASED_CTLS);
+     wvmcs(cpu->hvf_fd, VMCS_PRI_PROC_BASED_CTLS, val |
+             VMCS_PRI_PROC_BASED_CTLS_INT_WINDOW_EXITING);
+}
+
+void vmx_clear_int_window_exiting(CPUState *cpu)
+{
+     uint64_t val;
+     val = rvmcs(cpu->hvf_fd, VMCS_PRI_PROC_BASED_CTLS);
+     wvmcs(cpu->hvf_fd, VMCS_PRI_PROC_BASED_CTLS, val &
+             ~VMCS_PRI_PROC_BASED_CTLS_INT_WINDOW_EXITING);
+}
+
+#define NMI_VEC 2
+
+void hvf_inject_interrupts(CPUState *cpu_state)
+{
+    int allow_nmi = !(rvmcs(cpu_state->hvf_fd, VMCS_GUEST_INTERRUPTIBILITY) &
+                VMCS_INTERRUPTIBILITY_NMI_BLOCKING);
+    X86CPU *x86cpu = X86_CPU(cpu_state);
+    CPUX86State *env = &x86cpu->env;
+
+    uint64_t idt_info = rvmcs(cpu_state->hvf_fd, VMCS_IDT_VECTORING_INFO);
+    uint64_t info = 0;
+    
+    if (idt_info & VMCS_IDT_VEC_VALID) {
+        uint8_t vector = idt_info & 0xff;
+        uint64_t intr_type = idt_info & VMCS_INTR_T_MASK;
+        info = idt_info;
+        
+        uint64_t reason = rvmcs(cpu_state->hvf_fd, VMCS_EXIT_REASON);
+        if (intr_type == VMCS_INTR_T_NMI && reason != EXIT_REASON_TASK_SWITCH) {
+            allow_nmi = 1;
+            vmx_clear_nmi_blocking(cpu_state);
+        }
+        
+        if ((allow_nmi || intr_type != VMCS_INTR_T_NMI)) {
+            info &= ~(1 << 12); /* clear undefined bit */
+            if (intr_type == VMCS_INTR_T_SWINTR ||
+                intr_type == VMCS_INTR_T_PRIV_SWEXCEPTION ||
+                intr_type == VMCS_INTR_T_SWEXCEPTION) {
+                uint64_t ins_len = rvmcs(cpu_state->hvf_fd,
+                                         VMCS_EXIT_INSTRUCTION_LENGTH);
+                wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INST_LENGTH, ins_len);
+            }
+            if (vector == EXCEPTION_BP || vector == EXCEPTION_OF) {
+                /*
+                 * VT-x requires #BP and #OF to be injected as software
+                 * exceptions.
+                 */
+                info &= ~VMCS_INTR_T_MASK;
+                info |= VMCS_INTR_T_SWEXCEPTION;
+                uint64_t ins_len = rvmcs(cpu_state->hvf_fd,
+                                         VMCS_EXIT_INSTRUCTION_LENGTH);
+                wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INST_LENGTH, ins_len);
+            }
+            
+            uint64_t err = 0;
+            if (idt_info & VMCS_INTR_DEL_ERRCODE) {
+                err = rvmcs(cpu_state->hvf_fd, VMCS_IDT_VECTORING_ERROR);
+                wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_EXCEPTION_ERROR, err);
+            }
+            /*printf("reinject  %lx err %d\n", info, err);*/
+            wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INTR_INFO, info);
+        };
+    }
+
+    if (cpu_state->interrupt_request & CPU_INTERRUPT_NMI) {
+        if (allow_nmi && !(info & VMCS_INTR_VALID)) {
+            cpu_state->interrupt_request &= ~CPU_INTERRUPT_NMI;
+            info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | NMI_VEC;
+            wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INTR_INFO, info);
+        } else {
+            vmx_set_nmi_window_exiting(cpu_state);
+        }
+    }
+
+    if (env->hvf_emul->interruptable &&
+        (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
+        (EFLAGS(env) & IF_MASK) && !(info & VMCS_INTR_VALID)) {
+        int line = cpu_get_pic_interrupt(&x86cpu->env);
+        cpu_state->interrupt_request &= ~CPU_INTERRUPT_HARD;
+        if (line >= 0) {
+            wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INTR_INFO, line |
+                  VMCS_INTR_VALID | VMCS_INTR_T_HWINTR);
+        }
+    }
+    if (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) {
+        vmx_set_int_window_exiting(cpu_state);
+    }
+}
+
+int hvf_process_events(CPUState *cpu_state)
+{
+    X86CPU *cpu = X86_CPU(cpu_state);
+    CPUX86State *env = &cpu->env;
+
+    EFLAGS(env) = rreg(cpu_state->hvf_fd, HV_X86_RFLAGS);
+
+    if (cpu_state->interrupt_request & CPU_INTERRUPT_INIT) {
+        hvf_cpu_synchronize_state(cpu_state);
+        do_cpu_init(cpu);
+    }
+
+    if (cpu_state->interrupt_request & CPU_INTERRUPT_POLL) {
+        cpu_state->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        apic_poll_irq(cpu->apic_state);
+    }
+    if (((cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
+        (EFLAGS(env) & IF_MASK)) ||
+        (cpu_state->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu_state->halted = 0;
+    }
+    if (cpu_state->interrupt_request & CPU_INTERRUPT_SIPI) {
+        hvf_cpu_synchronize_state(cpu_state);
+        do_cpu_sipi(cpu);
+    }
+    if (cpu_state->interrupt_request & CPU_INTERRUPT_TPR) {
+        cpu_state->interrupt_request &= ~CPU_INTERRUPT_TPR;
+        hvf_cpu_synchronize_state(cpu_state);
+        apic_handle_tpr_access_report(cpu->apic_state, env->eip,
+                                      env->tpr_access_type);
+    }
+    return cpu_state->halted;
+}
diff --git a/target/i386/hvf-utils/x86hvf.h b/target/i386/hvf-utils/x86hvf.h
new file mode 100644
index 0000000000..4e0d723689
--- /dev/null
+++ b/target/i386/hvf-utils/x86hvf.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef X86HVF_H
+#define X86HVF_H
+#include "cpu.h"
+#include "x86_descr.h"
+
+int hvf_process_events(CPUState *);
+int hvf_put_registers(CPUState *);
+int hvf_get_registers(CPUState *);
+void hvf_inject_interrupts(CPUState *);
+void hvf_set_segment(struct CPUState *cpu, struct vmx_segment *vmx_seg,
+                     SegmentCache *qseg, bool is_tr);
+void hvf_get_segment(SegmentCache *qseg, struct vmx_segment *vmx_seg);
+void hvf_put_xsave(CPUState *cpu_state);
+void hvf_put_segments(CPUState *cpu_state);
+void hvf_put_msrs(CPUState *cpu_state);
+void hvf_get_xsave(CPUState *cpu_state);
+void hvf_get_msrs(CPUState *cpu_state);
+void vmx_clear_int_window_exiting(CPUState *cpu);
+void hvf_get_segments(CPUState *cpu_state);
+void vmx_update_tpr(CPUState *cpu);
+void hvf_cpu_synchronize_state(CPUState *cpu_state);
+#endif
-- 
2.14.3
