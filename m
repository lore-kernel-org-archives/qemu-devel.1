Received: from eggs.gnu.org ([2001:4830:134:3::10]:43903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gSOCe-0000Qm-7p
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gSOCa-0001DY-Ri
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:26:08 -0500
Received: from m12-13.163.com ([220.181.12.13]:34922)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gSOCY-000173-CV
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:26:04 -0500
From: Li Qiang <liq3ea@163.com>
Date: Thu, 29 Nov 2018 07:25:52 -0800
Message-Id: <20181129152552.14363-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] hw: scsi: dc390: add device unrealize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com, Li Qiang <liq3ea@163.com>

Currently the dc390 device has no unrealize function. This
can cause memory leak when hotplug/unplug device. Also more
serious, it will trigger an assert when rehotplug. 
The backtrack is following:

qemu-system-x86_64: migration/savevm.c:734: vmstate_register_with_alias_id: Assertion `!se->compat || se->instance_id == 0' failed.

Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
[Switching to Thread 0x7ffff7fce280 (LWP 5721)]
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
51	../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
1  0x00007ffff5a10801 in __GI_abort () at abort.c:79
2  0x00007ffff5a0039a in __assert_fail_base (fmt=0x7ffff5b877d8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
    assertion=assertion@entry=0x555555f67f68 "!se->compat || se->instance_id == 0",
    file=file@entry=0x555555f67d07 "migration/savevm.c", line=line@entry=734,
    function=function@entry=0x555555f68e50 <__PRETTY_FUNCTION__.32111> "vmstate_register_with_alias_id")
    at assert.c:92
3  0x00007ffff5a00412 in __GI___assert_fail (assertion=0x555555f67f68 "!se->compat || se->instance_id == 0",
    file=0x555555f67d07 "migration/savevm.c", line=734,
    function=0x555555f68e50 <__PRETTY_FUNCTION__.32111> "vmstate_register_with_alias_id") at assert.c:101
4  0x0000555555bfc1d2 in vmstate_register_with_alias_id (dev=0x5555577fff60, instance_id=-1,
    vmsd=0x555556533840 <vmstate_eeprom>, opaque=0x555556e82ad0, alias_id=-1, required_for_version=0, errp=0x0)
    at migration/savevm.c:734
5  0x0000555555b3ab79 in vmstate_register (dev=0x5555577fff60, instance_id=0, vmsd=0x555556533840 <vmstate_eeprom>,
    opaque=0x555556e82ad0) at /home/test/qemu/include/migration/vmstate.h:1067
6  0x0000555555b3b106 in eeprom93xx_new (dev=0x5555577fff60, nwords=64) at hw/nvram/eeprom93xx.c:323
7  0x0000555555b8b587 in dc390_scsi_realize (dev=0x5555577fff60, errp=0x7fffffffd9f8) at hw/scsi/esp-pci.c:482
8  0x0000555555b4b62e in pci_qdev_realize (qdev=0x5555577fff60, errp=0x7fffffffda70) at hw/pci/pci.c:2038
9  0x0000555555a89cb2 in device_set_realized (obj=0x5555577fff60, value=true, errp=0x7fffffffdc40)
    at hw/core/qdev.c:826
10 0x0000555555c7fbe8 in property_set_bool (obj=0x5555577fff60, v=0x5555567d9c50, name=0x555555edda12 "realized",
    opaque=0x5555575a6170, errp=0x7fffffffdc40) at qom/object.c:1991
11 0x0000555555c7de64 in object_property_set (obj=0x5555577fff60, v=0x5555567d9c50, name=0x555555edda12 "realized",
    errp=0x7fffffffdc40) at qom/object.c:1183
12 0x0000555555c80f2a in object_property_set_qobject (obj=0x5555577fff60, value=0x555556e84be0,
    name=0x555555edda12 "realized", errp=0x7fffffffdc40) at qom/qom-qobject.c:27
13 0x0000555555c7e149 in object_property_set_bool (obj=0x5555577fff60, value=true, name=0x555555edda12 "realized",
    errp=0x7fffffffdc40) at qom/object.c:1249
14 0x00005555559d3207 in qdev_device_add (opts=0x5555573aab00, errp=0x7fffffffdcb0) at qdev-monitor.c:642
15 0x00005555559d39f0 in qmp_device_add (qdict=0x555556a15000, ret_data=0x0, errp=0x7fffffffdcf0)
---Type <return> to continue, or q <return> to quit---
    at qdev-monitor.c:822
16 0x0000555555a01e2a in hmp_device_add (mon=0x5555568b8000, qdict=0x555556a15000) at hmp.c:2067

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/scsi/esp-pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 419fc668ac..09d1331395 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -463,6 +463,14 @@ static void dc390_write_config(PCIDevice *dev,
     }
 }
 
+static void dc390_scsi_uninit(PCIDevice *dev)
+{
+    DC390State *pci = DC390(dev);
+
+    eeprom93xx_free(&dev->qdev, pci->eeprom);
+    esp_pci_scsi_uninit(dev);
+}
+
 static void dc390_scsi_realize(PCIDevice *dev, Error **errp)
 {
     DC390State *pci = DC390(dev);
@@ -510,6 +518,7 @@ static void dc390_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = dc390_scsi_realize;
+    k->exit = dc390_scsi_uninit;
     k->config_read = dc390_read_config;
     k->config_write = dc390_write_config;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-- 
2.17.1
