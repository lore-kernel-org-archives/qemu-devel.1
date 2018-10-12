Received: from eggs.gnu.org ([2001:4830:134:3::10]:60825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Ax-0008C0-Om
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1gB7Aq-0006UG-72
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1gB7Ao-0006RY-1T
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 19:48:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w9CNiXtr088239
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:47 GMT
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by userp2120.oracle.com with ESMTP id 2mxnprndsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNmjKr029690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:45 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9CNmiU1023372
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 23:48:45 GMT
From: Jagannathan Raman <jag.raman@oracle.com>
Date: Fri, 12 Oct 2018 19:48:28 -0400
Message-Id: <72de54d4a7c5051cb2b4d287d9c40a473d2321e2.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
In-Reply-To: <cover.1539387238.git.jag.raman@oracle.com>
References: <cover.1539387238.git.jag.raman@oracle.com>
Subject: [Qemu-devel] [RFC PATCH v1 1/8] multi-process QEMU: build system
 for remote device process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: john.g.johnson@oracle.com, Kanth.Ghatraju@oracle.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com

- Makefile changes necessary to support the building of the remote device
  process is added
- functions that are necessary to compile the code, but are not needed at
  run-time are stubbed out
- main() function of remote SCSI device process is implemented

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 Makefile                |  3 +-
 Makefile.objs           | 16 ++++++++++
 Makefile.target         | 39 +++++++++++++++++++++++-
 accel/stubs/kvm-stub.c  |  5 +++
 accel/stubs/tcg-stub.c  | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
 backends/Makefile.objs  |  2 ++
 block/Makefile.objs     |  2 ++
 hw/Makefile.objs        |  6 ++++
 hw/block/Makefile.objs  |  2 ++
 hw/core/Makefile.objs   | 14 +++++++++
 hw/nvram/Makefile.objs  |  2 ++
 hw/pci/Makefile.objs    |  4 +++
 hw/scsi/Makefile.objs   |  3 ++
 hw/scsi/qemu-scsi-dev.c | 35 +++++++++++++++++++++
 migration/Makefile.objs |  2 ++
 qom/Makefile.objs       |  4 +++
 stubs/monitor.c         | 25 +++++++++++++++
 stubs/net-stub.c        | 31 +++++++++++++++++++
 stubs/replay.c          | 14 +++++++++
 stubs/vl-stub.c         | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 stubs/vmstate.c         | 20 ++++++++++++
 21 files changed, 387 insertions(+), 2 deletions(-)
 create mode 100644 hw/scsi/qemu-scsi-dev.c
 create mode 100644 stubs/net-stub.c
 create mode 100644 stubs/vl-stub.c

diff --git a/Makefile b/Makefile
index 1144d6e..b6cac08 100644
--- a/Makefile
+++ b/Makefile
@@ -429,6 +429,7 @@ dummy := $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
+                scsi-dev-obj-y \
                 common-obj-m \
                 ui-obj-y \
                 ui-obj-m \
@@ -507,7 +508,7 @@ CAP_CFLAGS += -DCAPSTONE_HAS_X86
 subdir-capstone: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))
 
-$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
+$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) $(scsi-dev-obj-y) \
 	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
diff --git a/Makefile.objs b/Makefile.objs
index 1e1ff38..0a3799c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -73,6 +73,22 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
 block-obj-m = block/
 
+####################################################
+# scsi-dev-obj-y is code used by remote SCSI device
+
+scsi-dev-obj-y += hw/
+scsi-dev-obj-y += qom/
+scsi-dev-obj-y += backends/
+scsi-dev-obj-y += block/
+scsi-dev-obj-y += migration/
+
+scsi-dev-obj-y += cpus-common.o
+scsi-dev-obj-y += dma-helpers.o
+scsi-dev-obj-y += blockdev.o
+scsi-dev-obj-y += qdev-monitor.o
+scsi-dev-obj-y += bootdevice.o
+scsi-dev-obj-y += iothread.o
+
 #######################################################################
 # crypto-obj-y is code used by both qemu system emulation and qemu-img
 
