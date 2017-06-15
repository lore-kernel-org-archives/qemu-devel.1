Received: from eggs.gnu.org ([2001:4830:134:3::10]:40988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPF-0008SM-JU
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSPB-0007cn-Ls
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:41 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSPB-0007bv-C6
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:37 -0400
Received: by mail-wr0-x233.google.com with SMTP id 77so16395323wrb.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:37 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:43 +0200
Message-Id: <1497523981-38449-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/41] accel: move kvm related accelerator files
 into accel/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

move kvm related accelerator files into accel/ subdirectory, also
create one stub subdirectory, which will include accelerator's stub
files.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <1496383606-18060-5-git-send-email-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs                        |  1 +
 Makefile.target                      |  4 +---
 accel/Makefile.objs                  |  2 ++
 accel/kvm/Makefile.objs              |  1 +
 kvm-all.c => accel/kvm/kvm-all.c     |  2 +-
 accel/kvm/trace-events               | 15 +++++++++++++++
 accel/stubs/Makefile.objs            |  1 +
 kvm-stub.c => accel/stubs/kvm-stub.c |  0
 trace-events                         | 13 -------------
 9 files changed, 22 insertions(+), 17 deletions(-)
 create mode 100644 accel/kvm/Makefile.objs
 rename kvm-all.c => accel/kvm/kvm-all.c (99%)
 create mode 100644 accel/kvm/trace-events
 create mode 100644 accel/stubs/Makefile.objs
 rename kvm-stub.c => accel/stubs/kvm-stub.c (100%)

diff --git a/Makefile.objs b/Makefile.objs
index 871eca8..6e5c706 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -163,6 +163,7 @@ trace-events-subdirs += qom
 trace-events-subdirs += linux-user
 trace-events-subdirs += qapi
 trace-events-subdirs += accel/tcg
+trace-events-subdirs += accel/kvm
 
 trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
 
diff --git a/Makefile.target b/Makefile.target
index 73cd9c6..3d49f29 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -88,7 +88,7 @@ all: $(PROGS) stap
 
 #########################################################
 # cpu emulator library
-obj-y = exec.o
+obj-y += exec.o
 obj-y += accel/
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
 obj-y += tcg/tcg-common.o tcg/tcg-runtime.o
@@ -99,7 +99,6 @@ obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
-obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 
 obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decContext.o
 obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decNumber.o
@@ -140,7 +139,6 @@ ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
 obj-y += qtest.o bootdevice.o
 obj-y += hw/
-obj-$(CONFIG_KVM) += kvm-all.o
 obj-y += memory.o
 obj-y += memory_mapping.o
 obj-y += dump.o
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 11ad823..cd5702f 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -1,2 +1,4 @@
 obj-$(CONFIG_SOFTMMU) += accel.o
+obj-y += kvm/
 obj-y += tcg/
+obj-y += stubs/
diff --git a/accel/kvm/Makefile.objs b/accel/kvm/Makefile.objs
new file mode 100644
index 0000000..85351e7
--- /dev/null
+++ b/accel/kvm/Makefile.objs
@@ -0,0 +1 @@
+obj-$(CONFIG_KVM) += kvm-all.o
diff --git a/kvm-all.c b/accel/kvm/kvm-all.c
similarity index 99%
rename from kvm-all.c
rename to accel/kvm/kvm-all.c
index 98ad151..75feffa 100644
--- a/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -36,7 +36,7 @@
 #include "exec/ram_addr.h"
 #include "exec/address-spaces.h"
 #include "qemu/event_notifier.h"
-#include "trace-root.h"
+#include "trace.h"
 #include "hw/irq.h"
 
 #include "hw/boards.h"
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
new file mode 100644
index 0000000..f89ba55
--- /dev/null
+++ b/accel/kvm/trace-events
@@ -0,0 +1,15 @@
+# Trace events for debugging and performance instrumentation
+
+# kvm-all.c
+kvm_ioctl(int type, void *arg) "type 0x%x, arg %p"
+kvm_vm_ioctl(int type, void *arg) "type 0x%x, arg %p"
+kvm_vcpu_ioctl(int cpu_index, int type, void *arg) "cpu_index %d, type 0x%x, arg %p"
+kvm_run_exit(int cpu_index, uint32_t reason) "cpu_index %d, reason %d"
+kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
+kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
+kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
+kvm_irqchip_commit_routes(void) ""
+kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
+kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
+kvm_irqchip_release_virq(int virq) "virq %d"
+
diff --git a/accel/stubs/Makefile.objs b/accel/stubs/Makefile.objs
new file mode 100644
index 0000000..bd5794f
--- /dev/null
+++ b/accel/stubs/Makefile.objs
@@ -0,0 +1 @@
+obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
diff --git a/kvm-stub.c b/accel/stubs/kvm-stub.c
similarity index 100%
rename from kvm-stub.c
rename to accel/stubs/kvm-stub.c
diff --git a/trace-events b/trace-events
index 62d8100..bae63fd 100644
--- a/trace-events
+++ b/trace-events
@@ -55,19 +55,6 @@ dma_complete(void *dbs, int ret, void *cb) "dbs=%p ret=%d cb=%p"
 dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
 dma_map_wait(void *dbs) "dbs=%p"
 
-# kvm-all.c
-kvm_ioctl(int type, void *arg) "type 0x%x, arg %p"
-kvm_vm_ioctl(int type, void *arg) "type 0x%x, arg %p"
-kvm_vcpu_ioctl(int cpu_index, int type, void *arg) "cpu_index %d, type 0x%x, arg %p"
-kvm_run_exit(int cpu_index, uint32_t reason) "cpu_index %d, reason %d"
-kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
-kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
-kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
-kvm_irqchip_commit_routes(void) ""
-kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d virq %d"
-kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
-kvm_irqchip_release_virq(int virq) "virq %d"
-
 # memory.c
 memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
 memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr %#"PRIx64" value %#"PRIx64" size %u"
-- 
1.8.3.1
