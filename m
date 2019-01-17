Received: from eggs.gnu.org ([209.51.188.92]:45792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gk779-0005lg-6e
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:49:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gk778-000212-8Z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:49:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:36274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gk778-0001sS-0P
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:49:42 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Thu, 17 Jan 2019 20:49:04 +0800
Message-Id: <1547729344-3895-5-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1547729344-3895-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1547729344-3895-1-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [PATCH v6 4/4] i386: allow to load initrd below 4 GB
 for recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: philmd@redhat.com, zhijianx.li@intel.com, philip.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Since linux commit: cf8fa920cb42 ("i386: handle an initrd in highmem (version 2)")
linux has supported initrd up to 4 GB, but the header field
ramdisk_max is still set to 2 GB to avoid "possible bootloader bugs".

When use '-kernel vmlinux -initrd initrd.cgz' to launch a VM,
the firmware(it could be linuxboot_dma.bin) helps to read initrd
contents into guest memory(below ramdisk_max) and jump to kernel.
that's similar with what bootloader does, like grub.

In addition, initrd_max is uint32_t simply because QEMU doesn't support
the 64-bit boot protocol (specifically the ext_ramdisk_image field).

Therefore here just limit initrd_max to UINT32_MAX simply as well to
allow initrd to be loaded below 4 GB.

NOTE: it's possible that linux protocol within [0x208, 0x20c]
supports up to 4 GB initrd as well.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

---
V6: update comments
V5: udpate comments and changelog
V3: correct grammar and check XLF_CAN_BE_LOADED_ABOVE_4G first (Michael S. Tsirkin)

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 hw/i386/pc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 64d23b2..10977a3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1130,7 +1130,26 @@ static void load_linux(PCMachineState *pcms,
 #endif
 
     /* highest address for loading the initrd */
-    if (protocol >= 0x203) {
+    if (protocol >= 0x20c &&
+        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
+        /*
+         * Linux has supported initrd up to 4 GB for a very long time (2007,
+         * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
+         * though it only sets initrd_max to 2 GB to "work around bootloader
+         * bugs". Luckily, QEMU firmware(which does something like bootloader)
+         * has supported this.
+         *
+         * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, initrd can
+         * be loaded into any address.
+         *
+         * In addition, initrd_max is uint32_t simply because QEMU doesn't
+         * support the 64-bit boot protocol (specifically the ext_ramdisk_image
+         * field).
+         *
+         * Therefore here just limit initrd_max to UINT32_MAX simply as well.
+         */
+        initrd_max = UINT32_MAX;
+    } else if (protocol >= 0x203) {
         initrd_max = ldl_p(header+0x22c);
     } else {
         initrd_max = 0x37ffffff;
-- 
2.7.4
