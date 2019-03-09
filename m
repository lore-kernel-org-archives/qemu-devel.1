Received: from eggs.gnu.org ([209.51.188.92]:47235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wic-0003qi-6f
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2WiZ-0000Pn-Oo
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:30 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2WiW-0000LG-Fn
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:25 -0500
Received: by mail-wr1-x431.google.com with SMTP id l12so7191067wrp.6
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:23 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:47:56 +0100
Message-Id: <1552117698-12355-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/25] hw/i386/pc: run the multiboot loader
 before the PVH loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>

From: Stefano Garzarella <sgarzare@redhat.com>

Some multiboot images could be in the ELF format. In the current
implementation QEMU fails because we try to load these images
as a PVH image.

In order to fix this issue, we should try multiboot first (we
already check the multiboot magic header before to load it).
If it is not a multiboot image, we can try the PVH loader.

Fixes: ab969087da6 ("pvh: Boot uncompressed kernel using direct boot ABI", 2019-01-15)
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190214180216.246707-1-sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4212818..9c8f833 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1210,6 +1210,17 @@ static void load_linux(PCMachineState *pcms,
         protocol = lduw_p(header+0x206);
     } else {
         /*
+         * This could be a multiboot kernel. If it is, let's stop treating it
+         * like a Linux kernel.
+         * Note: some multiboot images could be in the ELF format (the same of
+         * PVH), so we try multiboot first since we check the multiboot magic
+         * header before to load it.
+         */
+        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
+                           kernel_cmdline, kernel_size, header)) {
+            return;
+        }
+        /*
          * Check if the file is an uncompressed kernel file (ELF) and load it,
          * saving the PVH entry point used by the x86/HVM direct boot ABI.
          * If load_elfboot() is successful, populate the fw_cfg info.
@@ -1262,12 +1273,6 @@ static void load_linux(PCMachineState *pcms,
 
             return;
         }
-        /* This looks like a multiboot kernel. If it is, let's stop
-           treating it like a Linux kernel. */
-        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
-                           kernel_cmdline, kernel_size, header)) {
-            return;
-        }
         protocol = 0;
     }
 
-- 
1.8.3.1