diff --git a/Makefile.target b/Makefile.target
index 4d56298..c5feda2 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -19,21 +19,26 @@ ifdef CONFIG_USER_ONLY
 # user emulator name
 QEMU_PROG=qemu-$(TARGET_NAME)
 QEMU_PROG_BUILD = $(QEMU_PROG)
+SCSI_DEV_PROG=qemu-scsi-dev
+SCSI_DEV_BUILD = $(SCSI_DEV_PROG)
 else
 # system emulator name
 QEMU_PROG=qemu-system-$(TARGET_NAME)$(EXESUF)
+SCSI_DEV_PROG=qemu-scsi-dev
 ifneq (,$(findstring -mwindows,$(SDL_LIBS)))
 # Terminate program name with a 'w' because the linker builds a windows executable.
 QEMU_PROGW=qemu-system-$(TARGET_NAME)w$(EXESUF)
 $(QEMU_PROG): $(QEMU_PROGW)
 	$(call quiet-command,$(OBJCOPY) --subsystem console $(QEMU_PROGW) $(QEMU_PROG),"GEN","$(TARGET_DIR)$(QEMU_PROG)")
 QEMU_PROG_BUILD = $(QEMU_PROGW)
+SCSI_DEV_BUILD = $(SCSI_DEV_PROG)
 else
 QEMU_PROG_BUILD = $(QEMU_PROG)
+SCSI_DEV_BUILD = $(SCSI_DEV_PROG)
 endif
 endif
 
-PROGS=$(QEMU_PROG) $(QEMU_PROGW)
+PROGS=$(QEMU_PROG) $(QEMU_PROGW) $(SCSI_DEV_PROG)
 STPFILES=
 
 # Makefile Tests
@@ -107,6 +112,13 @@ obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 
+scsi-dev-tgt-obj-y += accel/stubs/kvm-stub.o
+scsi-dev-tgt-obj-y += accel/stubs/tcg-stub.o
+scsi-dev-tgt-obj-y += stubs/vl-stub.o
+scsi-dev-tgt-obj-y += stubs/net-stub.o
+scsi-dev-tgt-obj-y += stubs/monitor.o
+scsi-dev-tgt-obj-y += stubs/replay.o
+
 #########################################################
 # Linux user emulator target
 
@@ -164,10 +176,20 @@ endif # CONFIG_SOFTMMU
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
+dummy := $(call unnest-vars,..,scsi-dev-tgt-obj-y)
+all-scsi-dev-obj-y := $(scsi-dev-tgt-obj-y)
+
+all-scsi-dev-obj-y += memory.o
+all-scsi-dev-obj-y += exec.o
+all-scsi-dev-obj-y += numa.o
+all-scsi-dev-obj-y += ioport.o
+all-scsi-dev-obj-y += cpus.o
+
 target-obj-y :=
 block-obj-y :=
 common-obj-y :=
 chardev-obj-y :=
+scsi-dev-obj-y :=
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call unnest-vars,,target-obj-y)
 target-obj-y-save := $(target-obj-y)
@@ -180,6 +202,7 @@ dummy := $(call unnest-vars,.., \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
+               scsi-dev-obj-y \
                common-obj-m)
 target-obj-y := $(target-obj-y-save)
 all-obj-y += $(common-obj-y)
