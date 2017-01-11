Received: from eggs.gnu.org ([2001:4830:134:3::10]:45722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROh0-0003gp-6V
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgt-0003g8-Cv
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:18 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:33375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgs-0003ed-OX
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:11 -0500
Received: by mail-wj0-x244.google.com with SMTP id kp2so91999566wjc.0
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:36:10 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:24 +0100
Message-Id: <1484163327-111841-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 30/33] target/i386: Add Intel HAX files
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

That's a forward port of the core HAX interface code from the
emu-2.2-release branch in the external/qemu-android repository as used by
the Android emulator.

The original commit was "target/i386: Add Intel HAX to android emulator"
saying:
"""
  Backport of 2b3098ff27bab079caab9b46b58546b5036f5c0c
  from studio-1.4-dev into emu-master-dev

    Intel HAX (harware acceleration) will enhance android emulator performance
    in Windows and Mac OS X in the systems powered by Intel processors with
    "Intel Hardware Accelerated Execution Manager" package installed when
    user runs android emulator with Intel target.

    Signed-off-by: David Chou <david.j.chou@intel.com>
"""

It has been modified to build and run along with the current code base.
The formatting has been fixed to go through scripts/checkpatch.pl,
and the DPRINTF macros have been updated to get the instanciations checked by
the compiler.

The FPU registers saving/restoring has been updated to match the current
QEMU registers layout.

The implementation has been simplified by doing the following modifications:
- removing the code for supporting the hardware without Unrestricted Guest (UG)
  mode (including all the code to fallback on TCG emulation).
- not including the Darwin support (which is not yet debugged/tested).
- simplifying the initialization by removing the leftovers from the Android
  specific code, then trimming down the remaining logic.
- removing the unused MemoryListener callbacks.

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Message-Id: <e1023837f8d0e4c470f6c4a3bf643971b2bca5be.1484045952.git.vpalatin@chromium.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hax-stub.c                  |   39 ++
 include/sysemu/hax.h        |   56 +++
 target/i386/hax-all.c       | 1155 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/hax-i386.h      |   86 ++++
 target/i386/hax-interface.h |  361 ++++++++++++++
 target/i386/hax-mem.c       |  289 +++++++++++
 target/i386/hax-windows.c   |  479 ++++++++++++++++++
 target/i386/hax-windows.h   |   89 ++++
 8 files changed, 2554 insertions(+)
 create mode 100644 hax-stub.c
 create mode 100644 include/sysemu/hax.h
 create mode 100644 target/i386/hax-all.c
 create mode 100644 target/i386/hax-i386.h
 create mode 100644 target/i386/hax-interface.h
 create mode 100644 target/i386/hax-mem.c
 create mode 100644 target/i386/hax-windows.c
 create mode 100644 target/i386/hax-windows.h

