Received: from eggs.gnu.org ([209.51.188.92]:35945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6b-0000MG-PH
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6X-0004j2-Q2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6V-0004gI-Mc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A9FE356E4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:09:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BC51A5DA27
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:42 +0100
Message-Id: <20190311220843.4026-27-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/27] pc: Support firmware configuration with
 -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The PC machines put firmware in ROM by default.  To get it put into
flash memory (required by OVMF), you have to use -drive
if=3Dpflash,unit=3D0,... and optionally -drive if=3Dpflash,unit=3D1,...

Why two -drive?  This permits setting up one part of the flash memory
read-only, and the other part read/write.  It also makes upgrading
firmware on the host easier.  Below the hood, it creates two separate
flash devices, because we were too lazy to improve our flash device
models to support sector protection.

The problem at hand is to do the same with -blockdev somehow, as one
more step towards deprecating -drive.

Mapping -drive if=3Dnone,... to -blockdev is a solved problem.  With
if=3DT other than if=3Dnone, -drive additionally configures a block devic=
e
frontend.  For non-onboard devices, that part maps to -device.  Also a
solved problem.  For onboard devices such as PC flash memory, we have
an unsolved problem.

This is actually an instance of a wider problem: our general device
configuration interface doesn't cover onboard devices.  Instead, we have
a zoo of ad hoc interfaces that are much more limited.  One of them is
-drive, which we'd rather deprecate, but can't until we have suitable
replacements for all its uses.

Sadly, I can't attack the wider problem today.  So back to the narrow
problem.

My first idea was to reduce it to its solved buddy by using pluggable
instead of onboard devices for the flash memory.  Workable, but it
requires some extra smarts in firmware descriptors and libvirt.  Paolo
had an idea that is simpler for libvirt: keep the devices onboard, and
add machine properties for their block backends.

The implementation is less than straightforward, I'm afraid.

First, block backend properties are *qdev* properties.  Machines can't
have those, as they're not devices.  I could duplicate these qdev
properties as QOM properties, but I hate that.

More seriously, the properties do not belong to the machine, they
belong to the onboard flash devices.  Adding them to the machine would
then require bad magic to somehow transfer them to the flash devices.
Fortunately, QOM provides the means to handle exactly this case: add
alias properties to the machine that forward to the onboard devices'
properties.

Properties need to be created in .instance_init() methods.  For PC
machines, that's pc_machine_initfn().  To make alias properties work,
we need to create the onboard flash devices there, too.  Requires
several bug fixes, in the previous commits.  We also have to realize
the devices.  More on that below.

If the user sets pflash0, firmware resides in flash memory.
pc_system_firmware_init() maps and realizes the flash devices.

Else, firmware resides in ROM.  The onboard flash devices aren't used
then.  pc_system_firmware_init() destroys them unrealized, along with
the alias properties.

The existing code to pick up drives defined with -drive if=3Dpflash is
replaced by code to desugar into the machine properties.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <87ftrtux81.fsf@dusky.pond.sub.org>
---
 hw/i386/pc.c         |   2 +
 hw/i386/pc_sysfw.c   | 233 ++++++++++++++++++++++++++++---------------
 include/hw/i386/pc.h |   3 +
 3 files changed, 156 insertions(+), 82 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d8572d3c00..d71dc28ef6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2649,6 +2649,8 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbus_enabled =3D true;
     pcms->sata_enabled =3D true;
     pcms->pit_enabled =3D true;
+
+    pc_system_flash_create(pcms);
 }
=20
 static void pc_machine_reset(void)
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 785123252c..c628540774 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -40,6 +40,17 @@
=20
 #define BIOS_FILENAME "bios.bin"
=20
+/*
+ * We don't have a theoretically justifiable exact lower bound on the ba=
se
+ * address of any flash mapping. In practice, the IO-APIC MMIO range is
+ * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving f=
ree
+ * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8=
MB in
+ * size.
+ */
+#define FLASH_SIZE_LIMIT (8 * MiB)
+
+#define FLASH_SECTOR_SIZE 4096
+
 static void pc_isa_bios_init(MemoryRegion *rom_memory,
                              MemoryRegion *flash_mem,
                              int ram_size)