@@ -190,7 +213,14 @@ all-obj-$(CONFIG_USER_ONLY) += $(crypto-aes-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
+all-scsi-dev-obj-y += $(block-obj-y)
+all-scsi-dev-obj-y += $(crypto-obj-y)
+all-scsi-dev-obj-y += $(io-obj-y)
+all-scsi-dev-obj-y += $(chardev-obj-y)
+all-scsi-dev-obj-y += $(scsi-dev-obj-y)
+
 $(QEMU_PROG_BUILD): config-devices.mak
+$(SCSI_DEV_BUILD): config-devices.mak
 
 COMMON_LDADDS = ../libqemuutil.a
 
@@ -202,6 +232,13 @@ ifdef CONFIG_DARWIN
 	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
 endif
 
+$(SCSI_DEV_BUILD): $(all-scsi-dev-obj-y) $(COMMON_LDADDS)
+	$(call LINK, $(filter-out %.mak, $^))
+ifdef CONFIG_DARWIN
+	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ","$(TARGET_DIR)$@")
+	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
+endif
+
 gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
 	$(call quiet-command,rm -f $@ && $(SHELL) $(SRC_PATH)/scripts/feature_to_c.sh $@ $(TARGET_XML_FILES),"GEN","$(TARGET_DIR)$@")
 
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 02d5170..573b4da 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -32,6 +32,7 @@ bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
+bool kvm_halt_in_kernel_allowed;
 
 int kvm_destroy_vcpu(CPUState *cpu)
 {
@@ -59,6 +60,10 @@ void kvm_cpu_synchronize_post_init(CPUState *cpu)
 {
 }
 
+void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     abort();
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 76ae461..e6efd65 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -16,11 +16,92 @@
 #include "tcg/tcg.h"
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
+#include "translate-all.h"
+#include "exec/ram_addr.h"
+
+bool parallel_cpus;
 
 void tb_flush(CPUState *cpu)
 {
 }
 
+void tb_check_watchpoint(CPUState *cpu)
+{
+}
+
+void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end)
+{
+}
+
+void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
+                                   int is_cpu_write_access)
+{
+}
+
+void tb_invalidate_phys_page_fast(struct page_collection *pages,
+                                  tb_page_addr_t start, int len)
+{
+}
+
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 {
 }
+
+void tlb_flush(CPUState *cpu)
+{
+}
+
+void tlb_flush_page(CPUState *cpu, target_ulong addr)
+{
+}
+
+void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
+{
+}
+
+void tcg_region_init(void)
+{
+}
+
+void tcg_register_thread(void)
+{
+}
+
+void tcg_flush_softmmu_tlb(CPUState *cs)
+{
+}
+
+void cpu_loop_exit_noexc(CPUState *cpu)
+{
+    cpu->exception_index = -1;
+    cpu_loop_exit(cpu);
+}
+
+void cpu_loop_exit(CPUState *cpu)
+{
+    cpu->can_do_io = 1;
+    siglongjmp(cpu->jmp_env, 1);
+}
+
+void cpu_reloading_memory_map(void)
+{
+}
+
+int cpu_exec(CPUState *cpu)
+{
+    return 0;
+}
+
+void cpu_exec_step_atomic(CPUState *cpu)
+{
+}
+
+struct page_collection *
+page_collection_lock(tb_page_addr_t start, tb_page_addr_t end)
+{
+    return NULL;
+}
+
+void page_collection_unlock(struct page_collection *set)
+{
+}
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 717fcbd..6c6aa03 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -16,3 +16,5 @@ common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) += \
 endif
 
 common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
+
+scsi-dev-obj-y += hostmem.o
diff --git a/block/Makefile.objs b/block/Makefile.objs
index c8337bf..50431ce 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -51,3 +51,5 @@ qcow.o-libs        := -lz
 linux-aio.o-libs   := -laio
 parallels.o-cflags := $(LIBXML2_CFLAGS)
 parallels.o-libs   := $(LIBXML2_LIBS)
+
+scsi-dev-obj-y += stream.o
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a19c141..9c99c29 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -38,3 +38,9 @@ devices-dirs-$(CONFIG_SOFTMMU) += smbios/
 devices-dirs-y += core/
 common-obj-y += $(devices-dirs-y)
 obj-y += $(devices-dirs-y)
+
+scsi-dev-obj-y += core/
+scsi-dev-obj-y += scsi/
+scsi-dev-obj-y += block/
+scsi-dev-obj-y += pci/
+scsi-dev-obj-y += nvram/
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 53ce575..e93aeba 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -14,3 +14,5 @@ obj-$(CONFIG_SH4) += tc58128.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
 obj-$(CONFIG_VIRTIO_BLK) += dataplane/
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
+
+scsi-dev-obj-y += block.o cdrom.o hd-geometry.o
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index eb88ca9..6fd29ac 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -23,3 +23,17 @@ common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
 
 obj-$(CONFIG_SOFTMMU) += generic-loader.o
 obj-$(CONFIG_SOFTMMU) += null-machine.o
