Received: from eggs.gnu.org ([2001:4830:134:3::10]:59721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vv-00017C-SK
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vu-0005AE-Kx
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vu-000541-DN
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vi-0003Nk-AV
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:22 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:03 +0000
Message-Id: <1485531137-2362-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/22] pflash_cfi01: fix per-device sector
 length in CFI table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For configurations of the pflash_cfi01 device which set it up with a
device-width not equal to the width (ie where we are emulating
multiple narrow flash devices wired up in parallel), we were giving
incorrect values in the CFI data table:

(1) the sector length entry should specify the sector length for a
    single device, not the length for the overall collection of
    devices
(2) the number of blocks per device must not be divided by the
    number of devices because the resulting device size would not
    match the overall size
(3) this then means that the overall write block size must be
    modified depending on the number of devices because the entry is
    per device and when the guest writes into the flash it
    calculates the write size by using the CFI entry (write size
    per device) multiplied by the number of chips.
    (It would alternatively be possible to modify the write
    block size in the CFI table (currently hardcoded at 2048) and
    leave the overall write block size alone.)

This commit corrects these bugs, and adds a hw-compat property
to retain the old behaviour on 2.8 and earlier versions. (The
only board we have which uses this sort of flash config and
has machine versioning is the "virt" board -- the PC uses a
single flash device and so behaviour is unaffected whether
using old-multiple-chip-handling or not.)

Here is a configuration example from the vexpress board:

VEXPRESS_FLASH_SIZE = 64M
VEXPRESS_FLASH_SECT_SIZE 256K
num-blocks = VEXPRESS_FLASH_SIZE / VEXPRESS_FLASH_SECT_SIZE = 256
sector-length = 256K
width = 4
device-width = 2

The code will fill the CFI entry with the following entries:
  num-blocks = 256
  sector-length = 128K
  writeblock_size = 2048

This results in two chips, each with 256 * 128K = 32M device size and
a write block size of 2048.

A sector erase will be sent to both chips, thus 256K must be erased.
When the guest sends a block write command, it will write 4096 bytes
data at once (2048 per device).

Signed-off-by: David Engraf <david.engraf@sysgo.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: cleaned up and expanded commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/compat.h     |  4 ++++
 hw/block/pflash_cfi01.c | 22 +++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 34e9b4a..ee0dd1b 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -10,6 +10,10 @@
         .driver   = "fw_cfg_io",\
         .property = "x-file-slots",\
         .value    = stringify(0x10),\
+    },{\
+        .driver   = "pflash_cfi01",\
+        .property = "old-multiple-chip-handling",\
+        .value    = "on",\
     },
 
 #define HW_COMPAT_2_7 \
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 5f0ee9d..71b98a3 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -99,6 +99,7 @@ struct pflash_t {
     char *name;
     void *storage;
     VMChangeStateEntry *vmstate;
+    bool old_multiple_chip_handling;
 };
 
 static int pflash_post_load(void *opaque, int version_id);
@@ -703,7 +704,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     pflash_t *pfl = CFI_PFLASH01(dev);
     uint64_t total_len;
     int ret;
-    uint64_t blocks_per_device, device_len;
+    uint64_t blocks_per_device, sector_len_per_device, device_len;
     int num_devices;
     Error *local_err = NULL;
 
@@ -726,8 +727,14 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
      * in the cfi_table[].
      */
     num_devices = pfl->device_width ? (pfl->bank_width / pfl->device_width) : 1;
-    blocks_per_device = pfl->nb_blocs / num_devices;
-    device_len = pfl->sector_len * blocks_per_device;
+    if (pfl->old_multiple_chip_handling) {
+        blocks_per_device = pfl->nb_blocs / num_devices;
+        sector_len_per_device = pfl->sector_len;
+    } else {
+        blocks_per_device = pfl->nb_blocs;
+        sector_len_per_device = pfl->sector_len / num_devices;
+    }
+    device_len = sector_len_per_device * blocks_per_device;
 
     /* XXX: to be fixed */
 #if 0
@@ -832,6 +839,9 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
         pfl->cfi_table[0x2A] = 0x0B;
     }
     pfl->writeblock_size = 1 << pfl->cfi_table[0x2A];
+    if (!pfl->old_multiple_chip_handling && num_devices > 1) {
+        pfl->writeblock_size *= num_devices;
+    }
 
     pfl->cfi_table[0x2B] = 0x00;
     /* Number of erase block regions (uniform) */
@@ -839,8 +849,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     /* Erase block region 1 */
     pfl->cfi_table[0x2D] = blocks_per_device - 1;
     pfl->cfi_table[0x2E] = (blocks_per_device - 1) >> 8;
-    pfl->cfi_table[0x2F] = pfl->sector_len >> 8;
-    pfl->cfi_table[0x30] = pfl->sector_len >> 16;
+    pfl->cfi_table[0x2F] = sector_len_per_device >> 8;
+    pfl->cfi_table[0x30] = sector_len_per_device >> 16;
 
     /* Extended */
     pfl->cfi_table[0x31] = 'P';
@@ -898,6 +908,8 @@ static Property pflash_cfi01_properties[] = {
     DEFINE_PROP_UINT16("id2", struct pflash_t, ident2, 0),
     DEFINE_PROP_UINT16("id3", struct pflash_t, ident3, 0),
     DEFINE_PROP_STRING("name", struct pflash_t, name),
+    DEFINE_PROP_BOOL("old-multiple-chip-handling", struct pflash_t,
+                     old_multiple_chip_handling, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.7.4
