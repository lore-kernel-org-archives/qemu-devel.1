Received: from eggs.gnu.org ([209.51.188.92]:60618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODM-0006qS-Lt
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODJ-0002rC-OO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODJ-0002qE-G6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id y15so5067570wma.0
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:09 +0100
Message-Id: <1552323335-46779-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 05/31] hw/i386/pc: run the multiboot loader
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
