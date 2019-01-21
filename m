Received: from eggs.gnu.org ([209.51.188.92]:52184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldz3-0005DA-GH
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldz2-000526-Es
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:41 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldz2-0004h9-6Q
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:40 -0500
Received: by mail-wr1-x442.google.com with SMTP id l9so24410492wrt.13
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:07:11 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:06:19 +0100
Message-Id: <1548093980-43088-49-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 48/49] i386: allow to load initrd below 4 GB for
 recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Li Zhijian <lizhijian@cn.fujitsu.com>

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

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 90e684d..3d66f81 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1289,7 +1289,26 @@ static void load_linux(PCMachineState *pcms,
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
1.8.3.1
