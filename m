Received: from eggs.gnu.org ([2001:4830:134:3::10]:46294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1cRcjd-0007gn-8D
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1cRcjV-00046d-L1
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:35:57 -0500
From: David Engraf <david.engraf@sysgo.com>
Message-ID: <98b1ad64-fe10-4ede-3493-f6d4b49ee1d9@sysgo.com>
Date: Thu, 12 Jan 2017 11:35:15 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------22FB409B6AD5939EA0559780"
Subject: [Qemu-devel] [PATCH] pflash_cfi01: fix per device sector length in
 CFI table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

This is a multi-part message in MIME format.
--------------22FB409B6AD5939EA0559780
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

The CFI entry for sector length must be set to sector length per device. 
This is important for boards using multiple devices like the ARM 
Vexpress board (width = 4, device-width = 2).

Linux and u-boots calculate the size ratio by dividing both values:

size_ratio = info->portwidth / info->chipwidth;

After that the sector length will be multiplied by the size_ratio, thus 
the CFI entry for sector length is doubled. When Linux or u-boot send a 
sector erase, they expect to erase the doubled sector length, but QEMU 
only erases the board specified sector length.

This patch fixes the sector length in the CFI table to match the length 
per device, equal to blocks_per_device.

Signed-off-by: David Engraf <david.engraf@sysgo.com>


--------------22FB409B6AD5939EA0559780
Content-Type: text/x-patch;
 name="fix_pflash_sector_len.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fix_pflash_sector_len.patch"

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 5f0ee9d..8bb61e4 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -703,7 +703,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     pflash_t *pfl = CFI_PFLASH01(dev);
     uint64_t total_len;
     int ret;
-    uint64_t blocks_per_device, device_len;
+    uint64_t blocks_per_device, sector_len_per_device, device_len;
     int num_devices;
     Error *local_err = NULL;
 
@@ -727,7 +727,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
      */
     num_devices = pfl->device_width ? (pfl->bank_width / pfl->device_width) : 1;
     blocks_per_device = pfl->nb_blocs / num_devices;
-    device_len = pfl->sector_len * blocks_per_device;
+    sector_len_per_device = pfl->sector_len / num_devices;
+    device_len = sector_len_per_device * blocks_per_device;
 
     /* XXX: to be fixed */
 #if 0
@@ -839,8 +840,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     /* Erase block region 1 */
     pfl->cfi_table[0x2D] = blocks_per_device - 1;
     pfl->cfi_table[0x2E] = (blocks_per_device - 1) >> 8;
-    pfl->cfi_table[0x2F] = pfl->sector_len >> 8;
-    pfl->cfi_table[0x30] = pfl->sector_len >> 16;
+    pfl->cfi_table[0x2F] = sector_len_per_device >> 8;
+    pfl->cfi_table[0x30] = sector_len_per_device >> 16;
 
     /* Extended */
     pfl->cfi_table[0x31] = 'P';

--------------22FB409B6AD5939EA0559780--