@@ -71,96 +82,118 @@ static void pc_isa_bios_init(MemoryRegion *rom_memor=
y,
     memory_region_set_readonly(isa_bios, true);
 }
=20
-#define FLASH_MAP_UNIT_MAX 2
+static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
+                                     const char *name,
+                                     const char *alias_prop_name)
+{
+    DeviceState *dev =3D qdev_create(NULL, TYPE_PFLASH_CFI01);
=20
-/* We don't have a theoretically justifiable exact lower bound on the ba=
se
- * address of any flash mapping. In practice, the IO-APIC MMIO range is
- * [0xFEE00000..0xFEE01000[ -- see IO_APIC_DEFAULT_ADDRESS --, leaving f=
ree
- * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8=
MB in
- * size.
- */
-#define FLASH_MAP_BASE_MIN ((hwaddr)(4 * GiB - 8 * MiB))
+    qdev_prop_set_uint64(dev, "sector-length", FLASH_SECTOR_SIZE);
+    qdev_prop_set_uint8(dev, "width", 1);
+    qdev_prop_set_string(dev, "name", name);
+    object_property_add_child(OBJECT(pcms), name, OBJECT(dev),
+                              &error_abort);
+    object_property_add_alias(OBJECT(pcms), alias_prop_name,
+                              OBJECT(dev), "drive", &error_abort);
+    return PFLASH_CFI01(dev);
+}
=20
-/* This function maps flash drives from 4G downward, in order of their u=
nit
- * numbers. The mapping starts at unit#0, with unit number increments of=
 1, and
- * stops before the first missing flash drive, or before
- * unit#FLASH_MAP_UNIT_MAX, whichever is reached first.
- *
- * Addressing within one flash drive is of course not reversed.
- *
- * An error message is printed and the process exits if:
- * - the size of the backing file for a flash drive is non-positive, or =
not a
- *   multiple of the required sector size, or
- * - the current mapping's base address would fall below FLASH_MAP_BASE_=
MIN.
+void pc_system_flash_create(PCMachineState *pcms)
+{
+    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
+
+    if (pcmc->pci_enabled) {
+        pcms->flash[0] =3D pc_pflash_create(pcms, "system.flash0",
+                                          "pflash0");
+        pcms->flash[1] =3D pc_pflash_create(pcms, "system.flash1",
+                                          "pflash1");
+    }
+}
+
+static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
+{
+    char *prop_name;
+    int i;
+    Object *dev_obj;
+
+    assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
+
+    for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
+        dev_obj =3D OBJECT(pcms->flash[i]);
+        if (!object_property_get_bool(dev_obj, "realized", &error_abort)=
) {
+            prop_name =3D g_strdup_printf("pflash%d", i);
+            object_property_del(OBJECT(pcms), prop_name, &error_abort);
+            g_free(prop_name);
+            object_unparent(dev_obj);
+            pcms->flash[i] =3D NULL;
+        }
+    }
+}
+
+/*
+ * Map the pcms->flash[] from 4GiB downward, and realize.
+ * Map them in descending order, i.e. pcms->flash[0] at the top,
+ * without gaps.
+ * Stop at the first pcms->flash[0] lacking a block backend.
+ * Set each flash's size from its block backend.  Fatal error if the
+ * size isn't a non-zero multiple of 4KiB, or the total size exceeds
+ * FLASH_SIZE_LIMIT.
  *
- * The drive with unit#0 (if available) is mapped at the highest address=
, and
- * it is passed to pc_isa_bios_init(). Merging several drives for isa-bi=
os is
+ * If pcms->flash[0] has a block backend, its memory is passed to
+ * pc_isa_bios_init().  Merging several flash devices for isa-bios is
  * not supported.
  */
