Received: from eggs.gnu.org ([209.51.188.92]:59612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLS-0001p5-HB
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1h1nLQ-0004ss-C2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1h1nLQ-0004r8-2O
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:21:32 -0500
From: elena.ufimtseva@oracle.com
Date: Wed,  6 Mar 2019 23:21:09 -0800
Message-Id: <20190307072109.8334-1-elena.ufimtseva@oracle.com>
Subject: [Qemu-devel] [multiprocess RFC PATCH 06/37] multi-process: build
 system for remote device process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, kwolf@redhat.com, mreitz@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, fam@euphon.net, quintela@redhat.com, dgilbert@redhat.com, afaerber@suse.de

From: Jagannathan Raman <jag.raman@oracle.com>

Modify Makefile to support the building of the remote
device process. Implements main() function of remote
device process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 Makefile                |  5 ++++-
 Makefile.objs           | 22 ++++++++++++++++++++++
 Makefile.target         | 50 +++++++++++++++++++++++++++++++++++++++++++++++--
 backends/Makefile.objs  |  2 ++
 block/Makefile.objs     |  2 ++
 hw/Makefile.objs        |  7 +++++++
 hw/block/Makefile.objs  |  2 ++
 hw/core/Makefile.objs   | 14 ++++++++++++++
 hw/nvram/Makefile.objs  |  2 ++
 hw/pci/Makefile.objs    |  4 ++++
 hw/scsi/Makefile.objs   |  2 ++
 migration/Makefile.objs |  2 ++
 qom/Makefile.objs       |  4 ++++
 remote/Makefile.objs    |  1 +
 remote/remote-main.c    | 35 ++++++++++++++++++++++++++++++++++
 15 files changed, 151 insertions(+), 3 deletions(-)
 create mode 100644 remote/Makefile.objs
 create mode 100644 remote/remote-main.c

diff --git a/Makefile b/Makefile
index 2208bde..e325297 100644
--- a/Makefile
+++ b/Makefile
@@ -378,6 +378,8 @@ dummy := $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
+                remote-pci-obj-y \
+                remote-lsi-obj-y \
                 common-obj-m \
                 ui-obj-y \
                 ui-obj-m \
@@ -459,7 +461,8 @@ subdir-capstone: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))
 
 $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) $(slirp-obj-y) \
-	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
+	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY)) \
+	$(remote-pci-obj-y) $(remote-lsi-obj-y)
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
diff --git a/Makefile.objs b/Makefile.objs
index 6e91ee5..702acc8 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -22,6 +22,28 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
 block-obj-m = block/
 
+#########################################################
+# remote-pci-obj-y is common code used by remote devices
+
+remote-pci-obj-$(CONFIG_MPQEMU) += hw/
+remote-pci-obj-$(CONFIG_MPQEMU) += qom/
+remote-pci-obj-$(CONFIG_MPQEMU) += backends/
+remote-pci-obj-$(CONFIG_MPQEMU) += block/
+remote-pci-obj-$(CONFIG_MPQEMU) += migration/
+remote-pci-obj-$(CONFIG_MPQEMU) += remote/
+
+remote-pci-obj-$(CONFIG_MPQEMU) += cpus-common.o
+remote-pci-obj-$(CONFIG_MPQEMU) += dma-helpers.o
+remote-pci-obj-$(CONFIG_MPQEMU) += blockdev.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qdev-monitor.o
+remote-pci-obj-$(CONFIG_MPQEMU) += bootdevice.o
+remote-pci-obj-$(CONFIG_MPQEMU) += iothread.o
+
+##############################################################
+# remote-lsi-obj-y is code used to implement remote LSI device
+
+remote-lsi-obj-$(CONFIG_MPQEMU) += hw/
+
 #######################################################################
 # crypto-obj-y is code used by both qemu system emulation and qemu-img
 
diff --git a/Makefile.target b/Makefile.target
index 3b79e70..81335c6 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -33,7 +33,12 @@ QEMU_PROG_BUILD = $(QEMU_PROG)
 endif
 endif
 