diff --git a/hax-stub.c b/hax-stub.c
new file mode 100644
index 0000000..a532dba
--- /dev/null
+++ b/hax-stub.c
@@ -0,0 +1,39 @@
+/*
+ * QEMU HAXM support
+ *
+ * Copyright (c) 2015, Intel Corporation
+ *
+ * Copyright 2016 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "sysemu/hax.h"
+
+int hax_sync_vcpus(void)
+{
+    return 0;
+}
+
+int hax_populate_ram(uint64_t va, uint32_t size)
+{
+    return -ENOSYS;
+}
+
+int hax_init_vcpu(CPUState *cpu)
+{
+    return -ENOSYS;
+}
+
+int hax_smp_cpu_exec(CPUState *cpu)
+{
+    return -ENOSYS;
+}
diff --git a/include/sysemu/hax.h b/include/sysemu/hax.h
new file mode 100644
index 0000000..d9f0239
--- /dev/null
+++ b/include/sysemu/hax.h
@@ -0,0 +1,56 @@
+/*
+ * QEMU HAXM support
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * Copyright (c) 2011 Intel Corporation
+ *  Written by:
+ *  Jiang Yunhong<yunhong.jiang@intel.com>
+ *  Xin Xiaohui<xiaohui.xin@intel.com>
+ *  Zhang Xiantao<xiantao.zhang@intel.com>
+ *
+ * Copyright 2016 Google, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_HAX_H
+#define QEMU_HAX_H
+
+#include "config-host.h"
+#include "qemu-common.h"
+
+int hax_sync_vcpus(void);
+int hax_init_vcpu(CPUState *cpu);
+int hax_smp_cpu_exec(CPUState *cpu);
+int hax_populate_ram(uint64_t va, uint32_t size);
+
+void hax_cpu_synchronize_state(CPUState *cpu);
+void hax_cpu_synchronize_post_reset(CPUState *cpu);
+void hax_cpu_synchronize_post_init(CPUState *cpu);
+
+#ifdef CONFIG_HAX
+
+int hax_enabled(void);
+
+#include "hw/hw.h"
+#include "qemu/bitops.h"
+#include "exec/memory.h"
+int hax_vcpu_destroy(CPUState *cpu);
+void hax_raise_event(CPUState *cpu);
+void hax_reset_vcpu_state(void *opaque);
+#include "target/i386/hax-interface.h"
+#include "target/i386/hax-i386.h"
+
+#else /* CONFIG_HAX */
+
+#define hax_enabled() (0)
+
+#endif /* CONFIG_HAX */
+
+#endif /* QEMU_HAX_H */
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
new file mode 100644
index 0000000..ef13015
--- /dev/null
+++ b/target/i386/hax-all.c
@@ -0,0 +1,1155 @@
+/*
+ * QEMU HAX support
+ *
+ * Copyright IBM, Corp. 2008
+ *           Red Hat, Inc. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *  Glauber Costa     <gcosta@redhat.com>
+ *
+ * Copyright (c) 2011 Intel Corporation
+ *  Written by:
+ *  Jiang Yunhong<yunhong.jiang@intel.com>
+ *  Xin Xiaohui<xiaohui.xin@intel.com>
+ *  Zhang Xiantao<xiantao.zhang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+/*
+ * HAX common code for both windows and darwin
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/address-spaces.h"
+#include "exec/exec-all.h"
+#include "exec/ioport.h"
+
+#include "qemu-common.h"
+#include "strings.h"
+#include "hax-i386.h"
+#include "sysemu/accel.h"
+#include "sysemu/sysemu.h"
+#include "qemu/main-loop.h"
+#include "hw/boards.h"
+
+#define DEBUG_HAX 0
+
+#define DPRINTF(fmt, ...) \
+    do { \
+        if (DEBUG_HAX) { \
+            fprintf(stdout, fmt, ## __VA_ARGS__); \
+        } \
+    } while (0)
+
+/* Current version */
+const uint32_t hax_cur_version = 0x4; /* API v4: unmapping and MMIO moves */
+/* Minimum HAX kernel version */
+const uint32_t hax_min_version = 0x4; /* API v4: supports unmapping */
+
+static bool hax_allowed;
+
+struct hax_state hax_global;
+
+static void hax_vcpu_sync_state(CPUArchState *env, int modified);
+static int hax_arch_get_registers(CPUArchState *env);
+
+int hax_enabled(void)
+{
+    return hax_allowed;
+}
+
+int valid_hax_tunnel_size(uint16_t size)
+{
+    return size >= sizeof(struct hax_tunnel);
+}
+
+hax_fd hax_vcpu_get_fd(CPUArchState *env)
+{
+    struct hax_vcpu_state *vcpu = ENV_GET_CPU(env)->hax_vcpu;
+    if (!vcpu) {
+        return HAX_INVALID_FD;
+    }
+    return vcpu->fd;
+}
+
+static int hax_get_capability(struct hax_state *hax)
+{
+    int ret;
+    struct hax_capabilityinfo capinfo, *cap = &capinfo;
+
+    ret = hax_capability(hax, cap);
+    if (ret) {
+        return ret;
+    }
+
+    if ((cap->wstatus & HAX_CAP_WORKSTATUS_MASK) == HAX_CAP_STATUS_NOTWORKING) {
+        if (cap->winfo & HAX_CAP_FAILREASON_VT) {
+            DPRINTF
+                ("VTX feature is not enabled, HAX driver will not work.\n");
+        } else if (cap->winfo & HAX_CAP_FAILREASON_NX) {
+            DPRINTF
+                ("NX feature is not enabled, HAX driver will not work.\n");
+        }
+        return -ENXIO;
+
+    }
+
+    if (!(cap->winfo & HAX_CAP_UG)) {
+        fprintf(stderr, "UG mode is not supported by the hardware.\n");
+        return -ENOTSUP;
+    }
+
+    if (cap->wstatus & HAX_CAP_MEMQUOTA) {
+        if (cap->mem_quota < hax->mem_quota) {
+            fprintf(stderr, "The VM memory needed exceeds the driver limit.\n");
+            return -ENOSPC;
+        }
+    }
+    return 0;
+}
+
+static int hax_version_support(struct hax_state *hax)
+{
+    int ret;
+    struct hax_module_version version;
+
+    ret = hax_mod_version(hax, &version);
+    if (ret < 0) {
+        return 0;
+    }
+
+    if (hax_min_version > version.cur_version) {
+        fprintf(stderr, "Incompatible HAX module version %d,",
+                version.cur_version);
+        fprintf(stderr, "requires minimum version %d\n", hax_min_version);
+        return 0;
+    }
+    if (hax_cur_version < version.compat_version) {
+        fprintf(stderr, "Incompatible QEMU HAX API version %x,",
+                hax_cur_version);
+        fprintf(stderr, "requires minimum HAX API version %x\n",
+                version.compat_version);
+        return 0;
+    }
+
+    return 1;
+}
+
+int hax_vcpu_create(int id)
+{
+    struct hax_vcpu_state *vcpu = NULL;
+    int ret;
+
+    if (!hax_global.vm) {
+        fprintf(stderr, "vcpu %x created failed, vm is null\n", id);
+        return -1;
+    }
+
+    if (hax_global.vm->vcpus[id]) {
+        fprintf(stderr, "vcpu %x allocated already\n", id);
+        return 0;
+    }
+
+    vcpu = g_malloc(sizeof(struct hax_vcpu_state));
+    if (!vcpu) {
+        fprintf(stderr, "Failed to alloc vcpu state\n");
+        return -ENOMEM;
+    }
+
+    memset(vcpu, 0, sizeof(struct hax_vcpu_state));
+
+    ret = hax_host_create_vcpu(hax_global.vm->fd, id);
+    if (ret) {
+        fprintf(stderr, "Failed to create vcpu %x\n", id);
+        goto error;
+    }
+
+    vcpu->vcpu_id = id;
+    vcpu->fd = hax_host_open_vcpu(hax_global.vm->id, id);
+    if (hax_invalid_fd(vcpu->fd)) {
+        fprintf(stderr, "Failed to open the vcpu\n");
+        ret = -ENODEV;
+        goto error;
+    }
+
+    hax_global.vm->vcpus[id] = vcpu;
+
+    ret = hax_host_setup_vcpu_channel(vcpu);
+    if (ret) {
+        fprintf(stderr, "Invalid hax tunnel size\n");
+        ret = -EINVAL;
+        goto error;
+    }
+    return 0;
+
+  error:
+    /* vcpu and tunnel will be closed automatically */
+    if (vcpu && !hax_invalid_fd(vcpu->fd)) {
+        hax_close_fd(vcpu->fd);
+    }
+
+    hax_global.vm->vcpus[id] = NULL;
+    g_free(vcpu);
+    return -1;
+}
+
+int hax_vcpu_destroy(CPUState *cpu)
+{
+    struct hax_vcpu_state *vcpu = cpu->hax_vcpu;
+
+    if (!hax_global.vm) {
+        fprintf(stderr, "vcpu %x destroy failed, vm is null\n", vcpu->vcpu_id);
+        return -1;
+    }
+
+    if (!vcpu) {
+        return 0;
+    }
+
+    /*
+     * 1. The hax_tunnel is also destroied when vcpu destroy
+     * 2. close fd will cause hax module vcpu be cleaned
+     */
+    hax_close_fd(vcpu->fd);
+    hax_global.vm->vcpus[vcpu->vcpu_id] = NULL;
+    g_free(vcpu);
+    return 0;
+}
+
+int hax_init_vcpu(CPUState *cpu)
+{
+    int ret;
+
+    ret = hax_vcpu_create(cpu->cpu_index);
+    if (ret < 0) {
+        fprintf(stderr, "Failed to create HAX vcpu\n");
+        exit(-1);
+    }
+
+    cpu->hax_vcpu = hax_global.vm->vcpus[cpu->cpu_index];
+    cpu->hax_vcpu_dirty = true;
+    qemu_register_reset(hax_reset_vcpu_state, (CPUArchState *) (cpu->env_ptr));
+
+    return ret;
+}
+
+struct hax_vm *hax_vm_create(struct hax_state *hax)
+{
+    struct hax_vm *vm;
+    int vm_id = 0, ret;
+
+    if (hax_invalid_fd(hax->fd)) {
+        return NULL;
+    }
+
+    if (hax->vm) {
+        return hax->vm;
+    }
+
+    vm = g_malloc(sizeof(struct hax_vm));
+    if (!vm) {
+        return NULL;
+    }
+    memset(vm, 0, sizeof(struct hax_vm));
+    ret = hax_host_create_vm(hax, &vm_id);
+    if (ret) {
+        fprintf(stderr, "Failed to create vm %x\n", ret);
+        goto error;
+    }
+    vm->id = vm_id;
+    vm->fd = hax_host_open_vm(hax, vm_id);
+    if (hax_invalid_fd(vm->fd)) {
+        fprintf(stderr, "Failed to open vm %d\n", vm_id);
+        goto error;
+    }
+
+    hax->vm = vm;
+    return vm;
+
+  error:
+    g_free(vm);
+    hax->vm = NULL;
+    return NULL;
+}
+
+int hax_vm_destroy(struct hax_vm *vm)
+{
+    int i;
+
+    for (i = 0; i < HAX_MAX_VCPU; i++)
+        if (vm->vcpus[i]) {
+            fprintf(stderr, "VCPU should be cleaned before vm clean\n");
+            return -1;
+        }
+    hax_close_fd(vm->fd);
+    g_free(vm);
+    hax_global.vm = NULL;
+    return 0;
+}
+
+static void hax_handle_interrupt(CPUState *cpu, int mask)
+{
+    cpu->interrupt_request |= mask;
+
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    }
+}
+
+static int hax_init(ram_addr_t ram_size)
+{
+    struct hax_state *hax = NULL;
+    struct hax_qemu_version qversion;
+    int ret;
+
+    hax = &hax_global;
+
+    memset(hax, 0, sizeof(struct hax_state));
+    hax->mem_quota = ram_size;
+
+    hax->fd = hax_mod_open();
+    if (hax_invalid_fd(hax->fd)) {
+        hax->fd = 0;
+        ret = -ENODEV;
+        goto error;
+    }
+
+    ret = hax_get_capability(hax);
+
+    if (ret) {
+        if (ret != -ENOSPC) {
+            ret = -EINVAL;
+        }
+        goto error;
+    }
+
+    if (!hax_version_support(hax)) {
+        ret = -EINVAL;
+        goto error;
+    }
+
+    hax->vm = hax_vm_create(hax);
+    if (!hax->vm) {
+        fprintf(stderr, "Failed to create HAX VM\n");
+        ret = -EINVAL;
+        goto error;
+    }
+
+    hax_memory_init();
+
+    qversion.cur_version = hax_cur_version;
+    qversion.min_version = hax_min_version;
+    hax_notify_qemu_version(hax->vm->fd, &qversion);
+    cpu_interrupt_handler = hax_handle_interrupt;
+
+    return ret;
+  error:
+    if (hax->vm) {
+        hax_vm_destroy(hax->vm);
+    }
+    if (hax->fd) {
+        hax_mod_close(hax);
+    }
+
+    return ret;
+}
+
+static int hax_accel_init(MachineState *ms)
+{
+    int ret = hax_init(ms->ram_size);
+
+    if (ret && (ret != -ENOSPC)) {
+        fprintf(stderr, "No accelerator found.\n");
+    } else {
+        fprintf(stdout, "HAX is %s and emulator runs in %s mode.\n",
+                !ret ? "working" : "not working",
+                !ret ? "fast virt" : "emulation");
+    }
+    return ret;
+}
+
+static int hax_handle_fastmmio(CPUArchState *env, struct hax_fastmmio *hft)
+{
+    if (hft->direction < 2) {
+        cpu_physical_memory_rw(hft->gpa, (uint8_t *) &hft->value, hft->size,
+                               hft->direction);
+    } else {
+        /*
+         * HAX API v4 supports transferring data between two MMIO addresses,
+         * hft->gpa and hft->gpa2 (instructions such as MOVS require this):
+         *  hft->direction == 2: gpa ==> gpa2
+         */
+        uint64_t value;
+        cpu_physical_memory_rw(hft->gpa, (uint8_t *) &value, hft->size, 0);
+        cpu_physical_memory_rw(hft->gpa2, (uint8_t *) &value, hft->size, 1);
+    }
+
+    return 0;
+}
+
+static int hax_handle_io(CPUArchState *env, uint32_t df, uint16_t port,
+                         int direction, int size, int count, void *buffer)
+{
+    uint8_t *ptr;
+    int i;
+    MemTxAttrs attrs = { 0 };
+
+    if (!df) {
+        ptr = (uint8_t *) buffer;
+    } else {
+        ptr = buffer + size * count - size;
+    }
+    for (i = 0; i < count; i++) {
+        address_space_rw(&address_space_io, port, attrs,
+                         ptr, size, direction == HAX_EXIT_IO_OUT);
+        if (!df) {
+            ptr += size;
+        } else {
+            ptr -= size;
+        }
+    }
+
+    return 0;
+}
+
+static int hax_vcpu_interrupt(CPUArchState *env)
+{
+    CPUState *cpu = ENV_GET_CPU(env);
+    struct hax_vcpu_state *vcpu = cpu->hax_vcpu;
+    struct hax_tunnel *ht = vcpu->tunnel;
+
+    /*
+     * Try to inject an interrupt if the guest can accept it
+     * Unlike KVM, HAX kernel check for the eflags, instead of qemu
+     */
+    if (ht->ready_for_interrupt_injection &&
+        (cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        int irq;
+
+        irq = cpu_get_pic_interrupt(env);
+        if (irq >= 0) {
+            hax_inject_interrupt(env, irq);
+            cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
+        }
+    }
+
+    /* If we have an interrupt but the guest is not ready to receive an
+     * interrupt, request an interrupt window exit.  This will
+     * cause a return to userspace as soon as the guest is ready to
+     * receive interrupts. */
+    if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        ht->request_interrupt_window = 1;
+    } else {
+        ht->request_interrupt_window = 0;
+    }
+    return 0;
+}
+
+void hax_raise_event(CPUState *cpu)
+{
+    struct hax_vcpu_state *vcpu = cpu->hax_vcpu;
+
+    if (!vcpu) {
+        return;
+    }
+    vcpu->tunnel->user_event_pending = 1;
+}
+
+/*
+ * Ask hax kernel module to run the CPU for us till:
+ * 1. Guest crash or shutdown
+ * 2. Need QEMU's emulation like guest execute MMIO instruction
+ * 3. Guest execute HLT
+ * 4. QEMU have Signal/event pending
+ * 5. An unknown VMX exit happens
+ */
+static int hax_vcpu_hax_exec(CPUArchState *env)
+{
+    int ret = 0;
+    CPUState *cpu = ENV_GET_CPU(env);
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    struct hax_vcpu_state *vcpu = cpu->hax_vcpu;
+    struct hax_tunnel *ht = vcpu->tunnel;
+
+    if (!hax_enabled()) {
+        DPRINTF("Trying to vcpu execute at eip:" TARGET_FMT_lx "\n", env->eip);
+        return 0;
+    }
+
+    cpu->halted = 0;
+
+    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+        cpu->interrupt_request &= ~CPU_INTERRUPT_POLL;
+        apic_poll_irq(x86_cpu->apic_state);
+    }
+
+    if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
+        DPRINTF("\nhax_vcpu_hax_exec: handling INIT for %d\n",
+                cpu->cpu_index);
+        do_cpu_init(x86_cpu);
+        hax_vcpu_sync_state(env, 1);
+    }
+
+    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+        DPRINTF("hax_vcpu_hax_exec: handling SIPI for %d\n",
+                cpu->cpu_index);
+        hax_vcpu_sync_state(env, 0);
+        do_cpu_sipi(x86_cpu);
+        hax_vcpu_sync_state(env, 1);
+    }
+
+    do {
+        int hax_ret;
+
+        if (cpu->exit_request) {
+            ret = 1;
+            break;
+        }
+
+        hax_vcpu_interrupt(env);
+
+        qemu_mutex_unlock_iothread();
+        hax_ret = hax_vcpu_run(vcpu);
+        qemu_mutex_lock_iothread();
+        current_cpu = cpu;
+
+        /* Simply continue the vcpu_run if system call interrupted */
+        if (hax_ret == -EINTR || hax_ret == -EAGAIN) {
+            DPRINTF("io window interrupted\n");
+            continue;
+        }
+
+        if (hax_ret < 0) {
+            fprintf(stderr, "vcpu run failed for vcpu  %x\n", vcpu->vcpu_id);
+            abort();
+        }
+        switch (ht->_exit_status) {
+        case HAX_EXIT_IO:
+            ret = hax_handle_io(env, ht->pio._df, ht->pio._port,
+                            ht->pio._direction,
+                            ht->pio._size, ht->pio._count, vcpu->iobuf);
+            break;
+        case HAX_EXIT_FAST_MMIO:
+            ret = hax_handle_fastmmio(env, (struct hax_fastmmio *) vcpu->iobuf);
+            break;
+        /* Guest state changed, currently only for shutdown */
+        case HAX_EXIT_STATECHANGE:
+            fprintf(stdout, "VCPU shutdown request\n");
+            qemu_system_shutdown_request();
+            hax_vcpu_sync_state(env, 0);
+            ret = 1;
+            break;
+        case HAX_EXIT_UNKNOWN_VMEXIT:
+            fprintf(stderr, "Unknown VMX exit %x from guest\n",
+                    ht->_exit_reason);
+            qemu_system_reset_request();
+            hax_vcpu_sync_state(env, 0);
+            cpu_dump_state(cpu, stderr, fprintf, 0);
+            ret = -1;
+            break;
+        case HAX_EXIT_HLT:
+            if (!(cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+                !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+                /* hlt instruction with interrupt disabled is shutdown */
+                env->eflags |= IF_MASK;
+                cpu->halted = 1;
+                cpu->exception_index = EXCP_HLT;
+                ret = 1;
+            }
+            break;
+        /* these situations will continue to hax module */
+        case HAX_EXIT_INTERRUPT:
+        case HAX_EXIT_PAUSED:
+            break;
+        case HAX_EXIT_MMIO:
+            /* Should not happen on UG system */
+            fprintf(stderr, "HAX: unsupported MMIO emulation\n");
+            ret = -1;
+            break;
+        case HAX_EXIT_REAL:
+            /* Should not happen on UG system */
+            fprintf(stderr, "HAX: unimplemented real mode emulation\n");
+            ret = -1;
+            break;
+        default:
+            fprintf(stderr, "Unknown exit %x from HAX\n", ht->_exit_status);
+            qemu_system_reset_request();
+            hax_vcpu_sync_state(env, 0);
+            cpu_dump_state(cpu, stderr, fprintf, 0);
+            ret = 1;
+            break;
+        }
+    } while (!ret);
+
+    if (cpu->exit_request) {
+        cpu->exit_request = 0;
+        cpu->exception_index = EXCP_INTERRUPT;
+    }
+    return ret < 0;
+}
+
+static void do_hax_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
+{
+    CPUArchState *env = cpu->env_ptr;
+
+    hax_arch_get_registers(env);
+    cpu->hax_vcpu_dirty = true;
+}
+
+void hax_cpu_synchronize_state(CPUState *cpu)
+{
+    if (!cpu->hax_vcpu_dirty) {
+        run_on_cpu(cpu, do_hax_cpu_synchronize_state, RUN_ON_CPU_NULL);
+    }
+}
+
+static void do_hax_cpu_synchronize_post_reset(CPUState *cpu,
+                                              run_on_cpu_data arg)
+{
+    CPUArchState *env = cpu->env_ptr;
+
+    hax_vcpu_sync_state(env, 1);
+    cpu->hax_vcpu_dirty = false;
+}
+
+void hax_cpu_synchronize_post_reset(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_hax_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
+}
+
+static void do_hax_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
+{
+    CPUArchState *env = cpu->env_ptr;
+
+    hax_vcpu_sync_state(env, 1);
+    cpu->hax_vcpu_dirty = false;
+}
+
+void hax_cpu_synchronize_post_init(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_hax_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
+}
+
+int hax_smp_cpu_exec(CPUState *cpu)
+{
+    CPUArchState *env = (CPUArchState *) (cpu->env_ptr);
+    int fatal;
+    int ret;
+
+    while (1) {
+        if (cpu->exception_index >= EXCP_INTERRUPT) {
+            ret = cpu->exception_index;
+            cpu->exception_index = -1;
+            break;
+        }
+
+        fatal = hax_vcpu_hax_exec(env);
+
+        if (fatal) {
+            fprintf(stderr, "Unsupported HAX vcpu return\n");
+            abort();
+        }
+    }
+
+    return ret;
+}
+
+static void set_v8086_seg(struct segment_desc_t *lhs, const SegmentCache *rhs)
+{
+    memset(lhs, 0, sizeof(struct segment_desc_t));
+    lhs->selector = rhs->selector;
+    lhs->base = rhs->base;
+    lhs->limit = rhs->limit;
+    lhs->type = 3;
+    lhs->present = 1;
+    lhs->dpl = 3;
+    lhs->operand_size = 0;
+    lhs->desc = 1;
+    lhs->long_mode = 0;
+    lhs->granularity = 0;
+    lhs->available = 0;
+}
+
+static void get_seg(SegmentCache *lhs, const struct segment_desc_t *rhs)
+{
+    lhs->selector = rhs->selector;
+    lhs->base = rhs->base;
+    lhs->limit = rhs->limit;
+    lhs->flags = (rhs->type << DESC_TYPE_SHIFT)
+        | (rhs->present * DESC_P_MASK)
+        | (rhs->dpl << DESC_DPL_SHIFT)
+        | (rhs->operand_size << DESC_B_SHIFT)
+        | (rhs->desc * DESC_S_MASK)
+        | (rhs->long_mode << DESC_L_SHIFT)
+        | (rhs->granularity * DESC_G_MASK) | (rhs->available * DESC_AVL_MASK);
+}
+
+static void set_seg(struct segment_desc_t *lhs, const SegmentCache *rhs)
+{
+    unsigned flags = rhs->flags;
+
+    memset(lhs, 0, sizeof(struct segment_desc_t));
+    lhs->selector = rhs->selector;
+    lhs->base = rhs->base;
+    lhs->limit = rhs->limit;
+    lhs->type = (flags >> DESC_TYPE_SHIFT) & 15;
+    lhs->present = (flags & DESC_P_MASK) != 0;
+    lhs->dpl = rhs->selector & 3;
+    lhs->operand_size = (flags >> DESC_B_SHIFT) & 1;
+    lhs->desc = (flags & DESC_S_MASK) != 0;
+    lhs->long_mode = (flags >> DESC_L_SHIFT) & 1;
+    lhs->granularity = (flags & DESC_G_MASK) != 0;
+    lhs->available = (flags & DESC_AVL_MASK) != 0;
+}
+
+static void hax_getput_reg(uint64_t *hax_reg, target_ulong *qemu_reg, int set)
+{
+    target_ulong reg = *hax_reg;
+
+    if (set) {
+        *hax_reg = *qemu_reg;
+    } else {
+        *qemu_reg = reg;
+    }
+}
+
+/* The sregs has been synced with HAX kernel already before this call */
+static int hax_get_segments(CPUArchState *env, struct vcpu_state_t *sregs)
+{
+    get_seg(&env->segs[R_CS], &sregs->_cs);
+    get_seg(&env->segs[R_DS], &sregs->_ds);
+    get_seg(&env->segs[R_ES], &sregs->_es);
+    get_seg(&env->segs[R_FS], &sregs->_fs);
+    get_seg(&env->segs[R_GS], &sregs->_gs);
+    get_seg(&env->segs[R_SS], &sregs->_ss);
+
+    get_seg(&env->tr, &sregs->_tr);
+    get_seg(&env->ldt, &sregs->_ldt);
+    env->idt.limit = sregs->_idt.limit;
+    env->idt.base = sregs->_idt.base;
+    env->gdt.limit = sregs->_gdt.limit;
+    env->gdt.base = sregs->_gdt.base;
+    return 0;
+}
+
+static int hax_set_segments(CPUArchState *env, struct vcpu_state_t *sregs)
+{
+    if ((env->eflags & VM_MASK)) {
+        set_v8086_seg(&sregs->_cs, &env->segs[R_CS]);
+        set_v8086_seg(&sregs->_ds, &env->segs[R_DS]);
+        set_v8086_seg(&sregs->_es, &env->segs[R_ES]);
+        set_v8086_seg(&sregs->_fs, &env->segs[R_FS]);
+        set_v8086_seg(&sregs->_gs, &env->segs[R_GS]);
+        set_v8086_seg(&sregs->_ss, &env->segs[R_SS]);
+    } else {
+        set_seg(&sregs->_cs, &env->segs[R_CS]);
+        set_seg(&sregs->_ds, &env->segs[R_DS]);
+        set_seg(&sregs->_es, &env->segs[R_ES]);
+        set_seg(&sregs->_fs, &env->segs[R_FS]);
+        set_seg(&sregs->_gs, &env->segs[R_GS]);
+        set_seg(&sregs->_ss, &env->segs[R_SS]);
+
+        if (env->cr[0] & CR0_PE_MASK) {
+            /* force ss cpl to cs cpl */
+            sregs->_ss.selector = (sregs->_ss.selector & ~3) |
+                                  (sregs->_cs.selector & 3);
+            sregs->_ss.dpl = sregs->_ss.selector & 3;
+        }
+    }
+
+    set_seg(&sregs->_tr, &env->tr);
+    set_seg(&sregs->_ldt, &env->ldt);
+    sregs->_idt.limit = env->idt.limit;
+    sregs->_idt.base = env->idt.base;
+    sregs->_gdt.limit = env->gdt.limit;
+    sregs->_gdt.base = env->gdt.base;
+    return 0;
+}
+
+/*
+ * After get the state from the kernel module, some
+ * qemu emulator state need be updated also
+ */
+static int hax_setup_qemu_emulator(CPUArchState *env)
+{
+
+#define HFLAG_COPY_MASK (~( \
+  HF_CPL_MASK | HF_PE_MASK | HF_MP_MASK | HF_EM_MASK | \
+  HF_TS_MASK | HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK | \
+  HF_OSFXSR_MASK | HF_LMA_MASK | HF_CS32_MASK | \
+  HF_SS32_MASK | HF_CS64_MASK | HF_ADDSEG_MASK))
+
+    uint32_t hflags;
+
+    hflags = (env->segs[R_CS].flags >> DESC_DPL_SHIFT) & HF_CPL_MASK;
+    hflags |= (env->cr[0] & CR0_PE_MASK) << (HF_PE_SHIFT - CR0_PE_SHIFT);
+    hflags |= (env->cr[0] << (HF_MP_SHIFT - CR0_MP_SHIFT)) &
+        (HF_MP_MASK | HF_EM_MASK | HF_TS_MASK);
+    hflags |= (env->eflags & (HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK));
+    hflags |= (env->cr[4] & CR4_OSFXSR_MASK) <<
+              (HF_OSFXSR_SHIFT - CR4_OSFXSR_SHIFT);
+
+    if (env->efer & MSR_EFER_LMA) {
+        hflags |= HF_LMA_MASK;
+    }
+
+    if ((hflags & HF_LMA_MASK) && (env->segs[R_CS].flags & DESC_L_MASK)) {
+        hflags |= HF_CS32_MASK | HF_SS32_MASK | HF_CS64_MASK;
+    } else {
+        hflags |= (env->segs[R_CS].flags & DESC_B_MASK) >>
+            (DESC_B_SHIFT - HF_CS32_SHIFT);
+        hflags |= (env->segs[R_SS].flags & DESC_B_MASK) >>
+            (DESC_B_SHIFT - HF_SS32_SHIFT);
+        if (!(env->cr[0] & CR0_PE_MASK) ||
+            (env->eflags & VM_MASK) || !(hflags & HF_CS32_MASK)) {
+            hflags |= HF_ADDSEG_MASK;
+        } else {
+            hflags |= ((env->segs[R_DS].base |
+                        env->segs[R_ES].base |
+                        env->segs[R_SS].base) != 0) << HF_ADDSEG_SHIFT;
+        }
+    }
+
+    hflags &= ~HF_SMM_MASK;
+
+    env->hflags = (env->hflags & HFLAG_COPY_MASK) | hflags;
+    return 0;
+}
+
+static int hax_sync_vcpu_register(CPUArchState *env, int set)
+{
+    struct vcpu_state_t regs;
+    int ret;
+    memset(&regs, 0, sizeof(struct vcpu_state_t));
+
+    if (!set) {
+        ret = hax_sync_vcpu_state(env, &regs, 0);
+        if (ret < 0) {
+            return -1;
+        }
+    }
+
+    /* generic register */
+    hax_getput_reg(&regs._rax, &env->regs[R_EAX], set);
+    hax_getput_reg(&regs._rbx, &env->regs[R_EBX], set);
+    hax_getput_reg(&regs._rcx, &env->regs[R_ECX], set);
+    hax_getput_reg(&regs._rdx, &env->regs[R_EDX], set);
+    hax_getput_reg(&regs._rsi, &env->regs[R_ESI], set);
+    hax_getput_reg(&regs._rdi, &env->regs[R_EDI], set);
+    hax_getput_reg(&regs._rsp, &env->regs[R_ESP], set);
+    hax_getput_reg(&regs._rbp, &env->regs[R_EBP], set);
+#ifdef TARGET_X86_64
+    hax_getput_reg(&regs._r8, &env->regs[8], set);
+    hax_getput_reg(&regs._r9, &env->regs[9], set);
+    hax_getput_reg(&regs._r10, &env->regs[10], set);
+    hax_getput_reg(&regs._r11, &env->regs[11], set);
+    hax_getput_reg(&regs._r12, &env->regs[12], set);
+    hax_getput_reg(&regs._r13, &env->regs[13], set);
+    hax_getput_reg(&regs._r14, &env->regs[14], set);
+    hax_getput_reg(&regs._r15, &env->regs[15], set);
+#endif
+    hax_getput_reg(&regs._rflags, &env->eflags, set);
+    hax_getput_reg(&regs._rip, &env->eip, set);
+
+    if (set) {
+        regs._cr0 = env->cr[0];
+        regs._cr2 = env->cr[2];
+        regs._cr3 = env->cr[3];
+        regs._cr4 = env->cr[4];
+        hax_set_segments(env, &regs);
+    } else {
+        env->cr[0] = regs._cr0;
+        env->cr[2] = regs._cr2;
+        env->cr[3] = regs._cr3;
+        env->cr[4] = regs._cr4;
+        hax_get_segments(env, &regs);
+    }
+
+    if (set) {
+        ret = hax_sync_vcpu_state(env, &regs, 1);
+        if (ret < 0) {
+            return -1;
+        }
+    }
+    if (!set) {
+        hax_setup_qemu_emulator(env);
+    }
+    return 0;
+}
+
+static void hax_msr_entry_set(struct vmx_msr *item, uint32_t index,
+                              uint64_t value)
+{
+    item->entry = index;
+    item->value = value;
+}
+
+static int hax_get_msrs(CPUArchState *env)
+{
+    struct hax_msr_data md;
+    struct vmx_msr *msrs = md.entries;
+    int ret, i, n;
+
+    n = 0;
+    msrs[n++].entry = MSR_IA32_SYSENTER_CS;
+    msrs[n++].entry = MSR_IA32_SYSENTER_ESP;
+    msrs[n++].entry = MSR_IA32_SYSENTER_EIP;
+    msrs[n++].entry = MSR_IA32_TSC;
+#ifdef TARGET_X86_64
+    msrs[n++].entry = MSR_EFER;
+    msrs[n++].entry = MSR_STAR;
+    msrs[n++].entry = MSR_LSTAR;
+    msrs[n++].entry = MSR_CSTAR;
+    msrs[n++].entry = MSR_FMASK;
+    msrs[n++].entry = MSR_KERNELGSBASE;
+#endif
+    md.nr_msr = n;
+    ret = hax_sync_msr(env, &md, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    for (i = 0; i < md.done; i++) {
+        switch (msrs[i].entry) {
+        case MSR_IA32_SYSENTER_CS:
+            env->sysenter_cs = msrs[i].value;
+            break;
+        case MSR_IA32_SYSENTER_ESP:
+            env->sysenter_esp = msrs[i].value;
+            break;
+        case MSR_IA32_SYSENTER_EIP:
+            env->sysenter_eip = msrs[i].value;
+            break;
+        case MSR_IA32_TSC:
+            env->tsc = msrs[i].value;
+            break;
+#ifdef TARGET_X86_64
+        case MSR_EFER:
+            env->efer = msrs[i].value;
+            break;
+        case MSR_STAR:
+            env->star = msrs[i].value;
+            break;
+        case MSR_LSTAR:
+            env->lstar = msrs[i].value;
+            break;
+        case MSR_CSTAR:
+            env->cstar = msrs[i].value;
+            break;
+        case MSR_FMASK:
+            env->fmask = msrs[i].value;
+            break;
+        case MSR_KERNELGSBASE:
+            env->kernelgsbase = msrs[i].value;
+            break;
+#endif
+        }
+    }
+
+    return 0;
+}
+
+static int hax_set_msrs(CPUArchState *env)
+{
+    struct hax_msr_data md;
+    struct vmx_msr *msrs;
+    msrs = md.entries;
+    int n = 0;
+
+    memset(&md, 0, sizeof(struct hax_msr_data));
+    hax_msr_entry_set(&msrs[n++], MSR_IA32_SYSENTER_CS, env->sysenter_cs);
+    hax_msr_entry_set(&msrs[n++], MSR_IA32_SYSENTER_ESP, env->sysenter_esp);
+    hax_msr_entry_set(&msrs[n++], MSR_IA32_SYSENTER_EIP, env->sysenter_eip);
+    hax_msr_entry_set(&msrs[n++], MSR_IA32_TSC, env->tsc);
+#ifdef TARGET_X86_64
+    hax_msr_entry_set(&msrs[n++], MSR_EFER, env->efer);
+    hax_msr_entry_set(&msrs[n++], MSR_STAR, env->star);
+    hax_msr_entry_set(&msrs[n++], MSR_LSTAR, env->lstar);
+    hax_msr_entry_set(&msrs[n++], MSR_CSTAR, env->cstar);
+    hax_msr_entry_set(&msrs[n++], MSR_FMASK, env->fmask);
+    hax_msr_entry_set(&msrs[n++], MSR_KERNELGSBASE, env->kernelgsbase);
+#endif
+    md.nr_msr = n;
+    md.done = 0;
+
+    return hax_sync_msr(env, &md, 1);
+}
+
+static int hax_get_fpu(CPUArchState *env)
+{
+    struct fx_layout fpu;
+    int i, ret;
+
+    ret = hax_sync_fpu(env, &fpu, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    env->fpstt = (fpu.fsw >> 11) & 7;
+    env->fpus = fpu.fsw;
+    env->fpuc = fpu.fcw;
+    for (i = 0; i < 8; ++i) {
+        env->fptags[i] = !((fpu.ftw >> i) & 1);
+    }
+    memcpy(env->fpregs, fpu.st_mm, sizeof(env->fpregs));
+
+    for (i = 0; i < 8; i++) {
+        env->xmm_regs[i].ZMM_Q(0) = ldq_p(&fpu.mmx_1[i][0]);
+        env->xmm_regs[i].ZMM_Q(1) = ldq_p(&fpu.mmx_1[i][8]);
+        if (CPU_NB_REGS > 8) {
+            env->xmm_regs[i + 8].ZMM_Q(0) = ldq_p(&fpu.mmx_2[i][0]);
+            env->xmm_regs[i + 8].ZMM_Q(1) = ldq_p(&fpu.mmx_2[i][8]);
+        }
+    }
+    env->mxcsr = fpu.mxcsr;
+
+    return 0;
+}
+
+static int hax_set_fpu(CPUArchState *env)
+{
+    struct fx_layout fpu;
+    int i;
+
+    memset(&fpu, 0, sizeof(fpu));
+    fpu.fsw = env->fpus & ~(7 << 11);
+    fpu.fsw |= (env->fpstt & 7) << 11;
+    fpu.fcw = env->fpuc;
+
+    for (i = 0; i < 8; ++i) {
+        fpu.ftw |= (!env->fptags[i]) << i;
+    }
+
+    memcpy(fpu.st_mm, env->fpregs, sizeof(env->fpregs));
+    for (i = 0; i < 8; i++) {
+        stq_p(&fpu.mmx_1[i][0], env->xmm_regs[i].ZMM_Q(0));
+        stq_p(&fpu.mmx_1[i][8], env->xmm_regs[i].ZMM_Q(1));
+        if (CPU_NB_REGS > 8) {
+            stq_p(&fpu.mmx_2[i][0], env->xmm_regs[i + 8].ZMM_Q(0));
+            stq_p(&fpu.mmx_2[i][8], env->xmm_regs[i + 8].ZMM_Q(1));
+        }
+    }
+
+    fpu.mxcsr = env->mxcsr;
+
+    return hax_sync_fpu(env, &fpu, 1);
+}
+
+static int hax_arch_get_registers(CPUArchState *env)
+{
+    int ret;
+
+    ret = hax_sync_vcpu_register(env, 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = hax_get_fpu(env);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = hax_get_msrs(env);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
+static int hax_arch_set_registers(CPUArchState *env)
+{
+    int ret;
+    ret = hax_sync_vcpu_register(env, 1);
+
+    if (ret < 0) {
+        fprintf(stderr, "Failed to sync vcpu reg\n");
+        return ret;
+    }
+    ret = hax_set_fpu(env);
+    if (ret < 0) {
+        fprintf(stderr, "FPU failed\n");
+        return ret;
+    }
+    ret = hax_set_msrs(env);
+    if (ret < 0) {
+        fprintf(stderr, "MSR failed\n");
+        return ret;
+    }
+
+    return 0;
+}
+
+static void hax_vcpu_sync_state(CPUArchState *env, int modified)
+{
+    if (hax_enabled()) {
+        if (modified) {
+            hax_arch_set_registers(env);
+        } else {
+            hax_arch_get_registers(env);
+        }
+    }
+}
+
+/*
+ * much simpler than kvm, at least in first stage because:
+ * We don't need consider the device pass-through, we don't need
+ * consider the framebuffer, and we may even remove the bios at all
+ */
+int hax_sync_vcpus(void)
+{
+    if (hax_enabled()) {
+        CPUState *cpu;
+
+        cpu = first_cpu;
+        if (!cpu) {
+            return 0;
+        }
+
+        for (; cpu != NULL; cpu = CPU_NEXT(cpu)) {
+            int ret;
+
+            ret = hax_arch_set_registers(cpu->env_ptr);
+            if (ret < 0) {
+                return ret;
+            }
+        }
+    }
+
+    return 0;
+}
+
+void hax_reset_vcpu_state(void *opaque)
+{
+    CPUState *cpu;
+    for (cpu = first_cpu; cpu != NULL; cpu = CPU_NEXT(cpu)) {
+        cpu->hax_vcpu->tunnel->user_event_pending = 0;
+        cpu->hax_vcpu->tunnel->ready_for_interrupt_injection = 0;
+    }
+}
+
+static void hax_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+    ac->name = "HAX";
+    ac->init_machine = hax_accel_init;
+    ac->allowed = &hax_allowed;
+}
+
+static const TypeInfo hax_accel_type = {
+    .name = ACCEL_CLASS_NAME("hax"),
+    .parent = TYPE_ACCEL,
+    .class_init = hax_accel_class_init,
+};
+
+static void hax_type_init(void)
+{
+    type_register_static(&hax_accel_type);
+}
+
+type_init(hax_type_init);
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
new file mode 100644
index 0000000..bcbd105
--- /dev/null
+++ b/target/i386/hax-i386.h
@@ -0,0 +1,86 @@
+/*
+ * QEMU HAXM support
+ *
+ * Copyright (c) 2011 Intel Corporation
+ *  Written by:
+ *  Jiang Yunhong<yunhong.jiang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef _HAX_I386_H
+#define _HAX_I386_H
+
+#include "cpu.h"
+#include "sysemu/hax.h"
+
+#ifdef CONFIG_WIN32
+typedef HANDLE hax_fd;
+#endif
+
+extern struct hax_state hax_global;
+struct hax_vcpu_state {
+    hax_fd fd;
+    int vcpu_id;
+    struct hax_tunnel *tunnel;
+    unsigned char *iobuf;
+};
+
+struct hax_state {
+    hax_fd fd; /* the global hax device interface */
+    uint32_t version;
+    struct hax_vm *vm;
+    uint64_t mem_quota;
+};
+
+#define HAX_MAX_VCPU 0x10
+#define MAX_VM_ID 0x40
+#define MAX_VCPU_ID 0x40
+
+struct hax_vm {
+    hax_fd fd;
+    int id;
+    struct hax_vcpu_state *vcpus[HAX_MAX_VCPU];
+};
+
+#ifdef NEED_CPU_H
+/* Functions exported to host specific mode */
+hax_fd hax_vcpu_get_fd(CPUArchState *env);
+int valid_hax_tunnel_size(uint16_t size);
+
+/* Host specific functions */
+int hax_mod_version(struct hax_state *hax, struct hax_module_version *version);
+int hax_inject_interrupt(CPUArchState *env, int vector);
+struct hax_vm *hax_vm_create(struct hax_state *hax);
+int hax_vcpu_run(struct hax_vcpu_state *vcpu);
+int hax_vcpu_create(int id);
+int hax_sync_vcpu_state(CPUArchState *env, struct vcpu_state_t *state,
+                        int set);
+int hax_sync_msr(CPUArchState *env, struct hax_msr_data *msrs, int set);
+int hax_sync_fpu(CPUArchState *env, struct fx_layout *fl, int set);
+#endif
+
+int hax_vm_destroy(struct hax_vm *vm);
+int hax_capability(struct hax_state *hax, struct hax_capabilityinfo *cap);
+int hax_notify_qemu_version(hax_fd vm_fd, struct hax_qemu_version *qversion);
+int hax_set_ram(uint64_t start_pa, uint32_t size, uint64_t host_va, int flags);
+
+/* Common host function */
+int hax_host_create_vm(struct hax_state *hax, int *vm_id);
+hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id);
+int hax_host_create_vcpu(hax_fd vm_fd, int vcpuid);
+hax_fd hax_host_open_vcpu(int vmid, int vcpuid);
+int hax_host_setup_vcpu_channel(struct hax_vcpu_state *vcpu);
+hax_fd hax_mod_open(void);
+void hax_memory_init(void);
+
+
+#ifdef CONFIG_WIN32
+#include "target/i386/hax-windows.h"
+#endif
+
+#include "target/i386/hax-interface.h"
+
+#endif
diff --git a/target/i386/hax-interface.h b/target/i386/hax-interface.h
new file mode 100644
index 0000000..d141308
--- /dev/null
+++ b/target/i386/hax-interface.h
@@ -0,0 +1,361 @@
+/*
+ * QEMU HAXM support
+ *
+ * Copyright (c) 2011 Intel Corporation
+ *  Written by:
+ *  Jiang Yunhong<yunhong.jiang@intel.com>
+ *  Xin Xiaohui<xiaohui.xin@intel.com>
+ *  Zhang Xiantao<xiantao.zhang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+/* Interface with HAX kernel module */
+
+#ifndef _HAX_INTERFACE_H
+#define _HAX_INTERFACE_H
+
+/* fx_layout has 3 formats table 3-56, 512bytes */
+struct fx_layout {
+    uint16_t fcw;
+    uint16_t fsw;
+    uint8_t ftw;
+    uint8_t res1;
+    uint16_t fop;
+    union {
+        struct {
+            uint32_t fip;
+            uint16_t fcs;
+            uint16_t res2;
+        };
+        uint64_t fpu_ip;
+    };
+    union {
+        struct {
+            uint32_t fdp;
+            uint16_t fds;
+            uint16_t res3;
+        };
+        uint64_t fpu_dp;
+    };
+    uint32_t mxcsr;
+    uint32_t mxcsr_mask;
+    uint8_t st_mm[8][16];
+    uint8_t mmx_1[8][16];
+    uint8_t mmx_2[8][16];
+    uint8_t pad[96];
+} __attribute__ ((aligned(8)));
+
+struct vmx_msr {
+    uint64_t entry;
+    uint64_t value;
+} __attribute__ ((__packed__));
+
+/*
+ * Fixed array is not good, but it makes Mac support a bit easier by avoiding
+ * memory map or copyin staff.
+ */
+#define HAX_MAX_MSR_ARRAY 0x20
+struct hax_msr_data {
+    uint16_t nr_msr;
+    uint16_t done;
+    uint16_t pad[2];
+    struct vmx_msr entries[HAX_MAX_MSR_ARRAY];
+} __attribute__ ((__packed__));
+
+union interruptibility_state_t {
+    uint32_t raw;
+    struct {
+        uint32_t sti_blocking:1;
+        uint32_t movss_blocking:1;
+        uint32_t smi_blocking:1;
+        uint32_t nmi_blocking:1;
+        uint32_t reserved:28;
+    };
+    uint64_t pad;
+};
+
+typedef union interruptibility_state_t interruptibility_state_t;
+
+/* Segment descriptor */
+struct segment_desc_t {
+    uint16_t selector;
+    uint16_t _dummy;
+    uint32_t limit;
+    uint64_t base;
+    union {
+        struct {
+            uint32_t type:4;
+            uint32_t desc:1;
+            uint32_t dpl:2;
+            uint32_t present:1;
+            uint32_t:4;
+            uint32_t available:1;
+            uint32_t long_mode:1;
+            uint32_t operand_size:1;
+            uint32_t granularity:1;
+            uint32_t null:1;
+            uint32_t:15;
+        };
+        uint32_t ar;
+    };
+    uint32_t ipad;
+};
+
+typedef struct segment_desc_t segment_desc_t;
+
+struct vcpu_state_t {
+    union {
+        uint64_t _regs[16];
+        struct {
+            union {
+                struct {
+                    uint8_t _al, _ah;
+                };
+                uint16_t _ax;
+                uint32_t _eax;
+                uint64_t _rax;
+            };
+            union {
+                struct {
+                    uint8_t _cl, _ch;
+                };
+                uint16_t _cx;
+                uint32_t _ecx;
+                uint64_t _rcx;
+            };
+            union {
+                struct {
+                    uint8_t _dl, _dh;
+                };
+                uint16_t _dx;
+                uint32_t _edx;
+                uint64_t _rdx;
+            };
+            union {
+                struct {
+                    uint8_t _bl, _bh;
+                };
+                uint16_t _bx;
+                uint32_t _ebx;
+                uint64_t _rbx;
+            };
+            union {
+                uint16_t _sp;
+                uint32_t _esp;
+                uint64_t _rsp;
+            };
+            union {
+                uint16_t _bp;
+                uint32_t _ebp;
+                uint64_t _rbp;
+            };
+            union {
+                uint16_t _si;
+                uint32_t _esi;
+                uint64_t _rsi;
+            };
+            union {
+                uint16_t _di;
+                uint32_t _edi;
+                uint64_t _rdi;
+            };
+
+            uint64_t _r8;
+            uint64_t _r9;
+            uint64_t _r10;
+            uint64_t _r11;
+            uint64_t _r12;
+            uint64_t _r13;
+            uint64_t _r14;
+            uint64_t _r15;
+        };
+    };
+
+    union {
+        uint32_t _eip;
+        uint64_t _rip;
+    };
+
+    union {
+        uint32_t _eflags;
+        uint64_t _rflags;
+    };
+
+    segment_desc_t _cs;
+    segment_desc_t _ss;
+    segment_desc_t _ds;
+    segment_desc_t _es;
+    segment_desc_t _fs;
+    segment_desc_t _gs;
+    segment_desc_t _ldt;
+    segment_desc_t _tr;
+
+    segment_desc_t _gdt;
+    segment_desc_t _idt;
+
+    uint64_t _cr0;
+    uint64_t _cr2;
+    uint64_t _cr3;
+    uint64_t _cr4;
+
+    uint64_t _dr0;
+    uint64_t _dr1;
+    uint64_t _dr2;
+    uint64_t _dr3;
+    uint64_t _dr6;
+    uint64_t _dr7;
+    uint64_t _pde;
+
+    uint32_t _efer;
+
+    uint32_t _sysenter_cs;
+    uint64_t _sysenter_eip;
+    uint64_t _sysenter_esp;
+
+    uint32_t _activity_state;
+    uint32_t pad;
+    interruptibility_state_t _interruptibility_state;
+};
+
+/* HAX exit status */
+enum exit_status {
+    /* IO port request */
+    HAX_EXIT_IO = 1,
+    /* MMIO instruction emulation */
+    HAX_EXIT_MMIO,
+    /* QEMU emulation mode request, currently means guest enter non-PG mode */
+    HAX_EXIT_REAL,
+    /*
+     * Interrupt window open, qemu can inject interrupt now
+     * Also used when signal pending since at that time qemu usually need
+     * check interrupt
+     */
+    HAX_EXIT_INTERRUPT,
+    /* Unknown vmexit, mostly trigger reboot */
+    HAX_EXIT_UNKNOWN_VMEXIT,
+    /* HALT from guest */
+    HAX_EXIT_HLT,
+    /* Reboot request, like because of tripple fault in guest */
+    HAX_EXIT_STATECHANGE,
+    /* the vcpu is now only paused when destroy, so simply return to hax */
+    HAX_EXIT_PAUSED,
+    HAX_EXIT_FAST_MMIO,
+};
+
+/*
+ * The interface definition:
+ * 1. vcpu_run execute will return 0 on success, otherwise mean failed
+ * 2. exit_status return the exit reason, as stated in enum exit_status
+ * 3. exit_reason is the vmx exit reason
+ */
+struct hax_tunnel {
+    uint32_t _exit_reason;
+    uint32_t _exit_flag;
+    uint32_t _exit_status;
+    uint32_t user_event_pending;
+    int ready_for_interrupt_injection;
+    int request_interrupt_window;
+    union {
+        struct {
+            /* 0: read, 1: write */
+#define HAX_EXIT_IO_IN  1
+#define HAX_EXIT_IO_OUT 0
+            uint8_t _direction;
+            uint8_t _df;
+            uint16_t _size;
+            uint16_t _port;
+            uint16_t _count;
+            uint8_t _flags;
+            uint8_t _pad0;
+            uint16_t _pad1;
+            uint32_t _pad2;
+            uint64_t _vaddr;
+        } pio;
+        struct {
+            uint64_t gla;
+        } mmio;
+        struct {
+        } state;
+    };
+} __attribute__ ((__packed__));
+
+struct hax_module_version {
+    uint32_t compat_version;
+    uint32_t cur_version;
+} __attribute__ ((__packed__));
+
+/* This interface is support only after API version 2 */
+struct hax_qemu_version {
+    /* Current API version in QEMU */
+    uint32_t cur_version;
+    /* The minimum API version supported by QEMU */
+    uint32_t min_version;
+} __attribute__ ((__packed__));
+
+/* The mac specfic interface to qemu, mostly is ioctl related */
+struct hax_tunnel_info {
+    uint64_t va;
+    uint64_t io_va;
+    uint16_t size;
+    uint16_t pad[3];
+} __attribute__ ((__packed__));
+
+struct hax_alloc_ram_info {
+    uint32_t size;
+    uint32_t pad;
+    uint64_t va;
+} __attribute__ ((__packed__));
+#define HAX_RAM_INFO_ROM     0x01 /* Read-Only */
+#define HAX_RAM_INFO_INVALID 0x80 /* Unmapped, usually used for MMIO */
+struct hax_set_ram_info {
+    uint64_t pa_start;
+    uint32_t size;
+    uint8_t flags;
+    uint8_t pad[3];
+    uint64_t va;
+} __attribute__ ((__packed__));
+
+#define HAX_CAP_STATUS_WORKING     0x1
+#define HAX_CAP_STATUS_NOTWORKING  0x0
+#define HAX_CAP_WORKSTATUS_MASK    0x1
+
+#define HAX_CAP_FAILREASON_VT      0x1
+#define HAX_CAP_FAILREASON_NX      0x2
+
+#define HAX_CAP_MEMQUOTA           0x2
+#define HAX_CAP_UG                 0x4
+
+struct hax_capabilityinfo {
+    /* bit 0: 1 - working
+     *        0 - not working, possibly because NT/NX disabled
+     * bit 1: 1 - memory limitation working
+     *        0 - no memory limitation
+     */
+    uint16_t wstatus;
+    /* valid when not working
+     * bit 0: VT not enabeld
+     * bit 1: NX not enabled*/
+    uint16_t winfo;
+    uint32_t pad;
+    uint64_t mem_quota;
+} __attribute__ ((__packed__));
+
+struct hax_fastmmio {
+    uint64_t gpa;
+    union {
+        uint64_t value;
+        uint64_t gpa2;  /* since HAX API v4 */
+    };
+    uint8_t size;
+    uint8_t direction;
+    uint16_t reg_index;
+    uint32_t pad0;
+    uint64_t _cr0;
+    uint64_t _cr2;
+    uint64_t _cr3;
+    uint64_t _cr4;
+} __attribute__ ((__packed__));
+#endif
diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
new file mode 100644
index 0000000..2884040
--- /dev/null
+++ b/target/i386/hax-mem.c
@@ -0,0 +1,289 @@
+/*
+ * HAX memory mapping operations
+ *
+ * Copyright (c) 2015-16 Intel Corporation
+ * Copyright 2016 Google, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/address-spaces.h"
+#include "exec/exec-all.h"
+
+#include "target/i386/hax-i386.h"
+#include "qemu/queue.h"
+
+#define DEBUG_HAX_MEM 0
+
+#define DPRINTF(fmt, ...) \
+    do { \
+        if (DEBUG_HAX_MEM) { \
+            fprintf(stdout, fmt, ## __VA_ARGS__); \
+        } \
+    } while (0)
+
+/**
+ * HAXMapping: describes a pending guest physical memory mapping
+ *
+ * @start_pa: a guest physical address marking the start of the region; must be
+ *            page-aligned
+ * @size: a guest physical address marking the end of the region; must be
+ *          page-aligned
+ * @host_va: the host virtual address of the start of the mapping
+ * @flags: mapping parameters e.g. HAX_RAM_INFO_ROM or HAX_RAM_INFO_INVALID
+ * @entry: additional fields for linking #HAXMapping instances together
+ */
+typedef struct HAXMapping {
+    uint64_t start_pa;
+    uint32_t size;
+    uint64_t host_va;
+    int flags;
+    QTAILQ_ENTRY(HAXMapping) entry;
+} HAXMapping;
+
+/*
+ * A doubly-linked list (actually a tail queue) of the pending page mappings
+ * for the ongoing memory transaction.
+ *
+ * It is used to optimize the number of page mapping updates done through the
+ * kernel module. For example, it's effective when a driver is digging an MMIO
+ * hole inside an existing memory mapping. It will get a deletion of the whole
+ * region, then the addition of the 2 remaining RAM areas around the hole and
+ * finally the memory transaction commit. During the commit, it will effectively
+ * send to the kernel only the removal of the pages from the MMIO hole after
+ * having computed locally the result of the deletion and additions.
+ */
+static QTAILQ_HEAD(HAXMappingListHead, HAXMapping) mappings =
+    QTAILQ_HEAD_INITIALIZER(mappings);
+
+/**
+ * hax_mapping_dump_list: dumps @mappings to stdout (for debugging)
+ */
+static void hax_mapping_dump_list(void)
+{
+    HAXMapping *entry;
+
+    DPRINTF("%s updates:\n", __func__);
+    QTAILQ_FOREACH(entry, &mappings, entry) {
+        DPRINTF("\t%c 0x%016" PRIx64 "->0x%016" PRIx64 " VA 0x%016" PRIx64
+                "%s\n", entry->flags & HAX_RAM_INFO_INVALID ? '-' : '+',
+                entry->start_pa, entry->start_pa + entry->size, entry->host_va,
+                entry->flags & HAX_RAM_INFO_ROM ? " ROM" : "");
+    }
+}
+
+static void hax_insert_mapping_before(HAXMapping *next, uint64_t start_pa,
+                                      uint32_t size, uint64_t host_va,
+                                      uint8_t flags)
+{
+    HAXMapping *entry;
+
+    entry = g_malloc0(sizeof(*entry));
+    entry->start_pa = start_pa;
+    entry->size = size;
+    entry->host_va = host_va;
+    entry->flags = flags;
+    if (!next) {
+        QTAILQ_INSERT_TAIL(&mappings, entry, entry);
+    } else {
+        QTAILQ_INSERT_BEFORE(next, entry, entry);
+    }
+}
+
+static bool hax_mapping_is_opposite(HAXMapping *entry, uint64_t host_va,
+                                    uint8_t flags)
+{
+    /* removed then added without change for the read-only flag */
+    bool nop_flags = (entry->flags ^ flags) == HAX_RAM_INFO_INVALID;
+
+    return (entry->host_va == host_va) && nop_flags;
+}
+
+static void hax_update_mapping(uint64_t start_pa, uint32_t size,
+                               uint64_t host_va, uint8_t flags)
+{
+    uint64_t end_pa = start_pa + size;
+    uint32_t chunk_sz;
+    HAXMapping *entry, *next;
+
+    QTAILQ_FOREACH_SAFE(entry, &mappings, entry, next) {
+        if (start_pa >= entry->start_pa + entry->size) {
+            continue;
+        }
+        if (start_pa < entry->start_pa) {
+            chunk_sz = end_pa <= entry->start_pa ? size
+                                                 : entry->start_pa - start_pa;
+            hax_insert_mapping_before(entry, start_pa, chunk_sz,
+                                      host_va, flags);
+            start_pa += chunk_sz;
+            host_va += chunk_sz;
+            size -= chunk_sz;
+        }
+        chunk_sz = MIN(size, entry->size);
+        if (chunk_sz) {
+            bool nop = hax_mapping_is_opposite(entry, host_va, flags);
+            bool partial = chunk_sz < entry->size;
+            if (partial) {
+                /* remove the beginning of the existing chunk */
+                entry->start_pa += chunk_sz;
+                entry->host_va += chunk_sz;
+                entry->size -= chunk_sz;
+                if (!nop) {
+                    hax_insert_mapping_before(entry, start_pa, chunk_sz,
+                                              host_va, flags);
+                }
+            } else { /* affects the full mapping entry */
+                if (nop) { /* no change to this mapping, remove it */
+                    QTAILQ_REMOVE(&mappings, entry, entry);
+                    g_free(entry);
+                } else { /* update mapping properties */
+                    entry->host_va = host_va;
+                    entry->flags = flags;
+                }
+            }
+            start_pa += chunk_sz;
+            host_va += chunk_sz;
+            size -= chunk_sz;
+        }
+        if (!size) { /* we are done */
+            break;
+        }
+    }
+    if (size) { /* add the leftover */
+        hax_insert_mapping_before(NULL, start_pa, size, host_va, flags);
+    }
+}
+
+static void hax_process_section(MemoryRegionSection *section, uint8_t flags)
+{
+    MemoryRegion *mr = section->mr;
+    hwaddr start_pa = section->offset_within_address_space;
+    ram_addr_t size = int128_get64(section->size);
+    unsigned int delta;
+    uint64_t host_va;
+
+    /* We only care about RAM pages */
+    if (!memory_region_is_ram(mr)) {
+        return;
+    }
+
+    /* Adjust start_pa and size so that they are page-aligned. (Cf
+     * kvm_set_phys_mem() in kvm-all.c).
+     */
+    delta = qemu_real_host_page_size - (start_pa & ~qemu_real_host_page_mask);
+    delta &= ~qemu_real_host_page_mask;
+    if (delta > size) {
+        return;
+    }
+    start_pa += delta;
+    size -= delta;
+    size &= qemu_real_host_page_mask;
+    if (!size || (start_pa & ~qemu_real_host_page_mask)) {
+        return;
+    }
+
+    host_va = (uintptr_t)memory_region_get_ram_ptr(mr)
+            + section->offset_within_region + delta;
+    if (memory_region_is_rom(section->mr)) {
+        flags |= HAX_RAM_INFO_ROM;
+    }
+
+    /* the kernel module interface uses 32-bit sizes (but we could split...) */
+    g_assert(size <= UINT32_MAX);
+
+    hax_update_mapping(start_pa, size, host_va, flags);
+}
+
+static void hax_region_add(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    memory_region_ref(section->mr);
+    hax_process_section(section, 0);
+}
+
+static void hax_region_del(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    hax_process_section(section, HAX_RAM_INFO_INVALID);
+    memory_region_unref(section->mr);
+}
+
+static void hax_transaction_begin(MemoryListener *listener)
+{
+    g_assert(QTAILQ_EMPTY(&mappings));
+}
+
+static void hax_transaction_commit(MemoryListener *listener)
+{
+    if (!QTAILQ_EMPTY(&mappings)) {
+        HAXMapping *entry, *next;
+
+        if (DEBUG_HAX_MEM) {
+            hax_mapping_dump_list();
+        }
+        QTAILQ_FOREACH_SAFE(entry, &mappings, entry, next) {
+            if (entry->flags & HAX_RAM_INFO_INVALID) {
+                /* for unmapping, put the values expected by the kernel */
+                entry->flags = HAX_RAM_INFO_INVALID;
+                entry->host_va = 0;
+            }
+            if (hax_set_ram(entry->start_pa, entry->size,
+                            entry->host_va, entry->flags)) {
+                fprintf(stderr, "%s: Failed mapping @0x%016" PRIx64 "+0x%"
+                        PRIx32 " flags %02x\n", __func__, entry->start_pa,
+                        entry->size, entry->flags);
+            }
+            QTAILQ_REMOVE(&mappings, entry, entry);
+            g_free(entry);
+        }
+    }
+}
+
+/* currently we fake the dirty bitmap sync, always dirty */
+static void hax_log_sync(MemoryListener *listener,
+                         MemoryRegionSection *section)
+{
+    MemoryRegion *mr = section->mr;
+
+    if (!memory_region_is_ram(mr)) {
+        /* Skip MMIO regions */
+        return;
+    }
+
+    memory_region_set_dirty(mr, 0, int128_get64(section->size));
+}
+
+static MemoryListener hax_memory_listener = {
+    .begin = hax_transaction_begin,
+    .commit = hax_transaction_commit,
+    .region_add = hax_region_add,
+    .region_del = hax_region_del,
+    .log_sync = hax_log_sync,
+    .priority = 10,
+};
+
+static void hax_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
+{
+    /*
+     * In HAX, QEMU allocates the virtual address, and HAX kernel
+     * populates the memory with physical memory. Currently we have no
+     * paging, so user should make sure enough free memory in advance.
+     */
+    if (hax_populate_ram((uint64_t)(uintptr_t)host, size) < 0) {
+        fprintf(stderr, "HAX failed to populate RAM");
+        abort();
+    }
+}
+
+static struct RAMBlockNotifier hax_ram_notifier = {
+    .ram_block_added = hax_ram_block_added,
+};
+
+void hax_memory_init(void)
+{
+    ram_block_notifier_add(&hax_ram_notifier);
+    memory_listener_register(&hax_memory_listener, &address_space_memory);
+}
diff --git a/target/i386/hax-windows.c b/target/i386/hax-windows.c
new file mode 100644
index 0000000..15a180b
--- /dev/null
+++ b/target/i386/hax-windows.c
@@ -0,0 +1,479 @@
+/*
+ * QEMU HAXM support
+ *
+ * Copyright (c) 2011 Intel Corporation
+ *  Written by:
+ *  Jiang Yunhong<yunhong.jiang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "hax-i386.h"
+
+/*
+ * return 0 when success, -1 when driver not loaded,
+ * other negative value for other failure
+ */
+static int hax_open_device(hax_fd *fd)
+{
+    uint32_t errNum = 0;
+    HANDLE hDevice;
+
+    if (!fd) {
+        return -2;
+    }
+
+    hDevice = CreateFile("\\\\.\\HAX",
+                         GENERIC_READ | GENERIC_WRITE,
+                         0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
+
+    if (hDevice == INVALID_HANDLE_VALUE) {
+        fprintf(stderr, "Failed to open the HAX device!\n");
+        errNum = GetLastError();
+        if (errNum == ERROR_FILE_NOT_FOUND) {
+            return -1;
+        }
+        return -2;
+    }
+    *fd = hDevice;
+    return 0;
+}
+
+/* hax_fd hax_mod_open */
+ hax_fd hax_mod_open(void)
+{
+    int ret;
+    hax_fd fd = NULL;
+
+    ret = hax_open_device(&fd);
+    if (ret != 0) {
+        fprintf(stderr, "Open HAX device failed\n");
+    }
+
+    return fd;
+}
+
+int hax_populate_ram(uint64_t va, uint32_t size)
+{
+    int ret;
+    struct hax_alloc_ram_info info;
+    HANDLE hDeviceVM;
+    DWORD dSize = 0;
+
+    if (!hax_global.vm || !hax_global.vm->fd) {
+        fprintf(stderr, "Allocate memory before vm create?\n");
+        return -EINVAL;
+    }
+
+    info.size = size;
+    info.va = va;
+
+    hDeviceVM = hax_global.vm->fd;
+
+    ret = DeviceIoControl(hDeviceVM,
+                          HAX_VM_IOCTL_ALLOC_RAM,
+                          &info, sizeof(info), NULL, 0, &dSize,
+                          (LPOVERLAPPED) NULL);
+
+    if (!ret) {
+        fprintf(stderr, "Failed to allocate %x memory\n", size);
+        return ret;
+    }
+
+    return 0;
+}
+
+int hax_set_ram(uint64_t start_pa, uint32_t size, uint64_t host_va, int flags)
+{
+    struct hax_set_ram_info info;
+    HANDLE hDeviceVM = hax_global.vm->fd;
+    DWORD dSize = 0;
+    int ret;
+
+    info.pa_start = start_pa;
+    info.size = size;
+    info.va = host_va;
+    info.flags = (uint8_t) flags;
+
+    ret = DeviceIoControl(hDeviceVM, HAX_VM_IOCTL_SET_RAM,
+                          &info, sizeof(info), NULL, 0, &dSize,
+                          (LPOVERLAPPED) NULL);
+
+    if (!ret) {
+        return -EFAULT;
+    } else {
+        return 0;
+    }
+}
+
+int hax_capability(struct hax_state *hax, struct hax_capabilityinfo *cap)
+{
+    int ret;
+    HANDLE hDevice = hax->fd;        /* handle to hax module */
+    DWORD dSize = 0;
+    DWORD err = 0;
+
+    if (hax_invalid_fd(hDevice)) {
+        fprintf(stderr, "Invalid fd for hax device!\n");
+        return -ENODEV;
+    }
+
+    ret = DeviceIoControl(hDevice, HAX_IOCTL_CAPABILITY, NULL, 0, cap,
+                          sizeof(*cap), &dSize, (LPOVERLAPPED) NULL);
+
+    if (!ret) {
+        err = GetLastError();
+        if (err == ERROR_INSUFFICIENT_BUFFER || err == ERROR_MORE_DATA) {
+            fprintf(stderr, "hax capability is too long to hold.\n");
+        }
+        fprintf(stderr, "Failed to get Hax capability:%luu\n", err);
+        return -EFAULT;
+    } else {
+        return 0;
+    }
+}
+
+int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
+{
+    int ret;
+    HANDLE hDevice = hax->fd; /* handle to hax module */
+    DWORD dSize = 0;
+    DWORD err = 0;
+
+    if (hax_invalid_fd(hDevice)) {
+        fprintf(stderr, "Invalid fd for hax device!\n");
+        return -ENODEV;
+    }
+
+    ret = DeviceIoControl(hDevice,
+                          HAX_IOCTL_VERSION,
+                          NULL, 0,
+                          version, sizeof(*version), &dSize,
+                          (LPOVERLAPPED) NULL);
+
+    if (!ret) {
+        err = GetLastError();
+        if (err == ERROR_INSUFFICIENT_BUFFER || err == ERROR_MORE_DATA) {
+            fprintf(stderr, "hax module verion is too long to hold.\n");
+        }
+        fprintf(stderr, "Failed to get Hax module version:%lu\n", err);
+        return -EFAULT;
+    } else {
+        return 0;
+    }
+}
+
+static char *hax_vm_devfs_string(int vm_id)
+{
+    char *name;
+
+    if (vm_id > MAX_VM_ID) {
+        fprintf(stderr, "Too big VM id\n");
+        return NULL;
+    }
+
+#define HAX_VM_DEVFS "\\\\.\\hax_vmxx"
+    name = g_strdup(HAX_VM_DEVFS);
+    if (!name) {
+        return NULL;
+    }
+
+    snprintf(name, sizeof HAX_VM_DEVFS, "\\\\.\\hax_vm%02d", vm_id);
+    return name;
+}
+
+static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
+{
+    char *name;
+
+    if (vm_id > MAX_VM_ID || vcpu_id > MAX_VCPU_ID) {
+        fprintf(stderr, "Too big vm id %x or vcpu id %x\n", vm_id, vcpu_id);
+        return NULL;
+    }
+
+#define HAX_VCPU_DEVFS "\\\\.\\hax_vmxx_vcpuxx"
+    name = g_strdup(HAX_VCPU_DEVFS);
+    if (!name) {
+        return NULL;
+    }
+
+    snprintf(name, sizeof HAX_VCPU_DEVFS, "\\\\.\\hax_vm%02d_vcpu%02d",
+             vm_id, vcpu_id);
+    return name;
+}
+
+int hax_host_create_vm(struct hax_state *hax, int *vmid)
+{
+    int ret;
+    int vm_id = 0;
+    DWORD dSize = 0;
+
+    if (hax_invalid_fd(hax->fd)) {
+        return -EINVAL;
+    }
+
+    if (hax->vm) {
+        return 0;
+    }
+
+    ret = DeviceIoControl(hax->fd,
+                          HAX_IOCTL_CREATE_VM,
+                          NULL, 0, &vm_id, sizeof(vm_id), &dSize,
+                          (LPOVERLAPPED) NULL);
+    if (!ret) {
+        fprintf(stderr, "Failed to create VM. Error code: %lu\n",
+                GetLastError());
+        return -1;
+    }
+    *vmid = vm_id;
+    return 0;
+}
+
+hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id)
+{
+    char *vm_name = NULL;
+    hax_fd hDeviceVM;
+
+    vm_name = hax_vm_devfs_string(vm_id);
+    if (!vm_name) {
+        fprintf(stderr, "Failed to open VM. VM name is null\n");
+        return INVALID_HANDLE_VALUE;
+    }
+
+    hDeviceVM = CreateFile(vm_name,
+                           GENERIC_READ | GENERIC_WRITE,
+                           0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
+    if (hDeviceVM == INVALID_HANDLE_VALUE) {
+        fprintf(stderr, "Open the vm device error:%s, ec:%lu\n",
+                vm_name, GetLastError());
+    }
+
+    g_free(vm_name);
+    return hDeviceVM;
+}
+
+int hax_notify_qemu_version(hax_fd vm_fd, struct hax_qemu_version *qversion)
+{
+    int ret;
+    DWORD dSize = 0;
+    if (hax_invalid_fd(vm_fd)) {
+        return -EINVAL;
+    }
+    ret = DeviceIoControl(vm_fd,
+                          HAX_VM_IOCTL_NOTIFY_QEMU_VERSION,
+                          qversion, sizeof(struct hax_qemu_version),
+                          NULL, 0, &dSize, (LPOVERLAPPED) NULL);
+    if (!ret) {
+        fprintf(stderr, "Failed to notify qemu API version\n");
+        return -1;
+    }
+    return 0;
+}
+
+int hax_host_create_vcpu(hax_fd vm_fd, int vcpuid)
+{
+    int ret;
+    DWORD dSize = 0;
+
+    ret = DeviceIoControl(vm_fd,
+                          HAX_VM_IOCTL_VCPU_CREATE,
+                          &vcpuid, sizeof(vcpuid), NULL, 0, &dSize,
+                          (LPOVERLAPPED) NULL);
+    if (!ret) {
+        fprintf(stderr, "Failed to create vcpu %x\n", vcpuid);
+        return -1;
+    }
+
+    return 0;
+}
+
+hax_fd hax_host_open_vcpu(int vmid, int vcpuid)
+{
+    char *devfs_path = NULL;
+    hax_fd hDeviceVCPU;
+
+    devfs_path = hax_vcpu_devfs_string(vmid, vcpuid);
+    if (!devfs_path) {
+        fprintf(stderr, "Failed to get the devfs\n");
+        return INVALID_HANDLE_VALUE;
+    }
+
+    hDeviceVCPU = CreateFile(devfs_path,
+                             GENERIC_READ | GENERIC_WRITE,
+                             0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL,
+                             NULL);
+
+    if (hDeviceVCPU == INVALID_HANDLE_VALUE) {
+        fprintf(stderr, "Failed to open the vcpu devfs\n");
+    }
+    g_free(devfs_path);
+    return hDeviceVCPU;
+}
+
+int hax_host_setup_vcpu_channel(struct hax_vcpu_state *vcpu)
+{
+    hax_fd hDeviceVCPU = vcpu->fd;
+    int ret;
+    struct hax_tunnel_info info;
+    DWORD dSize = 0;
+
+    ret = DeviceIoControl(hDeviceVCPU,
+                          HAX_VCPU_IOCTL_SETUP_TUNNEL,
+                          NULL, 0, &info, sizeof(info), &dSize,
+                          (LPOVERLAPPED) NULL);
+    if (!ret) {
+        fprintf(stderr, "Failed to setup the hax tunnel\n");
+        return -1;
+    }
+
+    if (!valid_hax_tunnel_size(info.size)) {
+        fprintf(stderr, "Invalid hax tunnel size %x\n", info.size);
+        ret = -EINVAL;
+        return ret;
+    }
+    vcpu->tunnel = (struct hax_tunnel *) (intptr_t) (info.va);
+    vcpu->iobuf = (unsigned char *) (intptr_t) (info.io_va);
+    return 0;
+}
+
+int hax_vcpu_run(struct hax_vcpu_state *vcpu)
+{
+    int ret;
+    HANDLE hDeviceVCPU = vcpu->fd;
+    DWORD dSize = 0;
+
+    ret = DeviceIoControl(hDeviceVCPU,
+                          HAX_VCPU_IOCTL_RUN,
+                          NULL, 0, NULL, 0, &dSize, (LPOVERLAPPED) NULL);
+    if (!ret) {
+        return -EFAULT;
+    } else {
+        return 0;
+    }
+}
+
+int hax_sync_fpu(CPUArchState *env, struct fx_layout *fl, int set)
+{
+    int ret;
+    hax_fd fd;
+    HANDLE hDeviceVCPU;
+    DWORD dSize = 0;
+
+    fd = hax_vcpu_get_fd(env);
+    if (hax_invalid_fd(fd)) {
+        return -1;
+    }
+
+    hDeviceVCPU = fd;
+
+    if (set) {
+        ret = DeviceIoControl(hDeviceVCPU,
+                              HAX_VCPU_IOCTL_SET_FPU,
+                              fl, sizeof(*fl), NULL, 0, &dSize,
+                              (LPOVERLAPPED) NULL);
+    } else {
+        ret = DeviceIoControl(hDeviceVCPU,
+                              HAX_VCPU_IOCTL_GET_FPU,
+                              NULL, 0, fl, sizeof(*fl), &dSize,
+                              (LPOVERLAPPED) NULL);
+    }
+    if (!ret) {
+        return -EFAULT;
+    } else {
+        return 0;
+    }
+}
+
+int hax_sync_msr(CPUArchState *env, struct hax_msr_data *msrs, int set)
+{
+    int ret;
+    hax_fd fd;
+    HANDLE hDeviceVCPU;
+    DWORD dSize = 0;
+
+    fd = hax_vcpu_get_fd(env);
+    if (hax_invalid_fd(fd)) {
+        return -1;
+    }
+    hDeviceVCPU = fd;
+
+    if (set) {
+        ret = DeviceIoControl(hDeviceVCPU,
+                              HAX_VCPU_IOCTL_SET_MSRS,
+                              msrs, sizeof(*msrs),
+                              msrs, sizeof(*msrs), &dSize, (LPOVERLAPPED) NULL);
+    } else {
+        ret = DeviceIoControl(hDeviceVCPU,
+                              HAX_VCPU_IOCTL_GET_MSRS,
+                              msrs, sizeof(*msrs),
+                              msrs, sizeof(*msrs), &dSize, (LPOVERLAPPED) NULL);
+    }
+    if (!ret) {
+        return -EFAULT;
+    } else {
+        return 0;
+    }
+}
+
+int hax_sync_vcpu_state(CPUArchState *env, struct vcpu_state_t *state, int set)
+{
+    int ret;
+    hax_fd fd;
+    HANDLE hDeviceVCPU;
+    DWORD dSize;
+
+    fd = hax_vcpu_get_fd(env);
+    if (hax_invalid_fd(fd)) {
+        return -1;
+    }
+
+    hDeviceVCPU = fd;
+
+    if (set) {
+        ret = DeviceIoControl(hDeviceVCPU,
+                              HAX_VCPU_SET_REGS,
+                              state, sizeof(*state),
+                              NULL, 0, &dSize, (LPOVERLAPPED) NULL);
+    } else {
+        ret = DeviceIoControl(hDeviceVCPU,
+                              HAX_VCPU_GET_REGS,
+                              NULL, 0,
+                              state, sizeof(*state), &dSize,
+                              (LPOVERLAPPED) NULL);
+    }
+    if (!ret) {
+        return -EFAULT;
+    } else {
+        return 0;
+    }
+}
+
+int hax_inject_interrupt(CPUArchState *env, int vector)
+{
+    int ret;
+    hax_fd fd;
+    HANDLE hDeviceVCPU;
+    DWORD dSize;
+
+    fd = hax_vcpu_get_fd(env);
+    if (hax_invalid_fd(fd)) {
+        return -1;
+    }
+
+    hDeviceVCPU = fd;
+
+    ret = DeviceIoControl(hDeviceVCPU,
+                          HAX_VCPU_IOCTL_INTERRUPT,
+                          &vector, sizeof(vector), NULL, 0, &dSize,
+                          (LPOVERLAPPED) NULL);
+    if (!ret) {
+        return -EFAULT;
+    } else {
+        return 0;
+    }
+}
diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
new file mode 100644
index 0000000..1d8f68d
--- /dev/null
+++ b/target/i386/hax-windows.h
@@ -0,0 +1,89 @@
+/*
+ * QEMU HAXM support
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * Copyright (c) 2011 Intel Corporation
+ *  Written by:
+ *  Jiang Yunhong<yunhong.jiang@intel.com>
+ *  Xin Xiaohui<xiaohui.xin@intel.com>
+ *  Zhang Xiantao<xiantao.zhang@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef TARGET_I386_HAX_WINDOWS_H
+#define TARGET_I386_HAX_WINDOWS_H
+
+#include <windows.h>
+#include <memory.h>
+#include <malloc.h>
+#include <winioctl.h>
+#include <string.h>
+#include <stdio.h>
+#include <windef.h>
+
+#define HAX_INVALID_FD INVALID_HANDLE_VALUE
+
+static inline void hax_mod_close(struct hax_state *hax)
+{
+    CloseHandle(hax->fd);
+}
+
+static inline void hax_close_fd(hax_fd fd)
+{
+    CloseHandle(fd);
+}
+
+static inline int hax_invalid_fd(hax_fd fd)
+{
+    return (fd == INVALID_HANDLE_VALUE);
+}
+
+#define HAX_DEVICE_TYPE 0x4000
+
+#define HAX_IOCTL_VERSION       CTL_CODE(HAX_DEVICE_TYPE, 0x900, \
+                                         METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_IOCTL_CREATE_VM     CTL_CODE(HAX_DEVICE_TYPE, 0x901, \
+                                         METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_IOCTL_CAPABILITY    CTL_CODE(HAX_DEVICE_TYPE, 0x910, \
+                                         METHOD_BUFFERED, FILE_ANY_ACCESS)
+
+#define HAX_VM_IOCTL_VCPU_CREATE   CTL_CODE(HAX_DEVICE_TYPE, 0x902, \
+                                            METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_VM_IOCTL_ALLOC_RAM     CTL_CODE(HAX_DEVICE_TYPE, 0x903, \
+                                            METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_VM_IOCTL_SET_RAM       CTL_CODE(HAX_DEVICE_TYPE, 0x904, \
+                                            METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_VM_IOCTL_VCPU_DESTROY  CTL_CODE(HAX_DEVICE_TYPE, 0x905, \
+                                            METHOD_BUFFERED, FILE_ANY_ACCESS)
+
+#define HAX_VCPU_IOCTL_RUN      CTL_CODE(HAX_DEVICE_TYPE, 0x906, \
+                                         METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_VCPU_IOCTL_SET_MSRS CTL_CODE(HAX_DEVICE_TYPE, 0x907, \
+                                         METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_VCPU_IOCTL_GET_MSRS CTL_CODE(HAX_DEVICE_TYPE, 0x908, \
+                                         METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_VCPU_IOCTL_SET_FPU  CTL_CODE(HAX_DEVICE_TYPE, 0x909, \
+                                         METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_VCPU_IOCTL_GET_FPU  CTL_CODE(HAX_DEVICE_TYPE, 0x90a, \
+                                         METHOD_BUFFERED, FILE_ANY_ACCESS)
+
+#define HAX_VCPU_IOCTL_SETUP_TUNNEL  CTL_CODE(HAX_DEVICE_TYPE, 0x90b, \
+                                              METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_VCPU_IOCTL_INTERRUPT     CTL_CODE(HAX_DEVICE_TYPE, 0x90c, \
+                                              METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_VCPU_SET_REGS            CTL_CODE(HAX_DEVICE_TYPE, 0x90d, \
+                                              METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define HAX_VCPU_GET_REGS            CTL_CODE(HAX_DEVICE_TYPE, 0x90e, \
+                                              METHOD_BUFFERED, FILE_ANY_ACCESS)
+
+#define HAX_VM_IOCTL_NOTIFY_QEMU_VERSION CTL_CODE(HAX_DEVICE_TYPE, 0x910, \
+                                                  METHOD_BUFFERED,        \
+                                                  FILE_ANY_ACCESS)
+#endif /* TARGET_I386_HAX_WINDOWS_H */
-- 
1.8.3.1
