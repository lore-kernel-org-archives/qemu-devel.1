Received: from eggs.gnu.org ([2001:4830:134:3::10]:55422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJZc-0008Gx-U1
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJZb-0005ei-IJ
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:00:12 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJZb-0005dT-DB
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:00:11 -0400
Received: by mail-oi0-x241.google.com with SMTP id t11so13230512oib.1
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:00:11 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:00:10 +0300
Message-ID: <CA+KKJYAZ7ZQ_SuwgJYiTiZSM=roGQgZhLoL4HM4YY-W4h6GVWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 26/43] unicore32: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, gxt@mprc.pku.edu.cn

>From 32ac7bdabbf1935a8a30f606aa3263461117e7d0 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:36:57 +0300
Subject: [PATCH 26/43] unicore32: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 include/hw/unicore32/puv3.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/hw/unicore32/puv3.h b/include/hw/unicore32/puv3.h
index 5a4839f..e9e3ae6 100644
--- a/include/hw/unicore32/puv3.h
+++ b/include/hw/unicore32/puv3.h
@@ -41,10 +41,15 @@
 #define PUV3_IRQS_OST0          (26)

 /* All puv3_*.c use DPRINTF for debug. */
-#ifdef DEBUG_PUV3
-#define DPRINTF(fmt, ...) printf("%s: " fmt , __func__, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+
+#ifndef DEBUG_PUV3
+#define DEBUG_PUV3 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                 \
+    if (DEBUG_PUV3) {                                          \
+        fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
+    }                                                          \
+} while (0);

 #endif /* QEMU_HW_PUV3_H */
-- 
2.8.0.rc3
