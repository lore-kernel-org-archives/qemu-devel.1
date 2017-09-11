Received: from eggs.gnu.org ([2001:4830:134:3::10]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1drUp3-0006A6-F7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1drUoz-0002EI-H0
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:45 -0400
Received: from mail-sn1nam01on0040.outbound.protection.outlook.com
	([104.47.32.40]:13620
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1drUoz-0002D8-8P
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:41 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 11 Sep 2017 12:52:56 -0700
Message-ID: <9cb1d23551898c9c9a5f84da6773e99871285120.1505158760.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1505158760.git.alistair.francis@xilinx.com>
References: <cover.1505158760.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 5/8] General warn report fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, pbonzini@redhat.com

Tidy up some of the warn_report() messages after having converted them
to use warn_report().

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
V4:
 - Small fixes

 block/vvfat.c               |  3 +--
 hw/arm/vexpress.c           |  2 +-
 hw/i386/xen/xen-mapcache.c  |  2 +-
 hw/mips/mips_malta.c        |  4 ++--
 hw/mips/mips_r4k.c          |  3 +--
 hw/s390x/s390-virtio.c      | 14 ++++++++------
 net/hub.c                   |  6 ++----
 net/net.c                   |  5 +++--
 target/i386/hax-mem.c       |  6 +++---
 target/ppc/translate_init.c |  3 +--
 ui/keymaps.c                |  3 +--
 11 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 6659a4a96a..cbabb36f62 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1227,8 +1227,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     switch (s->fat_type) {
     case 32:
-        warn_report("FAT32 has not been tested. "
-                    "You are welcome to do so!");
+        warn_report("FAT32 has not been tested. You are welcome to do so!");
         break;
     case 16:
     case 12:
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f72ee6658b..96c5eebeaf 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -494,7 +494,7 @@ static void vexpress_modify_dtb(const struct arm_boot_info *info, void *fdt)
          * happen with older device tree blobs.
          */
         warn_report("couldn't find interrupt controller in "
-                    "dtb; will not include virtio-mmio devices in the dtb.");
+                    "dtb; will not include virtio-mmio devices in the dtb");
     } else {
         int i;
         const hwaddr *map = daughterboard->motherboard_map;
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 91a4fd6984..baab93b614 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -127,7 +127,7 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
 
         if (rlimit_as.rlim_max != RLIM_INFINITY) {
             warn_report("QEMU's maximum size of virtual"
-                        " memory is not infinity.");
+                        " memory is not infinity");
         }
         if (rlimit_as.rlim_max < MCACHE_MAX_SIZE + NON_MCACHE_MEMORY_SIZE) {
             mapcache->max_mcache_size = rlimit_as.rlim_max -
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 233e2ee802..7d6e58348e 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -216,8 +216,8 @@ static void generate_eeprom_spd(uint8_t *eeprom, ram_addr_t ram_size)
     }
 
     if (ram_size) {
-        warn_report("SPD cannot represent final %dMB"
-                    " of SDRAM", (int)ram_size);
+        warn_report("SPD cannot represent final " RAM_ADDR_FMT "MB"
+                    " of SDRAM", ram_size);
     }
 
     /* fill in SPD memory information */
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 6ffb88fd70..b48a4d72ac 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -254,8 +254,7 @@ void mips_r4k_init(MachineState *machine)
 	}
     } else if (!qtest_enabled()) {
         /* not fatal */
-        warn_report("could not load MIPS bios '%s'",
-                    bios_name);
+        warn_report("could not load MIPS bios '%s'", bios_name);
     }
     g_free(filename);
 
diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
index 25781f04d8..0e91c465f2 100644
--- a/hw/s390x/s390-virtio.c
+++ b/hw/s390x/s390-virtio.c
@@ -141,9 +141,10 @@ void gtod_save(QEMUFile *f, void *opaque)
 
     r = s390_get_clock(&tod_high, &tod_low);
     if (r) {
-        warn_report("Unable to get guest clock for migration. "
-                    "Error code %d. Guest clock will not be migrated "
-                    "which could cause the guest to hang.", r);
+        warn_report("Unable to get guest clock for migration: %s",
+                    strerror(-r));
+        error_printf("Guest clock will not be migrated "
+                     "which could cause the guest to hang.");
         qemu_put_byte(f, S390_TOD_CLOCK_VALUE_MISSING);
         return;
     }