-PROGS=$(QEMU_PROG) $(QEMU_PROGW)
+ifdef CONFIG_MPQEMU
+SCSI_DEV_PROG=qemu-scsi-dev
+SCSI_DEV_BUILD = $(SCSI_DEV_PROG)
+endif
+
+PROGS=$(QEMU_PROG) $(QEMU_PROGW) $(SCSI_DEV_PROG)
 STPFILES=
 
 # Makefile Tests
@@ -115,6 +120,16 @@ obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/kvm-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/tcg-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/hax-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/whpx-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/vl-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/net-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/monitor.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/replay.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/xen-mapcache.o
+
 #########################################################
 # Linux user emulator target
 
@@ -170,11 +185,22 @@ endif # CONFIG_SOFTMMU
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
+dummy := $(call unnest-vars,..,remote-pci-tgt-obj-y)
+all-remote-pci-obj-y := $(remote-pci-tgt-obj-y)
+
+all-remote-pci-obj-y += memory.o
+all-remote-pci-obj-y += exec.o
+all-remote-pci-obj-y += numa.o
+all-remote-pci-obj-y += ioport.o
+all-remote-pci-obj-y += cpus.o
+
 target-obj-y :=
 block-obj-y :=
 common-obj-y :=
 chardev-obj-y :=
 slirp-obj-y :=
+remote-pci-obj-y :=
+remote-lsi-obj-y :=
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call unnest-vars,,target-obj-y)
 target-obj-y-save := $(target-obj-y)
@@ -189,7 +215,9 @@ dummy := $(call unnest-vars,.., \
                io-obj-y \
                common-obj-y \
                common-obj-m \
-               slirp-obj-y)
+               slirp-obj-y \
+               remote-pci-obj-y \
+               remote-lsi-obj-y)
 target-obj-y := $(target-obj-y-save)
 all-obj-y += $(common-obj-y)
 all-obj-y += $(target-obj-y)
@@ -201,7 +229,18 @@ all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(slirp-obj-y)
 
+all-remote-pci-obj-y += $(authz-obj-y)
+all-remote-pci-obj-y += $(block-obj-y)
+all-remote-pci-obj-y += $(crypto-obj-y)
+all-remote-pci-obj-y += $(io-obj-y)
+all-remote-pci-obj-y += $(chardev-obj-y)
+all-remote-pci-obj-y += $(remote-pci-obj-y)
+
+
+all-remote-lsi-obj-y += $(all-remote-pci-obj-y) $(remote-lsi-obj-y)
+
 $(QEMU_PROG_BUILD): config-devices.mak
+$(SCSI_DEV_BUILD): config-devices.mak
 
 COMMON_LDADDS = ../libqemuutil.a
 
@@ -213,6 +252,13 @@ ifdef CONFIG_DARWIN
 	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
 endif
 
+$(SCSI_DEV_BUILD): $(all-remote-lsi-obj-y) $(COMMON_LDADDS)
+	$(call LINK, $(filter-out %.mak, $^))
+ifdef CONFIG_DARWIN
+	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ","$(TARGET_DIR)$@")
+	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
+endif
+
 gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
 	$(call quiet-command,rm -f $@ && $(SHELL) $(SRC_PATH)/scripts/feature_to_c.sh $@ $(TARGET_XML_FILES),"GEN","$(TARGET_DIR)$@")
 
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index ff619d3..47c4161 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -15,3 +15,5 @@ common-obj-$(CONFIG_VHOST_CRYPTO) += cryptodev-vhost-user.o
 endif
 
 common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += hostmem.o
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 7a81892..cfc7719 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -63,3 +63,5 @@ qcow.o-libs        := -lz
 linux-aio.o-libs   := -laio
 parallels.o-cflags := $(LIBXML2_CFLAGS)
 parallels.o-libs   := $(LIBXML2_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) += stream.o
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index e2fcd6a..4cbfdff 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -39,3 +39,10 @@ devices-dirs-$(CONFIG_SOFTMMU) += smbios/
 devices-dirs-y += core/
 common-obj-y += $(devices-dirs-y)
 obj-y += $(devices-dirs-y)