+
+scsi-dev-obj-y += qdev-properties.o
+scsi-dev-obj-y += qdev.o
+scsi-dev-obj-y += bus.o
+scsi-dev-obj-y += irq.o
+scsi-dev-obj-y += hotplug.o
+scsi-dev-obj-y += machine.o
+scsi-dev-obj-y += fw-path-provider.o
+scsi-dev-obj-y += reset.o
+scsi-dev-obj-y += sysbus.o
+scsi-dev-obj-y += loader.o
+scsi-dev-obj-y += nmi.o
+scsi-dev-obj-y += qdev-properties-system.o
+scsi-dev-obj-y += qdev-fw.o
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index a912d25..f52e770 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -5,3 +5,5 @@ common-obj-y += fw_cfg.o
 common-obj-y += chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
 obj-$(CONFIG_PSERIES) += spapr_nvram.o
+
+scsi-dev-obj-y += fw_cfg.o
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index 9f905e6..46af40a 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -7,3 +7,7 @@ common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o pcie_port.o
 
 common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
 common-obj-$(CONFIG_ALL) += pci-stub.o
+
+scsi-dev-obj-y += pci.o pci_bridge.o
+scsi-dev-obj-y += msi.o msix.o
+scsi-dev-obj-y += pcie.o
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 718b4c2..8cf6344 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -13,3 +13,6 @@ obj-y += virtio-scsi.o virtio-scsi-dataplane.o
 obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-common.o vhost-scsi.o
 obj-$(CONFIG_VHOST_USER_SCSI) += vhost-scsi-common.o vhost-user-scsi.o
 endif
