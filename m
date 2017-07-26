Received: from eggs.gnu.org ([2001:4830:134:3::10]:58793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1daO0T-0001pL-Su
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1daO0P-0000v3-Sc
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1daO0P-0000ty-Ns
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:13:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 460CE4629B
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 15:04:48 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Wed, 26 Jul 2017 17:04:46 +0200
Message-Id: <20170726150446.20381-1-otubo@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com

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
