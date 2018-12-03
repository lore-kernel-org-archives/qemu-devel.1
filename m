Received: from eggs.gnu.org ([2001:4830:134:3::10]:58710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1gTf6D-00081l-HV
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 22:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1gTf69-0001wB-DY
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 22:40:45 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56436 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
	id 1gTf69-0001sF-2p
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 22:40:41 -0500
From: Zheng Xiang <zhengxiang9@huawei.com>
Date: Mon, 3 Dec 2018 11:38:53 +0800
Message-ID: <20181203033853.31488-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] pcie: set link state inactive/active after hot
 unplug/plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Cc: wanghaibin.wang@huawei.com, Zheng Xiang <zhengxiang9@huawei.com>, Zheng Xiang <xiang.zheng@linaro.com>

When VM boots from the latest version of linux kernel, after
hot-unpluging virtio-blk disks which are hotplugged into
pcie-root-port, the VM's dmesg log shows:

[  151.046242] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0001 from Slot Status
[  151.046365] pciehp 0000:00:05.0:pcie004: Slot(0-3): Attention button pressed
[  151.046369] pciehp 0000:00:05.0:pcie004: Slot(0-3): Powering off due to button press
[  151.046420] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  151.046425] pciehp 0000:00:05.0:pcie004: pciehp_green_led_blink: SLOTCTRL a8 write cmd 200
[  151.046464] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  151.046468] pciehp 0000:00:05.0:pcie004: pciehp_set_attention_status: SLOTCTRL a8 write cmd c0
[  156.163421] pciehp 0000:00:05.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 2f1
[  156.163427] pciehp 0000:00:05.0:pcie004: pciehp_unconfigure_device: domain:bus:dev = 0000:06:00
[  156.198736] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  156.198772] pciehp 0000:00:05.0:pcie004: pciehp_power_off_slot: SLOTCTRL a8 write cmd 400
[  157.224124] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0018 from Slot Status
[  157.224194] pciehp 0000:00:05.0:pcie004: pciehp_green_led_off: SLOTCTRL a8 write cmd 300
[  157.224220] pciehp 0000:00:05.0:pcie004: pciehp_check_link_active: lnk_status = 2011
[  157.224223] pciehp 0000:00:05.0:pcie004: Slot(0-3): Link Up
[  157.224233] pciehp 0000:00:05.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 7f1
[  157.224281] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  157.224285] pciehp 0000:00:05.0:pcie004: pciehp_power_on_slot: SLOTCTRL a8 write cmd 0
[  157.224300] pciehp 0000:00:05.0:pcie004: __pciehp_link_set: lnk_ctrl = 0
[  157.224336] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  157.224339] pciehp 0000:00:05.0:pcie004: pciehp_green_led_blink: SLOTCTRL a8 write cmd 200
[  159.739294] pci 0000:06:00.0 id reading try 50 times with interval 20 ms to get ffffffff
[  159.739315] pciehp 0000:00:05.0:pcie004: pciehp_check_link_status: lnk_status = 2011
[  159.739318] pciehp 0000:00:05.0:pcie004: Failed to check link status
[  159.739371] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  159.739394] pciehp 0000:00:05.0:pcie004: pciehp_power_off_slot: SLOTCTRL a8 write cmd 400
[  160.771426] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  160.771452] pciehp 0000:00:05.0:pcie004: pciehp_green_led_off: SLOTCTRL a8 write cmd 300
[  160.771495] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  160.771499] pciehp 0000:00:05.0:pcie004: pciehp_set_attention_status: SLOTCTRL a8 write cmd 40
[  160.771535] pciehp 0000:00:05.0:pcie004: pending interrupts 0x0010 from Slot Status
[  160.771539] pciehp 0000:00:05.0:pcie004: pciehp_green_led_off: SLOTCTRL a8 write cmd 300

After analyzing the log information, it seems that qemu doesn't
change the Link Status from active to inactive after hot-unplug.
This results in the abnormal log after the linux kernel commit
d331710ea78fea merged.

Furthermore, If I hotplug the same virtio-blk disk after hot-unplug,
the virtio-blk would turn on and then back off.

So this patch set the Link Status inactive after hot-unplug and
active after hot-plug.

Signed-off-by: Zheng Xiang <zhengxiang9@huawei.com>
Signed-off-by: Zheng Xiang <xiang.zheng@linaro.com>
Cc: Wang Haibin <wanghaibin.wang@huawei.com>
---
 hw/pci/pcie.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6c91bd4..66b73b8 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -345,6 +345,10 @@ void pcie_cap_slot_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (!dev->hotplugged) {
         pci_word_test_and_set_mask(exp_cap + PCI_EXP_SLTSTA,
                                    PCI_EXP_SLTSTA_PDS);
+        if (pci_dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
+            pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                                       PCI_EXP_LNKSTA_DLLLA);
+        }
         return;
     }
 
@@ -355,6 +359,10 @@ void pcie_cap_slot_hotplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (pci_get_function_0(pci_dev)) {
         pci_word_test_and_set_mask(exp_cap + PCI_EXP_SLTSTA,
                                    PCI_EXP_SLTSTA_PDS);
+        if (pci_dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
+            pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                                       PCI_EXP_LNKSTA_DLLLA);
+        }
         pcie_cap_slot_event(PCI_DEVICE(hotplug_dev),
                             PCI_EXP_HP_EV_PDC | PCI_EXP_HP_EV_ABP);
     }
@@ -531,6 +539,10 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
 
         pci_word_test_and_clear_mask(exp_cap + PCI_EXP_SLTSTA,
                                      PCI_EXP_SLTSTA_PDS);
+        if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA) {
+            pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+                                         PCI_EXP_LNKSTA_DLLLA);
+        }
         pci_word_test_and_set_mask(exp_cap + PCI_EXP_SLTSTA,
                                        PCI_EXP_SLTSTA_PDC);
     }
-- 
1.8.3.1