+
+remote-pci-obj-$(CONFIG_MPQEMU) += core/
+remote-pci-obj-$(CONFIG_MPQEMU) += block/
+remote-pci-obj-$(CONFIG_MPQEMU) += pci/
+remote-pci-obj-$(CONFIG_MPQEMU) += nvram/
+
+remote-lsi-obj-$(CONFIG_MPQEMU) += scsi/
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index e206b8e..d3bafab 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -14,3 +14,5 @@ obj-$(CONFIG_SH4) += tc58128.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
 obj-$(CONFIG_VIRTIO_BLK) += dataplane/
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += block.o cdrom.o hd-geometry.o
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index a799c83..3e3afaa 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -22,3 +22,17 @@ common-obj-$(CONFIG_SOFTMMU) += split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
 common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
 common-obj-$(CONFIG_SOFTMMU) += null-machine.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += qdev-properties.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qdev.o
+remote-pci-obj-$(CONFIG_MPQEMU) += bus.o
+remote-pci-obj-$(CONFIG_MPQEMU) += irq.o
+remote-pci-obj-$(CONFIG_MPQEMU) += hotplug.o
+remote-pci-obj-$(CONFIG_MPQEMU) += machine.o
+remote-pci-obj-$(CONFIG_MPQEMU) += fw-path-provider.o
+remote-pci-obj-$(CONFIG_MPQEMU) += reset.o
+remote-pci-obj-$(CONFIG_MPQEMU) += sysbus.o
+remote-pci-obj-$(CONFIG_MPQEMU) += loader.o
+remote-pci-obj-$(CONFIG_MPQEMU) += nmi.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qdev-properties-system.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qdev-fw.o
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index 26f7b4c..9802a31 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -6,3 +6,5 @@ common-obj-y += chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
 obj-$(CONFIG_PSERIES) += spapr_nvram.o
 obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += fw_cfg.o
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index 9f905e6..f62025c 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -7,3 +7,7 @@ common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o pcie_port.o
 
 common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
 common-obj-$(CONFIG_ALL) += pci-stub.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += pci.o pci_bridge.o
+remote-pci-obj-$(CONFIG_MPQEMU) += msi.o msix.o
+remote-pci-obj-$(CONFIG_MPQEMU) += pcie.o
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 45167ba..3052650 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -13,3 +13,5 @@ obj-y += virtio-scsi.o virtio-scsi-dataplane.o
 obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-common.o vhost-scsi.o
 obj-$(CONFIG_VHOST_USER_SCSI) += vhost-scsi-common.o vhost-user-scsi.o
 endif
+
+remote-lsi-obj-$(CONFIG_MPQEMU) += scsi-generic.o scsi-bus.o lsi53c895a.o scsi-disk.o emulation.o
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index a4f3baf..016b6ab 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -13,3 +13,5 @@ common-obj-$(CONFIG_RDMA) += rdma.o
 common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
 rdma.o-libs := $(RDMA_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) += qemu-file.o vmstate.o qjson.o vmstate-types.o
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index 516349e..f0392c2 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -2,3 +2,7 @@ qom-obj-y = object.o container.o qom-qobject.o
 qom-obj-y += object_interfaces.o
 
 common-obj-y = cpu.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += object.o qom-qobject.o container.o
+remote-pci-obj-$(CONFIG_MPQEMU) += object_interfaces.o
+remote-pci-obj-$(CONFIG_MPQEMU) += cpu.o
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
new file mode 100644
index 0000000..a9b2256
--- /dev/null
+++ b/remote/Makefile.objs
@@ -0,0 +1 @@
+remote-pci-obj-$(CONFIG_MPQEMU) += remote-main.o
diff --git a/remote/remote-main.c b/remote/remote-main.c
new file mode 100644
index 0000000..53c2aa5
--- /dev/null
+++ b/remote/remote-main.c
@@ -0,0 +1,35 @@
+/*
+ * Remote device initialization
+ *
+ * Copyright 2019, Oracle and/or its affiliates. All rights reserved.
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
-- 
1.8.3.1
