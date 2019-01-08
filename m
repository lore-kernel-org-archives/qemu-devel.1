Received: from eggs.gnu.org ([209.51.188.92]:48579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1ggkbk-0001Cs-MV
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1ggkbg-0003Ue-P4
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:11:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:5703)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1ggkbf-0003Ko-Pe
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:11:20 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Date: Tue,  8 Jan 2019 01:03:47 -0500
Message-Id: <20190108060348.3359-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] vfio: assign idstr for VFIO's mmaped regions
 for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, Zhao Yan <yan.y.zhao@intel.com>

if multiple regions in vfio are mmaped, their corresponding ramblocks
are like below, i.e. their idstrs are "".

(qemu) info ramblock
Block Name  PSize       Offset               Used            Total
pc.ram      4 KiB  0x0000000000000000 0x0000000020000000 0x0000000020000000
            4 KiB  0x0000000021100000 0x0000000020000000 0x0000000020000000
            4 KiB  0x0000000020900000 0x0000000000800000 0x0000000000800000
            4 KiB  0x0000000020240000 0x0000000000687000 0x0000000000687000
            4 KiB  0x00000000200c0000 0x0000000000178000 0x0000000000178000
pc.bios     4 KiB  0x0000000020000000 0x0000000000040000 0x0000000000040000
pc.rom      4 KiB  0x0000000020040000 0x0000000000020000 0x0000000000020000

This is because ramblocks' idstr are assigned by calling
vmstate_register_ram(), but memory region of type ram device ptr does not
call vmstate_register_ram().
vfio_region_mmap
        |->memory_region_init_ram_device_ptr
               |-> memory_region_init_ram_ptr

Without empty idstrs will cause problem to snapshot copying during
migration, because it uses ramblocks' idstr to identify ramblocks.
ram_save_setup {
  …
  RAMBLOCK_FOREACH(block) {
      qemu_put_byte(f, strlen(block->idstr));
      qemu_put_buffer(f, (uint8_t *)block->idstr,strlen(block->idstr));
      qemu_put_be64(f, block->used_length);
  }
  …
}
ram_load() {
    block = qemu_ram_block_by_name(id);
    if (block) {
        if (length != block->used_length) {
            qemu_ram_resize(block, length, &local_err);
        }
     ….
   }
}

Therefore, in this patch,
vmstate_register_ram() is called for memory region of type ram ptr,
also a unique vfioid is assigned to vfio devices across source
and target vms.
e.g. in source vm, use qemu parameter
-device
vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:00:02.0/
882cc4da-dede-11e7-9180-078a62063ab1,vfioid=igd

and in target vm, use qemu paramter
-device
vfio-pci,sysfsdev=/sys/bus/pci/devices/0000:00:02.0/
5ac1fb20-2bbf-4842-bb7e-36c58c3be9cd,vfioid=igd

Signed-off-by: Zhao Yan <yan.y.zhao@intel.com>
---
 hw/vfio/pci.c                 | 8 +++++++-
 include/hw/vfio/vfio-common.h | 1 +
 memory.c                      | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c0cb1ec289..7bc2ed0752 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2533,7 +2533,12 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     }
 
     for (i = VFIO_PCI_BAR0_REGION_INDEX; i < VFIO_PCI_ROM_REGION_INDEX; i++) {
-        char *name = g_strdup_printf("%s BAR %d", vbasedev->name, i);
+        char *name;
+        if (vbasedev->vfioid) {
+            name = g_strdup_printf("%s BAR %d", vbasedev->vfioid, i);
+        } else {
+            name = g_strdup_printf("%s BAR %d", vbasedev->name, i);
+        }
 
         ret = vfio_region_setup(OBJECT(vdev), vbasedev,
                                 &vdev->bars[i].region, i, name);
@@ -3180,6 +3185,7 @@ static void vfio_instance_init(Object *obj)
 static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
+    DEFINE_PROP_STRING("vfioid", VFIOPCIDevice, vbasedev.vfioid),
     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
                             display, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1b434d02f6..84bab94f52 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -108,6 +108,7 @@ typedef struct VFIODevice {
     struct VFIOGroup *group;
     char *sysfsdev;
     char *name;
+    char *vfioid;
     DeviceState *dev;
     int fd;
     int type;
diff --git a/memory.c b/memory.c
index d14c6dec1d..dbb29fa989 100644
--- a/memory.c
+++ b/memory.c
@@ -1588,6 +1588,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
                                 uint64_t size,
                                 void *ptr)
 {
+    DeviceState *owner_dev;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
     mr->terminates = true;
@@ -1597,6 +1598,9 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
     mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fatal);
+
+    owner_dev = DEVICE(owner);
+    vmstate_register_ram(mr, owner_dev);
 }
 
 void memory_region_init_ram_device_ptr(MemoryRegion *mr,
-- 
2.17.1
