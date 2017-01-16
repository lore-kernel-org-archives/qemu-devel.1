Received: from eggs.gnu.org ([2001:4830:134:3::10]:58402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAdU-0001I9-SM
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:00:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAdS-0000E9-G1
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:00:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAdS-0000Dd-5e
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:58 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:59:15 +0100
Message-Id: <20170116165916.8575-32-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/32] hax: add Darwin support
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

Re-add the MacOSX/Darwin support:
Use the Intel HAX is kernel-based hardware acceleration module
(similar to KVM on Linux).

Based on the original "target/i386: Add Intel HAX to android emulator" patch
from David Chou <david.j.chou@intel.com> from  emu-2.2-release branch in
the external/qemu-android repository.

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Message-Id: <81b85c3032da902e73e77302af508b4b1a7c0ead.1484045952.git.vpalatin@chromium.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/Makefile.objs |   3 +
 target/i386/hax-darwin.c  | 316 ++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/hax-darwin.h  |  63 +++++++++
 target/i386/hax-i386.h    |   8 ++
 4 files changed, 390 insertions(+)
 create mode 100644 target/i386/hax-darwin.c
 create mode 100644 target/i386/hax-darwin.h

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index acbe7b0..4fcb7f3 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -9,3 +9,6 @@ obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 ifdef CONFIG_WIN32
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
 endif
