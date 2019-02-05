Received: from eggs.gnu.org ([209.51.188.92]:36463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Ge-0002di-RN
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gd-00049W-8N
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:20 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gc-0003z8-Te
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:19 -0500
Received: by mail-wm1-x342.google.com with SMTP id y8so4739335wmi.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:47 +0100
Message-Id: <1549390526-24246-38-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 37/76] i386: import & use bootparam.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Li Zhijian <lizhijian@cn.fujitsu.com>

it's from v4.20-rc5.

CC: Stefano Garzarella <sgarzare@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c                                 |  8 +------
 include/standard-headers/asm-x86/bootparam.h | 34 ++++++++++++++++++++++++++++
 scripts/update-linux-headers.sh              |  6 +++++
 3 files changed, 41 insertions(+), 7 deletions(-)
 create mode 100644 include/standard-headers/asm-x86/bootparam.h

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 00166d1..9664822 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -76,6 +76,7 @@
 #include "hw/usb.h"
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
+#include "standard-headers/asm-x86/bootparam.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -1059,13 +1060,6 @@ static long get_file_size(FILE *f)
     return size;
 }
 
-/* setup_data types */
-#define SETUP_NONE     0
-#define SETUP_E820_EXT 1
-#define SETUP_DTB      2
-#define SETUP_PCI      3
-#define SETUP_EFI      4
-
 struct setup_data {
     uint64_t next;
     uint32_t type;
diff --git a/include/standard-headers/asm-x86/bootparam.h b/include/standard-headers/asm-x86/bootparam.h
new file mode 100644
index 0000000..67d4f01
--- /dev/null
+++ b/include/standard-headers/asm-x86/bootparam.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_X86_BOOTPARAM_H
+#define _ASM_X86_BOOTPARAM_H
+
+/* setup_data types */
+#define SETUP_NONE			0
+#define SETUP_E820_EXT			1
+#define SETUP_DTB			2
+#define SETUP_PCI			3
+#define SETUP_EFI			4
+#define SETUP_APPLE_PROPERTIES		5
+#define SETUP_JAILHOUSE			6
+
+/* ram_size flags */
+#define RAMDISK_IMAGE_START_MASK	0x07FF
+#define RAMDISK_PROMPT_FLAG		0x8000
+#define RAMDISK_LOAD_FLAG		0x4000
+
+/* loadflags */
+#define LOADED_HIGH	(1<<0)
+#define KASLR_FLAG	(1<<1)
+#define QUIET_FLAG	(1<<5)
+#define KEEP_SEGMENTS	(1<<6)
+#define CAN_USE_HEAP	(1<<7)
+
+/* xloadflags */
+#define XLF_KERNEL_64			(1<<0)
+#define XLF_CAN_BE_LOADED_ABOVE_4G	(1<<1)
+#define XLF_EFI_HANDOVER_32		(1<<2)
+#define XLF_EFI_HANDOVER_64		(1<<3)
+#define XLF_EFI_KEXEC			(1<<4)
+
+
+#endif /* _ASM_X86_BOOTPARAM_H */
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 0a964fe..3578cfe 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -120,6 +120,12 @@ for arch in $ARCHLIST; do
         cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
         cp_portable "$tmpdir/include/asm/kvm_para.h" "$output/include/standard-headers/asm-$arch"
+        # Remove everything except the macros from bootparam.h avoiding the
+        # unnecessary import of several video/ist/etc headers
+        sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' \
+               "$tmpdir/include/asm/bootparam.h" > "$tmpdir/bootparam.h"
+        cp_portable "$tmpdir/bootparam.h" \
+                    "$output/include/standard-headers/asm-$arch"
     fi
 done
 
-- 
1.8.3.1