@@ -170,9 +171,10 @@ int gtod_load(QEMUFile *f, void *opaque, int version_id)
 
     r = s390_set_clock(&tod_high, &tod_low);
     if (r) {
-        warn_report("Unable to set guest clock value. "
-                    "s390_get_clock returned error %d. This could cause "
-                    "the guest to hang.", r);
+        warn_report("Unable to set guest clock for migration: %s",
+                    strerror(-r));
+        error_printf("Guest clock will not be restored "
+                     "which could cause the guest to hang.");
     }
 
     return 0;
diff --git a/net/hub.c b/net/hub.c
index 745a2168a1..14b4eec68f 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -310,8 +310,7 @@ void net_hub_check_clients(void)
         QLIST_FOREACH(port, &hub->ports, next) {
             peer = port->nc.peer;
             if (!peer) {
-                warn_report("hub port %s has no peer",
-                            port->nc.name);
+                warn_report("hub port %s has no peer", port->nc.name);
                 continue;
             }
 
@@ -334,8 +333,7 @@ void net_hub_check_clients(void)
             warn_report("vlan %d with no nics", hub->id);
         }
         if (has_nic && !has_host_dev) {
-            warn_report("vlan %d is not connected to host network",
-                        hub->id);
+            warn_report("vlan %d is not connected to host network", hub->id);
         }
     }
 }
diff --git a/net/net.c b/net/net.c
index 1301cdbd88..39ef546708 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1494,8 +1494,9 @@ void net_check_clients(void)
     QTAILQ_FOREACH(nc, &net_clients, next) {
         if (!nc->peer) {
             warn_report("%s %s has no peer",
-                        nc->info->type == NET_CLIENT_DRIVER_NIC ?
-                        "nic" : "netdev", nc->name);
+                        nc->info->type == NET_CLIENT_DRIVER_NIC
+                        ? "nic" : "netdev",
+                        nc->name);
         }
     }
 
diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
index 756f2dd268..27a0d214f2 100644
--- a/target/i386/hax-mem.c
+++ b/target/i386/hax-mem.c
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "exec/address-spaces.h"
 #include "exec/exec-all.h"
+#include "qemu/error-report.h"
 
 #include "target/i386/hax-i386.h"
 #include "qemu/queue.h"
@@ -178,9 +179,8 @@ static void hax_process_section(MemoryRegionSection *section, uint8_t flags)
     if (!memory_region_is_ram(mr)) {
         if (memory_region_is_romd(mr)) {
             /* HAXM kernel module does not support ROMD yet  */
-            warn_report("Ignoring ROMD region 0x%016" PRIx64
-                        "->0x%016" PRIx64 "", __func__, start_pa,
-                        start_pa + size);
+            warn_report("Ignoring ROMD region 0x%016" PRIx64 "->0x%016" PRIx64,
+                        start_pa, start_pa + size);
         }
         return;
     }
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 49190ec95a..466bf97347 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9321,8 +9321,7 @@ static void init_ppc_proc(PowerPCCPU *cpu)
     }
 #endif
     if (env->check_pow == NULL) {
-        warn_report("no power management check handler "
-                    "registered."
+        warn_report("no power management check handler registered."
                     " Attempt QEMU to crash very soon !");
     }
 }
diff --git a/ui/keymaps.c b/ui/keymaps.c
index a6cefdaff9..f9762d1497 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -198,8 +198,7 @@ int keysym2scancode(void *kbd_layout, int keysym)
     if (keysym < MAX_NORMAL_KEYCODE) {
         if (k->keysym2keycode[keysym] == 0) {
             trace_keymap_unmapped(keysym);
-            warn_report("no scancode found for keysym %d",
-                        keysym);
+            warn_report("no scancode found for keysym %d", keysym);
         }
         return k->keysym2keycode[keysym];
     } else {
-- 
2.11.0
