Received: from eggs.gnu.org ([2001:4830:134:3::10]:48763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d5Nip-0003fT-3T
	for qemu-devel@nongnu.org; Mon, 01 May 2017 22:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d5Nik-00088p-CO
	for qemu-devel@nongnu.org; Mon, 01 May 2017 22:39:27 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:36555)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lu.zhipeng@zte.com.cn>) id 1d5Nii-00086j-CZ
	for qemu-devel@nongnu.org; Mon, 01 May 2017 22:39:22 -0400
From: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Date: Tue, 2 May 2017 10:38:11 +0800
Message-Id: <1493692691-30801-1-git-send-email-lu.zhipeng@zte.com.cn>
Subject: [Qemu-devel] [PATCH] hmp: add 'info virtio-pci-status id' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, mst@redhat.com, marcel@redhat.com
Cc: qemu-devel@nongnu.org, ZhiPeng Lu <lu.zhipeng@zte.com.cn>

Add command to  query a virtio pci device status.
we can get id of the virtio pci device by 'info pci' command.
HMP Test case:
    ==============
    virsh # qemu-monitor-command --hmp 3 info pci
      Bus  0, device   3, function 0:
        Ethernet controller: PCI device 1af4:1000
          IRQ 11.
          BAR0: I/O at 0xc000 [0xc03f].
          BAR1: 32 bit memory at 0xfebd1000 [0xfebd1fff].
          BAR4: 64 bit prefetchable memory at 0xfe000000 [0xfe003fff].
          BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
          id "net0"
      Bus  0, device   4, function 0:
        USB controller: PCI device 8086:24cd
          IRQ 11.
          BAR0: 32 bit memory at 0xfebd2000 [0xfebd2fff].
          id "usb"
    virsh # qemu-monitor-command 3  --hmp "info virtio-pci-status net0"
    status=15

    virsh # qemu-monitor-command 3  --hmp "info virtio-pci-status usb"
    the 'info virtio_pci_status' command only supports virtio pci devices

Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
---
 hmp-commands-info.hx    | 14 ++++++++++++++
 hw/pci/pci-stub.c       |  6 ++++++
 hw/virtio/virtio-pci.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/sysemu.h |  1 +
 4 files changed, 68 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index a53f105..7b9c4db 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -815,6 +815,20 @@ ETEXI
         .cmd = hmp_info_vm_generation_id,
     },
 
+    {
+        .name       = "virtio-pci-status",
+        .args_type  = "id:s",
+        .params     = "id",
+        .help       = "show virtio pci device  status",
+        .cmd        = hmp_info_virtio_pci_status,
+    },
+
+STEXI
+@item info virtio-pci-status  @var{id}
+@findex virtio-pci-status
+Show status about virtio pci device
+ETEXI
+
 STEXI
 @end table
 ETEXI
diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index 36d2c43..3609a52 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -35,3 +35,9 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "PCI devices not supported\n");
 }
+
+void hmp_info_virtio_pci_status(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "PCI devices not supported\n");
+}
+
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index f9b7244..5fa862b 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -37,6 +37,7 @@
 #include "qemu/range.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/visitor.h"
+#include "monitor/monitor.h"
 
 #define VIRTIO_PCI_REGION_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_present(dev))
 
@@ -50,6 +51,7 @@ static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
                                VirtIOPCIProxy *dev);
 static void virtio_pci_reset(DeviceState *qdev);
 
+static void query_virtio_pci_status(Monitor *mon, const char *id);
 /* virtio device */
 /* DeviceState to VirtIOPCIProxy. For use off data-path. TODO: use QOM. */
 static inline VirtIOPCIProxy *to_virtio_pci_proxy(DeviceState *d)
@@ -2556,6 +2558,51 @@ static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
                         virtio_bus_name);
 }
 
+static void query_virtio_pci_status(Monitor *mon, const char *id)
+{
+    int ret = 0, i = 0;
+    PCIDevice *dev = NULL;
+    hwaddr addr = 0;
+    uint8_t val = 0;
+    const char *devtype = NULL;
+
+    ret = pci_qdev_find_device(id, &dev);
+    if (ret) {
+        monitor_printf(mon, "Can not find device %s\n", id);
+        return;
+    }
+    devtype = object_get_typename(OBJECT(dev));
+    if (strncmp("virtio-", devtype, 7) == 0) {
+        for (i = 0; i < PCI_NUM_REGIONS; i++) {
+            if (dev->io_regions[i].type == PCI_BASE_ADDRESS_SPACE_IO) {
+                addr = dev->io_regions[i].addr;
+                break;
+            }
+        }
+        if (addr != -1 && addr != 0) {
+            address_space_rw(&address_space_io, addr + VIRTIO_PCI_STATUS,
+            MEMTXATTRS_UNSPECIFIED, &val, 1, 0);
+            if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
+                fprintf(stderr, "driver is ok\n");
+            } else {
+                fprintf(stderr, "driver is not ok\n");
+            }
+            monitor_printf(mon, "status=%d", val);
+        } else {
+            monitor_printf(mon, "status=%d", val);
+        }
+    } else {
+        monitor_printf(mon, "the 'info virtio_pci_status' command "
+           "only supports virtio pci devices");
+    }
+}
+
+void hmp_info_virtio_pci_status(Monitor *mon, const QDict *qdict)
+{
+    const char *id = qdict_get_try_str(qdict, "id");
+    query_virtio_pci_status(mon, id);
+}
+
 static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *bus_class = BUS_CLASS(klass);
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 576c7ce..de66cc0 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -238,4 +238,5 @@ extern QemuOptsList qemu_net_opts;
 extern QemuOptsList qemu_global_opts;
 extern QemuOptsList qemu_mon_opts;
 
+extern void hmp_info_virtio_pci_status(Monitor *mon, const QDict *qdict);
 #endif
-- 
1.8.3.1