+
+scsi-dev-obj-y += qemu-scsi-dev.o
+scsi-dev-obj-y += scsi-generic.o scsi-bus.o lsi53c895a.o scsi-disk.o
diff --git a/hw/scsi/qemu-scsi-dev.c b/hw/scsi/qemu-scsi-dev.c
new file mode 100644
index 0000000..3cb8698
--- /dev/null
+++ b/hw/scsi/qemu-scsi-dev.c
@@ -0,0 +1,35 @@
+/*
+ * Remote SCSI device
+ *
+ * Copyright 2018, Oracle and/or its affiliates. All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include <stdio.h>
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+
+int main(int argc, char *argv[])
+{
+    module_call_init(MODULE_INIT_QOM);
+
+    return 0;
+}
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index c83ec47..c634b89 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -13,3 +13,5 @@ common-obj-$(CONFIG_RDMA) += rdma.o
 common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
 rdma.o-libs := $(RDMA_LIBS)
+
+scsi-dev-obj-y += qemu-file.o vmstate.o qjson.o vmstate-types.o
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index 516349e..cf25361 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -2,3 +2,7 @@ qom-obj-y = object.o container.o qom-qobject.o
 qom-obj-y += object_interfaces.o
 
 common-obj-y = cpu.o
+
+scsi-dev-obj-y += object.o qom-qobject.o container.o
+scsi-dev-obj-y += object_interfaces.o
+scsi-dev-obj-y += cpu.o
diff --git a/stubs/monitor.c b/stubs/monitor.c
index 3890771..9280932 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -2,6 +2,8 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "monitor/monitor.h"
+#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-commands-misc.h"
 
 __thread Monitor *cur_mon;
 
@@ -14,3 +16,26 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 void monitor_init(Chardev *chr, int flags)
 {
 }
+
+int monitor_get_cpu_index(void)
+{
+    return -ENOSYS;
+}
+void monitor_printf(Monitor *mon, const char *fmt, ...)
+{
+}
+
+bool monitor_cur_is_qmp(void)
+{
+    return false;
+}
+
+ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
+                                                   Error **errp)
+{
+    return NULL;
+}
+
+void monitor_vfprintf(FILE *stream, const char *fmt, va_list ap)
+{
+}
diff --git a/stubs/net-stub.c b/stubs/net-stub.c
new file mode 100644
index 0000000..cb2274b
--- /dev/null
+++ b/stubs/net-stub.c
@@ -0,0 +1,31 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "net/net.h"
+
+int qemu_find_net_clients_except(const char *id, NetClientState **ncs,
+                                 NetClientDriver type, int max)
+{
+    return -ENOSYS;
+}
+
+NetClientState *net_hub_port_find(int hub_id)
+{
+    return NULL;
+}
+
+int net_hub_id_for_client(NetClientState *nc, int *id)
+{
+    return -ENOSYS;
+}
+
+int qemu_show_nic_models(const char *arg, const char *const *models)
+{
+    return -ENOSYS;
+}
+
+int qemu_find_nic_model(NICInfo *nd, const char * const *models,
+                        const char *default_model)
+{
+    return -ENOSYS;
+}
+
diff --git a/stubs/replay.c b/stubs/replay.c
index 04279ab..226ce54 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -80,3 +80,17 @@ void replay_mutex_lock(void)
 void replay_mutex_unlock(void)
 {
 }
+
+bool replay_has_checkpoint(void)
+{
+    return false;
+}
+
+int replay_get_instructions(void)
+{
+    return 0;
+}
+
+void replay_account_executed_instructions(void)
+{
+}
diff --git a/stubs/vl-stub.c b/stubs/vl-stub.c
new file mode 100644
index 0000000..78925ac
--- /dev/null
+++ b/stubs/vl-stub.c
@@ -0,0 +1,79 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/uuid.h"
+#include "sysemu/sysemu.h"
+#include "exec/cpu-common.h"
+#include "exec/gdbstub.h"
+#include "sysemu/replay.h"
+#include "disas/disas.h"
+
+bool tcg_allowed;
+bool xen_allowed;
+bool boot_strict;
+
+int mem_prealloc;
+int smp_cpus;
+int vga_interface_type = VGA_NONE;
+int smp_cores = 1;
+int smp_threads = 1;
+int icount_align_option;
+int boot_menu;
+
+unsigned int max_cpus;
+const uint32_t arch_type;
+const char *mem_path;
+uint8_t qemu_extra_params_fw[2];
+uint8_t *boot_splash_filedata;
+size_t boot_splash_filedata_size;
+struct syminfo *syminfos;
+
+ram_addr_t ram_size;
+MachineState *current_machine;
+QemuUUID qemu_uuid;
+
+int runstate_is_running(void)
+{
+    return 0;
+}
+
+void runstate_set(RunState new_state)
+{
+}
+
+void vm_state_notify(int running, RunState state)
+{
+}
+
+bool qemu_vmstop_requested(RunState *r)
+{
+    return false;
+}
+
+void qemu_system_debug_request(void)
+{
+}
+
+void qemu_remove_machine_init_done_notifier(Notifier *notify)
+{
+}
+
+char *qemu_find_file(int type, const char *name)
+{
+    return NULL;
+}
+
+void gdb_set_stop_cpu(CPUState *cpu)
+{
+}
+
+void replay_enable_events(void)
+{
+}
+
+void replay_disable_events(void)
+{
+}
+
+void x86_cpu_list(FILE *f, fprintf_function cpu_fprintf)
+{
+}
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index 6399474..2a8d109 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -1,9 +1,12 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "migration/vmstate.h"
+#include "migration/misc.h"
 
 const VMStateDescription vmstate_dummy = {};
 
+const VMStateInfo vmstate_info_timer;
+
 int vmstate_register_with_alias_id(DeviceState *dev,
                                    int instance_id,
                                    const VMStateDescription *vmsd,
@@ -24,3 +27,20 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 {
     return true;
 }
+
+void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
+{
+}
+
+void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
+{
+}
+
+void vmstate_register_ram_global(MemoryRegion *mr)
+{
+}
+
+bool migration_is_idle(void)
+{
+    return false;
+}
-- 
1.8.3.1
