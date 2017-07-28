Received: from eggs.gnu.org ([2001:4830:134:3::10]:40479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1db3pa-0007Eh-QO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1db3pZ-0005yO-UQ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:53:22 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 28 Jul 2017 13:53:18 +0200
Message-Id: <20170728115318.31781-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCH] fix qemu-system-unicore32 crashing when
 calling without -kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, gxt@mprc.pku.edu.cn, thuth@redhat.com

Starting qemu-system-unicore32 without the -kernel parameter results in
an assert() returns false and aborts qemu. This patch replaces it with a
proper error message followed by exit(1).

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 hw/unicore32/puv3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index e9d1a60b6f..ff62efb4df 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -92,7 +92,10 @@ static void puv3_load_kernel(const char *kernel_filename)
     if (kernel_filename == NULL && qtest_enabled()) {
         return;
     }
-    assert(kernel_filename != NULL);
+    if (kernel_filename == NULL) {
+        error_report("kernel parameter cannot be empty");
+        exit(1);
+    }
 
     /* only zImage format supported */
     size = load_image_targphys(kernel_filename, KERNEL_LOAD_ADDR,
-- 
2.13.3
