Received: from eggs.gnu.org ([2001:4830:134:3::10]:54328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1db1Gm-0007pN-Hc
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1db1Gj-0006f4-Vk
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:09:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1db1Gj-0006e9-Q1
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:09:13 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 28 Jul 2017 11:09:05 +0200
Message-Id: <1501232945-195611-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.10] pc: make 'pc.rom' readonly when
 machine has PCI enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wang.yechao255@zte.com.cn, mst@redhat.com, dgilbert@redhat.com, peng.hao2@zte.com.cn

looking at bios ROM mapping in QEMU it seems that only isapc
(i.e. not PCI enabled machine) requires ROM being mapped as
RW in other cases BIOS is mapped as RO. Do the same for option
ROM 'pc.rom' when machine has PCI enabled.

As useful side-effect pc.rom MemoryRegion stops being
put in vhost memory map (filtered out by vhost_section()),
which reduces number of entries by 1.

Coincidentally it fixes migration failure reported in

"[PATCH V2]  vhost: fix a migration failed because of vhost region merge"

where following destination CLI with /sys/module/vhost/parameters/max_mem_regions = 8

export DIMMSCOUNT=6
QEMU -enable-kvm \
     -netdev type=tap,id=guest0,vhost=on,script=no,vhostforce \
     -device virtio-net-pci,netdev=guest0 \
     -m 256,slots=256,maxmem=2G \
     `i=0; while [ $i -lt $DIMMSCOUNT ]; do echo \
         "-object memory-backend-ram,id=m$i,size=128M \
          -device pc-dimm,id=d$i,memdev=m$i"; i=$(($i + 1)); \
     done`

will fail to startup with error:

 "-device pc-dimm,id=d5,memdev=m5: a used vhost backend has no free memory slots left"

while it's possible to add the 6th DIMM during hotplug
on source.

Issue is caused by the fact that number of entries in vhost map
is bigger on 1 entry, when -device is processed, than
after guest boots up, and that offending entry belongs to
'pc.rom', it's not like vhost intends to do IO in ROM range
so making it RO hides region from vhost and makes number
of entries in vhost memory map at -device/machine_done time
match number of entries after guest boots.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reported-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/i386/pc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e3fcd51..de459e2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1449,6 +1449,9 @@ void pc_memory_init(PCMachineState *pcms,
     option_rom_mr = g_malloc(sizeof(*option_rom_mr));
     memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
                            &error_fatal);
+    if (pcmc->pci_enabled) {
+        memory_region_set_readonly(option_rom_mr, true);
+    }
     vmstate_register_ram_global(option_rom_mr);
     memory_region_add_subregion_overlap(rom_memory,
                                         PC_ROM_MIN_VGA,
-- 
2.7.4
