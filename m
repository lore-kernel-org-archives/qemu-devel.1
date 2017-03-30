Received: from eggs.gnu.org ([2001:4830:134:3::10]:45353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1ctdHp-0000TA-3E
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shah.suramya@gmail.com>) id 1ctdHm-0000ZO-0F
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:51:01 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shah.suramya@gmail.com>)
	id 1ctdHl-0000ZC-M6
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:50:57 -0400
Received: by mail-pg0-x243.google.com with SMTP id 81so11405096pgh.3
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 09:50:57 -0700 (PDT)
From: Suramya Shah <shah.suramya@gmail.com>
Date: Thu, 30 Mar 2017 22:20:08 +0530
Message-Id: <20170330165008.26419-1-shah.suramya@gmail.com>
Subject: [Qemu-devel] [PATCH v5] hw/unicore32: remove wrong assertion in puv
 machine init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, gxt@mprc.pku.edu.cn, Suramya Shah <shah.suramya@gmail.com>


Running QEMU with qemu-system-unicore32 without the kernel parameter results in an assertion error.
Assert should not be used to check user provided parameters. Report an error and exit instead
Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
---
 hw/unicore32/puv3.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 032078f..2c17cc9 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -93,8 +93,11 @@ static void puv3_load_kernel(const char *kernel_filename)
     if (kernel_filename == NULL && qtest_enabled()) {
         return;
     }
-    assert(kernel_filename != NULL);
-
+    if (kernel_filename == NULL) {
+        error_report("No kernel found");
+        exit(1);
+    }
+
     /* only zImage format supported */
     size = load_image_targphys(kernel_filename, KERNEL_LOAD_ADDR,
             KERNEL_MAX_SIZE);
-- 
2.9.3