-static void pc_system_flash_init(MemoryRegion *rom_memory)
+static void pc_system_flash_map(PCMachineState *pcms,
+                                MemoryRegion *rom_memory)
 {
-    int unit;
-    DriveInfo *pflash_drv;
+    hwaddr total_size =3D 0;
+    int i;
     BlockBackend *blk;
     int64_t size;
-    char *fatal_errmsg =3D NULL;
-    hwaddr phys_addr =3D 0x100000000ULL;
-    uint32_t sector_size =3D 4096;
     PFlashCFI01 *system_flash;
     MemoryRegion *flash_mem;
-    char name[64];
     void *flash_ptr;
     int ret, flash_size;
=20
-    for (unit =3D 0;
-         (unit < FLASH_MAP_UNIT_MAX &&
-          (pflash_drv =3D drive_get(IF_PFLASH, 0, unit)) !=3D NULL);
-         ++unit) {
-        blk =3D blk_by_legacy_dinfo(pflash_drv);
+    assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
+
+    for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
+        system_flash =3D pcms->flash[i];
+        blk =3D pflash_cfi01_get_blk(system_flash);
+        if (!blk) {
+            break;
+        }
         size =3D blk_getlength(blk);
         if (size < 0) {
-            fatal_errmsg =3D g_strdup_printf("failed to get backing file=
 size");
-        } else if (size =3D=3D 0) {
-            fatal_errmsg =3D g_strdup_printf("PC system firmware (pflash=
) "
-                               "cannot have zero size");
-        } else if ((size % sector_size) !=3D 0) {
-            fatal_errmsg =3D g_strdup_printf("PC system firmware (pflash=
) "
-                               "must be a multiple of 0x%x", sector_size=
);
-        } else if (phys_addr < size || phys_addr - size < FLASH_MAP_BASE=
_MIN) {
-            fatal_errmsg =3D g_strdup_printf("oversized backing file, pf=
lash "
-                               "segments cannot be mapped under "
-                               TARGET_FMT_plx, FLASH_MAP_BASE_MIN);
+            error_report("can't get size of block device %s: %s",
+                         blk_name(blk), strerror(-size));
+            exit(1);
         }
-        if (fatal_errmsg !=3D NULL) {
-            Location loc;
-
-            /* push a new, "none" location on the location stack; overwr=
ite its
-             * contents with the location saved in the option; print the=
 error
-             * (includes location); pop the top
-             */
-            loc_push_none(&loc);
-            if (pflash_drv->opts !=3D NULL) {
-                qemu_opts_loc_restore(pflash_drv->opts);
-            }
-            error_report("%s", fatal_errmsg);
-            loc_pop(&loc);
-            g_free(fatal_errmsg);
+        if (size =3D=3D 0 || size % FLASH_SECTOR_SIZE !=3D 0) {
+            error_report("system firmware block device %s has invalid si=
ze "
+                         "%" PRId64,
+                         blk_name(blk), size);
+            info_report("its size must be a non-zero multiple of 0x%x",
+                        FLASH_SECTOR_SIZE);
+            exit(1);
+        }
+        if ((hwaddr)size !=3D size
+            || total_size > HWADDR_MAX - size
+            || total_size + size > FLASH_SIZE_LIMIT) {
+            error_report("combined size of system firmware exceeds "
+                         "%" PRIu64 " bytes",
+                         FLASH_SIZE_LIMIT);
             exit(1);
         }
=20
-        phys_addr -=3D size;
+        total_size +=3D size;
+        qdev_prop_set_uint32(DEVICE(system_flash), "num-blocks",
+                             size / FLASH_SECTOR_SIZE);
+        qdev_init_nofail(DEVICE(system_flash));
+        sysbus_mmio_map(SYS_BUS_DEVICE(system_flash), 0,
+                        0x100000000ULL - total_size);
=20
-        /* pflash_cfi01_register() creates a deep copy of the name */
-        snprintf(name, sizeof name, "system.flash%d", unit);
-        system_flash =3D pflash_cfi01_register(phys_addr, name,
-                                             size, blk, sector_size,
-                                             1      /* width */,
-                                             0x0000 /* id0 */,
-                                             0x0000 /* id1 */,
-                                             0x0000 /* id2 */,
-                                             0x0000 /* id3 */,
-                                             0      /* be */);
-        if (unit =3D=3D 0) {
+        if (i =3D=3D 0) {
             flash_mem =3D pflash_cfi01_get_memory(system_flash);
             pc_isa_bios_init(rom_memory, flash_mem, size);
=20
@@ -235,23 +268,59 @@ void pc_system_firmware_init(PCMachineState *pcms,
                              MemoryRegion *rom_memory)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
-    bool isapc_ram_fw =3D !pcmc->pci_enabled;
+    int i;
     DriveInfo *pflash_drv;
+    BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
+    Location loc;
=20
-    pflash_drv =3D drive_get(IF_PFLASH, 0, 0);
-
-    if (isapc_ram_fw || pflash_drv =3D=3D NULL) {
-        /* When a pflash drive is not found, use rom-mode */
-        old_pc_system_rom_init(rom_memory, isapc_ram_fw);
+    if (!pcmc->pci_enabled) {
+        old_pc_system_rom_init(rom_memory, true);
         return;
     }
=20
-    if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
-        /* Older KVM cannot execute from device memory. So, flash memory
-         * cannot be used unless the readonly memory kvm capability is p=
resent. */
-        fprintf(stderr, "qemu: pflash with kvm requires KVM readonly mem=
ory support\n");
-        exit(1);
+    /* Map legacy -drive if=3Dpflash to machine properties */
+    for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
+        pflash_blk[i] =3D pflash_cfi01_get_blk(pcms->flash[i]);
+        pflash_drv =3D drive_get(IF_PFLASH, 0, i);
+        if (!pflash_drv) {
+            continue;
+        }
+        loc_push_none(&loc);
+        qemu_opts_loc_restore(pflash_drv->opts);
+        if (pflash_blk[i]) {
+            error_report("clashes with -machine");
+            exit(1);
+        }
+        pflash_blk[i] =3D blk_by_legacy_dinfo(pflash_drv);
+        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
+                            "drive", pflash_blk[i], &error_fatal);
+        loc_pop(&loc);
     }
=20
-    pc_system_flash_init(rom_memory);
+    /* Reject gaps */
+    for (i =3D 1; i < ARRAY_SIZE(pcms->flash); i++) {
+        if (pflash_blk[i] && !pflash_blk[i - 1]) {
+            error_report("pflash%d requires pflash%d", i, i - 1);
+            exit(1);
+        }
+    }
+
+    if (!pflash_blk[0]) {
+        /* Machine property pflash0 not set, use ROM mode */
+        old_pc_system_rom_init(rom_memory, false);
+    } else {
+        if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
+            /*
+             * Older KVM cannot execute from device memory. So, flash
+             * memory cannot be used unless the readonly memory kvm
+             * capability is present.
+             */
+            error_report("pflash with kvm requires KVM readonly memory s=
upport");
+            exit(1);
+        }
+
+        pc_system_flash_map(pcms, rom_memory);
+    }
+
+    pc_system_flash_cleanup_unused(pcms);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4f5ed7cefc..276ff15d4d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -6,6 +6,7 @@
 #include "hw/boards.h"
 #include "hw/isa/isa.h"
 #include "hw/block/fdc.h"
+#include "hw/block/flash.h"
 #include "net/net.h"
 #include "hw/i386/ioapic.h"
=20
@@ -39,6 +40,7 @@ struct PCMachineState {
     PCIBus *bus;
     FWCfgState *fw_cfg;
     qemu_irq *gsi;
+    PFlashCFI01 *flash[2];
=20
     /* Configuration options: */
     uint64_t max_ram_below_4g;
@@ -277,6 +279,7 @@ extern PCIDevice *piix4_dev;
 int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
=20
 /* pc_sysfw.c */
+void pc_system_flash_create(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_mem=
ory);
=20
 /* acpi-build.c */
--=20
2.17.2
