Received: from eggs.gnu.org ([2001:4830:134:3::10]:35046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rimjhim0107@gmail.com>) id 1coSDG-0005sk-0n
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rimjhim0107@gmail.com>) id 1coSD9-0000TA-MZ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:00:54 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rimjhim0107@gmail.com>)
	id 1coSD9-0000Sk-GP
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:00:47 -0400
Received: by mail-pg0-x244.google.com with SMTP id b5so5527631pgg.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 03:00:47 -0700 (PDT)
From: Anishka0107 <rimjhim0107@gmail.com>
Date: Thu, 16 Mar 2017 10:00:21 +0530
Message-Id: <1489638621-31978-1-git-send-email-rimjhim0107@gmail.com>
Subject: [Qemu-devel] [PATCH] puv3: always compile-check debug printf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org
Cc: Anishka0107 <rimjhim0107@gmail.com>

    To prevent bitrot of the format string of the debug statement, files with
  conditional debug statements should ensure that printf is compiled always,
  and enclosed within if(0) statements and not in #ifdef.

Signed-off-by: Anishka Gupta <rimjhim0107@gmail.com>
---
 include/hw/unicore32/puv3.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/hw/unicore32/puv3.h b/include/hw/unicore32/puv3.h
index 5a4839f..e268484 100644
--- a/include/hw/unicore32/puv3.h
+++ b/include/hw/unicore32/puv3.h
@@ -41,10 +41,14 @@
 #define PUV3_IRQS_OST0          (26)
 
 /* All puv3_*.c use DPRINTF for debug. */
-#ifdef DEBUG_PUV3
-#define DPRINTF(fmt, ...) printf("%s: " fmt , __func__, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#define DEBUG_PUV3 0
+
+#define DPRINTF(fmt, ...)
+    if (DEBUG_PUV3) {
+        fprintf(stderr, "%s: " fmt , __func__, ## __VA_ARGS__)
+    }
+    else {
+        do {} while (0)
+    }
 
 #endif /* QEMU_HW_PUV3_H */
-- 
2.5.0
