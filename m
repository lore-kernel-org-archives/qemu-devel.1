Received: from eggs.gnu.org ([2001:4830:134:3::10]:56071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJa9-0000Is-SQ
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJa8-000631-QV
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:00:45 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJa8-00062c-KM
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:00:44 -0400
Received: by mail-oi0-x241.google.com with SMTP id d2so5883781oig.2
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:00:44 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:00:43 +0300
Message-ID: <CA+KKJYB3NyaJZXF35-LkRkbc+1juXKaSFLM5jitxFQ+9ZdUeMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 27/43] vfio: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>From c986c5a54a394feadfd885d41848f28d11fec40f Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:37:26 +0300
Subject: [PATCH 27/43] vfio: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 include/hw/vfio/vfio-common.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c582de1..3d3cc89 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -33,14 +33,15 @@
 #define ERR_PREFIX "vfio error: %s: "
 #define WARN_PREFIX "vfio warning: %s: "

-/*#define DEBUG_VFIO*/
-#ifdef DEBUG_VFIO
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "vfio: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_VFIO
+#define DEBUG_VFIO 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                         \
+    if (DEBUG_VFIO) {                                  \
+        fprintf(stderr, "vfio: " fmt, ## __VA_ARGS__); \
+    }                                                  \
+} while (0);

 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
-- 
2.8.0.rc3