+ifdef CONFIG_DARWIN
+obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
+endif
diff --git a/target/i386/hax-darwin.c b/target/i386/hax-darwin.c
new file mode 100644
index 0000000..1c5bbd0
--- /dev/null
+++ b/target/i386/hax-darwin.c
@@ -0,0 +1,316 @@
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
+/* HAX module interface - darwin version */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+
+#include "qemu/osdep.h"
+#include "target/i386/hax-i386.h"
+
+hax_fd hax_mod_open(void)
+{
+    int fd = open("/dev/HAX", O_RDWR);
+    if (fd == -1) {
+        fprintf(stderr, "Failed to open the hax module\n");
+    }
+
+    fcntl(fd, F_SETFD, FD_CLOEXEC);
+
+    return fd;
+}
+
+int hax_populate_ram(uint64_t va, uint32_t size)
+{
+    int ret;
+    struct hax_alloc_ram_info info;
+
+    if (!hax_global.vm || !hax_global.vm->fd) {
+        fprintf(stderr, "Allocate memory before vm create?\n");
+        return -EINVAL;
+    }
+
+    info.size = size;
+    info.va = va;
+    ret = ioctl(hax_global.vm->fd, HAX_VM_IOCTL_ALLOC_RAM, &info);
+    if (ret < 0) {
+        fprintf(stderr, "Failed to allocate %x memory\n", size);
+        return ret;
+    }
+    return 0;
+}
+
+int hax_set_ram(uint64_t start_pa, uint32_t size, uint64_t host_va, int flags)
+{
+    struct hax_set_ram_info info;
+    int ret;
+
+    info.pa_start = start_pa;
+    info.size = size;
+    info.va = host_va;
+    info.flags = (uint8_t) flags;
+
+    ret = ioctl(hax_global.vm->fd, HAX_VM_IOCTL_SET_RAM, &info);
+    if (ret < 0) {
+        return -errno;
+    }
+    return 0;
+}
+
+int hax_capability(struct hax_state *hax, struct hax_capabilityinfo *cap)
+{
+    int ret;
+
+    ret = ioctl(hax->fd, HAX_IOCTL_CAPABILITY, cap);
+    if (ret == -1) {
+        fprintf(stderr, "Failed to get HAX capability\n");
+        return -errno;
+    }
+
+    return 0;
+}
+
+int hax_mod_version(struct hax_state *hax, struct hax_module_version *version)
+{
+    int ret;
+
+    ret = ioctl(hax->fd, HAX_IOCTL_VERSION, version);
+    if (ret == -1) {
+        fprintf(stderr, "Failed to get HAX version\n");
+        return -errno;
+    }
+
+    return 0;
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
+#define HAX_VM_DEVFS "/dev/hax_vm/vmxx"
+    name = g_strdup(HAX_VM_DEVFS);
+    if (!name) {
+        return NULL;
+    }
+
+    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
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
+#define HAX_VCPU_DEVFS "/dev/hax_vmxx/vcpuxx"
+    name = g_strdup(HAX_VCPU_DEVFS);
+    if (!name) {
+        return NULL;
+    }
+
+    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
+             vm_id, vcpu_id);
+    return name;
+}
+
+int hax_host_create_vm(struct hax_state *hax, int *vmid)
+{
+    int ret;
+    int vm_id = 0;
+
+    if (hax_invalid_fd(hax->fd)) {
+        return -EINVAL;
+    }
+
+    if (hax->vm) {
+        return 0;
+    }
+
+    ret = ioctl(hax->fd, HAX_IOCTL_CREATE_VM, &vm_id);
+    *vmid = vm_id;
+    return ret;
+}
+
+hax_fd hax_host_open_vm(struct hax_state *hax, int vm_id)
+{
+    hax_fd fd;
+    char *vm_name = NULL;
+
+    vm_name = hax_vm_devfs_string(vm_id);
+    if (!vm_name) {
+        return -1;
+    }
+
+    fd = open(vm_name, O_RDWR);
+    g_free(vm_name);
+
+    fcntl(fd, F_SETFD, FD_CLOEXEC);
+
+    return fd;
+}
+
+int hax_notify_qemu_version(hax_fd vm_fd, struct hax_qemu_version *qversion)
+{
+    int ret;
+
+    if (hax_invalid_fd(vm_fd)) {
+        return -EINVAL;
+    }
+
+    ret = ioctl(vm_fd, HAX_VM_IOCTL_NOTIFY_QEMU_VERSION, qversion);
+
+    if (ret < 0) {
+        fprintf(stderr, "Failed to notify qemu API version\n");
+        return ret;
+    }
+    return 0;
+}
+
+/* Simply assume the size should be bigger than the hax_tunnel,
+ * since the hax_tunnel can be extended later with compatibility considered
+ */
+int hax_host_create_vcpu(hax_fd vm_fd, int vcpuid)
+{
+    int ret;
+
+    ret = ioctl(vm_fd, HAX_VM_IOCTL_VCPU_CREATE, &vcpuid);
+    if (ret < 0) {
+        fprintf(stderr, "Failed to create vcpu %x\n", vcpuid);
+    }
+
+    return ret;
+}
+
+hax_fd hax_host_open_vcpu(int vmid, int vcpuid)
+{
+    char *devfs_path = NULL;
+    hax_fd fd;
+
+    devfs_path = hax_vcpu_devfs_string(vmid, vcpuid);
+    if (!devfs_path) {
+        fprintf(stderr, "Failed to get the devfs\n");
+        return -EINVAL;
+    }
+
+    fd = open(devfs_path, O_RDWR);
+    g_free(devfs_path);
+    if (fd < 0) {
+        fprintf(stderr, "Failed to open the vcpu devfs\n");
+    }
+    fcntl(fd, F_SETFD, FD_CLOEXEC);
+    return fd;
+}
+
+int hax_host_setup_vcpu_channel(struct hax_vcpu_state *vcpu)
+{
+    int ret;
+    struct hax_tunnel_info info;
+
+    ret = ioctl(vcpu->fd, HAX_VCPU_IOCTL_SETUP_TUNNEL, &info);
+    if (ret) {
+        fprintf(stderr, "Failed to setup the hax tunnel\n");
+        return ret;
+    }
+
+    if (!valid_hax_tunnel_size(info.size)) {
+        fprintf(stderr, "Invalid hax tunnel size %x\n", info.size);
+        ret = -EINVAL;
+        return ret;
+    }
+
+    vcpu->tunnel = (struct hax_tunnel *) (intptr_t) (info.va);
+    vcpu->iobuf = (unsigned char *) (intptr_t) (info.io_va);
+    return 0;
+}
+
+int hax_vcpu_run(struct hax_vcpu_state *vcpu)
+{
+    int ret;
+
+    ret = ioctl(vcpu->fd, HAX_VCPU_IOCTL_RUN, NULL);
+    return ret;
+}
+
+int hax_sync_fpu(CPUArchState *env, struct fx_layout *fl, int set)
+{
+    int ret, fd;
+
+    fd = hax_vcpu_get_fd(env);
+    if (fd <= 0) {
+        return -1;
+    }
+
+    if (set) {
+        ret = ioctl(fd, HAX_VCPU_IOCTL_SET_FPU, fl);
+    } else {
+        ret = ioctl(fd, HAX_VCPU_IOCTL_GET_FPU, fl);
+    }
+    return ret;
+}
+
+int hax_sync_msr(CPUArchState *env, struct hax_msr_data *msrs, int set)
+{
+    int ret, fd;
+
+    fd = hax_vcpu_get_fd(env);
+    if (fd <= 0) {
+        return -1;
+    }
+    if (set) {
+        ret = ioctl(fd, HAX_VCPU_IOCTL_SET_MSRS, msrs);
+    } else {
+        ret = ioctl(fd, HAX_VCPU_IOCTL_GET_MSRS, msrs);
+    }
+    return ret;
+}
+
+int hax_sync_vcpu_state(CPUArchState *env, struct vcpu_state_t *state, int set)
+{
+    int ret, fd;
+
+    fd = hax_vcpu_get_fd(env);
+    if (fd <= 0) {
+        return -1;
+    }
+
+    if (set) {
+        ret = ioctl(fd, HAX_VCPU_SET_REGS, state);
+    } else {
+        ret = ioctl(fd, HAX_VCPU_GET_REGS, state);
+    }
+    return ret;
+}
+
+int hax_inject_interrupt(CPUArchState *env, int vector)
+{
+    int ret, fd;
+
+    fd = hax_vcpu_get_fd(env);
+    if (fd <= 0) {
+        return -1;
+    }
+
+    ret = ioctl(fd, HAX_VCPU_IOCTL_INTERRUPT, &vector);
+    return ret;
+}
diff --git a/target/i386/hax-darwin.h b/target/i386/hax-darwin.h
new file mode 100644
index 0000000..0c0968b
--- /dev/null
+++ b/target/i386/hax-darwin.h
@@ -0,0 +1,63 @@
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
+#ifndef TARGET_I386_HAX_DARWIN_H
+#define TARGET_I386_HAX_DARWIN_H
+
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <stdarg.h>
+
+#define HAX_INVALID_FD  (-1)
+static inline int hax_invalid_fd(hax_fd fd)
+{
+    return fd <= 0;
+}
+
+static inline void hax_mod_close(struct hax_state *hax)
+{
+    close(hax->fd);
+}
+
+static inline void hax_close_fd(hax_fd fd)
+{
+    close(fd);
+}
+
+/* HAX model level ioctl */
+#define HAX_IOCTL_VERSION _IOWR(0, 0x20, struct hax_module_version)
+#define HAX_IOCTL_CREATE_VM _IOWR(0, 0x21, uint32_t)
+#define HAX_IOCTL_DESTROY_VM _IOW(0, 0x22, uint32_t)
+#define HAX_IOCTL_CAPABILITY _IOR(0, 0x23, struct hax_capabilityinfo)
+
+#define HAX_VM_IOCTL_VCPU_CREATE _IOWR(0, 0x80, uint32_t)
+#define HAX_VM_IOCTL_ALLOC_RAM _IOWR(0, 0x81, struct hax_alloc_ram_info)
+#define HAX_VM_IOCTL_SET_RAM _IOWR(0, 0x82, struct hax_set_ram_info)
+#define HAX_VM_IOCTL_VCPU_DESTROY _IOW(0, 0x83, uint32_t)
+#define HAX_VM_IOCTL_NOTIFY_QEMU_VERSION _IOW(0, 0x84, struct hax_qemu_version)
+
+#define HAX_VCPU_IOCTL_RUN  _IO(0, 0xc0)
+#define HAX_VCPU_IOCTL_SET_MSRS _IOWR(0, 0xc1, struct hax_msr_data)
+#define HAX_VCPU_IOCTL_GET_MSRS _IOWR(0, 0xc2, struct hax_msr_data)
+
+#define HAX_VCPU_IOCTL_SET_FPU  _IOW(0, 0xc3, struct fx_layout)
+#define HAX_VCPU_IOCTL_GET_FPU  _IOR(0, 0xc4, struct fx_layout)
+
+#define HAX_VCPU_IOCTL_SETUP_TUNNEL _IOWR(0, 0xc5, struct hax_tunnel_info)
+#define HAX_VCPU_IOCTL_INTERRUPT _IOWR(0, 0xc6, uint32_t)
+#define HAX_VCPU_SET_REGS       _IOWR(0, 0xc7, struct vcpu_state_t)
+#define HAX_VCPU_GET_REGS       _IOWR(0, 0xc8, struct vcpu_state_t)
+
+#endif /* TARGET_I386_HAX_DARWIN_H */
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index bcbd105..8ffe91f 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -16,6 +16,10 @@
 #include "cpu.h"
 #include "sysemu/hax.h"
 
+#ifdef CONFIG_DARWIN
+typedef int hax_fd;
+#endif
+
 #ifdef CONFIG_WIN32
 typedef HANDLE hax_fd;
 #endif
@@ -77,6 +81,10 @@ hax_fd hax_mod_open(void);
 void hax_memory_init(void);
 
 
+#ifdef CONFIG_DARWIN
+#include "target/i386/hax-darwin.h"
+#endif
+
 #ifdef CONFIG_WIN32
 #include "target/i386/hax-windows.h"
 #endif
-- 
2.9.3
