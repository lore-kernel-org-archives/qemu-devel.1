Received: from eggs.gnu.org ([2001:4830:134:3::10]:47636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1cK3xY-0000Wm-V4
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.engraf@sysgo.com>) id 1cK3xY-0005LJ-70
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 09:03:04 -0500
From: David Engraf <david.engraf@sysgo.com>
Message-ID: <d15e8de4-f7d8-1c28-7e5e-31d0aa10819d@sysgo.com>
Date: Thu, 22 Dec 2016 15:02:54 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------8875C6CC09A0B51199EFB81B"
Subject: [Qemu-devel] [PATCH] vexpress fix flash device-width
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

This is a multi-part message in MIME format.
--------------8875C6CC09A0B51199EFB81B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

The current implementation uses width = 4 and device-width = 2 for the 
flash configuration. When using u-boot or Linux, the flash is detected 
as 32 x 16 bit, thus the sector size is doubled to 512 KB. When u-boot 
sends a sector erase, only the first 256 KB are erased because the QEMU 
flash implementation uses the configured sector size of 256 KB and 
ignores the width and device-width ratio.

This patch will change device-width to 4, thus the width and 
device-width are equal and u-boot detects the flash as 32 x 32 bit with 
the correct sector size of 256 KB.

- David


--------------8875C6CC09A0B51199EFB81B
Content-Type: text/x-patch;
 name="vexpress.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="vexpress.patch"

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 58760f4..85ec347 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -526,7 +526,7 @@ static pflash_t *ve_pflash_cfi01_register(hwaddr base, const char *name,
                          VEXPRESS_FLASH_SIZE / VEXPRESS_FLASH_SECT_SIZE);
     qdev_prop_set_uint64(dev, "sector-length", VEXPRESS_FLASH_SECT_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
-    qdev_prop_set_uint8(dev, "device-width", 2);
+    qdev_prop_set_uint8(dev, "device-width", 4);
     qdev_prop_set_bit(dev, "big-endian", false);
     qdev_prop_set_uint16(dev, "id0", 0x89);
     qdev_prop_set_uint16(dev, "id1", 0x18);

--------------8875C6CC09A0B51199EFB81B--
