Received: from eggs.gnu.org ([2001:4830:134:3::10]:58200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cmq1L-0000EC-2n
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 18:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cmq1H-0000fB-5j
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 18:01:55 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cmq1H-0000cF-0T
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 18:01:51 -0500
Received: by mail-pf0-x242.google.com with SMTP id j5so14848774pfb.3
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 15:01:46 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 11 Mar 2017 15:01:33 -0800
Message-Id: <1489273293-22586-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: xtfpga: load DTB only when FDT
 support is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

xtensa linux can use DTB but does not require it, so FDT support is not
a requirement for target/xtensa. Don't try to load DTB when FDT support
is not configured.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/xtfpga.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index dc6fdcc..11176e2 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -317,6 +317,7 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
             cur_tagptr = put_tag(cur_tagptr, BP_TAG_COMMAND_LINE,
                                  strlen(kernel_cmdline) + 1, kernel_cmdline);
         }
+#ifdef CONFIG_FDT
         if (dtb_filename) {
             int fdt_size;
             void *fdt = load_device_tree(dtb_filename, &fdt_size);
@@ -332,6 +333,14 @@ static void lx_init(const LxBoardDesc *board, MachineState *machine)
                                  sizeof(dtb_addr), &dtb_addr);
             cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + fdt_size, 4096);
         }
+#else
+        if (dtb_filename) {
+            error_report("could not load DTB '%s': "
+                         "FDT support is not configured in QEMU",
+                         dtb_filename);
+            exit(EXIT_FAILURE);
+        }
+#endif
         if (initrd_filename) {
             BpMemInfo initrd_location = { 0 };
             int initrd_size = load_ramdisk(initrd_filename, cur_lowmem,
-- 
2.1.4
